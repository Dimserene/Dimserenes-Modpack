@echo off
echo *******************************************************
echo IMPORTANT: Please backup your current Mods folder before proceeding.
echo The installation will overwrite existing files in your Mods directory.
echo *******************************************************
pause

REM Set repository folder path
set "REPO_FOLDER=BetterCalc-Pack"
set "TARGET_FOLDER=%appdata%\Balatro\Mods"

REM Check if the repository folder already exists
if exist "%REPO_FOLDER%" (
    echo The repository folder "%REPO_FOLDER%" already exists.
    echo Would you like to delete it and clone a fresh copy? This will erase all its contents.
    echo Press Y to confirm or N to cancel the operation.
    set /p "choice=Your choice (Y/N): "
    if /i "%choice%"=="Y" (
        echo Deleting the existing repository folder...
        rmdir /s /q "%REPO_FOLDER%"
        if exist "%REPO_FOLDER%" (
            echo Failed to delete the folder. Please check permissions.
            pause
            exit /b 1
        ) else (
            echo Repository folder deleted successfully.
        )
    ) else (
        echo Operation canceled by the user.
        pause
        exit /b 1
    )
)

REM Clone the repository
echo Cloning the modpack repository...
git clone --recurse-submodules --remote-submodules https://github.com/Dimserene/BetterCalc-Pack
if errorlevel 1 (
    echo Failed to clone the repository. Please check your internet connection or Git installation.
    pause
    exit /b 1
)

REM Check if the Mods folder exists in the repository
if not exist "%REPO_FOLDER%\Mods" (
    echo The Mods folder was not found in the repository. Please ensure the repository is correct.
    pause
    exit /b 1
)

REM Check if the target Mods folder exists
if exist "%TARGET_FOLDER%" (
    echo The target Mods folder already exists at %TARGET_FOLDER%.
    echo Would you like to delete it? This will erase all its contents.
    echo Press Y to confirm or N to cancel the installation.
    set /p "choice=Your choice (Y/N): "
    if /i "%choice%"=="Y" (
        echo Deleting the existing Mods folder...
        rmdir /s /q "%TARGET_FOLDER%"
        if exist "%TARGET_FOLDER%" (
            echo Failed to delete the folder. Please check permissions.
            pause
            exit /b 1
        ) else (
            echo Existing Mods folder deleted successfully.
        )
    ) else (
        echo Installation canceled by the user.
        pause
        exit /b 1
    )
)

REM Copy Mods folder to the target location
echo Copying Mods folder to %TARGET_FOLDER%...
xcopy "%REPO_FOLDER%\Mods" "%TARGET_FOLDER%" /e /h /i /y
if errorlevel 1 (
    echo Failed to copy Mods folder. Please check the source and destination paths.
    pause
    exit /b 1
)

echo Installation complete. Please ensure everything is working correctly.
pause
