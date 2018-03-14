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
    type frame = {formals: access list, vs: Temp.temp list, numLoc: int, funStart: Temp.label }
	
    fun newFrame({name, formals}) = {formals= nil, vs= nil, numLoc= 1, funStart= Temp.newlabel()}
    fun name(frame) = Temp.newlabel()
	fun formals(frame) = nil
	fun allocLocal(frame) = fn(b) => InFrame(1)


end