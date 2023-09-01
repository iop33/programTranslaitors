// import section
package Parser;

import java_cup.runtime.*;

%%
// declaration section
%class MPLexer
%cup
%function next_token
%line
%column
%debug
%type Symbol
%eofval{
	return new Symbol( sym.EOF);
%eofval}




//states
%state COMMENT
//macros
slovo = [a-zA-Z]
cifra = [0-9]

%%
// rules section
\(\*			{ yybegin( COMMENT ); }
<COMMENT>\*\)	{ yybegin( YYINITIAL ); }
<COMMENT>.		{ ; }

[\t\r\n\s ]		{ ; }
\( { return new Symbol( sym.lp); }
\) { return new Symbol( sym.rp); }
\{ { return new Symbol( sym.lv); }
\} { return new Symbol( sym.rv); }
//operators
&& { return new Symbol( sym.and); }
\|\| { return new Symbol( sym.or); }
\+ { return new Symbol( sym.plus); }
\* { return new Symbol( sym.mul); }
\- { return new Symbol( sym.min); }
\/  { return new Symbol( sym.div); }
\< { return new Symbol( sym.less); }
\<= { return new Symbol( sym.lesse); }
\> { return new Symbol( sym.great); }
\>= { return new Symbol( sym.greate ); }
== { return new Symbol( sym.eq); }
\!= { return new Symbol( sym.neq ); }

//separators
; { return new Symbol( sym.dotcomma ); }
= { return new Symbol( sym.assign); }



//keywords
"main"		{ return new Symbol( sym.main );	}	
"float"			{ return new Symbol( sym._float );	}
"int"		{ return new Symbol( sym._int);	}
"bool"		{ return new Symbol( sym._bool);	}
"char"			{ return new Symbol( sym._char );	}
"input"			{ return new Symbol( sym.input );	}
"output"			{ return new Symbol( sym.output );	}
"if"			{ return new Symbol( sym._if );	}
"else if"			{ return new Symbol( sym._elseif );	}
"else"			{ return new Symbol( sym._else );	}
"while"			{ return new Symbol( sym._while );	}
"for"			{ return new Symbol( sym._for );	}

//id-s
{slovo}+ { return new Symbol(sym.id); }
{slovo}({slovo}|{cifra})*	{ return new Symbol( sym.id); }
({slovo} | _)({slovo}|{cifra}| _ )* { return new Symbol(sym.id); }

//constants
'[^]' { return new Symbol( sym._const); }
{cifra}+ { return new Symbol( sym._const); }
0\.{cifra}+(E[+\-]{cifra}+)? { return new Symbol( sym._const);}
true  { return new Symbol( sym._const ); }
false { return new Symbol( sym._const); }

//error symbol
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }

