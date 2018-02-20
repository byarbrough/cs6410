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

	fun transProg(absyn) = transExp(E.baseVEnv, E.baseTEnv, absyn)
end