@echo off
setLocal enableDelayedExpansion
set /a i=-1
for /f %%a in (config.txt) do (
set /a i+=1
set value!i!=%%a
)
echo !value0!
echo !value1!
echo !value2!
echo !value3!
echo !value4!
pause


