@echo off

echo ~~~~~ Running %TOOL_NAME% Configuration ~~~~~

powershell -Command "$WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut('%DESKTOP_PATH%\VS Code.lnk'); $Shortcut.TargetPath = '%VSCODE_PATH%'; $Shortcut.Save()"