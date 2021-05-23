# AllTheThings

## [SL-2.3.1](https://github.com/DFortun81/AllTheThings/tree/SL-2.3.1) (2021-05-21)
[Full Changelog](https://github.com/DFortun81/AllTheThings/compare/SL-2.3.0...SL-2.3.1) [Previous Releases](https://github.com/DFortun81/AllTheThings/releases)

- Sync localization (#764)  
- Sync localization (#763)  
- Small reformatting  
- Auolocalize "Renown" header and remove old string  
- level 50 boost set is now tagged a bnet balance required  
- trial set change  
- Sync locale strings for drop chances setting  
- Missing Source messages should no longer manage to show up prior to ATT being fully loaded  
- renown headers added  
- Reparsed since wow was extremely unhappy with the previous Categories.lua for some unknown reason  
- Marked The Netherlight Crucible quest as removed. Minor legion paladin updates.  
- Last BfA source quest fix for today  
- added brightscale hatchling to sika's extravagant tribute  
- fixed a couple pvp items for sanct xoxo  
- More BfA source quest ammendments  
- More BfA source quest additions  
- More Tiragarde Sound source quest additions  
- Added a Tiragarde Sound source quest  
- Re-designed population of world quest rewards within /attwq so that they are populated dynamically instead of all at once when building the list. This should lead to lower memory usage when repeatedly clicking 'Update' (out of habit) and allow for existing quest records to simply insert their rewards into themselves. Also hopefully nothing is very broken but I'll probably have to re-visit the logic and clean it up. Please screenshot anything horribly broken in #errors. Thanks  
    Also SelfCallback calls can be converted back into Callbacks since passing arguments works properly  
- Fixed some items which were supposed to be currencies  
- TBC's last patch was a different number than I had in the parser. Update TBC parser.  
- Explicitly linked Cooking Profession Skills for TBC Classic zones.  
- Updated the Cooking Recipes within the Profession header.  
- Marked Firecracker Helm, Girdle & Slippers as unobtainable  
- Reworked First Aid and its associated classic quests.  
- Better fixed World Quests list population for certain items/quests (will need to revisit the 'Treat Currencies as Containers' logic though for accuracy)  
    Fixed a bug with CreateObject that would effectively delete all incoming raw data when turning the data into an object  
    Also spacing on variables  
    Note to fix the Wakening Essence vendor  
    Cleaned up some Callback-argument logic for clarity  
    Added 'tierID' as a valid hash key  
- Updated the Herbalism Recipes within the Profession header.  
- Updated the Mining Recipes within the Profession header.  
- Added Viridian Phase-Hunter store mount. Added/updated various legion quests.  
- TBC xpac icon was way to bright!  
- Updated the TBC build tool to build to the TBC folder rather than to Beta.  
- Cleaned up and added timeline information for Azuremyst Isle.  
- Added some Pandaria source quests  
- Cleaned up and added timeline information for Ammen Vale.  
- Cleaned up and added timeline information for Bloodmyst Isle.  
- Fixed some item tooltips when they contain a modID and bonusID (like /attwq warfront boxes and WoD Normal Warforged items)  
- Just when you thought "man only one quest in the Exodar, what a dead zone" and it turns out it wasn't added until Wrath.  
- Cleaned up The Exodar quests. Moved all of the breadcrumbs to Stormwind City where they belong.  
- Moved the breadcrumb quest "Wulf Calls" to Stormwind. (TODO: Fix formatting.)  
- Moved the breadcrumb A Summons from Ander Germaine to Stormwind.  
- Updated all Parser versions to build for their new folders. Contribs: Going forward, please start using the "Parser for Retail" executable. We're gonna be deprecating the "Parser V2" executable in a few weeks.  
- Added a Tooltip setting for whether 'Drop Chance' information should be calculated for an Item in an ATT list  
- Now using Grey/Yellow question marks (instead of a 'star') to denote Quests in lists which the player is on and/or ready to turn in (to match how it shows in-game for in progress quests)  
- Added quest arrow icon  
- Added 3 icons  
    Small update to BC xpac Icon now closer to the new BC "classic" icon  
    Added both a yellow & Grey "?" icon  
- Various minor updates  
- Warden's Scroll Case wasn't added until 6.1.0.19508.  
- Tried to fix the OnUpdateReputation method to be usable more generically and not override user settings on visibility  
- Fixed a quest incorrectly marked as repeatable  
- Marked all of the Outland zones as TBC Phase One required.  
    The Isle of Quel'Danas has a TBC Phase 5 Requirement.  
    Removed all faction headers and dirtily smashed the quests and vendors into the places they should have been ages ago. (This will need to be touched up significantly before TBC Launch, apologies users for the temporary lack of organization, Prepatch is here and I'm out of time.)  
    Updated information on Mr. Pinchy.  
- Added the OnUpdateReputationRequired function that objects may subscribe to in order to enforce visibility requirements for non-player faction requirements. (Scryers & Aldor)  
- Marked Nagrand as TBC Phase One, dirtily butchered the pointless Faction headers.  
- Applied the TBC Phase 1 requirement to Hellfire Peninsula.  
- Added Exploration data for Bloodmyst Isle.  
- Engineering 'Reaves' components flagged with Engineering skill since the tracking quest for each item is otherwise is being considered for any character  
- Added Exploration data for Azuremyst Isle.  
- Added Exploration data for Hellfire Peninsula.  
- Added Exploration data for Netherstorm.  
- Added Exploration data for Blade's Edge Mountains.  
- Added Exploration data for Zangarmarsh.  
- Added Exploration data for Nagrand.  
- Added Exploration data for Shadowmoon Valley.  
- Added Empty Nightcap Cask  
- Added Fashion Abomination achievement.  Necrolord abomi-thing costs are now tracked under Fashion Abomination instead of Wardrobe Makeover, since all criteria for the latter will be marked complete by blizz once you have finished the achieve for 25, but the criteria for the former will stay incomplete until you have finished all 35 things.  Added provider/coords for hunter mount quest in legion.  
- Marked Conservator's Leather Tunic as never implemented since it has been reported to not come from the expected ensemble.  
    More various legion quests updated.  
- a couple useless ember court items out of unsorted  
- Slight reversion of the .editorconfig, but keeping the extra EOL new line purging intact! :)  
- Updated the .editorconfig file to match expected file format standards. No spaces to indent in file format and no extra line at the end.  
- Fixed some Party Sync logic when a player goes offline without leaving the party  
    Added logic for Toy collection to be improved (not active until I find a new Toy to test...)  
- Fixed logic for Party Sync indicator on non-available quests (it only works on quests that have already been completed by the character)  
    Prepped for new quest indicator icons soon...  
- Initial formatting for Azuremyst, Bloodmyst, and the Exodar for timeline manipulation. (not including quest changes yet)  
- Locale sync  
- Hopefully final review of Quest + Reputation logic  
    Removed fake breadcrumb statuses from 2 Consortium quests (now that Quest + Reputation should be working properly to show accurate collectibility/collection)  
- Added Exploration data for Terokkar Forest for TBC.  
- Added Ghostlands Exploration data. The ZA flight path confirmed not implemented until Phase 4.  
- Reviewed Quest collection logic for Quests which grant reputation so that it should correctly accomodate both ways of collecting (Reputation / Quest)  
- Added Area IDs for the Ghostlands. (now to explore and match them to texture coordinates!)  
- Added Exploration for Eversong Woods. (to Classic, Retail is not ready!)  
- Added some future tech for Exploration objects... soon.  
- Fixed items collectible as cost from having a tooltip Total +1 greater than their actual Contains count  
- Cleaned up a lot of "easy-to-fix" duplicated quest entries ( > 51046)  
- Moved headerID "Common Vendor Items" to -20, added "Exploration" as headerID -15 as it is in Classic.  
- Checking source quests on beta yielded some unexpected results in the Ghostlands.  
- Finished the Ghostlands timeline adjustments for TBC.  
- New parser writes some information about the chunk that failed now.  
- Recipe: Transmute Skyfire Diamond is no longer marked Alchemy.  
- Fixed popouts of collectible as 'cost' items to generate a popout list which matches their Contains tooltip  
- Removed some commented info  
    Changed Party Sync logic a little to show that uncollected Quests which cannot be re-played in the current session to have the 'Incomplete' (blue X) as the left-side indicator  
- Removed TODO which was nowhere near the thinging needing to-doing  
- Added proper costs for T5 tokens on IoQD  
- Added some extra quest info and zone drops unique to Eversong Woods.  
- Finished Silvermoon City timeline adjustments for TBC.  
- Added a Common Cataclysm Recipe group for Enchanting.  
- Added a Common Cataclysm Recipe group for Jewelcrafting. (a doozy!)  
- Added Common Cataclysm Recipe groups for Blacksmithing, Leatherworking, and Tailoring vendor recipes. Working on the rest next, but figured it'd be a huge commit if I did them all in one push.  
- I've moved the rest of the garbage to Orgrimmar. Someone else can deal with the duplication and consolidate it, I don't have time!  
- Consolidated the quest "Meet with Grezz Ragefist (Cata+) / Meet with Gormok Ogrefist (SL+)" in Orgrimmar. (Why do they do this...)  
- Consolidated the quest "Meet with Gordul" back into Orgrimmar.  
- Consolidated Kazak's Behest (SL+) / Kranosh's Behest (WOD+) / Zevrost's Behest (Cata+), since it's a breadcrumb, it goes in Orgrimmar with maps linking it elsewhere.  
- another weekly poa quest  
- First pass cleaning up Ghostlands and Silvermoon City lead me on a Priest Quest nightmare! I'm not done!  
- Right Click any quest to see its Quest Chain Requirements  
- Added Commander's Downfall quest.  
    Removed misleading description from Thaumaturge Vashreen.  
- Explicitly marked the spellIDs associated with the recipes in Black Temple.  
- Explicitly marked class requirements for the Ashtongue Talisman trinkets in BT.  
- No longer accidentally marking Sense Undead as a TBC Phase One required spell.  
- Updated Eversong Woods and Sunstrider Isle to utilize timelines in preparation for TBC.  
- Added source quests for MoP war board Quest breadcrumbs  
    Modified Quest Removed to trigger a callback so that it only updates once per frame (i.e. leaving Party Sync or using a macro to abandon multiple quests at once)  
- Warlock Class Hall questID fix  
- Added some logic to automatically show otherwise unavailable quests when entering a Party Sync session. The 'saved' checkmark (left side) will show whether your character is able to pick up/replay the quest  
    Registered another event for removal of a quest from the player's log so that windows can update properly in case any show active quests  
    Determined another sourceQuest for a Nagrand Quest  
    Fixed Breadcrumb skip warning to only activate if getting locked out of a breadcrumb that the player can acquire on the current character  
- Fixed the Death Tracker freaking out in Debug Mode on a fresh character.  
- Data was nil when right clicking on "Return to Sathiel" in Eversong Woods. Feel free to try debugging. :)  
- Applied customCollect to all Covenant main quests  
    Cleaned up some Nested Quest Chain Requirements (NQCR) logic  
    Modified NQCR logic to ignore Quests which do not meet the current character's custom collect requirements, unless the root Quest already does not meet the customCollect requirement  
- Added an additional Help Text for Quest entries as it became apparent this was not common knowledge of the special popout functionality on a Quest-related group  
    Added a coord for 'Bell of Remembrance' to help point in the right direction for the mob drop  
- Commented out some pre-filtering code when showing NPC tooltips which seems rather unnecessary due to the same logic being applied later on  
    Commented out a currently-unused function  
    Consolidated logic of SearchForObjectClone  
    Removed logic which bypassed cloning certain popout window results since it allowed for searches within that popout to alter the structure of the popout data (fixes #761)  
    Moved Blingtron quests into generic Quests headers under the respective expansion craftables so that the Engineering filter is not enforced on the Quests themselves  
- Sync localization (#762)  
- Remove more unused headers/object names  
- Battle Pets linked using maps now properly go underneath the Pet Battles filter header in the mini list.  
- Removed a profession header that only contained Bloated Smallfish from several zones. Moved Classic crafted items for Fishing to the Crafted Items section.  
- Added a note and 'contained' HQT unlocks for the Ember Court BoA Items so you can prevent making the same mistake I may or may not have made  
    Consolidated accurate Tooltip integration check logic and applied it in missing tooltip attachments (fixes #340)  
    Uncommented many Holiday Icons from DeadSerious (still requires further source clean up for a couple of them to work properly everywhere)  
    Adjusted logic for Contains to accurately check the entire parent path of the Thing to ensure it is obtainable by the current character (fixes #383) [this will break Blingtron tooltips for non-Engineers until Bling is moved somewhere else in the DB... and maybe other things]  
- Added/updated more Legion Hunter quests  
- parser test 2  
- parser test  
- Removed a couple unnecessary clone methods since the retrieved data is not modified  
- Added proper filter to Ragnaros group of 15th anniversary items (fixes #654)  
- Consolidated logic for generating Spec icons in rows/tooltips  
- Removed symlinks from SoO Essences since they are properly using 'cost'  
    Improved handling/logic of showing Spec Icons in window rows  
- Fixed hash function for items with spellIDs since sometimes different items can use the same spellID and they need to be distinguished properly (fixes #700)  
- Trinkets/Crafted Items are no longer getting their recipeID used as a collectible attribute of the item (i.e. collectible trinkets) (fixes #671) (Likely due to Parser fixes from before)  
- removed drop is back!  
- Mark all repeatable Chromie quests as such and remove one dupe in SW  
- Sync some localization strings  
- Various legion quest updates  
- Thori'dal, the Stars' Fury achievement is now Warrior, Rogue, Hunter only.  
- Raid quests are supposed to be contained within their respective raid.  
- Updated Ruins of Ahn'Qiraj and associated quests to Classic's future timelines. (these files now match between ATT-Clasic and AllTheThings!)  
- Moved the Black Empire containers to the Assaults themselves. (Restructure this stuff when possible.)  
- Added a finalized section for the Tier 0.5 Sets, which were tested thoroughly in the Classic version of ATT!  
- Updated Blackwing Lair and associated quests to Classic's future timelines. (these files now match between ATT-Clasic and AllTheThings!)  
- Updated Molten Core and associated quests to Classic's future timelines. (these files now match between ATT-Clasic and AllTheThings!)  
- Legion quest updates for hunter, DH, DK  
- HQT from Revendreth WQ  
- Updated Onyxia's Lair and its associated quests.  
- Slight change to "!" size  
- ...  
- Fixed Adventurer: Nemea quest and Nemea follower for Kyrians. More Hunter legion quest updates.  
- Updated quest header icon path  
- Universal quest header icon  
- More Legion hunter updates. Removed quest trigger attached to Arsenal: Winterborn Weapons.  
- Added paths for more icons  
    Added a path for Rare, Quest, Icon, Treasure chest and legion invasions  
- Gave the quest icons a little love  
- New/updated icons + small change to content file  
    Added quest icon  
    Added daily quest icon  
    Added daily quest turn in icon  
- Added Paths for Hoilday Icons  
- Name change icons to mmatch others  
- Added Hoilday icons for sorting  
- Added some Paladin Class Hall HQTs  
- Explicitly added class requirements to the tokens because of classic's limitation.  
- Restructured Sunwell Plateau.  
- Cleaned up heroic ZA to match.  
- Made use of the lvlsquish helper function instead of inline preprocessor commands.  
- Cleaned up Zul'Aman and its associated quests.  
    Added helper functions to clean up the more common #if #endif blocks for readability.  
- Fixed showing unobtainable quest pre-requisites when not in Debug mode  
- Fixed a bug with crafting logic where recipes which do not create an item (enchanting etc.) cause an error  
- lost winged ritual kris exists woooo  
- Fixed making a popout window from within a popout window changing the indentation of the group from the first popout window  
- Moved a couple functions around  
    Altered the logic of the popout window to actually perform the same logic as when searching for that Thing (if it doesn't already contain things). This way, the tooltip of an Item/Currency used to purchase Things will match the popout window of that same Item/Currency as expected  
- Couple Naval Mission HQTs  
    Clicking in the Scrollbar area on an ATT window will now scroll exactly the same amount as the number of currently visible rows in the window (the arrow buttons are still weird though)  
- Removed inaccurate description for Scunner  
    Fixed duplicate descriptions showing for some creature tooltips  
- More legion quest updates, mostly Hunter  
- Updated parser to allow for "u" and "timeline" resolution.  
- Added some legion HQTs  
- Further minor improvements to performance of some duplicate-prevention logic during tooltip/search processing  
    Moved duplicate prevention to 'Descriptions' on NPC's only instead of for all tooltip Info generated (Please report weird duplicate tooltip data if noticed)  
- Minor performance adjustments for tooltips/search performance [WIP]  
- added sq for a night fae quest  
- Added/updated more Legion hunter quests  
- moved some mounts from temel to the tributes they allegedly drop from  
    some ember court hqts  
- Added an item to Garrison missions  
- Fixed creature/etc. Models showing for Items with a SourceID when other display data is associated with the Item  
    Stopped trying to show Models for all Items with SourceIDs, only showing for Artifact variants currently (probably needs the player model to display certain visuals properly)  
- Made some progress on Black Temple.  
- Moved the Vials of Eternity to the Caverns of Time.  
- Moved all quests relevant to Hyjal Summit into the Hyjal Summit file as per design specifications.  
    Added a constant for CAVERNS\_OF\_TIME.  
- Updated Hyjal Summit to work with Classic data and requirements.  
- updated description for droman aliothe's rsvp quest  
- Re-organized and cleaned up "Love is in the Air"  
- Updated the formatting of Tempest Keep based on weird retail behaviour. (perhaps revisit later)  
- Fixed a bug with the legendary weapons in Tempest Keep.  
- Level squish was Shadowlands.  
- Updated the formatting of SSC and added explicit class requirements to T4/T5 Tokens.  
- Updated/added some legion Hunter quests  
- Cleaned up Magtheridon's Lair and its associated quests.  
- New localization string  
- ....  
- ...  
- Added Thrown weapons up to and including TBC.  
- Sync localization (#759)  
- Fix last  
- Fix path in localization script  
- More Noblegarden, added cost to vendor items  
- Warlock Class Hall tidy up  
- Since cost is now a thing, I've cleaned up all of the explicit references in the raids for tier tokens for Burning Crusade. (someone else feel free to do newer content)  
- Added an unsorted item from Death Knight mission  
- Removed all references to "order", "ordered", and "sort" properties. As it turns out, if you were using a non-English client, this could severely affect your bootup time if you are running on a potato.  
- More Death Knight adjustments from playing through  
    Now caching 'nextQuests' (from breadcrumbs)  
    With Breadcrumbs considered collectible, accepting a Quest that will prevent a known prior Breadcrumb from being collected will cause a warning sound and chat alert to be presented  
- Renamed ZA's file to sort by release order.  
- Achievements weren't added until Wrath, so for Classic to use these files, they need to be dynamically ripped out.  
- Removed all of the remaining unnecessary explicit color definitions from descriptions.  
- Removed some more unnecessary explicit color definitions from various descriptions.  
    Added information about Skyshards and associated them with Alani.  
- Removed some unnecessary explicit color definitions from various descriptions... not even halfway done. Please do not do this.  
- Fixed an issue where flight path data would not always attribute unobtainable data on refreshes after the first.  
    Also no longer adding the reference to ATT > Flight Paths to the cache as it is unnecessary bloat, the source within the addon is the only important information.  
- Fixed newly received artifacts being collected immediately  
    More various Death Knight adjustments  
- Fixed some Minilist logic when the current mapID has no data attached to it  
    Fixed/added some Death Knight legion artifact quest chain info  
    Added a sourceQuest to the Legion Death Knight Order Hall flight path  
- Fixed 'Contains' on Artifacts to properly show the nested Variants  
- Minor adjustments to Artifact search/display/tooltips  
- Artifacts with a SourceID display proper tooltips now  
    Underlight Angler shows the proper artifact variants in the Model preview  
    Any SourceID can be visually previewed via the Model preview when manually searching for a Source (/att s:###)  
    Fixed ItemID for a random Legion Leatherworking recipe  
    Harvester saves Artifact sources separately from other sources since they use a different format  
    Parser now reads and associates SourceIDs for ArtifactIDs  
    Removed temporary artifact item caching logic now that all artifacts have their known SourceIDs  
    Modified Harvester so it can re-harvest during the same game session using the same or new parameters  
- Add Wago.io integration (#758)  
- Minor Update to shop Icon  
- Minor update to Item Sets icon  
- Small event Icon update  
    More to come  
- Minor fixes and updated Timewalking  
- Deleting old icon  
- Deleting to make a small update  
- Deleting to make a small update  
- Deleting to make a small update  
- Deleting to make a small update  
- Xpac Features updated (Blue +)  
- Deleting old icon  
- Small update to Dugeon and Raids Icon (swirly portal)  
- Deleting Old Icon  
- New Zone Icon (mini Azeroth)  
- Deleting Old Icon  
- Added Revamped Xpac icons  
- Deleting Old Xpac Icon  
- Deleting Old Xpac Icon  
- Deleting Old Xpac Icon  
- Deleting Old Xpac Icon  
- Deleting Old Xpac Icon  
- Deleting Old Xpac Icon  
- Deleting Old Xpac Icon  
- Deleting Old Xpac Icon  
- Deleting Old Xpac Icon  
- Various minor updates  
- Added more Necrolord crafting things  
- Harvester now collects Artifact SourceIDs [WIP]  
    Harvester now has an option to clear existing data when starting a new harvest (instead of always doing it)  
    All Artifact ItemIDs are cached when data is loaded so that stand-alone Artifacts show their proper Model (i.e. Sourced Hidden Appearances) [Likely temporary work-around]  
- Fixed comments on two Deadmines items  
    Fixed modID on Cookie's Tenderizer  
    Slight improvement to harvester performance  
- Fixed dynamic flight path section sorting  
- The Flight Paths dynamic section now fills itself with cached metadata.  
- Added possible Source ID to group tooltips which do not have/generate their own Item link (i.e. artifact variants)  
- Fixed Parser not actually including the offHand data for Artifacts as Items  
- Removed lots of unused custom headers  
- Fixed a couple weird artifacts which were nested inside of their hidden unlock Item under the main artifact category  
    Added 'isOffHand' to the Parser/artifacts so we can store extra information about artifacts in order to generate the proper item link  
    Fixed a lot of artifact logic so that the model shows properly for the current artifact variant  
    Relative Artifact ItemID is cached properly so that artifacts listed elsewhere (hidden artifacts, etc.) will show their proper model with the tooltip [WIP]  
- update zhCN by fredako (萌丶汉丶纸) (#749)  
- Some manual fixes for object localization  
- Localization fixes (#756)  
- More Priest and Warlock Class Hall tidy up  
- Rename BfA expansion features folder  
- Move secrets in evironment to the step level from job level in release workflow  
- Fixed a bug when trying to open a popout list using a sourceID which isn't in the DB  
    Small logic adjustments to try and improve performance concerning items  
    Small adjustments to try and improve performance when searching for item links  
    Removed some unnecessary lines  
- Converted Mount Collection refreshing into an After-Combat callback  
    Improved update performance of checking all collected mounts (plus it should refresh correctly if learning multiple mounts during combat or within a single game frame)  
- Converted the RefreshSaves coroutine into an After-Combat callback  
- Fixed unnecessary yield which caused problems when a mapID can not be retrieved when changing zones  
- Old goblin/gnome engineer quests are back to being removed.  
- Updated more Warlock legion things  
- Fixed Items from alt-collected Quests being treated as an available 'cost'  
- Modified Faction objects to behave similar to other objects for being 'saved' in that it is based on the current character's actual reputation  
- Fixed Callback functionality to actually utilize parameters properly  
    Added an 'AfterCombatCallback' function so we don't need to create repeated combat-checking coroutines and can just register a function to process once combat ends  
    Moved Quest completion checking into an After-Combat callback so that it does not trigger during combat and will only trigger once per frame  
    Moved Location/Minilist refresh into an After-Combat callback  
- another poa weekly  
- Partially fixed some logic for groups which have a cost but can be alt-collected via altQuests  
    Groups with a total that also have a cost can cause variable collection states based on update progress when refreshing or changing collection filters [WIP]  
- another dredger butler quest  
- Added/updated more Rogue legion quests  
- Added Daisy pet.  Added details for several more warlock legion quests.  
- Added all known Holidays to holiday icon table  
- Added an Ember Court Dredger butler upgrade Item/Quest  
- Another Ember Court HQT  
- Added an Ember Court Restock quest  
- Couple Sootible Hat HQTs  
- Fixed Recipe SpellID's being applied sometimes to Items which match the name of the Recipe but do not contain a colon in the name (still blaming Blizzard for this travesty)  
- Fixed auto-expanding of the minilist current difficulty  
- Further clean up of Noblegarden + costs on some achievements (maybe it's all good now?)  
- Further cleanup of Noblegarden + Quests  
- Added logic to allow for custom Holiday icons in one place rather than all over Source files  
    Added a Source constant for Noblegarden's unobtainable filter value and implemented in some places  
    Converted all Noblegarden headers to use the consistent 'Holiday' group logic  
    Cleaned up a lot of horribly weird mashup of items and achievements (we have better ways to handle this intention now) [WIP]  
- Paladin Class Hall tidy up part 3  
- more path of ascension and some other small covenant additions  
- Modified LFR groupings for BFA:BoD to be uncollectible faction-specific achievement headers  
- Removed remaining locailization comments  
- Updated some Legion Rogue quests  
- Some more Legion quest cleanup  
- Adjusted the 'saved' property throughout to consistently represent a boolean value for whether the current character has completed a specific group, or is otherwise locked from completing a group  
    Fixed not auto-expanding Saved groups  
    Cleaned up some looped variable declarations  
    Added lazy window update when accepting a quest so that the current quest indicator shows properly if necessary  
- More Legion quest cleanup - fixed quests that were incorrectly marked as removed and/or alliance-only; updated providers, coords, formatting etc.  
- a few night fae map names added in comments  
- Undid last couple ICC changes; instead removed marks from common boss drops. Now you can see the marks you still need on each of the exact bosses that drop them, and since the marks are costs they contain the tier items linked to them from the vendors.  
- Removed duplicate marks under several other ICC bosses that are already under Common Boss Drops  
- Removed duplicate marks under Deathbringer Saurfang that are already under Common Boss Drops  
    Added A Timely Summons from Northrend quest  
- Updated more legion warlock quests  
- Added a 'Star' indicator which shows next to any Quest row which is currently active for your character  
- Modified some collection update logic to reduce lag when collecting certain types of Things  
- Consolidated Flight Path collection logic further  
- Fixed Refresh logic for Quest Chain Windows to ignore Account-Wide Quest collection (i.e. while moving/resizing the window)  
    Fixed initial Update/Refresh for Quest Chain Windows not taking place  
- Consolidated some Parser Merge logic  
- Converted WOD crafted items to utilize 'cost' instead of being nested inside their upgrade item (which is irrelevant now anyway...)  
- Added a few Warlock legion quests  
- Added HQT for Unworthy Crown  
- Added Unity quest  
- Modified the Class Preset filters to include various filterIDs which are applied to normally non-collectible Things, so they do not inherently hide actual collectibles below themselves (i.e. Containers with Appearances)  
    Modified the Update method to only propogate to child groups if it is itself visible (instead of inside out, due to our filtering not always being applied to the collectible nodes)  
- unique mode fix for legendary from firelands  
- Fixed missing Artifact account-wide data check (fixes #754)  
- Fixed some filtering logic which was ignoring specific filters (fishing poles, etc.) and was always showing them (due to trying to work-around for something else previously...)  
    Fixed group update logic to ensure visibility when sub-groups are supposed to be visible  
- Fixed Tooltips not showing SourceID for Items with hidden SourceID's  
    Fixed Things with hidden SourceID's not being applied/utilized properly (fishing poles, etc.)  
- some NYI stuff  
- some NYI items (maybe we get some info for those)  
- tagged some pet battle quests as not repeatable even with party sync  
- THE\_MAW map constant  
- REVENDRETH map constant  
- ARDENWEALD map constant  
- fix for a NYI item & a class/profession book  
- Formatting  
- MALDRAXXUS map constant  
- ORIBOS map constant  
- SHADOWLANDS map constant  
- BASTION map constant  
- Formatting, CHAMBER\_OF\_HEART constants  
- Paladin Class Hall tidy up pt 2  
- Assign lvl 50 to all BfA raids  
- more necrolord stuff  
- Paladin Class Hall tidy up pt 1  
- Removed weird achievement tagging from Juggling Torch which made it become permanently uncollectible  
- HQT for Ember Court unlock  
- Adjusted Update logic to process based on actual Windows instead of all existing data and cloned data during an entire game session  
    Added/modified Callback functionality for self-calling function callbacks  
    Collecting Pets no longer causes excess lag  
- Fixed Debug mode from hiding Things  
- Fixed a bug when switching between Unique and Comp modes.  
- Fixed Parser logic from attempting to associate a recipeID to something that isn't an Item or is a Profession-specific Toy  
    Removed printing of automated recipe associations--we need to move towards consolidated/automated information not into spreading the same information into thousands of new places  
- Recipe fixes I  
- Parser now outputs the missing Recipe Skill using the proper Skill constant string  
- Converted one example Recipe  
- Fixed Recipe syncing with their Items for approximately 1400 Items  
    Parser now shows which ItemIDs need to have their proper recipe/skill information included in Source eventually  
- mapped battle for stromgarde quests to their scenario  
- adding missing object names so my loading screens aren't 3 minutes long on an ssd  
    slumber emoji dagger emoji  
- Mole machine tidy up  
- Quests from darkal & put the entire black dagger questline together under kultiras (alliance) & zandalar (horde)  
- The old ArtifactRelicItemLevels table has ilvls that are far too high to be possible. I'm going to allow this table to get wiped out with the transition.  
- Added a note and customCollect  
- Quest Chain Requirement popouts will now include the Item which starts the initial Quest of the sequence for clarity (if the Item has been Sourced)  
    Removed QuestID from Lifewoven Bracelet as it is already used as a provider for that Quest  
- Ember Court additions and clean up/speculation/organization  
- Improved performance of tooltip rendering for Items  
- Due to an annoying race condition involving PLAYER\_LOGIN, I've refactored the event into VARIABLES\_LOADED.  
- Item icon IDs are also cached once retrieved  
- Add two new object names  
- Remove some redundant info from source files  
- Added support for Square minimaps.  
- sourcetree crashed  
- some level tagging  
- quest provided by darkal  
- order change with pandaria files  
- Now ignoring the sync tool's log file.  
- Added some missing helper files.  
- Refactored the ATT Sync Tool to work with the latest SavedVariables format standard.  
- quests provided by darkal  
- Pet Battle quests and altQuests  
- Vulpera heritage tracking quest  
- Added Swords Deck to DMF  
- The CollectedSources table is now stored in the ATTAccountWideData table.  
- All account wide collection tables other than CollectedSources are now stored in ATTAccountWideData.  
- Sorting functionality is no longer recursive  
- Commented out some update logic that doesn't pertain to Retail  
- Adjusted IsNPCQuestGiver to match variable-naming and formatting and to only consider objects with questID for the requested NPC (#750)  
    Removed regroup logic from IsNPCQuestGiver since 'visible' for groups is calculated based on active filters already  
- Add IsNPCQuestGiver (#750)  
    Added IsNPCQuestGiver function  
    * Exposes a public method to query if the current character has any Quests available from the provided NPCID  
- Modified Callback functionality so that a method can Callback itself  
    Converted the CustomCollectibility table into the new ATTCharacterData format  
    Fixed issue where CustomCollectibility attempts to process prior to having addon variables loaded  
- added crs for final thread to gieger, some more necrolord stuff  
- corrected a necrolord sq, added isdaily tag to a treasure chest in maldraxxus  
- Refactored some unnecessary globals and fixed the AH Module.  
- nyi items + parser  
- fixing tahonta note  
- bloop  
- Fixed level on Ancient Tome of Teleport: Dalaran description  
    Removed Legion intro quest description incorrect post squish  
- Mark "Assault on Violet Hold: Into the Violet Hold" as removed in DH Class Hall  
- Sync localization (#753)  
- Localize "ItemFilter" window  
- Fix percent notes on Vicious Saddle, fixes #751  
- Removed all references to CollectedFactionBonusReputationPerCharacter as it was not saved, backed up, or even used. Good job, drunk Crieve!  
- Removed a massive chunk of unused data in the saved variables pertaining to Source Sets, which are used to display an item's relevant Transmog Sets for other characters. The memory cost was not worth the feature.  
- Slightly changed how Achievements are cached.  
- Cleaned up how we save the Artifact Relic Level data used for calculating the usefulness of an Artifact Relic.  
- Converted the AzeriteEssenceRanks table into the new ATTCharacterData format.  
- Converted the Spells table into the new ATTCharacterData format.  
- Converted the Buildings table into the new ATTCharacterData format.  
- Converted the Factions table into the new ATTCharacterData format.  
- Converted the Titles table into the new ATTCharacterData format.  
- Converted the Flight Paths and Quests tables into the new ATTCharacterData format.  
- Converted the Followers table into the new ATTCharacterData format.  
- Converted the lockouts table to exist relative to the character in saved data.  
- Fixed the account wide death counter.  
- Adjusted how we cache Achievement collection data. (and where)  
- starting on necrolord verification/updates  
- Corrected a number of issues caused by my last OnUpdate modification.  
    Also removed a ton of unnecessary in line localization comments. (please don't do this)  
- Converted the Characters table into the ATTCharacterData table.  
    Converted the Death Tracker to utilize the new Character Data table.  
    The UpdateGroups pipeline has been modified to use the standard Update Loop rather than... whatever the hell it was doing instead.  
- Dark Iron mole machines should now collect appropriately as 'Quests'  
- Commented out the 'infintie source quest loop' check for now...  
- some night fae quest/map adjustments  
- Fix some localized strings  
- scooted ensembles beneath arsenals in boralus, added a missing object for a night fae campaign quest  
- The deaths tracker now hides the realm name for characters on your realm.  
- Added the "ItemFilter" window. You can access it from this debug script: /script AllTheThings:GetWindow("ItemFilter"):Toggle()  
- Updated Parser now properly writes OnUpdate.  
- Fixed unobtainable status of 2 Exile's Reach FP's for Alliance  
- Keys are now also removed from the filter list.  
