structure Liveness: 
sig
	datatype igraph = IGRAPH of 
		{ graph: IGraph.graph,
		  tnode: Temp.temp -> IGraph.node, 
		  gtemp: IGraph.node -> Temp.temp, 
		  moves: (IGraph.node * IGraph.node) list
		}
  val interferenceGraph : Flow.flowgraph -> 
                          igraph * (Flow.Graph.node -> 
                                    Temp.temp list)
  val show : outstream * igraph -> unit
end
struct 
	(* remember what is live at exit of each node *)
  type liveSet = unit Temp.Table.table * temp list
  type liveMap = liveSet Flow.Graph.Table.table


fun interferenceGrpah(fg) =

	(* make IG from LiveMap *)
	let fun makeIG(fg) = 
		(* if node is in def *)
		 
		(* at edge where temps are in liveMap *)
	in
		(* each flow node *)
	end

	(* return list of temps that are live-out at a node *)
	let fun liveOuts(n) =

	in

	end

	(* return *)
	igraph: makeIG(fg), (Flow.Graph.node -> Temp.temp list): liveouts;



end