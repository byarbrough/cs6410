functor TigerLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : Tiger_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct
open Symbol

end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\000\000\000\000\
\\001\000\001\000\173\000\005\000\173\000\007\000\173\000\009\000\173\000\
\\011\000\173\000\013\000\173\000\015\000\038\000\016\000\037\000\
\\017\000\036\000\018\000\035\000\025\000\173\000\026\000\173\000\
\\030\000\173\000\031\000\173\000\034\000\173\000\035\000\173\000\
\\037\000\173\000\038\000\173\000\042\000\173\000\043\000\173\000\
\\044\000\173\000\000\000\
\\001\000\001\000\174\000\005\000\174\000\007\000\174\000\009\000\174\000\
\\011\000\174\000\013\000\174\000\015\000\038\000\016\000\037\000\
\\017\000\036\000\018\000\035\000\025\000\174\000\026\000\174\000\
\\030\000\174\000\031\000\174\000\034\000\174\000\035\000\174\000\
\\037\000\174\000\038\000\174\000\042\000\174\000\043\000\174\000\
\\044\000\174\000\000\000\
\\001\000\001\000\175\000\005\000\175\000\007\000\175\000\009\000\175\000\
\\011\000\175\000\013\000\175\000\015\000\038\000\016\000\037\000\
\\017\000\036\000\018\000\035\000\025\000\175\000\026\000\175\000\
\\030\000\175\000\031\000\175\000\034\000\175\000\035\000\175\000\
\\037\000\175\000\038\000\175\000\042\000\175\000\043\000\175\000\
\\044\000\175\000\000\000\
\\001\000\001\000\176\000\005\000\176\000\007\000\176\000\009\000\176\000\
\\011\000\176\000\013\000\176\000\015\000\038\000\016\000\037\000\
\\017\000\036\000\018\000\035\000\025\000\176\000\026\000\176\000\
\\030\000\176\000\031\000\176\000\034\000\176\000\035\000\176\000\
\\037\000\176\000\038\000\176\000\042\000\176\000\043\000\176\000\
\\044\000\176\000\000\000\
\\001\000\001\000\177\000\005\000\177\000\007\000\177\000\009\000\177\000\
\\011\000\177\000\013\000\177\000\015\000\038\000\016\000\037\000\
\\017\000\036\000\018\000\035\000\025\000\177\000\026\000\177\000\
\\030\000\177\000\031\000\177\000\034\000\177\000\035\000\177\000\
\\037\000\177\000\038\000\177\000\042\000\177\000\043\000\177\000\
\\044\000\177\000\000\000\
\\001\000\001\000\178\000\005\000\178\000\007\000\178\000\009\000\178\000\
\\011\000\178\000\013\000\178\000\015\000\038\000\016\000\037\000\
\\017\000\036\000\018\000\035\000\025\000\178\000\026\000\178\000\
\\030\000\178\000\031\000\178\000\034\000\178\000\035\000\178\000\
\\037\000\178\000\038\000\178\000\042\000\178\000\043\000\178\000\
\\044\000\178\000\000\000\
\\001\000\002\000\023\000\003\000\022\000\004\000\021\000\008\000\020\000\
\\016\000\019\000\029\000\018\000\032\000\017\000\033\000\016\000\
\\036\000\015\000\040\000\014\000\041\000\013\000\000\000\
\\001\000\002\000\047\000\000\000\
\\001\000\002\000\057\000\000\000\
\\001\000\002\000\073\000\000\000\
\\001\000\002\000\074\000\000\000\
\\001\000\002\000\075\000\000\000\
\\001\000\002\000\082\000\000\000\
\\001\000\002\000\105\000\012\000\104\000\028\000\103\000\000\000\
\\001\000\002\000\107\000\000\000\
\\001\000\002\000\127\000\000\000\
\\001\000\002\000\132\000\000\000\
\\001\000\002\000\135\000\000\000\
\\001\000\002\000\137\000\000\000\
\\001\000\002\000\143\000\000\000\
\\001\000\002\000\148\000\000\000\
\\001\000\006\000\090\000\027\000\089\000\000\000\
\\001\000\006\000\120\000\000\000\
\\001\000\006\000\131\000\019\000\130\000\000\000\
\\001\000\006\000\146\000\000\000\
\\001\000\008\000\091\000\000\000\
\\001\000\009\000\079\000\000\000\
\\001\000\009\000\098\000\000\000\
\\001\000\009\000\119\000\000\000\
\\001\000\011\000\086\000\015\000\038\000\016\000\037\000\017\000\036\000\
\\018\000\035\000\019\000\034\000\020\000\033\000\021\000\032\000\
\\022\000\031\000\023\000\030\000\024\000\029\000\025\000\028\000\
\\026\000\027\000\000\000\
\\001\000\011\000\097\000\015\000\038\000\016\000\037\000\017\000\036\000\
\\018\000\035\000\019\000\034\000\020\000\033\000\021\000\032\000\
\\022\000\031\000\023\000\030\000\024\000\029\000\025\000\028\000\
\\026\000\027\000\000\000\
\\001\000\013\000\128\000\000\000\
\\001\000\013\000\134\000\000\000\
\\001\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\
\\030\000\078\000\000\000\
\\001\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\
\\034\000\110\000\000\000\
\\001\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\
\\035\000\077\000\000\000\
\\001\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\
\\035\000\133\000\000\000\
\\001\000\019\000\088\000\000\000\
\\001\000\019\000\096\000\000\000\
\\001\000\019\000\141\000\000\000\
\\001\000\019\000\142\000\000\000\
\\001\000\027\000\076\000\000\000\
\\001\000\027\000\118\000\000\000\
\\001\000\037\000\072\000\000\000\
\\001\000\038\000\101\000\000\000\
\\001\000\039\000\116\000\000\000\
\\151\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\000\000\
\\152\000\000\000\
\\153\000\000\000\
\\154\000\000\000\
\\155\000\000\000\
\\156\000\000\000\
\\157\000\000\000\
\\158\000\000\000\
\\159\000\010\000\026\000\014\000\025\000\027\000\024\000\000\000\
\\160\000\000\000\
\\161\000\000\000\
\\162\000\000\000\
\\163\000\000\000\
\\164\000\000\000\
\\165\000\000\000\
\\166\000\000\000\
\\167\000\002\000\023\000\003\000\022\000\004\000\021\000\008\000\020\000\
\\016\000\019\000\029\000\018\000\032\000\017\000\033\000\016\000\
\\036\000\015\000\040\000\014\000\041\000\013\000\000\000\
\\168\000\000\000\
\\169\000\007\000\081\000\015\000\038\000\016\000\037\000\017\000\036\000\
\\018\000\035\000\019\000\034\000\020\000\033\000\021\000\032\000\
\\022\000\031\000\023\000\030\000\024\000\029\000\025\000\028\000\
\\026\000\027\000\000\000\
\\170\000\000\000\
\\171\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\000\000\
\\172\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\000\000\
\\179\000\017\000\036\000\018\000\035\000\000\000\
\\180\000\017\000\036\000\018\000\035\000\000\000\
\\181\000\000\000\
\\182\000\000\000\
\\183\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\000\000\
\\184\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\
\\031\000\111\000\000\000\
\\185\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\000\000\
\\186\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\000\000\
\\187\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\000\000\
\\188\000\000\000\
\\189\000\000\000\
\\190\000\002\000\023\000\003\000\022\000\004\000\021\000\008\000\020\000\
\\016\000\019\000\029\000\018\000\032\000\017\000\033\000\016\000\
\\036\000\015\000\040\000\014\000\041\000\013\000\000\000\
\\191\000\000\000\
\\192\000\005\000\100\000\015\000\038\000\016\000\037\000\017\000\036\000\
\\018\000\035\000\019\000\034\000\020\000\033\000\021\000\032\000\
\\022\000\031\000\023\000\030\000\024\000\029\000\025\000\028\000\
\\026\000\027\000\000\000\
\\193\000\000\000\
\\194\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\000\000\
\\195\000\000\000\
\\196\000\005\000\124\000\015\000\038\000\016\000\037\000\017\000\036\000\
\\018\000\035\000\019\000\034\000\020\000\033\000\021\000\032\000\
\\022\000\031\000\023\000\030\000\024\000\029\000\025\000\028\000\
\\026\000\027\000\000\000\
\\197\000\000\000\
\\198\000\008\000\055\000\010\000\054\000\012\000\053\000\000\000\
\\199\000\039\000\114\000\000\000\
\\200\000\000\000\
\\201\000\000\000\
\\202\000\000\000\
\\203\000\042\000\046\000\043\000\045\000\044\000\044\000\000\000\
\\204\000\000\000\
\\205\000\000\000\
\\206\000\000\000\
\\207\000\000\000\
\\208\000\000\000\
\\209\000\000\000\
\\210\000\000\000\
\\211\000\002\000\109\000\000\000\
\\212\000\000\000\
\\213\000\005\000\139\000\000\000\
\\214\000\000\000\
\\215\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\000\000\
\\216\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\000\000\
\\217\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\000\000\
\\218\000\015\000\038\000\016\000\037\000\017\000\036\000\018\000\035\000\
\\019\000\034\000\020\000\033\000\021\000\032\000\022\000\031\000\
\\023\000\030\000\024\000\029\000\025\000\028\000\026\000\027\000\000\000\
\"
val actionRowNumbers =
"\007\000\058\000\057\000\056\000\
\\048\000\054\000\052\000\053\000\
\\050\000\055\000\047\000\059\000\
\\062\000\093\000\008\000\007\000\
\\007\000\007\000\063\000\061\000\
\\060\000\088\000\007\000\009\000\
\\007\000\007\000\007\000\007\000\
\\007\000\007\000\007\000\007\000\
\\007\000\007\000\007\000\007\000\
\\007\000\096\000\095\000\094\000\
\\093\000\044\000\010\000\011\000\
\\012\000\042\000\036\000\034\000\
\\051\000\027\000\065\000\013\000\
\\007\000\080\000\084\000\090\000\
\\030\000\068\000\067\000\001\000\
\\002\000\003\000\004\000\005\000\
\\006\000\072\000\071\000\070\000\
\\069\000\092\000\063\000\038\000\
\\022\000\026\000\007\000\007\000\
\\007\000\049\000\064\000\007\000\
\\039\000\031\000\028\000\082\000\
\\091\000\045\000\014\000\007\000\
\\015\000\101\000\035\000\075\000\
\\074\000\065\000\007\000\089\000\
\\079\000\081\000\007\000\078\000\
\\097\000\046\000\101\000\098\000\
\\105\000\043\000\029\000\023\000\
\\007\000\007\000\066\000\086\000\
\\007\000\082\000\016\000\032\000\
\\007\000\024\000\017\000\037\000\
\\073\000\033\000\018\000\077\000\
\\083\000\100\000\099\000\106\000\
\\007\000\019\000\103\000\007\000\
\\085\000\040\000\107\000\041\000\
\\102\000\020\000\076\000\007\000\
\\007\000\025\000\086\000\108\000\
\\021\000\087\000\103\000\104\000\
\\000\000"
val gotoT =
"\
\\001\000\010\000\002\000\148\000\011\000\009\000\012\000\008\000\
\\013\000\007\000\014\000\006\000\017\000\005\000\018\000\004\000\
\\019\000\003\000\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\003\000\041\000\004\000\040\000\005\000\039\000\009\000\038\000\
\\010\000\037\000\000\000\
\\000\000\
\\001\000\046\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\047\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\048\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\050\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\016\000\049\000\017\000\005\000\018\000\004\000\
\\019\000\003\000\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\054\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\001\000\056\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\057\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\058\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\059\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\060\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\061\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\062\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\063\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\064\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\065\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\066\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\067\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\068\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\003\000\069\000\004\000\040\000\005\000\039\000\009\000\038\000\
\\010\000\037\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\015\000\078\000\000\000\
\\000\000\
\\001\000\081\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\083\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\020\000\082\000\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\050\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\016\000\085\000\017\000\005\000\018\000\004\000\
\\019\000\003\000\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\090\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\091\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\092\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\000\000\
\\001\000\093\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\021\000\097\000\000\000\
\\000\000\
\\000\000\
\\006\000\100\000\000\000\
\\001\000\104\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\007\000\106\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\015\000\110\000\000\000\
\\001\000\111\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\113\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\007\000\115\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\119\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\120\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\024\000\121\000\000\000\
\\001\000\123\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\021\000\124\000\000\000\
\\000\000\
\\000\000\
\\001\000\127\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\134\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\008\000\136\000\000\000\
\\001\000\138\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\142\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\001\000\143\000\011\000\009\000\012\000\008\000\013\000\007\000\
\\014\000\006\000\017\000\005\000\018\000\004\000\019\000\003\000\
\\022\000\002\000\023\000\001\000\000\000\
\\000\000\
\\024\000\145\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\008\000\147\000\000\000\
\\000\000\
\\000\000\
\"
val numstates = 149
val numrules = 68
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle General.Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(List.map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = unit
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | STRING of unit ->  (string) | INT of unit ->  (int)
 | ID of unit ->  (string)
 | recarg of unit ->  ( ( symbol * Absyn.exp * pos )  list)
 | record of unit ->  (Absyn.exp) | assignment of unit ->  (Absyn.exp)
 | argseqcont of unit ->  (Absyn.exp list)
 | argseq of unit ->  (Absyn.exp list)
 | funcall of unit ->  (Absyn.exp) | literal of unit ->  (Absyn.exp)
 | lets of unit ->  (Absyn.exp) | seqexp of unit ->  (Absyn.exp)
 | seqexpcont of unit ->  ( ( Absyn.exp * pos )  list)
 | array of unit ->  (Absyn.exp) | cond of unit ->  (Absyn.exp)
 | opexp of unit ->  (Absyn.exp) | lvalue of unit ->  (Absyn.var)
 | fundec of unit ->  (Absyn.fundec) | vardec of unit ->  (Absyn.dec)
 | tyfieldscont of unit ->  (Absyn.field list)
 | tyfields of unit ->  (Absyn.field list) | ty of unit ->  (Absyn.ty)
 | tydec of unit ->  (Absyn.dec) | dec of unit ->  (Absyn.dec)
 | decs of unit ->  (Absyn.dec list) | program of unit ->  (Absyn.exp)
 | exp of unit ->  (Absyn.exp)
end
type svalue = MlyValue.svalue
type result = Absyn.exp
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn (T 31) => true | (T 32) => true | (T 33) => true | (T 39) => true
 | (T 35) => true | (T 36) => true | (T 37) => true | (T 41) => true
 | (T 42) => true | (T 43) => true | (T 27) => true | (T 28) => true
 | (T 29) => true | (T 30) => true | (T 34) => true | (T 38) => true
 | (T 40) => true | _ => false
val preferred_change : (term list * term list) list = 
(nil
,nil
 $$ (T 29))::
(nil
,nil
 $$ (T 30))::
(nil
,nil
 $$ (T 7))::
nil
val noShift = 
fn (T 0) => true | _ => false
val showTerminal =
fn (T 0) => "EOF"
  | (T 1) => "ID"
  | (T 2) => "INT"
  | (T 3) => "STRING"
  | (T 4) => "COMMA"
  | (T 5) => "COLON"
  | (T 6) => "SEMICOLON"
  | (T 7) => "LPAREN"
  | (T 8) => "RPAREN"
  | (T 9) => "LBRACK"
  | (T 10) => "RBRACK"
  | (T 11) => "LBRACE"
  | (T 12) => "RBRACE"
  | (T 13) => "DOT"
  | (T 14) => "PLUS"
  | (T 15) => "MINUS"
  | (T 16) => "TIMES"
  | (T 17) => "DIVIDE"
  | (T 18) => "EQ"
  | (T 19) => "NEQ"
  | (T 20) => "LT"
  | (T 21) => "LE"
  | (T 22) => "GT"
  | (T 23) => "GE"
  | (T 24) => "AND"
  | (T 25) => "OR"
  | (T 26) => "ASSIGN"
  | (T 27) => "ARRAY"
  | (T 28) => "IF"
  | (T 29) => "THEN"
  | (T 30) => "ELSE"
  | (T 31) => "WHILE"
  | (T 32) => "FOR"
  | (T 33) => "TO"
  | (T 34) => "DO"
  | (T 35) => "LET"
  | (T 36) => "IN"
  | (T 37) => "END"
  | (T 38) => "OF"
  | (T 39) => "BREAK"
  | (T 40) => "NIL"
  | (T 41) => "FUNCTION"
  | (T 42) => "VAR"
  | (T 43) => "TYPE"
  | (T 44) => "UMINUS"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn (T 1) => MlyValue.ID(fn () => ("bogus")) | 
(T 2) => MlyValue.INT(fn () => (1)) | 
(T 3) => MlyValue.STRING(fn () => ("")) | 
_ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 44) $$ (T 43) $$ (T 42) $$ (T 41) $$ (T 40) $$ (T 39) $$ (T 38)
 $$ (T 37) $$ (T 36) $$ (T 35) $$ (T 34) $$ (T 33) $$ (T 32) $$ (T 31)
 $$ (T 30) $$ (T 29) $$ (T 28) $$ (T 27) $$ (T 26) $$ (T 25) $$ (T 24)
 $$ (T 23) $$ (T 22) $$ (T 21) $$ (T 20) $$ (T 19) $$ (T 18) $$ (T 17)
 $$ (T 16) $$ (T 15) $$ (T 14) $$ (T 13) $$ (T 12) $$ (T 11) $$ (T 10)
 $$ (T 9) $$ (T 8) $$ (T 7) $$ (T 6) $$ (T 5) $$ (T 4) $$ (T 0)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (()):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.exp exp1, exp1left, exp1right)) :: rest671)
) => let val  result = MlyValue.program (fn _ => let val  (exp as exp1
) = exp1 ()
 in (exp)
end)
 in ( LrTable.NT 1, ( result, exp1left, exp1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.literal literal1, literal1left, 
literal1right)) :: rest671)) => let val  result = MlyValue.exp (fn _
 => let val  (literal as literal1) = literal1 ()
 in (literal)
end)
 in ( LrTable.NT 0, ( result, literal1left, literal1right), rest671)

end
|  ( 2, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.seqexp 
seqexp1, _, _)) :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let val 
 result = MlyValue.exp (fn _ => let val  (seqexp as seqexp1) = seqexp1
 ()
 in (seqexp)
end)
 in ( LrTable.NT 0, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 3, ( ( _, ( MlyValue.opexp opexp1, opexp1left, opexp1right)) :: 
rest671)) => let val  result = MlyValue.exp (fn _ => let val  (opexp
 as opexp1) = opexp1 ()
 in (opexp)
end)
 in ( LrTable.NT 0, ( result, opexp1left, opexp1right), rest671)
end
|  ( 4, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: ( _, ( _, (
MINUSleft as MINUS1left), _)) :: rest671)) => let val  result = 
MlyValue.exp (fn _ => let val  (exp as exp1) = exp1 ()
 in (
Absyn.OpExp(
          {left=Absyn.IntExp(0), oper= Absyn.MinusOp, right=exp, pos=MINUSleft})
)
end)
 in ( LrTable.NT 0, ( result, MINUS1left, exp1right), rest671)
end
|  ( 5, ( ( _, ( MlyValue.array array1, array1left, array1right)) :: 
rest671)) => let val  result = MlyValue.exp (fn _ => let val  (array
 as array1) = array1 ()
 in (array)
end)
 in ( LrTable.NT 0, ( result, array1left, array1right), rest671)
end
|  ( 6, ( ( _, ( MlyValue.cond cond1, cond1left, cond1right)) :: 
rest671)) => let val  result = MlyValue.exp (fn _ => let val  (cond
 as cond1) = cond1 ()
 in (cond)
end)
 in ( LrTable.NT 0, ( result, cond1left, cond1right), rest671)
end
|  ( 7, ( ( _, ( MlyValue.lets lets1, lets1left, lets1right)) :: 
rest671)) => let val  result = MlyValue.exp (fn _ => let val  (lets
 as lets1) = lets1 ()
 in (lets)
end)
 in ( LrTable.NT 0, ( result, lets1left, lets1right), rest671)
end
|  ( 8, ( ( _, ( MlyValue.lvalue lvalue1, lvalue1left, lvalue1right))
 :: rest671)) => let val  result = MlyValue.exp (fn _ => let val  (
lvalue as lvalue1) = lvalue1 ()
 in (Absyn.VarExp(lvalue))
end)
 in ( LrTable.NT 0, ( result, lvalue1left, lvalue1right), rest671)
end
|  ( 9, ( ( _, ( MlyValue.funcall funcall1, funcall1left, 
funcall1right)) :: rest671)) => let val  result = MlyValue.exp (fn _
 => let val  (funcall as funcall1) = funcall1 ()
 in (funcall)
end)
 in ( LrTable.NT 0, ( result, funcall1left, funcall1right), rest671)

end
|  ( 10, ( ( _, ( MlyValue.assignment assignment1, assignment1left, 
assignment1right)) :: rest671)) => let val  result = MlyValue.exp (fn
 _ => let val  (assignment as assignment1) = assignment1 ()
 in (assignment)
end)
 in ( LrTable.NT 0, ( result, assignment1left, assignment1right), 
rest671)
end
|  ( 11, ( ( _, ( MlyValue.record record1, record1left, record1right))
 :: rest671)) => let val  result = MlyValue.exp (fn _ => let val  (
record as record1) = record1 ()
 in (record)
end)
 in ( LrTable.NT 0, ( result, record1left, record1right), rest671)
end
|  ( 12, ( ( _, ( _, NIL1left, NIL1right)) :: rest671)) => let val  
result = MlyValue.literal (fn _ => (Absyn.NilExp))
 in ( LrTable.NT 17, ( result, NIL1left, NIL1right), rest671)
end
|  ( 13, ( ( _, ( MlyValue.INT INT1, INT1left, INT1right)) :: rest671)
) => let val  result = MlyValue.literal (fn _ => let val  (INT as INT1
) = INT1 ()
 in (Absyn.IntExp(INT))
end)
 in ( LrTable.NT 17, ( result, INT1left, INT1right), rest671)
end
|  ( 14, ( ( _, ( MlyValue.STRING STRING1, (STRINGleft as STRING1left)
, STRING1right)) :: rest671)) => let val  result = MlyValue.literal
 (fn _ => let val  (STRING as STRING1) = STRING1 ()
 in (Absyn.StringExp(STRING, STRINGleft))
end)
 in ( LrTable.NT 17, ( result, STRING1left, STRING1right), rest671)

end
|  ( 15, ( ( _, ( _, (BREAKleft as BREAK1left), BREAK1right)) :: 
rest671)) => let val  result = MlyValue.literal (fn _ => (
Absyn.BreakExp(BREAKleft)))
 in ( LrTable.NT 17, ( result, BREAK1left, BREAK1right), rest671)
end
|  ( 16, ( rest671)) => let val  result = MlyValue.seqexp (fn _ => (
Absyn.SeqExp([])))
 in ( LrTable.NT 15, ( result, defaultPos, defaultPos), rest671)
end
|  ( 17, ( ( _, ( MlyValue.seqexpcont seqexpcont1, _, seqexpcont1right
)) :: ( _, ( MlyValue.exp exp1, (expleft as exp1left), _)) :: rest671)
) => let val  result = MlyValue.seqexp (fn _ => let val  (exp as exp1)
 = exp1 ()
 val  (seqexpcont as seqexpcont1) = seqexpcont1 ()
 in (Absyn.SeqExp((exp, expleft):: seqexpcont))
end)
 in ( LrTable.NT 15, ( result, exp1left, seqexpcont1right), rest671)

end
|  ( 18, ( rest671)) => let val  result = MlyValue.seqexpcont (fn _ =>
 ([]))
 in ( LrTable.NT 14, ( result, defaultPos, defaultPos), rest671)
end
|  ( 19, ( ( _, ( MlyValue.seqexpcont seqexpcont1, _, seqexpcont1right
)) :: ( _, ( MlyValue.exp exp1, expleft, _)) :: ( _, ( _, 
SEMICOLON1left, _)) :: rest671)) => let val  result = 
MlyValue.seqexpcont (fn _ => let val  (exp as exp1) = exp1 ()
 val  (seqexpcont as seqexpcont1) = seqexpcont1 ()
 in ((exp, expleft):: seqexpcont)
end)
 in ( LrTable.NT 14, ( result, SEMICOLON1left, seqexpcont1right), 
rest671)
end
|  ( 20, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.IfExp(
          {test=exp1, then'=exp2, else'=SOME (Absyn.IntExp(0)), pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 21, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.IfExp(
          {test=exp1, then'=Absyn.IntExp(1), else'=SOME exp2, pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 22, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.OpExp(
          {left=exp1, oper= Absyn.GeOp, right=exp2, pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 23, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.OpExp(
          {left=exp1, oper= Absyn.GtOp, right=exp2, pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 24, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.OpExp(
          {left=exp1, oper= Absyn.LeOp, right=exp2, pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 25, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.OpExp(
          {left=exp1, oper= Absyn.LtOp, right=exp2, pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 26, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.OpExp(
          {left=exp1, oper= Absyn.NeqOp, right=exp2, pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 27, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.OpExp(
          {left=exp1, oper= Absyn.EqOp, right=exp2, pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 28, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.OpExp(
          {left=exp1, oper= Absyn.PlusOp, right=exp2, pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 29, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.OpExp(
          {left=exp1, oper= Absyn.MinusOp, right=exp2, pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 30, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.OpExp(
          {left=exp1, oper= Absyn.TimesOp, right=exp2, pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 31, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.opexp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.OpExp(
          {left=exp1, oper= Absyn.DivideOp, right=exp2, pos=exp1left})
)
end)
 in ( LrTable.NT 11, ( result, exp1left, exp2right), rest671)
end
|  ( 32, ( ( _, ( MlyValue.exp exp3, _, exp3right)) :: _ :: ( _, ( 
MlyValue.exp exp2, _, _)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) :: 
( _, ( _, (IFleft as IF1left), _)) :: rest671)) => let val  result = 
MlyValue.cond (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 val  exp3 = exp3 ()
 in (
Absyn.IfExp(
          {test=exp1, then'=exp2, else'= SOME exp3, pos= IFleft})
)
end)
 in ( LrTable.NT 12, ( result, IF1left, exp3right), rest671)
end
|  ( 33, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, _, _)) :: ( _, ( _, (IFleft as IF1left), _)) :: 
rest671)) => let val  result = MlyValue.cond (fn _ => let val  exp1 = 
exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.IfExp(
          {test=exp1, then'= exp2, else'=NONE, pos= IFleft})
)
end)
 in ( LrTable.NT 12, ( result, IF1left, exp2right), rest671)
end
|  ( 34, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, _, _)) :: ( _, ( _, (WHILEleft as WHILE1left), _))
 :: rest671)) => let val  result = MlyValue.cond (fn _ => let val  
exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (Absyn.WhileExp(
          {test=exp1, body=exp2, pos=WHILEleft}))

end)
 in ( LrTable.NT 12, ( result, WHILE1left, exp2right), rest671)
end
|  ( 35, ( ( _, ( MlyValue.exp exp3, _, exp3right)) :: _ :: ( _, ( 
MlyValue.exp exp2, _, _)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) ::
 _ :: ( _, ( MlyValue.ID ID1, _, _)) :: ( _, ( _, (FORleft as FOR1left
), _)) :: rest671)) => let val  result = MlyValue.cond (fn _ => let
 val  (ID as ID1) = ID1 ()
 val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 val  exp3 = exp3 ()
 in (
Absyn.ForExp(
          {var= symbol ID, escape = ref false, lo = exp1,
            hi=exp2, body=exp3, pos=FORleft})
)
end)
 in ( LrTable.NT 12, ( result, FOR1left, exp3right), rest671)
end
|  ( 36, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: _ :: ( _, 
( MlyValue.exp exp1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, (IDleft
 as ID1left), _)) :: rest671)) => let val  result = MlyValue.array (fn
 _ => let val  (ID as ID1) = ID1 ()
 val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
Absyn.ArrayExp(
          {typ= symbol ID, size = exp1, init= exp2, pos= IDleft})
)
end)
 in ( LrTable.NT 13, ( result, ID1left, exp2right), rest671)
end
|  ( 37, ( ( _, ( _, _, END1right)) :: ( _, ( MlyValue.seqexp seqexp1,
 _, _)) :: _ :: ( _, ( MlyValue.decs decs1, _, _)) :: ( _, ( _, (
LETleft as LET1left), _)) :: rest671)) => let val  result = 
MlyValue.lets (fn _ => let val  (decs as decs1) = decs1 ()
 val  (seqexp as seqexp1) = seqexp1 ()
 in (
Absyn.LetExp(
          {decs= decs, body = seqexp, pos= LETleft}))

end)
 in ( LrTable.NT 16, ( result, LET1left, END1right), rest671)
end
|  ( 38, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.argseq 
argseq1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, (IDleft as ID1left), _
)) :: rest671)) => let val  result = MlyValue.funcall (fn _ => let
 val  (ID as ID1) = ID1 ()
 val  (argseq as argseq1) = argseq1 ()
 in (
Absyn.CallExp(
          {func=symbol ID, args=argseq, pos=IDleft}))

end)
 in ( LrTable.NT 18, ( result, ID1left, RPAREN1right), rest671)
end
|  ( 39, ( rest671)) => let val  result = MlyValue.argseq (fn _ => ([]
))
 in ( LrTable.NT 19, ( result, defaultPos, defaultPos), rest671)
end
|  ( 40, ( ( _, ( MlyValue.argseqcont argseqcont1, _, argseqcont1right
)) :: ( _, ( MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val 
 result = MlyValue.argseq (fn _ => let val  (exp as exp1) = exp1 ()
 val  (argseqcont as argseqcont1) = argseqcont1 ()
 in (exp :: argseqcont)
end)
 in ( LrTable.NT 19, ( result, exp1left, argseqcont1right), rest671)

end
|  ( 41, ( rest671)) => let val  result = MlyValue.argseqcont (fn _ =>
 ([]))
 in ( LrTable.NT 20, ( result, defaultPos, defaultPos), rest671)
end
|  ( 42, ( ( _, ( MlyValue.argseqcont argseqcont1, _, argseqcont1right
)) :: ( _, ( MlyValue.exp exp1, _, _)) :: ( _, ( _, COMMA1left, _)) ::
 rest671)) => let val  result = MlyValue.argseqcont (fn _ => let val 
 (exp as exp1) = exp1 ()
 val  (argseqcont as argseqcont1) = argseqcont1 ()
 in (exp :: argseqcont)
end)
 in ( LrTable.NT 20, ( result, COMMA1left, argseqcont1right), rest671)

end
|  ( 43, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.lvalue lvalue1, (lvalueleft as lvalue1left), _)) :: rest671))
 => let val  result = MlyValue.assignment (fn _ => let val  (lvalue
 as lvalue1) = lvalue1 ()
 val  (exp as exp1) = exp1 ()
 in (
Absyn.AssignExp(
          {var= lvalue, exp = exp, pos= lvalueleft}))

end)
 in ( LrTable.NT 21, ( result, lvalue1left, exp1right), rest671)
end
|  ( 44, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.recarg 
recarg1, _, _)) :: ( _, ( MlyValue.exp exp1, _, _)) :: _ :: ( _, ( 
MlyValue.ID ID2, ID2left, _)) :: _ :: ( _, ( MlyValue.ID ID1, ID1left,
 _)) :: rest671)) => let val  result = MlyValue.record (fn _ => let
 val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 val  (exp as exp1) = exp1 ()
 val  (recarg as recarg1) = recarg1 ()
 in (
Absyn.RecordExp(
          {fields= (symbol ID2, exp, ID2left) :: recarg, 
                    typ= symbol ID1, pos = ID1left})
)
end)
 in ( LrTable.NT 22, ( result, ID1left, RBRACE1right), rest671)
end
|  ( 45, ( rest671)) => let val  result = MlyValue.recarg (fn _ => ([]
))
 in ( LrTable.NT 23, ( result, defaultPos, defaultPos), rest671)
end
|  ( 46, ( ( _, ( MlyValue.recarg recarg1, _, recarg1right)) :: ( _, (
 MlyValue.exp exp1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, IDleft, _))
 :: ( _, ( _, COMMA1left, _)) :: rest671)) => let val  result = 
MlyValue.recarg (fn _ => let val  (ID as ID1) = ID1 ()
 val  (exp as exp1) = exp1 ()
 val  (recarg as recarg1) = recarg1 ()
 in ((symbol ID, exp, IDleft) :: recarg)
end)
 in ( LrTable.NT 23, ( result, COMMA1left, recarg1right), rest671)
end
|  ( 47, ( ( _, ( MlyValue.ID ID1, (IDleft as ID1left), ID1right)) :: 
rest671)) => let val  result = MlyValue.lvalue (fn _ => let val  (ID
 as ID1) = ID1 ()
 in (Absyn.SimpleVar(symbol ID, IDleft))
end)
 in ( LrTable.NT 10, ( result, ID1left, ID1right), rest671)
end
|  ( 48, ( ( _, ( _, _, RBRACK1right)) :: ( _, ( MlyValue.exp exp1, _,
 _)) :: _ :: ( _, ( MlyValue.ID ID1, (IDleft as ID1left), _)) :: 
rest671)) => let val  result = MlyValue.lvalue (fn _ => let val  (ID
 as ID1) = ID1 ()
 val  (exp as exp1) = exp1 ()
 in (
Absyn.SubscriptVar( Absyn.SimpleVar(symbol ID, IDleft), exp, IDleft))

end)
 in ( LrTable.NT 10, ( result, ID1left, RBRACK1right), rest671)
end
|  ( 49, ( ( _, ( MlyValue.ID ID1, _, ID1right)) :: _ :: ( _, ( 
MlyValue.lvalue lvalue1, (lvalueleft as lvalue1left), _)) :: rest671))
 => let val  result = MlyValue.lvalue (fn _ => let val  (lvalue as 
lvalue1) = lvalue1 ()
 val  (ID as ID1) = ID1 ()
 in (Absyn.FieldVar(lvalue, symbol ID, lvalueleft))
end)
 in ( LrTable.NT 10, ( result, lvalue1left, ID1right), rest671)
end
|  ( 50, ( ( _, ( _, _, RBRACK1right)) :: ( _, ( MlyValue.exp exp1, _,
 _)) :: _ :: ( _, ( MlyValue.lvalue lvalue1, (lvalueleft as 
lvalue1left), _)) :: rest671)) => let val  result = MlyValue.lvalue
 (fn _ => let val  (lvalue as lvalue1) = lvalue1 ()
 val  (exp as exp1) = exp1 ()
 in (Absyn.SubscriptVar(lvalue, exp, lvalueleft))
end)
 in ( LrTable.NT 10, ( result, lvalue1left, RBRACK1right), rest671)

end
|  ( 51, ( ( _, ( MlyValue.decs decs1, _, decs1right)) :: ( _, ( 
MlyValue.dec dec1, dec1left, _)) :: rest671)) => let val  result = 
MlyValue.decs (fn _ => let val  (dec as dec1) = dec1 ()
 val  (decs as decs1) = decs1 ()
 in (dec :: decs)
end)
 in ( LrTable.NT 2, ( result, dec1left, decs1right), rest671)
end
|  ( 52, ( rest671)) => let val  result = MlyValue.decs (fn _ => ([]))
 in ( LrTable.NT 2, ( result, defaultPos, defaultPos), rest671)
end
|  ( 53, ( ( _, ( MlyValue.tydec tydec1, tydec1left, tydec1right)) :: 
rest671)) => let val  result = MlyValue.dec (fn _ => let val  (tydec
 as tydec1) = tydec1 ()
 in (tydec)
end)
 in ( LrTable.NT 3, ( result, tydec1left, tydec1right), rest671)
end
|  ( 54, ( ( _, ( MlyValue.vardec vardec1, vardec1left, vardec1right))
 :: rest671)) => let val  result = MlyValue.dec (fn _ => let val  (
vardec as vardec1) = vardec1 ()
 in (vardec)
end)
 in ( LrTable.NT 3, ( result, vardec1left, vardec1right), rest671)
end
|  ( 55, ( ( _, ( MlyValue.fundec fundec1, fundec1left, fundec1right))
 :: rest671)) => let val  result = MlyValue.dec (fn _ => let val  (
fundec as fundec1) = fundec1 ()
 in (Absyn.FunctionDec([fundec]))
end)
 in ( LrTable.NT 3, ( result, fundec1left, fundec1right), rest671)
end
|  ( 56, ( ( _, ( MlyValue.ty ty1, _, ty1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, (TYPEleft as TYPE1left), _)) :: 
rest671)) => let val  result = MlyValue.tydec (fn _ => let val  (ID
 as ID1) = ID1 ()
 val  (ty as ty1) = ty1 ()
 in (Absyn.TypeDec({name= symbol ID, ty=ty, pos=TYPEleft} :: []))
end)
 in ( LrTable.NT 4, ( result, TYPE1left, ty1right), rest671)
end
|  ( 57, ( ( _, ( MlyValue.ID ID1, (IDleft as ID1left), ID1right)) :: 
rest671)) => let val  result = MlyValue.ty (fn _ => let val  (ID as 
ID1) = ID1 ()
 in (Absyn.NameTy(symbol ID, IDleft))
end)
 in ( LrTable.NT 5, ( result, ID1left, ID1right), rest671)
end
|  ( 58, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.tyfields 
tyfields1, _, _)) :: ( _, ( _, LBRACE1left, _)) :: rest671)) => let
 val  result = MlyValue.ty (fn _ => let val  (tyfields as tyfields1) =
 tyfields1 ()
 in (Absyn.RecordTy( tyfields))
end)
 in ( LrTable.NT 5, ( result, LBRACE1left, RBRACE1right), rest671)
end
|  ( 59, ( ( _, ( MlyValue.ID ID1, IDleft, ID1right)) :: _ :: ( _, ( _
, ARRAY1left, _)) :: rest671)) => let val  result = MlyValue.ty (fn _
 => let val  (ID as ID1) = ID1 ()
 in (Absyn.ArrayTy( symbol ID, IDleft))
end)
 in ( LrTable.NT 5, ( result, ARRAY1left, ID1right), rest671)
end
|  ( 60, ( rest671)) => let val  result = MlyValue.tyfields (fn _ => (
[]))
 in ( LrTable.NT 6, ( result, defaultPos, defaultPos), rest671)
end
|  ( 61, ( ( _, ( MlyValue.tyfieldscont tyfieldscont1, _, 
tyfieldscont1right)) :: ( _, ( MlyValue.ID ID2, _, _)) :: _ :: ( _, ( 
MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  result = 
MlyValue.tyfields (fn _ => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 val  (tyfieldscont as tyfieldscont1) = tyfieldscont1 ()
 in (

         	{ name= symbol ID1, escape= ref false,
         	  typ= symbol ID2, pos= ID1left } 
         	:: tyfieldscont 
)
end)
 in ( LrTable.NT 6, ( result, ID1left, tyfieldscont1right), rest671)

end
|  ( 62, ( rest671)) => let val  result = MlyValue.tyfieldscont (fn _
 => ([]))
 in ( LrTable.NT 7, ( result, defaultPos, defaultPos), rest671)
end
|  ( 63, ( ( _, ( MlyValue.tyfieldscont tyfieldscont1, _, 
tyfieldscont1right)) :: ( _, ( MlyValue.ID ID2, _, _)) :: _ :: ( _, ( 
MlyValue.ID ID1, ID1left, _)) :: ( _, ( _, COMMA1left, _)) :: rest671)
) => let val  result = MlyValue.tyfieldscont (fn _ => let val  ID1 = 
ID1 ()
 val  ID2 = ID2 ()
 val  (tyfieldscont as tyfieldscont1) = tyfieldscont1 ()
 in (

             	{ name= symbol ID1, escape= ref false,
         		 typ= symbol ID2, pos= ID1left } 
     		 	:: tyfieldscont
)
end)
 in ( LrTable.NT 7, ( result, COMMA1left, tyfieldscont1right), rest671
)
end
|  ( 64, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, (VARleft as VAR1left), _)) :: 
rest671)) => let val  result = MlyValue.vardec (fn _ => let val  (ID
 as ID1) = ID1 ()
 val  (exp as exp1) = exp1 ()
 in (
Absyn.VarDec(
				{ name= symbol ID, escape= ref false, typ = NONE,
				  init=exp, pos= VARleft })
)
end)
 in ( LrTable.NT 8, ( result, VAR1left, exp1right), rest671)
end
|  ( 65, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID2, ID2left, _)) :: _ :: ( _, ( MlyValue.ID ID1, _, _))
 :: ( _, ( _, (VARleft as VAR1left), _)) :: rest671)) => let val  
result = MlyValue.vardec (fn _ => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 val  (exp as exp1) = exp1 ()
 in (
Absyn.VarDec(
				{ name= symbol ID1,  escape= ref false, 
          typ = SOME (symbol ID2, ID2left),
				  init=exp, pos= VARleft })
)
end)
 in ( LrTable.NT 8, ( result, VAR1left, exp1right), rest671)
end
|  ( 66, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: _ :: ( _, 
( MlyValue.tyfields tyfields1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1,
 _, _)) :: ( _, ( _, (FUNCTIONleft as FUNCTION1left), _)) :: rest671))
 => let val  result = MlyValue.fundec (fn _ => let val  (ID as ID1) = 
ID1 ()
 val  (tyfields as tyfields1) = tyfields1 ()
 val  (exp as exp1) = exp1 ()
 in (

				{ name= symbol ID, params= tyfields, 
				  result= NONE, body= exp, pos=FUNCTIONleft }
)
end)
 in ( LrTable.NT 9, ( result, FUNCTION1left, exp1right), rest671)
end
|  ( 67, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID2, ID2left, _)) :: _ :: _ :: ( _, ( MlyValue.tyfields 
tyfields1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, _, _)) :: ( _, ( _,
 (FUNCTIONleft as FUNCTION1left), _)) :: rest671)) => let val  result
 = MlyValue.fundec (fn _ => let val  ID1 = ID1 ()
 val  (tyfields as tyfields1) = tyfields1 ()
 val  ID2 = ID2 ()
 val  (exp as exp1) = exp1 ()
 in (

				{ name= symbol ID1, params= tyfields, 
				  result= SOME(symbol ID2, ID2left), 
				  body= exp, pos=FUNCTIONleft }
)
end)
 in ( LrTable.NT 9, ( result, FUNCTION1left, exp1right), rest671)
end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.program x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : Tiger_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.VOID,p1,p2))
fun ID (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.ID (fn () => i),p1,p2))
fun INT (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.INT (fn () => i),p1,p2))
fun STRING (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.STRING (fn () => i),p1,p2))
fun COMMA (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun COLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun SEMICOLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun LPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun RPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun DOT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun PLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun MINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun TIMES (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun DIVIDE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun EQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun NEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun LT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun LE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun GT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun GE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun AND (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun OR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun ASSIGN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun ARRAY (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun IF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun THEN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun ELSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun WHILE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun FOR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun TO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun DO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun LET (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun IN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.VOID,p1,p2))
fun END (p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.VOID,p1,p2))
fun OF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun BREAK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.VOID,p1,p2))
fun NIL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.VOID,p1,p2))
fun FUNCTION (p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.VOID,p1,p2))
fun VAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 42,(
ParserData.MlyValue.VOID,p1,p2))
fun TYPE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 43,(
ParserData.MlyValue.VOID,p1,p2))
fun UMINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 44,(
ParserData.MlyValue.VOID,p1,p2))
end
end
