signature FRAME = 
sig
	type frame
	type access
	val newFrame: {name: Temp.label, formals: bool list} -> frame
	val name : frame -> Temp.label
	val formals: frame -> access list
	val allocLocal : frame -> bool -> access
end


structure MipsFrame : FRAME = 
struct
	datatype access = InFrame of int 
                    | InReg of Temp.temp 
  val wordSize = 4
  type frame = {formals: access list, numLoc: int ref, numForm: int ref, funName: Temp.label }

  (*Allocate formal variables based on if they escape or not. *)
	fun allocFormals({formals, numLoc, numForm, funName}) = fn(b) => 
		if b then (numForm := !numForm + 1; InFrame(!numForm * wordSize))
				 else InReg(Temp.newtemp())


	(*create a new empty frame with formals allocated*)
  fun newFrame({name, formals}) = 
  	let 
  		val frame = {formals= nil, numLoc= ref 0, numForm= ref 0, funName= name}
  		val formals' = map (allocFormals frame) formals
  	in 
  		{formals= formals',numLoc = ref 0, numForm= #numForm frame, funName = name}
  	end
  (*Return the label associated with the given frame*)
  fun name({formals, numLoc, numForm, funName}) = funName
  (*Return the formals of the given frame*)
	fun formals({formals, numLoc,numForm, funName}) = formals
	(*Allocate local variables based on if they escape or not. *)
	fun allocLocal({formals,numLoc, numForm, funName}) =
		(*Only first four non-escaping variables are saved in registers *)
		let
			val pcount : int ref = ref 0;
		in
		fn(b) => 
			if b then (numLoc := !numLoc + 1; InFrame(!numLoc * wordSize))
				   else (pcount := !pcount + 1; InReg(Temp.newtemp()))
		end

end