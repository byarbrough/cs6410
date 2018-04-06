structure RegAlloc : REG_ALLOC = 
struct
	structure Frame = MipsFrame
	type allocation = Frame.register Temp.Table.table
	
	fun alloc(instrs: Assem.instr list, 
						frame:  Frame.frame) : Assem.instr list * allocation = ()
end