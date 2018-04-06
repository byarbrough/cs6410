signature MAKEGRAPH = 
 sig
	val instrs2graph: Assem.instr list -> 
					  Flow.flowgraph * Flow.Graph.node list
end 
structure MakeGraph : MAKEGRAPH =
struct 
  structure G = Graph
  structure T = Graph.Table
  structure S = Symbol
  structure A = Assem
  structure F = Flow
  (* Update the JumpTable to have the label (if present)
     associated with the given node. This is so a label is 
     associated with the instruction (node) after it.*)
  fun updateJTable(jTable, node, NONE) = jTable
    | updateJTable(jTable, node, SOME(lab)) = 
        S.enter(jTable, lab, node)
  (* Update the graph to include the dependency on the previous
     node (if present) *)
  fun addPrevNode(fromNode, NONE) = ()
    | addPrevNode(fromNode, SOME(toNode)) =
    G.mk_edge({from=fromNode, to=toNode})

  (*Helper for instrs2graph with the following parameters:
    1: Assem.instr list to process
    2: node Option: the previous node to add a edge to if present
    3: flowGraph the current flowGraph
    4: jumpWL: a (label list * node) list which represents all of
       the nodes which have jumps that need to be added to the 
       graph. This is done at the end once all the labels are 
       created
    5: jTable: A Table of labels to nodes. This is built up as the 
       instrs are processed and is used at the end to add the jumpWL
       edges
    6: addLabel: a label option used with updateJTable to add labels to 
       the jTable.*)

	fun instrsHelper([] : A.instr list, 
                   prevNode : F.Graph.node option, 
                   fgraph : F.flowgraph, 
                   nodes : F.Graph.node list, 
                   jumpWL : (Temp.label list * F.Graph.node) list, 
                   jTable : F.Graph.node S.table, 
                   addLabel : Temp.label option) = 
        let
          (*returns the node associated with a label using 
            jTable*)
          fun getJumpNode(lab) =
            case S.look(jTable, lab) 
              of NONE => 
                   ErrorMsg.impossible "label not in jumpeTable"
               | SOME(node) => node
          
          (*Add an edge from the given node to 
            every label in jList*)
          fun addEdges(jList, node) =
          let
            fun addEdge(lab) = 
              G.mk_edge({from=node, to=getJumpNode(lab)})
          in
            app addEdge jList
          end
        in
          (app addEdges jumpWL;
           (fgraph, nodes))
        end
    | instrsHelper(A.OPER({assem, dst, src, jump}) :: instrs, 
                   prevNode, fgraph, nodes, jumpWL, jTable, addLabel) =
        let
          val F.FGRAPH{control, def, use, ismove} = fgraph
          val node = G.newNode(control)
          val def' = T.enter(def, node, dst)
          val use' = T.enter(use, node, src)
          val ismove' = T.enter(ismove, node, false)
          val jumpWL' = (case jump 
                          of NONE => jumpWL 
                           | SOME(l) => (l, node) :: jumpWL)
          val jTable' = updateJTable(jTable, node, addLabel)
        in
          (addPrevNode(node, prevNode);
          instrsHelper(instrs, SOME(node),
                       F.FGRAPH{control=control, 
                        def=def', 
                        use=use', 
                        ismove=ismove'}, 
                       node :: nodes, 
                       jumpWL', 
                       jTable',
                       NONE))
        end

    | instrsHelper(A.LABEL({assem, lab}) :: instrs, 
                   prevNode, fgraph, nodes, jumpWL, jTable, addLabel) =
        instrsHelper(instrs, prevNode, fgraph, nodes, jumpWL, jTable,
                     SOME(lab))
    
    | instrsHelper(A.MOVE({assem, dst, src}) :: instrs, 
                   prevNode, fgraph, nodes, jumpWL, jTable, addLabel) = 
      let
          val F.FGRAPH{control, def, use, ismove} = fgraph
          val node = G.newNode(control)
          val def' = T.enter(def, node, [dst])
          val use' = T.enter(use, node, [src])
          val ismove' = T.enter(ismove, node, true)
          val jTable' = updateJTable(jTable, node, addLabel)
      in
          (addPrevNode(node, prevNode);
          instrsHelper(instrs, SOME(node),
                       F.FGRAPH{control=control, 
                        def=def', 
                        use=use', 
                        ismove=ismove'}, 
                       node :: nodes, 
                       jumpWL, 
                       jTable',
                       NONE))
      end

  (* Creates base values and calls them on instrsHelper *)
  fun instrs2graph(arr) = 
    let 
      val graph =F.FGRAPH({
        control= G.newGraph(),
        def= Graph.Table.empty,
        use= Graph.Table.empty,
        ismove= Graph.Table.empty})

    in
      instrsHelper(arr, NONE, graph, [], [], S.empty, NONE)
    end
end