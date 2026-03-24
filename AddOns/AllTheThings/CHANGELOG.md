# AllTheThings

## [5.0.19](https://github.com/ATTWoWAddon/AllTheThings/tree/5.0.19) (2026-03-22)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/5.0.18...5.0.19) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- passseeerrr  
- Hardcoded two more localization strings that are not present in classic flavors  
- Replace Decor string with another one that exists in TBC  
- Reparse for git users  
- [DB] Removed container for symlink-only content (cleaner just to tack the symlink into respective boxes)  
- [DB] Simplified Quel'thalas Zone Rewards symlink  
    [DB] Use new common Quel'thalas Zone Rewards symlink in all existing locations  
- [Parser] Added a 'SYM' constant container which auto-tables itself and any requested keys to allow for cleaner repeated symlink storage in DATA  
- Added all Voidspire raid BoE items.  
- Fix a few minor errors  
- [DB] Nullaeus Cache hooked to respective questID and Beacon of Hope as provider  
- [Logic] Add localization support to the command-line tooltip UI. (#2361)  
    * Add multi-language support to the command-line UI  
    * Apply suggestions from code review  
    Co-authored-by: Dmitry Volodin <mr.molkree@gmail.com>  
    * Update AZERITE\_ESSENCE.lua  
    the right name from https://www.wowhead.com/es/azerite-essences  
    * Rename AZERITE\_ESSENCE.lua to Features - Commands  
    Move/rename file from .contrib/Parser/lib/Strings/Settings/Interface/Information/AZERITE\_ESSENCE.lua to .contrib/Parser/lib/Strings/Settings/Features - Commands/AZERITE\_ESSENCE.lua. No content changes (100% similarity); reorganizes the AZERITE\_ESSENCE string file under the Features - Commands directory.  
    * Use CRF key for DIFFICULTY localization  
    Replace the hard-coded English and Chinese strings with the centralized CRF placeholder ~CRF\_DIFFICULTY in .contrib/Parser/lib/Strings/Settings/Features - Commands/DIFFICULTY.lua. This makes the entry reference the shared localization token and removes the explicit Chinese translation so the parser relies on the common CRF key.  
    ---------  
    Co-authored-by: Dmitry Volodin <mr.molkree@gmail.com>  
- set note for bad elekk promo  
- [DB] Added a description and symlink for 'Essence of Lumber' (maybe not final)  
- Fix a few reported errors  
- [DB] Some refactors to Stormarion Assault based on recent in-game changes  
- Harandar: Sort Renown 9 Moths and remove duplicate entries  
- Updated Wago build files  
    GlobalStrings taken from https://www.townlong-yak.com/framexml/live/Helix/GlobalStrings.lua  
- Fix many tabs  
- Add Pinterest promo, update Gortham  
- 'Actually Safe Treasure Chest' is daily.  
- Add new Trial of Style content, implement Season Start Timeline, fix many reported errors  
- Classic/TBC: Removed the "ShouldShowRelatedThingsInTooltip" option from Reputation-based Achievement Data. These tags, particularly for Insane in the Membrane were inaccurate and added nothing other than bloat. (The Hold Shift option has more information and is 100% accurate to the requirements of the achievement. This matches retail achievement displays more.)  
- Classic: Moved the Elemental Invasions section to World Events, fixed the icon, and moved the ace to a common boss drops section.  
- Classic/TBC: Added Pattern: Truefaith Gloves to Seeker Aqualon in Redridge. (35% pre Cataclysm)  
- [Logic] Fixed a small Upgrade issue where it was not showing properly in tooltips  
- [Debug] Make it slightly easier on myself to switch debugging Events on or off  
- Classic: Updated database references to use IsSpellKnownHelper as per the comment.  
- [DB] Coords & daily for Brewhouse  
- [TBC] Updated the phase assignment for the Knothide Ammo Pouch recipe.  
- Fixed spell rank detection.  
- Deprecated app.IsSpellKnown. Use app.IsSpellKnownHelper from now on as to not confuse the WoW API with this helper function. Removed unused parameters from the helper.  
- Removed "CheckRecipeLearned" since it doesn't work.  
- [Logic] Some Upgrade cleanup  
- Moved some Spell APIs to the WOWAPI.  
- [Logic] Fixed an issue where popouts from /att [link] could show content which did not completely match the linked Item  
- [Logic] ATT now knows about upgrades on MID items  
- [DB] Copied wrong quest  
- [DB] Added probable sq for 'Lessons in the Void'  
- [DB] Adjusted 'Legends of the Haranir' quest structure & HQTs  
- Fixed Baron Rivendare's double entry in Stratholme for Classic Era/TBC.  
- [Parser] Compress the ExplorationAreaPositionDB\_SavedVars DB  
- [DB] MID Raid drops once again link to their respective Upgrade Appearances since Blizzard reverted their intended transmog change (apparently in Oct 2025)  
- Add twitch drop, fix a few reported errors  
- Adjusted classic quest order.  
- Leveling prey box also contains prey gear.  
- [DB] Update Darnassus.  
    add q 9432.  
- The objective text no longer appears within the source location string. (Example: Beacon Torche for the All Along the Watchtowers quest.)  
- #2363 AccessibilityScore now takes the phase into consideration in order to force the tooltip to display for the earliest accessible version of a thing.  
- Zul'Aman no longer erroneously applies Phase 4 to all instances of Badge of Justice.  
- [DB] Reparse for all classic flavors.  
- [Logic] Removed some debugging window prints for now  
- Fix a few minor errors  
- Retail: weekly reset updates  
    - added proper pvp questID for seasonal stuff  
    - added \_drop for What's For Lunch? due to bad blizzard API  
    - 93857 already was in, just few strings above  
- [Logic] Now allowing a stand-alone header group in a minilist to become the root group  
- Update...Ratt's Revenge  
- Voidspire: Add the Questgiver to the rest of the skip quests. It is probably the same NPC as with previous expansions  
- Update Season 1.lua  
- Voidspire: Add quest giver  
- Revert "Voidspire: Skip quest"  
    - It was already there...  
    - This reverts commit 887ffbf4668659dc0c42ae6a6409d0964632e3d0.  
- [DB] Fixed a weird data issue causing all MID expansion features to show in Eversong and Zul'Aman  
- Voidspire: Skip quest  
- Voidstorm: Start 'The Voidspire' quest chain  
- [Logic] Some adjustments to make rooted-subclass constructors properly handle their variants  
- [DB] Fix a source quest  
- [DB] Adjust Saltheril's Soiree  
- Fix a few reported errors  
- [Locale] Update zhCN/zhTW: Object.  
- [Locale] Update All: Object.  
- [Logic] Heavily-used Sub-Classes can now define a 'RootConstructor' to allow direct creation of the Sub-Class type and bypass the conditional constructor logic of their Base Class  
- [Contrib] Missing comma  
- [DB] MID World Bosses set up  
- Fix a few reported errors  
- [DB] Voidspire quest and couple delve HQTs  
- [DB] Added an FP map  
    [DB] Added The Voidspire quest  
- [DB] Added more Prey traps and 2x Nightmare completion HQT  
- Paw Pal Decor / Roofus  
- Objects  
- Updated the Silver Totem of Aquementas.  
- Abundance: Update quests  
- [Logic] Removed assignment and use of app.IsReady  
    * Note: Any 3rd parties relying on this field should add an event handler for the OnReady event instead  
- [DB] Couple HQTs in LFRs  
- [DB] Link some Prey traps to respective content (now that they're Vignettes this is probably more helpful)  
- Fix a few reported errors  
- [DB] Fix races on 85050  
    [DB] Some temporary MID WB questIDs  
    [DB] Restructure PvP 4 week quest sequence  
- Voidstorm: Small updates to quest rewards  
- Adjusted the Good Luck Other-Half-Charm.  
- [Locale] Update zhCN.  
    [Locale] Update zhCN: CHANNEL\_MASTER. (#2360)  
    * Update CHANNEL\_MASTER.lua  
    [locale] Update zhCN: Phase. (#2359)  
    * [locale] update a translate for zhCN  
    [locale] Update zhCN: CategoryDB. (#2355)  
    * Update CategoryDB.lua  
- [Contrib] Use a local key to track initial setup instead of app.IsReady  
- [Contrib] /att report-reset now additionally clears the previous quest check  
    [Contrib] /att contribute-debug now includes showing checked coords distance  
    [Contrib] Added some higher-precision for MID maps  
- [Logic] Now supporting WQLAreaPOITooltipTooltip for WorldQuestList (since it changed the tooltip it uses recently)  
- [DB] HQT 85049 for Horde Pandaren heritage trigger  
- [DB] Remove a couple duplicated HQTs  
- [DB] Forgot to unstage \db\ so here's the rest of the parse :weary:  
- [DB] Fixed questID for Forgotten Ink and Quill [not sure what 94747 is]  
- [Parser] Minor performance improvements  
- Adjusted the Assassin's Contract zone drop information.  
- Updated the Locked Away quest chain.  
- Fixed the Blood of Heroes object header.  
- PTR: bunch of stuff in session  
- Retail: backlog clear up  
- Silvermoon City: Change description on a vendor  
- Moved the Power Crystals to Treasures and some dropped quest items to Zone Drops.  
- Voidstorm: 'Foothold' quest updates  
- Silvermoon City: 'A Favor for the Lion' quest updates  
- Eversong Woods/Special Assignment: Shade and Claw  
- Adjusted the Grimesilt Outhouse Key and associated quest.  
- Voidstorm: Final Sojourner updates  
- Fixed comment typo  
- Voidstorm: Rename Stormarion Assault file  
- Voidstorm: Minor tweak to the 'Breaking the Triad' Sojourner quest chain  
- [Locale] Update zhCN/zhTW: Ensemble Learned.  
- [Locale] Update zhCN/zhTW: Characters.  
- Voidstorm: More Sojourner quest updates  
- Voidstorm: Sojourner quest updates  
- [Parser] Full reparse  
- Parser consistency (#2356)  
    * [Parser] Some extra logging to look for issues with other contribs  
    * [DB] Parse (this branch will not be merged so it's ok)  
    * [Parser] More adjustments to narrow down diff issue  
    * [Parser] Added capability to re-merge shared data if a shared key is freshly-merged  
    * [Parser] Ensure we pre-drop all DB datas before using them to share common data  
    * This ensures that situations where an itemID should drop spellID won't bypass the \_drop by adding spellID after checking \_drop, etc.  
    * [DB] Moved some Pet Battles content which doesn't require Pet Battles  
    * [Parser] Added \_drop for mountID merge  
    [Parser] Removed pre-drop and re-run merge logic, using key-based merges, if required, instead  
    [Parser] Now merging into a combined object prior to merging into the root data [Note: situations where one merge field might specify \_drop needs to account for other merged fields which had not merged yet that should be dropped]  
    [Parser] Re-parsed for comparisons  
    * [Parser] Revised sequence of PostProcessMergeInto to happen during Incorporation stage but after all Data Cloning has completed  
    [Parser] PostProcessMergeInto now uses \_sort\_g instead of g directly  
    [Parser] \_sort\_g is now handled as the last step of Incorporation to ensure all automatically-nested content is consistently-sorted  
    * [Parser] Revert a bit of debugging change  
    * Merge master to line up files  
    * [Parser] Clean up some remaining debugging stuff  
    * Restore master changes for \db\  
    * [Parser] Fix a couple conditional checks that apparently break in Classic parses  
- Stubbed Roofus pack  
