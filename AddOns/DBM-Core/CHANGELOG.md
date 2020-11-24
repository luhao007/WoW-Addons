# Deadly Boss Mods Core

## [9.0.5](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/9.0.5) (2020-11-23)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/9.0.4...9.0.5) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- Prep release  
- Update koKR (#393)  
    Co-authored-by: QartemisT <QartemisT@gmail.com>  
    Co-authored-by: Adam <MysticalOS@users.noreply.github.com>  
- FFFFFFFFFFF Full power.......Dungeon mods are at.......FULL POWER!  
- Fixes  
- That was most miserable dungeon to fix to date. Especially Kin-tara which doesn't even work like journal says anymore and needed hacky phase change detection  
    Updated all bosses in Spires  
    Added spires trash mod.  
- Update koKR (#392)  
- Did a full pass on Sanguine depths and did some minor tweaks.  
    Also added trash mod based on what's in guide (which isn't much for this dungeon, might need more?)  
- fix  
- Perfected Grlobgrog timers, even if it took nearly an hour for a single boss. inefficient as time management goes since there isn't time for this right now, which is why adding/fixing crash timer on Stradama will have to wait.  
    Fixed bugs in timers that already existed across plaguefall  
    Finished plaguefall trash mod  
- Full fresh review of all bosses in nectrotic wake and timer updates and removal of debug code since both target scans verified  
    Updated Necrotic Wake trash mod with more stuff  
- already losing focus and making sloppy mistakes.  
- Reviewed Mists of Tirna, Halls of Atonement, and De Other Side dungeons and corrected several timers with latest data from November 20-22 beta logs  
- Fixed a copy paste error  
- Fixed a bug in De Other Side trash with dispel type on Renew and added filter protection for mage spellsteal  
    Added Mists of Tirna Scithe trash mod  
    Updated some timers on Tredova and added interrupt warning to parasite, which is now apparently an interrupt mechanic (it wasn't at time mod was made)  
- Trash warning support for De Other Side and Halls of Atonement  
- Finally update generals timer data from most recent mythic test.  
    Added untested icon marking for attackable dancing fool on council  
- Revert "KR Update (#384)"  
- KR Update (#384)  
    Co-authored-by: QartemisT <QartemisT@gmail.com>  
    Co-authored-by: Adam <MysticalOS@users.noreply.github.com>  
- Fixed logged syncs so they don't actually needlessly send syncs to self over comms, just locally handle like non logged syncs  
    Fixed world syncs to actually locally handle sync so you can still get world buff alerts when you aren't guilded. Doesn't actually matter on retail, but it was fixed on classic might as well fix it here.  
- Re-enable timer tracker in alpha, to test if blizz has resolved their stuff  
- Fixes (#386)  
- Optimize the GUI category system (#385)  
    - Strip out some unused variables  
    - Strip out some unused functions  
    - Categories/panels now use ID's (which already existed), rather than names for lookups  
    - Localized some functions to prevent excessive bloat on the globalized frames.  
- Prep new alpha cycle  
