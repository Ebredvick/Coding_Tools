@echo off
SETLOCAL EnableDelayedExpansion

echo ~~~~~ Running %TOOL_NAME% Uninstaller ~~~~~

cd ./anaconda

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

:Uninstall
call "%INSTALL_LOCATION%\Uninstall-Anaconda3.exe"
goto WaitForUninstall

:WaitForUninstall
timeout /t 3 /nobreak > nul
tasklist | findstr /R "Un_A" >nul 2>&1
if errorlevel 1 (
    echo %TOOL_NAME% is uninstalled
    goto Cleanup
) else (
    goto WaitForUninstall
)

:Cleanup
del /s /q "%UserProfile%\anaconda3"

cd ..
ENDLOCAL
exit /b