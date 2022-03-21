/*
 * Teodor Ilie, 20100698
 * Denise Micu, 20061143
 * The scanner definition for COOL.
 */

/*
 * Everything enclosed in %{ %} in the first section is copied verbatim to the
 * output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */

%{

#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

/* ============== Declarations ============================================== */

/* to assemble string constants */
char string_buf[MAX_STR_CONST];
char *string_buf_ptr;

/* to keep track of current line number */
extern int curr_lineno;
extern int verbose_flag;
extern YYSTYPE cool_yylval;

/* make sure we don't go over the Cool string limit */
int str_size = 0;

/* use to deal with nested comments correctly */
int nested_comment = 0;

/* function declarations, initialized at the bottom in subroutines. */
#define OUTPUT_ERROR(message) { \
      cool_yylval.error_msg = (message); \
      return ERROR; \
  }

#define ADD_TO_STR(characters) { \
      if (string_buf_ptr + 1 > &string_buf[MAX_STR_CONST - 1]) { \
          BEGIN(INVALID_STRING); \
          OUTPUT_ERROR("String constant too long"); \
      } \
      *string_buf_ptr++ = (characters); \
  }

%}

/* ============== Definitions =============================================== */

/* State declarations for comments and strings - syntactic sugar. */
%x COMMENT
%x IN_LINE_COMMENT

%x STRING
%x INVALID_STRING

/* Define names for regular expressions here. */
DIGIT          [0-9]
LETTERDIGIT    [a-zA-Z0-9_]

/* OBJECTID must start with a lowecase letter. */
OBJECTID       [a-z]{LETTERDIGIT}*

/* TYPEIS must start with an uppercase letter. */
TYPEID         [A-Z]{LETTERDIGIT}*

LE             <=
ASSIGN         <-
DARROW         =>

%%

 /* ============== Rules ==================================================== */

 /* Rules are in a specific order to ensure that the file is processed correctly
  * by the lexer although some variation of this order would be acceptable. */

 /* Operators and miscellaneous symbols */

"-"              return '-';
"*"              return '*';
"+"              return '+';
"/"              return '/';

"="              return '=';
"<"              return '<';
"."              return '.';
":"              return ':';
"@"              return '@';
"~"              return '~';
","              return ',';
";"              return ';';
"{"              return '{';
"}"              return '}';
"("              return '(';
")"              return ')';

{DARROW}    return DARROW;
{ASSIGN}    return ASSIGN;
{LE}        return LE;

 /* Keywords are not case sensitive, except for true and false,
  * which must always begin with a lower-case letter 't' or 'f'. */

(?i:class)        return (CLASS);

(?i:if)           return (IF);
(?i:fi)           return (FI);
(?i:else)         return (ELSE);
(?i:then)         return (THEN);

(?i:loop)         return (LOOP);
(?i:pool)         return (POOL);

(?i:case)         return (CASE);
(?i:esac)         return (ESAC);

(?i:in)           return (IN);
(?i:inherits)     return (INHERITS);
(?i:let)          return (LET);
(?i:while)        return (WHILE);
(?i:isvoid)       return (ISVOID);
(?i:new)          return (NEW);
(?i:of)           return (OF);
(?i:not)          return (NOT);


t(?i:rue)     {
                 cool_yylval.boolean = true;
                 return (BOOL_CONST);
              }
f(?i:alse)    {
                 cool_yylval.boolean = false;
                 return (BOOL_CONST);
              }

 /* Digit rule */

{DIGIT}+      {
                 cool_yylval.symbol = inttable.add_string(yytext);
                 return INT_CONST;
	            }

 /* TYPEID and OBJECTID have their own rules in Cool.*/

{OBJECTID}    {
                 cool_yylval.symbol = stringtable.add_string(yytext);
                 return (OBJECTID);
              }
{TYPEID}      {
                 cool_yylval.symbol = stringtable.add_string(yytext);
                 return (TYPEID);
              }

 /* String rules. first rule is for starting a string, next for ending a string
  * and resetting the string. Afterwards, other string cases are implemented. */

 /* Valid string rules. */

\"          {
                string_buf_ptr = string_buf;
                BEGIN(STRING);
            }
<STRING>\" {
                cool_yylval.symbol = stringtable.add_string(string_buf);
                *string_buf_ptr = '\0';
                BEGIN(INITIAL);
                return STR_CONST;
}
<STRING>\0 {
                BEGIN(INVALID_STRING);
                OUTPUT_ERROR("String contains null character");
}
<STRING>\\\0 {
                BEGIN(INVALID_STRING);
                OUTPUT_ERROR("String contains null character");
}
<STRING>\n {
                ++curr_lineno;
                BEGIN(INITIAL);
                OUTPUT_ERROR("Unterminated string constant");
}
<STRING><<EOF>> {
                BEGIN(INITIAL);
                OUTPUT_ERROR("EOF in string constant");
}
<STRING>\\b {
                ADD_TO_STR('\b');       /* backspace */
}
<STRING>\\f {
                ADD_TO_STR('\f');       /* formfeed */
}
<STRING>\\t {
                ADD_TO_STR('\t');       /* tab */
}
<STRING>\\n {
                ADD_TO_STR('\n');       /* newline */
}
<STRING>\\\n {
                /* escaped newline */
                ++curr_lineno;
                ADD_TO_STR('\n');

}
<STRING>\\. {
                ADD_TO_STR(yytext[1]);
}
<STRING>[^\\\n\0\"]+ {
                if (string_buf_ptr + yyleng >
                        &string_buf[MAX_STR_CONST - 1]) {
                    BEGIN(INVALID_STRING);
                    OUTPUT_ERROR("String constant too long");
                }
                strcpy(string_buf_ptr, yytext);
                string_buf_ptr += yyleng;
}

 /* Invalid string rules */

<INVALID_STRING>\"          {
                BEGIN(INITIAL);
}
<INVALID_STRING>\n          {
                ++curr_lineno;
                BEGIN(INITIAL);
}
<INVALID_STRING>\\\n        {
                ++curr_lineno;
}
<INVALID_STRING>\\.         {}
<INVALID_STRING>[^\\\n\"]+  {}

 /* Comments */
"--".*                  {}
"*)"                    {
                OUTPUT_ERROR("Unmatched *)"); /* special error */
                }
<INITIAL,COMMENT>"(*"   {
                BEGIN(COMMENT);
                ++nested_comment;
            }
<COMMENT>"*"+")" {
                nested_comment--;
                if (nested_comment == 0) /* if not in a comment */
                    BEGIN(INITIAL);
}
<COMMENT><<EOF>> {
                BEGIN(INITIAL);         /* stops an EOF loop */
                OUTPUT_ERROR("EOF in comment");
}
<COMMENT>\\\n {
                ++curr_lineno;  /* move on the the next line */
}
<COMMENT>\\.|[^(*\\\n]*|"("+[^(*\\\n]*|"*"+[^)*\\\n]* {
                /* ignore gibberish */
}
<COMMENT>\n {
                ++curr_lineno;  /* move on the the next line */
}


 /* Finally, use up whitespace but don't do anything with it, except for
  * returning an error if a '.' is encountered. */

\n+              {
                      curr_lineno += yyleng;
                }

[\v\t\f\r ]+    {}
.               {
	                  OUTPUT_ERROR(yytext);
                }

 /* End of rules section */
%%
