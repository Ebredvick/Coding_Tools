@echo off
SETLOCAL EnableDelayedExpansion

cd ./gitbash

:: Read the config file
for /f "tokens=1* delims==" %%a in (config.txt) do (
    call set %%a=%%b
)

echo ~~~~~ Configuring Git ~~~~~
set "bashrc=%USERPROFILE%\.bashrc"
set "gitconfig=%USERPROFILE%\.gitconfig"
echo # .bashrc > "%bashrc%"
echo # .gitconfig > "%gitconfig%"

:: Set User Name and Email
set /p GIT_NAME="Enter Your Git User Name: "
set /p GIT_EMAIL="Enter Your Git Email: "
echo [user] > "%gitconfig%"
echo     name = %GIT_NAME% >> "%gitconfig%"
echo     email = %GIT_EMAIL% >> "%gitconfig%"

::Set Alias
echo [alias] >> "%gitconfig%"
echo     "lg = log --color --graph --pretty=format:'%%Cred%%h%%Creset -%%C(yellow)%%d%%Creset %%s %%Cgreen(%%cr) %%C(bold blue)<%%an>%%Creset' --abbrev-commit" >> "%gitconfig%"

::Set nano as default editor
echo [core] >> "%gitconfig%"
echo     editor = nano >> "%gitconfig%"

::Add Conda command to Git Bash
echo . /c/Users/%USERNAME%/anaconda3/etc/profile.d/conda.sh >> %USERPROFILE%/.bashrc
echo export PATH="%USERPROFILE%/anaconda3:$PATH" >> %USERPROFILE%/.bashrc

:: Set Home Directory
echo export HOME="%UserProfile%/dev" >> %UserProfile%\Git\etc\profile

:: Create Shortcut On Desktop
powershell -Command "$WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut('"%SHORTCUT_PATH%"\Git Bash.lnk'); $Shortcut.TargetPath = '!GIT_BASH_BIN_PATH!'; $Shortcut.Save()"
pause
cd ..