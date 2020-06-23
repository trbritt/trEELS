REM mr -o start_streak.gdf EELS.mr gpt EELS_input_sample.in N=10000 
REM gdfa -o startStds_streak.gdf start_streak.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

mr -o inputpulse_streak.gdf EELS.mr gpt EELS_input_sample.in zsample=0.53 N=10000 

REM gdfsolve -v -o sol_no_sc.gdf solveEELSonDetector_no_sc.sol mr EELS.mr gpt EELS.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 sc=0 streak=1
REM gdf2a -w 16 -v -o sol_no_sc.txt sol_no_sc.gdf

REM no sc params - E0=1.38e6 phi=-0.752 Isol2=656.197 Isol3=796.8 phi110=0.39
REM sc params from original simulation opt. - E0=1.503e6 phi=-0.7468 Isol2=649.7 Isol3=922.7 phi110=0.3939
REM sc params from this opt - E0=1.50e6 phi=-0.7615 Isol2=639.1 Isol3=918.7 phi110=0.09231
REM values below are from optimisation of original simulation which should be identical ...

mr -o EELSwithoutSample_no_sc.gdf EELS.mr gpt EELS.in E0=1.39e6 phi=-0.7268 Isol2=649.7 Isol3=802.7 phi110=0.3139 N=10000 B0=3e-3 outputZ=2.2 sc=0 streak=1
gdfa -o EELSwithoutSampleStds_no_sc.gdf EELSwithoutSample_no_sc.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

REM the next line below when you specify outputT=0 in the line below, it says the particles hit the 
REM sample picoseconds later than in the original simulation(3.145ns vs 3.1ns respectively). 
REM When you do not specify it, it gives the same value as the original simulation for the time
REM the particles hit the sample. The only effect this variable has is whether or not to implement
REM the tout() argument at the end of EELS_input_sample.in. So, what's goin on!

mr -o inputpulse_streak.gdf EELS.mr gpt EELS_input_sample.in zsample=0.53 N=10000 scale=20
mr -o EELSwithSample_no_sc.gdf EELS.mr gpt EELS.in E0=1.39e6 phi=-0.7268 Isol2=649.7 Isol3=802.7 phi110=0.3139 scale=20 N=10000 B0=3e-3 outputZ=2.2 sc=0 streak=1
gdfa -o EELSwithSampleStds_no_sc.gdf EELSwithSample_no_sc.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG