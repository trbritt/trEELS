REM gdfsolve -o sol_ideal_test.gdf solveEELSonDetector_lowfreq_ideal_test.sol mr EELS.mr gpt EELS_ideal.in N=10000 outputT=0 outputZ=2.2 sc=1 streak=1 div=8e5 E0=2.9e6 phi=0.66 Isol2=500.08 Isol3=921.00 scale=20 zsample=0.53 
REM gdf2a -w 16 -v -o sol_ideal_test.txt sol_ideal_test.gdf
REM phi110=1.27

mr -o inputpulse_ideal.gdf EELS.mr gpt UED_ideal.in outputT=0 outputZ=0.50 N=10000 div=8e5
mr -o EELSwithSample_lowfreq_ideal_test_phi110.gdf EELS_test.mr gpt EELS_ideal.in E0=2.9e6 phi=0.66 Isol2=500.08 Isol3=921.00 scale=20 N=10000 B0=3e-3 outputZ=2.2 zsample=0.53 sc=1 streak=1 div=8e5
REM gdfa -o EELSwithSampleStds_lowfreq_ideal_test_Isol3.gdf EELSwithSample_lowfreq_ideal_test_Isol3.gdf time avgz stdx stdz avgBz avgBx avgG nemixrms nemizrms stdG


REM mr -o tmp.gdf EELS.mr gpt EELS_ideal.in E0=2.9e6 phi=0.66 Isol2=500.08 Isol3=921.00 phi110=1.25 B0=3e-3 scale=20 N=10000 zsample=0.53 sc=1 streak=1 div=8e5 outputT=0
REM gdfsolve -v -o sol_test.gdf solveEELSonDetector_lowfreq_ideal.sol mr EELS.mr gpt EELS_ideal_streak_test.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 streak=1 div=8e5
REM gdf2a -w 16 -v -o sol_test.txt sol_test.gdf
REM mr -o tmp_streak.gdf EELS_test.mr gpt EELS_ideal_streak_test.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 streak=1 div=8e5 Isol3=915.00