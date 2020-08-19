REM gdfsolve -v -o sol_lowfreq_streak_only.gdf solve_streak_only.sol mr EELS.mr gpt streak.in N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2
REM gdf2a -w 16 -v -o sol_lowfreq_streak_only.txt sol_lowfreq_streak_only.gdf

REM gdfmgo -v -j 11 -o sol_lowfreq_streak_only_mgo.gdf solve_streak_only.mgo mr EELS.mr gpt streak.in N=10000 B0=3e-3 sc=1 streak=1 

REM gdfsolve -v -o sol_lowfreq_streak_only_mgo.gdf solve_streak_only.mgo mr EELS.mr gpt streak.in N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2

mr -o EELS_streak_only.gdf EELS.mr gpt streak.in Isol3=922 phi110=0.592 N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2
gdfa -o EELSStds_streak_only.gdf EELS_streak_only.gdf time avgx avgz stdx stdz avgBz stdBz avgBx stdBx avgG stdG nemixrms nemizrms avgy stdy avgr
gdf2his -b -o EELS_streak_only_hist_x.gdf EELS_streak_only.gdf x 0.9e-5
gdf2his -b -o EELS_streak_only_hist_y.gdf EELS_streak_only.gdf y 0.9e-5
gdf2his -b -o EELS_streak_only_hist_z.gdf EELS_streak_only.gdf z 1e-5
gdf2his -b -o EELS_streak_only_hist_Bz.gdf EELS_streak_only.gdf Bz 1e-5
gdf2his -b -o EELS_streak_only_hist_Bx.gdf EELS_streak_only.gdf Bx 1e-5
gdf2his -b -o EELS_streak_only_hist_rxy.gdf EELS_streak_only.gdf rxy 0.9e-5
gdf2his -b -o EELS_streak_only_hist_G.gdf EELS_streak_only.gdf G 1e-5
@echo off
for %%l in (
	2.80e-5
	2.85e-5
	2.90e-5 
	2.95e-5 
	3.00e-5 
	3.05e-5 
	3.10e-5 
	3.15e-5 
	3.20e-5
	3.25e-5
	3.30e-5) do (
		REM echo Solving for stdz = %%l
		REM mr -o EELS_streak_only.gdf EELS.mr gpt streak.in Isol3=922 phi110=0.592 N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2 stdz=%%l outputT=0
		REM gdfa -a EELSStds_streak_only.gdf EELS_streak_only.gdf time avgx avgz stdx stdz avgBz stdBz avgBx stdBx avgG stdG nemixrms nemizrms
		REM gdf2his -b -a EELS_streak_only_hist_x.gdf EELS_streak_only.gdf x 0.9e-5
		REM gdf2his -b -a EELS_streak_only_hist_y.gdf EELS_streak_only.gdf y 0.9e-5
		REM gdf2his -b -a EELS_streak_only_hist_z.gdf EELS_streak_only.gdf z 1e-5

		REM gdf2his -b -a EELS_streak_only_hist_Bz.gdf EELS_streak_only.gdf Bz 1e-5
		REM gdf2his -b -a EELS_streak_only_hist_Bx.gdf EELS_streak_only.gdf Bx 1e-5

		REM gdf2his -b -a EELS_streak_only_hist_rxy.gdf EELS_streak_only.gdf rxy 0.9e-5
		REM gdf2his -b -a EELS_streak_only_hist_G.gdf EELS_streak_only.gdf G 1e-5

	)

@echo off
for %%l in (
	0.0041) do (
		echo Solving for stdx = %%l
		REM gdfsolve -v -o tmp_streak_only.gdf solve_streak_only.sol mr EELS.mr gpt streak.in N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2 stdx=%%l
		REM gdf2a -w 16 -v -o tmp_streak_only.txt tmp_streak_only.gdf

		REM get_Isol3
		REM get_phi110

		REM @echo on
		REM setlocal enabledelayedexpansion
		REM set /p I3=<tmpI
		REM set /p p1=<tmpphi110
		
		REM echo %%I3%%
		REM echo %%p1%%

		mr -a EELS_streak_only.gdf EELS.mr gpt streak.in Isol3=922 phi110=0.592 N=10000 B0=3e-3 sc=1 streak=1 outputZ=2.2 stdx=%%l outputT=0
		gdfa -o EELSStds_streak_only_stdx.gdf EELS_streak_only.gdf time avgx avgz stdx stdz avgBz stdBz avgBx stdBx avgG stdG nemixrms nemizrms avgy stdy avgr
		gdf2his -b -a EELS_streak_only_hist_x.gdf EELS_streak_only.gdf x 0.9e-5
		gdf2his -b -a EELS_streak_only_hist_y.gdf EELS_streak_only.gdf y 0.9e-5
		gdf2his -b -a EELS_streak_only_hist_z.gdf EELS_streak_only.gdf z 1e-5
		gdf2his -b -a EELS_streak_only_hist_Bz.gdf EELS_streak_only.gdf Bz 1e-5
		gdf2his -b -a EELS_streak_only_hist_Bx.gdf EELS_streak_only.gdf Bx 1e-5
		gdf2his -b -a EELS_streak_only_hist_rxy.gdf EELS_streak_only.gdf rxy 0.9e-5
		gdf2his -b -a EELS_streak_only_hist_G.gdf EELS_streak_only.gdf G 1e-5
		REM endlocal
	)