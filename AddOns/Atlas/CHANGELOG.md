# Changelog

## 3.9.0 - July 14, 2025
### Added
- Added separate options for the scale and transparency of the small Atlas map, so that you can easily toggle back and forth between a full-size Atlas map, and a minimap-like Atlas map
- When the small Atlas map is partially transparent, hovering over it will bring it back to full opacity
### Changed
- Apply map autoselect (if enabled) to the small Atlas map as well
### Removed
- Removed option to check for disabled modules
### Fixed
- Retail: Fixed Addon Compartment button
- Retail: Fixed AtlasLoot button showing on maps that didn't have an instance associated with them
- Retail: Fixed Hylbrande's position in Tazavesh (Blizzard map is wrong)

## 3.8.0 - July 9, 2025
### Added
- Retail: Added a defeated indicator to boss portraits and boss tooltips, like the built-in instance map (Note that this will only be as good as the built-in map, which sometimes doesn't mark bosses as defeated)
### Changed
- Cata/MoP: Enabled boss portraits on the map (if enabled in Atlas options) and in the boss list
### Fixed
- Retail: Fix position of EJ loot frame

## 3.7.1 - July 3, 2025
### Fixed
- Cata/MoP: Remove dungeon journal buttons for instances that aren't in the game just yet

## 3.7.0 - June 30, 2025
### Added
- Cata/MoP: Added support for Mists of Pandaria Classic
- Classic Era: Added a Scarlet Enclave entry (no map)
### Changed
- Changed to the native frame template, which is mostly only noticeable on retail
### Removed
- Removed the slightly larger map option available for some of the Legion instances

## 3.6.6 - June 21, 2025
### Fixed
- Retail: Fix errors when LibBabble-SubZone is installed as a separate library

## 3.6.5 - June 17, 2025
### Changed
- Retail: Update TOC to 11.1.7

## 3.6.4 - May 31, 2025
An update for Mists Classic is in progress, and will likely come out the day before Mists prepatch, since it isn't currently compatible with Cata Classic.
### Changed
- Classic Era: Switched world map button to Krowi's World Map Buttons
- Updated lib Krowi's World Map Buttons
### Fixed
- Cataclysm: Fixed error from adding classic UBRS
- Cataclysm: Fixed error from TBC instances being in the WOTLK data
- Retail: Fixed world map button highlight

## 3.6.3 - April 27, 2025
### Fixed
- Cataclysm: Add missing classic UBRS

## 3.6.2 - April 22, 2025
### Changed
- Retail: Update TOC to 11.1.5
### Fixed
- Retail: Fix adventure journal map for Blackrock Spire

## 3.6.1 - April 8, 2025
### Changed
- Classic Era: Update TOC to 1.15.7
### Fixed
- Retail: Operation: Floodgate B map is a bit less blurry

## 3.6.0 - March 5, 2025
### Added
- Retail: Added Operation: Floodgate map
- Retail: Added Liberation of Undermine map

## 3.5.2 - February 25, 2025
### Changed
- Retail: Added category and group to TOC
- Retail: Update TOC to 11.1.0
### Fixed
- Retail: Fixed error when sorting by level

## 3.5.1 - February 18, 2025
### Changed
- Cataclysm: Update TOC to 4.4.2
- Retail and Cataclysm: Re-enabled instance journal button for Dragon Soul, End Time, Well of Eternity and Hour of Twilight

## 3.5.0 - February 13, 2025
### Added
- Retail: Added The War Within maps, with the same caveats as Dragonflight and Shadowlands maps
- Classic Era: Added a Karazhan Crypts entry (no map, because the game doesn't have a minimap for it)

## 3.4.3 - January 28, 2025
### Changed
- Classic Era: Update TOC to 1.15.6

## 3.4.2 - January 26, 2025
### Fixed
- Retail: AtlasLoot button will show on Shadowlands and Dragonflight maps

## 3.4.1 - December 20, 2024
### Changed
- Retail: Update TOC to 11.0.7

## 3.4.0 - December 5, 2024
### Added
- Retail: Added Dragonflight maps, with the same caveats as the Shadowlands maps added in 3.2.0.
- Classic Era: Added SoD data, including maps for Demon Fall Canyon (outside area only), Storm Cliffs, Tainted Scar and Crystal Vale.
### Fixed
- Classic Era: Fixed Next/Previous Map buttons

## 3.3.1 - November 22, 2024
### Changed
- Added the current Atlas version to the title of the frame
- Classic Era: Disabled the Atlas LFG button until level 10 (since the built-in LFG tool isn't available until then) and noted that in the tooltip

## 3.3.0 - November 21, 2024
### Added
- Classic Era: Added an LFG button in the top right that will take you to the built-in LFG tool's group browser for that instance. The built-in LFG tool (and this button) are only enabled for SoD and Classic Fresh realms.
### Changed
- Classic Era: Update TOC to 1.15.5

## 3.2.0 - November 7, 2024
### Added
- Retail: Added Shadowlands maps! There are a couple asterisks, the first being that maps of interior areas aren't included. Interior minimaps work differently from exterior minimaps, and I wasn't able to find a reasonable way to make them. The second asterisk is that entrances, connections and bosses (when boss portraits are disabled) aren't marked. Previously those were embedded into the image, but I would like to change that so they get added dynamically.

## 3.1.0 - October 29, 2024
### Added
- Retail and Cataclysm: Re-enabled the functionality of opening the achievement frame by clicking on an achievement in Atlas
- Cataclysm: Like Retail, there are buttons that will take you to the Journal instance entry (Cataclysm instances only) or the Journal instance map (all instances)
- Cataclysm: Like Retail, clicking on a boss name will open its encounter in the Journal (Cataclysm instances only)
### Changed
- Retail: Update TOC to 11.0.5
- Cataclysm: Update TOC to 4.4.1

## 3.0.0 - October 17, 2024
### Added
- Added Cataclysm Classic support
### Changed
- Maps from the Atlas expansion addons have been merged into Atlas (fork) itself and can be uninstalled. While this increases the minimum download size, it greatly simplifies installation and maintainability, and also lets me add Cataclysm support without forking all the expansion addons. The other addons, like Battlegrounds or Dungeon Locations, aren't merged in but will still work if they are installed.

## 2.0.2 - October 7, 2024
### Fixed
- Fixed a few missed C_AddOns functions in integrations

## 2.0.1 - October 6, 2024
### Changed
- Updated Ace libraries
### Fixed
- Fixed error when creating a dialog

## 2.0.0 - October 5, 2024
After Atlas broke with TWW, I reached out to the Atlas team about maintaining Atlas. I didn't get a response, so I decided to fork Atlas and get it working again. I hope to add Cataclysm support soon as well.
### Changed
- Classic Era: Update TOC to 1.15.4
- Retail: Update TOC to 11.0.2
- Retail: Update functions to use C_AddOns namespace
- Update Options button to use new Settings API
### Fixed
- Classic Era: Close button is now the correct size

v1.52.08 (Jul. 29, 2023)
------------------------
- Toc update to support WoW 10.1.5 / 3.4.2

v1.52.07 (Mar. 28, 2023)
------------------------
- Classic Era's WorldMap button support fixed

v1.52.06 (Mar. 20, 2023)
------------------------
- Toc update to support WoW 10.0.7 / 3.4.1

v1.52.05 (Dec. 03, 2022)
------------------------
- Fixed EJ loot window's file button issues

v1.52.04 (Nov. 29, 2022)
------------------------
- Library update: LibUIDropDownMenu

v1.52.03 (Nov. 20, 2022)
------------------------
- Library update: LibBabble-SubZone
- Remove Atlas button from Adventure Journal

v1.52.02 (Nov. 19, 2022)
------------------------
- Toc update to support WoW 10.0.2
- Library update: LibBabble-SubZone

v1.52.01 (Nov. 12, 2022)
------------------------
- Migrate WorldMap Atlas button to use Krowi_WorldMapButtons

v1.52.00 (Nov. 06, 2022)
------------------------
- Dragonflight implementation
- Temporary disable the achievement's linking feature as it's not working at the moment
- Toc update to support WoW 10.0.0

v1.51.06 (Aug. 31, 2022)
------------------------
- Fixed error while checking if alpha build is outdated or not

v1.51.05 (Aug. 30, 2022)
------------------------
- Fixed maps' POI tooltip info was missing due to previous fix's side effect

v1.51.04 (Aug. 22, 2022)
------------------------
- Prevent from WOLTKC maps to have boss button

v1.51.03 (Aug. 21, 2022)
------------------------
- Error fixing

v1.51.02 (Aug. 21, 2022)
------------------------
- Fixed boss names' lookup while in classic server
- Enhance achievement's handling to prevent from nil situation

v1.51.01 (Aug. 17, 2022)
------------------------
- Toc update to support WoW 9.2.7

v1.51.00 (Jul. 23, 2022)
------------------------
- Library update: LibUIDropDownMenu
- Library update: LibBabble-SubZone
- Retail ToC update to support WoW 9.2.5
- Classic ToC update to support WoW 1.14.3
- Added support for Wrath of the  Lich King Classic (WoW 3.4.0)
- Updated retail's uiMapName to ID
- Resolved when only plug-in is loaded, addon still throw warning message

v1.50.04 (Mar. 23, 2022)
------------------------
- Update level range for ClassicEra / BCC

v1.50.03 (Mar. 23, 2022)
------------------------
- BCC ToC update to support WoW 2.5.4

v1.50.02 (Feb. 28, 2022)
------------------------
- Library update: LibUIDropDownMenu

v1.50.01 (Feb. 23, 2022)
------------------------
- Library update: LibBabble-SubZone

v1.50.00 (Feb. 23, 2022)
------------------------
- Toc update to support WoW 9.2.0

v1.49.09 (Feb. 20, 2022)
------------------------
- Library update: LibBabble-SubZone

v1.49.08 (Feb. 19, 2022)
------------------------
- Updated level section information

v1.49.07 (Feb. 15, 2022)
------------------------
- Library update: LibUIDropDownMenu

v1.49.06 (Feb. 10, 2022)
------------------------
- Library update: LibUIDropDownMenu

v1.49.05 (Feb. 9, 2022)
------------------------
- Support multiple ToC
- BCC ToC update to support WoW 2.5.3
- Classic ToC update to support WoW 1.14.2

v1.49.04 (Jan. 27, 2022)
------------------------
- Library update: LibUIDropDownMenu

v1.49.03 (Jan. 26, 2022)
------------------------
- TOC update to support WoW 9.1.5
- Fixed GameToolTip's backdrop setting issue

v1.49.02 (Jun. 30, 2021)
------------------------
- TOC update to support WoW 9.1.0
- Update AreaID table for retail; spilt files for each classic server
- Library update: LibUIDropDownMenu
- Library update: LibBabble-SubZone

v1.49.01 (Jun. 14, 2021)
------------------------
- Library update: LibUIDropDownMenu

v1.49.00 (May 20, 2021)
------------------------
- TOC update to support WoW 9.0.5
- AreaIDs updated to sync with WoW 9.1.0; WoW Classic TBC 2.5.1

v1.48.03 (Dec. 06, 2020)
------------------------
- TOC update to support WoW 9.0.2 (Shadowlands)
- Library update: LibUIDropDownMenu

v1.48.02 (Oct. 26, 2020)
------------------------
- Library update: LibBabble-SubZone

v1.48.01 (Oct. 18, 2020)
------------------------
- Library update: LibUIDropDownMenu

v1.48.00 (Oct. 18, 2020)
------------------------
- Codes and TOC update to support WoW 9.0 (Shadowlands)
- Updated AreaID to sync with Shadowlands

v1.47.04 (Jul. 26, 2020)
------------------------
- Library update: LibBabble-SubZone

v1.47.03 (Jun. 20, 2020)
------------------------
- Further fixed Atlas:GetBossName() to load the plugin's locale first and then BabbleBoss; require to pass module name:
  Atlas:GetBossName(bossname, encounterID, creatureIndex, moduleName)

v1.47.02 (Jun. 20, 2020)
------------------------
- Adjusted Atlas:GetBossName() to load the plugin's locale first and then BabbleBoss

v1.47.01 (Feb. 11, 2020)
------------------------
- Library update: LibBabble-SubZone

v1.47.00 (Jan. 20, 2020)
------------------------
- ToC update to support WoW 8.3.0
- Added AreaID table so that we can lookup AreaName via C_Map.GetAreaInfo()

v1.46.04 (Jan. 06, 2020)
------------------------
- WorldMap icon adjustment for WoW classic
- Integration of AtlasLoot - Battle for Azeroth

v1.46.03 (Jan. 06, 2020)
------------------------
- Library update: LibBabble-SubZone

v1.46.02 (Jan. 05, 2020)
------------------------
- Library update: LibBabble-SubZone

v1.46.01 (Jan. 04, 2020)
------------------------
- Library update: LibBabble-SubZone

v1.46.00 (Jan. 01, 2020)
------------------------
- Added BfA map module's support

v1.45.02 (Dec. 30, 2019)
------------------------
- ToC update to support WoW 8.2.5

v1.45.01 (Sep. 04, 2019)
------------------------
- Code changed to support both WoW 8.2 and classic server

v1.45.00 (Sep. 04, 2019)
------------------------
- ToC update to support WoW 8.2.0

v1.44.07 (Dec. 31, 2018)
------------------------
- Migrate to use LibUIDropDownMenu again with version 2.0
  - Replace with L_UIDropDownMenuTemplate in XML with Lua function call L_Create_UIDropDownMenu()

v1.44.06 (Dec. 20, 2018)
------------------------
- Workaround to fix UIDropDownMenu's tainting issue

v1.44.05 (Dec. 18, 2018)
------------------------
- Fixed case issue of UIDROPDOWNMENU_MENU_VALUE

v1.44.04 (Dec. 18, 2018)
------------------------
- ToC update to support WoW 8.0.1
- Remove library: LibUIDropDownMenu

v1.44.03 (Aug. 12, 2018)
------------------------
- Lib Update: LibBabble-SubZone-3.0

v1.44.02 (Aug. 11, 2018)
------------------------
- Libs update:
  - LibUIDropDownMenu

v1.44.01 (Aug. 11, 2018)
------------------------
- Fixed old function call GetCurrentMapAreaID() and remove it as no longer needed
- Fixed issues when Atlas was previously loaded with more map modules and was selected in the later one
  from the dropdown, but then less map modules were loaded in the fresh login
- Libs update:
  - LibDBIcon

v1.44.00 (Aug. 09, 2018)
------------------------
- ToC update to support WoW 8.0.1
- Libraries update
- WorldMap integration fixed
- Update EJ related functions
- Splitting the development-used-only lib folder and release one
- Update the function to bring up WoW's default map from Atlas

v1.43.06 (Apr. 24, 2018)
------------------------
- Library updtae: LibUIDropDownMenu

v1.43.05 (Mar. 04, 2018)
------------------------
- Libs update:
  - LibDBIcon
  - AceConfig

v1.43.04 (Feb. 22, 2018)
------------------------
- Libs update:
  - LibBabble-Boss
  - LibBabble-Faction

v1.43.03 (Sep. 19, 2017)
------------------------
- Fixed search function issue
- Fixed frame's scale won't get adjusted after a new login

v1.43.02 (Sep. 19, 2017)
------------------------
- Updated LibDialog and fixed issue in PlaySound function call

v1.43.01 (Aug. 31, 2017)
------------------------
- Libraries updtae: LibUIDropDownMenu, LibDialog (temporary fixed)

v1.43.00 (Aug. 30, 2017)
------------------------
- ToC update to support WoW 7.3.0
- Libraries update: Aces, LibBabble-Boss, LibBabble-SubZone, LibUIDropDownMenu

v1.42.05 (Aug. 16, 2017)
------------------------
- Added exception handling for maps' auto-selection while player is in Dalaran.
  If Dalaran is in Northrend, then the selection will be Violet Hold.
- Lib update: Ace3
- Localization update:
  - Russian (BLizzatron)

v1.42.04 (Jul. 15, 2017)
------------------------
- Enhanced map modules / plugins' detection.

v1.42.03 (Jul. 06, 2017)
------------------------
- Fixed issue in Atlas:GetBossName() to throw sub-boss' name instead of the boss-category name.
  For example, in the "Opera Hall" event inside Karazhan, it was presented as "The Big Bad Wolf".
  Now this will be presented correctly.

v1.42.02 (Jul. 02, 2017)
------------------------
- Added option to customize maximum number of menu items
- Added category icon to dropdown menu
- Added to show boss icon
- Fixed version's checking while plugin addon was alpha build
- Lib Update: LibUIDropDownMenu
- Updated PlaySound API's usage method to support both 7.2.5 and 7.3.0 of WoW clients
- Localization update:
  - Simplified Chinese (ananhaid)
  - German (pas06)

v1.42.01 (Jun. 29, 2017)
------------------------
- Fixed index error

v1.42.00 (Jun. 29, 2017)
------------------------
- Modulized Atlas' module data like map entries and association database.
  Now these data won't be kept inside Atlas core addon. Those will be stored
  and maintained in Atlas modules.
  For user who didn't install old map modules like Outland, the corresponding
  map menu also won't appeared.
- Renamed Atlas_RegisterPlugin() to Atlas:RegisterPlugin()
  Plugin author will need to make corresponding changes.
- Renamed Atlas_DropDownLayouts_Order table to Atlas.dropdowns.DropDownLayouts_Order
- Renamed Atlas_DropDownLayouts table to Atlas.dropdowns.DropDownLayouts
- Fixed plugin map image hasn't been set properly
- Enhanced map menus' presentation.
  While one of the map category has more than 30 maps, it will be split to another
  category automatically

v1.41.18 (Jun. 22, 2017)
------------------------
- Added achievement's icon while displaying map's corresponding achievements
- Enhanced Atlas frame's displaying to not to impact with WorldMap's displaying
  and zooming in/out

v1.41.18 (Jun. 21, 2017)
------------------------
- Enhanced msp'd auto-selecting to prevent from error popping-up

v1.41.17 (Jun. 18, 2017)
------------------------
- Enhanced the addon loading status check for detecting AtlasLoot
  and other Atlas plugins

v1.41.16 (Jun. 16, 2017)
------------------------
- Fixed lib loading issue

v1.41.15 (Jun. 16, 2017)
------------------------
- Lib linking fixed

v1.41.14 (Jun. 16, 2017)
------------------------
- Fixed no-lib version's lib setting. LibDataBroker-1.1 should be embedded anyway.
- Re-organized option panel's layout

v1.41.13 (Jun. 04, 2017)
------------------------
- Prevent from error popping up while clicking on boss button before Adventure
  Journal is available to current character.

v1.41.12 (May 25, 2017)
------------------------
- Lib update:
  - Replace NoTaint_UIDropDownMenu with LibUIDropDownMenu

v1.41.11 (May 20, 2017)
------------------------
- Lib update:
  - NoTaint_UIDropDown
- Localization update:
  - German (pas06)

v1.41.10 (May 18, 2017)
------------------------
- Adjusted GetCreatureName function's lookup behavior to ignore BabbleBoss's looking up
- Adjusted Dropdown menu's formatting
- Localization update:
  - Russian (BLizzatron)
  - Simplified Chinese (ananhaid)
- Library update:
  - LibAboutPanel

v1.41.09 (May 14, 2017)
------------------------
- Enhanced AtlasLoot integration feature

v1.41.08 (May 12, 2017)
------------------------
- Fixed issue in localization files

v1.41.07 (May 12, 2017)
------------------------
- Fixed the function call of Lib_CloseDropDownMenus within EJLoot functions
- Adjusted the loot panel's dropdown initialization
- Lib update:
  - NoTaint_UIDropDown

v1.41.06 (May 10, 2017)
------------------------
- Updated map data for the Deadmines

v1.41.05 (Apr. 30, 2017)
------------------------
- Updated map data of Black Rook Hold

v1.41.04 (Apr. 25, 2017)
------------------------
- Disabled listening to EJ_LOOT_DATA_RECIEVED event to prevent from one random error.

v1.41.03 (Apr. 18, 2017)
------------------------
- Added map data of Gul'dan's chamber
- Added feature to retrieve creature name from server and get displayed on
  map's legend panel and tooltip.
  This should improve the issue for those lack of translation

v1.41.02 (Apr. 17, 2017)
------------------------
- Library update: NoTaint_UIDropDownMenu

v1.41.01 (Apr. 15, 2017)
------------------------
- Added new map data of the Nighthold

v1.41.00 (Apr. 14, 2017)
------------------------
- Migrated option panel and settings to be managed via Ace3 libraries
- Now you can disable the boss portait if you don't like it
- Now you can select a default profile for all of your characters, or define
  individual one for specific characters
- Re-arranged most of the functions to be object-oriented
- Re-ordered the code files' loading sequence in ToC
- Drop AtlasOptions

v1.40.06 (Apr. 13, 2017)
------------------------
- Checking deprecated plugins now will recognize the alpha build's version
  if specifed; or will ignore those set "v3.9.0" as the version
  number to be changed by CurseForge's auto-packaging.

v1.40.05 (Apr. 13, 2017)
------------------------
- Now Atlas won't force to disable deprecated plugins.
- Translation update:
  - Korean
  - Latin American Spanish (MrCook1e)
  - Simplified Chinese

v1.40.04 (Apr. 07, 2017)
------------------------
- Nighthold map data update

v1.40.03 (Apr. 06, 2017)
------------------------
- Libraries update:
  - LibBabble-Boss-3.0
  - LibBabble-Faction-3.0

v1.40.02 (Apr. 02, 2017)
------------------------
- Fixed boss button issue

v1.40.01 (Apr. 01, 2017)
------------------------
- Fixed the copyOption will through error for the new user who has no old AtlasOptions DB.
- Disable AtlasDontShowInfo_12201 as there is no reason to show this one anymore.

v1.40.00 (Mar. 31, 2017)
------------------------
- Re-organized maps of Return to Karazhan
- Updated EJLoot function by adding IconBorder
- Slightly enhanced EJ Loot's displaying
- Codes re-organized:
  - Move WorldMap related codes to WorldMapIntegration.lua
  - Move Atlas frame related codes to AtlasFrame.lua
  - Move integration related lua fils to another folder
  - Rename lua files
- Migrated options to somehow managed via AceDB
- Codes clean-up
- Enable module version checking for AtlasLoot and AtlasMajorCitiesEnhanced

v1.39.00 (Mar. 28, 2017)
------------------------
- ToC update to support WoW 7.2
- Fixed issue when AtlasLoot link is clicked but the corresponding
  entry is not available.
- Added to support to lookup run-time item name and show in map's legend
  panel and map's tooltip
- Added WoW 7.2 new dungeon and raid's map data (Cathedral of Eternal Night & Tomb of Sargeras)
- Added instance's description to drop down menu's tooltip
- Split Legion's instance drop down into Dungeons and Raids

v1.38.06 (Mar. 24, 2017)
------------------------
- Added maps of Return to Karazhan

v1.38.05 (Mar. 22, 2017)
------------------------
- Lib update:
  - NoTaint_UIDropDownMenu
- Added to support class color in large map

v1.38.04 (Mar. 21, 2017)
------------------------
- Enhanced Atlas button on Adventure Journal when ElvUI is enabled
- Translation update:
  - Korean
  - German

v1.38.03 (Mar. 16, 2017)
------------------------
- Library update:
  - LibBabble-SubZone-3.0 (translation update to 7.2.0.23758)

v1.38.02 (Mar. 16, 2017)
------------------------
- Translation update:
  - French

v1.38.01 (Mar. 10, 2017)
------------------------
- Performance enhancement:
  - AtlasLoot integration
  - Atlas Map's auto-selection
  - AutoSelect_from_WorldMap
  - Map path locating
  - NPC button's tooltip handling
  - Prev / Next map and map series' switching

v1.38.00 (Mar. 08, 2017)
------------------------
- Added highlight texture on legend panel when mouse hover the boss lines
- Re-arranged frames to use AtlasTemplates
- Library update:
  - LibBabble-SubZone-3.0
- Added AtlasLoot integration:
  - While browsing Atlas instance map, by clicking AtlasLoot button will open
    corresponding loot frame within AtlasLoot

v1.37.04 (Mar. 03, 2017)
------------------------
- Enhanced the loot toggling to switch Atlas small frame to normal frame
- Translation update:
  - French
  - Simplified Chinese
  - Traditional Chinese

v1.37.03 (Feb. 08, 2017)
------------------------
- Added option to toggle Atlas button on World Map window
- Updated KeyBindings' category
- Localization update:
  - Spanish (maqjav)

v1.37.02 (Jan. 24, 2017)
------------------------
- Fixed the achievement criteria's displaying issue

v1.37.01 (Jan. 24, 2017)
------------------------
- Clicking on achievement showing in instance's legend panel will now open
  corresponding achievement within Blizzard's Achievement window

v1.37.00 (Jan. 22, 2017)
------------------------
- Added to support in showing achievement info
- Fixed the issue for old raids which the boss does not have overview information
  in Adventure Journal but while previously browsing new dungeon / raid and then
  old raid, the boss is still showing the overview info from wrong boss when
  mouse hover the boss button
- Enhanced tooltip handling
- Added boss overview's - character role's section details
- Localization update:
  - Spanish (Lawghter)

v1.36.04 (Jan. 20, 2017)
------------------------
- Remove Highmaul from Outland when categorize map with continent
- New feature: Now Atlas will remember your last map selected from each category.
  For example: You select Legion - Neltharion's Lair;
  and then Transportation - Broken Isles;
  and then Outdoor Raids - Broken Isles;
  now when you change to Legion again, it will by-default select Neltharion's Lair

v1.36.03 (Jan. 16, 2017)
------------------------
- Added to support quick map switching by clicking the Next or
  Previous map button

v1.36.02 (Jan. 05, 2017)
------------------------
- Fixed the issue that left-click on boss name in right-side legend panel
  won't open adventure journal
- Translation update:
  - Korean

v1.36.01 (Jan. 01, 2017)
------------------------
- Enhanced Adventure Journal features' integration / linking:
  - setup instanceID, encounterID, mapID, dungeonLevel info to be passed
    from AtlasMap or buttons instead of re-retrieve them from map data
    while calling encounter journal related functions
- Fixed to call Atlas_EncounterJournal_SetLootButton() inside
  Atlas_EncounterJournal_LootCallback()
- Disable EJ_LOOT_DATA_RECIEVED event as it seems to be impact to the official
  Adventure Journal

v1.36.00 (Dec. 28, 2016)
------------------------
- Library updated: NoTaint_UIDropDownMenu
- Slightly enhanced the usage of UIDropDownMenu to better prevent from UI taint
- Added boss loots (adopted from Adventure Journal).
  You can right-click on the boss icon showing in Atlas window to see the boss drops
- Translation update:
  - Korean
  - Simplified Chinese

v1.35.04 (Nov. 16, 2016)
------------------------
- Enhanced Journal Encounter related codes to prevent from trying to open
  adventure journal when it's not yet available due to user's level is too low
- Enhanced gear level's tooltip and prevent it from showing up when the map
  is non-relative to gear level
- Added dungeon / raid / heroci / mythic icon text to instance maps' information panel
- Enhanced codes related to Atlas' dropdown and instance map's level related
  information displaying to better deal with the situation that only heroic
  or mythic mode is available for specific instance
- Fixed issues that NavBar in Adventure Journal window was wrongly nested while
  launching from Atlas multiple times with different instances / bosses
- Translation update:
  - Korean (netaras)

v1.35.03 (Oct. 28, 2016)
------------------------
- Added Xavius to the Emerald Nightmare
- Added feature to show player's current gear level when hovering over the
  instance's minimum gear level line
- Library update:
  - LibBabble-SubZone-3.0

v1.35.02 (Oct. 28, 2016)
------------------------
- Added Gul'dan to the Nighthold
- Translation update:
  - Simplified Chinese (ananhaid)

v1.35.01 (Oct. 27, 2016)
------------------------
- Updated to support Trial of Valor
- Added instance's minimum gear level

v1.35.00 (Oct. 27, 2016)
------------------------
- Toc update to support WoW 7.1.0
- Library update:
  - LibBabble-SubZone-3.0
  - LibBabble-Boss-3.0
  - NoTaint_UIDropDownMenu
- Translation update:
  - Korean (wooyekim)
  - Portuguese (MetalFlavio)

v1.34.05 (Oct. 12, 2016)
------------------------
- Translation update:
  - Korean (netaras)
  - Portuguese (MetalFlavio)

v1.34.04 (Oct. 04, 2016)
------------------------
- Added PvP icon to be presented in large map
- Translation update:
  - Korean (netaras)
  - Portuguese (MetalFlavio)
  - Russian (dartraiden)

v1.34.03 (Sep. 20, 2016)
------------------------
- Slightly enhanced maps' loading process to prevent from nil data being feed
- Added the entrance map for the Arcway and Nighthold
- Translation update:
  - French (Stuxz)
- Fixed the subzone subsitution of Ahn'Qiraj, Temple of Atal'Hakkar, and Karazhan for Traditional Chinese

v1.34.02 (Sep. 09, 2016)
------------------------
- Move instance map data into individual module's local DB
- Set minimap button's default position

v1.34.01 (Sep. 03, 2016)
------------------------
- Minor fix on adventure journal related functions, EncounterJournal_ListInstances() looks to be not necessary anymore.

v1.34.00 (Aug. 31, 2016)
------------------------
- Corrected the boss ID of Sartharion in The Obsidian Sanctum
- Corrected the instance ID of Vault of Archavon
- Changed the old Violet Hold's location to Dalaran (Northrend)
- Updated Icecrown Citadel mapA to add the info regarding to portal to Dalaran
- Minor update for map presenting
- Attached Atlas button to World Map window
- Attached Atlas button to Adventure Journal window
- Added World Map buttton. And now switching between Atlas, World Map, and Adventure Journal will be easier with one click
- New Atlas frames introduced:
  - Large frame: when a instance or location has a large scale of map provided, user can click on size-up button to switch to it
  - Light frame: with the normal Atlas frame, user can collapse the right side of legend panel and only show the main map
- Boss buttons on instance map: now instance's bosses will be presenting with corresponding boss button
- Libraries update: LibBabble-Boss-3.0, LibBabble-Faction-3.0
- Translation update:
  - Simplified Chinese (ananhaid)
  - French (Stuxz)
  - German (pas06)
  - Brazilian Portuguese (Sunflow72)
- Library update: LibBabble-SubZone

v1.33.02 (Jul. 26, 2016)
------------------------
- Revamped Atlas frame and slightly enlarge the info panel.
- Removed AtlasLoot related codes as it no longer depends on Atlas
- Library update: LibDBIcon
- New features:
  - Now mouse hover over the boss entry in the right info panel will show the boss' description when it is available.
    If you click on the boss line, it will open the boss' detail page in Adventure Journal
  - On the instance maps, now mouse hover over the encounter's ID and click on it will open the boss' detail page in Adventure Journal.
- Update Deprecated_List to for AtlasQuest, 4.10.01 will be needed.

v1.33.01 (Jul. 25, 2016)
------------------------
- Slightly enhanced the detection of old modules / plugins and notification of missing those.
- Translation update:
  - Simplified Chinese (lilyhewitt)
  - French (Stuxz)
  - Korean (muffinman369)
  - German (pas06)
- Update Deprecated_List to support the latest AtlasQuest


v1.33.00 (Jul. 19, 2016)
------------------------
- Toc updated to support WoW Legion pre-patch (7.0.3)
- Code changes to support WoW Legion
  - texture:SetTexture(r, g, b, a) changes into texture:SetColorTexture(r, g, b, a)
- Adjusted map info layout to split recommended level into individual line
- Added instance's mythic info
- Instance's level info will be showing with difficulty color based on your current
  level against the instance's level
- Added Siege of Niuzao Temple's heroic info
- Added Warlords of Draenor instances' mythic info
- Added instance and boss info for the following old ones:
  - Ruins of Ahn'Qiraj, Temple of Ahn'Qiraj, Blackwing Lair, The Molten Core,
    Black Temple, Serpentshrine Cavern, Hyjal Summit, Gruul's Lair, Magtheridon's Lair,
    Karazhan, Sunwell Plateau, Tempest Keep, Icecrown Citadel, Naxxramas,
    The Obsidian Sanctum, Onyxia's Lair, The Ruby Sanctum, The Eye of Eternity,
    Trial of the Crusader, Ulduar, Vault of Archavon
- Removed the faction section in AtlasIngameLocales
- Translation update:
  - Simplified Chinese (ananhaid)
  - German (pas06)
- Libraries update: LibBabble-Boss-3.0, LibBabble-Faction-3.0, LibBabble-SubZone-3.0
- Enhanced Atlas_GetBossName() to get better localization result
- Legion instance maps will be released in the later stage, hopefully before the official launch on Sep. 1st, 2016.


v1.32.10 (Jul. 15, 2016)
------------------------
- Added LibBabble-Faction lib to replace the faction looking-up with AtlasIngameLocales's
  GetFactionInfoByID.
  The faction section in AtlasIngameLocales will be removed in later release
- Re-ordered Hellfire Citadel map series.
  - Archimonde is now in the last map
  - Added Mannoroth and Hellfire Assault
- Added symbols' definition so that localization is more flexible when presenting symbols
  (punctuations) in other languages
- Bug fix: map series button is now working again
  (Lib_ToggleDropDownMenu should be used after introducing NoTaint_UIDropDownMenu)


v1.32.09 (Jul. 01, 2016)
------------------------
- Map selection will now also remember the last choice from plugins after reload or logout
- LibBabble-SubZone update (6.2-release5, 7.0.3.22090)
- Translation update:
  - Simplified Chinese (ananhaid)
  - German (pas06)


v1.32.08 (Jun. 27, 2016)
------------------------
- Translation update:
  - Spanish (maqjav)
  - Simplified Chinese (ananhaid)
  - German (pas06)
- Added Atlas_WarlordsofDraenor to module list
- Lib-BabbleSubZone update (6.2-release3, 7.0.3.22045)


v1.32.07 (Jun. 23, 2016)
------------------------
- Dialog button fixed
- Localization files now use CurseForge's keyword subsitution
  (Translators, please use CurseForge's Localization page to update translation from now on.)
  (URL: http://wow.curseforge.com/addons/atlas/localization/)
- Added itIT and koKR (mostly placeholder)
- Enable no-lib package on CurseForge


v1.32.06 (May 16, 2016)
------------------------
- Added modded NoTaint_UIDropDownMenu1.1 to resolve dropdown menu taint issue


v1.32.05 (May 12, 2016)
------------------------
- Fixed the wrong module name of Warlords of Draenor


v1.32.04 (May 11, 2016)
------------------------
- Enhanced codes to prevent from non-boss info showing unexpectedly
- Moved modules' map db info from core Atlas to corresponding module for better maintenance


v1.32.03 (May 9, 2016)
------------------------
- Updated Serpentshrine Cavern map to add elevator point
- Enhanced the way to show the non-boss info


v1.32.02 (Apr. 28, 2016)
------------------------
- Added Supreme Lord Kazzak NPC info
- Enhance NPC text displaying codes to support non-boss description to be shown
  in tooltip
- Added maps' additional tooltips:
    - Dungeon entrance maps
    - Draenor maps
    - Pandaria maps


v1.32.01 (Apr. 25, 2016)
------------------------
- Added Hellfire NPC data


v1.32.00 (Jul. 13, 2015)
------------------------
- TOC update to support WoW 6.2
- Move out Draenor maps to individual mape module
- Remove plugins and modules from the main repository as they have been in
  individual repositories
- Added Hellfire Citadel map data


v1.31.01 (Mar. 01, 2015)
------------------------
- TOC update to support WoW 6.1
- Translation Update:
    - ruRU (StingerSoft)
    - zhCN (ananhaid)
    - esES/esMX (maqjav)


v1.31.00 (Nov. 10, 2014)
------------------------
- Maps added:
    - Auchindoun
    - Blackrock Foundry (Raid)
    - Bloodmaul Slag Mines
    - The Everbloom
    - Grimrail Depot
    - Highmaul (Raid)
    - Iron Docks
    - Shadowmoon Burial Grounds
    - Skyreach
- Maps updated:
    - Upper Blackrock Spire
- Split Mists of Pandaria maps to independent module
- Split entrance maps from Atlas core addon
- Added boss's overview info (if available) to the game tooltip while hover to
  the boss location on the dungeon map
- Added the codes back to check the Atlas modules, when not available, put a
  placeholder map with notification text
- Translation updates:
    - deDE (Dynaletik)
    - esES/esMX (maqjav)
    - frFR (dokcharlie, Khiria)
    - zhCN/zhTW (ananhaid / Arith)
    - ruRU (StingerSoft)


v1.30.01 (Oct. 29, 2014)
------------------------
- Update libraries: AceDB-3.0, LibBabble-SubZone-3.0, LibDialog-1.0, CallbackHandler-1.0, LibStub


v1.30.00 (Oct. 15, 2014)
-----------------------
- Update libraries: LibAboutPanel, LibDataBroker-1.1, LibBabble-SubZone-3.0, LibDialog-1.0
- TOC update to support WoW 6.0


v1.26.02 (Sep. 17, 2013)
-----------------------
- Restore back the simple search feature
- Added Atlas_MapSeries array and new feature, when an instance have series
  map, additional button will appear so that user will be easier to switch
  to other maps
- Enhance Atlas_GetBossName() to lookup minibosses' name
- Enhance dungoen list to show difficulties based on the dungeon's recommended
  minimum level the player's level
- Map updated:
    - Siege of Orgrimmar
- Translation update
    - deDE (Dynaletik)
    - esES/esMX (maqjav)
    - frFR (Khiria)
    - zhCN/zhTW (ananhaid / Arith)
    - ruRU (StingerSoft)


v1.26.01 (Sep. 12, 2013)
-----------------------
- Fix the issue that CheckModule will always through a warning window
- Fix the issue while clicking the Option button the first time won't lead you
  to the Atlas option panel
- Translation minor update to correct the description on how to drag the
  minimap button


v1.26.00 (Sep. 09, 2013)
-----------------------
- TOC update to support WoW 5.4
- Map added:
    - Siege of Orgrimmar
- Translation update
    - deDE (Dynaletik)
    - zhCN/zhTW (ananhaid)
    - ruRU (StingerSoft)
- Bugs fixed:
    - Fixed a bug which shown 1.22.01 update info every time
- Minor enhancemnet:
    - Codes cleanup


v1.25.00 (May 21, 2013)
-----------------------
- TOC update to support WoW 5.3
- Added Rare mob locations to Throne of Thunder
- Added ingame locales for factions & items
- Removed BabbleFaction library
- Issues fixed:
    - Boss gametooltip's scaling
    - FrameXML override bug
    - Options check button tooltip
    - Dungeon journal button location
    - Instance/Entrance button location
    - Search and Clear button size and location
- Options sliders now can be adjusted with mouse wheel
- Slider min-max value changes
- Moved "Instance sort by" dropdown menu under to the checkbuttons.
- Translation update
    - deDE (Dynaletik)
    - esES/esMX (maqjav)
    - ruRU (StingerSoft)
    - frFR (Khiria)
    - zhCN/zhTW (ananhaid)


v1.24.00 (Mar. 05, 2013)
-----------------------
- TOC update to support WoW 5.2
- Introduce the use of LibDialog
- Maps added:
    - Raid: Throne of Thunder
- Maps updated:
    - Heart of Fear
- Translation update
    - deDE (Dynaletik)
    - esES/esMX (maqjav)
    - ruRU (StingerSoft)
    - zhCN/zhTW (ananhaid)
- Minor issues fixed
    - WotLK map's info


v1.23.0 (Dec. 07, 2012)
-----------------------
- TOC update to support WoW 5.1


v1.22.1 (Oct. 10, 2012)
-----------------------
- Maps and legend info update:
    - Gate of the Setting Sun
    - Mogu'Shan Palace
    - Shado-Pan Monastery
    - Stormstout Brewery
    - Temple Of The Jade Serpent
    - Scholomance
    - ScarletHalls
    - MoguShanVaults
- Translation update
    - deDE (Dynaletik)
    - esES/esMX (maqjav)
    - ruRU (StingerSoft)
    - frFR (Khiria)
    - zhCN/zhTW (ananhaid)
- Bugs fixed:
    - minimap button toggle issue
- Enable option to check if any missing Atlas built-in module or plug-in


v1.22.0 (Sep. 25, 2012)
-----------------------
- Update TOC to support WoW 5.0, support for Mists of Pandaria
- Maps added:
    - Gate of the Setting Sun
    - Heart of Fear (Raid)
    - Mogu'shan Palace
    - Mogu'shan Vaults (Raid)
    - Scarlet Halls
    - Shado-pan Monastery
    - Siege of Niuzao Temple
    - Stormstout Brewery
    - Temple of the Jade Serpent
    - Terrace of Endless Spring (Raid)
- Maps updated:
    - Ragefire Chasm
    - Scarlet Monastery
    - Scholomance
    - Auchindoun: Auchenai Crypts
        - Coilfang Reservoir: The Slave Pens
        - Maraudon
        - Razorfen Kraul
        - Drak'Tharon Keep
- New Calalycsm module created, core module only to keep the current expansion
  new and revised maps
- Updated lots of boss names to use the dungeon journal
- Added Atlas Information window when the addon is loaded
- Readme update
- Translation update
    - deDE (Dynaletik)
    - esES (maqjav)
    - ruRU (StingerSoft)
    - frFR (Khiria)
    - zhCN (ananhaid)
- added the use of following Libs: AceAddon-3.0, AceConsole-3.0, AceDB-3.0,
  LibDBIcon-1.0;
    - Minimap button now rendering with LibDBIcon
    - New chatcommand '/atlasbutton' to toggle the Atlas minimap button
- Added most of the dungeons' boss description when mouse is hover


v1.21.1 (Dec. 06, 2011)
-----------------------
- Maps Updated:
    - Dragon Soul (dubca7, Dynaletik)
    - End Time (dubca7, Dynaletik)
    - Well of Eternity (dubca7, Dynaletik)
    - Hour of Twilight (dubca7, Dynaletik)
    - Caverns of Time (dubca7, Dynaletik)
- Fixed Gnomeregan map info to point to correct dungeon ID
- Fixed Dragon Soul map's auto-selection issue (Dynaletik)
- Translation update
    - zhCN translation update (dh0000)
    - Copy esES to esMX
    - Added ptBR and ptPT translation (Barkend, limited translation for now)
- Lib update:
    - Update Lib-BabbleSubZone to release 4 to prevent from multiple addons
      loaded the same lib and causing translation missing issue


v1.21.0 (Nov. 29, 2011)
-----------------------
- Update TOC to support WoW 4.3
- Split plugins into separated addons
    - Atlas_Battlegrounds
    - Atlas_DungeonLocs
    - Atlas_OutdoorRaids
    - Atlas_Transportation
- Split dungeon maps into separated modules based on the expansion sets;
  *** NOTE that if you would like to have all the dungeon maps to be displayed
      in Atlas, you have to download all the modules.
    - Atlas_BurningCrusade
    - Atlas_ClassicWoW
    - Atlas_WrathoftheLichKing
- New Feature:
    - Added boss description as game tooltip to the map which was associated
      with Dungeon Journal
- Fixed Frozen Halls dungeons missing in level categorizing method (Celellach)
- Dungeon information enhancement: now the dungeons' level range, recommended
  level range, minimum level, and player limit will be synchronized with
  Dungeon Finder info.
- New Maps Added:
    - The Dragon Soul (dubca7, Dynaletik)
    - Well of Eternity (dubca7, Dynaletik)
    - Hour of Twilight (dubca7, Dynaletik)
    - End Time (dubca7, Dynaletik)
- Maps Updated:
    - Firelands (dubca7)
    - Baradin Hold (dubca7)
    - Caverns of Time Dungeon Entrance (dubca7)
    - Throne ff the Four Winds (dubca7)
    - The Bastion Of Twilight (dubca7)
    - The Sunken Temple Instance / Entrance (dubca7, Dynaletik, Celellach)
- Translation Updated
    - German (Dynaletik)
    - Russian (StingerSoft)
    - French (Khiria)
    - Traditional Chinese (arith)
    - Simplified Chinese (ananhaid)
    - Spanish (maqjav)
    - Russian (StingerSoft)


v1.20.1 (Sep. 09, 2011)
-----------------------
- Added Journal Encounter button to Atlas frame (lag, arith, Dynaletik)
- Maps updated:
    - Eye of the Storm (dubca7)
    - Black Temple (dubca7)
- Maps info updated:
    - Firelands map info updated (Dynaletik)
    - Throne of the Four Winds map info updated (arith, Dynaletik)
- Map auto-selection algorithm enhancement to fix the problem when different
  dungeons' subzone have same translation in other language(s)
- Minor additions, bugfixes, and layout tuning (Dynaletik, arith)
- Translation updated
  - German (Dynaletik)
  - Russian (StingerSoft)
  - French (Khiria)
  - Traditional Chinese (arith)
  - Simplified Chinese (ananhaid)
  - Spanish (maqjav)
  - Russian (StingerSoft)


v1.20.0 (Jun. 28, 2011)
-----------------------
- TOC update to support WoW 4.2
- Maps added / updated:
    - New raid map - Firelands (dubca7, Dynaletik)
    - Eye of the Storm (dubca7)
    - Dungeon location map update (dubca7, Dynaletik)
    - Baradin Hold map update (dubca7, Dynaletik)
    - Transportation maps update (arith)
    - Zul'Gurub map update (arith, Dynaletik)
    - Zul'Aman map update (dubca7, Dynaletik)
- Remove dungeon keys (Dynaletik)
- Boss name translation enhancement by using Encounter Journal feature
  (Dynaletik, arith)
- Fixed some dungeon level ranges (Dynaletik)
- Translation update
  - German (Dynaletik)
  - Russian (StingerSoft, Dynaletik)
  - Spanish (maqjav, Dynaletik)
  - French (Dynaletik)
  - Traditional Chinese (zhTW, arith)


v1.19.2 (May 30, 2011)
-----------------------
- Dungeon maps' auto-select feature fixed for Throne of Tides,
  Blackrock Spire, and Wailing Caverns
- Maps' auto-select database enhancement
- Transportation map update:
  - Added flight point - Vendetta Point (Horde) in Southern Barrens, Kalimdor
- Translation minor update
  - Spanish (maqjav)


v1.19.1 (May 06, 2011)
-----------------------
- Updated Wailing Caverns map (dubca7)
- Updated Zul'Aman NPCs
- Translation update
  - German (Dynaletik)
  - French (Khiria)
  - Russian (StingerSoft)
  - Traditional Chinese (arith)
  - Spanish (maqjav)


v1.19.0 (Apr. 28, 2011)
-----------------------
- Support WoW 4.1
- Added Zul'Gurub dungeon map
- Dungeon level info update


v1.18.3 (Apr. 13, 2011)
-----------------------
- TempestKeep Entrance map info update
- Transportation maps update
- TolBarad 3 cell blocks added
- Rare mobs locations updated in several dungeon maps
- Archaeology Quest in Uldum 5 men dungeons
- Remove Argent Dawn faction from dungeon maps


v1.18.2 (Jan. 28, 2011)
-----------------------
- NPC map updates for several dungeons
- Added Caverns of Time: Hyjal Entrance map
- Added Tempest Keep Entrance map
- Added Ulduar Entrance map


v1.18.1 (Jan. 06, 2011)
-----------------------
- Translation update
  - German (Dynaletik)
  - French (Khiria)
  - Russian (StingerSoft)
  - Traditional Chinese (arith)
  - Spanish (maqjav)
- Maps and NPCs update for several dungeons and continents
- Resolve Eastern Kingdom dungeon menu display issue by spliting into two parts


v1.18.0 (Dec. 07, 2010)
-----------------------
- Prepared Atlas for the Cataclysm Maps
- Added Baradin Hold
- Added Blackrock Caverns
- Added Blackwing Descent
- Added Grim Batol
- Added Halls of Origination
- Added Lost City of the Tol'vir
- Added The Bastion of Twilight
- Added The Stonecore
- Added The Vortex Pinnacle
- Added Throne of the Four Winds
- Added Throne of the Tides
- Added Battleground maps
  - The Battle For Gilneas
  - Tol Barad
  - Twin Peaks
- Revamped and updated all old maps
- Dungeon Level info updated
- Battleground Level info updated
- Introduced LibBabble-Boss, LibBabble-Faction to Atlas
- Fixed the right-click won't bring up WorldMap issue
- Fixed minimap Middle-Click won't bring up Atlas Options window
- Translation update
  - German (Dynaletik)
  - French (Khiria)
  - Russian (StingerSoft)
  - Spanish (maqjav)
  - Traditional Chinese (arith)


v1.17.2 (Oct. 18, 2010)
-----------------------
- Hotfix to resolve the plugins maps won't show when AtlasLoot is enabled.
- Added About panel.


v1.17.1 (Oct. 13, 2010)
-----------------------
- support WoW 4.0
- translation update
  - Simplified Chinese (DiabloHu)
  - Spanish (maqjav)
- change the options to be per account instead of per character
- fixed Ruby Sanctum map


v1.17.0 (Aug. 15, 2010)
-----------------------
- improved auto-selection feature for foreign languages (Dynaletik, arith, Lothaer)
- introduced LibBabble-Zone and LibBabble-SubZone to Atlas (arith, Dynaletik)
- new map: Hellfire Citadel dungeon entrace map (arith)
- new maps: Halaa PvP, Hellfire Peninsula PvP, Zangarmarsh PvP,
            Terokkar Forest PvP, Wintergrasp PvP, Game of Tower, Silithyst Must Flow (arith)
- cleaned up and tweaked some code
- translation update for several languages
  - German: Dynaletik
  - French: dokcharlie
  - Russian: StingerSoft
  - Traditional Chinese: s8095324, arith
  - Simplified Chinese: arith
- rewrote the readme file for Traditional Chinese (arith)
- added Lunar Elders locations in Northrend maps (Deadca7, Dynaletik)
- several maps refine (Deadca7)


v1.16.1 (Jun. 07, 2010)
-----------------------
- new map: Ruby Sanctum
- fixed and added some ICC entries
- minor fixes


v1.16.0 (never released)
-----------------------
- new map: Icecrown Citadel, in three parts (Deadca7)
- new map: The Frozen Halls: The Forge of Souls (Deadca7)
- new map: The Frozen Halls: Pit of Saron (Deadca7)
- new map: The Frozen Halls: Halls of Reflection (Deadca7)
- added Toravon to VoA and updated the map (Deadca7)
- added new instances to the dungeon locations map (Dynaletik)
- added the new flight paths (Dienur, Dynaletik, Jeehell)
- added event boss to SFK (Dynaletik)
- removed Onyxia attunement (Dynaletik)
- fixed wave 6 to wave 5 in Culling of Stratholme (Dynaletik)
- fixed many flight path routes (Dynaletik, Jeehell)
- fixed some map categorization issues
- rewrote and simplified the readme file
- removed the world map coordinates feature


v1.15.2 (Dec. 18, 2009)
-----------------------
- updated TOC number to 30300 for the 3.3 patch
- fix for zhTW (Traditional Chinese) translation (s8095324)


v1.15.1 (Oct. 10, 2009)
-----------------------
- fix for deDE (German) translation
- updated version check for some Atlas addons
- settings will now be preserved between some updates


v1.15.0 (Oct. 07, 2009)
-----------------------
- new map: Crusaders' Coliseum: Trial of the Champion (Deadca7)
- new map: Crusaders' Coliseum: Trial of the Crusader (Deadca7)
- new map: Isle of Conquest (Deadca7, Celellach)
- added Koralon the Flame Watcher to VoA (Deadca7)
- added Dark Ranger Marrah to Utgarde Keep (thandrenn)
- added Prospector Doren and Archivum Console to Ulduar (thandrenn)
- added flight path from The Dark Portal to Shattrath (Celellach)
- added trans routes (portals) from capitals to Dark Portal (Celellach)
- added exit to The Botanica (Celellach)
- added VoA to dungeon location map (Celellach)
- added brackets to battleground level ranges (Celellach)
- removed Highlord Kruul map entirely (nonameform)
- removed Maraudon key since it's no longer needed (Hegarol)
- fixed some level range groups (Celellach)
- fixed some mob positions in Wailing Caverns (arith)
- tagged Ahune with Midsummer Festival (Celellach)
- changed Lunar tag to Lunar Festival (Celellach)
- updated Onyxia's Lair player and level data (Bolino)
- current deDE (German) translation (Nihlo)
- current esES (Spanish) translation (maqjav)
- current frFR (French) translation (TrAsHeR)
- current ruRU (Russian) translation (StingerSoft)
- current zhCN (Simplified Chinese) translation (arith)
- current zhTW (Traditional Chinese) translation (arith)


v1.14.2 (Aug. 19, 2009)
-----------------------
- updated TOC number to 30200 for the 3.2 patch


v1.14.1 (May 12, 2009)
-----------------------
- fixed some locations in Blackwing Lair (Celellach)


v1.14.0 (Apr. 28, 2009)
-----------------------
- updated TOC number to 30100 for the 3.1 patch
- new map: Ulduar [in 5 parts] (deadca7, everyone else!)
- new map: Vault of Archavon (deadca7)
- new map: Strand of the Ancients (deadca7, Celellach)
- new map: The Eye of Eternity (deadca7)
- revamped Stratholme Past map (thandrenn, Celellach, Nalumis, Hinalover)
- revamped Northrend transportation maps (Timo, Celellach, Dynaletik, dcemuser, Kharthus)
- revamped The Oculus map (Celellach, thandrenn)
- added Stratholme Past to CoT Entrance map (Celellach)
- added exit to Ahn'kahet map (Celellach)
- added Brigg Smallshanks to Utgarde Pinnacle (Celellach)
- added Commander Kolurg to The Nexus map (Spleebie)
- added Kurzel to Drak'Tharon Keep map (thandrenn)
- added Drakuru's Brazier to Drak'Tharon Keep map (Celellach)
- added Vesperon, Tenebron, Shadron, and the entrance to Obsidian Sanctum map (Celellach)
- added Ahn'kahet Brazier to Ahn'kahet map (Celellach)
- added Watchers to Azjol-Nerub (Celellach)
- added additional entrance and exit to Gundrak (Celellach)
- added Wanders tag to Bjarngrim in HoL (Celellach)
- added Ulduar to dungeon locations map (Celellach)
- added exit to Tempest Keep Mechanar (Celellach)
- added The Violet Hold Key to Violet Hold (Celellach)
- added Celestial Planetarium Key to Ulduar (Celellach)
- added a new category for 80+ maps
- moved Trollgore's location in Drak'Tharon Keep (Spleebie)
- moved Elder Starsong in Sunken Temple map (Robsato)
- removed rep lines from Magtheridon's Lair (Celellach)
- removed rep line from Naxx (Dynaletik, Celellach)
- removed Archmage from Naxx (Celellach)
- removed Mallet key from Zul'Farrak (Celellach)
- removed Amulet key from Onyxia's Lair (Celellach)
- removed all keys from Molten Core (Celellach)
- removed Seal key from UBRS (Celellach)
- removed Urn key from Karazhan (Celellach)
- removed Medallion key from all BT (Celellach)
- removed Tempest Key from The Eye (Celellach)
- removed optional deps from TOC file (Phanx)
- renumbered Ahn'kahet (Celellach)
- renumbered The Nexus (Celellach)
- increased battleground level ranges to 80 (Celellach)
- increased frame strata to HIGH to avoid messing with the default interface
- changed x-category in TOC files (Phanx)
- fixed some Alterac Valley coloring and ordering issues (Celellach)
- current deDE (German) translation (Dynaletik)
- current esES (Spanish) translation (maqjav)
- current frFR (French) translation (Kiria, TrAsHeR)
- current ruRU (Russian) translation (StingerSoft)
- current zhCN (Simplified Chinese) translation (DiabloHu)
- current zhTW (Traditional Chinese) translation (banana, arith)


v1.13.0 (Nov. 24, 2008)
-----------------------
- added tons of new WotLK instance maps!
- added most if not all WotLK map data (thanks to DiabloHu, Deadca7, and others!)
- corrected some map category grouping issues
- added cursor coordinates to the world map
- added Don Carlos and Guerrero to Old Hillsbrad Foothills (Hegarol)
- gave Veyzhak the Cannibal a home in The Sunken Temple (Telchar)
- updated Naxx information and data for WotLK changes
- the flight path plugin now contains all transport routes (boat, zep, portals)
- the flight path plugin has been renamed to Transportation
- added Northrend dungeon location map
- outdated modules are now checked for and disabled
- resetting defaults now properly resets the sort-mode
- resetting defaults now properly updates the status of the lock button
- other minor tweaks and improvements


v1.12.3 (Oct. 26, 2008)
-----------------------
- fixed various errors on non-English clients
- fixed the right-click to toggle world map bug
- added LibDataBroker support
- Titan Panel support fixed (via LDB)
- changed the options panel to the built-in interface
- added support for the built-in defaults button
- removed the minimap button icon's green tint


v1.12.2 (Oct. 15, 2008)
-----------------------
- scrolling error fix
- all remaining instances of 'Rep' changed to 'Reputation' in the locale files
- non-English readme files should have no more messed up characters


v1.12.1 (Oct. 15, 2008)
-----------------------
- updated TOC number to 30000 for the 3.0 patch
- some compatibility fixes for the new patch
- added 'Ahn'Qiraj' and 'Blackrock Mountain' as a prefix for the instances within them
- added Delrissa's Minions to MT
- added 'Griz Gutshank' to BRD
- added a Minimum Level for SP
- renamed 'Rep' to 'Reputation'


v1.12.0 (Jul. 25, 2008)
-----------------------
- changed the Atlas data format to include GUID information (no in-game change)
- changed the frame strata back to MEDIUM so Atlas can cover/be-covered-by other windows
- added a fix for some UI elements that appear above the Atlas window
- added a Shattered Sun Offensive reputation tag to MT
- removed 'The' from both AQ instance names
- added a mark (1) for Patchwerk to the map of Naxx
- changed the entry colors for the Abomination Wing in Naxx
- split C'Thun encounter into two entries in AQ40
- removed 'The' from ST title
- added an AKA line to ST
- changed Troll minibosses to Atal'ai defenders in ST
- changed Doomrigger's Clasp to Doomrigger's Coffer in UBRS
- added the chapter to Draconic for Dummies in BWL
- split the key entry into two in MC
- added 'The' to the different Deeds in Scholo
- added 'Various' to Postbox Keys in Strat
- changed Scarlet side to Living side in Strat
- changed Medallion of Faith to Malor's strongbox in Strat
- changed Plans: Serenity and Plans: Corruption to Blacksmithing Plans in Strat
- removed Plaguewood from Naxx location
- added Four Horsemen Chest to Naxx
- removed 'The' from Argent Dawn reputation line in Scholo, Strat and Naxx
- added brakets to the two Pusillin entries in DM East
- added brakets to Thralls stop entries in COT1
- added (Lower) to Discs of Norgannon in Ulda
- added a new key for Edge of madness in ZG
- removed 'The' from Zandalar Tribe reputation line in ZG
- added a Servants Quater entry to Kara [A]
- completely rearanged the opera event in Kara [A] (renamed titles, added NPC)
- added Dustcovered Chest to the chess event entry in Kara [B]
- changed Budd's Map of ZA to The Map of ZA
- changed Windcaller Claw to Claw in Underbog
- changed Seer Udalo to Udalo in the Arcatras
- removed Stasis Chamber tag from Yor in Manatombs
- changed the order of reliquiary of souls in BT
- added 'The' to Illidari Council in BT
- refreshed the Shadowfang Keep map (Deadca7)
- added minimum level data to instance maps (Deadca7)
- changed the frame artwork to accommodate min level
- zone information text will no longer extend past the edge of the frame
- zone information text can now be ctrl-mouseover'd for a tooltip
- merged the Entrances plugin (and all its maps) into the core Atlas addon
- tweaked auto-select, more outdoor zones are now associated with instance maps
- expanded meta-zone abbreviations to their full names, eg. HFC --> Hellfire Citadel
- added a new sort-by option: type (separating instances and entrances)
- added a key-binding to force a one-time auto-select, even if the option is disabled
- added <Angle Bracket Titles> to all appropriate mobs in the Atlas database
- changed "East" and "West" designations to "Eastern Kingdoms" and "Kalimdor" (Telchar)
- added Ahune <The Frost Lord> to Slave Pens (Nihlo, Telchar)
- this is a giant update, my apologies if I've forgotten anything


v1.11.0 (Mar. 26, 2008)
-----------------------
- updated TOC number to 20400 for the 2.4 patch
- new map: Magisters' Terrace
- new map: Sunwell Plateau
- the Atlas legend is quite a bit wider now
- some artwork updates and tweaks, mostly for the scrollbar
- added a button to toggle between entrances and instances, including a dropdown menu for multi-instance entrance maps
- updated all the entrance map level ranges
- with the wider legend, removed some instances of wrapping and abbreviation
- tiny code fix for AtlasMajorCities (preliminary) (Andy)
- tweaked the default position of the minimap button (Telchar)
- renamed the five default Atlas plugins for a cleaner AddOns directory
- improved the screen clamping offset values
- fixed a bug with the reset position button
- frame scale slider option increased to 1.5
- legend entries that are too long will be truncated now
- added an option to show a legend entry tooltip if the control button is held down
- changed the frame strata of the main window so it covers all the action bars
- added an option to display the player's coordinates on the world map
- changed Horde Base to Horde Encampment and Night Elf Base to Night Elf Village in Hyjal (Telchar)
- changed Blacksmith Plans to Blacksmithing Plans 3 times in BRD (Telchar)
- added acronyms to Gnomeregan, Stockade, Magtheridon' Lair and all battlegrounds (Telchar)
- changed Mailbox Keys to Postbox Keys in Stratholme (Telchar)
- added Zaelot to the names of Zath and Lor'Khan in ZG (Telchar)
- changed Necro Wing to Plague Wing in Naxxramas (Telchar)
- removed Prince from Kael'Thas Sunstriders name (Telchar)
- many changes to the Zul'Aman map (Celellach)
- many changes to the Blackwing Lair map (Nihlo)
- many changes to the Shadowfang Keep map (Celellach)
- added Razorfen Spearhide to Razorfen Kraul (Celellach)
- new map in outdoor raids: Skettis (Celellach, Nifl)
- revamped Alterac Valley North and South maps (Celellach)
- added Base Camp to Grom'Gol flightpoint (Telchar)
- added Harrison Jones to ZA map (Kiria)
- added angle-bracket titles to some mobs (more coming)
- fixed a number of typos
- remove attunement quest required for Karazhan, Hyjal Summit and Black Temple
- revamped the auto-select feature to make use of SubZone data
- Titan Panel support fix and some updates


v1.10.3 (Nov. 30, 2007)
-----------------------
- the Atlas source is now hosted at Google Code
- updated TOC number to 20300 for the 2.3 patch
- new Zul'Aman map (Nifl, Celellach)
- new CoT entrance map (Nifl, Celellach)
- new SM entrance map (Nifl, Celellach)
- revamped the background artwork on the FP and DL maps
- updated the FP maps with the new flight points/paths
- updated the DL maps with the new dungeon (Zul'Aman)
- renumbered the FP and DL maps for consistency
- new Karazhan entrance map (Mottie)
- revamped the UBRS map (Nifl, Celellach)
- revamped the LBRS map (Nifl, Celellach)
- revamped the Karazhan map and split into two (Mottie)
- revamped the DM entrance map (Nifl, Telchar)
- combined BT full and middle maps into one BT start map (Telchar)
- added a new option for the grouping of instance maps
- fixed an auto-select issue with the new grouping code
- deDE, frFR, and esES localisation files are now encoded in UTF-8 (Maqjav)
- updated instance level ranges with the patch 2.3 changes
- alphabetized some multi-part maps so they appear in the correct order
- fixed a slight problem with Atlas remembering the last map you were looking at between sessions
- Atlas will only remember the last map between sessions if it's one of the built-in ones
- added specific zone names to the 'dragons of nightmare' areas (Celellach)
- added named mobs that are roaming at the 'dragons of nightmare' spots (Celellach)
- added Coren Direbrew (Brewfest) to BRD (Celellach)
- added class-info to the mobs of the Kael'thas Sunstrider encounter (Telchar)
- added Sah'rhee to RFD (Celellach)
- changed the organization of DM arena mobs (Kiria)
- added Elder Mistwalker to the DM arena (Celellach)
- tagged DM arena mobs as random (Kiria)
- added Library marker to the DM North map (Celellach)
- added Shrine of Gelihast, Morridune and Altar of the Deeps to BFD
- changed Fathom Core to Fathom Stone in BFD
- retooled the mob locations in SM Graveyard a bit (Celellach)
- added The Headless Horseman to SM Graveyard (Celellach)
- added posible spawn points for Burning Felguard in LBRS (Celellach)
- added Elder Stonefort to LBRS (Celellach)
- put Doomrigger's Clasp in UBRS in the right place (Celellach)
- changed the organization of Vem encounter in AQ40 (Celellach)
- added Lord Kri and Princess Yauj to Vem encounter in AQ40 (Celellach)
- added Vek'lor and Vek'nilash to Twin Emperors in AQ40 (Celellach)
- added the entrance and a few mobs to Naxx (Celellach)
- added specific mobs and their classes to Illidari Council in BT (Telchar)
- added a number of mobs to Black Temple (Arzach)
- renumbered Black Temple maps for consistency (Thandrenn)
- added event names to CoT maps (Celellach)
- added Ambassador Pax'ivi to Mana-Tombs (DiabloHu)
- added Cryo-Engineer Sha'heen to Mana-Tombs (Celellach)
- added D'ore to Auchenai Crypts (Celellach)
- added Lakka to Sethekk Halls (Celellach)
- added Shattered Hand Executioner to Shattered Halls (lichee)
- added a number of mobs to The Shattered Halls (Celellach)
- removed Blackened Urn key from Kara end (Celellach)
- added Seer Olum to Serpentshrine Cavern (Celellach)
- added Indormi and Tydormu to Hyjal Summit; locations still needed (Celellach)
- renumbered Serpentshrine Cavern map for accuracy (Nihlo)
- fixed some indentation issues
- this was a huge update, so one or two things might have been missed here
- current French translation (Kiria)
- current Spanish translation (maqjav)
- current Simplified Chinese translation (DiabloHu)
- current Traditional Chinese translation (arith)
- current German translation (Telchar)


v1.10.2 (Sep. 28, 2007)
-----------------------
- updated TOC number to 20200 for the 2.2 patch


v1.10.1 (Sep. 05, 2007)
-----------------------
- added individual instance names to Outland DL map (Telchar)
- changed/fixed the CoT instance names in the West DL map (Telchar)
- added class types to Maulgar's adds in Gruul's Lair (Lothaer, Yegg)
- changed/fixed typo "Ferelas" to "Feralas" in FP maps (Celellach)
- changed/fixed Moonglade FPs "Shrine of Remulos" to "Nighthaven" (Celellach)
- added/clarified the additional Moonglade flight points (Celellach)
- added a few mobs to the Wailing Caverns entrance map (Celellach)
- changed plugin name "Entrances" to "Instance Entrances"
- changed/fixed Naxx location to "Plaguewood, Eastern Plaguelands" (Celellach)
- changed layout of CoT instances in Dungeon Locs plugin (Celellach)
- added numerical displays to all the options pane's sliders
- the Reset Position button now resets all the sliders too!
- new Dire Maul entrance map including arena mobs (Kiria)
- added troll miniboss names to ST map (Kiria)
- added High Priestess of Thaurissan to BRD (Kiria)
- added Oggleflint to RFC (Kiria)
- added Zelemar the Wrathful the RFC (Kiria)
- added Dire Pool to DM entrance map (Celellach)


v1.10.0 (Aug. 20, 2007)
-----------------------
- fixed the Forest Song, Ashenvale flight point
- renumbered the Alliance Kalimdor flight path map
- translated into zhCN / Simplified Chinese (DiabloHu)
- translated into zhTW / Traditional Chinese (arith)
- translated into frFR / French (Kiria, TrAsHeR, Wysiwyg77)
- translated into deDE / German (Nihlo, Thurraz, Celellach)
- translated into esES / Spanish (maqjav)
- koKR / Korean translation still needed


v1.10.0pre5 (Aug. 15, 2007)
-----------------------
- added class tags to Moroes adds in Karazhan
- added Sneed's Shredder to The Deadmines
- renumbered The Arcatraz for better flow
- added Stormwind to Thorium Point flight path
- added Grom'gol to Flame Crest flight path
- added Ratchet to Gadgetzan flight path
- added Ratchet to Astranaar flight path
- added Ratchet to Brackenwall Village flight path
- added Brackenwall Village to Camp Tauraj flight path
- added Brackenwall Village to Freewind Post flight path
- added Thunderbluff to Zoram'gar flight path
- added Evergrove to Toshley's Station flight path
- added Honor Hold to Shattrath flight path
- added Emerald Sanctuary, Felwood flight point
- added Forest Song, Ashenvale flight point
- added Emerald Sanctuary to Talonbranch Glade flight path
- added Emerald Sanctuary to Bloodvenom Post flight path
- added Forest Song to Astranaar flight path
- renumbered Horde Kalimdor flight path map
- renumbered Alliance Kalimdor flight path map
- renumbered Horde Outland flight path map
- renumbered Alliance Outland flight path map
- added Blackwind Landing, Terokkar Forest flight point
- added Skyguard Outpost, Blade's Edge flight point
- added Blackwind Landing to Skyguard Outpost flight path
- thanks to Celellach for providing so much data!


v1.10.0pre4 (Aug. 10, 2007)
-----------------------
- removed optional tags in Kara (Nalumis)
- changed cot3 name back to Hyjal Summit (Celellach)
- re-lettered Black Temple maps (Celellach)
- added acronym for Blackrock Mountain (Nihlo)
- added Vorrel Sengutz to SM Graveyard
- added Kazkaz the Unholy to ST entrance
- added Zekkis to ST entrance
- added Veyzhak the Cannibal to ST entrance
- added Hammertoe Grez to Uld entrance
- added Magregan Deepshadow to Uld entrance
- added Tablet of Ryun'Eh to Uld entrance
- added Krom Stoutarm's Chest to Uld entrance
- added Garrett's Family Chest to Uld entrance
- added Digmaster Shovelphlange to Uld entrance
- added Conspicuous Urn to Uldaman
- added Tablet of Will to Uldaman
- added Shadowforge Cache to Uldaman
- added Blackened Urn to Kara as key
- tagged Nightbane in Kara with summon
- added The Eye of Haramad to Mana-Tombs as key
- tagged Yor in Mana-Tombs with summon and heroic
- added Essence-Infused Moonstone to Sethekk as key
- tagged Anzu in Sethekk as heroic (fixed summon tag)
- fixed Blood Guard Porung's heroic tag in HFC:SH
- added Mortog Steamhead to CFR entrance
- changed player limit for CFR entrance to 5/25


v1.10.0pre3 (Aug. 06, 2007)
-----------------------
- finally added data to Battle for Mount Hyjal
- modified Hyjal map; shaded the top half
- fixed Lothos Riftwaker's name in Blackrock Mountain
- fixed the Blackrock Spire names in Blackrock Mountain
- added numerical data for Black Temple (Full)
- added attunement requirement to Ony and Kara
- moved all attunement requirements to be listed first
- updated all Black Temple maps considerably
- once again, special thanks to Celellach
- fixed "Slim" in Auch entrance (Nihlo)


v1.10.0pre2 (Aug. 06, 2007)
-----------------------
- new map: Black Temple (Full)
- updated Maraudon entrance map
- updated Deadmines entrance map
- updated Blackrock Mountain entrance map
- updated Gnomeregan entrance map
- updated Auchindoin entrance map
- added attunement requirment to CoT and BT maps
- added key and rep to BT maps
- added Illidan Stormrage to Black Temple (Top)
- added underwater entrance to CFR entrance map
- changed all entrance markers to letters
- thanks to Celellach for the majority of the notes


v1.10.0pre (Aug. 05, 2007)
-----------------------
- new maps: Black Temple (three levels)
- new plugin containing entrance maps
- changed Durnholde Keep to Old Hillsbrad Foothills
- hyphenated Mana-Tombs
- added several mobs to the DM library
- added Yor to Mana-Tombs
- added Anzu to Sethekk Halls
- added Overcharged Manacell to The Mechanar
- added several mobs to Kara
- added several mobs to Gruul's Lair
- added Skar'this the Heretic to The Slave Pens
- added Seer Udalo to The Arcatraz
- added several mobs to The Eye


v1.9.1 (May 23, 2007)
-----------------------
- updated TOC number to 20100 for the 2.1 patch
- removed Interface/AddOns structure from archive
- fixed two swapped mobs in The Eye (avatarshokpin)
- minor updates to French (frFR) translation


v1.9 (May 21, 2007)
-----------------------
- made several database changes and additions
- archive now contains Interface/AddOns structure
- updated level ranges (needs some more work)
- completely rewrote and updated the readme file
- contains translations for enUS, deDE, frFR, koKR, zhCN, zhTW
- still needs readme and GPL files for koKR (Korean)


v1.9RC2 (Apr. 16, 2007)
-----------------------
- split Scarlet Monastery into four different maps
- made many database changes, additions, and corrections
- added auto-select code for Outland instances (Drahcir)
- renumbered LBRS and Stratholme maps (Celellach)


v1.9RC1 (Mar. 23, 2007)
-----------------------
- new maps: The Eye, Doom Lord Kazzak, Doomwalker
- new maps: Outland dungeon locations and flight paths
- changed Kazzak encounter to Highlord Kruul
- added key listings to many maps (thanks Celellach)
- added repulation listings to many maps (Celellach and Hegarol)
- many, many database additions and fixes (thanks everyone)
- changed Addon List formatting and coloring of plugins
- tweaked appearance of certain maps for consistancy
- probably more stuff that I'm forgetting right now


v1.9b1 (Feb. 22, 2007)
-----------------------
- many new Burning Crusade maps
- many database additions and fixes
- cleaned up options panel


v1.8.6 (Feb. 01, 2007)
-----------------------
- updated TOC number to 20003
- disabled "Replace World Map" for taint issues
- various translation updates across the board
- search function improvement (Keith)


v1.8.6b5
-----------------------
- added a search feature (thanks Keith G.)
- made visual changes to the options panel
- some minor window texture improvements


v1.8.6b4
-----------------------
- the legend is now fully scrollable
- maps can contain more than 27 entries
- improved the frame's artwork a bit
- switched all the button templates
- updated German (deDE) translation (Dynaletik)
- updated Spanish (esES) translation (bornay)


v1.8.6b3
-----------------------
- split off non-instance maps as Atlas plugins
- install or enable any of them or none of them


v1.8.6b2
-----------------------
- version number is now only stored in the TOC
- updated German (deDE) translation (Dynaletik)
- added a simple code interface for plugins!
- comes with the sample plugin AtlasPlugin


v1.8.6b
-----------------------
- integrated Titan Panel support
- truly massive internal restructuring


v1.8.5 (Dec. 02, 2006)
-----------------------
- wide release in anticipation of WoW v2 patch
- fixed options frame dragging compatibility
- fixed Spanish (esES) localization file
- Atlas is now released under the GPL


v1.8.5b3
-----------------------
- no more AtlasLoader; no more load-on-demand (goodbye)
- scrapped v1.8.5b2 and reverted to v1.8.5b base
- the "Reset Position" button works again
- all other b2 features should be a-okay
- settings are now saved per-character
- removed some unnecessary myAddOns code (as of b2)
- new default minimap button position (as of b2)
- lots of new metadata in the TOC (as of b2)


v1.8.5b2
-----------------------
- completely localized (arith, Sirlefou, Dynaletik, bornay)
- added AtlasLoader which loads Atlas on first use (whoa!)
- changed minimap button to use crisper built-in art (snazzy!)
- auto-select should be hackishly working again (whoops!)
- frame position is stored differently due to load on demand
- renamed all the localization files (Atlas-xxXX.lua)
- created some folders for organization


v1.8.5b
-----------------------
- updated TOC number to 20000 for TBC (WoW 2.0)
- added a bunch of new HC and CFR maps (Nifl)
- instance maps are now divided into categories
- new option to scale the Atlas window
- new option to set the radius of the minimap button
- new option to clamp the Atlas window
- the options panel is now draggable and clamped
- the options sliders now display their min/max values
- code compatibility update for BC (Daviesh)
- minimap icon has new colors to diff from blizz's world map button
- higher quality minimap icon, with new default position
- changed naming scheme of localization files


v1.8.4 (Oct. 21, 2006)
-----------------------
- since the beta NDA has been lifted, the HC maps are back; see:
- http://forums.worldofwarcraft.com/thread.html?topicId=32338600
- changed Spanish (esES) localization to be automatic
- NOTE: ***Atlas needs a full Spanish translation!***
- updated German (deDE) text (Dynaletik)
- updated Korean (koKR) text (k2hyun)


v1.8.3 (Oct. 11, 2006)
-----------------------
- removed HC maps as per Blizzard's wishes, see:
- http://forums.worldofwarcraft.com/thread.html?topicId=32338600
- updated French (frFR) text (Pherus)
- updated German (deDE) text (Dynaletik)
- updated Chinese Simplified (zhCN) text and readme (DiabloHu)
- updated Chinese Traditional (zhTW) text (arith)
- updated the backgrounds of the two HC maps (Nifl)
- changed AQ20 damage from physical to nature (Pherus)
- added Ony as Onyxia short version (Pherus)
- added Onyxia as fire damage (Pherus)


v1.8.2 (Oct. 07, 2006)
-----------------------
- new map: Hellfire Citadel, The Blood Furnaces (Patrick M.)
- new map: Hellfire Citadel, The Shatterd Halls (Patrick M.)
- updated Chinese Simplified (zhCN) text and readme (DiabloHu)
- updated Chinese Traditional (zhTW) text (arith)
- updated Korean (koKR) text (k2hyun)
- improved the ToggleWorldMap replacement (Daphne P.)
- possible fix for a rare World Map scaling bug
- added damage type to ZG, MC, BWL, AQ20, AQ40, Nax (Pauper)
- added druid-only flight paths


v1.8.1 (Aug. 22, 2006)
-----------------------
- updated TOC number to 11200 for the 1.12 patch
- fixed a serious World Map error caused by 1.12
- fixed a bug in the French translation (KKram)


v1.8 (Aug. 17, 2006)
-----------------------
- new map category: Raid Encounters
- new maps: Azuregos, FourDragons, and Kazzak
- added Death Knight Darkreaver to Scholo (Aludian)
- added Lord Hel'nurath to DM West (Aludian)
- added Master Elemental Shaper Krixix to BWL (Hegarol)
- changed the location of Lord Roccor in BRD (Medion)
- changed "n/a" to "---" for localization reasons
- fixed BRD data so everything shows up


v1.7.5 (June 30, 2006)
-----------------------
- updated Chinese Simplified (zhCN) text and readme (DiabloHu)
- updated Chinese Traditional (zhTW) text (arith, Suzuna)
- updated French (frFR) text (Pherus)
- updated German (deDE) text (Nihlo, Dynaletik)
- updated Korean (koKR) text (k2hyun)
- added some localizations to the TOC file
- removed the separate Spanish TOC file


v1.7.4 (June 20, 2006)
-----------------------
- updated TOC number to 11100 for the 1.11 patch
- added the new flight hubs and paths
- updated Catalan text (Lehn)
- updated Chinese Traditional (zhTW) text (Suzuna)
- updated Chinese Simplified (zhCN) text (DiabloHu)
- added Chinese Simplified (zhCN) Readme (DiabloHu)
- fixed some errors on the flight path maps (arith)
- fixed some errors on the UBRS legend (Aludian)
- added Shadowpriest Sezz'ziz to ZF (Aludian)
- added Solakar Flamewreath to UBRS (Hegarol)
- added Dungeon Set Quest Bosses (Niflheim)
- added EarthFeatureFrame as optional dep (Ryan S.)


v1.7.3 (June 6, 2006)
-----------------------
- updated Chinese Simplified (zhCN) text (DiabloHu)
- updated Chinese Traditional (zhTW) text (arith)
- updated French (frFR) text (Pherus)
- updated German (deDE) text (Nihlo)
- updated Korean (koKR) text (k2hyun)
- updated Spanish text (festor)
- added Spanish Readme (festor)
- added Spanish TOC (festor)
- fixed typo in Kel'Thuzad's name (Aludian)
- fixed position of Magister Kalendris (Dynaletik)
- fixed numbers for Dungeon Locations East (Morfin)
- fixed numbers for Dungeon Locations West (Mox)
- added some acronyms and abbreviations (thegabbert)


v1.7.2 (May 29, 2006)
-----------------------
- new map category: Dungeon Locations
- new maps: Dungeon Locations (East and West)
- tweaked Uldaman, Sunken Temple, and ZG maps
- updated Chinese Simplified (zhCN) text (DiabloHu)
- updated Chinese Traditional (zhTW) text (arith)
- updated German (deDE) text (Nihlo)
- updated French (frFR) text (Pherus)
- widened the Reset Position button
- Rajaxx is listed first in AQ20 (Nihlo)
- AQ20 might work with auto-select now (Cold)
- bugfix for the right-click feature (Cold)


v1.7.1 (May 24, 2006)
-----------------------
- quick fix for the PURP error with non-En clients


v1.7 (May 24, 2006)
-----------------------
- new map: Naxxramas (eDark, Cryect)
- updated the resolution of many maps (Niflheim)
- added Catalan text, see above for use (Lehn)
- added Dutch text, see above for use (JungZandvliet)
- updated German (deDE) text (Nihlo, anon)
- updated Chinese Traditional (zhTW) text (arith)
- updated Korean (koKR) text (Next96)
- localized Atlas_GetFixedZoneText (DocVanGogh)
- fixed a typo in Battleguard Sartura's name (Iskim, Michael R.)
- added a new option: Display Acronyms
- changed the way Atlas inits (Grayhoof)
- changed the way Atlas saves its settings (Grayhoof)
- escape once again closes the Atlas window, sorry about that
- TitanAtlas, MapAtlas, and AtlasLoot will be (re)appearing soon!


v1.6.2 (April 8, 2006)
-----------------------
- updated TOC number to 11000 for the 1.10 patch
- removed Titan Panel support (TitanAtlas) for the time being
- hopefully fixed the awful load-time errors (send me feedback)
- fixed a typo in the name of Captain Dreenn in AQ20 (Manias, baloor)
- updated Chinese Simplified (zhCN) text (DiabloHu)
- updated Chinese Traditional (zhTW) text (warrenchen, arith)
- updated French (frFR) text (Pherus)
- updated German (deDE) text (Nihlo)
- fixed the colors of some NPCs in Alterac Valley (RommelESP)
- fixed the location of Mulverick in Alterac Valley (RommelESP)
- Auto-Select might start working in Ahn'Qiraj (Gnor)
- fixed the names of Drenn, Qeez, Xurrem, and Tuubid (anon)
- player limits updated to reflect 1.10 changes (Faithbleed)
- changed Stormspike to Stormpike (Dazzle)
- added flight: Ironforge and Light's Hope Chapel
- added flight: Stonetalon Peak and Astranaar
- added flight: Talendris Point and Everlook
- added flight: Theramore and Talendris Point
- added flight: Sepulcher and Tarren Mill
- fixed "Kraal de Tranchebauge" in frFR text (Sparrows)


v1.6.1 (March 1, 2006)
-----------------------
- fixed a clarity problem with BWL (placebo)
- fixed a typo in the name of Arygos in AQ40 (Foogray)
- fixed some location errors in AQ40 (anon, Manias)
- fixed the location of a few mobs in AQ20 (anon, Pater)
- added a number of missing mobs to AQ20 (anon, Jan S.)
- added data to both AV maps (RommelESP)
- added an flight from Morgan's Vigil to Stormwind (Harm H.)
- marked Ghaz'Ranka in ZG as optional (placebo)
- moved Atlas_MapTypes into localization file (Pherus)
- changed "Flight Point Maps" to "Flight Path Maps"
- updated French (frFR) text (Pherus)


v1.6
-----------------------
- slightly expanded the Atlas frame
- implemented a category system for maps
- added a button to reset the frame's position
- new map: Alterac Valley (North) (Niflheim)
- new map: Alterac Valley (South) (Niflheim)
- new map: FP (Flight Points) Alliance (East)
- new map: FP (Flight Points) Alliance (West)
- new map: FP (Flight Points) Horde (East)
- new map: FP (Flight Points) Horde (West)
- added location data to AQ20 (Jan S., Pater, Zanchez)
- fixed AQ20 orientation (thanks everyone)
- marked certain bosses in ZG as optional (Aludian)
- added Dustwraith (Rare) to ZF (KarWing)
- removed a nonexistent pathway in BWL (Ferahgus)
- updated French (frFR) text (Pherus)
- updated German (deDE) text (GermanWraith)
- updated Chinese Simplified (zhCN) text (DiabloHu, Slaytanic)
- changed the way Atlas initializes (Shamino)
- fully commented Atlas.lua (more to come)
- Auto Select, Replace World Map only work in instances
- added Right-Click setting to TitanAtlas menu


v1.5
-----------------------
- new map: Warsong Gulch (Niflheim)
- new map: Arathi Basin (Niflheim)
- new map: The Ruins of Ahn'Qiraj (Niflheim)
- added Korean (koKR) text (hicle, Mars)
- added Spanish text, see Readme for usage (festor)
- updated Chinese Simplified (zhCN) text (Xiang Lei)
- updated French (frFR) text (Pherus)
- updated German (deDE) text (Chinkuwaila, ninjamask)
- added data to The Temple of Ahn'Qiraj map (Ragowit, Zanchez)
- added Sandarr Dunereaver (Rare) to Zul'Farrak (DiabloHu)
- changed the location of Jed Runewatcher in UBRS (Aludian)
- graphical updates for BRD, MC, Stockades, RFK, RFD, UBRS (wowguru.com)
- the Replace World Map feature is now turned off by default
- fixed a bug that would prevent the World Map from closing
- chaged the way Atlas checks to see if you're in an instance
- to decrease download size all maps are now 16 bit instead of 32 bit
- changed Muddy Churning Waters in Zul'Gurub from (B) to (1')
- added an Atlas watermark to the corner of all maps
- changed "The Stockades" to "The Stockade" (tyroney)
- added Right-Click for World Map feature (tyroney)
- added Interface/Addons directory structure to the zip file


v1.4.1 (January 14, 2006)
-------------------------
- updated Chinese Simplified (zhCN) text (DiabloHu)
- updated German (deDE) text (EarMaster)
- fixed an error-causing bug in non-Enlish clients


v1.4 (January 13, 2006)
-------------------------
- new feature: Replace World Map
- new map: The Temple of Ahn'Qiraj (wowguru.com)
- changed the minimap button's tooltip to be more user friendly (Yatlas)
- the position of the minimap button can be changed with the mouse (Yatlas)


v1.3.3 (January 11, 2006)
-------------------------
- updated Chinese Simplified (zhCN) text (Slaytanic)
- updated German (deDE) text (Maischter)


v1.3.2 (January 9, 2006)
------------------------
- updated TOC number to 10900 for the 1.9 patch
- added Spirestone Battle Lord (Rare) to LBRS (Bhaerau)
- fixed a number of Stratholme spawns (Ville K.)
- fixed Lorgus Jett in Blackfathom Deeps (Ville K. and Greymalkin)
- updated Chinese Simplified (zhCN) localization (DiabloHu)
- updated French (frFR) localization (Pherus)
- updated German (deDE) localization (anavolver, Jan S.)
- hopefully fixed some auto-select problems (jmu)
- fixed a bug with the sanitize function (Pherus)
- changed minimum transparency from zero to 0.25


v1.3.1 (December 6, 2005)
-------------------------
- updated French (frFR) localization (Pherus)
- added Deviate Faerie Dragon to Wailing Caverns (Searing)
- added Spirestone Butcher to Lower Blackrock Spire (Gauss)


v1.3
-------------------------
- updated TOC number to 1800
- added Chinese Traditional (zhTW) localization (ama)
- updated level ranges for all instances based on meeting stones (David C.)
- fixed a minor event handling bug (PiraMod)
- added the Library to Dire Maul North and West maps (Pherus)
- updated French (frFR) localization (Pherus)
- added more fishing spots to Zul'Gurub map (Jan)
- added automatic drop-down list sorting (Alexander M.)
- updated Chinese Simplified (zhCN) localization (DiabloHu)
- added Zul'Gurub boss aspects (Matthew M.)
- added ModWatcher support
- fixed a drop-down list bug
- centralized LevelRange and PlayerLimit values


v1.2
-------------------------
- added Titan Panel support via TitanAtlas addon (Adsertor)
- core addon code tweaks and improvements (Adsertor)
- updated MyAddOns support for both Atlas and TitanAtlas
- Atlas now remembers the last map you were looking at


v1.1.3
-------------------------
- added Chinese localization (DiabloHu)


v1.1.2
-------------------------
- added French localization (Sparrows)


v1.1.1
-------------------------
- added German localization (Dermott, Katastrophen)
- updated rare spawns in Scarlet Monastery (Geisterkarle)
- removed (Rare) status from The Unforgiven in Stratholme (tanniss)
- Auto Select is now enabled by default
- fixed the AutoSelect variable bug


v1.1
-------------------------
- updated TOC number to 1700
- new maps: Blackwing Lair (wowguru.com) and Zul'Gurub (Jan)
- re-added the Auto Select feature as an option
- created a Readme.txt file to include with releases
- added Tsu'Zee (Rare) to Dire Maul West (Quiche)
- added The Unforgiven (Rare) to Stratholme (Aludian)
- added Earthcaller Halmgar (Rare) to Razorfen Kraul (Luke)
- added Fifth and Sixth Mosh'aru Tablets to Lower Blackrock Spire (Billy)
- added High Interrogator Gerstahn to Blackrock Depths (Yukkon)
- added Blood Steward of Kirtonos to Scholomance (Ernesto)
- named each Postbox in Stratholme (Thomas)
- added Bannok Grimaxe (Rare) to Lower Blackrock Spire (Galon)
- added Deathsworn Captain (Rare) to Shadowfang Keep (Harri)
- added Alchemy Lab to Scholomance (Gere)
- added Commander Gor'shak to Blackrock Depths (Jonas)
- each item in the legend now has its own line


v1.0.1
-------------------------
- updated TOC number to 1600 for 1.6 patch
- added French localization! (thanks Sasmira)
- marked Ragglesnout in RFD as rare (thanks Joshua B.)
- fixed the location of Marshal Windsor in BRD (thanks Stefan and Fegnus)
- reverted to the old default minimap button position, for all you trackers


v1.0
-------------------------
- major layout changes!
- new maps: Shadowfang Keep and Blackrock Spire (Lower)
- all instance data is now stored as text
- full localization support (other languages coming soon)
- CTMod support added and Cosmos/myAddOns support improved
- options frame layout tweaked a little bit
- minimap button position code improved
- minimap button default position changed
- saved variable name changed to AtlasOptions
- reordered drop down menu to ignore "The"
- the frame can longer be right-click-dragged
- changed the player limit for UBRS from 10 to 15 (thanks Scynn, Vilkku, and many others)
- fixed the location of Kharan Mighthammer in BRD (thanks Mark)
- fixed the location of Old Serra'kis in BFD (thanks Aludian)
- fixed the location of Lorgus Jett in BFD (thanks Slooter and Komal)
- added Marshal Windsor to BRD (thanks Mark)
- made a number of changes to the Strath map (thanks Chris)
- added Father Flame to UBRS, duplicated marking for both map sections (thanks SageoftheTimes)
- added the names of the deeds in Scholomance (thanks Aludian)
- added Zul'Farrak Dead Hero to ZF (thanks Dor)
- added Magister Kalendris to DM West (thanks Ziiv, Buio, and Joshua B.)
- added a secret chest and the lever that opens it to Scholomance (thanks Aludian)
- removed the exit from Strath


v0.9.5
-------------------------
- updated TOC number to 1500 for the 1.5 patch
- new maps: Onyxia's Lair and Blackrock Spire (Upper)
- added player limit to all maps
- added location of instance to all maps
- added Skul to Stratholme map (thanks Miya)
- added the various locations Targorr the Dread can spawn in The Stockade (thanks Deathmatcher)
- moved Lorgus Jett in Blackfathom Deeps; is he in the right place now? (need feedback)
- removed statue activation order from Temple map (due to a number of requests)
- have many of the mobs in Stratholme moved? looking for solid and detailed information


v0.9.4
-------------------------
- new maps: The Temple of Atal'Hakkar and Dire Maul (North, East and West)
- special thanks goes out to Nogame at worldofwarcraft.gameamp.com for the blank maps
- added Lorgus Jett, Baron Aquanis and Fathom Core to Blackfathom Deeps (thanks Cadex)
- added Azshir the Sleepless to Scarlet Monastery (thanks John K.)
- added Fallen Champion and Ironspine to Scarlet Monastery (thanks Shape)
- added Bruegal Ironknuckle to The Stockade (thanks DragonBlade)
- added Stonespine to Stratholme (thanks Shape)
- moved Magistrate Barthilas to the correct location (thanks Shape)
- made a few cosmetic changes to the Scholomance map
- changed the framestrata of the minimap button to low (thanks Zilas)
- added a small credit to the titlebar


v0.9.3
-------------------------
- added Zerillis to Zul'Farrak map (thanks JennerCobrari)
- fixed a typo in the Scarlet Monastery map (thanks halfhand and nonlinear)
- marked Hearthsinger Forresten in Stratholme as rare (thanks DrimIT)


v0.9.2
-------------------------
- new maps: Scholomance, Stratholme and The Stockade
- Atlas is 28% larger! (all maps are higher resolution)
- added Meshlok the Harvester to Maraudon map (thanks Aludian)
- added version number to the Atlas window
- added an options button to the Atlas window
- added a key binding to toggle the options window
- updated all level ranges from official wow website
- changed the Atlas icon to something better
- the minimap button now collapses with the minimap
- options are now saved under a single variable


v0.9.1
-------------------------
- updated Gnomeregan map with a new mob and marked one as rare
- updated myAddOns support for the options frame
- fixed problem with saving the status of the minimap button
- fixed problem with the frame level of the minimap button


v0.9
-------------------------
- added Obsidian Sentinel to Uldaman map (thanks Bhaerau)
- new options window: type '/atlas options' to bring it up
- new minimap button, moveable and hideable (thanks CTMod code)
- transparency control slider


v0.8.2
-------------------------
- added Lorgalis Manuscript to Blackfathom Deeps map (thanks Connall)
- lock button added next to close button, frame can only be dragged when unlocked
- lock status is saved between sessions
- frame position no longer resets all the time
- frame position is unaffected by other UIPanels


v0.8.1
-------------------------
- added Ragglesnout to Razorfen Downs map (thanks beffe)
- Escape once again closes the window (clearly important)
- still draggable, but position isn't saved (a temp solution)


v0.8
-------------------------
- new map: The Deadmines (thanks Pycelle)
- updated level range for all maps
- due to popular demand, Atlas is once again draggable!
- Escape no longer closes frame, use hotkey instead
- updated myAddOns support


v0.7
-------------------------
- new maps: Razorfen Kraul, Razorfen Downs and Molten Core (thanks Conquest/Sudo)
- added punch card locs to Gnomeregan map
- added missing credit to SM map


v0.6
-------------------------
- new maps: Gnomeregan and Zul'farrak
- removed loaded message (spam) upon entering the world
- added level information to all maps
- minor tweaks and spelling fixes


v0.5
-------------------------
- new map: Wailing Caverns (thank you Grimm@CC)
- fixed issue with not being able to open other panels while Atlas was open, as a side effect dragging is disabled (feedback welcome)
- Atlas will now automatically open to the map of the instance you're in (needs feedback and testing)
- added myAddOns support
- added Cosmos support


v0.4
-------------------------
- new map: Scarlet Monastery
- pressing escape now closes frame
- fixed version numbering


v0.3
-------------------------
- new maps: Maraudon and Uldaman
- added hotkey binding to toggle frame


v0.2
-------------------------
- unreleased


v0.1
-------------------------
- unreleased
