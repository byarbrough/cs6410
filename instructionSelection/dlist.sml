structure DList : 
sig
	type 'a dlist
	val newlist : unit -> dlist
	val add : 'a * 'a dlist -> unit
	val rem : 'a dlist -> unit
	val next : unit -> 'a 
	val prev : unit -> 'a
end
 = 
struct
	
end