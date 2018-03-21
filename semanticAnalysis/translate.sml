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
  val procEntryExit : {level: level, body: exp} -> unit
  (*structure Frame : FRAME*)
  val getResult : unit -> frag list
  val fragList : frag list

  (*Conversion functions below*)
  (* transExp *)
  val irNil : unit -> exp
  val irInt : int -> exp
  val irString : string -> exp
  (*
  val irCallExp : () -> ()*)
  val irOpExp : {exp: exp, ty : Types.ty} * 
                 Absyn.oper *
                 {exp: exp, ty : Types.ty} *
                 Absyn.pos -> exp
  (*
  val irRecordExp : () -> ()
  val irSeqExp : () -> ()
  val irAssignExp : () -> ()
  *)
  val irIfExp : {test: exp, ty : Types.ty} * 
                  {thn: exp, ty : Types.ty} *
                  {els: exp, ty : Types.ty} *
                  Absyn.pos -> exp
  (*)
  val irWhileExp : () -> ()
  val irForExp : () -> ()
  val irBreakExp : () -> ()
  val irLetExp : () -> ()
  val irArrayExp : () -> ()
  *)
  (* trvar *)
  val irSimpleVar : access * level -> exp

end

structure Translate : TRANSLATE = struct 
  structure F = MipsFrame
  structure T = Temp
  structure Tr = Tree
  structure A = Absyn
  datatype level = TopLevel 
  			 | Level of {parent: level, frame: F.frame, uni: unit ref}
  datatype exp = 
      Ex of Tr.exp 
    | Nx of Tr.stm
    | Cx of T.label * T.label -> Tr.stm
  type access = level * F.access
  type frag = F.frag
  (*The outermost level*)
  val outermost = TopLevel

  val fragList = []

  (* returns a new level from the give name, parent level and formals*)
  fun newLevel({parent, name, formals}) = 
  		Level({ parent= parent,
		          frame= F.newFrame({name= name, formals= formals}), 
		          uni = ref ()})
  (*Return the access list of formals for the given level*)
  fun formals(TopLevel) = []
    | formals(Level(level)) = map (fn(formal) => (Level(level), formal)) (F.formals(#frame level))
 
  (*Return a function that will return an allocated variable given a boolean.*)
  fun allocLocal(TopLevel) = 
  		ErrorMsg.impossible "allocLocal should not be given outermost level"
  	| allocLocal(Level level) = fn(b) => (Level(level), (F.allocLocal(#frame level) b))

  fun seq([]) = ErrorMsg.impossible "seq should not be given an empty list"
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
    | unCx(Ex e) = (fn(t, f) => Tr.CJUMP(Tr.NE, e, Tr.CONST 0, t, f))        
    | unCx(Nx n) = ErrorMsg.impossible "Nx should not ever be converted to Cx"

  fun procEntryExit _  = ()

  fun getResult() = []

  (*Translate semant to IR tree language*)
  (* transExp *)
  fun irNil() = Ex(Tr.CONST 0)
  fun irInt(num) = Ex(Tr.CONST(num))
  fun irString(str) =
  let
     val lab = T.newlabel()
   in
      F.STRING(lab, str) :: fragList;
      Ex(Tr.NAME(lab))
   end 

  fun irCallExp{func, args, pos} = ()

  
  fun arith(trOp : Tr.binop, l, r) =
        Ex(Tr.BINOP(trOp, unEx(l), unEx(r)))
  fun comp(trComp : Tr.relop, l, r) = 
     Cx(fn(t : T.label, f : T.label) => 
          Tr.CJUMP(Tr.LT, unEx(l), unEx(r), t, f))
  

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
        Ex(F.externalCall("stringLT", [unEx(l), unEx(r)]))
    | irOpExp({exp=l, ty=ty1}, A.LtOp, 
              {exp=r, ty=ty2}, pos) = 
        comp(Tr.LT, l, r)   
    | irOpExp({exp=l, ty=_}, A.LeOp, 
              {exp=r, ty=_}, pos) =
        comp(Tr.LE, l, r)   
    | irOpExp({exp=l, ty=_}, A.GtOp, 
              {exp=r, ty=_}, pos) =
         comp(Tr.GT, l, r)   
    | irOpExp({exp=l, ty=_}, A.GeOp, 
              {exp=r, ty=_}, pos) =
         comp(Tr.GE, l, r)             
    | irOpExp({exp=l, ty=_}, A.EqOp, 
              {exp=r, ty=_}, pos) =
         comp(Tr.EQ, l, r)   
    | irOpExp({exp=l, ty=_}, A.NeqOp, 
              {exp=r, ty=_}, pos) =
         comp(Tr.NE, l, r)               

  fun irRecordExp{fields, typ, pos} = ()
(*
  fun irSeqExp(nil') = {exp, ty}
    | irSeqExp(exp, pos) :: tail) = ()
*)
  fun irAssignExp{var, exp, pos} = ()

  fun irIfExp{test, thn, els= SOME(exp), pos} =
    let
      val r = T.newtemp();
      val t = T.newlabel();
      val f = T.newlabel();
      val e1 = unCx(test);
      val e2 = unEx(thn);
      val e3 = unEx(els)
    in
      ()
    end

  fun irWhileExp{test, body, pos} = ()
  fun irForExp{var, escape, lo, hi, body, pos} = ()
  fun irBreakExp(pos) = ()

  fun irLetExp{decs, body, pos} = ()
  fun irArrayExp{typ, size, int, pos} = ()


  (*fun simpleVar*)
  (* trvar *)
  (*location of var: k is offset within frame and fp is frame pointer *)
  fun irSimpleVar(
    ({parent= p1, frame= f1, uni= u1}, access), 
     {parent= p2, frame= f2, uni= u2}) = 
    if u1 = u2 then F.exp(access)(F.FP) else 
      Tr.MEM(Tr.PLUS, Tr.CONST(sl), 
              irSimpleVar(({parent=p1, frame=f1, uni=u1}, access),
                          p2))
end
    