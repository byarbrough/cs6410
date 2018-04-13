type svalue = Tokens.svalue
type pos = int
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (svalue, pos) token
exception LexerException of int * int
			
val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
val commentNest = ref 0;
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = if !commentNest > 0 then raise LexerException(!lineNum, 0)
			else Tokens.EOF(!lineNum,0)



%%
%header (functor TigerLexFun (structure Tokens: Tiger_TOKENS));
alpha=[A-Za-z];
ascii=[0-9] | [0-9]{2} | 1[0-1][0-9] | 12[0-7];
ctrl=[a-z];
str="\""(("\\"(n|t|"^"{ctrl}|{ascii}|"\""|(" "*"\\")))|[^"\""])*"\"";
lineNum := !lineNum+1;
linePos := yypos :: !linePos;
%s COMMENT E_COMMENT B_COMMENT;
%%
<INITIAL,COMMENT,B_COMMENT,E_COMMENT>\n  => (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
<INITIAL>"/*"         => (YYBEGIN COMMENT; commentNest := !commentNest + 1; continue());
<COMMENT>[^*\/\n]*=> (continue());
<COMMENT>"/" => (YYBEGIN B_COMMENT; continue());
<COMMENT>"*" => (YYBEGIN E_COMMENT; continue());
<B_COMMENT>"/"*=>(continue());
<B_COMMENT>"*"=>(YYBEGIN COMMENT; commentNest:= !commentNest + 1; continue());
<B_COMMENT>[^*\/]=>(YYBEGIN COMMENT; continue());
<E_COMMENT>"*"*=>(continue());
<E_COMMENT>"/"=>(commentNest := !commentNest - 1; if !commentNest <= 0 then YYBEGIN INITIAL  else YYBEGIN COMMENT; continue());
<E_COMMENT>[^*\/]=>(YYBEGIN COMMENT; continue());

"\n"		 => (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
" "|"\t"     => (continue());

"("          => (Tokens.LPAREN(		!lineNum, yypos - hd(!linePos)));
")"          => (Tokens.RPAREN(		!lineNum, yypos - hd(!linePos)));
"["          => (Tokens.LBRACK(		!lineNum, yypos - hd(!linePos)));
"]"          => (Tokens.RBRACK(		!lineNum, yypos - hd(!linePos)));
"{"          => (Tokens.LBRACE(		!lineNum, yypos - hd(!linePos)));
"}"          => (Tokens.RBRACE(		!lineNum, yypos - hd(!linePos)));
"."          => (Tokens.DOT(		!lineNum, yypos - hd(!linePos)));
";"          => (Tokens.SEMICOLON(	!lineNum, yypos - hd(!linePos)));
":"          => (Tokens.COLON(		!lineNum, yypos - hd(!linePos)));
","          => (Tokens.COMMA(		!lineNum, yypos - hd(!linePos)));
	   
"-"          => (Tokens.MINUS(		!lineNum, yypos - hd(!linePos)));
"*"          => (Tokens.TIMES(		!lineNum, yypos - hd(!linePos)));
"/"          => (Tokens.DIVIDE(		!lineNum, yypos - hd(!linePos)));
"+"          => (Tokens.PLUS(		!lineNum, yypos - hd(!linePos)));
"="          => (Tokens.EQ(			!lineNum, yypos - hd(!linePos)));
"<"          => (Tokens.LT(			!lineNum, yypos - hd(!linePos)));
">"          => (Tokens.GT(			!lineNum, yypos - hd(!linePos)));
"<>"         => (Tokens.NEQ(		!lineNum, yypos - hd(!linePos)));
">="         => (Tokens.GE(			!lineNum, yypos - hd(!linePos)));
"<="         => (Tokens.LE(			!lineNum, yypos - hd(!linePos)));
"&"          => (Tokens.AND(		!lineNum, yypos - hd(!linePos)));
"|"          => (Tokens.OR(			!lineNum, yypos - hd(!linePos)));
":="         => (Tokens.ASSIGN(		!lineNum, yypos - hd(!linePos)));

"type"       => (Tokens.TYPE(		!lineNum, yypos - hd(!linePos)));
"var"        => (Tokens.VAR(		!lineNum, yypos - hd(!linePos)));
"function"   => (Tokens.FUNCTION(	!lineNum, yypos - hd(!linePos)));	    
"break"      => (Tokens.BREAK(		!lineNum, yypos - hd(!linePos)));
"of"         => (Tokens.OF(			!lineNum, yypos - hd(!linePos)));		
"end"        => (Tokens.END(		!lineNum, yypos - hd(!linePos)));
"in"         => (Tokens.IN(			!lineNum, yypos - hd(!linePos)));
"nil"        => (Tokens.NIL(		!lineNum, yypos - hd(!linePos)));
"let"        => (Tokens.LET(		!lineNum, yypos - hd(!linePos)));
"do"         => (Tokens.DO(			!lineNum, yypos - hd(!linePos)));
"to"         => (Tokens.TO(			!lineNum, yypos - hd(!linePos)));	     
"for"        => (Tokens.FOR(		!lineNum, yypos - hd(!linePos)));
"while"      => (Tokens.WHILE(		!lineNum, yypos - hd(!linePos)));
"else"       => (Tokens.ELSE(		!lineNum, yypos - hd(!linePos)));		
"then"       => (Tokens.THEN(		!lineNum, yypos - hd(!linePos)));
"if"         => (Tokens.IF(			!lineNum, yypos - hd(!linePos)));
"array"      => (Tokens.ARRAY(		!lineNum, yypos - hd(!linePos)));	     

[0-9]+       => (Tokens.INT( 
							Option.getOpt(Int.fromString(yytext),0),
									!lineNum, yypos - hd(!linePos)));		 
{alpha}({alpha}|[0-9]|_)* =>  
				(Tokens.ID(yytext, 	!lineNum, yypos - hd(!linePos)));

{str} 		=> (Tokens.STRING(
					substring(yytext,1,size(yytext)-2), 
									!lineNum, yypos - hd(!linePos)));

.            => ((ErrorMsg.error yypos ("illegal character " ^ yytext));
				raise LexerException(!lineNum, yypos - hd(!linePos)));
