@echo off
SETLOCAL EnableDelayedExpansion

cd ./vscode

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

echo ~~~~~ Running %TOOL_NAME% Configuration ~~~~~

::check if necessary folders exist
if not exist %APPDATA%/Code/User (
    mkdir %APPDATA%/Code/User
)

xcopy .\settings.json %APPDATA%\Code\User /i /y

::Registry Key to Open Files with VSCode
SET KEY_NAME="HKEY_CLASSES_ROOT\Directory\shell\VSCode"
SET VALUE_NAME=""
SET VALUE_TYPE="REG_SZ"
SET VALUE_DATA="Open w&ith Code"

REG ADD %KEY_NAME% /v %VALUE_NAME% /t %VALUE_TYPE% /d %VALUE_DATA% /f

SET KEY_NAME="HKEY_CLASSES_ROOT\Directory\shell\VSCode"
SET VALUE_NAME="Icon"
SET VALUE_TYPE="REG_SZ"
SET VALUE_DATA="%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"

REG ADD %KEY_NAME% /v %VALUE_NAME% /t %VALUE_TYPE% /d %VALUE_DATA% /f

SET KEY_NAME="HKEY_CLASSES_ROOT\Directory\shell\VSCode\command"
SET VALUE_NAME=""
SET VALUE_TYPE="REG_SZ"
SET VALUE_DATA="\"%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe\" \"%%V\""

REG ADD %KEY_NAME% /v %VALUE_NAME% /t %VALUE_TYPE% /d %VALUE_DATA% /f

::Registry Key to Open Folders with VSCode
SET KEY_NAME="HKEY_CLASSES_ROOT\*\shell\VSCode"
SET VALUE_NAME=""
SET VALUE_TYPE="REG_SZ"
SET VALUE_DATA="Open w&ith Code"

REG ADD %KEY_NAME% /v %VALUE_NAME% /t %VALUE_TYPE% /d %VALUE_DATA% /f

SET KEY_NAME="HKEY_CLASSES_ROOT\*\shell\VSCode"
SET VALUE_NAME="Icon"
SET VALUE_TYPE="REG_SZ"
SET VALUE_DATA="%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"

REG ADD %KEY_NAME% /v %VALUE_NAME% /t %VALUE_TYPE% /d %VALUE_DATA% /f

SET KEY_NAME="HKEY_CLASSES_ROOT\*\shell\VSCode\command"
SET VALUE_NAME=""
SET VALUE_TYPE="REG_SZ"
SET VALUE_DATA="\"%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe\" \"%%1\""

REG ADD %KEY_NAME% /v %VALUE_NAME% /t %VALUE_TYPE% /d %VALUE_DATA% /f

powershell -Command "$WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut('%SHORTCUT_PATH%\VS Code.lnk'); $Shortcut.TargetPath = '%VSCODE_PATH%'; $Shortcut.Save()"

cd ..

ENDLOCAL