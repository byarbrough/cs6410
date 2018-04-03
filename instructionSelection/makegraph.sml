structure MakeGraph:
sig
	val instrs2graph: Assem.instr list -> 
					  Flow.flowgraph * Flow.Graph.node list
end 
struct 
	fun instrs2graph([]) = []
    | instrs2graph(OPER({assem, dst, src, jump})) =
    | instrs2graph(LABEL({assem, lab})) =
    | instrs2graph(MOVE({assem, dst, src}))
end