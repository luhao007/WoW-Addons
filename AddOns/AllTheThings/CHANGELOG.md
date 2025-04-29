# AllTheThings

## [4.4.2](https://github.com/ATTWoWAddon/AllTheThings/tree/4.4.2) (2025-04-27)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.4.1...4.4.2) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- [Locale] Update zhTW.  
- more aq stuff  
- Deleted the unused EnsembleDB file.  
- Parser: Attempting to include AllowableRace from the ItemSearchName table.  
    Deleted a number of classic only itemDB sources that are no longer needed.  
- more TempleofAQ Sod Stuff  
- "A Taste of Home" is not Evoker-only  
- Parser: Now assigning Relic types.  
- gilded scarab can be put into the sod version  
- added aq20-40raid to SoD based on wowhead infos  
- Parser: Now only allowing the classes that are in ALL\_CLASSES to be included in the classes table within ItemSourceNames.  
- Merge branch 'master' of https://github.com/ATTWoWAddon/AllTheThings  
- Revert "testing aq stuff"  
- [Locale] Update esES. (#1969)  
    * [Locale] Added spanish translations in various headers  
    * Solved Error on spanish locale #1972  
- testing aq stuff  
- Parser: Added AllowableClass from the ItemSearchNames wago data table. Facing is a float.  
- Retail: Apparently also uses the Phases settings file?  
- MISTS: Added Skill Level Requirements for Mists of Pandaria recipes.  
- Parser: Added ItemSearchName from Wago. (eventually I'd like to kill our old itemDB implementations)  
- Parser: Now trimming the english flight path names.  
- Parser: Item now passes along its lvl data to ItemDB from Wago.  
- Parser: Fixed an issue with TaxiNode parsing.  
- Parser: Now utilizing Wago database files for TaxiNodes. (Default Flight Path Names)  
- Simplifed the Update Wago Build files batch files and also added missing ItemEffect files.  
- [DB] Gave HQT 86695 a name (90134 and 90752 are still sus...)  
- [DB] Removed the unused AchievementDB modules. (We use Wago's database files now)  
- Parser: Updated the GlyphDB to use Wago files instead of a processed lua DB module that requires additional work.  
- MISTS: Fixed which encounter logic to use.  
- MISTS: Fixed which tooltip renderer to use.  
- Classic: Fixed a logic bug involving SearchForField not always returning a container as it had previously done so.  
- MISTS: Removed some achievement references from the Loremaster achievement based on expansion.  
- MISTS: Removed invalid achievement criteria from outdoor zones.  
- Parser: Removed sourceID assignments from Rings and Necklaces.  
- Phases should NOT be the default settings page.  
- MISTS: Added Mists of Pandaria database for testing on the MOP Classic Beta.  
    [DB] Rebuilt all databases.  
- Cata: Swoopy is a Flying type.  
- Classic: Added placeholder timeline data for Brawler's Guild.  
- Classic: Now including Wago files for Item, ModifierTree, SpellEffect, TransmogSet (if applicable)  
- Added a missing timeline value to some Children's Week pets. (Someone needs to fix this section)  
- Classic: Now using ItemModifiedAppearance from Wago Tools instead of using harvested sourceIDs.  
- [DB] More account wide quests I noticed  
- Removed duplicated regex and cleanup batch files.  
- took me 10minutes to find this error lol  
- added all alch sod p6 recipes  
    sourced all the common goods that all the recipes I added require  
- Deleted the unused ItemAppearance wago data. (This is just for visual appearance, not for anything useful.)  
- finished mining, 4 tailoring items  
- Moved all WAGO files out of Parser/DATAS/00 - DB/Wago to the new .wago folder. Included Wago data for all expansions that already have Wago data modules available. Retail config now points to The War Within's Wago folder.  
- final missing )  
- parsing, missing something somewhere  
- added all p6 sod engineering recipes  
- added all enchanting recipes from build xx 15.5.57537  
- MISTS: Updated Phase assignments for Dungeons and Outdoor Zones.  
    Classic: Moved phase activatations to their own expansion specific pages.  
- added all p6 enchanting aq items  
- added 7 tailoring items  
- more sod tailoring patterns  
- razorbramble items added  
    i have to do small commits or they conflict with crieve  
- parsing  
    correct some 1.15.6 to 1.15.5  
    added LW armor kits sod  
- MISTS: Changed all references to MOP\_PHASE\_ONE to MOP\_PHASE\_LANDFALL.  
- added phase 6 sod recipes that drop in aq  
    alch&bs recipes can now be tracked and have their crafted items sourced  
- Moved a number of mapID constants into variables.  
- MISTS: Updated mapIDs.  
- Fixed a logic error for instances that exist but don't have a dungeon journal entry yet. (MOP Classic)  
- Fixed some logic errors for MOP Classic. (MOP uses Retail functions)  
- Update some Nightfall rares and quests  
- Re-add Cartels of Undermine faction, fix some reported errors  
- updated mdi toy  
    toy is no longer available  
    MDI is also now always the great push format. updated the description to reflect that  
- removed another layer, so its only 7 layers deep and not 9  
    added achievementsheader  
- removed 1 layering of gobo rep  
- parse  
- nvm defender had both quests, stipend is reso crystals  
- renown 10 quests  
- missed some weapons in sym(idk how)  
- [Parser] Retail: Adjusted objective conversion logic to happen later, and only perform on item/object/npc which are not already Sourced  
- Update \_\_auto-sources.lua  
- Add Flame's Radiance renown 5 quest  
- drop mark of honor from 1 quest  
- better note  
- found 2 pets for the childreen week update  
- added new source ids  
- [Logic] Retail: Most Dynamic groups expand a bit more reliably when generated (Professions and Currency still refuse to behave)  
- cloak share isnt a thing  
- added description for multi unlock of the arathi crusader set. But does any1 see them? probably not  
- arathi weapons cant be bought  
    boss gives 42%  
- Trial of Style Icon update  
- [Logic] Retail: Root Dynamic category now marked as source ignored  
- [Logic] Dynamic runner now does 1 dynamic group per frame instead of 5  
- [Logic] Retail: Lots of small performance improvements for Search logic & fixed one huge oversight causing every search to perform a full scan instead of a cached-search  
