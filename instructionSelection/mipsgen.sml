signature CODEGEN = 
sig
	structure Frame : FRAME
	val codegen : Frame.frame -> Tree.stm -> Assem.instr list
end

structure MipsGen : CODEGEN = 
struct
	structure A = Assem
	structure T = Tree
	structure Frame = MipsFrame
  structure S = Symbol
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

      (*Returns a string reprentation of a given int 
        without '~' used for negation*)
      fun int (i) =
        if i >= 0
        then Int.toString i
        else "-" ^ Int.toString(~i)
      (*Helper function for conditional expressions*)
      fun helpCOp(T.EQ) = "beq"
        | helpCOp(T.NE) = "bne"
        | helpCOp(T.LT) = "blt"
        | helpCOp(T.GT) = "bgt"
        | helpCOp(T.LE) = "ble"
        | helpCOp(T.GE) = "bge"
        | helpCOp(T.ULT) = "blt"
        | helpCOp(T.ULE) = "ble"
        | helpCOp(T.UGT) = "bgt"
        | helpCOp(T.UGE) = "bge"

			(* Helper function for binary arithmetic *)
			fun helpBinOp(r, T.PLUS, T.CONST(i), right) = 
				    {assem="addi `d0, `s0, " ^ int i ^ "\n",
				     src=[munchExp(right)], dst=[r], jump=NONE}
				| helpBinOp(r, T.PLUS, left, T.CONST(i))  =
	          {assem="addi `d0, `s0, " ^ int i ^ "\n",
	           src=[munchExp(left)], dst=[r], jump=NONE}
        | helpBinOp(r, T.PLUS, left, right) =
	          {assem="add `d0, `s0, `s1\n",
	           src=[munchExp(left), munchExp(right)], dst=[r], jump=NONE}
        | helpBinOp(r, T.MINUS, left, right) = 
	          {assem="sub `d0, `s0, `s1\n",
	           src=[munchExp(left), munchExp(right)], dst=[r], jump=NONE}
        | helpBinOp(r, T.MUL, left, right) = 
	          {assem="mul `d0, `s0, `s1\n",
             src=[munchExp(left), munchExp(right)], dst=[r], jump=NONE}
        | helpBinOp(r, T.DIV, left, right) = 
	          {assem="div `s0, `s1\nmflo `d0\n",
	           src=[munchExp(left), munchExp(right)], dst=[r], jump=NONE}
        | helpBinOp(r, bop, left, right) =
          ErrorMsg.impossible "helpBinOp given unsupported operator"

			and munchStm(T.SEQ(a,b)) = (* stm sequence *)
				  (munchStm(a); munchStm(b))
				| munchStm(T.MOVE(T.MEM(e1), e2)) = (* store results in memory *)
				    emit(A.OPER{assem="sw `s0, 0(`s1)\n", 
				  	 src=[munchExp(e1), munchExp(e2)], dst=[], jump=NONE})
				| munchStm(T.MOVE(T.TEMP i, e2)) = (* store results in temp *)
				    emit(A.OPER{assem="add `d0, `s0, r0\n",
			  	    src=[munchExp(e2)], dst=[i], jump=NONE})
				| munchStm(T.LABEL lab) = (* simple label *)
			      emit(A.LABEL{assem= S.name lab ^ "\n", lab=lab})
        | munchStm(T.CJUMP(cop, l, r, t, f)) =
            emit(A.OPER{assem=helpCOp(cop) ^ " `s0, `s1, `j0\n",
                      src=[munchExp(l), munchExp(r)],
                      dst=[],
                      jump=SOME([t,f])})
        | munchStm(T.EXP(T.CALL(T.NAME(lab), args))) =
            emit(A.OPER{assem="jal `j0\n", 
                        src=munchArgs(0, args),
                        dst=Frame.calldefs,
                        jump=SOME([lab])})
        | munchStm(T.EXP(T.CALL(e, args))) =
            emit(A.OPER{assem="jal `s0\n", 
                        src=munchExp(e) :: munchArgs(0, args),
                        dst=Frame.calldefs,
                        jump=NONE})
        | munchStm(T.EXP(e)) =
            (munchExp(e); ())
        | munchStm(T.JUMP(e, labs)) = 
            emit(A.OPER({assem="j `s0\n",
                          src=[munchExp(e)],
                          dst=[],
                          jump=SOME(labs)}))
        | munchStm(e) =
          ErrorMsg.impossible 
            (Printtree.printtree(TextIO.stdOut,e); 
          ErrorMsg.impossible 
            "munchStm match not found for exp ")
        

			and munchExp(Tree.ESEQ(s, e)) = 
          (munchStm s; munchExp e)
      | munchExp(T.CONST i ) = (* load constant *)
			  result(fn r => emit(A.OPER
			  {assem="addi `d0, r0, " ^ int i ^ "\n", src=[], dst=[r], jump=NONE}))
			| munchExp(T.BINOP(trop, left, right)) = (* arithmetic *)
				result(fn r => emit(A.OPER(helpBinOp(r, trop, left, right))))
			| munchExp(T.TEMP t) = t (* the temp *)
      | munchExp(T.NAME lab) = 
          result(fn r => emit(A.OPER{assem="lw `d0, " ^ Symbol.name lab ^ "\n",
                                src=[],
                                dst=[r],
                                jump=NONE}))
      | munchExp(T.MEM(e)) =
        result(fn r => emit(Assem.OPER{assem="la `d0, 0(`s0)\n",
                              src=[munchExp e],
                              dst=[r], jump=NONE}))
      | munchExp(T.CALL(T.NAME(lab), args)) =
        result(fn r => emit(A.OPER{assem="jal `j0\n", 
                        src= munchArgs(0, args),
                        dst=Frame.calldefs,
                        jump=SOME([lab])}))
      | munchExp(T.CALL(e, args)) =
        result(fn r => emit(A.OPER{assem="jal `s0\n", 
                        src=munchExp(e) :: munchArgs(0, args),
                        dst=Frame.calldefs,
                        jump=NONE}))
      

      and munchArgs(i, []) = []
        | munchArgs(i, arg :: args) = 
          munchExp(arg) :: munchArgs(i + 1, args)

		in
			munchStm stm;
			rev(!ilist)
		end
end