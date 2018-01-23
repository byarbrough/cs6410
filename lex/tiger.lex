type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end



%%
alpha=[A-Za-z];
%%
\n	=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
","	=> (Tokens.COMMA(yypos,yypos+1));

"("     => (Tokens.LPAREN(!lineNum, hd(!linePos)));
")"     => (Tokens.RPAREN(!lineNum, hd(!linePos)));
"["     => (Tokens.LBRACE(!lineNum, hd(!linePos)));
"]"     => (Tokens.RBRACE(!lineNum, hd(!linePos)));
"{"     => (Tokens.LBRACK(!lineNum, hd(!linePos)));
"}"     => (Tokens.RBRACK(!lineNum, hd(!linePos)));
	    
"."     => (Tokens.DOT(!lineNum, hd(!linePos)));
";"     => (Tokens.SEMICOLON(!lineNum, hd(!linePos)));
":"     => (Tokens.COLON(!lineNum, hd(!linePos)));
","     => (Tokens.COMMA(!lineNum, hd(!linePos)));
	   
"-"     => (Tokens.MINUS(!lineNum, hd(!linePos)));
"*"     => (Tokens.TIMES(!lineNum, hd(!linePos)));
"/"     => (Tokens.DIVIDE(!lineNum, hd(!linePos)));
"+"     => (Tokens.PLUS(!lineNum, hd(!linePos)));
"="     => (Tokens.EQ(!lineNum, hd(!linePos)));
"<"     => (Tokens.LT(!lineNum, hd(!linePos)));
">"     => (Tokens.GT(!lineNum, hd(!linePos)));
"<>"    => (Tokens.NEQ(!lineNum, hd(!linePos)));
">="    => (Tokens.GE(!lineNum, hd(!linePos)));
"<="    => (Tokens.LE(!lineNum, hd(!linePos)));
"&"     => (Tokens.AND(!lineNum, hd(!linePos)));
"|"     => (Tokens.OR(!lineNum, hd(!linePos)));
":="    => (Tokens.ASSIGN(!lineNum, hd(!linePos)));

"type"  => (Tokens.TYPE(!lineNum, hd(!linePos)));
"var"   => (Tokens.VAR(!lineNum, hd(!linePos)));
"function"     => (Tokens.FUNCTION(!lineNum, hd(!linePos)));	    
"break"     => (Tokens.BREAK(!lineNum, hd(!linePos)));
"of"     => (Tokens.OF(!lineNum, hd(!linePos)));		
"end"     => (Tokens.END(!lineNum, hd(!linePos)));
"in"     => (Tokens.IN(!lineNum, hd(!linePos)));
"nil"     => (Tokens.NIL(!lineNum, hd(!linePos)));
"let"     => (Tokens.LET(!lineNum, hd(!linePos)));
"do"     => (Tokens.DO(!lineNum, hd(!linePos)));
"to"     => (Tokens.TO(!lineNum, hd(!linePos)));	     
"for"     => (Tokens.FOR(!lineNum, hd(!linePos)));
"while"     => (Tokens.WHILE(!lineNum, hd(!linePos)));
"else"     => (Tokens.ELSE(!lineNum, hd(!linePos)));		
"then"     => (Tokens.THEN(!lineNum, hd(!linePos)));
"if"     => (Tokens.IF(!lineNum, hd(!linePos)));
"array"     => (Tokens.ARRAY(!lineNum, hd(!linePos)));	     
"assign"     => (Tokens.ASSIGN(!lineNum, hd(!linePos)));	    	       
-[1-9][0-9]* => (Tokens.INT(yytext, !lineNum, hd(!linePos))); 
[0-9]+      =>  (Tokens.INT(yytext, !lineNum, hd(!linePos)));		 
{alpha}({alpha}|[0-9]|_)* =>  (Tokens.ID(yytext, !lineNum, hd(!linePos)));			       
  .       => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());
