## Summary
The scope of this assignment was to create a lexical analyzer for the programming language COOL. The lexer is written in flex, structured in this order: declarations, definitions, and rules. No user subroutines were used, instead, some helper functions were initialized at the top of the file. Below we outline how different scenarios were handled in our program, and explain why certain design choices were made. 


States Used to keep track of Location:
COMMENT
IN_LINE_COMMENT
STRING
INVALID_STRING

COMMENT was used to keep track of whether or not we are in a comment state, which is between “(*” and “*)”. The global variable nested_comment was used to keep track of how deep we are in a nested comment section. IN_LINE_COMMENT was used to track single line comments, which start with “—“. STRING was used to track valid strings, and INVALID_STRING was used to track the state of being in an invalid string.


## Rule Prioritization:
Rules were written in an order such that the higher priority rules are at the top. For example, keywords are higher up than strings, so they are parsed as keywords instead of strings. Whitespace is at the the bottom of the rules section. 

Rule precedent was also used within sections, particularly string and comment rules. For example, the rule for taking the first character of a string, a double quote, was placed before the rest. Comments used a similar prioritization, with a difference being that the rule for a closed comment “*)” was placed first to check for the “Unmatched *” error.


## Error Handling:
Multiple error handling scenarios are present in our program, such as nested comments, null in comment, bad identifiers, and others. Two functions are initialized at the top of the program, OUTPUT_ERROR and ADD_TO_STR for error handling, and code cleanliness. OUTPUT_ERROR was created to return an error message when errors were identified, and to return the ERROR token. ADD_TO_STR adds characters to a string, checks if its not too long, and adds the characters to the string buffer pointer varivale. Special care was taken with the EOF in comment error, which uses BEGIN(INITIAL) first to stop an infinite loop which was happening in testing. 
 
Error testing was done in the test.cl file to ensure all error types were caught.





	       
