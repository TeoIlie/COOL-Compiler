Class A { -- test class
 
num : Int <- 0; -- test int declaration, and attribute in feature rule
str : String; -- test String declaration, without value
 
func1(): Int { -- test function declaration, and method in feature rule
	(let x:Int <- 1 in 2)+3
};

func2(): String {
	if true then 1 else 0 fi -- test if statement
};	

func3(): String {
	while num = 0 loop num <- 0 pool -- test while loop
};	

func4(): Int {
	num <- 2 * 2
};
};

Class B inherits A { -- test inherited class, and class_list rule 
};
