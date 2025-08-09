# AllTheThings

## [4.6.1](https://github.com/ATTWoWAddon/AllTheThings/tree/4.6.1) (2025-08-08)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.6.0...4.6.1) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- [DB] Cataclysm Cooking reagents  
- [DB] Couple K'aresh fixes  
    [DB] Many account-wide quests identified manually (I should probably make another script for this...)  
- [Logic] Added an override for Criteria getting their name so that some Criteria will retrieve their name a bit more reliably (you know since GetAchievementCriteriaInfoByID and GetAchievementCriteriaInfo return different data for the same Criteria. Makes sense.)  
- [DB] Couple more account wide quests  
- Sort some K'aresh pets  
- [DB] Some weekly/account-wide K'aresh Warrant stuff  
- [DB] TWW Discovery recipes & salvage items adjusted  
- Fix some minor 11.2 errors  
- [Logic] Fix and add a couple more ignored Vignette reporting for Phase Conduits  
- [DB] Fixed Fractured Spark linked to a pet  
- [Locale] profession part 5 (#2135)  
- Classic: Fixed a bug with Reputation Quests.  
- Fix some more 11.2.0 Errors  
- K'aresh: Small addendum to a description for "Phase-Lost-and-Found" achievement  
- K'aresh: Source Delve Sturdy Chests and fix reported errors  
- Fixed the tooltip for Vacant Destroyers.  
- K'aresh: Half-Disgested Journal drops from Creepers in Untethered Space  
- Update Eco-Dome A'dani with InstanceHelper  
- Fix some reported 11.2.0 Errors  
- For the White Pawn quest it's the Alliance Bodyguard, not the Horde Seadog.  
- Moved the "The Arena of Annihilation" quest to the Arena of Annihilation scenario file.  
- The Kun-Lai Kicker is already listed in the Brewmoon Festival Scenario.  
- Moved MoP classic HQT out of retail.  
- [DB] Mists: add map ID constants for Shrine of Two Moons and Shrine of Seven Stars  
- [DB] Mists: gate Heroic Deeds behind Escalation phase and timeline properly  
- [DB] Mists: gate Tiny Carps behind ToT phase and timeline them  
- [DB] Mists: gate Balanced Trillium Ingot and Chief Engineer Jard's Journal behind SoO phase  
- [DB] Mists: gate Pandaren Treasure Noodle Cart Kit behind SoO phase  
- [DB] Changed some TWW Eng recipes to use 'salvagerecipe' shortcut  
- [Parser] Added a new shortcut to help us list 'salvage' Recipe outputs more cleanly in ATT  
- Add pre-SoO coordinates for Sahn Tidehunter  
- [DB] Mists: add internal note for Into The Vale quests, they won't be added to Classic (confirmed by Blizz)  
- ..  
- [DB] Fixed Item provider source for 'Swap Meet'  
    [Parser] Reparsed  
- [Logic] Retail: Fixed an issue where Total Cost stopped tracking non-collectible container-type results in the popout (Ensembles, etc.)  
- [Logic] Ignore Phase Conduit vignettes  
- Learning is a practice of repetition and analysis  
- [PAT] Updated source file format based on current standards.  
- [DB] Sourced a missing quest provider  
- [DB] Remove extra coords from Heka'tamos since the locations change daily and are marked on minimap  
- [DB] Couple K'aresh rare updates  
- Fix more 11.2.0 errors  
- [Misc] HQT note  
- [DB] Fixed encounters for Eco-Dome Al'dani  
- [DB] Contract quests are AW  
- [DB] Fixed Hermes NYI Pet taking over the new Spark item  
- added daily/weekly lockout based on eremeir screenshot  
- Fix some reported 11.2.0 Errors  
- [DB] Some coords for Heka'tamos interactibles  
    [DB] Fixed n instead of filter  
- 2 more rares HQT moved  
- pahse diving vendor  
- [DB] More timeline semantics  
- more rares and world quests  
- flightpath system and rare mob description removal  
- treasures are now under phase diving  
- moved phase diving rares to phase diving  
- [Logic] Removed some useless Quest-related fields from Event headers  
- [DB] Don't need to 'sym' BattlePets which are Sourced with possible coord(s)  
- [Parser] Adjusted wording of 'EXPAND\_DIFFICULTY\_CHECKBOX\_TOOLTIP' to more closely represent the actual logic without needing the context of 'Expand Minilists' being a linked required setting  
- Linked Mishi to the objective for Last Piece of the Puzzle.  
- [Logic] Retail: The 'Expand Mini Lists' setting now applies to the Minilist and any created Popout ATT windows!  
    * Retail: 'Expand Mini Lists' is separate functionality from 'Expand Current Difficulty' and they can now be toggled independently. (No reason your instance Minilist has to suffer just because you want to collapse the Minilist everywhere else!)  
- [Logic] Retail: Adjusted minilist a bit  
    * Content Sourced in another real Zone but shown in the current Zone will now be contained in a 'Remote Zones' header to help reduce some excessive header bloat in some main cities and Zones (i.e. Catalysts/Vendors from Raids, remote zone quests available in a city, etc.) [This does not affect content normally mapped into the minilist otherwise]  
- Classic: No longer repeating descriptions on tooltips.  
- K'aresh: Fibers have swapped quests  
- [Misc] Updated 11.2 GlobalStrings ref (ty Townlong-Yak)  
- Fixed the tooltip on Infested Book for Pages of History.  
- Fixed the tooltip on the Firework Launcher.  
- Fixed the tooltip on the Boiling Cauldron.  
- Linked the Tian Instructor to the Perfection quest in Jade Forest.  
- Linked Greenwood Thief to the objective for A Courteous Guest.  
- Fix some more 11.2 Errors, parse  
- K'aresh: Fix some reported errors  
- [DB] Fix MFO timeline (again)  
- [DB] Fix upgrade mappings for LOU and MFO (future)  
- [Logic] Retail: Achievement Sources no longer include their respective Criteria (Criteria get their own Source line already)  
- Classic: Descriptions are now properly being attached to tooltips if they're not applied to the most accessible source.  
- Added the Sniper Rifle object for SI:7 Report: Take No Prisoners  
- Added the Hozen Cage object.  
- Added object data for Twinspire munitions.  
- Adjust some Delve things  
- [DB] Fix timeline use in Manaforge Omega  
    [DB] Fix token cost on Chest of Gold for TWW:S3  
    [DB] Added Beledar's Spawn vignette NPCID  
- testing pop order  
- added i(168632), -- Slipstream Generator  
- naming  
- mechagon is available now again and renamed twws2 to mythicplus since it will be probably unvailable in the far future  
- DK Starting Zone: Content Revision  
    - Sort quests by completion order  
    - Added several Quest Objectives; Sourced QIs and PQIs  
- [DB] Mists: added HQT for weekly Elder Charms of Good Fortune turn-in  
- [DB] Couple timeline fixes  
- Fix a few small errors  
- Corrected 2 K'aresh Skyriding Glyph coords.(#2132)  
- [DB] Fixed Catalyst tooltips for TWW:S3  
- Clean up after PAT  
- [PAT] Updated source file format based on current standards.  
- Fix a few more K'aresh errors  
- [Locale] Profession headers part 4 (#2131)  
    * Corrected the game version and note about the CN new year promo  
    * Profession headers part 4 zandalari and mop  
- Mark K'aresh World Quests as World Quests  
- Fix a few errors  
- [Logic] Added expected Upgrade bonuses for TWW:S3 (assuming Blizzard didn't :clown: the bonus sequences in reverse or something)  
- Fix some K'aresh content, WB is active  
- Timeline and fix some 11.2 Quests  
- [Logic] Removed TWW:S2 upgrade bonuses (need to automate this from Wago somehow :thinking:)  
- [DB] Mists: timeline CM dailies and fix Proving Grounds and So You Want to Be a Blacksmith... for Horde as well  
- [DB] Mists: tie Proving Grounds to SoO phase and So You Want to Be a Blacksmith... to ToT phase  
- [DB] Mists: set Path of the Last Emperor quest to be available with Escalation phase  
- Last fields should always have a comma, even if nothing follows  
- Fix some minor 11.2 Errors  
