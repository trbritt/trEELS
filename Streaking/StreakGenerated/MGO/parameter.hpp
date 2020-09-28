/*
	Author: Tristan Britt
	This files 'parameter.hpp' is the header for
	'parameter.cpp' and contatins all includes and
	prototypes for the member functions defined in that file.
	This file defines a class Parameter that generates an
	analagous linspace vector specifying all the combinations
	of that particular parameter it wants to pass to the Grid
	object and thus include in the overall permutations
	created by that object to compute the result over. (does that make sense? lmao)

	This class is used only in the MGO.exe executable defined by
	'main.cpp'. 
*/
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <algorithm>
#include <cassert>
#ifndef PARAMETERHEADERDEF
#define PARAMETERHEADERDEF
using namespace std;

class Parameter 
{
private:
	double low, high;
	int N;
	vector<double> points;
public:
	string name;
	Parameter(string name, double low, double high, int N);
	Parameter(string name, double low, double high);
	vector<double> get_points();
	void set_points(vector<double>);
	double operator[](int i); // zero-based indexing
	int length();

};

#endif