# A3: Semantic Analysis

## Summary
The goal of this assignment was to implement the 3rd part of the Cool compiler, which is semantic analysis. So far, the previous two assignments covered lexing and parsing. The next step is to take the AST from the parser output and annotate it with types using type checking. Previous passes that inspect classes and build symbol tables were already implemented. The primary task was to complete the code implementing inference rules for various type-checking methods, as well as the install_formal function. 

The final semantic analyzer was tested against the reference semantic analyzer in /home/compilers/cool/bin to ensure the annotated ASTs look the same, according to 
https://discord.com/channels/928849746322419764/933074767098052630/952771143998259280. 


## Semantic Analysis Description
The primary goal of this assignment was to write code for each class expression outlining the type checking rules, called tc(). These were all based on the Cool manual, but translated into C code.

1. formal_class::install_formal: Ensures that the type declaration is not SELF_TYPE, the formal parameter is defined, the name is not ‘self’ and it is not multiply defined. Add the variable to the table.
2. bool_const_class::tc we assume that the type is Bool.
3. string_const_class::tc we assume the type is Str.
4. sub_class::tc ensure both expressions have Int type for subtraction.
5. mul_class::tc basically same as sub_class -> ensure both are Ints for multiplication.
6. divide_class::tc division needs to have 2 Ints. 
7. neg_class::tc primitive logical negation is type Int.
8. lt_class::tc less than class requires 2 Int’s to compare and returns a Bool.
9. leq_class::tcc similar to above; less than or equal compares 2 Int’s, and returns a Bool. 
10. comp_class::tc compare class takes a Boolean e1 and returns a type Bool.
11. object_class::tc object class makes sure the identifier is declared, and then returns the type from the var_lookup function that searches the symbol table.
12. isvoid_class::tc a test of isvoid always has type Bool.
13. eq_class::tc ensures you check an Int with an Int, or Bool with a Bool, but not Int with Bool. Returns a Bool result.
14. assign_class::tc ensures the name is not ‘self’, that the name exists in var_lookup, and that the class is declared correctly. type_leq ensures the class is a child class, so that it has all the required attributes and methods.
15. static_dispatch_class::tc this is the most complex type check method. like regular dispatch_class above it, each subexpression is type-checked first. The types of arguments in the dispatch must conform to the declared types for arguments. The result type may be the type of the first expression or SELF_TYPE. Static dispatch differs because only the type T_0 must conform to T, for class T of method f given to dispatch. Assertions are: type_name cannot be SELF_TYPE, class must be defined, the expression must conform to static dispatch type, the method must be defined, the method has the correct number of arguments, and method parameters must conform to declared types.
16. cond_class::tc  checks conditionals and ensures the predicate is Bool. returns type using type_lub, which uses the least upper bound function.
17. loop_class::tc checks loop condition is type Bool, and returns type Object.
18. typcase_class::tc checks case statements. Each branch is type-checked. Type of the entire case is the join of the cases, again using type_lub. Errors are duplicate branch, class not defined in a statement, name == self, and SELF_TYPE in case branch. 


## Error Handling and Testing:
Many error handling scenarios exist in the code. Error messages were written to provide some information as to what the type of error was, for example, the plus_class error message explains that the arguments are Non-Int. 

The strategy for testing was to match the error messages with reference semantic analyzer error messages. Code was written in a semantically correct fashion in good.cl, by testing it on the refsemant. Next, semant.cc was tested for correctness by analyzing the AST output and making sure the semantic analyzer had inferred the correct types - same as the refsemant. Next, code was ‘broken’ to trigger errors with the refparser. Then, mysemant was tested to output the same errors, sometimes with slightly different wording.





	       
