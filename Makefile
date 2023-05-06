a.out: BMM_Scanner.yy.c BMM_Parser.tab.c
	@gcc -ll BMM_Scanner.yy.c BMM_Parser.tab.c

BMM_Scanner.yy.c: BMM_Scanner.l
	@flex -o BMM_Scanner.yy.c BMM_Scanner.l

BMM_Parser.tab.c: BMM_Parser.y
	@bison -d BMM_Parser.y

.PHONY: clean
clean:
	@rm *.out *.tab.c *.tab.h *.yy.c