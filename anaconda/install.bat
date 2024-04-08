@echo off
SETLOCAL EnableDelayedExpansion

echo ~~~~~ Installing %TOOL_NAME% ~~~~~

cd ./anaconda

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

:Install
%INSTALLER% /InstallationType=JustMe /RegisterPython=0 /S /D=%INSTALL_LOCATION%

:: Exit directory of this script
cd ..

ENDLOCAL