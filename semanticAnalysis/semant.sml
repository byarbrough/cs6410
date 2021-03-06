(*
TODO:
*)

signature SEMANT = 
sig
    val transProg : Absyn.exp -> Translate.frag list
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
    exception TypeErrorException of int
    (* number of for/while loops currently nested in*)
    val looplevel = ref 0

    (*Check if during  record creation the 
      fields are initalized in the correct order*)
    fun checkField(field, nil, pos) = ( ErrorMsg.error pos 
        ("Field variable " ^ S.name field ^ " not found");
            raise TypeErrorException(pos))
      | checkField(field, (name, ty) :: fields, pos) =
      (case field = name 
        of true => ty
        | false => checkField(field, fields, pos))

    (*Wrapper for checking types that throws an error*)
    fun checkTypeWrapper(true, pos) = ()
        | checkTypeWrapper(false, pos) =
        ( ErrorMsg.error pos (
            "Types missmatched at line " ^ Int.toString(pos));
            raise TypeErrorException(pos))

    (*Check if a given exp is an Int type*)
    fun checkInt ({exp, ty= T.INT}) = true
      | checkInt ({exp, ty}) = false

    (*Check if a given exp is a String type*)
    fun checkStr ({exp, ty= T.STRING}) = true
      | checkStr ({exp, ty}) = false

    (*Check if a given exp is an Unit type*)
    fun checkUnit ({exp, ty= T.UNIT}) = true     
      | checkUnit ({exp, ty}) = false

    (*Check if given 2 arrays they are equal 
      types based on their unique references*)
    fun checkArrays({ty= T.ARRAY(ty1, unique1), 
                      exp=exp1}, 
                    {ty=T.ARRAY(ty2, unique2), 
                      exp=exp2}) = 
                      unique1 = unique2
      | checkArrays ({ty=ty1, ...}, {ty=ty2, ...}) = false  
  
    (*Check if a given exo is a Record or Nil*)
    fun checkRecord ({exp, ty= T.RECORD(l, unique)}) = true
      | checkRecord ({exp, ty= T.NIL})= true
      | checkRecord ({exp, ty}) = false  
    
    (*Check if a given expression is of break or unit type.*)
    fun checkBreak ({exp, ty= T.BREAK}) = true
      | checkBreak ({exp, ty = T.UNIT}) = true
      | checkBreak ({exp, ty}) = false
 
    (*Recures a type to its true type 
      value instead of named values*)
    fun actual_ty (T.NAME(id, tyref)) = 
        (case !tyref 
            of SOME(ty) => actual_ty(ty)
            | NONE => raise TypeErrorException(0))
      | actual_ty (ty) = ty  

    (*Checks if two given types are equivalent*)
    fun checkSame (ty1, ty2) =
      let fun
        chkSm (T.RECORD(fields1, unique1), 
               T.RECORD(fields2, unique2)) =
            unique1 = unique2
          | chkSm (T.RECORD(fields, unique), T.NIL) = true
          | chkSm (T.NIL, T.RECORD(fields, unique)) = true 
          | chkSm (T.NIL, T.NIL) = true
          | chkSm (T.INT, T.INT) = true
          | chkSm (T.STRING, T.STRING) = true
          | chkSm (T.ARRAY(ty1, unique1), 
                   T.ARRAY(ty2, unique2)) =
                    unique1 = unique2
          | chkSm (T.UNIT, T.UNIT) = true
          | chkSm (T.NAME(id1, tyref1), 
                   T.NAME(id2, tyref2)) = true
          | chkSm ( ty1, ty2) = false
      in
          chkSm(actual_ty(ty1), actual_ty(ty2))
      end

    (*Returns the type of a if statement 
      given the two types for then and else exps*)
    fun checkIf(T.BREAK, ty2, pos) = ty2
      |  checkIf(ty1, T.BREAK, pos) = ty1
      |  checkIf(ty1, ty2, pos) = 
          (checkTypeWrapper(checkSame(ty1, ty2), pos); ty1)

    (*Check if a given type is equal to 
      the type of the given array*)
    fun checkArrayElement(T.ARRAY(aty, unique), ty) = 
          checkSame(aty, ty)
      | checkArrayElement(aty, ty) = false
    
    (*Translate the given exp with the 
      given envionrments and level to *)
    fun transExp(venv, tenv, exp, level, breakpoint)
         : {exp:Tr.exp, ty: T.ty} =
      let fun 
          trexp (A.VarExp(var))
            = trvar(var)
        | trexp (A.NilExp) = 
            {exp=Tr.irNil(),ty=T.NIL}
        | trexp (A.IntExp(num)) = 
            {exp=Tr.irInt(num),ty=T.INT}
        | trexp (A.StringExp(str, pos)) = 
            {exp=Tr.irString(str),ty=T.STRING}
        | trexp (A.CallExp{func, args, pos}) = 
          let 
              val (flevel, label, formals, result) =
                (case S.look(venv, func) 
                  of SOME(E.FunEntry{ level, 
                                      label, 
                                      formals, 
                                      result}) =>
                      (level, label, formals, result)
                   | SOME(E.VarEntry{...}) =>
                      (ErrorMsg.error pos
                      ("variable name " ^ 
                        S.name func ^ 
                        " Called as function");
                              raise TypeErrorException(pos))
                   | NONE =>
                      (ErrorMsg.error pos
                      ("function name not defined for " ^ 
                        S.name func);
                              raise TypeErrorException(pos)))
              val args' = map trexp args
              fun checkArgs([], []) = true
                | checkArgs(fty :: formals, {exp, ty} :: args) = 
                      checkSame(fty, ty) andalso 
                      checkArgs(formals, args)
                | checkArgs(args, types) = false
          in 
              (checkTypeWrapper(checkArgs(formals, args'), pos); 
               {exp=Tr.irCallExp(label, flevel, map #exp args', level), 
                ty=result})
          end
        
        | trexp (A.OpExp{left, oper= A.PlusOp, right, pos}) =
            let 
              val leftExp = trexp left
              val rightExp = trexp right
            in
              (checkTypeWrapper(
                checkInt(leftExp) andalso 
                checkInt(rightExp), pos);
              {exp=Tr.irOpExp(leftExp, A.PlusOp, rightExp, pos),
               ty=T.INT})
            end
        
        | trexp (A.OpExp{left, oper= A.MinusOp, right, pos}) =
            let 
              val leftExp = trexp left
              val rightExp = trexp right
            in
              (checkTypeWrapper(
                checkInt(leftExp) andalso 
                checkInt(rightExp), pos);
              {exp=Tr.irOpExp(leftExp, A.MinusOp, rightExp, pos),
              ty=T.INT})
            end
        
        | trexp (A.OpExp{left, oper= A.TimesOp, right, pos}) =
            let 
              val leftExp = trexp left
              val rightExp = trexp right
            in
              (checkTypeWrapper(
                checkInt(leftExp) andalso 
                checkInt(rightExp), pos);
              {exp=Tr.irOpExp(leftExp, A.TimesOp, rightExp, pos),
              ty=T.INT})
            end
        
        | trexp (A.OpExp{left, oper= A.DivideOp, right, pos}) =
            let 
              val leftExp = trexp left
              val rightExp = trexp right
            in
              (checkTypeWrapper(
                checkInt(leftExp) andalso 
                checkInt(rightExp), pos);
              {exp=Tr.irOpExp(leftExp, A.DivideOp, rightExp, pos),
               ty=T.INT})
            end
        
        | trexp (A.OpExp{left, oper= A.LtOp, right, pos}) =
            let 
              val leftExp = trexp left
              val rightExp = trexp right
            in
              (checkTypeWrapper(
                (checkStr(leftExp) andalso 
                 checkStr(rightExp)) orelse
                (checkInt(leftExp) andalso
                 checkInt(rightExp)), pos);
              {exp=Tr.irOpExp(leftExp, A.LtOp, rightExp, pos),
               ty=T.INT})
            end
        
        | trexp (A.OpExp{left, oper= A.LeOp, right, pos}) =
            let 
              val leftExp = trexp left
              val rightExp = trexp right
            in
              (checkTypeWrapper(
                (checkStr(leftExp) andalso 
                 checkStr(rightExp)) orelse
                (checkInt(leftExp) andalso
                 checkInt(rightExp)), pos);
              {exp=Tr.irOpExp(leftExp, A.LeOp, rightExp, pos),
               ty=T.INT})
            end

        | trexp (A.OpExp{left, oper= A.GtOp, right, pos}) =
            let 
              val leftExp = trexp left
              val rightExp = trexp right
            in
              (checkTypeWrapper(
                (checkStr(leftExp) andalso 
                 checkStr(rightExp)) orelse
                (checkInt(leftExp) andalso
                 checkInt(rightExp)), pos);
              {exp=Tr.irOpExp(leftExp, A.GtOp, rightExp, pos),
               ty=T.INT})    
            end

        | trexp (A.OpExp{left, oper= A.GeOp, right, pos}) =
            let 
              val leftExp = trexp left
              val rightExp = trexp right
            in
              (checkTypeWrapper(
                (checkStr(leftExp) andalso 
                 checkStr(rightExp)) orelse
                (checkInt(leftExp) andalso
                 checkInt(rightExp)), pos);
              {exp=Tr.irOpExp(leftExp, A.GeOp, rightExp, pos),
               ty=T.INT})
            end
        
        | trexp (A.OpExp{left, oper= A.EqOp, right, pos}) =
            let 
              val leftExp = trexp left
              val rightExp = trexp right
            in
              (checkTypeWrapper(
                (checkRecord(leftExp) andalso
                 checkRecord(rightExp)) orelse
                checkArrays(leftExp, rightExp) orelse
                (checkStr(leftExp) andalso 
                 checkStr(rightExp)) orelse
                (checkInt(leftExp) andalso
                 checkInt(rightExp)), pos);
              {exp=Tr.irOpExp(leftExp, A.EqOp, rightExp, pos),
               ty=T.INT})
            end

        | trexp (A.OpExp{left, oper= A.NeqOp, right, pos}) =
            let 
              val leftExp = trexp left
              val rightExp = trexp right
            in
              (checkTypeWrapper(
                (checkRecord(leftExp) andalso
                 checkRecord(rightExp)) orelse
                checkArrays(leftExp, rightExp) orelse
                (checkStr(leftExp) andalso 
                 checkStr(rightExp)) orelse
                (checkInt(leftExp) andalso
                 checkInt(rightExp)), pos);
              {exp=Tr.irOpExp(leftExp, A.NeqOp, rightExp, pos),
               ty=T.INT})
            end

        | trexp (A.RecordExp{fields, typ, pos}) = 
        let
          val fields' = map trexp (map #2 fields)
          (*checks if each field is correctly ordered*)
          fun checkFieldsOrder([], []) = true
            | checkFieldsOrder((fid, exp, pos) :: fields, 
                               (tfid, ty) :: tyfields) =
              fid = tfid andalso 
              checkFieldsOrder(fields, tyfields)
            | checkFieldsOrder(fields, tyfields) = false  
          (*Check if each field type is correct*)
          fun checkFieldsTy([], []) = true
            | checkFieldsTy({exp, ty=fty} :: fields, 
                          (tfid, ty) :: tyfields) = 
                checkSame(fty, ty) andalso 
                checkFieldsTy(fields, tyfields)  

            | checkFieldsTy(fields, tyfields) = false  

          val rty = 
              (case  S.look(tenv, typ)
                 of SOME(t) => (case actual_ty(t) 
                    of T.RECORD(tyfields, unique) => 
                      (checkTypeWrapper(
                        checkFieldsOrder(fields, tyfields) andalso
                        checkFieldsTy(fields', tyfields), pos);
                       T.RECORD(tyfields, unique))
                    | t => (ErrorMsg.error pos 
                            (S.name typ ^ 
                             " of type " ^ 
                             T.toString(t) ^  
                             " is not a record type");
                            raise TypeErrorException(pos)))
                |  NONE => (ErrorMsg.error pos 
                            ("type name not found for variable " ^ 
                              S.name typ);
                            raise TypeErrorException(pos)))
        in 
         {exp=Tr.irRecordExp(map #exp fields'), ty= rty}
        end
        | trexp (A.SeqExp(nil)) = {exp=Tr.irSeqExp([]), ty= T.UNIT}
        | trexp (A.SeqExp(seq)) =
          let 
            fun combineSeq((ex, _), (exps, ty)) =
              let 
                val { exp, ty } = trexp ex
              in 
                (exp :: exps, ty) 
              end
            val (seq', ty) = foldr combineSeq ([], T.NIL) seq    
          in 
            {exp = Tr.irSeqExp(seq'), ty= ty}
          end
        | trexp (A.AssignExp{var, exp, pos}) = 
            let 
              val {exp=var', ty=vty} = (trvar var)
              val {exp=exp', ty=ety} = (trexp exp)
            in
              (checkTypeWrapper(
                checkSame( vty, ety), pos);
              {exp=Tr.irAssignExp(var', exp'), ty= T.UNIT}) 
            end
        | trexp (A.IfExp{test, then', else'= SOME(exp), pos}) = 
            let 
                val {exp= then'', ty = tty} = trexp then'
                val {exp=exp', ty = ety} = trexp exp
                val test' = trexp test
            in
              (checkTypeWrapper(checkInt(test'), pos); 
                {exp=Tr.irIfExp(#exp test', then'', SOME(exp'), pos), 
                 ty=checkIf(tty, ety, pos)})
            end          
        | trexp (A.IfExp{test, then', else'= NONE, pos}) = 
            let 
                  val then'' = trexp then'
                  val test' = trexp test
            in
              (checkTypeWrapper( 
                checkInt(test') andalso 
                checkBreak(then''), pos); 
               {exp= Tr.irIfExp(#exp test', 
                                #exp then'', 
                                NONE, pos), 
                ty= T.UNIT})  
            end            
        | trexp (A.WhileExp{test, body, pos}) =
            let 
              val break = Temp.newlabel()
              val test' = trexp test
              val body' = transExp(venv, tenv, body, 
                                   level,SOME(break))
            in
              (looplevel := !looplevel + 1;
               checkTypeWrapper(
                (checkInt(test') andalso 
                checkBreak(body')), pos);
               looplevel := !looplevel - 1;
               {exp=Tr.irWhileExp(#exp test', 
                                  #exp body', break), ty= T.UNIT})
            end
        | trexp (A.ForExp{var, escape, lo, hi, body, pos}) = 
            let 
              val venv' = 
                S.enter(venv, var, 
                        E.VarEntry{
                          access=(Tr.allocLocal(level) (!escape)),
                          ty=T.INT})
              val newBreak = Temp.newlabel()
              val break = SOME(newBreak)
              val lo' = transExp(venv', tenv, lo, level, break)
              val hi' = transExp(venv', tenv, hi, level, break)
              val body' = transExp(venv', tenv, body, level, break)
            in 
              (checkTypeWrapper(
                  checkInt(lo') andalso 
                  checkInt(hi') andalso
                 checkBreak(body'), pos);
              {exp=Tr.irForExp(#exp lo', 
                               #exp hi',
                               #exp body', newBreak), ty= T.UNIT})
            end
        | trexp (A.BreakExp(pos)) = 
            (case breakpoint 
              of SOME(break) =>
                  {exp=Tr.irBreakExp(break, pos), ty= T.BREAK}
               | NONE =>
                  (ErrorMsg.error pos 
                    ("break found outside of loop");
                  raise TypeErrorException(pos)))
        | trexp (A.LetExp{decs, body, pos}) =
            let 
                (* Combine Var and Fun Declerations together.*)
                fun combineDecs(nil) = nil
                  | combineDecs(dec :: nil) = (dec :: nil)
                  | combineDecs(A.FunctionDec(l1) :: 
                                A.FunctionDec(l2) :: rest) = 
                      combineDecs(A.FunctionDec(l1 @ l2) :: rest)
                  | combineDecs(A.TypeDec(l1) :: 
                                A.TypeDec(l2) :: rest) =
                      combineDecs(A.TypeDec(l1 @ l2) :: rest)
                  | combineDecs(first :: rest) = 
                      first :: combineDecs(rest)
                fun addDecs(dec, {venv=venv', tenv=tenv', exps}) = 
                      let
                        val {venv=venv'', 
                             tenv=tenv'',
                             exps=exps'} = 
                              transDec(venv', tenv', dec, level, breakpoint)
                      in 
                        {venv=venv'', 
                         tenv=tenv'', 
                         exps=exps' @ exps}
                      end

                val {venv=venv', tenv=tenv', exps} = 
                  foldl addDecs 
                        {venv=venv, tenv=tenv, exps=[]} 
                        (combineDecs(decs))
                val {exp, ty} =  transExp(venv', tenv', body, level, breakpoint)
            in 
               {exp=Tr.irLetExp(exps, exp), ty=ty}
            end
        | trexp (A.ArrayExp{typ, size, init, pos}) =
          let 
              val aty = (case  S.look(tenv, typ)
                  of SOME(t) => t
                  |  NONE => 
                    (ErrorMsg.error pos 
                      ("type name not found for variable " ^ 
                        S.name typ);
                              raise TypeErrorException(pos)))
              val sty = trexp(size)
              val ity = trexp(init)
          in
          (checkTypeWrapper(
              checkArrayElement(actual_ty(aty), 
                                actual_ty((#ty ity))) andalso
              checkInt(sty), pos); 
          {exp=Tr.irArrayExp(#exp sty, #exp ity), ty= aty})
      end
     (*Translate Vars*)
     and trvar (A.SimpleVar(id, pos)) = 
          (case S.look(venv,id)
              of SOME(E.VarEntry{access,ty}) => 
              {exp=Tr.simpleVar(access, level), 
               ty=actual_ty ty}
              | SOME(E.FunEntry{level, label, formals, result}) => 
                  (ErrorMsg.error pos 
                  ("function name not found for variable " ^ 
                
                    S.name id);
                  raise TypeErrorException(pos))

              | NONE => ( ErrorMsg.error pos 
                  ("undefined variable " ^ S.name id);
                  raise TypeErrorException(pos)))

       | trvar (A.FieldVar(var, field, pos)) =
          let
            fun findField(n, []) =
                  (ErrorMsg.error pos 
                    ("expected variable not a record");
                  raise TypeErrorException(pos))
              | findField(n, (curN, ty) :: fields) =
                  if n = curN
                  then 0
                  else 1 + findField(n, fields) 
            val var' = trvar var
          in
            (case actual_ty (#ty var')
              of T.RECORD(fields, unique) => 
                {exp=Tr.irFieldVar(#exp var', 
                                findField(field, fields)), 
                 ty=checkField(field, fields, pos)}
              | ty => ( ErrorMsg.error pos 
                  ("expected variable not a record");
                  raise TypeErrorException(pos)))
          end
       | trvar (A.SubscriptVar(var, exp, pos)) = 
          let
            val exp' = trexp exp
            val var' = trvar var
          in 
          (case actual_ty (#ty var')
              of T.ARRAY(ty, unique) => 
                (checkTypeWrapper(checkInt(exp'), pos);
                 {exp=Tr.irSubscriptVar(#exp var', #exp exp'), 
                  ty=ty})
              | ty => ( ErrorMsg.error pos 
                  ("expected variable not an array");
                  raise TypeErrorException(pos)))
          end 
      in 
          (trexp exp)
      end

    (* returns the new type created*)
    and transTy (tenv, ty) = 
      let fun 
          trty (A.NameTy(id, pos)) = 
            (case  S.look(tenv, id)
              of SOME(t) => T.NAME(id, ref (SOME(t)))
              |  NONE => 
                (ErrorMsg.error pos 
                  ("type name not found for variable " 
                    ^ S.name id);
                raise TypeErrorException(pos)))
        | trty (A.RecordTy(fields)) = 
            let 
              fun transparam{name, typ, pos, escape} = 
                (case  S.look(tenv, typ)
                  of SOME(t) => (name, t)
                  |  NONE => 
                    (ErrorMsg.error pos 
                      ("type name not found for variable " 
                        ^ S.name typ);
                    raise TypeErrorException(pos)))
            in 
              T.RECORD(map transparam fields, ref ())
            end
        | trty (A.ArrayTy(id, pos)) = 
            (case  S.look(tenv, id)
              of SOME(t) => T.ARRAY(t, ref ())
              |  NONE => 
                (ErrorMsg.error pos 
                  ("type name not found for variable " 
                  ^ S.name id);
                raise TypeErrorException(pos)))
      in 
          (trty ty)
      end

    (* returns a record {venv, tenv, exps} for the 
       new enviornment including the declerations in dec*)
    and transDec(venv, tenv, dec, level, breakpoint) = 
    let fun
      trdec (A.FunctionDec(fundecs)) = 
        let 
          (*Returns the name, type, and escape for 
            a given parameter*)
          fun transparam{name, typ, pos, escape} = 
            case  S.look(tenv, typ)
              of SOME t => {name=name, ty=t, escape=escape}
              |  NONE => 
                  (ErrorMsg.error pos 
                    ("type name not found for variable " 
                      ^ S.name typ);
                  raise TypeErrorException(pos))
          (*Given a function and enviornment adds 
            the given function to the env*)
          fun addNewF({name, params, result, body, pos}, env) = 
              let 
                  val params' = map transparam params
                  val result_ty = 
                    case result
                      of NONE => 
                      T.UNIT 
                      |  SOME(rt, tyPos) => 
                        case S.look(tenv, rt)
                          of SOME(result_ty) => result_ty
                          |  NONE =>
                            (ErrorMsg.error pos 
                              ("type name not found for variable " 
                                ^ S.name rt);
                             raise TypeErrorException(pos))
                  val label=Te.newlabel()
                  val formals=map #ty params'
                  val escapeFormals= map ! (map #escape params')
              in
              S.enter(env, name, E.FunEntry{
                level=Tr.newLevel({parent=(level), 
                                   name=label, 
                                   formals=escapeFormals}),
                  label=label, 
                  formals=formals, 
                  result=result_ty})
              end
          (*The variable env with all of the functions included*)
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
                      (ErrorMsg.error pos 
                        ("type name not found for variable "
                          ^ S.name rt);
                      raise TypeErrorException(pos))               
              val params' = map transparam params
              (* Put all params into variable enviornment *)
              fun  enterparam ({name, ty, escape}, venv) = 
                S.enter(venv, name, 
                  E.VarEntry{
                    access=(Tr.allocLocal(level) (!escape)), 
                    ty=ty})
              (*The variable env with all of 
                the functions and function parameters from this 
                function included*)
              val venv'' = foldl enterparam venv' params' 
              val {exp=body', ty=bodyTy} = 
                    transExp(venv'', tenv, body, level, breakpoint);
              in 
                  (checkTypeWrapper(
                    checkSame(bodyTy, result_ty), pos);
                    Tr.irFunDec(level, body'))

              end) fundecs;
          {venv=venv', tenv= tenv, exps=[]})
          
        in  
          {venv= venv', tenv=tenv, exps= []}
        end

      | trdec (A.VarDec{name, escape, typ, init, pos}) = 
        let 
          val {exp, ty} = transExp(venv, tenv, init, 
                                   level, breakpoint)
          val acc = 
            (case typ 
              of SOME(id, pos) => 
                (case S.look(tenv, id)
                 of NONE => 
                  (ErrorMsg.error pos 
                    ("type name not found for variable " 
                      ^ S.name id);
                   raise TypeErrorException(pos))
                 |  SOME(ety) =>
                  (checkTypeWrapper(checkSame(ty, ety), pos));
                   Tr.allocLocal(level) (!escape))
              | NONE => 
                (case (actual_ty(ty)) 
                  of T.NIL =>
                    (ErrorMsg.error pos 
                      ("Nil variable decleration" ^  
                       "must have type for var " ^ S.name name);
                        raise TypeErrorException(pos))
                  | ty  =>  Tr.allocLocal(level) (!escape)))
        in 
          {venv = S.enter(venv, name,
                    E.VarEntry{access=acc, ty=ty}),
           tenv = tenv,
           exps = [Tr.irAssignExp( 
                    (Tr.simpleVar(acc, level)), exp)]
          }
        end

      | trdec (A.TypeDec(typeDecs)) = 
        let
          (*Adds the given type to the given enviornment*)
          fun addNewT({name, ty, pos}, env) = 
              S.enter(env, name, 
                      T.NAME(name, ref (S.look(env, name))))
          (*Type enviornment with all of the types included*)
          val tenv' = foldl addNewT tenv typeDecs
          
          (*Check if the given typeref is in the given list*)
          fun inList(tref, nil) = false
            | inList(tref, first :: rest) = 
              tref = first orelse inList(tref, rest)
          (*Checks if the given typeref is 
            cyclical type by checking if it resolves to 
            a type that isnt a NAME type.*)
          fun isCycle(trefs, (T.NAME(id, tyr), pos)) =
              (case inList(tyr, trefs) of 
                true => (ErrorMsg.error pos 
                  ("type cycle found for type " ^ S.name id);
                  raise TypeErrorException(pos))
              | false => case !tyr of 
                          NONE =>
                            (ErrorMsg.error pos (
                              "compiler error unset type for " ^ 
                              S.name id);
                            raise TypeErrorException(pos))
                        | SOME(t) => isCycle(tyr :: trefs, 
                                             (t, pos)))

            | isCycle(trefs, (ty, pos)) = ()

          (*Checks if there are any type 
            cycles in the given type enviornment*)
          fun checkTyCycles(env) =
            app (fn ({name, ty, pos}) => 
              (case S.look(env, name) of
                SOME(t) => isCycle(nil, (t, pos))
                | NONE =>
                  (ErrorMsg.error pos 
                    ("type name not found in env " ^ 
                     S.name name);
                  raise TypeErrorException(pos)))) typeDecs
        in 
          (app (fn ({name, ty, pos}) => 
              let 
                  val newty = transTy(tenv', ty) 
                  val (SOME (T.NAME(name,tyr))) = 
                      S.look(tenv',name)
              in tyr := SOME newty
              end) 
           typeDecs;
           checkTyCycles(tenv');
          {venv=venv, tenv= tenv', exps=[]})
        end
    in 
      (trdec dec)
    end     
    (*Translates the given expression to _____*)
    fun transProg(absyn) = 
      let 
        val level = Tr.newLevel(
                      {parent=Tr.outermost, 
                       name=Temp.newlabel(), 
                       formals=[]})
        val {exp, ty} = transExp(E.base_venv, 
                                E.base_tenv, absyn, 
                                level, NONE); 
      in 
        (Tr.procEntryExit(level, exp); Tr.getResult())
      end
end