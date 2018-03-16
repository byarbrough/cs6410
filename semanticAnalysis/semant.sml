(*
TODO:
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
    structure Te = Temp
    structure S = Symbol
    structure F = MipsFrame
    (* Tracks the current level of the function *)
    val curLevel = ref Tr.outermost
    exception TypeErrorException of int
    val looplevel = ref 0
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

   fun checkArrays ({ty= T.ARRAY(ty1, unique1), exp=exp1}, 
                    {ty=T.ARRAY(ty2, unique2), exp=exp2}) = unique1 = unique2
      | checkArrays ({ty=ty1, ...}, {ty=ty2, ...}) = false  
  

   fun checkRecord ({exp, ty= T.RECORD(l, unique)}) = true
      | checkRecord ({exp, ty= T.NIL})= true
      | checkRecord ({exp, ty}) = false  
  
    fun checkBreak ({exp, ty= T.BREAK}) = true
     | checkBreak ({exp, ty = T.UNIT}) = true
     | checkBreak ({exp, ty}) = false
 
    fun actual_ty (T.NAME(id, tyref)) = 
        (case !tyref 
            of SOME(ty) => actual_ty(ty)
            | NONE => raise TypeErrorException(0)) (*todo figure out if this is possible*)
      | actual_ty (ty) = ty  

     fun checkSame (ty1, ty2) =
          let fun
            chkSm (T.RECORD(fields1, unique1), T.RECORD(fields2, unique2)) =
                unique1 = unique2
              | chkSm (T.RECORD(fields, unique), T.NIL) = true
              | chkSm (T.NIL, T.RECORD(fields, unique)) = true 
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
    fun checkIf(T.BREAK, ty2, pos) = ty2
     |  checkIf(ty1, T.BREAK, pos) = ty1
     |  checkIf(ty1, ty2, pos) = (checkTypeWrapper(checkSame(ty1, ty2), pos); ty1)



    fun checkArrayElement(T.ARRAY(aty, unique), ty) = checkSame(aty, ty)
      | checkArrayElement(aty, ty) = false
    fun transExp(venv, tenv, exp) =
        let fun 
            trexp (A.VarExp(var)) = trvar(var)
          | trexp (A.NilExp) = {exp=(),ty=T.NIL}
          | trexp (A.IntExp(num)) = {exp=(),ty=T.INT}
          | trexp (A.StringExp(str)) = {exp=(),ty=T.STRING}

          | trexp (A.CallExp{func, args, pos}) = 
            let 
                val (formals, result) =
                  (case S.look(venv, func) 
                    of SOME(E.FunEntry{ level, label, formals, result}) =>
                        (formals, result)
                     | SOME(E.VarEntry{...}) =>
                        (ErrorMsg.error pos
                        ("variable name " ^ S.name func ^ " Called as function");
                                raise TypeErrorException(pos))
                     | NONE =>
                        (ErrorMsg.error pos
                        ("function name not defined for " ^ S.name func);
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
                        (checkRecord(trexp left) andalso
                          checkRecord(trexp right)) orelse
                         checkArrays(trexp left, trexp right) orelse
                        (checkStr(trexp left) andalso 
                         checkStr(trexp right)) orelse
                        (checkInt(trexp left) andalso
                         checkInt(trexp right)), pos);
                      {exp=(),ty= T.INT})
          | trexp (A.OpExp{left, oper= A.NeqOp, right, pos}) =
                      (checkTypeWrapper(
                        (checkRecord(trexp left) andalso
                          checkRecord(trexp right)) orelse
                         checkArrays(trexp left, trexp right) orelse
                        (checkStr(trexp left) andalso 
                         checkStr(trexp right)) orelse
                        (checkInt(trexp left) andalso
                         checkInt(trexp right)), pos);
                      {exp=(),ty= T.INT}) 

          | trexp (A.RecordExp{fields, typ, pos}) = 
          let 
            fun checkFields(nil, nil) = true
              | checkFields((fid, exp, pos) :: fields, (tfid, ty) :: tyfields) = 
                fid = tfid andalso 

                checkSame(#ty (trexp exp), ty) andalso 
                checkFields(fields, tyfields)  
              | checkFields(fields, tyfields) = false   
            val rty = (case  S.look(tenv, typ)

                     of SOME(t) => (case actual_ty(t) 
                        of T.RECORD(tyfields, unique) => 
                            (checkTypeWrapper(checkFields(fields, tyfields), pos);
                            T.RECORD(tyfields, unique))
                        | t => (ErrorMsg.error pos (S.name typ ^ " of type " 
                                    ^ T.toString(t) ^  " is not a record type");
                                raise TypeErrorException(pos)))
                    |  NONE => (ErrorMsg.error pos ("type name not found for variable " ^ S.name typ);
                                raise TypeErrorException(pos)))
          in 
           {exp=(), ty= rty}
          end

          | trexp (A.SeqExp(nil)) = {exp=(), ty= T.UNIT} (*FIX THIS*)
          | trexp (A.SeqExp((exp, pos) :: tail)) = (trexp(A.SeqExp(tail)); trexp(exp))
          | trexp (A.AssignExp{var, exp, pos}) = 
              (checkTypeWrapper(
                checkSame( #ty (trvar var), #ty (trexp exp)), pos);
              {exp=(), ty= T.UNIT})
          | trexp (A.IfExp{test, then', else'= SOME(exp), pos}) = 
                let 
                    val {ty = tty, ...} = trexp then'
                    val {ty = ety, ...} = trexp exp
                in
                  (checkTypeWrapper(checkInt(trexp test), pos); 
                    {exp=(), ty=checkIf(tty, ety, pos)})
                end          
          | trexp (A.IfExp{test, then', else'= NONE, pos}) = (checkTypeWrapper( 
                checkInt(trexp test) andalso checkBreak(trexp then'), pos); 
                {exp=(), ty= T.UNIT})              
          | trexp (A.WhileExp{test, body, pos}) = (looplevel := !looplevel + 1;
              checkTypeWrapper(
                (checkInt(trexp test) andalso 
                checkBreak(trexp body)), pos);
              looplevel := !looplevel - 1;

              {exp=(), ty= T.UNIT})
          (* Maybe need to typecheck car and escape too? *)
          | trexp (A.ForExp{var, escape, lo, hi, body, pos}) = 
            let 
                val venv' = 
                  S.enter(venv, var, E.VarEntry{access=(Tr.allocLocal(!curLevel) (!escape)),
                         ty=T.INT})
            in 
              (looplevel := !looplevel + 1;
                checkTypeWrapper(checkInt(transExp(venv', tenv, lo)) andalso 
                 checkInt(transExp(venv', tenv, hi)) andalso
                 checkBreak(transExp(venv', tenv, body)), pos);
              looplevel := !looplevel - 1;
              {exp=(), ty= T.UNIT})
            end
          | trexp (A.BreakExp(pos)) = (case !looplevel of
            0 => (ErrorMsg.error pos ("break found outside of loop");
                                raise TypeErrorException(pos))
            | num => {exp=(), ty= T.BREAK})
          | trexp (A.LetExp{decs, body, pos}) =
            let 
                fun combineDecs(nil) = nil
                  | combineDecs(dec :: nil) = (dec :: nil)
                  | combineDecs(A.FunctionDec(l1) :: A.FunctionDec(l2) :: rest) 
                    = combineDecs(A.FunctionDec(l1 @ l2) :: rest)
                  | combineDecs(A.TypeDec(l1) :: A.TypeDec(l2) :: rest) 
                    = combineDecs(A.TypeDec(l1 @ l2) :: rest)
                  | combineDecs(first :: rest) = first :: combineDecs(rest)
                fun addDecs(dec, {venv=venv', tenv=tenv'}) = transDec(venv', tenv', dec)
                val {venv=venv', tenv=tenv'} = 
                  foldl addDecs {venv=venv, tenv=tenv} (combineDecs(decs))
            in 
                transExp(venv', tenv', body)
            end
          | trexp (A.ArrayExp{typ, size, init, pos}) =
            let 
                val aty = (case  S.look(tenv, typ)
                    of SOME(t) => t
                    |  NONE => 
                      (ErrorMsg.error pos ("type name not found for variable " ^ S.name typ);
                                raise TypeErrorException(pos)))
                val sty = trexp(size)
                val ity = trexp(init)
            in
            (checkTypeWrapper(
                checkArrayElement(actual_ty(aty), actual_ty((#ty ity))) andalso
                checkInt(sty), pos); 

            {exp=(), ty= aty})
        end
       
       and trvar (A.SimpleVar(id, pos)) = 
            (case S.look(venv,id)
                of SOME(E.VarEntry{access,ty}) => 
                {exp=(), ty=actual_ty ty}
                | SOME(E.FunEntry{level, label, formals, result}) => ( ErrorMsg.error pos 
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
                |  NONE => 
                  (ErrorMsg.error pos ("type name not found for variable " ^ S.name id);
                            raise TypeErrorException(pos)))
      | trty (A.RecordTy(fields)) = 
      let 
        fun transparam{name, typ, pos, escape} = 
            (case  S.look(tenv, typ)
            of SOME(t) => (name, t)
            |  NONE => 
              (ErrorMsg.error pos ("type name not found for variable " ^ S.name typ);
                        raise TypeErrorException(pos)))

      in 
        T.RECORD(map transparam fields, ref ())
      end
      | trty (A.ArrayTy(id, pos)) = 
            (case  S.look(tenv, id)
                of SOME(t) => T.ARRAY(t, ref ())
                |  NONE => 
                  (ErrorMsg.error pos ("type name not found for variable " ^ S.name id);
                            raise TypeErrorException(pos)))

    in 
        (trty ty)
    end

    (* returns a record {venv, tenv} for the new enviornment*)
    and transDec(venv, tenv, dec) = 
    let fun
     trdec (A.FunctionDec(fundecs)) = 
        (*{name, params, result, body, pos}*)

      let 
        fun transparam{name, typ, pos, escape} = 
                        case  S.look(tenv, typ)
                        of SOME t => {name=name, ty=t, escape=escape}
                        |  NONE => 
                          (ErrorMsg.error pos ("type name not found for variable " ^ S.name typ);
                    raise TypeErrorException(pos))
        fun addNewF({name, params, result, body, pos}, env) = 
            let 
                val params' = map transparam params
                val result_ty = 
                    case result
                        of NONE => T.UNIT 
                        |  SOME(rt, tyPos) => 
                            case S.look(tenv, rt)
                                of SOME(result_ty) => result_ty
                                |  NONE =>
                                  (ErrorMsg.error pos ("type name not found for variable "
                                          ^ S.name rt);
                            raise TypeErrorException(pos))
                val label=Te.namelabel(S.name(name))
                val formals=map #ty params'
                val escapeFormals= map ! (map #escape params')
            in
            S.enter(env, name, E.FunEntry{
              level=Tr.newLevel({parent=(!curLevel), name=label, formals=escapeFormals}),
                label=label, formals=formals, result = result_ty})
            end
        val venv' = foldl addNewF venv fundecs
        val _ = (app (fn ({name, params, result, body, pos}) => 
            let 
                val result_ty = 
                    case result
                        of NONE => T.UNIT 
                        |  SOME(rt, tyPos) => 
                            case S.look(tenv, rt)
                                of SOME(result_ty) => result_ty
                                |  NONE =>
                                (ErrorMsg.error pos ("type name not found for variable "
                                       ^ S.name rt);
                            raise TypeErrorException(pos))               
                val params' = map transparam params
                (* Put all params into variable enviornment *)
                fun  enterparam ({name, ty, escape}, venv) = S.enter(venv, name, 
                    E.VarEntry{access=(Tr.allocLocal(!curLevel) (!escape)), ty=ty})
                val venv'' = foldl enterparam venv' params' 
                val bodyty = transExp(venv'', tenv, body);
                in 
                    checkTypeWrapper(checkSame(#ty bodyty, result_ty), pos)
                end) fundecs;
            {venv=venv', tenv= tenv})
          
      in  
        {venv= venv', tenv=tenv}
      end
          



      | trdec (A.VarDec{name, escape, typ, init, pos}) = 
        let val {exp, ty} = transExp(venv, tenv, init)
        in (case typ 
            of SOME(id, pos) => 
                (case S.look(tenv, id)
                 of NONE => 
                  (ErrorMsg.error pos ("type name not found for variable " ^ S.name id);
                    raise TypeErrorException(pos))
                 |  SOME(ety) =>
                  (checkTypeWrapper(checkSame(ty, ety), pos));
                {tenv=tenv, 
                 venv=S.enter(venv, name,
                  E.VarEntry{access=(Tr.allocLocal(!curLevel) (!escape)), ty=ty})})
            |  NONE => (case (actual_ty(ty)) of
                        T.NIL =>
                          (ErrorMsg.error pos (
                              "Nil variable decleration must have type for var " ^ S.name name);
                              raise TypeErrorException(pos))
                      | ty  =>  {tenv=tenv, 
            venv=S.enter(venv, name, E.VarEntry{access=(Tr.allocLocal(!curLevel) (!escape)), ty=ty})}))
        end

      | trdec (A.TypeDec(typeDecs)) = 

        let
            fun addNewT({name, ty, pos}, env) = 
                S.enter(env, name, T.NAME(name, ref (S.look(env, name))))
            val tenv' = foldl addNewT tenv typeDecs
            
            fun inList(tref, nil) = false
              | inList(tref, first :: rest) = 
                tref = first orelse inList(tref, rest)
            
            fun isCycle(trefs, (T.NAME(id, tyr), pos)) =
                (case inList(tyr, trefs) of 
                  true => (ErrorMsg.error pos ("type cycle found for type " ^ S.name id);
                    raise TypeErrorException(pos))
                | false => case !tyr of 
                            NONE =>
                              (ErrorMsg.error pos (
                                "compiler error unset type for " ^ S.name id);
                              raise TypeErrorException(pos))
                          | SOME(t) => isCycle(tyr :: trefs, (t, pos)))

              | isCycle(trefs, (ty, pos)) = ()

            fun checkTyCycles(env) =
              app (fn ({name, ty, pos}) => 
                (case S.look(env, name) of
                  SOME(t) => isCycle(nil, (t, pos))
                  | NONE =>
                    (ErrorMsg.error pos ("type name not found in env " ^ S.name name);
                    raise TypeErrorException(pos)))) typeDecs
        in 
            (app (fn ({name, ty, pos}) => 
                let 
                    val newty = transTy(tenv', ty) 
                    val (SOME (T.NAME(name,tyr))) = S.look(tenv',name)
                in tyr := SOME newty
                end) 
             typeDecs;
             checkTyCycles(tenv');
            {venv=venv, tenv= tenv'})
        end
    in 
        (trdec dec)
    end     
    

    fun transProg(absyn) = (transExp(E.base_venv, E.base_tenv, absyn); ())
end