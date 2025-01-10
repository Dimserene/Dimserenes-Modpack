@echo off

echo ********************************************************
echo IMPORTANT: Please backup your current Mods folder before proceeding.
echo The installation will overwrite existing files in your Mods directory.
echo ********************************************************

:: Check if old Dimserenes-Modpack folder exists
if exist "Dimserenes-Modpack" (
    echo A previous Dimserenes-Modpack folder already exists.
    echo It will now be removed before cloning a new copy.
    echo Press [ENTER] to continue or close this window to cancel.
    pause
    rmdir /s /q "Dimserenes-Modpack"
)

:: Clone the modpack
git clone --recurse-submodules --remote-submodules https://github.com/Dimserene/Dimserenes-Modpack

:: Copy new Mods folder to the Balatro Mods directory
echo Copying Mods folder to %appdata%\Balatro\Mods ...
xcopy "Dimserenes-Modpack\Mods" "%appdata%\Balatro\Mods" /w /e /h /i

echo Installation complete. Please ensure everything is working correctly.
pause