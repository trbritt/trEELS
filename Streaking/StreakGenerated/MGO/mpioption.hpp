#include <boost/mpi.hpp>
#include <iostream>
#include <vector>
namespace mpi = boost::mpi;

class mpioption
{
private:
    friend class boost::serialization::access;

    template<class Archive>
    void serialize(Archive& ar, const unsigned int version)
    {
        //ar& degrees;
        //ar& minutes;
        //ar& seconds;
        ar& value;
    }

public:
    vector<double> value;

    mpioption() {};
    mpioption(vector<double> v) :
        value(v)
    {}
};