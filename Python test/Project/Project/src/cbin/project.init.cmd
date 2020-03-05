@echo off
rem ================================================================================
rem 
rem 	Project Name:
rem 		Developer Command Framework for Windows.
rem 
rem 	Module Name:
rem 		Project init.
rem 
rem 	Date:
rem 		$Id: project.init.cmd 5 2018-08-10 10:37:04Z sonohara $
rem 
rem 	History:
rem 		2014/09/01 K.Sonohara
rem 			New create.
rem 
rem 	Site:
rem 		ExpertSoftware Inc.
rem 		https://www.e-software.company/
rem 
rem ================================================================================

setlocal
call %~dp0\envs.cmd

cd /d %PROJECT_HOME%

if not "%NODEJS_HOME%" == "" (
mkdir %PROJECT_HOME%\node_modules
compact /c "%PROJECT_HOME%\node_modules"

call npm install
call npm update
)

pause
:end
endlocal
