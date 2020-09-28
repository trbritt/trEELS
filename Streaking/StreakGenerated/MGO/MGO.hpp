/*
    Author: Tristan Britt
    This file 'MGO.hpp' is the header file for
    'MGO.cpp' and contains all includes and prototypes
    for the class MGOSingleRun. This class is used to instantiate
    a computation in GPT for a given single choice of parameters.
    The combination of parameters passed to an instance of this
    class can either be from the DiffEv executable used
    to reduce the search space \in parameter space, or from 
    a Grid object for a node by node computation in a 
    rectangular parameter space. 
*/

#include <iostream>
#ifndef MGOSingleRunHEADERDEF
#define MGOSingleRunHEADERDEF
#include <string>
using namespace std;
class MGOSingleRun
{
private:
    string output, input, mrfile;
    bool A, help, verbose;
    string add_args;

    string gptcommand = "";
    string gdfacommand = "";
    string gdf2acommand = "";

    string get_license() const;

    void run_command_line(string command);

protected:



public:
    MGOSingleRun(string OUTFILE, string INFILE, string MRFILE, bool A, bool help, bool verbose, string add_args);
    void setgptargs(bool A, bool help, bool verbose, string add_args);
    void setgdfaargs();
    void setgdf2aargs();

    void compute();

    void compute_gpt();
    void compute_gdfa();
    void compute_gdf2a();

    void get_commands();
    string get_output_file();
    string get_input_file();
    double result(string parameter, double position);
    //double get_result(string parameter, double position);
};

#endif