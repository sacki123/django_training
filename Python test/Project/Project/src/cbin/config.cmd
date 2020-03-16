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
rem 		$Id: config.cmd 5 2018-08-10 10:37:04Z sonohara $
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

rem Project Home
set PROJECT_HOME=%CD%\..

rem node.js v5.0.x
set NODEJS_HOME=%ProgramFiles%\nodejs

rem Android Studio
set ANDROID_STUDIO=%ProgramFiles%\android\Android Studio

rem JDK v1.8.x
set JDK_HOME=%ProgramFiles%\Java\jdk1.8.0_162

rem Android v23.x
set ANDROID_HOME=%LOCALAPPDATA%\Android\android-sdk

rem Cordova Project
set CORDOVA_DIR=%PROJECT_HOME%\cordova

rem Cordova Package
set CORDOVA_PACKAGE=

rem Python v2.7.x
set PYTHON_HOME=C:\Python\2.7

rem GIT
set GIT_HOME=%ProgramFiles%\Git

rem ImageMagick
set IM_HOME=%ProgramFiles%\ImageMagick-7.0.7-Q16

rem PHP v5.3.x
set PHP_HOME=C:\xampp\php
