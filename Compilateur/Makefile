GRM=compilateur.y
LEX=compilateur.l
BIN=compilateur

CC=gcc
CFLAGS=-Wall -g

OBJ=y.tab.o lex.yy.o symbol.o util.o main.o

all: $(BIN)

symbol.o: 
	gcc -c symbol.c

util.o: 
	gcc -c util.c

%.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

y.tab.c: $(GRM)
	yacc -d $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(CPPFLAGS) $^ -o $@

clean:
	rm $(OBJ) y.tab.c y.tab.h lex.yy.c compilateur

