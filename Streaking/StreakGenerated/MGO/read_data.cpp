#include "zlib.h"
#include <iostream>
#include <fstream>
#include <string>
#define LENGTH 0x1000

int main(int argc, char* argv[])
{
    const char* file_name = argv[1];
    gzFile file;
    file = gzopen(file_name, "rb9");
    while (1) {
        int err;
        int bytes_read;
        unsigned char buffer[LENGTH];
        bytes_read = gzread(file, buffer, LENGTH - 1);
        buffer[bytes_read] = '\0';
        printf("%s", buffer);
        if (bytes_read < LENGTH - 1) {
            if (gzeof(file)) {
                break;
            }
            else {
                const char* error_string;
                error_string = gzerror(file, &err);
                if (err) {
                    fprintf(stderr, "Error: %s.\n", error_string);
                    exit(EXIT_FAILURE);
                }
            }
        }
    }
    gzclose(file);
}