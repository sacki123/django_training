@echo off
cd /d %~dp0
echo """"""""""""""""""""""""""""""""""""""""""""""""""
echo ����I�����Ă��������B
set /p ENV="   1. ���K�FPractice  -  2. ���؁FStaging: "
if %ENV%==1 (
	set PATH_ENV="prac_config.txt"	
	set PATH_SQL="%~dp0\PRACTICE_SQL\"
	set ENV_NAME="PRAC_"
) else (
		if %ENV%==2 (
			set PATH_ENV="stg_config.txt"
			set PATH_SQL="%~dp0\STAGING_SQL\"
			set ENV_NAME="STG_"
		) else (
			echo �P�܂��͂Q��I�����Ă��������B
			pause
			exit /b
		)
)
set /p SQL_NAME="�e�[�u��������͂��Ă��������B�i�e�[�u�����͑啶���j:"
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

if (%OSTYPE% == "AMD64") (
	%PATH_MYSQL64%mysql -h !value0! -P !value1! -u !value2! -p!value3! !value4! < %PATH_SQL%%SQL_NAME%%EXT% > %~dp0/OUTPUT/%ENV_NAME%%SQL_NAME%.csv
	cscript.exe %~dp0/bin/convert.vbs %~dp0/OUTPUT/%ENV_NAME%%SQL_NAME%.csv

) else (
	%PATH_MYSQL32%mysql -h !value0! -P !value1! -u !value2! -p!value3! !value4! < %PATH_SQL%%SQL_NAME%%EXT% > %~dp0/OUTPUT/%ENV_NAME%%SQL_NAME%.csv
	cscript.exe	%~dp0/bin/convert.vbs %~dp0/OUTPUT/%ENV_NAME%%SQL_NAME%.csv
)
cd /d %~dp0/OUTPUT
if exist %ENV_NAME%%SQL_NAME%.csv (
del %ENV_NAME%%SQL_NAME%.csv
)
if exist %ENV_NAME%%SQL_NAME%_1.csv (
ren %ENV_NAME%%SQL_NAME%_1.csv %ENV_NAME%%SQL_NAME%.csv
)
endlocal
exit /b
