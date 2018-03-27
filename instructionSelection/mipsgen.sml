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

			(* Helper function for binary arithmetic *)
			fun helpBinOp(r, T.PLUS, T.CONST(i), right) = 
				  {assem="ADDI `d0, `s0+" ^ int i ^ "\n",
				  src=[munchExp(right)], dest=[r], jump=NONE}
				| helpBinOp(r, T.PLUS, left, T.CONST(i))  =
		          {assem="ADDI `d0, `s0+" ^ int i ^ "\n",
		          src=[munchExp(left)], dest=[r], jump=NONE}
		        | helpBinOp(r, T.PLUS, left, right) =
		          {assem="ADD `d0, `s0+'s1\n",
		          src=[munchExp(left), munchExp(right)], dest=[r], jump=NONE}
		        | helpBinOp(r, T.MINUS, left, right) = 
		          {assem="SUB `d0, `s0-`s1\n",
		          src=[munchExp(left), munchExp(right)], dest=[r], jump=NONE}
		        | helpBinOp(r, T.MULT, left, right) = 
		          {assem="MUL `d0, `s0*`s1\n",
		          src=[munchExp(left), munchExp(right)], dest=[r], jump=NONE}
		        | helpBinOp(r, T.DIV, left, right) = 
		          {assem="DIV `s0\ `s1\n" ^ "MFLO `d0\n",
		          src=[munchExp(left), munchExp(right)], dest=[r], jump=NONE}

	         (* Helper function for relational operators *)
	         fun helpRelOp(r, ) =
	         	{"", src=[], dest=[], JUMP=SOME}

			fun munchStm(T.SEQ(a,b)) = (* stm sequence *)
				  (muchStm(a), muchStm(b))
				| muchStm(T.MOVE(T.MEM(e1), e2)) = (* store results in memory *)
				  emit(A.OPER{assem="SW `s0, 0(`s1)\n", 
				  	src=[munchExp(e1), munchExp(e2)], dst=[], jump=NONE})
				| muchStm(T.MOVE(T.TEMP i, e2)) = (* store results in temp *)
				  emit(A.OPER{assem="ADD `d0, `s0, r0\n",
				  	src=[munchExp(e2)], dst=[i], jump=NONE})
				| muchStm(T.LABEL lab) = (* simple label *)
				  emit(A.LABEL{assem= lab ^ :\n", lab=lab})

			and munchExp(T.COSNT i ) = (* load constant *)
			  result(fn r => emit(A.OPER
			  {assem="ADDI `d0, r0+" ^ int i ^ "\n", src=[], dst=[r], jump=NONE}))
			| munchExp(T.BINOP(trop, left, right)) (* arithmetic *)
				result(fn r => emit(helpBinOp(r, trop, left, right)))
			| munchExp(T.TEMP t) = t (* the temp *)



		in
			munchStm stm;
			rev(!ilist)
		end
end