@echo off
SETLOCAL EnableDelayedExpansion

::Install Menu

echo 1. Install All
echo 2. Uninstall All
echo 3. Post Configuration Only
echo 4. Exit

set /p choice="Enter your choice: "
if !choice!==1 goto InstallAll
if !choice!==2 goto UninstallAll
if !choice!==3 goto PostConfig
if !choice!==4 exit

:InstallAll
CALL gitbash\setup.bat
pause
CALL gitbash\install.bat
exit /b

:UninstallAll
exit /b

:PostConfig
exit /b

:Exit
exit /b