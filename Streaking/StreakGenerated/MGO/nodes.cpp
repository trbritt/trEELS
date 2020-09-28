/*
	Author: Tristan Britt
	This files 'nodes.cpp' contains the definitions for all the functions
	prototyped in the appropraite header. See 'nodes.hpp' for an
	explanation of how these functions are used.
*/
#include "nodes.hpp"

using namespace std;

void print_curr_opt(const vector<vector<double>>& v, vector<size_t>& it)
{
	for (size_t i = 0, size = v.size(); i != size; ++i) {
		cout << v[i][it[i]] << " ";
	}
	cout << " : ";
	for (size_t i = 0, size = v.size(); i != size; ++i) {
		cout << it[i] << " ";
	}
	cout << endl;
}

void increase(const vector<vector<double>>& v, vector<size_t>& it)
{
	for (size_t i = 0, size = it.size(); i != size; ++i) {
		const size_t index = size - 1 - i;
		++it[index];
		if (it[index] == v[index].size()) {
			it[index] = 0;
		}
		else {
			return;
		}
	}
}

vector<double> get_opt(const vector<vector<double>>& v, vector<size_t>& it)
{
	vector<double> p;
	for (size_t i = 0, size = v.size(); i != size; ++i) {
		p.push_back(v[i][it[i]]);
	}
	return p;
}


vector<double> get_next_opt(const vector<vector<double>>& v, vector<size_t>& it)
{
	increase(v, it);
	return get_opt(v, it);
}

string get_cmd(vector<string> names, vector<double>& v1, bool fullcmd)
{
	string cmd = "";
	assert(names.size() == v1.size());
	for (int j = 0; j < (int)v1.size(); ++j) {
		//cout << v1[j] << " ";
		cmd.append(names[j]);
		cmd.append("=");
		cmd.append(boost::lexical_cast<string>(v1[j]));
		cmd.append(" ");
	}
	if (fullcmd) cmd.append("N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2");
	return cmd;
}

