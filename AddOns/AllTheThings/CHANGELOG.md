# AllTheThings

## [4.0.19](https://github.com/DFortun81/AllTheThings/tree/4.0.19) (2024-10-20)
[Full Changelog](https://github.com/DFortun81/AllTheThings/compare/4.0.18...4.0.19) [Previous Releases](https://github.com/DFortun81/AllTheThings/releases)

- I break things down, but not by force,  
    I turn tangled words into a clearer course.  
    A guide through code, I sort and arrange,  
    From jumbled mess to meaning, I change.  
    What am I?  
- Fix some minor errors  
- Retail: coords and spreading the light hqts  
- Cata: Disabled achievement automation on Twenty-Five Tabards.  
- TWW: Update some coordinates in Azj-Kahet  
    Partially revert commit 97c749063ac1137083f09de4d92d187ace3710b0  
    Clean-up comments section of the HQTs  
    Missing quest data/givers referred in the comments are most likely related to Dor'garad and Kaheti Excavations as they are yet to be implemented  
- coord  
- Update Uldum.lua  
    Uldum: Harrison Jones not spawning after cutscenes  
- Fixed location for Candy Bucket — Dustwallow Marsh, Mudsprocket.  
- Found a new Radiant Remnant but didn't get the objectID :weary:  
- Fixed implementation of the 'Stonevault Mechsuit' so it's not listed inside of the Quest Starter Item (bad!)  
- Couple minor adjustments to 'Total Cost' logic and 'Source Quest Requirements' so that a quest chain with multiple Costs will properly show all costs of the quest chain (may adjust more with further testing over time)  
    Fixed Quest Provider Items which get shown in Quest chains from possibly being permanently visible in the Main list  
- Strip Trial of Style ensemble quests  
- DF PvP Ensembles added  
- Confirmed 100% Trial of Style Ensembles (there's way more Items than you thought you got!)  
- Fixed FlightPath Bug  
- Classic TWs  
- [Localization] Update zhTW.  
- TWW: Update a few coordinates in Azj-Kahet  
- Added 'accepted or' text to the tooltip for pre-requisite quests of a Thing since our representation for simply 'accepting' a quest to be available is identical to having to 'complete' a quest  
- Parser: Now supports 'extraTransmogSetSpells' used within an 'iensemble' object to define additional non-Item TransmogSet spells which trigger automatically when learning the base Ensemble  
    Added 'extraTransmogSetSpells' to the 'Ensemble: Heritage of the Draenei' as an example  
    Added new 'EnsembleSpell' Type for Ensemble Spells which derive only from Spells and not Items  
- Cata: Updated objectives for Mauti.  
- Cata: Updated objectives for The Hunter's Revenge.  
- Cata: Updated objectives for Serpents and Poison.  
- Fixed a missing parameter for the Factions class.  
- Cata: Tricks and Treats of Azeroth hasn't been removed yet. Thanks Blizzard.  
- TWW candy bucket quests and placeholder comments for provider / coord to be added once event goes live (everything already came in with 11.0.2 so it's timelined that way, even though the event will start at the same time when 11.0.5 goes live)  
- Sourced remaining anniversary achievements + updated wago files + parsed for retail and ptr  
- Added TypicalCharacterCollected & TypicalAccountCollected to encapsulate the simplest typical cache-checking for collected Things  
    Added use of these 'typical' collected functions where currently-applicable in Classes  
    Now using simple collectible swap for Toys  
- NPC 145707 is Mobile  
- Couple Heritage quest details  
- Clean up some Illusion class stuff and use simple collectible swap  
- Removed Trackable from Titles and added the simple collectible swap  
- Deepholm and Uldum requires the use of flying mounts  
- TWW/Azj-Kahet: Missing quest for one Forgotten Memorial Treasure  
    TWW/Azj-Kahet: Another rumor bites the dust  
- Added missing quest objectives for Hallow's End.  
- TWW/Azj-Kahet: Fix an issue with inaccurate-quest reports related to Rumors  
- Adjusted the repeatable Hallow's End quests to be nested as you need to be on the holiday quest to have them appear. This matches similar quest objective layouts.  
- Retail: FillGroups now only triggers the OnWindowFillComplete event for the filled window if it actually filled the root group of that window (e.g. FIllGroups can be triggered on individual groups in some cases and we don't want that to trigger this event over and over on the hosting window)  
- Fixed Item-based Things which are keyed as another ID as considering themselves 'missing'  
- Fixed some Hallow's End coordinates for Vashj'ir.  
- Deleted unused achievement criteria data in Hallow's End. (we use automation now!)  
- Fix extremely weird Lua error for opening popouts which of course doesn't actually happen to me in the first place  
- List window now supports both missing and collected together. Can be used to find completed missing quests for Sourceless.lua file.  
- Drop redundant ignorebonus fields on iensemble items  
- Cata: Fixed achievement criteria!  
- Worm theory copy sorted  
- Added collected parameter for the list window.  
    Added Tailoring HQT.  
- Parser: Fixed some issues with CSV parsing when a field is left out in earlier versions of DB2.  
- Sourced some HAT and added others to the exlcusion list  
- Parser: Attempting to fix the AchievementDB for Cataclysm.  
- Added Candy Bucket object data.  
- Strip redundant ensemble data, all non-pvp ensembles and arsenals should be converted or TODO noted (unless missed because of naming)  
- Cata: Fixed some phaseID assignments for Engineering recipes that came out with the Molten Front.  
- BaseObjectFields no longer needs to be externally available as all Class creation is now handled by CreateClass  
    Renamed BaseObjectFields to CreateClassMeta to make more sense  
- Retail: Migrated the last Class (Profession) to a standalone file  
- Retail: Quick fix to not sort under popped out Difficulty groups  
- Classic: Added a silly thing for creatureID.  
- Classic: Removed an unused function  
    NPC DisplayID retrieval no longer forces OnRenderDirty  
    Moved the GetDisplayID logic from Model.lua to NPC.lua now that it's being used by Classic  
- Cleaning up any potential reference in non-db code to a singular "cr" field. (crs or creatureID is the standard)  
- Contributor Quest check no longer does extra print when providerID is missing  
    Contributor ignore tables now use proper metatables  
- Fix some reported retail errors  
- Fixed some more scuffed iconIDs.  
- Strip some redundant ensemble data  
- Add Sand Scarab twitch drop  
- Retail: ATT Windows no longer have explicit StartProcessing/StopProcessing functions defined. Instead (the only current use case) has been converted into an Event: OnWindowFillComplete. This Event (currently un-used externally) is triggered for a given Window when the FillGroups process is completed within that Window.  
    Retail: ATT Windows no longer preemptively define some empty group data when created since we always use 'SetData' properly  
    Retail: The 'Source(s)' group in popouts is now considered source-ignored  
- Retail: Recipes filled into popouts don't need to forcibly not merge, and can be created if not Sourced  
- Found a few more replacements for AutoTable  
- Couple string-keys replaced with key references  
- Added a base AutoTable metatable reference since this is commonly used in a few places  
- Couple minor data errors/reports  
- [VS Code] Remove auto-adding of Globals.  
- Meetup with the Caravan clarification  
- Cata: Moves 'Meetup with the Caravan' from Uldum to Deepholm.  
- Removed the console read line that was used for debugging.  
- Add missing quests for Stonevault Mechsuit, fix some reported errors  
- Some protections & extra chat for Contribute quest checks which cannot procede  
- Added object data for Soul Device.  
- VSCcode please just shutup  
- TWW/Azj-Kahet: One more rumor  
    And fix another typo... This is why I don't rush things and triple check my work.  
- Fix typo  
- TWW/Azj-Kahet: Forgotten Memorials (Aspirant's Tributes) are part of the Severed Threads Pact system  
- Southern Barrens:  Breadcrumb 28550 description  
- Strip redundant ensemble data  
- Fate Weaver  
- Added a 'convertItem' shortcut to help with Items which can be converted back and forth via on use  
    BC Motes/Primals are now linked as expected  
    WOTLK Crystallized/Eternals are now linked as expected  
    Retail: Fixed popouts of popout Recipes duplicating their Crafted Item  
- OnRenderDirty should always be a callback event when hooked into spammy triggers  
- Moved The Fallen Guardian from Molten Front to the Elemental Bonds section.  
- Retail: Fixed an issue where popouts of certain crafting reagents would infinitely fill themselves with recursive sets of nested crafted items  
- Classic: Deleted the Music Roll and Selfie Filter unimplemented class declarations.  
- Classic: Now using the Header class file.  
- Header module using CreateClassInstance instead of CreateObject  
- Classic: Now using the NPC class file.  
- Classic: The "Show Colors" checkbox now functions correctly for rows.  
- Even more super sneaky herbs. I don't like these herbs.  
- The Finer Things tracking is account-wide  
- HQT for The Finer Things 1st turn-in  
    Various Weekly/non-Weeklies fixed based on not resetting  
    Doan's Strongbox is account-wide  
- TWW/Azj-Kahet: Rumors  
    LEG/Argus: Added and updated some coordinates  
- Add new sub bundle mounts, fix some reported errors  
- Currency groups now show their quantity/maxQuantity as a statistic in ATT rows  
- Update some 11.0.5 timewalking rewards  
- Fixed a garbled export command.  
- Removed preprocessors that originally ripped out map icons from pre-Wrath builds of the DB.  
- Final (v2?) batch of iconID updates.  
- Fixed a bunch of garbled iconIDs.  
- Fixed a couple of missing iterface icons. (inv\_engineering\_failure-detection-pylon)  
- Looks like it was case sensitive. This fixed that.  
- Added the IconID Converter tool. This tool can replace all of the IconPaths with IconIDs.  
    First pass of the tool without reparsing.  
- Textures don't need to include their file extension.  
- Added a bunch more manually-checked Warband-wide quests  
- Parser: Now forcing all icons to be exported as lowercase.  
- Adjusted Warband-Wide text again because it actually looked weird  
- Completed By for Warband-wide quests is now consistent with the Blizzard text in quest dialogs for previously completely quests  
- Parser: IconFileID values now properly get exported as a numeric value rather than a string.  
- Fixed /attuned. (Classic Only)  
- Deleted the last bit of manually added achievement descriptions that were originally used for pre-wrath achievement tracking.  
- Deleted more achievement descriptions...  
- Deleted a bunch of manually added achievement descriptions. (was used pre-AchievementData DB)  
- Deleted all locally sourced achievement icons. (You don't need to include them if you use fileID!)  
- Now including an AchievementData DB for Classic Era, SOD, TBC, and Wrath Classic. This new module is fully localized and uses the correct icons using fileID.  
- Added esMX support to LocalizationDB.  
- Reverted GetSpellInfo update, it broke Classic Era.  
- Retail: "Estimated cost" in tooltips no longer duplicate-counts Things which are listed within the same tooltip multiple times due to other nesting reasons  
- Added Scarlet Onslaught Trunk object to Icecrown  
- Added the Classic Achievement DB tool. (Used to build the Achievement Data localization for pre-Wrath Achievements (TODO))  
- Retail: Fixed Lua error for professions without a spellID  
- Uldum: Added coords to auto-accept quests  
- Uldum: Battle Pets  
- remove dummy select(1,..) function.  
- Migrate GetSpellName.  
- Some updates.  
