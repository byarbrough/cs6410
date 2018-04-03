signature FRAME = 
sig
	type frame
	type access
	type register
	datatype frag = 
		  PROC of {body: Tree.stm, frame: frame} 
		| STRING of Temp.label * string
	val newFrame: {name: Temp.label, formals: bool list} -> frame
	val name : frame -> Temp.label
	val string : Temp.label * string -> string
	val formals: frame -> access list	
	val allocLocal : frame -> bool -> access
	val FP : Temp.temp
	val RV : Temp.temp
	val RA : Temp.temp
	val ZERO : Temp.temp
	val registersAsTemps : Temp.temp list
  val calldefs : Temp.temp list
	val wordSize : int
	val exp : access -> Tree.exp -> Tree.exp
	val externalCall : string * Tree.exp list -> Tree.exp
	val procEntryExit1 : frame * Tree.exp -> Tree.exp (*STUBBED*)
	val procEntryExit2 : frame * Assem.instr list -> Assem.instr list
	val procEntryExit3 : frame * Tree.exp -> 
          {prolog : string, body : Tree.exp, epilog : string} (*STUBBED*)
	val tempMap: register Temp.Table.table

end


structure MipsFrame : FRAME = 
struct
	datatype access = InFrame of int 
	                | InReg of Temp.temp 
	type register = string
	val FP = Temp.newtemp()
	val RV = Temp.newtemp()
	val RA = Temp.newtemp()
	val ZERO = Temp.newtemp()
	val registersAsTemps = [ZERO, RA, FP, RV]
	val specialregs = [FP, RV, ZERO] 
	(*a0-a3*)
	val argregs = [Temp.newtemp(), Temp.newtemp(), 
				   Temp.newtemp(), Temp.newtemp()]
   	(*t0-t9*)
	val callersaves = [Temp.newtemp(), Temp.newtemp(),
					   Temp.newtemp(), Temp.newtemp(),
					   Temp.newtemp(), Temp.newtemp(),
					   Temp.newtemp(), Temp.newtemp(),
					   Temp.newtemp(), Temp.newtemp()]
    (*s0-s7*)
	val callesaves = [Temp.newtemp(), Temp.newtemp(),
					  Temp.newtemp(), Temp.newtemp(),
					  Temp.newtemp(), Temp.newtemp(),
					  Temp.newtemp(), Temp.newtemp()]
  val calldefs =  RA :: RV :: callersaves 
  val tempMap = 
        foldr
        (fn ((str, r), acc) =>
          Temp.Table.enter (acc, r, str)) Temp.Table.empty
        [("fp", FP), ("rv", RV), ("ra", RA), ("zero", ZERO)]
  val wordSize = 4
  type frame = {formals: access list, 
  							numLoc: int ref, 
  							numForm: int ref, 
  							funName: Temp.label}

  datatype frag = 
		  PROC of {body: Tree.stm, frame: frame} 
		| STRING of Temp.label * string
  (*Allocate formal variables based on if they escape or not. *)
	fun allocFormals({formals, numLoc, numForm, funName}) = fn(b) => 
		if b orelse !numForm > 4 then (numForm := !numForm + 1;
			InFrame(!numForm * wordSize))
				 else InReg(Temp.newtemp())


	(*create a new empty frame with formals allocated*)
  fun newFrame({name, formals}) = 
  	let 
  		val frame = {formals= nil, 
  								 numLoc= ref 0, 
  								 numForm= ref 0, 
  								 funName= name}
  		val formals' = map (allocFormals frame) formals
  	in 
  		{formals= formals',
  		 numLoc = ref 0, 
  		 numForm= #numForm frame, 
  		 funName = name}
  	end
  (*Return the label associated with the given frame*)
  fun name({formals, numLoc, numForm, funName}) = funName
  (*Return the formals of the given frame*)
	fun formals({formals, numLoc,numForm, funName}) = formals
	(*Allocate local variables based on if they escape or not. *)
	fun allocLocal({formals,numLoc, numForm, funName}) =
		fn(b) => 
		if b then (numLoc := !numLoc + 1; InFrame(!numLoc * wordSize))
		   	 else InReg(Temp.newtemp())

 	(*Call a function in an external program*)
 	fun externalCall(s, args) =
 		Tree.CALL(Tree.NAME(Temp.namelabel s), args)

 	fun exp access loc = 
 		(case access 
			of InReg(temp) => Tree.TEMP(temp)
 		   | InFrame(k) => 
 				Tree.MEM(
 					Tree.BINOP(Tree.MINUS, loc, Tree.CONST(k))))

	fun string(label, str) = 
		Symbol.name label ^ ": .asciiz \"" ^ str ^ "\"\n"
 	fun procEntryExit1(frame, body)= body
 	fun procEntryExit2(frame, instr) =
      instr @ [Assem.OPER{assem="",
                src=[ZERO,RA,FP,RV],
                dst=[],
                jump=NONE}]
	fun procEntryExit3({funName,formals, numLoc, numForm}, body) =
    {prolog="PROCEDURE " ^ Symbol.name funName ^ "\n",
     body=body, 
     epilog = "END " ^ Symbol.name funName ^ "\n"}
end