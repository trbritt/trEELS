REM mr -o inputpulse_ideal.gdf EELS.mr gpt UED_ideal.in outputT=0 outputZ=0.50 N=10000 div=1e5
REM gdfsolve -v -o sol_lowfreq_ideal_div.gdf solveEELSonDetector_lowfreq_ideal.sol mr EELS.mr gpt EELS_ideal.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 sc=1 streak=1 div=1e5

REM for /l %%G in (0,5000,95000) do (
REM	echo div=%%G
REM	mr -o inputpulse_ideal.gdf EELS.mr gpt UED_ideal.in outputT=0 outputZ=0.50 N=10000 div=%%G
REM	gdfsolve -v -a sol_lowfreq_ideal_div.gdf solveEELSonDetector_lowfreq_ideal.sol mr EELS.mr gpt EELS_ideal.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 sc=1 streak=1 div=%%G
REM )

gdf2a -w 16 -v -o sol_lowfreq_ideal_div.txt sol_lowfreq_ideal_div.gdf

setlocal enabledelayedexpansion
@echo off
findstr /N "E0" sol_lowfreq_ideal_div.txt> tmp
set Cnt=0
for /f "tokens=*" %%a in (tmp) do (
	set /a Cnt+=1
	set l=%%a
	set line=!l:~-15!
	call set arrayE[%%Cnt%%]=!line!

)
findstr /N "phi" sol_lowfreq_ideal_div.txt> tmp
set Cnt=0
for /f "tokens=*" %%a in (tmp) do (
	set /a Cnt+=1
	set l=%%a
	set line=!l:~-15!
	call set arrayp1[%%Cnt%%]=!line!

)
findstr /N "Isol2" sol_lowfreq_ideal_div.txt> tmp
set Cnt=0
for /f "tokens=*" %%a in (tmp) do (
	set /a Cnt+=1
	set l=%%a
	set line=!l:~-15!
	call set arrayI2[%%Cnt%%]=!line!

)
findstr /N "Isol3" sol_lowfreq_ideal_div.txt> tmp
set Cnt=0
for /f "tokens=*" %%a in (tmp) do (
	set /a Cnt+=1
	set l=%%a
	set line=!l:~-15!
	call set arrayI3[%%Cnt%%]=!line!

)
findstr /N "phi110" sol_lowfreq_ideal_div.txt> tmp
set Cnt=0
for /f "tokens=*" %%a in (tmp) do (
	set /a Cnt+=1
	set l=%%a
	set line=!l:~-15!
	call set arrayp2[%%Cnt%%]=!line!

)
findstr /N "div" sol_lowfreq_ideal_div.txt> tmp
set Cnt=0
for /f "tokens=*" %%a in (tmp) do (
	set /a Cnt+=1
	set l=%%a
	set line=!l:~-15!
	call set arrayD[%%Cnt%%]=!line!

)
del tmp
for /l %%i in (1,1,19) do (
	set E=!arrayE[%%i]!
	set p1=!arrayp1[%%i]!
	set I2=!arrayI2[%%i]!
	set p2=!arrayp2[%%i]!
	set I3=!arrayI3[%%i]!
	set d=!arrayD[%%i]!
	echo !E! !p1! !I2! !p2! !I3! !d!
	mr -o inputpulse_ideal.gdf EELS.mr gpt UED_ideal.in outputT=0 outputZ=0.50 N=10000 div=!d!
	mr -o divs/EELSwithoutSample_lowfreq_ideal_div_%%i.gdf EELS.mr gpt EELS_ideal.in E0=!E! phi=!p1! Isol2=!I2! Isol3=!I3! phi110=!p2! div=!d! N=10000 B0=3e-3 sc=1 streak=1
	gdfa -o divs/EELSwithoutSampleStds_lowfreq_ideal_div_%%i.gdf divs/EELSwithoutSample_lowfreq_ideal_div_%%i.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG

)
endlocal


REM mr -o EELSwithSample_lowfreq_ideal_test_div.gdf EELS_test.mr gpt EELS_ideal.in E0=2.9e6 phi=1.43 Isol2=600.94 Isol3=967.21 scale=20 N=10000 B0=3e-3 outputZ=2.2 zsample=0.53 sc=1 streak=1
REM phi110=0.251
