#!/bin/bash

echo "*******************************************************"
echo "IMPORTANT: Please backup your current Mods folder before proceeding."
echo "The installation will overwrite existing files in your Mods directory."
echo "*******************************************************"
read -p "Press [Enter] to continue..."

git remote set-url origin https://github.com/Dimserene/BetterCalc-Pack
git pull
git submodule update --remote --recursive --merge

echo "Copying Mods folder to the Balatro Mods directory..."
cp -r ./Mods /home/$USER/.steam/steam/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro

echo "Update complete. Please ensure everything is working correctly."
read -p "Press [Enter] to continue..."