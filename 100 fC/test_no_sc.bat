mr -o start_streak.gdf EELS.mr gpt EELS_input_sample.in N=10000 
gdfa -o startStds_streak.gdf start_streak.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

REM mr -v -o EELSwithoutSample_no_sc.gdf EELS_no_sc.mr gpt EELS.in N=10000 B0=3e-3 outputZ=2.2 sc=0 streak=1
REM gdfa -o EELSwithoutSampleStds_no_sc.gdf EELSwithoutSample_no_sc.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

gdfsolve -v -o sol_no_sc.gdf solveEELSonDetector_no_sc.sol mr EELS.mr gpt test_no_sc.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 sc=0 streak=1
gdf2a -w 16 -v -o sol_no_sc.txt sol_no_sc.gdf