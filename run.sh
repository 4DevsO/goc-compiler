rm parser.tab.c
rm parser.tab.h
rm parser.yy.c
rm my_compiler
bison -d src/parser.y
flex -o parser.yy.c src/lexer.l
gcc -o my_compiler parser.yy.c parser.tab.c -lfl

./my_compiler < examples/case01
./my_compiler < examples/case02

./my_compiler < t