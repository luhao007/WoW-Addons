# AllTheThings

## [4.0.13](https://github.com/DFortun81/AllTheThings/tree/4.0.13) (2024-09-10)
[Full Changelog](https://github.com/DFortun81/AllTheThings/compare/4.0.12...4.0.13) [Previous Releases](https://github.com/DFortun81/AllTheThings/releases)

- Retail: different fixes from reports  
- Update Vanilla and VC factionIDs to use constants for those missing, catch more missed conversions  
- more QIs 8.0.1(ish), hey darkal  
- Removed extra Source of MoP Eng mounts since they're listed by required specialization already  
- Retail: Fixed a discrepancy with Direct Group Update which would leave 'orphaned' collectibles behind if they had previously been a Cost/Upgrade prior to a settings change. Now the proper Update and progress adjustments are performed based on recursive visibility of the group in question, and the Main list totals once again stay constant without needing additional force refreshes  
- Changed some contrib report formatting for easier copy/paste  
- Moved a couple achievements under their respective WQs  
    One provider addition  
- Added some missing ring quest rewards to Vengeance for Orsis.  
- Merge pull request #1779 from NORPG/master  
    update zhTW  
- update zhTW  
- Updated The First Rule of Ring of Blood is You Don't Talk About Ring of Blood to include the criteria and zones.  
- Sweep some retail errors  
- Added some objects for spawning Collector Astorestes  
- Val'kyrs - reunborn again  
- Wildhammer Tour of Duty now properly shows the correct criteriaUIDs for each npc.  
- Northrend zones: Unborn Val'kyr coords in each zone  
- Dalaran: The Amazing Zanzo  
- Added Dracthyr starter zone Explorations.  
    Changed the starter zone to include any Dracthyr class.  
- Removed added Explorations from unsorted.  
- Added all TWW Explorations.  
- Some cleaning up for unsorted and nyi  
- Armor and cosmetic sorting  
- Including detail about Black Forge and Anvil  
- Some Weapon and Delves sorting  
- Crafted Items: Dark Iron Bar learning costs  
- Quest Items Sorting  
- Some Misc Sorting  
- Retail: Added a couple more custom collect updates from starting SL content (but it's still weird for 70+ characters... need more testing)  
    Added coord for previous SL push-quest  
- Various data todo backlog & contribute reports  
- Fixed a logic bug that caused every character to consider spells 241857 & 148972 as learned. [Will have to implement a revert fix for this later]  
- coords  
- Some quest fixes  
- Fixed Hastily Scrawled Notes infinitely filling itself inside itself (with bonus comment for why it happened)  
- Update Treasures.lua  
    Cant provide yourself.. thats just weird  
- removed cost from queen's pheromone  
- Retail: att contribute fixes  
- Add war supply chest?  
- Enormous Eel Egg is different for alliance players.  
- Update Severed Threads Pact.lua  
- Vignettes will no longer alert when not using the 'Include Completed' option if those Vignettes are not complete but also not visible in the list  
- Retail: contribute  
    * Quests which are not actually 'accepted' are now checked (i.e. Renown progression)  
    * Quest Object providers are now checked properly  
    * Minor report formatting adjustments  
    * Removed a couple Debug chat outputs  
- Parser: Added a post processor to clean up empty groups (during consolidation there was still sometimes data which hasn't moved yet and would leave behind an empty g field)  
- The Horde's Hoard didn't have a source quest requirement.  
- Fixed the Glop / Broodmother quests on the Therazane faction description.  
- First pass of Deepholm. (Still need to add objectives and stuff)  
