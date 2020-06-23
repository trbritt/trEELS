REM gdfsolve -v -o sol_lowfreq_ideal_inj.gdf solveEELSonInjection.sol mr EELS.mr gpt test_removenonlinearbz.in N=10000 outputT=0 outputZ=0.60
REM phi110=1.27

mr -o inputpulse_ideal.gdf EELS.mr gpt UED_ideal.in outputT=0 outputZ=0.50 N=10000 div=8e5
mr -o EELSwithSample_lowfreq_ideal_test.gdf EELS_test.mr gpt EELS_ideal.in E0=2.9e6 phi=0.66 Isol2=500.08 Isol3=921.00 scale=20 N=10000 B0=3e-3 outputZ=2.2 zsample=0.53 sc=1 streak=1 div=8e5