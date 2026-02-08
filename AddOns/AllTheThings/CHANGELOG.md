# AllTheThings

## [5.0.5](https://github.com/ATTWoWAddon/AllTheThings/tree/5.0.5) (2026-02-01)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/5.0.3a...5.0.5) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- Fix release on tags  
- [Locale] Update zhTW.  
- Readd Ensemble: Scorching Conqueror  
- Fix type  
- Disabled Parser's OnInit error message and added back the china only values.  
- Timeline trading post, source BFA Pseudo-secret, fix some reported errors  
- Disable Both cnONLY promos  
- kk  
- parser  
- Fix parser?  
- Beta: pvp vendors checkup (part 1)  
- Beta: Delve vendors unsorted sorted  
- added cn promo items to the best of the existing itemids  
- Beta: Prey vendor (beta parse attached just in case)  
- Beta: Outdoor, Delves (backlog), Prey (backlog)  
    I hate everything related to questIDs of Prey stuff. Yes, Blizzard, it's your fault.  
- Update Contributor.lua  
- Re-run Retail Parser... Didn't even realize I ran it the first time...  
- Harandar: Many new additions  
    - Added majority of quests related to 'Legends Never Die' Achievement  
    - Added majority of lore objects related to 'Chronicler of the Haranir' Achievement  
    - Move Glowing Moths to 'Dust 'Em Off' header  
    - Harandar Decor Specialist (sourceQuests are incomplete)  
    - Added a few World Quests  
    - Added a bunch of Achievements from Quests and Exploration categories  
    - and some minor tune-ups  
    - Beta Parse  
- Update Contributor.lua  
- Fix parser?  
- Add new Secret, two achievements, and fix some reported errors  
- Added more removed items to quantum.  
- Added vendor with useless items in Founder's Point.  
- A lot of inscription recipes were missing in retail due to wrong #if preprocessor.  
    Removed a lot of duplicated recipes which are already correctly sorted elsewhere, but some remain duplicated for now, since inscription is not completed and is the worst profession to ever exist for our database.  
- Headers are always capitalized.  
- Exclude maps from Winds of Mysterious Fortune event, drops happen everywhere now  
- [Logic] Blizzard changing Decor APIs again... fixed some Decor refresh  
- [DB] MoP EF: Order of the Cloud Serpents : Descriptions  
- sorted by alphabet  
- added suggestion: endeavor headers  
- Twilight Ascension: 'Too Deep and Too Dark' World Quest  
- Twilight Ascension: Repeatable quests are weekly  
    - Fix NYI flag on an Emerald Sporbit  
- Fixed sourceID of the new pre-patch crossbows (remove after wago updates).  
- Found one more wrong NYI recipe.  
- Fixed 2 Dragonflight tailoring training recipes.  
- Fix many reported errors  
- Update Mount/Pet/ToyDB for 12.0.1.65617  
- Add last February Trading Post discount vendor, NYI item included  
- Beta: more delves backlog and some outdoor stuff  
- Twilight Ascension: Cost of Max Level equipment was halved  
- Twilight Ascension: Crossbows added to vendors (as per hotfix)  
- Add 3/4 discount vendors for February Trading Post  
- Pre-patch rares have no questID anymore due to the loot hotfix.  
- Fix lockCriteria for q(9267  
- Moved Midnight world drop grey cloaks.  
- Add February 2026 Trading Post, discount vendors to follow  
- Update Ranked mode and preset  
- number number number _  
- Fix Dark Portal decor unlock requirement  
- Adjusted the Thorium Brotherhood Contract for A Binding Contract in BRD.  
- [Logic] Timerunning is no longer active, so stop loading it (some day we will figure out how to automate this)  
- Twilight Ascension: Better description for 'Voice of the Eclipse' rare  
- Twilight Ascension: 'Twilight Bonds' World Quest  
- Twilight Ascension: Add gear for leveling characters on the vendor  
- Twilight Ascension: Voice of the Eclipse is random spawn in Twilight Highlands  
- Twilight Ascension: Coordinate for Voice of the Eclipse  
- Fixed coord for Nedrand the Eyegorger.  
- Fixed pre-patch event items cost.  
- Fixed questID of T'aavihan the Unbound rare.  
- Corrected timeline for grey world drops from Midnight. They are already obtainable through pre-patch event.  
- Beta: small bunch of delves backlog (and some wq in eversong wood)  
- #2274 Fixed the GOSSIP\_SHOW event to only be registered for in zones with known flight paths.  
- [CI] Refine release workflow with semantic tag filtering and release type detection  
    * Restrict tag triggers to semantic version tags (x.y.z)  
    * Introduce release\_type (release vs alpha) based on trigger source  
    * Only check changes since last tag for alpha runs  
    * Always allow build jobs to run for tagged releases  
    * Prevent unnecessary scheduled builds when no changes exist  
- Fix some reported errors  
- Brawler's Guild: Fix a typo in the criteria for the achievement 'The Best There Is'  
- Brawler's Guild: Fix the criteria for the achievement 'The Best There Is'  
    - Retail Parse  
- Mark WQs as WQs  
- Add new Discord quest promo  
- Tiny formatting fix  
- Hal'hadar's Phasebound Visor is already removed from My Stab-Happy Nemesis  
    lame  
- Update Winds of Mysterious Fortune timeline  
    This event is recurring and the correct dates are automatically picked up from the calendar  
- Unremove Voidborne Victor achievement  
- [Misc.] Unify file name.  
- [CI] Trigger Parser on all branches.  
- Run Parser on master branch pushes again  
- [Parser] Managed to get some object names from Wowhead  
- [DB] Update some Endeavor weekly quests in Founder's Point  
- [DB] Found another Endeavor decor vendor  
- Moved The Dreamweavers faction to a Factions header.  
- Brawler's Guild: Achievement 'Rumble Club' is automated  
    - Retail Parse  
- Brawler's Guild: Source all currently available Challenge Cards  
- Brawler's Guild: Merge criteria for Rumble Club under the Achievement itself  
- [CI] Fix dummy Parser run.  
    To prevent unnecessary parser runs in certain situations.  
- Revert "[CI] To prevent unnecessary parser runs in certain situationsㄡ"  
- ci: fix release race condition  
    this should prevent us from checking out different commits in different jobs within one workflow if new commits arrive during the run  
- Revert "[CI] Update Parser config."  
- Fix a few reported errors  
- Revert CI changes.  
    This reverts commits  
    3b4b6a899b61f3c8ace944dac9d4ad5b25ac66db.  
    3bc10148adab4d3115c302fff47a2ffa065a77e0.  
    94b0a62ecb2b037ebb3119ceb167f6b7f5b4a318.  
    f201b53d48efc3053320b762dfedf1fcff2c9523.  
    2f12016a7657650a19e1adde093f0b99567044a3.  
    09e82a6f3a5d3cdf4ccd9888f0e50d2485e1a75c.  
    8eccf21282af0bb922f3718613530f4d0db91958.  
    7d1259435381fd1bf9ca7fbe0ac9a6f13bf8e778.  
    6be2e08421d5a876d472c95a1828924947af5474.  
    8f8eea1bde8db88c49083969be695f0a615120aa.  
    f21bb7fad6cf7facef69eb0e440837ee07836d52.  
    d32e3f8b9d32e163af54e391174ae3f8f77d7baf.  
    2b18b8ac78e37e6e3b2ee6e27dee42a46bdac98c.  
    fcd5f0bf454039bc983504494aa6df843e6a67dc.  
    6d4207ddb86577ce979888c80e63c5633af3238d.  
    89cb805c0d26a76dba891e4c49be33817550325e.  
    2a31a368441058a6d1e0331557d3ec79dca8e427.  
    2ba7f9d4b464cb85e014f59b4ddbd5a4073ec7a1.  
- Add State of Azeroth drop  
- Tazavesh achievements are also still obtainable.  
- [CI] Disable alpha release.  
