signature ENV = 
sig
	type ty
	datatype enventry = 
	  VarEntry of {access: Translate.access, ty : ty}
	| FunEntry of {level: Translate.level, 
				   label: Temp.label, 
				   formals: ty  list, 
				   result: ty}
	val base_tenv : ty Symbol.table
	val base_venv : enventry Symbol.table
end
structure Env : ENV = 
struct
	structure S = Symbol
	structure T = Types 
	type ty = T.ty
	datatype enventry = 
		  VarEntry of {access: Translate.access, ty : ty}
		| FunEntry of {level: Translate.level, 
					   label: Temp.label, 
					   formals: ty  list, 
					   result: ty}
	val base_tenv = 
		(S.enter ((S.enter ((S.enter (S.empty, 
			S.symbol("string"), T.STRING)),
			S.symbol("int"), T.INT)),
			S.symbol("nil"), T.NIL))

	val base_venv = 
	(S.enter ((S.enter ((S.enter ((S.enter ((S.enter
	((S.enter ((S.enter ((S.enter ((S.enter ((S.enter 
		(S.empty, 
		S.symbol("print"), FunEntry({level = 1, label = Temp.newlabel(), formals= [T.STRING], result= T.UNIT }))),
		S.symbol("flush"), FunEntry({level = 1, label = Temp.newlabel(), formals= [], result= T.UNIT }))),
		S.symbol("getchar"), FunEntry({level = 1, label = Temp.newlabel(), formals= [], result= T.STRING }))),
		S.symbol("ord"), FunEntry({level = 1, label = Temp.newlabel(), formals= [T.STRING], result= T.INT }))),
		S.symbol("chr"), FunEntry({level = 1, label = Temp.newlabel(), formals= [T.INT], result= T.STRING }))),
		S.symbol("size"), FunEntry({level = 1, label = Temp.newlabel(), formals= [T.STRING], result= T.INT }))),
		S.symbol("substring"), FunEntry({level = 1, label = Temp.newlabel(), formals= [T.STRING, T.INT, T.INT], result= T.STRING }))),
		S.symbol("concat"), FunEntry({level = 1, label = Temp.newlabel(), formals= [T.STRING, T.STRING], result= T.STRING }))),
		S.symbol("not"), FunEntry({level = 1, label = Temp.newlabel(), formals= [T.INT], result= T.INT }))),
		S.symbol("exit"), FunEntry({level = 1, label = Temp.newlabel(), formals= [T.INT], result= T.UNIT })))
end