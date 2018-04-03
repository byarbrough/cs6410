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
  fun updateJTable(jTable, node, NONE) = jTable
    | updateJTable(jTable, node, SOME(lab)) = 
        S.enter(jTable, lab, node)
  fun addPrevNode(fromNode, NONE) = ()
    | addPrevNode(fromNode, SOME(toNode)) =
    G.mk_edge({from=fromNode, to=toNode})

	fun instrsHelper([] : A.instr list, 
                   prevNode : Flow.Graph.node option, 
                   fgraph : Flow.flowgraph, 
                   nodes : Flow.Graph.node list, 
                   jumpWL : (Temp.label list * Flow.Graph.node) list, 
                   jTable : Flow.Graph.node S.table, 
                   addLabel : Temp.label option) = 
        let
          fun getJumpNode(lab) =
            case S.look(jTable, lab) 
              of NONE => 
                  ErrorMsg.impossible "label not in jumpeTable"
               | SOME(node) => node
          
          
          fun addEdges(jList, node) =
          let
            fun addEdge(lab) = 
              G.mk_edge({to=node, from=getJumpNode(lab)})
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