type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = Tokens.EOF(!lineNum,0)



%%
alpha=[A-Za-z];
ctrl=[a-z];
%%
\n	=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
" "|"\t"     => (linePos := yypos :: !linePos; continue());
"("     => (Tokens.LPAREN(!lineNum, yypos - hd(!linePos)));
")"     => (Tokens.RPAREN(!lineNum, yypos - hd(!linePos)));
"["     => (Tokens.LBRACE(!lineNum, yypos - hd(!linePos)));
"]"     => (Tokens.RBRACE(!lineNum, yypos - hd(!linePos)));
"{"     => (Tokens.LBRACK(!lineNum, yypos - hd(!linePos)));
"}"     => (Tokens.RBRACK(!lineNum, yypos - hd(!linePos)));
"."     => (Tokens.DOT(!lineNum, yypos - hd(!linePos)));
";"     => (Tokens.SEMICOLON(!lineNum, yypos - hd(!linePos)));
":"     => (Tokens.COLON(!lineNum, yypos - hd(!linePos)));
","     => (Tokens.COMMA(!lineNum, yypos - hd(!linePos)));
	   
"-"     => (Tokens.MINUS(!lineNum, yypos - hd(!linePos)));
"*"     => (Tokens.TIMES(!lineNum, yypos - hd(!linePos)));
"/"     => (Tokens.DIVIDE(!lineNum, yypos - hd(!linePos)));
"+"     => (Tokens.PLUS(!lineNum, yypos - hd(!linePos)));
"="     => (Tokens.EQ(!lineNum, yypos - hd(!linePos)));
"<"     => (Tokens.LT(!lineNum, yypos - hd(!linePos)));
">"     => (Tokens.GT(!lineNum, yypos - hd(!linePos)));
"<>"    => (Tokens.NEQ(!lineNum, yypos - hd(!linePos)));
">="    => (Tokens.GE(!lineNum, yypos - hd(!linePos)));
"<="    => (Tokens.LE(!lineNum, yypos - hd(!linePos)));
"&"     => (Tokens.AND(!lineNum, yypos - hd(!linePos)));
"|"     => (Tokens.OR(!lineNum, yypos - hd(!linePos)));
":="    => (Tokens.ASSIGN(!lineNum, yypos - hd(!linePos)));

"type"  => (Tokens.TYPE(!lineNum, yypos - hd(!linePos)));
"var"   => (Tokens.VAR(!lineNum, yypos - hd(!linePos)));
"function"     => (Tokens.FUNCTION(!lineNum, yypos - hd(!linePos)));	    
"break"     => (Tokens.BREAK(!lineNum, yypos - hd(!linePos)));
"of"     => (Tokens.OF(!lineNum, yypos - hd(!linePos)));		
"end"     => (Tokens.END(!lineNum, yypos - hd(!linePos)));
"in"     => (Tokens.IN(!lineNum, yypos - hd(!linePos)));
"nil"     => (Tokens.NIL(!lineNum, yypos - hd(!linePos)));
"let"     => (Tokens.LET(!lineNum, yypos - hd(!linePos)));
"do"     => (Tokens.DO(!lineNum, yypos - hd(!linePos)));
"to"     => (Tokens.TO(!lineNum, yypos - hd(!linePos)));	     
"for"     => (Tokens.FOR(!lineNum, yypos - hd(!linePos)));
"while"     => (Tokens.WHILE(!lineNum, yypos - hd(!linePos)));
"else"     => (Tokens.ELSE(!lineNum, yypos - hd(!linePos)));		
"then"     => (Tokens.THEN(!lineNum, yypos - hd(!linePos)));
"if"     => (Tokens.IF(!lineNum, yypos - hd(!linePos)));
"array"     => (Tokens.ARRAY(!lineNum, yypos - hd(!linePos)));	     
"assign"     => (Tokens.ASSIGN(!lineNum, yypos - hd(!linePos)));	    	       
-[1-9][0-9]* => (Tokens.INT( Option.getOpt(Int.fromString(yytext),0), !lineNum, yypos - hd(!linePos))); 
[0-9]+      =>  (Tokens.INT( Option.getOpt(Int.fromString(yytext),0), !lineNum, yypos - hd(!linePos)));		 
{alpha}({alpha}|[0-9]|_)* =>  (Tokens.ID(yytext, !lineNum, yypos - hd(!linePos)));
"\""("\\"(n|t|{ctrl}|[0-127]|"\""|" "*)|"\\")*[^"\""]  =>  (Tokens.STRING(yytext, !lineNum, yypos - hd(!linePos)));
.       => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());
