class Main inherits IO {
   main(): SELF_TYPE {
	out_string("Hello, World.\n")
     };
  };

	-- This is a comment test.

  -- Test booleans
	true
  tRuE
	tRUE
	True
  false
  fALSE
  faLsE
  False

  -- Test operators, symbols
  -
  *
  @
  # --error
  (
  )
  ;

  -- Test LETTERDIGIT, DIGIT, OBJECTID, TYPEID
  0
  9
  100
  oBJECTDID
  OBJECTDID
  tYPEID
  TYPEID
  <=
  <-
  =>

  -- Test keywords
  CLASS
  class
  cLaS
  WHILE
  LOOP
  NOT

  -- Test strings
  "This is a string"
  -- the following string is too long
  "ststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststststTOOLONG"
  -- the string below has an unterminated error
  "Unterminated string \n

  -- Test comments
  (* This is a valid comment *)
  (*(* This is a valid nested comment *)*)
  *)  -- This is an unmatched close comment error
      -- Below is an EOF in comment error
  (*
