@echo off
cd /d %~dp0
set PATH_SQL="\\terastation1\ES$\02_差込印刷イメージ作成\差込み作業用\sql\"
set SQL_NAME="sample"
set EXT=".sql"
set PATH_MYSQL64="%~dp0\bin\64\"
set PATH_MYSQL32="%~dp0\bin\32\"
set OSTYPE=%PROCESSOR_ARCHITECTURE%
setLocal enableDelayedExpansion
set /a i=-1
for /f %%a in (config.txt) do (
set /a i+=1
set value!i!=%%a
)
if (%OSTYPE% == "AMD64") (
%PATH_MYSQL64%mysql -h !value0! -P !value1! -u !value2! -p!value3! !value4! < %PATH_SQL%%SQL_NAME%%EXT% > %~dp0/OUTPUT/%SQL_NAME%.txt
)else (%PATH_MYSQL32%mysql -h !value0! -P !value1! -u !value2! -p!value3! !value4! < %PATH_SQL%%SQL_NAME%%EXT% > %~dp0/OUTPUT/%SQL_NAME%.txt)
pause
exit 
