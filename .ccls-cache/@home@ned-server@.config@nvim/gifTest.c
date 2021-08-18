
#include "gifFiles.h"


/*
writes a project (linked list of frames) to a file
input:
	fpath <const char*> - path to a possible file to write to
	head <FrameNode*> - pointer to head of the list
output:
	ans <int> - whether it wrote or not
*/
int writeList(const char* fpath, FrameNode* head)
{
	FrameNode* tmp = NULL;
	FILE* fp = fopen(fpath, WRTIEMODE);
	if (!fp)
	{
		printf("file wasn't found!");
		return FALSE;
	}
	else
	{
		printf("writing to %s\n", fpath);
		tmp = head;
		while (tmp)
		{
			fprintf(fp, "%s,%u,%s\n", tmp->frame->name, tmp->frame->duration, tmp->frame->path);
			tmp = tmp->next;
		}
	}
	fclose(fp);
	return TRUE;
}

/*
Loads a project from a file
input:
	fpath <const char*> - path to a possible file to load from
output:
	head <FrameNode*> - pointer to head of the loaded list
*/
FrameNode* loadList(const char* fpath)
{
	int i = ZERO;
	int param = ZERO;
	char ch = ZERO;
	char str[MAX_VALUE_SIZE] = { ZERO };
	FILE* fp = NULL;
	FrameNode* head = NULL;
	FrameNode* tmp = NULL;
	fp = fopen(fpath, READMODE);
	if (!fp)
	{
		printf("File didn't load\a\n");
		exit(EXIT_FAILURE);
	}
	while (ch != EOF) // catch all frames
	{
		tmp = createNode();
		for (param = ZERO; param < AMOUNT_OF_VARIABLES_IN_FRAME; param++) // catch all 3 params
		{
			i = ZERO;
			ch = ZERO;
			while (ch != COLUMN && ch != NEWLINE && ch != EOF) // catch param
			{
				ch = fgetc(fp);
				if (ch != COLUMN && ch != NEWLINE && ch != EOF)
				{
					str[i] = ch;
					i++;
				}
			}

			if (ch != EOF)
			{
				switch (param) // act based on type of param
				{
					case NAME_INDEX:
						if (findName(head, str))
						{
							printf("Error in file, found multiple frames with same name <%s>.\a\n", str);
							freeList(&head);
							exit(EXIT_FAILURE);
						}
						tmp->frame->name = (char*)malloc(sizeof(char) * strlen(str) + 1);
						strcpy(tmp->frame->name, str);
						break;

					case DURATION_INDEX:
						if (atoi(str) < ZERO)
						{
							printf("Error in file, found negative duration for frame <%s> (in frame named %s).\a\n", str, tmp->frame->name);
							freeList(&head);
							exit(EXIT_FAILURE);
						}
						tmp->frame->duration = atoi(str);
						break;

					case PATH_INDEX:
						if (!fileExists(str))
						{
							printf("Error in file, found invalid path <%s> (in frame named %s).\a\n", str, tmp->frame->name);
							freeList(&head);
							exit(EXIT_FAILURE);
						}
						tmp->frame->path = (char*)malloc(sizeof(char) * strlen(str) + 1);
						strcpy(tmp->frame->path, str);
						break;
				}
				memset(str, ZERO, MAX_VALUE_SIZE);
			}
		}
		if (ch != EOF)
		{
		insertAtEnd(&head, tmp);
		}
	}
	fclose(fp);
	printf("Project loaded successfully\n");
	return head;
}


/*
checks if a file exists in a given file path
input:
	fpath <const char*> - path to the possible file
output:
	ans <int> - whether there is a file or not
*/
int fileExists(const char* fpath)
{
	FILE* file = NULL;
	if ((file = fopen(fpath, READMODE)))
	{
		fclose(file);
		return TRUE;
	}
	return FALSE;
}

