mr -o start_ideal.gdf EELS.mr gpt UED_ideal.in N=10000 div=8e5
gdfa -o startStds_ideal.gdf start_ideal.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG stdzs

REM mr -o inputpulse_ideal.gdf EELS.mr gpt transform.in outputZ=0.25 N=10000
mr -o inputpulse_ideal.gdf EELS.mr gpt UED_ideal.in outputT=0 outputZ=0.50 N=10000 div=8e5

REM gdfsolve -v -o sol_lowfreq_ideal.gdf solveEELSonDetector_lowfreq_ideal.sol mr EELS.mr gpt EELS_ideal.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 sc=1 streak=1 div=8e5
REM gdf2a -w 16 -v -o sol_lowfreq_ideal.txt sol_lowfreq_ideal.gdf


REM E0=2.93e6 phi=0.36 Isol2=655.28 Isol3=922.7 phi110=0.146 orig opt
REM E0=2.93e6 phi=0.651 Isol2=60 Isol3=933 phi110=1.16	translated 3
REM E0=2.929e6 phi=0.65 Isol2=575.8 Isol3=924.00 phi110=1.2 emit x same identically

REM *below is optimised params at 1e4 with higher effective bunch charge* 
mr -o EELSwithoutSample_lowfreq_ideal.gdf EELS.mr gpt EELS_ideal.in E0=2.929e6 phi=0.65 Isol2=575.8 Isol3=926.00 phi110=1.22 B0=3e-3 N=10000 sc=1 streak=1 div=8e5
gdfa -o EELSwithoutSampleStds_lowfreq_ideal.gdf EELSwithoutSample_lowfreq_ideal.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

REM *below is optimised params at 1e4* 
mr -o EELSwithSample_lowfreq_ideal.gdf EELS.mr gpt EELS_ideal.in E0=2.929e6 phi=0.65 Isol2=575.8 Isol3=926.00 phi110=1.22 B0=3e-3 scale=20 N=10000 outputZ=2.2 zsample=0.53 sc=1 streak=1 div=8e5
gdfa -o EELSwithSampleStds_lowfreq_ideal.gdf EELSwithSample_lowfreq_ideal.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

