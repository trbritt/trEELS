setlocal enabledelayedexpansion
@echo off
findstr "Isol3" tmp_streak_only.txt > tmp
for /f "delims=" %%i in (tmp) do (
	if 1==1 (
	set first_line=%%i
	echo !first_line:~-15! > tmpI
	goto :eof
	)
)
del tmp
endlocal
@echo on