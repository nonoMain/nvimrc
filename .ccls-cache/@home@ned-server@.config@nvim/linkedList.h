#ifndef LINKEDLISTH
#define LINKEDLISTH

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define ZERO 0
#define FALSE 0
#define TRUE !FALSE

// Frame struct
typedef struct Frame
{
	char* name;
	unsigned int duration;
	char* path;
} Frame;

// Link (node) struct
typedef struct FrameNode
{
	Frame* frame;
	struct FrameNode* next;
} FrameNode;

/*
adds the node to the end of an existing list or creates a new list
input: pointer to the start of the list, pointer of node to add
output: None.
*/
void insertAtEnd(FrameNode** head, FrameNode* newNode);
/*
removes a frame with a given name
input: pointer to the start of the list, name of frame to remove
output: whether a frame was found and deleted or not
*/
int removeFrame(FrameNode** head, const char* name);
/*
moves a frame with a given name to a given index
input: pointer to the start of the list, name of frame to move, index to move node to
output: None.
*/
void moveFrame(FrameNode** head, const char* name, int index);
/*
sets the duration a frame with a given name to a new one from the user
input: pointer to the start of the list, name of frame to change his duration
output: None.
*/
void setDuration(FrameNode* head, const char* name);
/*
sets the duration of all frames to a new one from the user
input: pointer to the start of the list
output: None.
*/
void setDurationForAll(FrameNode* head);
/*
prints a given list
input: pointer to the start of the list
output: None.
*/
void printList(FrameNode* head);
/*
allocates memory for a new node and resets the params to 'NULL'
input: None.
output: pointer to the new node
*/
FrameNode* createNode();
/*
initializes a node with given values
input: the node to initialize, name of the frame, duration to show frame, path to the image
output: None.
*/
void initNode(FrameNode* node, char** name, unsigned int duration, char** path);
/*
reverse the order of the linked list
input: pointer to the start of the list
*/
void reverse(FrameNode** head);
/*
frees the memory of a given list
input: pointer to the start of the list
output: None.
*/
void freeList(FrameNode** head);
/*
looks for a frame with the given name
input: pointer to the start of the list, name to look for
output: whether a frame was found or not
*/
int findName(FrameNode* head, const char* nameToFind);

#endif
