@echo off
SETLOCAL EnableDelayedExpansion

cd ./gitbash

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

echo ~~~~~ Running %TOOL_NAME% Installer ~~~~~

:Install
%INSTALLER% /SP- /VERYSILENT /SUPPRESSMSGBOXES /FORCECLOSEAPPLICATIONS /DIR=%INSTALL_LOCATION%

:: Exit directory of this script
cd ..

ENDLOCAL