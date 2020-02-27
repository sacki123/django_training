@echo off
cd /d %~dp0
setLocal enableDelayedExpansion
set PATH_SQL="\\terastation1\ES$\02_差込印刷イメージ作成\差込み作業用\sql\"
set SQL_NAME="sample"
set EXT=".sql"
set PATH_MYSQL64="%~dp0\bin\64\"
set PATH_MYSQL32="%~dp0\bin\32\"
set OSTYPE=%PROCESSOR_ARCHITECTURE%
set /a i=-1

for /f %%a in (config.txt) do (
set /a i+=1
set value!i!=%%a
)
if (%OSTYPE% == "AMD64") (
	%PATH_MYSQL64%mysql -h !value0! -P !value1! -u !value2! -p!value3! !value4! < %PATH_SQL%%SQL_NAME%%EXT% > %~dp0/OUTPUT/%SQL_NAME%.csv
	cscript.exe %~dp0/bin/convert.vbs %~dp0/OUTPUT/%SQL_NAME%.csv

)else (
	%PATH_MYSQL32%mysql -h !value0! -P !value1! -u !value2! -p!value3! !value4! < %PATH_SQL%%SQL_NAME%%EXT% > %~dp0/OUTPUT/%SQL_NAME%.csv
	cscript.exe %~dp0/bin/convert.vbs %~dp0/OUTPUT/%SQL_NAME%.csv
)
cd /d %~dp0/OUTPUT
if exist %SQL_NAME%.csv (
del %SQL_NAME%.csv
)
if exist %SQL_NAME%_1.csv (
ren %SQL_NAME%_1.csv %SQL_NAME%.csv
)
endlocal
exit

