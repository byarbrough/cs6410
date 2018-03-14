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
  datatype level = Top 
  			 | Level of {parent: level, frame: F.frame, uni: unit ref}
  type access = level * F.access
  
  val outermost = Top
  fun newLevel({parent, name, formals}) = 
  		Level({ parent= parent,
		  frame= F.newFrame({name= name, formals= formals}), 
		  uni = ref ()})
  fun formals(level) = nil (*stubbed*)
  fun allocLocal(Top) =  ErrorMsg.impossible "allocLocal should not be given outermost level"
  	| allocLocal(Level level) = fn(b) => (Level(level), (F.allocLocal(#frame level) b))

end
  