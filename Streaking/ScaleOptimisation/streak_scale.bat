mr -o EELS_streak_scale_only.gdf ../EELS.mr gpt streak_scale.in Isol3=922 phi110=0.592 N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2 optimise=0
gdfa -o EELSStds_streak_scale_only.gdf EELS_streak_scale_only.gdf time avgx avgz stdx stdz avgBz stdBz avgBx stdBx avgG stdG nemixrms nemizrms avgy stdy avgr
gdf2his -b -o EELS_streak_scale_only_hist_x.gdf EELS_streak_scale_only.gdf x 0.9e-5
gdf2his -b -o EELS_streak_scale_only_hist_y.gdf EELS_streak_scale_only.gdf y 0.9e-5
gdf2his -b -o EELS_streak_scale_only_hist_z.gdf EELS_streak_scale_only.gdf z 1e-5
gdf2his -b -o EELS_streak_scale_only_hist_Bz.gdf EELS_streak_scale_only.gdf Bz 1e-5
gdf2his -b -o EELS_streak_scale_only_hist_By.gdf EELS_streak_scale_only.gdf By 1e-5
gdf2his -b -o EELS_streak_scale_only_hist_Bx.gdf EELS_streak_scale_only.gdf Bx 1e-5
gdf2his -b -o EELS_streak_scale_only_hist_rxy.gdf EELS_streak_scale_only.gdf rxy 0.9e-5
gdf2his -b -o EELS_streak_scale_only_hist_G.gdf EELS_streak_scale_only.gdf G 1e-5

REM Initial run \vec{\sigma} = 1.21, 1.49, 1, 1.44, 1.93, 1 (x,y,z,Bz,By,Bz)
REM gdfsolve -v -o tmp_streak_scale_only.gdf solve_streak_scale_only.sol mr ../EELS.mr gpt streak_scale.in N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2 optimise=1
REM gdf2a -w 16 -v -o tmp_streak_scale_only.txt tmp_streak_scale_only.gdf

		
mr -o EELS_streak_scale_only_new.gdf ../EELS.mr gpt streak_scale.in Isol3=922 phi110=1.04 N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2 optimise=1
gdfa -o EELSStds_streak_scale_only_new.gdf EELS_streak_scale_only_new.gdf time avgx avgz stdx stdz avgBz stdBz avgBx stdBx avgG stdG nemixrms nemizrms avgy stdy avgr
gdf2his -b -o EELS_streak_scale_only_hist_x_new.gdf EELS_streak_scale_only_new.gdf x 0.9e-5
gdf2his -b -o EELS_streak_scale_only_hist_y_new.gdf EELS_streak_scale_only_new.gdf y 0.9e-5
gdf2his -b -o EELS_streak_scale_only_hist_z_new.gdf EELS_streak_scale_only_new.gdf z 1e-5
gdf2his -b -o EELS_streak_scale_only_hist_Bz_new.gdf EELS_streak_scale_only_new.gdf Bz 1e-5
gdf2his -b -o EELS_streak_scale_only_hist_By_new.gdf EELS_streak_scale_only_new.gdf By 1e-5
gdf2his -b -o EELS_streak_scale_only_hist_Bx_new.gdf EELS_streak_scale_only_new.gdf Bx 1e-5
gdf2his -b -o EELS_streak_scale_only_hist_rxy_new.gdf EELS_streak_scale_only_new.gdf rxy 0.9e-5
gdf2his -b -o EELS_streak_scale_only_hist_G_new.gdf EELS_streak_scale_only_new.gdf G 1e-5
		
