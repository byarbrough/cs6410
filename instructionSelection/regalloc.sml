structure RegAlloc : REG_ALLOC = 
struct
	structure Frame = MipsFrame
	structure G = Graph
	structure DL = DList
	structure RU = RegAllocUtil
	type allocation = Frame.register Temp.Table.table

  val K = 32 (*CHECK THIS*)
	
	fun alloc(instrs: Assem.instr list, 
						frame:  Frame.frame) : Assem.instr list * allocation = 
	let
		(*Global Worklists: 
		 *invariant* : each node is in only one of the following*)
		val (Liveness.IGRAPH{graph=igraph, 
							 tnode=tempToNode, 
							 gtemp=nodeToTemp, 
							 moves}, bblist) = MakeGraph.instrs2graph(instrs)
		val (iGraph, liveMap) = Liveness.interferenceGraph(flowgraph)
		val precolored : G.node DL.dlist  = [tempToNode(Frame.FP), 
										 	 tempToNode(Frame.Zero),
										     tempToNode(Frame.RV),
										     tempToNode(Frame.RA)]
		val inital : G.node DL.dlist
		val simplifyWL : G.node DL.dlist
		val freezeWL :  G.node DL.dlist
		val spillWL : G.node DL.dlist
		val coalescedNodes : G.node DL.dlist
		val coloredNodes : G.node DL.dlist
		val selectStack :  G.node DL.dlist
		
		(*Move sets/worklists*)
		val coalescedMoves : (G.node * G.node) DL.dlist
		val constrainedMoves : (G.node * G.node) DL.dlist
		val frozenMoves : (G.node * G.node) DL.dlist
		val worklistMoves : (G.node * G.node) DL.dlist
		val activeMoves : (G.node * G.node) DL.dlist

		(*other Data structures*)

		val adjSet : (*tbd on the interface for this. it will be 
									something like () T.Graph T.Graph*)
		val adjList : G.node Dl.dlist G.Table 
		fun degree(node) : int
    fun decDegree(node) : unit
		val moveList : (G.node * G.node) DL.dlist G.Table
		fun alias(node) : node
		fun color(node) : int

		(*Given a node return the list or dlist that it is in.*)
		fun nodeMember(node: G.node) =  

    fun nodeMoves(node) =
				RU.mintersect(moveList, RU.munion(activeMoves, worklistMoves))

		fun moveRelated(node) = 
			 	size(nodeMoves(node)) > 0
    
    fun adjacent(node) = (*STUB*)
    (*For all nodes in node if they have any NodeMoves that are active, 
      put them into the worklistMoves*)  
    fun enableMoves(nodes) = 
      DL.app(nodes, fn(node) => 
        Dl.app(nodeMoves(node)), fn(n) => 
          if DL.member?(n, activeMoves) then 
            (DL.rem(n, activeMoves);
              Dl.add(n, worklistMoves)))

    (*For all given nodes decrement their degree and move them if needed to
      the appropriate worklists based off moveRelated*)
    fun decrementDegree(node) = 
      let 
        val d = degree(node)
      in 
        (decDegree(node); 
         if d = K then 
          (enableMoves(RN.union([node], adjacent(node)))
           Dl.rem(node, spillWL);
           if moveRelated(node) 
           then 
              DL.add(node, freezeWL)
            else
              Dl.add(node, simplifyWL)))
      end 


		fun livenessAnalysis() :

		fun build() : 

		fun makeWorklist() : 

		fun simplify() :

		fun coalesce() :

		fun freeze() : 

		fun selectSpill():

		fun reWriteProgram(spilledNodes) :

		fun assignColors():
	in 

	end


	
end