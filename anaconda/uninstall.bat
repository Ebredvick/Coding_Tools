@echo off
SETLOCAL EnableDelayedExpansion

cd ./anaconda

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

echo ~~~~~ Running %TOOL_NAME% Uninstaller ~~~~~

:Uninstall
call "%INSTALL_LOCATION%\Uninstall-Anaconda3.exe" /S
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
rmdir /s /q "%UserProfile%\anaconda3"
rmdir /s /q "%UserProfile%\.condarc"
rmdir /s /q "%UserProfile%\.anaconda"
rmdir /s /q "%UserProfile%\.continuum"
rmdir /s /q "%UserProfile%\.conda"

:End
cd ..
ENDLOCAL
exit /b