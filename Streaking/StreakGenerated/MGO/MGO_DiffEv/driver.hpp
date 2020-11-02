/*Author: Tristan Britt
* This file 'driver.hpp' provides the headers
* and prototypes for objective functions 
* ultimately passed to DiffEv driver for
* optimisation. 
*/

#define VARS_COUNT 20
#define POPULATION_SIZE 200
#define MAX_GEN 100
#define PROC_CNT 12

#define _USE_MATH_DEFINES
#include <cmath>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif
#include "differential_evolution.hpp"
#include <iostream>
#include <string>
#include <vector>
#include "nodes.hpp"
#include "MGO.hpp"
#include "parsefiles.hpp"
#include <boost/lexical_cast.hpp>
#include <algorithm>
#include <random>
#include <cstdio>
void run_diffev();
double gpt_result(const amichel::de::DVector& args);
double sphere_function(const amichel::de::DVector& args);
int ran(int min, int max);

