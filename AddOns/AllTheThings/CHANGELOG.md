# AllTheThings

## [4.6.4](https://github.com/ATTWoWAddon/AllTheThings/tree/4.6.4) (2025-08-17)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.6.3...4.6.4) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- MOP: Fixed a coordinate for a Golden Lotus quest.  
- Fix a few minor errors, add Stay A While  
- Manaforge Vandals: Fix the cost appearing on Vendors rather on items alone  
    (You buy FROM the Vendors, not the Vendors themselves. They aren't so cheap...)  
- s3 astral  
- Autolocalized more World Drops categories  
- Added all NYI items from Manaforge Omega.  
- Added all NYI unknown source IDs.  
- Sourced all Tier Sets of TWW Season 3.  
- [PAT] Updated source file format based on current standards.  
- [Logic] Retail: Fixed some minilist logic where a map with only Remote Zone content showing would turn the 'Remote Zones' into the root of the minilist  
- Fix a few minor errors  
- Legion Remix: A few more quests (including dailies)  
    - Gear rewards depend on the zone  
    - Looks like Timeless Scrolls from Pandaria Remix made it into general creature drops  
- Fix some reported errors, parse  
- Remix: Create 'Infinite Bazaar' header for future use  
- Legion Remix: Quest Revision  
    - Added all Remix Artifact weapons to the first quest they can be obtained  
    - Correct mistakes found through 2nd playthrough  
- [DB] Legion - Broken Shore: Sourcing Portal-Stones and Sentinax Beacons  
- Legion Remix: More quests  
    - Moved gear obtained from Caches to general Rewards as they are not localized to Dalaran  
- 11.2.0.62610 achievement fixes  
- [DB] Mists: Fix NYI quest 31697.  
- [DB] Couple data tweaks  
- [DB] Mists: gate Battlefield content behind Escalation phase  
- [PAT] Updated source file format based on current standards.  
- [DB] Gilded Stash isn't removed  
- [DB] Added reward for Voidborne Victor  
- Legion Remix: Introductory Quest Chain finished  
    - Infinite Bazaar file prepped for data population  
- Adjust MFO HQTs, add sym to K'aresh cache  
- Update PTR Wago files for 11.2.5.62554  
- [Logic] Maps detection updates  
    * Fixed ATT not reporting any Exploration which was under NYI  
    * Added some other Exploration checks to report Areas which are found in game but have no valid coords  
    * Instance-based Areas should also be able to report but without coords (untested, lel)  
- Updated Remix: Legion removed patch  
    at least 11.2.7, maybe even later  
    this also makes it visible on PTR again  
- Updated Remix: Legion eventID  
    hopefully automatic dates detection should work now?  
- Updated Remix: Legion dates  
    We should be using the eventID for this, not hardcoded dates  
- Fixed PTR parser config  
    Doesn't matter right now but we don't want to keep adjusting build number with every build  
- Fix many reported errors, sort K'aresh rare drops out of common drops header (which was supposed to be temp)  
- MOP: Fixed the coordinates for What Comes to Pass.  
- cosmetic is removed  
- special note for starlight beacon  
- Legion Remix: Starting quests  
- [DB] Add note for Celestial dailies  
- [DB] Mists: fix quest ID for Scholo Celestial daily  
- [DB] Mists: added Aqua Strider to Satchel of Celestial Chance  
- [DB] Unsorted item is sourced  
- [PAT] Updated source file format based on current standards.  
- Update Mount/Pet/ToyDB for 11.2.5.62554  
- [DB] MFO: Another H HQT  
- Legion Remix: New Character gear  
- [DB] MFO: Added Priest-only quest from Dimensius  
- [DB] MFO: H Bone Melter HQT  
- [Logic] Retail: Fixed Lua error when loading Debugger window  
- Legion Remix: Update timeline  
- [DB] Partially adjusted TWW Mining Crafted Items to better represent the desired standard (also the one last deposit I've never seen, reeeee)  
- [DB] Found a Delve trinket  
- K'aresh: Update a couple descriptions  
- MOP: Added Beads of the Mogu'shi to Shado-Pan Monastery.  
- MOP: Added Elegion, the Fanged Crescent to Mogu'shan Palace.  
- MOP: Added Gara'kal, Fist of the Spiritbinder to Temple of the Jade Serpent.  
- Harvest: 11.2.5.62554  
- Harvest: 11.2.0.62493  
- Harvest: 11.2.0.62438  
- Harvest: 5.5.0.62518  
- Harvest: 5.5.0.62422  
- Harvest: 3.4.5.62423  
- Update Harvester to handle 11.2.5  
- Added Heroic Plexus Sentinel ID  
- [Locale] Abbreviations in es and mx (#2144)  
    * Update the description of the checkbox expand difficulty in es and mx  
    * Abbreviations updated in es and mx  
    Antorus is of legion  
    * Fix the translation of characters unlocks  
    * clean entries  
- [DB] Mists: add coordinates to Mai the Jade Shaper  
- [DB] Mists - Jewelcrafting: source epic gem recipes  
- [DB] Mists: gate Warlock Green Fire quest line behind ToT phase  
- [DB] Gate some PvP epic gems behind ToT  
- [DB] Mists: fix PvP vendors for Malevolent season  
- [DB] Mists: added Golden Water Strider to Satchel of Celestial Chance  
- [DB] Timeline WoD versions of MoP PvP vendors  
- [DB] Celestial Riding Crane is confirmed from le Celestial Chance bag  
- Added all fireworks from 'Bundle of Fireworks'.  
- [DB] Mists: Assault on Zan'vess scenario is in the game already  
- [DB] Molten Core: Zone drop armour no longer BoE.  
- [Logic] Retail: Total Cost is now far more reliable in calculating when a new popout is created  
- [DB] Adjust a couple MFO HQTs  
- [DB] WotLK: Sourcing Fetch Ball.  
- Reprioritized the layout of the Read Me  
- Added Normal Dimensius ID  
- [Locale] headers and descriptions, Removed the message of removed from the game of dalaran fireworks, still available via DF engineering (#2143)  
    * [Locale] Celestial dungeons header in DE, ES, MX, FR and PT  
    * [Locale] Burden of Eternity items in es and mx  
    * [Locale] Severed Threads Pact header in es and mx  
    * [Locale] Nightfall header in all languages  
    * [Locale] War mode gear header in es and mx  
    * Dalaran firework still avaliable to players since DF  
- [Logic] Retail: Fixed a logic gap where completed content in a popout could be included for Cost calculations  
- [Logic] Retail: Prioritize current Class/Race content when sorting the Contains portion of a Tooltip  
- Added Normal Velaryn Bloodwrath ID  
- Added Forgeweaver Araz normal ID  
- [DB] Parse for Git users  
- Fix some more reported errors  
- [DB] Mists: add Challenger Wuli as Horde quest giver for Celestial + Challenge mode dungeons  
- [DB] Mists: add Challenger Soong as quest giver for Celestial + Challenge mode dungeon dailies  
