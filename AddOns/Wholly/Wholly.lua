--
--	Wholly
--	Written by scott@mithrandir.com
--
--	This was inspired by my need to replace EveryQuest with something that was more accurate.  The pins
--	was totally inspired by QuestHubber which I found when looking for a replacement for EveryQuest.  I
--	initially made a port of QuestHubber to QuestHubberGrail to make use of the Grail database, but now
--	I have integrated that work into this addon.  Many thanks for all the work put into QuestHubber.  I
--	was inspired to add a quest breadcrumb area from seeing one in Quest Completist.
--
--	Version History
--		001	Initial version.
--		002	Support for displaysDungeonQuests now works properly.
--			Added the ability for the panel tooltip to display questgivers.
--			Added the ability to click a quest in the panel to create a TomTom waypoint.
--			Map pins are only displayed for the proper dungeon level of the map.
--		003	Added a panel button to switch to the current zone.
--			Changed the Close button into a Sort button that switches between three different modes:
--				1. Alphabetical  2. Quest level, then alphabetical  3. Quest status, then alphabetical
--			Made map pins only have one pin per NPC, indicating the "best" color possible.
--			The entire zone dropdown button on the quest log panel now can be clicked to change zones.
--			Corrected a problem where someone running without LibStub would get a LUA error.
--			Corrected a localization issue.
--		004	Added the ability to display a basic quest prerequisite chain in the quest panel tooltip, requiring Grail 014 or later.
--			Added the ability to right-click a "prerequisite" quest in the panel to put a TomTom arrow to the first prerequisite quest.
--			Added Dungeons and Other menu items for map areas in the quest log panel.
--			The last-used sort preference is stored on a per-character basis.
--		005	Corrected the fix introduced in version 003 putting the LibDataBroker icon back in place.
--			Corrected a problem where the quest log tooltip would have an error if the questgiver was in a dungeon appearing in the zone.
--			Added the ability for the quest log tooltip to show that the questgiver should be killed (like the map pin tooltip).
--			The problem where map pins would not live update unless the quest log panel was opened has been fixed as long
--				as the Wholly check button appears on the map.
--			Added the ability to show quest breadcrumb information when the Quest Frame opens, showing a tooltip of breadcrumb
--				quests when the mouse enters the "breadcrumb area", and putting TomTom waypoints when clicking in it.
--		006	Added the new quest group "World Events" which has holiday quests in it, requiring Grail 015.
--			Added a tooltip to the Wholly check button on the map that indicates how many quests of each type are in the map.
--			Added a tooltip to the LibDataBroker icon that shows the quest log panel "map" selection and the quest count/type.
--			Added a tooltip to the quest log panel Zone button that shows the quest count/type.
--			Corrected the problem where the quest log panel and map pins were not live updating when quest givers inside dungeons checked.
--			Corrected the problem where an NPC that drops items that starts more than one quest does not display the information properly
--				in its tooltip.
--			Made it so the open World Map can be updated when crossing into a new zone.
--		007	Added the ability to show whether quests in the quest log are completed or failed.
--			Made it so right-clicking an "in log" quest will put in TomTom waypoints for the turn in locations, which requires Grail 016
--				for proper functioning since Grail 015 had a bug.
--			Made the strings for the preferences color quest information like it appears in the UI.
--			Made it so alt-clicking a log in the Wholly quest log selects the NPC that gives the quest or for the case of "in log" quests
--				the one to which the quest is turned in.
--		008	Split out Dungeons into dungeons in different continents, requiring Grail version 017.
--			Corrected a misspelling of the global game tooltip name.
--		009	Added localization for ptBR in anticipation of the Brazilian release.
--			Changed over to using Blizzard-defined strings for as many things as possible.
--			Corrected a problem that was causing the tooltip for creatures that needed to be killed to start a quest not to appear properly.
--			Added a few basic localizations.
--			Made the breadcrumb frame hide by default to attempt to eliminate an edge case.
--			Fixed a problem where button clicking behavior would never be set if the button was first entered while in combat.
--			Made prerequisite information appear as question marks instead of causing a LUA error in case the Grail data is lacking.
--		010	Made it so the color of the breadcrumb quest names match their current status.
--			The click areas to the right and bottom of the quest log window no longer extend past the window.
--			Added menu options for Class quests, Profession quests, Reputation quests, and Daily quests.  The Class and Profession quests will show all the quests in the system except for the class and professions that match the player.  For those, the quests are displayed using the normal filtering rules.  The Reputation quests follow the normal filtering rules except those that fail to be acceptable solely because of reputation will be displayed instead of following the display unobtainable filter.
--			Changed over to using Grail's StatusCode() vice Status(), and making use of more modern bit values, thereby requiring version 20.
--			Removed a few event types that are handled because Grail now does that.  Instead switched to using Grail's new Status notification.
--			The tooltips for quests in the panel show profession and reputation requirements as appropriate.
--			Corrected a problem where the quest panel may not update properly while in combat.
--		011	Made it so the breadcrumb warning will disappear properly when the user dismisses the quest frame.
--			Made it so Grail's support for Monks does not cause headaches when Monks are not available in the game.
--			Made it so Classes that do not have any class quests will not show up in the list.
--			Put in a feature to limit quests shown to those that count towards Loremaster, thereby requiring Grail version 21.
--			When the quest details appear the quest ID is shown in the top right, and it has a tooltip with useful quest information.
--			Changed the behavior of right-clicking a quest in the quest panel to put arrows to the turn in locations for all but prerequisite quests.
--			The tooltip information describing the quest shows failure reasons by changing to red categories that fail, and to orange categories that fail in prerequisite quests.
--			The quest tooltip information now indicates the first quest(s) in the prerequisite quest list as appropriate.
--			The preference to control displaying prerequisite quests in the tooltip has been removed.
--		012	Added the ability for the tooltip to display faction reputation changes that happen when a quest is turned in.
--			Grouped the Dungeons menu items under a single Dungeons menu item.
--			Added menu items for Reputation Changes quests, grouped by reputation.
--			Added menu items for Achievement quests, grouped by continent, requiring Grail 22.
--			Updated the TOC to support Interface 40300.
--			Fixed the map pin icons whose height Blizzard changed with the 4.3 release.
--		013	Fixes a problem where map pins would not appear and the quest ID would not appear in the Blizzard Quest Frame because the events were not set up properly because sometimes Blizzard sends events in a different order than expected.
--			Makes all the Wholly quest panel update calls ensure they are performed out of combat.
--			Updates Portuguese translation thanks to weslleih and htgome.
--			Fixes a problem where quests in the Blizzard log sometimes would not appear purple in the Wholly Quest Log.
--			Fixes a problem where holidays are not detected properly because of timing issues.
--		014	Fixes the problem where the NPC tooltip did not show the exclamation point properly (instead showing a different icon) when the NPC can start a quest.
--			Adds a search ability that allows searching for quests based on their titles.
--			Adds the ability to display player coordinates into a LibDataBroker feed.
--			Updates some localizations.
--			Fixes the problem where the panel would no longer update after a UI reload, requiring Grail 26.
--			Adds some more achievements to the menu that are world event related.
--			Makes it so quests in the Blizzard quest log will be colored purple in preference to other colors (like brown in case the player would no longer qualify getting the quest).
--			Makes it so the indicator for a completed repeatable quest will appear even if the quest is not colored blue.
--		015	Adds the filtered and total quest counts to the tooltip that tells the counts of the types of quests.  For the world map button tooltip the filtered quest count displays in red if the quest markers on the map are hidden.
--			Corrects a problem where lacking LibDataBroker would cause a LUA error associated with the player coordinates.
--			Fixes a cosmetic issue with the icon in the top left of the Wholly quest log panel to show the surrounding edge properly.
--			Changes the world map check box into a button that performs the same function.
--			Changes the classification of "weekly", "monthly" and "yearly" quests so they no longer appear as resettable quests, but as normal ones.
--			Adds a tooltip for the coordinates that shows the map area ID and name.
--		016	*** Requires Grail 28 or later ***
--			Adds the ability to color the achievement menu items based on whether they are complete.
--			Corrects the problem where the tooltip does not show the different names of the NPCs that can drop an item to start a quest.
--			Corrects the problem where alt-clicking a quest would not select the NPC properly if the NPC drops an item to start a quest.
--			Tracks multiple waypoints that are logically added as a group so when one is removed all of them are removed.
--			Updates some Portuguese localizations.
--			Adds the ability to show bugged information about a quest.
--			Adds a preference to consider bugged quests unobtainable.
--			Makes it select the closest waypoint when more than one is added at the same time.
--		017 *** Requires Grail 29 or later ***
--			Updates the preferences to allow more precise control of displayed quest types.
--			Creates the ability to control whether achievement and reputation change information is used.
--			Adds some Russian localization by freega3 but abused by me.
--          Adds basic structural support for the Italian localization.
--			Changes the presentation of prerequisite quest information to have all types unified in one location.
--		018	Adds some missing Italian UI keys.
--			Removes UI keys no longer used.
--			Fixes the icon that appears in the tooltip when an NPC drops an item that starts a quest.
--			Adds the ability to display item quest prerequisites.
--			Changes the priority of quest classification to ensure truly repeatable quests are never green.
--			Adds support for Cooking and Fishing achievements, present in Grail 31.
--			Adds support to display LightHeaded data by shift-left-click a quest in the Wholly quest panel.
--			Adds the ability to display abandoned and accepted quest prerequisites.
--		019	Adds German localization provided by polzi and aryl2mithril.
--			Adds French localization provided by deadse and Noeudtribal.
--			Corrects the problem where the preference to control holiday quests always was not working properly, requiring Grail 32.
--			Updates Russian localization provided by dartraiden.
--			Adds support for Just Another Day in Tol Barad achievements when Grail provides that data (starting in Grail 32).
--			Adds the ability to display all quests from the search menu.
--			Updates Portuguese localization provided by andrewalves.
--			Corrects a rare problem interacting with LDB.
--			Adds the ability to display quest prerequisites filtering through flag quests when Grail provides the functionality.
--		020	*** Requires Grail 33 or later ***
--			Corrects the problem where quests in the log that are no longer obtainable do not appear properly.
--			Adds the ability to show daily quests that are too high for the character as orange.
--			Adds Spanish localization provided by Trisquite.
--			Moves the Daily quests into the Other category.
--			Adds the experimental option to have a wide quest panel.
--		021 *** Requires Grail 34 or later ***
--			Makes it so Mists of Pandaria reputations can be handled.
--			Makes it so starter Pandarens no longer cause LUA errors.
--			Corrects the problem where removing all TomTom waypoints was not clearing them from Wholly's memory.
--			Corrects locations for Wholly informational frames placed on QuestFrame in MoP beta.
--			Updates the tooltip to better indicate when breadcrumb quests are problems for unobtainable quests.
--			Adds the ability to display profession prerequisites (in the prerequisites section vice its own for the few that need it).
--		022	*** Requires Grail 36 or later ***
--			Corrects the problem where NPC tooltips may not be updated until the world map is shown.
--			Changes how map pins are created so no work is done unless the WorldMapFrame is being shown.
--			Adds the ability to show that quests are Scenario or Legendary.
--			Changes the artwork on the right side of the wide panel.
--			Fixes the problem where the search panel was not attaching itself to the Wholly quest panel.
--			Updates some Korean localization provided by next96.
--			Makes it so Legendary quests appear orange while daily quests that are too high level appear dark blue.
--			Adds two new sort techniques, and also a tooltip for the sort button that describes the active sort technique.
--			Adds the ability to show an abbreviated quest count for each map area in the second scroll area of the wide quest panel, with optional live updates.
--			Fixes the problem where the Wholly world map button can appear above other frames.
--			Makes changing the selection in the first scroll view in the wide version of the Wholly quest panel, remove the selection in the second scroll view, thereby allowing the zone button to properly switch to the current zone.
--			Adds a Wholly quest tooltip for each of the quests in the Blizzard quest log.
--			Updates searching in the wide frame to select the newly sought term.
--		023	Updates some Korean localization provided by next96.
--			Updates some German localization provided by DirtyHarryGermany.
--			Updates from French localization provided by akirra83.
--			Adds support to indicate account-wide quests, starting with Grail 037 use.
--		024 *** Requires Grail 38 or later ***
--			Updates some Russian localization provided by dartraiden.
--			Adds support for quests that require skills as prerequisites, requiring Grail 038.
--			Updates some Italian localization provided by meygan.
--		025	*** Requires Grail 39 or later ***
--			Adds support to display quest required friendship levels.
--			Fixes the problem where NPC tooltips would not be updated (from changed addon data) upon reloading the UI.
--			Adds support to display prerequisites using Grail's newly added capabilities for OR within AND.
--			Adds support for quests that require lack of spells or spells ever being cast as prerequisites.
--			Adds a filter for Scenario quests.
--			Delays the creation of the dropdown menu until it is absolutely needed to attempt to minimize the taint in Blizzard's code.
--			Fixes an issue where considering bugged quests unobtainable would not filter as unobtainable properly.
--		026	*** Requires Grail 40 or later ***
--			Adds support for displaying special reputation requirements currently only used in Tillers quests.
--		027	*** Requires Grail 41 or later ***
--			Adds the ability to display requirements for spells that have ever been experienced.
--			Adds the ability to specify amounts above the minimum reputation level as provided in Grail 041 and later.
--			Updates some Traditional Chinese localization provided by machihchung and BNSSNB.
--			Adds the ability to display requirements from groups of quests, both turning in and accepting the quests.
--			Changes spell prerequisite failures to color red vice yellow.
--			Changes preference "Display holiday quests always" to become a "World Events" filter instead, making World Events always shown in their categories.
--			Changes world events titles to be brown (unobtainable) if they are not being celebrated currently.
--			Adds the ability to Ctrl-click any quest in the Wholly quest panel to add waypoints for EVERY quest in the panel.
--			Corrects the incorrect rendering of the wide panel that can happen on some systems.
--			Adds keybindings for toggling display of map pins and quests that need prerequsites, daily quests, repeatable quests, completed, and unobtainable quests.
--			Adds the ability to display maximum reputation requirements that are quest prerequisites.
--			Changes the maximum line count for the tooltip before the second is created, to be able to be overridden by WhollyDatabase.maximumTooltipLines value if it exists.
--			Adds the ability to Ctrl-Shift-click any quest in the Wholly quest panel to toggle whether the quest is ignored.
--			Adds the ability to filter quests that are marked ignored.
--		028	Switches to using Blizzard's IGNORED string instead of maintaining a localized version.
--			Adds basic support for putting pins on the Omega Map addon.
--			Changes the display of the requirement for a quest to ever have been completed to be green if true, and not the actual status of the quest.
--			Updates the TOC to support interface 50100.
--			Replaces the calls to Grail:IsQuestInQuestLog() with the status bit mask use since (1) we know whether the quest is in the log from its status, and (2) the call was causing Grail to use a lot of memory.
--		029	Adds support for Grail's T code prerequisites.
--			Adds Simplified Chinese localization provided by Sunteya.
--		030	Changes to use some newly added API Grail provides, *** requiring Grail 45 or later ***.
--			Updates some Spanish localization provided by Davidinmoral.
--			Updates some French localization provided by Noeudtribal.
--			Reputation values that are not to be exceeded now have "< " placed in front of the value name.
--			Allows the key binding for toggling open/close the Wholly panel to work in combat, though this function will need to be rebound once.
--			Fixes a map pin problem with the addon Mapster Enhanced.
--			Changes the faction prerequisites to color green, red or brown depending on whether the prerequisite is met, can be met with increase in reputation or is not obtainable because reputation is too high.
--			Adds support for Grail's new "Other" map area where oddball quests are located.
--			Adds support for Grail's new NPC location flags of created and mailbox.
--			Updates some Portuguese localization provided by marciobruno.
--			Adds Pet Battle achievements newly provided by Grail.
--		031	Updates some German localization provided by bigx2.
--			Updates some Russian localization provided by dartraiden.
--			Adds ability to display F code prerequisite information.
--		032 Fixes a problem where the Achievements were not working properly unless the UI was reloaded.
--			Adds the ability to display NPCs with prerequisites, *** requiring Grail 47 or later ***.
--			Makes the X code prerequisite display with ![Turned in].
--			Adds the ability to display phase prerequisite information.
--			Adds some Spanish translations based on input by Davidinmoral.
--		033	Adds a hidden default shouldNotRestoreDirectionalArrows that can be present in the WhollyDatabase saved variables to not reinstate directional arrows upon reloading.
--			Adds the ability to show when a quest is obsolete (removed) or pending.
--			Adds support for displaying Q prerequisites and for displaying pet "spells".
--			Changes the technique used to display reputation changes in the tooltip, *** requiring Grail 048 or later ***.
--			Adds support for Grail's new representation of prerequisite information.
--		034 Changes the tooltip code to allow for better displaying of longer entries.
--			Adds some Korean localization provided by next96.
--			Changes the Interface to 50300 to support the 5.3.0 Blizzard release.
--			Adds the ability to control the Grail-When loadable addon to record when quests are turned in.
--			Adds the ability to display when quests are turned in, and if the quest can be done more than once, the count of how many times done.
--			Updates support for Grail's new representation of prerequisite information.
--		035	Updates Chinese localizations by Isjyzjl.
--			Adds the ability to show equipped iLvl prerequisites.
--			Corrects the display problem with OR within AND prerequisites introduced in version 034.
--			Makes opening the preferences work even if Wholly causes the preferences to be opened the first time in a session.
--		036	Updates Russian localizations by dartraiden.
--			Removes the prerequisite population code in favor of API provided by Grail, requiring Grail 054 or later.
--		037	Fixes the problem where tooltips do not appear in non-English clients properly.
--		038	Fixes the problem where tooltips that show the currently equipped iLevel cause a Lua error.
--			Adds a preference to control whether tooltips appear in the Blizzard Quest Log.
--			Corrects the problem introdced by Blizzard in their 5.4.0 release when they decided to call API (IsForbidden()) before checking whether it exists.
--			Makes the attached Lightheaded frame work better with the wide panel mode.
--			Corrects a problem where a variable was leaking into the global namespace causing a prerequisite evaluation failure.
--			Attempts to make processing a little quicker by making local references to many Blizzard functions.
--		039	Fixes the problem where tooltips for map pins were not appearing correctly.
--			Fixes a Lua error with the non-wide Wholly quest panel's drop down menu.
--			Fixes a Lua error when Wholly is used for the first time (or has no saved variables file).
--			Adds a preference to control display of weekly quests.
--			Adds a color for weekly quests.
--			Enables quest colors to be stored in player preferences so users can changed them, albeit manually.
--			Fixes the problem where the keybindings or buttons not on the preference panel would not work the first time without the preference panel being opened.
--		040	Updates Russian localizations by dartraiden.
--			Adds a workaround to supress the panel that appears because of Blizzard's IsDisabledByParentalControls taint issue.
--			Updates Simplified Chinese localizations by dh0000.
--		041	Adds the capability to set the colors for each of the quest types.
--			Changes to use newer way Grail does things.
--		042	Updates Russian localizations by dartraiden.
--			Corrects the search function to use the new Grail quest structures.
--			Makes it so quests that are pending or obsolete do not appear when the option indicates unobtainable quests should not appear.
--			Changed display of profession requirements to only show failure as quest prerequisites now show profession requirements consistently.
--		043	Handles Grail's change in AZ quests to handle pre- and post-063 implementation.
--			Adds the ability to mark quests with arbitrary tags.
--		044 Corrects the Lua error that happens when attempting to tag a quest when no tag exists.
--			Fixes the map icons to look cleaner by Shenj.
--			Updates Russian localizations by vitasikxp.
--		045 Updates various localizations by Nimhfree.
--			Updates to support changes in WoD that Grail supports.  *** Requires Grail 065 or later. ***
--			Adds hidden WhollyDatabase preference ignoreReputationQuests that controls whether the Reputations section of quests appears in the Wholly panel.
--			Adds hidden WhollyDatabase preference displaysEmptyZones that controls whether map zones where no quests start are displayed.
--			Changes the Interface to 60000.
--		046	Regenerates installation package.
--		047	Updates Traditional Chinese localizations by machihchung.
--			Updates Portuguese localizations by DMoRiaM.
--			Updates French localizations by Dabeuliou;
--			Changes level for pins to display over Blizzard POIs.
--			Changes level for pins so yellow/grey pins display over other colors.
--			Changes default behavior to only show in tooltips faction changes available to the player, with hidden WhollyDatabase preference showsAllFactionReputations to override.
--		048	Fixes a problem where Wholly does not load properly when TomTom is not present.
--		049	Adds the ability to display quests that reward followers.
--			Updates some Korean localization provided by next96.
--			Updates some German localization provided by DirtyHarryGermany.
--		050	Adds support for garrison building requirements.
--			Updates Russian localization provided by dartraiden.
--			Updates German localization provided by DirtyHarryGermany.
--			Updates both Chinese localizations provided by FreedomL10n.
--		051	Adds support to control display of bonus objective, rare mob and treasure quests.
--			Adds Wholly tooltip to the QuestLogPopupDetailFrame.
--			Updates French localization provided by aktaurus.
--			Breaks out the preferences into multiple pages, making the hidden preferences no longer hidden.
--			Adds ability to control the display of legendary quests.
--			Updates Russian localization provided by dartraiden.
--			Changes the Interface to 60200.
--		052	Adds support to display new group prerequisite information.
--			Corrects the issue where NPC tooltips were not showing drops that start quests.
--			Updates Spanish (Latin America) localization by Moixe.
--			Updates German localization by Mistrahw.
--			Updates Korean localization by mrgyver.
--			Updates Spanish (Spain) localization by Ertziano.
--			Corrects the problem where the drop down button in the Wholly window does not update the follower name properly.
--			Adds the ability to display quest rewards.
--			Splits up zone drop downs that are too large.
--		053	Adds the ability to filter pet battle quests.
--			Adds the ability to display a quest as a bonus objective, rare mob, treasure or pet battle.
--			Adds the ability to have the quest filter work for NPC tooltips.
--			Updates German localization by Rikade.
--			Updates prerequisite displays to match new Grail features.
--		054	Adds support for Adventure Guide
--			Updates German localization by potsrabe.
--		055	Updates Traditional Chinese localization by gaspy10.
--			Updates Spanish (Spain) localization by ISBILIANS.
--			Corrects the problem where the map location is lost on UI reload.
--		056	Updates German localization by pas06.
--			Adds the ability to filter quests based on PVP.
--			Adds the ability to support Grail's ability to indicate working buildings.
--		057	Changes the ability to display quest rewards without the need for Grail to have the information.
--			Updates Traditional Chinese localization by gaspy10.
--			Adds the ability to display prerequisites for classes.
--			Updates Spanish (Spain) localization by Ehren_H.
--			Changes the Interface to 70000.
--		058	Adds the ability to control the display of some Blizzard world map icons.
--			Fixes the placement of the Wholly world map button so it appears when the world map is opened.
--			Fixes presenting a window when attempting to load an on-demand addon fails.
--		059	Fixes the problem where hiding Blizzard map POIs in combat causes Lua errors.
--			Adds the ability to control the display of Blizzard story line quest markers.
--			Updates French translation by coldragon78.
--			Updates Traditional Chinese localization by gaspy10.
--		060 Adds the ability to control the display of World Quests, including a key binding.
--			Adds a Legion Repuation Changes section.
--			Fixes the problem where the coordinates would cause issues in instances.
--		061	Adds ability to show "available" prerequisite used for world quests.
--			Updates German localization by Broesel01.
--			Updates Korean localization by netaras.
--		062 Updates Spanish (Spain) localization by annthizze.
--			Adds support for Grail's ability to detect withering in NPCs and therefore quest requirements.
--			Updates Brazilian Portuguese localization.
--			Updates French localization.
--			Updates Korean localization.
--			Updates Spanish (Latin America) localization.
--			Adds support for world quests to have their own pin color.
--		063	Updates the Interface to 70200.
--			Adds support for artifact level prerequisites.
--			Updates Spanish (Latin America) localization.
--			Updates French localization by sk8cravis.
--			Updates German localization by RobbyOGK.
--		064	Updates the Interface to 70300.
--			Updates the use of PlaySound based on Blizzard's changes based on Gello's post.
--		065	Corrects a timing problem where the notification frame might be sent events before initialized properly.
--			Adds a binding to toggle Loremaster quests.
--			Updates technique to hide flight points on Blizzard map.
--			Adds ability to hide dungeon entrances on Blizzard map.
--			Updates Russian localization from iGreenGO and EragonJKee.
--			Updates German localization from Adrinator and Haipia.
--		066	*** Requires Grail 93 or later ***
--			Adds the ability to display prerequisites for Class Hall Missions.
--			Adds support for Allied races.
--			Updates Russian localization from mihaha_xienor.
--			Updates Spanish localization from raquetty.
--		067	*** Requires Grail 096 or later ***
--			Corrects the problem where some dungeons are not listed.
--			Updates French localization by deathart709 and MongooZz.
--			Updates Russian localization by RChernenko.
--			Updates Spanish localization by neinhalt_77.
--			Made it so we can handle Blizzard removing GetCurrentMapDungeonLevel() and GetCurrentMapAreaID().
--			Updates Italian localization by luigidirico96.
--			Groups the continents together under a heading.
--			Changes to use for WORLD_QUEST Blizzard's TRACKER_HEADER_WORLD_QUESTS.
--			Disables ability to hide Blizzard map items because Blizzard API has changed.
--			Updates Simplified Chinese localization by dh0000 and Aladdinn.
--		068	Corrects the issue where the map was caused to change unexpectedly.
--			Corrects the problem where TomTom arrows were not being added properly with the new TomTom.
--			Updates Latin American Spanish localization by danvar33.
--		069	Updates Russian localization by dartraiden.
--			Removes quest level for those quests that have no real level, and changes the display to show variable level maximums as appropriate.
--			Updates a bunch of localizations from users who provided input on: https://wow.curseforge.com/projects/wholly/localization
--		070	Updates Interface in TOC to 80100.
--			Allows map button to work with Titan Location.
--			Adds a little defensive code to avoid a Lua error.
--		071	Updates Interface in TOC to 80200.
--			Adds a little defensive code to avoid a Lua error.
--			Makes it so achievements are not loaded in Classic.
--			Makes it so some of the UI elements are not used in Classic.
--			Adds the ability to show a message in the chat indicating a breadcrumb is available.
--			Corrects issue where map pins could be the wrong type.
--		072	Fixes a problem where the open world map in Classic errors when changing zones.
--			Fixes the problem where the Wholly map button was not appearing and working properly in Classic.
--			Fixes the problem where exclusive classes in Classic were failing because of Retail classes.
--			Adds the ability to have the Wholly information appear in a tooltip when hovering over a quest in the Blizzard quest panel.
--			Adds the ability to have the Wholly tooltip contain the quest title and description in Classic, with the description in white.
--		073	Makes it so lack of NPC name for item drops no longer causes a Lua error.
--			Makes it so NPCs are colored red if they are not available to the player.
--			Adds the ability to display the NPC comments in the Wholly quest tooltip.
--		074	Makes it so the Wholly map button does not move when TomTom is installed.
--			Makes it so the Wholly map button moves when Questie is also loaded.
--			Makes the Wholly quest panel appear much nicer in Classic.
--		075 *** Requires Grail 104 or later ***
--			Fixes a problem where the search edit box was not created properly.
--			Shows quests that are turned in to a zone in the Wholly quest panel.
--			Adds the ability to show map pins for quest turn in locations.
--		076	Updates the Classic Wholly quest panel to have a right side.
--			Changes the colors for turn in pins to be white and yellow to match the NPCs in the world.
--			Updates preferences to allow control over displaying turn in map pins that are complete or incomplete.
--			Corrects issue where map button does not appear upon first login for new character.
--		077	Adjusts the position of the breadcrumb frame to look better in Classic.
--			Adds support for Heart of Azeroth level requirements.
--		078 *** Requires Grail 109 or later ***
--			Updates the Classic interface to 11304 to match the latest Blizzard release.
--			Updates getting NPC locations to newer API use in Grail.
--		079	*** Requires Grail 110 or later ***
--			Changes made to handle Grail's delayed loading of NPC names.
--		080	*** Requires Grail 111 or later ***
--			Changes to start supporting Shadowlands.
--			Changes interface to 90001.
--		081 *** Requires Grail 112 or later ***
--			Changes the reputation section to allow for future expansions without code change.
--			Adds the ability to use Blizzard's user waypoint.
--			Changes interface to 90002.
--		082	*** Requires Grail 114 or later ***
--			Adds the ability to display covenant renown level prerequisites (minimum and maximum).
--			Adds the ability to display calling quests availability prerequisites.
--			Adds the ability to display quest types for biweekly, threat and calling quests.
--			Adds the ability to display covenant talent prerequisites.
--			Adds the ability to display custom achivements Grail supports.
--		083	Adds the ability to display the expansion associated with the quest.
--			Changes interface to 90005 (and 20501 for Classic Burning Crusade).
--		084 *** Requires Grail 116 or later ***
--			Switched to a unified addon for all of Blizzard's releases.
--			Enables displaying a requirement of a renown level independent of covenant.
--			Transforms the Wholly map button into one with just "W" and puts it at the top left of the map.
--			Reintroduces some ability to filter Blizzard map pins in Retail.
--			Changes retail interface to 90100.
--		085	Updates _OnUpdate to ensure coordinates are returned before updating locations.
--			Changes retail interface to 90105, BCC to 20502 and Classic to 11400.
--      086 Changes retail interface to 90205, BCC to 20504 and Classic to 11402.
--			Adds support for quests that only become available after the next daily reset.
--			Adds an option to hide the quest ID on the Quest Frame.
--			Adds support for quests that only become available when currency requirements are met.
--		087 *** Requires Grail 119 or later ***
--			Changes retail interface to 100002, Wrath to 30400 and Vanilla to 11403.
--		088	Corrects the problem where mouse clicks on the Wholly quest panel failed to act.
--			Corrects the problem where the location of the Wholly quest panel is not retained across restarts.
--			Adds support for quests that have major faction renown level prerequisites.
--			Adds support for quests that have POI presence prerequisites.
--			Adds support for items with specific counts as prerequisites.
--			Changes retail interface to 100005.
--			Adds support group membership completion counts being exact (to support Dragon Isles Waygate quests).
--		089 Changes Classic Wrath interface to 30401.
--		090 Changes retail interface to 100007.
--		091 Adds initial support for The War Within.
--			Switches TOC to have a single Interface that lists all supported versions.
--
--	Known Issues
--
--			The quest log quest colors are not updated live (when the panel is open).
--
--	UTF-8 file
--

local format, pairs, tContains, tinsert, tonumber = format, pairs, tContains, tinsert, tonumber
local ipairs, print, strlen, tremove, type = ipairs, print, strlen, tremove, type
local strsplit, strfind, strformat, strsub, strgmatch = strsplit, string.find, string.format, string.sub, string.gmatch
local bitband = bit.band
local tablesort = table.sort
local mathmax, mathmin, sqrt = math.max, math.min, math.sqrt

local CloseDropDownMenus					= CloseDropDownMenus
local CreateFrame							= CreateFrame
--local GetAchievementInfo					= GetAchievementInfo
local GetAddOnMetadata						= GetAddOnMetadata
local GetBuildInfo							= GetBuildInfo
local GetCoinTextureString					= GetCoinTextureString or C_CurrencyInfo.GetCoinTextureString
local GetCursorPosition						= GetCursorPosition
local GetCVarBool							= GetCVarBool
local GetLocale								= GetLocale
local GetQuestID							= GetQuestID
local GetRealZoneText						= GetRealZoneText
--local GetSpellInfo							= GetSpellInfo
local GetTitleText							= GetTitleText
local InCombatLockdown						= InCombatLockdown
--local InterfaceOptions_AddCategory			= InterfaceOptions_AddCategory
local InterfaceOptionsFrame_OpenToCategory	= InterfaceOptionsFrame_OpenToCategory
local IsControlKeyDown						= IsControlKeyDown
local IsShiftKeyDown						= IsShiftKeyDown
local LoadAddOn								= LoadAddOn
local PlaySound								= PlaySound
local ToggleDropDownMenu					= ToggleDropDownMenu
local UIDropDownMenu_AddButton				= UIDropDownMenu_AddButton
local UIDropDownMenu_CreateInfo				= UIDropDownMenu_CreateInfo
local UIDropDownMenu_GetText				= UIDropDownMenu_GetText
local UIDropDownMenu_Initialize				= UIDropDownMenu_Initialize
local UIDropDownMenu_JustifyText			= UIDropDownMenu_JustifyText
local UIDropDownMenu_SetText				= UIDropDownMenu_SetText
local UIDropDownMenu_SetWidth				= UIDropDownMenu_SetWidth
local UnitIsPlayer							= UnitIsPlayer

local GameTooltip = GameTooltip
local UIErrorsFrame = UIErrorsFrame
local UIParent = UIParent
local QuestFrame = QuestFrame
local WorldMapFrame = WorldMapFrame

local GRAIL = nil	-- will be set in PLAYER_LOGIN

local directoryName, _ = ...
local GetAddOnMetadata_API = GetAddOnMetadata or C_AddOns.GetAddOnMetadata
local versionFromToc = GetAddOnMetadata_API(directoryName, "Version")
local _, _, versionValueFromToc = strfind(versionFromToc, "(%d+)")
local Wholly_File_Version = tonumber(versionValueFromToc)
local requiredGrailVersion = 119

--	Set up the bindings to use the localized name Blizzard supplies.  Note that the Bindings.xml file cannot
--	just contain the TOGGLEQUESTLOG because then the entry for Wholly does not show up.  So, we use a version
--	named WHOLLY_TOGGLEQUESTLOG which maps to the same Global string, which works exactly as we want.
_G["BINDING_NAME_CLICK com_mithrandir_whollyFrameHiddenToggleButton:LeftButton"] = BINDING_NAME_TOGGLEQUESTLOG
--BINDING_NAME_WHOLLY_TOGGLEQUESTLOG = BINDING_NAME_TOGGLEQUESTLOG
BINDING_HEADER_WHOLLY = "Wholly"
BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Toggle map pins"
BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Toggle shows needs prerequisites"
BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Toggle shows dailies"
BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Toggle shows weeklies"
BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Toggle shows repeatables"
BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Toggle shows unobtainables"
BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Toggle shows completed"
BINDING_NAME_WHOLLY_TOGGLESHOWWORLDQUESTS = "Toggle shows World Quests"
BINDING_NAME_WHOLLY_TOGGLESHOWLOREMASTER = "Toggle shows Loremaster quests"
BINDING_NAME_WHOLLY_TOGGLESHOWMAPFLIGHTPOINTS = "Toggle shows Blizzard flight points"
BINDING_NAME_WHOLLY_TOGGLESHOWMAPCALLINGQUESTS = "Toggle shows Blizzard calling quests"
BINDING_NAME_WHOLLY_TOGGLESHOWMAPCAMPAIGNQUESTS = "Toggle shows Blizzard campaign quests"
BINDING_NAME_WHOLLY_TOGGLESHOWMAPWORLDQUESTS = "Toggle shows Blizzard world quests"

if nil == Wholly or Wholly.versionNumber < Wholly_File_Version then

	local function trim(s)
		local n = s:find"%S"
		return n and s:match(".*%S", n) or ""
	end

	WhollyDatabase = {}

	Wholly = {

		cachedMapCounts = {},
		cachedPanelQuests = {},		-- quests and their status for map area self.zoneInfo.panel.mapId
		cachedPinQuests = {},		-- quests and their status for map area self.zoneInfo.pins.mapId
		carboniteMapLoaded = false,
		carboniteNxMapOpen = nil,
		checkedGrailVersion = false,	-- used so the actual check can be simpler
		checkedNPCs = {},
		chooseClosestWaypoint = true,
		clearNPCTooltipData = function(self)
									self.checkedNPCs = {}
									self.npcs = {}
									self:_RecordTooltipNPCs(Grail.GetCurrentMapAreaID())
								end,
		color = {
			['?'] = "FFFFFF00",	-- yellow	[turn in]
			['*'] = "FFFFFFFF",	-- white	[turn in, not complete]
			['!'] = "FFFF0000",	-- red		[turn in, failed]
			['B'] = "FF996600",	-- brown	[unobtainable]
			['C'] = "FF00FF00",	-- green	[completed]
			['D'] = "FF0099CC",	-- daily	[repeatable]
			['G'] = "FFFFFF00",	-- yellow	[can accept]
			['H'] = "FF0000FF", -- blue		[daily + too high level]
			['I'] = "FFFF00FF",	-- purple	[in log]
			['K'] = "FF66CC66",	-- greenish	[weekly]
			['L'] = "FFFFFFFF",	-- white	[too high level]
			['O'] = "FFFFC0CB", -- pink		[world quest]
			['P'] = "FFFF0000",	-- red		[does not meet prerequisites]
			['R'] = "FF0099CC",	-- daily	[true repeatable - used for question mark in pins]
			['U'] = "FF00FFFF",	-- bogus default[unknown]
			['W'] = "FF666666",	-- grey		[low-level can accept]
			['Y'] = "FFCC6600", -- orange	[legendary]
			},
		colorWells = {},
		configurationScript1 = function(self)
									Wholly:ScrollFrame_Update_WithCombatCheck()
									Wholly.pinsNeedFiltering = true
									Wholly:_UpdatePins()
									Wholly:clearNPCTooltipData()
								end,
		configurationScript2 = function(self)
									Wholly:_UpdatePins()
									if Wholly.tooltip:IsVisible() and Wholly.tooltip:GetOwner() == Wholly.mapFrame then
										Wholly.tooltip:ClearLines()
										Wholly.tooltip:AddLine(Wholly.mapCountLine)
									end
								end,
		configurationScript3 = function(self)
									Wholly:_DisplayMapFrame(self:GetChecked())
								end,
		configurationScript4 = function(self)
									Wholly:UpdateQuestCaches(true)
									Wholly:ScrollFrame_Update_WithCombatCheck()
									Wholly:_UpdatePins(true)
								end,
		configurationScript5 = function(self)
									Wholly:UpdateBreadcrumb(Wholly)
								end,
		configurationScript7 = function(self)
									Wholly:ScrollFrame_Update_WithCombatCheck()
								end,
		configurationScript8 = function(self)
									Wholly:UpdateCoordinateSystem()
								end,
		configurationScript9 = function(self)
									if WhollyDatabase.loadAchievementData and Grail.capabilities.usesAchievements then
										Grail:LoadAddOn("Grail-Achievements")
									end
									Wholly:_InitializeLevelOneData()
								end,
		configurationScript10 = function(self)
									if WhollyDatabase.loadReputationData then
										Grail:LoadReputations()
									end
									Wholly:_InitializeLevelOneData()
								end,
		configurationScript11 = function(self)
									Wholly:ToggleCurrentFrame()
								end,
		configurationScript12 = function(self)
									Wholly:ScrollFrameTwo_Update()
								end,
		configurationScript13 = function(self)
								end,
		configurationScript14 = function(self)
									if WhollyDatabase.loadDateData then
										Grail:LoadAddOn("Grail-When")
									end
								end,
		configurationScript15 = function(self)
									if WhollyDatabase.loadRewardData then
										Grail:LoadAddOn("Grail-Rewards")
									end
								end,
		configurationScript16 = function(self)
--									WorldMapFrame_Update()
								end,
		ToggleWorldMapFrameMixin = function(provider, shouldHide)
			local mixins = Wholly.GetMapProvidersForMixin(WorldMapFrame, provider)
			if nil ~= mixins then
				Wholly.mixinsRefreshAllData = Wholly.mixinsRefreshAllData or {} 	-- key is the provider, value is its original implementation of RefreshAllData
				if nil == Wholly.mixinsRefreshAllData[provider] then
					Wholly.mixinsRefreshAllData[provider] = provider.RefreshAllData
				end
				for _, mixin in pairs(mixins) do
					if shouldHide then
						mixin.RefreshAllData = function(fromOnShow) end
						mixin:RemoveAllData()
					else
						mixin.RefreshAllData = Wholly.mixinsRefreshAllData[provider]
						mixin:RefreshAllData(false)
					end
				end
			end
		end,
		configurationScript17 = function(self)
									-- Flight points are handled by FlightPointDataProviderMixin
									-- Calling quests are handled by BonusObjectiveDataProviderMixin
									-- Campaign (storyline) quests are handled by StorylineQuestDataProviderMixin
									-- World quests are handled by WorldQuestDataProviderMixin
									-- there is Blizzard UI to remove quest objectives, and world quests (albeit by reward)
									-- DO NOT KNOW the following: InvasionDataProviderMixin
									-- TODO: See whether there are other items we can remove from the map - dungeon entrances, treasures, teleportation hubs
									-- DungeonEntranceDataProviderMixin DOES NOT seem to control dungeon entrances
								end,
		configurationScript18 = function(self)
									Wholly:_InitializeLevelOneData()
									Wholly:ScrollFrameOne_Update()
									Wholly:ScrollFrameTwo_Update()
									Wholly:ScrollFrame_Update_WithCombatCheck()
									Wholly.pinsNeedFiltering = true
									Wholly:_UpdatePins()
									Wholly:clearNPCTooltipData()
								end,
		configurationScript19 = function(self)
									Wholly.ToggleWorldMapFrameMixin(FlightPointDataProviderMixin, WhollyDatabase.hidesWorldMapFlightPoints)
								end,
		configurationScript20 = function(self)
									Wholly.ToggleWorldMapFrameMixin(BonusObjectiveDataProviderMixin, WhollyDatabase.hidesBlizzardWorldMapCallingQuests)
								end,
		configurationScript21 = function(self)
-- StorylineQuestDataProviderMixin disappeared
--									Wholly.ToggleWorldMapFrameMixin(StorylineQuestDataProviderMixin, WhollyDatabase.hidesBlizzardWorldMapCampaignQuests)
								end,
		configurationScript22 = function(self)
									Wholly.ToggleWorldMapFrameMixin(WorldQuestDataProviderMixin, WhollyDatabase.hidesBlizzardWorldMapWorldQuests)
								end,
		configurationScript23 = function(self)
--									Wholly.ToggleWorldMapFrameMixin(DungeonEntranceDataProviderMixin, WhollyDatabase.hidesDungeonEntrances)
--									Wholly.ToggleWorldMapFrameMixin(VignetteDataProviderMixin, WhollyDatabase.hidesWorldMapTreasures)
								end,
		configurationScript24 = function(self)
									if WhollyDatabase.hidesIDOnQuestPanel then
										com_mithrandir_whollyQuestInfoFrame:Hide()
									else
										com_mithrandir_whollyQuestInfoFrame:Show()
									end
								end,
		coordinates = nil,
		currentFrame = nil,
		currentMaximumTooltipLines = 50,
		currentTt = 0,
		debug = true,
		defaultMaximumTooltipLines = 50,
		dropdown = nil,
		dropdownLimit = 40,
		dropdownText = nil,
		dungeonTest = {},

		eventDispatch = {
			['PLAYER_REGEN_ENABLED'] = function(self, frame)
				if self.combatScrollUpdate then
					self.combatScrollUpdate = false
					self:ScrollFrame_Update()
				end
				if self.combatHidePOI then
					self.combatHidePOI = false
					self:_HidePOIs()
				end
				frame:UnregisterEvent("PLAYER_REGEN_ENABLED")
			end,
			--	So in Blizzard's infinite wisdom it turns out that normal quests that just appear with the
			--	quest giver post a QUEST_DETAIL event, unless they are quests like the Candy Bucket quests
			--	which post a QUEST_COMPLETE event (even though they really are not complete until they are
			--	accepted).  And if there are more than one quest then QUEST_GREETING is posted, which also
			--	is posted if one were to decline one of the selected ones to return to the multiple choice
			--	frame again.  Therefore, it seems three events are required to ensure the breadcrumb panel
			--	is properly removed.
			['QUEST_ACCEPTED'] = function(self, frame)
				self:BreadcrumbUpdate(frame)
			end,
			['QUEST_COMPLETE'] = function(self, frame)
				self:BreadcrumbUpdate(frame, true)
			end,
			['QUEST_DETAIL'] = function(self, frame)
				self:BreadcrumbUpdate(frame)
			end,
			['QUEST_GREETING'] = function(self, frame)
				com_mithrandir_whollyQuestInfoFrameText:SetText("")
				com_mithrandir_whollyQuestInfoBuggedFrameText:SetText("")
				com_mithrandir_whollyBreadcrumbFrame:Hide()
			end,
			['QUEST_LOG_UPDATE'] = function(self, frame)	-- this is just here to record the tooltip information after a reload
				frame:UnregisterEvent("QUEST_LOG_UPDATE")

				-- This used to be in ADDON_LOADED but has been moved here because it was reported in 5.2.0
				-- that the Achievements were not appearing properly, and this turned out to be caused by a
				-- change that Blizzard seems to have done to make it so GetAchievementInfo() no longer has
				-- a proper title in its return values at that point.
				if WhollyDatabase.loadAchievementData and Grail.capabilities.usesAchievements then
					self.configurationScript9()
				end

				self:_RecordTooltipNPCs(Grail.GetCurrentMapAreaID())
			end,
			['QUEST_PROGRESS'] = function(self, frame)
				self:BreadcrumbUpdate(frame, true)
			end,
			['PLAYER_LOGIN'] = function(self, frame, arg1)
--				if "Wholly" == arg1 then	-- this is a remnant from when this was ADDON_LOADED and not PLAYER_LOGIN
GRAIL = Grail
if not GRAIL or GRAIL.versionNumber < requiredGrailVersion then
local errorMessage = format(self.s.REQUIRES_FORMAT, requiredGrailVersion)
print(errorMessage)
UIErrorsFrame:AddMessage(errorMessage)
return
end
self.checkedGrailVersion = true

					self:_RegisterSlashCommand()

					self:_SetupWhollyQuestPanel()

					self:_SetupSearchFrame()

com_mithrandir_whollyFrameTitleText:SetText("Wholly ".. com_mithrandir_whollyFrameTitleText:GetText())
com_mithrandir_whollyFrameWideTitleText:SetText("Wholly ".. com_mithrandir_whollyFrameWideTitleText:GetText())

self.toggleButton = CreateFrame("Button", "com_mithrandir_whollyFrameHiddenToggleButton", com_mithrandir_whollyFrame, "SecureHandlerClickTemplate")
self.toggleButton:SetAttribute("_onclick", [=[
local parent = self:GetParent()
if parent:IsShown() then
parent:Hide()
else
parent:Show()
end
]=])

self.currentFrame = com_mithrandir_whollyFrame

-- The frame is not allowing button presses to things just on the outside of its bounds so we move the hit rect
--frame:SetHitRectInsets(0, 32, 0, 84)

					self:_SetupLibDataBroker()
					self:_SetupTooltip()
					self:_SetupWorldMapWhollyButton()


-- if the UI panel disappears (maximized WorldMapFrame) we need to change parents
UIParent:HookScript("OnHide", function()
self.tooltip:SetParent(WorldMapFrame);
self.tooltip:SetFrameStrata("TOOLTIP");
end)
UIParent:HookScript("OnShow", function()
self.tooltip:SetParent(UIParent);
self.tooltip:SetFrameStrata("TOOLTIP");
end)

-- Dragonflight introduces new tool tip processing
if TooltipDataProcessor then
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, Wholly._CheckNPCTooltip)
else
	GameTooltip:HookScript("OnTooltipSetUnit", Wholly._CheckNPCTooltip)
end

					self:_SetupBlizzardQuestLogSupport()
					self:_SetupQuestInfoFrame()

-- Our frame positions are wrong for MoP, so we change them here.
com_mithrandir_whollyQuestInfoBuggedFrame:SetPoint("TOPLEFT", QuestFrame, "TOPLEFT", 100, -35)
if Grail.existsClassic then
com_mithrandir_whollyBreadcrumbFrame:SetPoint("TOPLEFT", QuestFrame, "BOTTOMLEFT", 16, 70)
else
com_mithrandir_whollyBreadcrumbFrame:SetPoint("TOPLEFT", QuestFrame, "BOTTOMLEFT", 16, -10)
end

if "deDE" == GetLocale() then
com_mithrandir_whollyFramePreferencesButton:SetText("Einstellungen")
end
if "ruRU" == GetLocale() then
com_mithrandir_whollyFrameSortButton:SetText("Сортировать")
end

com_mithrandir_whollyFrameSwitchZoneButton:SetText(self.s.MAP)
com_mithrandir_whollyFrameWideSwitchZoneButton:SetText(self.s.MAP)

					local Grail = Grail
					local TomTom = TomTom

					local WDB = self:_SetupDefaults()

					-- load all the localized quest names
					Grail:LoadLocalizedQuestNames()

					-- Add some options based on game capabilities (which basically means version (retail vs classic))
					local S = Wholly.s
					if Grail.capabilities.usesFlightPoints then
						tinsert(Wholly.configuration[S.WORLD_MAP], { S.HIDE_WORLD_MAP_FLIGHT_POINTS, 'hidesWorldMapFlightPoints', 'configurationScript19' })
					end
					if Grail.capabilities.usesCallingQuests then
						tinsert(Wholly.configuration[S.WORLD_MAP], { S.HIDE_BLIZZARD_WORLD_MAP_CALLING_QUESTS, 'hidesBlizzardWorldMapCallingQuests', 'configurationScript20' })
					end
					if Grail.capabilities.usesCampaignQuests then
						tinsert(Wholly.configuration[S.WORLD_MAP], { S.HIDE_BLIZZARD_WORLD_MAP_CAMPAIGN_QUESTS, 'hidesBlizzardWorldMapCampaignQuests', 'configurationScript21' })
					end
					if Grail.capabilities.usesWorldQuests then
						tinsert(Wholly.configuration[S.WORLD_MAP], { S.HIDE_BLIZZARD_WORLD_MAP_WORLD_QUESTS, 'hidesBlizzardWorldMapWorldQuests', 'configurationScript22' })
					end

					-- Setup the preferences
--					local com_mithrandir_whollyConfigFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
--					com_mithrandir_whollyConfigFrame:SetScript("OnShow", function(self) Wholly:ConfigFrame_OnShow(self) end)
--					local com_mithrandir_whollyTitleAppearanceConfigFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
--					com_mithrandir_whollyTitleAppearanceConfigFrame:SetScript("OnShow", function(self) Wholly:ConfigFrame_OnShow(self) end)
--					local com_mithrandir_whollyWorldMapConfigFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
--					com_mithrandir_whollyWorldMapConfigFrame:SetScript("OnShow", function(self) Wholly:ConfigFrame_OnShow(self) end)
--					local com_mithrandir_whollyWidePanelConfigFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
--					com_mithrandir_whollyWidePanelConfigFrame:SetScript("OnShow", function(self) Wholly:ConfigFrame_OnShow(self) end)
--					local com_mithrandir_whollyLoadDataConfigFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
--					com_mithrandir_whollyLoadDataConfigFrame:SetScript("OnShow", function(self) Wholly:ConfigFrame_OnShow(self) end)
--					local com_mithrandir_whollyOtherConfigFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
--					com_mithrandir_whollyOtherConfigFrame:SetScript("OnShow", function(self) Wholly:ConfigFrame_OnShow(self) end)
					self:ConfigFrame_OnLoad(com_mithrandir_whollyConfigFrame, "Wholly")
					self:ConfigFrame_OnLoad(com_mithrandir_whollyTitleAppearanceConfigFrame, Wholly.s.TITLE_APPEARANCE, "Wholly")
					self:ConfigFrame_OnLoad(com_mithrandir_whollyWorldMapConfigFrame, Wholly.s.WORLD_MAP, "Wholly")
					self:ConfigFrame_OnLoad(com_mithrandir_whollyWidePanelConfigFrame, Wholly.s.WIDE_PANEL, "Wholly")
					self:ConfigFrame_OnLoad(com_mithrandir_whollyLoadDataConfigFrame, Wholly.s.LOAD_DATA, "Wholly")
					self:ConfigFrame_OnLoad(com_mithrandir_whollyOtherConfigFrame, Wholly.s.OTHER_PREFERENCE, "Wholly")

					self:_SetupMapPinsProvider()
					self:_SetupMapPinsProviderPin()
					self:_SetupMapPinsPool()	-- this needs to happen after calling _SetupMapPinsProviderPin() because it references items therein

					self:_DisplayMapFrame(WDB.displaysMapFrame)
					Grail:RegisterObserver("Status", self._CallbackHandler)
					Grail:RegisterObserverQuestAbandon(self._CallbackHandler)

					-- Find out which "map area" is for the player's class
					for key, value in pairs(Grail.classMapping) do
						if Grail.playerClass == value then
							self.playerClassMap = Grail.classToMapAreaMapping['C'..key]
						end
					end

					self:UpdateCoordinateSystem()	-- installs OnUpdate script appropriately

					frame:RegisterEvent("PLAYER_ENTERING_WORLD")
					frame:RegisterEvent("QUEST_ACCEPTED")
					frame:RegisterEvent("QUEST_COMPLETE")			-- to clear the breadcrumb frame
					frame:RegisterEvent("QUEST_GREETING")			-- to clear the breadcrumb frame
					frame:RegisterEvent("QUEST_LOG_UPDATE")			-- just to be able update tooltips after reload UI
					frame:RegisterEvent("QUEST_PROGRESS")
					frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")	-- this is for the panel
					self:UpdateBreadcrumb()							-- sets up registration of events for breadcrumbs based on user preferences
					if not WDB.shouldNotRestoreDirectionalArrows then
						self:_ReinstateDirectionalArrows()
					end

					if WDB.loadReputationData then
						self.configurationScript10()
					end

					if WDB.loadDateData then
						self.configurationScript14()
					end

--					if WDB.loadRewardData then
--						self.configurationScript15()
--					end

					-- Execute the configurationScript appropriate for setting up specific WorldMapFrame settings
					if Grail.capabilities.usesFlightPoints then self.configurationScript19() end
					if Grail.capabilities.usesCallingQuests then self.configurationScript20() end
					if Grail.capabilities.usesCampaignQuests then self.configurationScript21() end
					if Grail.capabilities.usesWorldQuests then self.configurationScript22() end

					-- We steal the TomTom:RemoveWaypoint() function because we want to override it ourselves
					if TomTom and TomTom.RemoveWaypoint then
						self.removeWaypointFunction = TomTom.RemoveWaypoint
						TomTom.RemoveWaypoint = function(self, uid)
							Wholly:_RemoveDirectionalArrows(uid)
							Wholly.removeWaypointFunction(TomTom, uid)
						end
					end
					if TomTom and TomTom.ClearAllWaypoints then
						self.clearAllWaypointsFunction = TomTom.ClearAllWaypoints
						TomTom.ClearAllWaypoints = function(self)
							Wholly:_RemoveAllDirectionalArrows()
							Wholly.clearAllWaypointsFunction(TomTom)
						end
					end
					-- We steal Carbonite's Nx.TTRemoveWaypoint() function because we need it to clear our waypoints
					if Nx and Nx.TTRemoveWaypoint then
						self.carboniteRemoveWaypointFunction = Nx.TTRemoveWaypoint
						Nx.TTRemoveWaypoint = function(self, uid)
							Wholly:_RemoveDirectionalArrows(uid)
							Wholly.carboniteRemoveWaypointFunction(Nx, uid)
						end
					end

					self.easyMenuFrame = CreateFrame("Frame", "com_mithrandir_whollyEasyMenu", self.currentFrame, "UIDropDownMenuTemplate")
					self.easyMenuFrame:Hide()
					StaticPopupDialogs["com_mithrandir_whollyTagDelete"] = {
						text = CONFIRM_COMPACT_UNIT_FRAME_PROFILE_DELETION,
						button1 = ACCEPT,
						button2 = CANCEL,
						OnAccept = function(self, tagName)
							WhollyDatabase.tags[tagName] = nil
							Wholly:ScrollFrameTwo_Update()
							end,
						timeout = 0,
						whileDead = true,
						hideOnEscape = true,
						preferredIndex = 3,
						}

					self:_InitializeLevelOneData()
					if WDB.useWidePanel then self:ToggleCurrentFrame() end

--				end	-- matching the if arg1 == "Wholly" then
			end,
			['PLAYER_ENTERING_WORLD'] = function(self, frame)
				self.zoneInfo.zone.mapId = Grail.GetCurrentMapAreaID()
				self:UpdateCoordinateSystem()
			end,
			['ZONE_CHANGED_NEW_AREA'] = function(self, frame)
				local WDB = WhollyDatabase
				local Grail = Grail

				self.zoneInfo.zone.mapId = Grail.GetCurrentMapAreaID()
				if WDB.updatesWorldMapOnZoneChange and WorldMapFrame:IsVisible() then
					WorldMapFrame:SetMapID(self.zoneInfo.zone.mapId)
--					OpenWorldMap(self.zoneInfo.zone.mapId)	-- does not work on Classic, Blizzard errors
				end
				self:UpdateQuestCaches(false, false, WDB.updatesPanelWhenZoneChanges, true)

                --	When first entering a zone for the first time the NPCs need to be studied to see whether their
                --	tooltips need to be modified with quest information.
                local newMapId = self.zoneInfo.zone.mapId
                if not self.checkedNPCs[newMapId] then
                    self:_RecordTooltipNPCs(newMapId)
                end

				-- Now update open tooltips showing our quest count data
				if GameTooltip:IsVisible() then
					if GameTooltip:GetOwner() == com_mithrandir_whollyFrameSwitchZoneButton then
						GameTooltip:ClearLines()
						GameTooltip:AddLine(Wholly.panelCountLine)
					elseif GameTooltip:GetOwner() == self.ldbTooltipOwner then -- LibDataBroker tooltip
						GameTooltip:ClearLines()
						GameTooltip:AddLine("Wholly - " .. Wholly:_Dropdown_GetText() )
						GameTooltip:AddLine(Wholly.panelCountLine)
					elseif GameTooltip:GetOwner() == self.ldbCoordinatesTooltipOwner then -- LibDataBroker coordinates tooltip
						GameTooltip:ClearLines()
						local mapAreaId = Wholly.zoneInfo.zone.mapId
						local mapAreaName = Grail:MapAreaName(mapAreaId) or "UNKNOWN"
						GameTooltip:AddLine(strformat("%d %s", mapAreaId, mapAreaName))
					end
				elseif self.tooltip:IsVisible() then
					if self.tooltip:GetOwner() == self.mapFrame then
						self.tooltip:ClearLines()
						self.tooltip:AddLine(Wholly.mapCountLine)
					end
				end
			end,
			},
		filteredPanelQuests = {},	-- filtered table from cachedPanelQuests using current panel filters
		filteredPinQuests = {},		-- filtered table from cachedPinQuests using current pin filters
		initialUpdateProcessed = false,
		lastWhich = nil,
		lastPrerequisiteQuest = nil,
		lastUpdate = 0,
		ldbCoordinatesTooltipOwner = nil,
		ldbTooltipOwner = nil,
		levelOneCurrent = nil,
		levelOneData = nil,
		levelTwoCurrent = nil,
		levelTwoData = nil,
		mapFrame = nil,			-- the world map frame that contains the checkbox to toggle pins
        mapPins = {},
        mapPinsPool = nil,			-- set up in _SetupMapPinsPool()
        mapPinsProvider = nil,		-- set up in _SetupMapPinsProvider()
        mapPinsProviderPin = nil,	-- set up in _SetupMapPinsProviderPin()
        mapPinsRegistry = {},
		mapPinsTemplateName = "WhollyPinsTemplate",
		mapPinCount = 0,
		maximumSearchHistory = 10,
		npcs = {},
		onlyAddingTooltipToGameTooltip = false,
		pairedConfigurationButton = nil,-- configuration panel button that does the same thing as the world map button
		pairedCoordinatesButton = nil,	-- configuration panel button that does the same thing as the LDB coordinate button
		panelCountLine = "",
		pinsDisplayedLast = nil,
		pinsNeedFiltering = false,
		playerAliveReceived = false,
		playerClassMap = nil,
		preferenceButtons = {},			-- when each of the preference buttons gets created we put them in here to be able to access them if we want
		previousX = 0,
		previousY = 0,
		receivedCalendarUpdateEventList = false,
		pins = {},				-- the pins are contained in a structure that follows, where the first key is the parent frame of the pins contained
		--		pins = {
		--				[WorldMapDetailFrame] = {
		--										[npcs] = {},	-- each key is the NPC id, and the value is the actual pin
		--										[ids] = {},		-- each key is the id : NPC id, and the value is the actual pin
		--										},
		--				}
		removeWaypointFunction = nil,
		s = {
			-- Start of actual strings that need localization.
			['KILL_TO_START_FORMAT'] = "Kill to start [%s]",
			['DROP_TO_START_FORMAT'] = "Drops %s to start [%s]",
			['REQUIRES_FORMAT'] = "Wholly requires Grail version %s or later",
			['MUST_KILL_PIN_FORMAT'] = "%s [Kill]",
			['ESCORT'] = "Escort",
			['BREADCRUMB'] = "Breadcrumb quests:",
			['IS_BREADCRUMB'] = "Is breadcrumb quest for:",
			['PREREQUISITES'] = "Prerequisites:",
			['OTHER'] = "Other",
			['SINGLE_BREADCRUMB_FORMAT'] = "Breadcrumb quest available",
			['MULTIPLE_BREADCRUMB_FORMAT'] = "%d Breadcrumb quests available",
			['WORLD_EVENTS'] = "World Events",
			['REPUTATION_REQUIRED'] = "Reputation Required",
			['REPEATABLE'] = "Repeatable",
			['YEARLY'] = "Yearly",
			['GRAIL_NOT_HAVE'] = "|cFFFF0000Grail does not have this quest|r",
			['QUEST_ID'] = "Quest ID: ",
			['REQUIRED_LEVEL'] = "Required Level",
			['MAXIMUM_LEVEL_NONE'] = "None",
			['QUEST_TYPE_NORMAL'] = "Normal",
			['MAPAREA_NONE'] = "None",
			['LOREMASTER_AREA'] = "Loremaster Area",
			['FACTION_BOTH'] = "Both",
			['CLASS_NONE'] = "None",
			['CLASS_ANY'] = "Any",
			['GENDER_NONE'] = "None",
			['GENDER_BOTH'] = "Both",
			['GENDER'] = "Gender",
			['RACE_NONE'] = "None",
			['RACE_ANY'] = "Any",
			['HOLIDAYS_ONLY'] = "Available only during Holidays:",
			['SP_MESSAGE'] = "Special quest never enters Blizzard quest log",
			['INVALIDATE'] = "Invalidated by Quests:",
			['OAC'] = "On acceptance complete quests:",
			['OCC'] = "On completion of requirements complete quests:",
			['OTC'] = "On turn in complete quests:",
			['ENTER_ZONE'] = "Accepted when entering map area",
			['WHEN_KILL'] = "Accepted when killing:",
			['SEARCH_NEW'] = "New",
			['SEARCH_CLEAR'] = "Clear",
			['SEARCH_ALL_QUESTS'] = "All quests",
			['NEAR'] = "Near",
			['FIRST_PREREQUISITE'] = "First in Prerequisite Chain:",
			['BUGGED'] = "|cffff0000*** BUGGED ***|r",
			['IN_LOG'] = "In Log",
			['TURNED_IN'] = "Turned in",
			['EVER_COMPLETED'] = "Has ever been completed",
			['ITEM'] = "Item",
			['ITEM_LACK'] = "Item lack",
			['ABANDONED'] = "Abandoned",
			['NEVER_ABANDONED'] = "Never Abandoned",
			['ACCEPTED'] = "Accepted",	-- ? CALENDAR_STATUS_ACCEPTED ?
			['LEGENDARY'] = "Legendary",
			['ACCOUNT'] = "Account",
			['EVER_CAST'] = "Has ever cast",
			['EVER_EXPERIENCED'] = "Has ever experienced",
			['TAGS'] = "Tags",
			['TAGS_NEW'] = "New Tag",
			['TAGS_DELETE'] = "Delete Tag",
			['MAP'] = "Map",	-- ? BRAWL_TOOLTIP_MAP ?
			['PLOT'] = "Plot",
			['BUILDING'] = "Building",

			['BASE_QUESTS'] = "Base Quests",
			['COMPLETED'] = "Completed",	-- ? QUEST_COMPLETE ? -- it is "Quest completed"
			['NEEDS_PREREQUISITES'] = "Needs prerequisites",
			['UNOBTAINABLE'] = "Unobtainable",
			['LOW_LEVEL'] = "Low-level",
			['HIGH_LEVEL'] = "High level",
			['TITLE_APPEARANCE'] = "Quest Title Appearance",
			['PREPEND_LEVEL'] = "Prepend quest level",
			['APPEND_LEVEL'] = "Append required level",
			['REPEATABLE_COMPLETED'] = "Show whether repeatable quests previously completed",
			['IN_LOG_STATUS'] = "Show status of quests in log",
			['MAP_PINS'] = "Display map pins for quest givers",
			['MAP_PINS_TURNIN'] = "Display map pins for turn in for completed quests in log",
			['MAP_PINS_TURNIN_INCOMPLETE'] = "Display map pins for turn in for incomplete quests in log",
			['MAP_BUTTON'] = "Display button on world map",
			['MAP_DUNGEONS'] = "Display dungeon quests in outer map",
			['MAP_UPDATES'] = "Open world map updates when zones change",
			['OTHER_PREFERENCE'] = "Other",
			['PANEL_UPDATES'] = "Quest log panel updates when zones change",
			['SHOW_BREADCRUMB'] = "Display breadcrumb quest information on Quest Frame",
			['SHOW_BREADCRUMB_MESSAGE'] = "Display breadcrumb message in chat",
			['SHOW_LOREMASTER'] = "Show only Loremaster quests",
			['ENABLE_COORDINATES'] = "Enable player coordinates",
			['ACHIEVEMENT_COLORS'] = "Show achievement completion colors",
			['BUGGED_UNOBTAINABLE'] = "Bugged quests considered unobtainable",
			['BLIZZARD_TOOLTIP'] = "Tooltips appear on Blizzard Quest Log",
			['WIDE_PANEL'] = "Wide Wholly Quest Panel",
			['WIDE_SHOW'] = "Show",	-- ? SHOW ?
			['QUEST_COUNTS'] = "Show quest counts",
			['LIVE_COUNTS'] = "Live quest count updates",
			['LOAD_DATA'] = "Load Data",
			['COMPLETION_DATES'] = "Completion Dates",
			['ALL_FACTION_REPUTATIONS'] = "Show all faction reputations",
			['RARE_MOBS'] = 'Rare Mobs',
			['TREASURE'] = 'Treasure',
			['EMPTY_ZONES'] = 'Display empty zones',
			['IGNORE_REPUTATION_SECTION'] = 'Ignore reputation section of quests',
			['RESTORE_DIRECTIONAL_ARROWS'] = 'Should not restore directional arrows',
			['ADD_ADVENTURE_GUIDE'] = 'Display Adventure Guide quests in every zone',
			['HIDE_WORLD_MAP_FLIGHT_POINTS'] = 'Hide flight points',
			['HIDE_BLIZZARD_WORLD_MAP_TREASURES'] = 'Hide Blizzard treasures',
			['HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES'] = 'Hide Blizzard bonus objectives',
			['HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS'] = 'Hide Blizzard quest map pins',
			['HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES'] = 'Hide Blizzard dungeon entrances',
			['HIDE_BLIZZARD_WORLD_MAP_CALLING_QUESTS'] = 'Hide Blizzard calling quests',
			['HIDE_BLIZZARD_WORLD_MAP_CAMPAIGN_QUESTS'] = 'Hide Blizzard campaign quests',
			['HIDE_BLIZZARD_WORLD_MAP_WORLD_QUESTS'] = 'Hide Blizzard world quests',
			['HIDE_ID_ON_QUEST_FRAME'] = 'Hide quest ID on Quest Frame',
			},
		tooltip = nil,
		updateDelay = 0.5,
		updateThreshold = 0.1,
		versionNumber = Wholly_File_Version,
		waypoints = {},
		zoneInfo = {
			["map"] = { ["mapId"] = 0, ["dungeonLevel"] = 0, },	-- this is what the world map is set to
			["panel"] = { ["mapId"] = 0, ["dungeonLevel"] = 0, },	-- this is what the Wholly panel is displaying
			["pins"] = { ["mapId"] = 0, ["dungeonLevel"] = 0, },	-- this is where the pins were last showing
			["zone"] = { ["mapId"] = 0, ["dungeonLevel"] = 0, },	-- this is where the player is
			},

		_AchievementName = function(self, mapID)
			local colorStart, colorEnd = "", ""
			local Grail = Grail
			local baseName = Grail:MapAreaName(mapID) or "UNKONWN"
			if WhollyDatabase.showsAchievementCompletionColors then
				local completed = Grail:AchievementComplete(mapID - Grail.mapAreaBaseAchievement)
				colorStart = completed and "|cff00ff00" or "|cffffff00"
				colorEnd = "|r"
			end
			return colorStart .. baseName .. colorEnd, baseName
		end,

		_AddDirectionalArrows = function(self, questTable, npcType, groupNumberToUse)
			local TomTom = TomTom
			local hasTomTom = TomTom and TomTom.AddWaypoint
			local hasBlizzardWaypoint = C_Map and C_Map.SetUserWaypoint
			if not hasTomTom and not hasBlizzardWaypoint then return end
			if nil == questTable or nil == npcType then return end
			local locations
			local WDB = WhollyDatabase
			local Grail = Grail

			if not groupNumberToUse then
				WDB.lastGrouping = WDB.lastGrouping or 0	-- initialize if needed
				WDB.lastGrouping = WDB.lastGrouping + 1
				WDB.waypointGrouping = WDB.waypointGrouping or {}
				WDB.waypointGrouping[WDB.lastGrouping] = {}
			end
			for _, questId in pairs(questTable) do
				if 'T' == npcType then
					locations = Grail:QuestLocationsTurnin(questId)
				else
					locations = Grail:QuestLocationsAccept(questId)
				end
				if nil ~= locations then
					local indexValue = questId .. npcType
					local t = {}
					for _, npc in pairs(locations) do
						if nil ~= npc.x then
							if hasTomTom then
								local npcName = self:_PrettyNPCString(Grail:NPCName(npc.id), npc.kill, npc.realArea) or "***"
								local uid = TomTom:AddWaypoint(npc.mapArea, npc.x/100, npc.y/100,
										{	persistent = false,
											title = npcName .. " - " .. self:_QuestName(questId),
										})
								tinsert(t, uid)
							end
							if hasBlizzardWaypoint then
							--	local point = { uiMapID = npc.mapArea, position = CreateVector2D(npc.x/100, npc.y/100) }
								local point = UiMapPoint.CreateFromCoordinates(npc.mapArea, npc.x/100, npc.y/100)
								C_Map.SetUserWaypoint(point)	-- this just puts a point on the map
								C_SuperTrack.SetSuperTrackedUserWaypoint(true)	-- this makes it appear in the UI
								-- ObjectiveTracker_Update(OBJECTIVE_TRACKER_UPDATE_QUEST_ADDED, questID) -- does not seem to do anything we want
							end
						end
					end
					if 0 < #t then
						local actualGroup = groupNumberToUse or WDB.lastGrouping
						self.waypoints[indexValue] = { grouping = actualGroup, uids = t }
						if not groupNumberToUse then
							tinsert(WDB.waypointGrouping[WDB.lastGrouping], indexValue)
						end
						if self.chooseClosestWaypoint and TomTom.SetClosestWaypoint and 1 < #t then
							TomTom:SetClosestWaypoint()
						end
					end
				end
			end
			if not groupNumberToUse and 0 == #(WDB.waypointGrouping[WDB.lastGrouping]) then
				WDB.waypointGrouping[WDB.lastGrouping] = nil
				WDB.lastGrouping = WDB.lastGrouping - 1
			end
		end,

		--	This adds a line to the "current" tooltip, creating a new one as needed.
		_AddLine = function(self, value, value2, texture, shouldWrap)
			local tt
			if not self.onlyAddingTooltipToGameTooltip then
				tt = self.tt[self.currentTt]
				if tt:NumLines() >= self.currentMaximumTooltipLines then
					local previousTt = tt
					self.currentTt = self.currentTt + 1
					tt = self.tt[self.currentTt]
					if nil == tt then
						tt = CreateFrame("GameTooltip", "com_mithrandir_WhollyOtherTooltip"..self.currentTt, GameTooltip, "GameTooltipTemplate")
						self.tt[self.currentTt] = tt
					end
					tt:SetOwner(previousTt, "ANCHOR_RIGHT")
					tt:ClearLines()
				end
			else
				tt = GameTooltip
			end
			if nil ~= value2 then
				tt:AddDoubleLine(value, value2)
			else
				if shouldWrap then
					tt:AddLine(value, 1, 1, 1, shouldWrap)
				else
					tt:AddLine(value)
				end
			end
			if nil ~= texture then
				tt:AddTexture(texture)
			end
		end,

		BreadcrumbClick = function(self, frame)
			local Grail = Grail
			local questId = self:_BreadcrumbQuestId()
			self:_AddDirectionalArrows(Grail:AvailableBreadcrumbs(questId), 'A')
		end,

		BreadcrumbEnter = function(self, frame)
			local Grail = Grail
			GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
			GameTooltip:ClearLines()
			local questId = self:_BreadcrumbQuestId()
			local breadcrumbs = Grail:AvailableBreadcrumbs(questId)
			if nil ~= breadcrumbs then
				GameTooltip:AddLine(self.s.BREADCRUMB)
				for i = 1, #breadcrumbs do
					GameTooltip:AddLine(self:_PrettyQuestString({ breadcrumbs[i], Grail:ClassificationOfQuestCode(breadcrumbs[i], nil, WhollyDatabase.buggedQuestsConsideredUnobtainable) }))
				end
				GameTooltip:Show()
			end
		end,

		_BreadcrumbQuestId = function(self)
			local questId = GetQuestID()
			local questName = GetTitleText()
			local Grail = Grail

			-- Check the make sure the questId we are attempting to use makes sense with the title, otherwise
			-- the questId is incorrect and we need to try to get it
			if questName ~= self:_QuestName(questId) then
				questId = Grail:QuestIdFromNPCOrName(questName, nil, true)
			end
			return questId
		end,

		BreadcrumbUpdate = function(self, frame, shouldHide)
			local questId = self:_BreadcrumbQuestId()
			com_mithrandir_whollyQuestInfoFrameText:SetText(questId)
			self:UpdateBuggedText(questId)
			if shouldHide then
				com_mithrandir_whollyBreadcrumbFrame:Hide()
			else
				self:ShowBreadcrumbInfo()
			end
		end,

		ButtonEnter = function(self, button, ...)
			local Grail = Grail
			local aliasQuestId = Grail:AliasQuestId(button.questId)
			local questIdToUse = aliasQuestId or button.questId
			self:_PopulateTooltipForQuest(button, questIdToUse, (questIdToUse ~= button.questId) and button.questId or nil)

			if not button.secureProcessed and not InCombatLockdown() then
				button:SetAttribute("type1", "click")
				button:SetAttribute("clickbutton", Wholly)
				button:SetAttribute("type2", "click")
				button:SetAttribute("shift-type1", "click")
				button:SetAttribute("ctrl-type1", "click")
				button:SetAttribute("ctrl-shift-type1", "click")
				button:SetAttribute("shift-type2", "click")
				button:SetAttribute("alt-type1", "macro")
				button.secureProcessed = true
			else
				-- TODO: Should attempt a delayed setting of this if not button.secureProcessed and InCombatLockdown()
			end

			if 'P' == button.statusCode then
				local controlTable = { ["result"] = {}, ["preq"] = nil, ["lastIndexUsed"] = 0, ["doMath"] = true }
				local lastIndexUsed = Grail._PreparePrerequisiteInfo(Grail:QuestPrerequisites(button.questId, true), controlTable)
				self.lastPrerequisites = controlTable.result
--				local lastIndexUsed = Grail:_PreparePrerequisiteInfo(Grail:QuestPrerequisites(button.questId, true), self.lastPrerequisites, nil, 0, true)
				local outputString
				local started = false
				local tempTable = {}
				for questId, value in pairs(self.lastPrerequisites) do
					tinsert(tempTable, questId)
					outputString = ""
					if not started then
						self:_AddLine(" ")
						self:_AddLine(self.s.FIRST_PREREQUISITE)
						started = true
					end
					for key, value2 in pairs(value) do
						if "" == outputString then
							outputString = "("..value2
						else
							outputString = outputString..","..value2
						end
					end
					outputString = outputString..") "
					self:_AddLine(outputString..self:_PrettyQuestString({ questId, Grail:ClassificationOfQuestCode(questId, nil, WhollyDatabase.buggedQuestsConsideredUnobtainable) }), questId)
				end
				self.lastPrerequisites = started and tempTable or nil
			else
				self.lastPrerequisites = nil
			end

			for i = 1, self.currentTt do
				self.tt[i]:Show()
			end
		end,

		ButtonPostClick = function(self, button)
			if button ~= self.clickingButton then print("Post click not from the same Pre click") end
			self.clickingButton = nil
		end,

		ButtonPreClick = function(self, button)
			self.clickingButton = button
		end,

		_CallbackHandler = function(type, questId)
			local WDB = WhollyDatabase

			Wholly:UpdateQuestCaches(true)
			Wholly:_UpdatePins(true)
			if WDB.showQuestCounts and WDB.liveQuestCountUpdates then
				for mapId, ignoredCurrentString in pairs(Wholly.cachedMapCounts) do
					local questsInMap = Wholly:_ClassifyQuestsInMap(mapId) or {}
					Wholly.cachedMapCounts[mapId] = Wholly:_PrettyQuestCountString(questsInMap, nil, nil, true)
				end
				Wholly:ScrollFrameTwo_Update()
			end
		end,

		_CheckNPCTooltip = function(tooltip)
			if (not UnitIsPlayer("mouseover") or true) then
				-- check if this npc drops a quest item
				local id = Grail:GetNPCId(false, true)	-- only "mouseover" will be used
				local qs = id and Wholly.npcs[tonumber(id)] or nil
				if nil ~= qs then
					for _, questId in pairs(qs) do
						if Grail:CanAcceptQuest(questId) then
							local _, kindsOfNPC = Grail:IsTooltipNPC(id)
							if nil ~= kindsOfNPC then
								for i = 1, #(kindsOfNPC), 1 do
									local tooltipMessage = nil
									if kindsOfNPC[i][1] == Grail.NPC_TYPE_KILL then
										tooltipMessage = format(Wholly.s.KILL_TO_START_FORMAT, Wholly:_QuestName(questId))
									elseif kindsOfNPC[i][1] == Grail.NPC_TYPE_DROP then
										if Wholly:_DroppedItemMatchesQuest(kindsOfNPC[i][2], questId) then
											tooltipMessage = format(Wholly.s.DROP_TO_START_FORMAT, Grail:NPCName(kindsOfNPC[i][2]), Wholly:_QuestName(questId))
										end
									end
									if nil ~= tooltipMessage then
										local leftStr = format("|TInterface\\MINIMAP\\ObjectIcons:0:0:0:0:128:128:16:32:16:32|t %s", tooltipMessage)
										tooltip:AddLine(leftStr);
									end
								end
							end
							tooltip:Show();
						end
					end
				end
			end
		end,

		---
		--	Gets all the quests in the map area, then classifies them based on the current player.
		_ClassifyQuestsInMap = function(self, mapId)
			local retval = nil
			if nil ~= mapId and tonumber(mapId) then
				mapId = tonumber(mapId)
				local displaysHolidayQuestsAlways = false
				local WDB = WhollyDatabase
				local showsLoremasterOnly = WDB.showsLoremasterOnly
				if mapId >= Grail.mapAreaBaseHoliday and mapId <= Grail.mapAreaMaximumHoliday then displaysHolidayQuestsAlways = true end
				retval = {}
				local questsInMap = Grail:QuestsInMap(mapId, WDB.displaysDungeonQuests, showsLoremasterOnly, true) or {}
				for _,questId in pairs(questsInMap) do
					tinsert(retval, { questId, Grail:ClassificationOfQuestCode(questId, displaysHolidayQuestsAlways, WDB.buggedQuestsConsideredUnobtainable) })
				end
				if WDB.shouldAddAdventureGuideQuests then
					local questsInAdventureGuide = Grail:QuestsInMap(1, WDB.displaysDungeonQuests, showsLoremasterOnly) or {}
					for _,questId in pairs(questsInAdventureGuide) do
						if not tContains(questsInMap, questId) then
							tinsert(retval, { questId, Grail:ClassificationOfQuestCode(questId, displaysHolidayQuestsAlways, 	WDB.buggedQuestsConsideredUnobtainable) })
						end
					end
				end
			end
			return retval
		end,

		--	Shift right-click	:	Tag quest
		--	Shift control-click	:	Ignore quest
		--	Shift left-click	:	Toggle LightHeaded (does nothing if LightHeaded not installed)
		--	Control click		:	Directional arrows for all quests in "map area"
		--	Right-click			:	Directional arrows for questgivers for first in prerequisites, or directional arrows to turn-in NPCs if no prerequisites
		--	Left-click			:	Directional arrows for questgivers
		-- This is named this way with this function signature because it is called from the SecureActionButtonTemplate exactly like this.
		Click = function(self, leftOrRight)
			if IsShiftKeyDown() and "RightButton" == leftOrRight then
				self:_TagProcess(self.clickingButton.questId)
				return
			end
			if IsShiftKeyDown() and IsControlKeyDown() then
				self:ToggleIgnoredQuest()
				self.configurationScript1()
				return
			end
			if IsShiftKeyDown() then
				if LightHeaded then self:ToggleLightHeaded() end
				return
			end
			if IsControlKeyDown() then
				local questsInMap = self.filteredPanelQuests
				local numEntries = #questsInMap
				for i = 1, numEntries do
					self:_AddDirectionalArrows({questsInMap[i][1]}, 'A')
				end
				return
			end
			local button = self.clickingButton
			local questsToUse = {button.questId}
			local npcType = 'A'
			if "RightButton" == leftOrRight then
				if nil ~= self.lastPrerequisites then
					questsToUse = self.lastPrerequisites
				else
					npcType = 'T'
				end
			end
			self:_AddDirectionalArrows(questsToUse, npcType)
		end,

		_ColorCodeFromInfo = function(self, colorCode, r, g, b, a)
			local aString = Grail:_HexValue(a * 255, 2)
			local rString = Grail:_HexValue(r * 255, 2)
			local gString = Grail:_HexValue(g * 255, 2)
			local bString = Grail:_HexValue(b * 255, 2)
			WhollyDatabase.color[colorCode] = aString .. rString .. gString .. bString
		end,

		--	This takes the colorCode value "AARRGGBB" and returns the r, g, b, a as decimals
		_ColorInfoFromCode = function(self, colorCode)
			local colorString = WhollyDatabase.color[colorCode]
			local a = tonumber(strsub(colorString, 1, 2), 16) / 255
			local r = tonumber(strsub(colorString, 3, 4), 16) / 255
			local g = tonumber(strsub(colorString, 5, 6), 16) / 255
			local b = tonumber(strsub(colorString, 7, 8), 16) / 255
			return r, g, b, a
		end,

		--	This will update all the preference text that have associated color codes
		_ColorUpdateAllPreferenceText = function(self)
			for i = 1, #self.configuration.Wholly do
				if nil ~= self.configuration.Wholly[i][6] then
					self.colorWells[i].swatch:SetVertexColor(self:_ColorInfoFromCode(self.configuration.Wholly[i][6]))
					self:_ColorUpdatePreferenceText(i, "Wholly")
				end
			end
		end,

		--	This will set the text for the preference
		_ColorUpdatePreferenceText = function(self, configIndex, panelName)
			local button = self.preferenceButtons[self.configuration[panelName][configIndex][2]]
			local colorCode
			if nil ~= button then
				local colorStart, colorEnd = "", ""
				colorCode = self.configuration[panelName][configIndex][6]
				if nil ~= colorCode then
					colorStart = "|c" .. WhollyDatabase.color[colorCode]
					colorEnd = "|r"
				end
				_G[button:GetName().."Text"]:SetText(colorStart .. self.configuration[panelName][configIndex][1] .. colorEnd)
			end
		end,

		--	This creates a color well associated with the colorCode
		_ColorWell = function(self, configIndex, panel)
			local well = CreateFrame("Button", nil, panel)
			well:EnableMouse(true)
			well:SetHeight(16)
			well:SetWidth(16)
			well:SetScript("OnClick", Wholly._ColorWell_OnClick)
			well.configIndex = configIndex
			local swatch = well:CreateTexture(nil, "OVERLAY")
			swatch:SetWidth(16)
			swatch:SetHeight(16)
			swatch:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
			swatch:SetPoint("LEFT")
			well.swatch = swatch
			return well
		end,

		_ColorWell_Callback = function(self, frame, r, g, b, a, processingAlpha)
			frame.swatch:SetVertexColor(r, g, b, a)
			self:_ColorCodeFromInfo(self.configuration.Wholly[frame.configIndex][6], r, g, b, a)
			self:_ColorUpdatePreferenceText(frame.configIndex, "Wholly")
		end,

		_ColorWell_OnClick = function(frame)
			HideUIPanel(ColorPickerFrame)
			ColorPickerFrame:SetFrameStrata("FULLSCREEN_DIALOG")
			ColorPickerFrame.func = function()
				local r, g, b = ColorPickerFrame:GetColorRGB()
				local a = 1 - OpacitySliderFrame:GetValue()
				Wholly:_ColorWell_Callback(frame, r, g, b, a)
			end
			ColorPickerFrame.hasOpacity = true
			ColorPickerFrame.opacityFunc = function()
				local r, g, b = ColorPickerFrame:GetColorRGB()
				local a = 1 - OpacitySliderFrame:GetValue()
				Wholly:_ColorWell_Callback(frame, r, g, b, a, true)
			end
			local r, g, b, a = Wholly:_ColorInfoFromCode(Wholly.configuration.Wholly[frame.configIndex][6])
			ColorPickerFrame.opacity = 1 - a
			ColorPickerFrame:SetColorRGB(r, g, b)
			ColorPickerFrame.cancelFunc = function()
				Wholly:_ColorWell_Callback(frame, r, g, b, a, true)
			end
			ShowUIPanel(ColorPickerFrame)
		end,

		ConfigFrame_OnLoad = function(self, panel, panelName, panelParentName)
			panel.name = panelName
			if nil ~= panelParentName then
				panel.parent = panelParentName
			end
			panel:Hide()
			if InterfaceOptions_AddCategory then
				InterfaceOptions_AddCategory(panel)
			else
				-- When panelParentName is nil we are dealing with the top-level
				if nil == panelParentName then
					local category, layout = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
					Settings.RegisterAddOnCategory(category)
					Wholly.settingsCategory = category
				else
					local subcategory = Settings.RegisterCanvasLayoutSubcategory(Wholly.settingsCategory, panel, panel.name)
				end
			end
			local parent = panel:GetName()
			local indentLevel
			local lineLevel = 0
			local button
			local offset
			local wellOffset
			
			if not self.checkedGrailVersion then
				local errorMessage = format(self.s.REQUIRES_FORMAT, requiredGrailVersion)
				button = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				offset = -5
				indentLevel = 0
				lineLevel = lineLevel + 1
				button:SetPoint("TOPLEFT", panel, "TOPLEFT", (indentLevel * 200) + 8, (lineLevel * -20) + 10 + offset)
				button:SetText(errorMessage)
				return 
			end

			for i = 1, #self.configuration[panel.name] do
				if self.configuration[panel.name][i][2] then
					button = CreateFrame("CheckButton", parent.."Button"..i, panel, "InterfaceOptionsCheckButtonTemplate")
					offset = 0
				else
					button = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
					offset = -5
				end
				if self.configuration[panel.name][i][4] then
					indentLevel = indentLevel + 1
				else
					indentLevel = 0
					lineLevel = lineLevel + 1
				end
				wellOffset = 0
				if self.configuration[panel.name][i][6] then
					local well = self:_ColorWell(i, panel)
					well.swatch:SetVertexColor(self:_ColorInfoFromCode(self.configuration[panel.name][i][6]))
					well:ClearAllPoints()
					well:SetPoint("TOPLEFT", panel, "TOPLEFT", (indentLevel * 200) + 6 , (lineLevel * -22) + 14 + offset)
					well:Show()
					self.colorWells[i] = well
				end
				if self.configuration[panel.name][i][2] then wellOffset = 12 end
				button:SetPoint("TOPLEFT", panel, "TOPLEFT", (indentLevel * 200) + 8 + wellOffset, (lineLevel * -22) + 18 + offset)
				if self.configuration[panel.name][i][2] then
					button:SetScript("OnClick", function(self)
													WhollyDatabase[Wholly.configuration[panel.name][i][2]] = self:GetChecked()
													Wholly[Wholly.configuration[panel.name][i][3]](self)
												end)
					if nil ~= self.configuration[panel.name][i][5] then
						self[self.configuration[panel.name][i][5]] = button
					end
					self.preferenceButtons[self.configuration[panel.name][i][2]] = button
					self:_ColorUpdatePreferenceText(i, panel.name)
				else
					button:SetText(self.configuration[panel.name][i][1])
				end
			end

			if nil == panelParentName then
				button = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				button:SetPoint("TOPLEFT", panel, "TOPLEFT", 6, -587)
				button:SetText(COLORS .. ':')
				local previousButton = button
				button = CreateFrame("Button", parent .. "ColorReset", panel, "UIPanelButtonTemplate")
				button:SetWidth(150)
				button:SetPoint("TOPLEFT", previousButton, "TOPRIGHT", 8, 5)
				_G[button:GetName().."Text"]:SetText(RESET_TO_DEFAULT)
				button:SetScript("OnClick", function(self) Wholly:_ResetColors() end)
			end

			self:ConfigFrame_OnShow(panel)
		end,

		ConfigFrame_OnShow = function(self, panel)
			if not self.checkedGrailVersion then return end
			local parent = panel:GetName()
			for i = 1, #self.configuration[panel.name] do
				if self.configuration[panel.name][i][2] then
					_G[parent.."Button"..i]:SetChecked(WhollyDatabase[self.configuration[panel.name][i][2]])
				end
			end
		end,

		_DisplayMapFrame = function(self, shouldDisplay)
			if shouldDisplay then self.mapFrame:Show() else self.mapFrame:Hide() end
		end,

		_Dropdown_AddButton = function(self, level, hasArrow, item)
			local info = UIDropDownMenu_CreateInfo()
			info.hasArrow = hasArrow
			info.notCheckable = true
			info.text = item.displayName
			info.value = item
			if not hasArrow then
				info.func = item.f		-- default to any menu provided function
				if nil == info.func then
					info.func = function()
						Wholly.zoneInfo.panel.mapId = item.mapID
						Wholly._ForcePanelMapArea(Wholly)
						CloseDropDownMenus()
					end
				end
			end
			UIDropDownMenu_AddButton(info, level)
		end,

		_Dropdown_Create = function(self)
			local f = com_mithrandir_whollyFrame
			self.dropdown = CreateFrame("Button", f:GetName().."ZoneButton", f, "UIDropDownMenuTemplate")
			UIDropDownMenu_Initialize(self.dropdown, self.Dropdown_Initialize) -- took away "MENU" because no show with it
			self.dropdown:SetPoint("TOPLEFT", f, "TOPLEFT", 60, -40)
			UIDropDownMenu_SetWidth(self.dropdown, 240, 0)
			UIDropDownMenu_JustifyText(self.dropdown, "LEFT")
			-- By default, the dropdown has it clicking work with the little button on the right.  This makes it work for the whole button:
			self.dropdown:SetScript("OnClick", function(self) ToggleDropDownMenu(nil, nil, Wholly.dropdown) PlaySound(PlaySoundKitID and "igMainMenuOptionCheckBoxOn" or 856) end)
		end,

		_Dropdown_GetText = function(self)
			if nil ~= self.dropdown then
				self.dropdownText = UIDropDownMenu_GetText(self.dropdown)
			end
			return self.dropdownText
		end,

		Dropdown_Initialize = function(self, level)
			local UIDROPDOWNMENU_MENU_VALUE = UIDROPDOWNMENU_MENU_VALUE
			level = level or 1
			if 1 == level then
				for k, v in pairs(Wholly.levelOneData) do
					Wholly:_Dropdown_AddButton(level, true, v)
				end
			elseif 2 == level then
				local children = UIDROPDOWNMENU_MENU_VALUE["children"]
				if nil ~= children then
					for k, v in pairs(children) do
						Wholly:_Dropdown_AddButton(level, true, v)
					end
				else
					Wholly:_SetLevelOneCurrent(UIDROPDOWNMENU_MENU_VALUE)
					Wholly:_InitializeLevelTwoData()
					for k, v in pairs(Wholly.levelTwoData) do
						Wholly:_Dropdown_AddButton(level, false, v)
					end
				end
			else	-- assumption is level 3 which is the highest we have
				Wholly:_SetLevelOneCurrent(UIDROPDOWNMENU_MENU_VALUE)
				Wholly:_InitializeLevelTwoData()
				for k, v in pairs(Wholly.levelTwoData) do
					Wholly:_Dropdown_AddButton(level, false, v)
				end
			end
		end,

		_Dropdown_SetText = function(self, newTitle)
			self.dropdownText = newTitle
			if nil ~= self.dropdown then
				UIDropDownMenu_SetText(self.dropdown, self.dropdownText)
			end
		end,

		_DroppedItemMatchesQuest = function(self, dropNPCCode, matchingQuestId)
			local retval = true
			dropNPCCode = tonumber(dropNPCCode)
			matchingQuestId = tonumber(matchingQuestId)
			if nil ~= dropNPCCode and nil ~= matchingQuestId then
				local questCodes = Grail:AssociatedQuestsForNPC(dropNPCCode)
				if nil ~= questCodes then
					retval = false
					for _, questId in pairs(questCodes) do
						if questId == matchingQuestId then
							retval = true
						end
					end
				end
			end
			return retval
		end,

		_FilterQuests = function(self, forPanel)
			local f = forPanel and self.filteredPanelQuests or self.filteredPinQuests
			f = {}
			local questsInMap = forPanel and self.cachedPanelQuests or self.cachedPinQuests
			local shouldAdd, statusCode, status

			--	We want to be able to force display of quests that are class or profession specific
			--	unless they are associated with the player.  In that case, the display of the quests
			--	obeys the same rules as the quests in a normal map area.
			local shouldForce = false
			local currentMapId = self.zoneInfo.panel.mapId
			if nil ~= currentMapId and currentMapId >= Grail.mapAreaBaseClass and currentMapId <= Grail.mapAreaMaximumProfession then
				shouldForce = true
				if self.playerClassMap == currentMapId then shouldForce = false end
				if currentMapId >= Grail.mapAreaBaseProfession then
					for key,value in pairs(Grail.professionToMapAreaMapping) do
						if value == currentMapId then
							local actualKey = key:sub(2, 2)
							if Grail:ProfessionExceeds(actualKey, 1) then -- indicates the profession is known
								shouldForce = false
							end
						end
					end
				end
			end
			local reputationQuest = false
			if nil ~= currentMapId and currentMapId > Grail.mapAreaBaseReputation and currentMapId <= Grail.mapAreaMaximumReputation then
				reputationQuest = true
			end

			local questId
			local WDB = WhollyDatabase
			local dealingWithHolidays = nil ~= currentMapId and currentMapId >= Grail.mapAreaBaseHoliday and currentMapId <= Grail.mapAreaMaximumHoliday and true or false
			local holidayModification = dealingWithHolidays and (Grail.bitMaskHoliday + Grail.bitMaskAncestorHoliday) or 0
			local buggedModification = WDB.buggedQuestsConsideredUnobtainable and Grail.bitMaskBugged or 0
			for i = 1, #questsInMap do
				statusCode = questsInMap[i][2]

				questId = questsInMap[i][1]
				status = Grail:StatusCode(questId)
				shouldAdd = false
				local questObsoleteOrPending = (Grail:IsQuestObsolete(questId) or Grail:IsQuestPending(questId))

				if Grail:CanAcceptQuest(questId, false, WDB.showsQuestsThatFailPrerequsites, true, true, dealingWithHolidays, WDB.buggedQuestsConsideredUnobtainable) or
					(WDB.showsCompletedQuests and Grail:IsQuestCompleted(questId) and 0 == bitband(status, Grail.bitMaskQuestFailureWithAncestor - (Grail.bitMaskAncestorReputation + Grail.bitMaskReputation) - holidayModification)) or
					0 < bitband(status, Grail.bitMaskInLog) or
					(WDB.showsUnobtainableQuests and (bitband(status, Grail.bitMaskQuestFailureWithAncestor - holidayModification + buggedModification) > 0 or questObsoleteOrPending)) then
					shouldAdd = true
				end

				shouldAdd = shouldAdd and self:_FilterQuestsBasedOnSettings(questId, status, dealingWithHolidays)

				if not forPanel then
					if 'I' == statusCode then
						shouldAdd = (nil ~= Grail:QuestLocationsTurnin(questId, true, false, true, self.zoneInfo.pins.mapId))
						if shouldAdd then
							local _, completed = Grail:IsQuestInQuestLog(questId)
							if completed then
								shouldAdd = WDB.displaysMapPinsTurnin
							else
								shouldAdd = WDB.displaysMapPinsTurninIncomplete
							end
						end
					end
					if 'C' == statusCode then shouldAdd = false end
					if 'B' == statusCode then shouldAdd = false end
				end

				if shouldAdd then
					tinsert(f, questsInMap[i])
				end
			end
			if forPanel then self.filteredPanelQuests = f else self.filteredPinQuests = f end
			if not forPanel then
				self.mapCountLine = self:_PrettyQuestCountString(questsInMap, #(self.filteredPinQuests), true)
			else
				self.panelCountLine = self:_PrettyQuestCountString(questsInMap, #(self.filteredPanelQuests))
				if currentMapId and 0 ~= currentMapId then
					self.cachedMapCounts[currentMapId] = self:_PrettyQuestCountString(questsInMap, nil, nil, true)
				end
			end
		end,

		--	Returns false if the settings say this should not be used
		_FilterQuestsBasedOnSettings = function(self, questId, status, dealingWithHolidays)
			status = status or Grail:StatusCode(questId)
			local WDB = WhollyDatabase
			if not WDB.showsRepeatableQuests and Grail:IsRepeatable(questId) then return false end
			if not WDB.showsDailyQuests and Grail:IsDaily(questId) then return false end
			if not WDB.showsQuestsInLog and 0 < bitband(status, Grail.bitMaskInLog) then return false end
			if not WDB.showsLowLevelQuests and Grail:IsLowLevel(questId) then return false end
			if not WDB.showsHighLevelQuests and bitband(status, Grail.bitMaskLevelTooLow) > 0 then return false end
			if not WDB.showsScenarioQuests and Grail:IsScenario(questId) then return false end
			if not WDB.showsHolidayQuests and not dealingWithHolidays and Grail:CodeHoliday(questId) ~= 0 then return false end
			if not WDB.showsIgnoredQuests and self:_IsIgnoredQuest(questId) then return false end
			if not WDB.showsWeeklyQuests and Grail:IsWeekly(questId) then return false end
			if not WDB.showsUnobtainableQuests and (Grail:IsQuestObsolete(questId) or Grail:IsQuestPending(questId)) then return false end
			if not WDB.showsBonusObjectiveQuests and Grail:IsBonusObjective(questId) then return false end
			if not WDB.showsRareMobQuests and Grail:IsRareMob(questId) then return false end
			if not WDB.showsTreasureQuests and Grail:IsTreasure(questId) then return false end
			if not WDB.showsLegendaryQuests and Grail:IsLegendary(questId) then return false end
			if not WDB.showsPetBattleQuests and Grail:IsPetBattle(questId) then return false end
			if not WDB.showsPVPQuests and Grail:IsPVP(questId) then return false end
			if not WDB.showsWorldQuests and Grail:IsWorldQuest(questId) then return false end
			return true
		end,

		_FilterPanelQuests = function(self)
			self:_FilterQuests(true)
		end,

		_FilterPinQuests = function(self)
			self:_FilterQuests(false)
		end,

		_ForcePanelMapArea = function(self, ignoreForcingSelection)
			local currentMapId = self.zoneInfo.panel.mapId
			local mapAreaName = Grail:MapAreaName(currentMapId) or GetRealZoneText()	-- default to something if we do not support the zone
			if nil ~= mapAreaName then self:_Dropdown_SetText(mapAreaName) end
			self.cachedPanelQuests = self:_ClassifyQuestsInMap(currentMapId) or {}
			self:ScrollFrame_Update_WithCombatCheck()

			if not ignoreForcingSelection then
				local soughtIndex = self.mapToContinentMapping[currentMapId]
				if nil ~= soughtIndex then
					for i, v in pairs(self.levelOneData) do
						if v.index == soughtIndex then
							self:_SetLevelOneCurrent(v)
						elseif nil ~= v.children then
							for j, w in pairs(v.children) do
								if w.index == soughtIndex then
									self:_SetLevelOneCurrent(w)
								end
							end
						end
					end
				else
					self:_SetLevelOneCurrent(nil)
				end
				self:ScrollFrameOne_Update()
				--	Now we create a bogus entry for the level two data
				self:_SetLevelTwoCurrent({ displayName = mapAreaName, mapID = currentMapId })
				self:ScrollFrameTwo_Update()
			end
		end,

		_GetMousePosition = function(self, parentFrame)
			local left, top = parentFrame:GetLeft(), parentFrame:GetTop();
			local width, height = parentFrame:GetWidth(), parentFrame:GetHeight();
			local scale = parentFrame:GetEffectiveScale();

			local x, y = GetCursorPosition();
			local cx = (x/scale - left) / width;
			local cy = (top - y/scale) / height;
	
			return mathmin(mathmax(cx, 0), 1), mathmin(mathmax(cy, 0), 1);
		end,

		-- Blizzard has change API from GetSpellInfo to C_Spell.GetSpellInfo and we use the
		-- proper one here, but just to get the name.
		GetSpellInfo = function(self, spellId)
			if C_Spell and C_Spell.GetSpellInfo then
				local info = C_Spell.GetSpellInfo(spellId)
				if info then
					return info.name
				else
					return nil
				end
			else
				return GetSpellInfo(spellId)
			end
		end,

		_PinSetType = function(pin, texType)
			if pin.texType == texType then return end -- don't need to make changes
			local colorString = WhollyDatabase.color[texType]
			local r = tonumber(strsub(colorString, 3, 4), 16) / 255
			local g = tonumber(strsub(colorString, 5, 6), 16) / 255
			local b = tonumber(strsub(colorString, 7, 8), 16) / 255

			-- WoD beta does not allow custom textures so we go back to the old way
			if not Grail.existsWoD or Grail.blizzardRelease >= 18663 then
				if 'R' == texType or '?' == texType or '*' == texType or '!' == texType then
					pin.texture:SetTexture("Interface\\Addons\\Wholly\\question")
				else
					pin.texture:SetTexture("Interface\\Addons\\Wholly\\exclamation")
				end
				pin.texture:SetVertexColor(r, g, b)
			else
				local width, height = 0.125, 0.125
				pin.texture:SetTexture("Interface\\MINIMAP\\ObjectIcons.blp")
				pin.texture:SetDesaturated(false)
				pin.texture:SetVertexColor(1, 1, 1)
				if texType == "D" then
					pin.texture:SetTexCoord(3*width, 4*width, 1*height, 2*height);
				elseif texType == "R" then
					pin.texture:SetTexCoord(4*width, 5*width, 1*height, 2*height);
				elseif texType == "P" then
					pin.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
					pin.texture:SetVertexColor(1.0, 0.0, 0.0);
				elseif texType == "O" then
					pin.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
					pin.texture:SetVertexColor(1.0, 192/255, 203/255);
				elseif texType == "Y" then
					pin.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
					pin.texture:SetVertexColor(12/15, 6/15, 0.0);
				elseif texType == "H" then
					pin.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
					pin.texture:SetVertexColor(0.0, 0.0, 1.0);
				elseif texType == "W" then
					pin.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
					pin.texture:SetVertexColor(0.75, 0.75, 0.75);
				elseif texType == "L" then
					pin.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
					pin.texture:SetDesaturated(1);
				else
					pin.texture:SetTexCoord(1*width, 2*width, 1*height, 2*height);
				end
			end
			pin.texture:SetAllPoints()
			pin.texType = texType
		end,

		_PinIndex = function(self, x, y, npcId)
			return format("%d:%d:%d", npcId, x, y)
		end,

		RegisterMapPin = function(self, pin, x, y, npcId)
			self.mapPins = self.mapPins or {}
			if nil ~= pin and nil ~= npcId and nil ~= x and nil ~= y then
				self.mapPins[self:_PinIndex(x, y, npcId)] = pin
			end
		end,

		RegisteredMapPin = function(self, x, y, npcId)
			self.mapPins = self.mapPins or {}
			local retval = nil
			if nil ~= npcId and nil ~= x and nil ~= y then
				retval = self.mapPins[self:_PinIndex(x, y, npcId)]
			end
			return retval
		end,

		_RegisterSlashCommand = function(self)
			SlashCmdList["WHOLLY"] = function(msg)
				self:SlashCommand(frame, msg)
			end
			SLASH_WHOLLY1 = "/wholly"
		end,

		UnregisterMapPin = function(self, pin)
			self.mapPins = self.mapPins or {}
			if pin then
				pin:Hide()
				if pin.npcId and pin.xcoord and pin.ycoord then
					self.mapPins[self:_PinIndex(pin.xcoord, pin.ycoord, pin.npcId)] = nil
				end
			end
		end,

		_HideTooltip = function(self)
			self.tooltip:Hide()
		end,

		--	This will return a colored version of the holidayName if it is not celebrating the holiday currently.
		_HolidayName = function(self, holidayName)
			local colorStart, colorEnd = "", ""
			if not Grail:CelebratingHoliday(holidayName) then
				colorStart = "|cff996600"
				colorEnd = "|r"
			end
			return colorStart .. holidayName .. colorEnd, holidayName
		end,

--	Continents						maps to their mapId or mapId + 3000 * level (e.g., Eastern Kingdoms 2 vs. 1)
--		12	Kalimdor
--		13	Eastern Kingdoms
--		101	Outland
--		113	Northrend
--		948	The Maelstrom
--		424	Pandaria
--		572	Draenor
--		619	Broken Isles
--		905	Argus
--		875	Zandalar
--		876	Kul Tiras
--	World Events					-1	was 21
--	Class							-2	was 22
--	Professions						-3	was 23
--	Reputation						-4	was 24
--	>Achievements
--		continents...				13,000 + mapId	was 30 + Grail.continentIndexMapping[mapId]
--		holidays...					15,000 + holiday index	was 40 + holiday index
--		professions...				16,000 + profession index	was 50 + profession index
--		pet battle					17,000	was 74
--		other						17,001	was 60
--	>Reputation Changes				-100 - expansion level (currently 0 through 7)	was 61 through 67 (68)
--		expansions...
--	Followers						-5	was 71
--	Other							-6	was 72
--	Search							-7	was 73
--	Tags							-8	was 75


		--	This routine will populate the data structure self.levelOneData with all of the items
		--	that are supposed to appear in the top-level dropdown or scroller.  Note that some of
		--	the items' appearances are controlled by preferences.
		_InitializeLevelOneData = function(self)
			--	each row will contain a displayName
			--	if the row is a header row, it will contain header (which is an integer so its status can be found in saved variables)
			--		and children which is a table of rows
			--	if the row is not a header row it will contain index (which is an integer used later to populate next level data)

			local WDB = WhollyDatabase
			local entries = {}
			local t1
			self.mapToContinentMapping = {}

			--	Basic continents
			t1 = { displayName = CONTINENT, header = 1, children = {} }
			for mapId, continentTable in pairs(Grail.continents) do
--				local numberEntries = math.floor((#(continentTable.zones) + #(continentTable.dungeons) + self.dropdownLimit - 1) / self.dropdownLimit)
				local numberEntries = math.floor((#(self:_AreasOfInterestInContinent(continentTable)) + self.dropdownLimit - 1) / self.dropdownLimit)
				for counter = 1, numberEntries do
					local addition = (numberEntries > 1) and (" "..counter) or ""
					tinsert(t1.children, { displayName = continentTable.name .. addition, index = mapId + 3000 * (counter - 1) })
				end
			end
			tablesort(t1.children, function(a, b) return a.displayName < b.displayName end)
			tinsert(entries, t1)

			if Grail.capabilities.usesWorldEvents then
				tinsert(entries, { displayName = Wholly.s.WORLD_EVENTS, index = -1 })
			end
			tinsert(entries, { displayName = CLASS, index = -2 })
			tinsert(entries, { displayName = TRADE_SKILLS, index = -3 })		-- Professions
			if not WDB.ignoreReputationQuests then
				tinsert(entries, { displayName = REPUTATION, index = -4 })
			end

			--	Achievements
			if WDB.loadAchievementData and Grail.capabilities.usesAchievements then
				t1 = { displayName = ACHIEVEMENTS, header = 2, children = {} }
				for mapId, continentTable in pairs(Grail.continents) do
					tinsert(t1.children, { displayName = continentTable.name, index = 13000 + mapId })
				end
				tablesort(t1.children, function(a, b) return a.displayName < b.displayName end)
				local i = 0
				if Grail.capabilities.usesWorldEvents then
					if nil ~= Grail.worldEventAchievements and nil ~= Grail.worldEventAchievements[Grail.playerFaction] then
						for holidayKey, _ in pairs(Grail.worldEventAchievements[Grail.playerFaction]) do
							i = i + 1
							tinsert(t1.children, { displayName = Grail.holidayMapping[holidayKey], index = 95000 + i, holidayName = Grail.holidayMapping[holidayKey]})
						end
					end
				end
				i = 0
				if nil ~= Grail.professionAchievements and nil ~= Grail.professionAchievements[Grail.playerFaction] then
					for professionKey, _ in pairs(Grail.professionAchievements[Grail.playerFaction]) do
						i = i + 1
						tinsert(t1.children, { displayName = Grail.professionMapping[professionKey], index = 96000 + i, professionName = Grail.professionMapping[professionKey] })
					end
				end
				tinsert(t1.children, { displayName = BATTLE_PET_SOURCE_5, index = 97000 })
				tinsert(t1.children, { displayName = Wholly.s.OTHER, index = 97001 })
				tinsert(entries, t1)
			end

			--	Reputation Changes
			if WDB.loadReputationData then
				t1 = { displayName = COMBAT_TEXT_SHOW_REPUTATION_TEXT, header = 3, children = {} }
				local highestSupportedExpansion = Grail:_HighestSupportedExpansion()
				for expansionIndex = 0, highestSupportedExpansion do
					local expansionName = Grail:_ExpansionName(expansionIndex)
					if nil ~= expansionName then
						tinsert(t1.children, { displayName = expansionName, index = -100 - expansionIndex })
					else
						break
					end
				end
				tinsert(entries, t1)
			end

			if Grail.capabilities.usesFollowers then
				tinsert(entries, { displayName = Wholly.s.FOLLOWERS, index = -5})
			end
			tinsert(entries, { displayName = Wholly.s.OTHER, index = -6 })
			tinsert(entries, { displayName = SEARCH, index = -7 })
			tinsert(entries, { displayName = Wholly.s.TAGS, index = -8 })

			self.levelOneData = entries			
		end,

		_ShouldAddMapId = function(self, mapId)
			local retval = false
			if WhollyDatabase.displaysEmptyZones or
				(0 < (Grail.indexedQuests[mapId] and #(Grail.indexedQuests[mapId]) or 0)) or
				(0 < (Grail.indexedQuestsExtra[mapId] and #(Grail.indexedQuestsExtra[mapId]) or 0)) then
				retval = true
			end
			return retval
		end,

		_AreasOfInterestInContinent = function(self, continent)
			local t = {}
			local zones = continent.zones
			local dungeonsToAdd = Grail:_TableCopy(continent.dungeons)
			for i = 1, #zones do
				local t1 = {}
				t1.sortName = zones[i].name
				t1.displayName = t1.sortName
				t1.mapID = zones[i].mapID
				Grail:_TableRemove(dungeonsToAdd, t1.mapID)
				if self:_ShouldAddMapId(t1.mapID) then
					tinsert(t, t1)
				end
			end
			for i = 1, #dungeonsToAdd do
				local t1 = {}
				t1.sortName = dungeonsToAdd[i].name
				t1.displayName = t1.sortName
				t1.mapID = dungeonsToAdd[i].mapID
				if self:_ShouldAddMapId(t1.mapID) then
					tinsert(t, t1)
				end
			end
			tablesort(t, function(a, b) return a.sortName < b.sortName end)
			for i = 1, #t do
				self.mapToContinentMapping[t[i].mapID] = continent.mapID + 3000 * (math.floor((i + self.dropdownLimit - 1) / self.dropdownLimit) - 1)
			end
			return t
		end,

		--	This routine will populate the data structure self.levelTwoData with all of the items
		--	that are supposed to appear in the next-level dropdown or scroller based on the level
		--	one selection.
		_InitializeLevelTwoData = function(self)
			local displaysEmptyZones = WhollyDatabase.displaysEmptyZones
			local t = {}
			local which = self.levelOneCurrent and self.levelOneCurrent.index or nil
			if nil == which then self.levelTwoData = t return end
			if which >= 0 and which < 13000 then				-- Basic continent
				t = self:_AreasOfInterestInContinent(Grail.continents[which % 3000])
				--	Now we determine which part of this table we are going to keep based on whether we are offset
				if #t > self.dropdownLimit then
					local offset = math.floor(which / 3000)
					local start = 1 + offset * self.dropdownLimit
					local stop = mathmin(start - 1 + self.dropdownLimit, #t)
					local newT = {}
 					for current = start, stop do
						tinsert(newT, t[current])
					end
					t = newT
				end
--			elseif 20 > which then			-- Dungeons
--				local mapAreas = Grail.continents[Grail.continentMapIds[self.levelOneCurrent.continent]].dungeons
--				for i = 1, #mapAreas do
--					local t1 = {}
--					t1.sortName = Grail:MapAreaName(mapAreas[i]) or "UNKNOWN"
--					t1.displayName = t1.sortName
--					t1.mapID = mapAreas[i]
--					tinsert(t, t1)
--				end
			elseif -1 == which then			-- World Events
				for code, name in pairs(Grail.holidayMapping) do
					local t1 = {}
					t1.sortName = name
					t1.displayName = self:_HolidayName(name)
					t1.mapID = Grail.holidayToMapAreaMapping['H'..code]
					tinsert(t, t1)
				end
			elseif -2 == which then		-- Class
				for code, englishName in pairs(Grail.classMapping) do
					local localizedGenderClassName = Grail:CreateClassNameLocalizedGenderized(englishName)
					local classColor = RAID_CLASS_COLORS[englishName]
					local mapId = Grail.classToMapAreaMapping['C'..code]
					if nil == classColor then
						classColor = { r = 0.0, g = 1.0, b = 150/255 }
						localizedGenderClassName = "Monk"
					end	-- need to do for Monk currently
					if nil ~= Grail:MapAreaName(mapId) then
						local t1 = {}
						t1.sortName = localizedGenderClassName
						t1.displayName = format("|cff%.2x%.2x%.2x%s|r", classColor.r*255, classColor.g*255, classColor.b*255, localizedGenderClassName)
						t1.mapID = mapId
						tinsert(t, t1)
					end
				end
			elseif -3 == which then		-- Professions
				for code, professionName in pairs(Grail.professionMapping) do
					local mapId = Grail.professionToMapAreaMapping['P'..code]
					if nil ~= Grail:MapAreaName(mapId) then
						local t1 = {}
						t1.sortName = professionName
						t1.displayName = professionName
						t1.mapID = mapId
						tinsert(t, t1)
					end
				end
			elseif -4 == which then		-- Reputations
				for reputationIndex, reputationName in pairs(Grail.reputationMapping) do
					local factionId = tonumber(reputationIndex, 16)
					local mapId = Grail.mapAreaBaseReputation + factionId
					if nil ~= Grail:MapAreaName(mapId) then
						local t1 = {}
						t1.sortName = reputationName
						t1.displayName = reputationName
						t1.mapID = mapId
						tinsert(t, t1)
					end
				end
			elseif which >= 13000 and which < 95000 then		-- Continent Achievements
				local mapAreas = Grail.achievements[Grail.playerFaction] and Grail.achievements[Grail.playerFaction][which - 13000] or {}
				for i = 1, #mapAreas do
					local t1 = {}
					t1.sortName = Grail:MapAreaName(mapAreas[i]) or "UNKONWN"
					t1.displayName = self:_AchievementName(mapAreas[i])
					t1.mapID = mapAreas[i]
					tinsert(t, t1)
				end
			elseif which >= 95000 and which < 96000 then		-- Holiday Achievements
				local mapAreas = Grail.worldEventAchievements[Grail.playerFaction] and Grail.worldEventAchievements[Grail.playerFaction][Grail.reverseHolidayMapping[self.levelOneCurrent.holidayName]] or {}
				for i = 1, #mapAreas do
					local t1 = {}
					t1.sortName = Grail:MapAreaName(mapAreas[i]) or "UNKNOWN"
					t1.displayName = self:_AchievementName(mapAreas[i])
					t1.mapID = mapAreas[i]
					tinsert(t, t1)
				end
			elseif which >= 96000 and which < 97000 then		-- Profession Achievements
				local mapAreas = Grail.professionAchievements[Grail.playerFaction] and Grail.professionAchievements[Grail.playerFaction][Grail.reverseProfessionMapping[self.levelOneCurrent.professionName]] or {}
				for i = 1, #mapAreas do
					local t1 = {}
					t1.sortName = Grail:MapAreaName(mapAreas[i]) or "UNKNOWN"
					t1.displayName = self:_AchievementName(mapAreas[i])
					t1.mapID = mapAreas[i]
					tinsert(t, t1)
				end
			elseif 97001 == which then		-- Other Achievements
				-- 5 Dungeon Achievement
				local t1 = {}
				local mapID = Grail.mapAreaBaseAchievement + 4956
				t1.displayName, t1.sortName = self:_AchievementName(mapID)
				t1.mapID = mapID
				tinsert(t, t1)

				-- Just Another Day in Tol Barad Achievement
				t1 = {}
				mapID = Grail.mapAreaBaseAchievement + ("Alliance" == Grail.playerFaction and 5718 or 5719)
				t1.displayName, t1.sortName = self:_AchievementName(mapID)
				t1.mapID = mapID
				tinsert(t, t1)
			elseif which <= -100 then		-- Reputation Changes
				local mapAreas = Grail.reputationExpansionMapping[which * -1 - 99]
				for i = 1, #mapAreas do
					local t1 = {}
					local mapID = Grail.mapAreaBaseReputationChange + mapAreas[i]
					local factionId = Grail:_HexValue(mapAreas[i], 3)
					t1.sortName = Grail.reputationMapping[factionId]
					t1.displayName = t1.sortName
					t1.mapID = mapID
					if nil ~= Grail.indexedQuests[mapID] and 0 ~= #(Grail.indexedQuests[mapID]) then
						tinsert(t, t1)
					end
				end
			elseif -5 == which then		-- Followers
				local followerInfo, qualityLevel
				for questId, followerId in pairs(Grail.followerMapping) do
					if Grail:MeetsRequirementFaction(questId) then
						followerInfo = C_Garrison.GetFollowerInfo(followerId)
						local followerName = followerInfo.name
						qualityLevel = followerInfo.quality
						tinsert(t, { sortName = followerName, displayName = ITEM_QUALITY_COLORS[qualityLevel].hex..followerName.."|r", mapID = 0, f = function() Grail:SetMapAreaQuests(0, followerName, { questId }) Wholly.zoneInfo.panel.mapId = 0 Wholly._ForcePanelMapArea(Wholly, true) CloseDropDownMenus() end })
					end
				end
			elseif -6 == which then		-- Other
				for i = 1, #(Grail.otherMapping) do
					local t1 = {}
					local mapID = Grail.otherMapping[i]
					t1.sortName = Grail:MapAreaName(mapID) or "UNKNOWN"
					t1.displayName = t1.sortName
					t1.mapID = mapID
					tinsert(t, t1)
				end
				local mapAreaID = Grail.mapAreaBaseDaily
				local mapName = Grail:MapAreaName(mapAreaID) or "UNKNOWN"
				tinsert(t, { sortName = mapName, displayName = "|c" .. WhollyDatabase.color['D'] .. mapName .. "|r", mapID = mapAreaID })
				mapAreaID = Grail.mapAreaBaseOther
				mapName = Wholly.s.OTHER
				tinsert(t, { sortName = mapName, displayName = mapName, mapID = mapAreaID })
			elseif -7 == which then		-- Search
				-- We use sortName in a special way because we do not want these items sorted alphabetically
				local lastUsed = 1
				local WDB = WhollyDatabase

				tinsert(t, { sortName = 1, displayName = Wholly.s.SEARCH_NEW, f = function() Wholly._SearchFrameShow(Wholly, nil) Wholly.zoneInfo.panel.mapId = nil Wholly._SetLevelTwoCurrent(Wholly, nil) Wholly._ForcePanelMapArea(Wholly,true) CloseDropDownMenus() end })
				if WDB.searches and 0 < #(WDB.searches) then
					for i = 1, #(WDB.searches) do
						local shouldSelect = (i == #(WDB.searches)) and self.justAddedSearch
						tinsert(t, { sortName = i + 1, displayName = SEARCH .. ': ' .. WDB.searches[i], mapID = 0, selected = shouldSelect, f = function() Wholly.SearchForQuestNamesMatching(Wholly, WDB.searches[i]) Wholly.zoneInfo.panel.mapId = 0 Wholly._ForcePanelMapArea(Wholly, true) CloseDropDownMenus() end })
					end
					lastUsed = #(WDB.searches) + 2
					tinsert(t, { sortName = lastUsed, displayName = Wholly.s.SEARCH_CLEAR, f = function() WDB.searches = nil CloseDropDownMenus() Wholly.zoneInfo.panel.mapId = nil Wholly._SetLevelTwoCurrent(Wholly, nil) Wholly._ForcePanelMapArea(Wholly,true) Wholly.ScrollFrameTwo_Update(Wholly) end })
					self.justAddedSearch = nil
				end
				tinsert(t, { sortName = lastUsed + 1, displayName = Wholly.s.SEARCH_ALL_QUESTS, f = function() Wholly.SearchForAllQuests(Wholly) Wholly.zoneInfo.panel.mapId = 0 Wholly._ForcePanelMapArea(Wholly, true) CloseDropDownMenus() end })
			elseif 97000 == which then		-- Pet Battle achievements
				local mapAreas = Grail.petBattleAchievements[Grail.playerFaction] or {}
				for i = 1, #mapAreas do
					local t1 = {}
					t1.sortName = Grail:MapAreaName(mapAreas[i]) or "UNKNOWN"
					t1.displayName = self:_AchievementName(mapAreas[i])
					t1.mapID = mapAreas[i]
					tinsert(t, t1)
				end
			elseif -8 == which then		-- Tags
				local WDB = WhollyDatabase
				tinsert(t, { sortName = " ", displayName = Wholly.s.TAGS_NEW, f = function() Wholly._SearchFrameShow(Wholly, true) Wholly.zoneInfo.panel.mapId = nil Wholly._SetLevelTwoCurrent(Wholly, nil) Wholly._ForcePanelMapArea(Wholly,true) CloseDropDownMenus() end })
				if WDB.tags then
					for tagName, _ in pairs(WDB.tags) do
						tinsert(t, { sortName = tagName, displayName = Wholly.s.TAGS .. ': ' .. tagName, mapID = 0, f = function() Wholly.SearchForQuestsWithTag(Wholly, tagName) Wholly.zoneInfo.panel.mapId = 0 Wholly._ForcePanelMapArea(Wholly, true) CloseDropDownMenus() end })
					end
					tinsert(t, { sortName = "  ", displayName = Wholly.s.TAGS_DELETE, f = function() Wholly._TagDelete(Wholly) Wholly.zoneInfo.panel.mapId = nil Wholly._SetLevelTwoCurrent(Wholly, nil) Wholly._ForcePanelMapArea(Wholly,true) end })
				end
			end
			if nil ~= t and #t > 1 then
				tablesort(t, function(a, b) return a.sortName < b.sortName end)
			end

			-- We want to make sure we retain the proper selection
			if nil ~= self.levelTwoCurrent then
				for i, v in pairs(t) do
--					if v.displayName == self.levelTwoCurrent.displayName and v.mapID == self.levelTwoCurrent.mapID then
					if v.mapID == self.levelTwoCurrent.mapID then
						v.selected = true
					end
				end
			end
			self.levelTwoData = t
			self.lastWhich = which
		end,

		--	Starting in Blizzard's 5.4 release the SECURE_ACTIONS.click routine now calls IsForbidden() on the delegate
		--	without first seeing if the delegate implements it.  Of course since Wholly did not implement it and is
		--	considered the delegate as it is the "clickbutton" attribute, Lua errors would happen for clicks.  Now it
		--	is implemented.
		IsForbidden = function(self)
			return false
		end,

		_IsIgnoredQuest = function(self, questId)
			return Grail:_IsQuestMarkedInDatabase(questId, WhollyDatabase.ignoredQuests)
		end,

		_LoadDefaults = function(self)
			local db = {}
			db.defaultsLoaded = true
			db.prependsQuestLevel = true
			db.appendRequiredLevel = true
			db.showsLowLevelQuests = true
			db.showsAnyPreviousRepeatableCompletions = true
			db.updatesPanelWhenZoneChanges = true
			db.displaysMapPins = true
			db.displaysMapFrame = true
			db.displaysDungeonQuests = true
			db.displaysBreadcrumbs = true
			db.displaysBreadcrumbMessages = false
			db.displaysHolidaysAlways = true
			db.updatesWorldMapOnZoneChange = true
			db.showsInLogQuestStatus = true
			db.showsAchievementCompletionColors = true
			db.loadAchievementData = true
			db.loadReputationData = true
			db.showsHolidayQuests = true
			db.showsWeeklyQuests = true
			db.showsLegendaryQuests = true
			db.showsPetBattleQuests = true
			db.showsPVPQuests = true
			db.showsWorldQuests = true
			db.loadDateData = true
			db.displaysMapPinsTurnin = true
			db.displaysMapPinsTurninIncomplete = false
			db.version = Wholly.versionNumber
			WhollyDatabase = db
			return db
		end,

		_NPCInfoSectionCore = function(self, heading, table, button, meetsCriteria, processingPrerequisites)
			if nil == table then return end
			self:_AddLine(" ")
			self:_AddLine(heading)
			for first, second in pairs(table) do
				local npcId = processingPrerequisites and first or second
				local locations = Grail:NPCLocations(npcId)
				if nil ~= locations then
					for _, npc in pairs(locations) do
						local locationString = npc.mapArea and Grail:MapAreaName(npc.mapArea) or ""
						if npc.near then
							locationString = locationString .. ' ' .. self.s.NEAR
						elseif npc.mailbox then
							locationString = locationString .. ' ' .. self.s.MAILBOX
						elseif npc.created then
							locationString = locationString .. ' ' .. self.s.CREATED_ITEMS
						elseif nil ~= npc.x then
							locationString = locationString .. strformat(' %.2f, %.2f', npc.x, npc.y)
						end
						local rawNameToUse = Grail:NPCName(npc.id) or "**"
						local nameToUse = rawNameToUse
						if npc.dropId then
							nameToUse = nameToUse .. " (" .. Grail:NPCName(npc.dropId) .. ')'
						end
						local prettiness = self:_PrettyNPCString(nameToUse, npc.kill, npc.realArea)
						-- Check to ensure the NPC is available for this player
						local soughtFactionCode = 'A'
						if 'Horde' == Grail.playerFaction then
							soughtFactionCode = 'H'
						end
						local factionCode = Grail:_NPCFaction(npcId)
						if nil ~= factionCode and soughtFactionCode ~= factionCode then
							-- We need to turn the NPC red because the player cannot access this
							prettiness = "|cffff0000" .. prettiness .. "|r"
						end
						if processingPrerequisites then
							self:_QuestInfoSection({prettiness, locationString}, second)
						else
							self:_AddLine(prettiness, locationString)
						end
						local comment = Grail:NPCComment(npcId)
						if nil ~= comment then
							self:_AddLine(" ", comment)
						end
						if meetsCriteria then
							local desiredMacroValue = self.s.SLASH_TARGET .. ' ' .. rawNameToUse
							if button:GetAttribute("macrotext") ~= desiredMacroValue and not InCombatLockdown() then
								button:SetAttribute("macrotext", desiredMacroValue)
							end
						end
					end
				end
			end
		end,

		_NPCInfoSection = function(self, heading, table, button, meetsCriteria)
			self:_NPCInfoSectionCore(heading, table, button, meetsCriteria)
		end,

		_NPCInfoSectionPrerequisites = function(self, heading, table, button, meetsCriteria)
			self:_NPCInfoSectionCore(heading, table, button, meetsCriteria, true)
		end,

		_OnEnterBlizzardQuestButton = function(blizzardQuestButton)
			if WhollyDatabase.displaysBlizzardQuestTooltips then
				local frame = blizzardQuestButton
				local questId = blizzardQuestButton.questID
				-- Prior to BfA beta 26567 this check and reassigning of questId was not needed.
				-- Now in 26610 it is not needed anymore.
--				if Grail.battleForAzeroth then
--					local questTitle, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, theQuestId, startEvent = Grail:GetQuestLogTitle(blizzardQuestButton.questLogIndex)
--					questId = theQuestId
--				end
				if Grail.existsClassic then
					local questLogIndex = blizzardQuestButton:GetID() + FauxScrollFrame_GetOffset(QuestLogListScrollFrame)
					local questTitle, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, theQuestId, startEvent = Grail:GetQuestLogTitle(questLogIndex)
					questId = theQuestId
					frame = not isHeader and blizzardQuestButton or nil
				end
				if nil ~= frame then
					Wholly.onlyAddingTooltipToGameTooltip = not Grail.existsClassic
					Wholly:_PopulateTooltipForQuest(frame, questId)
					Wholly.onlyAddingTooltipToGameTooltip = false
					GameTooltip:Show()
				end
			end
		end,

		_OnEvent = function(self, frame, event, ...)
			if self.eventDispatch[event] then
				self.eventDispatch[event](self, frame, ...)
			end
		end,

		OnHide = function(self, frame)
		end,

		OnLoad = function(self, frame)
		end,

		---
		--	The first time the panel is shown it is populated with the information from the current map area.
		OnShow = function(self, frame)
			self:_ProcessInitialUpdate()
			if nil == self.dropdown and self.currentFrame == com_mithrandir_whollyFrame then
				self:_Dropdown_Create()
				local mapAreaName = GRAIL:MapAreaName(self.zoneInfo.panel.mapId) or GetRealZoneText()	-- default to something if we do not support the zone
				if nil ~= mapAreaName then self:_Dropdown_SetText(mapAreaName) end
			end
			if WhollyDatabase.showsInLogQuestStatus then
				self:ScrollFrame_Update_WithCombatCheck()
			end
			self:ScrollFrameOne_Update()
			self:ScrollFrameTwo_Update()
		end,

		_OnUpdate = function(self, frame, elapsed)
			self.lastUpdate = self.lastUpdate + elapsed
			if self.lastUpdate < self.updateThreshold then return end
			local x, y = Grail.GetPlayerMapPosition('player')
			if x and y and (self.previousX ~= x or self.previousY ~= y) then
				if nil ~= self.coordinates then
					self.coordinates.text = strformat("%.2f, %.2f", x * 100, y * 100)
				end
				self.previousX = x
				self.previousY = y
			end
			self.lastUpdate = 0
		end,

		--	For some odd reason, if the options have never been opened they will default to opening to a Blizzard
		--	option and not the desired one.  So a brutal workaround is to call it twice, which seems to do the job.
		_OpenInterfaceOptions = function(self)
			if InterfaceOptionsFrame_OpenToCategory then
				InterfaceOptionsFrame_OpenToCategory("Wholly")
				InterfaceOptionsFrame_OpenToCategory("Wholly")
			else
				Settings.OpenToCategory(Wholly.settingsCategory.ID)
			end
		end,

		_PresentTooltipForBlizzardQuest = function(self, blizzardQuestButton)
			local questIndex = blizzardQuestButton:GetID()
			local questTitle, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questId, startEvent = Grail:GetQuestLogTitle(questIndex)
			if not isHeader then
				self:_PopulateTooltipForQuest(blizzardQuestButton, questId)
				for i = 1, self.currentTt do
					self.tt[i]:Show()
				end
			end
		end,

		_PrettyNPCString = function(self, npcName, mustKill, realAreaId)
			if mustKill then npcName = format(self.s.MUST_KILL_PIN_FORMAT, npcName) end
			if realAreaId then npcName = format("%s => %s", npcName, GRAIL:MapAreaName(realAreaId) or "UNKNOWN") end
			return npcName
		end,

		_PrettyQuestCountString = function(self, questTable, displayedCount, forMap, abbreviated)
			local WDB = WhollyDatabase
			local retval = ""
			local codesToUse = abbreviated and { 'G', 'W', 'L', 'Y', } or { 'G', 'W', 'L', 'Y', 'P', 'D', 'K', 'R', 'H', 'I', 'C', 'B', 'O', }
			local lastCode = abbreviated and 'P' or 'U'
			displayedCount = displayedCount or 0
			if nil ~= questTable then
				local totals = { ['B'] = 0, ['C'] = 0, ['D'] = 0, ['G'] = 0, ['H'] = 0, ['I'] = 0, ['K'] = 0, ['L'] = 0, ['O'] = 0, ['P'] = 0, ['R'] = 0, ['U'] = 0, ['W'] = 0, ['Y'] = 0, }
				local code
				for i = 1, #questTable do
					code = questTable[i][2]
					totals[code] = totals[code] + 1
				end
				local colorCode
				for _,code in pairs(codesToUse) do
					colorCode = WDB.color[code]
					retval = retval .. "|c" .. colorCode .. totals[code] .. "|r/"
				end
				local displayStart, displayEnd = "", ""
				if forMap and not WhollyDatabase.displaysMapPins then
					displayStart, displayEnd = "|cffff0000", "|r"
				end
				retval = retval .. "|c" .. WDB.color[lastCode] .. totals[lastCode] .. "|r"
				if not abbreviated then
					retval = retval .. "  [" .. displayStart .. displayedCount .. displayEnd .. "/" .. #questTable .."]"
				end
			end
			return retval
		end,

		_PrettyQuestString = function(self, questTable)
			local WDB = WhollyDatabase
			local questId = questTable[1]
			local questCode, subcode, numeric = GRAIL:CodeParts(questId)
			local filterCode = questTable[2]
			local colorCode = WDB.color[filterCode]
			if questCode == 'I' or questCode == 'i' then
				local name = self:GetSpellInfo(numeric)
				local negateString = (questCode == 'i') and "!" or ""
				return format("|c%s%s|r %s[%s]", colorCode, name, negateString, self.s.SPELLS)
			elseif questCode == 'F' then
				return format("|c%s%s|r [%s]", colorCode, subcode == 'A' and self.s.ALLIANCE or self.s.HORDE, self.s.FACTION)
			elseif questCode == 'W' then
				local questTable = GRAIL.questStatusCache['G'][subcode] or {}
				return format("|c%s%d|r/%d", colorCode, numeric, #(questTable))
			elseif questCode == 'V' then
				local questTable = GRAIL.questStatusCache['G'][subcode] or {}
				return format("|c%s%d|r/%d [%s]", colorCode, numeric, #(questTable), self.s.ACCEPTED)
			elseif questCode == 'w' then
				local questTable = GRAIL.questStatusCache['G'][subcode] or {}
				return format("|c%s%d|r/%d [%s, %s]", colorCode, numeric, #(questTable), self.s.COMPLETE, self.s.TURNED_IN)
			elseif questCode == 'r' then
				local questTable = GRAIL.questStatusCache['G'][subcode] or {}
				return format("|c%s%d|r/%d [%s, %s]", colorCode, numeric, #(questTable), self.s.IN_LOG, self.s.TURNED_IN)
			elseif questCode == 't' or questCode == 'T' or questCode == 'u' or questCode == 'U' then
				if ('t' == questCode or 'u' == questCode) and 'P' == filterCode then colorCode = WDB.color.B end
				return format("|c%s%s|r [%s]", colorCode, GRAIL.reputationMapping[subcode], self.s.REPUTATION_REQUIRED)
			elseif questCode == 'Z' then
				local name = self:GetSpellInfo(numeric)
				return format("|c%s%s|r [%s]", colorCode, name, self.s.EVER_CAST)
			elseif questCode == 'J' or questCode == 'j' then
				local name = Grail:GetBasicAchievementInfo(numeric)
				local negateString = (questCode == 'j') and "!" or ""
				return format("|c%s%s|r %s[%s]", colorCode, name, negateString, self.s.ACHIEVEMENTS)
			elseif questCode == 'Y' or questCode == 'y' then
				local name = Grail:GetBasicAchievementInfo(numeric, true)
				local negateString = (questCode == 'y') and "!" or ""
				return format("|c%s%s|r %s[%s][%s]", colorCode, name, negateString, self.s.ACHIEVEMENTS, self.s.PLAYER)
			elseif questCode == 'K' or questCode == 'k' then
				local name = GRAIL:NPCName(numeric)
				local itemString = (questCode == 'k') and self.s.ITEM_LACK or self.s.ITEM
				local count = tonumber(subcode)
				local countString = count and "("..count..") " or ""
				return format("|c%s%s|r %s[%s]", colorCode, name, countString, itemString)
			elseif questCode == 'L' or questCode == 'l' then
				local lessThanString = (questCode == 'l') and "<" or ""
				return format("|c%s%s %s%d|r", colorCode, self.s.LEVEL, lessThanString, numeric)
			elseif questCode == 'N' or questCode == 'n' then
				local englishName = Grail.classMapping[subcode]
				local localizedGenderClassName = Grail:CreateClassNameLocalizedGenderized(englishName)
				local classColor = RAID_CLASS_COLORS[englishName]
				local notString = questCode == 'n' and "!" or ""
				return format("|c%s%s |r|cff%.2x%.2x%.2x%s%s|r", colorCode, CLASS, classColor.r*255, classColor.g*255, classColor.b*255, notString, localizedGenderClassName)
			elseif questCode == 'P' then
				local meetsRequirement, actualSkillLevel = GRAIL:ProfessionExceeds(subcode, numeric)
				local levelCode
				if meetsRequirement then
					colorCode = WDB.color['C']
					levelCode = WDB.color['C']
				elseif actualSkillLevel ~= GRAIL.NO_SKILL then
					colorCode = WDB.color['C']
					levelCode = WDB.color['P']
				else
					colorCode = WDB.color['P']
					levelCode = WDB.color['P']
				end
				return format("|c%s%s|r |c%s%d|r [%s]", colorCode, GRAIL.professionMapping[subcode], levelCode, numeric, self.s.PROFESSIONS)
			elseif questCode == 'Q' or questCode == 'q' then
				local comparison = questCode == 'Q' and ">=" or '<'
				return format("|c%s%s %s %s|r", colorCode, self.s.CURRENTLY_EQUIPPED, comparison, self.s.ILEVEL)
			elseif questCode == 'R' then
				local name = self:GetSpellInfo(numeric)
				return format("|c%s%s|r [%s]", colorCode, name, self.s.EVER_EXPERIENCED)
			elseif questCode == 'S' or questCode == 's' then
				local skillName
				if numeric > 200000000 then
					skillName = GRAIL:NPCName(numeric)
				else
					skillName = self:GetSpellInfo(numeric)
				end
				local negateString = (questCode == 's') and "!" or ""
				return format("|c%s%s|r %s[%s]", colorCode, skillName, negateString, self.s.SKILL)
			elseif questCode == 'G' then
				local positive = (numeric < 0) and numeric * -1 or numeric
				local id, buildingName = C_Garrison.GetBuildingInfo(positive)
				local requiredPlotString = ''
				if '' ~= subcode then
					requiredPlotString = " " .. self.s.PLOT .. " " .. subcode
				end
				return format("|c%s%s%s|r [%s]", colorCode, buildingName, requiredPlotString, self.s.BUILDING)
			elseif questCode == 'z' then
				local positive = (numeric < 0) and numeric * -1 or numeric
				local id, buildingName = C_Garrison.GetBuildingInfo(positive)
				return format("|c%s%s - %s|r [%s]", colorCode, buildingName, GARRISON_FOLLOWER_WORKING, self.s.BUILDING)
			elseif questCode == '=' or questCode == '<' or questCode == '>' then
				local phaseLocation = GRAIL:MapAreaName(subcode) or "UNKNOWN"
				local phaseString = format(self.s.STAGE_FORMAT, numeric)
				return format("|c%s%s %s [%s]|r", colorCode, phaseLocation, questCode, phaseString)
			elseif questCode == 'x' then
				return format("|c%s"..ARTIFACTS_KNOWLEDGE_TOOLTIP_LEVEL.."|r", colorCode, numeric)
			elseif questCode == 'a' or questCode == 'b' or questCode == '^' then
				return format("|c%s"..AVAILABLE_QUEST.."|r", colorCode)
			elseif questCode == '@' then
				return format("|c%s%s %s %d|r", colorCode, GRAIL:NPCName(100000000 + subcode), self.s.LEVEL, numeric)
			elseif questCode == '#' then
				return format(GARRISON_MISSION_TIME, format("|c%s%s|r", colorCode, GRAIL:MissionName(numeric) or numeric))
--				return format("Mission Needed: |c%s%s|r", colorCode, GRAIL:MissionName(numeric))	-- GARRISON_MISSION_TIME
			elseif questCode == '&' then
				local message = format(REQUIRES_AZERITE_LEVEL_TOOLTIP, numeric)
				return format("|c%s%s|r", colorCode, message)
			elseif questCode == '$' or questCode == '*' then
				local covenantNameToDisplay = (0 == subcode) and "" or C_Covenants.GetCovenantData(subcode).name or "???"
				local comparisonToDisplay = (questCode == '*') and " <" or ""
				return format("|c%s%s - %s%s|r", colorCode, LANDING_PAGE_RENOWN_LABEL, covenantNameToDisplay, comparisonToDisplay, numeric)
			elseif questCode == '%' then
				return format("|c%s%s|r", colorCode, self:_QuestName(400000 + numeric))
			elseif questCode == '(' then
				local todayResetDate = C_DateAndTime.AdjustTimeByMinutes(C_DateAndTime.GetCurrentCalendarTime(), (C_DateAndTime.GetSecondsUntilDailyReset() - (86400 * 1)) / 60)
				local presentableDate = strformat("%4d-%02d-%02d %02d:%02d", todayResetDate.year, todayResetDate.monthDay, todayResetDate.day, todayResetDate.hour, todayResetDate.minute)
				local completedColorCode = GRAIL:IsQuestCompleted(numeric) and WDB.color['C'] or WDB.color['P']
				return format("|c%s%s |r|c%s< %s|r", completedColorCode, self:_QuestName(numeric), colorCode, presentableDate)
			elseif questCode == ')' then
				local currencyName, currentAmount = GRAIL:GetCurrencyInfo(subcode)
				return format("|c%s%s|r", colorCode, currencyName)
			elseif questCode == '_' or questCode == '~' then
				local extra = questCode == '~' and " [" .. Grail.accountUnlock .. "]" or ""
				return format("|c%s%s%s - %s|r", colorCode, LANDING_PAGE_RENOWN_LABEL, extra, GRAIL.reputationMapping[subcode])
			elseif questCode == '`' then
				local mapId = tonumber(subcode)
				local poiId = tonumber(numeric)
				if mapId and poiId and C_AreaPoiInfo and C_AreaPoiInfo.GetAreaPOIInfo then
					local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapId, poiId)
					local nameToUse
					if poiInfo then
						nameToUse = poiInfo.name
					else
						nameToUse = self:_QuestName(100000000 + mapId * 10000 + poiId)
					end
					return format("|c%s%s - %s|r", colorCode, MINIMAP_TRACKING_POI, nameToUse)	-- "Points of Interest"
				end
				return format("|c%sPOI ERROR|r", colorCode)
			else
				questId = numeric
				local typeString = ""
				local WDB = WhollyDatabase
				if questCode == 'B' then
					typeString = format(" [%s]", self.s.IN_LOG)
				elseif questCode == 'C' then
					typeString = format(" [%s, %s]", self.s.IN_LOG, self.s.TURNED_IN)
				elseif questCode == 'c' then
					typeString = format(" ![%s, %s]", self.s.IN_LOG, self.s.TURNED_IN)
				elseif questCode == 'D' then
					typeString = format(" [%s]", self.s.COMPLETE)
				elseif questCode == 'e' then
					typeString = format(" ![%s, %s]", self.s.COMPLETE, self.s.TURNED_IN)
				elseif questCode == 'E' then
					typeString = format(" [%s, %s]", self.s.COMPLETE, self.s.TURNED_IN)
				elseif questCode == 'H' then
					typeString = format(" [%s]", self.s.EVER_COMPLETED)
				elseif questCode == 'h' then
					typeString = format(" ![%s]", self.s.EVER_COMPLETED)
				elseif questCode == 'M' then
					typeString = format(" [%s]", self.s.ABANDONED)
				elseif questCode == 'm' then
					typeString = format(" [%s]", self.s.NEVER_ABANDONED)
				elseif questCode == 'O' then
					typeString = format(" [%s]", self.s.ACCEPTED)
				elseif questCode == 'X' then
					typeString = format(" ![%s]", self.s.TURNED_IN)
				end
				local statusCode = GRAIL:StatusCode(questId)
				local questLevel = GRAIL:QuestLevelString(questId)
				local questLevelString = WDB.prependsQuestLevel and questLevel ~= "" and format("[%s] ", questLevel or "??") or ""
				local requiredLevelString = ""
				if WDB.appendRequiredLevel then
					local success, _, questLevelNeeded, _ = GRAIL:MeetsRequirementLevel(questId)
					if bitband(statusCode, GRAIL.bitMaskLevelTooLow) > 0 then requiredLevelString = format(" [%s]", questLevelNeeded) end
				end
				local repeatableCompletedString = WDB.showsAnyPreviousRepeatableCompletions and bitband(statusCode, GRAIL.bitMaskResettableRepeatableCompleted) > 0 and "*" or ""
				return format("|c%s%s%s%s%s|r%s", colorCode, questLevelString, self:_QuestName(questId), repeatableCompletedString, requiredLevelString, typeString)
			end
		end,

		_ProcessInitialUpdate = function(self)
			if not self.initialUpdateProcessed then
				self.zoneInfo.panel.mapId = self.zoneInfo.zone.mapId
				self:_ForcePanelMapArea()
				self.initialUpdateProcessed = true
			end
		end,

		_PopulateTooltipForQuest = function(self, frame, questId, aliasQuestId)
			local Grail = Grail
			self.currentTt = 1
			questId = tonumber(questId)
			if not self.onlyAddingTooltipToGameTooltip then
				self.tt[1]:SetOwner(frame, "ANCHOR_RIGHT")
				self.tt[1]:ClearLines()
			end
			if nil == questId then return end
			if not self.onlyAddingTooltipToGameTooltip then
				if not Grail.existsClassic then
					self.tt[1]:SetHyperlink(format("quest:%d", questId))
				else
					self:_AddLine(self:_QuestName(questId))
					local description = Grail.quest.description[questId]
					if nil ~= description then
						description = description:gsub("$B", "\n")
						self:_AddLine(" ")
						self:_AddLine(description, nil, nil, true)
					end
				end
			end
			if not Grail:DoesQuestExist(questId) then self:_AddLine(" ") self:_AddLine(self.s.GRAIL_NOT_HAVE) return end

			local bugged = Grail:IsBugged(questId)
			if bugged then
				self:_AddLine(" ")
				self:_AddLine(self.s.BUGGED)
				self:_AddLine(bugged)
			end

			local obsolete = Grail:IsQuestObsolete(questId)
			if obsolete then
				self:_AddLine(" ")
				self:_AddLine("|cffff0000"..self.s.UNAVAILABLE.." ("..self.s.REMOVED..")|r", obsolete)
			end

			local pending = Grail:IsQuestPending(questId)
			if pending then
				self:_AddLine(" ")
				self:_AddLine("|cffff0000"..self.s.UNAVAILABLE.." ("..self.s.PENDING..")|r", pending)
			end

			if self.debug then
				self:_AddLine(" ")
				local aliasQuestString = aliasQuestId and " ("..aliasQuestId..")" or ""
				self:_AddLine(self.s.QUEST_ID ..questId..aliasQuestString)
			end

			local GWP = GrailWhenPlayer
			if nil ~= GWP then
				local when = GWP['when'][questId]
				if nil == when then
					if Grail:IsQuestCompleted(questId) or Grail:HasQuestEverBeenCompleted(questId) then
						when = self.s.TIME_UNKNOWN
					end
				end
				if nil ~= when then
					self:_AddLine(" ")
					when = "|cff00ff00" .. when .. "|r"
					local count = GWP['count'][questId]
					self:_AddLine(strformat(self.s.COMPLETED_FORMAT, when), count)
				end
			end

			questId = aliasQuestId or questId	-- remap to the alias now that the Blizzard interaction is done
			if GetQuestExpansion then
				self:_AddLine(EXPANSION_FILTER_TEXT, Grail:_ExpansionName(GetQuestExpansion(questId)))
			end
			local obtainersCode = Grail:CodeObtainers(questId)
			local obtainersRaceCode = Grail:CodeObtainersRace(questId)
			local holidayCode = Grail:CodeHoliday(questId)
			local questLevel = Grail:QuestLevelString(questId)
			local _, _, requiredLevel, notToExceedLevel = Grail:MeetsRequirementLevel(questId)
			local questType = self:_QuestTypeString(questId)
			local statusCode = Grail:StatusCode(questId)
			local normalColor, redColor, orangeColor, greenColor = "ffffd200", "ffff0000", "ffff9900", "ff00ff00"
			local colorCode

			self:_AddLine(" ")
			if questLevel ~= "" then
				self:_AddLine(LEVEL, questLevel)
			end
			self:_AddLine(self.s.REQUIRED_LEVEL, requiredLevel)
			if bitband(statusCode, Grail.bitMaskLevelTooHigh) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorLevelTooHigh) > 0 then colorCode = orangeColor else colorCode = normalColor end
			self:_AddLine("|c"..colorCode..self.s.MAX_LEVEL.."|r", (notToExceedLevel * Grail.bitMaskQuestMaxLevelOffset == Grail.bitMaskQuestMaxLevel) and self.s.MAXIMUM_LEVEL_NONE or notToExceedLevel)

			if "" == questType then questType = self.s.QUEST_TYPE_NORMAL end
			self:_AddLine(TYPE, trim(questType))

			local loremasterString = self.s.MAPAREA_NONE
			local loremasterMapArea = Grail:LoremasterMapArea(questId)
			if nil ~= loremasterMapArea then loremasterString = Grail:MapAreaName(loremasterMapArea) or "UNKNOWN" end
			self:_AddLine(self.s.LOREMASTER_AREA, loremasterString)

			self:_AddLine(" ")
			local factionString = FACTION_OTHER
			if Grail.bitMaskFactionAll == bitband(obtainersCode, Grail.bitMaskFactionAll) then
				factionString = self.s.FACTION_BOTH
			elseif 0 < bitband(obtainersCode, Grail.bitMaskFactionAlliance) then
				factionString = self.s.ALLIANCE
			elseif 0 < bitband(obtainersCode, Grail.bitMaskFactionHorde) then
				factionString = self.s.HORDE
			end
			if bitband(statusCode, Grail.bitMaskFaction) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorFaction) > 0 then colorCode = orangeColor else colorCode = normalColor end
			self:_AddLine("|c"..colorCode..self.s.FACTION.."|r", factionString)

			local classString
			if 0 == bitband(obtainersCode, Grail.bitMaskClassAll) then
				classString = self.s.CLASS_NONE
			elseif Grail.bitMaskClassAll == bitband(obtainersCode, Grail.bitMaskClassAll) then
				classString = self.s.CLASS_ANY
			else
				classString = ""
				for letterCode, bitValue in pairs(Grail.classToBitMapping) do
					if 0 < bitband(obtainersCode, bitValue) then
						local englishName = Grail.classMapping[letterCode]
						local localizedGenderClassName = Grail:CreateClassNameLocalizedGenderized(englishName)
						local classColor = RAID_CLASS_COLORS[englishName]
						if nil ~= localizedGenderClassName and nil ~= classColor then
							classString = classString .. format("|cff%.2x%.2x%.2x%s|r ", classColor.r*255, classColor.g*255, classColor.b*255, localizedGenderClassName)
						end
					end
				end
				classString = trim(classString)
			end
			if bitband(statusCode, Grail.bitMaskClass) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorClass) > 0 then colorCode = orangeColor else colorCode = normalColor end
			self:_AddLine("|c"..colorCode..CLASS.."|r", classString)

			local genderString = self.s.GENDER_NONE
			if Grail.bitMaskGenderAll == bitband(obtainersCode, Grail.bitMaskGenderAll) then
				genderString = self.s.GENDER_BOTH
			elseif 0 < bitband(obtainersCode, Grail.bitMaskGenderMale) then
				genderString = self.s.MALE
			elseif 0 < bitband(obtainersCode, Grail.bitMaskGenderFemale) then
				genderString = self.s.FEMALE
			end
			if bitband(statusCode, Grail.bitMaskGender) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorGender) > 0 then colorCode = orangeColor else colorCode = normalColor end
			self:_AddLine("|c"..colorCode..self.s.GENDER .."|r", genderString)

			-- Note that race can show races of any faction, especially if the quest is marked just to exclude a specific race
			local raceString
			if 0 == bitband(obtainersRaceCode, Grail.bitMaskRaceAll) then
				raceString = self.s.RACE_NONE
			elseif Grail.bitMaskRaceAll == bitband(obtainersRaceCode, Grail.bitMaskRaceAll) then
				raceString = self.s.RACE_ANY
			else
				raceString = ""
				for letterCode, raceTable in pairs(Grail.races) do
					local bitValue = raceTable[4]
					if 0 < bitband(obtainersRaceCode, bitValue) then
						local englishName = Grail.races[letterCode][1]
						local localizedGenderRaceName = Grail:CreateRaceNameLocalizedGenderized(englishName)
						raceString = raceString .. localizedGenderRaceName .. " "
					end
				end
				raceString = trim(raceString)
			end
			if bitband(statusCode, Grail.bitMaskRace) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorRace) > 0 then colorCode = orangeColor else colorCode = normalColor end
			self:_AddLine("|c"..colorCode..RACES.."|r", raceString)

			if 0 ~= holidayCode then
				self:_AddLine(" ")
				if bitband(statusCode, Grail.bitMaskHoliday) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorHoliday) > 0 then colorCode = orangeColor else colorCode = normalColor end
				self:_AddLine("|c"..colorCode..self.s.HOLIDAYS_ONLY.."|r")
				for letterCode, bitValue in pairs(Grail.holidayToBitMapping) do
					if 0 < bitband(holidayCode, bitValue) then
						self:_AddLine(Grail.holidayMapping[letterCode])
					end
				end
			end

			if bitband(Grail:CodeType(questId), Grail.bitMaskQuestSpecial) > 0 then
				self:_AddLine(" ")
				self:_AddLine(self.s.SP_MESSAGE)
			end

			if nil ~= questId and nil ~= Grail.quests[questId] and nil ~= Grail.quests[questId]['rep'] then
				self:_AddLine(" ")
				if bitband(statusCode, Grail.bitMaskReputation) > 0 then colorCode = redColor elseif bitband(statusCode, Grail.bitMaskAncestorReputation) > 0 then colorCode = orangeColor else colorCode = normalColor end
				self:_AddLine("|c"..colorCode..self.s.REPUTATION_REQUIRED.."|r")
				for reputationIndex, repTable in pairs(Grail.quests[questId]['rep']) do
					-- repTable can have 'min' and/or 'max'
					local repValue = repTable['min']
					local reputationString
					if nil ~= repValue then
						local _, reputationLevelName = Grail:ReputationNameAndLevelName(reputationIndex, repValue)
						if nil ~= reputationLevelName then
							local exceeds, earnedValue = Grail:_ReputationExceeds(Grail.reputationMapping[reputationIndex], repValue)
							reputationString = format(exceeds and "|cFF00FF00%s|r" or "|cFFFF0000%s|r", reputationLevelName)
							self:_AddLine(Grail.reputationMapping[reputationIndex], reputationString)
						end
					end
					repValue = repTable['max']
					if nil ~= repValue then
						local _, reputationLevelName = Grail:ReputationNameAndLevelName(reputationIndex, repValue)
						if nil ~= reputationLevelName then
							local exceeds, earnedValue = Grail:_ReputationExceeds(Grail.reputationMapping[reputationIndex], repValue)
							reputationString = format(not exceeds and "|cFF00FF00< %s|r" or "|cFFFF0000< %s|r", reputationLevelName)
							self:_AddLine(Grail.reputationMapping[reputationIndex], reputationString)
						end
					end
				end
			end

			-- Just give an indication that there is a Professions failure, but the user will need to look at prerequisites to see which professions.
			if bitband(statusCode, Grail.bitMaskProfession + Grail.bitMaskAncestorProfession) > 0 then
				self:_AddLine(" ")
				if bitband(statusCode, Grail.bitMaskProfession) > 0 then
					colorCode = redColor
				else
					colorCode = orangeColor
				end
				self:_AddLine("|c"..colorCode..self.s.PROFESSIONS..':'.."|r")
			end

			self:_QuestInfoSection(self.s.BREADCRUMB, Grail:QuestBreadcrumbs(questId))

--	At the moment the UI will show both invalidated and breadcrumb invalidated ancestors as orange.
			local breadcrumbColorCode
			if bitband(statusCode, Grail.bitMaskInvalidated) > 0 then
				if Grail:IsInvalidated(questId, true) then	-- still invalid ignoring breadcrumbs
					colorCode = redColor
					breadcrumbColorCode = normalColor
				else
					colorCode = normalColor
					breadcrumbColorCode = redColor
				end
			elseif bitband(statusCode, Grail.bitMaskAncestorInvalidated) > 0 then
				colorCode = orangeColor
				breadcrumbColorCode = orangeColor
			else
				breadcrumbColorCode = normalColor
				colorCode = normalColor
			end
			self:_QuestInfoSection("|c"..breadcrumbColorCode..self.s.IS_BREADCRUMB.."|r", Grail:QuestBreadcrumbsFor(questId))
			self:_QuestInfoSection("|c"..colorCode..self.s.INVALIDATE.."|r", Grail:QuestInvalidates(questId))

			local lastIndexUsed = 0
			if Grail.DisplayableQuestPrerequisites then
				lastIndexUsed = self:_QuestInfoSection(self.s.PREREQUISITES, Grail:DisplayableQuestPrerequisites(questId, true), lastIndexUsed)
			else
				lastIndexUsed = self:_QuestInfoSection(self.s.PREREQUISITES, Grail:QuestPrerequisites(questId, true), lastIndexUsed)
			end

			self:_QuestInfoSection(self.s.OAC, Grail:QuestOnAcceptCompletes(questId))
			self:_QuestInfoSection(self.s.OCC, Grail:QuestOnCompletionCompletes(questId))
			self:_QuestInfoTurninSection(self.s.OTC, Grail:QuestOnTurninCompletes(questId))
			self:_QuestInfoSection(self.s.OTC, Grail:QuestOnDoneCompletes(questId))
			if nil ~= Grail.quests[questId] and nil ~= Grail.quests[questId]['AZ'] then
				self:_AddLine(" ")
				if "table" == type(Grail.quests[questId]['AZ']) then
					for _, mapAreaId in pairs(Grail.quests[questId]['AZ']) do
						self:_AddLine(self.s.ENTER_ZONE, Grail:MapAreaName(mapAreaId) or "UNKNOWN")
					end
				else
					self:_AddLine(self.s.ENTER_ZONE, Grail:MapAreaName(Grail.quests[questId]['AZ']) or "UNKNOWN")
				end
			end

			local reputationCodes = Grail.questReputations[questId]
			if nil ~= reputationCodes then
				local reputationCount = strlen(reputationCodes) / 4
				self:_AddLine(" ")
				self:_AddLine(self.s.REPUTATION_CHANGES .. ':')
				local index, value
				for i = 1, reputationCount do
					index, value = Grail:ReputationDecode(strsub(reputationCodes, i * 4 - 3, i * 4))
					if value > 0 then
						colorCode = greenColor
					else
						colorCode = redColor
						value = -1 * value
					end
					if WhollyDatabase.showsAllFactionReputations or Grail:FactionAvailable(index) then
						self:_AddLine(Grail.reputationMapping[index], "|c"..colorCode..value.."|r")
					end
				end
			end

			-- Technically we should be able to fetch quest reward information for quests that are not in our quest log
			self:_AddLine(" ")
			self:_AddLine(self.s.QUEST_REWARDS .. ":")
			local rewardXp = 0
			if not Grail.existsClassic then
				rewardXp = GetQuestLogRewardXP(questId)
			end
			if 0 ~= rewardXp then
				self:_AddLine(strformat(self.s.GAIN_EXPERIENCE_FORMAT, rewardXp))
			end
			local rewardMoney = GetQuestLogRewardMoney(questId)
			if 0 ~= rewardMoney then
				self:_AddLine(GetCoinTextureString(rewardMoney))
			end
			local numberRewardCurrencies = 0
			if GetNumQuestLogRewardCurrencies then
				if not Grail.existsClassic then
					numberRewardCurrencies = GetNumQuestLogRewardCurrencies(questId)
				end
			else
				local info = C_QuestInfoSystem.GetQuestRewardCurrencies(questId)
				if info then
					self:_AddLine(info.name, info.totalRewardAmount, info.texture)
				end
			end
			for counter = 1, numberRewardCurrencies do
				local currencyName, currencyTexture, currencyCount = GetQuestLogRewardCurrencyInfo(counter, questId)
				self:_AddLine(currencyName, currencyCount, currencyTexture)
			end
--	TODO:	Determine whether these API work properly for quests because we are getting Wholly displaying values
--			that seem to be for the previous quest dealt with.  It is as if the internal counter that Blizzard is
--			using is wrong.
--			for counter = 1, GetNumQuestLogRewards(questId) do
--				local name, texture, count, quality, isUsable = GetQuestLogRewardInfo(counter, questId)
--				self:_AddLine(name, count, texture)
--			end
--			local numberQuestChoiceRewards = GetNumQuestLogChoices(questId)
--			if 1 < numberQuestChoiceRewards then
--				self:_AddLine(self.s.REWARD_CHOICES)
--			end
--			for counter = 1, numberQuestChoiceRewards do
--				local name, texture, numItems, quality, isUsable = GetQuestLogChoiceInfo(counter, questId)
--				self:_AddLine(name, count, texture)
--			end

--			if nil ~= Grail.questRewards then
--				local rewardString = Grail.questRewards[questId]
--				if nil ~= rewardString then
--					self:_AddLine(" ")
--					self:_AddLine(self.s.QUEST_REWARDS .. ":")
--					local rewards = { strsplit(":", rewardString) }
--					local reward
--					local rewardType, restOfReward
--					local displayedBanner = false
--					for counter = 1, #rewards do
--						reward = rewards[counter]
--						if reward ~= "" then
--							rewardType = strsub(reward, 1, 1)
--							restOfReward = strsub(reward, 2)
--							if 'X' == rewardType then
--								local experience = tonumber(restOfReward)
--								self:_AddLine(strformat(self.s.GAIN_EXPERIENCE_FORMAT, experience))
--							elseif 'M' == rewardType then
--								local coppers = tonumber(restOfReward)
----								local golds = coppers / 10000
----								local silvers = (coppers - (golds * 10000)) / 100
----								coppers = coppers % 100
--								self:_AddLine(GetCoinTextureString(coppers))
--							elseif 'R' == rewardType then
--								local itemIdString, itemCount = strsplit("-", restOfReward)
--								local _, itemLink = GetItemInfo(itemIdString)
--								self:_AddLine(itemLink, itemCount)
--							elseif 'C' == rewardType then
--								if not displayedBanner then
--									displayedBanner = true
--									self:_AddLine(self.s.REWARD_CHOICES)
--								end
--								local itemIdString, itemCount = strsplit("-", restOfReward)
--								local _, itemLink = GetItemInfo(itemIdString)
--								self:_AddLine(itemLink, itemCount)
--							end
--						end
--					end
--				end
--			end

			self:_NPCInfoSection(self.s.WHEN_KILL, Grail:QuestNPCKills(questId), frame, false)

			local possibleNPCs = Grail:QuestNPCPrerequisiteAccepts(questId)
			if nil ~= possibleNPCs then
				self:_NPCInfoSectionPrerequisites(self.s.QUEST_GIVERS..':', possibleNPCs, frame, ('I' ~= frame.statusCode))
			else
				self:_NPCInfoSection(self.s.QUEST_GIVERS..':', Grail:QuestNPCAccepts(questId), frame, ('I' ~= frame.statusCode))
			end

			possibleNPCs = Grail:QuestNPCPrerequisiteTurnins(questId)
			if nil ~= possibleNPCs then
				self:_NPCInfoSectionPrerequisites(self.s.TURN_IN..':', possibleNPCs, frame, ('I' ~= frame.statusCode))
			else
				self:_NPCInfoSection(self.s.TURN_IN..':', Grail:QuestNPCTurnins(questId), frame, ('I' == frame.statusCode))
			end

		end,

		QuestInfoEnter = function(self, frame)
			self:_PopulateTooltipForQuest(frame, self:_BreadcrumbQuestId())
			for i = 1, self.currentTt do
				self.tt[i]:Show()
			end
		end,

		QuestInfoEnterPopup = function(self, frame)
if not Grail.existsClassic then
			self:_PopulateTooltipForQuest(frame, QuestLogPopupDetailFrame.questID)
			for i = 1, self.currentTt do
				self.tt[i]:Show()
			end
end
		end,

		_QuestInfoSection = function(self, heading, tableOrString, lastUsedIndex)
			if nil == tableOrString then return lastUsedIndex end
			local indentation
			if "table" == type(heading) then
				self:_AddLine(heading[1], heading[2])
				indentation = "   "
			else
				self:_AddLine(" ")
				self:_AddLine(heading)
				indentation = ""
			end
			local controlTable = { indentation = indentation, lastIndexUsed = lastIndexUsed, func = self._QuestInfoSectionSupport }
			Grail._ProcessCodeTable(tableOrString, controlTable)
			return controlTable.index
		end,

		_QuestInfoSectionSupport = function(controlTable)
			local self = Wholly
			local WDB = WhollyDatabase
			local innorItem, indentation, index, useIndex2, index2 = controlTable.innorItem, controlTable.indentation, controlTable.index, controlTable.useIndex2, controlTable.pipeIndex
			local commaCount, orIndex, pipeCount, pipeIndex = controlTable.commaCount, controlTable.orIndex, controlTable.pipeCount, controlTable.pipeIndex
--			local index2String = useIndex2 and ("("..index2..")") or ""
			local orString = (0 < commaCount) and "("..orIndex..")" or ""
			local pipeString = (0 < pipeCount) and "("..pipeIndex..")" or ""
			local code, subcode, numeric = Grail:CodeParts(innorItem)
			local classification = Grail:ClassificationOfQuestCode(innorItem, nil, WDB.buggedQuestsConsideredUnobtainable)
			local wSpecial = false
			if 'V' == code or 'W' == code or 'w' == code or 'r' == code then
				wSpecial, numeric = true, ''
			elseif 'T' == code or 't' == code then
				local reputationName, reputationLevelName = Grail:ReputationNameAndLevelName(subcode, numeric)
				if 't' == code then
					reputationLevelName = "< " .. reputationLevelName
				end
				numeric = format("|c%s%s|r", WDB.color[classification], reputationLevelName)
			elseif 'U' == code or 'u' == code then
				local reputationName, reputationLevelName = Grail:FriendshipReputationNameAndLevelName(subcode, numeric)
				if 'u' == code then
					reputationLevelName = "< " .. reputationLevelName
				end
				numeric = format("|c%s%s|r", WDB.color[classification], reputationLevelName)
			elseif ('G' == code or 'z' == code) and Grail.GarrisonBuildingLevelString then
				numeric = Grail:GarrisonBuildingLevelString(numeric)
			elseif ('K' == code or 'k' == code) then
				if numeric > 100000000 then numeric = numeric - 100000000 end
			end
			self:_AddLine(indentation..orString..pipeString..self:_PrettyQuestString({ innorItem, classification }), numeric)
			if wSpecial then
				local cacheTable = Grail.questStatusCache['G'][subcode]
				if cacheTable then
					for _, questId in pairs(cacheTable) do
						self:_AddLine(indentation.."    "..self:_PrettyQuestString({ questId, Grail:ClassificationOfQuestCode(questId, nil, WDB.buggedQuestsConsideredUnobtainable) }), questId)
					end
				else
					print("Grail error because no group quest cache for prerequisite code", innorItem)
				end
			end
		end,

		_QuestInfoTurninSection = function(self, heading, table)
			if nil == table then return end
			self:_AddLine(" ")
			self:_AddLine(heading)
			for key, value in pairs(table) do
				if "table" == type(value) and 2 == #value then
					self:_AddLine(Grail:NPCName(value[1]), self:_PrettyQuestString({ value[2], Grail:ClassificationOfQuestCode(value[2], nil, WhollyDatabase.buggedQuestsConsideredUnobtainable) }).." "..value[2])
				else
					self:_AddLine("Internal Error with OTC: ", value)
				end
			end
		end,

		_QuestName = function(self, questId)
			return Grail:QuestName(questId) or "NO NAME"
		end,

		_QuestTypeString = function(self, questId)
			local retval = ""
			local bitValue = Grail:CodeType(questId)
			if bitValue > 0 then
				if bitband(bitValue, Grail.bitMaskQuestRepeatable) > 0 then retval = retval .. self.s.REPEATABLE .. " " end
				if bitband(bitValue, Grail.bitMaskQuestDaily) > 0 then retval = retval .. self.s.DAILY .. " " end
				if bitband(bitValue, Grail.bitMaskQuestWeekly) > 0 then retval = retval .. self.s.WEEKLY .. " " end
				if bitband(bitValue, Grail.bitMaskQuestMonthly) > 0 then retval = retval .. self.s.MONTHLY .. " " end
				if bitband(bitValue, Grail.bitMaskQuestYearly) > 0 then retval = retval .. self.s.YEARLY .. " " end
				if bitband(bitValue, Grail.bitMaskQuestEscort) > 0 then retval = retval .. self.s.ESCORT .. " " end
				if bitband(bitValue, Grail.bitMaskQuestDungeon) > 0 then retval = retval .. self.s.DUNGEON .. " " end
				if bitband(bitValue, Grail.bitMaskQuestRaid) > 0 then retval = retval .. self.s.RAID .. " " end
				if bitband(bitValue, Grail.bitMaskQuestPVP) > 0 then retval = retval .. self.s.PVP .. " " end
				if bitband(bitValue, Grail.bitMaskQuestGroup) > 0 then retval = retval .. self.s.GROUP .. " " end
				if bitband(bitValue, Grail.bitMaskQuestHeroic) > 0 then retval = retval .. self.s.HEROIC .. " " end
				if bitband(bitValue, Grail.bitMaskQuestScenario) > 0 then retval = retval .. self.s.SCENARIO .. " " end
				if bitband(bitValue, Grail.bitMaskQuestLegendary) > 0 then retval = retval .. self.s.LEGENDARY .. " " end
				if Grail.bitMaskQuestAccountWide and bitband(bitValue, Grail.bitMaskQuestAccountWide) > 0 then retval = retval .. self.s.ACCOUNT .. " " end
				if bitband(bitValue, Grail.bitMaskQuestPetBattle) > 0 then retval = retval .. self.s.PET_BATTLES .. " " end
				if bitband(bitValue, Grail.bitMaskQuestBonus) > 0 then retval = retval .. self.s.BONUS_OBJECTIVE .. " " end
				if bitband(bitValue, Grail.bitMaskQuestRareMob) > 0 then retval = retval .. self.s.RARE_MOBS .. " " end
				if bitband(bitValue, Grail.bitMaskQuestTreasure) > 0 then retval = retval .. self.s.TREASURE .. " " end
				if bitband(bitValue, Grail.bitMaskQuestWorldQuest) > 0 then retval = retval .. self.s.WORLD_QUEST .. " " end
				if bitband(bitValue, Grail.bitMaskQuestBiweekly) > 0 then retval = retval .. self.s.BIWEEKLY .. " " end
				if bitband(bitValue, Grail.bitMaskQuestThreatQuest) > 0 then retval = retval .. self.s.THREAT_QUEST .. " " end
				if bitband(bitValue, Grail.bitMaskQuestCallingQuest) > 0 then retval = retval .. self.s.CALLING_QUEST .. " " end
			end
			return trim(retval)
		end,

		--	This records into the npcs table all those NPCs whose tooltips need to be augmented with quest information for the provided mapId.
		_RecordTooltipNPCs = function(self, mapId)
			local questsInMap = self:_ClassifyQuestsInMap(mapId) or {}
			local questId, locations

			for i = 1, #questsInMap do
				questId = questsInMap[i][1]
				if self:_FilterQuestsBasedOnSettings(questId) then
					locations = Grail:QuestLocationsAccept(questId, false, false, true, mapId, true)
					if nil ~= locations then
						for _, npc in pairs(locations) do
							local xcoord, ycoord, npcName, npcId = npc.x, npc.y, npc.name, npc.id
							if nil ~= xcoord then
								-- record the NPC as needing a tooltip note for the specific quest (it can be a redirect because an actual "NPC" may be the item that starts the quest)
								local shouldProcess, kindsOfNPC = Grail:IsTooltipNPC(npcId)
								if shouldProcess then
									for i = 1, #(kindsOfNPC), 1 do
										local npcIdToUse = tonumber(npcId)
										local shouldAdd = true
										if kindsOfNPC[i][1] == Grail.NPC_TYPE_DROP then
											shouldAdd = self:_DroppedItemMatchesQuest(kindsOfNPC[i][2], questId)
										end
										if kindsOfNPC[i][1] == Grail.NPC_TYPE_BY then npcIdToUse = tonumber(kindsOfNPC[i][2]) end
										if nil == self.npcs[npcIdToUse] then self.npcs[npcIdToUse] = {} end
										if shouldAdd and not tContains(self.npcs[npcIdToUse], questId) then tinsert(self.npcs[npcIdToUse], questId) end
									end
								end
							end
						end
					end
				end
			end
			self.checkedNPCs[mapId] = true
		end,

		--	This walks through the persistent information about groups of waypoints and reinstates
		--	them since our directional arrows we do not have TomTom make persistent.
		_ReinstateDirectionalArrows = function(self)
			local WDB = WhollyDatabase
			if nil == WDB.waypointGrouping then return end
			for groupNumber, t in pairs(WDB.waypointGrouping) do
				if 0 == #t then
					WDB.waypointGrouping[groupNumber] = nil
				else
					local t1 = {}
					local npcType = 'A'
					local codeLen
					for _, code in pairs(t) do
						codeLen = strlen(code)
						tinsert(t1, strsub(code, 1, codeLen - 1))
						npcType = strsub(code, codeLen, codeLen)
					end
					self:_AddDirectionalArrows(t1, npcType, groupNumber)
				end
			end
		end,

		_RemoveAllDirectionalArrows = function(self)
			for code, t in pairs(self.waypoints) do
				WhollyDatabase.waypointGrouping[t.grouping] = nil
			end
			self.waypoints = {}
		end,

		--	This uses the TomTom sense of uid to remove that waypoint and any others that were added
		--	in the same grouping of waypoints.
		_RemoveDirectionalArrows = function(self, uid)
			local foundGrouping = nil
			local WDB = WhollyDatabase
			local TomTom = TomTom

			for code, t in pairs(self.waypoints) do
				if t.uids and tContains(t.uids, uid) then
					foundGrouping = t.grouping
				end
			end
			if nil ~= foundGrouping then
				for _, code in pairs(WDB.waypointGrouping[foundGrouping]) do
					for _, uid in pairs(Wholly.waypoints[code].uids) do
						self.removeWaypointFunction(TomTom, uid)
					end
				end
				WDB.waypointGrouping[foundGrouping] = nil
			end
		end,

		_ResetColors = function(self)
			local WDB = WhollyDatabase
			WDB.color = {}
			for code, colorCode in pairs(self.color) do
				WDB.color[code] = colorCode
			end
			self:_ColorUpdateAllPreferenceText()
		end,

		ScrollFrame_OnLoad = function(self, frame)
			HybridScrollFrame_OnLoad(frame)
			frame.update = Wholly.ScrollFrame_Update_WithCombatCheck
			HybridScrollFrame_CreateButtons(frame, "com_mithrandir_whollyButtonTemplate")
		end,

		ScrollFrameOne_OnLoad = function(self, frame)
			HybridScrollFrame_OnLoad(frame)
			frame.update = Wholly.ScrollFrameOne_Update
			HybridScrollFrame_CreateButtons(frame, "com_mithrandir_whollyButtonOneTemplate")
		end,

		ScrollFrameTwo_OnLoad = function(self, frame)
			HybridScrollFrame_OnLoad(frame)
			frame.update = Wholly.ScrollFrameTwo_Update
			HybridScrollFrame_CreateButtons(frame, "com_mithrandir_whollyButtonTwoTemplate")
		end,

		ScrollFrame_Update_WithCombatCheck = function(self)
			if not InCombatLockdown() then
				Wholly:ScrollFrame_Update()
			else
				Wholly.combatScrollUpdate = true
				Wholly.notificationFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
			end
		end,

		ScrollFrameOne_Update = function(self)
--			self = self or Wholly
			self = Wholly
			self:ScrollFrameGeneral_Update(self.levelOneData, com_mithrandir_whollyFrameWideScrollOneFrame)
		end,

		ScrollFrameTwo_Update = function(self)
--			self = self or Wholly
			self = Wholly
			self:_InitializeLevelTwoData()
			self:ScrollFrameGeneral_Update(self.levelTwoData, com_mithrandir_whollyFrameWideScrollTwoFrame)
		end,

		_SearchFrameShow = function(self, reallyTags)
			com_mithrandir_whollySearchFrame.processingTags = reallyTags
			local titleToUse = reallyTags and self.s.TAGS_NEW or SEARCH
			com_mithrandir_whollySearchFrameTitle:SetText(titleToUse)
			com_mithrandir_whollySearchFrame:Show()
		end,

		SetupScrollFrameButton = function(self, buttonIndex, numButtons, buttons, shownEntries, scrollOffset, item, isHeader, indent, scrollFrame)
			local highlight = (scrollFrame == com_mithrandir_whollyFrameWideScrollOneFrame) and com_mithrandir_whollyFrameWideScrollOneFrameLogHighlightFrame or com_mithrandir_whollyFrameWideScrollTwoFrameLogHighlightFrame
			highlight:Hide()
			if shownEntries > scrollOffset and buttonIndex <= numButtons then
				local button = buttons[buttonIndex]
				local indentation = indent and "    " or ""
				button.normalText:SetText(indentation .. item.displayName)
				button.tag:SetText(self.cachedMapCounts[item.mapID])
				if WhollyDatabase.showQuestCounts then
					button.tag:Show()
				else
					button.tag:Hide()
				end
				if isHeader then
					if WhollyDatabase.closedHeaders[item.header] then
						button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
					else
						button:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
					end
				else
					button:SetNormalTexture("Interface\\Addons\\Wholly\\blank")
				end
				button.item = item
				if item.selected then
					highlight:ClearAllPoints()
					highlight:SetParent(button)
					highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
					highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
					highlight:Show()
				end
				button:Show()
				buttonIndex = buttonIndex + 1
			end
			return buttonIndex
		end,

		--	This technique uses marching through the data to update the buttons.
		--	This is done because some of our data may be closed, and in any case any of the headings
		--	that are open need to be processed differently.
		ScrollFrameGeneral_Update = function(self, items, frame)
			local numEntries = items and #items or 0
			local shownEntries = 0
			local buttons = frame.buttons
			local numButtons = #buttons
			local scrollOffset = HybridScrollFrame_GetOffset(frame)
			local buttonHeight = buttons[1]:GetHeight()
			local button, itemIndex
			local buttonIndex = 1

			--	Go through the data and put it into the buttons based on where the scrolling is within
			--	the data, and based on what headers are open or closed.
			for i = 1, numEntries do
				if items[i].header then		-- a header
					shownEntries = shownEntries + 1
					buttonIndex = self:SetupScrollFrameButton(buttonIndex, numButtons, buttons, shownEntries, scrollOffset, items[i], true, false, frame)
					if not WhollyDatabase.closedHeaders[items[i].header] then
						for j = 1, #(items[i].children) do
							shownEntries = shownEntries + 1
							buttonIndex = self:SetupScrollFrameButton(buttonIndex, numButtons, buttons, shownEntries, scrollOffset, items[i].children[j], false, true, frame)
						end
					end
				else						-- a normal entry
					shownEntries = shownEntries + 1
					buttonIndex = self:SetupScrollFrameButton(buttonIndex, numButtons, buttons, shownEntries, scrollOffset, items[i], false, false, frame)
				end
				
			end

			--	Now any remaining buttons in the UI should be hidden
			for i = buttonIndex, numButtons do
				buttons[i]:Hide()
			end

			--	How have the scroll frame update itself
			HybridScrollFrame_Update(frame, shownEntries * buttonHeight, numButtons * buttonHeight)
		end,

		ScrollFrame_Update = function(self)
			self = self or Wholly
			self:_FilterPanelQuests()
			local questsInMap = self.filteredPanelQuests
			local numEntries = #questsInMap
			local buttons = com_mithrandir_whollyFrameScrollFrame.buttons
			local numButtons = #buttons
			local scrollOffset = HybridScrollFrame_GetOffset(com_mithrandir_whollyFrameScrollFrame)
			local buttonHeight = buttons[1]:GetHeight();
			local button, questIndex, questId, questLevelString, requiredLevelString, colorCode, questLevel, filterCode, repeatableCompletedString
			local shouldShowTag

			tablesort(questsInMap, Wholly.SortingFunction)
			for i = 1, numButtons do
				button = buttons[i]
				questIndex = i + scrollOffset
				if questIndex <= numEntries then
					questId = questsInMap[questIndex][1]
					filterCode = questsInMap[questIndex][2]
					button.normalText:SetText(self:_PrettyQuestString(questsInMap[questIndex]))
					shouldShowTag = false
					if 'I' == filterCode and WhollyDatabase.showsInLogQuestStatus and WhollyDatabase.showsQuestsInLog then
						local questStatus = Grail:StatusCode(questId)
						local statusText = nil
						shouldShowTag = true
						if bitband(questStatus, Grail.bitMaskInLogComplete) > 0 then statusText = self.s.COMPLETE
						elseif bitband(questStatus, Grail.bitMaskInLogFailed) > 0 then statusText = self.s.FAILED
						else shouldShowTag = false
						end
						if nil ~= statusText then
							button.tag:SetText("(" .. statusText .. ")")
						end
					end
					if not shouldShowTag and self:_IsIgnoredQuest(questId) then
						button.tag:SetText("[" .. self.s.IGNORED .. "]")
						shouldShowTag = true
					end
					if shouldShowTag then button.tag:Show() else button.tag:Hide() end
					button.questId = questId
					button.statusCode = filterCode
					button:Show()
				else
					button:Hide()
				end
			end
			HybridScrollFrame_Update(com_mithrandir_whollyFrameScrollFrame, numEntries * buttonHeight, numButtons * buttonHeight)
		end,

		ScrollOneClick = function(self, button)
			if button.item.header then
				local which = button.item.header
				if WhollyDatabase.closedHeaders[which] then
					WhollyDatabase.closedHeaders[which] = nil
				else
					WhollyDatabase.closedHeaders[which] = true
				end
				self:ScrollFrameOne_Update()
			else
				if self.levelOneCurrent ~= button.item then
					self.zoneInfo.panel.mapId = nil
					self:_SetLevelTwoCurrent(nil)
					self:_ForcePanelMapArea(true)
				end
				self:_SetLevelOneCurrent(button.item)
				self:ScrollFrameOne_Update()
				self:ScrollFrameTwo_Update()
			end
		end,

		ScrollTwoClick = function(self, button)
			self:_SetLevelTwoCurrent(button.item)
			if button.item.f then
				button.item.f()
			else
				self.zoneInfo.panel.mapId = button.item.mapID
				self:_ForcePanelMapArea(true)
			end
			self:ScrollFrameTwo_Update()	-- to update selection
		end,

		SearchEntered = function(self)
			local searchText = com_mithrandir_whollySearchEditBox:GetText()
			com_mithrandir_whollySearchEditBox:SetText("")
			com_mithrandir_whollySearchFrame:Hide()

			-- Remove leading and trailing whitespace
			searchText = trim(searchText)

			if searchText and "" ~= searchText then
				if com_mithrandir_whollySearchFrame.processingTags then
					WhollyDatabase.tags = WhollyDatabase.tags or {}
					WhollyDatabase.tags[searchText] = WhollyDatabase.tags[searchText] or {}
				else
					if nil == WhollyDatabase.searches then WhollyDatabase.searches = {} end
					tinsert(WhollyDatabase.searches, searchText)
					if #(WhollyDatabase.searches) > self.maximumSearchHistory then
						tremove(WhollyDatabase.searches, 1)
					end
					self:SearchForQuestNamesMatching(searchText)
					self.zoneInfo.panel.mapId = 0
					self.justAddedSearch = true
				end
				self:_ForcePanelMapArea(true)
				self:ScrollFrameTwo_Update()
			end
		end,

-- TODO: Cause the loadable addons to be loaded if they are not already done so for any search...use the current locale

		SearchForAllQuests = function(self)
			Grail:SetMapAreaQuests(0, SEARCH .. ' ' .. Wholly.s.SEARCH_ALL_QUESTS, Grail.quest.name, true)
		end,

		SearchForQuestNamesMatching = function(self, searchTerm)
			-- the searchTerm is broken up by spaces which are considered AND conditions
			local terms = { strsplit(" ", searchTerm) }
			local results = {}
			local started = false
			for i = 1, #terms do
				if terms[i] ~= "" then
					if not started then
						for qid, questName in pairs(Grail.quest.name) do
							if strfind(questName, terms[i]) then tinsert(results, qid) end
						end
						started = true
					else
						local newResults = {}
						for _, q in pairs(results) do
							if strfind(Grail.quest.name[q], terms[i]) then tinsert(newResults, q) end
						end
						results = newResults
					end
				end
			end
			-- clear the mapArea 0 because that is what we use for computed results
			Grail:SetMapAreaQuests(0, SEARCH .. ': ' .. searchTerm, results)
		end,

		SearchForQuestsWithTag = function(self, tagName)
			local results = {}
			local questId
			if WhollyDatabase.tags then
				for k, v in pairs(WhollyDatabase.tags[tagName]) do
					for i = 0, 31 do
						if bitband(v, 2^i) > 0 then
							questId = k * 32 + i + 1
							if not tContains(results, questId) then tinsert(results, questId) end
						end
					end
				end
			end
			Grail:SetMapAreaQuests(0, Wholly.s.TAGS .. ': ' .. tagName, results)
		end,

		-- This is really setting to the current map
		SetCurrentMapToPanel = function(self, frame)		-- called by pressing the Zone button in the UI
			self:UpdateQuestCaches(false, false, true)
			self:ZoneButtonEnter(frame)	-- need to update the tooltip which is showing
		end,

		SetCurrentZoneToPanel = function(self, frame)
			self:UpdateQuestCaches(false, false, true, true)
		end,

		_SetLevelOneCurrent = function(self, newValue)
			if self.levelOneCurrent ~= newValue then
				if self.levelOneCurrent ~= nil then
					self.levelOneCurrent.selected = nil
				end
				self.levelOneCurrent = newValue
				if newValue ~= nil then
					newValue.selected = true
				end
			end
		end,

		_SetLevelTwoCurrent = function(self, newValue)
			if self.levelTwoCurrent ~= newValue then
				if self.levelTwoCurrent ~= nil then
					self.levelTwoCurrent.selected = nil
				end
				self.levelTwoCurrent = newValue
				if newValue ~= nil then
					newValue.selected = true
				end
			end
		end,

		_GetBreadcrumbMessage = function(self)
			local retval = nil
			local questId = self:_BreadcrumbQuestId()
			local breadcrumbs = Grail:AvailableBreadcrumbs(questId)
			if nil ~= breadcrumbs then
				if 1 == #breadcrumbs then
					retval = self.s.SINGLE_BREADCRUMB_FORMAT
				else
					retval = format(self.s.MULTIPLE_BREADCRUMB_FORMAT, #breadcrumbs)
				end
			end
			return retval
		end,

		_SetupBlizzardQuestLogSupport = function(self)
			-- Make it so the Blizzard quest log can display our tooltips
			if not Grail.existsClassic then
				hooksecurefunc("QuestMapLogTitleButton_OnEnter", Wholly._OnEnterBlizzardQuestButton)
				-- Now since the Blizzard UI has probably created a quest frame before I get
				-- the chance to hook the function I need to go through all the quest frames
				-- and hook them too.
				if not Grail.battleForAzeroth then
					local titles = QuestMapFrame.QuestsFrame.Contents.Titles
					for i = 1, #(titles) do
						titles[i]:HookScript("OnEnter", Wholly._OnEnterBlizzardQuestButton)
					end
				end
			else
				hooksecurefunc("QuestLogTitleButton_OnEnter", Wholly._OnEnterBlizzardQuestButton)
			end
		end,

		_SetupDefaults = function(self)
			local WDB = WhollyDatabase or {}

			if nil == WDB.defaultsLoaded then
				WDB = self:_LoadDefaults()
			end
			if nil == WDB.currentSortingMode then
				WDB.currentSortingMode = 1
			end
			if nil == WDB.closedHeaders then
				WDB.closedHeaders = {}
			end
			if nil == WDB.ignoredQuests then
				WDB.ignoredQuests = {}
			end
			-- Setup the colors, only setting those that do not already exist
			WDB.color = WDB.color or {}
			for code, colorCode in pairs(self.color) do
				WDB.color[code] = WDB.color[code] or colorCode
			end

			-- Now to be nicer to those that have used the addon before the current
			-- incarnation, newly added defaults will have their normal setting set
			-- as appropriate.
			if nil == WDB.version then		-- first loaded prior to version 006, so default options added in 006
				WDB.displaysHolidaysAlways = true		-- version 006
				WDB.updatesWorldMapOnZoneChange = true	-- version 006
				WDB.version = 6							-- just to make sure none of the other checks fails
			end
			if WDB.version < 7 then
				WDB.showsInLogQuestStatus = true			-- version 007
			end
			if WDB.version < 16 then
				WDB.showsAchievementCompletionColors = true	-- version 016
			end
			if WDB.version < 17 then
				-- transform old values into new ones as appropriate
				if WDB.showsDailyQuests then
					WDB.showsRepeatableQuests = true
				end
				WDB.loadAchievementData = true
				WDB.loadReputationData = true
			end
			if WDB.version < 27 then WDB.showsHolidayQuests = true end
			if WDB.version < 34 then WDB.loadDateData = true end
			if WDB.version < 38 then WDB.displaysBlizzardQuestTooltips = true end
			if WDB.version < 39 then WDB.showsWeeklyQuests = true end
			if WDB.version < 51 then WDB.showsLegendaryQuests = true end
			if WDB.version < 53 then WDB.showsPetBattleQuests = true end
			if WDB.version < 56 then WDB.showsPVPQuests = true end
			if WDB.version < 60 then WDB.showsWorldQuests = true end
			if WDB.version < 75 then
				WDB.displaysMapPinsTurnin = true
				WDB.color["?"] = self.color["?"]
			end
			if WDB.version < 76 then
				WDB.displaysMapPinsTurninIncomplete = false
				WDB.color["*"] = self.color["*"]
				WDB.color["!"] = self.color["!"]
			end
			WDB.version = Wholly.versionNumber

			if WDB.maximumTooltipLines then
				self.currentMaximumTooltipLines = WDB.maximumTooltipLines
			else
				self.currentMaximumTooltipLines = self.defaultMaximumTooltipLines
			end
			WhollyDatabase = WDB
			return WhollyDatabase
		end,

		_SetupMapPinsPool = function(self)
			if CreateUnsecuredRegionPoolInstance then
				self.mapPinsPool = CreateUnsecuredRegionPoolInstance(self.mapPinsTemplateName)
			else
				self.mapPinsPool = CreateFramePool("FRAME")
			end
		
			self.mapPinsPool.parent = WorldMapFrame:GetCanvas()
			
			self.mapPinsPool.creationFunc = function()
				local frame = CreateFrame("Frame", nil, WorldMapFrame:GetCanvas())
				frame:SetSize(16, 16)
				return Mixin(frame, self.mapPinsProviderPin)
			end
			
			-- Blizzard uses a new function name in the 11.x world
			self.mapPinsPool.createFunc = self.mapPinsPool.creationFunc
			
			self.mapPinsPool.resetterFunc = function(pinPool, pin)
				pin:Hide()
				pin:ClearAllPoints()
				pin:OnReleased()
				pin.pinTemplate = nil
				pin.owningMap = nil
			end
			
			-- Blizzard uses a new function name in the 11.x world
			self.mapPinsPool.resetFunc = self.mapPinsPool.resetterFunc
			
			WorldMapFrame.pinPools[self.mapPinsTemplateName] = self.mapPinsPool
		end,

		_SetupMapPinsProvider = function(self)
			self.mapPinsProvider = CreateFromMixins(MapCanvasDataProviderMixin)
		
			self.mapPinsProvider.RemoveAllData = function(self)
				self:GetMap():RemoveAllPinsByTemplate(Wholly.mapPinsTemplateName)
			end
			
			self.mapPinsProvider.RefreshAllData = function(self, fromOnShow)
				self:RemoveAllData()
				if WhollyDatabase.displaysMapPins then
					local uiMapID = self:GetMap():GetMapID()
					Wholly.zoneInfo.pins.mapId = uiMapID
					if not uiMapID then return end
					Wholly.cachedPinQuests = Wholly:_ClassifyQuestsInMap(uiMapID) or {}
					Wholly:_FilterPinQuests()
					local questsInMap = Wholly.filteredPinQuests
					local codeMapping = { ['?'] = 0, ['G'] = 1, ['W'] = 2, ['D'] = 3, ['R'] = 4, ['K'] = 5, ['H'] = 6, ['Y'] = 7, ['P'] = 8, ['L'] = 9, ['O'] = 10, ['U'] = 11, ['*'] = 12, ['!'] = 13 }
					for i = 1, #questsInMap do
						local id = questsInMap[i][1]
						local code = questsInMap[i][2]
						if 'D' == code and Grail:IsRepeatable(id) then code = 'R' end
						if 'I' == code then
							local _, completed = Grail:IsQuestInQuestLog(id)
							completed = completed or 0
							if completed > 0 then
								code = '?'
							elseif completed < 0 then
								code = '!'
							else
								code = '*'
							end
						end
						local codeValue = codeMapping[code]
						local locations = ('?' == code or '*' == code or '!' == code) and Grail:QuestLocationsTurnin(id, true, false, true, uiMapID) or Grail:QuestLocationsAccept(id, false, false, true, uiMapID, true)
						if nil ~= locations then
							for _, npc in pairs(locations) do
								local xcoord, ycoord, npcName, npcId = npc.x, npc.y, npc.name, npc.id
								if nil ~= xcoord then
									-- Either find an existing pin to see whether we need to change its texture type or create
									-- a new pin.  We might need to change the texture depending on how many quests are going
									-- to be displayed for the NPC.  We want the map to show one pin for the NPC and have its
									-- texture be for the "best" quest type that NPC shows.
									local possibleExistingPin = Wholly:RegisteredMapPin(xcoord, ycoord, npcId)
									if nil ~= possibleExistingPin then
										if codeValue < codeMapping[possibleExistingPin.texType] then
											possibleExistingPin:SetType(code)
										end
									else
										self:GetMap():AcquirePin(Wholly.mapPinsTemplateName, code, self:GetMap(), xcoord, ycoord, npcId)
									end
								end
							end
						end
					end
				else
					Wholly.mapCountLine = ""        -- do not display a tooltip for pins we are not showing
				end
			end
			
			WorldMapFrame:AddDataProvider(self.mapPinsProvider)
		end,

		_SetupMapPinsProviderPin = function(self)
			self.mapPinsProviderPin = CreateFromMixins(MapCanvasPinMixin)
			self.mapPinsProviderPin.OnLoad = function(self)
				self:UseFrameLevelType("PIN_FRAME_LEVEL_AREA_POI")
				self.texture = self:CreateTexture()
				self:SetScalingLimits(1, 1.0, 1.2)
				self:SetMouseMotionEnabled(true)
				self:SetScript("OnEnter", function(self) Wholly:ShowTooltip(self) end)
				self:SetScript("OnLeave", function() Wholly:_HideTooltip() end)
				self.SetType = Wholly._PinSetType
			end
			
			self.mapPinsProviderPin.OnAcquired = function(self, code, map, x, y, npcId)
				self:SetPosition(x/100, y/100)
				self:SetType(code)
				self.map = map
				self.npcId = npcId
				self.xcoord = x
				self.ycoord = y
				Wholly:RegisterMapPin(self, x, y, npcId)
				self:Show()
			end

			self.mapPinsProviderPin.OnReleased = function(self)
				Wholly:UnregisterMapPin(self)
			end

			-- Copied hack from Here Be Dragons to avoid in-combat error on 10.1.5
			self.mapPinsProviderPin.SetPassThroughButtons = function() end
		end,

		_SetupLibDataBroker = function(self)
			local LibStub = _G["LibStub"]
			if LibStub then
				local LDB = LibStub("LibDataBroker-1.1", true)
				if LDB then
					local launcher = LDB:NewDataObject("Wholly", {	type="launcher",
																	icon="Interface\\Icons\\INV_Misc_Book_07",
																	OnClick = function(theFrame, button)
																		if button == "RightButton" then
																			Wholly:_OpenInterfaceOptions()
																		else
																			Wholly.currentFrame:Show()
																		end
																	end,
																	OnTooltipShow = function(tooltip)
																		Wholly:_ProcessInitialUpdate()
																		Wholly.ldbTooltipOwner = tooltip:GetOwner()
																		local dropdownValue = Wholly:_Dropdown_GetText()
																		local printValue = dropdownValue or ""
																		tooltip:AddLine("Wholly - " .. printValue )
																		tooltip:AddLine(Wholly.panelCountLine)
																	end,
																})
					self.coordinates = LDB:NewDataObject("Wholly Coordinates", {	type="data source",
																					icon="Interface\\Icons\\INV_Misc_Map02",
																					text="",
																					OnClick = function(theFrame, button)
																						Wholly.pairedCoordinatesButton:Click()
																					end,
																					OnTooltipShow = function(tooltip)
																						Wholly.ldbCoordinatesTooltipOwner = tooltip:GetOwner()
																						local mapAreaId = Wholly.zoneInfo.zone.mapId
																						local mapAreaName = Grail:MapAreaName(mapAreaId) or "UNKNOWN"
																						tooltip:AddLine(strformat("%d %s", mapAreaId, mapAreaName))
																					end,
																				})
				end
			end
		end,

		_SetupQuestInfoFrame = function(self)
			-- Create the quest info frame
			if nil == com_mithrandir_whollyQuestInfoFrame then
				local frame = CreateFrame("Frame", "com_mithrandir_whollyQuestInfoFrame", QuestFrame)
				frame:EnableMouse(true)
				frame:SetSize(60, 14)
				local xOffset, yOffset = -15, -35
				if Grail.existsClassic then
					xOffset, yOffset = -55, -55
				end
				frame:SetPoint("TOPRIGHT", QuestFrame, "TOPRIGHT", xOffset, yOffset)
				frame:SetScript("OnEnter", function(self) Wholly:QuestInfoEnter(self) end)
				frame:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
				local fontString = frame:CreateFontString("com_mithrandir_whollyQuestInfoFrameText", "BACKGROUND", "GameFontNormal")
				fontString:SetJustifyH("RIGHT")
				fontString:SetSize(60, 20)
				fontString:SetPoint("CENTER")	-- needed to add this even though it worked without this in XML
				fontString:SetText("None")
				self.configurationScript24()	-- hides the frame based on preferences
			end
		end,

		_SetupSearchFrame = function(self)
			if nil == com_mithrandir_whollySearchFrame then
				local frameName = "com_mithrandir_whollySearchFrame"
				local frame = CreateFrame("Frame", frameName, com_mithrandir_whollyFrame, BackdropTemplateMixin and "BackdropTemplate")
				frame:Hide()
				frame:SetSize(288, 96)
				frame:SetPoint("BOTTOMLEFT", com_mithrandir_whollyFrame, "TOPLEFT", 64, -14)

				frame:SetBackdrop({	bgFile = "Interface/TutorialFrame/TutorialFrameBackground",
									edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
									tile = true,
									tileSize = 32,
									edgeSize = 16,
									insets = { left = 5, right = 5, top = 5, bottom = 5 }
									});

				local fontString = frame:CreateFontString(frameName.."Title", "ARTWORK", "ChatFontNormal")
				fontString:SetPoint("TOP", 0, -8)
				fontString:SetText(SEARCH)

				local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
				closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -3, -3)
				closeButton:SetScript("OnClick", function(self) com_mithrandir_whollySearchFrame:Hide() end)

				local editBox = CreateFrame("EditBox", "com_mithrandir_whollySearchEditBox", frame)
				editBox:SetMaxLetters(50)
				local texture = editBox:CreateTexture(nil, "BACKGROUND")
				texture:SetColorTexture(.2, .2, .2, 1)
				editBox:SetSize(190, 20)
				editBox:SetPoint("TOP", 0, -32)
				editBox:SetScript("OnEnterPressed", function(self) Wholly:SearchEntered() end)
				editBox:SetScript("OnEscapePressed", function(self) com_mithrandir_whollySearchFrame:Hide() end)
				editBox:SetFontObject("ChatFontNormal")

				local searchButton = CreateFrame("Button", nil, frame)
				searchButton:SetText(SEARCH)
				searchButton:SetPoint("BOTTOM", 0, 8)
				searchButton:SetScript("OnClick", function(self) Wholly:SearchEntered() end)
			end
		end,

		_SetupTooltip = function(self)
			self.tooltip = CreateFrame("GameTooltip", "com_mithrandir_WhollyTooltip", UIParent, "GameTooltipTemplate");
			self.tooltip:SetFrameStrata("TOOLTIP");
			self.tooltip.large = com_mithrandir_WhollyTooltipTextLeft1:GetFontObject();
			self.tooltip.small = com_mithrandir_WhollyTooltipTextLeft2:GetFontObject();
			self.tooltip.SetLastFont = function(self, fontObj, rightText)
				local txt = rightText and "Right" or "Left"
				_G[format("com_mithrandir_WhollyTooltipText%s%d", txt, self:NumLines())]:SetFont(fontObj:GetFont())
			end
			self.tt = { [1] = GameTooltip }
		end,

		_SetupScrollFrame = function(self, scrollFrameName, frame, sizeX, sizeY, offsetX, offsetY)
			local scrollFrame = CreateFrame("ScrollFrame", scrollFrameName, frame, "HybridScrollFrameTemplate")
			scrollFrame:SetSize(sizeX, sizeY)
			scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", offsetX, offsetY)
			
			local slider = CreateFrame("Slider", scrollFrameName.."ScrollBar", scrollFrame, "HybridScrollBarTemplate")
			slider:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", 0, -13)
			slider:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 0, 14)
			slider:SetScript("OnLoad", function(self)
				local name = self:GetName()
				_G[name.."BG"]:Hide()
				_G[name.."Top"]:Hide()
				_G[name.."Bottom"]:Hide()
				_G[name.."Middle"]:Hide()
				self.doNotHide = true
			end)
			scrollFrame.scrollBar = slider	-- hopefully this is parentKey="scrollBar"

			local highlightName = scrollFrameName.."LogHighlightFrame"
			local highlightFrame = CreateFrame("Frame", highlightName, frame)
			highlightFrame:Hide()
--			highlightFrame:SetPoint("TOPLEFT")
--			highlightFrame:SetPoint("BOTTOMRIGHT")
			local highlightTexture = highlightFrame:CreateTexture(highlightName.."LogSkillHighlight", "ARTWORK")
			highlightTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
			highlightTexture:SetBlendMode("ADD")
--			highlightFrame:SetScript("OnLoad", function(self) self:SetParent(nil) end)
			return scrollFrame
		end,

		_SetupWhollyQuestPanel = function(self)
			if nil == com_mithrandir_whollyFrame then
				local frameName = "com_mithrandir_whollyFrame"
				local frame = CreateFrame("Frame", frameName, UIParent)
				frame:SetToplevel(true)
				frame:EnableMouse(true)
				frame:SetMovable(true)
				frame:SetUserPlaced(true)
				frame:Hide()
				if Grail.existsClassic then
					frame:SetSize(348, 445)
				else
					frame:SetSize(384, 512)
				end
				local frameInfo = WhollyDatabase[frame:GetName()]
				if frameInfo then
					frame:SetPoint(frameInfo[1], UIParent, frameInfo[2], frameInfo[3], frameInfo[4])
				else
					frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, -104)
				end

				local topLeftTexture = frame:CreateTexture(nil, "BORDER")
				topLeftTexture:SetPoint("TOPLEFT")
				if Grail.existsClassic then
					local originalTextureX, originalTextureY = 512, 512
					local desiredX, desiredY = 322, 445
					topLeftTexture:SetSize(desiredX, desiredY)
					topLeftTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLogDualPane-Left")
					topLeftTexture:SetTexCoord(0, desiredX / originalTextureX, 0, desiredY / originalTextureY)
				else
					topLeftTexture:SetSize(256, 256)
					topLeftTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLog-TopLeft")
				end

				local topRightTexture = frame:CreateTexture(nil, "BORDER")
				topRightTexture:SetPoint("TOPRIGHT")
				if Grail.existsClassic then
					topRightTexture:SetSize(26, 445)
					topRightTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLogDualPane-Right")
					topRightTexture:SetTexCoord(0.55, 0.65, 0, 0.86914)
				else
					topRightTexture:SetSize(128, 256)
					topRightTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLog-TopRight")
				end

				if not Grail.existsClassic then
					local bottomLeftTexture = frame:CreateTexture(nil, "BORDER")
					bottomLeftTexture:SetSize(256, 256)
					bottomLeftTexture:SetPoint("BOTTOMLEFT")
					bottomLeftTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BotLeft")

					local bottomRightTexture = frame:CreateTexture(nil, "BORDER")
					bottomRightTexture:SetSize(128, 256)
					bottomRightTexture:SetPoint("BOTTOMRIGHT")
					bottomRightTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BotRight")
				end

				local bookTexture = frame:CreateTexture(nil, "BACKGROUND")
				bookTexture:SetSize(64, 64)
				bookTexture:SetPoint("TOPLEFT", 3, -4)
				bookTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")

				local fontString = frame:CreateFontString(frameName.."TitleText", "ARTWORK", "GameFontNormal")
				fontString:SetSize(300, 14)
				fontString:SetPoint("TOP", 0, -15)
				fontString:SetText(QUEST_LOG)

				local offsetX, offsetY = 0, 0
				if Grail.existsClassic then
					offsetX = 36
					offsetY = -67
				end

				local closeButton = CreateFrame("Button", frameName.."CloseButton", frame, "UIPanelCloseButton")
				if Grail.existsClassic then
					closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -30 + offsetX, -8)
				else
					closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -34 + offsetX, -12)
				end

				local sortButton = CreateFrame("Button", frameName.."SortButton", frame, "UIPanelButtonTemplate")
				sortButton:SetText(TRACKER_SORT_LABEL)
				sortButton:SetSize(110, 21)
				sortButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -43 + offsetX, 80 + offsetY)
				sortButton:SetScript("OnClick", function(self) Wholly:Sort(self) end)
				sortButton:SetScript("OnEnter", function(self) Wholly:SortButtonEnter(self) end)
				sortButton:SetScript("OnLeave", function(self) Wholly:SortButtonLeave(self) end)

				local preferencesButton = CreateFrame("Button", frameName.."PreferencesButton", frame, "UIPanelButtonTemplate")
				preferencesButton:SetText(PREFERENCES)
				preferencesButton:SetSize(110, 21)
				preferencesButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -151 + offsetX, 80 + offsetY)
				preferencesButton:SetScript("OnClick", function(self) Wholly:_OpenInterfaceOptions() end)

				local mapButton = CreateFrame("Button", frameName.."SwitchZoneButton", frame, "UIPanelButtonTemplate")
				mapButton:SetText(MAP)
				mapButton:SetSize(110, 21)
				mapButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -259 + offsetX, 80 + offsetY)
				mapButton:SetScript("OnClick", function(self) Wholly:SetCurrentMapToPanel(self) end)
				mapButton:SetScript("OnEnter", function(self) Wholly:ZoneButtonEnter(self) end)
				mapButton:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

				local scrollFrame = self:_SetupScrollFrame(frameName.."ScrollFrame", frame, 305, 335, 19, -75)
				scrollFrame:SetScript("OnLoad", function(self) Wholly:ScrollFrame_OnLoad(self) end)

				frame:SetScript("OnShow", function(self)
					Wholly:OnShow(self)
					PlaySound(PlaySoundKitID and "igCharacterInfoOpen" or 839)
				end)
				frame:SetScript("OnHide", function(self)
					Wholly:OnHide(self)
					PlaySound(PlaySoundKitID and "igCharacterInfoClose" or 840)
					if self.isMoving then
						self:StopMovingOrSizing()
						self.isMoving = false
					end
				end)
				frame:SetScript("OnMouseUp", function(self)
					if self.isMoving then
						self:StopMovingOrSizing()
						self.isMoving = false
						local p1, _, p2, p3, p4 = self:GetPoint()
						WhollyDatabase[self:GetName()] = { p1, p2, p3, p4 }
					end
				end)
				frame:SetScript("OnMouseDown", function(self, button)
					if (not self.isLocked or self.isLocked == 0) and button == "LeftButton" then
						self:StartMoving()
						self.isMoving = true
					end
				end)

				Wholly:OnLoad(frame)	-- no need to do this, as it does nothing
				tinsert(UISpecialFrames, frame:GetName())
				Wholly:ScrollFrame_OnLoad(scrollFrame)
			end
			if nil == com_mithrandir_whollyFrameWide then
				local frameName = "com_mithrandir_whollyFrameWide"
				local frame = CreateFrame("Frame", frameName, UIParent)
				frame:SetToplevel(true)
				frame:EnableMouse(true)
				frame:SetMovable(true)
				frame:SetUserPlaced(true)
				frame:Hide()
				frame:SetSize(682, 447)
				local frameInfo = WhollyDatabase[frame:GetName()]
				if frameInfo then
					frame:SetPoint(frameInfo[1], UIParent, frameInfo[2], frameInfo[3], frameInfo[4])
				else
					frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, -104)
				end

				local bookTexture = frame:CreateTexture(nil, "BACKGROUND")
				bookTexture:SetSize(64, 64)
				bookTexture:SetPoint("TOPLEFT", 3, -4)
				bookTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")

				local topLeftTexture = frame:CreateTexture(nil, "BACKGROUND")
				topLeftTexture:SetPoint("TOPLEFT")
				local originalTextureX, originalTextureY = 512, 512
				local desiredX, desiredY = 512, 445
				topLeftTexture:SetSize(desiredX, desiredY)
				topLeftTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLogDualPane-Left")
				topLeftTexture:SetTexCoord(0, desiredX / originalTextureX, 0, desiredY / originalTextureY)

				local topRightTexture = frame:CreateTexture(nil, "BACKGROUND")
				topRightTexture:SetPoint("TOPRIGHT")
				originalTextureX, originalTextureY = 256, 512
				desiredX, desiredY = 170, 445
				topRightTexture:SetSize(desiredX, desiredY)
				topRightTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLogDualPane-Right")
				topRightTexture:SetTexCoord(0, desiredX / originalTextureX, 0, desiredY / originalTextureY)

				local fontString = frame:CreateFontString(frameName.."TitleText", "ARTWORK", "GameFontNormal")
				fontString:SetSize(300, 14)
				fontString:SetPoint("TOP", 0, -15)
				fontString:SetText(QUEST_LOG)
				
				local bottomRightInnerTexture = frame:CreateTexture(nil, "BORDER")
				bottomRightInnerTexture:SetPoint("BOTTOMRIGHT", -80, 2)
				bottomRightInnerTexture:SetSize(80, 34)
				bottomRightInnerTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLogDualPane-Right")
				bottomRightInnerTexture:SetTexCoord(0.3046875, 0.6171875, 0.80273, 0.86914)

				local topLeftInnerTexture = frame:CreateTexture(nil, "BORDER")
				topLeftInnerTexture:SetPoint("TOPLEFT", -1, -218)
				topLeftInnerTexture:SetSize(350, 4)
				topLeftInnerTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLogDualPane-Left")
				topLeftInnerTexture:SetTexCoord(0.0, 0.625, 0.7988275, 0.80664)

				local bottomLeftInnerTexture = frame:CreateTexture(nil, "BORDER")
				bottomLeftInnerTexture:SetPoint("BOTTOMLEFT", 270, 2)
				bottomLeftInnerTexture:SetSize(80, 34)
				bottomLeftInnerTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLogDualPane-Left")
				bottomLeftInnerTexture:SetTexCoord(0.4765625, 0.6328125, 0.80273, 0.86914)

				local secondBottomLeftInnerTexture = frame:CreateTexture(nil, "BORDER")
				secondBottomLeftInnerTexture:SetPoint("BOTTOMLEFT", 350, 36)
				secondBottomLeftInnerTexture:SetSize(300, 338)
				secondBottomLeftInnerTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLogDualPane-Left")
				secondBottomLeftInnerTexture:SetTexCoord(0.0390625, 0.566640625, 0.140625, 0.80078063)
				
				local offsetX, offsetY = 0, 0
				
				local closeButton = CreateFrame("Button", frameName.."CloseButton", frame, "UIPanelCloseButton")
				if Grail.existsClassic then
					closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2 + offsetX, -8)
				else
					closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2 + offsetX, -12)
				end

				local switchZoneButton = CreateFrame("Button", frameName.."SwitchZoneButton", frame, "UIPanelButtonTemplate")
				switchZoneButton:SetText(MAP)
				switchZoneButton:SetSize(110, 21)
				switchZoneButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 18 + offsetX, 15 + offsetY)
				switchZoneButton:SetScript("OnClick", function(self) Wholly:SetCurrentMapToPanel(self) end)
				switchZoneButton:SetScript("OnEnter", function(self) Wholly:ZoneButtonEnter(self) end)
				switchZoneButton:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
				
				local reallySwitchZoneButton = CreateFrame("Button", frameName.."ReallySwitchZoneButton", frame, "UIPanelButtonTemplate")
				reallySwitchZoneButton:SetText(ZONE)
				reallySwitchZoneButton:SetSize(96, 21)
				reallySwitchZoneButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 129 + offsetX, 15 + offsetY)
				reallySwitchZoneButton:SetScript("OnClick", function(self) Wholly:SetCurrentZoneToPanel(self) end)
				reallySwitchZoneButton:SetScript("OnEnter", function(self) Wholly:ZoneButtonEnter(self) end)
				reallySwitchZoneButton:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

				local preferencesButton = CreateFrame("Button", frameName.."PreferencesButton", frame, "UIPanelButtonTemplate")
				preferencesButton:SetText(PREFERENCES)
				preferencesButton:SetSize(124, 21)
				preferencesButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 224 + offsetX, 15 + offsetY)
				preferencesButton:SetScript("OnClick", function(self) Wholly:_OpenInterfaceOptions() end)

				local sortButton = CreateFrame("Button", frameName.."SortButton", frame, "UIPanelButtonTemplate")
				sortButton:SetText(TRACKER_SORT_LABEL)
				sortButton:SetSize(150, 21)
				sortButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -8 + offsetX, 15 + offsetY)
				sortButton:SetScript("OnClick", function(self) Wholly:Sort(self) end)
				sortButton:SetScript("OnEnter", function(self) Wholly:SortButtonEnter(self) end)
				sortButton:SetScript("OnLeave", function(self) Wholly:SortButtonLeave(self) end)

				local scrollOneFrame = self:_SetupScrollFrame(frameName.."ScrollOneFrame", frame, 305, 140, 19, -75)
				scrollOneFrame:SetScript("OnLoad", function(self) Wholly:ScrollFrameOne_OnLoad(self) end)

				local scrollTwoFrame = self:_SetupScrollFrame(frameName.."ScrollTwoFrame", frame, 305, 180, 19, -224)
				scrollTwoFrame:SetScript("OnLoad", function(self) Wholly:ScrollFrameTwo_OnLoad(self) end)

				frame:SetScript("OnShow", function(self)
					Wholly:OnShow(self)
					PlaySound(PlaySoundKitID and "igCharacterInfoOpen" or 839)
				end)
				frame:SetScript("OnHide", function(self)
					Wholly:OnHide(self)
					PlaySound(PlaySoundKitID and "igCharacterInfoClose" or 840)
					if self.isMoving then
						self:StopMovingOrSizing()
						self.isMoving = false
					end
				end)
				frame:SetScript("OnMouseUp", function(self)
					if self.isMoving then
						self:StopMovingOrSizing()
						self.isMoving = false
						local p1, _, p2, p3, p4 = self:GetPoint()
						WhollyDatabase[self:GetName()] = { p1, p2, p3, p4 }
					end
				end)
				frame:SetScript("OnMouseDown", function(self, button)
					if (not self.isLocked or self.isLocked == 0) and button == "LeftButton" then
						self:StartMoving()
						self.isMoving = true
					end
				end)

				tinsert(UISpecialFrames, frame:GetName())
				Wholly:ScrollFrameOne_OnLoad(scrollOneFrame)
				Wholly:ScrollFrameTwo_OnLoad(scrollTwoFrame)
			end
		end,

		_SetupWorldMapWhollyButton = function(self)
			local parentFrame = Grail.existsClassic and WorldMapFrame or WorldMapFrame.BorderFrame
			local f = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")
--			f:SetSize(100, 25)
			f:SetSize(24, 22)
			f:SetToplevel(true)
			if not Grail.existsClassic then
				f:SetScale(0.7)
			end
--			f:SetText("Wholly")
			f:SetText("W")
			if Grail.existsClassic then
				f:SetFrameLevel(10)
				f:SetPoint("TOPLEFT", WorldMapFrame.BorderFrame, "TOPLEFT", 5, -37)
			else
				f:SetPoint("TOPLEFT", WorldMapFrameHomeButton, "BOTTOMLEFT", -25, 25)
			end
--			f:SetScript("OnShow", function(self)
--				if Gatherer_WorldMapDisplay then
--					self:SetPoint("TOPLEFT", Gatherer_WorldMapDisplay, "TOPRIGHT", 4, 0)
--				elseif Questie_Toggle then
--					self:SetPoint("TOPRIGHT", Questie_Toggle, "TOPLEFT", -8, 2)
--				elseif TitanMapCursorLocation then
--					self:SetPoint("TOPLEFT", TitanMapCursorLocation, "TOPRIGHT", 10, 6)
--				elseif Grail.existsClassic then
--					self:SetPoint("TOPRIGHT", WorldMapContinentDropDown, "TOPLEFT", 10, 0)
--				elseif TomTomWorldFrame and TomTomWorldFrame.Player then
--					self:SetPoint("TOPLEFT", TomTomWorldFrame.Player, "TOPRIGHT", 10, 6)
--				else
--					self:SetPoint("TOPLEFT", WorldMapFrame.BorderFrame.Tutorial, "TOPRIGHT", 0, -30)
--				end
--			end)
			f:SetScript("OnEnter", function(self)
				local t = Wholly.tooltip
				t:ClearLines()
				t:SetOwner(self)
				t:AddLine(Wholly.mapCountLine)
				t:Show()
				t:ClearAllPoints()
				t:SetPoint("TOPLEFT", self, "BOTTOMRIGHT")
			end)
			f:SetScript("OnLeave", function(self) Wholly.tooltip:Hide() end)
			f:SetScript("OnClick", function(self) Wholly.pairedConfigurationButton:Click() end)
			f:Hide()
			self.mapFrame = f
		end,

		ShowBreadcrumbInfo = function(self)
			local questId = self:_BreadcrumbQuestId()
--			local breadcrumbs = Grail:AvailableBreadcrumbs(questId)
			com_mithrandir_whollyBreadcrumbFrame:Hide()
			com_mithrandir_whollyQuestInfoFrameText:SetText(questId)
			self:UpdateBuggedText(questId)
			local breadcrumbMessage = self:_GetBreadcrumbMessage()
			if nil ~= breadcrumbMessage then
				if WhollyDatabase.displaysBreadcrumbs then
					com_mithrandir_whollyBreadcrumbFrameMessage:SetText(breadcrumbMessage)
					com_mithrandir_whollyBreadcrumbFrame:Show()
				end
				if WhollyDatabase.displaysBreadcrumbMessages then
					print(format("|cFFFFFF00Wholly|r |cFFFF00FF%s|r", breadcrumbMessage))
				end
			end
--			if nil ~= breadcrumbs then
--				if 1 == #breadcrumbs then com_mithrandir_whollyBreadcrumbFrameMessage:SetText(self.s.SINGLE_BREADCRUMB_FORMAT)
--				else com_mithrandir_whollyBreadcrumbFrameMessage:SetText(format(self.s.MULTIPLE_BREADCRUMB_FORMAT, #breadcrumbs))
--				end
--				com_mithrandir_whollyBreadcrumbFrame:Show()
--			end
		end,

		ShowTooltip = function(self, pin)
			local WDB = WhollyDatabase
			local listedQuests = {}
			self.tooltip:SetOwner(pin, "ANCHOR_RIGHT")
			self.tooltip:ClearLines()

            local parentFrame = pin.originalParentFrame
			-- find all quests in range of hover
            local mx, my = pin:GetPosition()
			local npcList = {}
			local npcNames = {}

			local questsInMap = self.filteredPinQuests
			local questId, code
			for i = 1, #questsInMap do
				questId = questsInMap[i][1]
				code = questsInMap[i][2]
--                local locations = Grail:QuestLocationsAccept(questId, false, false, true, parentFrame:GetMapID(), true)
				local locations = 'I' == code and Grail:QuestLocationsTurnin(questId, true, false, true, pin.map) or Grail:QuestLocationsAccept(questId, false, false, true, pin.map, true)
				if nil ~= locations then
					for _, npc in pairs(locations) do
						if nil ~= npc.x then
                            local dist = sqrt( (mx - npc.x/100)^2 + (my - npc.y/100)^2 )
--							if dist <= 0.02 or (NxMap1 == parentFrame and npc.id == pin.npcId) then
							if dist <= 0.02 then
								if not npcList[npc.id] then
									npcList[npc.id] = {}
									local nameToUse = Grail:NPCName(npc.id) or "??"
									if npc.dropid then
										nameToUse = nameToUse .. " (" .. Grail:NPCName(npc.dropId) .. ')'
									end
									npcNames[npc.id] = self:_PrettyNPCString(nameToUse, npc.kill, npc.realArea)
								end
								tinsert(npcList[npc.id], questsInMap[i])
							end
						end
					end
				end
			end

			local first = true
			for npc, questList in pairs(npcList) do
				if not first then
					self.tooltip:AddLine(" ")
				else
					first = false
				end
				for _, qt in ipairs(questList) do
					local leftStr = self:_PrettyQuestString(qt)
					local q = qt[1]
					local rightStr = self:_QuestTypeString(q)
					if strlen(rightStr) > 0 then rightStr = format("|c%s%s|r", WDB.color[qt[2]], rightStr) end

					-- check if already printed - this is for spam quests like the human starting area that haven't been labeled correctly
					if not questName or not listedQuests[questName] then
						self.tooltip:AddDoubleLine(leftStr, rightStr)
						self.tooltip:SetLastFont(self.tooltip.large)
						self.tooltip:SetLastFont(self.tooltip.small, true)
						if questName then listedQuests[questName] = true end
					end
				end
				self.tooltip:AddLine(npcNames[npc], 1, 1, 1, 1)
				self.tooltip:SetLastFont(self.tooltip.small)
			end
	
            self.tooltip:Show();
		end,

		SlashCommand = function(self, frame, msg)
			self:ToggleUI()
		end,

		Sort = function(self, frame)
			-- This is supposed to cycle through the supported sorting techniques and make the contents of the panel
			-- show the quests based on those techniques.
			-- 1 Quest alphabetical
			-- 2 Quest level (and then alphabetical)
			-- 3 Quest level, then type, then alphabetical
			-- 4 Quest type (and then alphabetical)
			-- 5 Quest type, then level, then alphabetical
			WhollyDatabase.currentSortingMode = WhollyDatabase.currentSortingMode + 1
			if (WhollyDatabase.currentSortingMode > 5) then WhollyDatabase.currentSortingMode = 1 end
			self:ScrollFrame_Update_WithCombatCheck()
			self:SortButtonLeave(frame)	-- to update the tooltip with the new sorting info
			self:SortButtonEnter(frame)	-- to update the tooltip with the new sorting info
		end,

		SortButtonEnter = function(self, frame)
			local sortModes = {
				[1] = self.s.ALPHABETICAL,
				[2] = self.s.LEVEL..", "..self.s.ALPHABETICAL,
				[3] = self.s.LEVEL..", "..self.s.TYPE..", "..self.s.ALPHABETICAL,
				[4] = self.s.TYPE..", "..self.s.ALPHABETICAL,
				[5] = self.s.TYPE..", "..self.s.LEVEL..", "..self.s.ALPHABETICAL,
				}
			GameTooltip:ClearAllPoints()
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
			GameTooltip:AddLine(sortModes[WhollyDatabase.currentSortingMode])
			GameTooltip:Show()
		end,

		SortButtonLeave = function(self, frame)
			GameTooltip:Hide()
		end,

		SortingFunction = function(a, b)
			local retval = false
			if 1 == WhollyDatabase.currentSortingMode then
				retval = Wholly:_QuestName(a[1]) < Wholly:_QuestName(b[1])
			elseif 2 == WhollyDatabase.currentSortingMode then
				local aLevel, bLevel = Grail:QuestLevel(a[1]) or 1, Grail:QuestLevel(b[1]) or 1
				if aLevel == bLevel then
					retval = Wholly:_QuestName(a[1]) < Wholly:_QuestName(b[1])
				else
					retval = aLevel < bLevel
				end
			elseif 3 == WhollyDatabase.currentSortingMode then
				local aLevel, bLevel = Grail:QuestLevel(a[1]) or 1, Grail:QuestLevel(b[1]) or 1
				if aLevel == bLevel then
					local aCode, bCode = a[2], b[2]
					if aCode == bCode then
						retval = Wholly:_QuestName(a[1]) < Wholly:_QuestName(b[1])
					else
						retval = aCode < bCode
					end
				else
					retval = aLevel < bLevel
				end
			elseif 4 == WhollyDatabase.currentSortingMode then
				local aCode, bCode = a[2], b[2]
				if aCode == bCode then
					retval = Wholly:_QuestName(a[1]) < Wholly:_QuestName(b[1])
				else
					retval = aCode < bCode
				end
			elseif 5 == WhollyDatabase.currentSortingMode then
				local aCode, bCode = a[2], b[2]
				if aCode == bCode then
					local aLevel, bLevel = Grail:QuestLevel(a[1]) or 1, Grail:QuestLevel(b[1]) or 1
					if aLevel == bLevel then
						retval = Wholly:_QuestName(a[1]) < Wholly:_QuestName(b[1])
					else
						retval = aLevel < bLevel
					end
				else
					retval = aCode < bCode
				end
			end
			return retval
		end,

		_TagDelete = function(self)
			local menu = {}
			local menuItem
			if WhollyDatabase.tags then
				for tagName, questTable in pairs(WhollyDatabase.tags) do
					menuItem = { text = tagName, isNotRadio = true }
					menuItem.func = function(self, arg1, arg2, checked) Wholly:_TagDeleteConfirm(tagName) end
					tinsert(menu, menuItem)
				end
			end
 			tablesort(menu, function(a, b) return a.text < b.text end)
			tinsert(menu, 1, { text = Wholly.s.TAGS_DELETE, isTitle = true })
			EasyMenu(menu, self.easyMenuFrame, self.easyMenuFrame, 0, 0, "MENU")
		end,

		_TagDeleteConfirm = function(self, tagName)
			local dialog = StaticPopup_Show("com_mithrandir_whollyTagDelete", tagName)
			if dialog then dialog.data = tagName end
		end,

		_TagProcess = function(self, questId)
			local menu = {}
			local menuItem
			if WhollyDatabase.tags then
				for tagName, questTable in pairs(WhollyDatabase.tags) do
					menuItem = { text = tagName, isNotRadio = true }
					menuItem.checked = Grail:_IsQuestMarkedInDatabase(questId, questTable)
					menuItem.func = function(self, arg1, arg2, checked) Grail:_MarkQuestInDatabase(questId, WhollyDatabase.tags[tagName], checked) if Wholly.levelOneCurrent.index == 74 and Wholly.levelTwoCurrent.sortName == tagName then Wholly.SearchForQuestsWithTag(Wholly, tagName) Wholly.zoneInfo.panel.mapId = 0 Wholly._ForcePanelMapArea(Wholly, true) end end
					tinsert(menu, menuItem)
				end
			end
 			tablesort(menu, function(a, b) return a.text < b.text end)
			tinsert(menu, 1, { text = Wholly.s.TAGS .. ": " .. self:_QuestName(questId), isTitle = true })
			EasyMenu(menu, self.easyMenuFrame, self.easyMenuFrame, 0, 0, "MENU")
		end,

		ToggleCurrentFrame = function(self)
			local isShowing = self.currentFrame:IsShown()
			local x, y
			if isShowing then
				self.currentFrame:Hide()	-- Hide the current frame before we manipulate
			end
			if com_mithrandir_whollyFrame == self.currentFrame then
				self.currentFrame = com_mithrandir_whollyFrameWide
				x, y = 348, -75
			else
				self.currentFrame = com_mithrandir_whollyFrame
				x, y = 19, -75
			end
			self.toggleButton:ClearAllPoints()
			self.toggleButton:SetParent(self.currentFrame)
			com_mithrandir_whollyFrameScrollFrame:ClearAllPoints()
			com_mithrandir_whollyFrameScrollFrame:SetParent(self.currentFrame)
			com_mithrandir_whollyFrameScrollFrame:SetPoint("TOPLEFT", self.currentFrame, "TOPLEFT", x, y)
			if isShowing then
				self.currentFrame:Show()
			end
			com_mithrandir_whollySearchFrame:ClearAllPoints()
			com_mithrandir_whollySearchFrame:SetParent(self.currentFrame)
			com_mithrandir_whollySearchFrame:SetPoint("BOTTOMLEFT", self.currentFrame, "TOPLEFT", 64, -14)
			self.easyMenuFrame:ClearAllPoints()
			self.easyMenuFrame:SetParent(self.currentFrame)
			self.easyMenuFrame:SetPoint("LEFT", self.currentFrame, "RIGHT")
		end,

		ToggleIgnoredQuest = function(self)
			local desiredQuestId = self.clickingButton.questId
			Grail:_MarkQuestInDatabase(desiredQuestId, WhollyDatabase.ignoredQuests, self:_IsIgnoredQuest(desiredQuestId))
		end,

		ToggleLightHeaded = function(self)
			local desiredQuestId = self.clickingButton.questId
			if LightHeadedFrame:IsVisible() and LightHeadedFrameSub.qid == desiredQuestId then LightHeadedFrame:Hide() return end
			LightHeadedFrame:ClearAllPoints()
			LightHeadedFrame:SetParent(self.currentFrame)
			-- default to attaching on the right side
			local lhSide, whollySide, x, y = "LEFT", "RIGHT", -39, 31
			if self.currentFrame == com_mithrandir_whollyFrameWide then
				x = -8
				y = 0
			end
			LightHeadedFrame:SetPoint(lhSide, self.currentFrame, whollySide, x, y)
			LightHeadedFrame:Show()
			LightHeaded:UpdateFrame(desiredQuestId, 1)
		end,

		ToggleSwitch = function(self, key)
			local button = self.preferenceButtons[key]
			if nil ~= button then
				button:Click()
			end
		end,

		ToggleUI = function(self)
			if not self.currentFrame then print(format(self.s.REQUIRES_FORMAT, requiredGrailVersion)) return end
			if not InCombatLockdown() then
				if self.currentFrame:IsShown() then
					self.currentFrame:Hide()
				else
					self.currentFrame:Show()
				end
			end
		end,

		---
		--	Sets up the event monitoring to handle those associated with displaying breadcrumb information.
		UpdateBreadcrumb = function(self)
			if WhollyDatabase.displaysBreadcrumbs or WhollyDatabase.displaysBreadcrumbMessages then
				self.notificationFrame:RegisterEvent("QUEST_DETAIL")
				if QuestFrame:IsVisible() then
					self:ShowBreadcrumbInfo()
				end
			else
				self.notificationFrame:UnregisterEvent("QUEST_DETAIL")
				com_mithrandir_whollyBreadcrumbFrame:Hide()
			end
		end,

		UpdateBuggedText = function(self, questId)
			local bugged = Grail:IsBugged(questId)
			if bugged then
				com_mithrandir_whollyQuestInfoBuggedFrameText:SetText(self.s.BUGGED)
			else
				com_mithrandir_whollyQuestInfoBuggedFrameText:SetText("")
			end
		end,

		UpdateCoordinateSystem = function(self)
			if WhollyDatabase.enablesPlayerCoordinates and not Grail:IsInInstance() then
				self.notificationFrame:SetScript("OnUpdate", function(frame, ...) self:_OnUpdate(frame, ...) end)
			else
				self.notificationFrame:SetScript("OnUpdate", nil)
				if nil ~= self.coordinates then
					self.coordinates.text = ""
				end
				self.previousX = 0
			end
		end,

        _UpdatePins = function(self, forceUpdate)
			if WorldMapFrame:IsVisible() then
            	self.mapPinsProvider:RefreshAllData()
			end
        end,

		UpdateQuestCaches = function(self, forceUpdate, setPinMap, setPanelMap, useCurrentZone)
			if not Grail:IsPrimed() then return end
			local desiredMapId = useCurrentZone and self.zoneInfo.zone.mapId or Grail.GetCurrentDisplayedMapAreaID()
			if desiredMapId ~= self.zoneInfo.panel.mapId or forceUpdate then
				if setPanelMap then
					self.zoneInfo.panel.mapId = desiredMapId
				end
				self:_ForcePanelMapArea(not setPanelMap)
			end
		end,

		ZoneButtonEnter = function(self, frame)
			GameTooltip:ClearAllPoints()
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
			GameTooltip:AddLine(Wholly.panelCountLine)
			GameTooltip:Show()
		end,

		}

	Wholly_ToggleUI = function()
		Wholly.ToggleUI(Wholly)
	end

	local nf = CreateFrame("Frame")
	Wholly.notificationFrame = nf
	nf:SetScript("OnEvent", function(frame, event, ...) Wholly:_OnEvent(frame, event, ...) end)
	nf:RegisterEvent("PLAYER_LOGIN")

	local locale = GetLocale()
	local S = Wholly.s
	if "deDE" == locale then
		S["ABANDONED"] = "Abgebrochen"
		S["ACCEPTED"] = "Angenommen"
		S["ACHIEVEMENT_COLORS"] = "Zeige Farben je nach Erfolgs-Vervollständigung"
		S["ADD_ADVENTURE_GUIDE"] = "In allen Gebieten die Quests aus dem Abenteuerführer anzeigen"
		S["ALL_FACTION_REPUTATIONS"] = "Alle Fraktionsrufe anzeigen"
		S["APPEND_LEVEL"] = "Erforderliche Stufe anhängen"
		S["BASE_QUESTS"] = "Hauptquests"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Kartenpunkte umschalten."
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Abgeschlossene Quests anzeigen ein/aus"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Tägliche Quests anzeigen ein/aus"
		BINDING_NAME_WHOLLY_TOGGLESHOWLOREMASTER = "Meister der Lehren-Quests anzeigen"
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Voraussetzungen anzeigen ein/aus"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Wiederholbare Quests anzeigen ein/aus"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Anzeige \"Unerreichbares\" umschalten."
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Wöchentliche Quests anzeigen ein/aus"
		BINDING_NAME_WHOLLY_TOGGLESHOWWORLDQUESTS = "Weltquests anzeigen"
		S["BLIZZARD_TOOLTIP"] = "QuickInfos werden im Blizzard-Questlog angezeigt"
		S["BREADCRUMB"] = "Brotkrumen-Quests:"
		S["BUGGED"] = "*** FEHLERHAFT ***"
		S["BUGGED_UNOBTAINABLE"] = "Fehlerhafte, wahrscheinlich unerfüllbare Quests"
		S["BUILDING"] = "Gebäude"
		S["CHRISTMAS_WEEK"] = "Weihnachtswoche (inkl. Winterhauchfest)"
		S["CLASS_ANY"] = "Jede"
		S["CLASS_NONE"] = "Keine"
		S["COMPLETED"] = "Abgeschlossen"
		S["COMPLETION_DATES"] = "Fertigstellungstermine"
		S["DROP_TO_START_FORMAT"] = "Dropt %s, um [%s] zu starten"
		S["EMPTY_ZONES"] = "Leere Zonen anzeigen"
		S["ENABLE_COORDINATES"] = "Anzeige der Spielerkoordinaten"
		S["ENTER_ZONE"] = "Annahme, wenn Kartenbereich erreicht wird"
		S["ESCORT"] = "Eskorte"
		S["EVER_CAST"] = "Wurde schon mal vom Spieler irgendwann benutzt."
		S["EVER_COMPLETED"] = "Wurde schon einmal abgeschlossen"
		S["EVER_EXPERIENCED"] = "Wurde schon mal auf den Spieler irgendwann benutzt."
		S["FACTION_BOTH"] = "Beide"
		S["FIRST_PREREQUISITE"] = "Erster in einer Questreihe"
		S["GENDER"] = "Geschlecht"
		S["GENDER_BOTH"] = "Beide"
		S["GENDER_NONE"] = "Keins"
		S["GRAIL_NOT_HAVE"] = "Grail kennt diese Quest nicht"
		S["HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES"] = "Blizzards Bonusziele ausblenden"
		S["HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES"] = "Blizzards Instanzeingänge ausblenden"
		S["HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS"] = "Blizzards Kartenpunkte für Quests ausblenden"
		S["HIDE_BLIZZARD_WORLD_MAP_TREASURES"] = "Blizzards Schätze auf der Weltkarte ausblenden"
		S["HIDE_WORLD_MAP_FLIGHT_POINTS"] = "Flugpunkte verbergen"
		S["HIGH_LEVEL"] = "Hochstufig"
		S["HOLIDAYS_ONLY"] = "Verfügbar nur an Feiertagen:"
		S["IGNORE_REPUTATION_SECTION"] = "Rufabschnitt bei Quests ignorieren"
		S["IN_LOG"] = "Im Log"
		S["IN_LOG_STATUS"] = "Status der Quests im Log anzeigen"
		S["INVALIDATE"] = "Ungültig durch Quests:"
		S["IS_BREADCRUMB"] = "Ist eine Brotkrumen-Quest für:"
		S["ITEM"] = "Gegenstand"
		S["ITEM_LACK"] = "Gegenstand fehlt"
		S["KILL_TO_START_FORMAT"] = "Töte, um [%s] zu starten"
		S["LIVE_COUNTS"] = "Sofortige Questanzahl-Aktualisierung"
		S["LOAD_DATA"] = "Daten laden"
		S["LOREMASTER_AREA"] = "Bereich 'Meister der Lehren'"
		S["LOW_LEVEL"] = "Niedrigstufig"
		S["MAP"] = "Karte"
		S["MAP_BUTTON"] = "Button auf Weltkarte anzeigen"
		S["MAP_DUNGEONS"] = "Dungeonquests in Umgebungskarte anzeigen"
		S["MAP_PINS"] = "Kartensymbole für Questgeber anzeigen"
		S["MAP_UPDATES"] = "Weltkarte aktualisieren, wenn Zone wechselt"
		S["MAPAREA_NONE"] = "Keine"
		S["MAXIMUM_LEVEL_NONE"] = "Keine"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d Brotkrumen-Quests verfügbar"
		S["MUST_KILL_PIN_FORMAT"] = "%s [Kill]"
		S["NEAR"] = "Naher NPC"
		S["NEEDS_PREREQUISITES"] = "Benötigt Voraussetzungen"
		S["NEVER_ABANDONED"] = "Niemals abgebrochen"
		S["OAC"] = "Bei Annahme fertiggestellte Quests:"
		S["OCC"] = "Bei Erfüllung der Voraussetzungen fertiggestellte Quests:"
		S["OTC"] = "Beim Abgeben fertiggestellte Quests;"
		S["OTHER"] = "Andere"
		S["OTHER_PREFERENCE"] = "Sonstiges"
		S["PANEL_UPDATES"] = "Questlog aktualisieren, wenn Zone wechselt"
		S["PLOT"] = "Grundstück"
		S["PREPEND_LEVEL"] = "Queststufe voranstellen"
		S["PREREQUISITES"] = "Quests, die Vorraussetzung sind:"
		S["QUEST_COUNTS"] = "Zeige Questanzahl"
		S["QUEST_ID"] = "Quest-ID:"
		S["QUEST_TYPE_NORMAL"] = "Normal"
		S["RACE_ANY"] = "Jede"
		S["RACE_NONE"] = "Keine"
		S["RARE_MOBS"] = "Seltene Gegner"
		S["REPEATABLE"] = "Wiederholbar"
		S["REPEATABLE_COMPLETED"] = "Zeige, ob wiederholbare Quests bereits abgeschlossen wurden"
		S["REPUTATION_REQUIRED"] = "Ruf erforderlich:"
		S["REQUIRED_LEVEL"] = "Benötigte Stufe:"
		S["REQUIRES_FORMAT"] = "Wholly benötigt Grail-Version %s oder neuer"
		S["RESTORE_DIRECTIONAL_ARROWS"] = "Sollte nicht die Richtungspfeile wiederherstellen"
		S["SEARCH_ALL_QUESTS"] = "Alle Quests"
		S["SEARCH_CLEAR"] = "Suche löschen"
		S["SEARCH_NEW"] = "Neue Suche"
		S["SELF"] = "Selbst"
		S["SHOW_BREADCRUMB"] = "Detaillierte Questinformationen im Questfenster anzeigen"
		S["SHOW_BREADCRUMB_MESSAGE"] = "Display breadcrumb message in chat"
		S["SHOW_LOREMASTER"] = "Zeige nur Meister-der-Lehren-Quests"
		S["SINGLE_BREADCRUMB_FORMAT"] = "Brotkrumen-Quest verfügbar"
		S["SP_MESSAGE"] = "Spezial-Quests tauchen niemals in Blizzards Quest-Log auf"
		S["TAGS"] = "Tags"
		S["TAGS_DELETE"] = "Tag entfernen"
		S["TAGS_NEW"] = "Tag hinzufügen"
		S["TITLE_APPEARANCE"] = "Aussehen der Quests im Questlog"
		S["TREASURE"] = "Schatz"
		S["TURNED_IN"] = "Abgegeben"
		S["UNOBTAINABLE"] = "Unerfüllbar"
		S["WHEN_KILL"] = "Annahme beim Töten:"
		S["WIDE_PANEL"] = "Breites Wholly-Questfenster"
		S["WIDE_SHOW"] = "Zeige"
		S["WORLD_EVENTS"] = "Weltereignisse"
		S["YEARLY"] = "Jährlich"
	elseif "esES" == locale then
		S["ABANDONED"] = "Abandonada"
		S["ACCEPTED"] = "Aceptada"
		S["ACHIEVEMENT_COLORS"] = "Mostrar colores de finalización de logros"
		S["ADD_ADVENTURE_GUIDE"] = "Desplegar Guía de Aventuras y misiones en todas las zonas"
		S["ALL_FACTION_REPUTATIONS"] = "Mostrar reputaciones de todas las facciones"
		S["APPEND_LEVEL"] = "Añadir nivel requerido"
		S["BASE_QUESTS"] = "Misiones Base"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Mostrar/ocultar marcas en el mapa"
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Mostrar/ocultar misiones completadas"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Mostrar/ocultar misiones diarias"
		BINDING_NAME_WHOLLY_TOGGLESHOWLOREMASTER = "Mostrar/ocultar misiones del Maestro Cultural"
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Mostrar/ocultar misiones con prerequisitos obligatorios"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Mostrar/ocultar misiones repetibles"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Mostrar/ocultar misiones no obtenibles"
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Mostrar/ocultar misiones semanales"
		BINDING_NAME_WHOLLY_TOGGLESHOWWORLDQUESTS = "Mostrar/ocultar de Misiones de Mundo"
		S["BLIZZARD_TOOLTIP"] = "Aparecen descripciones emergentes en el Diario de Misión de Blizzard"
		S["BREADCRUMB"] = "Cadena de misiones:"
		S["BUGGED"] = "*** ERROR ***"
		S["BUGGED_UNOBTAINABLE"] = "*ERROR* en misión es considerada no obtenible "
		S["BUILDING"] = "Estructura requerida"
		S["CHRISTMAS_WEEK"] = "Semana navideña"
		S["CLASS_ANY"] = "Cualquiera"
		S["CLASS_NONE"] = "Ninguna"
		S["COMPLETED"] = "Completada"
		S["COMPLETION_DATES"] = "Fechas de conclusión"
		S["DROP_TO_START_FORMAT"] = "Deja caer %s que inicia [%s]"
		S["EMPTY_ZONES"] = "Mostrar zonas vacías"
		S["ENABLE_COORDINATES"] = "Habilitar coordenadas del jugador"
		S["ENTER_ZONE"] = "Aceptar al entrar en el area del mapa"
		S["ESCORT"] = "Escoltar"
		S["EVER_CAST"] = "ya lanzo este Hechizo or no ah lanzado el hechizo X"
		S["EVER_COMPLETED"] = "Ha sido completado"
		S["EVER_EXPERIENCED"] = "Ya se ha recibido"
		S["FACTION_BOTH"] = "Ambas faciones"
		S["FIRST_PREREQUISITE"] = "Primera en la cadena de prerequisitos:"
		S["GENDER"] = "Sexo"
		S["GENDER_BOTH"] = "Ambos"
		S["GENDER_NONE"] = "Ninguno"
		S["GRAIL_NOT_HAVE"] = "Grail no tiene esta misión"
		S["HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES"] = "Ocultar Bonos de blizzard de los objetivos"
		S["HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES"] = "Ocultar las entradas de las mazmorras"
		S["HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS"] = "Ocultar marcadores de misión de Blizzard"
		S["HIDE_BLIZZARD_WORLD_MAP_TREASURES"] = "Ocultar tesoros de Blizzard"
		S["HIDE_WORLD_MAP_FLIGHT_POINTS"] = "Ocultar puntos de vuelo"
		S["HIGH_LEVEL"] = "misiones de nivel alto "
		S["HOLIDAYS_ONLY"] = "Solo disponible durante eventos festivos:"
		S["IGNORE_REPUTATION_SECTION"] = "Ignorar sección de reputación de las misiones"
		S["IN_LOG"] = "En el registro"
		S["IN_LOG_STATUS"] = "Mostrar estado de misión en registro"
		S["INVALIDATE"] = "Invalidado por misiones:"
		S["IS_BREADCRUMB"] = "Es misión de tránsito para:"
		S["ITEM"] = "Objeto"
		S["ITEM_LACK"] = "Faltan mas de este articulo"
		S["KILL_TO_START_FORMAT"] = "Matar para iniciar [%s]"
		S["LIVE_COUNTS"] = "Actualizaciones de recuentos de misiones en vivo"
		S["LOAD_DATA"] = "Cargar datos"
		S["LOREMASTER_AREA"] = "Zona de Maestro Cultural"
		S["LOW_LEVEL"] = "Bajo nivel"
		S["MAP"] = "Mapa"
		S["MAP_BUTTON"] = "Mostrar botón en mapa del mundo"
		S["MAP_DUNGEONS"] = "Mostrar misiones de mazmorra en minimapa"
		S["MAP_PINS"] = "Mostrar marcas en el mapa para NPC de inicio de misión"
		S["MAP_UPDATES"] = "Actualizar mapa del mundo al cambiar de zona"
		S["MAPAREA_NONE"] = "Ninguno"
		S["MAXIMUM_LEVEL_NONE"] = "Ninguno"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d misiones de la cadena disponibles"
		S["MUST_KILL_PIN_FORMAT"] = "%s [Matar]"
		S["NEAR"] = "Cerca"
		S["NEEDS_PREREQUISITES"] = "Necesita prerequisitos"
		S["NEVER_ABANDONED"] = "Nunca abandonada"
		S["OAC"] = "Al aceptar completa misiones:"
		S["OCC"] = "Al cumplir los requisitos completa misiones:"
		S["OTC"] = "Al entregar completa misiones:"
		S["OTHER"] = "Otro"
		S["OTHER_PREFERENCE"] = "Otra"
		S["PANEL_UPDATES"] = "Actualizar registro de misiones al cambiar de zona"
		S["PLOT"] = "Plano"
		S["PREPEND_LEVEL"] = "Anteponer nivel de la búsqueda"
		S["PREREQUISITES"] = "Misiones previas"
		S["QUEST_COUNTS"] = "Mostrar recuentos de misiones"
		S["QUEST_ID"] = "ID de misión:"
		S["QUEST_TYPE_NORMAL"] = "Normal"
		S["RACE_ANY"] = "Cualquiera"
		S["RACE_NONE"] = "Ninguna"
		S["RARE_MOBS"] = "Criaturas raras"
		S["REPEATABLE"] = "Repetible"
		S["REPEATABLE_COMPLETED"] = "Mostrar si las misiones repetibles han sido completadas"
		S["REPUTATION_REQUIRED"] = "Reputación requerida:"
		S["REQUIRED_LEVEL"] = "Nivel requerido"
		S["REQUIRES_FORMAT"] = "Wholly requiere la versión %s o mas reciente de Grail"
		S["RESTORE_DIRECTIONAL_ARROWS"] = "No restablecer flechas direccionales"
		S["SEARCH_ALL_QUESTS"] = "Todas las misiones"
		S["SEARCH_CLEAR"] = "Limpiar"
		S["SEARCH_NEW"] = "Nueva"
		S["SELF"] = "Auto"
		S["SHOW_BREADCRUMB"] = "Mostrar información de cadenas de misión en interfaz de misión"
		S["SHOW_BREADCRUMB_MESSAGE"] = "Display breadcrumb message in chat"
		S["SHOW_LOREMASTER"] = "Solo mostrar misiones de Maestro Cultural"
		S["SINGLE_BREADCRUMB_FORMAT"] = "Cadenas de misiones disponibles"
		S["SP_MESSAGE"] = "Misión especial, no entra en registro de misiones de Blizzard"
		S["TAGS"] = "Etiquetas"
		S["TAGS_DELETE"] = "Eliminar Etiqueta"
		S["TAGS_NEW"] = "Añadir Etiqueta"
		S["TITLE_APPEARANCE"] = "Apariencia del título de misión"
		S["TREASURE"] = "Tesoro"
		S["TURNED_IN"] = "Entregada"
		S["UNOBTAINABLE"] = "No obtenible"
		S["WHEN_KILL"] = "Aceptada al matar:"
		S["WIDE_PANEL"] = "Anchura del panel de Misión de Wholly"
		S["WIDE_SHOW"] = "Mostrar"
		S["WORLD_EVENTS"] = "Eventos del mundo"
		S["YEARLY"] = "Anualmente"
	elseif "esMX" == locale then
		S["ABANDONED"] = "Abandonado"
		S["ACCEPTED"] = "Aceptada"
		S["ACHIEVEMENT_COLORS"] = "Mostrar colores de logros completados"
		S["ADD_ADVENTURE_GUIDE"] = "Mostrar la guía de busqueda de aventuras en cada zona"
		S["ALL_FACTION_REPUTATIONS"] = "Mostrar todas las reputaciones de facciones"
		S["APPEND_LEVEL"] = "Añadir nivel requerido"
		S["BASE_QUESTS"] = "Base de Misiones"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Mostrar/ocultar marcas en el mapa"
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Mostrar/ocultar misiones completadas"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Mostrar/ocultar misiones diarias"
		BINDING_NAME_WHOLLY_TOGGLESHOWLOREMASTER = "Alternar muestra master Lore de las misiones"
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Mostrar/ocultar misiones con prerequisitos obligatorios"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Mostrar/ocultar misiones repetibles"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Mostrar/ocultar misiones no obtenibles"
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Mostrar/ocultar misiones semanales"
		BINDING_NAME_WHOLLY_TOGGLESHOWWORLDQUESTS = "Toggle shows World Quests"
		S["BLIZZARD_TOOLTIP"] = "Mostrar la Herramienta de información en el registro de busquedas de Blizzard"
		S["BREADCRUMB"] = "Misiones de senderos migas de pan:"
		S["BUGGED"] = "*** ERROR ***"
		S["BUGGED_UNOBTAINABLE"] = "Misiones con errores se consideran no obtenibles"
		S["BUILDING"] = "Estructura"
		S["CHRISTMAS_WEEK"] = "Semana navideña"
		S["CLASS_ANY"] = "Todas"
		S["CLASS_NONE"] = "Ninguna"
		S["COMPLETED"] = "Completada"
		S["COMPLETION_DATES"] = "Fechas de finalización"
		S["DROP_TO_START_FORMAT"] = "Recojer %s para iniciar [%s]"
		S["EMPTY_ZONES"] = "Mostrar zonas vacías"
		S["ENABLE_COORDINATES"] = "Habilitar coordenadas del jugador"
		S["ENTER_ZONE"] = "Aceptada al entrar al área del mapa"
		S["ESCORT"] = "Escoltar"
		S["EVER_CAST"] = "Ya se ha lanzado"
		S["EVER_COMPLETED"] = "Ya ha sido completada"
		S["EVER_EXPERIENCED"] = "Ya se ha recibido"
		S["FACTION_BOTH"] = "Ambas"
		S["FIRST_PREREQUISITE"] = "Primero en la Cadena de Prerequisitos:"
		S["GENDER"] = "Género"
		S["GENDER_BOTH"] = "Ambos"
		S["GENDER_NONE"] = "Ninguno"
		S["GRAIL_NOT_HAVE"] = "Grail no tiene esta misión"
		S["HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES"] = "Ocultar objetivos de bonificación de Blizzard"
		S["HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES"] = "Hide Blizzard dungeon entrances"
		S["HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS"] = "Ocultar marcadores de mapa de busqueda de Blizzard"
		S["HIDE_BLIZZARD_WORLD_MAP_TREASURES"] = "Ocultar tesoros de Blizzard"
		S["HIDE_WORLD_MAP_FLIGHT_POINTS"] = "Ocultar puntos de vuelo"
		S["HIGH_LEVEL"] = "Nivel Alto"
		S["HOLIDAYS_ONLY"] = "Solo disponible durante eventos:"
		S["IGNORE_REPUTATION_SECTION"] = "Ignorar sección de reputación de busquedas"
		S["IN_LOG"] = "En el Registro"
		S["IN_LOG_STATUS"] = "Mostrar estado de las misiones en el registro"
		S["INVALIDATE"] = "Invalidada por misiones:"
		S["IS_BREADCRUMB"] = "Es un camino de busqueda de migajas para:"
		S["ITEM"] = "Objeto"
		S["ITEM_LACK"] = "Falta objeto"
		S["KILL_TO_START_FORMAT"] = "Matar para iniciar [%s]"
		S["LIVE_COUNTS"] = "Actualizaciones de contadores de busquedas en vivo"
		S["LOAD_DATA"] = "Cargar Data"
		S["LOREMASTER_AREA"] = "Área del Maestro Cultural"
		S["LOW_LEVEL"] = "Nivel Bajo"
		S["MAP"] = "Mapa"
		S["MAP_BUTTON"] = "Mostrar botón en el mapa del mundo"
		S["MAP_DUNGEONS"] = "Mostrar misiones de mazmorras en el mapa exterior"
		S["MAP_PINS"] = "Mostrar marcadores en el mapa para dadores de misiones"
		S["MAP_UPDATES"] = "El mapa del mundo se actualiza cuando se cambia de zona"
		S["MAPAREA_NONE"] = "Ninguna"
		S["MAXIMUM_LEVEL_NONE"] = "Ninguno"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d Búsquedas de sendero de migas de pan disponibles"
		S["MUST_KILL_PIN_FORMAT"] = "%s [Matar]"
		S["NEAR"] = "Cerca"
		S["NEEDS_PREREQUISITES"] = "Necesita prerequisitos"
		S["NEVER_ABANDONED"] = "Nunca abandonada"
		S["OAC"] = "Al aceptar completa las misiones:"
		S["OCC"] = "Al cumplir los requisitos completa las misiones:"
		S["OTC"] = "Al entregar completa las misiones:"
		S["OTHER"] = "Otro"
		S["OTHER_PREFERENCE"] = "Otro"
		S["PANEL_UPDATES"] = "El registro de misiones se actualiza cuando se cambia de zona"
		S["PLOT"] = "Parcela"
		S["PREPEND_LEVEL"] = "Anteponer nivel de la misión"
		S["PREREQUISITES"] = "Prerequisitos:"
		S["QUEST_COUNTS"] = "Mostrar contador de misiones"
		S["QUEST_ID"] = "ID de misión:"
		S["QUEST_TYPE_NORMAL"] = "Normal"
		S["RACE_ANY"] = "Cualquiera"
		S["RACE_NONE"] = "Ninguna"
		S["RARE_MOBS"] = "Criaturas Raras"
		S["REPEATABLE"] = "Repetible"
		S["REPEATABLE_COMPLETED"] = "Mostrar si las misiones repetibles han sido previamente completadas"
		S["REPUTATION_REQUIRED"] = "Reputación Requerida:"
		S["REQUIRED_LEVEL"] = "Nivel Requerido"
		S["REQUIRES_FORMAT"] = "Wholly requiere la versión de Grail %s o superior"
		S["RESTORE_DIRECTIONAL_ARROWS"] = "No se deberían restaurar las flechas de dirección"
		S["SEARCH_ALL_QUESTS"] = "Todas las misiones"
		S["SEARCH_CLEAR"] = "Limpiar buscador"
		S["SEARCH_NEW"] = "Nueva búsqueda"
		S["SELF"] = "Auto"
		S["SHOW_BREADCRUMB"] = "Mostrar la información de la Mision El Sendero de Migas en la Cuadra de Búsqueda"
		S["SHOW_BREADCRUMB_MESSAGE"] = "Display breadcrumb message in chat"
		S["SHOW_LOREMASTER"] = "Solo mostrar misiones del Maestro Cultural"
		S["SINGLE_BREADCRUMB_FORMAT"] = "Mision El Sendero de Migas de Pan Disponible"
		S["SP_MESSAGE"] = "Misiones especiales nunca entran al registro de misiones de Blizzard"
		S["TAGS"] = "Etiquetas"
		S["TAGS_DELETE"] = "Eliminar Etiqueta"
		S["TAGS_NEW"] = "Añadir Etiqueta"
		S["TITLE_APPEARANCE"] = "Apariencia del Título de misión"
		S["TREASURE"] = "Tesoro"
		S["TURNED_IN"] = "Entregada"
		S["UNOBTAINABLE"] = "No obtenible"
		S["WHEN_KILL"] = "Aceptada al matar:"
		S["WIDE_PANEL"] = "Ampliar Wholly Registro de misiones"
		S["WIDE_SHOW"] = "Mostrar"
		S["WORLD_EVENTS"] = "Eventos del mundo"
		S["YEARLY"] = "Anualmente"
	elseif "frFR" == locale then
		S["ABANDONED"] = "Abandonnée"
		S["ACCEPTED"] = "Acceptée"
		S["ACHIEVEMENT_COLORS"] = "Afficher les couleurs de progression des hauts faits"
		S["ADD_ADVENTURE_GUIDE"] = "Afficher le Guide de l'Aventurier dans la section Autres"
		S["ALL_FACTION_REPUTATIONS"] = "Affiche toutes les réputations de factions"
		S["APPEND_LEVEL"] = "Ajouter le niveau minimum requis après le nom de la quête"
		S["BASE_QUESTS"] = "Quête de départ"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Afficher/cacher les marqueurs sur la carte"
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Afficher/cacher les quêtes complétées"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Afficher/cacher les journalières"
		BINDING_NAME_WHOLLY_TOGGLESHOWLOREMASTER = "Basculer l'affichage des quêtes de Loremaster"
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Afficher/cacher les quêtes nécessitants des prérequis"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Afficher/cacher les répétables"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Afficher/cacher les quêtes impossibles à obtenir"
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Afficher/cacher les quêtes hebdomadaires"
		BINDING_NAME_WHOLLY_TOGGLESHOWWORLDQUESTS = "Afficher/Cacher les quêtes mondiales"
		S["BLIZZARD_TOOLTIP"] = "Apparition des info-bulles sur le Journal de quêtes"
		S["BREADCRUMB"] = "Quêtes précédentes (suite de quêtes) :"
		S["BUGGED"] = "*** BOGUÉE ***"
		S["BUGGED_UNOBTAINABLE"] = "Quêtes boguées considérées comme impossibles à obtenir"
		S["BUILDING"] = "Bâtiment"
		S["CHRISTMAS_WEEK"] = "Vacances de Noël"
		S["CLASS_ANY"] = "Toutes"
		S["CLASS_NONE"] = "Aucune"
		S["COMPLETED"] = "Complétées"
		S["COMPLETION_DATES"] = "Date de restitution"
		S["DROP_TO_START_FORMAT"] = "Ramasser %s (butin) pour commencer [%s]"
		S["EMPTY_ZONES"] = "Afficher les zones vides"
		S["ENABLE_COORDINATES"] = "Activer les coordonnées du joueur"
		S["ENTER_ZONE"] = "Accepté(e) lors de l'entrée dans la zone"
		S["ESCORT"] = "Escorte"
		S["EVER_CAST"] = "N'a jamais lancé "
		S["EVER_COMPLETED"] = "N'a jamais été effectuée"
		S["EVER_EXPERIENCED"] = "N'a jamais fait l'expérience de "
		S["FACTION_BOTH"] = "Les deux"
		S["FIRST_PREREQUISITE"] = "Première dans la suite de prérequis :"
		S["GENDER"] = "Sexe"
		S["GENDER_BOTH"] = "Les deux"
		S["GENDER_NONE"] = "Aucun"
		S["GRAIL_NOT_HAVE"] = "Grail n'a pas cette quête dans sa base de données"
		S["HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES"] = "Masquer les objectifs bonus de Blizzard"
		S["HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES"] = "Masquer les entrées d'instance de Blizzard"
		S["HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS"] = "Masquer les marqueurs de quêtes de Blizzard"
		S["HIDE_BLIZZARD_WORLD_MAP_TREASURES"] = "Masquer les trésors de Blizzard"
		S["HIDE_WORLD_MAP_FLIGHT_POINTS"] = "Masquer les points de vol"
		S["HIGH_LEVEL"] = "Haut niveau"
		S["HOLIDAYS_ONLY"] = "Disponible uniquement pendant un évènement mondial :"
		S["IGNORE_REPUTATION_SECTION"] = "Ignorer la section réputation des quêtes"
		S["IN_LOG"] = "Dans le journal"
		S["IN_LOG_STATUS"] = "Afficher l'état des quêtes dans le journal"
		S["INVALIDATE"] = "Invalidé(e) par les quêtes :"
		S["IS_BREADCRUMB"] = "Est le prérequis des quêtes :"
		S["ITEM"] = "Objet"
		S["ITEM_LACK"] = "Objet manquant"
		S["KILL_TO_START_FORMAT"] = "Tuer pour commencer [%s]"
		S["LIVE_COUNTS"] = "Mise à jour en direct du compteur de quêtes"
		S["LOAD_DATA"] = "Chargement des données"
		S["LOREMASTER_AREA"] = "Zone de maître des traditions"
		S["LOW_LEVEL"] = "Bas niveau"
		S["MAP"] = "Carte"
		S["MAP_BUTTON"] = "Afficher le bouton sur la carte du monde"
		S["MAP_DUNGEONS"] = "Afficher les quêtes de donjons sur la carte extérieure"
		S["MAP_PINS"] = "Afficher les marqueurs (!) des donneurs de quêtes sur la carte"
		S["MAP_UPDATES"] = "Mise à jour de la carte du monde lors d'un changement de zone"
		S["MAPAREA_NONE"] = "Aucune"
		S["MAXIMUM_LEVEL_NONE"] = "Aucun"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d quêtes préalables disponibles"
		S["MUST_KILL_PIN_FORMAT"] = "%s [Tuer]"
		S["NEAR"] = "Proche"
		S["NEEDS_PREREQUISITES"] = "Prérequis nécessaires"
		S["NEVER_ABANDONED"] = "Jamais abandonnée"
		S["OAC"] = "Quêtes complétées dès obtention :"
		S["OCC"] = "Quêtes complétées dès complétion des objectifs :"
		S["OTC"] = "Quêtes complétées lorsque rendues :"
		S["OTHER"] = "Autres"
		S["OTHER_PREFERENCE"] = "Autres"
		S["PANEL_UPDATES"] = "Mise à jour du journal de quêtes lors d'un changement de zone"
		S["PLOT"] = "Terrain"
		S["PREPEND_LEVEL"] = "Ajouter le niveau de la quête avant son nom"
		S["PREREQUISITES"] = "Prérequis :"
		S["QUEST_COUNTS"] = "Montrer le nombre de quêtes"
		S["QUEST_ID"] = "ID de quête :"
		S["QUEST_TYPE_NORMAL"] = "Normal"
		S["RACE_ANY"] = "Toutes"
		S["RACE_NONE"] = "Aucune"
		S["RARE_MOBS"] = "Monstres Rare"
		S["REPEATABLE"] = "Répétable"
		S["REPEATABLE_COMPLETED"] = "Afficher si les quêtes répétables ont déjà été terminées auparavant"
		S["REPUTATION_REQUIRED"] = "Réputation nécessaire :"
		S["REQUIRED_LEVEL"] = "Niveau requis"
		S["REQUIRES_FORMAT"] = "Wholly nécessite Grail version %s ou ultérieure"
		S["RESTORE_DIRECTIONAL_ARROWS"] = "Ne devrait pas restaurer les flèches directionnelles"
		S["SEARCH_ALL_QUESTS"] = "Toutes les quêtes"
		S["SEARCH_CLEAR"] = "Effacer"
		S["SEARCH_NEW"] = "Nouvelle"
		S["SELF"] = "Soi-même"
		S["SHOW_BREADCRUMB"] = "Afficher les informations d'une suite de quêtes dans le journal de quêtes"
		S["SHOW_BREADCRUMB_MESSAGE"] = "Display breadcrumb message in chat"
		S["SHOW_LOREMASTER"] = "Afficher uniquement les quêtes comptant pour le haut fait de \"Maître des traditions\""
		S["SINGLE_BREADCRUMB_FORMAT"] = "Quête préalable disponible"
		S["SP_MESSAGE"] = "Certaines quêtes spéciales ne sont jamais affichées dans le journal de quêtes de Blizzard"
		S["TAGS"] = "Tags"
		S["TAGS_DELETE"] = "Supprimer le tag"
		S["TAGS_NEW"] = "Ajouter un tag"
		S["TITLE_APPEARANCE"] = "Apparence de l'intitulé des quêtes"
		S["TREASURE"] = "Trésor"
		S["TURNED_IN"] = "Rendue"
		S["UNOBTAINABLE"] = "Impossible à obtenir"
		S["WHEN_KILL"] = "Accepté(e) en tuant :"
		S["WIDE_PANEL"] = "Journal de quêtes Wholly large"
		S["WIDE_SHOW"] = "Afficher"
		S["WORLD_EVENTS"] = "Événements mondiaux"
		S["YEARLY"] = "Annuelle"
    elseif "itIT" == locale then
		S["ABANDONED"] = "Abbandonata"
		S["ACCEPTED"] = "Accettata"
		S["ACHIEVEMENT_COLORS"] = "Visualizza il colore delle realizzazioni completate"
		S["ADD_ADVENTURE_GUIDE"] = "Display Adventure Guide quests in every zone"
		S["ALL_FACTION_REPUTATIONS"] = "Mostra la reputazione di tutte le fazioni"
		S["APPEND_LEVEL"] = "Posponi livello richiesto"
		S["BASE_QUESTS"] = "Quest di base"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Toggle map pins"
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Attiva/disattiva visualizzazione quest completate"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Attiva/disattiva quest giornaliere"
		BINDING_NAME_WHOLLY_TOGGLESHOWLOREMASTER = "Toggle shows Loremaster quests"
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Attiva/disattiva visualizzazione prerequisiti"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Toggle shows repeatables"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Toggle shows unobtainables"
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Attiva/disattiva visualizzazione quest settimanali"
		BINDING_NAME_WHOLLY_TOGGLESHOWWORLDQUESTS = "Toggle shows World Quests"
		S["BLIZZARD_TOOLTIP"] = "Tooltips appear on Blizzard Quest Log"
		S["BREADCRUMB"] = "Traccia Missioni"
		S["BUGGED"] = "Bug"
		S["BUGGED_UNOBTAINABLE"] = "Missioni buggate considerate non ottenibili"
		S["BUILDING"] = "Building"
		S["CHRISTMAS_WEEK"] = "Settimana di Natale"
		S["CLASS_ANY"] = "Qualsiasi"
		S["CLASS_NONE"] = "Nessuna"
		S["COMPLETED"] = "Completata"
		S["COMPLETION_DATES"] = "Completion Dates"
		S["DROP_TO_START_FORMAT"] = "Drops %s to start [%s]"
		S["EMPTY_ZONES"] = "Mostra le zone vuote"
		S["ENABLE_COORDINATES"] = "Attiva le coordinate del giocatore"
		S["ENTER_ZONE"] = "Accetta quando entri nell'area"
		S["ESCORT"] = "Scorta"
		S["EVER_CAST"] = "Has ever cast"
		S["EVER_COMPLETED"] = "Stata completata"
		S["EVER_EXPERIENCED"] = "Has ever experienced"
		S["FACTION_BOTH"] = "Entrambe"
		S["FIRST_PREREQUISITE"] = "In primo luogo nella catena dei prerequisiti:"
		S["GENDER"] = "Genere"
		S["GENDER_BOTH"] = "Entrambi"
		S["GENDER_NONE"] = "Nessun"
		S["GRAIL_NOT_HAVE"] = "Grail non dispone di questa ricerca"
		S["HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES"] = "Hide Blizzard bonus objectives"
		S["HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES"] = "Hide Blizzard dungeon entrances"
		S["HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS"] = "Hide Blizzard quest map pins"
		S["HIDE_BLIZZARD_WORLD_MAP_TREASURES"] = "Hide Blizzard treasures"
		S["HIDE_WORLD_MAP_FLIGHT_POINTS"] = "Hide flight points"
		S["HIGH_LEVEL"] = "Di livello alto"
		S["HOLIDAYS_ONLY"] = "Disponibile solo durante le vacanze"
		S["IGNORE_REPUTATION_SECTION"] = "Ignora la sezione reputazione delle quest"
		S["IN_LOG"] = "Connettiti"
		S["IN_LOG_STATUS"] = "Mostra lo stato delle quest"
		S["INVALIDATE"] = "Missioni invalidate"
		S["IS_BREADCRUMB"] = "Is breadcrumb quest for:"
		S["ITEM"] = "Oggetto"
		S["ITEM_LACK"] = "Oggetto mancante"
		S["KILL_TO_START_FORMAT"] = "Uccidere per avviare [%s]"
		S["LIVE_COUNTS"] = "Aggiornamento conteggio missioni direttamente"
		S["LOAD_DATA"] = "Caricare i dati"
		S["LOREMASTER_AREA"] = "Loremaster Area"
		S["LOW_LEVEL"] = "Di livello basso"
		S["MAP"] = "Mappa"
		S["MAP_BUTTON"] = "Mostra pulsante mappa del mondo"
		S["MAP_DUNGEONS"] = "Mostra le quest nei dungeon sulla mappa esterna"
		S["MAP_PINS"] = "Mostra sulla mappa le quest da prendere"
		S["MAP_UPDATES"] = "Aggiorna la mappa quando cambio zona"
		S["MAPAREA_NONE"] = "Nessuna"
		S["MAXIMUM_LEVEL_NONE"] = "Nessun"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d Breadcrumb quests available"
		S["MUST_KILL_PIN_FORMAT"] = "%s [Uccidere]"
		S["NEAR"] = "Vicino a"
		S["NEEDS_PREREQUISITES"] = "Prerequisiti richiesti"
		S["NEVER_ABANDONED"] = "Mai abbandonata"
		S["OAC"] = "On acceptance complete quests:"
		S["OCC"] = "Requisiti richiesti per completare la missione"
		S["OTC"] = "On turn in complete quests:"
		S["OTHER"] = "Altro"
		S["OTHER_PREFERENCE"] = "Altre"
		S["PANEL_UPDATES"] = "Aggiorna il pannello log quest quando cambia zona"
		S["PLOT"] = "Plot"
		S["PREPEND_LEVEL"] = "Anteponi Livello missioni"
		S["PREREQUISITES"] = "Prerequisiti missione"
		S["QUEST_COUNTS"] = "Mostra conteggio missioni"
		S["QUEST_ID"] = "ID Missione"
		S["QUEST_TYPE_NORMAL"] = "Normali"
		S["RACE_ANY"] = "Qualsiasi"
		S["RACE_NONE"] = "Nessuna"
		S["RARE_MOBS"] = "Mob rari"
		S["REPEATABLE"] = "Ripetibile"
		S["REPEATABLE_COMPLETED"] = "Visualizza se le missioni ripetibili precedentemente completate"
		S["REPUTATION_REQUIRED"] = "Reputazione richiesta"
		S["REQUIRED_LEVEL"] = "Livello Richiesto"
		S["REQUIRES_FORMAT"] = "Richiede interamente versione Grail %s o versione successiva"
		S["RESTORE_DIRECTIONAL_ARROWS"] = "Should not restore directional arrows"
		S["SEARCH_ALL_QUESTS"] = "Tutte le quest"
		S["SEARCH_CLEAR"] = "Cancella"
		S["SEARCH_NEW"] = "Nuova"
		S["SELF"] = "Se stesso"
		S["SHOW_BREADCRUMB"] = "Mostra informazioni sul percorso della missione sul Quest Frame"
		S["SHOW_BREADCRUMB_MESSAGE"] = "Display breadcrumb message in chat"
		S["SHOW_LOREMASTER"] = "Mostra solo le missioni Loremaster"
		S["SINGLE_BREADCRUMB_FORMAT"] = "Cerca missioni disponibili"
		S["SP_MESSAGE"] = "Missione speciale mai entrata nel diario della Blizzard"
		S["TAGS"] = "Tag"
		S["TAGS_DELETE"] = "Rimuovi Tag"
		S["TAGS_NEW"] = "Aggiungi Tag"
		S["TITLE_APPEARANCE"] = "Mostra titolo quest"
		S["TREASURE"] = "Tesoro"
		S["TURNED_IN"] = "Consegnata"
		S["UNOBTAINABLE"] = "Non ottenibile"
		S["WHEN_KILL"] = "Accetta quando uccidi"
		S["WIDE_PANEL"] = "Ingrandisci il pannello Wholly quest"
		S["WIDE_SHOW"] = "Mostra"
		S["WORLD_EVENTS"] = "Eventi mondiali"
		S["YEARLY"] = "Annuale"
	elseif "koKR" == locale then
		S["ABANDONED"] = "포기"
		S["ACCEPTED"] = "수락함"
		S["ACHIEVEMENT_COLORS"] = "업적 완료 색상을 표시"
		S["ADD_ADVENTURE_GUIDE"] = "모든 지역에서 모험 안내서 퀘스트 표시"
		S["ALL_FACTION_REPUTATIONS"] = "모든 진영 평판 표시"
		S["APPEND_LEVEL"] = "요구 레벨 추가"
		S["BASE_QUESTS"] = "기본 퀘스트"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "지도 핀 표시 여부 전환"
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Toggle shows completed"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "일일 퀘스트 표시 여부 전환"
		BINDING_NAME_WHOLLY_TOGGLESHOWLOREMASTER = "Toggle shows Loremaster quests"
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Toggle shows needs prerequisites"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "반복 가능 퀘스트 표시 여부 전환"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Toggle shows unobtainables"
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "주간 퀘스트 표시 여부 전환"
		BINDING_NAME_WHOLLY_TOGGLESHOWWORLDQUESTS = "Toggle shows World Quests"
		S["BLIZZARD_TOOLTIP"] = "Blizzard 퀘스트 목록에 툴팁 표시"
		S["BREADCRUMB"] = "추가 목표 퀘스트:"
		S["BUGGED"] = "|cffff0000*** 오류 ***|r"
		S["BUGGED_UNOBTAINABLE"] = "불가능한 퀘스트는 오류로 결정"
		S["BUILDING"] = "Building"
		S["CHRISTMAS_WEEK"] = "한겨울 축제 주간"
		S["CLASS_ANY"] = "모두"
		S["CLASS_NONE"] = "없음"
		S["COMPLETED"] = "|cFF00FF00완료한 퀘스트|r"
		S["COMPLETION_DATES"] = "완료 날짜"
		S["DROP_TO_START_FORMAT"] = "Drops %s to start [%s]"
		S["EMPTY_ZONES"] = "빈 지역 표시"
		S["ENABLE_COORDINATES"] = "플레이어 좌표 사용"
		S["ENTER_ZONE"] = "지역에 진입할 떄 수락"
		S["ESCORT"] = "호위"
		S["EVER_CAST"] = "시전한 적 있음"
		S["EVER_COMPLETED"] = "완료한 적 있음"
		S["EVER_EXPERIENCED"] = "받은 적 있음"
		S["FACTION_BOTH"] = "둘다"
		S["FIRST_PREREQUISITE"] = "First in Prerequisite Chain:"
		S["GENDER"] = "성별"
		S["GENDER_BOTH"] = "둘다"
		S["GENDER_NONE"] = "없음"
		S["GRAIL_NOT_HAVE"] = "Grail에 이 퀘스트가 없습니다."
		S["HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES"] = "Hide Blizzard bonus objectives"
		S["HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES"] = "Hide Blizzard dungeon entrances"
		S["HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS"] = "Blizzard 퀘스트 지도 핀 숨김"
		S["HIDE_BLIZZARD_WORLD_MAP_TREASURES"] = "Hide Blizzard treasures"
		S["HIDE_WORLD_MAP_FLIGHT_POINTS"] = "Hide flight points"
		S["HIGH_LEVEL"] = "고레벨"
		S["HOLIDAYS_ONLY"] = "축제 동안에만 이용 가능:"
		S["IGNORE_REPUTATION_SECTION"] = "퀘스트의 평판 부분 무시"
		S["IN_LOG"] = "|cFFFF00FF목록에 있는 퀘스트|r"
		S["IN_LOG_STATUS"] = "퀘스트 진행 상태를 목록에 표시"
		S["INVALIDATE"] = "퀘스트 무효화"
		S["IS_BREADCRUMB"] = "Is breadcrumb quest for:"
		S["ITEM"] = "아이템"
		S["ITEM_LACK"] = "아이템 부족"
		S["KILL_TO_START_FORMAT"] = "Kill to start [%s]"
		S["LIVE_COUNTS"] = "실시간 퀘스트 수 갱신"
		S["LOAD_DATA"] = "데이터 불러오기"
		S["LOREMASTER_AREA"] = "현자 애드온 지역"
		S["LOW_LEVEL"] = "|cFF666666저레벨|r"
		S["MAP"] = "지도에"
		S["MAP_BUTTON"] = "세계 지도에 버튼 표시"
		S["MAP_DUNGEONS"] = "지도에 던전 퀘스트 표시"
		S["MAP_PINS"] = "퀘스트 주는 이를 지도에 핀으로 표시"
		S["MAP_UPDATES"] = "지역이 바뀔 때 세계 지도 갱신"
		S["MAPAREA_NONE"] = "없음"
		S["MAXIMUM_LEVEL_NONE"] = "없음"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "%d 개의 추가 목표 퀘스트가 가능합니다."
		S["MUST_KILL_PIN_FORMAT"] = "%s [죽임]"
		S["NEAR"] = "근처"
		S["NEEDS_PREREQUISITES"] = "|cFFFF0000전제조건이 필요한 퀘스트|r"
		S["NEVER_ABANDONED"] = "버릴 수 없음"
		S["OAC"] = "접수 완료 퀘스트:"
		S["OCC"] = "목표 완료 퀘스트:"
		S["OTC"] = "On turn in complete quests:"
		S["OTHER"] = "기타"
		S["OTHER_PREFERENCE"] = "기타"
		S["PANEL_UPDATES"] = "지역 이동시 퀘스트 목록 갱신"
		S["PLOT"] = "Plot"
		S["PREPEND_LEVEL"] = "퀘스트 레벨 표시"
		S["PREREQUISITES"] = "퀘스트 조건:"
		S["QUEST_COUNTS"] = "퀘스트 개수 표시"
		S["QUEST_ID"] = "퀘스트 ID:"
		S["QUEST_TYPE_NORMAL"] = "일반"
		S["RACE_ANY"] = "모두"
		S["RACE_NONE"] = "없음"
		S["RARE_MOBS"] = "희귀 몹"
		S["REPEATABLE"] = "반복"
		S["REPEATABLE_COMPLETED"] = "완료한 반복 퀘스트 표시"
		S["REPUTATION_REQUIRED"] = "평판 요구 사항:"
		S["REQUIRED_LEVEL"] = "요구 레벨"
		S["REQUIRES_FORMAT"] = "Wholly 애드온은 Grail의 %s 버전 이상을 요구합니다."
		S["RESTORE_DIRECTIONAL_ARROWS"] = "Should not restore directional arrows"
		S["SEARCH_ALL_QUESTS"] = "모든 퀘스트"
		S["SEARCH_CLEAR"] = "초기화"
		S["SEARCH_NEW"] = "신규"
		S["SELF"] = "자신"
		S["SHOW_BREADCRUMB"] = "퀘스트 창에 여러 퀘스트 정보 표시"
		S["SHOW_BREADCRUMB_MESSAGE"] = "Display breadcrumb message in chat"
		S["SHOW_LOREMASTER"] = "Loremaster 퀘스트만 표시"
		S["SINGLE_BREADCRUMB_FORMAT"] = "추가 목표 퀘스트가 가능합니다."
		S["SP_MESSAGE"] = "Special quest never enters Blizzard quest log"
		S["TAGS"] = "태그"
		S["TAGS_DELETE"] = "태그 삭제"
		S["TAGS_NEW"] = "태그 추가"
		S["TITLE_APPEARANCE"] = "퀘스트 제목 모양"
		S["TREASURE"] = "보물"
		S["TURNED_IN"] = "Turned in"
		S["UNOBTAINABLE"] = "|cFF996600불가능한 퀘스트|r"
		S["WHEN_KILL"] = "죽일 때 수락:"
		S["WIDE_PANEL"] = "넓은 Wholly 퀘스트 목록"
		S["WIDE_SHOW"] = "표시"
		S["WORLD_EVENTS"] = "월드 이벤트"
		S["YEARLY"] = "연간"
	elseif "ptBR" == locale then
		S["ABANDONED"] = "Abandonada"
		S["ACCEPTED"] = "Aceita"
		S["ACHIEVEMENT_COLORS"] = "Mostrar cores para conquistas obtidas"
		S["ADD_ADVENTURE_GUIDE"] = "Exibir missões do Guia de Aventura em todas as zonas"
		S["ALL_FACTION_REPUTATIONS"] = "Exibir reputações de todas as facções"
		S["APPEND_LEVEL"] = "Juntar nível necessário"
		S["BASE_QUESTS"] = "Missões-base"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Liga/desliga marcadores de mapa"
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Mostrar concluídas"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Mostrar diárias"
		BINDING_NAME_WHOLLY_TOGGLESHOWLOREMASTER = "Mostrar missões do Mestre Historiador"
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Mostrar pré-requisitos"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Mostrar repetíveis"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Mostrar indisponíveis"
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Mostrar semanais"
		BINDING_NAME_WHOLLY_TOGGLESHOWWORLDQUESTS = "Mostrar Missões de Mundo"
		S["BLIZZARD_TOOLTIP"] = "Dicas são exibidas no Registro de Missões da Blizzard"
		S["BREADCRUMB"] = "Missões em sequência:"
		S["BUGGED"] = "*** COM ERRO ***"
		S["BUGGED_UNOBTAINABLE"] = "Missões com erros consideradas indisponíveis"
		S["BUILDING"] = "Construindo"
		S["CHRISTMAS_WEEK"] = "Semana do Natal"
		S["CLASS_ANY"] = "Qualquer"
		S["CLASS_NONE"] = "Nenhuma"
		S["COMPLETED"] = "Concluída"
		S["COMPLETION_DATES"] = "Data de Conclusão"
		S["DROP_TO_START_FORMAT"] = "Encontre %s para começar [%s]"
		S["EMPTY_ZONES"] = "Exibir zonas vazias"
		S["ENABLE_COORDINATES"] = "Ativar coordenadas do jogador"
		S["ENTER_ZONE"] = "Aceita ao entrar na área do mapa"
		S["ESCORT"] = "Escolta"
		S["EVER_CAST"] = "Já foi lançado"
		S["EVER_COMPLETED"] = "Já foi concluída"
		S["EVER_EXPERIENCED"] = "Já experimentou"
		S["FACTION_BOTH"] = "Ambas"
		S["FIRST_PREREQUISITE"] = "Primeiro na cadeia de pré-requisitos:"
		S["GENDER"] = "Gênero"
		S["GENDER_BOTH"] = "Ambos"
		S["GENDER_NONE"] = "Nenhum"
		S["GRAIL_NOT_HAVE"] = "Grail não tem essa missão"
		S["HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES"] = "Ocultar objetivos bônus da Blizzard"
		S["HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES"] = "Ocultar entradas das masmorras da Blizzard"
		S["HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS"] = "Ocultar marcadores de missões da Blizzard"
		S["HIDE_BLIZZARD_WORLD_MAP_TREASURES"] = "Ocultar tesouros da Blizzard"
		S["HIDE_WORLD_MAP_FLIGHT_POINTS"] = "Ocultar mestres de voo"
		S["HIGH_LEVEL"] = "Nível alto"
		S["HOLIDAYS_ONLY"] = "Disponível apenas durante Feriados:"
		S["IGNORE_REPUTATION_SECTION"] = "Ignorar seção de reputação das missões"
		S["IN_LOG"] = "Em registro"
		S["IN_LOG_STATUS"] = "Exibir estado das missões no registro"
		S["INVALIDATE"] = "Invalidado pelas missões:"
		S["IS_BREADCRUMB"] = "É sequência de missão para:"
		S["ITEM"] = "Item"
		S["ITEM_LACK"] = "Falta Item"
		S["KILL_TO_START_FORMAT"] = "Mate para começar [%s]"
		S["LIVE_COUNTS"] = "Atualizações dinâmicas de contagem de missões"
		S["LOAD_DATA"] = "Carregar Dados"
		S["LOREMASTER_AREA"] = "Área do Mestre Historiador"
		S["LOW_LEVEL"] = "Nível baixo"
		S["MAP"] = " Mapa"
		S["MAP_BUTTON"] = "Exibir botão no mapa-múndi"
		S["MAP_DUNGEONS"] = "Exibir missões de masmorras no mapa externo"
		S["MAP_PINS"] = "Marcar recrutadores no mapa"
		S["MAP_UPDATES"] = "O mapa-múndi atualiza quando a zona muda"
		S["MAPAREA_NONE"] = "Nenhum"
		S["MAXIMUM_LEVEL_NONE"] = "Nenhum"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "Sequência de missões disponíveis %d"
		S["MUST_KILL_PIN_FORMAT"] = "[Matar] %s"
		S["NEAR"] = "Próximo"
		S["NEEDS_PREREQUISITES"] = "Pré-requisitos necessários"
		S["NEVER_ABANDONED"] = "Nunca abandonada"
		S["OAC"] = "Missões que se completam ao aceitar:"
		S["OCC"] = "Missões que se completam ao se cumprir os requisitos:"
		S["OTC"] = "Missões que se completam ao entregar:"
		S["OTHER"] = "Outro"
		S["OTHER_PREFERENCE"] = "Outro"
		S["PANEL_UPDATES"] = "Painel de registro das missões atualiza quando mudar de zona"
		S["PLOT"] = "Trama"
		S["PREPEND_LEVEL"] = "Prefixar nível das missões"
		S["PREREQUISITES"] = "Pré-requisitos:"
		S["QUEST_COUNTS"] = "Exibir contador de missões"
		S["QUEST_ID"] = "ID da missão:"
		S["QUEST_TYPE_NORMAL"] = "Normal"
		S["RACE_ANY"] = "Qualquer"
		S["RACE_NONE"] = "Nenhuma"
		S["RARE_MOBS"] = "Mobs Raros"
		S["REPEATABLE"] = "Repetível"
		S["REPEATABLE_COMPLETED"] = "Mostrar se missões repetíveis já foram concluídas"
		S["REPUTATION_REQUIRED"] = "Requer reputação:"
		S["REQUIRED_LEVEL"] = "Nível Requerido"
		S["REQUIRES_FORMAT"] = "Wholly requer a versão %s do Grail ou maior"
		S["RESTORE_DIRECTIONAL_ARROWS"] = "Não deve restaurar setas direcionais"
		S["SEARCH_ALL_QUESTS"] = "Todas as missões"
		S["SEARCH_CLEAR"] = "Limpar"
		S["SEARCH_NEW"] = "Nova"
		S["SELF"] = "Por si só"
		S["SHOW_BREADCRUMB"] = "Mostrar informações de andamento na Janela de Missões"
		S["SHOW_BREADCRUMB_MESSAGE"] = "Display breadcrumb message in chat"
		S["SHOW_LOREMASTER"] = "Exibir somente missões do Mestre Historiador"
		S["SINGLE_BREADCRUMB_FORMAT"] = "Sequência de missão disponível"
		S["SP_MESSAGE"] = "Missões especiais nunca entram no registro de missões da Blizzard"
		S["TAGS"] = "Rótulos"
		S["TAGS_DELETE"] = "Remover Rótulo"
		S["TAGS_NEW"] = "Novo Rótulo"
		S["TITLE_APPEARANCE"] = "Aparência do Título da Missão"
		S["TREASURE"] = "Tesouro"
		S["TURNED_IN"] = "Entregue"
		S["UNOBTAINABLE"] = "Indisponível"
		S["WHEN_KILL"] = "Aceita quando matar:"
		S["WIDE_PANEL"] = "Painel largo de Missões do Whooly"
		S["WIDE_SHOW"] = "Exibir"
		S["WORLD_EVENTS"] = "Eventos Mundiais"
		S["YEARLY"] = "Anualmente"
	elseif "ruRU" == locale then
		S["ABANDONED"] = "Отменено"
		S["ACCEPTED"] = "Принято"
		S["ACHIEVEMENT_COLORS"] = "Выделять завершение достижения определённым цветом"
		S["ADD_ADVENTURE_GUIDE"] = "Отображать задания Путеводителя по приключениям в каждой зоне"
		S["ALL_FACTION_REPUTATIONS"] = "Показывать репутацию со всеми фракциями"
		S["APPEND_LEVEL"] = "Указывать требуемый уровень"
		S["BASE_QUESTS"] = "Базовые задания"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "Переключить метки на карте"
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "Переключить отображение завершённых заданий"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "Переключить отображение ежедневных заданий"
		BINDING_NAME_WHOLLY_TOGGLESHOWLOREMASTER = "Переключить отображение заданий \"Хранителя мудрости\""
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "Переключить отображение требующих необходимые условия"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "Переключить отображение повторяющихся заданий"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "Переключить отображение недоступных заданий"
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "Переключить отображение еженедельных заданий"
		BINDING_NAME_WHOLLY_TOGGLESHOWWORLDQUESTS = "Переключить отображение локальных заданий"
		S["BLIZZARD_TOOLTIP"] = "Показывать подсказки в журнале заданий"
		S["BREADCRUMB"] = "Направляющие задания:"
		S["BUGGED"] = "*** СЛОМАНО ***"
		S["BUGGED_UNOBTAINABLE"] = "Сломанные задания невозможны для получения"
		S["BUILDING"] = "Здание"
		S["CHRISTMAS_WEEK"] = "Неделя Зимнего Покрова"
		S["CLASS_ANY"] = "Любой"
		S["CLASS_NONE"] = "Нет"
		S["COMPLETED"] = "Завершённые"
		S["COMPLETION_DATES"] = "Даты завершения заданий"
		S["DROP_TO_START_FORMAT"] = "Падает %s, начинается [%s]"
		S["EMPTY_ZONES"] = "Показывать пустые зоны"
		S["ENABLE_COORDINATES"] = "Показывать местоположение игрока"
		S["ENTER_ZONE"] = "Задание, принимаемое при входе в игровую зону"
		S["ESCORT"] = "Задание на сопровождение"
		S["EVER_CAST"] = "Когда-либо произносилось"
		S["EVER_COMPLETED"] = "Когда-либо было выполнено"
		S["EVER_EXPERIENCED"] = "Когда-либо наложилось"
		S["FACTION_BOTH"] = "Обе"
		S["FIRST_PREREQUISITE"] = "Первое в цепочке предварительных:"
		S["GENDER"] = "Пол"
		S["GENDER_BOTH"] = "Оба"
		S["GENDER_NONE"] = "Нет"
		S["GRAIL_NOT_HAVE"] = "Этого задания нет в Grail"
		S["HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES"] = "Скрывать дополнительные задачи"
		S["HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES"] = "Скрывать входы в подземелья"
		S["HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS"] = "Скрывать метки заданий на карте"
		S["HIDE_BLIZZARD_WORLD_MAP_TREASURES"] = "Скрывать сокровища"
		S["HIDE_WORLD_MAP_FLIGHT_POINTS"] = "Скрывать точки полёта"
		S["HIGH_LEVEL"] = "Высокий уровень"
		S["HOLIDAYS_ONLY"] = "Доступны только во время праздничных дней:"
		S["IGNORE_REPUTATION_SECTION"] = "Игнорировать репутационные части заданий"
		S["IN_LOG"] = "В журнале заданий"
		S["IN_LOG_STATUS"] = "Показывать статус заданий в журнале"
		S["INVALIDATE"] = "Недействительное из-за:"
		S["IS_BREADCRUMB"] = "Направляющее задание для:"
		S["ITEM"] = "Предмет"
		S["ITEM_LACK"] = "Предмет отсутствует"
		S["KILL_TO_START_FORMAT"] = "Убить, чтобы начать [%s]"
		S["LIVE_COUNTS"] = "Обновлять в реальном времени"
		S["LOAD_DATA"] = "Загрузить данные"
		S["LOREMASTER_AREA"] = "Хранитель мудрости"
		S["LOW_LEVEL"] = "Низкий уровень"
		S["MAP"] = "Карта"
		S["MAP_BUTTON"] = "Показывать кнопку на карте мира"
		S["MAP_DUNGEONS"] = "Показывать задания в подземельях на карте игровой зоны"
		S["MAP_PINS"] = "Показывать на карте отметки существ, давших задание"
		S["MAP_UPDATES"] = "Обновлять карту мира при смене игровой зоны"
		S["MAPAREA_NONE"] = "Нет"
		S["MAXIMUM_LEVEL_NONE"] = "Нет"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "Доступно направляющих заданий: %d"
		S["MUST_KILL_PIN_FORMAT"] = "%s [убить]"
		S["NEAR"] = "Рядом"
		S["NEEDS_PREREQUISITES"] = "С предварительными"
		S["NEVER_ABANDONED"] = "Не отменялось"
		S["OAC"] = "Задания, завершаемые при принятии:"
		S["OCC"] = "Задания, завершаемые при выполнении условий:"
		S["OTC"] = "Задания, завершаемые при возвращении:"
		S["OTHER"] = "Другое"
		S["OTHER_PREFERENCE"] = "Прочее"
		S["PANEL_UPDATES"] = "Обновлять журнал заданий при смене игровой зоны"
		S["PLOT"] = "Участок"
		S["PREPEND_LEVEL"] = "Показывать уровень задания"
		S["PREREQUISITES"] = "Предварительные задания:"
		S["QUEST_COUNTS"] = "Показывать количество заданий"
		S["QUEST_ID"] = "ID задания:"
		S["QUEST_TYPE_NORMAL"] = "Обычное"
		S["RACE_ANY"] = "Любые"
		S["RACE_NONE"] = "Нет"
		S["RARE_MOBS"] = "Редкие существа"
		S["REPEATABLE"] = "Повторяющиеся"
		S["REPEATABLE_COMPLETED"] = "Показывать ранее выполненные повторяющиеся задания"
		S["REPUTATION_REQUIRED"] = "Требуемая репутация"
		S["REQUIRED_LEVEL"] = "Требуемый уровень"
		S["REQUIRES_FORMAT"] = "Для работы Wholly требуется Grail версии %s или выше"
		S["RESTORE_DIRECTIONAL_ARROWS"] = "Не восстанавливать указатели направления"
		S["SEARCH_ALL_QUESTS"] = "Все задания"
		S["SEARCH_CLEAR"] = "Очистить"
		S["SEARCH_NEW"] = "Новый"
		S["SELF"] = "Само"
		S["SHOW_BREADCRUMB"] = "Показывать наличие направляющих заданий"
		S["SHOW_BREADCRUMB_MESSAGE"] = "Display breadcrumb message in chat"
		S["SHOW_LOREMASTER"] = "Показывать лишь задания, необходимые для получения \"Хранителя мудрости\""
		S["SINGLE_BREADCRUMB_FORMAT"] = "Доступно направляющее задание"
		S["SP_MESSAGE"] = "Особое задание никогда не попадает в журнал заданий Blizzard"
		S["TAGS"] = "Отмеченные"
		S["TAGS_DELETE"] = "Удалить отметку"
		S["TAGS_NEW"] = "Новая отметка"
		S["TITLE_APPEARANCE"] = "Название задания"
		S["TREASURE"] = "Сокровище"
		S["TURNED_IN"] = "Выполнено"
		S["UNOBTAINABLE"] = "Недоступные"
		S["WHEN_KILL"] = "Принимаемое при убийстве:"
		S["WIDE_PANEL"] = "Широкая панель Wholly"
		S["WIDE_SHOW"] = "Показать"
		S["WORLD_EVENTS"] = "Игровые события"
		S["YEARLY"] = "Ежегодные задания"
	elseif "zhCN" == locale then
		S["ABANDONED"] = "已放弃"
		S["ACCEPTED"] = "已接受"
		S["ACHIEVEMENT_COLORS"] = "显示成就完成颜色"
		S["ADD_ADVENTURE_GUIDE"] = "在所有区域显示“冒险指南”任务"
		S["ALL_FACTION_REPUTATIONS"] = "显示全部阵营的声望进度"
		S["APPEND_LEVEL"] = "显示需要等级"
		S["BASE_QUESTS"] = "基础任务"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "切换地图标记"
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "切换显示已完成"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "切换显示日常"
		BINDING_NAME_WHOLLY_TOGGLESHOWLOREMASTER = "切换是否显示“博学者”任务"
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "切换显示需要先决条件"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "切换显示可重复"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "切换显示无法获得"
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "切换显示周常"
		BINDING_NAME_WHOLLY_TOGGLESHOWWORLDQUESTS = "切换显示世界任务"
		S["BLIZZARD_TOOLTIP"] = "工具提示显示在暴雪任务日志中"
		S["BREADCRUMB"] = "引导任务："
		S["BUGGED"] = "*** 错误的 ***"
		S["BUGGED_UNOBTAINABLE"] = "被认为是不可能完成的任务"
		S["BUILDING"] = "建造"
		S["CHRISTMAS_WEEK"] = "圣诞周"
		S["CLASS_ANY"] = "任何"
		S["CLASS_NONE"] = "无"
		S["COMPLETED"] = "已完成"
		S["COMPLETION_DATES"] = "完成日期"
		S["DROP_TO_START_FORMAT"] = "掉落 %s 以开始 [%s]"
		S["EMPTY_ZONES"] = "显示空白区域"
		S["ENABLE_COORDINATES"] = "启用玩家坐标"
		S["ENTER_ZONE"] = "进入地图区域时接受"
		S["ESCORT"] = "护送"
		S["EVER_CAST"] = "曾经施放过"
		S["EVER_COMPLETED"] = "已经完成了"
		S["EVER_EXPERIENCED"] = "曾经经历过"
		S["FACTION_BOTH"] = "两者"
		S["FIRST_PREREQUISITE"] = "先决条件链中的第一个："
		S["GENDER"] = "性別"
		S["GENDER_BOTH"] = "两者"
		S["GENDER_NONE"] = "无"
		S["GRAIL_NOT_HAVE"] = "Grail 资料库内无此任务"
		S["HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES"] = "隐藏暴雪世界地图奖励目标"
		S["HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES"] = "隐藏暴雪世界地图副本入口"
		S["HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS"] = "隐藏暴雪世界地图任务图标"
		S["HIDE_BLIZZARD_WORLD_MAP_TREASURES"] = "隐藏暴雪世界地图宝藏"
		S["HIDE_WORLD_MAP_FLIGHT_POINTS"] = "隐藏飞行点"
		S["HIGH_LEVEL"] = "高等级"
		S["HOLIDAYS_ONLY"] = "仅在节日期间可用："
		S["IGNORE_REPUTATION_SECTION"] = "忽略任务的声望部分"
		S["IN_LOG"] = "在日志中"
		S["IN_LOG_STATUS"] = "在日志中显示任务的状态"
		S["INVALIDATE"] = "此任务无效："
		S["IS_BREADCRUMB"] = "是下列任务的引导任务："
		S["ITEM"] = "物品"
		S["ITEM_LACK"] = "缺少物品"
		S["KILL_TO_START_FORMAT"] = "击杀已开始 [%s]"
		S["LIVE_COUNTS"] = "实时任务计数更新"
		S["LOAD_DATA"] = "读取资料"
		S["LOREMASTER_AREA"] = "博学大师区域"
		S["LOW_LEVEL"] = "低等级"
		S["MAP"] = "地图"
		S["MAP_BUTTON"] = "在世界地图上显示按钮"
		S["MAP_DUNGEONS"] = "在外部地图显示副本任务"
		S["MAP_PINS"] = "在地图上显示任务给予者"
		S["MAP_UPDATES"] = "当区域变更时更新世界地图"
		S["MAPAREA_NONE"] = "无"
		S["MAXIMUM_LEVEL_NONE"] = "无"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "有 %d 个引导任务"
		S["MUST_KILL_PIN_FORMAT"] = "%s [击杀]"
		S["NEAR"] = "靠近"
		S["NEEDS_PREREQUISITES"] = "需要前置"
		S["NEVER_ABANDONED"] = "不可放弃"
		S["OAC"] = "接受时完成任务："
		S["OCC"] = "完成要求时完成任务："
		S["OTC"] = "缴付时完成任务："
		S["OTHER"] = "其他"
		S["OTHER_PREFERENCE"] = "其他"
		S["PANEL_UPDATES"] = "当变更区域时更新任务纪录视窗"
		S["PLOT"] = "空地"
		S["PREPEND_LEVEL"] = "显示任务等级"
		S["PREREQUISITES"] = "前置任务："
		S["QUEST_COUNTS"] = "显示任务计数"
		S["QUEST_ID"] = "任务 ID："
		S["QUEST_TYPE_NORMAL"] = "普通"
		S["RACE_ANY"] = "任意"
		S["RACE_NONE"] = "无"
		S["RARE_MOBS"] = "稀有怪"
		S["REPEATABLE"] = "可重复"
		S["REPEATABLE_COMPLETED"] = "显示已完成过的可重复任务"
		S["REPUTATION_REQUIRED"] = "声望要求"
		S["REQUIRED_LEVEL"] = "等级要求"
		S["REQUIRES_FORMAT"] = "Wholly 需要 %s 或更新的 Grail 版本"
		S["RESTORE_DIRECTIONAL_ARROWS"] = "不重置指向箭头"
		S["SEARCH_ALL_QUESTS"] = "所有任务"
		S["SEARCH_CLEAR"] = "清除"
		S["SEARCH_NEW"] = "新的"
		S["SELF"] = "自己"
		S["SHOW_BREADCRUMB"] = "在接受任务时如果跳过了引导任务，则显示警告"
		S["SHOW_BREADCRUMB_MESSAGE"] = "Display breadcrumb message in chat"
		S["SHOW_LOREMASTER"] = "仅显示博学大师成就相关任务"
		S["SINGLE_BREADCRUMB_FORMAT"] = "可取得引导任务"
		S["SP_MESSAGE"] = "不会进入内建任务纪录的特殊任务"
		S["TAGS"] = "标记"
		S["TAGS_DELETE"] = "删除标记"
		S["TAGS_NEW"] = "新标记"
		S["TITLE_APPEARANCE"] = "任务标题显示"
		S["TREASURE"] = "宝箱"
		S["TURNED_IN"] = "缴付"
		S["UNOBTAINABLE"] = "无法取得"
		S["WHEN_KILL"] = "击杀时取得："
		S["WIDE_PANEL"] = "更宽的 Wholly 任务面板"
		S["WIDE_SHOW"] = "显示"
		S["WORLD_EVENTS"] = "世界事件"
		S["YEARLY"] = "每年"
	elseif "zhTW" == locale then
		S["ABANDONED"] = "已放棄"
		S["ACCEPTED"] = "已接受"
		S["ACHIEVEMENT_COLORS"] = "顯示成就完成顏色"
		S["ADD_ADVENTURE_GUIDE"] = "顯示每個區域的冒險指南"
		S["ALL_FACTION_REPUTATIONS"] = "顯示所有陣營的聲望"
		S["APPEND_LEVEL"] = "後面顯示需要等級"
		S["BASE_QUESTS"] = "任務圖示 - 基本"
		BINDING_NAME_WHOLLY_TOGGLEMAPPINS = "切換地圖圖示"
		BINDING_NAME_WHOLLY_TOGGLESHOWCOMPLETED = "切換已完成的任務"
		BINDING_NAME_WHOLLY_TOGGLESHOWDAILIES = "切換每日任務"
		BINDING_NAME_WHOLLY_TOGGLESHOWLOREMASTER = "切換博學大師任務"
		BINDING_NAME_WHOLLY_TOGGLESHOWNEEDSPREREQUISITES = "切換需要前置的任務"
		BINDING_NAME_WHOLLY_TOGGLESHOWREPEATABLES = "切換重複任務"
		BINDING_NAME_WHOLLY_TOGGLESHOWUNOBTAINABLES = "切換無法取得的任務"
		BINDING_NAME_WHOLLY_TOGGLESHOWWEEKLIES = "切換每周任務"
		BINDING_NAME_WHOLLY_TOGGLESHOWWORLDQUESTS = "切換世界任務"
		S["BLIZZARD_TOOLTIP"] = "在遊戲內建的任務日誌中顯示任務資料庫的滑鼠提示資訊"
		S["BREADCRUMB"] = "後續任務："
		S["BUGGED"] = "*** 有問題的 ***"
		S["BUGGED_UNOBTAINABLE"] = "將有問題的任務視為不可取得"
		S["BUILDING"] = "建築"
		S["CHRISTMAS_WEEK"] = "聖誕週"
		S["CLASS_ANY"] = "任何職業"
		S["CLASS_NONE"] = "無"
		S["COMPLETED"] = "已完成"
		S["COMPLETION_DATES"] = "完成日期"
		S["DROP_TO_START_FORMAT"] = "掉落 %s 開始  [%s]"
		S["EMPTY_ZONES"] = "顯示空的區域"
		S["ENABLE_COORDINATES"] = "在資訊列插件上顯示玩家座標"
		S["ENTER_ZONE"] = "進入區域時取得"
		S["ESCORT"] = "護送"
		S["EVER_CAST"] = "曾經施放"
		S["EVER_COMPLETED"] = "從未完成過"
		S["EVER_EXPERIENCED"] = "有過經驗"
		S["FACTION_BOTH"] = "聯盟 & 部落"
		S["FIRST_PREREQUISITE"] = "前置任務串中的第一個："
		S["GENDER"] = "性別"
		S["GENDER_BOTH"] = "男女皆可"
		S["GENDER_NONE"] = "無"
		S["GRAIL_NOT_HAVE"] = "Grail 資料庫內無此任務"
		S["HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES"] = "隱藏暴雪獎勵目標圖示"
		S["HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES"] = "隱藏內建的副本入口"
		S["HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS"] = "隱藏暴雪地圖任務圖示"
		S["HIDE_BLIZZARD_WORLD_MAP_TREASURES"] = "隱藏暴雪寶藏圖示"
		S["HIDE_WORLD_MAP_FLIGHT_POINTS"] = "隱藏飛行鳥點圖示"
		S["HIGH_LEVEL"] = "高等級"
		S["HOLIDAYS_ONLY"] = "僅在節日時可取得："
		S["IGNORE_REPUTATION_SECTION"] = "忽略任務聲望的部分"
		S["IN_LOG"] = "已接"
		S["IN_LOG_STATUS"] = "在記錄中顯示任務狀態"
		S["INVALIDATE"] = "被下列任務停用："
		S["IS_BREADCRUMB"] = "是下列的後續任務："
		S["ITEM"] = "物品"
		S["ITEM_LACK"] = "缺少物品"
		S["KILL_TO_START_FORMAT"] = "擊殺開始 [%s]"
		S["LIVE_COUNTS"] = "即時更新數量"
		S["LOAD_DATA"] = "讀取資料"
		S["LOREMASTER_AREA"] = "博學大師區域"
		S["LOW_LEVEL"] = "低等級"
		S["MAP"] = "地圖"
		S["MAP_BUTTON"] = "在世界地圖上顯示切換顯示按鈕"
		S["MAP_DUNGEONS"] = "在外部地圖顯示副本任務"
		S["MAP_PINS"] = "在地圖上顯示任務給予者"
		S["MAP_UPDATES"] = "區域變更時更新世界地圖"
		S["MAPAREA_NONE"] = "無"
		S["MAXIMUM_LEVEL_NONE"] = "無"
		S["MULTIPLE_BREADCRUMB_FORMAT"] = "有 %d 個後續任務"
		S["MUST_KILL_PIN_FORMAT"] = "%s [擊殺]"
		S["NEAR"] = "靠近"
		S["NEEDS_PREREQUISITES"] = "需要前置"
		S["NEVER_ABANDONED"] = "從未放棄"
		S["OAC"] = "接受時完成任務"
		S["OCC"] = "完成要求時完成任務"
		S["OTC"] = "交回時完成任務"
		S["OTHER"] = "其他"
		S["OTHER_PREFERENCE"] = "其他"
		S["PANEL_UPDATES"] = "變更區域時更新任務記錄視窗"
		S["PLOT"] = "空地"
		S["PREPEND_LEVEL"] = "前面顯示任務等級"
		S["PREREQUISITES"] = "前置任務："
		S["QUEST_COUNTS"] = "顯示任務數量"
		S["QUEST_ID"] = "任務 ID："
		S["QUEST_TYPE_NORMAL"] = "普通"
		S["RACE_ANY"] = "任何種族"
		S["RACE_NONE"] = "無"
		S["RARE_MOBS"] = "稀有怪"
		S["REPEATABLE"] = "可重複"
		S["REPEATABLE_COMPLETED"] = "顯示已完成過的可重複任務"
		S["REPUTATION_REQUIRED"] = "需要聲望"
		S["REQUIRED_LEVEL"] = "等級要求"
		S["REQUIRES_FORMAT"] = "Wholly 需要 Grail  %s 或更新的版本"
		S["RESTORE_DIRECTIONAL_ARROWS"] = "不要恢復方向箭頭"
		S["SEARCH_ALL_QUESTS"] = "所有任務"
		S["SEARCH_CLEAR"] = "清除"
		S["SEARCH_NEW"] = "新的"
		S["SELF"] = "自己"
		S["SHOW_BREADCRUMB"] = "在任務提示中顯示後續任務資訊"
		S["SHOW_BREADCRUMB_MESSAGE"] = "Display breadcrumb message in chat"
		S["SHOW_LOREMASTER"] = "僅顯示博學大師成就相關任務"
		S["SINGLE_BREADCRUMB_FORMAT"] = "可取得後續任務"
		S["SP_MESSAGE"] = "不在遊戲內建任務記錄的特殊任務"
		S["TAGS"] = "標籤"
		S["TAGS_DELETE"] = "刪除標籤"
		S["TAGS_NEW"] = "新增標籤"
		S["TITLE_APPEARANCE"] = "任務標題"
		S["TREASURE"] = "寶藏"
		S["TURNED_IN"] = "交回"
		S["UNOBTAINABLE"] = "無法取得"
		S["WHEN_KILL"] = "擊殺時取得："
		S["WIDE_PANEL"] = "寬型視窗"
		S["WIDE_SHOW"] = "顯示較寬的任務資料庫視窗"
		S["WORLD_EVENTS"] = "世界事件"
		S["YEARLY"] = "每年"
	end

	-- The first group of these are actually taken from Blizzard's global
	-- variables that represent specific strings.  In other words, these
	-- do not need to be localized since Blizzard does the work for us.
	S['MAILBOX'] = MINIMAP_TRACKING_MAILBOX								-- "Mailbox"
	S['CREATED_ITEMS'] = NONEQUIPSLOT									-- "Created Items"	-- in Classic this is "Not equippable."
	S['SLASH_TARGET'] = SLASH_TARGET1									-- "/target"
	S['SPELLS'] = SPELLS												-- "Spells"
	S['FACTION'] = FACTION												-- "Faction"
	S['ALLIANCE'] = FACTION_ALLIANCE									-- "Alliance"
	S['HORDE'] = FACTION_HORDE											-- "Horde"
	S['ACHIEVEMENTS'] = ACHIEVEMENTS									-- "Achievements"
	S['PROFESSIONS'] = TRADE_SKILLS										-- "Professions"
	S['SKILL'] = SKILL													-- "Skill"
	S['STAGE_FORMAT'] = SCENARIO_STAGE									-- "Stage %d"
	S['CURRENTLY_EQUIPPED'] = CURRENTLY_EQUIPPED						-- "Currently Equipped"
	S['ILEVEL'] = ITEM_LEVEL_ABBR										-- "iLvl"
	S['UNAVAILABLE'] = UNAVAILABLE										-- "Unavailable"
	S['REMOVED'] = ACTION_SPELL_AURA_REMOVED							-- "removed"
	S['PENDING'] = PENDING_INVITE										-- "Pending"
	S['COMPLETED_FORMAT'] = DATE_COMPLETED								-- "Completed: %s"
	S['MAX_LEVEL'] = GUILD_RECRUITMENT_MAXLEVEL							-- "Max Level"
	S['FEMALE'] = FEMALE												-- "Female"
	S['MALE'] = MALE													-- "Male"
	S['REPUTATION_CHANGES'] = COMBAT_TEXT_SHOW_REPUTATION_TEXT			-- "Reputation Changes"	-- in Classic this is "Show Reputation"
	S['QUEST_GIVERS'] = TUTORIAL_TITLE1									-- "Quest Givers"	-- in Classic this is "Questgivers"
	S['TURN_IN'] = TURN_IN_QUEST										-- "Turn in"
	S['DAILY'] = DAILY													-- "Daily"
	S['WEEKLY'] = CALENDAR_REPEAT_WEEKLY								-- "Weekly"
	S['MONTHLY'] = CALENDAR_REPEAT_MONTHLY								-- "Monthly"
	S['DUNGEON'] = CALENDAR_TYPE_DUNGEON								-- "Dungeon"
	S['RAID'] = CALENDAR_TYPE_RAID										-- "Raid"
	S['PVP'] = CALENDAR_TYPE_PVP										-- "PvP"
	S['GROUP'] = CHANNEL_CATEGORY_GROUP									-- "Group"
	S['HEROIC'] = PLAYER_DIFFICULTY2									-- "Heroic"
	S['SCENARIO'] = GUILD_CHALLENGE_TYPE4								-- "Scenario"
	S['IGNORED'] = IGNORED												-- "Ignored"
	S['FAILED'] = FAILED												-- "Failed"
	S['COMPLETE'] = COMPLETE											-- "Complete"
	S['ALPHABETICAL'] = COMPACT_UNIT_FRAME_PROFILE_SORTBY_ALPHABETICAL	-- "Alphabetical"
	S['LEVEL'] = LEVEL													-- "Level"
	S['TYPE'] = TYPE													-- "Type"
	S['TIME_UNKNOWN'] = TIME_UNKNOWN									-- "Unknown"
	S['FILTERS'] = FILTERS												-- "Filters"
	S['WORLD_MAP'] = WORLD_MAP											-- "World Map"
	S['FOLLOWERS'] = GARRISON_FOLLOWERS									-- "Followers"
	S['BONUS_OBJECTIVE'] = TRACKER_HEADER_BONUS_OBJECTIVES				-- "Bonus Objectives"
	S['QUEST_REWARDS'] = QUEST_REWARDS									-- "Rewards"
	S['GAIN_EXPERIENCE_FORMAT'] = GAIN_EXPERIENCE						-- "|cffffffff%d|r Experience"
	S['REWARD_CHOICES'] = REWARD_CHOICES								-- "You will be able to choose one of these rewards:"
	S['PET_BATTLES'] = BATTLE_PET_SOURCE_5								-- "Pet Battle"
	S['PLAYER'] = PLAYER												-- "Player"
	S['WORLD_QUEST'] = TRACKER_HEADER_WORLD_QUESTS						-- "World Quests"
	S['BIWEEKLY'] = CALENDAR_REPEAT_BIWEEKLY							-- "Biweekly"
	S['THREAT_QUEST'] = WORLD_MAP_THREATS								-- "N'Zoth Assaults"
	S['CALLING_QUEST'] = CALLINGS_QUESTS								-- "Callings"

	local C = Wholly.color
	Wholly.configuration = {}
	Wholly.configuration.Wholly = {
		{ S.BASE_QUESTS },
		{ S.COMPLETED, 'showsCompletedQuests', 'configurationScript1', nil, nil, 'C' },
		{ S.NEEDS_PREREQUISITES, 'showsQuestsThatFailPrerequsites', 'configurationScript1', nil, nil, 'P' },
		{ S.UNOBTAINABLE, 'showsUnobtainableQuests', 'configurationScript1', nil, nil, 'B' },
		{ S.FILTERS },
		{ S.REPEATABLE, 'showsRepeatableQuests', 'configurationScript1', nil, nil, 'R' },
		{ S.DAILY, 'showsDailyQuests', 'configurationScript1', nil, nil, 'D' },
		{ S.IN_LOG, 'showsQuestsInLog', 'configurationScript1', nil, nil, 'I' },
		{ S.LOW_LEVEL, 'showsLowLevelQuests', 'configurationScript1', nil, nil, 'W' },
		{ S.HIGH_LEVEL, 'showsHighLevelQuests', 'configurationScript1', nil, nil, 'L' },
		{ S.SCENARIO, 'showsScenarioQuests', 'configurationScript1', nil },
		{ S.WORLD_EVENTS, 'showsHolidayQuests', 'configurationScript1' },
		{ S.IGNORED, 'showsIgnoredQuests', 'configurationScript1', nil },
		{ S.WEEKLY, 'showsWeeklyQuests', 'configurationScript1', nil, nil, 'K' },
		{ S.BONUS_OBJECTIVE, 'showsBonusObjectiveQuests', 'configurationScript1' },
		{ S.RARE_MOBS, 'showsRareMobQuests', 'configurationScript1' },
		{ S.TREASURE, 'showsTreasureQuests', 'configurationScript1' },
		{ S.LEGENDARY, 'showsLegendaryQuests', 'configurationScript1', nil, nil, 'Y' },
		{ S.PET_BATTLES, 'showsPetBattleQuests', 'configurationScript1' },
		{ S.PVP, 'showsPVPQuests', 'configurationScript1' },
		{ S.WORLD_QUEST, 'showsWorldQuests', 'configurationScript1', nil, nil, 'O' },
		}
	Wholly.configuration[S.TITLE_APPEARANCE] = {
		{ S.TITLE_APPEARANCE },
		{ S.PREPEND_LEVEL, 'prependsQuestLevel', 'configurationScript1' },
		{ S.APPEND_LEVEL, 'appendRequiredLevel', 'configurationScript1' },
		{ S.REPEATABLE_COMPLETED, 'showsAnyPreviousRepeatableCompletions', 'configurationScript1' },
		{ S.IN_LOG_STATUS, 'showsInLogQuestStatus', 'configurationScript7' },
		}
	Wholly.configuration[S.WORLD_MAP] = {
		{ S.WORLD_MAP },
		{ S.MAP_PINS, 'displaysMapPins', 'configurationScript2', nil, 'pairedConfigurationButton' },
		{ S.MAP_PINS_TURNIN, 'displaysMapPinsTurnin', 'configurationScript2' },
		{ S.MAP_PINS_TURNIN_INCOMPLETE, 'displaysMapPinsTurninIncomplete', 'configurationScript2' },
		{ S.MAP_BUTTON, 'displaysMapFrame', 'configurationScript3' },
		{ S.MAP_DUNGEONS, 'displaysDungeonQuests', 'configurationScript4' },
		{ S.MAP_UPDATES, 'updatesWorldMapOnZoneChange', 'configurationScript1' },
--		{ S.HIDE_BLIZZARD_WORLD_MAP_TREASURES, 'hidesWorldMapTreasures', 'configurationScript16' },
--		{ S.HIDE_BLIZZARD_WORLD_MAP_BONUS_OBJECTIVES, 'hidesBlizzardWorldMapBonusObjectives', 'configurationScript17' },
--		{ S.HIDE_BLIZZARD_WORLD_MAP_QUEST_PINS, 'hidesBlizzardWorldMapQuestPins', 'configurationScript16' },
--		{ S.HIDE_BLIZZARD_WORLD_MAP_DUNGEON_ENTRANCES, 'hidesDungeonEntrances', 'configurationScript23' },
		}
	Wholly.configuration[S.WIDE_PANEL] = {
		{ S.WIDE_PANEL },
		{ S.WIDE_SHOW, 'useWidePanel', 'configurationScript11' },
		{ S.QUEST_COUNTS, 'showQuestCounts', 'configurationScript12',  },
		{ S.LIVE_COUNTS, 'liveQuestCountUpdates', 'configurationScript13',  },
		}
	Wholly.configuration[S.LOAD_DATA] = {
		{ S.LOAD_DATA },
		{ S.ACHIEVEMENTS, 'loadAchievementData', 'configurationScript9' },
		{ S.REPUTATION_CHANGES, 'loadReputationData', 'configurationScript10', },
		{ S.COMPLETION_DATES, 'loadDateData', 'configurationScript14', },
--		{ S.QUEST_REWARDS, 'loadRewardData', 'configurationScript15', },
		}
	Wholly.configuration[S.OTHER_PREFERENCE] = {
		{ S.OTHER_PREFERENCE },
		{ S.PANEL_UPDATES, 'updatesPanelWhenZoneChanges', 'configurationScript1' },
		{ S.HIDE_ID_ON_QUEST_FRAME, 'hidesIDOnQuestPanel', 'configurationScript24' },
		{ S.SHOW_BREADCRUMB, 'displaysBreadcrumbs', 'configurationScript5' },
		{ S.SHOW_BREADCRUMB_MESSAGE, 'displaysBreadcrumbMessages', 'configurationScript5' },
		{ S.SHOW_LOREMASTER, 'showsLoremasterOnly', 'configurationScript4' },
		{ S.ENABLE_COORDINATES, 'enablesPlayerCoordinates', 'configurationScript8', nil, 'pairedCoordinatesButton' },
		{ S.ACHIEVEMENT_COLORS, 'showsAchievementCompletionColors', 'configurationScript1' },
		{ S.BUGGED_UNOBTAINABLE, 'buggedQuestsConsideredUnobtainable', 'configurationScript4' },
		{ S.BLIZZARD_TOOLTIP, 'displaysBlizzardQuestTooltips', 'configurationScript13' },
		{ S.ALL_FACTION_REPUTATIONS, 'showsAllFactionReputations', 'configurationScript1' },
		{ S.EMPTY_ZONES, 'displaysEmptyZones', 'configurationScript18' },
		{ S.IGNORE_REPUTATION_SECTION, 'ignoreReputationQuests', 'configurationScript1' },
		{ S.RESTORE_DIRECTIONAL_ARROWS, 'shouldNotRestoreDirectionalArrows', 'configurationScript1' },
		{ S.ADD_ADVENTURE_GUIDE, 'shouldAddAdventureGuideQuests', 'configurationScript4' },
		}

	Wholly.poisToHide = {}
	Wholly._HidePOIs = function(self)
		if not InCombatLockdown() then
			local wpth = self.poisToHide
			for i = 1, #wpth do
				wpth[i]:Hide()
			end
			Wholly.poisToHide = {}
		else
			self.combatHidePOI = true
			self.notificationFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		end
	end

-- Starting in BfA beta 26567 there is no more WorldMapFrame_Update so we cannot support this at the moment...
--if not Grail.battleForAzeroth then
--hooksecurefunc("WorldMapFrame_Update", function()
--	local wpth = Wholly.poisToHide
--	if WhollyDatabase.hidesWorldMapFlightPoints or WhollyDatabase.hidesWorldMapTreasures or WhollyDatabase.hidesDungeonEntrances then
--		for i = 1, GetNumMapLandmarks() do
--			local landmarkType, name, description, textureIndex, x, y = GetMapLandmarkInfo(i)
--			local shouldHide = false
--			if WhollyDatabase.hidesWorldMapTreasures and 197 == textureIndex then shouldHide = true end
--			if WhollyDatabase.hidesDungeonEntrances and LE_MAP_LANDMARK_TYPE_DUNGEON_ENTRANCE == landmarkType then shouldHide = true end
--			if WhollyDatabase.hidesWorldMapFlightPoints and LE_MAP_LANDMARK_TYPE_TAXINODE == landmarkType then shouldHide = true end
--			if shouldHide then
--				local poi = _G["WorldMapFramePOI"..i]
--				if poi then
--				-- The "if poi then" check is probably not needed, but better safe than sorry!
----					print("Hiding icon for",name)
----					poi:Hide()
--					wpth[#wpth + 1] = poi
--				end
--			end
--		end
--	end
--	if WhollyDatabase.hidesBlizzardWorldMapQuestPins then
--		for i = 1, C_Questline.GetNumAvailableQuestlines() do
--			local poi = _G["WorldMapStoryLine"..i]
--			if poi then
--				wpth[#wpth + 1] = poi
--			end
--		end
--	end
--	Wholly:_HidePOIs()
--end)
--end

-- Starting in BfA beta 26567 there is no more WorldMap_UpdateQuestBonusObjectives so we cannot support this at the moment...
--if not Grail.battleForAzeroth then
--hooksecurefunc("WorldMap_UpdateQuestBonusObjectives", function()
--	if WhollyDatabase.hidesBlizzardWorldMapBonusObjectives then
--		local mapAreaID = Grail.GetCurrentDisplayedMapAreaID()
--		local taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(mapAreaID)
--		local numTaskPOIs = 0;
--		if(taskInfo ~= nil) then
--			numTaskPOIs = #taskInfo;
--		end
--		local taskIconCount = 1;
--		if ( numTaskPOIs > 0 ) then
--			local wpth = Wholly.poisToHide
--			for _, info  in next, taskInfo do
--				local taskPOIName = "WorldMapFrameTaskPOI"..taskIconCount;
--				local taskPOI = _G[taskPOIName];
----				taskPOI:Hide();
--				wpth[#wpth + 1] = taskPOI
--				taskIconCount = taskIconCount + 1;
--			end
--			Wholly:_HidePOIs()
--		end
--	end
--end)
--end

Wholly.GetMapProvidersForMixin = function(mapCanvas, mixin)
	local retval = {}
    for provider in pairs(mapCanvas.dataProviders) do
        if provider.RemoveAllData == mixin.RemoveAllData then
			tinsert(retval, provider)
        end
    end
    return retval
end


end
