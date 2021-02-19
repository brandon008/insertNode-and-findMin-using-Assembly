CC=gcc


all:	assign3

assign3:	assignment3.o binary_search_tree.o bin.o
	gcc -o assign3 assignment3.o binary_search_tree.o bin.o






