# AllTheThings

## [4.7.2](https://github.com/ATTWoWAddon/AllTheThings/tree/4.7.2) (2025-10-15)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.7.1...4.7.2) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- Legion: Source a few Quest Items  
    - Remix: Infinite Bazaar should now show on mini list  
- Update Mount/PetToyDB for 12.0.0.63854  
- Update Mount/PetToyDB for 12.0.0.63728, 63854 pending wowhead intake, add Remix Shaman quest  
- [DB] Adjusted some Assault on Dark Portal items/HQTs based on linked data  
    [Parser] Fixed all coords being yeeted  
    [Parser] Revised a bit more how data is linked to quests  
- [Parser] Removed debug logging from structure replacements (it became way to spammy and pointless with the way it's multi-threaded now against multiple categories files)  
    [Parser] Removed debug warning about duplicate Coords during merge  
- MOP: Updated Sarkan's guids.  
- Added one more mail Remix Emerald Nightmare item (should be Nighthold though).  
- [Parser] Various fixes/improvements based on some ensemble/questID research  
    * Removed warning about ensemble missing SpellID (this no longer directly dictates whether an ensemble is actually populated)  
    * Adjusted logic concerning assignment of a questID provider and whether that questID can be assigned into the provider data if not already Sourced  
    * SpellEffect of an Item which triggers a TransmogSet will now be assigned as the SpellID of that Item if not existing  
    * Some fixes and additional type mappings for quest assignments from potential provider data  
    * No longer adjusting providers of HQT and other 'irregular' Quest types (was weird seeing HQTs with Quest Items...)  
- Fix some last minute errors  
- Incorporate lower difficulty ensembles into Mythic Remix ensembles  
- [Parser] 'extraTransmogSetItems' are now turned into nested Item Ensembles instead of Spell Ensembles (that way the ItemIDs are Sourced)  
- Remove duplicate Haywire Servobot entry from PetDB  
- [Parser] Fixed modID assignment to Ensemble Sources based on Wago data  
- Add new 12 Month Sub mount  
- [DB] Naxxramas: Typo  
- moved dalaran zonerewards to infinite bazar quest rewards  
- [DB] Prep Infinite Bazaar for nested Ensembles  
- [Parser] Now supports the 'extraTransmogSetItems' which includes additional Ensemble Items inside another Ensemble (for situations where Blizzard makes multiple Ensembles, then removes some of them and makes the removed ones trigger from the remaining one)  
- Fix some reported errors, move Remix Dalarn within the Broken Isles  
- Update The Laboratory of Mardivas.lua (#2177)  
    Zoomera need:  
    Lesser Benthic Arcanocrystal : Strange Oceanic Sediment  
    Greater Lithic Arcanocrystal : Strange Mineralized Water  
    and not inverse  
- [DB] Mists - Alchemy: fix Venerable Potion of Invisibility (original fixer never added the recipe lol)  
- [DB] Fix a stoopid  
- [DB] Mists - PvP: fix Malevolent Gladiator's Slasher and Hateful Gladiator's Staff  
- [Parser] Reparsed for Git  
- [PAT] Updated source file format based on current standards.  
- [Parser] Added Criteria Type 185 (Learn Toy) as an Item Provider  
- [DB] MFO - Added Renown 11 quest  
- [DB] Northern Barrens: Deckhand's Shirt clarification  
- [DB] Cleaned up 'Get Hek'd' to not have Item's linked on Criteria which trigger from QuestID  
- [Parser] Fixed an incorporation issue for Criteria where a spell would be directly assigned as a provider instead of added to \_spells (this allows for using a matching Item instead of Spell as provider)  
    [Parser] ItemID merges now accept 'spellID'  
    [DB] Fixed an unnecessary provider on 'Desert Rose' achievement  
- [Parser] Reparsed for Git  
- [DB] Cleaned up some PoA acheivements due to improved Criteria handling  
- [DB] Cleaned up some Garrison achievements to current standards  
- [Parser] Refactored more handling of Criteria cloning due to when in the Parse sequence it now takes place  
    [Parser] Remove 'spell' providers if a 'npc' or 'item' provider also exists  
- [DB] Crafted Items: Properly sourcing pre-MoP retail glyphs + misc  
- [Parser] Fix bad comma in Maps constants  
- [Parser] Incorporate\_DataCloning is now performed in parallel following the Incorporation stage  
    * This fixes various data inaccuracies caused by previously running the logic prior to fully-incorporating data leading to cases where Criteria might persist an NPC provider while also getting Sourced under that NPC  
- [Parser] PostProcess merge logic is now concurrent-safe and will be merged into Data using a consistent sort  
- [DB] Mists - Celestial: somehow never added Scholomance to the Celestial map list oops  
- [Parser] Added special key value combination for Criteria object type (combines CriteriaID/AchievementID to ensure a unique key for internal comparisons)  
- [Parser] Added a shift extension to help with simple combining of multiple ID values to determine unique ID of a given Data  
- [Parser] Added new Concurrent types to handle additional scenarios  
    * ConcurrentDataList - designed to support a sortable set of Data objects  
    * ConcurrentHashSet - designed to support typical HashSet implementation in a concurrent-safe context  
- Alpha: build 63728 updates  
    - added backlogged stuff from previous build Aratora quest chain and first part of Valeera quests  
    - added dungeon npcIDs for bosses in Zul'Aman  
    - Zul'Aman - main story quest chain  
    - Zul'Aman - rares (all of them missing kill questIDs)  
    - Zul'Aman - Flight Paths.  
- [Parser] Added extensions of TryGetValue for Coords and Cost to simplify their use  
    [Parser] Fixed 'single Object provider' warning when the Coords field has no actual data  
    [Parser] Reparsed with latest Parser  
- [Parser] Implemented use of the 'Coords' field type  
    * 'coord'/'coords' now merge using Coords logic into a Coords type object on the data  
    * coords validation now performed via Coords as an IProcessedField  
    * coords export now performed as an IExportableField and includes sorting to ensure consistent export  
    * Raw handling on 'coords' field converted to use Coords type  
    [Parser] Simplified a bit of Cost merging  
- [DB] Fixed a bad MapID using a header constant  
- [Logic] Comment a debug print  
- Legion Remix: Minor Bronze Caches can be bought from Pythagorus after obtaining the Cosmetic item(s)  
- [Logic] Safely call tooltip:GetName() in case this is a situation where this can cause an access violation for the Client (I can't repro this with the same steps reported, so it's just a guess)  
- Update Azsuna.lua  
- [DB] Push all DB parses with newlines  
- [Parser] Now defaulting to use newlines in [Git] pushes of Categories files (automated builds for Releases will continue to be compressed) [This should provide better diff insight of unexpected changes in Categories]  
- Adjust Parser workflow to parse all versions and determine full success/failure as a final step prior to Artifact upload (#2175)  
    * [Workflow] Test Parser workflow adjustments & forced error conditions for each Parse version  
    * [Workflow] Fix echo command  
    * [Workflow] Adjust final Parser check to look for failure  
    * [Workflow] Trigger the workflow if the workflow itself is changed  
    * [Workflow] Fixed final version check for powershell  
    * [Workflow] Revert error globals to check full success  
    * [Workflow] Wording adjusted  
- [Misc] Typos/debug comments/unused table reference  
- [Logic] Retail: Anything with a 'lockCriteria' will now show with the Breadcrumb color to help denote the nature of it possibly getting locked out  
- [Logic] Fixed CharacterUnlocks with a QuestID cache mechanism using AccountWide Quests instead of AccountWide CharacterUnlocks to determine AccountWide collection  
- [DB] Lots of small data fixes and structure revisions noticed during Parser debugging efforts  
- [Parser] Fixed an issue with simplify structures logic  
- [Parser] Rebuilt Parser with latest changes  
- [Parser] Concurrency & cleanup revision (#2173)  
    * [Parser] Added Validator function to validate a specific field value in regards to a reference data  
    * [Parser] Added a Handler type to perform a sequence of Condition-based Actions against Data structures upon completion of a given ParseStage  
    * [Parser] Added ItemID and CurrencyID validation for values in 'cost' fields  
    [Parser] Added WARN log when a 'cost' currency is not Sourced (due to how ATT determines and propogates Cost, there needs to be a Sourced data for each Item/Currency which is used as a Cost, or it will not properly be updated)  
    * [Parser] Added config setting 'UseExportNewlines' to let export of compressed categories use newlines between objects (should only be adjusted for debugging purposes)  
    * [Parser] Properly track Sourced 'currencyID' groups  
    * [Parser] Directly ignore 'g' and '\_\_parent' fields in MiniJSON-serialization of Dictionary types  
    [Parser] Removed Dictionary serialization override to prevent stack overflows from certain keys  
    * [Parser] Include Count when logging Orphaned Breadcrumb list  
    * [Parser] QuestDB merging now utilizes the standard DB merge logic  
    * Removed QUESTS container  
    * Removed AllQuests container  
    * No longer merging DB quest data into objects during Validation step  
    * Quest DB now respects the MERGE\_OBJECT\_FIELDS allowed fields for merging into Objects  
    * [Parser] Omit '\_\_parent' field from ItemDB merging  
    * [Parser] Omit '\_\_parent' field from general Object merging  
    * [Parser] Fixed SOURCED lookups failing to find existing Sourced data when using id values with a non-long Type  
    * [Parser] Object merging now handles Concurrency  
    [Parser] Shared object merging into objects now respects MERGE\_OBJECT\_FIELDS (since DB merges add all DB fields prior to MERGE\_OBJECT\_FIELDS existence, it needs to verify on merge-into step)  
    [Parser] Shared object merging now uses proper Merge function instead of direct assignment (a bit slower, but also safer and accurate to our data handling expectations when we merge single values into an array field from different places)  
    * [Parser] Exporting Category data is now sequential when Debugging (remains in parallel when run parser normally)  
    * [Parser] More concurrency updates for existing storage  
    * [Parser] Implementation and refactor of various parsing steps to utilize Handlers instead  
    * CurrentParseStageHandler now updated to the Handler for the CurrentParseStage  
    * Renamed some methods to better reflect their use and purpose in the parsing sequence  
    * Added implementation for utilizing Handlers within the parsing sequence  
    * Migrated many pieces of functionality and processing into Handler Actions for parallel processing  
    * Added a couple lines of logging output to capture Handler-based Actions processing  
    * Removed ParseStages: PostProcessing, Cleanup (no longer required due to Handler use)  
    * Added tracking of '\_\_parent' data for each data by default  
    * Track usage logic is now processed in parallel  
    * [Parser] Remove 'nextQuests' from non-breadcrumbs  
    * [Parser] Allow 'OnTooltip' DB merging for Items  
    * [Parser] Block DB merging for Objectives and Criteria (prevents cross-contamination due to shared key fields with their parent groups)  
    * [Parser] Source data after Validation phase so that Validation Handlers can accurately determine Sourced content at that stage  
    * [Parser] Use proper Merge function for merging DB data into DB store (this ensures proper field naming and formatting in DB stores)  
    * [Parser] Added more Merge fields for questID  
    * [Parser] Retail: Revised how objective data is migrated to the parent quest utilizing [crs/qis/providers/g] to properly associate the data based on various conditions  
    * [Parser] Prevent Criteria merging under other Things from forcing those Things obtainable via the \_u assignment from timeline checks  
    * [Parser] Non-Sourced 'cost-currency' switched to a debug warning for now until they are fixed  
    * [Parser] Merged 'g' content now re-applies the inherited fields logic to the merged content to ensure the timeline of the merged data is inherited if not otherwise defined  
    * [Parser] Prevent 'g' from merging into DB from Objects even when allowed in MERGE\_OBJECT\_FIELDS for DB to Object merging  
    * [Parser] Adjusted when data is added to Handlers due to stage-based removal of data needing to skip handling (initial implementation required handling of removed data, but this has changed and is no longer necessary)  
    * [Parser] Fix merge from DB replacing existing non-array fields with a different value (array-based fields will still merge incoming DB data)  
    * [Parser] Fixed the Validate\_headerID method name & location  
    * [Parser] Comments & unnecessary code  
    * [Parser] Handlers are now safe to use in a concurrent context  
    * [Parser] Handlers storage is now safe for Concurrent use  
    * [Contributor] Add a space in PlayerLocation of reports for the 'Diff' value  
    * [Parser] Cloned data is now checked if it will directly go into a Sourced data and thereby skips some residual checking if so  
    * [Parser] AssignFilterID now performed in one confined Action  
    * [Parser] Merge logic slightly improved by only initially attempting fields which are actually assigned in MERGE\_OBJECT\_FIELDS  
    * [Parser] Migrated a few missing Item merge fields to MERGE\_OBJECT\_FIELDS to ensure proper Filter assignment afterward (eventually all merge handling will be consistent via this mechanism instead of partially hard-coded for Items specifically making everything complicated)  
    * [Parser] Retail: Adjusted handling of Objective Provider Items so we don't currently end up with Quest Items as Providers outside of the Quest being active  
    * [Parser] Include 'ignoreBonus' as an itemID merged field  
    [Parser] Moved handling of 'ignoreBonus' to Consolidate step since it relies on DB merge for accuracy  
    [Parser] Fixed FilterID assignment in Ensemble-Sourced Items  
    * [Parser] Fixed merging conditional item data for ensemble contents  
    * [Parser] Retail: Quest Objective NPCs become Sourced under their Quest will no longer act as a Source for other data cloning  
    * [Parser] Temporarily removed Encounters being treated as Sources for their corresponding 'crs' due to overzealous merging without respect to difficulty in some cases  
    * [Parser] Prioritize recipeID > mountID > spellID Sources for Criteria  
    * Rebuilt parser, just to fix the build action  
    * [Parser] Removed the 'STRUCTURE\_REPLACEMENTS' comment from categories files  
    * [Parser] Include 'minReputation' for Item merges  
- Fix some reported quest and object errors  
- [DB] Mists - Celestial: Gao-Rei, Staff of the Legendary Protector drops off High Inquisitor Whitemane  
- [DB] Mists - Celestial: Jin'ya, Orb of the Waterspeaker drops off Darkmaster Gandling  
- [Locale] Update zhCN/zhTW: Midnight.  
- [DB] Mists - Celestial: Shin'ka, Execution of Dominion drops off Taran Zhu's chest  
- Comment out Invasion Points in InstanceDB.lua  
    They have the same mapID as The Emerald Nightmare raid, because of this EN lockouts display in the Invasion Points header  
    Tracking of Invasion Points should still work through bosses questIDs  
- Remix Trial of Valor items are not in Mote of a Broken Time currently.  
- Unbrick Parser  
- [PAT] Updated source file format based on current standards.  
- Update Contributor.lua  
- Forgot that Remix Emerald Nightmare LFR is in NYI.  
- Added last item for Remix Emerald Nightmare raid.  
- [DB] Vanilla edible mushrooms + drinks  
- [DB] Fixing parser error.  
- Legion: Minor stuff encountered during a play session  
- [DB] Wards of the Dread Citadel headers with guide  
- Sort some remix raid items, fix some tabs  
- [DB] Legion: Half Eaten Candy Bar  
- [DB]: Moving questline ends to The Wandering Isle  
- Fix a few more reported errors  
