﻿# Changelog

## 9.10.0 - July 22, 2025
### Added
- Added Classic Timewalking rewards
### Fixed
- Fixed droprate placeholder showing up in tooltip for some MoP content

## 9.9.0 - July 15, 2025
### Added
- Added Legion Timewalking rewards, including the brand-new cosmetic items
- Updated Cataclysm Timewalking rewards
- Added AtlasLoot button to the Addon Compartment
### Fixed
- Fixed name of the first boss in Battle of Dazar'alor
- Fixed tooltip/model/etc of the bosses in Battle of Dazar'alor so that they vary by faction as needed
- Fixed the two Jadefire Masters items that vary by faction

## 9.8.1 - July 8, 2025
### Added
- Added Chrono Corsair to Collections
### Fixed
- Fixed error on bonus rolls
- Updated Timely Buzzbee acquisition method in Collections

## 9.8.0 - July 8, 2025
### Added
- Added WoD Timewalking rewards, including the brand-new cosmetic items
- Added artifact relic item overlay on Legion artifact relics

## 9.7.0 - July 1, 2025
### Added
- Added Legacy of Scholomance instance to the Dragonflight module
- Added July Trading Post items to Collections
- Updated TBC Timewalking rewards
- Updated WOTLK Timewalking rewards
- Updated Lunar Festival rewards
### Fixed
- Fixed Scholomance sets saying they're no longer available when they're available in Legacy of Scholomance
- Fixed error when clicking on the Atlas button with Atlas (fork) v3.7.0

## 9.6.0 - June 24, 2025
### Added
- Updated MoP Timewalking rewards
- Added Lettuce pet to Collections
### Fixed
- Fixed the extra price text always being red when the cost is certain items

## 9.5.0 - June 21, 2025
### Added
- Added remaining BFA Timewalking rewards and moved items that are common to all timewalking vendors to a new section
- Updated Midsummer Fire Festival items
- Added Azerite item overlay on Azerite items
- Added conduit item overlay on Shadowlands item conduits
- Added Redeployment Module to Toys in Collections module
- Added OC91 Chariot to Mounts in Collections module
- Added resonance crystal costs to Mean-Ball Ball Bag and Tyrannotort's Treat

## 9.4.0 - June 17, 2025
### Added
- Added Lorewalking rewards to Toy Collection
- Added BFA Timewalking rewards (cosmetic items to come later)
- Added the ability to list an achievement as the method of acquisition on the secondary line. Mostly useful for mounts and pets where the secondary button is already used. Necessary data is only on TWW and DF mounts, pets and toys in Collections right now, but will get added elsewhere in the future.
### Changed
- Update TOC to 11.1.7
- Remove LibBabble-ItemSet and replace with C_Item.GetItemSetInfo
- Remove LibBabble-Boss and replace with other translations as needed
### Fixed
- Fixed Guardian Vorquin getting overwritten by Otterworldly Ottuk Carrier in Dragonflight mounts in Collections

## 9.3.0 - June 11, 2025
### Added
- Added cosmetic item border/overlay on cosmetic items
- Added BFA, Shadowlands and Dragonflight legendaries to Collections
- Added resonance crystal cost to Winner's Podium
- Updated Love is in the Air items
- Added Heartseeker Mana Ray to Collections
### Fixed
- Fixed item tooltip showing up on mount secondary buttons, sometimes on top of the mount tooltip

## 9.2.0 - June 5, 2025
### Added
- Added new pet, mount and toys from Dastardly Duos to Collections
### Fixed
- Fix lua error when viewing items in Legion instances
- Item difficulty bonuses only get added to weapons, armor, tier tokens and gems now (this means that items like mounts, pets and recipes are seen as the same across all difficulties for Favorites functionality)
- Fixed issue where item icons could cause non-item icons to have the wrong color border
- Fixed issue where achievement and pet icons could cause item icons to not have a border

## 9.1.0 - June 1, 2025
### Added
- Added faction-specific icons for TWW factions
- Added new mounts and pets from Revisited Horrific Visions to Collections
- Added returning mounts, pets and toys from the original Horrific Visions to Collections (under TWW because they were never added to AtlasLoot originally)
- Added recipe from Revisited Horrific Visions to Jewelcrafting
- Added Flame's Radiance tabards to both Factions and Tabard Collections
- Added June Trading Post items to Collections
### Changed
- Updated lib Krowi's World Map Buttons
### Fixed
- Fix some recipe items not having their favorite list in the tooltip
- Fix for lua error on items with quest names (known issue: uncached quest names may appear on the wrong item)
- Fixed world map button scale and highlight

## 9.0.1 - May 27, 2025
### Changed
- Added padding to the faction tooltip
### Fixed
- Fix error on boss list frames that scroll (like TBC Factions)
- Used stored faction name for factions you haven't encountered instead of hiding them completely
- Removed Glyph of the Headhunter from Legion Inscription Crafting

## 9.0.0 - May 26, 2025
Welcome to AtlasLoot v9! There are a few major changes to read about below. Due to this, settings have been reset, but the addition of profiles means you only have to change things once.
### Added
- Added the favorites functionality from AtlasLoot Classic. It's been updated to work with item strings (which separates items by raid difficuty, for example)
- The UI has been updated to match the modern Blizzard UI. Nearly everything has been updated, including item icons, lists, dropdowns, scrollbars, buttons and backgrounds
- Settings now use the Ace3 profile system, so you don't have to set up AtlasLoot on every character
- Items will now display with the stats for your current spec
### Changed
- Settings are now in the Blizzard Addon Options menu
### Removed
- Removed the ability to play sound clips from boss encounters. It was broken, didn't cover most encounters and doesn't really fit with AtlasLoot
- Removed some UI customization options that are no longer relevant in the new UI
### Fixed
- Fixed broken tier sets in Collections caused by reordering the list

## 8.28.0 - May 2, 2025
### Added
- Added three mounts and three pets from the May Trading Post to Collections

## 8.27.0 - April 28, 2025
### Added
- Added new Children's Week loot to World Events
- Added Children's Week and Noblegarden loot to Collections

## 8.26.0 - April 26, 2025
### Added
- Added Flame's Radiance to Factions
- Added missing Noblegarden loot to World Events

## 8.25.1 - April 25, 2025
### Changed
- Update TOC to 11.1.5

## 8.25.0 - April 1, 2025
This update marks the addition of the last TWW loot. There's still things to add and update from previous expansions, but I'm going to take a short detour and update the UI and add a new feature or two. It might be a few weeks until the next update, but it will be coming soon!
### Added
- Added TWW tier sets
- Added TWW PvP rewards
- Added Lively Darkmoon Charger
### Changed
- Merged PvP seasons with more than one item in the dropdown to reduce the length of the list
### Fixed
- Removed duplicate secondary button on TWW, Dragonflight and Shadowlands dungeons and raids
- Fixed item level of Legion tier sets

## 8.24.0 - March 24, 2025
### Added
- Added TWW mounts to Collections
- Added raid finder difficulty for Nerub-ar Palace and Liberation of Undermine
- Added Gallagio Loyalty Rewards Club to Factions
- Added secondary buttons to Dragonflight and Shadowlands mounts that were missing one
### Fixed
- Fixed Slumbering Worldsnail Shell price
- Removed a few unobtainable Dragonflight and Shadowlands mounts

## 8.23.0 - March 17, 2025
### Added
- Added TWW toys to Collections
- Added TWW pets to Collections
- Added secondary buttons to Dragonflight pets that were missing one
- A price consisting of items (like Artisan's Acuity) will be colored red or green depending on the amount currently in your inventory
### Fixed
- Fixed the quest name not displaying in the secondary text if there was a quest to obtain an item
- Fixed pet model in secondary tooltip not loading the first time the tooltip opens
- Fixed broken mount in WOTLK Timewalking Collection
- Removed a few unobtainable Dragonflight pets

## 8.22.0 - March 10, 2025
### Added
- Added Darkfuse Solutions faction
- Added TWW Leatherworking recipes
- Added TWW Tailoring recipes
- Added TWW Cooking recipes
### Changed
- Moved BFA and Legion Cooking recipes into the appropriate categories
### Fixed
- Fixed Atlas map button for Operation: Floodgate

## 8.21.0 - March 4, 2025
### Added
- Added The Cartels of Undermine renown track
- Added Bilgewater Cartel, Blackwater Cartel, Steamwheedle Cartel and Venture Company factions
- Added Operation: Floodgate instance loot
- Added Liberation of Undermine instance loot
- Added 22H Slicks to Engineering Devices
- Added Undermine contract and vantus rune to Inscription
- Added Undermine tabards to Collections
### Fixed
- Fixed reputation bars being empty when at max reputation
- Fixed %d showing up in renown reputation bars

## 8.20.0 - February 25, 2025
### Added
- Added TWW Engineering recipes
- Added TWW Inscription recipes
- Added TWW Jewelcrafting recipes
- Added Grimoire of the Shadow Succubus and Grimoire of the Abyssal to Warlock glyphs
### Changed
- Added category and group to TOC
- Update TOC to 11.1.0
### Fixed
- Updated IDs for Tome of the Clear Mind in the Crafting module
- Removed Glyph of Deluge and Glyph of the Observer
- Correctly categorized a few prismatic gems as WOTLK or BC

## 8.19.0 - February 19, 2025
### Added
- Added Dragonflight and The War Within tabards to Collections
- Added TWW Alchemy recipes
- Added TWW Blacksmithing recipes
- Added TWW Enchanting recipes
### Fixed
- Fixed error when clicking on tabs with factions under the Collections module
- Correctly categorized Enchant Shoulder - Boon of the Scavenger as Legion
- Removed Nexus Transformation from Enchanting since it's no longer in the game

## 8.18.0 - February 13, 2025
### Added
- Added the Atlas button to The War Within instance maps provided by Atlas (fork)
### Fixed
- Fixed transmog button not being desaturated on initial load

## 8.17.0 - February 2, 2025
### Added
- Added instance loot for Aberrus and Amirdrassil
- Added faction loot for Loamm Niffen and Dream Wardens

## 8.16.0 - January 27, 2025
### Added
- Added faction loot for Council of Dornogal, The Assembly of the Deeps, Hallowfall Arathi and The Severed Threads
### Fixed
- Fixed mangled Dragonflight prices

## 8.15.1 - January 15, 2025
### Fixed
- Fixed error when clicking on certain expansions under the Factions module

## 8.15.0 - January 12, 2025
### Added
- Added The War Within instance loot
### Fixed
- Fixed error when right clicking on the spec filter button

## 8.14.0 - January 9, 2025
### Added
- Added Shadowlands and Dragonflight modules that were previously separate
- Added the Atlas button to Shadowlands and Dragonflight instance maps provided by Atlas (fork)
- Added icon textures in addon list
### Changed
- Updated libraries
- Update TOC to 11.0.7
### Fixed
- Fixed various deprecations

v8.13.14 (Dec. 26, 2022)
========================
- Change faction items' token to itemID

v8.13.13 (Dec. 26, 2022)
========================
- Fxied renown level's calculation
- Added more Dragonflight faction's purchasing tokens (items / currencies)

v8.13.12 (Dec. 24, 2022)
========================
- Fixed Renown value's calculation / displaying issue
- Added more Dragonflight faction's purchasing tokens (items / currencies)

v8.13.11 (Dec. 15, 2022)
========================
- Added Evoker to class list
- Lib update: CallbackHandler

v8.13.10 (Dec. 12, 2022)
========================
- Updated BFA seasons' items
- Fixed Option window's selected issue

v8.13.09 (Dec. 05, 2022)
========================
- added more currencies
- update Legion tabards and added BFA tabards

v8.13.08 (Dec. 04, 2022)
========================
- Added more mount spells from Shadowlands and Dragonflight
- Added Dragonflight faction tokens / currencies

v8.13.07 (Dec. 03, 2022)
========================
- Added mounts

v8.13.06 (Dec. 03, 2022)
========================
- Migrate WorldMap button to use Krowi_WorldMapButtons
- Remove button on WorldMap's title bar
- Fixed Option window's selected issue
- Fixed Pets, Mounts, and QuickLoot's preview issues

v8.13.05 (Nov. 20, 2022)
========================
- added Shadowlands faction icon
- added faction related extra price type / faction reputation group (thanks serious2)

v8.13.04 (Nov. 20, 2022)
========================
- ToC update to support WoW 10.0.2
- Added faction IDs for Shadowlands and Dragonflight

v8.13.03 (Nov. 14, 2022)
========================
- Set all the libraries to be hard-embedded to resolve CF's auto-packaging problem

v8.13.02 (Nov. 13, 2022)
========================
- WoW 10.0.0 support
- Module enhancement
- ToC update

v8.13.01 (Feb. 13, 2022)
========================
- WoW 9.1.5 support
- BfA Updates:
  - Faction items added: Tortollan Seekers

v8.13.00 (Oct. 26, 2020)
========================
- WoW 9.0.1 support
  - Backdrop issue fixed
  - CurrencyInfo API changed
  - EncounterJournal API changed
- Bugs fixed:
  - Dressroom fixed
- BfA Updates:
  - Update dungeon "Operation: Mechagon" items
  - Added BfA PVP Season 1~4 items

v8.12.00 (Feb. 24, 2020)
========================
- ToC update to support WoW 8.3.0
- Added Raid - Ny'alotha, the Waking City

v8.11.00 (Jan. 06, 2020)
========================
- ToC update to support WoW 8.2.5
- Added world bosses and items: Wekemara, Ulmath
- Updated loot tables of: The Eternal Palace
- Added maps linked with Atlas for BfA

v8.10.00 (Jun. 29, 2019)
========================
- ToC update to support WoW 8.2.0
- Fix bug with border
- Add 8.2 stuff
- Fix Set_type.lua
- Remove the model reset

v8.09.00 (Dec. 16, 2018)
========================
- ToC update to support WoW 8.1.0
- Updates for Tides of Vengence (WoW 8.1.0)
  - World boss added: Ivus the Decayed
  - Raids added: Battle of Dazar'alor, Crucible of Storms

v8.08.03 (Dec. 13, 2018)
========================
- Updated faction items
- Fixed IngameLocale errors

v8.08.02 (Oct. 31, 2018)
========================
- Add dungeon pets/mounts
- Fix sort order of Kings rest AC
- Fix bug with overlay dont reset after pet button is cleared
- Added new Hollow's End items:
  - Pets: Naxxy
  - Toys: Horse Head Costume, Horse Tail Costume, Headless Horseman's Hearthstone
  - Disguises: Exquisite Costume Set: "Xavius", Exquisite Costume Set: "Deathwing"
  - Festive Transmog: Hat of the Youngest Sister, Hat of the Third Sister, Hat of the Second Sister, Hat of the First Sister
  - Heirloom Upgrades: Weathered Heirloom Armor Casing, Ancient Heirloom Armor Casing, Timeworn Heirloom Armor Casing

v8.08.01 (Oct. 03, 2018)
========================
- Add a better way for upgradet itemLvls
- Rework some BonusID things
- Add some parts for a transmog highlighter
- Added Glory of the Wartorn Hero achievements and dungeon achievements (thanks to martinvanstigtthans)
- Fixed bug with BonusRoll frame and Azerite Items
- Fixed lua error with secButtons
- Added a Transmog highlighter button

v8.08.00 (Sep. 22, 2018)
========================
- ToC update to support WoW 8.0.1
- Codes updated to support WoW 8.0.1's API and function calls
- Added AtlasLoot_BattleforAzeroth for dungeon and raid loots
- MapID migrated to uiMapID
- Fixed item scaling issue
- Added BfA professions
- Added option to toggle expansion icon to be displayed in dropdown or not
- Added module's tooltip in dropdown
- Added achievements from Atal'Dazar (thanks to martinvanstigtthans)
- Added LibDataBroker to no-lib version of release
- Updated MapID of Trial of Valor, Invasion Points, Halls of Valor

v8.07.13 (Apr. 13, 2018)
========================
- Update world event - Brawler's Guild's items (thanks for reaper66673563371)
  - Added Brawler's Ancient Healing Potion, Brawler's Potion of Prolonged Power
  - Added battle pet: Tylarr Gronnden
  - Added new ring: Pugilist's Powerful Punching Ring
  - Added new achievements
  - Added item: Brawler's Razor Claws
  - Added shirts
  - Added items to be purchased by using Brawler's Gold
  - Added challenge cards
- Update Darkmoon Faire
  - Added new toy: Blight Boar Microphone
- Added Wicked Soul to Lich King (thanks for reaper66673563371)
- Added battle pets:
  - Nightmare Whelpling drops from Ysondre in The Emerald Nightmare
- Added tabards:
  - Army of the Light Tabard, Argussian Reach Tabard

v8.07.12 (Apr. 03, 2018)
========================
- Fixed wrong faction was pointed to three of the mounts available from Shado Pan vendor
- Added mount - Darkmoon Dirigible in World Events - Darkmoon Faire
- Corrected boss name - Blood-Queen Lana'thel in Icecrown Citadel
- Added WoLTK instances' battle pets (thanks for reaper66673563371):
  - Icecrown Citadel:
    - Boneshard, Blood Beast, Blightbreath, Soulbroken Whelpling, Drudge Ghoul
  - Trial of the Crusader:
    - Dreadmaw, Snobold Runt, Nerubian Swarmer
  - Ulduar:
    - Magma Rageling, Ironbound Proto-Whelp, Runeforged Servitor, Sanctum Cub, Winter Rageling, Snaplasher, G0-R41-0N Ultratonk, Creeping Tentacle
- Added Cataclysm instances' battle pets (thanks for reaper66673563371):
  - Blackwing Descent:
    - Tinytron, Discarded Experiment, Rattlejaw
  - The Bastion of Twilight:
    - Twilight Clutch-Sister, Bound Stream, Faceless Minion
  - Throne of the Four Winds:
    - Drafty, Zephyrian Prince
  - Firelands:
    - Cinderweb Recluse, Blazehound, Surger, Infernal Pyreclaw
  - Dragon Soul:
    - Faceless Mindlasher, Corrupted Blood, Unstable Tendril

v8.07.11 (Mar. 20, 2018)
========================
- Remove mounts - Swift Razzashi Raptor and Swift Zulian Tiger from Mounts\Dungeons & Raids\Classic
- Lib Update:
  - LibSharedMedia

v8.07.10 (Mar. 04, 2018)
========================
- Libs update:
  - LibDBIcon

v8.07.09 (Feb. 22, 2018)
========================
- Update loot table for Argus the Unmaker in Antorus, the Burning Throne

v8.07.08 (Feb. 21, 2018)
========================
- Libs update:
  - LibBabble-Boss
  - LibBabble-Faction
Updated by 2TailedFox:
- Classic dungeons's loot table update:
  - Ragefire Chasm,
  - Deadmines,
  - The Stockades,
  - Shadowfang Keep,
  - Wailing Caverns,
  - Blackfathom Deeps,
  - Gnomeregan,
  - Scarlet Halls,
  - Scarlet Monastery,
  - Razorfen Kraul,
  - Maraudon,
  - Uldaman,
  - Dire Maul,
  - Scholomance,
  - Razorfen Downs,
  - Stratholme,
  - Zul'Farrak,
  - Blackrock Depths,
  - The Temple of Atal'hakkar
  - Lower Blackrock Spire.
- Removed Marisa du'Paige from Deadmines as her loot target, Walking Boots, is no longer present.
- The Lost Dwarves in Uldaman that can be killed by Horde players have been unified into a single loot table.

v8.07.07 (Jan. 22, 2018)
========================
Updated by 2TailedFox:
- Update Stratholme drops.
- If Rare mobs were listed under Trash Mobs, they will now have entries on main panel instead for additional visibility, and to unify how Rare mobs are listed.
- Unify how the Dungeon achievement is listed for bosses.
- Removed "Trash Mob" headers from sections that had them to unify appearances.
- Corrected Heroic achievement showing for Classic rather than Mists Heroic Scarlet Monastery.
- Slight cosmetic changes to certain dungeons.
- Added additional items for the filter to ignore.
- Update drops for Blackrock Depths.
- Minor cosmetic code correction for Blackfathom
- Princess Moira has now permanently changed to High Priestess of Thaurissan, as Princess Moira has taken up residence in Ironforge.
- Ring of Law now has two pages, and now has headers for what sub-boss drops what.
- Ensure item order is consistent across dungeons already re-examined.
  Order is as follows: (Back, Cloth) -> (Chest, Feet, Hands, Head, Legs, Shoulder, Waist, Wrist in the order of Cloth, Leather, Mail, Plate) -> (Finger, Neck, Trinket) ->
  Bow, Crossbow, Dagger, Fist Weapon, Gun, Held in Off-hand, Off Hand Dagger, Off Hand Shield, One-Hand Axe, One-Hand Mace, One-Hand Sword, Polearm, Staff,
  Two-Hand Axe, Two-Hand Mace, Two-Hand Sword, Wand). Other items of interest would usually follow, like Fishing Poles, Shirts and Tabards.
- Updated Blackrock Caverns, Lower Blackrock Spire and The Temple of Atal'hakkar.

v8.07.06 (Dec. 26, 2017)
========================
- Update Trash Mob drops for Dire Maul with new witnessed drop.
- Removed Knot Thimblejack's Cache from Dire Maul roster, contents have been unobtainable since at least Patch 4.0.6
- Update Scholomance

v8.07.05 (Nov. 12, 2017)
========================
- Added Legion PvP Season 7 items
- Added Tier 21 class set items
  - Added T21 link to Antorus
- Added mounts to Collections
- Added crafting spells / items introduced in 7.3.0

v8.07.04 (Nov. 11, 2017)
========================
- Added Legion PvP Season 6 items

v8.07.03 (Nov. 11, 2017)
========================
- Added Legion PvP Season 5 items

v8.07.02 (Nov. 09, 2017)
========================
- Added bonus roll ID for Antorus and Invasion Points

v8.07.01 (Sep. 24, 2017)
========================
- Added Atlas map links to Seat of the Triumvirate and Antorus, the Burning Throne
- Adjust boss order of Antorus, the Burning Throne
- Update Dire Maul - Convert to newer array system, add some missing drops. (2TailedFox)

v8.07.00 (Sep. 21, 2017)
========================
- Update Uldaman drops, implemented better array system for that section. (2TailedFox)
- Added instance loots for Seat of the Triumvirate, Antorus, the Burning Throne, and the drops from Invasion Points

v8.06.04 (Sep. 19, 2017)
========================
- Updated LibDialog
- Classic dungeon's boss drops updated (2TailedFox)

v8.06.03 (Sep. 10, 2017)
========================
- Classic dungeon's boss drops updated (2TailedFox)
- Added new factions - Argussian Reach, Army of the Light

v8.06.01 (Sep. 10, 2017)
========================
- Fixed WorldMap button's position

v8.06.01 (Sep. 04, 2017)
========================
- Temporary fix the PlaySound issue in LibDialog

v8.06.00 (Aug. 31, 2017)
========================
- ToC update to support WoW 7.3.0

v8.05.05 (Aug. 16, 2017)
========================
- Added expansion icon to module dropdown menu
- Fixed the "removed" Naxxramas' issue in WoLTK

v8.05.04 (Jul. 20, 2017)
========================
- Options
  - Fixed frame reset button was causing error and not functioning
  - Fixed Quick Look preview button was not functioning

v8.05.03 (Jul. 18, 2017)
========================
- Enhanced Atlas integration in better checking if corresponding Atlas map's map module
  is installed and enabled.
- Updated Outland Timewalking Dungeon Event items

v8.05.02 (Jul. 14, 2017)
========================
- Collection
  - Mount
    - Corrected the mounts from Kurenai for Alliance
    - Removed Baradin's Wardens from Horde
    - Added more mounts from nutral factions and Black Market
- PvP
  - Added legacy Justice / Valor points gears
  - Updated Seasons 1~13, Season 15 items and prices
  - Added Season 14 items
- Enhanced faction reputation's handling to support friendship reputation such as Nat Pagle
- Bonus roll:
  - Added bonus roll IDs for Broken Shore world bosses and Tomb of Sargeras bosses
  - Remove bonus roll IDs for Drov the Ruiner, Rukhmar, Tarlna the Ageless as no longer valid

v8.05.01 (Jul. 06, 2017)
========================
- Fixed the issue of error loading LibBabble-Faction-3.0

v8.05.00 (Jul. 06, 2017)
========================
- Updated PlaySound API's usage method to support both 7.2.5 and 7.3.0 of WoW clients
- Enhanced worldmap button integration while Mapster, HandyNotes_WorldMapButton, or ElvUI is installed
- Migrate Conquest / Honor Points to Mark of Honor and updated PvP items for WoD
  - Added WoD Season 2 weapons data
- PvP
  - Added Legion PvP Season 2, Season 3, Season 4 item sets
  - Added Legion PvP Season 1 non-set items
  - Updated Legion PvP Season 1 class-set items
- Collection
  - Tabards
    - Updated Collection - Tabards - PvP item's buying cost
    - Added Classic PvP tabards under Collection - Tabards - PvP
    - Added Legion Tabards
  - Mount
    - Added Warforged Nightmare to in-game shop page
    - Added Collection - Mounts - Faction
- Faction
  - Updated items for Voljin's Spear and Wrynn's Vanguard
- Added LibBabble-Faction to improve faction's displaying.
  You won't see "Faction xxxx" when it's not in your faction side.
- Classic
  - Added encounter instance ID and encounter ID to the following RAIDS:
    - Blackwing Lair, Molten Core, Ruins of Ahn'Qiraj, AhnQiraj
  - Remove Naxxramas
- Burning Crusade
  - Added encounter instance ID and encounter ID to the following RAIDS:
    - Black Temple, Gruul's Lair, Hyjal Summit, Karazhan, Magtheridon's Lair, Serpentshrine Cavern,
      Sunwell Plateau, Tempest Keep
- Wrath of the Lich King
  - Added encounter instance ID and encounter ID to the following RAIDS:
    - Icecrown Citadel, Naxxramas, OnyxiasLair, The Eye of Eternity, The Obsidian Sanctum,
      The Ruby Sanctum, Trial of the Crusader, Ulduar, Vault of Archavon
- Translation update:
  - Simplified Chinese, German, Traditional Chinese
## information for Devs
- Added back dev tools from v7.0x

v8.04.04 (Jun. 23, 2017)
========================
- Added Mists of Pandaria Timewalking items

v8.04.03 (Jun. 22, 2017)
========================
- Midsummer Fire Festival update:
  - Added Illusion: Deathfrost (dropped from Ahune), Set of Matches, Igneous Flameling

v8.04.02 (Jun. 21, 2017)
========================
- Options frame will now remembered its position once get dragged
## information for Devs
- Enhanced checkbox widget to support disabled. Now we need a trigger to refresh the option panel.

v8.04.01 (Jun. 16, 2017)
========================
- Fixed lib loading issue

v8.04.00 (Jun. 13, 2017)
========================
- Tomb of Sargeras loot items updated:
  - Maiden of Vigilance
  - Fallen Avatar
  - Kil'jaeden
    - Corrupted Containment Coil is now called Scornful Reflection and drops from Kil'jaeden instead of Fallen Avatar
- Updated T20 set's item source, chest is now drop from Maiden of Vigilance instead of Kil'jaeden

v8.03.07 (May 26, 2017)
========================
- Fixed issue that no-lib version was not able to locate LibBabble-ItemSet-3.0
- Fixed mount preview issue

v8.03.06 (May 05, 2017)
========================
- Slightly enhanced bonus loot's function to prevent from popping up error

v8.03.05 (Apr. 20, 2017)
========================
- Added 4 new Broken Shore world bosses's loot
- Use LibDialog to replace StaticPopupDialogs

v8.03.04 (Apr. 15, 2017)
========================
- Fixed tier set's linking issue from raid table
- Added tier set link to the Nighthold and Tomb of Sargeras
- Added achievement of Glory of the Tomb Raider table

v8.03.03 (Apr. 12, 2017)
========================
- Added Legion faction icons to Faction module
- Added Nether Portal Disruptor to Armies of Legionfall
- Re-organized Armies of Legionfall items

v8.03.02 (Apr. 11, 2017)
========================
- fixed Atlas integration issue to compatible with Atlas v1.40.00

v8.03.01 (Apr. 10, 2017)
========================
- added faction of Armies of Legionfall and the corresponding items

v8.03.00 (Apr. 09, 2017)
========================
- ToC update to support WoW 7.2
- added T20 item sets
- added Cathedral of Eternal Night & Tomb of Sargeras
- fixed most of the issues that wrong item levels showing in some raids and dungeons
- fixed missing items from Baron Silverlain in Shadowfang Keep's normal mode.

v8.02.24 (Mar. 21, 2017)
========================
- enhanced AtlasLoot buttton's handling on WorldMap when ElvUI is enabled but skin is disable on WorldMap

v8.02.23 (Mar. 20, 2017)
========================
- handling AtlasLoot button's style on WorldMap when ElvUI is enabled
- translation update:
  - German

v8.02.22 (Mar. 17, 2017)
========================
- handling HandyNotes_WorldMapButton's position

v8.02.21 (Mar. 16, 2017)
========================
- library update
  - LibBabble-ItemSet-3.0

v8.02.20 (Mar. 15, 2017)
========================
- added tier sets per class
- translation update:
  - Korean, Simplified Chinese

v8.02.12 (Mar. 15, 2017)
========================
- added WorldMap button style, now you can toggle it to show on title bar
- translation update:
  - Korean, Simplified Chinese, German
- fixed the issue with auto-select's pre-load module which will causing error while the 1st time open AL with class-filter enabled
## information for Devs
- move auto-selection codes to AtlasLoot.lua

v8.02.11 (Mar. 13, 2017)
========================
- added option to toggle WorldMap button
- enhanced auto-select's performance by pre-loading all instances' module during addon's loading stage
- added right-click to close Atlas window

v8.02.10 (Mar. 10, 2017)
========================
- added WorldMap integration
- added auto-select feature while in instance

v8.02.01 (Mar. 09, 2017)
========================
- set default module and map to be Legion and Legion instance
- translation update:
  - German, Korean, Simplified Chinese

v8.02.00 (Mar. 03, 2017)
========================
- added Atlas integration, now you can quickly open the Atlas instance map
  while browsing the instance loots within AtlasLoot
- replace local gold / silver icon with the WoW built-in ones
- added map button's tooltip
- translation update:
  - Korean, Simplified Chinese, Traditional Chinese

v8.01.20 (Mar. 01, 2017)
========================
- added non-passive first-aid items/spells from Legion expansion
- added new cooking skills from Legion expansion
- World Events - Argent Tournament Heirloom data revision (Kakjens)
- added item Dark Lupine Wraps to Lord Walden in Shadowfang Keep
- added item Blindwatcher's Chain to Baron Silverlaine in Shadowfang Keep
- translation update:
  - Korean, German, Traditional Chinese

v8.01.10 (Feb. 28, 2017)
========================
- updated class icons
- added Legion legendary items
- added T19 gear items
- translation update:
  Korean, Traditional Chinese, Simplified Chinese, French
## information for Devs
- fix some small bugs
- ADD "addDifficultyBonus" for PreSets, should make the bonusID things much easier

v8.01.09 (Jan. 11, 2017)
========================
- added ACs to 'Trial of Valor'
- migrate minimap button to use LibDBIcon
- added slash command description to localization table;

v8.01.08 (Dec. 23, 2016)
========================
- added ACs to 'The Nighthold'
- added ACs to 'The Emerald Nightmare'
- added AC 'Unleashed Monstrosities' to 'Broken Isles'
- fixed 'Dragons of Nightmare' LFR loot

v8.01.07 (Dec. 08, 2016)
========================
- added "The First Satyr's Spaulders" to the loot of Xavius
- added LFR to Trial of Valor
- updated QuickLootFrame with Legion raids
- fixed some mounts' displaying issue
- added class hall items
- fixed armor type's localization
- added class color
- enhanced localization automation also added itIT
- added artifact weapons to Collections
- update external repositories' URL due to curseforge's migration

v8.01.06 (Oct. 27, 2016)
========================
- added missing boss "Shade of Medivh" to "Return to Karazhan"
- changed order of bosses in Legion to reflect the Adventure Guide

v8.01.05 (Oct. 26, 2016)
========================
- updated TOC version to 7.1
- added Dungeon "Return To Karazhan" to Legion Content
- added Raid "Trial Of Valor" to Legion Content
- added zhTW description to TOC of AtlasLoot_Options.toc
## information for Devs
- added 2nd mythic dungeon bonusID to ItemString.lua

v8.01.04 (Sep. 21, 2016)
========================
- added PvP Legion Season 1 Class-Sets
- updated profession tailoring to Legion
- updated profession leatherworking to Legion
- updated profession jewelcrafting to Legion
- updated profession inscription to Legion
- updated profession engineering to Legion
- updated profession enchanting to Legion
**(known issue: not all created enchants are shown, but the spell)**
- added "rune" and "runes" as constant
- added "shoulder" as constant
- added zhTW description to AtlasLoot_Legion.toc by arith

v8.01.03beta1 (Sep. 14, 2016)
========================
*tagged as BETA due to the known issue mentioned below*
- updated profession enchanting to Legion
(known issue: not all created enchants are shown, but the spell)

v8.01.02 (Sep. 13, 2016)
========================
-- Legion --
- added faction "The Nightfallen"
- added faction "Valarjar"
- added faction "The Wardens"
- added faction "Dreamweavers"
- added faction "Highmountain Tribe"
- added faction "Court Of Farondis"
- updated profession alchemie to Legion
- updated profession blacksmithing to Legion
- added "Relic" as constant
-- WOD --
- added PvP WODSeason 3 Weapons
- added PvP Season 13 Class-Sets

v8.01.01 (Aug. 30, 2016)
========================
- Added AC "Legion Dungeon Hero"
- Added AC "Glory of the Legion Hero"
- Added AC "Glory of the Legion Raider"
- Added Dungeon "Assault On Violet Hold"
- Added Dungeon "Black Rook Hold"
- Added Dungeon "Darkheart Thicket"
- Added Dungeon "Eye Of Azshara"
- Added Dungeon "Court Of Stars"
- Added Dungeon "Halls Of Valor"
- Added Dungeon "Maw Of Souls"
- Added Dungeon "Neltharion's Lair"
- Added Dungeon "The Arcway"
- Added Dungeon "Vault Of The Wardens"
- Added Raid "The Nighthold"
- Added Raid "The Emerald Nightmare"
- Added Raid "Broken Isles"
- Fixed LFR Titanforged ItemLevel

v8.01.00 (Jul. 25, 2016)
========================
- first Legion encounter for tests (known issue: "titanforged" isn't shown correctly)
- A lot of legion pre patch related changes
-- fixed missing GetAuctionItemClasses
-- fix ClassFilter
-- fix Background Images (content frame)
-- fix Mounts
-- fix Bug with itemString
- set LibBabble-Boss-3.0 and LibBabble-ItemSet-3.0 to be external links
- Updated TOC
- created 1 instances and raids in data.lua
- added bonus IDs for Legion to ItemString.lua
- put Legion to constants.lua
- added Legion to the loader
- Added Legion folder

v8.00.72 (Jan. 25, 2016)
========================
- added WoD PvP Season 3 Weapons (Elite is missing)
- updated Mount-Tab in collection
- added PvP Season 6 & 7 Class-Sets
- zhCN/zhTW update

v8.00.71 (Jan. 15, 2016)
========================
- Added mount tab in collections (drop, achievement & profession) quest and shop mounts are missing atm
- Added prices to WoD PvP Season 3 Class-Sets
- Added WoD PvP Season 3 NonSet Items

v8.00.60 (Nov. 11, 2015)
========================
- fixed issue #925 (thanks to Ignifazius)
- removed warforged Crystallized Fel
- prepared WoD PvP Season 3 Class Sets (without prices)
- added currency "valor"
- added new quest item for mount to Archinmonde (hc/mythic)
- added WoD PvP Season 3 Cloth Non-Set
- prepared WoD PvP Season 3 NonSet Items
- prepared WoD PvP Season 2 & 3 Weapons
- Added WoD PvP Season 2 Amulets, Cloaks, Rings, Trinkets & Tabard
- updated WoD PvP Season 2 NonSet Cloth
- added WoD PvP Season 2 NonSet Leather, Mail & Plate

v8.00.52 (Nov. 08, 2015)
========================
- fixed bug in PvP Section

v8.00.51 (Oct. 01, 2015)
========================
- updated Brewfest ('15)
- Added WOD Season 2 non set cloth
- Added PVP Season 4 & 5 Class-Sets

v8.00.50 (Sep. 20, 2015)
========================
- mythic dungeon LUA-Error should be fixed (Teicket #915, #916)
- added zhTW translation for AtlasLoot_Options (thanks to gaspy10)
- Added WoD Season 2 Class-Sets
- added 6.2 Heirloom
- added Legandary Rings
- added class trinkets to Archimonde loot (tooltip only for own class and specialization)

v8.00.40 (Jul. 19, 2015)
========================
- fixed wrong tier-set view on content (Ticket #921)
- added Trash-Loot in Hellfire Citadel
- added new Apexis-Items (old Apexis disabled, will come back with new prices)
- fixed Bonusroll-.LUA-Error (first 7 Bosses confirmt)
- fixed Kazzak-Loot
- fixed Collection Tab-Title for Tier 18
- MYTHIC BONUSROLL-ERROR STILL NOT FIXED

v8.00.30 (Jun. 26, 2015)

v8.00.20 (Jun. 24, 2015)

v8.00.10 (Jun. 24, 2015)

v8.00.00 (May 21, 2015)
Compatible with Patch 6.0.3.

v7.07.03 (May 26, 2014)
Added Patch 5.4.8 items.
Added Timeless Isle Rare mobs.

v7.07.02 (Feb 27, 2014)
Added PvP Season 15 Set.
Added Patch 5.4.1, 5.4.2 & 5.4.7 items.
Updated Bonus Roll database.
Significantly reduced memory usage of Bonus Roll feature.

v7.07.01 (Sep 21, 2013)
Updated Bonus Roll database.
Various fixes, additions and translations.

v7.07.00 (Sep 10, 2013)
Compatible with Patch 5.4.
Compatible with Atlas 1.26.00.
Added Tier 16 Raid Set.
Added PvP Season 14 Set.
Added loot for Siege of Orgrimmar.
Added Timeless Isle Rewards.
Added new faction - Emperor Shaohao.
Updated Mount & Companion menus.
Minor fixes, additions and translations.

v7.06.00 (May 22, 2013)
Compatible with Patch 5.3.
Compatible with Atlas 1.25.00.
Added Darkspear Rebellion rewards.
Added Gate of the Setting Sun normal mode loot.
Updated Heirloom & BoA section with Patch 5.2 items.
Updated Brawler's Guild rewards.
Added amount of crafted items to crafting section.
Added bonusroll info to Thunderforged items.
Removed DKP & Classpriority addons, as they were not working anymore.
Minor fixes, additions and translations.

v7.05.03 (Apr 03, 2013)
Added all Thunderforged items to Throne of Thunder loot tables.
Converted faction names to use ingame locales instead of BabbleFaction.
Converted zone names to use ingame locales instead of BabbleZone.
Removed BabbleZone and BabbleFaction library.
Fixed a bug that occured with disabled modules.
Fixed a bug where icons sometimes had no tooltips.
Fixed a bug that sometimes prevented BonusRoll information from displaying the correct specs.
Minor fixes, additions and translations.

v7.05.02 (Mar 12, 2013)
Fixed a bug that prevented the factions menu to open.

v7.05.01 (Mar 12, 2013)
Added various missing 5.2 stuff.
Added missing Season 13 items.
Added drop rates to MoP dungeons.
Many minor fixes, additions and translations.

v7.05.00 (Mar 05, 2013)
Compatible with Patch 5.2.
Compatible with Atlas 1.24.00.
Added Tier 15 Raid Set.
Added PvP Season 13 Set.
Added loot for Throne of Thunder.
Added loot for Nalak, The Storm Lord.
Added loot for Oondasta.
Added faction - Kirin Tor Offensive.
Added faction - Sunreaver Onslaught.
Added faction - Shado-Pan Assault (Valor items).
Added new companions.
New feature: Bonus Roll information.
Updated several professions with new recipes.
Updated Midsummer Fire Festival loot.
Minor fixes, additions and translations.

v7.04.02 (Jan 25, 2013)
Added Operation: Shieldwall Justice and Valor items.
Added Dominance Offensive Justice and Valor items.
Added Bizmo's Brawlpub / Brawl'gar Arena rewards.
Added Domination Point rewards.
Updated Darkmoon Faire.
Revamped Faction menus.
Removed Hydraxian Waterlords from faction page.
Removed items not available in-game anymore from Argent Dawn and Cenarion Circles pages.
Many minor fixes, additions and translations.

v7.04.01 (Nov 30, 2012)
Compatible with Patch 5.1.
Added faction - Dominance Offensive.
Added faction - Operation: Shieldwall.
Added Lion's Landing rewards.
Minor fixes, additions and translations.

v7.04.00 (Nov 25, 2012)
Added missing dungeon and raid items.
Added Fishing to the crafting menus.
Added new Pets and Mounts.
Added Sha of Anger quest rewards.
Added prices for faction rewards.
Added Golden Lotus, Shado Pan and Klaxxi quest rewards.
Added Best Friend rewards for Nat Pagle, Old Hillpaw and Sho.
Added Mists of Pandaria "Glorious!" Rare mobs and "Lost and Found" rare items.
Added missing BoE World Epics including those obtained from pick-pocketing.
Added Leatherworking Mists of Pandaria vendor sold recipes.
Added Tailoring Mists of Pandaria vendor sold recipes.
Added Spirit of Harmony tradable items.
Added Mogu'Shan Vaults and Heart of Fear trash loot.
Updated Transformation section.
Updated Heirloom section and added Bind on Account items.
Updated Legendary Items section.
Updated Love is in the Air with the new ilvl 480 rewards.
Updated Pilgrim's Bounty.
Revamped Feast of Winter Veil.
Revamped Lunar Festival.
Many minor fixes, additions and translations.

v7.03.01 (Oct 11, 2012)
Fixed a nasty bug regarding Atlas.
Minor fixes, additions and translations.

v7.03.00 (Oct 10, 2012)
Compatible with Atlas 1.22.1.
Added Ironpaw cooking award items.
Added missing faction rewards.
Added missing raid items.
Added Season 12 PvP weapons.
Added Level 90 World BoE Items.
Updated Blacksmithing with Mists of Pandaria recipes.
Updated Cooking with Mists of Pandaria recipes.
Updated Inscription with Mists of Pandaria recipes.
Updated Jewelcrafting with Mists of Pandaria recipes.
Updated Leatherworking with Mists of Pandaria recipes.
Updated Tailoring with Mists of Pandaria recipes.
Updated Brewfest vendor.
Ton of minor fixes, additions and translations.

v7.02.00 (Oct 03, 2012)
Compatible with Atlas 1.22.
Added all of Mists of Pandaria raid loot (thanks Dynaletik).
Added Mists of Pandaria Valor Points items.
Added PvP Season 12 items.
Updated Alchemy with Mists of Pandaria recipes.
Updated Blacksmithing with Mists of Pandaria vendor sold plans.
Updated Enchanting with Mists of Pandaria recipes.
Many minor fixes, additions and translations.

v7.01.01 (Sep 26, 2012)
Fixed a nasty bug that prevented some menus to work.
Updated Archaeology with new Mists of Pandaria artifacts.
Minor fixes and additions.

v7.01.00 (Sep 24, 2012)
Added dungeon loot: Temple of the Jade Serpent, Stormstout Brewery, Mogu'Shan Palace, Shado-pan Monastery, Siege of Niuzao Temple, Gate of the Setting Sun.
Added new factions: The Anglers, The August Celestials, Golden Lotus, The Lorewalkers, The Klaxxi, Order of the Cloud Serpent. Shado-Pan, The Tillers.
Added Mists of Pandaria Justice Points items.
Added Tier 14 Raid Set.
Added new Mists of Pandaria companions and accessories.
Added new Mists of Pandaria mounts.
Added new Mists of Pandaria tabards.
Updated Engineering, First Aid and Mining with MoP recipes.
Updated loot tables for Coren Direbrew (Brewfest) and Headless Horsemen (Hallow's End).
Many minor fixes, additions and translations.

v7.00.01 (Aug 29, 2012)
Fixed a nasty bug with AtlasLoot_Loader.
Minor additions.

v7.00.00 (Aug 28, 2012)
Compatible with Patch 5.0.4.
Added loot for revamped Ragefire Chasm, Scarlet Monastery and Scholomance.
Added various preparations for Mists of Pandaria.
Added Dungeon Journal to Classic, BC and WotLK instances.
Removed all relics and thrown weapons.
Many minor additions, fixes and translations.

v6.05.04 (Mar 05, 2012)
Added an About page.
Added an Auto-Fix for corrupted Wishlists.
Fixed a bug with 10/25 Man Buttons.
Some minor fixes and additions.

v6.05.03 (Feb 04, 2012)
New feature: Wishlist items are shown in boss tooltip (Beta).
Added new TCG loot from War of the Ancients (not yet released).
Updated Winter Veil section.
Some minor fixes, additions and translations.

v6.05.02 (Dec 14, 2011)
Added missing PvP gems.
Added Season 1-3 weapons.
The default frame now properly saves its position.
Removed various LFR weapons as these items are not ingame.
Some minor fixes and additions.

v6.05.01 (Dec 06, 2011)
Added missing trash loot for Dragon Soul.
Added Season 11 items.
Added new prices for Season 1-3 sets.
Added some missing mounts and revamped rare mounts section.
Updated Transformation Items.
Added autoselect for missing cataclysm instances.
Added ptBR translation (Thanks Reiyr).
Some minor fixes and additions.

v6.05.00 (Nov 29, 2011)
Compatible with Patch 4.3.
Added support for Atlas 1.21.0.
Added loot for Endtime.
Added loot for Hours of Twilight.
Added loot for Well of Eternity.
Added loot for Dragon Soul.
Added new Baradin Hold boss.
Added new Valor Points items.
Added Tier 13 Raid Set.
Added new Mounts and Companions.
Revamped Darkmoon Faire section.
Updated Hallow's End.
Added new TCG loot from Throne of the Tides.
Added new TCG loot from Crown of Heaven (not yet released).
Added new TCG loot from Tomb of the Forgotten (not yet released).
Added new epic gems to the Jewelcrafting section.
Added new items to other professions.
Added Spells to the Archaeology section.
Added linkable currencies.
Fixed a bug that prevented search results from being added to the wishlist.
Many minor fixes, additions and translations.

v6.04.04 (Sep 11, 2011)
Added support for Atlas 1.20.1.
Added Season 10 items.
Added various Wishlist improvements.
Added an option to disable mouse-over on item descriptions.
Fixed a bug that prevented the search from working.
Many minor fixes, additions and translations.

v6.04.03 (June 30, 2011)
Small Database fix.

v6.04.02 (June 30, 2011)
Added Firelands Patterns and Shared Boss loot.
Added Tier 12 token drop locations.
Adjusted PvP prices.
Fixed another bug that prevented AtlasLoot from working.
Minor fixes and additions.

v6.04.01 (June 28, 2011)
Updated Cooking, Enchanting & Jewelcrafting.
Fixed a bug that prevented AtlasLoot from working.

v6.04.00 (June 28, 2011)
Compatible with Patch 4.2.
Added support for Atlas 1.20.0.
Added Firelands Raid loot Normal and Heroic.
Added new Baradin Hold boss.
Added new faction: Avengers of Hyjal.
Added Tier 12 Raid Set.
Added Season 10 PvP Set.
Added Molten Fire Daily Rewards.
Added various new mounts and companions.
Added various new crafting recipes.
Updated Alchemy section (Thanks to Auràya @ EU-Arygos).
Updated Crafting section with Molten Front rewards.
Updated Brewfest and Hallows' End boss loot.
Added links for bosses and instances between AtlasLoot and DungeonJournal.
Added a CompareFrame window to compare all items of an instance.
Added a new Wishlist interface.
Added an option to filter by stats.
Added an option to use the search only for selected modules.
Added viewable currencies to the item description.
Dungeons and Raids are now seperated in the loot browser.
The loot browser now remembers the last opened page.
Many minor fixes, additions and translations.

v6.03.02 (May 08, 2011)
Added support for Atlas 1.19.1.
Revamped Vault of Archavon and Baradin Hold loot tables.
Fixed a localization bug for missing Babble entries.
Fixed a bug with the instance autoselect.
Minor fixes and additions.

v6.03.01 (May 02, 2011)
Added missing Zul'Aman and Zul'Gurub loot.
Minor fixes, additions and translations.

v6.03.00 (Apr 26, 2011)
Compatible with Patch 4.1.
Added support for Atlas 1.18.3.
Added support for upcoming Atlas 1.19.0.
Added some missing 4.0.6 stuff.
Added various new 4.1 items.
Added loot for heroic Zul'Gurub and Zul'Aman.
Updated Enchanting with Cataclysm recipes.
Updated Leatherworking with Cataclysm recipes. (Thanks to Xecration)
Updated Children's Week.
Fixed a bug with overlapping panel buttons.
Fixed a bug with empty loot tables.
Many minor fixes, additions and translations.

v6.02.00 (Jan 30, 2011)
Reorganized Justice Points menu.
Added missing PvP stuff.
Revamped Archaeology.
Updated Alchemy with Cataclysm recipes. (Thanks to Yinzara)
Updated Blacksmithing Cataclysm and Classic level armor and weapons pages. Armor Enhancements, Weapons Enhancements and Miscellaneous pages have also been updated.
Updated Inscription with Cataclysm recipes. (Thanks to Xecration)
Updated Leatherworking with Cataclysm vendor sold patterns.
Updated Tailoring with Cataclysm recipes and vendor sold patterns. (Thanks to Razel (Earthen Ring) and Panik)
Added new stuff coming with Patch 4.0.6.
Added support for Atlas 1.18.2.
Removed Cataclysm dungeon and raid heroic trash drops.
Many minor fixes, additions and translations.

v6.01.02 (Dec 22, 2010)
Archaeology updated with Rare and Epic quality rewards.
Blacksmithing updated with vendor sold plans.
Enchanting updated with vendor sold formulas.
Many minor fixes, additions and translations.

v6.01.01 (Dec 06, 2010)
Fixed a bug that got people disconnected.
Added raid loot: Throne of the Four Winds, Bastion of Twilight, Blackwing Descent, Baradin Hold.
Updated frFR translation.
Many minor fixes and additions.

v6.01.00 (Nov 28, 2010)
New slash command "/al wishlist"
Search reenabled
Various bugs fixed
deDE, ruRu, zhTW translation updates
Many minor additions

v6.00.00 (Nov 23, 2010)
Compatible with World Of Warcraft: Cataclysm.
Added support for Atlas 1.18.0
New Features: New loot browser, Quicklook revamp, Wishlist revamp, Heirlooms can now be viewed by lvl, button to switch between price and description
Added all new dungeon loot: Blackrock Caverns, Throne of the Tides, The Stonecore, Vortex Pinnacle, Lost City of Tol'vir, Grim Batol, Halls of Origination
Added all new faction rewards: Baradin's Wardens, Dragonmaw Clan, Hellscream's Reach, Ramkahen, The Earthen Ring, The Guardians of Hyjal, Therazane, Wildhammer Clan
Added the following factions into the Classic faction page: Darnassus, Exodar, Gilneas, Gnomeregan, Ironforge, Stormwind, Bilgewater Cartel, Darkspear Trolls, Orgrimmar, Silvermoon City, Thunder Bluff and Undercity
Added the following factions into the Wrath of the Lich King page: The Silver Covenant and The Sunreavers
Added Tier 11 sets
Added Lvl85 PvP sets
Added Daily Cooking rewards.
Added new Darkmoon Faire trinkets
Updated Crafting professions (Blacksmithing, Cooking, Engineering, First Aid, Jewelcrafting and Mining) with new Cataclsym recipes.
Updated events: Brewfest and Love is in the Air.
Reorganized Companions, Mounts and Tabard pages. All new Companions, Mounts and Tabards added.
New collection page - Transformation items.
Converted all PvP prices into the new Honor Point system.
Converted all Badge and Emblem gear into the new Justice Point system.
Tons of minor fixes and additions

v5.11.07 (Oct 18, 2010)
Added support for Atlas 1.17.2

v5.11.06 (Oct 16, 2010)
Fixed the query button bug
Fixed the options menu bug

v5.11.05 (Oct 12, 2010)
Compatible with 4.0

v5.11.04 (Aug 14, 2010)
Added support for Atlas 1.17.0
Minor fixes

v5.11.03 (Jul 01, 2010)
Added Ruby Sanctum Heroic loot
Minor fixes and additions

v5.11.02 (Jun 22, 2010)
Added New TCG loot
Updated Lord Ahune loot
Minor fixes

v5.11.01 (Jun 03, 2010)
zhTW translation fixed

v5.11.00 (Jun 02, 2010)
Added Ruby Sanctum Normal loot
Lord Ahune drops updated
Added New TCG loot
Added support for upcoming Atlas 1.16.1
Minor fixes and additions

v5.10.01 (Mar 24, 2010)
Adjusted PvP prices
Total revamp of PvP section
Minor fixes and additions

v5.10.00 (Feb 16, 2010)
Added Arena Season 8 items
Adjusted old Arena prices
Added Lich King loot
Revamp of Love is in the Air Event
Final adjustments for Atlas 1.16.0
Minor fixes and additions

v5.09.05 (Jan 20, 2010)
Fixed the heroic toggle

v5.09.04 (Jan 19, 2010)
Added remaining ICC loot (Normal Mode)
Added Heroic ICC loot
Crafting updated for Patch 3.3
Added support for upcoming Atlas 1.16.0
Minor fixes and additions

v5.09.03 (Jan 04, 2010)
Added The Plagueworks raid loot
Minor fixes and additions

v5.09.02 (Dec 19, 2009)
Added Icecrown Citadel raid loot
Added Wishlist API (see forums)
Compatible with Atlas Fan-update
Minor fixes

v5.09.01 (Dec 11, 2009)
Pit of Saron is now visible in the loot browser
Minor fixes

v5.09.00 (Dec 08, 2009)
Updated for Patch 3.3
Added Icecrown Citadel Lower Spire (Normal Mode)
Added The Forge of Souls
Added the Halls of Reflection
Change so that you only get nagged for AtlasLoot/Atlas mismatches once
Change to the use of Babble data for non-English users
Minor fixes

v5.08.10 (Nov 29, 2009)
Commented out some Patch 3.3 stuff that was causing problems
Attempt to make the mod more resistant to errors

v5.08.09 (Nov 27, 2009)
Pilgrim's Bounty loot
More loot in preparation of Patch 3.3 (only on PTR)
Minor updates

v5.08.08 (Nov 20, 2009)
Added Emblem of Frost Rewards (only on PTR)
Added Tier 10 Sets (only on PTR)
Many minor fixes

v5.08.07 (Nov 19, 2009)
Added links to Tier 9 sets and PvP Sets in Emblem sections as appropriate
Fixed a bug due to changes to Babble-Boss

v5.08.06 (Oct 19, 2009)
Corrections for the ToC Tribute run
Updated Hallow's End Headless Horseman loot

v5.08.05  (Oct 12, 2009)
Update for Atlas 1.15.1
Fixed <- and -> navigation for Ulduar
Added the new Scourgewar trading card game in-game items.

v5.08.04 (Oct 04, 2009)
Fixed a bug where the loot filter was breaking heroic mode loot
Mod will no longer attempt to load a loot table at startup
Many minor bug fixes

v5.08.03 (Oct 01, 2009)
Fixed a bug with default loot table causing errors with a 'fresh' AL install
Update for the latest Atlas 1.15 test build
Cleanup of Onyxia loot

v5.08.02 (Sep 27, 2009)
Moved T2 Helms to Nefarian
25 Man Onyxia loot completed
Fixed bug where selection of default wishlist was not preserved

v5.08.01 (Sep 23, 2009)
Fixed Argent Confessor Bug

v5.08.00 (Sep 23, 2009)
First pass of Onyxia (level 80) loot
Added missing Tankard of Terror
Updated crafting for Patch 3.2.2

v5.07.07 (Sep 22, 2009)
Added Cooking Daily rewards
Added Fishing Daily rewards
Added Patch 3.2 Wintergrasp items
Added Emalon the Storm Watcher and Koralon the Flame Watcher loot to Vault of Archavon
Added Wrath of the Lich King Crafted Sets (Blacksmithing, Leatherworking and Tailoring)
Updated Brewfest 2009 items
Added Vanity Pet Accessories
Reins of the Violet Proto-Drake now available in Mount page
Compatible with the Atlas version 1.15 alpha build
Minor updates/fixes/translations

v5.07.06 (Sep 03, 2009)
Arena Season 7 Loot included
The loot filter now applies to most PvP and Rep rewards, more coming
Search and Wishlist headings fixed
Many minor bug fixes and updates
Localisation updates (including esMX)

v5.07.05 (Aug 17, 2009)
Added New Mounts, Pets and Tabards
Added 25 Man Trial of the Crusader loot
Updated Argent Tournament
Updated Emblem items
Updated Jewelcrafting and added new epic gem recipes to Jewelcrafting daily
Added crafted weapons (lvl80 ones have been missing)
Added Yogg-Saron+0 loot
Added PvP Heirlooms to set menu

v5.07.04 (Aug 13, 2009)
10 Man Trial of the Crusader is complete (Horde and Alliance)
More minor bug fixes

v5.07.03 (Aug 12, 2009)
Added New Dungeon : Trial of the Crusader, 10 Man Alliance Loot (thanks ThyrelR)
More minor bug fixes

v5.07.02 (Aug 10, 2009)
Added New Dungeon: Trial of the Champion
Added Patch 3.2 Crafted items
Emblem of Triumph rewards added
Removed all references to BabbleClass

v5.07.01 (Aug 05, 2009)
Fixed the back to front Druid sets

v5.07.00 (Aug 05, 2009)
Tier 9 Set items included
TOC update for Patch 3.2
Fixed deleting shared wishlists
Fixed editing shared wishlists
Items from shared wishlists are now correctly marked
The Loot Browser now uses Atlas menus where possible to reduce code maintenance

v5.06.02 (Jul 7, 2009)
Fixed sorting bug with the loot filter
Fixed adding items to wishlist from search results
Minor updates/fixes/translations

v5.06.01 (Jul 16, 2009)
Attempt to get around addon packager issues

v5.06.00 (Jul 15, 2009)
New Feature: Added an ability in the options menu to filter loot pages by item type
Loot Filter Documentation: http://www.daviesh.net/atlasloot_enhanced/wiki/index.php?n=AtlasLoot.LootTableFilter
New Feature: *Beta* Each character now has access to multiple wishlists and they can be shared between players
WishList Documentation: http://www.daviesh.net/atlasloot_enhanced/wiki/index.php?n=AtlasLoot.WishLists
Revamped the Mount page
Drop rates added for: Tempest Keep - The Eye, Serpentshrine Cavern, Zul'Aman, Caverns of Time - Battle for Mount Hyjal, Black Temple, Magisters' Terrace, Sunwell Plateau, Ahn'kahet: The Old Kingdom, Drak'Tharon Keep, The Violet Hold, Gundrak, Halls of Stone, Halls of Lightning, Caverns of Time: Old Stratholme, Utgarde Pinnacle, The Oculus, Naxxramas, Obsidian Sanctum, The Eye of Eternity, Ulduar
Minor updates/fixes/translations

v5.05.01 (Jun 08, 2009)
More Ulduar items added
New Argent Tournament items added
Drop rates added for Azjol-Nerub
Added an option to switch between new and old visual styles for the loot browser
Added the option to treat crafted items as crafting spells or as items
Minor updates/fixes/translations

v5.05.00 (May 13, 2009)
Major Ulduar update
Re-arranged loot table controls to make room for bigger buttons
Revamped the Non Combat Pets pages and added missing/new pets
New look for the standalone loot browser from Lag
Fixed bug with the 'Help' options panel
Compatible with the new Atlas version 1.14.1

v5.04.03 (Apr 27, 2009)
Added missing Emblem of Valour relics
Completed the Argent Tournament rewards
Completed Lake Wintergrasp rewards
Added gear for Arena Season 6
Updated PvP Prices
Ulduar updates
Noblegarden included
Minor updates/fixes/translations

v5.04.02 (Apr 19, 2009)
Fixed a bug with Atlas 1.13 and Atlas 1.14 layouts getting confused
New Tabards added

v5.04.01 (Apr 18, 2009)
Emblem of Conquest loot included
Fixed comparison tooltip bug
Fixed Vault of Archavon bug
Compatible with the new Atlas version 1.14
The Query Server button is now throttled (small delay between item queries)

v5.04.00a (Apr 15, 2009)
Fixed loot module toc numbers

v5.04.00 (Apr 15, 2009)
Added New Event: The Argent Tournament
Added Tier 8 (Ulduar) Sets
Added Cooking to 450 skill, all professions updated for Patch 3.1
Added new WotLK Darkmoon Faire items and revamped its menu
Added WotLK new World BoE Items
Added drop rates for Utgarde Keep and The Nexus
Trash Mob updates from Pucelle
Added Key to the Focusing Iris (Normal/Heroic) Rewards
The dressingroom and comparison tooltips should now work for crafted items
Holding down the shift key while mousing over items will now always show an available comparison tooltip
Minor updates/fixes/translations

v5.03.03 (Feb 16, 2009)
Revamped the following dungeons: Halls of Lightning, The Violet Hold
Added New Wintergrasp items from Patch 3.0.8
Added New Venture Bay Sigils
Updated Engineering for WotLK
Minor updates/fixes/translations

v5.03.02 (Jan 17, 2009)
Help Panel translation bugfix

v5.03.01 (Jan 15, 2009)
Updated wishlist code to deal with 25 Man loot better
Added WotLK Tailoring
Revamped the following dungeons: Ahn'kahet, Azjol-Nerub, The Nexus, Utgarde Keep, Drak'Tharon Keep,  Gundrak, Halls of Stone
Added a 'Help' panel in the options screen with how to use various features

v5.02.07 (Jan 04, 2009)
Added Vault of Archavon (Under WotLK instances in loot browser, PvP Rewards in Atlas)
Updated Gluth loot tables
Added Deadly Gladiator's Necklaces, Cloaks, and Rings
Added Battlemaster Trinkets (Level 80)
Added PvP Jewelcrafting Designs
Added Frenzyheart Tribe and The Oracles Disgusting Jar and Mysterious Egg rewards
Added Venture Bay rewards to the PvP section
Corrected Honor/Ratings for PvP items
Minor updates/fixes/translations

v5.02.06 (Dec 22, 2008)
Fixed a bug in LibAboutPanel implementation

v5.02.05 (Dec 22, 2008)
Malygos and Sartharion updates
Inscription Update
Wrath of the Lich King Blacksmithing done
Update to Emblem of Heroism items
Added support for LibAboutPanel

v5.02.04 (Dec 14, 2008)
Wrath of the Lich King Jewelcrafting
Utgarde Pinnacle Atlas interface fixed
Update to the mounts collection

v5.02.03 (Dec 04, 2008)
Major Naxx Update
Added new sets: Raine's Revenge and The Fists of Fury.
Renamed and Split the pre-60 page into 2 pages - Classic and Burning Crusade/Wrath of the Lich King
Added Winterfin Retreat as a new Wrath Faction
Minor updates/fixes/translations

v5.02.02 (Nov 30, 2008)
Minor bugfixes
Fixed a bug causing the 10 man/25 man toggle button to have the wrong text
Violet Hold Normal/Heroic loot included
Gundrak Heroic loot included
Sartharion Update
Naxx Update
Added WotLK Enchanting recipes

v5.02.01 (Nov 22, 2008)
Added WotLK Alchemy and Leatherworking recipes
Re-arranged Enchanting
Updated Inscription
Added the Horde Expedition and the Alliance Vanguard rep factions
Minor updates for Atlas 1.13

v5.02.00 (Nov 13, 2008)
Dungeons and Raids:
Added loot for 'Utgarde Keep'
Added loot for 'The Nexus'
Added loot for 'Azjol-Nerub'
Added loot for 'Ahn'kahet: The Old Kingdom'
Added loot for 'Drak'tharon Keep'
Added loot for 'The Violet Hold'
Added loot for 'Gundrak'
Added loot for 'Halls of Stone'
Added loot for 'CoT:Stratholme'
Added loot for 'The Oculus'
Added loot for 'Halls of Lightning'
Added loot for 'Utgarde Pinnacle'
Added loot for 'Naxxramas'
Added loot for 'Obsidian Sanctum'
Added loot for 'The Eye of Eternity'
Revamp of almost every Classic instance
Revamp of almost every BC instance
PvP:
Added PvP Level 80 Blue and Epic Sets (Savage/Hateful/Deadly Gladiator)
Added PvP Level 80 Blue Weapons (Savage Gladiator/Deadly)
Added PvP Non-Set Epics Level 80
Factions:
Added Argent Crusade faction
Added Frenzyheart Tribe faction
Added Kirin Tor faction
Added Knights of the Ebon Blade faction
Added The Kalu'ak faction
Added The Oracles faction
Added The Wyrmrest Accord faction
Revamp of Faction section
Sets:
Added Tier 7 10/25-Man Sets
Merged Tier 1/2 sets (sorted by class)
Merged Tier 4/5/6 sets (sorted by class/spec)
Merged Dungeon Set 3 (sorted by armor type)
Merged PvP Reputation sets (sorted by armor type)
Merged Arena sets (sorted by class/spec)
Removed class breakdown for AQ20 sets
Removed class breakdown for AQ40 sets
Removed class breakdown for ZG sets
Revamp of Tabard section
Revamp of Pre-60 set section
Revamp of Mounts sections
Added Non Combat Pets section
Interface:
Added 'prev' and 'next' buttons to many sets pages
Added 'prev' and 'next' buttons to many instance pages
Changed loot browser instance menu from sort by continent to sort by expansion
Events:
Hallow's End update
Crafting:
Revamped Alchemy section of the Crafting Module
New Profession: Inscription now included.

v5.01.04 (Nov 07, 2008)
Alchemy revamp complete
AtlasLootFu can now be reset with atlasloot reset functions
Many minor bugfixes

v5.01.03 (Oct 28, 2008)
Fixed T7 Paladin sets
Scourge Invasion updated
Removed the basic minimap button
Began re-arranging Alchemy

v5.01.02 (Oct 21, 2008)
Minor wishlist fixes
Localisation update

v5.01.01 (Oct 17, 2008)
Fixed the package

v5.01.00 (Oct 17, 2008)
New minimap button code, hopefully more reliable.

v5.00.02 (Oct 16, 2008)
Fixed a bug with Tier4/5/6 Sets being scrambled up
Fixed a bug with searching
Fixed a bug for displaying drop rates

v5.00.01 (Oct 15, 2008)
Updated for Atlas 1.12.2

v5.00.00 (Oct 14, 2008)
Compatible with WotLK
Switch from Ace2 to Ace3
Data from WotLK
Items in the wishlist now have a star next to them
LibDataBroker implemented (and hence Titan Panel support)
New Options menu
Loot browser now resizable in the options menu

v4.06.04 (Sep 05, 2008)
Attempted bug fix for people who have their boss buttons getting hidden behind Atlas

v4.06.03 (Aug 04, 2008)
Minor bug fixes

v4.06.02 (Jul 26, 2008)
Removed Atlas 1.11 compatibility
Fixed bug with Badge of Justice rewards
Fixed bug with prices not showing in the wishlist
Fixed bug in Alphamap integration

v4.06.01 (Jul 20, 2008)
AutoQuery has been removed, as it caused too many problems.  It has been replaced with a 'Query Server' button that will query all the items on the loot page.  If you get disconnected, you know which page to blame.
'Level 70 Instance Rewards' renamed to 'Badge of Justice Rewards'
Updated Brewfest section
Added loot table for Coren Direbrew (Brewfest)
Added Don Carlos loot table
Added new TCG loot from "Drums of War"
Readded previously removed vindicator items
Fixed Arena prices (Season 3)
Fixed a major Wishlist bug that caused crafted items to appear corrupted
The Quicklooks button now disables itself for search results and the wishlist
Minor updates/fixes/translations

v4.06.00 (Jun 25, 2008)
Compatible with the new Atlas 1.12 data format
New feature: Quicklooks, which allows you to bind loot tables to one of 4 shortcut buttons in Atlas or the loot browser
Added new TCG loot from "Hunt of Illidan"
Updated Midsummer Fire Festival section, including Lord Ahune
Arena prices and items for Season 4 adjusted
Many minor loot fixes/additions/translations

v4.05.00 (May 15, 2008)
New and improved searching system (some nice work from Kurax there)
All professions data available in the crafting module
More efficient memory use due to optimisations implemented in Patch 2.4
Added translations for all items
Completed Arena Season 4
Added M'uru loot table
Many minor loot fixes/additions

v4.04.01 (Apr 05, 2008)
Fixed the Atlas/Titan integration issue
Added new TBC set (The Fists of Fury)
Fixed the LBRS extra buttons
Upgrade to Babble 3.0
Many minor loot fixes/additions

v4.04.00 (Mar 29, 2008)
Updated for Patch 2.4
Updated for Atlas 1.11.0
Added Sunwell Plateau loot
Added Magisters' Terrace loot
Added new Faction - Shattered Sun Offensive
Added new Set - Latro's Flurry
Added new heroic items from Sunwell Isle
Added Reputation PvP sets
Added Arena season 4 sets/weapons (only a few IDs known)
Added Lord Ahune (Midsummer Festival)
Added new TCG loot (Servants of the Betrayer)
Removed old Level 70 PvP sets (no longer available)
Split crafted loot into its own module
Many minor loot fixes/additions/translations

v4.03.00 (Jan 25, 2008)
Added the 'WishList'.  Alt-click on any item to add it to the wishlist, alt-clicking on an item in the wishlist deletes it.  There are buttons added to the Atlas panel and the loot browser to open the wishlist.
PvP Non Set Epics now have the correct menu titles (Cloth/Leather and Mail/Plate)
'/atlasloot reset' now also resets the loot browser and options menu to the middle of the screen in case they are accidentally dragged away
Horde/Alliance PvP tokens and World PvP tokens switch depending on the faction of the character you are logged in as.  Due to this a number of loot tables have been cleaned up and had duplicate items removed.
Many minor loot fixes/additions/translations

v4.02.01 (Nov 30, 2007)
More adjustments for Atlas 1.10.3
Added '/atlasloot reset' command so reset the loot page you last visited if you get disconnected
Added '/atlasloot options' command to open the options screen without a FuBar/Minimap button
Added the new Vindicator epic items
Added the new March of the Legion trading card game in-game items.
Many minor loot fixes/additions/translations

v4.02.00 (Nov 13, 2007)
Updated for Patch 2.3
Updated for Atlas 1.10.3
Revamped the options screen
Added an option to automatically query the server for items instead of having right-click them all.  This can be turned on in the new options screen.
Corrected pre-60 dungeon loot to now be blue in line with Blizzard changes
Added Zul'Aman loot
Added Hyjal trash loot
Added Arena season 3 rewards
Adjusted prices for previous arena seasons
New menus for the PvP and Arena reward pages
New World Event: Brewfest
Added The Headless Horseman to the Hallow's End event
Split the Rare Mounts page to 2 - Classic WoW and Burning Crusade pages
Added new mounts to the Rare Mounts page
Added the new Heroic Badge items
New Menu for the Heroic Badge items
Many minor loot fixes/additions/translations

v4.01.05 (Sep 29, 2007)
Updated Version Check for Atlas 1.10.2

v4.01.04 (Sep 26, 2007)
Versioning Update for Patch 2.2
More BoE World Epics items added.
New World Events added: Skettis, Abyssal Council, Ethereum Prison
Pre 60 PvP gear added for WSG and AB.
Many minor loot fixes/additions

v4.01.03 (Sep 07, 2007)
French and German updates

v4.01.02 (Sep 05, 2007)
Updated for Atlas 1.10.1
Added BoE World Epics (thanks Lothaer!)
Reorganised the 'Collections' menu
World Events greatly expanded

v4.01.01 (Aug 20, 2007)
Update for German translation difference in Atlas 1.10

v4.01.00 (Aug 20, 2007)
Patch 2.2 Data included
Atlas 1.10 Compatible
Added 'World Events' section, more content there very soon
Added loot to the Entrace map mobs
Added the 2 centaur factions
Can now disable text notification when a LoD module loads (no message by default)
Added a 'Load Modules' button that manually loads all available LoD modules
Loot updates and translations
Bug fixes

v4.00.00 (Jul 15, 2007)
Core AtlasLoot mod now contains no data.  All data now contained in Load-On-Demand modules
Created 5 modules: AtlasLoot_OldInstances, AtlasLoot_BCInstances, AtlasLoot_RepFactions, AtlasLoot_SetsandPvP, AtlasLoot_WorldLoot
Total memory usage reduced where possible

v3.01.04 (Jul 08, 2007)
French and German bugfixes

v3.01.03 (Jul 07, 2007)
Bugfix: A file was still trying to access the old saved variables

v3.01.02 (Jul 07, 2007)
Fixed a bug where searching was not case insensitive if the item was unsafe
Saved Variables now use AceDB
Text messages generated by querying the server for items can now be switched off
Updated PvP item prices
Rep menus revamped
'Back' button moved to the bottom centre of the loot frame to be out of the way of long titles
TK Legendaries used in Kael'thas fight re-instated

v3.01.01 (Jun 23, 2007)
Updated PvP and Arena items for Patch 2.1.2 (thanks for your help gandharva)
Slight adjustment of loot table UI layout
Split Darkmoon Faire over two pages (one for cards, one for items)
The mod will now use Equipcompare if it is installed, if not it will use the Blizz version
French and Trad. Chinese updates
Many minor fixes/updates

v3.01.00 (Jun 12, 2007)
Replaced EquipCompare support with Blizzards own function (thanks to siena for fasttracking this)
Replace the 'Use Equipcompare' option wih a 'Show Comparison Tooltips' toggle
Updated for changes to Babble-Tradeskill
Fixed a bug in the BFD loot tables
Minor bug fixes and updates

v3.00.09 (Jun 06, 2007)
Fixed bug in search function
Further Item Link refinement
Trad Chinese Update
Minor updates/bug fixes/corrected typos

v3.00.08 (Jun 02, 2007)
Lootlink fix
Update to way Item Links in chat are handled
Minor updates and corrections

v3.00.07 (May 30, 2007)
Trad. Chinese Update
Many updates and fixes

v3.00.06 (May 29, 2007)
Trad. Chinese bugfix
Minor updates and fixes

v3.00.05 (May 28, 2007)
Fixed a bug with the Terokkar Forest PvP loot table
Removed obsolete data
Minor loot updates

v3.00.04 (May 26, 2007)
Fixes for French and Spanish
Minor loot updates

v3.00.03 (May 24, 2007)
Made the loot browser submenu persist when open and closed, only resets on relog
Partial French support (less likely to crash, but still mostly English)

v3.00.02 (May 23, 2007)
Capped debugging spam for those with tainted interfaces

v3.00.01 (May 23, 2007)
Updated for Atlas 1.9.1

v3.00.00 (May 22, 2007)
Updated for WoW Patch 2.01.00
Early data for the Black Temple, Hyjal Summit and new factions (note: Black Temple data only available via loot browser, no Atlas map yet)
Added Crafted Sets and more pre-60 sets
AtlasLootFu now built-in, no longer required seperately so delete any seperate AtlasLootFu folder
All localisation is done via AceLocale and Babble
Switched to a Dewdrop menu for the standalone loot browser
Rep Factions split into Original WoW and Burning Crusade
Major Loot Updates
Major Code revisions
Drop Rates for all 5 mans + Kara + Gruul's Lair (take Heroic drop rates with a grain of salt due to small sample sizes)

v2.04.00 (May 21, 2007)
Support for Atlas 1.9
Simp. Chinese Update
Added Pre-60 Sets to the collections menu (with help from Celellach)
Heroic Toggle now sticky (if you select a heroic table, all subsequent tables will be heroic [if available] until you switch back to normal)
Loot updates

v2.03.04 (Mar 18, 2007)
German fix
Loot update
Loot browser now toggles with minimap button and is closed with 'ESC' key

v2.03.03 (Mar 10, 2007)
Magtheridon fix for non-english clients.

v2.03.02 (Mar 10, 2007)
Fix for Atlas outland maps.

v2.03.01 (Mar 10, 2007)
Made searching case insensitive
Major loot update
Added new LvL 70 PvP and Arena Sets for healers
Adjusted Arena weapon prices in line with patch 2.0.10

v2.03.00 (Feb 21, 2007)
Support for AtlasExtras
Added search function (see 'Using AtlasLoot Search.txt' for limitation, etc)
Changed the way the minimap button is shown and hidden in an attempt to throw off addons that 'latch on' to the button and keep it shown.
Big Trad. Chinese update
Karazhan revamp
Huge Heroic Mode update
Added lvl60 Shaman PvP set for Alliance and lvl60 Paladin PvP set for horde
Updated lvl70 PvP reward prices
Added drop rates for Ramparts and Blood Furnace

v2.02.05 (Feb 11, 2007)
Support for AtlasCoT
Fixed the Priest T4 loot table
Updated the Violet Eye rep rewards
Many minor additions and corrections

v2.02.04 (Feb 05, 2007)
New version of AtlasLootFu (thanks Myrathi)
Added a Tabard section
Big French update
Many minor additions and corrections

v2.02.03 (Jan 27, 2007)
Added support for AtlasTempestKeep
Added drop locations for most Dungeon Set 3 pieces
Renamed to Addons folder to (hopefully) resolve Cosmos patcher issues
Added High King Maulgar in Gruul's Lair
Hellfire Ramparts revise to move Vazruden and Nazan's loot tables into the chest

v2.02.02 (Jan 23, 2007)
Urgent fix for the French client (Hegarol broke it!)

v2.02.01 (Jan 23, 2007)
Added support for AtlasAuchindoun
Made the AtlasLoot Panel toggle slightly smaller
Re-enabled lvl70 PvP rewards
Many minor updates

v2.02.00 (Jan 17, 2007)
Hacked clickable boss names into Atlas
Fixed a bug with the options menu
Minor Updates

v2.01.03 (Jan 16, 2007)
Updated to support the latest version of ItemSync

v2.01.02 (Jan 15, 2007)
Fix for the Atlas version check

v2.01.01 (Jan 15, 2007)
Bug fix for Alphamap users

v2.01.00 (Jan 15, 2007)
Updated to work with Atlas 1.8.6 (still completely Alphamap compatible)
Added optional FuBar Support (install AtlasLootFu to use it)
Added Toggle button for the AtlasLoot panel
Item set menus have been revamped for flexibility
Refined right-click server query
Unsafe items are now indicated with a red box around the icon
Item icons are now slightly bigger
Instance loot tables now split into 3 files for easier maintainence
Added the Keepers of Time
Added the Hydraxian Waterlords
Added the Bloodsail Pirates
Added the Scale of the Sands
Added Dungeon Set 3
Added lvl70 PvP Armor sets (Hidden as the items have since been removed from the game)
Added lvl70 PvP Accessories (Hidden as the items have since been removed from the game)
Added lvl70 PvP Non-set Epics (Hidden as the items have since been removed from the game)
Complete Tier 4
Complete Tier 5
Added loot tables for the Shadow Labyrinth
Added loot tables for the Shattered Halls
Added loot tables for the Steamvault
Added loot tables for the Mechanar
Added loot tables for the Botanica
Added loot tables for the Arcatraz
Added loot tables for Karazhan
Added loot tables for Hellfire Ramparts (Heroic Mode)
All Rep factions revised
Price displayed for PvP Armor sets and weapons
Price displayed for Arena PvP sets
Price displayed for Battleground rewards
Price displayed for Heroic Mode token turn-ins
Price displayed for World PvP rewards
Darkmoon Faire Ticket rewards now have prices displayed
Minor updates to 'old world' loot tables
Battleground rewards revamped

v2.00.01 (Dec 05, 2006)
Removed a minor Lootlink integration bug

v2.00.00 (Dec 05, 2006)
Updated for Atlas 1.8.5
Updated for WoW 2.0
Various code refinements
Added Ramparts, Blood Furnace, Slave Pens and Underbog loot tables
Added loot tables for Mana-Tombs, Crypts and Escape from Durnholde
Added loot tables for Sethekk Halls
Added Heroic Mode Instance Token Turn-ins
Added Sporeggar Faction
Added Cenarion Expedition Faction
Added Kurenai Faction
Added Honor Hold Faction
Added Thrallmar Faction
Added Tranquillien Faction
Added Scryer Faction
Added Aldor Faction
Added the Mag'har Faction
Added the Consortium Faction
Added the Lower City Faction
All World PvP Rewards added
Added Partial list of Tier 4 set pieces
Added Partial list of Arena PvP set pieces

v1.21.00 (Dec 03, 2006)
Update for Atlas 1.8.5
Fixed bug in Sunken Temple
Added Plugger to the Grim Guzzler
Added new User Interface
Added Cosmos Integration code
Added Minimap Button

v1.20.01 (Nov 02, 2006)
Fixed chatlink bug

v1.20.00 (Nov 02, 2006)
Major internal changes
Seperate section for PvP rewards
French Update
Korean Update

v1.19.04 (Oct 22, 2006)
Update for Atlas 1.8.4
Added the option to make the loot table background opaque
Added the option to show itemIDs at all times
Tome of Conjure Food VII Added
Fixed up Ring of the Earthshatterer
Fixed Darkmoon Faire typos
Alphamap Compatibility Update

v1.19.03 (Oct 13, 2006)
Atlas 1.8.3 compatibility update
Added AQ Opening quest chain to the AQ40 page
Trad. Chinese and German updates

v1.19.02 (Oct 08, 2006)
Atlas 1.8.2 compatibility update
Consolidation of AD rewards

v1.19.01 (Oct 07, 2006)
THIS RELEASE HAS NEW FILES, EXIT OUT OF WoW BEFORE INSTALLING
Added Book of Ferocious Bite V
Fixed T1 BoE bug
Update to T0 descriptions
Trash Mob data added to most instances (thanks to Coani for the research)
BRD Arena event fixed up, Houndmaster Grebmar dropped due to lack of space
New Reputation Tab Added
Added Rep rewards for all factions (thanks condor2k for finishing the research)
Naxx Update
Korean Update
German Update
French Update

v1.19.00 (Sep 19, 2006)
Included a small database of all AQ40 and Naxx tooltips as these items cannot always be queried with a right-click
Legendary Item page added in the 'Item Sets' window
Naxx Update
French Update

v1.18.05 (Sep 10, 2006)
Fixed a Zevrim Thornhoof typo
Added the recipes Lieutenant General Andorov sells
Made T0 trash drops more specific (where possible)
HUGE Naxx update
Minor German update
Change to make AtlasLoot frames work with AtlasQuest frames
Change to set display for external mods

v1.18.04
Fixed the Lootlink bug some were having
Headings no longer bring up tooltip fragments
Added Brood of Nozdormu Rings to the AQ40 page

v1.18.03 (Aug 29, 2006)
Right-clicking an unsafe item will attempt to get tooltip data from the server
Attempted improvements in Lootlink use in non-english clients (thanks KKram!)
Naxx Update
Updates for all localisations except Korean

NOTE: RIGHT CLICK QUERY USAGE
All you need to do is right click an item.  If it is in your local cache already,
you will just see a note saying the item is safe.  If the item needs to be fetched
from the server, you will see a message to that effect.  Keep right clicking until
that message goes away.

If you have right clicked on an item that has not dropped on your server (or in your
battlegroup) you will either be disconnected or the 'querying server' message will
not go away no matter how many time you click.

NOTE: NOT A BUG
The introduction of cross server battlegrounds has brought some interesting
challenges as far as loot linking goes.  In many cases, you can get the tooltip
for an item as someone in your battlegroup has it, but you cannot link it in a
chat channel as it has not dropped on your server.  As a result, I can no longer
guarantee safe item linking, only safe viewing of tooltip data

v1.18.02 (Aug 23, 2006)
Updated version check for Atlas 1.8.1

v1.18.01 (Aug 23, 2006)
Changed (no iteminfo) to (unsafe) in the English translation as the old text was confusing people
Expanded drop rates in Naxx to a few more bosses well and truly on farm
Fixed Armaments and Regalia drop rates in AQ40
Added error tooltip for 'unsafe' item links
Minor formatting changes
French Update
German Update

v1.18.00
New directory structure
Minor loot re-arranging to accomodate changes to Atlas 1.8
World Boss tables now accessible through GUI
Added Death Knight Darkreaver to Scholo
Added Lord Hel'nurath to DMW
Tier 0.5 Set Added
Drop locations added to T0, T1, T2 and T3 set descriptions
Fixed major XML bug
Added PvP Weapons
Added menu to access all sets and the options screen
Small fix for non-Atlas mods
Chinese, German, English and French pretty much up to date

v1.17.04
German, French and Chinese (Trad. and Simp.) updates
Naxx fixes

v1.17.03 (Aug 02, 2006)
Added PvP, T2, T1, T0 Armour sets (thanks to Asurn for helping with data assimilation)
Removed the default 'Boss:' prefix from headers that didn't need them
Trad. Chinese Update

v1.17.02
French, German and Trad. Chinese updates

v1.17.01
Bigger Buttons
Fixed problem for external addons hooking into Atlasloot
Attempted fix for Noth text in the German client, let me know if it works.
Attempted fix for localisation of set names, let me know if it works
Fixed framestrata error appearing in FrameXML.log
Simp. Chinese update

v1.17.00 (Jul 23, 2006)
Set interface re-programmed
Added T3 Sets to Naxx page
Added the Observer to DM North on Gordok's table
Simp. Chinese Update
Naxx Update

v1.16.03
VanCleef's Head graphic fixed.
Added ZG NR Enchant
Added Ribbly Screwspigot
Added Rockshard Pellets and Murloc Skin Bag
German Update
French Update and bugfix

v1.16.02
Fixed a number of typos
Viper, Defias and Scarlet sets added.
Localised armor set text
Quest items needed for armor sets localised
Reordering of some boss loot
Naxx updated

v1.16.01 (Jul 03, 2006)
German update for Atlas v1.7.5
Bug fix for people without Atlas installed
Drop Rates added to SFK, RC, SM, Uld, RFD, ZF, Mara, ST, Deadmines, WC, BFD, Stockade and Gnomeregan (thanks Pownas!)
Naxx Update

v1.16.00 (Jul 01, 2006)
Korean Update
German Update
French Update
Major XML and LUA reworking (HUGE Props to Telic for the ideas and most of the implementation)
Stub for Fixed price DKP entry
Added BRD Houndmaster
Fixed some dodgy MC colouring
More Naxx data :-)

v1.15.07
Simp. Chinese Update
French Update
More Naxx data :-)
Added BRD Princess

v1.15.06
French Update
Korean Update
German Update
Updated Ouro Loot
Updated Naxx Loot
Added Tablet of Flame Shock VI
Added better bag descriptions and Binding of the Windseeker description
Added Libram of Divinity

v1.15.05 (Jun 24, 2006)
Fixed Red Dragonscale Breastplate (en)
Trad. Chinese Update
Added Primal Hakkari Idol
Added the Polymorph: Turtle book for Mages
Added some more Naxx data
Added data to the Grim Guzzler in BRD
Added Shadowpriest Sezz'ziz in ZF (en)
Added a missing Ouro drop

v1.15.04 (Jun 23, 2006)
Updated Simp. Chinese
Added new ZG drops
Fixed popup bug on non-english clients

v1.15.03 (Jun 22, 2006)
Fixed ZF to mach Atlas v1.7.4
Seperated the Tier 0.5 Summonables to match Atlas v1.7.4 English (other languages as soon as Atlas is ready)
Now checks the Atlas version is compatible.
Completed WSG Pants Data
Filled in some gaps in Naxx

v1.15.02 (Jun 21, 2006)
Fix to match Atlas v1.7.4 UBRS changes
Upgraded ZG and AQ20 Sets to Epic Quality.

v1.15.01
Trad. Chinese Update
Updated toc for patch 1.11

v1.15.00
Added Warsong Gulch Rep Rewards
Added Zandalar Signets
Added ZG Trash drops
Added BRD Chests
Minor AQ Corrections
Implemented Phase One of database and localisation optimisations
French and German Updates
Reordering and cleanup of loot tables.

v1.14.04
Updated French localisation

v1.14.03
Bug fixed CORRECTLY this time :-)

v1.14.02
Minor bugfix
Minor German update

v1.14.01
Updated German, Korean, Simp. Chinese and Trad. Chinese translations
Drop Rate text localised
Safe item links now enabled by default

v1.14.00 (Jun 13, 2006)
Added Alterac Valley Rep Rewards and Arathi Basin Rep Rewards (lvl60)
Added Stubs for Naxxramas loot using all the test server data I could find

v1.13.01 (Jun 12, 2006)
Updated Traditional Chinese and Korean translations
Fix to boss names having the first couple of letters cut off in the German translation.

v1.13.00 (Jun 11, 2006)
Updated German, Simp. Chinese and Trad. Chinese translations
Now asks for setup when run for the first time.
Added Dire Maul Books
Tweaked Lootlink Handling
Re-arrangement of AQ20 Class Sets
AQ and ZG Class Sets now labeled with class name
Moved Solekar Flamewreath to his own table (de only)
Added AQ Enchants
Added Tier 0.5 Quest Summonables
Added ZG Enchants

v1.12.10
Updated French, German, Simp. Chinese and Korean translations
Added Ace of Warlords, Ace of Portals

v1.12.09
Updated French and German localisations
Added Smoking Heart of the Mountain to Lord Roccor (BRD)
Added Solakar Flamewreaths loot to 'Father Flame' on UBRS
Added Cat Carrier to Cookie (Deadmines)
Added Thick Obsidian Breastplate plans to Skeram (AQ40)
Added Onyxia Hide Backpack to Onyxia
Added Pusillin's unique drops to 'Pusillin Chase Ends' DM East
Added Knot Thimblejack's Cache
Flagged and seperated T0 loot in UBRS (en, de)
Added better profession descriptions on plans/schematics/etc (en,de)

v1.12.08
Fixed some more typos in the English version
Updated German Translation
Added World Spawns in anticipation of a new Atlas version and to give translators time to work on it.

v1.12.07 (Jun 04, 2006)
Updated Simplified Chinese translation
Fixed a number of typos in the English translation

v1.12.06 (Jun 03, 2006)
Added Traditional Chinese support

v1.12.05 (Jun 03, 2006)
Font fix for asian languages (I hope!)

v1.12.04 (Jun 03, 2006)
Updated Korean Translation
Better use of artwork (now an atlas symbol next to bosses with loot)

v1.12.03
Fixed minor xml oversight

v1.12.02
Added Chinese translation from unauthorised thewow.cn version

v1.12.01
Slight positioning change to deal with long text (like in ZG)
Added details to ZG item sets

v1.12.00
Added Korean localisation provided by k2hyun
Fixed French localisation to work with Atlas 1.7.2
Added a symbol to the right of boss line to indicate if there is loot. Changes color to indicate currently selected boss.

v1.11.07
Added AQ40 Class Set

v1.11.05
Updated French and German Translations
Added AQ20 and ZG Class Sets
Minor changes to fit Atlas 1.7.2

v1.11.00
Updated French and German Translations
Converted all text strings to global variables for translation
Partial translation of the Options menu
English localisation cleanup

v1.10.04
Fixed Options screen bug regarding optional dependancies being removed
Fixed MC Random Boss Items
Updated German translation (thanks Asurn)

v1.10.02
Review of English localisation. Fixed some bugs and layout issues.

v1.10.00
Patch 1.11 Ready!
Reorder and cleanup of MC (en)
Fixed Felheart Slippers bug
Fixed Blessed Qiraji Warhammer bug
AtlasLoot no longer overwrites the colour of the text in Atlas. This was prompted by the awesome looking Naxx map with coloured text in Atlas 1.7. Clickable bosses still highlight on mouseover though.

v1.9.5
Random Boss loot in MC added
Scholo complete
ZG Summonables added
Total revamp of German translation (thanks Asurn)

v1.9.1
DM North Fix (de)

v1.9.0
Minor xml update
Fixed floating Options title
Fixed the boss titles
Added start of Scholo

v1.8.0
Fixed bug causing tooltips to scroll off the edge of the screen.
Minor Thekal fix

v1.7.0
Atlas 1.7 Compliant
Added bug fix to deal with Atlas's new startup
Fix to DM North (de) due to text change in Atlas 1.7
Fix to SM (de) due to text change in Atlas 1.7
Added missing UD Strat loot

v1.6.08
Minor bug fixes with the German client
Sorting of lbrs loot

v1.6.07
Fixed minor bug in German client.

v1.6.06
Completed Strat and LBRS leaving only Scholo to do
NUMEROUS loot fixes
Fixed bug with boss names not displaying properly

v1.6.01
Fix AQ20 Formatting
Fix AQ20 for German Client

v1.6.0
Dressing Room Support (control-click on items)
Item Highlighting on mouseover
French Localization file
Ability to turn off EquipCompare (except with ItemSync tooltips as ItemSync uses the GameTooltip)
Added asurn's data: UBRS, Strat (partial), DM Tribute and many drop rates (That was AWESOME)

v1.4.06
MASSIVE cleanup of the code base
Added AQ40 Trash drops
Added ZG Shared drops (Primal Hakkari Stuff)
Added AQ20 Class Books

v1.4.01
Added support for EquipCompare

v1.3.01
Fixed bug where atlasloot was highjacking the /atlas command

v1.2.08
Fixed problem with Garr
Added drop rates to Blackwing Lair
Added Blackwing Lair Trash Mobs epic drops

v1.2.06
Fixed ZG Bug
Added code to allow drop rate to be added to tooltips, regardless of tooltip mode.

v1.1.05
Huge thank-you to asurn for DM, BRD and Shadowfang info

v1.1.01
-First Version, same as Pernicius's v1.03a version, but without the ItemSync tooltip bug
