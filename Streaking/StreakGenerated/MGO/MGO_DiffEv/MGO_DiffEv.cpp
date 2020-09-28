/*  Author: Tristan Britt
    Aight here's the loaddown on the biz.
    This program ('MGO_DiffEv.exe') is a differential evolution optimizer that utilises
    the header only library made by Adrian Michel distrubted under the BSD 3 Clause
    license.

    The functionality can be described as follows. The differential evolution logic
    is a multithreaded (single root process) that is realies on just a function
    f, the objective function, to minimise. Any function returning a double suffices.

    The interface with GPT goes as follows. An class, MGOSingleProblem, instantiates
    all the string arguments necessary to pass to a cmd.exe shell to compute
    a run of GPT for a given point in parameter space (determined stochastically
    as determined by the DiffEv logic. It additionally provides the methods
    necessary to interpret the GPT output (binary and human readable) and
    spit out a double, which is the value of some post-processing variable,
    in our case it will be 'stdx', but this can be changed easily. (For the
    diff ev commands, target can easily be changed in the gpt_result()
    function found in driver.cpp.

    The Diff Ev logic will stochastically populate a generation, and compute
    the subsequent value of interest per individual. It will then mutate the
    values in parameter space into a new generation, the specifics of which
    are governed by two values: weight and crossover, currently set (default)
    to 0.5 and 0.9 respectively (see driver.cpp). Additional values of interest
    include population size, termination criteria, and maximum number of generations.

    Running the executable twice will not produce the same result in general, since
    each population is stochastically populated. Once an 'ideal' solution is determined,
    you need to then run 'MGO.exe'. MGO.exe is an MPI program that is self sufficient
    once built. It generates instances of a class 'Parameter', which are then passed to
    an instance of the class 'Grid'. The root process generates (as needed) a point
    in parameter space to pass to other processes to compute the values in GPT, and
    determine the result. After completing all iterations, in the /bin directory of
    located in the same directory as main.cpp, all data from all runs will be stored in
    compressed gz files. There is a python program (SVM_generator.py) which decompresses
    the files and can read the results. All in all, MGO.exe will generate data complete exploring
    discrete rectangular nodes in parameter space (which should be based centrally
    around the solution determined by 'MGO_DiffEv.exe'), and thus an ideal solution
    may be found.

    In theory, should computational resources allow, MGO_DiffEv should be run multiple
    times, and a collection of 'ideal' solutions should be generated. Each run of MGO_DiffEv
    should generate a global min, but the stochastic nature of the evolution per generation
    doesn't in general allow for this.



*/
#include "MGO_DiffEv.hpp"

using namespace amichel::de;

int main()
{   
    run_diffev();

    return 0;
}