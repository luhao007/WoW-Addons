# Hekili

## [v11.2.0-1.0.0f](https://github.com/Hekili/hekili/tree/v11.2.0-1.0.0f) (2025-08-09)
[Full Changelog](https://github.com/Hekili/hekili/compare/v11.2.0-1.0.0e...v11.2.0-1.0.0f) [Previous Releases](https://github.com/Hekili/hekili/releases)

- Merge pull request #5060 from srhinos/thewarwithin  
    Fix Dominos Support for 11.2  
- Merge pull request #5058 from syrifgit/void-torrent  
    Shadow Priest - Fix Void Torrent interrupt\_if condition  
- Merge pull request #5056 from syrifgit/druid-apl  
    Druid apl  
- Merge pull request #5055 from taherbert/minor-frost-fixes  
    Fix: Minor Frost DK issues  
- Merge pull request #5054 from syrifgit/new-talent-skellies  
    Regenerate some skeletons  
- Merge pull request #5053 from syrifgit/spooky-scary-skeletons  
    Spooky Scary Skeletons  
- Fix Dominos Support for 11.2  
- Shadow Priest - Fix Void Torrent interrupt\_if condition  
    I think the `!talent.void_torrent` was struggling to go through the interpreter into the `if modifiers.interrupt_if and modifiers.interrupt_if() then`.  
    Changing it to our normal internal syntax fixes it, and it recommends the channel break as soon as your GCD is ready.  
    Fixes https://github.com/Hekili/hekili/issues/5046  
- DPS Druid APLs  
- demo lua error  
- define function before invoked  
- revisions per syrif  
- small fixes  
- Regenerate some skeletons  
    Druids: All missing their incarn copy talent  
    Unholy: Fixes defile  
    Specs that I hope weren't trying to PvP until now: Feral, Demo, Destro  
    Destro: Fix reverse entropy  
- Spooky Scary Skeletons  
