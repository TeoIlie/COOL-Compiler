# COOL-Compiler
## Intro
Compiler for the COOL language, including lexer, parser, and semantic analyzer. COOL stands for Classroom Object Oriented Language, and was developed by Alexander Aiken to help students learn compilers: https://www.google.com/url?https://theory.stanford.edu/~aiken/software/cool/cool-manual.pdf

## Lexer
The responsibility of the lexer is to break the input code into tokens, or 'lexemes.' 

## Parser
The parser takes the ouput from the lexer and creates an Abstract Syntax Tree.
<img width="583" alt="image" src="https://user-images.githubusercontent.com/71099741/159322107-e55590f4-0f1e-4850-9a58-770f9203791e.png">

## Semantic Analyzer
The semantic analzyer takes the output from the parser and annotates it with semantic actions, as well as doing type checking.
<img width="607" alt="image" src="https://user-images.githubusercontent.com/71099741/159321293-740fe0e1-aed4-4e64-b883-6ee3d257f952.png">
