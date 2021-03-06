structure Main = struct

  structure Tr = Translate
  structure F = MipsFrame
  structure R = RegAlloc


  fun makestring(temp) = 
    case Temp.Table.look(F.tempMap, temp)
      of SOME str => str
       | NONE => Temp.makestring(temp)

 fun makeRegs(temp, alloc) = 
    case Temp.Table.look(alloc, temp)
      of SOME str => str
       | NONE => Temp.makestring(temp)

  fun getsome (SOME x) = x
    | getsome (NONE) = ErrorMsg.impossible 
        "tried to get some of NONE"

  fun emitproc out (F.PROC{body,frame}) =
    let val _ = print ("emit " ^ Symbol.name(F.name frame) ^ "\n")
        val stms = Canon.linearize body
        val stms' = Canon.traceSchedule(Canon.basicBlocks stms)
        val instrs =   List.concat(map (MipsGen.codegen frame) stms')
        val instrs' = F.procEntryExit2(frame, instrs)
        (* register allocation not working yet, lines 29 and 32 *)
        (* val (instrs', alloc) = R.alloc(instrs, frame) *)
        val format0 = Assem.format(makestring)
        val {prolog,body,epilog} = F.procEntryExit3(frame,instrs')   
        (*val format0 = Assem.format(fn(temp) => makeRegs(temp, alloc))*)
    in  
      (TextIO.output(out,prolog);  
      (app (fn i => TextIO.output(out,format0 i)) body);
      TextIO.output(out,epilog))
    end
  | emitproc out (F.STRING(lab,s)) = TextIO.output(out, F.string(lab,s))

  fun withOpenFile fname f = 
    let val out = TextIO.openOut fname
    in (f out before TextIO.closeOut out) 
      handle e => (TextIO.closeOut out; raise e)
    end 

  fun compile filename = 
    let val absyn = Parse.parse filename
        val frags = (FindEscape.findEscape absyn; Semant.transProg absyn)
    in 
      withOpenFile (filename ^ ".s") 
      (fn out => (app (emitproc out) frags))
    end

end



