@echo off
SETLOCAL EnableDelayedExpansion

cd ./gitbash

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

echo ~~~~~ Configuring %TOOL_NAME% ~~~~~

::check if necessary files exist
if not exist .gitconfig (
    goto :CreateFiles
)
if not exist .bashrc (
    goto :CreateFiles
)
if not exist .bash_profile (
    goto :CreateFiles
)

:MoveFiles
:: Move Git Bash Files
xcopy .\.gitconfig %USERPROFILE% /y /i
xcopy .\.bashrc %USERPROFILE% /y /i
xcopy .\.bash_profile %USERPROFILE% /y /i
goto End

:CreateFiles
:: Set User Name and Email
set /p GIT_NAME="Enter Your Git User Name: "
set /p GIT_EMAIL="Enter Your Git Email: "

!GIT_BIN_PATH! config --global user.name "%GIT_NAME%"
!GIT_BIN_PATH! config --global user.email "%GIT_EMAIL%"
!GIT_BIN_PATH! config --global alias.lg "log --color --graph --pretty=format:'%%Cred%%h%%Creset -%%C(yellow)%%d%%Creset %%s %%Cgreen(%%cr) %%C(bold blue)<%%an>%%Creset' --abbrev-commit"
!GIT_BIN_PATH! config --global core.editor "nano"

::Add Conda command to Git Bash
if exist %UserProfile%\.bashrc (
    del %UserProfile%\.bashrc
)
echo . /c/Users/%USERNAME%/anaconda3/etc/profile.d/conda.sh >> %USERPROFILE%/.bashrc
echo export PATH="%USERPROFILE%/anaconda3:$PATH" >> %USERPROFILE%/.bashrc

::Create .bash_profile
if exist %UserProfile%\.bash_profile (
    del %UserProfile%\.bash_profile
)
echo source ~/.bashrc >> %UserProfile%\.bash_profile

:End
:: Create Shortcut On Desktop
powershell -Command "$WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut('"%SHORTCUT_PATH%"\Git Bash.lnk'); $Shortcut.TargetPath = '!GIT_BASH_BIN_PATH!'; $Shortcut.Save()"
cd ..
ENDLOCAL