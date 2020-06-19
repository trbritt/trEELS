I’ll transfer all the files and custom elements. For this simulation, I started out with what I think are all the parameters of the simulation of the UED paper that was published in 2007 (https://doi.org/10.1063/1.2801027). I used a bunch charge of 0.1 pC.

 

The first two lines of the EELS.bat file simulate the bunch creation in the gun. When you start playing around with parameters here, it is important to make sure that the increase in the longitudinal emittance is as small as possible, because this will be the main parameter determining the energy resolution that you can get.

 

The third line generates an initial bunch at z=0.25 for the EELS.in file to use.

 

In the EELS.in, there are a few custom elements. The TM010erf and TM110erf generate the compression field and streak field relatively, calculated from a 5th order on-axis field expansion, assuming a error function  step both at the entrance and exit of the cavity. These use the erfderivs.h and gaussderivs2.h files For the streak cavity, you also need to include the TE110gauss (which may or may not already be known to GPT) to model electric fringe fields with a Gaussian function. You can just copy these values, we’ve fitted them to cavity field simulations, and change the values of the field strengths ‘E0’ and ‘B0’, as well as the phases ‘phi’ and ‘phi110’.

 

The EELS and EELSbugged elements randomly add energy loss according to the distribution defined in the testSpectrum.dat file, scaled by a factor ‘scale’ in energy. I always just use 4 delta peaks.

 

The reason that there are 2 EELS elements is because they use the command gptscatteraddparmqn(), which changed around version 3.3 I think. When I used GPT 3.1 the EELS.c worked well, but now that I am using GPT 3.36, I have to use the EELSbugged.c element.

 

I didn’t use a stretching cavity in the simulations, because the bunch expands automatically, but you can add one if you want to play around with the exact bunch length and energy spread at the sample.

 

The fourth line in EELS.bat solves for a minimized streaked pulse at the detector position, which for me was an okay method to align all elements. I think this optimizer is not perfect, because the resolution on the detector is worse than expected from the longitudinal separation at the compressed point, and the compressed point seems to be slightly before the streak cavity, while I would expect it to be inside the cavity, but I didn’t have the time back then to perfect everything. The values from the solver today also seem to be slightly different, for the results published in my thesis I used ‘E0=1.510497501e6 phi=-0.7404840954 Isol2=666.7093669 Isol3=924.7010509 phi110=0.1631898458’, which also gave a slightly better resolution, but I suggest you play around with this some more yourself. The solver also takes quite long, so maybe use a smaller N the first time you run it.

 

The final 3 lines then simulate once without sample, and once with sample, with the parameters that I got from the solver, to get all interesting values out. I’ve also added a Matlab file that plots all relevant parameters.

 

I suggest you start playing with the initial bunch exiting the gun, and see how low a longitudinal emittance you can get. Then, you can look at whether the solver is good enough to get an EELS signal, or whether you have to write a better optimizer.
