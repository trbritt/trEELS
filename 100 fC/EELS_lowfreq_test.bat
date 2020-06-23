REM mr -o start_streak.gdf EELS.mr gpt EELS_input_sample.in N=10000 
REM gdfa -o startStds_streak.gdf start_streak.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

REM mr -o inputpulse_streak.gdf EELS.mr gpt EELS_input_sample.in zsample=0.53 N=10000 scale=20
REM mr -o EELSwithSample_lowfreq_test.gdf EELS_test.mr gpt EELS.in E0=2.68e6 Isol2=511.5 Isol3=874.3 phi110=0.3939 scale=20 N=10000 B0=3e-3 outputZ=2.2 sc=0 streak=1
REM gdfa -o EELSwithSampleStds_lowfreq_test.gdf EELSwithSample_lowfreq_test.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG


mr -o start.gdf EELS.mr gpt UED.in N=10000
gdfa -o startStds.gdf start.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

mr -o inputpulse.gdf EELS.mr gpt UED.in outputT=0 outputZ=0.25 N=10000

mr -o EELSwithSample_lowfreq_test.gdf EELS_test.mr gpt EELS_sc.in E0=2.93e6 phi=0.36 Isol2=655.28 Isol3=922.7 scale=20 N=10000 B0=3e-3 outputZ=2.2 zsample=0.53 sc=1 streak=1
REM gdfa -o EELSwithSampleStds_lowfreq_test.gdf EELSwithSample_lowfreq_test.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG