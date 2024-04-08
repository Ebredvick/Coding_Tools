@echo off
SETLOCAL EnableDelayedExpansion

cd ./anaconda

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

echo ~~~~~ Running %TOOL_NAME% Installer ~~~~~

:Install
%INSTALLER% /InstallationType=JustMe /RegisterPython=0 /S /D=%INSTALL_LOCATION%

:: Exit directory of this script
cd ..

ENDLOCAL