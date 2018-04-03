(* The string literals are:

    l3  ->  ""
    l5  ->  "X"
    l6  ->  " "
    l13 ->  "\n"
*)

val insrLists = map AssemStore.decode [("tig_main", 10, [AssemStore.OPER{assem="sw `s1, -8(`s0)", src=[0,16], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -12(`s0)", src=[0,17], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -16(`s0)", src=[0,18], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -20(`s0)", src=[0,19], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -24(`s0)", src=[0,20], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -28(`s0)", src=[0,21], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -32(`s0)", src=[0,22], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -36(`s0)", src=[0,23], dst=[], jump=NONE},
AssemStore.LABEL{assem="l30:", lab="l30"},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=24},
AssemStore.MOVE{assem="move `d0, `s0", src=2, dst=25},
AssemStore.OPER{assem="sw `s0, 0(`s1)", src=[25,24], dst=[], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=26},
AssemStore.OPER{assem="li `d0, 80", src=[], dst=[27], jump=NONE},
AssemStore.OPER{assem="sw `s1, -4(`s0)", src=[26,27], dst=[], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=28},
AssemStore.OPER{assem="lw `d0, -4(`s0)", src=[28], dst=[29], jump=NONE},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[30], jump=NONE},
AssemStore.OPER{assem="la `d0, tig_initArray", src=[], dst=[31], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=29, dst=32},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[33], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=32, dst=2},
AssemStore.MOVE{assem="move `d0, `s0", src=33, dst=3},
AssemStore.OPER{assem="jal `s0", src=[31,2,3], dst=[1,6,7,8,9,10,11,12,13,14,15,2,3,4,5], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=1, dst=34},
AssemStore.MOVE{assem="move `d0, `s0", src=34, dst=35},
AssemStore.OPER{assem="li `d0, 4", src=[], dst=[36], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=35, dst=37},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[36,37], dst=[38], jump=NONE},
AssemStore.OPER{assem="li `d0, 1", src=[], dst=[39], jump=NONE},
AssemStore.OPER{assem="sw `s1, 0(`s0)", src=[38,39], dst=[], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l27"]},
AssemStore.LABEL{assem="l27:", lab="l27"},
AssemStore.OPER{assem="li `d0, 1", src=[], dst=[40], jump=NONE},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[41], jump=NONE},
AssemStore.OPER{assem="beq `s0, `s1, `j0", src=[40,41], dst=[], jump=SOME["l26","l28"]},
AssemStore.LABEL{assem="l28:", lab="l28"},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=42},
AssemStore.MOVE{assem="move `d0, `s0", src=35, dst=43},
AssemStore.OPER{assem="la `d0, stringForRow.0", src=[], dst=[44], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=42, dst=45},
AssemStore.MOVE{assem="move `d0, `s0", src=43, dst=46},
AssemStore.MOVE{assem="move `d0, `s0", src=45, dst=2},
AssemStore.MOVE{assem="move `d0, `s0", src=46, dst=3},
AssemStore.OPER{assem="jal `s0", src=[44,2,3], dst=[1,6,7,8,9,10,11,12,13,14,15,2,3,4,5], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=1, dst=47},
AssemStore.MOVE{assem="move `d0, `s0", src=47, dst=48},
AssemStore.OPER{assem="la `d0, tig_print", src=[], dst=[49], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=48, dst=50},
AssemStore.MOVE{assem="move `d0, `s0", src=50, dst=2},
AssemStore.OPER{assem="jal `s0", src=[49,2], dst=[1,6,7,8,9,10,11,12,13,14,15,2,3,4,5], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=1, dst=51},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=52},
AssemStore.MOVE{assem="move `d0, `s0", src=35, dst=53},
AssemStore.OPER{assem="la `d0, updateRow.2", src=[], dst=[54], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=52, dst=55},
AssemStore.MOVE{assem="move `d0, `s0", src=53, dst=56},
AssemStore.MOVE{assem="move `d0, `s0", src=55, dst=2},
AssemStore.MOVE{assem="move `d0, `s0", src=56, dst=3},
AssemStore.OPER{assem="jal `s0", src=[54,2,3], dst=[1,6,7,8,9,10,11,12,13,14,15,2,3,4,5], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=1, dst=57},
AssemStore.MOVE{assem="move `d0, `s0", src=57, dst=35},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l27"]},
AssemStore.LABEL{assem="l26:", lab="l26"},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[1], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l29"]},
AssemStore.LABEL{assem="l29:", lab="l29"},
AssemStore.OPER{assem="lw `d0, -8(`s0)", src=[0], dst=[16], jump=NONE},
AssemStore.OPER{assem="lw `d0, -12(`s0)", src=[0], dst=[17], jump=NONE},
AssemStore.OPER{assem="lw `d0, -16(`s0)", src=[0], dst=[18], jump=NONE},
AssemStore.OPER{assem="lw `d0, -20(`s0)", src=[0], dst=[19], jump=NONE},
AssemStore.OPER{assem="lw `d0, -24(`s0)", src=[0], dst=[20], jump=NONE},
AssemStore.OPER{assem="lw `d0, -28(`s0)", src=[0], dst=[21], jump=NONE},
AssemStore.OPER{assem="lw `d0, -32(`s0)", src=[0], dst=[22], jump=NONE},
AssemStore.OPER{assem="lw `d0, -36(`s0)", src=[0], dst=[23], jump=NONE}]),
("updateRow.2", 9, [AssemStore.OPER{assem="sw `s1, -4(`s0)", src=[0,16], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -8(`s0)", src=[0,17], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -12(`s0)", src=[0,18], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -16(`s0)", src=[0,19], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -20(`s0)", src=[0,20], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -24(`s0)", src=[0,21], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -28(`s0)", src=[0,22], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -32(`s0)", src=[0,23], dst=[], jump=NONE},
AssemStore.LABEL{assem="l32:", lab="l32"},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=24},
AssemStore.MOVE{assem="move `d0, `s0", src=2, dst=25},
AssemStore.OPER{assem="sw `s0, 0(`s1)", src=[25,24], dst=[], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=3, dst=26},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=27},
AssemStore.OPER{assem="lw `d0, 0(`s0)", src=[27], dst=[28], jump=NONE},
AssemStore.OPER{assem="lw `d0, -4(`s0)", src=[28], dst=[29], jump=NONE},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[30], jump=NONE},
AssemStore.OPER{assem="la `d0, tig_initArray", src=[], dst=[31], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=29, dst=32},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[33], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=32, dst=2},
AssemStore.MOVE{assem="move `d0, `s0", src=33, dst=3},
AssemStore.OPER{assem="jal `s0", src=[31,2,3], dst=[1,6,7,8,9,10,11,12,13,14,15,2,3,4,5], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=1, dst=34},
AssemStore.MOVE{assem="move `d0, `s0", src=34, dst=35},
AssemStore.OPER{assem="li `d0, 4", src=[], dst=[36], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=35, dst=37},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[36,37], dst=[38], jump=NONE},
AssemStore.OPER{assem="li `d0, 4", src=[], dst=[39], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=26, dst=40},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[39,40], dst=[41], jump=NONE},
AssemStore.OPER{assem="lw `d0, 0(`s0)", src=[41], dst=[42], jump=NONE},
AssemStore.OPER{assem="sw `s1, 0(`s0)", src=[38,42], dst=[], jump=NONE},
AssemStore.OPER{assem="li `d0, 1", src=[], dst=[43], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=44},
AssemStore.OPER{assem="lw `d0, 0(`s0)", src=[44], dst=[45], jump=NONE},
AssemStore.OPER{assem="lw `d0, -4(`s0)", src=[45], dst=[46], jump=NONE},
AssemStore.OPER{assem="li `d0, 1", src=[], dst=[47], jump=NONE},
AssemStore.OPER{assem="sub `d0, `s0, `s1", src=[46,47], dst=[48], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l24"]},
AssemStore.LABEL{assem="l24:", lab="l24"},
AssemStore.MOVE{assem="move `d0, `s0", src=43, dst=49},
AssemStore.MOVE{assem="move `d0, `s0", src=48, dst=50},
AssemStore.OPER{assem="bgt `s0, `s1, `j0", src=[49,50], dst=[], jump=SOME["l23","l25"]},
AssemStore.LABEL{assem="l25:", lab="l25"},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=51},
AssemStore.OPER{assem="lw `d0, 0(`s0)", src=[51], dst=[52], jump=NONE},
AssemStore.OPER{assem="li `d0, 4", src=[], dst=[53], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=26, dst=54},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[53,54], dst=[55], jump=NONE},
AssemStore.OPER{assem="li `d0, 4", src=[], dst=[56], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=43, dst=57},
AssemStore.OPER{assem="li `d0, 1", src=[], dst=[58], jump=NONE},
AssemStore.OPER{assem="sub `d0, `s0, `s1", src=[57,58], dst=[59], jump=NONE},
AssemStore.OPER{assem="mul `d0, `s0, `s1", src=[56,59], dst=[60], jump=NONE},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[55,60], dst=[61], jump=NONE},
AssemStore.OPER{assem="lw `d0, 0(`s0)", src=[61], dst=[62], jump=NONE},
AssemStore.OPER{assem="li `d0, 4", src=[], dst=[63], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=26, dst=64},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[63,64], dst=[65], jump=NONE},
AssemStore.OPER{assem="li `d0, 4", src=[], dst=[66], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=43, dst=67},
AssemStore.OPER{assem="mul `d0, `s0, `s1", src=[66,67], dst=[68], jump=NONE},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[65,68], dst=[69], jump=NONE},
AssemStore.OPER{assem="lw `d0, 0(`s0)", src=[69], dst=[70], jump=NONE},
AssemStore.OPER{assem="la `d0, xor.1", src=[], dst=[71], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=52, dst=72},
AssemStore.MOVE{assem="move `d0, `s0", src=62, dst=73},
AssemStore.MOVE{assem="move `d0, `s0", src=70, dst=74},
AssemStore.MOVE{assem="move `d0, `s0", src=72, dst=2},
AssemStore.MOVE{assem="move `d0, `s0", src=73, dst=3},
AssemStore.MOVE{assem="move `d0, `s0", src=74, dst=4},
AssemStore.OPER{assem="jal `s0", src=[71,2,3,4], dst=[1,6,7,8,9,10,11,12,13,14,15,2,3,4,5], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=1, dst=75},
AssemStore.OPER{assem="li `d0, 4", src=[], dst=[76], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=35, dst=77},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[76,77], dst=[78], jump=NONE},
AssemStore.OPER{assem="li `d0, 4", src=[], dst=[79], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=43, dst=80},
AssemStore.OPER{assem="mul `d0, `s0, `s1", src=[79,80], dst=[81], jump=NONE},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[78,81], dst=[82], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=75, dst=83},
AssemStore.OPER{assem="sw `s0, 0(`s1)", src=[83,82], dst=[], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=43, dst=84},
AssemStore.OPER{assem="li `d0, 1", src=[], dst=[85], jump=NONE},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[84,85], dst=[43], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l24"]},
AssemStore.LABEL{assem="l23:", lab="l23"},
AssemStore.MOVE{assem="move `d0, `s0", src=35, dst=1},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l31"]},
AssemStore.LABEL{assem="l31:", lab="l31"},
AssemStore.OPER{assem="lw `d0, -4(`s0)", src=[0], dst=[16], jump=NONE},
AssemStore.OPER{assem="lw `d0, -8(`s0)", src=[0], dst=[17], jump=NONE},
AssemStore.OPER{assem="lw `d0, -12(`s0)", src=[0], dst=[18], jump=NONE},
AssemStore.OPER{assem="lw `d0, -16(`s0)", src=[0], dst=[19], jump=NONE},
AssemStore.OPER{assem="lw `d0, -20(`s0)", src=[0], dst=[20], jump=NONE},
AssemStore.OPER{assem="lw `d0, -24(`s0)", src=[0], dst=[21], jump=NONE},
AssemStore.OPER{assem="lw `d0, -28(`s0)", src=[0], dst=[22], jump=NONE},
AssemStore.OPER{assem="lw `d0, -32(`s0)", src=[0], dst=[23], jump=NONE}]),
("xor.1", 9, [AssemStore.OPER{assem="sw `s1, -4(`s0)", src=[0,16], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -8(`s0)", src=[0,17], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -12(`s0)", src=[0,18], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -16(`s0)", src=[0,19], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -20(`s0)", src=[0,20], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -24(`s0)", src=[0,21], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -28(`s0)", src=[0,22], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -32(`s0)", src=[0,23], dst=[], jump=NONE},
AssemStore.LABEL{assem="l34:", lab="l34"},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=24},
AssemStore.MOVE{assem="move `d0, `s0", src=2, dst=25},
AssemStore.OPER{assem="sw `s0, 0(`s1)", src=[25,24], dst=[], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=3, dst=26},
AssemStore.MOVE{assem="move `d0, `s0", src=4, dst=27},
AssemStore.MOVE{assem="move `d0, `s0", src=26, dst=28},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[29], jump=NONE},
AssemStore.OPER{assem="beq `s0, `s1, `j0", src=[28,29], dst=[], jump=SOME["l21","l20"]},
AssemStore.LABEL{assem="l20:", lab="l20"},
AssemStore.MOVE{assem="move `d0, `s0", src=27, dst=30},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[31], jump=NONE},
AssemStore.OPER{assem="beq `s0, `s1, `j0", src=[30,31], dst=[], jump=SOME["l15","l14"]},
AssemStore.LABEL{assem="l14:", lab="l14"},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[32], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l16"]},
AssemStore.LABEL{assem="l16:", lab="l16"},
AssemStore.MOVE{assem="move `d0, `s0", src=32, dst=33},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l22"]},
AssemStore.LABEL{assem="l22:", lab="l22"},
AssemStore.MOVE{assem="move `d0, `s0", src=33, dst=1},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l33"]},
AssemStore.LABEL{assem="l15:", lab="l15"},
AssemStore.OPER{assem="li `d0, 1", src=[], dst=[32], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l16"]},
AssemStore.LABEL{assem="l21:", lab="l21"},
AssemStore.MOVE{assem="move `d0, `s0", src=27, dst=34},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[35], jump=NONE},
AssemStore.OPER{assem="beq `s0, `s1, `j0", src=[34,35], dst=[], jump=SOME["l18","l17"]},
AssemStore.LABEL{assem="l17:", lab="l17"},
AssemStore.OPER{assem="li `d0, 1", src=[], dst=[36], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l19"]},
AssemStore.LABEL{assem="l19:", lab="l19"},
AssemStore.MOVE{assem="move `d0, `s0", src=36, dst=33},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l22"]},
AssemStore.LABEL{assem="l18:", lab="l18"},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[36], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l19"]},
AssemStore.LABEL{assem="l33:", lab="l33"},
AssemStore.OPER{assem="lw `d0, -4(`s0)", src=[0], dst=[16], jump=NONE},
AssemStore.OPER{assem="lw `d0, -8(`s0)", src=[0], dst=[17], jump=NONE},
AssemStore.OPER{assem="lw `d0, -12(`s0)", src=[0], dst=[18], jump=NONE},
AssemStore.OPER{assem="lw `d0, -16(`s0)", src=[0], dst=[19], jump=NONE},
AssemStore.OPER{assem="lw `d0, -20(`s0)", src=[0], dst=[20], jump=NONE},
AssemStore.OPER{assem="lw `d0, -24(`s0)", src=[0], dst=[21], jump=NONE},
AssemStore.OPER{assem="lw `d0, -28(`s0)", src=[0], dst=[22], jump=NONE},
AssemStore.OPER{assem="lw `d0, -32(`s0)", src=[0], dst=[23], jump=NONE}]),
("stringForRow.0", 9, [AssemStore.OPER{assem="sw `s1, -4(`s0)", src=[0,16], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -8(`s0)", src=[0,17], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -12(`s0)", src=[0,18], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -16(`s0)", src=[0,19], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -20(`s0)", src=[0,20], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -24(`s0)", src=[0,21], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -28(`s0)", src=[0,22], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -32(`s0)", src=[0,23], dst=[], jump=NONE},
AssemStore.LABEL{assem="l36:", lab="l36"},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=24},
AssemStore.MOVE{assem="move `d0, `s0", src=2, dst=25},
AssemStore.OPER{assem="sw `s0, 0(`s1)", src=[25,24], dst=[], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=3, dst=26},
AssemStore.OPER{assem="la `d0, l3", src=[], dst=[27], jump=NONE},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[28], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=29},
AssemStore.OPER{assem="lw `d0, 0(`s0)", src=[29], dst=[30], jump=NONE},
AssemStore.OPER{assem="lw `d0, -4(`s0)", src=[30], dst=[31], jump=NONE},
AssemStore.OPER{assem="li `d0, 1", src=[], dst=[32], jump=NONE},
AssemStore.OPER{assem="sub `d0, `s0, `s1", src=[31,32], dst=[33], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l11"]},
AssemStore.LABEL{assem="l11:", lab="l11"},
AssemStore.MOVE{assem="move `d0, `s0", src=28, dst=34},
AssemStore.MOVE{assem="move `d0, `s0", src=33, dst=35},
AssemStore.OPER{assem="bgt `s0, `s1, `j0", src=[34,35], dst=[], jump=SOME["l10","l12"]},
AssemStore.LABEL{assem="l12:", lab="l12"},
AssemStore.MOVE{assem="move `d0, `s0", src=27, dst=36},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=37},
AssemStore.OPER{assem="li `d0, 4", src=[], dst=[38], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=26, dst=39},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[38,39], dst=[40], jump=NONE},
AssemStore.OPER{assem="li `d0, 4", src=[], dst=[41], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=28, dst=42},
AssemStore.OPER{assem="mul `d0, `s0, `s1", src=[41,42], dst=[43], jump=NONE},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[40,43], dst=[44], jump=NONE},
AssemStore.OPER{assem="lw `d0, 0(`s0)", src=[44], dst=[45], jump=NONE},
AssemStore.OPER{assem="la `d0, charForBool.4", src=[], dst=[46], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=37, dst=47},
AssemStore.MOVE{assem="move `d0, `s0", src=45, dst=48},
AssemStore.MOVE{assem="move `d0, `s0", src=47, dst=2},
AssemStore.MOVE{assem="move `d0, `s0", src=48, dst=3},
AssemStore.OPER{assem="jal `s0", src=[46,2,3], dst=[1,6,7,8,9,10,11,12,13,14,15,2,3,4,5], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=1, dst=49},
AssemStore.MOVE{assem="move `d0, `s0", src=49, dst=50},
AssemStore.OPER{assem="la `d0, tig_concat", src=[], dst=[51], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=36, dst=52},
AssemStore.MOVE{assem="move `d0, `s0", src=50, dst=53},
AssemStore.MOVE{assem="move `d0, `s0", src=52, dst=2},
AssemStore.MOVE{assem="move `d0, `s0", src=53, dst=3},
AssemStore.OPER{assem="jal `s0", src=[51,2,3], dst=[1,6,7,8,9,10,11,12,13,14,15,2,3,4,5], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=1, dst=54},
AssemStore.MOVE{assem="move `d0, `s0", src=54, dst=27},
AssemStore.MOVE{assem="move `d0, `s0", src=28, dst=55},
AssemStore.OPER{assem="li `d0, 1", src=[], dst=[56], jump=NONE},
AssemStore.OPER{assem="add `d0, `s0, `s1", src=[55,56], dst=[28], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l11"]},
AssemStore.LABEL{assem="l10:", lab="l10"},
AssemStore.MOVE{assem="move `d0, `s0", src=27, dst=57},
AssemStore.OPER{assem="la `d0, l13", src=[], dst=[58], jump=NONE},
AssemStore.OPER{assem="la `d0, tig_concat", src=[], dst=[59], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=57, dst=60},
AssemStore.MOVE{assem="move `d0, `s0", src=58, dst=61},
AssemStore.MOVE{assem="move `d0, `s0", src=60, dst=2},
AssemStore.MOVE{assem="move `d0, `s0", src=61, dst=3},
AssemStore.OPER{assem="jal `s0", src=[59,2,3], dst=[1,6,7,8,9,10,11,12,13,14,15,2,3,4,5], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=1, dst=62},
AssemStore.MOVE{assem="move `d0, `s0", src=62, dst=1},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l35"]},
AssemStore.LABEL{assem="l35:", lab="l35"},
AssemStore.OPER{assem="lw `d0, -4(`s0)", src=[0], dst=[16], jump=NONE},
AssemStore.OPER{assem="lw `d0, -8(`s0)", src=[0], dst=[17], jump=NONE},
AssemStore.OPER{assem="lw `d0, -12(`s0)", src=[0], dst=[18], jump=NONE},
AssemStore.OPER{assem="lw `d0, -16(`s0)", src=[0], dst=[19], jump=NONE},
AssemStore.OPER{assem="lw `d0, -20(`s0)", src=[0], dst=[20], jump=NONE},
AssemStore.OPER{assem="lw `d0, -24(`s0)", src=[0], dst=[21], jump=NONE},
AssemStore.OPER{assem="lw `d0, -28(`s0)", src=[0], dst=[22], jump=NONE},
AssemStore.OPER{assem="lw `d0, -32(`s0)", src=[0], dst=[23], jump=NONE}]),
("charForBool.4", 9, [AssemStore.OPER{assem="sw `s1, -4(`s0)", src=[0,16], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -8(`s0)", src=[0,17], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -12(`s0)", src=[0,18], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -16(`s0)", src=[0,19], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -20(`s0)", src=[0,20], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -24(`s0)", src=[0,21], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -28(`s0)", src=[0,22], dst=[], jump=NONE},
AssemStore.OPER{assem="sw `s1, -32(`s0)", src=[0,23], dst=[], jump=NONE},
AssemStore.LABEL{assem="l38:", lab="l38"},
AssemStore.MOVE{assem="move `d0, `s0", src=0, dst=24},
AssemStore.MOVE{assem="move `d0, `s0", src=2, dst=25},
AssemStore.OPER{assem="sw `s0, 0(`s1)", src=[25,24], dst=[], jump=NONE},
AssemStore.MOVE{assem="move `d0, `s0", src=3, dst=26},
AssemStore.MOVE{assem="move `d0, `s0", src=26, dst=27},
AssemStore.OPER{assem="li `d0, 0", src=[], dst=[28], jump=NONE},
AssemStore.OPER{assem="beq `s0, `s1, `j0", src=[27,28], dst=[], jump=SOME["l8","l7"]},
AssemStore.LABEL{assem="l7:", lab="l7"},
AssemStore.OPER{assem="la `d0, l5", src=[], dst=[29], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l9"]},
AssemStore.LABEL{assem="l9:", lab="l9"},
AssemStore.MOVE{assem="move `d0, `s0", src=29, dst=1},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l37"]},
AssemStore.LABEL{assem="l8:", lab="l8"},
AssemStore.OPER{assem="la `d0, l6", src=[], dst=[29], jump=NONE},
AssemStore.OPER{assem="b `j0", src=[], dst=[], jump=SOME["l9"]},
AssemStore.LABEL{assem="l37:", lab="l37"},
AssemStore.OPER{assem="lw `d0, -4(`s0)", src=[0], dst=[16], jump=NONE},
AssemStore.OPER{assem="lw `d0, -8(`s0)", src=[0], dst=[17], jump=NONE},
AssemStore.OPER{assem="lw `d0, -12(`s0)", src=[0], dst=[18], jump=NONE},
AssemStore.OPER{assem="lw `d0, -16(`s0)", src=[0], dst=[19], jump=NONE},
AssemStore.OPER{assem="lw `d0, -20(`s0)", src=[0], dst=[20], jump=NONE},
AssemStore.OPER{assem="lw `d0, -24(`s0)", src=[0], dst=[21], jump=NONE},
AssemStore.OPER{assem="lw `d0, -28(`s0)", src=[0], dst=[22], jump=NONE},
AssemStore.OPER{assem="lw `d0, -32(`s0)", src=[0], dst=[23], jump=NONE}])]