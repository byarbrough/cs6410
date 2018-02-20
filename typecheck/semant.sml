signature SEMANT = 
sig
	val transProg : Absyn.exp -> unit
end
structure Semant : SEMANT = 
struct 
	structure A = Absyn
    structure E = Env
    structure T = Translate
    exception typeError
    
    
    fun transTy (tenv, ty) = ()
    fun transDec(venv, tenc, dec) = ()
    fun transExp(venv, tenv, exp) = ()
	fun transVar(venv, tenv, var) = ()

	fun transProg(absyn) = transExp(E.base_venv, E.base_tenv, absyn)
end