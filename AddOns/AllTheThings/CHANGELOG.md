# AllTheThings

## [5.0.26](https://github.com/ATTWoWAddon/AllTheThings/tree/5.0.26) (2026-04-12)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/5.0.25...5.0.26) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- PASSSSSSSER (R)  
- [TOC] Update for 3.80.1.  
- Fixed HQT root for Midnight raids.  
- Silvermoon City/Pets: Add a set of coordinates for 'Silvermoon Broom'  
- 12.0.5 Event: Decor Duel (Achievements and Vendors)  
- PTR: Parse  
- [DB] Added a note to 'A Skip Through the Void' on possible means of obtaining it when locked  
- [Contrib] Reduced Voidstorm accuracy check a bit  
- [DB] Fixed Star Metal Deposit coords  
    [DB] Some Treasure re-organization (I don't like having Costs for Things nested under the Thing itself... it leads to wild repeated nesting)  
- Removed some redundant locale strings, as only cn/tw localize game names  
- [Locale] Update zhCN. (#2381)  
- [Classic/Promotions] Quest for the owners of the Original "Collector's Edition" of TBC (#2383)  
- Update cost of Vrykul Lord’s Throne to 12000 (#2384)  
- [DB] Temp report begging on Delve HQTs  
- [Parser] Classic: Added a manual Recipe conversion  
    * Reparsed Classic/MOP  
- [Praser] Retail: Reparsed  
- [Parser] More revisions  
    * QuestID assignment via Spell/Item effect correlation improved and cleaned up [Hopefully it shouldn't randomly change either depending on sequencing of parallel operations in parser]  
    * SpellID assignment to Items based on Wago ItemEffect data revised based on effect type priority. It should be more accurate now to the 'Use' or activation Spell of each given Item. Previosuly some items were using the On Equip or other passive Spell which is less important  
    * ItemEffect.IsKnownTriggerType() simplified  
    * Logging data now outputs on a separate line for clarity  
- [DB] Various data restructure and fixes based on parser adjustments  
- Patch 12.0.5 releases on April 21st, 2026  
- [Promotions] Retail/Anniversary TBC Cross Promotion, Echoes of Midnight (#2379)  
- Account Management: Implement sync identity token for character messaging. This is a fallback for starter accounts not being able to retrieve their BattleTag through the game API.  
- Account Management: Add BattleTag display to character tooltip (to help in debugging / player support troubleshooting)  
- Arcantina: Update 'Crumbling Legacy'  
- Midnight Delve Vendors: Update cost of some items  
- Fixed Skyreach using raid difficulty  
- Midnight Weekly: Emissary of War  
- Midnight: 'Dawn of a New Well'  
- [Parser] Full Reparse on latest Parser  
- [DB] Various data fixes exposed by parser fixes  
- [Parser] Rebuilt Parser on latest changes  
- Parser merge simplification (#2382)  
    * [Parser] Various updates and improvements as I sprial into the depths...  
    * Wago data is now 'merged' prior to contrib data [This way contrib data merging afterwards is technically higher-priority and can replace the Wago data within the same object]  
    * Achievement handling no longer relies on obsolete/non-existent 'AchievementDB' and instead relies on the object data itself, which now includes the necessary merged data from Wago or contrib DBs  
    * Fixed Achievements being exported as GuildAchievements even when 'isGuild' was false  
    * Ensure 'isGuild' is not included in Achievement objects  
    * ConcurrentDataList can now construct directly from an existing data list  
    * 'name' field removal moved back to the final cleaning step  
    * [Parser] IncrementTypeUseCount lamba use slightly improved  
    * [Parser] ConditionalItemData no longer needed since merging now handled immediately  
    * [Parser] DBMerge supports 'relaxed' merging (i.e. not throwing an error if data does not contain the respective keyID attempting to be merged)  
    * [Parser] Minor improvement to default data field merge handling  
    * [Parser] Container exporting is once again performed in parallel  
    [Parser] Simplification is once again performed in parallel  
    * [Parser] Handler actions are once again performed in parallel  
    [Parser] Config 'TRACK\_itemID' can now be used to log changes to item data across Handler actions (may revise later)  
    * [Parser] All Item.Merge logic now uses Objects.Merge for consistency  
    * [Parser] Added more valid fields to MERGE\_OBJECT\_FIELDS to support migration away from static Item merge logic  
    * [Parser] Fixed an intermittent issue where Titles under any Achievements were marked uncollectible  
    * [Parser] Fixed regular Achievement Criteria exporting as Guild Achievement Criteria when they are not  
    * [Misc] Retail: Don't load custom Skill Level Requirements  
    * [Parser] Merge the \_wipe field for itemID  
    * [Parser] Don't merge ID values which are not valid  
    [Parser] Don't do object conversion for invalid key values  
    [Parser] Don't merge into objects based on invalid key values  
    [Parser] TryFindObjectConversion now returns decimal key value  
    * [Parser] Key values used in shared data are now stored as decimal instead of object [Tired of accounting for situations where a lookup has the wrong type but identical value and fails to find the data]  
    * [Parser] Fix an object type  
    * [Parser] Fixed artifactID cast & added warning if it fails to be used for sourceID lookups  
    * [Parser] Added MID Skill mappings & cleaned whitespace  
    * [Parser] Skill typo  
    * [Parser] Don't debug warn merge differences for identical values  
    * [Parser] Use \_wipe for cleaning up spellID on Mounts instead of \_drop  
    * [Parser] DB Item data no longer merges into the Items framework and instead is solely handled by the Object merging logic  
    * [Parser] Allow 'lvl' DB merge for itemID  
    [Parser] No longer allow 'requireSkill' merge for recipeID from sourced Objects  
    * [Parser] Guild Achievements don't need to export 'collectible'  
    * [Parser] Fix Guild Achievement removing collectible  
    * [Parser] Few more object merge fields  
    * [Parser] Handler actions can now be individually run against a specific data  
    * [Parser] Added missing Race bit indexes for proper Wago handling  
    * [Parser] Do 'icon' validation during Validate step rather than during Merge  
    * [Parser] Data with 'recipeID' now applies Recipe Filter  
    * [Parser] Merging object data is now simplified and will log an Error if the incoming data cannot convert to the proper field type requirement  
    * String modification is also removed from the merge logic. If needed, it can be handled during the necessary Process step, but currently I see no diffs in the Export  
    * [DB] Chronicle of Lost Memories should \_drop any merged customcollect values  
    [Parser] Simplified \_drop handling  
    * \_drop now fully prevents certain keys from merging into the respective object  
    * \_drop is no longer applied in some cases since base Object merging now accounts for \_drop directly  
    * [Parser] ItemSpeciesDB now merges directly to the ItemDB [Previously was to a temporary container which then merged conditionally into Items. ItemDB logic handles this all as expected]  
    [Parser] Couple additional allowed merge fields needed for Classic parses  
    * [Parser] Minor merge adjustments for better warning on type conversion failures  
    * [Parser] Use WithoutDrops when merging Items into data  
    [Parser] Fixed a couple spacing issues when using DATA\_REQUIREMENTS  
    * [Parser] Fixed an error when an \_encounter field has an odd number of values  
    * [Parser] Removed implicit sorting of parser-only data fields in int-array field types  
    * [Parser] Distinguish \_encounter from typical unique int-array field logic since it can have duplicate values when merged  
    * [Parser] Allow name to merge in for itemID so it can be used more easily later on  
    * [Parser] Fixed some name sorting logic  
    [Parser] WorldDrops are now sorted prior to final cleaning process to ensure the name field is still available  
    * [Parser] 'learnedAt' can now be merged to itemID objects (some non-Recipes have profession skill level requirements)  
    * [Parser] Remove 'name' merging for itemID  
    [Parser] Item name lookup now references the shared object data  
    [Parser] Fix some other item sorting issues  
    * [Parser] Added a \_name cache when looking up via Items.TryGetName  
    * [Parser] Cleaned up 'name' logic in general  
    [Parser] Ensemble raw sources are now sorted by 'name' if possible  
    * [Parser] Simpler 'g' sorting call  
    * [Parser] Name sorting now respects the config 'UseNameSorting'  
    * [Parser] Classic: Recipes assigned a specific 'u' phase via ProfessionDB will properly merge against all sources of the matching Recipe  
    * [Parser] minReputation/maxReputation fields are now protected from merge overwrites  
    * [Parser] TRACK\_itemID now tracks the respective Item data before/after each Processing step  
    * [Parser] IsEquivalent is a bit smarter for convertible Types  
    [Parser] Adjust DB merging for existing field values  
    * [Parser] Prevent requireSkill and skillID being duplicated  
    * [Parser] Specific requireSkill values used in ProfessionDB helpers are now allowed to replace requireSkill values assigned directly to object data. This replacement will also log a warning  
    * [Parser] Fixed an occassional parallelization issue due to Item merging not being concurrent-safe  
    * [Parser] Revert /db/ changes  
    * [Parser] Remove unused data  
- Adjusted the Your Fortune Awaits You... quests.  
