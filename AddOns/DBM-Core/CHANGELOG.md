# DBM - Core

## [11.2.4-22-g0576240](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/05762407d3ea549e399791bb4b43c5a4e7b5a488) (2025-08-01)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/11.2.4...05762407d3ea549e399791bb4b43c5a4e7b5a488) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- Few timer fixes  
- Replace test data with pull that isn't bugged  
- Push Nexus King updates  
- attempt to avoid lua errors on RU client caused by raid boss whispers that are > 255 string length  
- final micro adjustment to cleanup the DBM offline reports  
- micro adjustments  
- significant reworking of soul hunters since blizzard removed one of phase events i was using before. Plus this ends up being cleaner for all 3 difficulties anyways.  
- Update RU locales (#1695)  
- Update localization.es.lua (#1698)  
- Update localization.es.lua (#1699)  
- fix same bug with death throes  
- fixed bug with void harvest not referencing table as intended  
- eliminate redundant warning  
- Account for observed variances acrossed multiple pulls  
- Add missing mythic spell Void Tear to Araz  
- One timer tweak  
- Add heroic and Mythic timer updates to Naazindhri  
    Made icons compatible with public BW  
- tweak 1 timer to eliminate the 1 remaining refreshed warning  
- Loomithar heroic and mythic updates  
- Cleanup old S1 stuff from affixes module  
- Fix a bug causing wrong missing mod notification in MoP dungeons  
- Fixed a bug where Mythic and MythicPlus could return true in MoP challenge modes (since diffIndex 8 was reused for M+ at end of Challenge mode era)  
