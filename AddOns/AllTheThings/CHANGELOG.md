# AllTheThings

## [4.1.1](https://github.com/DFortun81/AllTheThings/tree/4.1.1) (2024-10-25)
[Full Changelog](https://github.com/DFortun81/AllTheThings/compare/4.1.0...4.1.1) [Previous Releases](https://github.com/DFortun81/AllTheThings/releases)

- woW rof esrap  
- Add Reven shop items  
- Retail: Reparsed.  
- Added a template file for Candy Buckets.  
- Added TWW Hallow's End candy bucket coords and objectIDs (which don't parse correctly yet, so no parse done)  
- Fixed timeline and put fishing cosmetics into cosmetic header.  
- [Cata] Geoff: Corrected timeline for the [Embroidered Shirt], as it is not available for purchase until 6.0.3.  
- [Cata] Geoff: Updated "Ancient Suffering" and "The Darkmist Legacy" as breadcrumbs as they are uncompletable if "Verinias the Twisted" is complete.  
- Add Hallow's End 2024, update anniversary drops  
- Anniversary HQT for timewalking quest  
- 1wpn made it, the other not  
- Update anniversary drops  
- bmah has new stuff  
- Parser: Fixed an issue where various object Types which defined default 'timeline' values were preventing sharedData/bubbleDown timeline values from being applied. We now use '\_defaulttimeline' to allow the fallback value for a 'timeline' field if it is not set via another function prior to being parsed  
    Parser: Removed arbitrary default timeline for Criteria objects and moved it to utilize \_defaulttimeline for consistency  
- remvoed rewards from fishing, as the only source is fishing for the cosmectics  
- Retail: Fixed display issue when a Recipe is not Sourced in ATT but shown in a popout  
- Retail: Use new non-collectible wrapper instead of manually assigning collectible = false so that popouts for Reagents/Recipes are simpler and more accurately determined with less logic checks  
- Added a wrapper to create a non-collectible version of a group. [This is preferred over manually setting 'collectible' to false since that can overwrite an identical, collectible version of that group when merged into the same parent group]  
- Retail: Removed 'HasCost' check from showing Source Lines in tooltip (haven't seen it actually return a true value in quite some time)  
    Retail: Fixed a logic issue with popouts for Reagent Items where the Reagent is also a Cost for a Recipe which utilizes the Reagent to produce where the Recipe itself was being marked as non-collectible  
- Cata: Marked all Replica PVP Gear as Hour of Twilight.  
- Whoops, missed the timeline.  
- Cata: Champion of the Tournament is now marked as a bounty. (/attbounty)  
- Fixed a MainOnly Appearances logic issue where a known Source would give credit for shared appearances of other Armor Types (i.e. known Plate Chest giving shared appearance credit for Mail chest which cannot actually be transmogged on the current character)  
- Added Elite requirement to Dragonflight PvP Elite Ensembles.  
- Cata: Marked the Heart & Soul of the Aspects as Hour of Twilight.  
- Cata: Scroll of Resurrection is now marked as Hour of Twilight. (Dragon Soul Phase)  
- Merge pull request #1819 from gjfLeo/master  
    Update zhCN locale.  
- Update zhCN locale.  
- Updated the function template to use constants.  
- Add Swipeasaurus and Chaos-Forged mounts  
- Update anniversary drops  
- Retail: Exploration Thing collected no longer does full logic checks to determine if an Exploration Thing is collected simply checks the cache like other Things do  
    Improved the batch collection of Exploration for the player position  
    Retail: Exploration for the current player position is now immediately checked when force refreshing (instead of getting delayed on a coroutine)  
- Fixed invalid u field value being used within OnInit functions of summonable items  
    Parser now can accurately check assigned unobtainable values based on valid phases within the data (not that this has any effect on raw function value assignments)  
- Fixed typo.  
- Historian Ju'pa does not have any items for sale, removed symlink  
- Revert "Migrate remaining headers Phase 1."  
- Migrate remaining headers Phase 1.  
- Remove zone drops from BRD cache symlink  
- Bit more anniversary achieve data  
- Finished BNet API Quests harvest for 11.0.5  
- Strip redundant ensemble data for 11.0.5 sets  
- Timewarped Ironforge Blueprints?  
- update bug report flavor.  
- Cata: Added Technique: Glyph of Colossus Smash for Inscription.  
- Add some mobilenppcs and update anniversary drops  
- Added a BRD symlink for the plethora of shared anniversary drops  
- Some anniversary achievement infos  
- Add mount drops to anniversary world bosses  
- Remix Ensembles/Arsenals are no longer class locked  
- Add BRD key vendors, confirm more anniversary drops  
- BNet Items Harvest finished for 11.0.5 (Quests had to partially start over due to API Token expiration :weary:)  
- Sort away NYI commendations, reintroduce Zandalar Tribe  
- Fix a few more reported errors  
- Sweep through some reported anniversary errors  
