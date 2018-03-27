signature CODEGEN = 
sig
	structure Frame : FRAME
	val codegen : Frame.Frame -> Tree.stm -> Assem.instr list
end

structure MipsGen : CODEGEN = 
struct
	structure A = Assem
	structure T = Tree
	structure F = MipsFrame

	fun codegen(frame)
		let
			fun munchStm(stm) -> 

			and munchExp(exp) -> 	
		in
			munchStm
		end
end