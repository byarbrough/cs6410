structure Liveness:
sig
  structure G : GRAPH
	datatype igraph = IGRAPH of 
		{ graph: G.graph,
		  tnode: Temp.temp -> G.node, 
		  gtemp: G.node -> Temp.temp, 
		  moves: (G.node * G.node) list
		}
  val interferenceGraph : Flow.flowgraph -> 
        igraph * (Flow.Graph.node -> Temp.temp list)
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
  fun union(l1, l2)  = 
      helpUnionSub(l1, l2, makeHS(l2, Temp.Table.empty))

  (*returns the contents of l1 - the contents of l2*)
  fun sub(l1, l2) =
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

   (* same as above but for temps *)
   fun getFromTemp(temp, table) =
   		case Temp.Table.look(table, temp)
   			of NONE => ErrorMsg.impossible
   				("temp: " ^ Int.toString(Temp.tempint(temp)) ^ " not in map but should be")
   			| SOME(v) => v

  (*check if the length of a listref is less than a list.*)
  fun compL(rold, lnew) = 
        length(!rold) < length(lnew)

        
  fun show(out, IGRAPH{graph, tnode, gtemp, moves}) =
    let 
      fun printNode(node) =
        TextIO.output(out, 
          "node " ^ G.nodename(node) ^ " : " ^ 
          (foldr (fn(n, str) => G.nodename(n) ^ " " ^ str)
          "" (G.adj(node))) ^ "\n")
      val nodes = G.nodes
    in
    app printNode (G.nodes(graph))
    end

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
		val Flow.FGRAPH({control, def, use, ismove})=fg
		val mapped = makeLiveMap(fg)
		val bbnodes = G.nodes(control)
		val regG = G.newGraph()
  	(* add all temps from list to table *)
  	fun nodesAdd([], tt, nt) = (tt, nt)
  	 |  nodesAdd(t :: temps, tt, nt) = 
  	 	let
  	 		val node = G.newNode(regG)
  	 		(* update tables *)
  	 		val tt' = Temp.Table.enter(tt, t, node)
  	 		val nt' = T.enter(nt, node, t) 
  	 	in
  	 		nodesAdd(temps, tt', nt')
  	 	end

  	 (* add nodes to graph, return complete tables *)
  	fun initIgraph([], acctemps) =
  			nodesAdd(acctemps, Temp.Table.empty, T.empty)
  	  | initIgraph(n :: myNodes, acctemps) =
	  		let
	  			val (_, tlist) = getFrom(n, mapped)
	  		in
	  			initIgraph(myNodes, union(acctemps, tlist))
	  		end

  	val (ttable, ntable) = initIgraph(bbnodes, [])
    val lol = app (fn(reg) => 
            print(G.nodename reg ^ " : " ^ 
                  Int.toString(Temp.tempint(
                               getFrom(reg, ntable))) ^ "\n"))
                                (G.nodes(regG))

  	fun constructIG(moves) =
      let 
        val nodeToLiveTempTable = foldr 
        (fn(node, tab) => 
          let
            val (_, l) = getFrom(node, mapped)
          in
            T.enter(tab, node, l)
          end) T.empty bbnodes
      in 
   		(IGRAPH({
   			graph=regG,
   			tnode= (fn(temp) => getFromTemp(temp, ttable)),
   			gtemp= (fn(node) => getFrom(node, ntable)),
   			moves=moves
   			}), (fn(node) => getFrom(node, nodeToLiveTempTable)))
      end

  	(* make interference graph *)
  	fun makeIG([], moves) = constructIG(moves)
  	  | makeIG(bb :: bblocks, moves) = 
  		let
  			val defRegs = getFrom(bb, def)
        val isAMove = getFrom(bb, ismove)
        val lol = if isAMove then
            (print("node " ^ G.nodename bb ^ " :\n  use: ");
             (app (fn(r) => 
                print(Int.toString(Temp.tempint(r)) ^ " ")) 
            (getFrom(bb, use)));
             print("\n  def: ");
             (app (fn(r) => 
                print(Int.toString(Temp.tempint(r)) ^ " ")) 
            (getFrom(bb, def)));
             print("\n"))


        else ()

        val useNode = getFromTemp((hd (getFrom(bb, use))), ttable)
  			val (_, liveReg) = getFrom(bb, mapped)
        val moves' = if isAMove 
                     then (getFromTemp((hd defRegs), ttable),
                           useNode) :: moves
                     else moves 
  		in
  			(app (fn(dreg) => app (fn(lreg) => 
  				let
  					val dnode = getFromTemp(dreg, ttable)
  					val lnode = getFromTemp(lreg, ttable)
  				in
  					if isAMove andalso G.eq(lnode, useNode) 
            then () 
            else G.mk_edge({from=dnode, to=lnode})
  				end) liveReg) defRegs; 
        makeIG(bblocks, moves'))
  		end
	in
		makeIG(bbnodes, [])
  end

end