@echo off
SETLOCAL EnableDelayedExpansion

cd ./vscode

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

echo ~~~~~ Running %TOOL_NAME% Uninstaller ~~~~~

::SET UNINSTALLER if _0 exists or _1 exists
if exist %UNINSTALLER_0% (
    set UNINSTALLER=%UNINSTALLER_0%
) else (
    set UNINSTALLER=%UNINSTALLER_1%
)

:Uninstall
if exist %UNINSTALLER% (
    call %UNINSTALLER% /VERYSILENT
    rmdir /s /q "%LocalAppData%\Programs\Microsoft VS Code"
    del "%UserProfile%\Desktop\VS Code.lnk"
) else (
    echo Uninstaller not found
)

cd ..
ENDLOCAL
exit /b
