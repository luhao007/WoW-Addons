# AllTheThings

## [5.0.6](https://github.com/ATTWoWAddon/AllTheThings/tree/5.0.6) (2026-02-08)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/5.0.5...5.0.6) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- Adjusted the debugger's import mechanic to account for situations where you would want to do some programmatic imports.  
    Using the Import Data button will now force an update.  
- Update Townlong Steppes.lua  
    NPCs now show ach criteria in tooltip  
- Springfur Alpaca  
    Think it's better under Special vs Quests?  
- Removed a print statement.  
- Added a button for Importing Raw Data into the Debugger!  
- Added buttons for exporting the data in Readable format.  
- Updated the Debugger window to include a rudementary Export All Data button.  
- [Logic] "Achievements" still sync for pre-WotLK versions  
- [Logic] Fixed an issue where Achievements were losing account-wide credit due when the opposing faction clone of the Achievement is completed instead  
- [Logic] Ensure summaryText field causes proper refresh if needed  
- [Logic] Fixed Auctions window not properly receiving async Refreshes  
- Formatting: Unifying the codestyle of ["cost"] field, Part 4  
- [Parser] Retail: No longer merges Objective-based NPCs under the parent Quest if that quest is marked removed. (Maybe can revisit in the future but for now this should fix most of those removed tooltips on existing NPCs which just have no apparent purpose anymore)  
- Added back the Debugger print statement for object names.  
- Formatting: Unifying the codestyle of ["cost"] field, Part 3  
- Added 3 missing Endeavors percentage HQTs.  
- [DB] Removed quest causes Grimble to appear as removed.  
- [Locale] Update zhTW.  
- [DB] HQT 94713  
- Classic: Fixed a bug where the maxreputation for a quest was being ignored by the cost evaluation logic.  
- Updated the Faction Cache (by removing it) for Quest Collectibles. Some quests have different requirements than others.  
    This commit fixes Horde specific cloth turn in quests being shown to Alliance players, etc.  
- Formatting: Unifying the codestyle of ["cost"] field, Part 2  
    - Also, fix blunders from previous commit  
- Formatting: Unifying the codestyle of ["cost"] field, Part 1  
- Twilight Ascension: Bonus Exp HQT  
- Added one more decor from housing area vendors.  
- Object DB Condensed - Parsed  
- Update 11 Midnight.lua  
    Not required.. but probably an account wide quest somewhere that does need to be completed.  
- #2286 The Debugger window now ignores secret value'd mobs.  
- #2285 The Debugger Window no longer gets activated by opening the Windows page of the Settings Menu.  
- Fixed a quest objective update bug where the tooltip was showing old objective data.  
- Added missing decor from housing area vendors.  
- Added breadcrumb from the new DH spec unlock questline.  
- [DB] Sourcing some vanilla and TBC consumables  
- Mark the latest Razer promo as removed  
- [UI] Fixed wrong tooltip on max tooltip top line length slider  
- [DB] Ecological Stability trackers appear to reset daily or some other schedule  
- [UI] Shift over Profile buttons now that the scroller is outside of the scrollbox  
- Costs now reference objectiveCost if no amount is supplied, otherwise fallback to 1.  
- Not sure how this through an error, but it did.  
- [DB] HQT 94711  
- contrib errors  
- [Logic] Fixed some nuanced Window issues  
    * MiniList properly loads an empty map when loading into an empty map (i.e. player housing interior)  
    * Fixed some repeated Updates when windows auto-open on load  
    * Some Events are properly Runner-based again to smooth out frames  
    * Fixed when an auto-load window with no content which is opened prior to windows being setup would fail to rebuild itself and show properly as expected  
- [Logic] Don't treat Neighborhood/Player housing like an Instance for certain aspects of building the Minilist  
- Classic: Fixed the issue with Deeprun Tram not substituting its mini list. This should also fix all of the starting zones as well.  
- [DB] Fixed Skinnin' For A Livin' guild achieve becoming a regular achievement due to deleted achievement data from Blizz  
- [Logic] autoHeaderID now caches as headerID since existing searches for headerID should match as they previously did (this fixes Heirloom upgrades disappearing entirely for one thing)  
- Classic Era / TBC: Fixed Battle Pet, Mount, and Toy detection.  
- [Logic] Make sure OnSetVisibilityForNestedQuest is defined in versions without party sync APIs for any users using 'Show Nested Quest Chains' option  
- [Logic] Fixed an issue where ATT Row tooltips would display information as if they were actually external tooltips  
- [DB] Cartel deals are account-wide  
- [DB] Fixed Expert Cookbook & many Charred Recipes having Recipes attached  
- [Logic] Fixed Windows getting stuck (while moving them) when the mouse moves off the top of the screen  
- [Logic] Fixed the Holiday header getting nested twice in the Minilist (and any other header which is also marked as a difficulty)  
- Ripped out Mount Journal and Battle Pet Lib content from the Classic/Mounts & Battle Pets file to simplify the logic a bit.  
- Pedantic timeline adjustment for Sin'dorei endeavor vendor  
- Fixed a bug in Tradeskills since SkillRank is gone. (Not sure what this was for, but the functionality is missing)  
- [Logic] Moved priority-based object creation to CreateClassInstance to replace a lot of logic in \_\_CreateObject  
- Quest Objectives now appear in the tooltip once again.  
- [Logic] Try to get Raid Assistant to chill out a bit  
- CreateObject now accounts for Objectives.  
- [Issue] Update flavor options.  
- [Misc.] Unfify case.  
- [Issue] Update flavor options.  
- [Logic] Fixed Window positions not being loaded when switching Profiles (will eventually be migrated to a Layout system)  
- [DB] A couple HQTs.  
- [Logic] Classic: BattlePets cache now properly initialized if missing  
- [Logic] Fixed Lua error for new users due to a missing default settings value for 'ContainsCount'  
- [Logic] Fixed Lua error when AllTheThingsSettingsPerCharacter does not exist for a character  
- [Logic] app.StartATTCoroutine can use the highly-optimized Runner coroutine handling  
- [Logic] Fixed Lua error when setting up Profiles for the first time  
- Fix a few reported errors  
- added cn items based on info  
- ci: revert attempted release optimisations  
    if we specify target in fetch we don't retrieve tags by default  
    and explicitly requesting tags doesn't work with depth  
    therefore we can't (easily) fetch only one branch with tags up to specified depth  
- ci: fetch tags in release again  
- ci: optimise release workflow  
    by not fetching non-release branches  
- Uppercase the List window name, so it's consistent with all other windows.  
- Fixed titles of Hidden windows.  
- You can now use "mid" with the Added With Patch window.  
- Fixed space for "After Refresh" text in the settings.  
- [Logic] Errors from Runners/Coroutines now use a dialog to contain the stack trace for better reporting (instead of just printing to chat)  
- [CI] Fix no changelog.  
- [Logic] Cleaned up and encapsulated Settings Slider creation  
    * Fixed Slider tooltips not showing  
- [DB] Prepatch WQs don't require the intro quest chain  
- [Logic] Fixed a Lua error due to some ATT windows being created and trying to access Settings prior to Settings being setup  
- [Logic] Cleaned up ATT slider settings logic (will probably revise further later on to work like other settings objects)  
    * Sliders now react to Profile changes properly  
    [Logic] ATT Windows now control themselves based on respective slider settings changes (rather than Settings controlling various Window functionality directly) (this will probably be slightly refactored as well soon)  
- [Logic] DirectGroupRefresh uses a soft-update again to ensure some expected functionality as is currently used is maintained  
    [Logic] Search logic uses DirectGroupRefresh again to work properly for filtered search content  
- [Logic] Fixed ScrollTo trying to scroll to negative indexes  
- Reeee  
- [Logic] Some Toys class cleanup  
- Fixed the hidden ones as well.  
- /att nwp works again, for now.  
- Fix a few reported errors  
- [Logic] Removed a bunch of unnecessary account data sync overrides which were unexpectedly clearing account wide data (Since only certain tables are whitelisted now for sync, or specific to certain caches, we don't want overrides doing completely different logic)  
- Remove manual sourceID override for pre-patch event crossbows  
    baked into Wago files now  
- Update Wago build files  
    this does result in different Parser output  
    GlobalStrings taken from https://www.townlong-yak.com/framexml/live/Helix/GlobalStrings.lua  
- The Related Things content is now flagged as source ignored so that it doesn't appear in the tooltip for achievements when the achievement is popped out.  
- Classic Era: Fixed the Insane in the Membrane achievement criteria.  
- ci: fix Classic Parsers in release workflow  
- ci: fetch deeper during release  
    manual fetch won't unshallow  
- ci: fetch tags manually  
    version 6.0.2 of checkout action has changed some logic concerning tags  
    so now it takes forever to retrieve all of them  
    instead we just fetch last 300 commits with tags ourselves  
- Revert "[CI] Try to fix timeout."  
- Added Strategist title.  
- Midnight catalyst preperations  
- Added 'Light of the Party' achievement and all its rewards.  
- [CI] Decrease depth.  
- [CI] Try to fix timeout.  
- [DB] Event: Correcting descriptions for Mysterious Satchels  
- Added the Maximum Price filter to the Auctions window.  
- [DB] Extra note for Cartel Zo Dead Drop  
- Fixed Prime not waiting until after all windows have been created before calling to GetDataCache.  
- Fixed the mini list loading correctly.  
- [Debug] Whitespace and debug print adjustments from testing  
- [Logic] Run Runner debug prints a bit faster when in Debugging  
- Rebuilt all DBs to include updated localization.  
- Window Definitions -- Phase 1 (#2281)  
    * Classic: Fixed a bug where window colors are not having their colors assigned correctly after a load for the class color setting.  
    * Fixed an issue with the RawText class that was causing an infinite loop. Changing the key fixes it. No idea why.  
    * Retail: Removed the need for the Toggle and SetVisible functions to pass through a force parameter. (Use HasPendingUpdate instead)  
    Classic: Refactored forceFullDataRefresh to HasPendingUpdate to match Retail.  
    Classic: Added support for locking windows and content tracking to match Retail.  
    * Retail: Refactored the name of the StorePosition function to RecordSettings to match Classic. This function will do more than just store position after these changes are finished.  
    * Improved the Container's CreateRow behaviour in both Classic and Retail.  
    Simplified the CreateWindow logic in Classic. (Part 1)  
    Retail: Windows are no longer flagged as UserPlaced. (This attempts to save window position to the Character's WoW UI Saved Variables, but it doesn't actually work and causes the data to be written for no reason)  
    * Unified some of the row helper functions for back, indent, expand, and portrait settings.  
    * Added the ExtendBaseClassHandler function that will allow us to inject new fields to the class constructors.  
    * Classic: Moved ProcessGroup to the consolidated section.  
    * Classic: Fixed a number of windows that didn't utilize the raw text class yet.  
    * Classic: Assigned each window's header to the Raw Text class.  
    * Classic: Deprecated and removed "CloneReference" as it doesn't properly handle inherited class methods and causes a ton of potential logical bugs that I'd rather never deal with again. This will slightly increase memory requirements of the dynamic content within windows.  
    * Refactored "progressText" to "summaryText".  
    You can now have an empty summaryText value. (This makes buttons less visually annoying to look at)  
    Refactored SetRowData and removed ClearRowData.  
    * Classic: Local List is no longer marked Top Level.  
    * Retail: Added the Auctions Module from Classic and it works!  
    The Auction Module now sorts data into their \_\_type categories in all flavors.  
    * Classic: Fixed AH searching.  
    * Classic: Added additional meta keys for Simple Item types.  
    * Retail: Now handling character unlock, mount mod, and item as HQT object types in the new Auction Module.  
    * Retail: Moved the declaration for progress and status text / icons to the shared window logic file (for now)  
    Classic: Added the statistic field to Achievements and the status text now shows currency and statistic data.  
    * Refactored "Refresh" to a less generic name "UpdateVisibleRowData" to match Classic.  
    * Fixed an annoying bug with the new Auction Module that was only using the final meta key value's groups. (It was wiping it for each meta key...!)  
    * Fixed yet another Auction Module bug involving the doubling up of items when an additional search is performed.  
    * Classic: Fixed the highlight texture overlay to prevent the inactive state from overlapping the left side border.  
    * The Auction Module now allows you to single click on bid auctions to search for those easier as well.  
    * Removed 110207 from Retail's list of supported versions.  
    * Classic: Now fully supporting TryColorizeName's integration into the text field.  
    * Classic: Fixed the Tradeskills window to properly show the headers without throwing an error about a missing metatable.  
    * Made some significant improvements to Classic's CreateWindow and arranged the functionality in a more clear way.  
    OnRenderDirty is now OnRedrawWindows. (Retail currently does a Refresh for this as there is no Redraw equivalent yet)  
    * Added the ability to specify an "Inactive Window Alpha", which makes it so that windows outside of mouse focus can be uniformly dimmed.  
    * New row highlight appearance!  
    * Classic: Added ScrollTo to the window definition.  
    * Removed the unused UpdateDone logic.  
    * Classic: Moving the mouse outside of the game window now releases the drag effect for a window. (fixes a bug with the window drag getting stuck to the cursor)  
    Classic: Moved the logic that creates a window to a secondary BuildWindow function. (Prep work for making window frames not immediately be created)  
    * Classic: Added support for the "Adjust Row Indents" configuration feature.  
    * Added localization for the new settings menu elements.  
    * Retail: Now using persistent Window Definition logic from Classic! (Part 1 of 134455)  
    * Retail: Enabled a whole buncha new windows from Classic!  
    * Fixed a bug with the Race class.  
    * Couple more fixes for retail windows.  
    * Fixed the Close Button for windows!  
    * Added Race ID to Information Types.  
    * Refactored Retail's "BuildSearchResponse" function to "BuildSearchResponseRetailStyle" just so that we don't lose which window was expecting what type of response. (They do slightly different things)  
    Copied over Classic's version to Retail and that fixed like half of the problems. lol  
    * Retail: The Bounty window is now fully compatible.  
    * Retail: The Added With Patch is now compatible and provides the game's current build version as the initial state if no state has been saved.  
    * Fixed an achievement bug where criteria objects were unaware that they were children of an achievement.  
    * Retail: The Unsorted window is now fully compatible.  
    * Updated SetWorldMapButtonSettings to not need to be manually activated.  
    * Updated ApplyAllWindowColors to not need to be manually activated.  
    * Cleaned up the event sequence on startup.  
    * Fixed the atlas border and background alignments for Artifact class types.  
    * Contribute now uses OnStartup.  
    * Startup events are now executed immediately.  
    * IgnorePopout is fine.  
    * AdHoc is built into all windows now. It's not something you need to enable.  
    * Fixed the Trading Post header in Prime.  
    * Synchronized a few of the primary categories.  
    Pet Battles dynamic category is not compatible with Retail yet.  
    * Drop Changes have been removed. This was highly inaccurate due to sourcing style changes and is significantly less important in retail environments now that everyone can learn anything.  
    * Updated the Refresh Lib and converted Classic over to using the Retail Refresh Collections logic.  
    * Consolidated the Settings Menu! Profiles now supported in Classic and Windows now (mostly) supported in Retail! (Still more work to do...)  
    * Fixed a display bug for the Windows Page.  
    * Classic: Adjusted GetDataCache a bit.  
    * The Death Tracker has been deprecated as a collectible Thing in Classic and no longer counts towards the total.  
    All functionality related to it has been rolled into a Debug Mode Only object, which will be displayed in the Classic version of the Main List as well.  
    * The Death Tracker can once again be popped out to its own group, if desired. Also simplified the logic for the class a lot since we no longer need to react to settings logic.  
    * The fields "progress" and "progressText" in tooltipInfo have been standardized to the lesser used "summaryText" field. This should make trying to find it a bit easier.  
    * Classic: Now supports DataHandling. Deprecated and removed RefreshDataQuietly.  
    * The two window logic files are now identical. (Though neither of the quest chain builders work... Sigh.)  
    * Combined the shared logic window with the remaining window logic file into the new Window Definitions source file.  
    * Fixed the Classic style of Quest Chain Requirements.  
    * Fixed tooltips for the classic variant.  
    * Fixed the retail style quest chain nesting behaviour.  
    * Dynamic Windows now properly destroy themselves even if they get detatched from their frames.  
    * The Prime list is now responsible for the command parsing of /att commands.  
    * Fixed a bug where a dynamic list opened twice would remain closed despite its final state being opened.  
    * Added C\_CurrencyInfo API into the WOWAPI Wrapper file.  
    Fixed some errors in Costs, Catalysts and Currency to make them compatible with MOP. (still need to check other flavors)  
    * Classic: No longer caching AllGamePatches.  
    * Improved cache performance and simplified flavor differences.  
    * Refactored the Heirlooms dynamic category to search for heirloomID using the flat search helper function.  
    * Updated the Retail specific windows to only load in retail and the classic variant to only load in classic. (to simplify the Windows.xml files)  
    * Updated build configurations for all Classic flavors to inherit build configuration settings from the retail config.  
    * Now utilizing more retail classes in Classic.  
    Tradeskills dynamic window no longer uses a symlink to generate its content.  
    Deprecated nearly every classic specific modification.  
    * Fixed Prime not refreshing in Classic.  
    * Dynamic Categories now correctly refresh their content.  
    * Fixed the Parser job to account for the new base configs.  
    * Adjusted all window definitions to call SetData in their OnInit other than the Mini List and Prime.  
    * The Bounty and New With Patch window no longer throws an exception if there are no results.  
    Fixed the Attunements window to work with keys. (Only tested in Classic Era)  
    * Updated the Mounts Window to toggle between Flat and Categorized.  
    Added functionality to build flat and categorized dynamic categories.  
    * Fixed Dynamic Categories automatically refreshing their internal groups value.  
    TogglingFlat now also updates Prime for Dynamic Categories.  
    * No longer generating the content of the Windows Page on game load.  
    * [Logic] Fixed Windows not respecting Profile-based definitions  
    * Fixed the Window Style page. Windows are no longer prewarmed by the Settings Menu accidentally.  
    Added Flat / Category toggle to the Settings Menu.  
    * The Crafted Items section now uses the custom header.  
    * OnTooltipForWindowButton in the Settings Menu no longer causes a FullUpdate!  
    * The categories selected by the Categorize function now include RootCategories and AutoHeader types. (though this should be looked at further if that's what we want)  
    Temporarily disabled Titles and Toys dynamic categories.  
    * Fixed the Titles dynamic category.  
    * Fixed the Toys dynamic category.  
    All of the windows that use SetFlat now appear in the Style menu.  
    * The Titles window once again shows Honor Titles pre-TBC.  
    * Fixed Heirlooms window and made it Flat compatible.  
    * Fixed the performance of Prime.  
    * Adjusted the event sequence for the RefreshCollections pipeline. (This whole system needs to be looked at for efficiency.)  
    * Removed the old settings to automatically open the main list, mini list, raid assistant, and world quests lists. (Windows are persistent, just leave them open if you want them!)  
    * Moved Prime's data assignment to its init. (this only caches it, it doesn't do work on it)  
    * Fixed the World Quests window.  
    * [Logic] Don't use coroutine to refresh windows when Retrieving data encountered. AsyncRefreshFunc is available for most delayed-refresh types  
    * [Logic] Force IsReady as the first handler in OnReady Event and remove \_\_OnIsReady Event (this IsReady is barely used, may even just remove at some point)  
    * Added the ability to tell a window definition that it needs to AutomaticallyOpen next reload regardless of its state at the end of a session.  
    * Don't automatically hide blank windows.  
    Added Discord Reporting for map data in classic.  
    Updated Mini List for Classic (About to add Retail stuff in as well)  
    * The Mini List now supports the Retail style from before the chaos began, though something seems wrong.  
    * Fixed the Retail Style for the Mini List window!  
    * [Logic] Fixed Mini List for Retail due to Lua error  
    [Logic] Fixed using VisualHeaders again in Mini List due to summaryText not allowed to override within Wrapped objects  
    [Logic] Removed OnWindowRefreshed for now since it's otherwise not needed except debugging currently  
    [Logic] OnWindowRefreshed will now be immediate (if used in the future)  
    * [Misc] Note to fix old settings into new window settings, not just remove  
    * [Logic] Updated how ExpandGroupsRecursively functions. It now acts as a top level call to ForceExpandGroupsRecursively and ConditionallyExpandGroupsRecursively.  
    ConditionallyExpandGroupsRecursively now internally handles the expansion of difficulties based on the settings.  
    This new system uses a difficultyHash that is cached on the difficulty object itself (since combinations are sporadic and not the same between expansions)  
    Deleted the Classic Mini List in favor of the more modern Retail Mini List style.  
    * Fixed the Auction Module again. (Preload doing weird things)  
    * [Logic] Speed up ProcessGroup by a decent amount  
    * [Logic] Callback scrollvalue updates since sometimes they do multiple changes within a single click or frame  
    [Debug] Couple debugging prints for later troubleshooting  
    * [Logic] Windows with OnUpdate should return true if the base Window logic should skip the DefaultUpdate. Otherwise there's no need to directly call DefaultUpdate as the last operation within OnUpdate as it will always be performed by the base Window logic afterwards  
    * Added in Dynamic Category Summary Headers to the AWP and NWP windows.  
    Fixed those windows to work with all game flavors and provided a means to opt in new categories.  
    * Fixed the Pet Battles dynamic window.  
    * [Logic] DirectGroupRefresh should just do a direct Refresh rather than soft-Update on the associated window  
    * [Logic] Rename IsFullyCollapsed -> HasExpandedSubgroup to represent what the function checks  
    * [Logic] Window scrollbars now behave as they previously did in Retail  
    * Scrolling uses 'paging' when clicking the empty portion of the scrollbar  
    * Scrollbar hides itself when there's not enough visible data in the window to require scrolling  
    * [Logic] Added a TableKeyDiff function to return whether two tables have different sets of assigned keys  
    [Logic] The Minilist now captures the current difficulties when it Rebuilds  
    [Logic] The Minilist no longer does a Rebuild due to PLAYER\_DIFFICULTY\_CHANGED unless the difficulties have actually changed  
    * [Logic] Retail: PLAYER\_DIFFICULTY\_CHANGED currently unnecessary for Retail since the difficulty cannot be changed while within instances  
    * [Logic] Quick conversion of Retail's Raid Assistant to function as expected  
    * Adjusted all of the hidden windows based on how they were used in Retail.  
    * [Logic] Fixed TLUG update  
    * Adjusted logic for all Quest related Windows and the Locked window.  
    * [Logic] Fixed a rendering issue when an unloaded Thing is placed into a new Row and never refreshes itself  
    * Updated the Illusions window and also turned on the ability to customize whether it is categorized or a flat list.  
    * Updated the Flight Paths window and also turned on the ability to customize whether it is categorized or a flat list.  
    * Fixed a bug with WindowDefinitions in the Windows page of the Settings menu.  
    * Updated the Factions window and also turned on the ability to customize whether it is categorized or a flat list.  
    * Fixed a localization error on /attexploration  
    * Fixed a missing table reference in the classic tradeskills UI  
    * Fixed a scenario where a broken specialization spell (from Alchemy no less?) appears in the dynamic profession recipe list.  
    * [Logic] Converted /att random to new window definition and fixed some logic issues  
    [DB] Remove Ad-Hoc settings reference from NOTHING\_TO\_SELECT\_FROM string  
    * [Logic] Adjusted some ScrollTo logic to be more efficient and work better (some strange issues still)  
    * Fixed a retrieving data bug where multiple windows attempting to redraw themselves at the same time would cause only one of those windows to redraw and not the other. (Function uniqueness bug involving Callback) [Possibly make Callback a member function of the window?]  
    When you scroll quickly through the list, the game no longer hemmorages due to a larger number of texture redraws if it doesn't have to by ensuring the texture context is different before rendering.  
    * Added the async OnCurrentDifficultiesChanged event. This makes it so that you don't need to manually register for PLAYER\_DIFFICULTY\_CHANGED.  
    Improved the performance of GetCurrentDifficulties, particularly for mini lists with a larger number of difficulty headers. (SoO)  
    Fixed detached Objectives to reference their sourceParent if they have one.  
    * Fixed the display of lockout information on the Difficulty object class.  
    * [Logic] Unhandled window events should Callback the Update incase the Event happens multiple times in a frame  
    [Logic] Missed removing a Refresh when using ScrollTo  
    * [Logic[ Fixed fallback SetOwner using a non-existent global  
    * [Debug] Couple notes for Crieve  
    [Logic] Include Suffx in OnWindowCreated event params to help identify when certain windows are being created  
    * Fixed the process command pass through in CreateWindow.  
    Also fixed the OnEvent handler to pass the object to the function, not the function to the object.  
    * Dynamic Category Headers now sorts the data within.  
    Adjusted the Future Unobtainables window to use raw text class.  
    * Fixed the Difficulty and Raid Assistant features for Classic/TBC. Apparently Classic has the APIs and you can call them on startup, but a few moments after it gets wiped from the list... lol Blizz you drunk  
    * Added a port to graveyard button to the Raid Assistant and removed the failed attempt to use LFG Create Group.  
    * Removed the unused property "ignoreNoEntries"  
    * [Logic] Retail: Raid Assistant: Don't ignore all clicks on header lul  
    * [Logic] OnWindowFillComplete can run immediate  
    [Debug] Fixed some coloring of Event prints which process immediately but also while the Event Runner is handling other events  
    * Merged the Raid Assistant window logic.  
    * Merged the Future Unobtainables window. (Classic actually had a bit more functionality in it.)  
    * Merged the Maps window. (Nothing was really different)  
    * Added the dynamic category header to the Removed From Game window. (/attrfg)  
    * [Logic] Events: Event Runner now always checks OnEndSequenceEvents when it is reset  
    [Logic] Immediate Events which are Sequenced will properly allow the Sequence Event stack to continue queueing even when the Event Runner is not already running  
    * [Logic] Swap order of Raid and Legacy Raid in Raid Assistant window  
    * [Logic] Due to some event sequence changes, we need to sync active fillers directly rather than waiting on an event such that they are active prior to any windows needing filling  
    * [Logic] No need to pollute every cost-able Thing with isOwnedCost=false when nil is fine  
    * [Logic] Optimized the recursive functions for building a flat and categorized search responses.  
    Fixed the label for Toys and Flight Paths when neither contained any content. (discovered by being bad in the above statement)  
    * [Logic] Revised some MiniList handling to provide the prior 'hot-swap' functionality from Retail (returning to a map within a minute will not trigger a full update on the window in an effort to reduce stuttering when quickly changing between zones)  
    * ToggleMiniListForCurrentZone now accepts a mapID to show a specific mapID  
    * MiniList SetMapID now always assumes the MiniList will be shown and can build out the data (why would we set a mapID otherwise?)  
    * MiniList RefreshLocation does the check to determine if the current location should refresh into the MiniList  
    * LocationTrigger uses a 0.1s delayed callback to SetMapID instead of DelayedRebuild  
    * MiniList TryAddAutoExpand represents consolidated expansion assignment  
    * /att mapid command now calls ToggleMiniListForCurrentZone(mapiID) instead of loading the MiniList window itself  
    * Minimap button now calls ToggleMiniListForCurrentZone instead of forcing MiniList to load itself when ATT loads  
    [Logic] Protect Fill assuming LocationTrigger exists (maybe some race condition needs resolving?)  
    * Updated the Random window to search for more things based on availability of content.  
    * [UI] Minor adjustments to alignment of some UI elements for better fit  
    * [Logic] Fix a Lua error when using Blizz frame debugger to inspect ATT windows  
    * [Logic] Fixed Search even when no scrolling occurs  
    [Logic] Reduced looped-function calls in Refresh window logic  
    [Logic] Fixed a Lua error when minimizing a window to only show the top row  
    [Logic] Fixed an issue where a new row would not clear itself when being shown in a window  
    [UI] Give the row container 1 more pixel :wink:  
    * Classic: Updated Naxx to utlize the Gluth symlink now that classic supports the extract command.  
    Classic: Updated Molten Core's Thunderfury quest chain to be visible for non-sword classes post-MOP in an effort to prevent degenerate behaviour in Classic/TBC.  
    * Fixed the Soft Reserves window.  
    * Removed debug prints from that window.  
    * Fixed the Enable Battle.net button on /attsync.  
    * Classic: Fixed the visibility of the Pending Sync Queue in the Account Management window.  
    * [Logic] /att random doesn't need custom OnUpdates for visibility since the whole window ignores the Visibility filter when updating  
    * [Logic] Prime needs to preload (not Init) since tons of stuff relies on it directly  
    * Revert "[Logic] /att random doesn't need custom OnUpdates for visibility since the whole window ignores the Visibility filter when updating"  
    * Removed the OnUpdate from the Random window to allow players to use their own visibility filters for the selected element  
    * [Logic] Added a helper setup for some common Settings objects  
    [Logic] SImplified and protected some settings sliders from insanely-spammy update frequency while being moved  
    * Updated the Account Management (/attsync) window. Apparently it was 100% compatible with Retail and syncs all tables without any changes. Neat.  
    * Fixed the default value for the build property to be a numeric value.  
    * [Logic] Hook Prime into Settings changes via Event (rather than Settings having the logic to directly change Prime) [WIP]  
    * Fixed the Item Filters (/attfilter) window.  
    * Removed the Filter Specific Things Window. This was just a window of every "f" item and was slow as shit. Use /attfilter and select a filter instead.  
    * Removed the old "Removed With Patch Drops" and "Missing Source IDs" windows and made the classic specific windows that are useless in retail classic exclusives.  
    * [Logic] Use FunctionRunner to remove event handlers instead of Callback  
    * Updated ProcessCommand to pass args and cmds instead of just the command.  
    * Pushing progress on the list window so Runaway can mess with it while I'm gone  
    * [Logic] Fixed World Quests window name  
    [Logic] Added a one-time conversion of prior auto-open settings keys into window definition keys  
    [Logic] Fixed various nuanced load issues with Windows based on when they were being created/built  
    [Logic] Fixed ShouldAutomaticallyOpen handling via window settings  
    [Logic] Added a safety-net for any Windows trying to Show themselves before ATT is able to properly render Windows (this shouldn't happen, so any offenders need to get adjusted)  
    [Logic] Reverted initial Quest refresh to OnStartup to prevent attempted Window updates prior to Windows existing  
    * [Logic] Defined EventHandlers for Windows should be defined with a self-reference  
    [Logic] Added a switch for Event Handlers on Windows to be captured with a self-reference handler (will eventually convert all window Event Handlers to be self-referencing by default)  
    * [Logic] Adjusted RecalculateAccountWideData to use the expected handlers for certain types so as to not delete tons of cached Account data  
    [Logic] White-listed the AccountWideData fields which are recalculated (some keys are saved directly in Account, never per Character)  
    [Logic] Adjusted saved variables use in Account Management to rely on proper event  
    * [Logic] Fixed scrolling for the first search in a window  
    * [Logic] Trading Post is allowed to be a minilist header  
    * [Logic] Fixed Cost currency/items not being linkable into chat (Retail bug)  
    * [Logic] Adjust precall-show window timing to prevent showing windows until the first OnWindowsUpdated event is handled. This prevents windows from showing and updating themselves before they even have usable data, or from updating multiple times on login due to repeated update handled events  
    * Finished updating the list window.  
    * Fixed a bug where the data list would only update its content if shown.  
    * Removed unused logic now that nothing uses CustomWindowParam or CustomWindowOnInit.  
    * Apparently there was a thing that referenced GetCustomWindowParam.  
    * Updated the AnalyzerCheckSymlinks to use a window.  
    * Commented out the args/params debugger. Any chat function passed to Prime should prevent prime's toggle from triggering.  
    * [Logic] Fixed a DLO issue where the changed row rendering sequence exposed a situation where override functions would be returned in place of object values when accessing the DLO prior to being loaded  
    * [Logic] Revised DLO logic slightly more to be consistent with expectation and use proper default for 'visible' prior to object load  
    * [Logic] Added a table method to stringify a table (not currently used)  
    * [Logic] Couple 'list' updates to get it closer to prior function in Retail [something still broken though when building from cache, WIP]  
    * [Logic] Don't auto-open 'list'  
    * Fixed a bug with DataHandling's MergeObjects function where it wasn't creating a hash for an object that was missing a hash property.  
    * Fixed a bug with CloneInstanceObject caused by AutoHeader using the same primary key as Header.  
    * [Logic] Use GetHash for fallback on hash in MergeObjects so we can track down who is being bad and fix them  
    * [Logic] list: Added a safety catch for trying to make a sourceID list with Debugging active (this currently lags out the Transmog SourceID lookup API whereas previously it did not)  
    * List shouldn't use flightPathID. The engine uses flightpathID  
    * [Logic] Don't re-open list automatically  
    [Logic] Fix a couple other IDs for list prefixes (should use Search lib mapper hmmm)  
    * [Logic] list now uses the Search KeyMaps to have parity with chat commands  
    * [Logic] DLOs only create a default table if actually needed  
    * [Logic] Fixed \_\_CreateObject potentially returning bad data objects  
    * [Logic] Fixed persistent progress/total when changing types  
    * Updated the Debugger window. (This is one that I would consider moving to a different addon entirely)  
    * Fixed Debugger's Merchant data for Retail.  
    * Removed the old window creation style and converted (without changes) the Import window to utilize the new Window logic.  
    * [Logic] Wrap KeyMaps in a function call to properly clean the input  
    * [Logic] Split into GetSearchKeyField and GetKeyField (modItemID vs itemID)  
    [Logic] Debugger - Use a direct LoadMerchant method instead of fresh one every time with C\_Timer  
    [Logic] Debugger - Couple locals, using GetKeyField & intentional print while capturing debugger loots  
    * [Logic] More Debugger adjustments  
    * Ignore visible filter when updating & remove ApplyForcedVisibility  
    * Cleaning now actually removes the desired set of cleaning fields (\_\_merge and hash just doesn't cut it)  
    * Adjusted assignment of saved variable table  
    * Debugger data is now backed up out of combat and 15 seconds after data has been updated to prevent situations where it's saved for every piece of loot from a single mob or during combat  
    * Debugger now has a 1 second delayed update for situations where tons of objects are added all at once (due to many loot or group loots all spamming chat)  
    * [Logic] Added SetWindowSettingsToProfile to ensure existing Profile Window points are synced  
    [Logic] If defined, window OnRecordSettings will now be called when a window stores its settings (OnSave is only on player logout currently)  
    * Classic: Fixed a reference to AuctionHouseFrame.  
    * Now using the Mounts Lib in Wrath+ Content.  
    Classic Era: Fixed the Mounts achievement detection.  
    * Classic Era: Added back the "Related Things" section for achievement popouts. (NOTE: Only applicable to calculated achievements, not post-Wrath achievements!)  
    * Classic: Disabled Total Mount counter debug message.  
    * [Logic] Using list for sourceID behaves normally now  
    [Logic] Added some quicker checks for used mod/bonus when attempting to determine item links for sourceID groups  
    * [Logic] Adjust colorize for text  
    ---------  
    Co-authored-by: Crieve <dylanfortune@live.com>  
- Classic: Fixed non-Grand Commendations being incorrectly marked as FactionBonus class instances.  
- Generate Missing Files  
- Reparse  
- castle\_nathria: correctly mark fated tokens from last 2 bosses as removed (#2280)  
    * castle\_nathria: moar modID constants; differentiate last2 modIDs and regular modIDs  
    * castle\_nathria: incorrect consts on generals  
- Midnight Alchemy  
- Sort Recipes  
- Harvest: 12.0.1.65701  
- Harvest: 12.0.1.65617  
- Harvest: 12.0.1.65448  
- Harvest: 12.0.0.65699  
- Harvest: 12.0.0.65655  
- Harvest: 12.0.0.65614  
- Harvest: 12.0.0.65560  
- Harvest: 12.0.0.65535  
- Harvest: 12.0.0.65512  
- Harvest: 12.0.0.65459  
- Harvest: 5.5.3.65703  
- Harvest: 3.80.0.65586  
- Harvest: 2.5.5.65534  
- Harvest: 2.5.5.65463  
- Teleports are now collectible in midnight  
- mmmmooount  
- more cn promo stuff  
- Harandar Map  
- Added Remaining Midnight Dungeons  
- darkmoon\_faire: add notes on crow pet; add coords to darkmoon glowfly (#2279)  
- Beta: a bits of outdoor (and backlog delve)  
- Midnight: Silvermoon Court Quartermaster  
    - Silvermoon Court Faction vendors  
- Fix some reported errors, add shop bundle, souurce Legion meta ach  
- Keep finding removed achievements.  
- These 2 achievements are still obtainable during anniversary.  
- Two more achievements are no longer obtainable.  
- Fixed "seasonal" achievements which are never removed.  
- Fixed quantity display in tooltips when cost is 1  
- Fix a few reported errors  
- Q'T Silvermoon City: Enchanter Erodin <Heirloom Vendor>  
    - Old Heirlooms are back!  
- Contrib errors  
- Midnight Intro: Re-Re-Visited  
    - Some quest rewards got changed, some got switched to other quest(s), new sub-zones were added  
    - Added (I think most of the) Delve Achievements  
    - Added a couple of vendors  
    - Beta Parse  
