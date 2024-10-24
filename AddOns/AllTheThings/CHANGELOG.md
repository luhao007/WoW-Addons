# AllTheThings

## [4.1.0](https://github.com/DFortun81/AllTheThings/tree/4.1.0) (2024-10-23)
[Full Changelog](https://github.com/DFortun81/AllTheThings/compare/4.0.19...4.1.0) [Previous Releases](https://github.com/DFortun81/AllTheThings/releases)

- parse to the wow  
- Bronze Celebration Tokens open world hqts  
- Some NP Account-wide HQTs  
    Some Anniversary HQT's and organization  
- Parser: Switched a couple debug warn messages to debug info  
- Bronze Celebration Token HQT from H Queen  
- Fix some quick anniversary errors  
- Bumped Item/Quest IDs for BNet API harvest (started for 11.0.5)  
- Updated WoW Anniversary event schedule  
- Adjusted some 20th anniversary stuff  
- Retail: Fixed Warchief's Command Board and Hero's Call Board quests from being double populated in various Main city minilists  
- Removed Ravasaur Trainers link to unimplemented Faction  
- Retail: Migrated some deprecated Blizzard API functions  
    Retail: Fixed /attwq due to 11.0.5 Blizzard API change  
- Added a chat error for when a missing Faction is found during refreshes instead of causing a Lua error  
- Update toc, add new mole machines, fix misc errors  
- Update retail parser config for 11.0.5.57171  
- Parser: Fixed a couple extra warnings that started showing up  
- Update what is and isn't available from Hearthstone's 10th Anniversary, fix some retail errors, set 11.0.5 timeline  
- Cata: Fixed Loremaster of Cataclysm (H)  
- Fresh Wago files  
- AchievementDB harvest and parse  
- Source harvest  
- Extrapolated crs for encounters from achievement data, as their absence led to parser errors. Change it if it is wrong, parsing would halt without. But hopefully the guess is right!  
- Parser: Achievement Criteria specifically requiring the SpellID of a Mount are now properly linked with provider of the Mount's ItemID  
- changed mop remix rewards to zone rewards to be the same layout as the other zones  
- delves now uses delve\_completion instead of rewards as rewards imply multiple sources, which there are none  
- Missed an object.  
- Cata: Fixed the objectives for Taking Precautions.  
- TWW: Confirmed the speculated QuestID and coordinates of the final Aspirant's Tribute  
    WoD: Khadgar's Servant is a MobileNPC  
- Numbers are hard.  
- Added many group finder HQTs from TWW and DF.  
    Sorted group finder HQTs from SL and BFA.  
- Sorted Putrid Goop, got a DM report about it  
- Vicious Flask of Manifested Fury did not make it live.  
- Retail: Fixed tooltip Sources which are not available in game to properly have the correct icon even when using Unobtainable Filters or Debug mode  
- Merge pull request #1817 from Machou/VenthyrTransport  
    Update mirror, now is daily, not weekly  
- by the time the toys are granted, the access to them is already removed  
- q  
- tiny update to pvp toy description in case they create more of them in the future  
- Update mirror, now is daily, not weekly  
- updated rewards header for weekly events & gave the caches a source (weekly events>rewards with nothing attached is as good as keeping them in unsorted)  
