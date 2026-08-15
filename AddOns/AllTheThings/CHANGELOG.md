# AllTheThings

## [5.3.1](https://github.com/ATTWoWAddon/AllTheThings/tree/5.3.1) (2026-08-13)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/5.3.0a...5.3.1) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- parse  
- [DB] Pepe object name  
- [Logic] Migrated Upgrade Module to 12.1 BonusID values  
- Housing: PEPE DECOR!  
- Housing: Cursed Keepsake, new items and a description update  
- Housing: Vaeli's quests offer Packs of Mistcrests now  
- The Coiled Isle: 12.1.0 Campaign Breadcrumb  
- [Wago] Midnight wago update now passes the build version to the localization wago update script so they stay in sync  
    [Wago] Removed ItemSparse  
    [Wago] Fixed CSV cleanup on ItemBonus and SpellEffect  
- Bump wago files to 12.1.0.69283  
- [TOC] Update for 12.1.5 ptr.  
- [Parser] Added debug warn for multiple coords being within 0.1 distance  
    [Parser] Adjusted \_spellQuests handling slightly so that directly-assigned questID won't be counted as a multiple assign between objects and prevent questID assignment  
    [DB] Fix Delver's Cosmetic Surprise Bag questID  
    [DB] Removed dupe NYI questID  
- [Parser] Added config for InRetailSeason  
- Timeline and constant fixes.  
- seasonal pvp and seasonal pve rewards now show up correctly  
- Added new hand-in quests to the Hidden Quest Triggers for Amani items  
- Updated the structure of Draconic For Dummies.  
- [DB] Ignore customCollect getting hooked onto some common SL currencies  
- [DB] Ran into some Drustvar treasures  
- [DB] Added some accurate coords for some Exploration I had to go find  
- [Misc] Locale & Instances parse  
- [Logic] Moved Dynamic Categories injection to a separate file for clarity  
    [Logic] Added a 'Current Season' Dynamic group under Dungeons & Raids which pulls in all Dungeon content available in Midnight Season 2  
    [DB] Designed handling for assigning dungeons/difficulties to be considered part of the current Retail season  
    [DB] Applied current season to the MID:S2 dungeons where applicable  
- [DB] Reduce some duplicated Criteria in Prey  
    [DB] Fixed UpgradeMapping for World difficulty of Tidebound Grotto  
- [Logic] Fixed AddEventRegistration breaking after OnReady event fires  
    [Logic] Fixed /att realtime-exploration-check trying to duplicate events  
