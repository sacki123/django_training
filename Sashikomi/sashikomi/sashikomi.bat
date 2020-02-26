@echo off
cd /d %~dp0
set PATH_SQL="\\terastation1\ES$\02_差込印刷イメージ作成\差込み作業用\sql\"
set SQL_NAME="sample"
set EXT=".sql"
set PATH_MYSQL64="%~dp0\bin\64\"
set PATH_MYSQL32="%~dp0\bin\32\"
set OSTYPE=%PROCESSOR_ARCHITECTURE%
if (%OSTYPE% == "AMD64") (
%PATH_MYSQL64%mysql -h 172.16.253.156 -P 32767 -u root -pzentester2019 zen < %PATH_SQL%%SQL_NAME%%EXT% > %~dp0/OUTPUT/%SQL_NAME%.csv
)else (%PATH_MYSQL32%mysql -h 172.16.253.156 -P 32767 -u root -pzentester2019 zen < %PATH_SQL%%SQL_NAME%%EXT% > %~dp0/OUTPUT/%SQL_NAME%.csv)
pause
exit 
