structure LIVENESS:
sig
  structure G : GRAPH
	datatype igraph = IGRAPH of 
		{ graph: G.graph,
		  tnode: Temp.temp -> G.node, 
		  gtemp: G.node -> Temp.temp, 
		  moves: (G.node * G.node) list
		}
  val interferenceGraph : Flow.flowgraph -> 
                          igraph * (Flow.Graph.node -> 
                                    Temp.temp list)
  val show : TextIO.outstream * igraph -> unit
end =
struct 
  structure G = Graph
  datatype igraph = IGRAPH of 
    { graph: G.graph,
      tnode: Temp.temp -> G.node, 
      gtemp: G.node -> Temp.temp, 
      moves: (G.node * G.node) list
    }
	(* remember what is live at exit of each node *)
  type liveSet = unit Temp.Table.table * Temp.temp list
  type liveMap = liveSet Flow.Graph.Table.table

fun show(out, igraph) = ()
fun interferenceGrpah(fg) =

	(* make IG from LiveMap *)
	let 
    fun makeIG(fg) = ()
		(* if node is in def *)
		 
		(* at edge where temps are in liveMap *)
	in
		(* each flow node *) ()
	end

	(* return list of temps that are live-out at a node *)
	let fun liveOuts(n) = ()

	in
    ()
	end

	(* return *)
  ()
	(*igraph: makeIG(fg), (Flow.Graph.node -> Temp.temp list): liveouts;*)



end