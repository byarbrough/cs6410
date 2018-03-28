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
      TEMP t6,
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
     TEMP t6)),
   SEQ(
    MOVE(
     MEM(
      BINOP(MINUS,
       TEMP t1,
       CONST 16)),
     ESEQ(
      MOVE(
       TEMP t5,
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
      TEMP t5)),
    SEQ(
     MOVE(
      MEM(
       BINOP(MINUS,
        TEMP t1,
        CONST 12)),
      ESEQ(
       MOVE(
        TEMP t4,
        CALL(
         NAME initArray,
          MEM(
           BINOP(MINUS,
            TEMP t1,
            CONST 4)),
          CONST 0)),
       TEMP t4)),
     SEQ(
      MOVE(
       MEM(
        BINOP(MINUS,
         TEMP t1,
         CONST 8)),
       ESEQ(
        MOVE(
         TEMP t3,
         CALL(
          NAME initArray,
           MEM(
            BINOP(MINUS,
             TEMP t1,
             CONST 4)),
           CONST 0)),
        TEMP t3)),
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
 TEMP t28,
 BINOP(MINUS,
  TEMP t1,
  CONST 20))
MOVE(
 TEMP t6,
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
  TEMP t28),
 TEMP t6)
MOVE(
 TEMP t29,
 BINOP(MINUS,
  TEMP t1,
  CONST 16))
MOVE(
 TEMP t5,
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
  TEMP t29),
 TEMP t5)
MOVE(
 TEMP t30,
 BINOP(MINUS,
  TEMP t1,
  CONST 12))
MOVE(
 TEMP t4,
 CALL(
  NAME initArray,
   MEM(
    BINOP(MINUS,
     TEMP t1,
     CONST 4)),
   CONST 0))
MOVE(
 MEM(
  TEMP t30),
 TEMP t4)
MOVE(
 TEMP t31,
 BINOP(MINUS,
  TEMP t1,
  CONST 8))
MOVE(
 TEMP t3,
 CALL(
  NAME initArray,
   MEM(
    BINOP(MINUS,
     TEMP t1,
     CONST 4)),
   CONST 0))
MOVE(
 MEM(
  TEMP t31),
 TEMP t3)
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
