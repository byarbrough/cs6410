CM.make "sources.cm"; 
use("hello.sml");
structure T = Graph.Table

fun testCode(lab, i, instrs) =
	let
		val (fg, nl) = MakeGraph.instrs2graph(instrs)
		val (ig, liveMap) = Liveness.interferenceGraph(fg)
  	in
		Liveness.show(TextIO.stdOut, ig)
	end;
app testCode insrLists;
(*Main.compile("../testcases/factorial.tig");*)