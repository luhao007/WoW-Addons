# AllTheThings

## [5.0.14](https://github.com/ATTWoWAddon/AllTheThings/tree/5.0.14) (2026-03-01)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/5.0.13...5.0.14) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- Fixed some expansion cooking awards  
- Timeline out Trading Post  
- All references to Console.Write and Console.WriteLine now use their Trace equivalents now so that the log file generated matches the output experienced by the user.  
- Added new Trolli Gummi promo pet  
- Moved delve gear out of bountiful header, since it can drop without keys.  
- Added 'Paladin Rescue' questchain.  
- Copy pasting is really hard to not forget.  
- Added all First Crafts for non-gathering professions in Midnight as HQTs for now. See more info in the commit's lua comment in each profession section.  
- Objects / Parsed  
- [DB] Adjust coords and source quest for 'Vexatious Vilebranch'  
- [DB] Fix some strange repeatable fields on Things  
- More objects localized  
    177 to go  
- Delve trinket?  
- Eversong Woods: Two more Sojourner Quest Chains  
    - Fix descriptions for Broken Isles hidden demons not to appear twice on certain NPCs  
- [DB] Various Broken Isles content continue to reset daily (maybe bug maybe permanent? Who knows!)  
- [DB] Argus Greater Invasions are weekly  
- [DB] 'Torch Tossing' (and prior version) appear to have become yearly based on resetting quests  
- [DB] Quest 'Uncommon Scents' becomes unflagged due to being considered 'yearly' even after no longer being available post-10.2.5  
- [DB] Shan'ze Ritual Stone loot is daily  
- Eversong Woods: Two more Sojourner Quest Chains  
- Clear some more reported errors, mostly Haranar (still a mess)  
- Fix yet more reported errors, grab some object names, parse  
- Added missing flightpath map.  
- Update Quests.lua  
    Correct coords  
- Update Quests.lua  
- Moar stuffs  
- [Logic] Fix various Auction window handling  
- [Logic] Fixed using global for 'otherQuestData' field cache logic  
- [Logic] Fillers can now be defaulted false per Scope  
    [Logic] Reagent/NPC Fillers now defaulted OFF for Minilist only  
- Fix some more reported errors  
- Eversong Woods: Sort a few more Sojourner quest chains  
    - Misc stuff in Murder Row Dungeon  
- Update Rares.lua  
    Rare's are daily  
- Pre-patch event is still available  
- Moved some general delve achievements still available in Midnight  
- Bump actions/download-artifact from 7 to 8 (#2326)  
    Bumps [actions/download-artifact](https://github.com/actions/download-artifact) from 7 to 8.  
    - [Release notes](https://github.com/actions/download-artifact/releases)  
    - [Commits](https://github.com/actions/download-artifact/compare/v7...v8)  
    ---  
    updated-dependencies:  
    - dependency-name: actions/download-artifact  
      dependency-version: '8'  
      dependency-type: direct:production  
      update-type: version-update:semver-major  
    ...  
    Signed-off-by: dependabot[bot] <support@github.com>  
    Co-authored-by: dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>  
- Bump actions/upload-artifact from 6 to 7 (#2325)  
    Bumps [actions/upload-artifact](https://github.com/actions/upload-artifact) from 6 to 7.  
    - [Release notes](https://github.com/actions/upload-artifact/releases)  
    - [Commits](https://github.com/actions/upload-artifact/compare/v6...v7)  
    ---  
    updated-dependencies:  
    - dependency-name: actions/upload-artifact  
      dependency-version: '7'  
      dependency-type: direct:production  
      update-type: version-update:semver-major  
    ...  
    Signed-off-by: dependabot[bot] <support@github.com>  
    Co-authored-by: dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>  
- Added placeholder timelines for future announced patches  
- Renamed launch timelines  
- [Logic] Cleaned up account-wide Quests cache is now moved to PriorQuests just in case it needs to be referenced later (for quests completed on deleted characters or something while in account mode, though that technically isn't a supported means of persistent collecting)  
- [Logic] OneTimeFixes can now be added for all game versions & added a Quest cache cleanup for storage with the value of 1 [this now denotes a specific scope of collection at the account scope rather than just being collected by a character]  
- Fix many reported errors, mostly in Eversong  
- Revert "Adjusted Account Wide syncing logic."  
- Quick fix a few reported errors  
- Added some tailoring first crafts / template - Parsed  
- Update Wago Files  
- Adjusted Account Wide syncing logic.  
- Update Quests.lua  
- Merge branch 'master' of https://github.com/ATTWoWAddon/AllTheThings  
- [DB] Revert Cracked Keystone  
- Update Quests.lua  
- [Parser] Warn log for bad OnInit function definitions  
    [Parser] 'DontEnforceSkillRequirements' is now a pass-thru field  
    [DB] Lockpicking doesn't need OnInit to assign a field to itself  
- [Logic] Regular Quests now ignore the regular collection fanfare/screenshot, if enabled in settings [Note: Future settings revamp may include further customization of how collection handling can be done per Type now that Retail/Classic are identical and almost all Types use the standard collection logic]  
- Update Contributor.lua  
- More objects  
- Eversong Woods: Initial verification of Sojourner quests  
    - The rest are locked behind Campaign Progression  
- Add Coords - Traces of Fel  
- Quest collection refactor (#2323)  
    * [Logic] NPC/Item/Objects which use Quest-based collection now work consistently with the typical Collection logic  
    [Logic] Batch Quest refresh no longer sends all currently completed quests to the cache and instead only caches the difference from current character Quest cache  
    [Logic] Initial Quest refresh now uses the character's cached Quests as a starting point to allow detection of 'useful' unflagged quests when loading  
    * This detection is added as a Contributor report for scenarios where Quests unflag since the character's last session which ATT has not marked as 'repeatable' in some way  
    [Logic] Added a PriorQuests cache which is populated with quests that the character had completed at one point, but are no longer marked as completed from Blizzard  
    [Logic] 'Completed By' in tooltip now additionally checks PriorQuests for completion information  
    [Logic] Various classes which duplicate quest-based functionality now import it directly from the Quest-defined logic  
    * [DB] Quest 62786 for ToP challenge is daily  
    * [Logic] Use the typical collected logic for Quests [this allows proper OnThingCollected events from collection processing]  
    * [Logic] Use Quest imports for ItemAsHQT  
    * [Logic] Add a small delay to Inaccurate Unflagged Quests so it doesn't get lost in login chat spam if any  
    * [DB] Cracked Keystone TWW:S2 isn't really a collectible since it unflagged  
- Fix yet more reported errors  
- Fix some more reported errors, mostly Zul'Aman  
- Fix a few reported errors, clear Quel'Danas errors  
- Midnight: Finally sourced the missing treasure chest in the Intro Scenario  
    - Fix 'Holy Pet Leash' Toy's Unsorted state by stashing a Beta quest into NYI  
- Added missing reward to 'Smuggler Showdown'  
- Classic Era: Fixed the mini list for Stormwind Stockade.  
- Midnight: Add a lot of reported missing quest rewards  
- Fix 'Girdle of Herbicide' itemid  
- How to Train Your Protege quest rewards  
- Nethersteel Deflectors dropped from Tarhu the Ransacker  
- [Logic] Use next in some Table functions  
    [UI] Don't highlight the top row of popouts, it's not helpful  
- Added missing objective data for Eight-Legged Menaces.  
- Fixed recursive provider for "Armed and Ready".  
