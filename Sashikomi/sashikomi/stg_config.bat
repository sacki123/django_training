@echo off
cd /d %~dp0
set /p ENV="Select Environment: 1. Practice  -  2. Staging :"
if %ENV%==1 (
	set PATH_ENV="prac_config.txt"	
	set PATH_SQL="%~dp0\PRACTICE_SQL"
) else (
		if %ENV%==2 (
			set PATH_ENV="stg_config.txt"
			set PATH_SQL="%~dp0\STAGING_SQL"
		) else (
			echo "ERROR"
		)
)
set /p SQL_NAME="Input Table Name (Upper case):"
set EXT=".sql"
set PATH_MYSQL64="%~dp0\bin\64\"
set PATH_MYSQL32="%~dp0\bin\32\"
set OSTYPE=%PROCESSOR_ARCHITECTURE%
cscript.exe %~dp0/decode.vbs %PATH_ENV%
setLocal enableDelayedExpansion
set /a i=-1
for /f %%a in (config.txt) do (
set /a i+=1
set value!i!=%%a
)
del config.txt
echo !value0!
echo !value1!
echo !value2!
echo !value3!
echo !value4!
pause