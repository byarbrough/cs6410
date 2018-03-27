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

	fun codegen (frame) (stm: T.stm) : A.instr list =
		let 
			val ilist = ref (nil: A.instr list)
			(* accumulate results into list *)
			fun emit(x) = 
				ilist := x :: !ilist
			(* hold result *)
			fun result(gen) = 
				let
					val t = Temp.newtemp()
				in 
					gen t; t
				end


			fun munchStm() =

			and munchExp(T.COSNT i ) =
				result(fn r => emit(A.OPER
					{"ADDI `d0 <- r0+" ^ int i ^ "\n", src[], dst=[r], jump=NONE}))
			| munchExp(T.TEMP t) = t


		in
			munchStm stm;
			rev(!ilist)
		end
end