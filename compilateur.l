%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap

%%
[ \t]+	                            { printf("tespace\n");} 
[\n]+	                            { printf("saut\n");} 
[0-9]+(e[0-9]+)?                    {  yylval.nb = atoi(yytext); return tNB; }
"if"	                            { return tIF; }
"main"	                       		{ printf("tmain\n");return tMAIN; }
"while"	                            { return tWHILE; }
"for"	                            { return tFOR; }
"printf"	                        { return tPRINTF; }
";"	                                { return tSEMC; }
","	                                { return tCOMA; }
"else"	                            { return tELSE; }
"="                                 { return tEQUAL; }  
"-"	                                { return tMINUS; }
"+"	                                { return tADD; }
"*"	                                { return tMUL; }
"=="								{ return tCOMP; }
">"									{ return tCOMPG; }
"<"									{ return tCOMPL; }
"/"	                                { return tDIV; } 
"("	                                { printf("tPO\n");return tPO;  }
")" 	                            { printf("tPC\n");return tPC;  }
"{"	                                { return tBRAO; }
"}" 	                            { return tBRAC;  }
"return"	                        { return tRET; }
"int"	                            { return tINT; }
"const"	                            { return tCONST; }
":"	                                { return tCOL; } 
[a-zA-Z][a-zA-Z0-9_]*	        	{ printf("tID\n");yylval.var = yytext[0]; return tID; }
.	                                { return tERROR;}


%%
/*int main()
{   yylex();
return 1;

}*/
/*yylval.nb = atof(yytext); return tNB;*/
/*strcpy(yylval.var, yytext[0]); return tVAR;*/ 