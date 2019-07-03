# Project Name
PROJ_NAME=lexer

# Source Codes
LEX_SOURCE=$(wildcard src/*.l)

# Input Files
IN_FILES=$(wildcard src/*.in)

# Compilers
CC=gcc
LEX=flex

#
# Compiling
#

all:
	$(LEX) -o $(PROJ_NAME).yy.c $(LEX_SOURCE)
	$(CC) $(PROJ_NAME).yy.c -o $(PROJ_NAME)
	rm -rf $(PROJ_NAME).yy.c

clean:
	rm -rf $(PROJ_NAME)
