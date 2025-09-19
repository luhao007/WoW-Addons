# AllTheThings

## [4.6.9](https://github.com/ATTWoWAddon/AllTheThings/tree/4.6.9) (2025-09-14)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.6.8...4.6.9) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- Legion Remix: Add coordinates to vendors  
    - Restructure Ensembles sold by Larah Treebender  
- [Logic] Retail: Moved FillGroups localizing to OnLoad for symlink module  
- Fix some reported quest and object errors  
- Legion Remix: Sort more stuff  
- Will we ever finish quantum items?  
- [Logic] Retail: Migrated Symlink module & confirmed working against all current Retail DB symlinks  
- [DB] Fixed an empty symlink due to container changes  
- [Contrib] Fixed function name derp  
- [Logic] Migrated the 'Currency calculation' tooltip option to its own information type (previously it was only included if 'Summarize Things' was enabled)  
- MOP: Added missing spellIDs for the Celestial Riding mounts.  
- MOP: The Eye of Eternity doesn't have a shared lockout.  
- checkout needs spacing  
- Put plate after mail.  
- Sorted Cataclysm rated battleground gear into class and armor headers.  
- Added a lot of new SL explorations (part one of SL).  
- [Contrib] PlayerLocation on reports should now include current difficultyID when one is available  
- [DB] Found a pineapple pizza & some fishing skill  
- Remove warning for Guise of the Phase Diver  
    This was fixed in the latest hotfixes  
- [DB] Rename Tazavesh HM HQT since it flags after success also  
- Legion Remix: Sort some stuff  
- [Contrib] Fixed quest inaccurate check for situations where QUEST\_DETAIL is never fired when accepting a new quest  
- [Contrib] Added a prevention of doing a quest check on the same quest twice in a row (prevent situations where Blizzard sends the QUEST\_DETAIL event twice for the same quest at the same time for some reason)  
- [Logic] Quest Covenant/Renown info is now split on separate lines  
- Update Antorus, The Burning Throne with InstanceHelper  
- Fixed typo.  
- [Logic] Explorations now also support zones (in some cases, subzones are treated as standalone zones). This resolves exploration handling in any instanced content as well.  
- Classic: Updated Naxxramas (Wrath) to show 25 man loot when in 10 man if built with a special preprocessor command exclusive to classic. (This is so that we can quickly change the style for phase one of wrath classic if/when it releases in Wrath Anniversary someday.)  
- [Contrib] Fixed an issue where ordered report data could replace other ordered report data  
    [Contrib] Inaccurate quest check is now performed when 'viewed' instead of when 'accepted' (non-contrib users would still get report check when a quest is 'accepted' as normal). This allows the report to be combined with any other inaccuracies of the quest (coords/providers/etc.) in one report  
- Legion Remix: Added a missing quest found in the achievement data (needs sorting and details added)  
- [Logic] Quest reporting now utilizes the Contributor reporting capabilities for consistent report formatting  
- Removed duplicated WoW's 21st Anniversary  
- [Logic[ Added 'GetNameFromProvider' function  
- [Contrib] Revised a lot of Contribute reporting logic to make it simpler to hook into from other aspects of ATT  
    * Improved report dialogs to always include certain pieces of information even when they aren't inaccurate  
    * Missing Quests from Objects should now have the proper in-game Object name if the mouse cursor currently shows the Object tooltip  
    * 'AddReportData' is now included in the Contributor Module API for external callers to generate consistent ATT report dialogs  
    * 'AddReportData' now accepts an additional 'chatlink' param that can replace the default chat link text for a report  
    * Revised formatting of the "fancy Discord box"  
- Sort remaining missing 11.2.5 achievements  
- Legion Remix: Move old Max Level Item Tokens back to Unsorted  
    Ref. 8b089b8464c03fa7062882537dcfe34d7603201c  
- Legion Remix: Consolidate all Max Level Item Tokens into a 'Mote of a Broken Time'  
- Wago: PTR 11.2.5 build 63092  
- [Logic] Minor improvement for some table concat logic  
- [API] Added a simplified API method 'GetLinkReference(link)' to make it easier for externally retrieving ATT data  
- Fix some reported quest and object errors  
- [Logic] Retail: Added a small cleanup function for a few deprecated SavedVariable keys I noticed locally (maybe not everyone has them)  
- [Parser] No longer attaching duplicated Item provider for Criteria which are marked with the same ItemID  
- [Parser] Now captures DebugDB data for Items used as providers on Headers  
    [Parser] Retail: Now properly captures DebugDB data on Quests whose objectives are merged into the Quest itself  
- [Parser] Now captures 'qis' (Quest Items) into the itemID DebugDB to prevent them from appearing as 'missing'  
- [DB] Fixed some data for Mechagon/Motherlode to remove missing items post-TWW:S2  
- [Parser] Found and fixed some Parser logic issues causing various Ensemble inconsistencies and inaccuracies based on in-game data  
- [Logic] Minor performance improvements by using raw for loops and assignments instead of ipairs/tinsert  
- [DB] Mists: add Chimera of Fear and Chimera of Doubt as quest objectives  
- [Logic] Minor performance improvements by using raw for loops and assignments instead of ipairs/tinsert  
- [Parser] Hierarchical consolidation is now also performed against AQD/HQD content to help reduce redundant/duplicated data  
    [DB] Retail: Reparsed  
- [DB] Mists: remove RF difficulty from MSV, HoF and ToES again in Classic  
- [DB] Mists: assign Sigils to specific bosses from Celestials and some Celestial file cleanup  
- [DB] Mists: Pheromone-Coated Choker drops from MSP  
- [Logic] Ignore 'Manaforge Vandals' quartermaster vignette  
- [DB] Adjusted info for 'Attuned to the Aether'  
- [Parser] Adjusted HQTs to not convert 'provider' into 'qgs' since they are not typical Quests with Quest Givers  
- [Parser] Moved FirstCraft and FirstSkin to global shortcuts for simplicity  
    * Adjusted the formatting of passing a table to FirstSkin to match the typical pattern  
    [DB] Fixed a situation where a breadcrumb is marked as a sourceQuest for something that has no questID  
    [Parser] Made it an error when an empty int-array is merged to help track down when bad data is added  
- Legion Remix: Fix some copy/paste blunders discovered by Harvest  
    - Added 1 new achievement  
- Generate Missing Files: Retail  
- Generate Missing Files: MoP  
- Generating Missin Files: Cata  
- Generate Missing Files: Wrath  
- Generate Missing Files: TBC  
- Generate Missing Files: Classic  
- Sort Recipes  
- Harvest: 11.2.5.62940  
- Harvest: 11.2.0.63003  
- Harvest: 11.2.0.62958  
- Harvest: 11.2.0.62876  
- Harvest: 5.5.1.63014  
- Harvest: 5.5.1.62856  
- Harvest: 5.5.0.62959  
- Harvest: 3.4.5.63009  
- Harvest: 3.4.5.62916  
- Harvest: 3.4.5.62824  
- Harvest: 1.15.7.62915  
- Harvest: 1.15.7.62797  
- [Logic] Fixed a couple tracking settings using CreateForcedAccountWideCheckbox directly instead of relying on ForceAccountWide checks  
- [Logic] Fixed an issue where Runners did not clear their 'OnEnd' function when completing  
- Adjust ToyDB entry  
- [DB] Mists: added alternative Legendary quest 'When in Doubt'  
- [DB] Classic: fix sources for Thick Murloc Scale  
- [PAT] Updated source file format based on current standards.  
- [DB] MFO: Renown 6 quest  
- [DB] 'A Challenger's Resilience' is seasonal (maybe we need a new data tag now that it's becoming more prevalent...)  
- [Logic] Retail: Collecting Things which have a spell-based Cost should now update the Cost properly (e.g. completing a First Craft for a Recipe should now remove the Cost from the Recipe automatically)  
- [Logic] Retail: Costs no longer calculate symlink checks directly. Instead Costs calculation now uses NPC and SYMLINK Fillers to additionally determine if a Thing should be considered a Cost (Note: If a user's settings disable all NPC and SYMLINK Filler use, then it may be misleading for them to see Currency on a Thing but see no content in the tooltip or respective popout, but that's what happens when turning off useful information...)  
    [Logic] Retail: Fixed an issue where cost calculations on a symlink which no longer had collectibles would prevent checking if the cost was a cost due to being a cost for another cost  
- [Logic] Retail: Removed conditional data values for total/progress/costTotal/upgradeTotal after extensive personal testing and ensuring that all ATT content properly uses constructed objects rather than any 'raw' tables  
- [Logic] Retail: Migrated the auto-expand logic to be event-driven after the mini list has completed 'filling' so that the auto-expand can properly affect filled content  
    [Logic] Fillers are now synced with settings as the first action during the OnRecalculate\_NewSettings event  
    [Contrib] Ignored an object in Uldir  
- some errors  
- [DB] Mists: fix error in Krasarang Wilds campaign HQT  
- [DB] Clean up HAT file  
- Legion Remix: Final commit (for now)... Majority of the event should be covered.  
    - Added 3 more Remix Quests  
    - Added Items for the Phase Tokens.  
- [Logic] Classic: actually insert "sub" subroutine result in the finalized table so that parser warning makes sense  
- [DB] Classic: resolve a few parser warnings for symlinks  
- [DB] Parse for Mists  
- [DB] Mists: clean up Celestial dungeons file and add missing items to dungeon bosses  
- [DB] Mists/WoD: add togglable filter for Realm Best achievements and titles in Challenge Mode  
- Fixed the second entry we have for Deckhand's Shirt  
- [DB] Mists: Darkmoon Fishing Cap is not in the game yet  
- [DB] Classic: Hearthstone isn't even a toy in Retail  
- [DB] Darkmoon Faire: Tugboat Bobber  
- [DB] Mists: Moonfang is not dropping loot until SoO, confirmed by Blizzard that her spawning is actually a bug  
- tabard comes from the achievement, only after is available from the vendor; needs 2400 too  
- pvp toy was missing  
- 4191 isnt limited to quartlz, but zonedrop  
- neutral ah note tagged as not relevant after cata  
- nyi item found  
- 16  
- shadefur is extended  
- Fix pet timeline  
- Add new overpriced pet, fix some reported errors, parse  
- tagging discovery enchanting as enchanting  
- [Logic] Retail: Cleaned up the minilist location trigger and made it a bit quicker to swap  
- [PAT] Updated source file format based on current standards.  
- [Logic] Retail: Removed reliance on IsReady by using events when applying a profile  
