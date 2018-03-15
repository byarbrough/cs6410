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

(* Temps are abstract names for local variables*)
structure Temp : TEMP = 
struct
	structure Table = IntMapTable(type key = int 
		fun getInt i = i)
	val curNumTemp = ref 0
	type temp = int
	(* return new temp from infinite set of temps *)	
	fun newTemp() = curNumTemp = !curNumTemp + 1; 
		            curNumTemp 
	fun makestring(temp) = Int.toString(temp)
	(* labels are abstract names for static memory *)
	type label = Symbol.symbol
	val curNumLabel = ref 100
	(* return a new label *)
	fun newlabel() = curNumLabel = !curNumLabel + 1;
					 Symbol.symbol("L" ^ Int.toString(!curNumLabel)
	fun namelabel(str) = Symbol.symbol str (* retrun new label for assembly language *)
end

