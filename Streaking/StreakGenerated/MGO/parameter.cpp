/*
    Author: Tristan Britt
    This file 'parameter.cpp' contains the definitions
    of all member functions of the class Parameter, 
    prototyped in 'parameter.hpp'. See that file for
    explanations of this class.
*/
#include "parameter.hpp"

//Constructor
Parameter::Parameter(string NAME, double LOWB, double HIGHB, int NUM)
{
    name = NAME;
	low = LOWB;
	high = HIGHB;
	N = NUM;
    if (0 != NUM)
    {
        if (1 == NUM)
        {
            points.push_back(LOWB);
        }
        else
        {
            double delta = (HIGHB - LOWB) / (NUM);

            for (auto i = 0; i <= (NUM); ++i)
            {
                points.push_back(LOWB + delta * i);
            }
            // ensure that start and end are exactly the same as the input
            //points.push_back(HIGHB);
        }
    }
}

//Overload constructor
Parameter::Parameter(string NAME, double LOWB, double HIGHB)
{
    name = NAME;
	low = LOWB;
	high = HIGHB;
    N = 0;
}

void Parameter::set_points(vector<double> v)
{
	sort(v.begin(), v.end());
	for (unsigned int j = 0; j < v.size(); ++j) points.push_back(v[j]);
    N = (int) v.size();
}

vector<double> Parameter::get_points()
{
	return points;
}

// Overloading square brackets
// Note that this uses `zero-based' indexing,
// and a check on the validity of the index
double Parameter::operator[](int i)
{
	assert(i > -1);
	assert(i <  length());
	return points[i];
}

int Parameter::length()
{
	return N+1;
}

