@echo off
SETLOCAL EnableDelayedExpansion

cd ./vscode

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

echo ~~~~~ Installing %TOOL_NAME% ~~~~~

:Install
%INSTALLER% /VERYSILENT /MERGETASKS=!runcode /DIR=%INSTALL_LOCATION%

:: Exit directory of this script
cd ..

ENDLOCAL