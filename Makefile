p1:
	mix escript.build && time ./gcj 1 < p1.in.txt > p1.out.txt
p2:
	mix escript.build && time ./gcj 2 < p2.in.txt > p2.out.txt
