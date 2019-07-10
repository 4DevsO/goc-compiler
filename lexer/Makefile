# Project Name
PROJ_NAME=parser

# Source Codes
LEX_SOURCE=$(wildcard src/*.l)
BISON_SOURCE=$(wildcard src/*.y)

# Input Files
IN_FILES=$(wildcard src/*.in)

# Compilers
CC=gcc
LEX=flex
BISON=bison

#
# Compiling
#

all:
	$(BISON) -d $(BISON_SOURCE)
	$(LEX) -o $(PROJ_NAME).yy.c $(LEX_SOURCE)
	$(CC)  -o $(PROJ_NAME) $(PROJ_NAME).yy.c parser.tab.c
	rm -rf $(PROJ_NAME).yy.c parser.tab.*

clean:
	rm -rf $(PROJ_NAME)
