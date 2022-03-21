## Summary
The goal of this assignment was to create a functioning parser for the programming language COOL. The lexer is written as a grammar with semantic actions. It becomes a parser using the bison tool, by running the command ‘make parser’. This creates a file called myparser, which can be used to parse a file by doing ./myparser filename.cl. Below we outline how different scenarios were handled in our program, and explain why certain design choices were made. 


## Grammar Rules:
Rules were written in the form nonTerminal : Production1 {SemanticAction1; } | Production 2 {SemanticAction2;} … ;

Grammar outputs an AST. The root node is called program, and is made up of a class list. The class list is a list of classes. Every class is of the form Class TypeID { list of features }; or Class inherits TypeID { list of features }; The features list can be empty of contains features, which are either methods or attributes. A method looks like OBJECTID '(' lst_formal ')' ':' TYPEID '{' expression ‘}’. An attribute looks like OBJECTID ':' TYPEID.  An attribute can also look like OBJECTID ':' TYPEID ASSIGN expression. Expression leads to another set of productions, which are very long, including conditionals, while loop, operators, case, string, int, and boolean options.

The grammar obeys a certain ordering in some cases. For example, class_list must come before class, and lst_feature must come after class. This solves conflicts like shift-reduce conflicts. Some ordering is not important, for example lst_arg could be interchanged in order with let_exp_nested.


## Error Handling and Testing:
Many error handling scenarios are present. As discussed above, the grammar is written to avoid shift-reduce and reduce-reduce conflicts. Because bison uses bottom-up parsing, it is not necessary to left-factor the grammar, we can leave it in ‘natural’ form. 
 
Error testing was done in the bad.cl file and good.cl test files. good.cl tests class declarations, with and without inherits, as well as conditionals, loops, Int and String declarations, assignment, and operations. This automatically tests nonterminals program, class_list, class, lst_feature, method, attr, expression_lst, expression, and let_exp_nested. All grammar rules appear to work correctly. Bad.cl tests similar cases, but with elements in place that should trip up the parser.





	       
