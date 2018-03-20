structure FindEscape :
sig 
	val findEscape: Absyn.exp -> unit
end =

struct 
	structure A = Absyn
	structure S = Symbol
	
	(*The current functional nesting level*)
	type depth = int
	type escEnv = (depth * bool ref) S.table

	(* Traverse a Var and check if it escapes*)
	fun traverseVar(env:escEnv, d:depth, v:A.var): unit = 
		(case v 
			of A.SimpleVar(name, pos) => 
				(case S.look(env, name) 
					of SOME(eDepth, escape) => 
						if d > eDepth then escape := true
													else ()
					| None => ())
			 | A.FieldVar(var, name, pos) => traverseVar(env, d, var)
			 | A.SubscriptVar(var, exp, pos) => 
			 		(traverseExp(env, d, exp);
		 			 traverseVar(env, d, var)))

	(* Traverse experesions and check if they vars and if any escape from 
	   thier level.*)
	and traverseExp(env: escEnv, d: depth, e:A.exp) : unit = 
		let fun trexp(A.VarExp(var)) = traverseVar(env, d, var)
	        | trexp(A.NilExp) = ()
	        | trexp(A.IntExp(i)) =()
	        | trexp(A.StringExp(str, pos)) = ()
	        | trexp(A.CallExp({func, args, pos})) = app trexp args

	        | trexp(A.OpExp ({left, oper, right, pos})) =
	        		(trexp left; trexp right)
	        | trexp(A.RecordExp({fields, typ, pos})) =
	        		app (fn(name, exp, pos) => trexp(exp)) fields
	        | trexp(A.SeqExp(nil)) = ()
	        | trexp(A.SeqExp((exp, pos) :: seqExp)) = 
	        		(trexp exp; trexp (A.SeqExp(seqExp)))
	        | trexp(A.AssignExp({var, exp, pos})) = 
	        		trexp exp
	        | trexp(A.IfExp({test, then', else', pos})) =
	        		(trexp test; trexp then'; 
	        			(case else'
	        				of SOME(exp) => trexp(exp) 
	        				 | NONE => ()))
	        | trexp(A.WhileExp({test, body, pos})) = 
	        		(trexp test; trexp body)
		    	| trexp(A.ForExp({var, escape, lo, hi, body, pos})) = 
	    				let 
	    					val newEnv = (escape := false; 
		    				            S.enter(env, var, (d, escape)))
		    			in
		    				(traverseExp(newEnv, d, lo);
		    				 traverseExp(newEnv, d, hi);
		    				 traverseExp(newEnv, d, body))
		    			end 

	        | trexp(A.BreakExp(pos)) = ()
	        | trexp(A.LetExp({decs, body, pos})) = 
	        		traverseExp(traverseDecs(env, d, decs), d, body) 
	        | trexp(A.ArrayExp({typ, size, init, pos})) = 
	        		(trexp size; trexp init)
		in 
			trexp(e)
		end

		(*Traverse the Decs by adding variable decs to the env,
		  and checking any exps for escaping variables*)
	and traverseDecs(env, d, decs: A.dec list): escEnv =
		let fun trdec(d: depth, nil) = env
		      | trdec(d, dec :: decs) = 
		  	(case dec 
		  		(*for functions increase depth and add arguments then check body*)
		  		of A.FunctionDec(nil) => env
		  		 | A.FunctionDec({name, params, result, body, pos} :: funDecs) =>
			  		let 
			  			(*acummulating env with fields*)
			  			fun addToEnv({name, escape, typ, pos}, env) = 
			  					(escape := false;
			  					 S.enter(env, name, (d + 1, escape)))
			  			val newEnv = foldl addToEnv env params
		  			in
		  				(traverseExp(newEnv, d + 1, body); 
	  					 traverseDecs(env, d, decs))  
						end
					(*for variables add them to the env and check their init*)
		  		|  A.VarDec({name, escape, typ, init, pos}) =>
			  		let 
			  			val newEnv = S.enter(env, name, (d, escape)) 
		  			in
		  				(escape := false;
		  				 traverseExp(newEnv, d, init); 
	  					 traverseDecs(newEnv, d, decs))  
						end
					(*typedecs don't need to be checked.*)
		  		|  A.TypeDec(tylist) => trdec(d, decs))
		in trdec(d, decs)
		end 

	(*Calculates the escaoes of the given expression*)
	fun findEscape(prog: A.exp) : unit = traverseExp(S.empty, 0, prog)
end