structure LIVENESS:
sig
  structure G : GRAPH
	datatype igraph = IGRAPH of 
		{ graph: G.graph,
		  tnode: Temp.temp -> G.node, 
		  gtemp: G.node -> Temp.temp, 
		  moves: (G.node * G.node) list
		}
  val interferenceGraph : Flow.flowgraph -> unit
                          (*igraph * (Flow.Graph.node -> 
                                    Temp.temp list)*)
  val show : TextIO.outstream * igraph -> unit
end =
struct 
  structure G = Graph
  structure T = G.Table
  datatype igraph = IGRAPH of 
    { graph: G.graph,
      tnode: Temp.temp -> G.node, 
      gtemp: G.node -> Temp.temp, 
      moves: (G.node * G.node) list
    }
	(* remember what is live at exit of each node *)
  type liveSet = unit Temp.Table.table * Temp.temp list
  type liveMap = liveSet Flow.Graph.Table.table
  fun union(l1, l2) = 
    let
      fun makeHS([], hs) = hs
        | makeHS(i :: l, hs) =
          let 
            val hs' = T.enter(hs, i, ())
          in 
            makeHS(l, hs')
          end
      (*add all of the items in l not in hashset hs to acc and then return acc*)
      fun helpUnion([], acc, hs) = acc
        | helpUnion(item :: l, acc, hs) = 
            (case T.look(hs, item) 
               of SOME() => helpUnion(l, acc, hs)
                | NONE =>  helpUnion(l, item :: acc, hs))

    in
      helpUnion(l1, l2, makeHS(l2, T.empty))
    end


fun show(out, igraph) = ()
(*
Make a table of node to list ref for in and out with all the nodes pointing to empty lists (ignoring moves)

Loop until hasnt changed. 

Go through nodes in fgraph and for each do:
  out = suc nodes in
  in  = use and (out - def)  

subtract needed
boolean flag needed



*)
fun interferenceGraph(fg) =

	(* make IG from LiveMap *)
	let 
    fun liveOuts(n) = ()
    fun makeIG(fg) = ()
		(* if node is in def *)
		 
		(* at edge where temps are in liveMap *)

	(* return list of temps that are live-out at a node *)
	(* return *)
  in 
  ()
	(*igraph: makeIG(fg), (Flow.Graph.node -> Temp.temp list): liveouts;*)
end


end