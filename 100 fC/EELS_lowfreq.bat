mr -o start.gdf EELS.mr gpt UED.in N=10000
gdfa -o startStds.gdf start.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

mr -o inputpulse.gdf EELS.mr gpt UED.in outputT=0 outputZ=0.25 N=10000

REM gdfsolve -v -o sol_lowfreq.gdf solveEELSonDetector_lowfreq.sol mr EELS.mr gpt EELS_sc.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 sc=1 streak=1 
REM gdf2a -w 16 -v -o sol_lowfreq.txt sol_lowfreq.gdf


REM *below is optimised params at 1e4 with higher effective bunch charge* 
mr -o EELSwithoutSample_lowfreq.gdf EELS.mr gpt EELS_sc.in E0=2.93e6 phi=0.36 Isol2=655.28 Isol3=922.7 phi110=0.146 N=10000 B0=3e-3 sc=1 streak=1
gdfa -o EELSwithoutSampleStds_lowfreq.gdf EELSwithoutSample_lowfreq.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

REM *below is optimised params at 1e4*
mr -o EELSwithSample_lowfreq.gdf EELS.mr gpt EELS_sc.in E0=2.93e6 phi=0.36 Isol2=655.28 Isol3=922.7 phi110=0.146 scale=20 N=10000 B0=3e-3 outputZ=2.2 zsample=0.53 sc=1 streak=1
gdfa -o EELSwithSampleStds_lowfreq.gdf EELSwithSample_lowfreq.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG