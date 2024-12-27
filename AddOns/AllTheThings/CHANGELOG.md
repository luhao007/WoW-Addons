# AllTheThings

## [4.2.3a](https://github.com/ATTWoWAddon/AllTheThings/tree/4.2.3a) (2024-12-23)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.2.3...4.2.3a) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- [Localization] update zhCN/zhTW:fix typo.  
- Added the 'sensemble' shortcut for when an Ensemble is directly-granted by SpellID alone  
    Parser: Refactored some Ensemble logic to fit more scenarios in which a TransmogSet data is determined  
    Parser: Added a bunch more WARN logging for situations where Ensembles end up with no data to help protect future erroneous situations  
    Ensemble: Stonebound Earthen Regalia converted to 'sensemble'  
- Retail: Added glyphs of the pistol shot  
- Parser: Added a WARN log when an iensemble fails to associate with any SpellEffect records (to pull in TransmogSet properly)  
    Parser: Fixed an issue where unknown ItemEffect types were being prioritized over known ItemEffect types when associating SpellIDs from Wago data (e.g. Anniversary ensembles)  
- Updated Retail Wago files  
- Fix Gill'el  
