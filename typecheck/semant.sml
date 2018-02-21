signature SEMANT = 
sig
	val transProg : Absyn.exp -> unit
end
structure Semant : SEMANT = 
struct 
	structure A = Absyn
    structure E = Env
    structure Tr = Translate
    structure T = Types
    structure S = Symbol
    exception TypeErrorException of int
    
    fun checkTypeWrapper(true, pos) = ()
    	| checkTypeWrapper(false, pos) =
    	( ErrorMsg.error pos ("Types missmatched at line " ^ Int.toString(pos));
			raise TypeErrorException(pos))

    fun checkInt ({exp, ty= T.INT}) = true
      | checkInt ({exp, ty}) = false

    fun checkStr ({exp, ty= T.STRING}) = true
      | checkStr ({exp, ty}) = false			    
    
    fun transTy (tenv) = 
    let  fun 
    	trty (A.NameTy(id, pos)) = ()
      | trty (A.RecordTy(fields)) = ()
      | trty (A.ArrayTy(id, pos)) = ()
 	in 
  		trty
	end

    fun transDec(venv, tenc) = 
	let fun
		trdec (A.FunctionDec(fundecs)) = ()
	  | trdec (A.VarDec{name, escape, typ, init, pos}) = ()
	  | trdec (A.TypeDec(nil)) = ()	
	  | trdec (A.TypeDec({name, ty, pos} :: rest)) = ()
	in 
		trdec
	end 	
    fun transExp(venv, tenv) =
    let fun 
    	trexp (A.VarExp(var)) = trvar(var)
	  | trexp (A.NilExp) = {exp=(),ty=T.NIL}
	  | trexp (A.IntExp(num)) = {exp=(),ty=T.INT}
	  | trexp (A.StringExp(str)) = {exp=(),ty=T.STRING}

	  | trexp (A.CallExp{func, args, pos}) = {exp=(),ty=T.NIL}
      
      |	trexp (A.OpExp{left, oper= A.PlusOp, right, pos}) =
                  (checkTypeWrapper(
                  	checkInt(trexp left) andalso 
                  	checkInt(trexp right), pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.MinusOp, right, pos}) =
                  (checkTypeWrapper(
                  	checkInt(trexp left) andalso 
                  	checkInt(trexp right), pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.TimesOp, right, pos}) =
                  (checkTypeWrapper(
                  	checkInt(trexp left) andalso 
                  	checkInt(trexp right), pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.DivideOp, right, pos}) =
                  (checkTypeWrapper(
                  	checkInt(trexp left) andalso 
                 	checkInt(trexp right), pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.LtOp, right, pos}) =
                  (checkTypeWrapper(
                  	(checkStr(trexp left) andalso 
              		 checkStr(trexp right)) orelse
                    (checkInt(trexp left) andalso
                	 checkInt(trexp right)), pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.LeOp, right, pos}) =
                 (checkTypeWrapper(
                  	(checkStr(trexp left) andalso 
              		 checkStr(trexp right)) orelse
                    (checkInt(trexp left) andalso
                	 checkInt(trexp right)), pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.GtOp, right, pos}) =
                  (checkTypeWrapper(
                  	(checkStr(trexp left) andalso 
              		 checkStr(trexp right)) orelse
                    (checkInt(trexp left) andalso
                	 checkInt(trexp right)), pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.GeOp, right, pos}) =
                  (checkTypeWrapper(
                  	(checkStr(trexp left) andalso 
              		 checkStr(trexp right)) orelse
                    (checkInt(trexp left) andalso
                	 checkInt(trexp right)), pos);
                  {exp=(),ty= T.INT})

	  | trexp (A.OpExp{left, oper= A.EqOp, right, pos}) =
                  (checkTypeWrapper(
                  	(checkStr(trexp left) andalso 
              		 checkStr(trexp right)) orelse
                    (checkInt(trexp left) andalso
                	 checkInt(trexp right)), pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.NeqOp, right, pos}) =
                  (checkTypeWrapper(
                  	(checkStr(trexp left) andalso 
              		 checkStr(trexp right)) orelse
                    (checkInt(trexp left) andalso
                	 checkInt(trexp right)), pos);
                  {exp=(),ty= T.INT}) 

	  | trexp (A.RecordExp{fields, typ, pos}) = {exp=(),ty= T.INT}

	  | trexp (A.SeqExp(nil)) = {exp=(), ty= T.UNIT}
	  | trexp (A.SeqExp((exp, pos) :: tail)) = (trexp(A.SeqExp(tail)); trexp(exp))
	  | trexp (A.AssignExp{var, exp, pos}) = {exp=(), ty= T.UNIT}
	  | trexp (A.IfExp{test, then', else', pos}) = {exp=(), ty= T.UNIT}
	  | trexp (A.WhileExp{test, body, pos}) = {exp=(), ty= T.UNIT}
	  | trexp (A.ForExp{var, escape, lo, hi, body, pos}) = {exp=(), ty= T.UNIT}
	  | trexp (A.BreakExp(pos)) = {exp=(), ty= T.UNIT}
	  | trexp (A.LetExp{decs, body, pos}) = {exp=(), ty= T.UNIT}
	  | trexp (A.ArrayExp{typ, size, init, pos}) = {exp=(), ty= T.UNIT}
   
   and trvar (A.SimpleVar(id, pos)) = 
   	(case S.look(venv,id)
   		of SOME(E.E.VarEntry{access,t{exp=(), ty=T.NIL}
	 | trvar (A.FieldVar(var, field, pos)) =  {exp=(), ty=T.NIL}
	 | trvar (A.SubscriptVar(var, exp, pos)) =  {exp=(), ty=T.NIL}			
    in 
    	trexp
    end

	fun transProg(absyn) = ((transExp(E.base_venv, E.base_tenv) absyn); ())
end
