# AllTheThings

## [4.7.3](https://github.com/ATTWoWAddon/AllTheThings/tree/4.7.3) (2025-10-19)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.7.2...4.7.3) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- 2parse4me  
- Artifact drops in Emerald Nightmare are LFR+  
- [DB] Retail: Adjusted some winter veil achievements to automate properly  
    [Parser] Better debug log for ignored CriteriaTree of an Achievement  
- Remove zero-width space from translation (#2179)  
    * Remove zero-width space from translation  
    * Remove zero-width space: Remix: Legion.  
    * Remove zero-width space: Winds of Mysterious Fortune.  
    * Remove zero-width space: Warcraft Movie  
    * Remove zero-width space: Nightfall.  
    ---------  
    Co-authored-by: Chun-Chi Hung <b10102229@gmail.com>  
- [PAT] Updated source file format based on current standards.  
- Sorted all unknown sourceIDs from TWW.  
- [Misc.] Remove zero-width space.  
- [Misc.] Update GlobalStrings.  
- [Misc.] Remove zero-width space.  
- [DB] Added extra drop in AK  
- [Parser] Adjusted SpellEffect regex to retain the trigger spell 64 type  
    [Parser] Parser now follows spell triggers to obtain further incorporation data  
    [Parser] Refactored some questID incorporation to better-determine questIDs in various situations  
    [Parser] Debug: Added RETAIL\_STYLE\_FILL\_ENABLED pre-processor tag  
    [DB] Removed unnecessary symlink from 'Letter of Note, Premier Party Planner' now that questID handling takes care of the same data association  
- [Parser] Added 'customCollect' to sorted fields  
    [Parser] Now properly sorts fields which consist of strings  
- [Parser] Fixed a few fields potentially remaining in Export for certain object Types  
- [DB] Symlink a once-per-account Valdrakken quest with partially-rewarded content  
- Removed some newly sorted Remix raid items from unsorted.  
- Added all Antorus Remix items.  
- [Logic] Retail: Removed some logic which has been hiding Achievement Criteria under Achievement tooltips since 2020 [Think it's better to show the info since it's more accurate than Blizzard Achievement Criteria list baked into Achievement tooltips]  
- [DB] Mists - Celestial: fix Jade Crane Chick pet from Celestial bags  
- bringing order to the isles not ingame  
- Added all Tomb of Sargeras Remix items.  
- Removed unconfirmed Remix zone drop items (they will be mapped into Ensembles automatically for now).  
- [Logic] Retail: Fixed right-click functionality on the 'Source(s)' header of a popout while still preventing popout of the group  
- Merge branch 'master' of https://github.com/ATTWoWAddon/AllTheThings  
- [Parser] Coord shift is now performed as a conditional Action on the Consolidate stage Handler & ignores shifting data with the '\_nocoordshift' tag  
- more clarification/cleanup for hallows end stuff, including future proofing some description. hqt doesnt seem to exist.  
- ghoulish set is limited per character, not acc  
- [Parser] Added a SORTABLE\_FIELDS definition and refactored how field sorting is done in parser so that sorted fields can be adjusted without a rebuild (also removed 'difficulties' since some in-game logic relies on that being a specific order currently)  
- following event layout for the special 1 per day items from brew fest  
- Cleared some Remix unsorted items and did revision to outdoor gear (cloaks are next on radar).  
- Fix some reported errors  
- Mists: do a little parse  
- Mists: harvest Wago db  
- [DB] Mists - Hallow's End: add ilvl 489 Hallow's End loot  
- "Hack" fix to unbreak the parser as per @AlexSoft1911 instructions  
- Added all dungeon drops for Remix.  
- Hallow's End: "Patched Harvest Golem" Ensemble no longer drops from the Dungeon Chest  
    It has been added to the "Candy and Toy" vendors for sale. New "Horseman's Ghoulish" set has been added in adec759b713bee0187d1feeb458b32376efc0279  
- [DB] Classic - Jewelcrafting: fix Prospecting spell ID header for some crafted items  
- [DB] Mists - Celestial: add Celestial vendors to general Shrine zone maps for visibility  
- Alpha: mapIDs a bit and sneaky quest  
- Added all Nighthold Remix items.  
- [PAT] Updated source file format based on current standards.  
- Simplified symlink.  
- [TOC] Update for 1.15.8 ptr.  
- [Logic] Update MoP Classic phase.  
- [TOC] Update for 5.5.2 ptr.  
- [Parser] Fixed an issue where coords on Achievements in Ringing Deeps were being double-shifted  
    [DB] Couple errors & Ringing Deeps Achievement infos  
- [DB] 2 Vignettes for Tide Behemoth  
    [Logic] Retail: Ignore an empty displayID  
- [DB] Convert all manual partial\_achievement sym into achpart shortcuts  
- [Parser] Added a 'achpart' shortcut to help make it cleaner to define partial achievements in ATT  
    [DB] Use achpart in a couple new places [WIP]  
- Fixed symlinks for 'Mote of a Broken Time'.  
- Update some Hallow's End rewards  
- Fix some reported quest and object errors  
- Moved 'Greyed Dragonscale Coif' in Remix to NYI.  
- Fixed Trial of Valor Remix special items.  
- [Parser] Added a QuestID-keyed Wago lookup for SpellEffects/Criteria to drastically-improve some portions of parser processing  
- [PAT] Updated source file format based on current standards.  
- Add the other 12 month sub mount everyone forgot about  
- [DB] Eastern Plaguelands: Sorting more consumable rewards  
- [Parser] Parsed for Git  
- [Parser] Simplified check for compressable structures during export  
    [Parser] Improved performance & consistency for structure replacements during export (repeated parses appear build identical categories now)  
- [Parser] Remove parallel replacement handling when debugging so it's easier to debug  
- [Wago] Adjusted SpellEffect regex to retain apply aura spell effects with a triggered spell (we can use this to find spells which trigger other spells which do something we can use)  
    [Parser] Adjusted SpellEffect incorporation to additionally handle SpellEffect chaining via apply aura (this is not common, but it does apply questID automatically for some Items)  
- Legion: Source a few Quest Items  
- [Logic] Retail: Cleaned up IsSpellKnownByQuestComplete by using a metatable instead (this makes it cleaner/faster/easier to add more overrides in the future as needed)  
- Fix some reported errors, fixes #2178  
- [DB] Eastern Plaguelands: Sorting Sweet Tea  
- [Logic] Added Spell learned override for Feldruid's Scornwing Idol  
- Housing Decor: Update some placeholders with newly datamined items  
- Revert "[PAT] Updated source file format based on current standards."  
- [Logic] Retail: Revised Timerunning Filtering a bit  
    * Non-Timerunning filtering should now be accurate in hiding Timerunning content  
    * Timerunning filtering should now always show Timerunning content, even when nested inside of non-Timerunning content (However, some non-Timerunning content is now visible as a side-effect... will attempt to refine this further in the near future)  
- [Parser] Added a 'repeatable' assignment on HQTs based on a SpellEffect using CLEAR\_QUEST (139)  
    * Can be prevented by adding \_norepeatable if needed  
    [Parser] Removed debug log of different object merge values (pretty spammy and not useful currently)  
    [Parser] Updated Wago data & adjusted SpellEffect Regex to retain Effect type 139  
    [DB] Marked various HQTs as no-repeatable based on personal confirmation  
    [DB] Added missing map for Infinite Bazaar  
    [DB] Removed 'isDaily' from some quest-based content (all of which has remained saved for quite a long while on my Main -- curious if anyone will complain these pop up for them)  
    [Parser] Reparsed for Git  
- [PAT] Updated source file format based on current standards.  
- [Parser] Removed a 'cost' - 'provider' consolidation on Cost types on Achievements/Criteria  
    [Parser] Parsed for Git  
- [Parser] Re-added sorting to some fields which contain only 'long' values to help ensure consistent exports  
- [Parser] Using ConcurrentDataList in a few more places where content is merged under other objects in an arbitrary manner to ensure consistent ordering  
- [DB] Fixed some Dream Wardens HQT  
- [Parser] cl() constructor doesn't need to include 'c' field since it's class-filtered by default  
- [DB] Removed some HQTs which can now be linked on their respective Items instead  
- [Parser] Added a debug warning to potentially remove certain HQTs which are linked by a single non-Quest Item such that the Item can simply hold the Quest directly  
- Commit a release parse for git users  
- [Parser] Adjustments to ID referencing  
    * ID referencing is now done at the end of the Consolidation phase (prior to this it's possible for groups to be missing referenced ID fields)  
    * IsItemReferenced now throws an exception if used prior to the Consolidation phase being complete  
    * Fixed some checks against the referenced ID's to be checks against Sourced groups  
    * Combined handling for referenced IDs & added 'qis' as referenced Items  
    * Uncollectibles are now handled at the start of the Unsorted stage instead of after Validation stage to ensure all referenced Items are accounted for  
