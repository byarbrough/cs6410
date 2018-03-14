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
  type level = int (*Probably need to change this to somehting more useful.*)
  type access = level * F.access
  
  val outermost = 0
  fun newLevel(temp) = 1
  fun formals(level) = nil
  fun allocLocal(level) = fn(b) => (1, (F.allocLocal(F.newFrame({name= T.newlabel(), formals= nil})) true))

end
  