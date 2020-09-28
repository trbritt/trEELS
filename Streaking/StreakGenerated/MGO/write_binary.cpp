// Demonstration of zlib utility functions
#include "write_binary.hpp"

unsigned long file_size(char* filename)
{
	FILE* pFile;// = fopen(filename, "rb");
	fopen_s(&pFile, filename, "rb");
	fseek(pFile, 0, SEEK_END);
	unsigned long size = ftell(pFile);
	fclose(pFile);
	return size;
}

int decompress_one_file(char* infilename, char* outfilename)
{
	gzFile infile = gzopen(infilename, "rb");
	FILE* outfile;// = fopen(outfilename, "wb");
	fopen_s(&outfile, outfilename, "wb");
	if (!infile || !outfile) return -1;

	char buffer[128];
	int num_read = 0;
	while ((num_read = gzread(infile, buffer, sizeof(buffer))) > 0) {
		fwrite(buffer, 1, num_read, outfile);

	}

	gzclose(infile);
	fclose(outfile);
}

int compress_one_file(char* infilename, char* outfilename)
{
	FILE* infile;// = fopen(infilename, "rb");
	fopen_s(&infile, infilename, "rb");
	gzFile outfile = gzopen(outfilename, "wb");
	if (!infile || !outfile) return -1;

	char inbuffer[128];
	int num_read = 0;
	unsigned long total_read = 0, total_wrote = 0;
	while ((int)(num_read = fread(inbuffer, 1, sizeof(inbuffer), infile)) > 0) {
		total_read += num_read;
		gzwrite(outfile, inbuffer, num_read);

	}
	fclose(infile);
	gzclose(outfile);

	printf("Read %lu bytes, Wrote %lu bytes, Compression factor % 4.2f pc \n", total_read, file_size(outfilename), (1.0 - file_size(outfilename) * 1.0 / total_read) * 100.0);
}

//
//int main(int argc, char** argv)
//{
//	compress_one_file(argv[1], argv[2]);
//	decompress_one_file(argv[2], argv[3]);
//}