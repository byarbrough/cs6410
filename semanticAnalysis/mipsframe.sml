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
  type frame = {formals: access list, numLoc: int ref, funStart: Temp.label }
	(*create a new empty frame with formals allocated*)
  fun newFrame({name, formals}) = 
  	let 
  		val frame = {formals= nil, numLoc= ref 0, funStart= name}
  		val formals' = map (allocLocal frame) formals
  	in 
  		{formals= formals',numLoc = ref 0, name = name}
  	end
  (*Return the label associated with the given frame*)
  fun name({formals, numLoc, funStart}) = funStart
  (*Return the formals of the given frame*)
	fun formals({formals, numLoc, funStart}) = formals
	(*Allocate local variabled based on if they escape or not. *)
	fun allocLocal({formals,numLoc, funStart}) = fn(b) => 
														(case b 
															of True => (numLoc := !numLoc + 1; InFrame(!numLoc * wordSize))
															 | False => InReg(Temp.newTemp())


end