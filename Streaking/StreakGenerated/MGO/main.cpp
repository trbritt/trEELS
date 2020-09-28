/*
	Author: Tristan Britt
	The overall purpose of this code is explained in 
	more detail in the MGO_DiffEv.cpp file, but
	since most of the code that directs the computations
	done by the MGO.exe executable are coded here,
	this file is commented by section.
*/

#include "main.hpp"

#define LENGTH 0x1000


int main(int argc, char* argv[])
{
	//instantiate boost mpi environment and world
	//store size of comm world and rank of executing process
	mpi::environment env{ argc, argv };
	mpi::communicator world;
	unsigned int comm_size, rank;
	rank = world.rank();
	comm_size = world.size();
	unsigned int root = 0;						//define root process id
	
	vector<vector<double>> v;					//create object scoped by all processes, but only modifed by root, will store each linspace
												//of each parameter, and serve as the object from which (based on an array of indices) we
												//will get the next point in discete parameter space to compute.

	vector<size_t> it;							//array of indices root process will alter
	vector<string> names;						//names of parametrs in order
	int N=1;
	if (!does_dir_exist("bin"))
		fs::create_directory("bin");

	if (!does_dir_exist("data"))
		fs::create_directory("data");
	double progress = 0.0;

	if (rank == root) {
		//generate all parameters for the simulation
		Parameter stdGBx("stdGBx", 7e-4, 9e-4, 20);
		Parameter zdiv("zdiv", 2e7, 3e7, 10);
		Parameter scalex("scalex", 1.0, 2.0, 10);
		Parameter stdr("stdr", 1e-4, 1e-3, 10);
		Parameter xydiv("xydiv", 5, 20, 15);
		Parameter phi110("phi110", 0, 2.0 * M_PI, 100);
		Parameter ISol3("ISol3", 900, 950, 25);
		//create Grid object of parameters, extract all combinations from this
		Grid grid(7, stdGBx, zdiv, scalex, stdr, xydiv, phi110, ISol3);
		v = grid.get_axes_pts();
		vector<string> names_tmp = grid.get_names();
		vector<size_t> tmp(v.size(), 0);
		it = tmp;
		names = names_tmp;
		//total number of computations
		N *= (stdGBx.length() * zdiv.length() * scalex.length() * stdr.length() * xydiv.length() * phi110.length() * ISol3.length());
		char in;
		cout << "Going to be performing " << N << " computations. Proceed? (Y/N)" << endl;
		cin >> in;
		in = tolower(in);
		if (in != 'y') return -1;
	}
	//broadcast names to processes so they can generate the commands to pass as strings to GPT
	//for each instance of MGOSingleRun they make. broadcast N so each process knows when
	//to stop
	mpi::broadcast(world, names, 0);
	mpi::broadcast(world, N, 0);
	const int N_TOT = N;

	//const int N_TOT = 100;
	int cnt = 0;
	int NUM_CHUNKS = N_TOT / comm_size;
	std::filesystem::space_info csi = std::filesystem::space("c:/");
	const size_t cspace = csi.available;

	while (cnt < N_TOT) {
		mpioption local_opt;											//class mpioption exists only so that the vector of parameters can
																		//serialised so that they can be sent by mpi from root to <rank>.
		vector<mpioption> send_opts;
		if (rank == root) {
			for (unsigned int i = 0; i < comm_size; ++i) 
				send_opts.push_back(mpioption(get_next_opt(v, it)));
		}
		mpi::scatter(world, send_opts, local_opt, 0);					//root process will distribute <size> problems to the processes for parallel
																		//computation. Note that this means the root process also does a computation per round
		cout << "PID: " << rank << "- COMP CNT:" << cnt+rank << " \n";

		string params_full = get_cmd(names, local_opt.value, true);

		string output = "bin/tmp_";
		output.append(boost::lexical_cast<string>(rank));
		output.append(".gdf");
		//each process will now instantiate a member of MGOSingleRun containing the parameters distributed to it
		//by the root process above by mpi::scatter.
		MGOSingleRun Problem(output, "../streak_generated_MGO.in", "../../EELS.mr", false, false, false, params_full);
		//TODO: once the MGO_DiffEv run finishes, the MGOSingleRun class now
		//is coded such that each of the computations done by GPT will not proceed until
		//the previous has finished since system commands are now executed by
		//popen not system(), so it should be possible to remove these barriers
		//(a minor optimisation but still)
		Problem.compute_gpt();
		world.barrier();												//need to compute data before analysing
		Problem.compute_gdfa();
		world.barrier();												//need to analyse data in binary before ->> human readable
		Problem.compute_gdf2a();
		string target = "stdx";
		/*string comptime;
		double elpsd;*/
		//clock_function(bind(&MGOSingleRun::get_commands, ref(Problem)), comptime, elpsd);
		//write_to_file("data", names, local_opt.value, target, 0.0, comptime, elpsd, cnt + rank, rank);
		
		string filename = "data/GPT_" + boost::lexical_cast<string>(rank + cnt);
		string indata = "";
		for (size_t i = 0; i < local_opt.value.size(); ++i) indata += (boost::lexical_cast<string>(local_opt.value[i]) + ",");
		indata += boost::lexical_cast<string>(Problem.result(target, 2.20)); 
		pack(filename, indata);											//see the file 'write_binary.cpp' to see how the data is packaged and copmressed in binary 
																		//for each run 

		cnt = cnt + comm_size;
		world.barrier();												//ensures processes all write data to file before beginning next round of problems
		std::filesystem::space_info csi_l = std::filesystem::space("c:/");
		if (csi_l.available < 0.1*cspace) {
			throw std::runtime_error("Going to run out of memory soon, so terminating processes ....");
		}
	}
	return 0; 
}