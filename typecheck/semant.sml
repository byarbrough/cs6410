(*
TODO: 
Make sure Nil assignment is correct
Make sure dec/seq/all list stuff is the correct way
Make it so funs that are next to each other are together

*)

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
    
    fun checkField(field, nil, pos) = ( ErrorMsg.error pos 
        ("Field variable " ^ S.name field ^ " not found");
            raise TypeErrorException(pos))
      | checkField(field, (name, ty) :: fields, pos) =
      (case field = name 
        of true => ty
        | false => checkField(field, fields, pos))

    fun checkTypeWrapper(true, pos) = ()
        | checkTypeWrapper(false, pos) =
        ( ErrorMsg.error pos ("Types missmatched at line " ^ Int.toString(pos));
            raise TypeErrorException(pos))

    fun checkInt ({exp, ty= T.INT}) = true
      | checkInt ({exp, ty}) = false

    fun checkStr ({exp, ty= T.STRING}) = true
      | checkStr ({exp, ty}) = false     

    fun checkUnit ({exp, ty= T.UNIT}) = true     
      | checkUnit ({exp, ty}) = false  

    
    fun actual_ty (T.NAME(id, tyref)) = 
        (case !tyref 
            of SOME(ty) => actual_ty(ty)
            | NONE => raise TypeErrorException(0)) (*todo figure out if this is possible*)
      | actual_ty (ty) = ty  

     fun checkSame (ty1, ty2) =
          let fun
            chkSm (T.RECORD(fields1, unique1), T.RECORD(fields2, unique2)) =
                unique1 = unique2 
              | chkSm (T.NIL, T.NIL) = true
              | chkSm (T.INT, T.INT) = true
              | chkSm (T.STRING, T.STRING) = true
              | chkSm (T.ARRAY(ty1, unique1), T.ARRAY(ty2, unique2)) =
                    unique1 = unique2
              | chkSm (T.UNIT, T.UNIT) = true
              | chkSm (T.NAME(id1, tyref1), T.NAME(id2, tyref2)) = true
              | chkSm ( ty1, ty2) = false
          in
              chkSm(actual_ty(ty1), actual_ty(ty2))
          end

    fun checkArrayElement(T.ARRAY(aty, unique), {exp, ty}) = checkSame(aty, ty)
      | checkArrayElement(aty, {exp, ty}) = false
    fun transExp(venv, tenv, exp) =
        let fun 
            trexp (A.VarExp(var)) = trvar(var)
          | trexp (A.NilExp) = {exp=(),ty=T.NIL}
          | trexp (A.IntExp(num)) = {exp=(),ty=T.INT}
          | trexp (A.StringExp(str)) = {exp=(),ty=T.STRING}

          | trexp (A.CallExp{func, args, pos}) = 
            let 
                val (formals, result) = (case S.look(venv, func) 
                    of SOME(E.FunEntry{formals, result}) => (formals, result)
                     | SOME(E.VarEntry{...}) => (ErrorMsg.error pos ("variable name " ^ S.name func ^ " Called as function");
                                raise TypeErrorException(pos))
                     | NONE => (ErrorMsg.error pos ("function name not defined for " ^ S.name func);
                                raise TypeErrorException(pos)))
                fun checkArgs(nil, nil) = true
                  | checkArgs(fty :: formals, exp :: args) = 
                        checkSame(fty, #ty (trexp exp)) andalso 
                        checkArgs(formals, args)
                  | checkArgs(args, types) = false
            in 
                (checkTypeWrapper(checkArgs(formals, args), pos); {exp=(), ty=result})
            end
          
          | trexp (A.OpExp{left, oper= A.PlusOp, right, pos}) =
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

          | trexp (A.RecordExp{fields, typ, pos}) = 
          let 
            fun checkField(field, nil) = false
              | checkField((fid, exp, pos), (tfid, ty) :: tyfields) =
                fid = tfid orelse checkField((fid, exp, pos), tyfields)

            fun checkFields(nil, tyfields) = true
              | checkFields(field :: fields, tyfields) = 
                checkField(field, tyfields) andalso checkFields(fields, tyfields)  

            val rty = (case  S.look(tenv, typ)
                    of SOME(T.RECORD(tyfields, unique)) => 
                    (checkTypeWrapper(checkFields(fields, tyfields), pos);
                     T.RECORD(tyfields, unique))

                    | SOME(t) => (ErrorMsg.error pos (S.name typ ^ " is not a record type");
                                raise TypeErrorException(pos))
                    |  NONE => (ErrorMsg.error pos ("type name not found for variable " ^ S.name typ);
                                raise TypeErrorException(pos)))
          in 
           {exp=(), ty= rty}
          end

          | trexp (A.SeqExp(nil)) = {exp=(), ty= T.UNIT}
          | trexp (A.SeqExp((exp, pos) :: tail)) = (trexp(A.SeqExp(tail)); trexp(exp))
          | trexp (A.AssignExp{var, exp, pos}) = 
              ((*checkTypeWrapper(
                checkSame( lvalue type, trexp exp), pos);*)
              {exp=(), ty= T.UNIT})
          | trexp (A.IfExp{test, then', else'= SOME(exp), pos}) = 
                let 
                    val {ty = tty, ...} = trexp then'
                    val {ty = ety, ...} = trexp exp
                in
                    (checkTypeWrapper(checkInt(trexp test) andalso 
                     checkSame(tty, ety), pos);
                    {exp=(), ty=tty})
                end          
          | trexp (A.IfExp{test, then', else'= NONE, pos}) = (checkTypeWrapper( 
                checkInt(trexp test) andalso checkUnit(trexp then'), pos); 
                {exp=(), ty= T.UNIT})              
          | trexp (A.WhileExp{test, body, pos}) = 
              (checkTypeWrapper(
                (checkInt(trexp test) andalso 
                checkUnit(trexp body)), pos);
              {exp=(), ty= T.UNIT})
          | trexp (A.ForExp{var, escape, lo, hi, body, pos}) = (* Maybe need to typecheck car and escape too? *)
            let 
                val venv' = S.enter(venv, var, E.VarEntry{access=ref (), ty=T.INT})
            in 
              (checkTypeWrapper(
                (checkInt(transExp(venv', tenv, lo)) andalso 
                checkInt(transExp(venv', tenv, hi)) andalso
                checkUnit(transExp(venv', tenv, body))), pos);
              {exp=(), ty= T.UNIT})
            end
          | trexp (A.BreakExp(pos)) = {exp=(), ty= T.UNIT}
          | trexp (A.LetExp{decs, body, pos}) =
            let 
                fun addDecs(dec, {venv=venv', tenv=tenv'}) = transDec(venv', tenv', dec)
                val {venv=venv', tenv=tenv'} = foldl addDecs {venv=venv, tenv=tenv} decs
            in 
                transExp(venv', tenv', body)
            end
          | trexp (A.ArrayExp{typ, size, init, pos}) =
            let 
                val aty = (case  S.look(tenv, typ)
                    of SOME(t) => t
                    |  NONE => (ErrorMsg.error pos ("type name not found for variable " ^ S.name typ);
                                raise TypeErrorException(pos)))
                val sty = trexp(size)
                val ity = trexp(init)
            in
            (checkTypeWrapper(
                checkArrayElement(aty, ity) andalso
                checkInt(sty), pos); 

            {exp=(), ty= aty})
        end
       
       and trvar (A.SimpleVar(id, pos)) = 
            (case S.look(venv,id)
                of SOME(E.VarEntry{access,ty}) => 
                {exp=(), ty=actual_ty ty}
                | SOME(E.FunEntry{formals, result}) => ( ErrorMsg.error pos 
                    ("function name not found for variable " ^ S.name id);
                    raise TypeErrorException(pos))

                | NONE => ( ErrorMsg.error pos ("undefined variable " ^ S.name id);
                    raise TypeErrorException(pos)))

         | trvar (A.FieldVar(var, field, pos)) =  
            (case actual_ty (#ty (trvar(var)))
                of T.RECORD(fields, unique) => {exp=(), ty=checkField(field, fields, pos)}
                | ty => ( ErrorMsg.error pos ("expected variable not a record");
                    raise TypeErrorException(pos)))
         | trvar (A.SubscriptVar(var, exp, pos)) = 
            (case actual_ty (#ty (trvar(var)))
                of T.ARRAY(ty, unique) => (checkTypeWrapper(checkInt(trexp exp), pos);
                                           {exp=(), ty=ty})
                | ty => ( ErrorMsg.error pos ("expected variable not an array");
                          raise TypeErrorException(pos)))
        in 
            (trexp exp)
        end

    (* returns the new type created*)
    and transTy (tenv, ty) = 
    let  fun 
        trty (A.NameTy(id, pos)) = 
            (case  S.look(tenv, id)
                of SOME(t) => T.NAME(id, ref (SOME(t)))
                |  NONE => (ErrorMsg.error pos ("type name not found for variable " ^ S.name id);
                            raise TypeErrorException(pos)))
      | trty (A.RecordTy(fields)) = 
      let 
        fun transparam{name, typ, pos, escape} = 
            (case  S.look(tenv, typ)
            of SOME(t) => (name, t)
            |  NONE => (ErrorMsg.error pos ("type name not found for variable " ^ S.name typ);
                        raise TypeErrorException(pos)))

      in 
        T.RECORD(map transparam fields, ref ())
      end
      | trty (A.ArrayTy(id, pos)) = 
            (case  S.look(tenv, id)
                of SOME(t) => T.ARRAY(t, ref ())
                |  NONE => (ErrorMsg.error pos ("type name not found for variable " ^ S.name id);
                            raise TypeErrorException(pos)))

    in 
        (trty ty)
    end

    (* returns a record {venv, tenv} for the new enviornment*)
    and transDec(venv, tenv, dec) = 
    let fun
        trdec (A.FunctionDec(nil)) = {venv=venv, tenv=tenv}
      | trdec (A.FunctionDec({name, params, result, body, pos} :: fundecs)) = 
      let val result_ty = 
        (case result
            of NONE => T.UNIT 
            |  SOME(rt, tyPos) => 
                (case S.look(tenv, rt)
                                of SOME(result_ty) => result_ty
                                |  NONE => (ErrorMsg.error pos ("type name not found for variable " ^ S.name rt);
                            raise TypeErrorException(pos))))
          fun transparam{name, typ, pos, escape} = 
                        case  S.look(tenv, typ)
                        of SOME t => {name=name, ty=t}
                        |  NONE => (ErrorMsg.error pos ("type name not found for variable " ^ S.name typ);
                    raise TypeErrorException(pos))
          val params' = map transparam params
          val venv' = S.enter(venv, name, 
            E.FunEntry{formals=map #ty params', result = result_ty})
          fun  enterparam ({name, ty}, venv) = S.enter(venv, name, 
            E.VarEntry{access=ref (), ty=ty})
          val venv'' = foldl enterparam venv' params' 
          val bodyty = transExp(venv'', tenv, body);
      in 
        checkTypeWrapper(checkSame(#ty bodyty, result_ty), pos); 
        transDec(venv', tenv, A.FunctionDec(fundecs))
      end
          



      | trdec (A.VarDec{name, escape, typ, init, pos}) = 
        let val {exp, ty} = transExp(venv, tenv, init)
        in (case typ 
            of SOME(id, pos) => 
                (case S.look(tenv, id)
                 of NONE =>   (ErrorMsg.error pos ("type name not found for variable " ^ S.name id);
                    raise TypeErrorException(pos))
                 |  SOME(ety) => (checkTypeWrapper(checkSame(ty, ety), pos));
                {tenv=tenv, 
                 venv=S.enter(venv, name, E.VarEntry{access= ref (), ty=ty})})
            |  NONE => {tenv=tenv, 
            venv=S.enter(venv, name, E.VarEntry{access= ref (), ty=ty})})
        end
      | trdec (A.TypeDec(nil)) = {venv=venv, tenv=tenv}
      | trdec (A.TypeDec({name, ty, pos} :: rest)) = 
      {venv=venv, 
       tenv= #tenv (transDec(venv, 
                     S.enter(tenv, name, transTy(tenv, ty)), 
                     A.TypeDec(rest)))
      }
    in 
        (trdec dec)
    end     
    

    fun transProg(absyn) = (transExp(E.base_venv, E.base_tenv, absyn); ())
end
