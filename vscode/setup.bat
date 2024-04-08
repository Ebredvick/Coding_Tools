@echo off
SETLOCAL EnableDelayedExpansion

echo ~~~~~ %TOOL_NAME% Setup ~~~~~

::Enter directory of this script
cd ./vscode

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

:: Check if installer already exists
if exist %INSTALLER% (
    echo Installer already exists
    echo 1. Install Current Version
    echo 2. Manually Download New Version
    set /p choice="Enter your choice: "
    if !choice!==1 goto :End
    if !choice!==2 goto :DeleteDownload
    goto :Install
) else (
    echo Installer does not exist
    goto :SetupDownload
)

:DeleteDownload
echo ~~~~~ Deleting %INSTALLER% ~~~~~
del %INSTALLER%
goto :Download

:SetupDownload
echo Current URL is %DOWNLOAD_URL%
echo 1. Use Current URL
echo 2. Enter New URL
set /p choice="Enter your choice: "
if !choice!==2 (
    set /p DOWNLOAD_URL="Enter the new URL: "

    set search=DOWNLOAD_URL
    set replace=DOWNLOAD_URL="!DOWNLOAD_URL!"

    for /f "tokens=1* delims==" %%a in (config.txt) do (
        if %%a==!search! (
            echo !replace! >> temp.tmp
        ) else (
            echo %%a=%%b >> temp.tmp
        )
    )
    move /y temp.tmp config.txt
)


:Download
echo ~~~~~ Downloading %TOOL_NAME% ~~~~~
curl -L -o %INSTALLER% %DOWNLOAD_URL%
timeout /t 3 /nobreak > nul

Exit directory of this script
cd ..

:End
ENDLOCAL