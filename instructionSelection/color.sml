structure Color  = 
struct
	structure Frame = MipsFrame
	structure G = Graph
	structure RU = RegAllocUtil

	type allocation = Frame.register Temp.Table.table

	fun color({interference as Liveness.IGRAPH{graph,tnode,gtemp,moves},
			   		 initial: allocation,
						 spillCost: G.node -> int,
						 registers: Frame.register list }) : 
						 	allocation * Temp.temp list =
		let
			val precolored : G.node list  = [tnode(Frame.FP), 
											 	 tnode(Frame.ZERO),
											     tnode(Frame.RV),
											     tnode(Frame.RA)]
			val initialNodes : G.node list  =
						G.nodes(graph)
			val K = 32

			
 			(*table of int ref that represent the number of 
			  adjacent nodes for a given node*)
			val degreeTable : int ref G.Table.table =
				foldr(fn(node, table) => 
					if not (RU.contains(node, precolored, Graph.eq))
					then 
						G.Table.enter(table, node, ref (length(G.adj(node))))
					else table) G.Table.empty initialNodes


			(*Helper function that gets the degree of a given node*)
			fun degree(node) : int =
				!(RU.getFrom(node, degreeTable))
 

			(*other Data structures*)

			(*The set of all adjacent nodes*)
			val adjSet : (G.node * G.node) list ref = ref( 
					foldr(fn(node, adj) => 
									 (map(fn(adjNode) => (node, adjNode))
							 	 			 (Graph.adj(node))) @ adj)
								[] initialNodes)
			(* A table that returns all of the adjacent nodes
			  to the given node*)
			val adjList : G.node list ref G.Table.table = 
					foldr(fn(node, table) => 
						if not (RU.contains(node, precolored, Graph.eq))
						then 
							G.Table.enter(table, node, ref (G.adj(node)))
						else table) G.Table.empty initialNodes
			
			val simplifyWL : G.node list ref = ref(
							List.filter(fn(node) => 
										not (RU.contains(node, precolored, Graph.eq))
										andalso degree(node) < K) initialNodes)
								
			val spillWL : G.node list ref = ref (
						List.filter(fn(node) => 
										not(RU.contains(node, precolored, Graph.eq))
										andalso degree(node) >= K) initialNodes)

			val spilledNodes : G.node list ref = ref []
			val selectStack :  G.node list ref = ref []

			(*Decrement the degree of a given node by 1*)
		  fun decDegree(node) : unit = 
		  	let 
		  		val deg = RU.getFrom(node, degreeTable)
		  	in
		  		deg := !deg - 1
		  	end


			

		  (*all nodes adjacent to a given node except 
		  	nodes in the selectStack*)
		  fun adjacent(node) = 
		  	RU.sub(!(RU.getFrom(node, adjList)), !selectStack)


			  (*For all given nodes decrement their degree and 
			  	move them if needed to the appropriate worklist*)
			  fun decrementDegree(node) = 
			    let 
			      val d = degree(node)
			    in 
			      (decDegree(node); 
			       if d = K then 
			        (spillWL := RU.sub([node], !spillWL);
			         simplifyWL := node :: !simplifyWL)
			      else())
			    end 

				(*Selects a canditate from the spill work list 
					to be maybe spilled and put it in simplifyWL*)
				fun selectSpill() =
					let
						val spillnode = 
							(foldr(fn(node, max) => 
								if spillCost(node) > spillCost(max) 
								then node
								else max) (hd(!spillWL)) (tl(!spillWL)))
					in
						(spillWL := RU.sub([spillnode], !spillWL);
						 simplifyWL := spillnode :: !simplifyWL)
					end

			(*For all the elements in the simplify worklist 
				remove them from the list, add them to the 
				select stack and decerement their degree*)
			fun simplify() =
				app (fn(n) => 
						(simplifyWL := RU.sub(!simplifyWL, [n]);
						 selectStack := n :: !selectStack;
						(app decrementDegree) (adjacent(n))))
						(!simplifyWL)

			fun assignColors() =
				let 
				fun helpAssignColors([]: G.node list, 
														 colors : Frame.register Temp.Table.table , 
														 coloredNodes : G.node list, 
														 spill : Temp.temp list) =
					(colors, coloredNodes, spill)
					| helpAssignColors(n :: nodes, colors, coloredNodes, spill) =
						let 
							val badColors = 
								map (fn(cnode) => RU.getFromTemp(gtemp(cnode), colors))
								(List.filter(fn(anode) => RU.contains(anode, coloredNodes, G.eq)) 
									(RU.union(precolored, !( RU.getFrom(n, adjList)))))
							

							val ok = RU.msub(registers, badColors, fn(a, b) => a = b)
						in
							if not (length(ok) = 0)
							then
								helpAssignColors(
									nodes, 
									Temp.Table.enter(colors, gtemp(n), hd(ok)),
									n :: coloredNodes,
									spill)
							else
								helpAssignColors(nodes, colors, 
																 coloredNodes, gtemp(n) :: spill)
						end
					val (colors, coloredNodes, spill) = 
								helpAssignColors(!selectStack, 
											           Temp.Table.empty,
											           [],[])
				in 
					(colors, spill)
				end

			fun main() = 
				if  not (length(!simplifyWL) = 0) then 
						(simplify(); main())
				else if not (length(!simplifyWL) = 0) then 
						(selectSpill(); main())
				else assignColors()
		in
			main()
		end

end