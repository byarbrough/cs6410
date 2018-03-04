(*
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
	type temp = string

	val newTemp = temp
	structure Table : TABLE sharing type Table.key = temp
	
end
*)


(* Temps are abstract names for local variables*)
structure Temp :
sig
	eqtype temp
	val newTemp : unit -> temp (* return new temp from infinite set of temps *)
	structure Table : TABLE sharing type Table.key = temp
	val makestring: temp -> string
	(* labels are abstract names for static memory *)
	type label = Symbol.symbol
	val newlabel : unit -> label (* return a new label *)
	val namelabel : string -> label (* retrun new label for assembly language *)
end

