(* the undefined label is for the "hello, world" string itself *)
val insrLists = map AssemStore.decode [("tig_main", 9, [AssemStore.OPER{assem="sw `s1, -4(`s0)", src=[0,16], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -8(`s0)", src=[0,17], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -12(`s0)", src=[0,18], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -16(`s0)", src=[0,19], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -20(`s0)", src=[0,20], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -24(`s0)", src=[0,21], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -28(`s0)", src=[0,22], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -32(`s0)", src=[0,23], dst=[], jump=NONE},
AssemStore.LABEL{assem="l354:", lab="l354"},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=24},
AssemStore.MOVE{assem="move `d0, `s0", src=2, dst=25},
AssemStore.OPER{assem="sw `s0, 0(`s1)", src=[25,24], dst=[], jump=NONE},
AssemStore.OPER{assem="la `d0, l352", src=[], dst=[26], jump=NONE},
AssemStore.OPER{assem="la `d0, tig_print", src=[], dst=[27], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=26, dst=28},
AssemStore.MOVE{assem="move `d0, `s0", src=28, dst=2},
AssemStore.OPER{assem="jal `s0", src=[27,2], dst=[1,6,7,8,9,10,11,12,13,14,15,2,3,4,5], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=1, dst=29},
AssemStore.MOVE{assem="move `d0, `s0", src=29, dst=1},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l353"]},
AssemStore.LABEL{assem="l353:", lab="l353"},
AssemStore.OPER{assem="lw `d0, -4(`s0)", src=[0], dst=[16], jump=NONE},
AssemStore.OPER{assem="lw `d0, -8(`s0)", src=[0], dst=[17], jump=NONE},
AssemStore.OPER{assem="lw `d0, -12(`s0)", src=[0], dst=[18], jump=NONE},
AssemStore.OPER{assem="lw `d0, -16(`s0)", src=[0], dst=[19], jump=NONE},
AssemStore.OPER{assem="lw `d0, -20(`s0)", src=[0], dst=[20], jump=NONE},
AssemStore.OPER{assem="lw `d0, -24(`s0)", src=[0], dst=[21], jump=NONE},
AssemStore.OPER{assem="lw `d0, -28(`s0)", src=[0], dst=[22], jump=NONE},
AssemStore.OPER{assem="lw `d0, -32(`s0)", src=[0], dst=[23], jump=NONE}])]
