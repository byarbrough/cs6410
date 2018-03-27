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

			fun helpBinOp(r, T.PLUS, T.CONST(i), right) = 
					{"ADDI `d0 <- `s0+" ^ int i ^ "\n",
					src=[munchExp(right)], dest=[r], JUMP=NONE}
				| helpBinOp(r, T.PLUS, left, T.CONST(i))  =
          {"ADDI `d0 <- `s0+" ^ int i ^ "\n",
          src=[munchExp(left)], dest=[r], JUMP=NONE}
        | helpBinOp(r, T.PLUS, left, right) =
          {"ADD `d0 <- `s0+'s1\n",
          src=[munchExp(left), munchExp(right)], dest=[r], JUMP=NONE}
        | helpBinOp(r, T.MINUS, left, right) = 
          {"SUB `d0 <- `s0-`s1\n",
          src=[munchExp(left), munchExp(right)], dest=[r], JUMP=NONE}
        | helpBinOp(r, T.MULT, left, right) = 
          {"MUL `d0 <- `s0*`s1\n",
          src=[munchExp(left), munchExp(right)], dest=[r], JUMP=NONE}
        | helpBinOp(r, T.DIV, left, right) = 
          {"DIV `s0\`s1\n" ^
           "MFLO `d0\n",
          src=[munchExp(left), munchExp(right)], dest=[r], JUMP=NONE}

			fun munchStm(T.CJUMP)

			and munchExp(T.COSNT i ) =
				result(fn r => emit(A.OPER
					{"ADDI `d0 <- r0+" ^ int i ^ "\n", src=[], dst=[r], jump=NONE}))
			| munchExp(T.BINOP(trop, left, right))
				result(fn r => emit(helpBinOp(r, trop, left, right)))
			| munchExp(T.TEMP t) = t



		in
			munchStm stm;
			rev(!ilist)
		end
end