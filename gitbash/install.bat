@echo off
SETLOCAL EnableDelayedExpansion

::Enter directory of this script
cd ./gitbash

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

:: Check if installer already exists
if exist %INSTALLER% (
    echo Installer already exists
    goto :Install
) else (
    echo Installer does not exist
    goto :Download
)

:Download
echo ~~~~~ Downloading %TOOL_NAME% ~~~~~
curl -L -o %INSTALLER% %DOWNLOAD_URL%
timeout /t 3 /nobreak > nul
goto :Install

:Install
echo ~~~~~ Installing %TOOL_NAME% ~~~~~
%INSTALLER% /SP- /VERYSILENT /SUPPRESSMSGBOXES /FORCECLOSEAPPLICATIONS /DIR=%INSTALL_LOCATION%

:: Exit directory of this script
cd ..

ENDLOCAL