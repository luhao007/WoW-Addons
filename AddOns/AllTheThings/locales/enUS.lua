--------------------------------------------------------------------------------
--						L O C A L I Z A T I O N  F I L E					  --
--------------------------------------------------------------------------------
--						English / United States (default)					  --
--------------------------------------------------------------------------------
--				Maintained By Dylan Fortune (http://dylanfortune.com)		  --
--------------------------------------------------------------------------------
--	 A localization file contains a single dictionary that populates a table  --
--------------------------------------------------------------------------------
--				This script is called directly after the Core.lua file. 	  --
--------------------------------------------------------------------------------

local name, app = ...;
app.L = {
	-- General Text
	["TITLE"] = "|cffb4b4ffALL THE THINGS|r";
	["AUCTION_TAB"] = "|cffb4b4ffATT|r";
	["DESCRIPTION"] = "\"Foolishly you have sought your own demise. Brazenly you have disregarded powers beyond your understanding. You have fought hard to invade the realm of the Collector. Now there is only one way out - To walk the lonely path... of the damned.\"";
	["THINGS_UNTIL"] = " THINGS UNTIL ";
	["THING_UNTIL"] = " THING UNTIL ";
	["YOU_DID_IT"] = "YOU DID IT!|r";


	-- Big new chunk from AllTheThings.lua
	["PROGRESS"] = "Progress";
	["TRACKING_PROGRESS"] = "Tracking Progress";
	["COLLECTED_STRING"] = " Collected";
	["PROVIDERS"] = "Provider(s)";
	["COLLECTION_PROGRESS"] = "Collection Progress";
	["CONTAINS"] = "Contains:";
	["FACTIONS"] = "Factions";
	["COORDINATES_STRING"] = "Coordinates";
	["FLIGHT_PATHS"] = "Flight Paths";
	["KNOWN_BY"] = "Known by ";
	["REQUIRES"] = "Requires";
	["RACE_LOCKED"] = "Race Locked";
	["PLEASE_REPORT_MESSAGE"] = ": Please report this to the ATT Discord in #errors! Thanks!";
	["NOT_AVAILABLE_IN_PL"] = "Not available in Personal Loot.";
	["MARKS_OF_HONOR_DESC"] = "Marks of Honor must be viewed in a Popout window to see all of the normal 'Contains' content.\n(Type '/att ' in chat then Shift-Click to link the item)\n\n|cFFfe040fAfter purchasing and using an ensemble, relogging & a forced ATT refresh (in this order)\nmay be required to register all the items correctly.|r";
	["ITEM_GIVES_REP"] = "Provides Reputation with '";
	["COST"] = "Cost";
	["COST_DESC"] = "This contains the visual breakdown of what is required to obtain or purchase this Thing";
	["SOURCES"] = "Source(s)";
	["SOURCES_DESC"] = "Shows the Source of this Thing.\n\nParticularly, a specific Vendor/NPC, Quest, Encounter, etc.";
	["WRONG_FACTION"] = "You might need to be on the other faction to view this.";
	["ARTIFACT_INTRO_REWARD"] = "Awarded for completing the introductory quest for this Artifact.";
	["WE_JUST_HATE_TIMEWALKING"] = "Timewalking difficulties needlessly create new Source IDs for items despite having the exact same name, appearance, and display in the Collections Tab.\n\nA plea to the Blizzard Devs: Please clean up the Source ID database and have your Timewalking / Titanforged item variants use the same Source ID as their base assuming the appearances and names are exactly the same. Not only will this make your database much cleaner, but it will also make Completionists excited for rather than dreading the introduction of more Timewalking content.\n\n - Crieve, the Very Bitter Account Completionist that had 99% Ulduar completion and now only has 64% because your team duplicated the Source IDs rather than reuse the existing one.";
	["FACTION_SPECIFIC_REP"] = "Not all reputations can be viewed on a single character. IE: Warsong Outriders cannot be viewed by an Alliance Player and Silverwing Sentinels cannot be viewed by a Horde Player.";
	["VISIT_FLIGHT_MASTER"] = "Visit the Flight Master to cache.";
	["FLIGHT_PATHS_DESC"] = "Flight paths are cached when you talk to the flight master on each continent.\n  - Crieve";
	["FOLLOWERS_COLLECTION_DESC"] = "Followers can be collected Account Wide. Unlocking them on one toon will count as collected across all your characters in ATT. \n\nYou must manually refresh the addon by Shift+Left clicking the header for this to be detected.";
	["HEIRLOOM_TEXT"] = "Unlocked Heirloom";
	["HEIRLOOM_TEXT_DESC"] = "This indicates whether or not you have acquired or purchased the heirloom yet.";
	["FAILED_ITEM_INFO"] = "Failed to acquire item information. The item may be invalid or may not have been cached on your server yet.";
	["HEIRLOOMS_UPGRADES_DESC"] = "This indicates whether or not you have upgraded the heirloom to a certain level.\n\nR.I.P. Gold.\n - Crieve";
	["MUSIC_ROLLS_AND_SELFIE_DESC"] = "These are unlocked per-character and are not currently shared across your account. If someone at Blizzard is reading this, it would be really swell if you made these account wide.\n\nYou must manually refresh the addon by Shift+Left clicking the header for this to be detected.";
	["MUSIC_ROLLS_AND_SELFIE_DESC_2"] = "\n\nYou must first unlock the Music Rolls by completing the Bringing the Bass in your garrison for this item to drop.\n\nSelfies require the S.E.L.F.I.E Toy.";
	["OPPOSITE_FACTION_EQ"] = "Opposite faction equivalent: ";
	["SELFIE_DESC"] = "Take a selfie using your ";
	["SELFIE_DESC_2"] = " with |cffff8000";
	["CLASSIC_TIER_DESC"] = "Four years after the Battle of Mount Hyjal, tensions between the Alliance & the Horde begin to arise once again. Intent on settling the arid region of Durotar, Thrall's new Horde expanded its ranks, inviting the undead Forsaken to join orcs, tauren, & trolls. Meanwhile, dwarves, gnomes & the ancient night elves pledged their loyalties to a reinvigorated Alliance, guided by the human kingdom of Stormwind. After Stormwind's king, Varian Wrynn, mysteriously disappeared, Highlord Bolvar Fordragon served as Regent but his service was marred by the manipulations & mind control of the Onyxia, who ruled in disguise as a human noblewoman. As heroes investigated Onyxia's manipulations, ancient foes surfaced in lands throughout the world to menace Horde & Alliance alike.";
	["TBC_TIER_DESC"] = "The Burning Crusade is the first expansion. Its main features include an increase of the level cap up to 70, the introduction of the blood elves & the draenei as playable races, & the addition of the world of Outland, along with many new zones, dungeons, items, quests, & monsters.";
	["WOTLK_TIER_DESC"] = "Wrath of the Lich King is the second expansion. The majority of the expansion content takes place in Northrend & centers around the plans of the Lich King. Content highlights include the increase of the level cap from 70 to 80, the introduction of the death knight Hero class, & new PvP/World PvP content.";
	["CATA_TIER_DESC"] = "Cataclysm is the third expansion. Set primarily in a dramatically reforged Kalimdor & Eastern Kingdoms on the world of Azeroth, the expansion follows the return of Deathwing, who causes a new Sundering as he makes his cataclysmic re-entrance into the world from Deepholm. Cataclysm returns players to the two continents of Azeroth for most of their campaigning, opening new zones such as Mount Hyjal, the sunken world of Vashj'ir, Deepholm, Uldum and the Twilight Highlands. It includes two new playable races, the worgen & the goblins. The expansion increases level cap to 85, adds the ability to fly in Kalimdor & Eastern Kingdoms, introduces Archaeology & reforging, & restructures the world itself.";
	["MOP_TIER_DESC"] = "Mists of Pandaria is the fourth expansion pack. The expansion refocuses primarily on the war between the Alliance & Horde, in the wake of the accidental rediscovery of Pandaria. Adventurers rediscover the ancient pandaren people, whose wisdom will help guide them to new destinies; the Pandaren Empire's ancient enemy, the mantid; and their legendary oppressors, the enigmatic mogu. The land changes over time & the conflict between Varian Wrynn & Garrosh Hellscream escalates. As civil war wracks the Horde, the Alliance & forces in the Horde opposed to Hellscream's violent uprising join forces to take the battle directly to Hellscream & his Sha-touched allies in Orgrimmar.";
	["WOD_TIER_DESC"] = "Warlords of Draenor is the fifth expansion. Across Draenor's savage jungles & battle-scarred plains, Azeroth's heroes will engage in a mythic conflict involving mystical draenei champions & mighty orc clans, & cross axes with the likes of Grommash Hellscream, Blackhand, & Ner’zhul at the height of their primal power. Players will need to scour this unwelcoming land in search of allies to help build a desperate defense against the old Horde’s formidable engine of conquest, or else watch their own world’s bloody, war-torn history repeat itself.";
	["LEGION_TIER_DESC"] = "Legion is the sixth expansion. Gul'dan is expelled into Azeroth to reopen the Tomb of Sargeras & the gateway to Argus, commencing the third invasion of the Burning Legion. After the defeat at the Broken Shore, the defenders of Azeroth search for the Pillars of Creation, which were Azeroth's only hope for closing the massive demonic portal at the heart of the Tomb. However, the Broken Isles came with their own perils to overcome, from Xavius, to God-King Skovald, to the nightborne, & to Tidemistress Athissa. Khadgar moved Dalaran to the shores of this land, the city serves as a central hub for the heroes. The death knights of Acherus also took their floating necropolis to the Isles. The heroes of Azeroth sought out legendary artifact weapons to wield in battle, but also found unexpected allies in the form of the Illidari. Ongoing conflict between the Alliance & the Horde led to the formation of the class orders, with exceptional commanders putting aside faction to lead their classes in the fight against the Legion.";
	["BFA_TIER_DESC"] = "Battle for Azeroth is the seventh expansion. Azeroth paid a terrible price to end the apocalyptic march of the Legion's crusade—but even as the world's wounds are tended, it is the shattered trust between the Alliance and Horde that may prove the hardest to mend. In Battle for Azeroth, the fall of the Burning Legion sets off a series of disastrous incidents that reignites the conflict at the heart of the Warcraft saga. As a new age of warfare begins, Azeroth's heroes must set out on a journey to recruit new allies, race to claim the world's mightiest resources, and fight on several fronts to determine whether the Horde or Alliance will lead Azeroth into its uncertain future.";
	["SL_TIER_DESC"] = "Shadowlands is the eighth expansion. What lies beyond the world you know? The Shadowlands, resting place for every mortal soul—virtuous or vile—that has ever lived.";
	["TITLES_DESC"] = "Titles are tracked across your account, however, your individual character must qualify for certain titles to be usable on that character.";
	["SHARED_APPEARANCES_LABEL"] = "Shared Appearances";
	["SHARED_APPEARANCES_LABEL_DESC"] = "The items in this list are shared appearances for the above item. In Unique Appearance Mode, this list can help you understand why or why not a specific item would be marked Collected.";
	["UNIQUE_APPEARANCE_LABEL"] = "Unique Appearance";
	["UNIQUE_APPEARANCE_LABEL_DESC"] = "This item has a Unique Appearance. You must collect this item specifically to earn the appearance.";
	["UPON_COMPLETION"] = "Upon Completion";
	["UPON_COMPLETION_DESC"] = "The above quests need to be completed before being able to complete the things listed below.";
	["QUEST_CHAIN_REQ"] = "Quest Chain Requirements";
	["QUEST_CHAIN_REQ_DESC"] = "The following quests need to be completed before being able to complete the final quest.";
	["AH_SEARCH_NO_ITEMS_FOUND"] = "No cached items found in search. Expand the group and view the items to cache the names and try again. Only Bind on Equip items will be found using this search.";
	["AH_SEARCH_BOE_ONLY"] = "Only Bind on Equip items can be found using this search.";
	["TSM_WARNING_1"] = "Running this command can potentially destroy your existing TSM settings by reassigning items to the ";
	["TSM_WARNING_2"] = " preset.\n\nWe recommend that you use a different profile when using this feature.\n\nDo you want to proceed anyways?";
	["PRESET_UPDATE_SUCCESS"] = "Updated the preset successfully.";
	["SHOPPING_OP_MISSING_1"] = "The preset is missing a 'Shopping' Operation assignment.";
	["SHOPPING_OP_MISSING_2"] = "Type '/tsm operations' to create or assign one.";
	["AUCTIONATOR_GROUPS"] = "Group-based searches are only supported using Auctionator.";
	["TSM4_ERROR"] = "TSM4 is not compatible with ATT yet. If you know how to create Presets like we used to do in TSM3, please whisper Crieve on Discord!";
	["QUEST_MAY_BE_REMOVED"] = "Failed to acquire information. This quest may have been removed from the game. ";
	["MINUMUM_STANDING"] = "Requires a minimum standing of";
	["_WITH_"] = " with ";
	["MAXIMUM_STANDING"] = "Requires a standing lower than";
	["MIN_MAX_STANDING"] = "Requires a standing between";
	["AND_"] = "And ";
	["_AND"] = " and";
	["_MORE"] = " more";
	["_OTHER_SOURCES"] = " other sources";
	["DURING_WQ_ONLY"] = "This can be completed when the world quest is active.";
	["COMPLETED_DAILY"] = "This can be completed daily.";
	["COMPLETED_WEEKLY"] = "This can be completed weekly.";
	["COMPLETED_MONTHLY"] = "This can be completed monthly.";
	["COMPLETED_YEARLY"] = "This can be completed yearly.";
	["COMPLETED_MULTIPLE"] = "This can be repeated multiple times.";
	["CRITERIA_FOR"] = "Criteria for";
	["CURRENCY_FOR"] = "Currency for";
	["LOOT_TABLE_CHANCE"] = "Loot Table Chance";
	["BEST_BONUS_ROLL_CHANCE"] = "Best Bonus Roll Chance";
	["BEST_PERSONAL_LOOT_CHANCE"] = "Best Personal Loot Chance";
	["BONUS_ROLL"] = "Bonus Roll";
	["PREREQUISITE_QUESTS"] = "There are prerequisite quests that must be completed before this may be obtained:";
	["BREADCRUMBS_WARNING"] = "There are breadcrumb quests that may be not be obtainable after completing this:";
	["THIS_IS_BREADCRUMB"] = "This is a breadcrumb quest.";
	["BREADCRUMB_PARTYSYNC"] = "This may be unable to be completed without Party Sync if completing any of these quests first:";
	["BREADCRUMB_PARTYSYNC_2"] = "This may be obtained via Party Sync with another character that has not completed any of these quests:";
	["BREADCRUMB_PARTYSYNC_3"] = "This may be obtained via Party Sync with a character that is able to accept this quest.";
	["NO_ENTRIES"] = "No entries matching your filters were found.";
	["NO_ENTRIES_DESC"] = "If you believe this was in error, try activating 'Debug Mode'. One of your filters may be restricting the visibility of the group.";
	["DEBUG_LOGIN"] = "Awarded for logging in.\n\nGood job! YOU DID IT!\n\nOnly visible while in Debug Mode.";
	["UNSORTED_1"] = "Unsorted";
	["UNSORTED_2"] = " (Unsorted)";
	["UNSORTED_DESC"] = "This data hasn't been implemented yet.";
	["NEVER_IMPLEMENTED"] = "Never Implemented";
	["NEVER_IMPLEMENTED_DESC"] = "Items here technically exist within the game but have never been made available to players";
	["HIDDEN_QUEST_TRIGGERS"] = "Hidden Quest Triggers";
	["HIDDEN_QUEST_TRIGGERS_DESC"] = "These are Quests which have been manually determined to trigger based on specific criteria and are mainly used internally by the game for tracking purposes";
	["UNSORTED_DESC_2"] = "Items here exist within the game and may be available to players, but have not yet been sourced into the accurate location in ATT";
	["BOUNTY_DESC"] = "This list contains Unobtainable items that the ATT Discord has reported as bugs that Blizzard has yet to fix.\n\nNOTE: All filters are ignored within this list for visibility. Only items removed from the game due to negligence rather than a gigantic fire breathing dragon are present on this list.\n\nTo Blizzard Devs: Please fix the items and encounters listed below.";
	["OPEN_AUTOMATICALLY"] = "Open Automatically";
	["OPEN_AUTOMATICALLY_DESC"] = "If you aren't a Blizzard Developer, it might be a good idea to uncheck this. This was done to force Blizzard to fix and/or acknowledge these bugs.";
	["TWO_CLOAKS"] = "|cffFF0000These two cloaks have very limited confirmed drops if any and are presumed broken!|r";
	["OGOM_THE_MANGLER_DESC"] = "|cffFF0000Ogom the Mangler seems just to spawn when you are doing the Daily 'Assualt on the Iron Siegeworks'. This Quest wasn't active since the start of Legion and the buyable Quest 'Missive: Assault on the Iron Siegeworks' does not work either.|r";
	["HOLYDAY_DESC"] = "A specific holiday may need to be active for you to complete the referenced Things within this section.";
	["DIFF_COMPLETED_1"] = "You have collected everything from this difficulty. Switch to ";
	["DIFF_COMPLETED_2"] = " instead.";
	["MINI_LIST"] = "Mini List";
	["MINI_LIST_DESC"] = "This list contains the relevant information for your current zone, which cannot be found in the ATT database";
	["UPDATE_LOCATION_NOW"] = "Update Location Now";
	["UPDATE_LOCATION_NOW_DESC"] = "If you wish to forcibly refresh the data to your current Map, click this button now!";
	["PERSONAL_LOOT_DESC"] = "Each player has an independent chance at looting an item useful for their class...\n\n... Or useless things like rings.\n\nClick twice to create a group automatically if you're by yourself.";
	["RAID_ASSISTANT"] = "Raid Assistant";
	["RAID_ASSISTANT_DESC"] = "Never enter the instance with the wrong settings again! Verify that everything is as it should be!";
	["LOOT_SPEC_UNKNOWN"] = "Loot Specialization Unknown";
	["LOOT_SPEC"] = "Loot Specialization";
	["LOOT_SPEC_DESC"] = "In Personal Loot dungeons, raids, and outdoor encounters, this setting will dictate which items are available for you.\n\nClick this row to change it now!";
	["DUNGEON_DIFF"] = "Dungeon Difficulty";
	["DUNGEON_DIFF_DESC"] = "The difficulty setting for dungeons.\n\nClick this row to change it now!";
	["RAID_DIFF"] = "Raid Difficulty";
	["RAID_DIFF_DESC"] = "The difficulty setting for raids.\n\nClick this row to change it now!";
	["LEGACY_RAID_DIFF"] = "Legacy Raid Difficulty";
	["LEGACY_RAID_DIFF_DESC"] = "The difficulty setting for legacy raids.\n\nClick this row to change it now!";
	["TELEPORT_TO_FROM_DUNGEON"] = "Teleport to/from Dungeon";
	["TELEPORT_TO_FROM_DUNGEON_DESC"] = "Click here to teleport to/from your current instance.\n\nYou can utilize the Mists of Pandaria Scenarios to quickly teleport yourself outside of your current instance this way.";
	["RESET_INSTANCES"] = "Reset Instances";
	["RESET_INSTANCES_DESC"] = "Click here to reset your instances.\n\nAlt+Click to toggle automatically resetting your instances when you leave a dungeon.\n\nWARNING: BE CAREFUL WITH THIS!";
	["DELIST_GROUP"] = "Delist Group";
	["DELIST_GROUP_DESC"] = "Click here to delist the group. If you are by yourself, it will softly leave the group without porting you out of any instance you are in.";
	["LEAVE_GROUP"] = "Leave Group";
	["LEAVE_GROUP_DESC"] = "Click here to leave the group. In most instances, this will also port you to the nearest graveyard after 60 seconds or so.\n\nNOTE: Only works if you're in a group or if the game thinks you're in a group.";
	["LOOT_SPEC_DESC_2"] = "In Personal Loot dungeons, raids, and outdoor encounters, this setting will dictate which items are available for you.\n\nClick this row to go back to the Raid Assistant.";
	["CURRENT_SPEC"] = "Current Specialization";
	["CURRENT_SPEC_DESC"] = "If you switch your talents, your loot specialization changes with you.";
	["DUNGEON_DIFF_DESC_2"] = "This setting allows you to customize the difficulty of a dungeon.\n\nClick this row to go back to the Raid Assistant.";
	["CLICK_TO_CHANGE"] = "Click to change now. (if available)";
	["RAID_DIFF_DESC_2"] = "This setting allows you to customize the difficulty of a raid.\n\nClick this row to go back to the Raid Assistant.";
	["LEGACY_RAID_DIFF_DESC_2"] = "This setting allows you to customize the difficulty of a legacy raid. (Pre-Siege of Orgrimmar)\n\nClick this row to go back to the Raid Assistant.";
	["REROLL"] = "Reroll";
	["REROLL_DESC"] = "Click this button to reroll using the active filter.";
	["APPLY_SEARCH_FILTER"] = "Apply a Search Filter";
	["APPLY_SEARCH_FILTER_DESC"] = "Please select a search filter option.";
	["SEARCH_EVERYTHING_BUTTON_OF_DOOM"] = "Click this button to search... EVERYTHING.";
	["ACHIEVEMENT"] = "Achievement";
	["ACHIEVEMENT_DESC"] = "Click this button to select a random achievement based on what you're missing.";
	["ITEM"] = "Item";
	["ITEM_DESC"] = "Click this button to select a random item based on what you're missing.";
	["INSTANCE"] = "Instance";
	["INSTANCE_DESC"] = "Click this button to select a random instance based on what you're missing.";
	["DUNGEON"] = "Dungeon";
	["DUNGEON_DESC"] = "Click this button to select a random dungeon based on what you're missing.";
	["RAID"] = "Raid";
	["RAID_DESC"] = "Click this button to select a random raid based on what you're missing.";
	["MOUNT"] = "Mount";
	["MOUNT_DESC"] = "Click this button to select a random mount based on what you're missing.";
	["PET"] = "Pet";
	["PET_DESC"] = "Click this button to select a random pet based on what you're missing.";
	["QUEST"] = "Quest";
	["QUEST_DESC"] = "Click this button to select a random quest based on what you're missing.";
	["TOY"] = "Toy";
	["TOY_DESC"] = "Click this button to select a random toy based on what you're missing.";
	["ZONE"] = "Zone";
	["ZONE_DESC"] = "Click this button to select a random zone based on what you're missing.";
	["GO_GO_RANDOM"] = "Random - Go Get 'Em!";
	["GO_GO_RANDOM_DESC"] = "This window allows you to randomly select a place or item to get. Go get 'em!";
	["CHANGE_SEARCH_FILTER"] = "Change Search Filter";
	["CHANGE_SEARCH_FILTER_DESC"] = "Click this to change your search filter.";
	["REROLL_2"] = "Reroll: ";
	["NOTHING_TO_SELECT_FROM"] = "There was nothing to randomly select from.";
	["NO_SEARCH_METHOD"] = "No search method specified.";
	["PROFESSION_LIST"] = "Profession List";
	["PROFESSION_LIST_DESC"] = "Open your professions to cache them.";
	["CACHED_RECIPES_1"] = "Cached ";
	["CACHED_RECIPES_2"] = " known recipes!";
	["WORLD_QUESTS"] = "World Quests";
	["WORLD_QUESTS_DESC"] = "These are World Quests and other time-limited Things that are currently available somewhere. Go get 'em!";
	["QUESTS_DESC"] = "Shows all possible QuestID's in the game in ascending numeric order.";
	["UPDATE_WORLD_QUESTS"] = "Update World Quests Now";
	["UPDATE_WORLD_QUESTS_DESC"] = "Sometimes the World Quest API is slow or fails to return new data. If you wish to forcibly refresh the data without changing zones, click this button now!\n\nAlt + Click to include currently-available Things which may not be time-limited";
	["CLEAR_WORLD_QUESTS"] = "Clear World Quests";
	["CLEAR_WORLD_QUESTS_DESC"] = "Click to clear the current information within the World Quests frame";
	["ALL_THE_ITEMS_FOR_ACHIEVEMENTS_DESC"] = "All items that can be used to obtain achievements that you are missing are displayed here.";
	["ALL_THE_APPEARANCES_DESC"] = "All appearances that you need are displayed here.";
	["ALL_THE_MOUNTS_DESC"] = "All mounts that you have not collected yet are displayed here.";
	["ALL_THE_BATTLEPETS_DESC"] = "All pets that you have not collected yet are displayed here.";
	["ALL_THE_QUESTS_DESC"] = "All quests that have objective or starting items that can be sold on the auction house are displayed here.";
	["ALL_THE_RECIPES_DESC"] = "All recipes that you have not collected yet are displayed here.";
	["ALL_THE_ILLUSIONS_DESC"] = "Illusions, toys, and other items that can be used to earn collectible items are displayed here.";
	["ALL_THE_REAGENTS_DESC"] = "All items that can be used to craft an item using a profession on your account.";
	["AH_SCAN_SUCCESSFUL_1"] = ": Successfully scanned ";
	["AH_SCAN_SUCCESSFUL_2"] = " item(s).";
	["REAGENT_CACHE_OUT_OF_DATE"] = "Reagent Cache is out-of-date and will be re-cached when opening your professions!";
	["ARTIFACT_CACHE_OUT_OF_DATE"] = "Artifact Cache is out-of-date/inaccurate and will be re-cached when logging onto each character!";
	["QUEST_LOOP"] = "Likely just broke out of an infinite source quest loop.";
	["QUEST_PREVENTS_BREADCRUMB_COLLECTION_FORMAT"] = "Quest '%s' %s will prevent collection of Breadcrumb Quest '%s' %s";
	["QUEST_OBJECTIVE_INVALID"] = "Invalid Quest Objective";
	["REFRESHING_COLLECTION"] = "Refreshing collection...";
	["DONE_REFRESHING"] = "Done refreshing collection.";
	["ADHOC_UNIQUE_COLLECTED_INFO"] = "This Item is Unique-Collected but failed to be detected due to missing Blizzard API information.\n\nIt will be fixed after the next Force-Refresh.";

	-- Item Filter Window
	["ITEM_FILTER_TEXT"] = "Item Filters";
	["ITEM_FILTER_DESCRIPTION"] = "You can search the ATT Database by using a item filter.";
	["ITEM_FILTER_BUTTON_TEXT"] = "Set Item Filter";
	["ITEM_FILTER_BUTTON_DESCRIPTION"] = "Click this to change the item filter you want to search for within ATT.";
	["ITEM_FILTER_POPUP_TEXT"] = "Which Item Filter would you like to search for?";

	-- Instructional Text
	["MINIMAP_MOUSEOVER_TEXT"] = "Right click to change settings.\nLeft click to open the Main List.\nCtrl + Left click to open the Mini List.\nShift + Left click to Refresh Collections.";
	["TOP_ROW_INSTRUCTIONS"] = "|cff3399ffLeft Click and Drag to Move\nRight Click to Open the Settings Menu\nShift + Click to Refresh Collections\nCtrl + Click to Expand/Collapse Recursively\nShift + Right Click to Sort Groups/Popout Lists|r";
	["OTHER_ROW_INSTRUCTIONS"] = "|cff3399ffLeft Click to Expand/Collapse\nRight Click to Pop Out to Mini List\nShift + Click to Refresh Collections\nCtrl + Click to Expand/Collapse Recursively\nShift + Right Click to Sort Groups/Popout Lists\nAlt + Right Click to Plot Waypoints|r";
	["TOP_ROW_INSTRUCTIONS_AH"] = "|cff3399ffLeft Click and Drag to Move\nRight Click to Open the Settings Menu\nShift + Click to Search the Auction House|r";
	["OTHER_ROW_INSTRUCTIONS_AH"] = "|cff3399ffLeft Click to Expand/Collapse\nRight Click to Pop Out to Mini List\nShift + Click to Search the Auction House|r";
	["RECENTLY_MADE_OBTAINABLE"] = "|CFFFF0000If this recently dropped for you (anywhere but Salvage\nCrates), please post in Discord where you got it to drop!|r";
	["RECENTLY_MADE_OBTAINABLE_PT2"] = "|CFFFF0000The more information, the better.  Thanks!|r";
	["TOP_ROW_TO_LOCK"] = "|cff3399ffAlt + Click to Lock this Window";
	["TOP_ROW_TO_UNLOCK"] = "|cffcf0000Alt + Click to Unlock this Window";
	["QUEST_ROW_INSTRUCTIONS"] = "Right Click to see any Quest Chain Requirements";
	["QUEST_ONCE_PER_ACCOUNT"] = "Once-Per-Account Quest";
	["QUEST_ONCE_PER_ACCOUNT_FORMAT"] = "Completed By: %s";

	-- Settings.lua
		["SKIP_AUTO_REFRESH"] = "Do Not Auto-Refresh!";
		["SKIP_AUTO_REFRESH_TOOLTIP"] = "By default (unchecked), any Settings change which may affect visible data will cause an automatic refresh.\n\nBy enabling this option, Settings changes won't take effect until the User performs a Full Refresh by Shift-Clicking on an ATT window.";
		["AFTER_REFRESH"] = "After Refresh";

		-- General tab
			-- Mode Title
				["MODE"] = "Mode";
				["TITLE_COMPLETIONIST"] = "Completionist ";
				["TITLE_UNIQUE_APPEARANCE"] = "Unique Appearance ";
				["TITLE_DEBUG"] = "Debug ";
				["TITLE_ACCOUNT"] = "Account ";
				["TITLE_MAIN_ONLY"] = " (Main Only)";
				["TITLE_NONE_THINGS"] = "None of the Things ";
				["TITLE_ONLY"] = " Only ";
				["TITLE_INSANE"] = "Insane ";
				["TITLE_SOME_THINGS"] = "Some of the Things ";
				["TITLE_LEVEL"] = "Level ";
				["_BETA_LABEL"] = " |CFF4AA7FF[Beta]|R";


	["GENERAL_TAB"] = "General";
	["TWITCH_BUTTON_TOOLTIP"] = "Click this button to copy the url to get to my Twitch Channel.\n\nYou can ask questions while I'm streaming and I will try my best to answer them!";
	["DISCORD_BUTTON_TOOLTIP"] = "Click this button to copy the url to get to the ALL THE THINGS Discord.\n\nYou can share your progress/frustrations with other collectors!";
	["DEBUG_MODE"] = "|Cff15abffDebug Mode|r (Show Everything)";
	["DEBUG_MODE_TOOLTIP"] = "Quite literally... ALL THE THINGS IN THE GAME. PERIOD. DOT. YEAH, ALL OF IT. Even Uncollectible things like bags, consumables, reagents, etc will appear in the lists. (Even yourself! No, really. Look.)\n\nThis is for Debugging purposes only. Not intended to be used for completion tracking.\n\nThis mode bypasses all filters, including Unobtainables.";
	["UNIQUE_MODE"] = "|CFFADD8E6Unique|r (Appearances)";
	["UNIQUE_MODE_TOOLTIP"] = "Enable this Mode to consider all Items which share the same Appearance to be collected once that specific Appearance has been collected.\n\nItems 'Collected' through this mode will be marked with an asterisk (*). This means that you haven't collected that specific Source of the Appearance yet.";
	["COMPLETIONIST_MODE"] = "|CFFADD8E6Completionist|r (Sources)";
	["COMPLETIONIST_MODE_TOOLTIP"] = "Enable this Mode to consider Items as Collected only when the specific Item has been unlocked for the given Appearance.\n\nThis means you will need to collect every shared Appearance of an Item.\n\nNote: By default, the game stops telling you about Items you have not collected once you have collected a shared Source, so this will ensure that uncollected Items are tracked.";
	["I_ONLY_CARE_ABOUT_MY_MAIN"] = "|cff3399ffI only care about my main.|r";
	["MAIN_ONLY_MODE_TOOLTIP"] = "Turn this setting on if you additionally want ATT to *pretend* that you've earned all shared appearances not locked by a different race or class.\n\nAs an example, if you have collected a Hunter-Only Tier Piece from ICC and there is a shared appearance from the raid without class/race restrictions, ATT will *pretend* that you've earned that source of the appearance as well.\n\nNOTE: Switching to a different race/class will incorrectly report that you've earned appearance sources that you haven't collected for that new chararacter when unlocked in this way.";
	["ACCOUNT_MODE"] = "|Cff00ab00Account Mode|r (All)";
	["ACCOUNT_MODE_TOOLTIP"] = "Turn this setting on if you want to track all of the Things for all of your characters regardless of class and race filters.\n\nUnobtainable filters still apply.";
	["FACTION_MODE"] = "Only Current Faction";
	["FACTION_MODE_TOOLTIP"] = "Turn this setting on if you want to see Account Mode data only for races and classes of your current faction.";
	["PRECISION_SLIDER"] = "Level of Precision for Percentage";
	["PRECISION_SLIDER_TOOLTIP"] = 'Use this to customize your desired level of precision in percentage calculations.\n\nDefault: 2';
	["MINIMAP_SLIDER"] = "Minimap Button Size";
	["MINIMAP_SLIDER_TOOLTIP"] = 'Use this to customize the size of the Minimap Button.\n\nDefault: 36';
	["THINGS_LABEL_TEXT"] = "Which \"Things\" do you want to Collect?";
	["ACHIEVEMENTS_CHECKBOX"] = "Achievements";
	["ACHIEVEMENTS_CHECKBOX_TOOLTIP"] = "Enable this option to track achievements.";
	["TMOG_CHECKBOX"] = "Appearances / Transmog";
	["TMOG_CHECKBOX_TOOLTIP"] = "Enable this option to track appearance acquisition.\n\nNOTE: Disabling this option also disables all fanfares and acquisition logic.  You can use this toggle as a way to prevent lag spikes while doing important group content, but bear in mind the computation will need to occur once re-enabled.\n\nTracked Account Wide by Default.";
	["AZERITE_ESSENCES_CHECKBOX"] = "|T"..app.asset("Expansion_BFA")..":0|t "..SPLASH_BATTLEFORAZEROTH_8_2_0_FEATURE2_TITLE;
	["AZERITE_ESSENCES_CHECKBOX_TOOLTIP"] = "Enable this option to track Azerite Essences.\n\nTracked per character by default.";
	["BATTLE_PETS_CHECKBOX"] = "Battle Pets / Companions";
	["BATTLE_PETS_CHECKBOX_TOOLTIP"] = "Enable this option to track battle pets and companions. These can be found in the open world or via boss drops in various Dungeons and Raids as well as from Vendors and Reputation.\n\nTracked Account Wide by Default.";
	["FLIGHT_PATHS_CHECKBOX"] = "Flight Paths / Ferry Stations";
	["FLIGHT_PATHS_CHECKBOX_TOOLTIP"] = "Enable this option to track flight paths and ferry stations.\n\nTo collect these, open the dialog with the flight / ferry master in each continent.\n\nNOTE: Due to phasing technology, you may have to phase to the other versions of a zone to get credit for those points of interest.";
	["FOLLOWERS_CHECKBOX"] = "Followers / Champions";
	["FOLLOWERS_CHECKBOX_TOOLTIP"] = "Enable this option to track followers and champions.\n\nIE: Garrison Followers, Legion Class Hall Champions, BFA Campaign Minions and SL Adventurers.";
	["HEIRLOOMS_CHECKBOX"] = "Heirlooms";
	["HEIRLOOMS_CHECKBOX_TOOLTIP"] = "Enable this option to track whether you have unlocked an Heirloom and its respective Upgrade Levels.\n\nHeirlooms that have an associated Appearance are filtered via the Appearances filter. (turning off appearances will still show the Heirloom itself)\n\nSome items that appear with heirloom quality also help boost reputations and can be filtered via the Reputations filter.";
	["HEIRLOOMS_UPGRADES_CHECKBOX"] = "+Upgrades";
	["HEIRLOOMS_UPGRADES_CHECKBOX_TOOLTIP"] = "Enable this option to specifically track collection of individual Heirloom Upgrades.\n\nWe all know Blizzard just loves to drain your gold and your soul, so keep track of that with this toggle.";
	["ILLUSIONS_CHECKBOX"] = "Illusions";
	["ILLUSIONS_CHECKBOX_TOOLTIP"] = "Enable this option to track illusions.\n\nThese are really cool-looking transmog effects you can apply to your weapons!\n\nNOTE: You are not an illusion, despite what all the Nightborne think.\n\nTracked Account Wide by Default.";
	["MOUNTS_CHECKBOX"] = "Mounts";
	["MOUNTS_CHECKBOX_TOOLTIP"] = "Enable this option to track mounts.\n\nYou can ride these to go places faster than when running. Who knew!\n\nTracked Account Wide by Default.";
	["MUSIC_ROLLS_SELFIE_FILTERS_CHECKBOX"] = "Music Rolls / Selfie Filters";
	["MUSIC_ROLLS_SELFIE_FILTERS_CHECKBOX_TOOLTIP"] = "Enable this option to track music rolls and selfie filters.\n\nYou can use your Jukebox Toy to play in-game music and your Selfie Camera toy to collect filters for your selfies from certain locations.";
	["QUESTS_CHECKBOX"] = "Quests";
	["QUESTS_CHECKBOX_TOOLTIP"] = "Enable this option to track normal Quests.\n\nYou can right click any Quest in the lists to pop out their full quest chain to show your progress and any prerequisite Quests.\n\nNOTE: Quests are not permanently tracked due to the nature of how Daily, Weekly, Yearly, and World Quests are tracked in the Blizzard Database.";
	["QUESTS_BREADCRUMBS_CHECKBOX"] = "+Breadcrumbs";
	["QUESTS_BREADCRUMBS_CHECKBOX_TOOLTIP"] = "Enable this option to specifically include tracking of Breadcrumb Quest completion.\n\nBreadcrumb Quests are technically 'optional' in that they only serve to lead the player to a different Quest, and become unavailable if they are not completed prior to completing their following Quest(s).\nThis can make obtaining Breadcrumbs very reliant on the Party Sync feature or Account-Wide Quests";
	["RECIPES_CHECKBOX"] = "Recipes";
	["RECIPES_CHECKBOX_TOOLTIP"] = "Enable this option to track recipes for your professions.\n\nNOTE: You must open your professions list in order to cache these.";
	["REPUTATIONS_CHECKBOX"] = "Reputations";
	["REPUTATIONS_CHECKBOX_TOOLTIP"] = "Enable this option to track reputations.\n\nOnce you reach Exalted or Best Friend with a reputation, it will be marked Collected.\n\nYou may have to do a manual refresh for this to update correctly.";
	["RUNEFORGELEGENDARIES_CHECKBOX"] = "|T"..app.asset("Expansion_SL")..":0|t Runecarving Powers";
	["RUNEFORGELEGENDARIES_CHECKBOX_TOOLTIP"] = "Enable this option to track Shadowlands Runecarving Powers.";
	["SOULBINDCONDUITS_CHECKBOX"] = "|T"..app.asset("Expansion_SL")..":0|t "..GetSpellInfo(348869);
	["SOULBINDCONDUITS_CHECKBOX_TOOLTIP"] = "Enable this option to track Shadowlands Soulbind Conduits.";
	["TITLES_CHECKBOX"] = "Titles";
	["TITLES_CHECKBOX_TOOLTIP"] = "Enable this option to track titles.\n\nThese can make your character stand out and look like you've played for awhile. Typically only new players do not have a title active.";
	["TOYS_CHECKBOX"] = "Toys";
	["TOYS_CHECKBOX_TOOLTIP"] = "Enable this option to track Toys.\n\nMost of these toys have a fun thing that they do. Others, like the Hearthstone Toys, can be used in place of your actual Hearthstone and can save you a bag slot! They also have interesting effects... Nice!\n\nTracked Account Wide by Default.";
	["MINIMAP_BUTTON_CHECKBOX"] = "Show the Minimap Button";
	["MINIMAP_BUTTON_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see the minimap button. This button allows you to quickly access the Main List, show your Overall Collection Progress, and access the Settings Menu by right clicking it.\n\nSome people don't like clutter. Alternatively, you can access the Main List by typing '/att' in your chatbox. From there, you can right click the header to get to the Settings Menu.";
	["MINIMAP_BUTTON_STYLE_CHECKBOX"] = "Use the Old Minimap Style";
	["MINIMAP_BUTTON_STYLE_CHECKBOX_TOOLTIP"] = "Some people don't like the new minimap button...\n\nThose people are wrong!\n\nIf you don't like it, here's an option to go back to the old style.";
	["SHOW_COMPLETED_GROUPS_CHECKBOX"] = "Show Completed Groups";
	["SHOW_COMPLETED_GROUPS_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see completed groups as a header with a completion percentage. If a group has nothing relevant for your class, this setting will also make those groups appear in the listing.\n\nWe recommend you turn this setting off as it will conserve the space in the mini list and allow you to quickly see what you are missing from the zone.";
	["SHOW_COLLECTED_THINGS_CHECKBOX"] = "Show Collected Things";
	["SHOW_COLLECTED_THINGS_CHECKBOX_TOOLTIP"] = "Enable this option to see Things which have already been Collected.\n\nWe recommend you turn this setting off as it will conserve the space in the mini list and allow you to quickly see what you are missing from the zone.";
	["SHOW_INCOMPLETE_THINGS_CHECKBOX"] = "Show All Trackable Things";
	["SHOW_INCOMPLETE_THINGS_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see items, objects, NPCs, and headers which can be tracked within the game without necessarily being considered 'collectible'.\n\nYou can use this to help you earn the Loremaster Achievement if you don't already have it.\n\nNOTE: Rare Spawns and Vignettes also appear in the listing with this setting turned on.";
	["SHOW_REPEATABLE_THINGS_CHECKBOX"] = "Collect Repeatable Quests";
	["SHOW_REPEATABLE_THINGS_CHECKBOX_TOOLTIP"] = "Enable this option if you want to treat repeatable daily, weekly, and yearly quests as collectible. They will appear in the list like a regular collectible quest.\n\nNOTE: This is NOT intended to be used all the time, but if you're doing a set of dailies in a zone you've otherwise completed and need to be reminded of what is there, you can use this to see them.";
	["FIRST_TIME_CHECKBOX"] = "Only first time";
	["FIRST_TIME_CHECKBOX_TOOLTIP"] = "Enable this option if you want to treat repeatable daily, weekly, yearly and world quests as collected if completed at least once, ignoring quest previously completed that has been reset.\n\nNOTE: Previously completed repeatable quest are only stored if you completed the quest with the addon active and that data will be lost if removed the addon data from WTF folder.";
	["FILTER_THINGS_BY_LEVEL_CHECKBOX"] = "Filter Things By Level";
	["FILTER_THINGS_BY_LEVEL_CHECKBOX_TOOLTIP"] = "Enable this setting if you only want to see content available to your current level character.\n\nNOTE: This is especially useful on Starter Accounts.";
	["HIDE_BOE_CHECKBOX"] = "Hide BoE/BoA Items";
	["HIDE_BOE_CHECKBOX_TOOLTIP"] = "Enable this setting if you want to hide Bind-on-Equip/Account items.\n\nThis setting is useful for when you are trying to finish a Classic Dungeon for a character and don't want to farm specifically for items that can be farmed on alts or on the Auction House.\n\nIE: Don't lose your mind grinding for Pendulum of Doom.";
	["HIDE_PVP_CHECKBOX"] = "Hide PvP Content";
	["HIDE_PVP_CHECKBOX_TOOLTIP"] = "Enable this setting if you want to hide any content which 'may' require Player vs. Player interactions within the game.";
	["IGNORE_FILTERS_FOR_BOES_CHECKBOX"] = "Ignore BoE/BoA Item Filters";
	["IGNORE_FILTERS_FOR_BOES_CHECKBOX_TOOLTIP"] = "Enable this setting if you want to ignore armor, weapon, race, class, or profession requirements for BoE/BoA items.\n\nIf you are trying to collect things for your alts via Auction House scanning, this mode may be useful to you.";
	["EXPAND_DIFFICULTY_CHECKBOX"] = "Expand Current Difficulty";
	["EXPAND_DIFFICULTY_CHECKBOX_TOOLTIP"] = "Enable this option if you want to automatically minimize difficulty headers in the mini list that are not active when you enter a dungeon or raid.\n\nExample: Minimize the Heroic header when in a Normal difficulty dungeon.";
	["WARN_DIFFICULTY_CHECKBOX"] = "Warn Completed Difficulty";
	["WARN_DIFFICULTY_CHECKBOX_TOOLTIP"] = "Enable this option if you want to be warned when you enter an instance with a difficulty setting that will result in you being unable to earn new collectibles when there is an alternative unsaved difficulty that you could enter instead.";
	["REPORT_COLLECTED_THINGS_CHECKBOX"] = "Report Collected Things";
	["REPORT_COLLECTED_THINGS_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see a message in chat detailing which items you have collected or removed from your collection.\n\nNOTE: This is present because Blizzard silently adds appearances and other collectible items and neglects to notify you of the additional items available to you.\n\nWe recommend you keep this setting on. You will still hear the fanfare with it off assuming you have that option turned on.";
	["REPORT_COMPLETED_QUESTS_CHECKBOX"] = "Report Quests";
	["REPORT_COMPLETED_QUESTS_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see the QuestID for any quest you Accept or Complete immediately after it happens. (For reporting bugs, trackings purposes, etc)";
	["REPORT_UNSORTED_CHECKBOX"] = "Only 'Unsourced'";
	["REPORT_UNSORTED_CHECKBOX_TOOLTIP"] = "Enable this option if you only want to see the QuestID if it isn't already Sourced.";

	-- Account Wide Checkboxes
	["ACCOUNT_WIDE"] = "Account Wide";
	["ACCOUNT_WIDE_ACHIEVEMENTS_TOOLTIP"] = "Achievement tracking is usually account wide, but there are a number of achievements exclusive to specific classes and races that you can't get on your main.";
	["ACCOUNT_WIDE_TRANSMOG_TOOLTIP"] = "Transmog appearances are only tracked account wide and cannot be disabled.";
	["ACCOUNT_WIDE_AZERITE_ESSENCES_TOOLTIP"] = "Azerite Essences cannot technically be collected and used account-wide, but if you only care about collecting them on your main character then you may prefer tracking them account-wide.";
	["ACCOUNT_WIDE_FLIGHT_PATHS_TOOLTIP"] = "Flight Paths tracking is only really useful per character, but do you really want to collect them all on all 50 of your characters?";
	["ACCOUNT_WIDE_FOLLOWERS_TOOLTIP"] = "Followers are typically per character, but do you really want to have to collect 243 Garrison Inn Followers on one character at a rate of 1 per week?\n\nI think not, good sir.";
	["ACCOUNT_WIDE_HEIRLOOMS_TOOLTIP"] = "Heirlooms are tracked account wide.";
	["ACCOUNT_WIDE_MUSIC_ROLLS_SELFIE_FILTERS_TOOLTIP"] = "Music Rolls & Selfie Filters are not normally tracked account wide in Blizzard's database, but we can do that.\n\nNOTE: You can only play Music Rolls using the Jukebox Toy or snap a selfie with your S.E.L.F.I.E Camera Toy that you have collected on your current character.";
	["ACCOUNT_WIDE_QUESTS_TOOLTIP"] = "Quest completion is typically per Character, but this will consider a Quest as completed if ANY Character has completed that specific Quest.";
	["ACCOUNT_WIDE_RECIPES_TOOLTIP"] = "Recipes are not normally tracked account wide in Blizzard's database, but we can do that.\n\nIt is impossible to collect them all on one character, so with this, you can give your alts and their professions meaning.";
	["ACCOUNT_WIDE_REPUTATIONS_TOOLTIP"] = "Reputations are now tracked account wide in Blizzard's database for achievements, so turning this on may be a good idea.";
	["ACCOUNT_WIDE_RUNEFORGELEGENDARIES_TOOLTIP"] = "Not sure this will help at all for collection... enjoy moving at least one character of every class through every Covenant and Renown progression...";
	["ACCOUNT_WIDE_SOULBINDCONDUITS_TOOLTIP"] = "Enable this to consider a Soulbind Conduit as collected for all characters if at least one character has learned it.";
	["ACCOUNT_WIDE_TITLES_TOOLTIP"] = "Most titles are tracked account wide, but some prestigious titles in WoW are locked to the character that earned them.\n\nToggle this if you don't care about that and want to see those titles marked Collected for your alts.";

	-- Filters tab
	["FILTERS_TAB"] = "Filters";
	["ITEM_FILTER_LABEL"] = "Armor / Weapon Filters";
	["CLASS_DEFAULTS_BUTTON"] = "Class Defaults";
	["CLASS_DEFAULTS_BUTTON_TOOLTIP"] = "Click this button to reset all of the filters to your class defaults.\n\nNOTE: Only filters that are collectible for your class can be turned on.";
	["ALL_BUTTON"] = "All";
	["ALL_BUTTON_TOOLTIP"] = "Click this button to enable all equipment filters at once.";
	["UNCHECK_ALL_BUTTON"] = "Uncheck All";
	["UNCHECK_ALL_BUTTON_TOOLTIP"] = "Click this button to disable all equipment filters at once.";
	["CUSTOM_FILTERS_LABEL"] = "Automatic Filters";
	["CUSTOM_FILTERS_EXPLAIN_LABEL"] = "|CFFFFFFFFThese filters are automatically applied based on your current character, but may be overridden by being checked, allowing you to see additional Things your character cannot currently collect.\nNone of these filters are ever enabled in Account or Debug modes regardless of the selections below.|r";
	["CUSTOM_FILTERS_GENERIC_TOOLTIP_FORMAT"] = "Enable this setting to forcibly show %s content even if it is not available to the current character.";

	-- Unobtainables tab
	["UNOBTAINABLES_TAB"] = "Unobtainables";
	["SEASONAL_LABEL"] = "Seasonal (Check to hide)";
	["SEASONAL_ENABLE"] = "Filter Seasonal Items";
	["SEASONAL_ALL"] = "Toggle All Seasonal";
	["UNOBTAINALBE_LABEL"] = "Unobtainable (Check to hide)";
	["UNOBTAINABLE_ENABLE"] = "Filter Unobtainable Items";
	["UNOBTAINABLE_ALL"] = "Toggle All Unobtainable";
	["NO_CHANCE_LABEL"] = "No Chance";
	["NO_CHANCE_ALL"] = "Toggle All \"No Chance\"";
	["HIGH_CHENCE_LABEL"] = "High Chance";
	["HIGH_CHANCE_ALL"] = "Toggle All \"High Chance\"";

	-- Interface tab
	["INTERFACE_TAB"] = "Interface";
	["TOOLTIP_LABEL"] = "Tooltips";
	["ENABLE_TOOLTIP_INFORMATION_CHECKBOX"] = "|CFFADD8E6Tooltip Integrations|r";
	["ENABLE_TOOLTIP_INFORMATION_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see the information provided by ATT in external tooltips. This includes item links sent by other players, in the auction house, in the dungeon journal, in your bags, in the world, on NPCs, etc.\n\nIf you turn this feature off, you are seriously reducing your ability to quickly determine if you need to kill a mob or learn an appearance.\n\nWe recommend you keep this setting on.";
	["DISPLAY_IN_COMBAT_CHECKBOX"] = "In Combat";
	["DISPLAY_IN_COMBAT_CHECKBOX_TOOLTIP"] = "Enable this option if you want to render tooltip information while you are in combat.\n\nIf you are raiding with your Mythic/Mythic+ Guild, you should probably turn this setting off to save as much performance as you can.\n\nIt can be useful while you are soloing old content to immediately know what you need from a boss.";
	["TOOLTIP_MOD_LABEL"] = "With Modifier";
	["TOOLTIP_MOD_NONE"] = "None";
	["TOOLTIP_MOD_SHIFT"] = "Shift";
	["TOOLTIP_MOD_CTRL"] = "Ctrl";
	["TOOLTIP_MOD_ALT"] = "Alt";
	["TOOLTIP_SHOW_LABEL"] = "Shown Information";
	["SHOW_COLLECTION_PROGRESS_CHECKBOX"] = "Collection Progress";
	["SHOW_COLLECTION_PROGRESS_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see your progress towards collecting a Thing or completing a group of Things at the Top Right of its tooltip.\n\nWe recommend that you keep this setting turned on.";
	["ICON_ONLY_CHECKBOX"] = "Icon Only";
	["ICON_ONLY_CHECKBOX_TOOLTIP"] = "Enable this option if you only want to see the icon in the topright corner instead of the icon and the collected/not collected text.\n\nSome people like smaller tooltips...";
	["COORDINATES_CHECKBOX"] = "Coordinates";
	["COORDINATES_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see coordinates in the tooltip when hovering over an entry in the mini list.";
	["DESCRIPTIONS_CHECKBOX"] = "Descriptions";
	["DESCRIPTIONS_CHECKBOX_TOOLTIP"] = "Enable this option to show descriptions within the tooltip. This may include the descriptive text added by a Contributor that felt some additional information was necessary.\n\nYou might want to keep this turned on.";
	["LORE_CHECKBOX"] = "Lore";
	["LORE_CHECKBOX_TOOLTIP"] = "Enable this option to show lore within the tooltip. This may include the descriptive text supplied by the Dungeon Journal or for flavor by a Contributor.";
	["KNOWN_BY_CHECKBOX"] = "Known By";
	["KNOWN_BY_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see the full list of characters on all servers that know this recipe in the tooltip.";
	["SHOW_MODELS_CHECKBOX"] = "Model Preview";
	["SHOW_MODELS_CHECKBOX_TOOLTIP"] = "Enable this option to show models within a preview instead of the icon on the tooltip.\n\nThis option may assist you in identifying what a Rare Spawn or Vendor looks like. It might be a good idea to keep this turned on for that reason.";
	["SHARED_APPEARANCES_CHECKBOX"] = "Shared Appearances";
	["SHARED_APPEARANCES_CHECKBOX_TOOLTIP"] = "Enable this option to see items that share a similar appearance in the tooltip.\n\nNOTE: Items that do not match the armor type are displayed in the list. This is to help you diagnose the Collection progress.\n\nIf you are ever confused by this, as of ATT v1.5.0, you can Right Click the item to open the item and its Shared Appearances into their own standalone Mini List.";
	["INCLUDE_ORIGINAL_CHECKBOX"] = "Include Original Source";
	["INCLUDE_ORIGINAL_CHECKBOX_TOOLTIP"] = "Enable this option if you actually liked seeing the original source info within the Shared Appearances list in the tooltip.";
	["ONLY_RELEVANT_CHECKBOX"] = "Only Relevant";
	["ONLY_RELEVANT_CHECKBOX_TOOLTIP"] = "Enable this option if you only want to see shared appearances that your character can unlock.\n\nNOTE: We recommend you keep this off as knowing the unlock requirements for an item can be helpful in identifying why an item is Not Collected.";
	["CLASSES_CHECKBOX"] = "Classes";
	["CLASSES_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see the full list of class requirements in the tooltip.";
	["RACES_CHECKBOX"] = "Races";
	["RACES_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see the full list of race requirements in the tooltip.";
	["SPEC_CHECKBOX"] = "Specializations";
	["SPEC_CHECKBOX_TOOLTIP"] = "Enable this option to show the loot specialization information of items in the item's tooltip as provided by the Game Client.\n\nNOTE: These icons will still appear within the ATT mini lists regardless of this setting.";
	["SUMMARIZE_CHECKBOX"] = "Summarize Things";
	["SUMMARIZE_CHECKBOX_TOOLTIP"] = "Enable this option to summarize Things in the tooltip. For example, if a Thing can be turned into a Vendor for another Thing, then show that other thing in the tooltip to provide visibility for its multiple uses. If a Thing acts as a Container for a number of other Things, this option will show all of the other Things that the container Contains.\n\nWe recommend that you keep this setting turned on.";
	["CONTAINS_SLIDER_TOOLTIP"] = 'Use this to customize the number of Summarized Things to show in the tooltip.\n\nDefault: 25';
	["SOURCE_LOCATIONS_CHECKBOX"] = "Source Locations";
	["SOURCE_LOCATIONS_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see full Source Location Paths for objects within the ATT database in the tooltip.";
	["LOCATIONS_SLIDER_TOOLTIP"] = 'Use this to customize the number of source locations to show in the tooltip.\n\nNOTE: This will also show "X" number of other sources based on how many, if that total is equivalent to the total number of displayed elements, then that will simply display the last source.\n\nDefault: 5';
	["COMPLETED_SOURCES_CHECKBOX"] = "For Completed";
	["COMPLETED_SOURCES_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see completed source locations in the tooltip.\n\nAs an example, if you complete the quest \"Bathran's Hair\" in Ashenvale, the tooltip for Evenar Stillwhisper will no longer show that quest when hovering over him.";
	["DROP_CHANCES_CHECKBOX"] = "Show Drop Chances";
	["DROP_CHANCES_CHECKBOX_TOOLTIP"] = "Enable this option to calculate various drop chance information in the tooltip for an item in an ATT window.\nThis can be helpful for knowing which Loot Spec should be used when Bonus Rolling for an item.";
	["FOR_CREATURES_CHECKBOX"] = "For Creatures";
	["FOR_CREATURES_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see Source Locations for Creatures.";
	["FOR_THINGS_CHECKBOX"] = "For Things";
	["FOR_THINGS_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see Source Locations for Things.";
	["FOR_UNSORTED_CHECKBOX"] = "For Unsorted";
	["FOR_UNSORTED_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see Source Locations which have not been fully sourced into the database.";
	["WITH_WRAPPING_CHECKBOX"] = "Allow Source Wrapping",
	["WITH_WRAPPING_CHECKBOX_TOOLTIP"] = "Enable this option to allow the Source lines to wrap within the tooltip.\nThis will ensure that the tooltips do not grow wider than necessary, but will unfortunately make the Source information harder to read in many situations.",
	["MISC_LABEL"] = "Miscellaneous";
	["SHOW_REMAINING_CHECKBOX"] = "Show Remaining Things";
	["SHOW_REMAINING_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see the number of items remaining instead of the progress over total.";
	["PERCENTAGES_CHECKBOX"] = "Show Percentage Completion";
	["PERCENTAGES_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see the percent completion of each row.\n\nColoring of groups by completion is unaffected.";
	["MORE_COLORS_CHECKBOX"] = "Use More Colors!";
	["MORE_COLORS_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see more colors utilized to help distinguish additional conditions for Things in lists (i.e. class colors, faction colors, etc.)";
	["TOOLTIP_HELP_CHECKBOX"] = "Show Tooltip Help";
	["TOOLTIP_HELP_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see the help info in ATT window tooltips which indicates various key/click combinations for ATT window functionality.\nIf you already know all of the key/click combinations, you may want to save tooltip space and disable this option.";
	["SIZING_LABEL"] = "Scale";
	["MAIN_LIST_SLIDER_LABEL"] = "Main List Scale";
	["MAIN_LIST_SCALE_TOOLTIP"] = 'Use this to customize the scale of the Main List.\n\nDefault: 1';
	["MINI_LIST_SLIDER_LABEL"] = "Mini/Other List Scale";
	["MINI_LIST_SCALE_TOOLTIP"] = 'Use this to customize the scale of all Mini and Bitty Lists.\n\nDefault: 1';

	-- Features tab
	["FEATURES_TAB"] = "Features";
	["MODULES_LABEL"] = "Modules & Mini Lists";
	["ADHOC_UPDATES_CHECKBOX"] = "Use Ad-Hoc Window Updates";
	["ADHOC_UPDATES_CHECKBOX_TOOLTIP"] = "Enable this option if you want only visible ATT windows to be updated.\n\nThis can greatly reduce loading times and prevent large framerate spikes in some situations.";
	["SKIP_CUTSCENES_CHECKBOX"] = "Automatically Skip Cutscenes";
	["SKIP_CUTSCENES_CHECKBOX_TOOLTIP"] = "Enable this option if you want ATT to automatically skip all cutscenes on your behalf.";
	["AUTO_BOUNTY_CHECKBOX"] = "Automatically Open the Bounty List";
	["AUTO_BOUNTY_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see the items that have an outstanding collection bounty. If you manage to snag one of the items posted on this list, you could make a good sum of gold.\n\nShortcut Command: /attbounty";
	["AUTO_MAIN_LIST_CHECKBOX"] = "Automatically Open the Main List";
	["AUTO_MAIN_LIST_CHECKBOX_TOOLTIP"] = "Enable this option if you want to automatically open the Main List when you login.\n\nYou can also bind this setting to a Key:\n\nKey Bindings -> Addons -> ALL THE THINGS -> Toggle Main List\n\nShortcut Command: /att";
	["AUTO_MINI_LIST_CHECKBOX"] = "Automatically Open the Mini List";
	["AUTO_MINI_LIST_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see everything you can collect in your current zone. The list will automatically switch when you change zones. Some people don't like this feature, but when you are solo farming, this feature is extremely useful.\n\nYou can also bind this setting to a Key.\n\nKey Bindings -> Addons -> ALL THE THINGS -> Toggle Mini List\n\nShortcut Command: /att mini";
	["AUTO_PROF_LIST_CHECKBOX"] = "Automatically Open the Profession List";
	["AUTO_PROF_LIST_CHECKBOX_TOOLTIP"] = "Enable this option if you want ATT to open and refresh the profession list when you open your professions. Due to an API limitation imposed by Blizzard, the only time an addon can interact with your profession data is when it is open. The list will automatically switch when you change to a different profession.\n\nWe don't recommend disabling this option as it may prevent recipes from tracking correctly.\n\nYou can also bind this setting to a Key. (only works when a profession is open)\n\nKey Bindings -> Addons -> ALL THE THINGS -> Toggle Profession Mini List\n\nShortcut Command: /att prof";
	["AUTO_RAID_ASSISTANT_CHECKBOX"] = "Automatically Open the Raid Assistant";
	["AUTO_RAID_ASSISTANT_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see an alternative group/party/raid settings manager called the 'Raid Assistant'. The list will automatically update whenever group settings change.\n\nYou can also bind this setting to a Key.\n\nKey Bindings -> Addons -> ALL THE THINGS -> Toggle Raid Assistant\n\nShortcut Command: /attra";
	["AUTO_WQ_LIST_CHECKBOX"] = "Automatically Open the World Quests List";
	["AUTO_WQ_LIST_CHECKBOX_TOOLTIP"] = "Enable this option if you want the 'World Quests' list to appear automatically. The list will automatically update whenever you switch zones.\n\nYou can also bind this setting to a Key.\n\nKey Bindings -> Addons -> ALL THE THINGS -> Toggle World Quests List\n\nShortcut Command: /attwq";
	["CURRENCIES_IN_WQ_CHECKBOX"] = "Allow Collectible Cost Groups";
	["CURRENCIES_IN_WQ_CHECKBOX_TOOLTIP"] = "Enable this option if you want to allow Items/Currencies which are used to purchase collectible Things to be considered collectible and show under dynamically-populated Quests.";
	["AUCTION_TAB_CHECKBOX"] = "Show the Auction House Module Tab";
	["AUCTION_TAB_CHECKBOX_TOOLTIP"] = "Enable this option if you want to see the Auction House Module provided with ATT.\n\nSome addons are naughty and modify this frame extensively. ATT doesn't always play nice with those toys.";
	["SORT_BY_PROGRESS_CHECKBOX"] = "Sort By Progress";
	["SORT_BY_PROGRESS_CHECKBOX_TOOLTIP"] = "Enable this option if you want the 'Sort' operation (Shift + Right Click) to sort by the total progress of each group (instead of by Name)";
	["QUEST_CHAIN_NESTED_CHECKBOX"] = "Nested Quest Chain Requirements";
	["QUEST_CHAIN_NESTED_CHECKBOX_TOOLTIP"] = "Enable this option if you want the Quest Chain Requirements (Right-Click on Quest) window to show required Quests as sub-groups of their following Quests, i.e. they must be completed from the inside out.\n\nThis is useful to not miss Breadcrumb Quests and should be used primarily for Quest completion in mind.\n\nOtherwise, Quest Chain Requirements will be displayed in a top-down list, with the earliest available Quest at the very top.";
	["CELEBRATIONS_LABEL"] = "Celebrations & Sound Effects";
	["MASTER_AUDIO_CHECKBOX"] = "Use the Master Audio Channel";
	["MASTER_AUDIO_CHECKBOX_TOOLTIP"] = "Enable this option if you want the celebrations and other ATT sound effects to play on the 'MASTER' audio channel.\n\nDefault: Yes\n\nA lot of people play with sound effects off, so this option allows the ATT sounds to bypass that should it be desired.";
	["CELEBRATE_COLLECTED_CHECKBOX"] = "Collected Things Trigger a Celebration";
	["CELEBRATE_COLLECTED_CHECKBOX_TOOLTIP"] = "Enable this option if you want to hear a celebratory 'fanfare' sound effect when you obtain a new Thing.\n\nThis feature can greatly help keep you motivated.";
	["WARN_REMOVED_CHECKBOX"] = "Removed Things Trigger a Warning";
	["WARN_REMOVED_CHECKBOX_TOOLTIP"] = "Enable this option if you want to hear a warning sound effect when you accidentally sell back or trade an item that granted you an appearance that would cause you to lose that appearance from your collection.\n\nThis can be extremely helpful if you vendor an item with a purchase timer. The addon will tell you that you've made a mistake.";
	["SCREENSHOT_COLLECTED_CHECKBOX"] = "Collected Things Trigger a Screenshot";
	["SCREENSHOT_COLLECTED_CHECKBOX_TOOLTIP"] = "Enable this option if you want to take a screenshot for every Thing you collect.";

	-- About tab
	["ABOUT"] = "About";
	["ABOUT_1"] = " |CFFFFFFFFis a collection tracking addon that shows you where and how to get everything in the game! We have a large community of users on our Discord (link at the bottom) where you can ask questions, submit suggestions as well as report bugs or missing items. If you find something collectible or a quest that isn't documented, you can tell us on the Discord, or for the more technical savvy, we have a Git that you may contribute directly to.\n\nWhile we do strive for completion, there's a lot of stuff getting added into the game each patch, so if we're missing something, please understand that we're a small team trying to keep up with changes as well as collect things ourselves. :D\n\nFeel free to ask me questions when I'm streaming and I'll try my best to answer it, even if it's not directly related to ATT (general WoW addon programming as well).\n\n- |r|Cffff8000Crieve|CFFFFFFFF\n\nPS: Check out All The Things Classic and TBC Classic!\n\nYes, I intend to play Classic WoW, but between working full time and developing the two versions of the addon, there won't be a lot of time for raiding.\n\nNo, ATT is not the addon that places icons on your bag icons. That's CanIMogIt and Caerdon Wardrobe!\n\nFor online collection comparing check out DataForAzeroth.com from shoogen!|r";
	["ABOUT_2"] = "Additional Contributors: |CFFFFFFFF(in no particular order)\nDaktar, Lucetia, Slumber, Gold, Avella, Aiue, Dead Serious, Oiche, Oxlotus, Eiltherune, Blueyleader, Iyanden, Pr3vention, BigBlaris, Talonzor, Mogwai, Heallie, Eckhardt, Boohyaka, Sadidorf, Sanctuari, Molkree, Runawaynow, Braghe, Myrhial, Darkal and the rest of the ALL THE THINGS Discord!\n\nSpecial Shoutout to AmiYuy (CanIMogIt) and Caerdon (Caerdon Wardrobe).|r  ";
	["ABOUT_3"] = "\n|CFFFFFFFFYou should absolutely download their addons to get the collection icons on items in your bags!|r";

	-- Binding Localizations
	["TOGGLE_ACCOUNT_MODE"] = "Toggle Account Mode";
	["TOGGLE_COMPLETIONIST_MODE"] = "Toggle Completionist Mode";
	["TOGGLE_DEBUG_MODE"] = "Toggle Debug Mode";
	["TOGGLE_FACTION_MODE"] = "Toggle Faction Mode";
	["PREFERENCES"] = "Preferences";
	["TOGGLE_COMPLETEDTHINGS"] = "Toggle Completed Things (Both)";
	["TOGGLE_COMPLETEDGROUPS"] = "Toggle Completed Groups";
	["TOGGLE_COLLECTEDTHINGS"] = "Toggle Collected Things";
	["TOGGLE_BOEITEMS"] = "Toggle BoE/BoA Items";
	["TOGGLE_SOURCETEXT"] = "Toggle Source Locations";
	["MODULES"] = "Modules";
	["TOGGLE_MAINLIST"] = "Toggle ATT Main List";
	["TOGGLE_MINILIST"] = "Toggle ATT Mini List";
	["TOGGLE_PROFESSION_LIST"] = "Toggle ATT Profession List";
	["TOGGLE_WORLD_QUESTS_LIST"] = "Toggle ATT World Quests";
	["TOGGLE_RAID_ASSISTANT"] = "Toggle ATT Raid Assistant";
	["TOGGLE_RANDOM"] = "Toggle ATT Random";
	["REROLL_RANDOM"] = "Reroll the Random Selection";

	-- Event Text
	["ITEM_ID_ADDED"] = "%s (%d) was added to your collection.";
	["ITEM_ID_ADDED_RANK"] = "%s (%d) [Rank %d] was added to your collection.";
	["ITEM_ID_ADDED_MISSING"] = "%s (%d) was added to your collection. Not found in the database. Please report to the ATT Discord!";
	["ITEM_ID_ADDED_SHARED"] = "%s (%d) [+%d] were added to your collection.";
	["ITEM_ID_ADDED_SHARED_MISSING"] = "%s (%d) [+%d] were added to your collection. Not found in the database. Please report to the ATT Discord!";
	["ITEM_ID_REMOVED"] = "%s (%d) was removed from your collection.";
	["ITEM_ID_REMOVED_SHARED"] = "%s (%d) [+%d] were removed from your collection.";

	-- Tooltip Text
	["DROP_RATE"] = "Drop Rate";
	["QUEST_GIVER"] = "Quest Giver";
	["LOCKOUT"] = "Lockout";
	["SHARED"] = "Shared";
	["SPLIT"] = "Per Difficulty";
	["REQUIRES_LEVEL"] = "Requires Level";
	["SECRETS_HEADER"] = "Secrets";
	["LIMITED_QUANTITY"] = "This has a limited quantity and may not always be present on the vendor.";
	["SOURCE_ID_MISSING"] = "Please report this Item and where it was acquired to the ATT Discord in #errors!";

	-- Filter Text
	["ACHIEVEMENT_ID"] = "Achievement ID";
	["ARTIFACT_ID"] = "Artifact ID";
	["AZERITE_ESSENCE_ID"] = "Azerite Essence ID";
	["CREATURE_ID"] = "Creature ID";
	["CURRENCY_ID"] = "Currency ID";
	["DIFFICULTY_ID"] = "Difficulty ID";
	["ENCOUNTER_ID"] = "Encounter ID";
	["EXPANSION_ID"] = "Expansion ID";
	["FILTER_ID"] = "Filter ID";
	["FOLLOWER_ID"] = "Follower ID";
	["INSTANCE_ID"] = "Instance ID";
	["ITEM_ID"] = "Item ID";
	["FACTION_ID"] = "Faction ID";
	["FLIGHT_PATH_ID"] = "Flight Path ID";
	["MAP_ID"] = "Map ID";
	["MOUNT_ID"] = "Mount ID";
	["MUSIC_ROLL_ID"] = "Music Roll ID";
	["NPC_ID"] = "NPC ID";
	["OBJECT_ID"] = "Object ID";
	["QUEST_ID"] = "Quest ID";
	["SET_ID"] = "Gear Set ID";
	["SOURCE_ID"] = "Source ID";
	["SPECIES_ID"] = "Species ID";
	["SPELL_ID"] = "Spell ID";
	["TITLE_ID"] = "Title ID";
	["TOY_ID"] = "Toy ID";
	["ILLUSION_ID"] = "Illusion ID";
	["VISUAL_ID"] = "Visual ID";
	["iLvl"] = "iLvl";

	-- Artifact Relic Completion
	["ARTIFACT_RELIC_CACHE"] = "Open your Artifact UI for all of your Artifact Weapons to cache whether this is an upgrade or not. This is useful for determining if you can trade this item to a Twink or not.";
	["ARTIFACT_RELIC_COMPLETION"] = "Artifact Relic Completion";
	["NOT_TRADEABLE"] = "Not Tradeable";
	["TRADEABLE"] = "Tradeable";


	-- Icons and Collection Text
	["LOGO_SMALL"] = app.asset("logo_tiny");	-- Winner of the Logo Contest (Used to be "Interface\\Icons\\INV_Axe_106.blp")
	["COLLECTED_ICON"] = "|T" .. app.asset("known") .. ":0|t";	-- Acquired the colors and icon from CanIMogIt.
	["COLLECTED_APPEARANCE_ICON"] = "|T" .. app.asset("known_circle") .. ":0|t";	-- Acquired the colors and icon from CanIMogIt.
	["COMPLETE_ICON"] = "|T" .. app.asset("known_green") .. ":0|t";	-- Acquired the colors and icon from CanIMogIt.
	["INCOMPLETE_ICON"] = "|T" .. app.asset("incomplete") .. ":0|t";	-- Acquired the colors and icon from CanIMogIt.
	["NOT_COLLECTED_ICON"] = "|T" .. app.asset("unknown") .. ":0|t";	-- Acquired the colors and icon from CanIMogIt.
	["COLLECTED"] = "|T" .. app.asset("known") .. ":0|t |cff15abffCollected|r";	-- Acquired the colors and icon from CanIMogIt.
	["COLLECTED_APPEARANCE"] = "|T" .. app.asset("known_circle") .. ":0|t |cff15abffCollected*|r";	-- Acquired the colors and icon from CanIMogIt.
	["NOT_COLLECTED"] = "|T" .. app.asset("unknown") .. ":0|t |cffff9333Not Collected|r";	-- Acquired the colors and icon from CanIMogIt.
	["COMPLETE"] = "|T" .. app.asset("known_green") .. ":0|t |cff6dce47Complete|r";	-- Acquired the colors and icon from CanIMogIt.
	["COMPLETE_OTHER"] = "|T" .. app.asset("known_green") .. ":0|t |cff6dce47Complete*|r";	-- Acquired the colors and icon from CanIMogIt.
	["INCOMPLETE"] = "|T" .. app.asset("incomplete") .. ":0|t |cff15abffIncomplete|r";	-- Acquired the colors and icon from CanIMogIt.
	["KNOWN_ON_CHARACTER"] = "|T" .. app.asset("known") .. ":0|t |cff15abffKnown on current character|r";
	["UNKNOWN_ON_CHARACTER"] = "|T" .. app.asset("unknown") .. ":0|t |cffff9333Unknown on current character|r";
	["COST_ICON"] = "|T" .. app.asset("Currency") .. ":0|t";
	["COST_TEXT"] = "|T" .. app.asset("Currency") .. ":0|t |cffdedadeCurrency|r";

	["ABBREVIATIONS"] = {
		["ALL THE THINGS"] = "ATT",
		["Antorus, the Burning Throne"] = "Antorus",
		["Expansion Pre"] = "Pre",
		["Expansion Features"] = "EF",
		["Dungeons & Raids"] = "D&R",
		["Classic %> "] = "",
		["The Burning Crusade"] = "BC",
		["Burning Crusade"] = "BC",
		["The BC"] = "BC",										-- Fix for BC PvP season
		["Wrath of the Lich King"] = "WotLK",
		["Cataclysm"] = "Cata",
		["Cataic"] = "Cataclysmic",								-- Fix for Cata last PvP Season
		["Mists of Pandaria"] = "MoP",
		["Warlords of Draenor"] = "WoD",
		["Battle for Azeroth"] = "BFA",
		["The Shadowlands"] = "SL",
		["Shadowlands"] = "SL",
		["Player vs Player"] = "PvP",
		["Raid Finder"] = "LFR",
		["Looking For Raid"] = "LFR",
		["Normal"] = "N",
		["Heroic"] = "H",
		["Mythic"] = "M",
		["Ny'alotha, the Waking City"] = "Ny'alotha",
		["Tazavesh, the Veiled Market"] = "Tazavesh",
		["10 Player"] = "10M",
		["10 Player (Heroic)"] = "10M (H)",
		["25 Player"] = "25M",
		["25 Player (Heroic)"] = "25M (H)",
		["Player vs. Player"] = STAT_CATEGORY_PVP,
		["Outdoor Zones"] = LFG_TYPE_ZONE,
		--["Zone Drop"] = LFG_TYPE_ZONE,
		["Zone Wide"] = LFG_TYPE_ZONE,
		["Item Sets"] = WARDROBE_SETS,
		["Pet Journal"] = PETS,
		--["Pet Battles"] = PETS,
		["Toy Box"] = TOY,
		["Monthly World Events"] = CALENDAR_REPEAT_MONTHLY,
		["Weekly World Events"] = CALENDAR_REPEAT_WEEKLY,
		["Mini World Events"] = GetSpellInfo(57055),
		["Emissary Quests"] = "Emissary",
		["World Quests"] = "WQ",
		["WoW Anniversary"] = "Anniversary",
		["Covenant:"] = "Cov:",
		["Sanctum Upgrades %> "] = "",
	};

	["CUSTOM_DIFFICULTIES"] = {
		[-1] = "Raid Finder (5.4)",
		[-2] = "Flexible (5.4)",
		[-3] = "Normal (5.4)",
		[-4] = "Heroic (5.4)",
	};

	-- Custom Icons for Factions (seems to be no automatic Faction-Icon associations in-game)
	["FACTION_ID_ICONS"] = {
		-- Examples --
		-- [FACTION_ID] = "PATH//TO//ICON",	-- Faction Name
		-- [FACTION_ID] = ICON_ID			-- Faction Name

		[1168] = 461821,	-- Guild
	};

	["FILTER_ID_TYPES"] = {
		-- "Armor Types"
		[1] = INVTYPE_HOLDABLE, 								-- Held in Off-Hand
		[2] = GetItemSubClassInfo(4,5),							-- Cosmetic
		[3] = GetItemSubClassInfo(8,3),							-- Cloaks
		[4] = GetItemSubClassInfo(4,1),							-- Cloth
		[5] = GetItemSubClassInfo(4,2),							-- Leather
		[6] = GetItemSubClassInfo(4,3),							-- Mail
		[7] = GetItemSubClassInfo(4,4),							-- Plate
		[8] = GetItemSubClassInfo(4,6),							-- Shields
		[9] = INVTYPE_TABARD,									-- Tabards
		[10] = INVTYPE_BODY,									-- Shirts
		[11] = "Artifacts",										-- Artifacts

		-- PADDING for extra types, if necessary

		-- "Weapon Types"
		[20] = GetItemSubClassInfo(2,15),						-- Daggers
		[21] = GetItemSubClassInfo(2,0),						-- 1H Axes
		[22] = GetItemSubClassInfo(2,1),						-- 2H Axes
		[23] = GetItemSubClassInfo(2,4),						-- 1H Maces
		[24] = GetItemSubClassInfo(2,5),						-- 2H Maces
		[25] = GetItemSubClassInfo(2,7),						-- 1H Swords
		[26] = GetItemSubClassInfo(2,8),						-- 2H Swords
		[27] = GetItemSubClassInfo(2,19),						-- Wands
		[28] = GetItemSubClassInfo(2,10),						-- Staffs
		[29] = GetItemSubClassInfo(2,6),						-- Polearms
		[30] = GetItemSubClassInfo(2,17),						-- Spears
		[31] = GetItemSubClassInfo(2,3),						-- Guns
		[32] = GetItemSubClassInfo(2,2),						-- Bows
		[33] = GetItemSubClassInfo(2,18),						-- Crossbows
		[34] = GetItemSubClassInfo(2,13),						-- Fist Weapons
		[35] = GetItemSubClassInfo(2,9),						-- Warglaives

		-- PADDING for extra types, if necessary
		[50] = GetItemSubClassInfo(2,14),						-- Miscellaneous
		[51] = GetItemSubClassInfo(8,1),						-- Neck
		[52] = GetItemSubClassInfo(8,10),						-- Finger
		[53] = INVTYPE_TRINKET,									-- Trinket
		[54] = GetItemSubClassInfo(3,11),						-- Relic
		[55] = "Consumables",									-- Consumable (Artifact Power, etc)
		[56] = GetItemClassInfo(5),								-- Reagents (Crafting, etc)
		[57] = GetItemSubClassInfo(2,20),						-- Fishing Poles
		[58] = AUCTION_CATEGORY_CONTAINERS,						-- Containers (Tier Tokens, Timeless Isle BoA gear tokens, Bags of loot, etc)
		[59] = "Class Books",									-- Class Books (Classic Spells, Ashran Books, etc)
		[60] = GetSpellInfo(181765),							-- S.E.L.F.I.E. Camera (For various filters)

		-- "Non-Equipment Types"
		[100] = MOUNTS,											-- Mounts
		[101] = AUCTION_CATEGORY_BATTLE_PETS,					-- Battle Pets
		[102] = TOY,											-- Toy
		[103] = "Illusions",									-- Illusions
		[104] = ITEM_BIND_QUEST,								-- Quest Items
		[105] = TRACKER_FILTER_ACHIEVEMENTS,					-- Achievements
		[106] = CALENDAR_FILTER_WEEKLY_HOLIDAYS,				-- Holiday
		[107] = "Vignettes",
		[108] = ENABLE_MUSIC.." "..ROLL,						-- Music Rolls
		[109] = HEIRLOOMS,										-- Heirlooms
		[110] = "Titles",										-- Titles
		[111] = GetItemClassInfo(16),							-- Glyph
		[112] = FACTION,										-- Factions
		[113] = INVTYPE_BAG,									-- Bags
		[114] = "Mount Equipment",								-- Mount Equipment

		-- "Recipes"
		[200] = AUCTION_CATEGORY_RECIPES,						-- Recipes

		[999] = "Event Item",
	};
	["FILTER_ID_ICONS"] = {
		[1] = "Interface\\Icons\\inv_misc_orb_01",								-- Held in Off-hand
		[2] = "Interface\\Icons\\Ability_Mage_IceForm",							-- Cosmetic
		[3] = "Interface\\Icons\\inv_misc_cape_11",								-- Cloaks
		[4] = "Interface\\Icons\\inv_chest_cloth_21",							-- Cloth Armor
		[5] = "Interface\\Icons\\inv_chest_leather_09",							-- Leather Armor
		[6] = "Interface\\Icons\\inv_chest_chain_05",							-- Mail Armor
		[7] = "Interface\\Icons\\inv_chest_plate01",							-- Plate Armor
		[8] = "Interface\\Icons\\inv_shield_06",								-- Shield
		[9] = "Interface\\Icons\\inv_misc_tournaments_tabard_gnome",			-- Tabards
		[10] = "Interface\\Icons\\inv_shirt_grey_01",							-- Shirts
		[11] = "Interface\\Icons\\Paladin_Protection",							-- Artifacts
		[20] = "Interface\\Icons\\inv_weapon_shortblade_01",					-- Daggers
		[21] = "Interface\\Icons\\inv_axe_17",									-- 1H Axes
		[22] = "Interface\\Icons\\inv_axe_09",									-- 2H Axes
		[23] = "Interface\\Icons\\inv_mace_02",									-- 1H Maces
		[24] = "Interface\\Icons\\inv_hammer_16",								-- 2H Maces
		[25] = "Interface\\Icons\\inv_sword_04",								-- 1H Swords
		[26] = "Interface\\Icons\\inv_sword_07",								-- 2H Swords
		[27] = "Interface\\Icons\\inv_wand_02",									-- Wands
		[28] = "Interface\\Icons\\inv_staff_27",								-- Staves
		[29] = "Interface\\Icons\\inv_spear_04",								-- Polearms
		[31] = "Interface\\Icons\\inv_weapon_rifle_01",							-- Guns
		[32] = "Interface\\Icons\\inv_weapon_bow_05",							-- Bows
		[33] = "Interface\\Icons\\inv_weapon_crossbow_01",						-- Crossbows
		[34] = "Interface\\Icons\\inv_misc_monsterclaw_02",						-- Fist Weapons
		[35] = "Interface\\Icons\\inv_weapon_glave_01",							-- Warglaives
		[50] = "Interface\\Icons\\Spell_Misc_Drink",							-- Miscellaneous
		[51] = "Interface\\Icons\\INV_Jewelry_Necklace_02",						-- Neck
		[52] = "Interface\\Icons\\INV_Jewelry_Ring_04",							-- Finger
		[53] = "Interface\\Icons\\INV_Trinket_Naxxramas05",						-- Trinket
		[54] = "Interface\\Icons\\inv_staff_2h_felfireraid_d_03",				-- Relic
		[55] = "Interface\\Icons\\INV_Drink_25_HoneyTea",						-- Consumables
		[59] = "Interface\\Icons\\INV_Misc_Book_03",							-- Class Books
		[100] = "Interface\\Icons\\ability_mount_fireravengodmountgreen",		-- Mounts
		[101] = "Interface\\Icons\\Tracking_WildPet",							-- Battle Pet
		[102] = "Interface\\Icons\\INV_Misc_Toy_10",							-- Toy
		[103] = "Interface\\Icons\\inv_inscription_weaponscroll03",				-- Illusions
		[111] = "Interface\\Icons\\Inv_glyph_minorwarrior",						-- Glyph
		[113] = "Interface\\Icons\\INV_Misc_Bag_08",							-- Bag
		[114] = "Interface\\Icons\\inv_blacksmith_leystonehoofplates_orange",	-- Mount Equipment
		[200] = "Interface\\Icons\\inv_scroll_05",								-- Recipes
		[999] = "Interface\\Icons\\INV_Holiday_Christmas_Present_01",			-- Event Item
	};

	-- Custom Icons for Holidays
	["HOLIDAY_ID_ICONS"] = {
		-- Examples --
		-- [HOLIDAY_ID] = app.asset("PATH"),	-- Holiday Name
		-- [HOLIDAY_ID] = "PATH//TO//ICON",	-- Holiday Name
		-- [HOLIDAY_ID] = ICON_ID			-- Holiday Name

		-- "Legit" Holidays
		[235442] = app.asset("Holiday_brewfest"),	-- Brewfest
		[235445] = app.asset("Holiday_Children"),	-- Children's Week
		[235448] = app.asset("Event_dmf"),	-- Darkmoon Faire
		[307365] = app.asset("Holiday_Day_of_the_Dead"),	-- Day of the Dead
		[235485] = app.asset("Holiday_winter_veil"),	-- Feast of Winter Veil
		-- [235457] = app.asset("TODO"),	-- Fireworks Spectacular
		[235462] = app.asset("Holiday_hallows_end"),	-- Hallow's End
		[235465] = app.asset("Holiday_Harvestfest"),	-- Harvest Festival
		[235468] = app.asset("Holiday_love"),	-- Love is in the Air
		[235471] = app.asset("Holiday_Lunar"),	-- Lunar Festival
		[235474] = app.asset("Holiday_Midsummer"),	-- Midsummer Fire Festival
		[235477] = app.asset("Holiday_noblegarden"),	-- Noblegarden
		[235466] = app.asset("Holiday_Pilgrim"),	-- Pilgrim's Bounty
		[235481] = app.asset("Holiday_Pirate"),	-- Pirates' Day

		-- "Micro" Holidays
		-- [1671624] = app.asset("TODO"),	-- Auction House Dance Party
		[1574965] = app.asset("Holiday_call_of_the_scarab"),	-- Call of the Scarab
		[2827082] = app.asset("Holiday_Tshirt"),	-- Free T-Shirt Day
		-- [1572471] = app.asset("TODO"),	-- Glowcap Festival
		-- [1574966] = app.asset("TODO"),	-- Hatching of the Hippogryphs
		-- [1574967] = app.asset("TODO"),	-- Kirin Tor Tavern Crawl
		-- [2827083] = app.asset("TODO"),	-- Luminous Luminaries
		[1572472] = app.asset("Holiday_Marchofmurloc"),	-- March of the Tadpoles
		-- [1671628] = app.asset("TODO"),	-- Moonkin Festival
		-- [1572475] = app.asset("TODO"),	-- Spring Balloon Festival
		-- [1671627] = app.asset("TODO"),	-- The Great Gnomeregan Run
		-- [1572478] = app.asset("TODO"),	-- Thousand Boat Bash
		[1671631] = app.asset("Holiday_Trialofstyle"),	-- Trial of Style
		-- [1574970] = app.asset("TODO"),	-- Un'Goro Madness
		-- [1572479] = app.asset("TODO"),	-- Volunteer Guard Day
		-- [2827084] = app.asset("TODO"),	-- Wanderer's Festival
	};

	-- These need to be localized manually.
	-- Can also use the direct IconID, i.e. wowhead.com/icon=###
	-- https://www.wowhead.com/icons
	["HEADER_ICONS"] = {
		--[-] = "Interface\\Icons\\",														--
	-- Commonly used
		[0] = app.asset("Interface_Zone_drop"),												-- Zone Drop
		[-1] = "Interface\\Icons\\Achievement_Garrison_Horde_PVE",							-- Common Boss Drop
		[-2] = app.asset("Interface_Vendor"),												-- Vendors
		[-3] = app.asset("Category_Holidays"),												-- Holidays
		[-4] = app.asset("Category_Achievements"),											-- Achievement
		[-7] = app.asset("Interface_World_boss"),				                            -- World Bosses (Achievement_Boss_ShadeOfEranikus)
		[-9] = app.asset("Category_PvP"),													-- Player vs. Player
		[-10] = "Interface\\Icons\\achievement_reputation_05",								-- Party Sync
		[-11] = "Interface\\Icons\\inv_misc_crate04horde",									-- Common Box Drops
		[-12] = "Interface\\Icons\\Ability_Warlock_DemonicEmpowerment",						-- East entrance demons
		[-13] = "Interface\\Icons\\Achievement_Reputation_Ogre",							-- North entrance ogres
		[-14] = "Interface\\Icons\\INV_Misc_Head_Elf_02",									-- West entrace elves
		[-15] = "Interface\\Addons\\ATT-Classic\\assets\\INV_Misc_Map02",					-- Exploration
		[-16] = app.asset("Interface_Rare"),												-- Rare
		[-17] = app.asset("Interface_Quest_header"),										-- Quests
		[-18] = app.asset("Interface_Rewards"),		 										-- Rewards
		--[-18] = "Interface\\Icons\\inv_misc_coinbag_special", 								-- Rewards
		[-19] = "Interface\\Icons\\INV_Misc_Head_Dragon_Green",								-- Dragons of Nightmare
		[-20] = "Interface\\Icons\\INV_Misc_Coin_02",										-- Common Vendor Items
		[-21] = "Interface\\Icons\\achievement_pvp_h_12",									-- Captains
		[-22] = app.asset("Category_Secrets"),												-- Secrets
		[-23] = "Interface\\Icons\\item_maldraxxus_paragonchest_01",						-- WoD Common Dungeon Drop
		[-26] = app.asset("Category_WorldDrops"),											-- Drop
		[-31] = app.asset("Category_Promo"),												-- Promotion
		[-34] = app.asset("Interface_WorldQuest"),							            	-- World Quests
		[-36] = app.asset("Category_InGameShop"),											-- In-Game Shop
		[-37] = "Interface\\Icons\\Garrison_Building_MageTower",							-- Discovery
		[-38] = app.asset("Category_Professions"),											-- Professions
		[-40] = "Interface\\Icons\\Inv_misc_book_17",										-- Legacy
		[-41] = "Interface\\Icons\\TRADE_ARCHAEOLOGY",										-- Cache of Madness
	-- Armor Types
		[-43] = "Interface\\Icons\\inv_chest_cloth_21",										-- Cloth Armor
		[-44] = "Interface\\Icons\\inv_chest_leather_09",									-- Leather Armor
		[-45] = "Interface\\Icons\\inv_chest_chain_05",										-- Mail Armor
		[-46] = "Interface\\Icons\\inv_chest_plate01",										-- Plate Armor
	-- World Events (These are used by ATT CLassic)
		[-47] = "Interface\\Icons\\achievement_worldevent_lunar",							-- Lunar Festival
		[-52] = "Interface\\Icons\\inv_misc_toy_04",										-- Children's Week
		[-53] = "Interface\\Icons\\inv_summerfest_symbol_high",								-- Midsummer Fire Festival
		[-54] = "Interface\\Icons\\inv_summerfest_symbol_low",								-- Unused (Previously: Midsummer Fire Festival [Horde])
		[-55] = "Interface\\Icons\\inv_helmet_66",											-- Pirates' Day",
		[-56] = "Interface\\Icons\\achievement_worldevent_brewmaster",						-- Brewfest
		[-57] = "Interface\\Icons\\INV_Holiday_Thanksgiving_Cornucopia",					-- Harvest Festival
		[-58] = app.asset("hallows_end"),													-- Hallow's End
		[-59] = "Interface\\Icons\\inv_misc_bone_humanskull_02",							-- Day of the Dead
		[-60] = "Interface\\Icons\\inv_thanksgiving_turkey",								-- Pilgrim's Bounty
		[-61] = "Interface\\Icons\\achievement_worldevent_merrymaker",						-- The Feast of Winter Veil
		[-62] = "Interface\\Icons\\inv_misc_fish_06",										-- Stranglethorn Fishing Extravaganza
	-- Emerald Nightmare
		[-68] = "Interface\\Icons\\spell_arcane_portalshattrath",							-- The Emerald Dream
	-- Maraudon
		[-69] = "Interface\\Icons\\spell_arcane_portalironforge",							-- Maraudon Purple
		[-70] = "Interface\\Icons\\INV_Jewelcrafting_ArgusGemUncut_Orange_MiscIcons",		-- Orange
		[-71] = "Interface\\Icons\\INV_Jewelcrafting_ArgusGemUncut_Purple_MiscIcons",		-- Purple

		[-73] = "Interface\\Icons\\achievement_zone_silithus_01",							-- Call of the Scarab
		[-75] = "Interface\\Icons\\Achievement_Zone_Blackrock_01",							-- Detention Block
		[-76] = "Interface\\Icons\\Achievement_Zone_Blackrock_01",							-- Shadowforge City
		[-77] = "Interface\\Icons\\Inv_archaeology_70_starlightbeacon",						-- Special
	-- Zul'Aman
		[-78] = "Interface\\Icons\\INV_Misc_Basket_05",										-- Timed Event
		[-79] = "Interface\\Icons\\INV_Misc_Bag_28_Halloween",								-- First Chest
		[-80] = "Interface\\Icons\\inv_misc_treasurechest03a",								-- Second Chest
		[-81] = "Interface\\Icons\\INV_Misc_Bag_10",										-- Third Chest
		[-82] = "Interface\\Icons\\INV_Box_01",												-- Final Chest

	-- SM
		[-85] = "Interface\\Icons\\Achievement_BG_Xkills_AVgraveyard",						-- Graveyard (SM)
		[-86] = "Interface\\Icons\\INV_Misc_Book_13",										-- Library (SM)
		[-87] = "Interface\\Icons\\Garrison_Building_Armory",								-- Armory (SM)
		[-88] = "Interface\\Icons\\Ability_Paladin_GaurdedbytheLight",						-- Cathedral (SM)
	-- Terrace of Endless Spring loot
		[-90] = "Interface\\Icons\\INV_Misc_Bone_Skull_01",									-- Elite

		[-93] = "Interface\\Icons\\Achievement_zone_silithus_01",							-- Silithus (The Wound)
		[-94] = "Interface\\Icons\\inv_misc_lockbox_1",										-- Black Market AH
	-- Garrisons
		[-99] = "Interface\\Icons\\inv_garrison_resource",									-- Buildings
		[-101] = "Interface\\Icons\\Achievement_GarrisonFollower_LevelUp",					-- Followers
	-- Druid Feral Druid Hidden Artifact Appearance
		[-130] = "Interface\\Icons\\achievement_zone_duskwood",								-- Duskwood Active
		[-131] = "Interface\\Icons\\achievement_zone_hinterlands_01",						-- The Hinterlands Active
		[-132] = "Interface\\Icons\\achievement_zone_feralas",								-- Feralas Active
		[-133] = "Interface\\Icons\\achievement_zone_duskwood",								-- Duskwood Activated
	-- Garrisons Invasions TODO: what levels?
		[-136] = "Interface\\Icons\\achievement_bg_defendxtowers_av",						-- Garrison Invasion
	-- Class Trial
		[-137] = "Interface\\Icons\\achievement_level_90",									-- Level 90
		[-138] = "Interface\\Icons\\achievement_level_100",									-- Level 100
	--
		[-139] = app.asset("Interface_World_boss"),											-- Bosses
	-- WoD Dungeons(Fake npcid)
		[-140] = select(6, EJ_GetInstanceInfo(547)),										-- Auchindoun
		[-141] = select(6, EJ_GetInstanceInfo(385)),										-- Bloodmaul Slag Mines
		[-142] = select(6, EJ_GetInstanceInfo(536)),										-- Grimrail Depot
		[-143] = select(6, EJ_GetInstanceInfo(558)),										-- Iron Docks
		[-144] = select(6, EJ_GetInstanceInfo(537)),										-- Shadowmoon Burial Grounds
		[-145] = select(6, EJ_GetInstanceInfo(476)),										-- Skyreach
		[-146] = select(6, EJ_GetInstanceInfo(556)),										-- The Everbloom
		[-147] = select(6, EJ_GetInstanceInfo(559)),										-- Upper Blackrock Spire
	-- Garrison
		[-152] = "Interface\\Icons\\achievement_zone_draenor_01",							-- Garrison Campaign
		[-153] = 1103070,																	-- Work Orders
	-- Class Trial
		[-155] = "Interface\\Icons\\ability_bossmagistrix_timewarp1",						-- Level 48 (old level 110)																	-- Level 48 (old Level 110)
		[-155] = 236566,																	-- Level 50 (old Level 120)
	-- Druid Feral Druid Hidden Artifact Appearance
		[-157] = "Interface\\Icons\\achievement_zone_hinterlands_01",						-- The Hinterlands Activated
		[-158] = "Interface\\Icons\\achievement_zone_feralas",								-- Feralas Activated
	-- Class Hall /Artifact
		-- [-159] = Uses different icons													-- Daily Dreamway Event Roll
	-- Collections
		[-160] = app.asset("Category_Mounts"),												-- Mounts
		[-161] = app.asset("Category_ToyBox"),												-- Toy
		[-162] = "Interface\\Icons\\inv_box_petcarrier_01",									-- Pets
	-- Armor
		[-163] = "Interface\\Icons\\garrison_purplearmor",									-- Armor
	-- Junkboxes
		[-165] = "Interface\\Icons\\inv_box_01",											-- Junkboxes
	-- Emissary
		[-169] = app.asset("Interface_Emissary_Callings"),								    -- Emissary Quests
	-- Legion Artifact Questline
		[-170] = "Interface\\Icons\\spell_shaman_maelstromweapon",							-- Balance of Power
	-- Events
		[-173] = "Interface\\Icons\\spell_holy_borrowedtime",								-- Timewalking
		[-176] = 3753381,																	-- Weekly Holidays
	-- Item Sets
		[-211] = 1530081,																	-- New Characters
	-- Treasure Chest
		[-212] = app.asset("Interface_Tchest"),									            -- Treasure Chest
	-- Dalaran Sub-Zone
		[-213] = "Interface\\LFGFRAME\\LFGICON-DALARANSEWERS",								-- The Underbelly
	-- PvP
		[-216] = "Interface\\Icons\\ability_rogue_combatreadiness",							-- Prestige
	-- Fishing
		[-217] = "Interface\\Icons\\INV_Fishing_Lure_Worm",									-- Lures (for Fishing)
		[-218] = "Interface\\Icons\\Achievement_Profession_Fishing_NorthrendAngler",		-- Coastal (for Fishing)
	-- Class
		[-220] = "Interface\\MINIMAP\\TRACKING\\Class",										-- Class
	-- Bonus Objectives
		[-221] = 237387,																	-- Bonus Objectives
	-- Misc Victory (Used in many Places)
		[-227] = "Interface\\ICONS\\spell_holy_divinepurpose",								-- Victory
	-- Flight Path
		[-228] = app.asset("Category_FlightPaths"),											-- Flight Paths
	-- Misc Weekly (Used in Many Places)
		[-229] = "Interface\\Icons\\Achievement_Quests_Completed_Daily_04",					-- Weekly
	-- Warfronts
		[-233] = "Interface\\Icons\\achievement_zone_arathihighlands_01",					-- Warfront: The Battle for Stromgarde
	-- Recipes (Only used in BMAH atm)
		[-235] = "Interface\\Icons\\inv_scroll_05",											-- Recipes
	-- War Campaign
		[-236] = "Interface\\Icons\\ui_alliance_7legionmedal",								-- Alliance War Campaign
	-- Warfront
		[-237] = "Interface\\Icons\\achievement_zone_darkshore_01",							-- Warfront: The Battle for Darkshore
	-- PvP
		[-240] = "Interface\\Icons\\Achievement_BG_KillXEnemies_GeneralsRoom",				-- Rated
		[-242] = "Interface\\Icons\\Achievement_BG_KillXEnemies_GeneralsRoom",				-- Unrated
		[-243] = "Interface\\Icons\\ability_hunter_markedfordeath",							-- Bounty
	-- War Campaign
		[-253] = "Interface\\Icons\\ui_horde_honorboundmedal",								-- Horde War Campaign
	-- Allied Races
		[-254] = "Interface\\Icons\\FactionChange",											-- Allied Races & Heritage
	-- Mailbox
		[-297] = "Interface\\Icons\\inv_letter_17",											-- Mailbox
	-- Garrison Missons
		[-299] = "Interface\\Icons\\achievement_garrisonquests_1000",						-- Missions
	-- PvP
		[-302] = "Interface\\Icons\\expansionicon_cataclysm",								-- Level Range 80-84
		[-303] = "Interface\\Icons\\expansionicon_mistsofpandaria",							-- Level Range 85-89
		[-304] = "Interface\\Icons\\INV_BannerPVP_03",										-- Battlegrounds
	-- Meta Armor/Weapon
		[-318] = "Interface\\Icons\\garrison_purplearmor",									-- Armor
		[-319] = "Interface\\Icons\\garrison_purpleweapon",									-- Weapons
	-- Armor Slots
		[-320] = "Interface\\Icons\\inv_helmet_03",											-- Head
		[-321] = "Interface\\Icons\\inv_shoulder_05",										-- Shoulder
		[-322] = "Interface\\Icons\\inv_misc_cape_11",										-- Back
		[-323] = "Interface\\Icons\\inv_chest_chain",										-- Chest
		[-324] = "Interface\\Icons\\inv_shirt_grey_01",										-- Shirt
		[-325] = "Interface\\Icons\\inv_misc_tournaments_tabard_gnome",						-- Tabard
		[-326] = "Interface\\Icons\\inv_bracer_07",											-- Wrist
		[-327] = "Interface\\Icons\\Inv_gauntlets_24",										-- Hands
		[-328] = "Interface\\Icons\\inv_belt_24",											-- Waist
		[-329] = "Interface\\Icons\\inv_pants_09",											-- Legs
		[-330] = "Interface\\Icons\\inv_boots_09",											-- Feet
	-- Weapon Slots
		[-331] = "Interface\\Icons\\inv_misc_orb_01",										-- Held in Off-hand
		[-332] = "Interface\\Icons\\inv_shield_06",											-- Shield
		[-333] = "Interface\\Icons\\inv_weapon_shortblade_01",								-- Daggers
		[-334] = "Interface\\Icons\\inv_axe_17",											-- 1H Axes
		[-335] = "Interface\\Icons\\inv_axe_09",											-- 2H Axes
		[-336] = "Interface\\Icons\\inv_mace_02",											-- 1H Maces
		[-337] = "Interface\\Icons\\inv_hammer_16",											-- 2H Maces
		[-338] = "Interface\\Icons\\inv_sword_04",											-- 1H Swords
		[-339] = "Interface\\Icons\\inv_sword_07",											-- 2H Swords
		[-340] = "Interface\\Icons\\ability_demonhunter_chaosstrike",						-- Warglaives
		[-341] = "Interface\\Icons\\inv_wand_02",											-- Wands
		[-342] = "Interface\\Icons\\inv_staff_27",											-- Staffs
		[-343] = "Interface\\Icons\\inv_spear_04",											-- Polearms
		[-345] = "Interface\\Icons\\inv_weapon_rifle_01",									-- Guns
		[-346] = "Interface\\Icons\\inv_weapon_bow_05",										-- Bows
		[-347] = "Interface\\Icons\\inv_weapon_crossbow_01",								-- Crossbows
		[-348] = "Interface\\Icons\\inv_misc_monsterclaw_02",								-- Fist Weapons
	-- Cosmetic
		[-349] = "Interface\\Icons\\Ability_Mage_IceForm",									-- Cosmetic
	-- Titanforged/Warforged
		[-355] = "Interface\\Icons\\misc_arrowlup",											-- Titanforged
	-- First Questline Draenor
		[-356] = "Interface\\Icons\\achievement_dungeon_outland_dungeonmaster",				-- Assault on the Dark Portal
	-- Outposts in Draenor
		[-357] = "Interface\\Icons\\garrison_building_sparringarena",						-- Sparring Arena Outpost (Gorgond)
		[-358] = "Interface\\Icons\\garrison_building_lumbermill",							-- Lumber Mill Outpost (Gorgrond)
		[-360] = "Interface\\Icons\\inv_misc_runedorb_01",									-- Arcane Sanctum
		[-361] = "Interface\\Icons\\ability_vehicle_siegeenginecannon",						-- Artillery Tower
		[-363] = "Interface\\Icons\\achievement_reputation_argentchampion",					-- The Argent Tournament
	-- Pre Class Hall Monk
		[-362] = "Interface\\Icons\\ability_monk_legacyoftheemperor",						-- Peak of Serenity
	-- Legendaries
		[-364] = app.asset("Weapon_Type_Legendary"),										-- Legendaries
	-- Heirlooms
		[-365] = app.asset("Weapon_Type_Heirloom"),											-- Heirlooms
	-- Naxxramas
		[-367] = "Interface\\Icons\\ability_rogue_deviouspoisons",							-- The Construct Quarter
		[-368] = "Interface\\Icons\\inv_trinket_naxxramas04",								-- The Arachnid Quarter
		[-369] = "Interface\\Icons\\spell_deathknight_classicon",							-- The Military Quarter
		[-370] = "Interface\\Icons\\inv_misc_cauldron_nature",								-- The Plague Quarter
		[-371] = "Interface\\Icons\\inv_misc_head_dragon_blue",								-- The Upper Necropolis
	-- Operation:Mechagon
		[-379] = "Interface\\Icons\\inv_misc_blizzcon09_graphicscard",						-- Junkyard
		[-380] = "Interface\\Icons\\inv_misc_key_06",										-- Workshop
	-- Misc Armor Slots
		[-383] = "Interface\\Icons\\inv_misc_gem_variety_02",								-- Miscellaneous
		[-384] = "Interface\\Icons\\inv_jewelcrafting_70_maxlvlneck_green",					-- Neck
		[-385] = "Interface\\Icons\\inv_70_dungeon_ring5a",									-- Finger
		[-386] = "Interface\\Icons\\inv_qirajidol_obsidian",								-- Trinket
		[-387] = "Interface\\Icons\\inv_staff_2h_felfireraid_d_03",							-- Relic
	-- Stratholme
		[-388] = "Interface\\Icons\\INV_Misc_Token_ScarletCrusade",							-- Main Gate (Stratholme)
		[-389] = "Interface\\Icons\\INV_MISC_KEY_13",										-- Service Entrance (Stratholme)
	-- Draenor Outposts
		[-390] = "Interface\\Icons\\inv_misc_coinbag_special",								-- Smuggler's Den
		[-391] = "Interface\\Icons\\achievement_guildperk_hastyhearth",						-- Stoktron Brewery (alliance)
		[-392] = "Interface\\Icons\\achievement_guildperk_hastyhearth",						-- Hearthfire Tavern (horde)
	-- Icecrown Citadel
		[-393] = "Interface\\Icons\\achievement_dungeon_icecrown_icecrownentrance",			-- Storming the Citadel
		[-394] = "Interface\\Icons\\achievement_dungeon_plaguewing",						-- The Plagueworks
		[-395] = "Interface\\Icons\\achievement_dungeon_crimsonhall",						-- The Crimson Halls
		[-396] = "Interface\\Icons\\achievement_dungeon_icecrown_frostwinghalls",			-- The Frostwing Halls
	-- BFA Outposts
		[-397] = "Interface\\Icons\\inv_icon_daily_mission_scroll",							-- Outposts
	-- T0.5
		[-420] = "Interface\\Icons\\INV_Chest_Plate03",										-- Tier 0.5 Sets
	-- BFA War Chest
		[-488] = "Interface\\Icons\\inv_misc_treasurechest04b",								-- Daily War Chest
	-- Tarot Cards
		[-491] = "Interface\\Icons\\inv_misc_ticket_tarot_rogue",							-- Tarot Cards
	-- Misc
		[-494] = "Interface\\Icons\\Ability_Shaman_Ascendance",								-- Miscellaneous
	-- Class Hall Demon Hunter
		[-498] = "Interface\\Icons\\inv_offhand_hyjal_d_01",								-- Twisting Nether (Demon Hunter Order Hall advancement)
		-- Mole Machine
		[-517] = "Interface\\Icons\\ability_racial_molemachine",							-- Mole Machine
	-- Blizzard Events and Anniversaries
		[-520] = "Interface\\Icons\\inv_misc_missilesmallcluster_green",					-- Expansion Pre-Launch
		[-522] = "Interface\\Icons\\expansionicon_wrathofthelichking",						-- Wotlk: Zombie Infestation
		[-523] = "Interface\\Icons\\expansionicon_cataclysm",								-- Cataclysm: Elemental Unrest
		[-525] = "Interface\\Icons\\Achievement_Boss_Blackhand",							-- WoD: Iron Horde Incursion
		[-526] = "Interface\\Icons\\inv_legionadventure",									-- Legion: Legion Invasion
		[-527] = "Interface\\Icons\\Spell_Shaman_StormEarthFire",							-- BFA: War of the Thorns
		[-531] = "Interface\\Icons\\inv_jewelry_amulet_03",									-- Spirit of Competition
		[-532] = "Interface\\Icons\\ability_shaman_stormstrike",							-- Heroes of the Storm
		[-533] = "Interface\\Icons\\Inv_misc_rune_01",										-- Hearthstone
		[-534] = "Interface\\Icons\\inv_misc_gift_01",										-- Collector's Edition
		[-535] = "Interface\\Icons\\ACHIEVEMENT_GUILDPERK_LADYLUCK",						-- Trading Card Game
		[-536] = "Interface\\Icons\\Inv_misc_rune_01",										-- Hearthstone Mercenaries
		[-537] = "Interface\\Icons\\diabloanniversary_achievement",							-- Diablo 20th Anniversary
		[-538] = "Interface\\Icons\\inv_box_01",											-- The Ahn'Qiraj War Effort
		[-539] = "Interface\\Icons\\Inv_hammer_25",											-- The Scepter of the Shifting Sands
		[-540] = "Interface\\Icons\\inv_stone_02",											-- The Scourge Invasion
		[-541] = "Interface\\Icons\\spell_holiday_tow_spicecloud",							-- The Silithyst Must Flow
		[-542] = "Interface\\Icons\\achievement_dungeon_outland_dungeonmaster",				-- The Opening of the Dark Portal
		[-543] = app.asset("Interface_Linvas"),						                    	-- Legion Invasions
		[-544] = "Interface\\Icons\\WoW_Token01",											-- WoW Collector's Edition
		[-545] = "Interface\\Icons\\inv_misc_blizzcon09_poster",							-- Blizzcon
		[-546] = "Interface\\Icons\\achievement_reputation_08",								-- Recruit A Friend
		[-550] = "Interface\\Icons\\Ability_pet_baneling",									-- Starcraft Collector's Edition
		[-551] = "Interface\\Icons\\DiabloAnniversary_HoradricCube",						-- Diablo Collector's Edition
		[-552] = "Interface\\Icons\\INV_Mace_1H_Doomhammer",								-- Warcraft 3 Spoils of War Edition
		[-553] = "Interface\\Icons\\INV_Drink_33_BloodRedAle",								-- iCoke
		[-554] = "Interface\\Icons\\INV_Misc_PaperPackage01c",								-- EU Fansite Promotion
		[-555] = "Interface\\Icons\\INV_Elemental_Primal_Air",								-- Korean Promotional Event
		[-556] = "Interface\\Icons\\achievement_arena_2v2_7",								-- Arena Tournament
		[-557] = "Interface\\Icons\\INV_Elemental_Primal_Air",								-- Korea World Event
		[-558] = "Interface\\Icons\\achievement_arena_2v2_7",								-- Battle.net World Championship Shanghai 2012
		[-564] = "Interface\\Icons\\Inv_sigil_thorim",										-- Starcraft II: Wings of Liberty
		[-565] = "Interface\\Icons\\Ability_pet_baneling",									-- Starcraft II: Heart of the Swarm
		[-566] = "Interface\\Icons\\DiabloAnniversary_HoradricCube",						-- Diablo III
		[-568] = "Interface\\Icons\\inv_pet_babywinston",									-- Overwatch: Origins
		[-569] = "Interface\\Icons\\Ability_hunter_pet_turtle",								-- Azeroth Academy Mentor Recruitment Promotion (China Only)
		[-573] = "Interface\\Icons\\spell_holy_guardianspirit",								-- Scroll of Resurrection
		[-574] = "Interface\\Icons\\DiabloAnniversary_HoradricCube",						-- Diablo III Annual Pass
		[-575] = "Interface\\Icons\\DiabloAnniversary_HoradricCube",						-- Diablo III: Reaper of Souls
		[-576] = "Interface\\Icons\\inv_archonpet",											-- StarCraft II: Legacy of the Void
		[-577] = "Interface\\Icons\\INV_MISC_FILM_01",										-- Warcraft Movie
		[-578] = app.asset("Expansion_CLASSIC"),											-- World of Warcraft 15th Anniversary
		[-579] = "Interface\\Icons\\achievement_dungeon_outland_dungeonmaster",				-- Dark Portal Pass
	-- Raid Buff Stack Size in Uldir
		[-583] = "Interface\\Icons\\inv_trinket_80_titan02c",								-- Power Increased to Level 1
		[-584] = "Interface\\Icons\\inv_trinket_80_titan02c",								-- Power Increased to Level 2
		[-585] = "Interface\\Icons\\inv_trinket_80_titan02c",								-- Power Increased to Level 3
		[-586] = "Interface\\Icons\\inv_trinket_80_titan02c",								-- Power Increased to Level 4
		[-587] = "Interface\\Icons\\inv_trinket_80_titan02c",								-- Power Increased to Level 5
		[-588] = "Interface\\Icons\\inv_trinket_80_titan02c",								-- Power Increased to Level 6
		[-589] = "Interface\\Icons\\inv_trinket_80_titan02c",								-- Power Increased to Level 7
		[-590] = "Interface\\Icons\\inv_trinket_80_titan02c",								-- Power Increased to Level 8
		[-591] = "Interface\\Icons\\inv_trinket_80_titan02c",								-- Power Increased to Level 9
		[-592] = "Interface\\Icons\\inv_trinket_80_titan02c",								-- Power Increased to Level 10
		[-593] = "Interface\\Icons\\70_inscription_deck_Hellfire",							-- Kill Credit 1
		[-594] = "Interface\\Icons\\70_inscription_deck_Hellfire_2",						-- Kill Credit 2
		[-595] = "Interface\\Icons\\70_inscription_deck_Hellfire_3",						-- Kill Credit 3
	-- Need these spells here because if we use them in the file it won't allow the quest to mark as complete due to it not being designed that way.
	-- This is the workaround.
	-- Quest Items - Used in NYI
		--[-600] = Doesnt need icon															-- Quest Items
	-- PvP Headers
		--[-650] = 1455894,																	-- Rated Battlegrounds
		--[-651] = "Interface\\Worldmap\\GlowSkull_64Grey",									-- Not used yet. Future PvP Icons if needed
		--[-652] = "Interface\\Worldmap\\GlowSkull_64",										-- Not used yet. Future PvP Icons if needed
		[-651] = "Interface\\Icons\\inv_pandarenserpentmount_white",						-- Honor Gear Prideful (S15)
		[-652] = "Interface\\Icons\\inv_pandarenserpentmount_white",						-- Honor Gear Grievous (S14)
		[-653] = "Interface\\Icons\\inv_pandarenserpentmount_white",						-- Honor Gear Tyrannical (S13)
		[-654] = "Interface\\Icons\\ability_mount_drake_twilight",							-- Honor Gear Cataclysmic (S11)
		--[-655] = 1596892, 																	-- Ensemble Gear (PvP)
		[-656] = "Interface\\Icons\\ability_mount_drake_twilight",							-- Honor Gear Ruthless (S10)
		[-657] = "Interface\\Icons\\ability_mount_redfrostwyrm_01",							-- Hateful Gladiator: Season 5 (Medium Gear)
		[-658] = app.asset("Expansion_TBC"),												-- Pre-Season BC
	-- PvP Set Names
		[-659] = "Interface\\Worldmap\\GlowSkull_64Green",									-- Aspirant PvP Gear
		[-660] = "Interface\\Worldmap\\GlowSkull_64Blue",									-- Combatant PvP Gear
		[-661] = "Interface\\Worldmap\\GlowSkull_64Purple",									-- Gladator PvP Gear
		[-662] = "Interface\\Worldmap\\GlowSkull_64Red",									-- Elite PvP Gear
	-- The Burning Crusade PvP Seasons
		[-663] = 463450,																	-- Classic Honor System
		[-664] = "Interface\\Icons\\achievement_featsofstrength_gladiator_01",				-- Gladiator: Season 1
		[-665] = "Interface\\Icons\\achievement_featsofstrength_gladiator_01",				-- Merciless Gladiator: Season 2
		[-666] = "Interface\\Icons\\achievement_featsofstrength_gladiator_02",				-- Vengeful Gladiator: Season 3
		[-667] = "Interface\\Icons\\achievement_featsofstrength_gladiator_03",				-- Brutal Gladiator: Season 4
	-- Wrath of the Lich-King PvP Seasons
		[-668] = "Interface\\Icons\\ability_mount_redfrostwyrm_01",							-- Deadly Gladiator: Season 5
		[-669] = "Interface\\Icons\\ability_mount_redfrostwyrm_01",							-- Furious Gladiator: Season 6
		[-670] = "Interface\\Icons\\ability_mount_redfrostwyrm_01",							-- Relentless Gladiator: Season 7
		[-671] = "Interface\\Icons\\ability_mount_redfrostwyrm_01",							-- Wrathful Gladiator: Season 8
	-- Cataclysm PvP Seasons
		[-672] = "Interface\\Icons\\ability_mount_drake_twilight",							-- Vicious Gladiator: Season 9
		[-673] = "Interface\\Icons\\ability_mount_drake_twilight",							-- Ruthless Gladiator: Season 10
		[-674] = 236235,																	-- Cataclysmic Gladiator: Season 11
	-- Mists of Pandaria PvP Seasons
		[-675] = "Interface\\Icons\\inv_pandarenserpentmount_white",						-- Malevolent Gladiator: Season 12
		[-676] = "Interface\\Icons\\inv_pandarenserpentmount_white",						-- Tyrannical Gladiator: Season 13
		[-677] = "Interface\\Icons\\inv_pandarenserpentmount_white",						-- Grievous Gladiator: Season 14
		[-678] = "Interface\\Icons\\inv_pandarenserpentmount_white",						-- Prideful Gladiator: Season 15
	-- Warlords of Dreanor PvP Seasons
		[-679] = "Interface\\Icons\\inv_fellessergronnmount",								-- Primal Gladiator: Warlords Season 1
		[-680] = "Interface\\Icons\\inv_fellessergronnmount_pale",							-- Wild Gladiator: Warlords Season 2
		[-681] = "Interface\\Icons\\inv_fellessergronnmount_dark",							-- Warmongering Gladiator: Warlords Season 3
	-- Legion PvP Seasons
		[-682] = "Interface\\Icons\\inv_stormdragonmount2",									-- Vindictive Gladiator: Legion Season 1
		[-683] = "Interface\\Icons\\inv_stormdragonmount2blue",								-- Fearless Gladiator: Legion Season 2
		[-684] = "Interface\\Icons\\inv_stormdragonmount2dark",								-- Cruel Gladiator: Legion Season 3
		[-685] = "Interface\\Icons\\inv_stormdragonmount2green",							-- Ferocious Gladiator: Legion Season 4
		[-686] = "Interface\\Icons\\inv_stormdragonmount2light",							-- Fierce Gladiator: Legion Season 5
		[-687] = "Interface\\Icons\\inv_stormdragonmount2yellow",							-- Dominant Gladiator: Legion Season 6
		[-688] = "Interface\\Icons\\inv_stormdragonmount2_fel",								-- Demonic Gladiator: Legion Season 7
	-- Battle for Azeroth PvP Seasons
		[-689] = "Interface\\Icons\\inv_protodrakegladiatormount_gold",						-- Dread Gladiator: Battle for Azeroth Season 1
		[-690] = "Interface\\Icons\\inv_protodrakegladiatormount_blue",						-- Sinister Gladiator: Battle for Azeroth Season 2
		[-691] = "Interface\\Icons\\inv_protodrakegladiatormount_purple",					-- Notorious Gladiator: Battle for Azeroth Season 3
		[-692] = "Interface\\Icons\\inv_protodrakegladiatormount_black",					-- Corrupted Gladiator: Battle for Azeroth Season 4
	-- Shadowlands PvP Seasons
		[-693] = "Interface\\Icons\\inv_shadebeastmount",									-- Sinful Gladiator: Shadowlands Season 1
		[-694] = 3949827,																	-- Unchained Gladiator: Shadowlands Season 2
	-- More PvP Seasons are likely to come dont use IDs here
	-- Pets
		[-796] = app.asset("Category_PetBattles"),											-- Battle
		[-797] = 631719,																	-- Journal
	-- Toys
		[-798] = app.asset("Category_SelfieFilters"),										-- Selfie Filter
	-- Timeless Isle
		[-799] = "775461",																	-- Burden of Eternity
	-- Secret Header
		[-800] = "Interface\\Icons\\inv_horse2purple",										-- Lucid Nightmare
		[-801] = "Interface\\Icons\\inv_serpentmount_darkblue",								-- Riddler's Mind-Worm
		[-802] = "Interface\\Icons\\inv_faeriedragon2_orange",								-- Sun Darter Hatchling
		[-804] = "Interface\\Icons\\inv_misc_toy_02",										-- Uuna
		[-805] = "Interface\\Icons\\inv_demongoat",											-- Baa'l
		[-806] = "Interface\\Icons\\inv_belt_armor_waistoftime_d_01",						-- Waist of Time
		[-807] = "Interface\\Icons\\inv_hivemind",											-- Hivemind
		[-808] = 2998185,																	-- Bound Shadehound
	-- More Secrets are likely to come dont use IDs here
	-- Chests
		[-850] = "Interface\\Icons\\INV_Eng_Crate2",										-- Mechanized Chest
		[-851] = "Interface\\Icons\\INV_Eng_Crate2",										-- Irontide Lockbox
	-- Heart of Azeroth
		[-852] = "Interface\\Icons\\inv_heartofazeroth",									-- Azerite Essences
		[-853] = "Interface\\Icons\\inv_azeritedebuff",										-- All Roles
		[-854] = "Interface\\Icons\\spell_fire_twilightpyroblast",							-- DPS
		[-855] = "Interface\\Icons\\spell_nature_healingwavegreater",						-- Healers
		[-856] = "Interface\\Icons\\ability_warrior_shieldwall",							-- Tanks
		[-857] = "Interface\\Icons\\inv_relics_hourglass",									-- Mythic+
		[-858] = "Interface\\Icons\\inv_smallazeritefragment",								-- Rank 1
		[-859] = "Interface\\Icons\\inv_tinyazeritesplinter",								-- Rank 2
		[-860] = "Interface\\Icons\\inv_smallazeriteshard",									-- Rank 3
		[-861] = "Interface\\Icons\\inv_smallazeritecluster",								-- Rank 4
		[-862] = "Interface\\Icons\\inv_heartofazeroth",									-- Heart of Azeroth
	-- SL Headers
		[-900] = 3675495,																	-- Covenant Sanctums
		[-901] = 3726261,																	-- Covenant Callings
		[-902] = 3726261,																	-- Renown
		[-903] = app.asset("Interface_Rewards"),											-- Zone Rewards
		[-904] = "Interface\\Icons\\ui_torghast",											-- Wrath of the Jailer
		[-905] = 3675495,																	-- Command Table
		[-906] = 3675495,																	-- Tier 1: Tactical Insight
		[-913] = "Interface\\Icons\\ui_torghast",											-- Tormentors of Torghast
		[-915] = "Interface\\Icons\\sanctum_features_animadiversion",						-- Anima Conductor
		[-916] = "Interface\\Icons\\sanctum_features_animadiversion",						-- Tier 1: Flowing Tendrils
		[-917] = "Interface\\Icons\\sanctum_features_animadiversion",						-- Tier 2: Streaming Threads
		[-918] = "Interface\\Icons\\sanctum_features_animadiversion",						-- Tier 3: Flowing Power
		[-920] = "Interface\\Icons\\ui_sigil_necrolord",									-- Covenant: Necrolord
		[-921] = "Interface\\Icons\\ui_sigil_necrolord",									-- Sanctum Upgrades (Necrolord)
		[-922] = 132334,																	-- Theater of Pain
		[-923] = "Interface\\Icons\\ui_sigil_necrolord",									-- Abomination Factory (Necrolord)
		[-924] = "Interface\\Icons\\ui_sigil_necrolord",									-- Transport Network (Necrolord)
		[-925] = "Interface\\Icons\\ui_sigil_necrolord",									-- Abomination Factory (Necrolord) Tier 1
		[-926] = "Interface\\Icons\\ui_sigil_necrolord",									-- Abomination Factory (Necrolord) Tier 2
		[-927] = "Interface\\Icons\\ui_sigil_necrolord",									-- Abomination Factory (Necrolord) Tier 3
		[-928] = "Interface\\Icons\\ui_sigil_necrolord",									-- Abomination Factory (Necrolord) Tier 4
		[-929] = "Interface\\Icons\\ui_sigil_nightfae",										-- Covenant: Night Fae
		[-930] = 136059,																	-- Queen's Conservatory
		[-1002] = 3528288,																	-- Dutiful Spirit
		[-1003] = 3528296,																	-- Martial Spirit
		[-1004] = 3528312,																	-- Prideful Spirit
		[-1005] = 3528280,																	-- Untamed Spirit
		[-935] = "Interface\\Icons\\ui_sigil_nightfae",										-- Sanctum Upgrades (Night Fae)
		[-936] = "Interface\\Icons\\ui_sigil_nightfae",										-- Soulshape Forms (Night Fae)
		[-937] = "Interface\\Icons\\ui_sigil_nightfae",										-- Transport Network (Night Fae)
		[-938] = "Interface\\Icons\\ui_sigil_necrolord",									-- Abomination Factory (Necrolord) Tier 5
		[-939] = "Interface\\Icons\\ui_sigil_kyrian",										-- Covenant: Kyrian
		[-941] = "Interface\\Icons\\ui_sigil_kyrian",										-- Sanctum Upgrades (Kyrian)
		[-942] = 3675496,																	-- Path of Ascension
		[-943] = 3536186,																	-- Tier 1: First Steps
		[-944] = 3196822,																	-- Tier 2: Sacred Trials
		[-945] = 3565450,																	-- Tier 3: Continued Training
		[-946] = 3565447,																	-- Tier 4: Teachings of Wisdom
		[-947] = 3565449,																	-- Tier 5: Trials of Humility
		[-948] = 3854018,																	-- Transport Network (Kyrian)
		[-3348] = 3854018,																	-- Tier 1: Step of Faith
		[-3349] = 3854018,																	-- Tier 2: Leap of Power
		[-3350] = 3854018,																	-- Tier 3: Eternal Paths
		[-949] = "Interface\\Icons\\ui_sigil_venthyr",										-- Covenant: Venthyr
		[-950] = 3854020,																	-- Transport Network
		[-951] = 3854020,																	-- Tier 1: Mirror Mirror
		[-952] = 3854020,																	-- Tier 2: Looking Glass
		[-953] = 3854020,																	-- Tier 3: Mirror's Edge
		[-954] = "Interface\\Icons\\spell_animarevendreth_buff",							-- Inquisitors
		[-955] = "Interface\\Icons\\spell_animarevendreth_buff",							-- High Inquisitors
		[-956] = "Interface\\Icons\\spell_animarevendreth_buff",							-- Grand Inquisitors
		[-957] = "Interface\\Icons\\ui_sigil_venthyr",										-- Sanctum Upgrades (Venthyr)
		[-958] = 3675495,																	-- Tier 2: Deserved Feast
		[-959] = 3675495,																	-- Tier 3: Superior Efficiency
		[-960] = 3675493,																	-- The Ember Court
		[-961] = 3675493,																	-- Tier 1: A New Court
		[-962] = 3675493,																	-- Tier 2: Homegrown Help
		[-963] = 3675493,																	-- Tier 3: Court Influencer
		[-964] = 3675493,																	-- Tier 4: Discerning Taste
		[-965] = 3675493,																	-- Tier 5: The Professionals
		[-966] = 979574,																	-- Blueprints & Crafting (for Kyrian Path of Ascension)
		[-967] = 3854020,																	-- Mirror Restoration
		[-968] = 3854020,																	-- Set A
		[-969] = 3854020,																	-- Set B
		[-970] = 3854020,																	-- Set C
		[-971] = 3854020,																	-- Set D
		[-972] = 3536185,																	-- Courage
		[-973] = 3536186,																	-- Loyalty
		[-974] = 3536184,																	-- Wisdom
		[-975] = 3536187,																	-- Humility
		[-978] = 651097,																	-- The Rift
		[-981] = 3601566,																	-- Conduits
		[-982] = 2178518,																	-- Skoldus Hall
		[-983] = 1392920,																	-- Fracture Chambers
		[-984] = 1392929,																	-- The Soulforges
		[-985] = 1392911,																	-- Coldheart Interstitia
		[-986] = 2178500,																	-- Mort'regar
		[-987] = 2178509,																	-- The Upper Reaches
		--
	-- Sets
		[-1000] = "Interface\\Icons\\achievement_transmog_collections",						-- Sets
	-- Black Vault
		[-1001] = "Interface\\Icons\\Racial_Dwarf_FindTreasure",							-- The Black Vault
	-- Warrior order hall lore items
		[-2200] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
		[-2201] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
		[-2202] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
		[-2203] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
		[-2204] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
		[-2205] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
		[-2206] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
		[-2207] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
		[-2208] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
		[-2209] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
		[-2210] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
		[-2211] = "Interface\\Icons\\inv_scroll_11",										-- Warrior order hall lore item
	-- T3
		[-3179] = "Interface\\Icons\\achievement_dungeon_naxxramas",						-- Tier 3 Sets
	-- Island Expeditions Sets
		[-3315] = "Interface\\Icons\\Inv_helm_robe_raidwarlock_j_01",						-- Spider Acolyte
		[-3316] = "Interface\\Icons\\inv_helmet_robe_raidpriest_j_01",						-- Hydraxian
		[-3317] = "Interface\\Icons\\Inv_helmet_robe_raidmage_j_01",						-- Frostwind
		[-3318] = "Interface\\Icons\\Inv_helmet_robe_raidwarlock_k_01",						-- Faceless Follower
		[-3319] = "Interface\\Icons\\Inv_helm_cloth_raidwarlock_q_01",						-- Swarmfury
		[-3320] = "Interface\\Icons\\Inv_helmet_leather_raiddruid_j_01",					-- Spiritbough
		[-3321] = "Interface\\Icons\\Inv_helmet_leather_raidmonk_l_01",						-- Tranquil Path
		[-3322] = "Interface\\Icons\\Inv_helm_leather_vrykulhunter_b_01",					-- Miststalker
		[-3323] = "Interface\\Icons\\Inv_helmet_leatherraidrogue_i_01",						-- Whirling Dervish
		[-3324] = "Interface\\Icons\\Inv_helm_leather_raiddruid_l_01",						-- Feralbark
		[-3325] = "Interface\\Icons\\Inv_helm_leather_firelandsdruid_d_01",					-- Firekin
		[-3326] = "Interface\\Icons\\Inv_helm_mail_raidhunter_l_01",						-- Wild Marauder
		[-3327] = "Interface\\Icons\\Inv_helm_mail_vrykuldragonrider_b_01",					-- Dragonrider
		[-3328] = "Interface\\Icons\\Inv_helm_mail_raidhunter_m_01",						-- Saurok
		[-3329] = "Interface\\Icons\\Inv_helm_mail_raidhunter_i_01",						-- Mrrglurggl
		[-3330] = "Interface\\Icons\\Inv_helmet_mail_raidshaman_k_01",						-- Headshrinker
		[-3331] = "Interface\\Icons\\Inv_helmet_116",										-- Voodoo Stalker
		[-3332] = "Interface\\Icons\\Inv_helmet_plate_raidwarrior_i_01",					-- Geocrag
		[-3333] = "Interface\\Icons\\Inv_helmet_plate_raidpaladin_j_01",					-- Razorfin
		[-3334] = "Interface\\Icons\\Inv_helmet_plate_raidwarrior_m_01",					-- Tomb-Keeper
		[-3335] = "Interface\\Icons\\Inv_helm_plate_vrykulwarrior_b_01",					-- Bloodwake
		[-3336] = "Interface\\Icons\\Inv_helmet_114",										-- Rattling Bone
		[-3337] = "Interface\\Icons\\Inv_helmet_plate_raidwarrior_k_01",					-- Twilight Dragon
		[-3339] = "Interface\\Icons\\Achievement_transmog_collections",						-- Item Sets
		[-3340] = "Interface\\Icons\\inv_helmet_30",										-- Dark Animator
		[-3341] = "Interface\\Icons\\inv_helmet_51",										-- Duskhaven
		[-3342] = "Interface\\Icons\\inv_helm_cloth_vrykulcaster_b_01",						-- Fallen Runelord
		[-3343] = "Interface\\Icons\\inv_helmet_153",										-- Choking Winter
		[-3344] = "Interface\\Icons\\inv_helmet_157",										-- Frostsworn
		[-3345] = "Interface\\Icons\\Inv_helmet_151",										-- Sanctified Scourgelord
		[-3347] = "Interface\\Icons\\inv_plate_draenorlfr_c_01helm",						-- Black Tooth Grunt
		[-4189] = "Interface\\Icons\\achievement_legionpvptier4",							-- Instance Item Sets, PvP
		[-4191] = "Interface\\Icons\\Achievement_PVP_Legion08",
		[-5350] = "Interface\\Icons\\ability_bossmagistrix_timewarp1",						-- Class Trial Item Sets
		[-6013] = app.asset("Category_Factions"),											-- Faction
		[-6014] = "Interface\\Icons\\Spell_Arcane_PortalUnderCity",							-- Cities
		[-7776] = "Interface\\Icons\\INV_Helm_Cloth_Holiday_Christmas_A_03",				-- Winter Revelers (for Winter Veil)
	-- Horde/Alliance/Neutral
		[-9912] = "Interface\\FriendsFrame\\PlusManz-PlusManz",						-- Neutral
		[-9913] = "Interface\\FriendsFrame\\PlusManz-Horde",						-- Horde
		[-9914] = "Interface\\FriendsFrame\\PlusManz-Alliance",						-- Alliance
	-- Specs
		[-9915] = "Interface\\Icons\\spell_holy_wordfortitude",						-- Discipline Priest Spec
		[-9917] = "Interface\\Icons\\spell_shadow_shadowwordpain",					-- Shadow Priest Spec
		[-9924] = "Interface\\Icons\\TalentSpec_Druid_Feral_Bear",					-- Guardian Druid Spec
		[-9925] = "Interface\\Icons\\TalentSpec_Druid_Feral_Cat",					-- Feral Druid Spec
		[-9926] = "Interface\\Icons\\TalentSpec_Druid_Balance",						-- Balance Druid Spec
		[-9927] = "Interface\\Icons\\TalentSpec_Druid_Restoration",					-- Restoration Druid Spec
		[-9931] = "Interface\\Icons\\Spell_Monk_Brewmaster_Spec",					-- Brewmaster Monk Spec
		[-9932] = "Interface\\Icons\\Spell_Monk_WindWalker_Spec",					-- Windwalker Monk Spec
		[-9933] = "Interface\\Icons\\Spell_Monk_MistWeaver_Spec",					-- Mistweaver Monk Spec
		[-9939] = "Interface\\Icons\\spell_nature_lightning",						-- Elemental Shaman Spec
		[-9940] = "Interface\\Icons\\spell_nature_lightningshield",					-- Enhancement Shaman Spec
		[-9941] = "Interface\\Icons\\spell_nature_magicimmunity",					-- Restoration Shaman Spec
		[-9942] = "Interface\\Icons\\Spell_Holy_HolyBolt",							-- Holy Paladin Spec
		[-9943] = "Interface\\Icons\\Ability_Paladin_ShieldoftheTemplar",			-- Protection Paladin Spec
		[-9944] = "Interface\\Icons\\spell_holy_auraoflight",						-- Retribution Paladin Spec
		[-9945] = "Interface\\Icons\\ability_rogue_eviscerate",						-- Arms Warrior Spec
		[-9947] = "Interface\\Icons\\INV_Shield_06",								-- Protection Warrior Spec
		[-9948] = "Interface\\Icons\\Spell_Deathknight_BloodPresence",				-- Blood Death Knight Spec
		[-9949] = "Interface\\Icons\\Spell_Deathknight_FrostPresence",				-- Frost Death Knight Spec
		[-9951] = "Interface\\Icons\\ClassIcon_Priest",								-- Discipline / Holy Spec
		[-9952] = "Interface\\Icons\\ClassIcon_Druid",								-- Guardian / Feral Spec
	------ ACHIEVEMENT HEADER SECTION ------
		[-9955] = "Interface\\Icons\\achievement_general",							-- General

		[-9957] = "Interface\\Icons\\inv_misc_map02",								-- Exploration

		[-9959] = app.asset("Category_D&R"),										-- Dungeons & Raids
		[-9960] = app.asset("Category_Professions"),								-- Professions
		[-9961] = app.asset("Category_Factions"),									-- Reputation
		[-9962] = app.asset("Category_Event"),										-- World Events
		[-9963] = app.asset("Category_PetJournal"),									-- Pet Battles
		[-9964] = "Interface\\Icons\\Paladin_Protection",							-- Collections
		[-9965] = "Interface\\Icons\\achievement_level_110",						-- Class Hall
		[-9966] = "Interface\\Icons\\inv_garrison_hearthstone",						-- Draenor Garrison
		[-9968] = "Interface\\Icons\\Paladin_Protection",							-- Legacy
		[-9969] = "Interface\\Icons\\Paladin_Protection",							-- Feats of Strength
		[-9971] = "Interface\\Icons\\inv_misc_food_15",								-- Cooking
		[-9972] = "Interface\\Icons\\trade_fishing",								-- Fishing
		[-9974] = "Interface\\Icons\\trade_archaeology",							-- Archaeology
		[-9975] = app.asset("Expansion_CLASSIC"),									-- Eastern Kingdoms
		[-9976] = app.asset("Expansion_CLASSIC"),									-- Kalimdor
		[-9977] = app.asset("Expansion_TBC"),										-- Outland
		[-9978] = app.asset("Expansion_WOTLK"),										-- Northrend
		[-9979] = app.asset("Expansion_CATA"),										-- Cataclysm
		[-9980] = app.asset("Expansion_MOP"),										-- Pandaria
		[-9981] = app.asset("Expansion_WOD"),										-- Draenor
		[-9982] = app.asset("Expansion_LEGION"),									-- Legion
		[-9983] = "Interface\\Icons\\Paladin_Protection",							-- Honor
		[-9984] = "Interface\\Icons\\Paladin_Protection",							-- Warsong Gulch
		[-9985] = "Interface\\Icons\\Paladin_Protection",							-- Arathi Basin
		[-9986] = "Interface\\Icons\\Paladin_Protection",							-- Eye of the Storm
		[-9987] = "Interface\\Icons\\Paladin_Protection",							-- Alterac Valley
		[-9988] = "Interface\\Icons\\Paladin_Protection",							-- Isle of Conquest
		[-9990] = "Interface\\Icons\\Paladin_Protection",							-- Battle for Gilneas
		[-9991] = "Interface\\Icons\\Paladin_Protection",							-- Twin Peaks
		[-9992] = "Interface\\Icons\\Paladin_Protection",							-- Silvershard Mines
		[-9993] = "Interface\\Icons\\Paladin_Protection",							-- Temple of Kotmogu
		[-9994] = "Interface\\Icons\\Paladin_Protection",							-- Deepwind Gorge
		[-9995] = "Interface\\Icons\\Paladin_Protection",							-- Wintergrasp
		[-9996] = "Interface\\Icons\\Paladin_Protection",							-- Tol Barad
		[-9997] = "Interface\\Icons\\Paladin_Protection",							-- Ashran
		[-9999] = "Interface\\Icons\\Paladin_Protection",							-- Rated Battleground
		[-10000] = "Interface\\Icons\\Paladin_Protection",							-- Arena
		[-10001] = "Interface\\Icons\\Paladin_Protection",							-- Seething Shore
		[-10002] = app.asset("Expansion_CLASSIC"),									-- Classic
		[-10003] = app.asset("Expansion_TBC"),										-- The Burning Crusade
		[-10004] = app.asset("Expansion_WOTLK"),									-- Lich King Dungeon
		[-10005] = app.asset("Expansion_WOTLK"),									-- Lich King Raid
		[-10006] = app.asset("Expansion_CATA"),										-- Cataclysm Dungeon
		[-10007] = app.asset("Expansion_CATA"),										-- Cataclysm Raid
		[-10008] = app.asset("Expansion_MOP"),										-- Pandaria Dungeon
		[-10009] = app.asset("Expansion_MOP"),										-- Pandaria Raid
		[-10010] = app.asset("Expansion_WOD"),										-- Draenor Dungeon
		[-10011] = app.asset("Expansion_WOD"),										-- Draenor Raid
		[-10012] = app.asset("Expansion_LEGION"),									-- Legion Dungeon
		[-10013] = app.asset("Expansion_LEGION"),									-- Legion Raid
		[-10014] = app.asset("Expansion_WOTLK"),									-- Wrath of the Lich King







		[-10025] = app.asset("Event_dmf"),											-- Darkmoon Faire
		[-10026] = "Interface\\Icons\\spell_holy_fistofjustice",					-- Brawler's Guild
		[-10027] = "Interface\\Icons\\Paladin_Protection",							-- Collect
		[-10028] = "Interface\\Icons\\Paladin_Protection",							-- Battle
		[-10029] = "Interface\\Icons\\Paladin_Protection",							-- Level
		[-10030] = app.asset("Category_ToyBox"),									-- Toy Box
		[-10031] = app.asset("Category_Mounts"),									-- Mounts
		[-10032] = app.asset("Category_ItemSets"),									-- Appearances
		[-10041] = app.asset("Expansion_MOP"),										-- Mists of Pandaria
		[-10042] = "Interface\\Icons\\Paladin_Protection",							-- Proving Grounds
		[-10043] = app.asset("Category_D&R"),										-- Dungeons
		[-10044] = app.asset("Category_D&R"),										-- Raids
		[-10045] = "Interface\\Icons\\Paladin_Protection",							-- Currencies
		[-10047] = app.asset("Category_Event"),										-- Events
		[-10048] = "Interface\\Icons\\buff_feltreasures",							-- Mage Tower
		[-10049] = "Interface\\Icons\\buff_forcesoforder",							-- Command Center
		[-10050] = "Interface\\Icons\\buff_epichunter",								-- Nether Disruptor
		[-10051] = "Interface\\Icons\\Paladin_Protection",							--
		[-10052] = app.asset("Expansion_BFA"),										-- Battle for Azeroth
		[-10053] = app.asset("Expansion_BFA"),										-- BFA Dungeon
		[-10054] = app.asset("Expansion_BFA"),										-- BFA Raid
		[-10055] = app.asset("Category_ExpansionFeatures"),							-- Expansion Features
		[-10056] = "Interface\\Icons\\Paladin_Protection",							--
		[-10057] = "Interface\\Icons\\Ability_Warrior_OffensiveStance",				-- War Effort
		[-10058] = "Interface\\Icons\\Paladin_Protection",							--
		[-10059] = "Interface\\Icons\\pandarenracial_innerpeace",					-- Pandaria Scenarios
		[-10061] = "Interface\\Icons\\achievement_faction_celestials",				-- The Four Celestials
		[-10067] = "Interface\\Icons\\inv_artifact_tome01",							-- AK Research Book
		[-10067] = app.asset("Weapon_Type_Artifact"),								-- Artifacts
		[-10070] = "Interface\\Icons\\Paladin_Protection",							--
		[-10071] = "Interface\\Icons\\Paladin_Protection",							--
		[-10072] = "Interface\\Icons\\ability_deathwing_assualtaspects",			-- N'Zoth Assault
		[-10073] = "Interface\\Icons\\spell_arcane_teleportorgrimmar",				-- Horrific Vision of Orgrimmar
		[-10074] = "Interface\\Icons\\spell_arcane_teleportstormwind",				-- Horrific Vision of Stomrwind
		[-10075] = "Interface\\Icons\\inv_legion_cache_valajar",					-- Assault: Amathet Advance
		[-10076] = "Interface\\Icons\\inv_legion_cache_nightmare",					-- Assault: The Black Empire
		[-10077] = "Interface\\Icons\\inv_misc_treasurechest03b",					-- Assault: The Warring Clans
		[-10078] = "Interface\\Icons\\inv_misc_archaeology_mantidbasket_01",		-- Assault: The Endless Swarm
		[-10079] = "Interface\\Icons\\inv_misc_ahnqirajtrinket_03",					-- Assault: Aqir Unearthed
		[-10080] = "Interface\\Icons\\trade_alchemy_potiond2",						-- Horrific Visions
		[-10081] = "Interface\\Icons\\spell_shadow_shadowmend",						-- Corrupted Area (Vision Scenario)
		[-10082] = "Interface\\Icons\\spell_priest_psyfiend",						-- Lost Area (Vision Scenario)
		[-10083] = "236373",														-- Covenant Assaults
		[-10100] = app.asset("Expansion_SL"),										-- Shadowlands
		[-10101] = app.asset("Expansion_SL"),										-- Shadowlands Dungeon
		[-10102] = app.asset("Expansion_SL"),										-- Shadowlands Raid
		[-10103] = "Interface\\Icons\\Paladin_Protection",							-- The Maw and Torghast
		[-10105] = 236373,															-- Covenant Assaults

	-- Achieve 14339 Sub-Criteira
		[-1433901] = 3528288,															-- Anima Crystal Shard
	--	hopefully temp custom NPCs, these objects do not have data on wowhead atm
		[-1433951] = "3854020",															-- Broken Mirror
		[-1433952] = "3854020",															-- Broken Mirror
		[-1433953] = "3854020",															-- Broken Mirror
		[-1433954] = "3854020",															-- Broken Mirror
		[-1433955] = "3854020",															-- Broken Mirror
		[-1433956] = "3854020",															-- Broken Mirror
		[-1433957] = "3854020",															-- Broken Mirror
		[-1433958] = "3854020",															-- Broken Mirror
		[-1433959] = "3854020",															-- Broken Mirror
		[-1433960] = "3854020",															-- Broken Mirror
		[-1433961] = "3854020",															-- Broken Mirror
		[-1433962] = "3854020",															-- Broken Mirror
	};
	["HEADER_NAMES"] = {
	-- Commonly used
		[0] = ZONE.." "..BATTLE_PET_SOURCE_1,									-- Zone Drop
		[-1] = BATTLE_PET_BREED_QUALITY2.." "..TRANSMOG_SOURCE_1,				-- Common Boss Drop
		[-2] = TUTORIAL_TITLE20,												-- Vendors
		[-3] = GetItemSubClassInfo(15,3),										-- Holiday
		[-4] = ACHIEVEMENTS,													-- Achievements
		[-7] = WORLD.." "..RAID_BOSSES,											-- World Bosses
		[-9] = BUG_CATEGORY14,													-- Player vs. Player
		[-10] = SPLASH_BATTLEFORAZEROTH_8_2_5_FEATURE1_TITLE,					-- Party Sync
		[-11] = "Common Box Drops",												-- Common Box Drops
		[-12] = DUNGEON_FLOOR_DIREMAUL5.." [East - Demons]",					-- Warpwood Quarter [East - Demon]
		[-13] = DUNGEON_FLOOR_DIREMAUL1.." [North - Ogres]",					-- Gordok Commons [North - Ogres]
		[-14] = DUNGEON_FLOOR_DIREMAUL2.." [West - Elves]",						-- Capital Gardens [West - Elves]
		[-15] = "Exploration",													-- Exploration
		[-16] = BATTLE_PET_BREED_QUALITY4,										-- Rares
		[-17] = TRACKER_HEADER_QUESTS,											-- Quests
		[-18] = QUEST_REWARDS, 													-- Rewards
		[-19] = "Dragons of Nightmare",											-- Dragons of Nightmare
		[-20] = "Common Vendor Items",											-- Common Vendor Items
		[-21] = "Captains",
		[-22] = "Secrets",														-- Secrets
		[-23] = "Common Dungeon Drop",											-- WoD Common Dungeon Drop
		[-26] = BATTLE_PET_SOURCE_1,											-- Drop
		[-31] = select(1,GetCategoryInfo(15268)),								-- Promotions
		[-34] = TRACKER_HEADER_WORLD_QUESTS,									-- World Quests
		[-36] = BATTLE_PET_SOURCE_10,											-- In-Game Shop
		[-37] = BATTLE_PET_SOURCE_11,											-- Discovery
		[-38] = TRADE_SKILLS,													-- Professions
		[-40] = LFG_LIST_LEGACY,												-- Legacy
		[-41] = "Cache of Madness",												-- Cache of Madness
	-- Armor Types
		[-43] = GetItemSubClassInfo(4,1).." "..RESISTANCE0_NAME,				-- Cloth
		[-44] = GetItemSubClassInfo(4,2).." "..RESISTANCE0_NAME,				-- Leather
		[-45] = GetItemSubClassInfo(4,3).." "..RESISTANCE0_NAME,				-- Mail
		[-46] = GetItemSubClassInfo(4,4).." "..RESISTANCE0_NAME,				-- Plate
	-- World Events (These are used by ATT CLassic)
		[-47] = select(1,GetCategoryInfo(160)),									-- Lunar Festival
		[-52] = select(1,GetCategoryInfo(163)),									-- Children's Week
		[-53] = "Midsummer Fire Festival",										-- Midsummer Fire Festival
		[-55] = "Pirates' Day",													-- Pirates' Day
		[-56] = select(1,GetCategoryInfo(162)),									-- Brewfest
		[-58] = select(1,GetCategoryInfo(158)),									-- Hallow's End
		[-59] = "Day of the Dead",												-- Day of the Dead
		[-60] = select(1,GetCategoryInfo(14981)),								-- Pilgrim's Bounty
		[-61] = GetSpellInfo(21953),											-- The Feast of Winter Veil
		[-62] = "Stranglethorn Fishing Extravaganza",							-- Stranglethorn Fishing Extravaganza

		[-68] = DUNGEON_FLOOR_NIGHTMARERAID13,									-- The Emerald Dream
		[-69] = GetSpellInfo(21127),											-- Maraudon Portal
		[-70] = DUNGEON_FLOOR_DESOLACE22.." - "..GetSpellInfo(251097),			-- Foulspore Cavern [Orange]
		[-71] = DUNGEON_FLOOR_DESOLACE21.." - "..GetSpellInfo(251095),			-- The Wicked Grotto [Purple]
		[-75] = DUNGEON_FLOOR_BLACKROCKDEPTHS1,									-- Detention Block
		[-76] = DUNGEON_FLOOR_BLACKROCKDEPTHS2,									-- Shadowforge City
		[-77] = SPECIAL,														-- Special
	-- Zul'Aman
		[-78] = "Timed Event",
		[-79] = "First Chest",
		[-80] = "Second Chest",
		[-81] = "Third Chest",
		[-82] = "Final Chest",
	-- SM
		[-85] = "Graveyard",
		[-86] = "Library",
		[-87] = "Armory",
		[-88] = "Cathedral",
	-- Terrace of Endless Spring loot
		[-90] = ELITE,															-- Elite

		[-93] = C_Map.GetAreaInfo(9310),										-- Silithus: The Wound
		[-94] = BLACK_MARKET_AUCTION_HOUSE,										-- Black Market Auction House
	-- Garrisons
		[-99] = "Buildings",
		[-101] = GARRISON_FOLLOWERS,											-- Followers
	-- Druid Feral Druid Hidden Artifact Appearance
		[-130] = DUNGEON_FLOOR_NIGHTMARERAID8.." "..GetSpellInfo(133137),		-- Duskwood Active
		[-131] = DUNGEON_FLOOR_NIGHTMARERAID7.." "..GetSpellInfo(133137),		-- The Hinterlands Active
		[-132] = DUNGEON_FLOOR_NIGHTMARERAID9.." "..GetSpellInfo(133137),		-- Feralas Active
		[-133] = DUNGEON_FLOOR_NIGHTMARERAID8.." "..GetSpellInfo(78741),		-- Duskwood Activated
	-- Garrisons Invasions TODO: what levels?
		[-136] = GARRISON_LANDING_INVASION,										-- Garrison Invasion
	-- Class Trial
		[-137] = string.format(SPELLBOOK_AVAILABLE_AT, 90),						-- Level 90
		[-138] = string.format(SPELLBOOK_AVAILABLE_AT, 100),					-- Level 100
	--
		[-139] = RAID_BOSSES,													-- Bosses
	-- WoD Dungeons(Fake npcid)
		[-140] = select(2, GetAchievementInfo(9039)),							-- Auchindoun
		[-141] = select(2, GetAchievementInfo(9037)),							-- Bloodmaul Slag Mines
		[-142] = select(2, GetAchievementInfo(9043)),							-- Grimrail Depot
		[-143] = select(2, GetAchievementInfo(9038)),							-- Iron Docks
		[-144] = select(2, GetAchievementInfo(9041)),							-- Shadowmoon Burial Grounds
		[-145] = select(2, GetAchievementInfo(8843)),							-- Skyreach
		[-146] = select(2, GetAchievementInfo(9044)),							-- The Everbloom
		[-147] = select(2, GetAchievementInfo(9042)),							-- Upper Blackrock Spire
	-- Garrison
		[-152] = "Garrison Campaign",											-- Garrison Campaign
		[-153] = CAPACITANCE_WORK_ORDERS,										-- Work Orders
	-- Class Trial
		[-154] = string.format(SPELLBOOK_AVAILABLE_AT, 48),						-- Level 48 (old level 110)
		[-155] = string.format(SPELLBOOK_AVAILABLE_AT, 50),						-- Level 50 (old Level 120)
	-- Druid Feral Druid Hidden Artifact Appearance
		[-157] = DUNGEON_FLOOR_NIGHTMARERAID7.." "..GetSpellInfo(78741),		-- The Hinterlands Activated
		[-158] = DUNGEON_FLOOR_NIGHTMARERAID9.." "..GetSpellInfo(78741),		-- Feralas Activated
	-- Class Hall /Artifact
		[-159] = "Event Roll",													-- Daily Dreamway Event Roll
	-- Collections
		[-160] = TUTORIAL_TITLE53,												-- Mounts
		[-161] = TOY,															-- Toy
		[-162] = PETS,															-- Pets
	-- Armor
		[-163] = RESISTANCE0_NAME,												-- Armor
	-- Junkboxes
		[-165] = GetItemSubClassInfo(13,1),										-- Junkboxes
	-- Emissary
		[-169] = BOUNTY_BOARD_LOCKED_TITLE,										-- Emissary Quests
	-- Legion Artifact Questline
		[-170] = GetSpellInfo(41341),											-- Balance of Power
	-- Events
		[-173] = PLAYER_DIFFICULTY_TIMEWALKER,									-- Timewalking
		[-176] = CALENDAR_FILTER_WEEKLY_HOLIDAYS,								-- Weekly Holidays
	-- Item Sets
		[-211] = NEW.." "..CHARACTER,											-- New Character
	-- Treasure Chest
		[-212] = GetSpellInfo(225652).." "..GetSpellInfo(168498),				-- Treasure Chest
	-- Dalaran Sub-Zone
		[-213] = DUNGEON_FLOOR_DALARAN2,										-- The Underbelly
	-- PvP
		[-216] = PVP_PRESTIGE_RANK_UP_TITLE,									-- Prestige
	-- Fishing
		[-217] = "Lures",														-- Lures (for Fishing)
		[-218] = "Coastal",														-- Coastal (for Fishing)
	-- Class
		[-220] = CLASS,															-- Class
	-- Bonus Objectives
		[-221] = TRACKER_HEADER_BONUS_OBJECTIVES,								-- Bonus Objectives
	-- Misc Victory (Used in many places)
		[-227] = GetSpellInfo(109382),											-- Victory
	-- Flight Path
		[-228] = GetSpellInfo(218950),											-- Flight Path
	-- Misc Weekly (Used in Many Places)
		[-229] = CALENDAR_REPEAT_WEEKLY,										-- Weekly
	-- Warfronts
		[-233] = GetSpellInfo(279443),											-- Warfront: The Battle for Stromgarde
	-- Recipes (Only used in BMAH atm)
		[-235] = AUCTION_CATEGORY_RECIPES,										-- Recipes
	-- War Campaign
		[-236] = C_Map.GetAreaInfo(9663),										-- War Campaign - Alliance
	-- Warfront
		[-237] = GetSpellInfo(290253),											-- Warfront: The Battle for Darkshore
	-- PvP
		[-240] = PVP_TAB_CONQUEST,												-- Rated
		[-242] = "Unrated",														-- Unrated
		[-243] = "Bounty",														-- Bounty
	-- War Campaign
		[-253] = C_Map.GetAreaInfo(9664),										-- War Campaign - Horde
	-- Allied Races
		[-254] = "Allied Races & Heritage",										-- Allied Races & Heritage
	-- Mailbox
		[-297] = MINIMAP_TRACKING_MAILBOX,										-- Mailbox
	-- Garrison Missions
		[-299] = GARRISON_MISSIONS,												-- Missions
	-- PvP
		[-302] = BATTLEFIELD_LEVEL.." 80-84",									-- Level Range 80-84
		[-303] = BATTLEFIELD_LEVEL.." 85-89",									-- Level Range 85-89
		[-304] = BATTLEGROUNDS,													-- Battlegrounds
	-- Meta Armor/Weapon
		[-318] = ARMOR,															-- Armor
		[-319] = AUCTION_CATEGORY_WEAPONS,										-- Weapons
	-- Armor Slots
		[-320] = INVTYPE_HEAD,													-- Head
		[-321] = INVTYPE_SHOULDER,												-- Shoulder
		[-322] = INVTYPE_CLOAK,													-- Back
		[-323] = INVTYPE_CHEST,													-- Chest
		[-324] = INVTYPE_BODY,													-- Shirt
		[-325] = INVTYPE_TABARD,												-- Tabard
		[-326] = INVTYPE_WRIST,													-- Wrist
		[-327] = INVTYPE_HAND,													-- Hands
		[-328] = INVTYPE_WAIST,													-- Waist
		[-329] = INVTYPE_LEGS,													-- Legs
		[-330] = INVTYPE_FEET,													-- Feet
	-- Weapon Slots
		[-331] = INVTYPE_HOLDABLE,												-- Held in Off-hand
		[-332] = GetItemSubClassInfo(4,6),										-- Shield
		[-333] = GetItemSubClassInfo(2,15),										-- Daggers
		[-334] = GetItemSubClassInfo(2,0),										-- 1H Axes
		[-335] = GetItemSubClassInfo(2,1),										-- 2H Axes
		[-336] = GetItemSubClassInfo(2,4),										-- 1H Maces
		[-337] = GetItemSubClassInfo(2,5),										-- 2H Maces
		[-338] = GetItemSubClassInfo(2,7),										-- 1H Swords
		[-339] = GetItemSubClassInfo(2,8),										-- 2H Swords
		[-340] = GetItemSubClassInfo(2,9),										-- Warglaives
		[-341] = GetItemSubClassInfo(2,19),										-- Wands
		[-342] = GetItemSubClassInfo(2,10),										-- Staffs
		[-343] = GetItemSubClassInfo(2,6),										-- Polearms
		[-345] = GetItemSubClassInfo(2,3),										-- Guns
		[-346] = GetItemSubClassInfo(2,2),										-- Bows
		[-347] = GetItemSubClassInfo(2,18),										-- Crossbows
		[-348] = GetItemSubClassInfo(2,13),										-- Fist Weapons
	-- Cosmetic
		[-349] = GetItemSubClassInfo(4,5),										-- Cosmetic
	-- Titanforged/Warforged
		[-355] = GetSpellInfo(257215),											-- Titanforged
	-- First Questline Draenor
		[-356] = "Assault on the Dark Portal",									-- Assault on the Dark Portal
	-- Outposts in Draenor
		[-357] = GetSpellInfo(171866),											-- Sparring Arena Outpost
		[-358] = GetSpellInfo(164028),											-- Lumber Mill Outpost
		[-360] = select(2,GetAchievementInfo(8987)),							-- Arcane Sanctum
		[-361] = GetSpellInfo(182108).." Tower",								-- Artillery Tower
	-- Pre Class Hall Monk
		[-362] = DUNGEON_FLOOR_KUNLAISUMMITSCENARIO0,							-- Peak of Serenity
	-- Argent Tournament
		[-363] = select(1,GetCategoryInfo(14941)),								-- The Argent Tournament
	-- Legendaries
		[-364] = LOOT_JOURNAL_LEGENDARIES,										-- Legendaries
	-- Heirlooms
		[-365] = HEIRLOOMS,														-- Heirlooms
	-- Naxxramas
		[-367] = DUNGEON_FLOOR_NAXXRAMAS1,										-- The Construct Quarter
		[-368] = DUNGEON_FLOOR_NAXXRAMAS2,										-- The Arachnid Quarter
		[-369] = DUNGEON_FLOOR_NAXXRAMAS3,										-- The Military Quarter
		[-370] = DUNGEON_FLOOR_NAXXRAMAS4,										-- The Plague Quarter
		[-371] = DUNGEON_FLOOR_NAXXRAMAS6, 										-- The Upper Necropolis
	-- Operation: Mechagon
		[-379] = "Junkyard",													-- Junkyard
		[-380] = GetSpellInfo(251998),											-- Workshop
	-- Misc Armor Slots
		[-383] = GetItemSubClassInfo(2,14),										-- Miscellaneous
		[-384] = GetItemSubClassInfo(8,1),										-- Neck
		[-385] = GetItemSubClassInfo(8,10),										-- Finger
		[-386] = INVTYPE_TRINKET,												-- Trinket
		[-387] = GetItemSubClassInfo(3,11),										-- Relic
	-- Stratholme
		[-388] = C_Map.GetAreaInfo(5916),										-- Stratholme - Main Gate
		[-389] = C_Map.GetAreaInfo(5917),										-- Stratholme - Service Entrance
	-- Draenor Outposts
		[-390] = C_Map.GetAreaInfo(7288),										-- Smuggler's Den (Spires of Arak)
		[-391] = C_Map.GetAreaInfo(7291),										-- Stoktron Brewery (Spires of Arak)
		[-392] = C_Map.GetAreaInfo(7290),										-- Hearthfire Tavern
	-- Icecrown Citadel
		[-393] = "Storming the Citadel",										-- Storming the Citadel
		[-394] = "The Plagueworks",												-- The Plagueworks
		[-395] = C_Map.GetAreaInfo(4892),										-- The Crimson Hall
		[-396] = C_Map.GetAreaInfo(7932),										-- The Frostwing Halls
	-- BFA Outposts
		[-397] = "Outposts",													-- Outposts
	-- T0.5
		[-420] = "Tier 0.5 Sets",												-- Tier 0.5 Sets
	-- BFA War Chest
		[-488] = "War Chest",													-- Daily War Chest
	-- Tarot Cards
		[-491] = "Tarot Cards",													-- Tarot Cards
	-- Misc
		[-494] = MAC_OPTIONS_MISC, 												-- Miscellaneous
	-- Class Hall Demon Hunter
		[-498] = C_Map.GetAreaInfo(7576),										-- Twisting Nether (Demon Hunter Order Hall advancement)
	-- Mole Machine
		[-517] = GetSpellInfo(265225),											-- Mole Machine
	-- Blizzard Events and Anniversaries
		[-520] = "Expansion Pre-Launch",										-- Expansion Pre-Launch
		[-522] = EXPANSION_NAME2..": Zombie Infestation",						-- Wrath of the Lich King: Zombie Infestation
		[-523] = EXPANSION_NAME3..": Elemental Unrest",							-- Cataclysm: Elemental Unrest
		[-525] = EXPANSION_NAME5..": Iron Horde Incursion",						-- Warlords of Draenor: Iron Horde Incursion
		[-526] = EXPANSION_NAME6..": Legion Invasion",							-- Legion: Legion Invasion
		[-527] = EXPANSION_NAME7..": War of the Thorns",						-- Battle for Azeroth: War of the Thorns
		[-528] = POSTMASTER_PIPE_BROKEN_ISLES,									-- Broken Isles [Mole Machine]
		[-531] = C_PetJournal.GetPetInfoBySpeciesID(179),						-- Spirit of Competition
		[-532] = "Heroes of the Storm",											-- Heroes of the Storm
		[-533] = "Hearthstone",													-- Hearthstone
		[-534] = "Collector's Edition",											-- Collector's Edition
		[-535] = BATTLE_PET_SOURCE_9,											-- Trading Card Game
		[-536] = "Hearthstone Mercenaries",										-- Hearthstone Mercenaries
		[-537] = "Diablo 20th Anniversary",										-- Diablo 20th Anniversary
		[-538] = "The Ahn'Qiraj War Effort",									-- The Ahn'Qiraj War Effort
		[-539] = "The Scepter of the Shifting Sands",							-- The Scepter of the Shifting Sands
		[-540] = "The Scourge Invasion",										-- The Scourge Invasion
		[-541] = "The Silithyst Must Flow",										-- The Silithyst Must Flow
		[-542] = "The Opening of the Dark Portal",								-- The Opening of the Dark Portal
		[-543] = "Legion Invasions",											-- Legion Invasions
		[-544] = "WoW Collector's Edition",										-- WoW Collector's Edition
		[-545] = "Blizzcon",													-- Blizzcon
		[-546] = REFER_A_FRIEND,												-- Recruit A Friend
		[-550] = "Starcraft Collector's Edition",								-- Starcraft Collector's Edition
		[-551] = "Diablo Collector's Edition",									-- Diablo Collector's Edition
		[-552] = "Warcraft 3 Spoils of War Edition",							-- Warcraft 3 Spoils of War Edition
		[-553] = "iCoke",														-- iCoke
		[-554] = "EU Fansite Promotion",										-- EU Fansite Promotion
		[-555] = "Korean Promotional Event",									-- Korean Promotional Event
		[-556] = "Arena Tournament",											-- Arena Tournament
		[-557] = "Korea World Event",											-- Korea World Event
		[-558] = "Battle.net World Championship Shanghai 2012",					-- Battle.net World Championship Shanghai 2012
		[-564] = "Starcraft II: Wings of Liberty",								-- Starcraft II: Wings of Liberty
		[-565] = "Starcraft II: Heart of the Swarm",							-- Starcraft II: Heart of the Swarm
		[-566] = "Diablo III",													-- Diablo III
		[-568] = "Overwatch: Origins",											-- Overwatch: Origins
		[-569] = "Azeroth Academy Mentor Recruitment Promotion",				-- Azeroth Academy Mentor Recruitment Promotion (China Only)
		[-573] = SCROLL_OF_RESURRECTION,										-- Scroll of Resurrection
		[-574] = "Diablo III Annual Pass",										-- Diablo III Annual Pass
		[-575] = "Diablo III: Reaper of Souls",									-- Diablo III: Reaper of Souls
		[-576] = "StarCraft II: Legacy of the Void",							-- StarCraft II: Legacy of the Void
		[-577] = "Warcraft Movie",												-- Warcraft Movie
		[-578] = select(2, GetAchievementInfo(13917)),							-- WoW's 15th Anniversary
		[-579] = "Dark Portal Pass",											-- Dark Portal Pass
	-- Raid Buff Stack Size in Uldir
		[-583] = string.format(AZERITE_ITEM_LEVELED_UP_TOAST, 1),				-- Power Increased to Level 1
		[-584] = string.format(AZERITE_ITEM_LEVELED_UP_TOAST, 2),				-- Power Increased to Level 2
		[-585] = string.format(AZERITE_ITEM_LEVELED_UP_TOAST, 3),				-- Power Increased to Level 3
		[-586] = string.format(AZERITE_ITEM_LEVELED_UP_TOAST, 4),				-- Power Increased to Level 4
		[-587] = string.format(AZERITE_ITEM_LEVELED_UP_TOAST, 5),				-- Power Increased to Level 5
		[-588] = string.format(AZERITE_ITEM_LEVELED_UP_TOAST, 6),				-- Power Increased to Level 6
		[-589] = string.format(AZERITE_ITEM_LEVELED_UP_TOAST, 7),				-- Power Increased to Level 7
		[-590] = string.format(AZERITE_ITEM_LEVELED_UP_TOAST, 8),				-- Power Increased to Level 8
		[-591] = string.format(AZERITE_ITEM_LEVELED_UP_TOAST, 9),				-- Power Increased to Level 9
		[-592] = string.format(AZERITE_ITEM_LEVELED_UP_TOAST, 10),				-- Power Increased to Level 10
		[-593] = GetSpellInfo(228357).." 1",									-- Kill Credit 1
		[-594] = GetSpellInfo(228357).." 2",									-- Kill Credit 2
		[-595] = GetSpellInfo(228357).." 3",									-- Kill Credit 3
	-- Need these spells here because if we use them in the file it won't allow the quest to mark as complete due to it not being designed that way.
	-- This is the workaround.
		[-600] = AUCTION_CATEGORY_QUEST_ITEMS,									-- Quest Items
	-- PvP Header
		-- Special Season Tags
		--[-650] = "Rated Battleground",										-- Listed under Cata PvP Seasons
		--[-651] = "Honor Gear Prideful Season",								-- Listed under MoP PvP Seasons
		--[-652] = "Honor Gear Grievous Season",								-- Listed under MoP PvP Seasons
		--[-653] = "Honor Gear Tyrannical Season",								-- Listed under MoP PvP Seasons
		--[-654] = "Honor Gear Cataclysmic Season",								-- Listed under Cata PvP Seasons
		--[-655] = "Ensemble Gear", 												-- Ensemble Gear (PvP)
		--[-656] = "Honor Gear Ruthless Season",								-- Listed under Cata PvP Seasons
		--[-657] = "Hateful Gladiator",											-- Listed under WOTLK PvP Seasons
		--[-658] = "BC Pre-Season",												-- Listed under BC PvP Seasons
		-- PvP Set Names
		[-659] = "Aspirant Gear",												-- Aspirant PvP Gear (WoD, BfA)
		[-660] = "Combatant Gear",												-- Combatant PvP Gear (WoD, Legion)
		[-661] = "Gladiator Gear",												-- Gladiator PvP Gear
		[-662] = "Elite Gear",													-- Elite PvP Gear
	-- Classic PvP Seasons
		[-663] = "Classic Honor System",										-- Classic Honor System
	-- The Burning Crusade PvP Seasons
		[-658] = "BC Pre-Season",												-- Pre-Season (PvP BC)
		[-664] = select(2, GetAchievementInfo(2091))..": Season 1",				-- Gladiator: Season 1
		[-665] = select(2, GetAchievementInfo(418))..": Season 2",				-- Merciless Gladiator: Season 2
		[-666] = select(2, GetAchievementInfo(419))..": Season 3",				-- Vengeful Gladiator: Season 3
		[-667] = select(2, GetAchievementInfo(420))..": Season 4",				-- Brutal Gladiator: Season 4
	-- Wrath of the Lich-King PvP Seasons
		[-668] = select(2, GetAchievementInfo(3336))..": Season 5",				-- Deadly Gladiator: Season 5
		[-657] = "Hateful Gladiator",											-- Hateful Gladiator: Season 5 ("medium pvp gear")
		[-669] = select(2, GetAchievementInfo(3436))..": Season 6",				-- Furious Gladiator: Season 6
		[-670] = select(2, GetAchievementInfo(3758))..": Season 7",				-- Relentless Gladiator: Season 7
		[-671] = select(2, GetAchievementInfo(4599))..": Season 8",				-- Wrathful Gladiator: Season 8
	-- Cataclysm PvP Seasons
		[-650] = PVP_RATED_BATTLEGROUND,										-- Rated Battleground
		[-672] = select(2, GetAchievementInfo(6002))..": Season 9",				-- Vicious Gladiator: Season 9
		[-656] = "Honor Gear Ruthless Season",									-- Honor Gear Ruthless (S10)
		[-673] = select(2, GetAchievementInfo(6124))..": Season 10",			-- Ruthless Gladiator: Season 10
		[-654] = "Honor Gear Cataclysmic Season",								-- Honor Gear Cataclysmic (S11)
		[-674] = select(2, GetAchievementInfo(6938))..": Season 11",			-- Cataclysmic Gladiator: Season 11
	-- Mists of Pandaria PvP Seasons
		[-675] = select(2, GetAchievementInfo(8214))..": Season 12",			-- Malevolent Gladiator: Season 12
		[-653] = "Honor Gear Tyrannical Season",								-- Honor Gear Tyrannical (S13)
		[-676] = select(2, GetAchievementInfo(8791))..": Season 13",			-- Tyrannical Gladiator: Season 13
		[-652] = "Honor Gear Grievous Season",									-- Honor Gear Grievous (S14)
		[-677] = select(2, GetAchievementInfo(8643)),							-- Grievous Gladiator: Season 14
		[-651] = "Honor Gear Prideful Season",									-- Honor Gear Prideful (S15)
		[-678] = select(2, GetAchievementInfo(8666)),							-- Prideful Gladiator: Season 15
	-- Warlords of Dreanor PvP Seasons
		[-679] = select(2, GetAchievementInfo(9232)),							-- Primal Gladiator: Warlords Season 1
		[-680] = select(2, GetAchievementInfo(10096)),							-- Wild Gladiator: Warlords Season 2
		[-681] = select(2, GetAchievementInfo(10097)),							-- Warmongering Gladiator: Warlords Season 3
	-- Legion PvP Seasons
		[-682] = select(2, GetAchievementInfo(11012)),							-- Vindictive Gladiator: Legion Season 1
		[-683] = select(2, GetAchievementInfo(11014)),							-- Fearless Gladiator: Legion Season 2
		[-684] = select(2, GetAchievementInfo(11037)),							-- Cruel Gladiator: Legion Season 3
		[-685] = select(2, GetAchievementInfo(11062)),							-- Ferocious Gladiator: Legion Season 4
		[-686] = select(2, GetAchievementInfo(12010)),							-- Fierce Gladiator: Legion Season 5
		[-687] = select(2, GetAchievementInfo(12134)),							-- Dominant Gladiator: Legion Season 6
		[-688] = select(2, GetAchievementInfo(12185)),							-- Demonic Gladiator: Legion Season 7
	-- Battle for Azeroth PvP Seasons
		[-689] = select(2, GetAchievementInfo(12945)),							-- Dread Gladiator: Battle for Azeroth Season 1
		[-690] = select(2, GetAchievementInfo(13200)),							-- Sinister Gladiator: Battle for Azeroth Season 2
		[-691] = select(2, GetAchievementInfo(13630)),							-- Notorious Gladiator: Battle for Azeroth Season 3
		[-692] = select(2, GetAchievementInfo(13957)),							-- Corrupted Gladiator: Battle for Azeroth Season 4
	-- Shadowlands PvP Seasons
		[-693] = select(2, GetAchievementInfo(14690)),							-- Sinful Gladiator: Shadowlands Season 1
		[-694] = select(2, GetAchievementInfo(14973)),							-- Unchained Gladiator: Shadowlands Season 2
	-- More PvP Seasons are likely to come dont use IDs here
	-- Pets
		[-796] = BATTLE_PET_SOURCE_5,											-- Pet Battle
		[-797] = PET_JOURNAL,													-- Pet Journal
	-- Toys
		[-798] = GetSpellInfo(181765),											-- S.E.L.F.I.E. Camera
	-- Timeless Isle
		[-799] = GetSpellInfo(147343),											-- Burden of Eternity
	-- Secret Header
		[-800] = GetSpellInfo(247402), 											-- Lucid Nightmare
		[-801] = GetSpellInfo(243025),											-- Riddler's Mind-Worm
		[-802] = GetSpellInfo(231215),											-- Sun Darter Hatchling
		[-804] = GetSpellInfo(254763),											-- Uuna
		[-805] = GetSpellInfo(277461),											-- Baa'l
		[-806] = "Waist of Time",												-- Waist of Time
		[-807] = GetSpellInfo(261395),											-- The Hivemind
		[-808] = GetSpellInfo(344577),											-- Bound Shadehound
	-- More Secrets are likely to come dont use IDs here
	-- Chests
		[-850] = "Mechanized Chest",											-- Mechanized Chest
		[-851] = "Black Empire Cache",											-- Black Empire Cache
	-- Heart of Azeroth
		[-852] = SPLASH_BATTLEFORAZEROTH_8_2_0_FEATURE2_TITLE,					-- Heart of Azeroth Essences
		[-853] = "All Roles",													-- All Roles
		[-854] = "DPS",															-- DPS
		[-855] = "Healers",														-- Healers
		[-856] = "Tanks",														-- Tanks
		[-857] = "Mythic+",														-- Mythic+
		[-858] = string.format(AZERITE_ESSENCE_RANK, 1),						-- Rank 1
		[-859] = string.format(AZERITE_ESSENCE_RANK, 2),						-- Rank 2
		[-860] = string.format(AZERITE_ESSENCE_RANK, 3),						-- Rank 3
		[-861] = string.format(AZERITE_ESSENCE_RANK, 4),						-- Rank 4
		[-862] = GetSpellInfo(275825),											-- Heart of Azeroth
	-- Shadowlands Header
		[-900] = select(1,GetCategoryInfo(15441)),								-- Covenant Sanctums
		[-901] = GetSpellInfo(339041),											-- Covenant Callings
		[-902] = COVENANT_SANCTUM_TAB_RENOWN,									-- Renown
		[-903] = "Zone Rewards",												-- Zone Rewards
		[-904] = GetSpellInfo(347208),											-- Wrath of the Jailer
		[-905] = GetSpellInfo(280630),											-- Command Table
		[-906] = "Tier 1: Tactical Insight",									-- Tier 1: Tactical Insight
		[-907] = "Dead Blanchy",												-- Dead Blanchy
		[-909] = "Hunt: Death Elementals",										-- Hunt: Death Elementals
		[-910] = "Hunt: Alpha Devourers",										-- Hunt: Alpha Devourers
		[-911] = "Hunt: Shadehounds",											-- Hunt: Shadehounds
		[-912] = "Hunt: Winged Soul Eaters",									-- Hunt: Winged Soul Eaters
		[-913] = "Tormentors of Torghast",										-- Tormentors of Torghast
		[-914] = COVENANT_MISSIONS_TITLE,										-- Adventures
		[-915] = ANIMA_DIVERSION_ORIGIN_TOOLTIP,								-- Anima Conductor
		[-916] = string.format(COVENANT_SANCTUM_TIER, 1)..": Flowing Tendrils",	-- Tier 1: Flowing Tendrils
		[-917] = string.format(COVENANT_SANCTUM_TIER, 2)..": Streaming Threads",-- Tier 2: Streaming Threads
		[-918] = string.format(COVENANT_SANCTUM_TIER, 3)..": Flowing Power",	-- Tier 3: Flowing Power
		[-977] = "Maelie the Wanderer",											-- Maelie the Wanderer
		[-978] = select(1, GetSpellInfo(354778)),								-- The Rift
		[-979] = "Broker Ve'ken & Broker Ve'nott",								-- Broker Ve'ken & Broker Ve'nott
		[-981] = GetSpellInfo(348869),											-- Conduits
		-- SL Maldraxxus/Necrolord
		[-920] = GetSpellInfo(321078),											-- Necrolord
		[-921] = "Sanctum Upgrades",											-- Sanctum Upgrades (Necrolord)
		[-922] = C_Map.GetAreaInfo(11465),										-- Theater of Pain
		[-923] = COVENANT_SANCTUM_FEATURE_NECROLORDS,							-- Abomination Factory
		[-924] = "Transport Network",											-- Transport Network (Necrolord)
		[-925] = string.format(COVENANT_SANCTUM_TIER, 1)..": Build A Buddy",	-- Abomination Factory (Necrolord) Tier 1
		[-926] = string.format(COVENANT_SANCTUM_TIER, 2)..": Crafting Limbs",	-- Abomination Factory (Necrolord) Tier 2
		[-927] = string.format(COVENANT_SANCTUM_TIER, 3)..": Bring Them to Life",	-- Abomination Factory (Necrolord) Tier 3
		[-928] = string.format(COVENANT_SANCTUM_TIER, 4)..": Forged Friends",	-- Abomination Factory (Necrolord) Tier 4
		[-938] = string.format(COVENANT_SANCTUM_TIER, 5)..": Best Fiends Forever",	-- Abomination Factory (Necrolord) Tier 5
		-- SL Ardenweald/Night Fae
		[-929] = GetSpellInfo(321077),											-- Night Fae
		[-930] = COVENANT_SANCTUM_FEATURE_NIGHT_FAE,							-- Queen's Conservatory
		[-934] = C_Map.GetAreaInfo(12840),										-- Star Lake Amphitheater
		[-935] = "Sanctum Upgrades",											-- Sanctum Upgrades (Night Fae)
		[-936] = "Soulshape Forms",												-- Soulshape Forms (Night Fae)
		[-937] = "Transport Network",											-- Transport Network (Night Fae)
		--[-938] is stolen for Necrolord because I ran out of numbers
		[-1002] = "Dutiful Spirit",												-- Dutiful Spirit
		[-1003] = "Martial Spirit",												-- Martial Spirit
		[-1004] = "Prideful Spirit",											-- Prideful Spirit
		[-1005] = "Untamed Spirit",												-- Untamed Spirit
		-- SL Bastion/Kyrian
		[-939] = GetSpellInfo(321076),											-- Kyrian
		[-940] = "Ascended Council",											-- Ascended Counil
		[-941] = "Sanctum Upgrades",											-- Sanctum Upgrades (Kyrian)
		[-942] = COVENANT_SANCTUM_FEATURE_KYRIAN,								-- Path of Ascension
		[-943] = string.format(COVENANT_SANCTUM_TIER, 1)..": First Steps",		-- Tier 1: First Steps
		[-944] = string.format(COVENANT_SANCTUM_TIER, 2)..": Sacred Trials",	-- Tier 2: Sacred Trials
		[-945] = string.format(COVENANT_SANCTUM_TIER, 3)..": Continued Training",	-- Tier 3: Continued Teaching
		[-946] = string.format(COVENANT_SANCTUM_TIER, 4)..": Teachings of Wisdom",	-- Tier 4: Teachings of Wisdom
		[-947] = string.format(COVENANT_SANCTUM_TIER, 5)..": Trials of Humility",	-- Tier 5: Trials of Humility
		[-948] = "Transport Network",											-- Transport Network (Kyrian)
		[-3348] = string.format(COVENANT_SANCTUM_TIER, 1)..": Step of Faith",	-- Tier 1: Step of Faith
		[-3349] = string.format(COVENANT_SANCTUM_TIER, 2)..": Leap of Power",	-- Tier 2: Leap of Power
		[-3350] = string.format(COVENANT_SANCTUM_TIER, 3)..": Eternal Paths",	-- Tier 3: Eternal Paths
		[-966] = "Blueprints & Crafting",										-- Blueprints (for Path of Ascension)
		[-972] = C_PetJournal.GetPetInfoBySpeciesID(3065),						-- Courage
		[-973] = "Loyalty",														-- Loyalty
		[-974] = GetSpellInfo(3166),											-- Wisdom
		[-975] = "Humility",													-- Humility
		-- SL Revendreth/Venthyr
		[-949] = GetSpellInfo(321079),											-- Venthyr
		[-950] = "Transport Network",											-- Transport Network
		[-951] = string.format(COVENANT_SANCTUM_TIER, 1)..": Mirror, Mirror",	-- Tier 1: Mirror, Mirror
		[-952] = string.format(COVENANT_SANCTUM_TIER, 2)..": Looking Glass",	-- Tier 2: Looking Glass
		[-953] = string.format(COVENANT_SANCTUM_TIER, 3)..": Mirror's Edge",	-- Tier 3: Mirror's Edge
		[-954] = "Inquisitors",													-- Inquisitors
		[-955] = "High Inquisitors",											-- High Inquisitors
		[-956] = "Grand Inquisitors",											-- Grand Inquisitors
		[-957] = "Sanctum Upgrades",											-- Sanctum Upgrades (Venthyr)
		[-958] = string.format(COVENANT_SANCTUM_TIER, 2)..": Deserved Feast",	-- Tier 2: Deserved Feast
		[-959] = string.format(COVENANT_SANCTUM_TIER, 3)..": Superior Efficiency",	-- Tier 3: Superior Efficiency
		[-960] = COVENANT_SANCTUM_FEATURE_VENTHYR,								-- The Ember Court
		[-961] = string.format(COVENANT_SANCTUM_TIER, 1)..": A New Court",		-- Tier 1: A New Court
		[-962] = string.format(COVENANT_SANCTUM_TIER, 2)..": Homegrown Help",	-- Tier 2: Homegrown Help
		[-963] = string.format(COVENANT_SANCTUM_TIER, 3)..": Court Influencer",	-- Tier 3: Court Influencer
		[-964] = string.format(COVENANT_SANCTUM_TIER, 4)..": Discerning Taste",	-- Tier 4: Discerning Taste
		[-965] = string.format(COVENANT_SANCTUM_TIER, 5)..": The Professionals",	-- Tier 5: The Professionals
		[-967] = "Mirror Restoration",											-- "Mirror Restoration",
		[-968] = "Set A",														-- Set A
		[-969] = "Set B",														-- Set B
		[-970] = "Set C",														-- Set C
		[-971] = "Set D",														-- Set D
		-- SL Torghast
		[-982] = select(2, GetAchievementInfo(14463)),							-- Skoldus Hall
		[-983] = select(2, GetAchievementInfo(14473)),							-- Fracture Chambers
		[-984] = select(2, GetAchievementInfo(14478)),							-- The Soulforges
		[-985] = select(2, GetAchievementInfo(14483)),							-- Coldheart Interstitia
		[-986] = select(2, GetAchievementInfo(14488)),							-- Mort'regar
		[-987] = select(2, GetAchievementInfo(14493)),							-- The Upper Reaches
	-- Sets
		[-1000] = WARDROBE_SETS, 												-- Sets
	-- Black Vault
		[-1001] = "The Black Vault",
	-- Warrior order hall lore items
		[-2200] = "Great Odyn and the Firelord",
		[-2201] = "The Wanderer and the Serpent",
		[-2202] = "Halls of Gold and Glory",
		[-2203] = "The Keeper's Eye",
		[-2204] = "First of the Val'kyr",
		[-2205] = "The Sealing of the Halls of Valor",
		[-2206] = "His Name Is Dragonblood",
		[-2207] = "The Last Words of Asgrim the Dreadkiller",
		[-2208] = "A Shieldmaiden's Creed",
		[-2209] = "The Prophecy of Rythas the Oracle",
		[-2210] = "The Lessons of the Blacklist",
		[-2211] = "Volund's Folly",
	-- T3
		[-3179] = string.format(GARRISON_CURRENT_LEVEL.." "..WARDROBE_SETS, 3),	-- Tier 3 Sets
	-- Island Expedition Sets
		[-3315] = "Spider Acolyte",
		[-3316] = "Hydraxian",
		[-3317] = "Frostwind",
		[-3318] = "Faceless Follower",
		[-3319] = "Swarmfury",
		[-3340] = "Dark Animator",
		[-3341] = "Duskhaven",
		[-3343] = "Choking Winter",
		[-3342] = "Fallen Runelord",
		[-3320] = "Spiritbough",
		[-3321] = "Tranquil Path",
		[-3322] = "Miststalker",
		[-3323] = "Whirling Dervish",
		[-3324] = "Feralbark",
		[-3325] = "Firekin",
		[-3344] = "Frostsworn",
		[-3326] = "Wild Marauder",
		[-3327] = "Dragonrider",
		[-3328] = "Saurok",
		[-3329] = "Mrrglurggl",
		[-3330] = "Headshrinker",
		[-3331] = "Voodoo Stalker",
		[-3332] = "Geocrag",
		[-3333] = "Razorfin",
		[-3345] = "Sanctified Scourgelord",
		[-3334] = "Tomb-Keeper",
		[-3335] = "Bloodwake",
		[-3336] = "Rattling Bone",
		[-3337] = "Twilight Dragon",
		[-3338] = ISLANDS_HEADER,												-- Island Expeditions
		[-3339] = LOOT_JOURNAL_ITEM_SETS,										-- Item Sets
		[-3347] = "Black Tooth Grunt",
		--[-3348] = string.format(COVENANT_SANCTUM_TIER, 1)..": Step of Faith",	-- Listed under 950//SL Bastion/Kyrian
		--[-3349] = string.format(COVENANT_SANCTUM_TIER, 2)..": Leap of Power",	-- Listed under 950//SL Bastion/Kyrian
		--[-3350] = string.format(COVENANT_SANCTUM_TIER, 3)..": Eternal Paths",	-- Listed under 950//SL Bastion/Kyrian
	-- PvP Sets
	-- Note: Some of these may go away once I check as I think I am localizing with gear sets, but leave for now
		[-4189] = CALENDAR_TYPE_PVP.." "..LOOT_JOURNAL_ITEM_SETS, 				-- Instance Item Sets, PvP
		[-4191] = ITEM_TOURNAMENT_GEAR,											-- Tournament Gear
	-- Tier/Dungeon/Event/Holiday Sets
		-- Artifact Strings
		[-5200] = "Base Appearance",
		[-5201] = "Class Hall Campaign",
		[-5202] = "Balance of Power",
		[-5203] = "Prestige Rewards",
		[-5204] = "Challenge Appearance",
		[-5205] = "Hidden Appearance",
		-- Class Sets
		[-5350] = "Class Trial Item Sets",										-- Class Trial
		--Note!! We are localizing them here so when we filter the achievement we don't filter the entire section which is bad!
		[-5353] = select(2,GetAchievementInfo(2398)),	-- 4th Anniversary
		[-5354] = select(2,GetAchievementInfo(4400)),	-- 5th Anniversary
		[-5355] = select(2,GetAchievementInfo(5512)),	-- 6th Anniversary
		[-5356] = select(2,GetAchievementInfo(5863)),	-- 7th Anniversary
		[-5357] = select(2,GetAchievementInfo(6131)),	-- 8th Anniversary
		[-5358] = select(2,GetAchievementInfo(7853)),	-- 9th Anniversary
		[-5359] = select(2,GetAchievementInfo(8820)),	-- 10th Anniversary
		[-5360] = select(2,GetAchievementInfo(10058)),	-- 11th Anniversary
		[-5361] = select(2,GetAchievementInfo(10741)),	-- 12th Anniversary
		[-5362] = select(2,GetAchievementInfo(11848)),	-- 13th Anniversary
		[-5363] = select(2,GetAchievementInfo(12827)),	-- 14th Anniversary
		[-5364] = select(2,GetAchievementInfo(13917)),	-- 15th Anniversary
		[-5365] = select(2,GetAchievementInfo(14271)),	-- 16th Anniversary

		[-6013] = FACTION,														-- Faction
		[-6014] = BUG_CATEGORY4,												-- Cities

		[-7776] = "Winter Revelers",											-- Winter Revelers (for Winter Veil)
	-- Factions
		[-9912] = COMBATLOG_FILTER_STRING_NEUTRAL_UNITS,						-- Neutral
		[-9913] = FACTION_HORDE, 												-- Horde
		[-9914] = FACTION_ALLIANCE, 											-- Alliance
	-- Specs
		[-9915] = GetSpellInfo(137032),											-- Discipline Priest Spec
		[-9917] = GetSpellInfo(137033),											-- Shadow Priest Spec
		[-9924] = GetSpellInfo(137010),											-- Guardian Druid Spec
		[-9925] = GetSpellInfo(137011),											-- Feral Druid Spec
		[-9926] = GetSpellInfo(137013),											-- Balance Druid Spec
		[-9927] = GetSpellInfo(137012),											-- Restoration Druid Spec
		[-9931] = GetSpellInfo(137023),											-- Brewmaster Monk Spec
		[-9932] = GetSpellInfo(137025),											-- Windwalker Monk Spec
		[-9933] = GetSpellInfo(137024),											-- Mistweaver Monk Spec
		[-9939] = GetSpellInfo(137040),											-- Elemental Shaman Spec
		[-9940] = GetSpellInfo(137041),											-- Enhancement Shaman Spec
		[-9941] = GetSpellInfo(137039),											-- Restoration Shaman Spec
		[-9942] = GetSpellInfo(137029),											-- Holy Paladin Spec
		[-9943] = GetSpellInfo(137028),											-- Protection Paladin Spec
		[-9944] = GetSpellInfo(137027),											-- Retribution Paladin Spec
		[-9945] = GetSpellInfo(137049),											-- Arms Warrior Spec
		[-9947] = GetSpellInfo(137048),											-- Protection Warrior Spec
		[-9948] = GetSpellInfo(137008),											-- Blood Death Knight Spec
		[-9949] = GetSpellInfo(137006),											-- Frost Death Knight Spec
		[-9951] = GetSpellInfo(148462).." & "..GetSpellInfo(137031), 			-- Discipline / Holy Priest Spec
		[-9952] = GetSpellInfo(234890).." & "..GetSpellInfo(137011), 			-- Guardian / Feral Druid Spec
	------ ACHIEVEMENT HEADER SECTION ------
		[-9955] = STAT_CATEGORY_GENERAL,										-- General

		[-9957] = select(1,GetCategoryInfo(97)),								-- Exploration

		[-9959] = GROUP_FINDER,													-- Dungeons & Raids
		[-9960] = TRADE_SKILLS,													-- Professions
		[-9961] = TUTORIAL_TITLE16,												-- Reputation
		[-9962] = BATTLE_PET_SOURCE_7,											-- World Events
		[-9963] = SHOW_PET_BATTLES_ON_MAP_TEXT,									-- Pet Battles
		[-9964] = COLLECTIONS,													-- Collections
		[-9965] = select(1,GetCategoryInfo(15304)),								-- Class Hall
		[-9966] = select(1,GetCategoryInfo(15303)),								-- Draenor Garrison
		[-9968] = LFG_LIST_LEGACY,												-- Legacy
		[-9969] = select(1,GetCategoryInfo(81)),								-- Feats of Strength
		[-9971] = select(1,GetCategoryInfo(170)),								-- Cooking
		[-9972] = select(1,GetCategoryInfo(171)),								-- Fishing
		[-9974] = select(1,GetCategoryInfo(15071)),								-- Archaeology
		[-9975] = select(1,GetCategoryInfo(14777)),								-- Eastern Kingdoms
		[-9976] = select(1,GetCategoryInfo(14778)),								-- Kalimdor
		[-9977] = select(1,GetCategoryInfo(14779)),								-- Outland
		[-9978] = select(1,GetCategoryInfo(14780)),								-- Northrend
		[-9979] = select(1,GetCategoryInfo(15069)),								-- Cataclysm
		[-9980] = select(1,GetCategoryInfo(15110)),								-- Pandaria
		[-9981] = select(1,GetCategoryInfo(15235)),								-- Draenor
		[-9982] = select(1,GetCategoryInfo(15252)),								-- Legion
		[-9983] = select(1,GetCategoryInfo(15266)),								-- Honor
		[-9984] = select(1,GetCategoryInfo(14804)),								-- Warsong Gulch
		[-9985] = select(1,GetCategoryInfo(14802)),								-- Arathi Basin
		[-9986] = select(1,GetCategoryInfo(14803)),								-- Eye of the Storm
		[-9987] = select(1,GetCategoryInfo(14801)),								-- Alterac Valley
		[-9988] = select(1,GetCategoryInfo(15003)),								-- Isle of Conquest
		[-9990] = select(1,GetCategoryInfo(15073)),								-- Battle for Gilneas
		[-9991] = select(1,GetCategoryInfo(15074)),								-- Twin Peaks
		[-9992] = select(1,GetCategoryInfo(15162)),								-- Silvershard Mines
		[-9993] = select(1,GetCategoryInfo(15163)),								-- Temple of Kotmogu
		[-9994] = select(1,GetCategoryInfo(15218)),								-- Deepwind Gorge
		[-9995] = select(1,GetCategoryInfo(14901)),								-- Wintergrasp
		[-9996] = select(1,GetCategoryInfo(15075)),								-- Tol Barad
		[-9997] = select(1,GetCategoryInfo(15414)),								-- Ashran
		[-9999] = select(1,GetCategoryInfo(15092)),								-- Rated Battleground
		[-10000] = select(1,GetCategoryInfo(165)),								-- Arena
		[-10001] = select(1,GetCategoryInfo(15292)),							-- Seething Shore
		[-10002] = select(1,GetCategoryInfo(14808)),							-- Classic
		[-10003] = select(1,GetCategoryInfo(14805)),							-- The Burning Crusade
		[-10004] = select(1,GetCategoryInfo(14806)),							-- Lich King Dungeon
		[-10005] = select(1,GetCategoryInfo(14922)),							-- Lich King Raid
		[-10006] = select(1,GetCategoryInfo(15067)),							-- Cataclysm Dungeon
		[-10007] = select(1,GetCategoryInfo(15068)),							-- Cataclysm Raid
		[-10008] = select(1,GetCategoryInfo(15106)),							-- Pandaria Dungeon
		[-10009] = select(1,GetCategoryInfo(15107)),							-- Pandaria Raid
		[-10010] = select(1,GetCategoryInfo(15228)),							-- Draenor Dungeon
		[-10011] = select(1,GetCategoryInfo(15231)),							-- Draenor Raid
		[-10012] = select(1,GetCategoryInfo(15254)),							-- Legion Dungeon
		[-10013] = select(1,GetCategoryInfo(15255)),							-- Legion Raid
		[-10014] = select(1,GetCategoryInfo(14823)),							-- Wrath of the Lich King







		[-10025] = select(1,GetCategoryInfo(15101)),							-- Darkmoon Faire
		[-10026] = select(1,GetCategoryInfo(15282)),							-- Brawler's Guild
		[-10027] = select(1,GetCategoryInfo(15118)),							-- Collect
		[-10028] = select(1,GetCategoryInfo(15119)),							-- Battle
		[-10029] = select(1,GetCategoryInfo(15120)),							-- Level
		[-10030] = select(1,GetCategoryInfo(15247)),							-- Toy Box
		[-10031] = select(1,GetCategoryInfo(15248)),							-- Mounts
		[-10032] = select(1,GetCategoryInfo(15259)),							-- Appearances
		[-10041] = select(1,GetCategoryInfo(15164)),							-- Mists of Pandaria
		[-10042] = select(1,GetCategoryInfo(15222)),							-- Proving Grounds
		[-10043] = select(1,GetCategoryInfo(15272)),							-- Dungeons
		[-10044] = select(1,GetCategoryInfo(15271)),							-- Raids
		[-10045] = select(1,GetCategoryInfo(15280)),							-- Currencies
		[-10047] = select(1,GetCategoryInfo(15274)),							-- Events
		[-10048] = BROKENSHORE_BUILDING_MAGETOWER,								-- Mage Tower
		[-10049] = BROKENSHORE_BUILDING_COMMANDCENTER,							-- Command Center
		[-10050] = BROKENSHORE_BUILDING_NETHERDISRUPTOR,						-- Nether Disruptor
		[-10051] = select(1,GetCategoryInfo(92)),								-- Character
		[-10052] = select(1,GetCategoryInfo(15284)),							-- Battle for Azeroth
		[-10053] = select(1,GetCategoryInfo(15285)),							-- Battle Dungeon
		[-10054] = select(1,GetCategoryInfo(15286)),							-- Battle Raid
		[-10055] = select(1,GetCategoryInfo(15301)),							-- Expansion Features
		[-10056] = select(1,GetCategoryInfo(15307)),							-- Island Expeditions
		[-10057] = select(1,GetCategoryInfo(15308)),							-- War Effort
		[-10058] = select(1,GetCategoryInfo(15283)),							-- World
		[-10059] = select(1,GetCategoryInfo(15302)),							-- Pandaria Scenarios
		[-10061] = select(2,GetAchievementInfo(7333)),							-- The Four Celestials
		-- If we ever need them they need a new number
		--[-10061] = BATTLE_PET_BREED_QUALITY1,									-- "Poor";
	-- 8.3
		[-10066] = BATTLE_PET_BREED_QUALITY6,									-- "Legendary";
		[-10067] = ITEM_QUALITY6_DESC, 											-- Artifact
		[-10069] = SCENARIOS,													-- Scenarios
		[-10070] = select(1, GetCategoryInfo(15417)),							-- Heart of Azeroth
		[-10071] = "Visions of N'Zoth",
		[-10072] = "N'Zoth Assault",
		[-10073] = select(2, GetAchievementInfo(14063)),						-- Horrific Vision of Orgrimmar
		[-10074] = select(2, GetAchievementInfo(14062)),						-- Horrific Vision of Stormwind
		[-10075] = "Assault: Amathet Advance",
		[-10076] = "Assault: The Black Empire",
		[-10077] = "Assault: The Warring Clans",
		[-10078] = "Assault: The Endless Swarm",
		[-10079] = "Assault: Aqir Unearthed",
		[-10080] = SPLASH_BATTLEFORAZEROTH_8_3_0_FEATURE1_TITLE,				-- Horrific Visions
		[-10081] = "Corrupted Area",
		[-10082] = "Lost Area",
		[-10083] = "Covenant Assaults",											-- Covenant Assaults
	-- Shadowlands Achievement Header
		[-10100] = select(1,GetCategoryInfo(15422)),							-- Shadowlands
		[-10101] = select(1,GetCategoryInfo(15428)),							-- Shadowlands Dungeon
		[-10102] = select(1,GetCategoryInfo(15438)),							-- Shadowlands Raids
		[-10103] = select(1,GetCategoryInfo(15440)),							-- The Maw and Torghast
		-- Achieve 14339 Sub-Criteira
		[-1433901] = "Anima Crystal Shard",										-- Anima Crystal Shard
	--	hopefully temp objects, these currently do not have accessible object data on wowhead
		[-1433951] = "Broken Mirror A-1",										-- Broken Mirror
		[-1433952] = "Broken Mirror A-2",										-- Broken Mirror
		[-1433953] = "Broken Mirror A-3",										-- Broken Mirror
		[-1433954] = "Broken Mirror B-1",										-- Broken Mirror
		[-1433955] = "Broken Mirror B-2",										-- Broken Mirror
		[-1433956] = "Broken Mirror B-3",										-- Broken Mirror
		[-1433957] = "Broken Mirror C-1",										-- Broken Mirror
		[-1433958] = "Broken Mirror C-2",										-- Broken Mirror
		[-1433959] = "Broken Mirror C-3",										-- Broken Mirror
		[-1433960] = "Broken Mirror D-1",										-- Broken Mirror
		[-1433961] = "Broken Mirror D-2",										-- Broken Mirror
		[-1433962] = "Broken Mirror D-3",										-- Broken Mirror
	};
	["HEADER_DESCRIPTIONS"] = {
		[-22] = "Naughty secrets...",
		[-34] = "World Quests are time-limited Quests available in specific locations with variable rewards.\n\nMake sure to check the ATT World Quests window (/attwq) often to see what time-limited Things you should go collect!",
		[-169] = "These items can be obtained by doing Emissary Quests or gaining a paragon box.",
		[-799] = "The following items can be created by using a Burden of Eternity on a Timeless Armor Token for a double dose of pointless RNG.",
		[-903] = "These items can drop from repeatable treasure chests, wish crickets, world quests or table missions.",
	};

	-- Saved Instance Name => Dungeon Journal Instance Name Converter
	-- If your saves aren't lining up, it's probably because Blizzard
	-- didn't use the same localization for the instance. Sorry.
	["SAVED_TO_DJ_INSTANCES"] = {
		["The Escape from Durnholde"] = "Old Hillsbrad Foothills";
		["Opening of the Dark Portal"] = "The Black Morass";
		["Auchindoun: Auchenai Crypts"] = "Auchenai Crypts";
		["Auchindoun: Mana-Tombs"] = "Mana-Tombs";
		["Auchindoun: Sethekk Halls"] = "Sethekk Halls";
		["Auchindoun: Shadow Labyrinth"] = "Shadow Labyrinth";
		["Coilfang: Serpentshrine Cavern"] = "Serpentshrine Cavern";
		["Coilfang: The Slave Pens"] = "The Slave Pens";
		["Coilfang: The Steamvault"] = "The Steamvault";
		["Coilfang: The Underbog"] = "The Underbog";
		["Hellfire Citadel: Ramparts"] = "Hellfire Ramparts";
		["Hellfire Citadel: The Blood Furnace"] = "The Blood Furnace";
		["Hellfire Citadel: The Shattered Halls"] = "The Shattered Halls";
		["Tempest Keep: The Arcatraz"] = "The Arcatraz";
		["Tempest Keep: The Botanica"] = "The Botanica";
		["Tempest Keep: The Mechanar"] = "The Mechanar";
		["Stormwind Stockade"] = "The Stockade";
		["Ahn'Qiraj Temple"] = "Temple of Ahn'Qiraj";
		["Sunken Temple"] = "The Temple of Atal'hakkar";
		["The Sunwell"] = "Sunwell Plateau";
		["Tempest Keep"] = "The Eye";
		["The Violet Hold"] = "Violet Hold";
		["Magister's Terrace"] = "Magisters' Terrace";
		["Violet Hold"] = "The Violet Hold";
	};

	-- This is necessary to have because Blizzard does not always have the correct map ID at the time of zone change.
	["ZONE_TEXT_TO_MAP_ID"] = {
		["Onyxia's Lair"] = 248,
		["The Trial of Style"] = -777,
		["Razorfen Downs"] = 300,
		["The Deadmines"] = 291,
	};

	-- Unobtainable Listing (for fellow 100%s out there)
	["UNOBTAINABLE_ITEM_TEXTURES"] = {
		"Interface\\FriendsFrame\\StatusIcon-DnD", 								-- No Hope
		"Interface\\FriendsFrame\\StatusIcon-Away", 							-- Little Hope
		"Interface\\FriendsFrame\\StatusIcon-Online",							-- There is Hope
		"Interface\\FriendsFrame\\StatusIcon-Offline",							-- Seasonal
	};
	["UNOBTAINABLE_ITEM_REASONS"] = {
		-- [id] = {header, description, name}, header: header id, 1-3 as above, 4 is legacy.
		[1] = {1, "|CFFFF0000This was never available to players.|r", "Never Implemented"}, -- No Hope
		[2] = {1, "|CFFFF0000This has been removed from the game.|r", "Removed From Game"}, -- No Hope

		-- Hidden Filter (General Tab)
		[12] = {0, "|CFF00FFDEThis Thing requires Player vs Player activities or a currency related to those activities.|r", "Requires PvP"},

		-- Arbitrary Filters
		[9] = {3, "|CFFFF0000The original source of obtaining this has been removed and is now only available via the Black Market Auction House.|r", "Black Market AH [BMAH]"},
		[10] = {3, "|CFFFF0000Originally obtained via a TCG card that is no longer in print, but may still be available via the Black Market, In-Game, or Real Life Auction House.|r", "Trading Card Game [TCG]"},
		[11] = {3, "|CFFFF0000This is no longer available unless you know someone that has access to the items used to summon the boss.|r", "Requires Summoning Items"},
		[13] = {1, "|CFFFF0000Your followers are too high and the mission for the cache will no longer spawn.|r", "Legacy Cache"},
		[14] = {3, "|CFFFF0000This can no longer be purchased or unlocked as Transmog unless you have the required PvP Title, required PvP Rating or were in the Top % of that season.|r", "PvP Elite/Gladiator"},
		[15] = {1, "|CFFFF0000This cannot be permanently learned or used for transmog.|r", "Unlearnable"},
		[35] = {3, "|CFFFF0000This is locked behind a paywall, such as the In-Game Shop, another Blizzard Product, or the Recruit-A-Friend Service.|r", "Blizzard Balance"},
		[36] = {1, "|CFFFF0000This was only obtainable during the WoW Anniversary when it was active and is no longer available.|r", "WoW Anniversary [Removed]"},	-- TODO: Remove.
		[38] = {1, "|CFFFF0000This is only available to players that completed the Legendary Cloak quest chain during Mists of Pandaria or via the BMAH.|r", "Ordos - Legendary Cloak"},
		[41] = {1, "|CFFFF0000This is only available to players that completed the associated Mage Tower Artifact Challenges and earned the base appearance.|r", "Mage Tower Appearances"},
		[45] = {1, "|CFFFF0000Blizzard's Loot changes broke several Items and made them Unobtainable.\nHouse of Nobles Cape/Gurubashi Empire Greatcloak (both BFA Emissary Rewards) & Ogom the Mangler\nare currently broken and need to be fixed.|r", "Broken Loot"},

		-- Seasonal Filters
		[1000] = {4, "|CFF00FFDEThis requires the Brewfest Holiday to be Active.|r", "Brewfest"},
		[1001] = {4, "|CFF00FFDEThis requires the Children's Week Holiday to be Active.|r", "Children's Week"},
		[1012] = {4, "|CFF00FFDEThis requires the Darkmoon Faire Holiday to be Active.|r", "Darkmoon Faire" },
		[1002] = {4, "|CFF00FFDEThis requires the Day of the Dead Holiday to be Active.|r", "Day of the Dead"},
		[1003] = {4, "|CFF00FFDEThis requires the Feast of Winter Veil Holiday to be Active.|r", "Feast of Winter Veil"},
		[1009] = {4, "|CFF00FFDEThis requires the Fireworks Celebration Holiday to be Active.|r", "Fireworks Celebration" },
		[1004] = {4, "|CFF00FFDEThis requires the Hallow's End Holiday to be Active.|r", "Hallow's End"},
		[1005] = {4, "|CFF00FFDEThis requires the Harvest Festival Holiday to be Active.|r", "Harvest Festival"},
		[1006] = {4, "|CFF00FFDEThis requires the Love is in the Air Holiday to be Active.|r", "Love is in the Air"},
		[1007] = {4, "|CFF00FFDEThis requires the Lunar Festival Holiday to be Active.|r", "Lunar Festival"},
		[1014] = {4, "|CFF00FFDEThis requires a Specific Micro Holiday to be Active.|r", "Micro Holiday"},
		[1008] = {4, "|CFF00FFDEThis requires the Midsummer Fire Festival Holiday to be Active.|r", "Midsummer Fire Festival"},
		[1010] = {4, "|CFF00FFDEThis requires the Noblegarden Holiday to be Active.|r", "Noblegarden"},
		[1013] = {4, "|CFF00FFDEThis requires the Pilgrim's Bounty Holiday to be Active.|r", "Pilgrim's Bounty"},
		[1011] = {4, "|CFF00FFDEThis requires the Pirates' Day Holiday to be Active.|r", "Pirates' Day"},
		[1015] = {4, "|CFF00FFDEThis requires the Stranglethorn Fishing Extravaganza to be active.|r", "Stranglethorn Fishing Extravaganza"},
		[1016] = {4, "|CFF00FFDEThis requires the Timewalking Event to be active.|r", "Timewalking"},
		[1017] = {4, "|CFF00FFDEThis requires the WoW's Anniversary Event to be active.|r", "WoW's Anniversary"},
	};

	["CUSTOM_COLLECTS_REASONS"] = {
		["NPE"] = { "|cff5bc41dNew Player Experience|r", "Only a New Character can Collect this" },
		["SL_SKIP"] = { "|cff76879cShadowlands Skip|r", "Only a Character who chose to skip the Shadowlands Storyline can Collect this" },
		["SL_COV_KYR"] = { "|cFF516bfeKyrian Covenant|r" },
		["SL_COV_NEC"] = { "|cFF40bf40Necrolord Covenant|r" },
		["SL_COV_NFA"] = { "|cFFA330C9Night Fae Covenant|r" },
		["SL_COV_VEN"] = { "|cFFfe040fVenthyr Covenant|r" },
	};
};
