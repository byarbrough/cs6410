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
    
    fun checkInt ({exp, ty= T.INT}, pos) = ()
   	  | checkInt ({exp, ty}, pos) = (TypeErrorException(pos); ())
    
    fun transTy (tenv, ty) = ()
    fun transDec(venv, tenc, dec) = ()
    fun transExp(venv, tenv) =
    let fun trexp (A.OpExp{left, oper= A.PlusOp, right, pos}) =
                  (checkInt(trexp left, pos);
                  checkInt(trexp right, pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.MinusOp, right, pos}) =
                  (checkInt(trexp left, pos);
                  checkInt(trexp right, pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.TimesOp, right, pos}) =
                  (checkInt(trexp left, pos);
                  checkInt(trexp right, pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.DivideOp, right, pos}) =
                  (checkInt(trexp left, pos);
                  checkInt(trexp right, pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.EqOp, right, pos}) =
                  (checkInt(trexp left, pos);
                  checkInt(trexp right, pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.NeqOp, right, pos}) =
                  (checkInt(trexp left, pos);
                  checkInt(trexp right, pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.LtOp, right, pos}) =
                  (checkInt(trexp left, pos);
                  checkInt(trexp right, pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.LeOp, right, pos}) =
                  (checkInt(trexp left, pos);
                  checkInt(trexp right, pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.GtOp, right, pos}) =
                  (checkInt(trexp left, pos);
                  checkInt(trexp right, pos);
                  {exp=(),ty= T.INT})
	  | trexp (A.OpExp{left, oper= A.GeOp, right, pos}) =
                  (checkInt(trexp left, pos);
                  checkInt(trexp right, pos);
                  {exp=(),ty= T.INT})

	
	
	
	
	
	
	
	
	
		      
    	  | trexp (A.RecordExp{fields, typ, pos}) = {exp=(),ty= T.INT}
    in 
    	trexp
    end
	fun transVar(venv, tenv, var) = ()

	fun transProg(absyn) = ((transExp(E.base_venv, E.base_tenv) absyn); ())
end
