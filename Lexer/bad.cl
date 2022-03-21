
(*
 *  execute "coolc bad.cl" to see the error messages that the coolc parser
 *  generates
 *
 *  execute "myparser bad.cl" to see the error messages that your parser
 *  generates
 *)

(* no error *)
class A {
};

(* error:  b is not a type identifier *)
Class b inherits A {
};

(* error:  a is not a type identifier *)
Class C inherits a {
};

(* error:  keyword inherits is misspelled *)
Class D inherts A {
};

(* error:  closing brace is missing *)
Class E inherits A {
;

(* error:  closing semi colon is missing *)
Class F {
}

(* error:  incorrect expression *)
Class G {
  ;
}

(* error:  incorrect conditional *)
Class G {
  if true then 1 else 0 -- test if statement
}

(* error:  incorrect conditional *)
Class G {
  if true 1 else 0 fi -- test if statement
}

(* error:  incorrect loop *)
Class H {
	while num = 0 loop num <- 0 -- test while loop
};

(* error:  incorrect loop *)
Class I {
	while num = 0 num <- 0 pool -- test while loop
};
