/*Author: Tristan Britt
* This file 'driver.cpp' is the source file containing
* the definitions of all objective functions to be passed
* to the DiffEv driver for optimisation (driver also defined here)
*/
#include "driver.hpp"

using namespace amichel::de;
void run_diffev() {
    try {
        /**
         * Create and initialize the constraints object
         *
         * First create it with default constraints (double type, min
         * -1.0e6, max 1.0e6) then set the first two elements to be of
         *  type real with x between -10, 10 and y between -100, 100.
         */
        constraints constraints{ VARS_COUNT, -1.0e8, 1.0e8 };
        constraints[0] = std::make_shared<real_constraint>(7.9e-4, 8.1e-4);    //stdGBx originally 7 to 9
        constraints[1] = std::make_shared<real_constraint>(1.9e7, 2.1e7);      //zdiv originally 1 to 3
        constraints[2] = std::make_shared<real_constraint>(1.1, 1.3);      //scalex originally 1 and 2
        constraints[3] = std::make_shared<real_constraint>(4e-4, 6e-4);    //stdr originally 1e-4 and 1e-3
        constraints[4] = std::make_shared<real_constraint>(12, 18);         //xydiv originally 5 and 20
        constraints[5] = std::make_shared<real_constraint>(-M_PI/2, M_PI/2);     //phi110
        constraints[6] = std::make_shared<real_constraint>(900, 950);     //ISol3 originally 800 and 1000


        /**
         * Instantiate two null listeners, one for the differential
         * evolution, the other one for the processors
         */
        listener_ptr listener(std::make_shared<null_listener>());
        processor_listener_ptr processor_listener(
            std::make_shared<null_processor_listener>());

        /**
         * Instantiate the collection of processors with the number of
         * parallel processors (4), the objective function and the
         * listener
         */
        processors _processors{ PROC_CNT, boost::ref( gpt_result ), processor_listener };

        /**
         * Instantiate a simple termination strategy which will stop the
         * optimization process after MAX_GEN generations
         */
        termination_strategy terminationStrategy(max_gen_termination_strategy(MAX_GEN));

        /**
         * Instantiate the selection strategy - we'll use the best of
         * parent/child strategy
         */
        selection_strategy selectionStrategy{ best_parent_child_selection_strategy{} };

        /**
         * Instantiate the mutation strategy - we'll use the mutation
         * strategy 1 with the weight and crossover factors set to 0.5
         * and 0.9 respectively
         */
        mutation_strategy_arguments mutation_arguments(0.5, 0.9);
        mutation_strategy_ptr mutationStrategy(
            std::make_shared<mutation_strategy_1>(VARS_COUNT,
                mutation_arguments));

        //3 introduces a jitter when mutating between generations
        //mutation_strategy_ptr mutationStrategy(
        //    std::make_shared<mutation_strategy_1>(VARS_COUNT,
        //        mutation_arguments));

        /**
         * Instantiate the differential evolution using the previously
         * defined constraints, processors, listener, and the various
         * strategies
         */
        differential_evolution de(
            VARS_COUNT, POPULATION_SIZE, _processors, constraints, true,
            terminationStrategy, selectionStrategy, mutationStrategy, listener);

        /**
         * Run the optimization process
         */
        std::string filename = "C:/Users/SimulationWorkstatio/Desktop/GPT_EELS/Streaking/StreakGenerated/x64/Debug";
        de.run();

        /**
         * Get the best individual resulted from the optimization
         * process
         */
        individual_ptr best(de.best());

        /**
         * Print out the result
         */
        std::cout << "min(f(x)) = " << best->cost() << " for x = (";
        for (int j = 0; j < 7; ++j) {
            if (j != 6) std::cout << (best->vars()).at(j) << ",";
            else  std::cout << (best->vars()).at(j) << ")" << std::endl;
        }
    }
    catch (const amichel::de::exception& e) {
        /**
         * Print out any errors that happened during the initialization
         * or optimization phases
         */
        std::cout << "an error occurred: " << e.what();
    }
}

/*Below gives a test objectve function for the driver to make
* sure generational evolution proceeds as expected
* defines the sphere function with obvious min at vec{0}
* Returns vector of zeros accurate up to floating point number 
* precision
*/
 
double sphere_function(const amichel::de::DVector& args) {
    /**
      * The two function arguments are the elements index 0 and 1 in
      * the argument vector, as defined by the constraints vector
      * below
      */
    double x = args.at(0);
    double y = args.at(1);
    double z = args.at(2);
    double a = args.at(3);
    double b = args.at(4);
    double c = args.at(5);
    double d = args.at(6);

    return x * x + y * y + z * z + a * a + b * b + c * c + d * d;
}
/*Below gives the objective function for the simulations performed by GPT
*it generates the commands necessary to pass to GPT to perform the 
* computaion for a given choice of parameters. It instantiates a
* member of the class MGOSingleRun, which contains all necessary
* functionality to run the simulation, convert the output (binary)
* to output (human readable), and extract the desired result.
* It returns the double for a given choice of parameters.
*/
double gpt_result(const amichel::de::DVector& args) {
    vector<string> names = { "stdGBx", "zdiv", "scalex", "stdr", "xydiv", "phi110", "ISol3" };
    vector<double> tmp;
    for (int i = 0; i < 7; ++i)tmp.push_back(args.at(i));
    string params_full = get_cmd(names, tmp, true);
    int j = ran(0, MAX_GEN * PROC_CNT * POPULATION_SIZE);
    string output = "bin/tmp_diffev_" + boost::lexical_cast<string>(j) + ".gdf";
    MGOSingleRun Problem(output, "../../streak_generated_MGO.in", "../../../EELS.mr", false, false, false, params_full);

    Problem.compute();
    fs::path p0 = Problem.get_output_file();
    fs::path p1 = Problem.get_output_file().substr(0, Problem.get_output_file().length() - 4) + "_stds.gdf";
    fs::path p2 = Problem.get_output_file().substr(0, Problem.get_output_file().length() - 4) + "_stds.txt";
    double res;
    if ((fs::exists(p0) && fs::exists(p1) && fs::exists(p2))) res = Problem.result("stdx", 2.20);
    else res = 1;
    return res;
}
/*standard number generator for creating output files for each instance of MGOSingleRun,
* so ensure each run, each generation, can create the output files and return the result
* without competition in writing/reading between threads.
*/
int ran(int min, int max)
{
    std::random_device r;
    std::mt19937 gen(r());
    std::uniform_int_distribution<> dis(min, max);
    return dis(gen);
}
