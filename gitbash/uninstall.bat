@echo off
SETLOCAL EnableDelayedExpansion

cd ./gitbash

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
    call %UNINSTALLER% /VERYSILENT /SUPPRESSMSGBOXES /FORCECLOSEAPPLICATIONS
) else (
    echo Uninstaller not found
)

:Cleanup
rmdir /s /q "%UserProfile%\Git"
del "%UserProfile%\Desktop\Git Bash.lnk"
del /f /q "%UserProfile%\.bash_history"
del /f /q "%UserProfile%\.bashrc"
del /f /q "%UserProfile%\.bash_profile"
del /f /q "%UserProfile%\.gitconfig"

:End
cd ..
ENDLOCAL

exit /b