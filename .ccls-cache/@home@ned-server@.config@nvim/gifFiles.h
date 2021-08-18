#ifndef GIFFILESH
#define GIFFILESH

#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "linkedList.h"

#define ZERO 0
#define FALSE 0
#define TRUE !FALSE
#define COLUMN ','
#define NEWLINE '\n'
#define READMODE "r"
#define WRTIEMODE "w"

#define MAX_VALUE_SIZE 400

#define AMOUNT_OF_VARIABLES_IN_FRAME 3

#define NAME_INDEX 0
#define DURATION_INDEX 1
#define PATH_INDEX 2

/*
writes a project (linked list of frames) to a file
input: file path, pointer to head of the list.
output: whether it wrote or not
*/
int writeList(const char* fpath, FrameNode* head);
/*
Loads a project from a file
input: path to a possible file to load from
output: pointer to head of the loaded list
*/
FrameNode* loadList(const char* fpath);
/*
checks if a file exists in a given file path
input: path to the possible file
output: whether there is a file or not
*/
int fileExists(const char* fpath);

#endif

