signature TRANSLATE = 
sig
	type level
	type access
	val outermost : level
	val newLevel : {parent: level, 
					name: Temp.label, 
					formals: bool list} -> level
	val formals : level -> access list
	val allocLocal : level -> bool -> access
end

structure Translate : TRANSLATE = struct 
  structure F = MipsFrame
  structure T = Temp
  datatype level = TopLevel 
  			 | Level of {parent: level, frame: F.frame, uni: unit ref}
  type access = level * F.access
  
  (*The outermost level*)
  val outermost = TopLevel

  (* returns a new level from the give name, parent level and formals*)
  fun newLevel({parent, name, formals}) = 
  		Level({ parent= parent,
		          frame= F.newFrame({name= name, formals= formals}), 
		          uni = ref ()})
  (*Return the access list of formals for the given level*)
  fun formals(TopLevel) = []
    | formals(Level(level)) = map (fn(formal) => (Level(level), formal)) (F.formals(#frame level))
 
  (*Return a function that will return an allocated variable given a boolean.*)
  fun allocLocal(TopLevel) = 
  		ErrorMsg.impossible "allocLocal should not be given outermost level"
  	| allocLocal(Level level) = fn(b) => (Level(level), (F.allocLocal(#frame level) b))
end
    