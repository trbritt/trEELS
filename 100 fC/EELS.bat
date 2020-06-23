mr -o start.gdf EELS.mr gpt UED.in N=10000
gdfa -o startStds.gdf start.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

mr -o inputpulse.gdf EELS.mr gpt UED.in outputT=0 outputZ=0.25 N=10000

gdfsolve -v -o sol.gdf solveEELSonDetector.sol mr EELS.mr gpt EELS_sc.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 sc=1 streak=1 
gdf2a -w 16 -v -o sol.txt sol.gdf

REM *below is optimised params at 1e4 with higher effective bunch charge* 
REM mr -o EELSwithoutSample.gdf EELS.mr gpt EELS_sc.in E0=1.503e6 phi=-0.7468 Isol2=649.7 Isol3=922.7 phi110=0.3939 N=10000 B0=3e-3 sc=1 streak=1
REM gdfa -o EELSwithoutSampleStds.gdf EELSwithoutSample.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

REM *below is optimised params at 1e4*
REM mr -o EELSwithSample_highres.gdf EELS.mr gpt EELS_sc.in E0=1.503e6 phi=-0.7468 Isol2=649.7 Isol3=922.7 phi110=0.3939 scale=20 N=10000 B0=3e-3 outputZ=2.2 zsample=0.53 sc=1 streak=1
REM gdfa -o EELSwithSampleStds_highres.gdf EELSwithSample_highres.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG