/*
	Author: Tristan Britt
	This file 'nodes.hpp' is the header file for 
	'nodes.cpp', and includes the includes and prototypes for
	all functions defined in that file. The way these functions
	are used is the following. The root process of MGO.exe
	is the sole accessor of an instance of the class Grid,
	which is in turn generated by instances of the class
	Parameter. The Grid object will contain a series of discrete
	points of each dimension specified by a Parameter object.
	An array of indices is instantiated that is then altered
	according to get_opt, get_next_opt, and increase by the
	root process and thus scattered to all other processesin
	MPI_COMM_WORLD. The array of indices determines the nex
	combination (as needed) so that all combinations of 
	the linspaces generated by the Parameter objects 
	is calculated.

*/
#include <vector>
#include <iostream>
#include <boost/lexical_cast.hpp>
#include <cassert>
using namespace std;

void print_curr_opt(const vector<vector<double>>& v, vector<size_t>& it);

void increase(const vector<vector<double>>& v, vector<size_t>& it);

vector<double> get_opt(const vector<vector<double>>& v, vector<size_t>& it);

vector<double> get_next_opt(const vector<vector<double>>& v, vector<size_t>& it);

string get_cmd(vector<string> names, vector<double>& v1, bool fullcmd);

