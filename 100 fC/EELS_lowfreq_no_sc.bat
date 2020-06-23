mr -o start_streak.gdf EELS.mr gpt EELS_input_sample.in N=10000 
gdfa -o startStds_streak.gdf start_streak.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

mr -o inputpulse_streak.gdf EELS.mr gpt EELS_input_sample.in zsample=0.53 N=10000 

REM gdfsolve -v -o sol_lowfreq_no_sc.gdf solveEELSonDetector_lowfreq.sol mr EELS.mr gpt EELS.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 sc=0 streak=1
REM gdf2a -w 16 -v -o sol_lowfreq_no_sc.txt sol_lowfreq_no_sc.gdf

mr -o EELSwithoutSample_lowfreq_no_sc.gdf EELS.mr gpt EELS.in E0=2.68e6 phi=0.364 Isol2=511.5 Isol3=874.3 phi110=0.3939 N=10000 B0=3e-3 outputZ=2.2 sc=0 streak=1
gdfa -o EELSwithoutSampleStds_lowfreq_no_sc.gdf EELSwithoutSample_lowfreq_no_sc.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

mr -o inputpulse_streak.gdf EELS.mr gpt EELS_input_sample.in zsample=0.53 N=10000 scale=20
mr -o EELSwithSample_lowfreq_no_sc.gdf EELS.mr gpt EELS.in E0=2.68e6 phi=0.364 Isol2=511.5 Isol3=874.3 phi110=0.3939 scale=20 N=10000 B0=3e-3 outputZ=2.2 sc=0 streak=1
gdfa -o EELSwithSampleStds_lowfreq_no_sc.gdf EELSwithSample_lowfreq_no_sc.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG