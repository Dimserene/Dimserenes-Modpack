# Dimserene's Modpacks (for Steamodded-1.0.0 Alpha)

![Alttext](https://github.com/Dimserene/Dimserenes-Modpack/blob/main/NewFullPackLogo.png)

Sub-Modpacks: [Vanilla Plus Pack](https://github.com/Dimserene/Vanilla-Plus-Pack) & [Fine-tuned Pack](https://github.com/Dimserene/Fine-tuned-Pack)

#### Thank you all the mod authors and many others on discord for helping and testing!
(Updates frequently)
Custom-made modpacks that are hand-picked and put together by myself

Some mod files needs to be altered to avoid compat issues if you want to put the mods together.（Note that i have applied all the modifications in the modpack)

This is not a full list of 1.0.0 compatible mods, this is a modpack that when put together and my goal is they should function with no problem.(at least i hope)

If you wanna join us dealing with this nightmare beast, you can join our [Discord](https://discord.com/channels/1116389027176787968/1255696773599592458)

(If you don't have access to Balatro official discord, click [here](https://discord.com/invite/balatro) first)

## Prerequisites

- Install [Git](https://git-scm.com/)

  [Download](https://git-scm.com/downloads)

- Install [__Lovely__](https://github.com/ethangreen-dev/lovely-injector) (latest release)

    [Download](https://github.com/ethangreen-dev/lovely-injector/releases) [Discord](https://discord.com/channels/1116389027176787968/1214591552903716954) [Authors](https://github.com/ethangreen-dev/lovely-injector/graphs/contributors?from=2024-03-03&to=2024-06-26&type=c)

---

> __⚠️You don't need to install Steamodded yourself! The modpack will install and update Steamodded for you!__ 

---

## How to Install

  Download __SetupFull.bat__(Windows) or __SetupFull.sh__(Linux), put it wherever you want, and run it. The mods will be automatically downloaded and put into correct directory.

  Or run following scripts in command prompt:

  ```
git clone --recurse-submodules --remote-submodules https://github.com/Dimserene/Dimserenes-Modpack
xcopy "Dimserenes-Modpack\Mods" "%appdata%\Balatro\Mods" /w /e /h /i
  ```

## How to Update Modpack

  Run __Update.bat__(Windows) or __UpdateFull.sh__(Linux) which should be in the downloaded Dimserenes-Modpack folder.

  Or run following commands where your downloaded modpack located:

  ```
git remote set-url origin https://github.com/Dimserene/Dimserenes-Modpack
git pull
git submodule update --remote --recursive --merge
  ```

  And then, copy all the contents in Mods folder to your Mods folder.

## FAQ

  1. There's some game crash / function not working as intended / other problem and i wanna report them!

     - Feel free to join the [Discord](https://discord.com/channels/1116389027176787968/1255696773599592458) and talk about them!
     
## The List ([Google Sheet](https://docs.google.com/spreadsheets/d/1L2wPG5mNI-ZBSW_ta__L9EcfAw-arKrXXVD-43eU4og/))

- [__Steamodded 1.0.0 Alpha__](https://github.com/Steamopollys/Steamodded) (latest main code)

  [Download](https://github.com/Steamopollys/Steamodded/archive/refs/heads/main.zip) [Discord](https://discord.com/channels/1116389027176787968/1209564621644505158) [Authors](https://github.com/Steamopollys/Steamodded/graphs/contributors)
