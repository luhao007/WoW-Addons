# Deadly Boss Mods Core

## [9.0.3](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/9.0.3) (2020-11-01)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/9.0.2...9.0.3) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- Fixes  
- reintroduce 8.x compat code, this is to make sure DBM-Core doesn't error to death on classic before getting a chance to tell classic users that they installed wrong version of DBM.  
- Added blizzards tutorial spec IDs used by all new characters going through exiles reach. Fixes issues with mod loading and throwing lua errors if a character manages to queue a dungeon (such as headless horseman) before actually completing tutorial  
- Updates for 16th aniversery events:  
     - Merged DBM-Azeroth into Event mods and blocked the old module from loading going forward as it's been deprecated. These bosses on retail were always event only bosses and always did belong in event mods, yet were written as stand alones to ease the porting to classic one day. Future planning which paid off quite well, but that time has passed and now on retail the mods moved to where they belong.  
     - Added a Doomwalker module which will sitll need updates once the boss is pulled in EU. This gets ball rolling though  
- Updated council of blood mechanics..................again  
- Forgot to unregister the now unused event.  
- Completely remove support for timertracker object from DBM. When it's no longer a DBM feature, DBM might eventually stop getting blamed when it breaks from uses not caused by DBM.  
- Fix a missed replacement  
- Full drycode of Valinor, the most dangerous of the 4 shadowlands world bosses. Although despite my best effort, I know in my gut this boss is going to be a nightmare for griefing and high pop servers that'll result in nerfs the first time it's up. Blizzard didn't learn from oondasta apparently.  
- Just another weekly update to Council, since blizzard is still in alpha stages of this fight apparently.  
- Prep Shadowlands world boss module  
- two initial timer adjustments on jaina with new min times  
