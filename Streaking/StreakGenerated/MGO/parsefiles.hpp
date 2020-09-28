/* 
	Author: Tristan Britt
	This file 'parsefiles.hpp' is the header for
	'parsefiles.cpp', and contains the includes and
	all prototypes for the functions in that file.
*/

#include <cmath>
#include <iostream>
#include <fstream>
#include <vector>
#include <cassert>
#include <iostream>
#include <string>
#include <sstream>
#include <cstdint>
#include <filesystem>
#include <boost/math/interpolators/barycentric_rational.hpp>
#include <boost/lexical_cast.hpp>

namespace fs = std::filesystem;

using namespace std;

double get_result(string filename, string parameter, double position);
vector<string> split(string strToSplit, char delimeter);
string get_raw_row(string FILENAME, unsigned int row);
vector<string> filter_row_string(string params);
int get_index(vector<string> v, string K);

bool does_dir_exist(const fs::path& p);

vector<char> get_csv_row(bool firstrow, string param, vector<string> names, vector<double> values, double result);

void clock_function(function<void()> functocall, string& comptime, double& elapsed);

void write_to_file(string dir, vector<string> names, vector<double> params, string param, double result,
	string comptime, double elapsed, int tot_cnt, int procid);
