CM.make "sources.cm"; 
(*use("sier.sml");
structure T = Graph.Table

fun testCode(lab, i, instrs) =
	let
		val (fg, nl) = MakeGraph.instrs2graph(instrs)
		val (ig, liveMap) = Liveness.interferenceGraph(fg)
  	in
		(Liveness.show(TextIO.stdOut, ig);
		TextIO.output(TextIO.stdOut, "\n\n\n"))
	end;
app testCode insrLists;*)
Main.compile("../testcases/toy.tig");