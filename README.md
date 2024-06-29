# (WIP)Dimserene's Modpack (for Steamodded-1.0.0 Balatro)

#### Thank you all the mod authors, `@humplydinkle`, `@chromapie` & `@asgrich` on discord for helping and testing!
(Updates frequently)
A custom-made modpack that is hand-picked and put together by myself

Some mod files needs to be altered to avoid compat issues if you want to put the mods together, and I will specify them in the list.（Note that i have applied all the below-mentioned modifications in the modpack repo)

I repeat, this is not a full list of 1.0.0 compatible mods, this is a modpack that when put together and my goal is they should function with no problem.

(at least i hope, and if you wanna join us dealing with this nightmare beast, you can join our [Discord](https://discord.com/channels/1116389027176787968/1255696773599592458))

## Prerequisites

- Install [__Lovely__](https://github.com/ethangreen-dev/lovely-injector) (latest release)

    [Download](https://github.com/ethangreen-dev/lovely-injector/releases/tag/v0.5.0-beta6) [Discord](https://discord.com/channels/1116389027176787968/1214591552903716954) [Authors](https://github.com/ethangreen-dev/lovely-injector/graphs/contributors?from=2024-03-03&to=2024-06-26&type=c)


## How to Install

  ```
  git clone --recurse-submodules --remote-submodules https://github.com/Dimserene/Dimserenes-Modpack
  ```
  
  And copy the Mods folder into %Appdata%/Balatro


## How to Update Modpack

  ```
cd Dimserenes-Modpack/
git submodule update --remote --merge
  ```

## The List

- [__Steamodded 1.0.0 Alpha__](https://github.com/Steamopollys/Steamodded?tab=readme-ov-file) (latest main code)

  [Download](https://github.com/Steamopollys/Steamodded/archive/refs/heads/main.zip) [Discord](https://discord.com/channels/1116389027176787968/1209564621644505158) [Authors](https://github.com/Steamopollys/Steamodded/graphs/contributors)

- [__Ante Scaling Slower__](https://www.nexusmods.com/balatro/mods/7) (latest release)

  By Infarctus

  [Download](https://www.nexusmods.com/balatro/mods/7?tab=files) [Discord](https://discord.com/channels/1116389027176787968/1219418031546040351)

- [__Balatro Safety__](https://github.com/Zei33/balatro-safety-steamodded) (latest release)

  By Zei

  [Download](https://github.com/Zei33/balatro-safety-steamodded/releases) [Discord](https://discord.com/channels/1116389027176787968/1249718085301178418)

- [__Blank Joker__](https://github.com/GitNether/nethers-jokers) (latest release)

  By Nether

  [Download](https://github.com/GitNether/nethers-jokers/releases/tag/blank-joker-standalone) [Discord](https://discord.com/channels/1116389027176787968/1245432531852066897)

- [__Betmma Series__](https://github.com/betmma/my_balatro_mods) (latest release)

  By Betmma

  [Download](https://github.com/betmma/my_balatro_mods/releases) [Discord](https://discord.com/channels/1116389027176787968/1225831216939536394)

- [__Better Stakes__](https://github.com/kjossul/BetterStakes) (latest main code)

  By kjossul

  [Download](https://github.com/kjossul/BetterStakes/archive/refs/heads/main.zip) [Discord](https://discord.com/channels/1116389027176787968/1217067932660666431)

- [__Bunco__](https://github.com/Firch/Bunco/tree/main) (latest main code)

  By Firch

  [Download](https://github.com/Firch/Bunco/archive/refs/heads/main.zip) [Discord](https://discord.com/channels/1116389027176787968/1220084296346501201)
  
- [__Codex Arcanum__](https://github.com/itayfeder/Codex-Arcanum) (latest release)

  By itayfeder

  [Download](https://github.com/itayfeder/Codex-Arcanum/releases) [Discord](https://discord.com/channels/1116389027176787968/1221916334372290620)

  1. Needs tweak for compat with the following mods:
      - Bunco
      - D6 jokers
      - DX Tarots
  - Change all `SMODS.Tag(s)` and `SMODS.Booster(s)` instances everywhere in files of this mod into `CATag(s)` and `CABooster(s)`
  - Search for
```
if _c.set == "Alchemical" or (_c.set == 'Booster' and _c.name:find("Alchemy")) or _c.name == 'Shock Humor' then
```
in CA_Overrides.lua and replace it with
```
if _c.set == "Alchemical" or (_c.set == 'Booster' and (_c.name and _c.name:find("Alchemy"))) or _c.name == 'Shock Humor' then
```
   Thanks ejwu, Chromapie and Myst for this
  2. Needs tweak for compat with the following mods:
      - Not Just Yet
  - Find and delete this entire section:
    ![alt text](https://media.discordapp.net/attachments/1254814398476713994/1255174809122246666/image.png?ex=667cd4e2&is=667b8362&hm=41834b0f44b02933db6238cbd95861a86ddb142a8ab0e8e03d44433c1a3ded67&)
    Thanks Toneblock for this

- [__Cryptid__](https://github.com/MathIsFun0/Cryptid) (latest main code)

  By Mathisfun

  [Download](https://github.com/MathIsFun0/Cryptid/archive/refs/heads/main.zip) [Discord](https://discord.com/channels/1116389027176787968/1219749193204371456)
 
- [__D6 Jokers__](https://github.com/GauntletGames-2086/D6-Jokers) (latest main code)

  By ItsFlowwey

  [Download](https://github.com/GauntletGames-2086/D6-Jokers/archive/refs/heads/main.zip) [Discord](https://discord.com/channels/1116389027176787968/1249518446669074474)
  
- [__Deck Creator__](https://github.com/adambennett/Balatro-DeckCreator) (latest release)

  By Nyoxide

  [Download](https://github.com/adambennett/Balatro-DeckCreator/releases) [Discord](https://discord.com/channels/1116389027176787968/1211808102999924746)

- [__DX Tarots__](https://github.com/JeffVi/DX-Tarots) (latest release)

  By JeffVi

  [Download](https://github.com/JeffVi/DX-Tarots/releases) [Discord](https://discord.com/channels/1116389027176787968/1226210957253017691)

  - Needs tweak for compat with the following mods:
    - Bunco
    - D6 Jokers
    - Codex Arcanum
  - Change all `SMODS.Booster(s)` instances everywhere in files of this mod into `CABooster(s)`
  - Change all `love.filesystem` instances everywhere in files of this mod into `NFS`
    Thanks Chromapie and Myst for this 

- [__Enhanced Enhancements__](https://github.com/LunaAstraCassiopeia/LunasBalatroMods) (latest main code)

  By Luna

  [Download](https://github.com/LunaAstraCassiopeia/LunasBalatroMods/archive/refs/heads/main.zip) [Discord](https://discord.com/channels/1116389027176787968/1216064295633289286)

- [__Escape Exit Button__](https://github.com/Steamopollys/Steamodded/blob/main/example_mods/Mods/EscapeExitButton.lua#L13) (latest build)

  - One of the example mods by Steamopollys

- [__Faster planet card animation__](https://www.nexusmods.com/balatro/mods/43?tab=description) (latest release)

  By Boomer678

  [Download](https://www.nexusmods.com/balatro/mods/43?tab=files)

- [__Fusion Jokers__](https://itayfeder.github.io/Fusion-Jokers/) (latest release)

  By itayfeder

  [Download](https://github.com/itayfeder/Fusion-Jokers/releases) [Discord](https://discord.com/channels/1116389027176787968/1227317656131211284)

- [__House Rules__](https://github.com/Mysthaps/BalatroMods) (latest release)

  By Myst

  [Download](https://github.com/Mysthaps/BalatroMods/releases) [Discord](https://discord.com/channels/1116389027176787968/1226224247677124719)
  
- [__Jank Jonklers__](https://spikeof2010.github.io/JankJonklers/) (latest release)

  By Lyman

  [Download](https://github.com/spikeof2010/JankJonklers/releases) [Discord](https://discord.com/channels/1116389027176787968/1214838383805997117)

- [__Jestobiology__](https://github.com/spikeof2010/Jestobiology/tree/AlphaBeta) build (latest release)

  By Lyman

  [Download](https://github.com/spikeof2010/Jestobiology/releases) [Discord](https://discord.com/channels/1116389027176787968/1231665856619086005)

- [__Jimbo's Pack__](https://github.com/art-muncher/Jimbo-s-Pack) (latest release)

  By elial1

  [Download](https://github.com/art-muncher/Jimbo-s-Pack/releases) [Discord](https://discord.com/channels/1116389027176787968/1248287850512781452)

- [__Joker Evolution__](https://github.com/SDM0/Joker-Evolution) (latest release)

  By SDM_0

  [Download](https://github.com/SDM0/Joker-Evolution/releases) [Discord](https://discord.com/channels/1116389027176787968/1249450412143153266)

- [__Lobotomy Corporation__](https://github.com/Mysthaps/LobotomyCorp) (latest release)

  By Myst

  [Download](https://github.com/Mysthaps/LobotomyCorp/releases) [Discord](https://discord.com/channels/1116389027176787968/1248249207526002698)

- [__Loop__](https://discord.com/channels/1116389027176787968/1248431147784863840) (latest release)

  By jenwalter666

  [Download](https://discord.com/channels/1116389027176787968/1248431147784863840/1248431147784863840) [Discord](https://discord.com/channels/1116389027176787968/1248431147784863840)

- [__Math Blinds__](https://github.com/Bazinga9000/MathBlinds) (latest main code)

  By Bazinga_900

  [Download](https://github.com/Bazinga9000/MathBlinds/archive/refs/heads/main.zip) [Discord](https://discord.com/channels/1116389027176787968/1245962046235873301)

- [__Mika's Balatro Mod Collection__](https://github.com/MikaSchoenmakers/MikasBalatro) (latest main code)

  [Download](https://github.com/MikaSchoenmakers/MikasBalatro/archive/refs/heads/main.zip) [Discord](https://discord.com/channels/1116389027176787968/1215775159638818826)

- [__More Speeds__](https://github.com/Steamopollys/Steamodded/blob/main/example_mods/Mods/MoreSpeeds.lua) (latest build)

  [Discord](https://discord.com/channels/1116389027176787968/1210304870457020487)

  - One of the example mods by Steamopollys
  
- [__Myst's Boss Blinds__](https://github.com/Mysthaps/MystBlinds) (latest release)

  By Myst

  [Download](https://github.com/Mysthaps/MystBlinds/releases) [Discord](https://discord.com/channels/1116389027176787968/1217028577858420806)

- [__Neow Blessings__](https://github.com/kjossul/NeowBlessings) (latest main code)

  By kjossul
  
  [Download](https://github.com/kjossul/NeowBlessings/archive/refs/heads/main.zip) [Discord](https://discord.com/channels/1116389027176787968/1217892947119308933)

- [__Not Just Yet__](https://github.com/Toneblock/balatro-NotJustYet/tree/v0.2.1) (latest release)

  By Toneblock

  [Download](https://github.com/Toneblock/balatro-NotJustYet/releases) [Discord](https://discord.com/channels/1116389027176787968/1254814398476713994)

- [__Ortalab__](https://github.com/GauntletGames-2086/Ortalab-DEMO/tree/test) (latest test branch code)

  By ItsFlowwey

  [Download](https://github.com/GauntletGames-2086/Ortalab-DEMO/archive/refs/heads/test.zip) [Discord](https://discord.com/channels/1116389027176787968/1217704157574860810)

- [__RO-Balatro__](https://github.com/AlexZGreat/Ro-Balatro) (latest release)

  By AlexZGreat

  [Download](https://github.com/AlexZGreat/Ro-Balatro/releases) [Discord](https://discord.com/channels/1116389027176787968/1247049217621360640)

- [__SDM_0's Stuff__](https://github.com/SDM0/Balatro-Mods/tree/smods_1.0.0) (latest branch code)

  By SDM_0

  [Download](https://github.com/SDM0/Balatro-Mods/archive/refs/heads/smods_1.0.0.zip) [Discord](https://discord.com/channels/1116389027176787968/1228825966940393483)

- [__Stickers Always Shown__](https://github.com/SirMaiquis/Balatro-Stickers-Always-Shown) (latest release)

  By Sir Maiquis

  [Download](https://github.com/SirMaiquis/Balatro-Stickers-Always-Shown/releases) [Discord](https://discord.com/channels/1116389027176787968/1234224985032097792)

  - Needs tweak for compat with SMODS 1.0.0
  - Change `local center = GetCenterKeyByJokerName(card.ability.name)` instance into `local center = card.config.center`

- [__Stupidity The Mod__](https://github.com/Aigengoku/Stupidity-the-mod) (latest release)

  By Aigengoku

  [Download](https://github.com/Aigengoku/Stupidity-the-mod/releases) [Discord](https://discord.com/channels/1116389027176787968/1248387108029202432)

- [__Tags Preview__](https://github.com/JKd3vLD/BalatroTagPreview) (latest release)

  By JK

  [Download](https://github.com/JKd3vLD/BalatroTagPreview/releases) [Discord](https://discord.com/channels/1116389027176787968/1233428772364095649)

- [__Taikomochi__](https://github.com/Amvoled/Taikomochi) (latest main code)

  By Amavoleda

  [Download](https://github.com/Amvoled/Taikomochi/archive/refs/heads/main.zip) [Discord](https://discord.com/channels/1116389027176787968/1211425207080718416)

- [__Talisman__](https://github.com/MathIsFun0/Talisman) (latest release)

  By Mathisfun

  [Download](https://github.com/MathIsFun0/Talisman/releases) [Discord](https://discord.com/channels/1116389027176787968/1241172556849876993)

- [__The World Ends With Jimbo__](https://github.com/parchmentEngineer/The-World-Ends-With-Jimbo) (latest release)

  By Parchment

  [Download](https://github.com/parchmentEngineer/The-World-Ends-With-Jimbo/releases) [Discord](https://discord.com/channels/1116389027176787968/1252312295296733194)

- [__Trance__](https://github.com/MathIsFun0/Trance/tree/v1.0.0) (latest release)

  By Mathisfun

  [Download](https://github.com/MathIsFun0/Trance/releases) [Discord](https://discord.com/channels/1116389027176787968/1248865517112918016)
