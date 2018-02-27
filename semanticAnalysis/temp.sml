signature TEMP = 
sig
	eqtype temp
	val newTemp : unit -> temp
	val makestring: temp -> string

	type label 
	val newlabel : unit -> label
	val namelabel : string -> label
end
structure Temp : TEMP = 
struct
	type label = Symbol.symbol
	structure Table : TABLE sharing type Table.key = temp
	
end