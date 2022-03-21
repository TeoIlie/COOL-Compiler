(* Move fast and break things *)
Class A {
	a : Int;
	b : Int;
	c : Object;
	d : Bool;
	e : Bool;
	f : Object;
	g : String;
	h : String;
	i : Object;
	num : Int <- 0;

	init(j : Int, k : Int, l : Bool, m: Bool, n : String, o : String) : A {
		{
		a <- j;
		b <- k;
		e <- l;
		d <- a - b; -- test assign_class error
 		a <- d - e; -- test sub_class error
		a <- d * e; -- test mul_class error
		a <- d / e; -- test div_class error
		f <- j = l; -- test eq_class error
		a <- p; -- test object_class and assign_class error
		self;
		}
	};

	func1(): Object {
		-- test comp_class error
		if num then 1 else 0 fi
	};	

	func2(): Object {
		-- test loop_class error
		while num loop num <- 0 pool
	};

	func3(): Object {
		-- test lt_class error
		if a < e then 1 else 0 fi 
	};

	func4(): Object {
		 -- test leq_class error
		if a <= e then 1 else 0 fi
	};

	func5(): Object {
		-- test typcase_class error
		case num of  
			x : A => num <- 2;
			y : B => num <- 3;
      	esac
	};
};

Class Main inherits IO {
    main() : Object {
	{
		(new A).init(1, 2, true, true, "a", "b");
		(new B); -- test new__class error 
	}
    };
};


