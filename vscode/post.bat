@echo off
SETLOCAL EnableDelayedExpansion

cd ./vscode

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

echo ~~~~~ Running %TOOL_NAME% Configuration ~~~~~

::check if necessary folders exist
if not exist %APPDATA%/Roaming/Code/User (
    mkdir %APPDATA%/Roaming/Code/User
)

xcopy .\settings.json %APPDATA%\Roaming\Code\User /i

powershell -Command "$WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut('%SHORTCUT_PATH%\VS Code.lnk'); $Shortcut.TargetPath = '%VSCODE_PATH%'; $Shortcut.Save()"

cd ..

ENDLOCAL