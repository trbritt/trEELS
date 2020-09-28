/*
    Author: Tristan Britt
    This file 'MGO.cpp' contains all member functions
    for the class MGOSingleRun, defined in 'MGO.hpp'.
    See that file for explanations.
*/

#include "MGO.hpp"
#include "parsefiles.hpp"
#include <stdio.h>
#include <stdlib.h>
#include <filesystem>
namespace fs = std::filesystem;

//Constructor
MGOSingleRun::MGOSingleRun(string OUTFILE, string INFILE, string MRFILE, bool a, bool h, bool v, string args)
{
    output = OUTFILE;
    input = INFILE;
    mrfile = MRFILE;

    A = a;
    help = h;
    verbose = v;
    add_args = args;
    //when member is created, automatically generate the commands for each executable
    //used by GPT in performin the simulation
    setgptargs(A, help, verbose, add_args);
    setgdfaargs();
    setgdf2aargs();
}
//private get license no func
string MGOSingleRun::get_license() const
{
    //the license number for our license of GPT needs to be included when running
    //the GPT executables from the command line (aka here).
    //a private function so no other function can see our license number
    return (string)"1434409565";
}
//set MGOSingleRun::gptcommand
void MGOSingleRun::setgptargs(bool A, bool help, bool verbose, string add_args)
{
    gptcommand.append("mr ");
    gptcommand.append((help == false) ? ("") : ("-h "));
    gptcommand.append((verbose == false) ? ("") : ("-v "));
    gptcommand.append((A == false) ? ("-o ") : ("-a "));
    gptcommand.append(output);

    gptcommand.append(" ");
    gptcommand.append(mrfile);
    gptcommand.append(" gpt ");
    gptcommand.append(input);

    gptcommand.append(" ");
    gptcommand.append(add_args);
    gptcommand.append(" GPTLICENSE=");
    gptcommand.append(get_license());
}

void MGOSingleRun::setgdfaargs()
{
    string GDFA_TARGETS[16] = { "time", "avgx", "avgz", "stdx", "stdz", "avgBz", "stdBz", "avgBx", "stdBx", "avgG", "stdG", "nemixrms", "nemizrms", "avgy", "stdy", "avgr" };

    string tmp = "";
    gdfacommand.append("gdfa ");
    gdfacommand.append("-o ");

    tmp = output.substr(0,output.length() - 4);
    gdfacommand.append(tmp);
    gdfacommand.append("_stds.gdf ");

    gdfacommand.append(output);
    gdfacommand.append(" ");

    for (int i = 0; i < 16; ++i)
    {
        gdfacommand.append(GDFA_TARGETS[i]);
        gdfacommand.append(" ");
    }
}
void MGOSingleRun::setgdf2aargs()
{
    gdf2acommand.append("gdf2a ");
    gdf2acommand.append("-w 16 ");
    gdf2acommand.append("-v -o ");
    string tmp = "";
    tmp = output.substr(0,output.length() - 4);
    gdf2acommand.append(tmp);
    gdf2acommand.append("_stds.txt ");
    gdf2acommand.append(tmp);
    gdf2acommand.append("_stds.gdf");
}
void MGOSingleRun::run_command_line(string command)
{
    /*This function requires some finesse in explaining.
    * Normally, you should execute system commands
    * using system(command.c_str()). The issue with this
    * is that this opens a new shell awhen its called
    * and even if the command passed to that shell hasnt
    * finished executing , the code here in C++ will. 
    * Since we're performing (multithreaded) computations
    * that successivley depend on the files generated
    * by previous calls of system(), we need to ensure that
    * the command passed to a shell has finished executing before
    * continuing the code here. This is done by essentially
    * taking the shell output and passing it to a buffer
    * and when there is no more text to pass to the buffer
    * (aka the command has finished executing) we continue.
    * We therefore need _popen to create a pipe (threadsafe).
    */
    char psBuffer[128];
    FILE* pPipe;
    if ((pPipe = _popen(command.c_str(), "rt")) == NULL)
        exit(1);
    while (fgets(psBuffer, 128, pPipe)) {
        puts(psBuffer);
    }
    if (feof(pPipe))
        int i = _pclose(pPipe);
}
void MGOSingleRun::compute_gpt()
{
    run_command_line(gptcommand);
}
void MGOSingleRun::compute_gdfa()
{
    run_command_line(gdfacommand);
}
void MGOSingleRun::compute_gdf2a()
{
    run_command_line(gdf2acommand);
}
void MGOSingleRun::get_commands()
{
    cout << "GPT command: " << gptcommand << endl;
    cout << "GDFA command: " << gdfacommand << endl;
    cout << "GDF2A command: " << gdf2acommand << endl;
}
void MGOSingleRun::compute() {
    compute_gpt();
    fs::path p = output;
    if (!(fs::exists(p)))
        throw std::runtime_error("GDF file not found; cannot compute gdfa...");
    compute_gdfa();
    p = output.substr(0, output.length() - 4) + "_stds.gdf";
    if (!(fs::exists(p)))
        throw std::runtime_error("GDFA file not found; cannot convert to human readable...");
    compute_gdf2a();
    p = output.substr(0, output.length() - 4) + "_stds.txt";
    if (!(fs::exists(p)))
        throw std::runtime_error("GDFA (human readable) file not found; cannot get result...");
}
string MGOSingleRun::get_output_file() {
    return output;
}
string MGOSingleRun::get_input_file() {
    return input;
}

double MGOSingleRun::result(string parameter, double position)
{
    string out = get_output_file().substr(0, get_output_file().length() - 4) + "_stds.txt";
    return get_result(out, parameter, position);
}