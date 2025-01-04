@echo off
echo *******************************************************
echo IMPORTANT: Please backup your current Mods folder before proceeding.
echo The installation will overwrite existing files in your Mods directory.
echo *******************************************************
pause

git remote set-url origin https://github.com/Dimserene/Active-Pack
git pull
git submodule update --remote --recursive --merge

echo Copying Mods folder to %appdata%\Balatro\Mods
xcopy "Mods" "%appdata%\Balatro\Mods" /w /e /h /i

echo Update complete. Please ensure everything is working correctly.
pause