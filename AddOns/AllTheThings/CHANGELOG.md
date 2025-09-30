# AllTheThings

## [4.6.13](https://github.com/ATTWoWAddon/AllTheThings/tree/4.6.13) (2025-09-29)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.6.12...4.6.13) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- [DB] Clean up the Brewfest file a bit so it doesn't have Lua syntax errors  
- [DB] Filter some pvp relics Post-MoP  
- [DB] Bubble down self on anniversary headers  
- [DB] Retail: Switched `maps` use on many Items under Crafted Items to be `maps_disp` (map information will retain in their tooltips, but no longer force those Items to show up by default in those maps. Using the Object Filler will be the desired way to keep the context of what Location-based Thing provides those Items within the respective maps)  
- [Logic] Retail: Added a quick command (/att reset-window <Suffix>) to allow resetting the Profile settings for an ATT Window (e.g. some users report windows have disappeared in some unknown way; this command should allow a user to reset that specific Window manually)  
- [DB] Fixed Firefin Snapper School objectID  
    [DB] Removed some use of `nomerge` which isn't necessary or expected  
- [Logic] Retail: Fix an issue where forcibly-non-merged objects were able to infinitely-nest inside themselves when filling certain Location Minilists  
- Fix some reported errors, add October 2025 Trading Post  
- Brewfest: Add post-Cata coordinate for Barleybrew Festive Keg  
- Simplify Brewfest HQT by trusting timelines  
