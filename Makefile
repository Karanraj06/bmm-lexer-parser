a.out: lex.yy.c y.tab.c
	@gcc -ll bmm_main.c lex.yy.c y.tab.c

lex.yy.c:
	@flex bmm_scanner.l

y.tab.c:
	@bison -dy bmm_parser.y

clean:
	@rm a.out lex.yy.c y.tab.c y.tab.h