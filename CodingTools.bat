@echo off
SETLOCAL EnableDelayedExpansion

::Set Working Directory to the location of this script
cd /d %~dp0

::Install Menu

echo 1. Install All
echo 2. Post Configuration Only
echo 3. Uninstall All
echo 4. Exit

set /p choice="Enter your choice: "
if !choice!==1 goto InstallAll
if !choice!==2 goto PostConfig
if !choice!==3 goto UninstallAll
if !choice!==4 exit

:InstallAll
CALL anaconda\setup.bat
CALL gitbash\setup.bat
CALL vscode\setup.bat
echo ~~~~~ Ready to Install ~~~~~
pause
CALL anaconda\install.bat
CALL gitbash\install.bat
CALL vscode\install.bat
echo ~~~~~ Installation Complete ~~~~~
goto PostConfig

:UninstallAll
CALL anaconda\uninstall.bat
CALL gitbash\uninstall.bat
CALL vscode\uninstall.bat
echo ~~~~~ Uninstall Complete ~~~~~
pause
exit /b

:PostConfig
if not exist %UserProfile%\dev (
    mkdir %UserProfile%\dev
)
CALL anaconda\post.bat
CALL gitbash\post.bat
CALL vscode\post.bat
echo ~~~~~ Post Configuration Complete ~~~~~
pause
exit /b

:Exit
exit /b