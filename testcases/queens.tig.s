EXP(
 ESEQ(
  SEQ(
   MOVE(
    MEM(
     BINOP(MINUS,
      TEMP t1,
      CONST 20)),
    ESEQ(
     MOVE(
      TEMP t30,
      CALL(
       NAME initArray,
        BINOP(MINUS,
         BINOP(PLUS,
          MEM(
           BINOP(MINUS,
            TEMP t1,
            CONST 4)),
          MEM(
           BINOP(MINUS,
            TEMP t1,
            CONST 4))),
         CONST 1),
        CONST 0)),
     TEMP t30)),
   SEQ(
    MOVE(
     MEM(
      BINOP(MINUS,
       TEMP t1,
       CONST 16)),
     ESEQ(
      MOVE(
       TEMP t29,
       CALL(
        NAME initArray,
         BINOP(MINUS,
          BINOP(PLUS,
           MEM(
            BINOP(MINUS,
             TEMP t1,
             CONST 4)),
           MEM(
            BINOP(MINUS,
             TEMP t1,
             CONST 4))),
          CONST 1),
         CONST 0)),
      TEMP t29)),
    SEQ(
     MOVE(
      MEM(
       BINOP(MINUS,
        TEMP t1,
        CONST 12)),
      ESEQ(
       MOVE(
        TEMP t28,
        CALL(
         NAME initArray,
          MEM(
           BINOP(MINUS,
            TEMP t1,
            CONST 4)),
          CONST 0)),
       TEMP t28)),
     SEQ(
      MOVE(
       MEM(
        BINOP(MINUS,
         TEMP t1,
         CONST 8)),
       ESEQ(
        MOVE(
         TEMP t27,
         CALL(
          NAME initArray,
           MEM(
            BINOP(MINUS,
             TEMP t1,
             CONST 4)),
           CONST 0)),
        TEMP t27)),
      MOVE(
       MEM(
        BINOP(MINUS,
         TEMP t1,
         CONST 4)),
       CONST 8))))),
  CALL(
   NAME try,
    TEMP t1,
    CONST 0)))
MOVE(
 TEMP t52,
 BINOP(MINUS,
  TEMP t1,
  CONST 20))
MOVE(
 TEMP t30,
 CALL(
  NAME initArray,
   BINOP(MINUS,
    BINOP(PLUS,
     MEM(
      BINOP(MINUS,
       TEMP t1,
       CONST 4)),
     MEM(
      BINOP(MINUS,
       TEMP t1,
       CONST 4))),
    CONST 1),
   CONST 0))
MOVE(
 MEM(
  TEMP t52),
 TEMP t30)
MOVE(
 TEMP t53,
 BINOP(MINUS,
  TEMP t1,
  CONST 16))
MOVE(
 TEMP t29,
 CALL(
  NAME initArray,
   BINOP(MINUS,
    BINOP(PLUS,
     MEM(
      BINOP(MINUS,
       TEMP t1,
       CONST 4)),
     MEM(
      BINOP(MINUS,
       TEMP t1,
       CONST 4))),
    CONST 1),
   CONST 0))
MOVE(
 MEM(
  TEMP t53),
 TEMP t29)
MOVE(
 TEMP t54,
 BINOP(MINUS,
  TEMP t1,
  CONST 12))
MOVE(
 TEMP t28,
 CALL(
  NAME initArray,
   MEM(
    BINOP(MINUS,
     TEMP t1,
     CONST 4)),
   CONST 0))
MOVE(
 MEM(
  TEMP t54),
 TEMP t28)
MOVE(
 TEMP t55,
 BINOP(MINUS,
  TEMP t1,
  CONST 8))
MOVE(
 TEMP t27,
 CALL(
  NAME initArray,
   MEM(
    BINOP(MINUS,
     TEMP t1,
     CONST 4)),
   CONST 0))
MOVE(
 MEM(
  TEMP t55),
 TEMP t27)
MOVE(
 MEM(
  BINOP(MINUS,
   TEMP t1,
   CONST 4)),
 CONST 8)
EXP(
 CALL(
  NAME try,
   TEMP t1,
   CONST 0))
