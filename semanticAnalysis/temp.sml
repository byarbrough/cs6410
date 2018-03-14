signature TEMP = 
sig
	eqtype temp
	val newTemp : unit -> temp
	val makestring: temp -> string
	structure Table : TABLE sharing type Table.key = temp

	type label 
	val newlabel : unit -> label
	val namelabel : string -> label
end
(*
structure Temp : TEMP = 
struct
	type label = Symbol.symbol
	type temp = string

	val newTemp = temp
	structure Table : TABLE sharing type Table.key = temp
	
end
*)


(* Temps are abstract names for local variables*)
structure Temp : TEMP = 
struct
	structure Table = IntMapTable(type key = int 
		fun getInt i = i)
	type temp = int
	fun newTemp() = 1 (* return new temp from infinite set of temps *)

	fun makestring(temp) = "todo"
	(* labels are abstract names for static memory *)
	type label = Symbol.symbol
	fun newlabel() = Symbol.symbol "todo"(* return a new label *)
	fun namelabel(str) = Symbol.symbol str (* retrun new label for assembly language *)
end

