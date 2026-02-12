# AllTheThings

## [5.0.8a](https://github.com/ATTWoWAddon/AllTheThings/tree/5.0.8a) (2026-02-12)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/5.0.8...5.0.8a) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- Possibly fixed an infinite loop in the profession window.  
- Added missing coordinates for Prayer to Elune.  
- Formatting: Unifying the codestyle of ["cost"] field, Part 7  
- Fixed a caching issue for total time played where other addons that request on startup are now accounted for.  
    Now also showing a By Class / By Race breakdown when mousing over the Characters header in Account Management (/attsync)  
- [Contrib] /att import no longer shows nested content within the list  
- german locale issue  
- The Account Management window now manages your character's total time played and displays it in the tooltip. (only refreshing this value every hour, you can manually trigger it with /played of course)  
- [Contrib] /att import accepts spellIDs now  
- [Logic] Achievements are now cached account-wide if marked as such from Blizzard [This will reduce saved vars storage for ATT per Character and correspondingly reduce in-game ATT memory use]  
- [Logic] TypicalCharacterCollected now includes direct account-wide collection check  
- [Logic] Only stored Character-based completion in Account-wide data table if the data is not already stored (don't replace direct Account-wide completion)  
- [DB] Ignore provider/coord for Star Savior title  
- [Contrib] /att import can now handle direct Global references  
