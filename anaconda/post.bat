@echo off
SETLOCAL EnableDelayedExpansion

cd ./anaconda

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

echo ~~~~~ Running %TOOL_NAME% Configuration ~~~~~
echo Not Implemented

cd ..

ENDLOCAL