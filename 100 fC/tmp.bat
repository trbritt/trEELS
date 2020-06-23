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
del tmp
for /l %%j in (1,1,19) do (
	set E=!arrayE[%%j]!
	echo !E!
)
