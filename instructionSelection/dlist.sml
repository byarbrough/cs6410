structure DList : 
sig
	type 'a dlist
	val newlist : unit -> dlist
	val add : 'a * 'a dlist -> unit
	val rem : 'a * 'a dlist -> unit
	val next : unit -> 'a 
	val prev : unit -> 'a
	val size :'a dlist -> int
	val member? : 'a * 'a dlist -> bool 
	val map : ...
	val app : ...
end
struct
	
end