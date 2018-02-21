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
    exception TypeErrorException of int
    
    fun checkTypeWrapper(true, pos) = ()
    	| checkTypeWrapper(false, pos) = 
			raise TypeErrorException(pos)

    fun checkInt ({exp, ty= T.INT}) = true
      | checkInt ({exp, ty}) = false

    fun checkStr ({exp, ty= T.STRING}) = true
      | checkStr ({exp, ty}) = false			    
    
    fun transTy (tenv, ty) = ()
    fun transDec(venv, tenc, dec) = ()
    fun transExp(venv, tenv) =
    let fun trexp (A.NilExp) = {exp=(),ty=T.NIL}
	  | trexp (A.IntExp(num)) = {exp=(),ty=T.INT}
	  | trexp (A.StringExp(str)) = {exp=(),ty=T.STRING}
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
							
    in 
    	trexp
    end
	fun transVar(venv, tenv, var) = ()

	fun transProg(absyn) = ((transExp(E.base_venv, E.base_tenv) absyn); ())
end
