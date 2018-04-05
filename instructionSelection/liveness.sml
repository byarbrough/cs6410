structure LIVENESS:
sig
  structure G : GRAPH
	datatype igraph = IGRAPH of 
		{ graph: G.graph,
		  tnode: Temp.temp -> G.node, 
		  gtemp: G.node -> Temp.temp, 
		  moves: (G.node * G.node) list
		}
  val interferenceGraph : Flow.flowgraph -> igraph (*temp for building*)
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
	(*Live out of each node*)
  type liveSet = unit Temp.Table.table * Temp.temp list
  type liveMap = liveSet Flow.Graph.Table.table

  (*Makes a hashset of the values in a list of nodes*)
  fun makeHS([], hs) = hs
    | makeHS(i :: l, hs) =
      let 
        val hs' = Temp.Table.enter(hs, i, ())
      in 
        makeHS(l, hs')
      end

  (*add all of the items in l not in the hashset hs 
    to acc and then return acc*)
  fun helpUnionSub([], acc, hs) = acc
    | helpUnionSub(item :: l, acc, hs) = 
        (case Temp.Table.look(hs, item) 
          of SOME() => helpUnionSub(l, acc, hs)
           | NONE =>  helpUnionSub(l, item :: acc, hs))


  (*returns the union of two node lists.*)
  fun union(l1 : Temp.temp list, l2 : Temp.temp list) : Temp.temp list = 
      helpUnionSub(l1, l2, makeHS(l2, Temp.Table.empty))

  (*returns the contents of l1 - the contents of l2*)
  fun sub(l1: Temp.temp list, l2 : Temp.temp list) =
      helpUnionSub(l1, [], makeHS(l2, Temp.Table.empty))

  (*Returns the value associated with the given
    node in the given table. If the node isnt
    present raise an error. This should only be 
    used if the node is definitely in the table*)
  fun getFrom(node, table) = 
      case T.look(table, node)
        of NONE => ErrorMsg.impossible 
                    "node not in map but should be"
         | SOME(v) => v

  (*check if the length of a listref is less than a list.*)
  fun compL(rold, lnew) = 
        length(!rold) < length(lnew)

        
  fun show(out, igraph) = () 
(*TODO!*)

  (* Creates a liveMap of nodes to thier
     liveOut temps.
     It Loop until the liveness hasnt changed. 
     In each loop it goes through nodes in fgraph calculates:
     out = union of successor nodes in
     in  = use union (out sub def)  
  *)
  fun makeLiveMap(Flow.FGRAPH({control,def,use,ismove})) =
    let
      val nodes = G.nodes(control)
      
      (*create an inital in or outTable from the 
        given nodes and table*)
      fun initInOutTable([], tab) = tab
        | initInOutTable(n :: nodes, tab) =
            initInOutTable(nodes, 
                           T.enter(tab, n, ref []))
      
      val outTable = initInOutTable(nodes, T.empty)
      val inTable = initInOutTable(nodes, T.empty)

      (*calculate Liveout from the union of the 
        liveIn of the given nodes.*)
      fun calcLiveOut(succs) = 
        let
          (*return the liveIn list for the given node*)
          fun getIn(node) = 
            let
              val inref = getFrom(node, inTable)
            in
              !inref
            end
        in
          foldr union [] (map getIn succs) 
        end
      (*Help create the liveMap by calling calcLiveNodes until
        no changes were made (and the given bool is false)*)
      fun makeLiveMapHelper(
            inTable  : Temp.temp list ref T.table,
            outTable : Temp.temp list ref T.table,
            rep      : bool) : liveMap =
        let 
          fun createLiveMap() =  
            foldr (fn(n, tab) => 
                    let
                      val liveOut = getFrom(n, outTable)
                    in
                      T.enter(tab, n, (makeHS(!liveOut, 
                                        Temp.Table.empty), 
                                      !liveOut))
                    end) 
                  T.empty nodes 
        in
          if rep
            then calcLiveNodes(nodes, false) 
            else createLiveMap()  
        end

      (*Run one loop of calculating live in and out for
        each node in nodes.*)
      and calcLiveNodes([], hasChanged) =
            makeLiveMapHelper(inTable, outTable, hasChanged)
        | calcLiveNodes(n :: nodes, hasChanged) =
          let 
            val rIn         = getFrom(n, inTable)
            val rOut        = getFrom(n, outTable)
            val succs       = G.succ(n)
            val useRegs     = getFrom(n, use) 
            val defRegs     = getFrom(n, def)
            val liveOut     = calcLiveOut(succs)
            val liveIn      = union(useRegs, sub(liveOut, defRegs))
            val hasChanged' = hasChanged orelse 
                              compL(rIn, liveIn) orelse 
                              compL(rOut, liveOut)
          in
            (rOut := liveOut;
            rIn := liveIn;
            calcLiveNodes(nodes, hasChanged'))
          end
	in

		makeLiveMapHelper(inTable, outTable, true)
	end


fun interferenceGraph(fg) =

	(* make IG from LiveMap *)
	let 
	(* return list of temps that are live-out at a node *)
	fun liveOuts(n) = ()

	(* construct interference graph *)
	fun makeIG({control, def, use, ismove}) = 
		let
			val newig = IGRAPH({
				graph=G.newGraph(),
				tnode=(),
				gtemp=(),
				moves=[]})

			val nodes = G.nodes(control)
			fun addEdge(node, regList) =
				let
					fun addEdge(reg) = 
					G.mk_edge({from=reg, to=node})
				in
					app addEdge regList
				end
			fun findI([]) = ()
			 |  findI(n :: nodes) =
				let
					(* if node is in def *)
					val regList = getFrom(n, def)
				in
					(* add edge where temps are in liveMap *)
					(addEdge(n, regList);
					findI(nodes))
				end
		in
			(findI(nodes); newig)
		end
	in
		makeIG(fg)
		(*igraph: makeIG(fg), (Flow.Graph.node -> Temp.temp list): liveouts;*)
	end

end