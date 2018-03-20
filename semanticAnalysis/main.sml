signature MAIN = 
sig
	val run : string -> Translate.frag list
end
structure Main : MAIN = 
struct
	fun run filename =
		let 
			val ast = Parse.parse(filename)
		in 
			FindEscape.findEscape(ast);
			Semant.transProg(ast)
		end
end