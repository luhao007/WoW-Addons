# AllTheThings

## [4.5.12](https://github.com/ATTWoWAddon/AllTheThings/tree/4.5.12) (2025-08-03)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.5.11...4.5.12) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- [Logic] [Retail] Migrated specialization APIs  
- [Logic] Added some WOWAPI wrappers and cleand up Spell module for 11.2  
- [Parser] No longer merging various functions into all Sources of the Item (this is problematic since the functions are expected to be Source-specific. i.e. an OnInit which assigns a 'u' value in one place does not inherently mean that same 'u' value should be assigned in all places for that Item)  
- [DB] Fixed Timely Goodie Bag showing as removed in some cases  
- [DB] Fixed Timely Goodie Bag and all content from appearing removed  
- [DB] Added modID to some Hallowfall drops to represent their proper in-game state when dropped (anyone know the Elite modID?)  
- Timeline out Enterprising Dungeon Master  
- Added correct currency amount for Cata Archaeology Finds.  
- Added correct currency amount for WotLK Archaeology Finds.  
- Added correct currency amount for TBC Archaeology Finds.  
- Added correct currency for Classic Archaeology Finds.  
- Updated Russian localization  
- Added all providers and maps of Archaeology Finds.  
- Fixed patch entry in NYI quest items.  
- MOP: Moved around the reroll currencies to their respective instances or zones.  
- [DB] Mists: JC - Serpent's Heart and Primal Diamond are available with ToT  
- MOP: Added a coordinate specific to classic for Bai-Jin the Butcher.  
- MOP: Moved The Golden Lotus related content to their own Expansion Features file.  
    Moved breadcrumbs for other zones out of Vale and into their respective files.  
- Clean up and timeline BFA Silithus file, clear parser warning, fixes #2126  
- [PAT] Updated source file format based on current standards.  
- MOP: Adjusted some Vale achievements.  
- Alani is not really a rare.  
- MOP: Updated the Grand Commendations to be collectible as heirlooms.  
- MOP: Moved The Lorewalkers related content to their own Expansion Features file.  
- [Parser] OnInit no longer incorrectly reports missing a return when there's a shared DB function reference instead of a function.  
- Updated timelines in the Legendary: The Black Prince expansion feature header.  
- Show the Legendary: The Black Prince expansion feature header when in the Veiled Stair mini list.  
- MOP: Added objectives to all Jade Forest quests.  
- Fix some reported errors, fixes ##2113  
- Parse Mists  
- [DB] Mists: phase a bunch of BS items and recipes  
- [DB] Mists: improve description for Vale phasing  
- [DB] Classic: nuke static Engi profession file  
- [DB] Classic: nuke static BS profession file  
- [DB] Mists: a few Inscription fixes  
- [DB] Mists: Tome of Illusions is only available from Legion  
- [DB] Classic: nuke static Enchanting profession file  
- [DB] Classic: nuke static Alchemy profession file  
- [DB] Fix preprocessor end  
- [DB] Add timeline to a few Brawler's Guild NPCs  
- [DB] Mists: phase a bunch of Tailoring items and recipes  
- [DB] Classic: nuke static Tailoring profession file  
- [DB] Classic: nuke static NYI recipe cache  
- [DB] Mists: phase a bunch of LW items and recipes  
- [DB] Classic: nuke static LW profession list  
- [DB] Classic: put Dragonscale/Ele/Tribal LW headers under Classic header  
- Corrected the game version and note about the CN new year promo (#2125)  
- [PAT] Updated source file format based on current standards.  
- The wizard is pleased.  
- The wizard said bash and powershell are two different things. YML is scary.  
- Descriptions are a last resort when something cannot be expressed cleanly through data  
- PTR 11.2.0: "Otherworldly Ecologist" completed  
    - Added a few more "Ecological Variety" Daily Quests  
    - Added two more World Quests  
- I asked a GitHub Action wizard what I should do, let's see if the wizard was right.  
- Let's try that again.  
- YML is a trash language, change ym(l) mind.  
- removed i(152873), -- Talanji's Salutary Scepter from sourceless. its sourced under quantum with a special note  
- marked chinese time limited promo as removed (not sure if it really did, was said as limited time promo and it hs been running for 6+months now)  
- MOP: Updated Ambersmith Zikk and a handful of other Dread Wastes things.  
- Moved the crs list from the cracked egg to the primal egg that actually drops  
- Updated The Veiled Stair and the Legendary Cloak expansions feature file.  
- Updated ensembles to utilize iensemble and converted most Mark of Honor costs into the moh helper function.  
- [DB] Fixed some Delve timelines  
- [Locale] Profession headers part 3 WoD-Legion  (#2122)  
    Profession headers part 3  
- WOD: Updated the PvP Seasons file to not have items nested within ensembles.  
- [Logic] Retail: GetSearchResults can now return if the search result is still 'working' (since filling takes place on the search result, we may fill content which has not yet been determined in some cases, thus leading to a working group)  
    [Logic] Retail: Refactored some Upgrade flow to improve situations where Upgrades failed to be determined when being filled. [Tooltips with Upgrades should now reliably show all Upgrades and only cache once no longer working on generating Upgrades]  
- More tab spellcasting  
- Cast the Tenderis Formatica and Indentium Tabularis charms to compress the Trading Post and scourge bad tabs  
- [DB] Another provider for Fashion Week  
- Casted the spell "Avada Kedarkal" on most Mark of Honor costs to make them use the "moh" shortcut (that also applies timelining to the cost inherently)  
- Timeline out July Trading Post  
- [DB] Fixed remaining 'Cloth Scavenging' variants to have proper lockCriteria  
- [DB] Mists: add Quests crafted items to DB references (Blingtron 4000) and fix phasing for 2 SoO Engi pets  
- [DB] Unintended note and unended preprocessor  
- Updated description for feral hidden artifact appearance.  
- [DB] WotLK - ICC: Removes repeated words. Removes repeated words.  
- [DB] WotLK Ench./JC/Ins./LW/Tailoring  
- Adjusted Arsenal: Draenor Challenger's Armaments to use iensemble... Someone should double check this.  
- Adjusted Draenor Arsenals to use iensemble.  
- MOP: Updated MOP\_PHASE\_LANDFALL to a later build to prevent it from being defaulted on during the current phase.  
- Barnaby wasn't added until 5.1. (Landfall)  
- [DB] Added the duplicated BC S2 PvP pieces purchased via BC S3 Tier tokens sold by Soryn  
- [DB] Added a note post 11.1.7 about the broken Warglaive of Azzinoth collection (go submit your bug reports to Blizzard if you want them fixed!)  
- The Tillers can actually be started at level 85.  
- [Locale] mop headers  (#2121)  
    * Cata and mop headers in es and mx  
    * The black prince header in all languages  
- * Partial Refactor of Catalyst handling  
    [Parser] ItemConversionDB refactored slightly to contain additional information for Catalyst determination of old content items  
    [Logic] Refactored some Catalyst logic to properly determine upgrade level on old items (because Blizzard stops telling us for literally no reason)  
    [DB] Adjusted upgradeTrackID for Sepulcher to work properly with adjusted logic  
    [DB] Cleaned up Aberrus Tier/Catalysts/timelines  
    [DB] Removed duplicated Catalyst from Zaralek Cavern  
- [DB] Fixed description on Revival Catalyst Console in VotI  
- [Misc] Some comments  
    [DB] Added DF S2 Tier structure  
- Updated some of the Tyrannical Gladiator ensembles.  
- Remnants of Anger now also appears in the Townlong Stepps mini list.  
- [Parser] Added an 'applyDataSelf' function to easily replace some uses of bubbleDownSelf for 'timeline' to avoid extra busy-work in reformatting of the data  
- Updated Prideful gladiator ensembles.  
- Add new Twitch Drop pet  
- Adjusted MOP era Arsenals (Ensembles coming soon)  
- Source NYI PVP items  
- Adjusted Cataclysm era Ensembles / Arsenals timelines and declaration.  
- Barnaby Fletcher is no longer breaking the parser.  
- [DB] Removed the duplicated Catalyst group from Forbidden Reach  
- Wrong timeline  
- 11.2.0 Professions and some upkeep/cleaning  
- Added objectives and missing source quests for The Tillers quests.  
- [PAT] Updated the format of the job to allow for no changes to not incorrectly flag the job as a failure based on Runaway's Copilot. No changes is GOOD!  
- [Contrib] 'Heart of the Forest' map is smol  
- More consistent checkboxes on the automated content  
- Re-ordered the Features descriptions a little bit  
- [Logic] Retail: Fixed Trading Post unobtainable filter getting reset  
- [DB] 'Synchronous Thread' achieve is automated properly  
- [PAT] Only change providers to qgs for "q" object types. (This fixes an issue where objective objects were having quest givers assigned erroneously)  
- Compress some Trading Post listings  
- Clear parser warning on reverse sorted quest objects  
- Changed the output of PAT to be either -1 for an error or 0 for not an error.  
- [Locales] Update objects in all languages and a few of settings in es and mx, DS minilist fix (#2114)  
    * strings in es and mx  
    * Love in the air object in mx and tw  
    * Undermine objects in all languages  
    * Kobold Knights objects translated to all languages  
    * Undermine objects  
    * DF objects missing translations in mx, cn, ko and tw  
    * Excavation Site 9 objects in all languages  
    * Azj-Kahet treasure missing mx and tw translations  
    * Fixed object translations for the Warlock's secret pet forms.  
    * undermine objects translations  
    * Delves objects translations  
    * Undermine epilogue objects translations  
    * Undermine objects translations  
    * Dastardly duos and visions revisited objects translations  
    * Void mount objects translations  
    * translations of expand minilist to es and mx  
    * Trading Post filter to es and mx  
    * Fix the minilist of LFR Dragon soul  
    * Fixed mixed translation of a object in korean in undermine.  
    * First part of translations to the profession Headers  
    * C.H.E.T.T. header to all languages  
    * Profession headers part2  
    * Header to the tillers in all languages  
- cn update (#2120)  
- Removed an untrue statement from the Dynamic Header IDs file.  
- Fixed a syntax issue that PAT didn't like.  
- [DB] Reparsed for line endings.  
- [Parser] Now actually writes \r\n for its last line.  
- [DB] Fixed VOTI timelines & catalyst being entirely considered removed :weary: Only LFR is removed  
    [DB] Some other timeline fixes  
    [Parser] expansion() now forcibly clears any timeline assigned to it to prevent easy cross-contamination between files of timelines  
- The tillers overhaul (#2119)  
    * Moved the Tillers to their own Expansion Features file.  
    Added a section for Harvesting within the Tillers header.  
    Added phase requirements for the Work Order daily quests.  
    * Added a map constant for VALLEY\_OF\_THE\_FOUR\_WINDS\_CAVERN\_OF\_ENDLESS\_ECHOES.  
    Added a function template for buddy-based reputation calculations.  
    * The Tiller buddy quests are no longer nested under the faction itself. (Factions should not act as headers)  
    * Classic: Now properly handling buddy reputations in the Quests lib.  
    * Added objectives to all Tiller's Daily and Repeatable quests.  
    * Added missing weed npcIDs.  
- [Parser] Some timeline/hierarchical field fixes  
    * Timeline processing now properly handles taking the first entry within the proper version scope when multiple of the same change end up merged together in the same timeline  
    * Hierarchical Field Adjustments improved performance in most cases  
    * Fixed handling of NonRepeat fields to actually scan all child groups for cleaning regardless of their values  
- [Logic] Fixed an issue with recursive information types where it could fail to find a valid recursive value when viewed in the Main list  
- PTR 11.2.0: "Secrets of the K'areshi" completed  
    - Re-structure Treasures a bit. Add data for the missing ones. All but 1 are done.  
- [DB] Added HQT from skipping covenant intro to 'Growing in Power' to prevent inaccurate reports  
- Add traderstender helper function, parse  
- Add August 2025 Trading Post  
- Edit some bubbleDowns, add maps to HV rewards  
- [Parser] Now exporting auto-sources, DynamicHeaderIDs, and Dynamic Objects with \r\n at the end of the file.  
- Fix nesting  
- Give AZ Essences a timeline  
- Attempt to fix more bad header timelines  
- Attempt to fix some bad header timelines  
- [DB] ... forgot one  
- [DB] It's possible to purchase SL Conduit-learning items prior to being able to use them. They're now linked to the Achievement which enables them to be usable  
- Revert "[Action] Try to make Commit Changes always return success."  
- [DB] 'Re-Introductions' is actually a breadcrumb  
- [Action] Try to make Commit Changes always return success.  
- sorted classic "achievements" (you got them by transfering to wotlk after som ended)  
- [PAT] Updated source file format based on current standards.  
- [Action] Try to make Commit Changes always return success.  
- [DB] WotLK Alchemy + Cooking  
- [Action] Try to make Commit Changes always return success.  
- [Logic] Tooltip adjustments  
    * Retail: The rare case of colorized-object tooltip names now properly grabs ATT results for the tooltip (i.e. Bountiful Delve caches)  
    * Simplified some indenting and function calls  
- [PAT] Updated source file format based on current standards.  
- [DB] Echoing Fragment are account-wide quests  
- [Logic] Retail: Some adjustments for 'Total Cost' calculations  
    * No longer including non-collectibles when in Debug mode  
    * Now recursively adds Costs for the Costs within the Total Cost group such that all nested Costs are shown at once  
    * Costs which themselves have further costs or providers are now highlighted and sorted to the end of the Total Costs group (to help indicate they are not an immediately-available Cost)  
- [DB] 'Faceless Mask of the Nemesis' technically has a cost not providers  
- [DB] 'Weaponsmithing, Reborn' is properly automated  
- Ran PAT on the Standards.lua file.  
- PTR 11.2.0: "Hard K'arroc" section of "Otherworldly Ecologist"  
    - Warrant: Grubber  
    - 4 more "Ecological Variety" Daily Quests  
    - "Dangerous Prowlers of K'aresh" coordinates  
    - Skyriding Glyphs and Quests  
    - Ba'eth's Request Storyline  
- Some Mounts sorted away  
- Unsorted 11.1.5, 11.1.7  
- Added 7.0.3 QI's (N+Q, " thru A)  
- 11.2.0 Unsorted some cleaning up  
- TWW S3 Dungeon Loot tables  
- exact number is better  
- wow 20th bday ended 6 months ago  
- [DB] A Flash of Bronze... is unavailable in retail  
- [Logic] Retail: Removed extraneous runner line  
- Update The Forge of Souls with InstanceHelper  
- Updated the PAT action to trigger every day at 7:00 UTC.  
- GitHub apparently wants \r\n, not just a newline character.  
- [PAT] Updated source file format based on current standards.  
- Indenting... really now. Thanks GitHub.  
- Added a GitHub action that may or may not work for running PAT manually.  
- [PAT] Retail ATT devs getting what they've wanted? Reorganized the priority of sourceQuest, sourceAchievement, altQuest, altAchievement, icon, and description. The next run of PAT will apply these changes to the database.  
- Update editorconfig for Newlines  
- Rebuilt all DBs to ensure that nothing was broken by the update.  
- [PAT] Applied updated trimming standard to all source files.  
- [PAT] Updated to include a newline charactera the end of the source files rather than trim it away.  
- Added the source code for the Process Automation Tool (PAT).  
- [PAT] All of the Parser folder is now under PAT's jurisdiction.  
- Fixed some whitespace in Blackrock Foundry that was causing PAT to have panic attack.  
- For real this time  
- Fix some reported errors  
- [PAT] All non-Blackrock Foundry D&R Files have now received a PATdown.  
- [PAT] All Outdoor Zone Files have now received a PATdown.  
- [PAT] All Shadowlands Outdoor Zone Files have now received a PATdown.  
- Fixed a bug involving nested npcs directly under quests with no additional context.  
- Fixed a bug that was preventing PAT from completing Krokuun involving non-standard block comment enders. (]] and --]] vs ]]--)  
- [PAT] All Zandalar and Nazjatar Outdoor Zone Files have now received a PATdown.  
- [PAT] All Kul Tiras Outdoor Zone Files have now received a PATdown.  
- [PAT] All Argus Outdoor Zone Files have now received a PATdown.  
- [PAT] Half the Broken Isles Outdoor Zone Files must have been hiding in an illusion and have now received a PATdown.  
- Automated some more Broken Isles achievements while I'm digging around in here...  
- No Shellfish Endeavor is now automated and no longer makes PAT angry and storm into her room.  
- [PAT] All Broken Isles Outdoor Zone Files have now received a PATdown. (blame Khad'gar)  
- [PAT] All Draenor Outdoor Zone Files have now received a PATdown.  
- Fixed a malformed description in Feline Friends Forever  
- Cleaned up some comments in Shrine of the Two Moons.  
- Fixed a bad bulk comment format in Orgrimmar.  
- Fixed the Uldum assault file, it had some wonky commenting going on in there.  
- Fixed the commented out version of Most Loyal (Sylvanas Version) that got royalled scuffed by PAT.  
- [PAT] Found some more Expansion Features  
- [PAT] All non-Outdoor Zone and Dungeon Files have now received a PATdown.  
- [PAT] No longer having a seizure related to bulk comments. (These are now parsed the same as preprocessors)  
- [PAT] Standrard update: While odd, situations where breadcrumb/worldquest and repeatable are on the same quest, breadcrumb should go first.  
- Fixed some weird indenting in the Peak of Serenity.  
- [PAT] Enforced file trimming and "g" to "groups" conversion to every source file within the Parser folder. (Parser still exports this as "g", but for source files we want the full and proper name "groups" to be used so that we can search for "g" without colliding with every file not conforming with PAT standards.)  
- Update Contributor.lua  
- Update The Wandering Isle.lua  
- Adjusted the Standard.lua file to indicate that you don't need to specify the map name anymore, you should use a constant.  
- [PAT] Name is now sorted to the top underneath AQD/HQD if they exist.  
- Fixed an indent in Stormwind that was giving PAT a seizure.  
- Adjusted "Crieve's List"  
- [PAT] Here are the new standards.  
- [PAT] Ran it against the Standard.lua file.  
- [PAT] All PVP, pre-WOD Expansion Features,  files have received a PATdown.  
    Also converted "g" to "groups" in the files I'm working on next. (PAT didn't like the format for modern dungeons, fixing it to understand what to do)  
- [PAT] All World Drop, Event, & Crafted Items Files files have received a PATdown.  
    Also trimmed all files even if there were no other changes detected. (PAT no longer forgets to do this)  
- [PAT] All Mists of Pandaria Dungeon Files files have received a PATdown.  
- [PAT] All Cataclysm Dungeon Files files have received a PATdown.  
- [PAT] All Wrath of the Lich King Dungeon Files files have received a PATdown.  
- [PAT] All Burning Crusade Dungeon Files files have received a PATdown.  
- [PAT] All Classic Dungeon Files files have received a PATdown.  
- [PAT] All Northrend Outdoor Zone files have received a PATdown.  
- Fixed a scuffed field. (This is why we always end a line with a comma...)  
- [PAT] All Outland Outdoor Zone files have received a PATdown.  
- [PAT] All Eastern Kingdoms files have received a PATdown.  
- PTR 11.2.0: Good chunk of "Otherworldly Ecologist" is completed  
- [PAT] Eastern Kingdoms getting a PATdown! (part one)  
- [PAT] All Kalimdor files have received a PATdown. Comments are now sorted just before groups in priority to fix a priority bug in preprocessors with comments.  
- [PAT] Kalimdor getting a PATdown now. (part three)  
- [PAT] Kalimdor getting a PATdown now. (part two)  
- [PAT] Kalimdor getting a PATdown now. (part one)  
- [PAT] All Pandaria files have received a PATdown.  
- [PAT] Some more automation  
- [PAT] No longer incompatible with preprocessors. (It inherently uses the priority of sub-properties within the preprocessor now.)  
- [PET] Adjusted some more formating using updated Provider Automaiton Tool logic.  
