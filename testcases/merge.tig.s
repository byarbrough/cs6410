EXP(
 ESEQ(
  SEQ(
   MOVE(
    TEMP t63,
    ESEQ(
     EXP(
      CALL(
       NAME readlist,
        TEMP t1)),
     ESEQ(
      MOVE(
       MEM(
        BINOP(MINUS,
         TEMP t1,
         CONST 4)),
       CALL(
        NAME getchar)),
      CONST 0))),
   SEQ(
    MOVE(
     TEMP t62,
     CALL(
      NAME readlist,
       TEMP t1)),
    MOVE(
     MEM(
      BINOP(MINUS,
       TEMP t1,
       CONST 4)),
     CALL(
      NAME getchar)))),
  CALL(
   NAME printlist,
    TEMP t1,
    CALL(
     NAME merge,
      TEMP t1,
      TEMP t62,
      TEMP t63))))
EXP(
 CALL(
  NAME readlist,
   TEMP t1))
MOVE(
 TEMP t65,
 BINOP(MINUS,
  TEMP t1,
  CONST 4))
MOVE(
 TEMP t64,
 CALL(
  NAME getchar))
MOVE(
 MEM(
  TEMP t65),
 TEMP t64)
MOVE(
 TEMP t63,
 CONST 0)
MOVE(
 TEMP t62,
 CALL(
  NAME readlist,
   TEMP t1))
MOVE(
 TEMP t67,
 BINOP(MINUS,
  TEMP t1,
  CONST 4))
MOVE(
 TEMP t66,
 CALL(
  NAME getchar))
MOVE(
 MEM(
  TEMP t67),
 TEMP t66)
MOVE(
 TEMP t69,
 TEMP t1)
MOVE(
 TEMP t68,
 CALL(
  NAME merge,
   TEMP t1,
   TEMP t62,
   TEMP t63))
EXP(
 CALL(
  NAME printlist,
   TEMP t69,
   TEMP t68))
L162
jal readlist
addi 71, r0, 4
sub 70, FP, 71
add 65, 70, r0
jal getchar
add 64, 72, r0
sw 65, 0(64)
addi 73, r0, 0
add 63, 73, r0
jal readlist
add 62, 74, r0
addi 76, r0, 4
sub 75, FP, 76
add 67, 75, r0
jal getchar
add 66, 77, r0
sw 67, 0(66)
add 69, FP, r0
jal merge
add 68, 78, r0
jal printlist
lw 79, L161
j 79
L161
MOVE(
 TEMP t2,
 ESEQ(
  SEQ(
   CJUMP(LT,
    TEMP t60,
    CONST 0,
    L158,L159),
   SEQ(
    LABEL L158,
    SEQ(
     MOVE(
      TEMP t61,
      CALL(
       NAME print,
        NAME L156)),
     SEQ(
      JUMP(
       NAME L160),
      SEQ(
       LABEL L159,
       SEQ(
        MOVE(
         TEMP t61,
         ESEQ(
          EXP(
           CALL(
            NAME printlist,
             TEMP t1,
             MEM(
              BINOP(PLUS,
               TEMP t60,
               CONST 4)))),
          ESEQ(
           EXP(
            CALL(
             NAME print,
              NAME L157)),
           CALL(
            NAME printint,
             TEMP t1,
             MEM(
              BINOP(PLUS,
               TEMP t60,
               CONST 0)))))),
        LABEL L160)))))),
  CONST 0))
CJUMP(LT,
 TEMP t60,
 CONST 0,
 L158,L159)
LABEL L158
MOVE(
 TEMP t61,
 CALL(
  NAME print,
   NAME L156))
JUMP(
 NAME L160)
LABEL L159
EXP(
 CALL(
  NAME printlist,
   TEMP t1,
   MEM(
    BINOP(PLUS,
     TEMP t60,
     CONST 4))))
EXP(
 CALL(
  NAME print,
   NAME L157))
MOVE(
 TEMP t61,
 CALL(
  NAME printint,
   TEMP t1,
   MEM(
    BINOP(PLUS,
     TEMP t60,
     CONST 0))))
LABEL L160
MOVE(
 TEMP t2,
 CONST 0)
L164
addi 80, r0, 0
blt 60, 80, L158
L159
addi 82, 60, 4
la 81, 0(82)
jal printlist
lw 83, L157
jal print
addi 86, 60, 0
la 85, 0(86)
jal printint
add 61, 84, r0
L160
addi 87, r0, 0
add RV, 87, r0
lw 88, L163
j 88
L158
lw 90, L156
jal print
add 61, 89, r0
lw 91, L160
j 91
L163
L157: .asciiz "" ""
L156: .asciiz ""\n""
MOVE(
 TEMP t2,
 ESEQ(
  EXP(
   CONST 0),
  ESEQ(
   SEQ(
    CJUMP(LT,
     TEMP t54,
     CONST 0,
     L153,L154),
    SEQ(
     LABEL L153,
     SEQ(
      MOVE(
       TEMP t59,
       ESEQ(
        EXP(
         CALL(
          NAME f,
           TEMP t1,
           BINOP(MINUS,
            CONST 0,
            TEMP t54))),
        CALL(
         NAME print,
          NAME L148))),
      SEQ(
       JUMP(
        NAME L155),
       SEQ(
        LABEL L154,
        SEQ(
         MOVE(
          TEMP t59,
          ESEQ(
           SEQ(
            CJUMP(LT,
             TEMP t54,
             CONST 0,
             L150,L151),
            SEQ(
             LABEL L150,
             SEQ(
              MOVE(
               TEMP t58,
               CALL(
                NAME f,
                 TEMP t1,
                 TEMP t54)),
              SEQ(
               JUMP(
                NAME L152),
               SEQ(
                LABEL L151,
                SEQ(
                 MOVE(
                  TEMP t58,
                  CALL(
                   NAME print,
                    NAME L149)),
                 LABEL L152)))))),
           CONST 0)),
         LABEL L155)))))),
   CONST 0)))
CJUMP(LT,
 TEMP t54,
 CONST 0,
 L153,L154)
LABEL L153
EXP(
 CALL(
  NAME f,
   TEMP t1,
   BINOP(MINUS,
    CONST 0,
    TEMP t54)))
MOVE(
 TEMP t59,
 CALL(
  NAME print,
   NAME L148))
JUMP(
 NAME L155)
LABEL L154
CJUMP(LT,
 TEMP t54,
 CONST 0,
 L150,L151)
LABEL L150
MOVE(
 TEMP t58,
 CALL(
  NAME f,
   TEMP t1,
   TEMP t54))
JUMP(
 NAME L152)
LABEL L151
MOVE(
 TEMP t58,
 CALL(
  NAME print,
   NAME L149))
LABEL L152
MOVE(
 TEMP t59,
 CONST 0)
LABEL L155
MOVE(
 TEMP t2,
 CONST 0)
L166
addi 92, r0, 0
blt 54, 92, L153
L154
addi 93, r0, 0
blt 54, 93, L150
L151
lw 95, L149
jal print
add 58, 94, r0
L152
addi 96, r0, 0
add 59, 96, r0
L155
addi 97, r0, 0
add RV, 97, r0
lw 98, L165
j 98
L153
addi 100, r0, 0
sub 99, 100, 54
jal f
lw 102, L148
jal print
add 59, 101, r0
lw 103, L155
j 103
L150
jal f
add 58, 104, r0
lw 105, L152
j 105
L165
L149: .asciiz ""0""
L148: .asciiz ""-""
MOVE(
 TEMP t2,
 ESEQ(
  SEQ(
   CJUMP(LT,
    TEMP t56,
    CONST 0,
    L146,L147),
   SEQ(
    LABEL L146,
    SEQ(
     MOVE(
      TEMP t57,
      ESEQ(
       EXP(
        CALL(
         NAME print,
          CALL(
           NAME chr,
            BINOP(PLUS,
             BINOP(MINUS,
              TEMP t56,
              BINOP(MUL,
               BINOP(DIV,
                TEMP t56,
                CONST 10),
               CONST 10)),
             CALL(
              NAME ord,
               NAME L145))))),
       CALL(
        NAME f,
         TEMP t1,
         BINOP(DIV,
          TEMP t56,
          CONST 10)))),
     LABEL L147))),
  CONST 0))
CJUMP(LT,
 TEMP t56,
 CONST 0,
 L146,L147)
LABEL L146
MOVE(
 TEMP t108,
 BINOP(MINUS,
  TEMP t56,
  BINOP(MUL,
   BINOP(DIV,
    TEMP t56,
    CONST 10),
   CONST 10)))
MOVE(
 TEMP t107,
 CALL(
  NAME ord,
   NAME L145))
MOVE(
 TEMP t106,
 CALL(
  NAME chr,
   BINOP(PLUS,
    TEMP t108,
    TEMP t107)))
EXP(
 CALL(
  NAME print,
   TEMP t106))
MOVE(
 TEMP t57,
 CALL(
  NAME f,
   TEMP t1,
   BINOP(DIV,
    TEMP t56,
    CONST 10)))
LABEL L147
MOVE(
 TEMP t2,
 CONST 0)
L168
addi 109, r0, 0
blt 56, 109, L146
L147
addi 110, r0, 0
add RV, 110, r0
lw 111, L167
j 111
L146
addi 115, r0, 10
div 56, 115
mflo 114
addi 116, r0, 10
mul 113, 114, 116
sub 112, 56, 113
add 108, 112, r0
lw 118, L145
jal ord
add 107, 117, r0
add 120, 108, 's1
jal chr
add 106, 119, r0
jal print
addi 123, r0, 10
div 56, 123
mflo 122
jal f
add 57, 121, r0
lw 124, L147
j 124
L167
L145: .asciiz ""0""
MOVE(
 TEMP t2,
 ESEQ(
  SEQ(
   CJUMP(LT,
    TEMP t47,
    CONST 0,
    L142,L143),
   SEQ(
    LABEL L142,
    SEQ(
     MOVE(
      TEMP t53,
      TEMP t48),
     SEQ(
      JUMP(
       NAME L144),
      SEQ(
       LABEL L143,
       SEQ(
        MOVE(
         TEMP t53,
         ESEQ(
          SEQ(
           CJUMP(LT,
            TEMP t48,
            CONST 0,
            L139,L140),
           SEQ(
            LABEL L139,
            SEQ(
             MOVE(
              TEMP t52,
              TEMP t47),
             SEQ(
              JUMP(
               NAME L141),
              SEQ(
               LABEL L140,
               SEQ(
                MOVE(
                 TEMP t52,
                 ESEQ(
                  SEQ(
                   CJUMP(LT,
                    MEM(
                     BINOP(PLUS,
                      TEMP t47,
                      CONST 0)),
                    MEM(
                     BINOP(PLUS,
                      TEMP t48,
                      CONST 0)),
                    L136,L137),
                   SEQ(
                    LABEL L136,
                    SEQ(
                     MOVE(
                      TEMP t51,
                      ESEQ(
                       SEQ(
                        MOVE(
                         TEMP t49,
                         CALL(
                          NAME allocRecord,
                           CONST 8)),
                        SEQ(
                         MOVE(
                          MEM(
                           BINOP(PLUS,
                            TEMP t49,
                            CONST 0)),
                          MEM(
                           BINOP(PLUS,
                            TEMP t47,
                            CONST 0))),
                         MOVE(
                          MEM(
                           BINOP(PLUS,
                            TEMP t49,
                            CONST 4)),
                          CALL(
                           NAME merge,
                            TEMP t1,
                            MEM(
                             BINOP(PLUS,
                              TEMP t47,
                              CONST 4)),
                            TEMP t48)))),
                       TEMP t49)),
                     SEQ(
                      JUMP(
                       NAME L138),
                      SEQ(
                       LABEL L137,
                       SEQ(
                        MOVE(
                         TEMP t51,
                         ESEQ(
                          SEQ(
                           MOVE(
                            TEMP t50,
                            CALL(
                             NAME allocRecord,
                              CONST 8)),
                           SEQ(
                            MOVE(
                             MEM(
                              BINOP(PLUS,
                               TEMP t50,
                               CONST 0)),
                             MEM(
                              BINOP(PLUS,
                               TEMP t48,
                               CONST 0))),
                            MOVE(
                             MEM(
                              BINOP(PLUS,
                               TEMP t50,
                               CONST 4)),
                             CALL(
                              NAME merge,
                               TEMP t1,
                               TEMP t47,
                               MEM(
                                BINOP(PLUS,
                                 TEMP t48,
                                 CONST 4)))))),
                          TEMP t50)),
                        LABEL L138)))))),
                  CONST 0)),
                LABEL L141)))))),
          CONST 0)),
        LABEL L144)))))),
  CONST 0))
CJUMP(LT,
 TEMP t47,
 CONST 0,
 L142,L143)
LABEL L142
MOVE(
 TEMP t53,
 TEMP t48)
JUMP(
 NAME L144)
LABEL L143
CJUMP(LT,
 TEMP t48,
 CONST 0,
 L139,L140)
LABEL L139
MOVE(
 TEMP t52,
 TEMP t47)
JUMP(
 NAME L141)
LABEL L140
CJUMP(LT,
 MEM(
  BINOP(PLUS,
   TEMP t47,
   CONST 0)),
 MEM(
  BINOP(PLUS,
   TEMP t48,
   CONST 0)),
 L136,L137)
LABEL L136
MOVE(
 TEMP t49,
 CALL(
  NAME allocRecord,
   CONST 8))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t49,
   CONST 0)),
 MEM(
  BINOP(PLUS,
   TEMP t47,
   CONST 0)))
MOVE(
 TEMP t126,
 BINOP(PLUS,
  TEMP t49,
  CONST 4))
MOVE(
 TEMP t125,
 CALL(
  NAME merge,
   TEMP t1,
   MEM(
    BINOP(PLUS,
     TEMP t47,
     CONST 4)),
   TEMP t48))
MOVE(
 MEM(
  TEMP t126),
 TEMP t125)
MOVE(
 TEMP t51,
 TEMP t49)
JUMP(
 NAME L138)
LABEL L137
MOVE(
 TEMP t50,
 CALL(
  NAME allocRecord,
   CONST 8))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t50,
   CONST 0)),
 MEM(
  BINOP(PLUS,
   TEMP t48,
   CONST 0)))
MOVE(
 TEMP t128,
 BINOP(PLUS,
  TEMP t50,
  CONST 4))
MOVE(
 TEMP t127,
 CALL(
  NAME merge,
   TEMP t1,
   TEMP t47,
   MEM(
    BINOP(PLUS,
     TEMP t48,
     CONST 4))))
MOVE(
 MEM(
  TEMP t128),
 TEMP t127)
MOVE(
 TEMP t51,
 TEMP t50)
LABEL L138
MOVE(
 TEMP t52,
 CONST 0)
LABEL L141
MOVE(
 TEMP t53,
 CONST 0)
LABEL L144
MOVE(
 TEMP t2,
 CONST 0)
L170
addi 129, r0, 0
blt 47, 129, L142
L143
addi 130, r0, 0
blt 48, 130, L139
L140
addi 132, 47, 0
la 131, 0(132)
addi 134, 48, 0
la 133, 0(134)
blt 131, 133, L136
L137
addi 136, r0, 8
jal allocRecord
add 50, 135, r0
addi 137, 50, 0
addi 139, 48, 0
la 138, 0(139)
sw 137, 0(138)
addi 140, 50, 4
add 128, 140, r0
addi 143, 48, 4
la 142, 0(143)
jal merge
add 127, 141, r0
sw 128, 0(127)
add 51, 50, r0
L138
addi 144, r0, 0
add 52, 144, r0
L141
addi 145, r0, 0
add 53, 145, r0
L144
addi 146, r0, 0
add RV, 146, r0
lw 147, L169
j 147
L142
add 53, 48, r0
lw 148, L144
j 148
L139
add 52, 47, r0
lw 149, L141
j 149
L136
addi 151, r0, 8
jal allocRecord
add 49, 150, r0
addi 152, 49, 0
addi 154, 47, 0
la 153, 0(154)
sw 152, 0(153)
addi 155, 49, 4
add 126, 155, r0
addi 158, 47, 4
la 157, 0(158)
jal merge
add 125, 156, r0
sw 126, 0(125)
add 51, 49, r0
lw 159, L138
j 159
L169
MOVE(
 TEMP t2,
 ESEQ(
  SEQ(
   MOVE(
    TEMP t44,
    CALL(
     NAME readint,
      TEMP t1,
      TEMP t43)),
   MOVE(
    TEMP t43,
    ESEQ(
     SEQ(
      MOVE(
       TEMP t42,
       CALL(
        NAME allocRecord,
         CONST 4)),
      MOVE(
       MEM(
        BINOP(PLUS,
         TEMP t42,
         CONST 0)),
       CONST 0)),
     TEMP t42))),
  ESEQ(
   SEQ(
    CJUMP(NE,
     MEM(
      BINOP(PLUS,
       TEMP t43,
       CONST 0)),
     CONST 0,
     L133,L134),
    SEQ(
     LABEL L133,
     SEQ(
      MOVE(
       TEMP t46,
       ESEQ(
        SEQ(
         MOVE(
          TEMP t45,
          CALL(
           NAME allocRecord,
            CONST 8)),
         SEQ(
          MOVE(
           MEM(
            BINOP(PLUS,
             TEMP t45,
             CONST 0)),
           TEMP t44),
          MOVE(
           MEM(
            BINOP(PLUS,
             TEMP t45,
             CONST 4)),
           CALL(
            NAME readlist,
             TEMP t1)))),
        TEMP t45)),
      SEQ(
       JUMP(
        NAME L135),
       SEQ(
        LABEL L134,
        SEQ(
         MOVE(
          TEMP t46,
          CONST 0),
         LABEL L135)))))),
   CONST 0)))
MOVE(
 TEMP t44,
 CALL(
  NAME readint,
   TEMP t1,
   TEMP t43))
MOVE(
 TEMP t42,
 CALL(
  NAME allocRecord,
   CONST 4))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t42,
   CONST 0)),
 CONST 0)
MOVE(
 TEMP t43,
 TEMP t42)
CJUMP(NE,
 MEM(
  BINOP(PLUS,
   TEMP t43,
   CONST 0)),
 CONST 0,
 L133,L134)
LABEL L133
MOVE(
 TEMP t45,
 CALL(
  NAME allocRecord,
   CONST 8))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t45,
   CONST 0)),
 TEMP t44)
MOVE(
 TEMP t161,
 BINOP(PLUS,
  TEMP t45,
  CONST 4))
MOVE(
 TEMP t160,
 CALL(
  NAME readlist,
   TEMP t1))
MOVE(
 MEM(
  TEMP t161),
 TEMP t160)
MOVE(
 TEMP t46,
 TEMP t45)
JUMP(
 NAME L135)
LABEL L134
MOVE(
 TEMP t46,
 CONST 0)
LABEL L135
MOVE(
 TEMP t2,
 CONST 0)
L172
jal readint
add 44, 162, r0
addi 164, r0, 4
jal allocRecord
add 42, 163, r0
addi 165, 42, 0
addi 166, r0, 0
sw 165, 0(166)
add 43, 42, r0
addi 168, 43, 0
la 167, 0(168)
addi 169, r0, 0
bne 167, 169, L133
L134
addi 170, r0, 0
add 46, 170, r0
L135
addi 171, r0, 0
add RV, 171, r0
lw 172, L171
j 172
L133
addi 174, r0, 8
jal allocRecord
add 45, 173, r0
addi 175, 45, 0
sw 175, 0(44)
addi 176, 45, 4
add 161, 176, r0
jal readlist
add 160, 177, r0
sw 161, 0(160)
add 46, 45, r0
lw 178, L135
j 178
L171
MOVE(
 TEMP t2,
 ESEQ(
  MOVE(
   TEMP t29,
   CONST 0),
  ESEQ(
   EXP(
    TEMP t29),
   ESEQ(
    EXP(
     ESEQ(
      SEQ(
       JUMP(
        NAME L131),
       SEQ(
        LABEL L132,
        SEQ(
         MOVE(
          TEMP t37,
          ESEQ(
           MOVE(
            MEM(
             BINOP(MINUS,
              TEMP t1,
              CONST 4)),
            CALL(
             NAME getchar)),
           ESEQ(
            MOVE(
             TEMP t29,
             BINOP(MINUS,
              BINOP(PLUS,
               BINOP(MUL,
                TEMP t29,
                CONST 10),
               CALL(
                NAME ord,
                 MEM(
                  BINOP(MINUS,
                   TEMP t1,
                   CONST 4)))),
              CALL(
               NAME ord,
                NAME L130))),
            CONST 0))),
         SEQ(
          LABEL L131,
          SEQ(
           CJUMP(NE,
            CALL(
             NAME isdigit,
              TEMP t1,
              MEM(
               BINOP(MINUS,
                TEMP t1,
                CONST 4))),
            CONST 0,
            L132,L129),
           LABEL L129))))),
      CONST 0)),
    ESEQ(
     MOVE(
      MEM(
       BINOP(PLUS,
        TEMP t28,
        CONST 0)),
      CALL(
       NAME isdigit,
        TEMP t1,
        MEM(
         BINOP(MINUS,
          TEMP t1,
          CONST 4)))),
     CALL(
      NAME skipto,
       TEMP t1))))))
MOVE(
 TEMP t29,
 CONST 0)
EXP(
 TEMP t29)
JUMP(
 NAME L131)
LABEL L132
MOVE(
 TEMP t180,
 BINOP(MINUS,
  TEMP t1,
  CONST 4))
MOVE(
 TEMP t179,
 CALL(
  NAME getchar))
MOVE(
 MEM(
  TEMP t180),
 TEMP t179)
MOVE(
 TEMP t182,
 BINOP(MUL,
  TEMP t29,
  CONST 10))
MOVE(
 TEMP t181,
 CALL(
  NAME ord,
   MEM(
    BINOP(MINUS,
     TEMP t1,
     CONST 4))))
MOVE(
 TEMP t184,
 BINOP(PLUS,
  TEMP t182,
  TEMP t181))
MOVE(
 TEMP t183,
 CALL(
  NAME ord,
   NAME L130))
MOVE(
 TEMP t29,
 BINOP(MINUS,
  TEMP t184,
  TEMP t183))
MOVE(
 TEMP t37,
 CONST 0)
LABEL L131
MOVE(
 TEMP t185,
 CALL(
  NAME isdigit,
   TEMP t1,
   MEM(
    BINOP(MINUS,
     TEMP t1,
     CONST 4))))
CJUMP(NE,
 TEMP t185,
 CONST 0,
 L132,L129)
LABEL L129
MOVE(
 TEMP t187,
 BINOP(PLUS,
  TEMP t28,
  CONST 0))
MOVE(
 TEMP t186,
 CALL(
  NAME isdigit,
   TEMP t1,
   MEM(
    BINOP(MINUS,
     TEMP t1,
     CONST 4))))
MOVE(
 MEM(
  TEMP t187),
 TEMP t186)
MOVE(
 TEMP t2,
 CALL(
  NAME skipto,
   TEMP t1))
L174
addi 188, r0, 0
add 29, 188, r0
L131
addi 192, r0, 4
sub 191, FP, 192
la 190, 0(191)
jal isdigit
add 185, 189, r0
addi 193, r0, 0
bne 185, 193, L132
L129
addi 194, 28, 0
add 187, 194, r0
addi 198, r0, 4
sub 197, FP, 198
la 196, 0(197)
jal isdigit
add 186, 195, r0
sw 187, 0(186)
jal skipto
add RV, 199, r0
lw 200, L173
j 200
L132
addi 202, r0, 4
sub 201, FP, 202
add 180, 201, r0
jal getchar
add 179, 203, r0
sw 180, 0(179)
addi 205, r0, 10
mul 204, 29, 205
add 182, 204, r0
addi 209, r0, 4
sub 208, FP, 209
la 207, 0(208)
jal ord
add 181, 206, r0
add 210, 182, 's1
add 184, 210, r0
lw 212, L130
jal ord
add 183, 211, r0
sub 213, 184, 183
add 29, 213, r0
addi 214, r0, 0
add 37, 214, r0
lw 215, L131
j 215
L173
L130: .asciiz ""0""
MOVE(
 TEMP t2,
 ESEQ(
  SEQ(
   JUMP(
    NAME L127),
   SEQ(
    LABEL L128,
    SEQ(
     MOVE(
      TEMP t36,
      ESEQ(
       MOVE(
        MEM(
         BINOP(MINUS,
          TEMP t1,
          CONST 4)),
        CALL(
         NAME getchar)),
       CONST 0)),
     SEQ(
      LABEL L127,
      SEQ(
       CJUMP(NE,
        ESEQ(
         SEQ(
          CJUMP(NE,
           CALL(
            NAME stringCompare,
             MEM(
              BINOP(MINUS,
               TEMP t1,
               CONST 4)),
             NAME L121),
           CONST 0,
           L122,L123),
          SEQ(
           LABEL L122,
           SEQ(
            MOVE(
             TEMP t34,
             CONST 1),
            SEQ(
             JUMP(
              NAME L124),
             SEQ(
              LABEL L123,
              SEQ(
               MOVE(
                TEMP t34,
                ESEQ(
                 SEQ(
                  MOVE(
                   TEMP t35,
                   CONST 1),
                  SEQ(
                   CJUMP(NE,
                    CALL(
                     NAME stringCompare,
                      MEM(
                       BINOP(MINUS,
                        TEMP t1,
                        CONST 4)),
                      NAME L120),
                    CONST 0,
                    L125,L126),
                   SEQ(
                    LABEL L126,
                    SEQ(
                     MOVE(
                      TEMP t35,
                      CONST 0),
                     LABEL L125)))),
                 TEMP t35)),
               LABEL L124)))))),
         CONST 0),
        CONST 0,
        L128,L119),
       LABEL L119))))),
  CONST 0))
JUMP(
 NAME L127)
LABEL L128
MOVE(
 TEMP t217,
 BINOP(MINUS,
  TEMP t1,
  CONST 4))
MOVE(
 TEMP t216,
 CALL(
  NAME getchar))
MOVE(
 MEM(
  TEMP t217),
 TEMP t216)
MOVE(
 TEMP t36,
 CONST 0)
LABEL L127
MOVE(
 TEMP t218,
 CALL(
  NAME stringCompare,
   MEM(
    BINOP(MINUS,
     TEMP t1,
     CONST 4)),
   NAME L121))
CJUMP(NE,
 TEMP t218,
 CONST 0,
 L122,L123)
LABEL L122
MOVE(
 TEMP t34,
 CONST 1)
JUMP(
 NAME L124)
LABEL L123
MOVE(
 TEMP t35,
 CONST 1)
MOVE(
 TEMP t219,
 CALL(
  NAME stringCompare,
   MEM(
    BINOP(MINUS,
     TEMP t1,
     CONST 4)),
   NAME L120))
CJUMP(NE,
 TEMP t219,
 CONST 0,
 L125,L126)
LABEL L126
MOVE(
 TEMP t35,
 CONST 0)
LABEL L125
MOVE(
 TEMP t34,
 TEMP t35)
LABEL L124
CJUMP(NE,
 CONST 0,
 CONST 0,
 L128,L119)
LABEL L119
MOVE(
 TEMP t2,
 CONST 0)
L176
L127
addi 223, r0, 4
sub 222, FP, 223
la 221, 0(222)
lw 224, L121
jal stringCompare
add 218, 220, r0
addi 225, r0, 0
bne 218, 225, L122
L123
addi 226, r0, 1
add 35, 226, r0
addi 230, r0, 4
sub 229, FP, 230
la 228, 0(229)
lw 231, L120
jal stringCompare
add 219, 227, r0
addi 232, r0, 0
bne 219, 232, L125
L126
addi 233, r0, 0
add 35, 233, r0
L125
add 34, 35, r0
L124
addi 234, r0, 0
addi 235, r0, 0
bne 234, 235, L128
L119
addi 236, r0, 0
add RV, 236, r0
lw 237, L175
j 237
L128
addi 239, r0, 4
sub 238, FP, 239
add 217, 238, r0
jal getchar
add 216, 240, r0
sw 217, 0(216)
addi 241, r0, 0
add 36, 241, r0
lw 242, L127
j 242
L122
addi 243, r0, 1
add 34, 243, r0
lw 244, L124
j 244
L175
L121: .asciiz "" ""
L120: .asciiz ""\n""
MOVE(
 TEMP t2,
 ESEQ(
  SEQ(
   CJUMP(LT,
    CALL(
     NAME ord,
      MEM(
       BINOP(MINUS,
        TEMP t1,
        CONST 4))),
    CALL(
     NAME ord,
      NAME L113),
    L114,L115),
   SEQ(
    LABEL L114,
    SEQ(
     MOVE(
      TEMP t32,
      ESEQ(
       SEQ(
        MOVE(
         TEMP t33,
         CONST 1),
        SEQ(
         CJUMP(LT,
          CALL(
           NAME ord,
            MEM(
             BINOP(MINUS,
              TEMP t1,
              CONST 4))),
          CALL(
           NAME ord,
            NAME L112),
          L117,L118),
         SEQ(
          LABEL L118,
          SEQ(
           MOVE(
            TEMP t33,
            CONST 0),
           LABEL L117)))),
       TEMP t33)),
     SEQ(
      JUMP(
       NAME L116),
      SEQ(
       LABEL L115,
       SEQ(
        MOVE(
         TEMP t32,
         CONST 0),
        LABEL L116)))))),
  CONST 0))
MOVE(
 TEMP t245,
 CALL(
  NAME ord,
   MEM(
    BINOP(MINUS,
     TEMP t1,
     CONST 4))))
MOVE(
 TEMP t247,
 TEMP t245)
MOVE(
 TEMP t246,
 CALL(
  NAME ord,
   NAME L113))
CJUMP(LT,
 TEMP t247,
 TEMP t246,
 L114,L115)
LABEL L114
MOVE(
 TEMP t33,
 CONST 1)
MOVE(
 TEMP t248,
 CALL(
  NAME ord,
   MEM(
    BINOP(MINUS,
     TEMP t1,
     CONST 4))))
MOVE(
 TEMP t250,
 TEMP t248)
MOVE(
 TEMP t249,
 CALL(
  NAME ord,
   NAME L112))
CJUMP(LT,
 TEMP t250,
 TEMP t249,
 L117,L118)
LABEL L118
MOVE(
 TEMP t33,
 CONST 0)
LABEL L117
MOVE(
 TEMP t32,
 TEMP t33)
JUMP(
 NAME L116)
LABEL L115
MOVE(
 TEMP t32,
 CONST 0)
LABEL L116
MOVE(
 TEMP t2,
 CONST 0)
L178
addi 254, r0, 4
sub 253, FP, 254
la 252, 0(253)
jal ord
add 245, 251, r0
add 247, 245, r0
lw 256, L113
jal ord
add 246, 255, r0
blt 247, 246, L114
L115
addi 257, r0, 0
add 32, 257, r0
L116
addi 258, r0, 0
add RV, 258, r0
lw 259, L177
j 259
L114
addi 260, r0, 1
add 33, 260, r0
addi 264, r0, 4
sub 263, FP, 264
la 262, 0(263)
jal ord
add 248, 261, r0
add 250, 248, r0
lw 266, L112
jal ord
add 249, 265, r0
blt 250, 249, L117
L118
addi 267, r0, 0
add 33, 267, r0
L117
add 32, 33, r0
lw 268, L116
j 268
L177
L113: .asciiz ""0""
L112: .asciiz ""9""
