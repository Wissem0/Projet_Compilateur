/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tFL = 258,
    tEQUAL = 259,
    tPO = 260,
    tPC = 261,
    tMINUS = 262,
    tADD = 263,
    tDIV = 264,
    tMUL = 265,
    tMAIN = 266,
    tWHILE = 267,
    tFOR = 268,
    tBRAO = 269,
    tBRAC = 270,
    tRET = 271,
    tSEMC = 272,
    tELSE = 273,
    tINT = 274,
    tCONST = 275,
    tCOL = 276,
    tERROR = 277,
    tCOMP = 278,
    tCOMPG = 279,
    tCOMPL = 280,
    tCOMA = 281,
    tPRINTF = 282,
    tNB = 283,
    tIF = 284,
    tID = 285
  };
#endif
/* Tokens.  */
#define tFL 258
#define tEQUAL 259
#define tPO 260
#define tPC 261
#define tMINUS 262
#define tADD 263
#define tDIV 264
#define tMUL 265
#define tMAIN 266
#define tWHILE 267
#define tFOR 268
#define tBRAO 269
#define tBRAC 270
#define tRET 271
#define tSEMC 272
#define tELSE 273
#define tINT 274
#define tCONST 275
#define tCOL 276
#define tERROR 277
#define tCOMP 278
#define tCOMPG 279
#define tCOMPL 280
#define tCOMA 281
#define tPRINTF 282
#define tNB 283
#define tIF 284
#define tID 285

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 14 "compilateur.y"
 int nb; char *var; 

#line 120 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
