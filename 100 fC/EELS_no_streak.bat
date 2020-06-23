mr -o start.gdf EELS.mr gpt UED.in N=10000
gdfa -o startStds.gdf start.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

mr -o inputpulse.gdf EELS.mr gpt UED.in outputT=0 outputZ=0.25 N=10000

gdfsolve -v -o sol_no_streak.gdf solveEELSonDetector_no_streak.sol mr EELS.mr gpt EELS_sc.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 sc=1 streak=0
gdf2a -w 16 -v -o sol_no_streak.txt sol_no_streak.gdf

REM *below is optimised params at 1e4 with higher effective bunch charge with no streak* 
REM mr -o EELSwithoutSample_low_no_streak.gdf EELS.mr gpt EELS_sc.in E0=1.5e6 phi=-.7544 Isol2=649.7 N=10000 B0=3e-3 sc=1 streak=0
REM gdfa -o EELSwithoutSampleStds_low_no_streak.gdf EELSwithoutSample_low_no_streak.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

REM *below is optimised params at 1e4 no streak*
REM mr -o EELSwithSample_low_no_streak.gdf EELS.mr gpt EELS_sc.in E0=1.5e6 phi=-.7544 Isol2=649.7 scale=20 N=10000 B0=3e-3 outputZ=2.2 zsample=0.53 sc=1 streak=0
REM gdfa -o EELSwithSampleStds_low_no_streak.gdf EELSwithSample_low_no_streak.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG