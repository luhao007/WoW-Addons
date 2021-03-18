# Deadly Boss Mods Core

## [9.0.23](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/9.0.23) (2021-03-15)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/9.0.22...9.0.23) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- Prep release  
- Added moveme buttons to other timer options panels  
- Revert nerf to icon settings. let users have both icons if they want. Also fixes regression where toggling icons in GUI didn't live update the dummy timers.  
- Dbt Fixes (#529)  
- remove debug stuff.  
- Update bug\_report.md  
    Remove twitch notice  
- DBT Update. Revert last text change to bar sorting option, because the rapid bar sorting bug is now fixed because of following changes:  
    1. Bars will no longer sort every single bar update since it's a bit of a cpu waste to sort bars when time remaining on any of bars has not changed.  
    2. Instead, bar sorting will only run when any of events happen (a new timer starts, the time on an existing bar has changed, a bar has been paused, a bar has been unpaused, or a bar configuration has been changed).  
- Label bar sorting as Not yet implimented so people using updated DBM know why it's not working anymore  
- small cleanup  
- Update bug\_report.md  
- Small micro optimize to backdrop template checks  
- Fix renew warnings in De Other Side (#525)  
- Backwards compat code for weak auras for now to prevent errors/freezes related to that  
- Fix regression that caused timers to tick twice as fast  
    Fix bar pausing for real  
    disable bar sorting in non debug mode for now since it's still royally fucked up when bars are paused  
- readded bar pausing to new timer object  
- Fix error and slim it some  
- Seems skin api needs whole damn thing to not error out, so restore literally the whole thing temporarily for migration  
- Fix default skin return again, this time it shouldn't error anymore even if users fail to remove it.  
- More error silencing for user migration  
- Fixed double updating bars, which seems to have fixed the massive anchoring bugs that were occuring as ewll  
    Fixed bars ignoring the sort setting as well.  
- Update banned mods  
- More fixes (bugs from original)  
- Fix  
- Merge in unfinished DBT rewrite now. it's buggy but it shouldn't have freezng issues like whatever the hell blizzard did with last couple patches that strongly dislike old DBT code  
- Update ci.yml  
    Prep WAGO API Token  
- Add Wago project ID  
- bump alpha  
