# AllTheThings

## [4.0.6](https://github.com/DFortun81/AllTheThings/tree/4.0.6) (2024-08-18)
[Full Changelog](https://github.com/DFortun81/AllTheThings/compare/4.0.5...4.0.6) [Previous Releases](https://github.com/DFortun81/AllTheThings/releases)

- Wait you weren't fishing in NSTV this whole time?  
- Thundercall is obtainable only from Quantum nowadays.  
- Made FILTERFUNC\_questID and used that for special HQTs. Probably going to use that for all NYI quests soon.  
- More stuff is now Sourceless instead of NYI.  
- Uncommented since this isn't getting in the way anymore  
- Warlock conjured item  
- Lets add commas! VSC wasn't happy  
- Dedupe gear conversions as reasonable  
- Fix wonky header before fixing data  
- Retail: Tooltips no longer include Object data which is marked as not in the game  
- Couple unused locals now that things are changed/moved  
- Hotfix for parser errors  
- added gear update for mop remix conversion  
- Merge pull request #1736 from Exodius/Exodius-gorgrond2  
    Zone: Gorgrond - Found a better way to mark the cave entrances.  
- Fix typos  
- Classic: Now uses Classic Item Filter Overrides to manually assign filters to specific Items instead of putting them randomly in data files  
- More NYI / Unsorted work.  
- Parser: Fixed an issue where Items with bonuses would generate their modItemID versions in Unsorted  
- Wrong modID.  
- Put raid vendors of DF Season 2 and 3 into the raids with #if AFTER the season. The item required for these items can be obtained only from the final boss of the raid when the season ends.  
- Fix wrong ID on Grunt's Plate Belt  
- Some NYI cleaning, mostly DOTI and Remix items.  
- Moved some HAT that no longer load ingame  
- NYI object is getting in the way, ugh  
- Zone: Gorgrond - Found a better way to mark the cave entrances.  
    Entrance will show up on the map when you ALT+Right Click on the entry.  
- Crafted Items/WotLK: Bladed Pickaxe and Hammer Pick descriptions  
- Mistook starting zone quest for heritage quest, derp  
- Cranegnasher now has correct id  
- Dream Wardens fell asleep and no longer offer any Dragon Isles Supplies quests.  
- Parsed again because something is wonky  
- Sagefish school fix for Ere  
- Valdrakken Accord Renown Supplies quests are gone.  
- PB/Quests: Algalon the Observer  
- Iskaara Tuskarrs cooked all your alts, therefore no need for Supplies quests anymore!  
- Say goodbye to Maruuk Centaur alt quests.  
- Removed nearly all Dragon Isles Supplies quests with 11.0.0.  
    Moved Dragonscale Expedition NYI Flag quests to NYI file.  
- Minor formatting fix  
- Remove School of Tastyfish from retail  
- Dark Iron Mole Machines now have their own header in minilists  
    'Garrison Campaign' converted to custom header  
- Nested Edge of Reality under Rares so it looks better in minilist  
- Updated my test method to scan all Warband-wide quests so that I don't get d/c instantly  
- Full questID scan through 86000 of all current Account-Wide quests from Blizzard  
- Added a few Warband-wide questIDs used by character unlocks (there are way more I'm sure but I'm slacker on collecting them)  
- Delves icon updated  
- Applied proper lockCriteria instead of altQuests to various BFA Warfront quests which become unavailable once Warfronts are unlocked on the Account  
- Merge pull request #1732 from Exodius/Exodius-gorgrond  
    Zone: Gorgrond - Update Descriptions for easier access to some treasures  
- Zone: Gorgrond - Update Descriptions for easier access to some treasures  
- Legion Gemcutter Module Items ignore their bonuses  
- Parser: Fixed an issue where Items that ignore their bonuses (modID/bonusID) would not properly be considered Sourced based on the modItemID using an automatically-applied modID (from being in an Instance) and thus generate a copy of themselves in Unsorted  
