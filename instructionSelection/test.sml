CM.make "sources.cm"; 
use("sier.sml");
structure T = Graph.Table

fun testCode(lab, i, instrs) =
	let
		val (Flow.FGRAPH{control,def, use, ismove} , nodes) = 
              MakeGraph.instrs2graph(instrs)
  	in
		app (fn i => (print (Flow.Graph.nodename(i) ^ "\n"))) nodes
	end;
app testCode insrLists;
(*Main.compile("../testcases/factorial.tig");*)