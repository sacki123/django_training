@echo off
rem ================================================================================
rem 
rem 	Project Name:
rem 		Developer Command Framework for Windows.
rem 
rem 	Module Name:
rem 		Local Machine init.
rem 
rem 	Date:
rem 		$Id: local.init.cmd 5 2018-08-10 10:37:04Z sonohara $
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

call npm update -g
call npm install grunt-cli -g

call npm install gulp -g

call npm install cordova -g
call npm install cordova-icon -g
call npm install cordova-splash -g
call npm install cordova-imaging -g

pause
:end
endlocal
