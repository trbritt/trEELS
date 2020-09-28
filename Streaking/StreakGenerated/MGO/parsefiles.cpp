/*
	Author: Tristan Britt
	This file 'parsefiles.cpp' contains the definitions
	for all functions invovled in parsing the human readable
	output for a given GPT run via GDF2A. The main function
	here is get_result(), which is the driver function for a method
	in the MGOSingleRun class, which returns the double of
	the value requested. All other functions are either
	exxtracing a row from the file, processing the 
	string, or formatting.
*/
#include "parsefiles.hpp"

using namespace std;

double get_result(string FILENAME, string parameter, double position) {
	const unsigned int row_params = 24;
	string params = get_raw_row(FILENAME, row_params);
	vector<string> params_new = filter_row_string(params);
	int idx_param = get_index(params_new, parameter);
	if (idx_param < 0) {
		cout << "Parameter not found: defaulting to first spatial component." << endl;
		idx_param = 1;
	}
	int idx_z = get_index(params_new, "avgz");
	const unsigned int array_size = 41;
	vector<double> z;
	vector<double> p;
	unsigned int j = 0;
	for (int i = row_params + 2; i < row_params + array_size; ++i) {
		string tmp = get_raw_row(FILENAME, i);
		vector<string> tmps = filter_row_string(tmp);
		string::size_type szz;     // alias of size_t
		z.push_back(stod(tmps[idx_z].c_str(), &szz));
		p.push_back(stod(tmps[idx_param].c_str()));
	}
	const unsigned int sz = (int)z.size();
	boost::math::barycentric_rational<double> b(z.data(), p.data(), sz);
	//cout << "Interpolated value param(" << position << ") = " << b(position) << ". " << endl;
	return b(position);
}


string get_raw_row(string FILENAME, unsigned int row) {

	ifstream file(FILENAME);
	unsigned int cnt = 1;
	string p = "";
	unsigned int end = 0;
	if (file.is_open()) {
		string line;
		while (getline(file, line) && end == 0) {
			// using printf() in all tests for consistency
			if (cnt == row) {
				/*    printf("%s", line.c_str());
					cout << endl;*/
				p = line.c_str();
				end = 1;
			}

			++cnt;
		}
		file.close();
	}
	return p;

}

vector<string> filter_row_string(string params) {
	unsigned int i = 0;
	unsigned int check = 0;
	string newstr = "";
	while (params[i]) {
		char c = params[i];
		if (isspace(c) && check == 0) {           //check spaces
			newstr.push_back(params[i]);
			check = 1;
		}
		else if (isalnum(c) || ispunct(c) ) {                //check alphabets and numbers
			newstr.push_back(params[i]);
			check = 0;
		}
		i++;
	}
	vector<string> pn = split(newstr, ' ');
	return pn;
}


/*
string split implementation by using delimeter as a character.
*/
vector<string> split(string strToSplit, char delimeter)
{
	stringstream ss(strToSplit);
	string item;
	vector<string> splittedStrings;
	while (getline(ss, item, delimeter))
	{
		splittedStrings.push_back(item);
	}

	return splittedStrings;
}

int get_index(vector<string> v, string K)
{
	auto it = find(v.begin(),
		v.end(), K);

	// If element was found 
	if (it != v.end()) {
		// calculating the index 
		// of K 
		int index = (int)distance(v.begin(),
			it);
		return index;
	}
	else {
		// If the element is not 
		// present in the vector 
		return (int)-1;
	}
}


bool does_dir_exist(const fs::path& p)
{
	fs::file_status s = fs::file_status{};
	if (fs::status_known(s) ? fs::exists(s) : fs::exists(p))
		return true;
	else
		return false;
}

vector<char> get_csv_row(bool firstrow, string param, vector<string> names, vector<double> values, double result)
{
	assert(names.size() == values.size());
	string res = "";

	if (firstrow) {
		for (size_t i = 0; i < names.size(); ++i) {
			res.append(names[i]);
			res.append(",");
		}
		res.append(param);
		res.append("\n");
	}
	else {
		for (size_t i = 0; i < names.size(); ++i) {

			res.append(boost::lexical_cast<string>(values[i]));
			res.append(",");
		}
		res.append(boost::lexical_cast<string>(result));
		res.append("\n");
	}
	vector<char> out(res.begin(), res.end());
	out.push_back('\0');
	return out;
}


void clock_function(function<void()> functocall, string& comptime, double& elapsed) 
{
	auto start = chrono::system_clock::now();
	functocall();
	auto end = chrono::system_clock::now();
	chrono::duration<double> elapsed_s = end - start;
	time_t end_time = chrono::system_clock::to_time_t(end);
	char str[26];
	ctime_s(str, sizeof(str), &end_time);

	comptime = str;
	elapsed = elapsed_s.count();

}

void write_to_file(string dir, vector<string> names, vector<double> params, string param, double result, string comptime, double elapsed, int tot_cnt, int procid)
{
	assert(names.size() == params.size());
	// Create and open a text file
	string filename = dir;
	filename.append("/GPT_");
	filename.append(boost::lexical_cast<string>(tot_cnt));
	filename.append(".dat");
	ofstream fh(filename);
	fh << "######################################" << endl;
	fh << "# BOF" << endl;
	fh << "######################################" << endl;
	fh << "ProcID: " << procid << endl;
	fh << "Timestamp: " << comptime << endl;
	fh << "Elapsed computation time: " << elapsed << " s" << endl;
	for (size_t i = 0; i < names.size(); ++i) {
		fh << names[i] << " " << params[i] << endl;;
	}
	fh << param << " "<< result << endl;
	fh << "######################################" << endl;
	fh << "# EOF" << endl;
	fh << "######################################" << endl;

	// Close the file
	fh.close();


}