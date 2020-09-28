REM gdfsolve -v -o EELS_streak_generated_opt.gdf solveEELSonDetector_generated.sol mr ../EELS.mr gpt streak_generated.in N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2

gdfmgo -j 11 -v -o EELS_streak_generated_opt_mgo.gdf solveEELSonDetector_generated.mgo mr -j 1 ../EELS.mr gpt -j 1 streak_generated.in N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2

mr -o EELS_streak_generated.gdf ../EELS.mr gpt streak_generated.in Isol3=922 phi110=0.592 N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2
gdfa -o EELSStds_streak_generated.gdf EELS_streak_generated.gdf time avgx avgz stdx stdz avgBz stdBz avgBx stdBx avgG stdG nemixrms nemizrms avgy stdy avgr
gdf2a -w 16 -v -o EELSStds_streak_generated.txt EELSStds_streak_generated.gdf

gdf2his -b -o EELS_streak_generated_hist_x.gdf EELS_streak_generated.gdf x 0.9e-5
gdf2his -b -o EELS_streak_generated_hist_y.gdf EELS_streak_generated.gdf y 0.9e-5
gdf2his -b -o EELS_streak_generated_hist_z.gdf EELS_streak_generated.gdf z 1e-5
gdf2his -b -o EELS_streak_generated_hist_Bz.gdf EELS_streak_generated.gdf Bz 1e-5
gdf2his -b -o EELS_streak_generated_hist_Bx.gdf EELS_streak_generated.gdf Bx 1e-5
gdf2his -b -o EELS_streak_generated_hist_rxy.gdf EELS_streak_generated.gdf rxy 0.9e-5
gdf2his -b -o EELS_streak_generated_hist_G.gdf EELS_streak_generated.gdf G 1e-5

gdf2his -b -o EELS_streak_orig_hist_x.gdf ../../"100 fC"/EELSwithoutSample_lowfreq.gdf x 0.9e-5
gdf2his -b -o EELS_streak_orig_hist_y.gdf ../../"100 fC"/EELSwithoutSample_lowfreq.gdf y 0.9e-5
gdf2his -b -o EELS_streak_orig_hist_z.gdf ../../"100 fC"/EELSwithoutSample_lowfreq.gdf z 1e-5
gdf2his -b -o EELS_streak_orig_hist_Bz.gdf ../../"100 fC"/EELSwithoutSample_lowfreq.gdf Bz 1e-5
gdf2his -b -o EELS_streak_orig_hist_Bx.gdf ../../"100 fC"/EELSwithoutSample_lowfreq.gdf Bx 1e-5
gdf2his -b -o EELS_streak_orig_hist_rxy.gdf ../../"100 fC"/EELSwithoutSample_lowfreq.gdf rxy 0.9e-5
gdf2his -b -o EELS_streak_orig_hist_G.gdf ../../"100 fC"/EELSwithoutSample_lowfreq.gdf G 1e-5

