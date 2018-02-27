signature FRAME = 
sig
	type frame
	type access
	val newFrame: {name: Temp.label, formals: bool list} -> frame
	val name : frame -> Temp.label
	val formals: frome -> access list
	val allocLocal : frame -> bool -> access
end


structure MipsFrame : FRAME = 
struct
	datatype frame = {formals: access list, vs: Temp.temp list, numLoc: int, funStart: Temp.label }
	datatype access = InFrane of int 
                    | InReg of Temp.temp 
    fun newFrame({name, formals list})

end