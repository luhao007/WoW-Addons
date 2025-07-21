# AllTheThings

## [4.5.10](https://github.com/ATTWoWAddon/AllTheThings/tree/4.5.10) (2025-07-20)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.5.9...4.5.10) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- Retail: Shifted the Achievements category closer to the other dynamic categories and changes how caching works.  
- [DB] Mists: fix Forest Spiderling pet  
- [Logic] Fixed a bunch of remaining uses of 'creatureID' where 'npcID' is directly accessible  
- [Parser] Fixed creatureID not converting to npcID in all cases (now that creatureID export use is switched to npcID)  
- Update Toy/MountDB for 11.2.0.62049  
- [DB] A bunch of NYI stuff from Cata/MoP  
- MOP: Updated WAGO DB  
- [Parser] headerID is now treated as its own distinct data type rather than piggybacking off of npcID.  
- Update Highmaul with Instancehelper  
- Replaced some comments mentioning npcID, these should be creatureIDs  
- PTR: 11.2.0 build 62049 updates  
- [Parser] Cleaning up some comments and ordering. (no logic changes yet)  
- [DB] Added a couple missing object names manually since they aren't found on Wowhead  
- [Logic] Quest accept/remove refresh is now triggered as a callback (sometimes it happens a lot in one game frame)  
- [Logic] Retail: Conduits are considered a 'Thing' by the code properly  
    [DB] Added a vignette NPCID for 'Voltstrike the Charged' prior to spawning  
    [Logic] Retail: Fixed another raw table used in an ATT list  
- [DB] 'Titan Console Overcharged' is removed in TWW S3  
- Fixed a duplicated power value in the battle pet tooltip. Also now referencing the localized string for OWNED\_PET.  
- [DB] Auchindoun converted to use InstanceHelper to give a standard structure example for WoD dungeons [WIP]  
- [Parser] Added 'BossWithHeader' function to InstanceHelper (niche situations where the content of the Boss should be wrapped in a particular header)  
- [DB] WotLK Fishing: Wrong school ID  
- Owned pets es/mx (#2105)  
    * Owned pets es/mx  
    * Shadowlands corrected name in mx  
- CUSTOM\_COLLECTS\_REASONS should now inherit esMX from esES.  
- Added a placeholder OWNED\_PETS localization string.  
- MOP+: Added Owned Pets to the Battle Pet tooltip.  
- Fix a few reported errors  
- cn update. (#2104)  
- Removed unnecessary Reference Counting for Custom Headers now that the old system has been cleaned up.  
- Fixed a bug with Debug Mode where the mini list would potentially link to an invalid data object.  
- Changed the Cooking Supplies vendors in Northrend Dalaran to display only one header for all the items you can buy from there.  
- [DB] Refactored WoD common dungeon drops to remove duplication  
    [DB] Removed duplicated TW sources of WoD common dungeon drops  
    [DB] Converted WoD TW dungeons to accurately pull the proper set of common drops (no Warforged in TW)  
    [DB] Refactored Auchindoun to remove duplication and properly show content in applicable multi-difficulty headers (like we do elsewhere in ATT)  
- WRATH: Updated the Commander Kolurg / Commander Stoutbeard encounter to use both encounterIDs utilizing AQD/HQD.  
    Updated the ResolveQuestData function to pass the most accurate data to the parent object, this will allow the aqd/hqd's metatable to become the parent if one isn't included.  
- [DB] Simplified a shortcut for making a WoD Warforged header  
- Deprecated OnSourceInit, we only use OnInit now.  
- Classic: Updated the Honored Key logic to utilize the TooltipDB.  
- [DB] TBC Alchemy + Cooking  
- AQD/HQD Consolidation: Parser now handles these fields and injects a resolution function call before calling to the class constructor.  
- Artifact headers in mx and es (#2103)  
- OVERCHARGED\_DELVES is no longer undefined when building for Beta.  
- Updates for 11.2.0.62049  
- Update Crucible of Storms with InstanceHelper  
- Classic: TrySetDisplayID appears to be functional in MOP.  
- Rebuilt LocalizationDB for all flavors to include updated ES/MX localizations.  
- Fixed the COMPLETE\_ICON, this one is also just supposed to be an icon.  
- Update translations to es and mx (#2101)  
    * restore  
    * Icons  
    * about  
    * settings  
    * features  
    * filters  
    * general  
    * Information  
    * Interface  
    * Interface - Accessibility  
    * Fillers  
    * profiles  
    * Retail settings  
    * UI  
    * Corrects in default locale  
    * Fix the gender of Lord queen  
- Fix a few reported errors  
- [DB] Vanilla Tailoring  
- [Logic] Retail: Added 'Achievements' Dynamic group (TBD: removing the current static Achievements category from Main list)  
- [Logic] Retail: Fixed a few more places where raw table data was used in ATT rows  
    [Logic] Retail: Cosmic Infuser (/attmaps) now includes showing how many times a given map has been 'mapped' by data  
- [Locales] Now that the color table was fixed, reverting the TOC load order change.  
- [Locales] Player Titles and Ranks now reference the DefaultColors rather than the dynamic Colors table in game.  
- [Locales] Moved Player Rank and Titles to the Tooltip Strings folder and fixed the load order to handle this change.  
- [Parser] Removed references to the /locales folder in Debug Mode.  
- [Locales] Added Player Rank and Titles to the Tooltip Strings folder.  
- [Parser] Added a couple error check conditions to InstanceHelper  
- [DB] Classic: added level 58 and level 70 character boosts and adjusted expansions per boost (all of the boosts were opened up right before or on prepatch of next xpac)  
- Sort Recipes  
- Harvest: 11.2.0.62049  
- Harvest: 11.2.0.61981  
- Harvest: 11.2.0.61871  
- Harvest: 11.2.0.61787  
- Harvest: 11.2.0.61703  
- Harvest: 11.2.0.61684  
- Harvest: 11.2.0.61624  
- Harvest: 11.1.7.61967  
- Harvest: 11.1.7.61965  
- Harvest: 11.1.7.61609  
- Harvest: 5.5.0.62071  
- Harvest: 5.5.0.62044  
- Harvest: 5.5.0.61879  
- Harvest: 5.5.0.61820  
- Harvest: 5.5.0.61798  
- Harvest: 5.5.0.61767  
- Harvest: 5.5.0.61735  
- Harvest: 5.5.0.61632  
- Harvest: 3.4.5.62072  
- Harvest: 3.4.5.61996  
- Harvest: 3.4.5.61937  
- Harvest: 3.4.5.61934  
- Harvest: 3.4.5.61815  
- Harvest: 3.4.4.61581  
- Harvest: 1.15.7.61582  
- Dedupe Maw of Souls  
- [Logic] Retail: Gave a 'key' to the Root window so my debugging logic doesn't complain about it  
- [Logic] Retail: Upgraded a lot of old existing ATT lists to use real RawText objects instead of raw tables  
- [Logic] Retail: ATT Main list now actually inherits base class fields so that things can be more consistent  
- [Logic] Retail: ATT now loads via Root.lua instead of 'OnLoad' event  
- Classic: Removed unused reference to app.Categories.Achievements, which doesn't exist in this flavor to avoid confusing myself later.  
- Update Maw of Souls with InstanceHelper  
- Classic: Added the sort order for retail exclusive categories  
- Retail: Fixed a bug with the CollectedWarband Information Type.  
- Classic: Removed the print statement from getAchievementCategory.  
- Classic: Now forcing the sort order of the Achievements Dynamic Category to match Blizzard's UI.  
- Removed unused src\Modules\ExtraCategories.lua file. Parser will eventually build this and external addon extensions will utilize the ATTC:CreateWindow API to build extension windows.  
- Refactored the word variable "Categories" in the Settings to "OptionsPages" to avoid having the file appear in searches looking for references to "Categories", which will be receiving an overhaul in the coming weeks.  
- Classic: Turned off "sourceIgnored" on the Enchanting recipe list.  
- Classic: All windows naturally record their last cached progress/total values.  
- Classic: Adjusted the Windows section of the settings menu to force an update if a window has a pending refresh.  
- Classic: Added support for 'sourceIgnored'.  
    Moved the tooltip display logic for 'sourceIgnored' to an information type.  
- Classic: Removed the unused UpdateRowProgress function.  
- [DB] Small formatting issue  
- [DB] Mists: apply Classic phases for Legendary quest chain  
- Updated CUSTOM\_COLLECTS\_REASONS and ABBREVIATIONS.  
- Updated how NEW\_VERSION\_FLAVORS is built.  
- [DB] NYI: two versions of Hellreaver that never got added  
- Rebuilt all headerIDs and DBs now that old style headers are no longer a part of the ecosystem.  
- Updated Legion Artifact logic to not require a specific headerID as a parent.  
- [DB] NYI: a BUNCH of staves  
- [DB] Migrate header: artifact. (#1933)  
    * [DB] Migrate header: Base Appearance.  
    * [DB] Migrate header: Class Hall Campaign.  
    * [DB] Migrate header: Balance of Power.  
    * [DB] Migrate header: Prestige Rewards.  
    * [DB] Migrate header: Challenge Appearance.  
    * [DB] Migrate header: Hidden Appearance.  
    * Removed old locale files as well as old references to the legacy headerID system.  
    ---------  
    Co-authored-by: Crieve <dylanfortune@live.com>  
- new texts for updating att  
- Linked CURRENCY\_ID to the Information type.  
- Categorized all localization files by running the new Localization Converter tool. This program will find the first reference of the locale and make an association to that source file for categorization.  
- Localization strings (#2099)  
    * Added Localization String files generated by the Localization Converter tool that look correct and don't need additional automation. (do not touch these yet, automation is going to replace all content, these are intended to show if/when they get changed incorrectly!)  
    * Fixed exporting localization strings that start with square brackets.  
    * Updated the tool to check for dependencies  
    * Removed all single line comments from the locale files (using the tool)  
    * Removed some more!  
    * Removed all finished strings  
    * Added simple Settings Menu localizations. Added the ability to nest localization strings within additional folders.  
    * SETTINGS\_MENU no longer a special L category  
    * Purged references to SETTINGS\_MENU.  
    * Removed simple localization strings.  
    * Apparently wasn't accounting for nested folders.  
    * Removed a bunch of extra indenting  
    * And in Default Locale  
    * Apparently the converter doesn't like commas.  
    * This was breaking parsing.  
    * Added some more simple localization added as a result of fixing the converter.  
    * Removed successfully simplified locales.  
    * Single quoted strings and multiline locales are bad  
    * Deprecated app.ccColors table in favor of using color string constants with proper color string handling.  
    * ATT is a DefaultColor, not a Color that can be modified later.  
    * Removed successfully simplified locales.  
    * Added simple color converting.  
    * Removed successfully simplified locales.  
    * Removed the unused DRAKEWATCHERMANUSCRIPTS\_CHECKBOX locale strings.  
    * Adjusted some more malformed strings.  
    * Added some more simple strings.  
    * Manually fixed some localization strings' readable text.  
    * Removed successfully simplified locales.  
    * Manually updated a number of localization strings.  
    * Manually converted the rest picked up by the converter tool.  
    * Removed successfully simplified locales.  
    * DRAGONFLIGHT doesn't exist.  
    * [Parser] Added Localization Strings  
    * Fixed some broken readable strings.  
    * [Parser] Now exports localization strings!  
    * Deprecated locales\en.lua and merged the rest into the Default Locale file.  
    * Deprecated all locale files and merged the rest into the Default Locale file.  
    * [Locales] Now parsing icon into the text dynamically.  
    * [Locales] Now parsing color into the text dynamically.  
    * [DB] Rebuilt all DBs to include localization generated by Parser.  
- Revert "new version update texts"  
- new version update texts  
- Diablo Event: Exact portal coordinates and some cosmetic updates to the file  
- Added the Localization Converter tool. (WARNING: Do NOT run this!)  
    Added a blank shortcut for creating a localization string to our database.  
- [Logic] Remove the Fill NPCs checkbox from settings (leaving locale strings for later clean up since partially-used still)  
- Revert "[Settings] Remove deprecated Fill NPCs checkbox (this is controlled by a Filler)"  
- [DB] Mists: fix classic phase being applied to ExpansionFeatures root oops  
- [DB] Classic: update promotions and in-game shop items  
- "Just Keep Swimming" was mentioned on the Going Away blue post  
- Sort locale english + removed duplicated key OPEN\_MINILIST\_FOR (#2096)  
    * Sort entrys in english  
    removed duplicated key entry of OPEN\_MINILIST\_FOR  
    * Sort english locals  
- Removed the unused ABOUT\_PAGE locale.  
- Fixed localization pull request.  
- [Logic] Retail: Catalyst adjustments to account for situations where a BoE/BoA Item has a nested BoP Item which can Catalyst, and may not have an Upgrade track (e.g. DF Primalist Tokens)  
- First batch of changes in locals in all languages to match files 1:1 with english locals, Sorting existing keys, translated missing keys to es and mx. the rest of languages added in TODO. (#2089)  
    * General text entries  
    * Social module  
    * Settings  
    * Instructional Text  
    * Event text  
    * Tooltip Text  
    * Filter Text  
    * Icons and Collection Text  
- [DB] Converted to proper Catalyst structure for VotI [WIP some catalyst logic adjustments to account for niche scenarios with this Tier)  
- [Settings] Remove deprecated Fill NPCs checkbox (this is controlled by a Filler)  
- [DB] Some prep data to allow the 'Primalist tokens to properly show their contained Item's catalyst results in tooltips  
- The Pet Cage toggle no longer requires a reload to work.  
- Added an option to explicitly enable/disable Pet Cage tooltip integration.  
- TSM no longer has a battle pet induced tooltip seizure.  
- Battle Pet Tooltips now respect the CanAttachTooltips requirements.  
- Add Zanj'ir toy secondary source, sort 11.2 toy, fixes #2090  
- [Logic] Retail: Catalyst Items now generate more accurately in some situations (e.g. hopefully this fixes the situation where 5/8 items sometimes show they catalyze into an upgradable item)  
- [Logic] Retail: Items which are assigned 'bonuses' prior to being referenced will now properly include those bonuses into the Item's Link when generated  
- Whoops, that should be "tooltip". Not the global.  
- Fixed a race condition with battle pet tooltips  
- Added Battle Pet tooltips!  
- PTR 11.2.0: "In Search of Darkness" story finally completed. Thanks to Blizz for finally fixing it.  
    - Added a couple of new items to Vendors  
    - Source all Phase Conduits (Temporary placed into Flight Paths)  
- Update Mount/Pet/ToyDB for 11.2.0.61981  
- Rework Trial of Valor to use InstanceHelper (#2087)  
- [DB] Adjust 'The Hataclysm' description to note semantics of required difficulty  
- Fix some reported errors  
- MOP: Added the preprocessor RETAIL\_STYLE\_FILL\_ENABLED since Classic doesn't support Retail styled filling in the mini list and will need the header present for the associated zones instead.  
- Timeline out Dastardly Duos, update shop items, parse  
- Add new Legion Timewalking items  
- Add new shop items, pet missing  
- [DB] Fixed 'Unclaimed Black Market Container' filling themselves in Lists (where all other BMAH content is already filled)  
- [DB] Fixed BMAH triple loading itself into various maps  
    [Parser] Reparsed  
- Fixed timeline constant DELETED\_9\_0\_1  
- The "not" symlink command no longer fails to match multiple elements.  
    Retail: The Black Market Auction House is no longer attempting to flip your RAM.  
- updated some bmah notes based on this https://www.wowhead.com/news/new-black-market-auction-house-listings-in-8-2-5-revealed-tusks-of-mannoroth-295182  
- [DB] Few more Sealed Tome objects in Karazhan  
- Merge branch 'master' of https://github.com/ATTWoWAddon/AllTheThings  
- [DB] Adjusted structure of Grimoire of the Ancient Observer  
- Fixed some missing timeline constants.  
- MOP: Updated Black Market Auction House based on the most accurate availability timeline values. (likely need to double check during each classic expansion)  
- MOP: Updated level requirements on the Peak of Serenity.  
- [DB] Classic: NYI things  
- [Logic] Adjusted handling of app.ReshowGametooltip to internally protect spam with a Callback  
    [Logic] Refreshing tooltips when Retrieving data is found is now much more reliable (shared appearances are still unreliable, WIP)  
- [Logic] Retail: Fixed an issue with async loading on Items/Quests in tooltip Contains  
    [Logic] Added app.ReshowGametooltip to re-draw the current GameTooltip if one is shown  
- Figured out a new missing WoD treasure.  
- MOP: Peak of Serenity moved to its own Expansion Features file.  
- [DB] Classic: add Classic 187 gear for level 80 boost  
- [DB] Mists: add Classic Level 85 boosted gear  
- PTR: 11.2.0 build 61871 updates  
    - added conquest gear  
    - fixed wrong timeline for some pvp s3 headers  
    - fixed timeline for s2 item (due to additional source)  
    - added Reshii Hood / Reshii Mantle  
- [DB] TWW Delve S2 achieves are removed with S3  
- [DB] Mists: update Missing DB and do a little parse  
- [DB] Mists: all the NYI cloth items starting with 'Art Template Cloth' (help me)  
- [DB] Mists: NYI Monster weapons!  
- [DB] Some comment clarity  
