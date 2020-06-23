REM gdfsolve -v -o sol_IC.gdf solveEELSonSample.sol mr EELS.mr gpt UED.in N=10000 outputZ=0.25
REM gdf2a -w 16 -v -o sol_IC.txt sol_IC.gdf

mr -o start_gauss.gdf EELS.mr gpt UED.in N=10000
gdfa -o startStds_gauss.gdf start_gauss.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

mr -o inputpulse.gdf EELS.mr gpt UED.in outputT=0 outputZ=0.25 N=10000

REM gdfsolve -v -o sol_gauss.gdf solveEELSonDetector.sol mr EELS.mr gpt EELS_sc.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 sc=1 streak=1 
REM gdf2a -w 16 -v -o sol_gauss.txt sol_gauss.gdf


REM *below is optimised params at 1e4 with higher effective bunch charge* 
REM g- E0=1.503e6 phi=-0.7468 Isol2=649.7 Isol3=922.7 phi110=0.3939
REM u- E0=1.503e6 phi=-0.7544 Isol2=649.7 Isol3=922.2 phi110=0.3265
REM s- E0=1.503e6 phi=-0.7544 Isol2=656.7 Isol3=924.2 phi110=0.384
mr -o EELSwithoutSample_gauss.gdf EELS.mr gpt EELS_sc.in E0=1.503e6 phi=-0.7468 Isol2=649.7 Isol3=922.7 phi110=0.3939 N=10000 B0=3e-3 outputZ=2.2 sc=1 streak=1
gdfa -o EELSwithoutSampleStds_gauss.gdf EELSwithoutSample_gauss.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

REM *below is optimised params at 1e4*
REM mr -o EELSwithSample_gauss.gdf EELS.mr gpt EELS_sc.in E0=1.503e6 phi=-0.7468 Isol2=649.7 Isol3=922.7 phi110=0.3939 scale=20 N=10000 B0=3e-3 outputZ=2.2 zsample=0.53 sc=1 streak=1
REM gdfa -o EELSwithSampleStds_gauss.gdf EELSwithSample_gauss.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG