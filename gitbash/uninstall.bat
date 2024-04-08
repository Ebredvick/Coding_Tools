@echo off
SETLOCAL EnableDelayedExpansion

echo ~~~~~ Running %TOOL_NAME% Uninstaller ~~~~~

cd ./gitbash

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

::SET UNINSTALLER if _0 exists or _1 exists
if exist %UNINSTALLER_0% (
    set UNINSTALLER=%UNINSTALLER_0%
) else (
    set UNINSTALLER=%UNINSTALLER_1%
)

:Uninstall
if exist %UNINSTALLER% (
    call %UNINSTALLER% /VERYSILENT /SUPPRESSMSGBOXES /FORCECLOSEAPPLICATIONS
    rmdir /s /q "%UserProfile%\Git"
    del "%UserProfile%\Desktop\Git Bash.lnk"
    ::Delete Git files
    del /f /q "%UserProfile%\.bash_history"
    del /f /q "%UserProfile%\.bashrc"
    del /f /q "%UserProfile%\.bash_profile"
    del /f /q "%UserProfile%\.gitconfig"
) else (
    echo Uninstaller not found
)

cd ..
ENDLOCAL
exit /b