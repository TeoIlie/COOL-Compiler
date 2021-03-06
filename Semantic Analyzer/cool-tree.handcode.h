//
// See copyright.h for copyright notice and limitation of liability
// and disclaimer of warranty provisions.
//
#include "copyright.h"



#ifndef COOL_TREE_HANDCODE_H
#define COOL_TREE_HANDCODE_H

#include "tree.h"
#include "cool.h"
#include "stringtab.h"
#include "symtab.h"                                   /*   ##  */
#define yylineno curr_lineno
extern int yylineno;

inline Boolean copy_Boolean(Boolean b) {return b; }
inline void assert_Boolean(Boolean) {}
inline void dump_Boolean(ostream& stream, int padding, Boolean b)
	{ stream << pad(padding) << (int) b << "\n"; }

void dump_Symbol(ostream& stream, int padding, Symbol b);
void assert_Symbol(Symbol b);
Symbol copy_Symbol(Symbol b);

typedef char* Register;                            /* ## */

class Program_class;
typedef Program_class *Program;
class Class__class;
typedef Class__class *Class_;
class Feature_class;
typedef Feature_class *Feature;
class Formal_class;
typedef Formal_class *Formal;
class Expression_class;
typedef Expression_class *Expression;
class Case_class;
typedef Case_class *Case;

typedef list_node<Class_> Classes_class;
typedef Classes_class *Classes;
typedef list_node<Feature> Features_class;
typedef Features_class *Features;
typedef list_node<Formal> Formals_class;
typedef Formals_class *Formals;
typedef list_node<Expression> Expressions_class;
typedef Expressions_class *Expressions;
typedef list_node<Case> Cases_class;
typedef Cases_class *Cases;

class SymTables;                                     //##
typedef SymTables *SymTabP;                          //##
                                                     //##
class InheritanceNode;                               //##
typedef InheritanceNode *InheritanceNodeP;           //##
                                                     //##
class Environment;                                   //##
typedef Environment *EnvironmentP;                   //##
                                                     //##

#define Program_EXTRAS                          \
virtual InheritanceNodeP semant() = 0; /* ## */ \
virtual void dump_with_types(ostream&, int) = 0; 



#define program_EXTRAS                          \
InheritanceNodeP semant();            /* ## */  \
void dump_with_types(ostream&, int);            

#define Class__EXTRAS                   \
virtual Symbol get_name() = 0;  	\
virtual Symbol get_parent() = 0;    	\
virtual Features get_features() = 0;    \
virtual Symbol get_filename() = 0;      \
virtual void dump_with_types(ostream&,int) = 0; 


#define class__EXTRAS                           \
Symbol get_name()   { return name; }            \
Symbol get_parent() { return parent; }          \
Features get_features() { return features; }    \
Symbol get_filename() { return filename; }      \
void dump_with_types(ostream&,int);                    


#define Feature_EXTRAS                                        \
virtual Symbol get_name() = 0;                  /* ## */      \
virtual void tc(EnvironmentP) = 0;              /* ## */      \
virtual void add_to_table(EnvironmentP) = 0;    /* ## */      \
virtual void dump_with_types(ostream&,int) = 0; 


#define Feature_SHARED_EXTRAS                                       \
Symbol get_name() { return name; }                       /* ## */           \
void tc(EnvironmentP);                                   /* ## */           \
void add_to_table(EnvironmentP);                         /* ## */           \
void dump_with_types(ostream&,int);    


#define method_EXTRAS                                    /* ## */           \
Formals get_formals()     { return formals; }            /* ## */           \
Symbol  get_return_type() { return return_type; }        /* ## */           \
int num_formals()         { return formals->len(); }     /* ## */           \
Formal  sel_formal(int i) { return formals->nth(i); }    /* ## */

#define attr_EXTRAS                                      /* ## */           \
Symbol get_type_decl() { return type_decl; }             /* ## */           \


#define Formal_EXTRAS                              \
virtual Symbol get_type_decl() = 0;                /* ## */ \
virtual Symbol get_name()      = 0;                /* ## */ \
virtual void install_formal(EnvironmentP env) = 0; /* ## */ \
virtual void dump_with_types(ostream&,int) = 0;


#define formal_EXTRAS                           \
Symbol get_type_decl() { return type_decl; }    /* ## */ \
Symbol get_name()      { return name; }         /* ## */ \
void install_formal(EnvironmentP env);          /* ## */ \
void dump_with_types(ostream&,int);


#define Case_EXTRAS                             \
virtual Symbol get_name() = 0;                  /* ## */ \
virtual Symbol get_type_decl() = 0;             /* ## */ \
virtual Expression get_expr() = 0;              /* ## */ \
virtual Symbol tc(EnvironmentP) = 0;            /* ## */ \
virtual void dump_with_types(ostream& ,int) = 0;


#define branch_EXTRAS                                   \
Symbol get_name() { return name; }                    /* ## */ \
Symbol get_type_decl() { return type_decl; }          /* ## */  \
Expression get_expr()  { return expr; }               /* ## */  \
Symbol tc(EnvironmentP env) { return expr->tc(env); } /* ## */  \
void dump_with_types(ostream& ,int);


#define Expression_EXTRAS                    \
virtual Symbol tc(EnvironmentP) = 0;         /* ## */ \
Symbol type;                                 \
Symbol get_type() { return type; }           \
Expression set_type(Symbol s) { type = s; return this; } \
virtual void dump_with_types(ostream&,int) = 0;  \
void dump_type(ostream&, int);               \
Expression_class() { type = (Symbol) NULL; } 


#define Expression_SHARED_EXTRAS           \
Symbol tc(EnvironmentP);                   /* ## */ \
void dump_with_types(ostream&,int); 


#define no_expr_EXTRAS        /* ## */ \


#endif
