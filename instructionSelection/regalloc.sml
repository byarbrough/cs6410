structure RegAlloc : REG_ALLOC = 
struct
	structure Frame = MipsFrame
	structure G = Graph
	structure DL = DList
	type allocation = Frame.register Temp.Table.table
	
	(*Global Worklists: 
	 *invariant* : each node is in only one of the following*)
	val precolored : G.node list  
	val inital : G.node list
	val simplifyWL : G.node DL.dlist
	val freezeWL :  G.node DL.dlist
	val spillWL : G.node DL.dlist
	val coalescedNodes : G.node list 
	val coloredNodes : G.node list
	val selectStack : G.node list
	
	(*Move sets/worklists*)
	val coalescedMoves : (G.node * G.node) list
	val constrainedMoves : (G.node * G.node) list
	val frozenMoves : (G.node * G.node) DL.dlist
	val worklistMoves : (G.node * G.node) DL.dlist
	val activeMoves : (G.node * G.node) DL.dlist

	(*other Data structures*)

	val adjSet : (*tbd on the interface for this. it will be 
								something like () T.Graph T.Graph*)
	val adjList : G.node list G.Table 
	val degree : int G.Table
	val moveList : G.node list G.Table
	fun alias(node) : node
	fun color(node) : int

	(*Given a node return the list or dlist that it is in.*)
	fun nodeMember(node: G.node) =  



	fun livenessAnalysis() :

	fun build() : 

	fun makeWorklist() : 

	fun simplify() :

	fun coalesce() :

	fun freeze() : 

	fun selectSpill():

	fun reWriteProgram(spilledNodes) :

	fun assignColors():


	fun alloc(instrs: Assem.instr list, 
						frame:  Frame.frame) : Assem.instr list * allocation = ()
end