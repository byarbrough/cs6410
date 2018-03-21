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

  (* make sure Semant doesn't need to touch the tree *)
  val simpleVar : access * level -> exp

  (*Conversion functions below*)
  (* transExp *)
  (*
  val irVar : () -> ()
  val irNil : () -> ()
  *)
  val irInt : int -> exp
  (*
  val irString : () -> ()
  val irCallExp : () -> ()
  val irOpExp : () -> ()
  val irRecordExp : () -> ()
  val irSeqExp : () -> ()
  val irAssignExp : () -> ()
  val irIfExp : () -> ()
  val irWhileExp : () -> ()
  val irForExp : () -> ()
  val irBreakExp : () -> ()
  val irLetExp : () -> ()
  val irArrayExp : () -> ()
  *)

end

structure Translate : TRANSLATE = struct 
  structure F = MipsFrame
  structure T = Temp
  structure Tr = Tree
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


  fun unEx(Ex e) = e
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

  fun unNx(Nx n) = n
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

  fun unCx(Cx c) = c
    | unCx(Ex e) = (fn(t, f) => Tr.CJUMP(Tr.NE, e, Tr.CONST 0, t, f))        
    | unCx(Nx n) = ErrorMsg.impossible "Nx should not ever be converted to Cx"

  fun procEntryExit _  = ()

  fun getResult() = []

  (*Translate semant to IR tree language*)
  (* transExp *)
  (*location of var: k is offset within frame and fp is frame pointer *)
  fun irVar(var{fp, k}) = Ex(Tr.MEM(Tr.BINOP(Tr.PLUS, TR.TEMP fp, TR.CONST k)))
  fun irNil() = ()
  fun irInt(num) = Ex(Tr.CONST(num))
  fun irString(str) = () 

  fun irCallExp{func, args, pose} = ()

  fun irOpExp{left, oper, right, pos} = ()

  fun irRecordExp{fields, typ, pos} = ()
(*
  fun irSeqExp(nil') = {exp, ty}
    | irSeqExp(exp, pos) :: tail) = ()
*)
  fun irAssignExp{var, exp, pos} = ()

  fun irIfExp{test, thn, els= SOME(exp), pos} = ()
    | irIfExp{test, thn, els= NONE, pos} = ()
  fun irWhileExp{tset, body, pos} = ()
  fun irForExp{var, escape, lo, hi, body, pos} = ()
  fun irBreakExp(pos) = ()

  fun irLetExp{decs, body, pos} = ()
  fun irArrayExp{typ, size, int, pos} = ()

  (* trvar *)

end
    