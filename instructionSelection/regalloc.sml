structure RegAlloc : REG_ALLOC = 
struct
	structure Frame = MipsFrame
	type allocation = Frame.register Temp.Table.table
	
  fun alloc(instrs: Assem.instr list, 
						frame:  Frame.frame) : Assem.instr list * allocation = 
	let
		(*Global Worklists: 
		 *invariant* : each node is in only one of the following*)
		val (flowgraph, bblist) = MakeGraph.instrs2graph(instrs)
		val (iGraph, liveMap) = Liveness.interferenceGraph(flowgraph)

    val (allocation, tempList) = Color.color(
    							{interference = iGraph, 
									 initial= Frame.tempMap,
									 spillCost= fn(node)  => 1,
									 registers= Frame.registers})
		
	in 
		(instrs, allocation)
	end


	
end