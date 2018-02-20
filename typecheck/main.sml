signature MAIN = 
sig
	val run : string -> unit
end
structure Main : MAIN = 
struct
	fun run filename =
		Semant.transProg(Parse.parse(filename))
end