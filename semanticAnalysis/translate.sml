signature TRANSLATE = 
sig
	type level
	type access
  type frag
  type exp
	val outermost : level
	val newLevel : {parent: level, 
					name: Temp.label, 
					formals: bool list} -> level
	val formals : level -> access list
	val allocLocal : level -> bool -> access
  val unEx : exp -> Tree.exp
  val unNx : exp -> Tree.stm
  val unCx : exp -> (Temp.label * Temp.label -> Tree.stm)
  val procEntryExit : level *  exp -> unit
  val getResult : unit -> frag list

  (*Conversion functions below*)
  (* transExp *)
  val irNil : unit -> exp
  val irInt : int -> exp
  val irString : string -> exp
  val irCallExp : unit -> exp (*STUBBED*)
  val irOpExp : {exp: exp, ty : Types.ty} * 
                 Absyn.oper *
                 {exp: exp, ty : Types.ty} *
                 Absyn.pos -> exp
  
  val irRecordExp : unit -> exp (*STUBBED*)
  val irSeqExp : exp list -> exp
  val irAssignExp : exp * exp -> exp
  
  val irIfExp : exp * exp * exp option * int -> exp
  val irWhileExp : exp * exp * Temp.label -> exp

  val irForExp : exp * exp * exp * Temp.label -> exp
  val irBreakExp : unit -> exp (*STUBBED*)
  
  val irLetExp : exp list * exp -> exp

  val irFunDec : level * exp -> unit
  
  val irArrayExp : exp * exp * Absyn.pos -> exp
  
  (* trvar *)
  val irFieldVar : exp * int -> exp
  val irSubscriptVar : exp * exp -> exp
  val simpleVar : access * level -> exp

end

structure Translate : TRANSLATE = struct 
  structure F = MipsFrame
  structure T = Temp
  structure Tr = Tree
  structure A = Absyn
  datatype level = TopLevel 
  			 | Level of {parent: level, 
                     frame: F.frame, 
                     uni: unit ref}
  datatype exp = 
      Ex of Tr.exp 
    | Nx of Tr.stm
    | Cx of T.label * T.label -> Tr.stm
  type access = level * F.access
  type frag = F.frag
  (*The outermost level*)
  val outermost = TopLevel

  val fragList : frag list ref= ref []

  (* returns a new level from the give name, 
     parent level and formals and gives the static 
     link to formals*)
  fun newLevel({parent, name, formals}) = 
  		Level({ parent= parent,
		          frame = F.newFrame({name= name, 
                                  formals= true :: formals}), 
		          uni = ref ()})
  (*Return the access list of formals for 
    the given level without the static link*)
  fun formals(TopLevel) = []
    | formals(Level(level)) = 
        tl (map (fn(formal) => (Level(level), formal)) 
            (F.formals(#frame level)))
 
  (*Return a function that will return an 
    allocated variable given a boolean.*)
  fun allocLocal(TopLevel) = 
  		ErrorMsg.impossible 
        "allocLocal should not be given outermost level"
  	| allocLocal(Level level) = 
        fn(b) => (Level(level), (F.allocLocal(#frame level) b))

  fun seq([]) = ErrorMsg.impossible 
                  "seq should not be given an empty list"
    | seq(last :: []) = last
    | seq(first :: rest) = Tr.SEQ(first, seq(rest))


  fun unEx(Ex e) : Tr.exp = e
    | unEx(Cx genstm) =
        let 
          val r = T.newtemp()
          val t = T.newlabel() and f = T.newlabel()
        in 
          Tr.ESEQ(seq[Tr.MOVE(Tr.TEMP r, Tr.CONST 1),
                      genstm(t,f), 
                      Tr.LABEL f,
                      Tr.MOVE(Tr.TEMP r, Tr.CONST 0),
                      Tr.LABEL t], 
                  Tr.TEMP r)
        end
    | unEx(Nx s) = Tr.ESEQ(s, Tr.CONST 0)

  fun unNx(Nx n) : Tr.stm = n
    | unNx(Ex e) = Tr.EXP(e)
        
    | unNx(Cx genstm) =
        let 
          val t = T.newlabel() and f = T.newlabel()
        in 
          Tr.SEQ(
            seq[genstm(t, f),
                Tr.LABEL t],
                Tr.LABEL f)
        end

  fun unCx(Cx c) : T.label * T.label -> Tr.stm = c
    | unCx(Ex e) = (fn(t, f) => 
                      Tr.CJUMP(Tr.NE, e, Tr.CONST 0, t, f))        
    | unCx(Nx n) = ErrorMsg.impossible 
                    "Nx should not ever be converted to Cx"

  fun procEntryExit(Level({parent, frame, uni}), exp)  = 
      (fragList := 
        F.PROC({body= unNx(exp), frame= frame}) :: !fragList;
        ())
    | procEntryExit(TopLevel, _) =
        ErrorMsg.impossible 
          "ProcEntryExit should not be called with TopLevel"

  fun getResult() = !fragList

  (*Translate semant to IR tree language*)
  (* transExp *)
  fun irNil() = Ex(Tr.CONST 0)
  fun irInt(num) = Ex(Tr.CONST(num))
  fun irString(str) =
  let
     val lab = T.newlabel()
   in
      F.STRING(lab, str) :: !fragList;
      Ex(Tr.NAME(lab))
   end 

  fun irCallExp{func, args, pos} = ()

  
  fun arith(trOp : Tr.binop, l, r) =
        Ex(Tr.BINOP(trOp, unEx(l), unEx(r)))
  fun comp(trComp : Tr.relop, l, r) = 
     Cx(fn(t : T.label, f : T.label) => 
          Tr.CJUMP(Tr.LT, unEx(l), unEx(r), t, f))

  fun compStr(oper, ex) =
    Cx(fn(t,f) => Tr.CJUMP(oper, unEx(ex), Tr.CONST(0), t, f))

  fun irOpExp({exp=l, ty=_}, A.PlusOp, 
              {exp=r, ty=_}, pos) = 
        arith(Tr.PLUS, l, r)
    
    | irOpExp({exp=l, ty=_}, A.MinusOp, 
              {exp=r, ty=_}, pos) =
        arith(Tr.MINUS, l, r)
    
    | irOpExp({exp=l, ty=_}, A.TimesOp, 
              {exp=r, ty=_}, pos) =
        arith(Tr.MUL, l, r)
    | irOpExp({exp=l, ty=_}, A.DivideOp, 
              {exp=r, ty=_}, pos) =
        arith(Tr.DIV, l, r)           
    | irOpExp({exp=l, ty=Types.STRING}, A.LtOp, 
              {exp=r, ty=ty2}, pos) = 
        compStr(Tr.LT,
          Ex(F.externalCall("stringCompare", [unEx(l), unEx(r)])))
    | irOpExp({exp=l, ty=ty1}, A.LtOp, 
              {exp=r, ty=ty2}, pos) = 
        comp(Tr.LT, l, r)
    | irOpExp({exp=l, ty=Types.STRING}, A.LeOp, 
              {exp=r, ty=ty2}, pos) = 
        compStr(Tr.LE,
          Ex(F.externalCall("stringCompare", [unEx(l), unEx(r)])))   
    | irOpExp({exp=l, ty=_}, A.LeOp, 
              {exp=r, ty=_}, pos) =
        comp(Tr.LE, l, r)
    | irOpExp({exp=l, ty=Types.STRING}, A.GtOp, 
              {exp=r, ty=ty2}, pos) = 
        compStr(Tr.GT,
          Ex(F.externalCall("stringCompare", [unEx(l), unEx(r)])))   
    | irOpExp({exp=l, ty=_}, A.GtOp, 
              {exp=r, ty=_}, pos) =
         comp(Tr.GT, l, r)
    | irOpExp({exp=l, ty=Types.STRING}, A.GeOp, 
              {exp=r, ty=ty2}, pos) = 
        compStr(Tr.GE,
          Ex(F.externalCall("stringCompare", [unEx(l), unEx(r)])))   
    | irOpExp({exp=l, ty=_}, A.GeOp, 
              {exp=r, ty=_}, pos) =
         comp(Tr.GE, l, r)
    | irOpExp({exp=l, ty=Types.STRING}, A.EqOp, 
              {exp=r, ty=ty2}, pos) = 
        compStr(Tr.NE,
          Ex(F.externalCall("stringCompare", [unEx(l), unEx(r)])))             
    | irOpExp({exp=l, ty=_}, A.EqOp, 
              {exp=r, ty=_}, pos) =
         comp(Tr.EQ, l, r)
    | irOpExp({exp=l, ty=Types.STRING}, A.NeqOp, 
              {exp=r, ty=ty2}, pos) = 
        compStr(Tr.EQ,
          Ex(F.externalCall("stringCompare", [unEx(l), unEx(r)])))   
    | irOpExp({exp=l, ty=_}, A.NeqOp, 
              {exp=r, ty=_}, pos) =
         comp(Tr.NE, l, r)               

  fun irSeqExp([]) =  Ex(Tr.CONST 0)
    | irSeqExp(exp :: []) = exp
    | irSeqExp(exp :: seq) =
        Ex(Tr.ESEQ(unNx exp, unEx(irSeqExp seq)))

  fun irAssignExp(var, exp) = 
    Nx(Tr.MOVE(unEx(var), unEx(exp)))

  fun irIfExp(test, thn, SOME(els), pos) =
    let
      val r = T.newtemp();
      val t = T.newlabel();
      val f = T.newlabel();
      val join = T.newlabel();
      val e1: T.label * T.label -> Tr.stm  = unCx(test);
      val e2: Tr.exp = unEx(thn);
      val e3: Tr.exp = unEx(els)
    in
      Ex(unEx(Nx(seq([e1(t, f), Tr.LABEL(t), Tr.MOVE(Tr.TEMP(r), e2),
        Tr.JUMP(Tr.NAME join, [join]), Tr.LABEL(f), Tr.MOVE(Tr.TEMP(r), e3),
        Tr.LABEL(join)]))))
    end
    | irIfExp(test, thn, NONE, pos) =
    let
      val r = T.newtemp();
      val t = T.newlabel();
      val f = T.newlabel();
      val e1: T.label * T.label -> Tr.stm  = unCx(test);
      val e2: Tr.exp = unEx(thn);
    in
      Ex(unEx(Nx(seq([e1(t, f), Tr.LABEL(t), Tr.MOVE(Tr.TEMP(r), e2),
        Tr.LABEL(f)]))))
    end

  fun irWhileExp(test, body, done) =
    let
      val t = T.newlabel();
      val s = T.newlabel();
      val d = T.newlabel(); (* this needs to be the same as the done that is passed in *)
      val r = T.newtemp();
      val e1: T.label * T.label -> Tr.stm = unCx(test);
      val e2: Tr.exp = unEx(body)
    in
      Ex(unEx(Nx(seq([Tr.JUMP(Tr.NAME(t), [t]), Tr.LABEL(s), Tr.MOVE(Tr.TEMP(r), e2),
        Tr.LABEL(t), e1(s, d), Tr.LABEL(d)]))))
    end


  fun irForExp(lo, hi, body, d) =
    let
      (* need to sub in var so it can be used? *)
      val i = T.newtemp();
      val h = T.newtemp();
      val r = T.newtemp();
      val t = T.newlabel();
      val b = T.newlabel();
      (*val d = T.newlabel(); im guessing this is where breaks should go*) 
      val bod: Tr.exp = unEx(body)

    in
      Ex(unEx(Nx(seq([Tr.MOVE(Tr.TEMP(i), unEx(lo)), Tr.MOVE(Tr.TEMP(h), unEx(hi)), Tr.LABEL(t),
        Tr.CJUMP(Tr.LT, Tr.TEMP(i), Tr.TEMP(h), b, d),
        Tr.MOVE(Tr.TEMP(r), bod), Tr.JUMP(Tr.NAME(t), [t]), Tr.LABEL(d)]))))
    end

  fun irBreakExp(pos) = ()

  fun irLetExp{decs, body, pos} = ()

  fun irArrayExp(size, init, pos) =
      Ex(F.externalCall("initArray",[unEx(size), unEx(init)]))

  (* trvar *)
  
  (*Helper for simpleVar, used to follow static links to find
    the location of a given access at a given level*)
  fun irSimpleVar((TopLevel, _), _ ) = 
        ErrorMsg.impossible 
          "simpleVar should not look into topLevel"
    | irSimpleVar(_ , TopLevel) =
        ErrorMsg.impossible 
          "simpleVar should not look into topLevel"
    | irSimpleVar(
        (Level({parent= pDest, 
                frame= fDest, 
                uni= uniDest}), access), 
         Level({parent= pCur, frame= fCur, uni= uniCur})) = 
        if uniCur = uniDest 
        then 
          F.exp(access)(Tr.TEMP(F.FP)) 
        else
          F.exp (hd (F.formals(fCur)))
                    (irSimpleVar(
                      (Level({parent=pDest, 
                              frame=fDest, 
                              uni=uniDest}), 
                       access),
                        pCur))
  (*Returns a exp which loads the given
    access with a given level following static links*)
  fun simpleVar(access, level) =
    Ex(irSimpleVar(access, level))

  fun irFieldVar(recExp, fieldNum) =
    Ex(Tr.MEM(
        Tr.BINOP(
          Tr.PLUS,
          unEx(recExp),
          Tr.CONST(fieldNum * F.wordSize)))) 
  fun irSubscriptVar(arrExp, subExp) =
    Ex(Tr.MEM(
        Tr.BINOP(
          Tr.PLUS,
          unEx(arrExp),
          Tr.BINOP(
            Tr.MUL,
            unEx(subExp),
            Tr.CONST(F.wordSize)))))
  fun irCallExp() = Ex(Tr.CONST(1))

  fun irRecordExp() = Ex(Tr.CONST(1)) 

  fun irBreakExp() = Ex(Tr.CONST(1))

  fun irLetExp(decs, body) = Ex(Tr.CONST(1))

  fun irFunDec(TopLevel, _) = 
         ErrorMsg.impossible 
          "irFunDec should not be given topLevel"
    | irFunDec(Level(level), exp) = 
        procEntryExit(Level(level),
          Nx(Tr.MOVE(Tr.TEMP(F.RV), 
                     F.procEntryExit1(#frame level, unEx(exp)))))

end
    