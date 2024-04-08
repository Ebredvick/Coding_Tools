@echo off
SETLOCAL EnableDelayedExpansion

cd ./vscode

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

echo ~~~~~ Running %TOOL_NAME% Installer ~~~~~

:Install
%INSTALLER% /VERYSILENT

:: Exit directory of this script
cd ..

ENDLOCAL