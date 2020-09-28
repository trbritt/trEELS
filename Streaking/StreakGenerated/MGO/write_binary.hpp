#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "zlib.h"

// link the static lib
unsigned long file_size(char* filename);
int decompress_one_file(char* infilename, char* outfilename);
int compress_one_file(char* infilename, char* outfilename);
