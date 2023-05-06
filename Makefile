BISON = bison
BMM_DSYM_FOLDER = bmm.dSYM
CC = gcc
CFLAGS = -g -ll
FLEX = flex
LEX_C_FILE = BMM_Scanner.yy.c
LEX_FILE = BMM_Scanner.l
OUTPUT_FILE = bmm
YACC_C_FILE = BMM_Parser.tab.c
YACC_FILE = BMM_Parser.y
YACC_H_FILE = BMM_Parser.tab.h

.PHONY: all clean lexer

all: $(OUTPUT_FILE)
	@./$(OUTPUT_FILE) $(INPUT_FILE)

$(OUTPUT_FILE): $(LEX_C_FILE) $(YACC_C_FILE)
	@$(CC) $(CFLAGS) $^ -o $@

lexer: $(LEX_C_FILE)
	@$(CC) $(CFLAGS) $^ -o $(OUTPUT_FILE)
	@./$(OUTPUT_FILE) $(INPUT_FILE)

$(LEX_C_FILE): $(LEX_FILE)
	@$(FLEX) -o $@ $^

$(YACC_C_FILE) $(YACC_H_FILE): $(YACC_FILE)
	@$(BISON) -d $^

clean:
	@rm -rf $(BMM_DSYM_FOLDER) $(LEX_C_FILE) $(OUTPUT_FILE) $(YACC_C_FILE) $(YACC_H_FILE)