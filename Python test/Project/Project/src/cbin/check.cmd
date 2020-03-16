@echo off
set PROJECT_HOME_BBIN=%CD%..\..\bbin
set REPORT_PY=%PROJECT_HOME_BBIN%\report.py
set MAKE_DS=%PROJECT_HOME_BBIN%\zen\pdf\make\P99\DS
set MAKE_JA=%PROJECT_HOME_BBIN%\zen\pdf\make\P99\JA
set MAKE_ZS=%PROJECT_HOME_BBIN%\zen\pdf\make\P99\ZS
set MAKE_JZ=%PROJECT_HOME_BBIN%\zen\pdf\make\P02\JZ
set OUTPUT_PDF=%PROJECT_HOME_BBIN%\zen\pdf\output_pdf

@echo *********エラーチェックbatchの作成*********
IF EXIST logs.txt Del logs.txt

:count
set i=0

REM Check JA
set /p var=Do you want to check JA?[Y/N]: 
if not %var%== N if not %var%== n (
    @echo Before to check, You need to delete all file output pdf in folder
    Del %OUTPUT_PDF%\JA\*
    @echo JA is Checking...

    echo ****Errors of JA**** >> logs.txt
    FOR %%i in (%MAKE_JA%\*.py) DO (
        @echo %%~ni running...
        python %REPORT_PY% \\etc\\default.ini make %%~ni
        set "TRUE="
        IF EXIST %OUTPUT_PDF%\P99\JA\%%~ni_001.pdf set TRUE=1
        IF EXIST %OUTPUT_PDF%\P99\JA\%%~ni_001.xlsx set TRUE=1
        IF EXIST %OUTPUT_PDF%\P99\JA\%%~ni_001.xls set TRUE=1
        IF defined TRUE (
            echo Successfully!
        ) ELSE (
            echo Failed!!!
            set /a i+=1
            echo %%~ni >> logs.txt
        )
    )
)


REM Check DS
Cls
set /p var=Do you want to check DS?[Y/N]: 
if not %var%== N if not %var%== n (
    @echo Before to check, You need to delete all file output pdf in folder
    Del %OUTPUT_PDF%\DS\*
    @echo DS is Checking...
    echo ****Errors of DS**** >> logs.txt
    FOR %%i in (%MAKE_DS%\*.py) DO (
        @echo %%~ni running...
        python %REPORT_PY% \\etc\\default.ini make %%~ni
        set "TRUE="
        IF EXIST %OUTPUT_PDF%\P99\DS\%%~ni_001.pdf set TRUE=1
        IF EXIST %OUTPUT_PDF%\P99\DS\%%~ni_001.xlsx set TRUE=1
        IF EXIST %OUTPUT_PDF%\P99\DS\%%~ni_001.xls set TRUE=1
        IF defined TRUE (
            echo Successfully!
        ) ELSE (
            echo Failed!!!
            set /a i+=1
            echo %%~ni >> logs.txt
        )
    )
)

REM Check ZS
set /p var=Do you want to check ZS?[Y/N]: 
if not %var%== N if not %var%== n (
    @echo Before to check, You need to delete all file output pdf in folder
    Del %OUTPUT_PDF%\ZS\*
    @echo ZS is Checking...
    echo ****Errors of ZS**** >> logs.txt
    FOR %%i in (%MAKE_ZS%\*.py) DO (
        @echo %%~ni running...
        python %REPORT_PY% \\etc\\default.ini make %%~ni
        set "TRUE="
        IF EXIST %OUTPUT_PDF%\P99\ZS\%%~ni_001.pdf set TRUE=1
        IF EXIST %OUTPUT_PDF%\P99\ZS\%%~ni_001.xlsx set TRUE=1
        IF EXIST %OUTPUT_PDF%\P99\ZS\%%~ni_001.xls set TRUE=1
        IF defined TRUE (
            echo Successfully!
        ) ELSE (
            echo Failed!!!
            set /a i+=1
            echo %%~ni >> logs.txt
        )
    )
)

REM Check JZ
set /p var=Do you want to check JZ?[Y/N]: 
if not %var%== N if not %var%== n (
    @echo Before to check, You need to delete all file output pdf in folder
    Del %OUTPUT_PDF%\JZ\*
    @echo JZ is Checking...
    echo ****Errors of JZ**** >> logs.txt
    FOR %%i in (%MAKE_JZ%\*.py) DO (
        @echo %%~ni running...
        python %REPORT_PY% \\etc\\default.ini make %%~ni
        set "TRUE="
        IF EXIST %OUTPUT_PDF%\P02\JZ\%%~ni_001.pdf set TRUE=1
        IF EXIST %OUTPUT_PDF%\P02\JZ\%%~ni_001.xlsx set TRUE=1
        IF EXIST %OUTPUT_PDF%\P02\JZ\%%~ni_001.xls set TRUE=1
        IF defined TRUE (
            echo Successfully!
        ) ELSE (
            echo Failed!!!
            set /a i+=1
            echo %%~ni >> logs.txt
        )
    )
)

Cls
REM Print Notices Errors
if not %i%==0 (
    echo Have %i% Errors
    echo Please check Errors in the file log.txt
)

:end
PAUSE