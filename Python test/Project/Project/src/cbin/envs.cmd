@echo off
rem ================================================================================
rem 
rem 	Project Name:
rem 		Developer Command Framework for Windows.
rem 
rem 	Module Name:
rem 		Command config file.
rem 
rem 	Date:
rem 		$Id: envs.cmd 5 2018-08-10 10:37:04Z sonohara $
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

IF NOT "%PROJECT_DONE%" == "" goto end

rem Project Home
IF "%PROJECT_HOME%" == "" SET PROJECT_HOME=%~dp0\..

IF EXIST "%PROJECT_HOME%\config.cmd" (
  CALL %PROJECT_HOME%\config.cmd
)

IF EXIST "%PROJECT_HOME%\config.local.cmd" (
  CALL %PROJECT_HOME%\config.local.cmd
)

IF NOT "%NODEJS_HOME%" == "" call "%NODEJS_HOME%\nodevars.bat"
IF NOT "%JAVA_HOME%" == "" SET JAVA_HOME=%JDK_HOME%
IF NOT "%JDK_HOME%" == "" SET PATH=%JDK_HOME%\bin;%PATH%
IF NOT "%PYTHON_HOME%" == "" SET PATH=%PYTHON_HOME%;%PYTHON_HOME%\Scripts;%PATH%
IF NOT "%ANDROID_HOME%" == "" SET PATH=%ANDROID_HOME%;%ANDROID_HOME%\tools;%ANDROID_HOME%\platform-tools;%PATH%
IF NOT "%PROJECT_HOME%" == "" SET PATH=%PROJECT_HOME%\bin;%PATH%
IF NOT "%PROJECT_HOME%" == "" SET PATH=%PROJECT_HOME%\cbin;%PATH%
IF NOT "%NODEJS_HOME%" == "" SET PATH=%PROJECT_HOME%\node_modules\.bin;%PATH%
IF NOT "%NODEJS_HOME%" == "" SET PATH=%APPDATA%\npm\.bin;%PATH%
IF NOT "%GIT_HOME%" == "" SET PATH=%GIT_HOME%\bin;%PATH%
IF NOT "%PHP_HOME%" == "" SET PATH=%PHP_HOME%\;%PATH%
IF NOT "%IM_HOME%" == "" SET PATH=%IM_HOME%;%PATH%
IF NOT "%GO_HOME%" == "" SET PATH=%GO_HOME%\bin;%PATH%

SET PATH=%~dp0;%PATH%

IF EXIST "%PYTHON_HOME%\Scripts\activate.bat" (
  CALL %PYTHON_HOME%\Scripts\activate.bat
)

SET PROJECT_DONE=%CD%
IF NOT "%GO_HOME%" == "" IF "%GOPATH%" == "" SET GOPATH=%PROJECT_DONE%\.go
IF NOT "%GO_HOME%" == "" IF "%GOPATH%" == "" SET PATH=%GOPATH%\bin;%PATH%

cd /d %PROJECT_HOME%

:end
