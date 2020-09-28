/*
	Author: Tristan Britt
	This file 'grid.cpp' contains the definitions
	of the member functions of the class Grid.
	See the header file for explanation.
*/
#include "grid.hpp"
#include "parameter.hpp"
#include "nodes.hpp"
//Constructor
Grid::Grid(unsigned int DIM, ...)
{
	assert(DIM > 0);
    dims = DIM;
	va_list valist;
	va_start(valist, DIM);
	//access ith argument in ... by va_arg(valist, i)
	for (unsigned int j = 0; j < DIM; ++j)
	{
		Parameter param = va_arg(valist, Parameter);
		axes_pts.push_back(param.get_points());
		names.push_back(param.name);
	}
	va_end(valist); //clean memory reserved for valist

}

//unsigned int Grid::size() 
//{
//    return N;
//}
unsigned int Grid::dim() 
{
    return dims;
}
vector<string> Grid::get_names()
{
	return names;
}

vector<double> Grid::operator[](int i)
{
	return axes_pts[i];
}

vector<vector<double>> Grid::get_axes_pts()
{
	return axes_pts;
}
//
//void Grid::set_points(vector<vector<double> >& arr)
//{   
//    //This generates a vector<vector<double>> with all combinations of points in parameter space
//    // number of arrays 
//    int n = arr.size();
//
//    // to keep track of next element in each of 
//    // the n arrays 
//    int* indices = new int[n];
//
//    // initialize with first element's index 
//    for (int i = 0; i < n; ++i)
//        indices[i] = 0;
//    while (1) {
//
//        // print current combination 
//        vector<double> pt;
//        for (int i = 0; i < n; ++i) {
//            //cout << arr[i][indices[i]] << " ";
//            pt.push_back(arr[i][indices[i]]);
//        }
//        //cout << endl;
//        nodes.push_back(pt);
//        // find the rightmost array that has more 
//        // elements left after the current element  
//        // in that array 
//        int next = n - 1;
//        while (next >= 0 && (indices[next] + 1 >= (int)arr[next].size()))
//            --next;
//
//        // no such array is found so no more  
//        // combinations left 
//        if (next < 0)
//            return;
//
//        // if found move to next element in that  
//        // array 
//        ++indices[next];
//
//        // for all arrays to the right of this  
//        // array current index again points to  
//        // first element 
//        for (int i = next + 1; i < n; ++i)
//            indices[i] = 0;
//    }
//    delete[] indices;
//}
