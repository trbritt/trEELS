/*
    Author: Tristan Britt
    This file 'main.hpp' is the header for
    'main.cpp', which contains the main function
    used by the executable MGO.exe. It contains
    mainly the includes but also the functions which
    write the data to binary after each run.
*/

#include "MGO.hpp"
#include "parsefiles.hpp"
#include "parameter.hpp"
#include "grid.hpp"
#include "nodes.hpp"
#include "mpioption.hpp"
#include "write_binary.hpp"
#include <mpi.h>
#include <boost/mpi.hpp>
#include <boost/mpi/collectives.hpp>
#include <boost/serialization/vector.hpp>
#include <boost/serialization/string.hpp>
#include <iostream>
#include <fstream>
#include <vector>
#include <cassert>
#include <iostream>
#include <string>
#include <sstream>
#include <memory>
#include <cstdlib>
#include <filesystem>
#include <stdlib.h>
#include <stdio.h>
#include <boost/lexical_cast.hpp>
#include <algorithm>
#include <iterator>
#include <ctime>
#include <chrono>
#include "zlib.h"
#include <errno.h>


#define _USE_MATH_DEFINES
#include <cmath>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif


namespace mpi = boost::mpi;


struct GzWrite { // RAII-Wrapper
    gzFile gz_; // C-Struct aus zlib.h
    explicit GzWrite(const string& filename)
        : gz_{ gzopen(filename.c_str(),"wb9") }
    {
        if (gz_ == NULL) {
            const size_t errmsglen = sizeof(errno) + 1;
            char errmsg[errmsglen];
            //throw std::runtime_error(strerror_s(errmsg, errmsglen, errno);
            strerror_s(errmsg, errmsglen, errno);
        }
    }
    ~GzWrite() {
        gzclose(gz_);
    }
    int write(const char* data, size_t len) {
        return gzwrite(gz_, data, len);
    }
    GzWrite(const GzWrite&) = delete; // keine Kopie
    GzWrite& operator=(const GzWrite&) = delete; // keine Zuweisung
};

void pack(const string& infn, const string& indata) {
    //vector<char> indata(infn.begin(), infn.end()); // lese Eingabe
    vector<char> in(indata.begin(), indata.end());
    GzWrite gz{ infn + ".gz" }; // initialisiere Ausgabe
    auto res = gz.write(in.data(), in.size());
    if (res == 0) throw std::runtime_error("Couldn't write to file...");
}