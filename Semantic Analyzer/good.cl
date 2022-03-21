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
	p : Int;
	q : Int;
	num : Int <- 0;

	init(j : Int, k : Int, l : Bool, m: Bool, n : String, o : String) : A {
		{
		a <- j;
		b <- k;
		c <- a - b; -- test sub_class
		p <- a * b; -- test mul_class
		q <- a / b; -- test divide_class
		d <- l;
		e <- m;
		f <- d = e; -- test comp_class
		self;
		}
	};

	func1(): Object {
		if isvoid(true) then 1 else 0 fi -- test cond_class and isvoid_class
	};	

	func2(): Object {
		while num = 0 loop num <- 0 pool -- test loop_class
	};

	func3(): Object {
		if a = b then 1 else 0 fi -- test eq_class on Ints
	};

	func4(): Object {
		if d = e then 1 else 0 fi -- test eq_class on Bools
	};

	func5(): Object {
		if a < b then 1 else 0 fi -- test lt_class
	};

	func6(): Object {
		if a <= b then 1 else 0 fi -- test leq_class
	};

	func7(): Object {
		case num of -- test typcase_class 
			x : A => num <- 2;
      	esac
	};
};

Class Main inherits IO {
    main() : Object {
	{
		-- the method call below tests static_dispatch_class and formal_class
		(new A).init(1, 2, true, true, "a", "b"); -- test bool_const_class, string_const_class
	}
    };
};


