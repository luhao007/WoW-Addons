-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 9)

AtlasLoot:RegisterModules(addonname)

local AL = AtlasLoot.Locales

local NORMAL_DUNGEON_DIFF = data:AddDifficulty(AL["Normal"], "DungeonWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 1)
local HEROIC_DUNGEON_DIFF = data:AddDifficulty(AL["Heroic"], "HeroicDungeonWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 2)
local MYTHICD_DUNGEON_DIFF = data:AddDifficulty(AL["Mythic"], "MythicDungeonWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 23)

local RF_DIFF = data:AddDifficulty(AL["Raid Finder"], "LFRWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 17)
local NORMAL_RAID_DIFF = data:AddDifficulty(AL["Normal"], "NormalRaidWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 14)
local HEROIC_PRE_DIFF = data:AddDifficulty(AL["Heroic"], "HeroicWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 15)
local MYTHIC_PRE_DIFF = data:AddDifficulty(AL["Mythic"], "MyhticWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 16)

local RAID_ITTYPE = data:AddItemTableType("Item", "Item") -- Normal, Thunder-/Warforged...

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID_COLOR)

-- /////////////////////////////////
-- Instance
-- /////////////////////////////////
--[[
data["InstanceName"] = {
	EncounterJournalID = 111,
	MapID = 749,
	ContentType = DUNGEON_CONTENT / RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items =
	{
		{ -- bossN
			EncounterJournalID = 1111,
			[NORMAL_RAID_DIFF] = {
			},
		},
	}
}
]]
data["De Other Side"] = {
	EncounterJournalID = 1188,
	MapID = 1679,
	AtlasMapID = "DeOtherSideA",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Hakkar the Soulflayer
			EncounterJournalID = 2408,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  179330 }, -- Zin'khas, Blade of the Fallen God
				{ 2,  179328 }, -- Bloodspiller
				{ 3,  179325 }, -- Hakkari Revenant's Grips
				{ 4,  179326 }, -- Girdle of the Soulflayer
				{ 5,  179324 }, -- Soulfeather Breeches
				{ 6,  179322 }, -- Windscale Moccasins
				{ 7,  179331 }, -- Blood-Spattered Scale
				{ 9,  181834 }, -- Chilled Resilience
				{ 10, 181737 }, -- Nourishing Chi
				{ 11, 182621 }, -- One With the Beast
				{ 12, 182307 }, -- Shielding Words
				{ 13, 183479 }, -- Umbral Intensity
				{ 14, 182134 }, -- Unruly Winds
				{ 15, 183504 }, -- Well-Placed Steel
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- The Manastorms
			EncounterJournalID = 2409,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  179339 }, -- Whizblast Walking Stick
				{ 2,  179340 }, -- Supercollider
				{ 3,  179335 }, -- Manastorm's Magnificent Threads
				{ 4,  179336 }, -- Rocket Chicken Handlers
				{ 5,  179337 }, -- Techno-Coil Legguards
				{ 6,  179338 }, -- Dynamo Doomstompers
				{ 7,  179342 }, -- Overwhelming Power Crystal
				{ 9,  183216 }, -- Memory of a Burning Wound
				{ 10, 183271 }, -- Memory of the Infinite Arcane
				{ 11, 183369 }, -- Memory of Wilfred's Sigil of Superior Summoning
				{ 12, 181509 }, -- Arcane Prodigy
				{ 13, 182748 }, -- Borne of Blood
				{ 14, 181842 }, -- Power Unto Others
				{ 15, 180896 }, -- Safeguard
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Dealer Xy'exa
			EncounterJournalID = 2398,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  179347 }, -- Collector's Pulse Staff
				{ 2,  179348 }, -- Xy Cartel Crossbow
				{ 3,  179344 }, -- Far Traveler's Shoulderpads
				{ 4,  179349 }, -- Dealer Xy'exa's Cape
				{ 5,  179346 }, -- Breastplate of Fatal Contrivances
				{ 6,  179343 }, -- Sash of Exquisite Acquisitions
				{ 7,  179345 }, -- Spatial Rift Striders
				{ 8,  179350 }, -- Inscrutable Quantum Device
				{ 10, 183265 }, -- Memory of a Wildfire Cluster
				{ 11, 183396 }, -- Flame Infusion
				{ 12, 182624 }, -- Show of Force
				{ 13, 183509 }, -- Sleight of Hand
				{ 14, 183464 }, -- Tough as Bark
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Mueh'zala
			EncounterJournalID = 2410,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  179353 }, -- Harness of Twisted Whims
				{ 2,  179354 }, -- Reality-Shatter Vambraces
				{ 3,  179351 }, -- Mueh'zala's Hexthread Sarong
				{ 4,  179352 }, -- Primeval Soul's Ankleguards
				{ 5,  179355 }, -- Death God's Signet
				{ 6,  179356 }, -- Shadowgrasp Totem
				{ 8,  183329 }, -- Memory of a Prism of Shadow and Fire
				{ 9,  183282 }, -- Memory of the Fatal Touch
				{ 10, 183350 }, -- Memory of the Great Sundering
				{ 11, 181943 }, -- Eradicating Blow
				{ 12, 183490 }, -- Floral Recycling
				{ 13, 181467 }, -- Flow of Time
				{ 14, 182145 }, -- Heavy Rainfall
				{ 15, 181376 }, -- Inner Fury
				{ 16, 182344 }, -- Lost in Darkness
				{ 17, 182138 }, -- Mind Devourer
				{ 18, 182684 }, -- Resolute Defender
				{ 19, 182736 }, -- Rolling Agony
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
	}
}

data["Halls of Atonement"] = {
	EncounterJournalID = 1185,
	MapID = 1663,
	AtlasMapID = "HallsofAtonement",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Halkias, the Sin-Stained Goliath
			EncounterJournalID = 2406,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178813 }, -- Sinlight Shroud
				{ 2,  178830 }, -- Shardskin Sabatons
				{ 3,  178817 }, -- Hood of Refracted Shadows
				{ 4,  178827 }, -- Sin Stained Pendant
				{ 5,  178818 }, -- Halkias's Towering Pillars
				{ 7,  182629 }, -- Memory of the Crimson Runes
				{ 8,  183380 }, -- Memory of a Seismic Reverberation
				{ 9,  181736 }, -- Flame Accretion
				{ 10, 182681 }, -- Vengeful Shock
				{ 11, 181848 }, -- Accelerated Cold
				{ 12, 181640 }, -- Tumbling Technique
				{ 13, 181845 }, -- Exaltation
			},
			[HEROIC_DUNGEON_DIFF] = {
				--GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 1, 178827 }, -- Sin Stained Pendant
				{ 2, 246276 }, -- Sinlight Shoulderpads
				{ 3, 246273 }, -- Vest of Refracted Shadows
				{ 4, 178818 }, -- Halkias's Towering Pillars
				{ 5, 178830 }, -- Shardskin Sabatons
			},
			[MYTHICD_DUNGEON_DIFF] = {
				--GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Echelon
			EncounterJournalID = 2387,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178815 }, -- Soaring Decimator's Hauberk
				{ 2,  178834 }, -- Stoneguardian's Morningstar
				{ 3,  178825 }, -- Pulsating Stoneheart
				{ 4,  178812 }, -- Wing Commander's Helmet
				{ 5,  178833 }, -- Stonefiend Shaper's Mitts
				{ 6,  178819 }, -- Skyterror's Stonehide Leggings
				{ 8,  183349 }, -- Memory of the Deeptremor Stone
				{ 9,  183487 }, -- Layered Mane
				{ 10, 181735 }, -- Hack and Slash
				{ 11, 183184 }, -- Stinging Strike
				{ 12, 182470 }, -- Demonic Momentum
				{ 13, 182127 }, -- Shake the Foundations
				{ 14, 183511 }, -- Deeper Daggers
			},
			[HEROIC_DUNGEON_DIFF] = {
				--GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 1, 178834 }, -- Stoneguardian's Morningstar
				{ 2, 178812 }, -- Wing Commander's Helmet
				{ 3, 178815 }, -- Soaring Decimator's Hauberk
				{ 4, 178833 }, -- Stonefiend Shaper's Mitts
				{ 5, 178819 }, -- Skyterror's Stonehide Leggings
				{ 6, 246344 }, -- Cursed Stone Idol
			},
			[MYTHICD_DUNGEON_DIFF] = {
				--GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- High Adjudicator Aleez
			EncounterJournalID = 2411,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178822 }, -- Cord of the Dark Word
				{ 2,  178826 }, -- Sunblood Amethyst
				{ 3,  178828 }, -- Nathrian Tabernacle
				{ 4,  178832 }, -- Gloves of Haunting Fixation
				{ 5,  178821 }, -- Mantle of Ephemeral Visages
				{ 6,  178814 }, -- Breastplate of Otherworldly Influence
				{ 8,  183306 }, -- Memory of the Righteous Bulwark
				{ 9,  181963 }, -- Blood Bond
				{ 10, 182675 }, -- Untempered Dedication
				{ 11, 181505 }, -- Resplendent Mist
				{ 12, 181867 }, -- Swift Penitence
			},
			[HEROIC_DUNGEON_DIFF] = {
				--GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 1, 246284 }, -- Nathrian Reliquary
				{ 2, 178821 }, -- Mantle of Ephemeral Visages
				{ 3, 178814 }, -- Breastplate of Otherworldly Influence
				{ 4, 178832 }, -- Gloves of Haunting Fixation
				{ 5, 178822 }, -- Cord of the Dark Word
				{ 6, 178826 }, -- Sunblood Amethyst
			},
			[MYTHICD_DUNGEON_DIFF] = {
				--GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 16, "ac12550" }, -- AC: Mythic: Freehold "Pecking Order"
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Lord Chamberlain
			EncounterJournalID = 2413,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178823 }, -- Waistcord of Dark Devotion
				{ 2,  178831 }, -- Slippers of Leavened Station
				{ 3,  178820 }, -- Pauldrons of Unleashed Pride
				{ 4,  178824 }, -- Signet of the False Accuser
				{ 5,  178829 }, -- Nathrian Ferula
				{ 6,  178816 }, -- Nathrian Usurper's Mask
				{ 8,  183275 }, -- Memory of the Firestorm
				{ 9,  183241 }, -- Memory of the Dark Titan
				{ 10, 182685 }, -- Increased Scrutiny
				{ 11, 183495 }, -- Lashing Scars
				{ 12, 181639 }, -- Siphoned Malice
				{ 13, 181461 }, -- Ice Bite
				{ 14, 182348 }, -- Lavish Harvest
				{ 15, 183500 }, -- Fade to Nothing
				{ 16, 183477 }, -- Precise Alignment
				{ 17, 182288 }, -- Impenetrable Gloom
				{ 18, 183076 }, -- Diabolic Bloodstone
				{ 19, 182598 }, -- Demon Muzzle
				{ 20, 182331 }, -- Empowered Release
				{ 21, 181774 }, -- Imbued Reflections
				{ 22, 182463 }, -- Harrowing Punishment
				{ 23, 182777 }, -- Hallowed Discernment
				{ 24, 181944 }, -- Resonant Words
				{ 25, 182962 }, -- Catastrophic Origin
				{ 26, 182130 }, -- Shattered Perceptions
				{ 27, 182751 }, -- Tyrant's Soul
				{ 28, 183474 }, -- Endless Thirst
			},
			[HEROIC_DUNGEON_DIFF] = {
				--GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 1, 178829 }, -- Nathrian Ferula
				{ 2, 178816 }, -- Nathrian Usurper's Mask
				{ 3, 246286 }, -- Spaulders of Unleashed Pride
				{ 4, 178823 }, -- Waistcord of Dark Devotion
				{ 5, 178831 }, -- Slippers of Leavened Station
				{ 6, 178824 }, -- Signet of the False Accuser
			},
			[MYTHICD_DUNGEON_DIFF] = {
				--GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
	}
}

data["Mists of Tirna Scithe"] = {
	EncounterJournalID = 1184,
	MapID = 1669,
	AtlasMapID = "MistsofTirnaScithe",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Ingra Maloch
			EncounterJournalID = 2400,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178713 }, -- Drustlord's Greataxe
				{ 2,  178709 }, -- Scithewood Scepter
				{ 3,  178692 }, -- Soulthorn Visage
				{ 4,  178694 }, -- Wrathbark Greathelm
				{ 5,  178696 }, -- Ingra Maloch's Mantle
				{ 6,  178698 }, -- Rainshadow Hauberk
				{ 7,  178704 }, -- Deathshackle Wristwraps
				{ 8,  178700 }, -- Clasp of Waning Shadow
				{ 9,  178708 }, -- Unbound Changeling
				{ 11, 183253 }, -- Memory of the Soulforge Embers
				{ 12, 182582 }, -- Enkindled Spirit
				{ 13, 181466 }, -- Grounding Breath
				{ 14, 181844 }, -- Pain Transformation
				{ 15, 182686 }, -- Powerful Precision
				{ 16, 183491 }, -- Ready for Anything
				{ 17, 182143 }, -- Swirling Currents
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Mistcaller
			EncounterJournalID = 2402,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178710 }, -- Tanglewood Thorn
				{ 2,  178691 }, -- Hood of the Hidden Path
				{ 3,  178707 }, -- Trailspinner Pendant
				{ 4,  178697 }, -- Prankster's Pauldrons
				{ 5,  178695 }, -- Wintersnap Shoulderguards
				{ 6,  178706 }, -- Fogweaver Gauntlets
				{ 7,  178705 }, -- Tricksprite Gloves
				{ 8,  178715 }, -- Mistcaller Ocarina
				{ 10, 183266 }, -- Memory of the Disciplinary Command
				{ 11, 183336 }, -- Memory of the Duskwalker's Patch
				{ 12, 181462 }, -- Coordinated Offensive
				{ 13, 182754 }, -- Duplicitous Havoc
				{ 14, 182448 }, -- Light's Barding
				{ 15, 181734 }, -- Magi's Brand
				{ 16, 183514 }, -- Perforated Veins
				{ 18, 182305 }, -- Crown of Autumnal Flora
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Tred'ova
			EncounterJournalID = 2405,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178714 }, -- Lakali's Spire of Knowledge
				{ 2,  178711 }, -- Axe of the Deadgrove
				{ 3,  178712 }, -- Acidslough Bulwark
				{ 4,  178693 }, -- Cocoonsilk Cowl
				{ 5,  178702 }, -- Bands of the Undergrowth
				{ 6,  178703 }, -- Hiveswarm Bracers
				{ 7,  178699 }, -- Sapgorger Belt
				{ 8,  178701 }, -- Gormshell Greaves
				{ 10, 183229 }, -- Memory of a Timeworn Dreambinder
				{ 11, 183473 }, -- Conflux of Elements
				{ 12, 182206 }, -- Convocation of the Dead
				{ 13, 180935 }, -- Crash the Ramparts
				{ 14, 182651 }, -- Destructive Reverberations
				{ 15, 181539 }, -- Discipline of the Grove
				{ 16, 183132 }, -- Echoing Call
				{ 17, 182142 }, -- Embrace of Earth
				{ 18, 182347 }, -- Essential Extraction
				{ 19, 182129 }, -- Fae Fermata
				{ 20, 183485 }, -- Savage Combatant
				{ 21, 183494 }, -- Septic Shock
				{ 22, 182384 }, -- Serrated Glaive
				{ 23, 182964 }, -- Soul Eater
				{ 24, 182335 }, -- Spirit Attunement
				{ 25, 182767 }, -- The Long Summer
				{ 26, 183463 }, -- Unnatural Malice
				{ 27, 181775 }, -- Way of the Fae
				{ 28, 183199 }, -- Withering Ground
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 30, 183623 }, -- Spinemaw Gormling
			},
		},
	}
}

data["Plaguefall"] = {
	EncounterJournalID = 1183,
	MapID = 1674,
	AtlasMapID = "PlaguefallA",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Globgrog
			EncounterJournalID = 2419,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178753 }, -- Surgical Pustule Extractor
				{ 2,  178760 }, -- Digested Interrogator's Gaze
				{ 3,  178773 }, -- Plague Handler's Greathelm
				{ 4,  178762 }, -- Blightborne Chain Legguards
				{ 5,  178756 }, -- Stradama's Misplaced Slippers
				{ 6,  178770 }, -- Slimy Consumptive Organ
				{ 8,  181786 }, -- Eternal Hunger
				{ 9,  183506 }, -- Lethal Poisons
				{ 10, 182465 }, -- Truth's Wake
				{ 11, 183486 }, -- Well-Honed Instincts
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Doctor Ickus
			EncounterJournalID = 2403,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178752 }, -- Sophisticated Bonecracker
				{ 2,  178759 }, -- Depraved Physician's Mask
				{ 3,  178763 }, -- Malodorous Gristle-Sown Spaulders
				{ 4,  178767 }, -- Tortured Assistant's Bindings
				{ 5,  178775 }, -- Fleshfused Crushers
				{ 6,  178771 }, -- Phial of Putrefaction
				{ 8,  180933 }, -- Ashen Juggernaut
				{ 9,  182140 }, -- Dissonant Echoes
				{ 10, 182752 }, -- Fel Commando
				{ 11, 182126 }, -- High Voltage
				{ 12, 181455 }, -- Icy Propulsion
				{ 13, 181495 }, -- Jade Bond
				{ 14, 183496 }, -- Nimble Fingers
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Domina Venomblade
			EncounterJournalID = 2423,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178929 }, -- Halberd of the Aranakk
				{ 2,  178928 }, -- Domina's Oozing Shiv
				{ 3,  178934 }, -- Fastened Venombarb Binds
				{ 4,  178930 }, -- Mitts of Flawless Duplication
				{ 5,  178932 }, -- Belt of Wretched Manipulations
				{ 6,  178931 }, -- Scarred Bloodbound Girdle
				{ 7,  178933 }, -- Arachnid Cipher Ring
				{ 9,  183260 }, -- Memory of the Serpentstalker's Trickery
				{ 10, 183345 }, -- Memory of the Rotten
				{ 11, 182208 }, -- Lingering Plague
				{ 12, 182368 }, -- Relentless Onslaught
				{ 13, 183167 }, -- Strength of the Pack
				{ 14, 182108 }, -- Thunderous Paws
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Margrave Stradama
			EncounterJournalID = 2404,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178754 }, -- Poxstorm, Longsword of Pestilence
				{ 2,  178764 }, -- Plagueborne Shoulderguards
				{ 3,  178755 }, -- Blighted Margrave's Cloak
				{ 4,  178757 }, -- Gloves of Obscure Rituals
				{ 5,  178761 }, -- Leggings of the Erudite Scholar
				{ 6,  178774 }, -- Muckwallow Stompers
				{ 7,  178769 }, -- Infinitely Divisible Ooze
				{ 9,  183212 }, -- Memory of a Darkglare Medallion
				{ 10, 182637 }, -- Memory of Death's Certainty
				{ 11, 183319 }, -- Memory of my Crystalline Reflection
				{ 12, 181770 }, -- Bone Marrow Hops
				{ 13, 182706 }, -- Brooding Pool
				{ 14, 182292 }, -- Brutal Grasp
				{ 15, 183472 }, -- Evolved Swarm
				{ 16, 182961 }, -- Fatal Decimation
				{ 17, 181981 }, -- Festering Transfusion
				{ 18, 183478 }, -- Fury of the Skies
				{ 19, 181553 }, -- Gift of the Lich
				{ 20, 181504 }, -- Infernal Cascade
				{ 21, 182339 }, -- Necrotic Barrage
				{ 22, 182139 }, -- Rabid Shadows
				{ 23, 182770 }, -- Righteous Might
				{ 24, 183493 }, -- Sudden Fractures
				{ 25, 182346 }, -- Tumbling Waves
				{ 26, 182442 }, -- Veteran's Repute
				{ 27, 182747 }, -- Withering Bolt
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 29, 181271 }, -- Sludge Feeler
			},
		},
	}
}

data["Sanguine Depths"] = {
	EncounterJournalID = 1189,
	MapID = 1675,
	--AtlasMapID = "",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Kryxis the Voracious
			EncounterJournalID = 2388,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178854 }, -- Hungering Devourer's Twinblade
				{ 2,  178853 }, -- Voracious Gorger Spine
				{ 3,  178835 }, -- Anima-Splattered Hide
				{ 4,  178844 }, -- Essence Surge Binders
				{ 5,  178846 }, -- Shackles of Alluring Vitality
				{ 6,  178836 }, -- Sabatons of the Rushing Juggernaut
				{ 7,  178848 }, -- Entwined Gorger Tendril
				{ 9,  183234 }, -- Memory of a Luffa-Infused Embrace
				{ 10, 183297 }, -- Memory of Xuen
				{ 11, 183202 }, -- Deadly Tandem
				{ 12, 181740 }, -- Evasive Stride
				{ 13, 182133 }, -- Insatiable Appetite
				{ 14, 183480 }, -- Taste for Blood
				{ 15, 181769 }, -- Tempest Barrier
				{ 16, 181776 }, -- Vicious Contempt
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Executor Tarvold
			EncounterJournalID = 2415,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178855 }, -- Sinsmasher
				{ 2,  178859 }, -- Castigator's Mantle
				{ 3,  178851 }, -- Cloak of Enveloping Manifestations
				{ 4,  178845 }, -- Vambraces of the Depraved Warden
				{ 5,  178843 }, -- Executor's Prideful Girdle
				{ 6,  178837 }, -- Sinsoaked Waders
				{ 7,  178849 }, -- Overflowing Anima Cage
				{ 9,  182755 }, -- Ashen Remains
				{ 10, 182203 }, -- Debilitating Malady
				{ 11, 181942 }, -- Focused Mending
				{ 12, 182464 }, -- Harmony of the Tortollan
				{ 13, 183499 }, -- Quick Decisions
				{ 14, 182604 }, -- Roaring Fire
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Grand Proctor Beryllia
			EncounterJournalID = 2421,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178852 }, -- Vessel of Shining Radiance
				{ 2,  178847 }, -- Radiant Light Binders
				{ 3,  178841 }, -- Iron Spiked Handgrips
				{ 4,  178842 }, -- Waistguard of Expurged Anguish
				{ 5,  178838 }, -- Beryllia's Leggings of Endless Torment
				{ 6,  178850 }, -- Lingering Sunmote
				{ 8,  183323 }, -- Memory of Flash Concentration
				{ 9,  183303 }, -- Memory of Maraad's Dying Breath
				{ 10, 182324 }, -- Felfire Haste
				{ 11, 183489 }, -- Flash of Clarity
				{ 12, 180847 }, -- Inspiring Presence
				{ 13, 181847 }, -- Lasting Spirit
				{ 14, 182137 }, -- Magma Fist
				{ 15, 181506 }, -- Master Flame
				{ 16, 182608 }, -- Virtuous Command
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 18, 180591 }, -- Vial of Roiling Emotions
			},
		},
		{ -- General Kaal
			EncounterJournalID = 2407,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178856 }, -- Kaal's Gloomblade
				{ 2,  178857 }, -- Stone General's Edge
				{ 3,  178860 }, -- Cowl of the Devoted General
				{ 4,  178858 }, -- Wicked Bladewing Pauldrons
				{ 5,  178840 }, -- Guilewind Stone Talons
				{ 6,  178839 }, -- Wind Dancer's Legguards
				{ 7,  178862 }, -- Bladedancer's Armor Kit
				{ 8,  178861 }, -- Decanter of Anima-Charged Winds
				{ 10, 183358 }, -- Memory of an Earthen Harmony
				{ 11, 183289 }, -- Memory of Stormstout
				{ 12, 187506 }, -- Condensed Anima Sphere
				{ 13, 182677 }, -- Punish the Guilty
				{ 14, 182125 }, -- Pyroclastic Shock
				{ 15, 183507 }, -- Triple Threat
				{ 16, 181742 }, -- Walk with the Ox
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
	}
}

data["Spires of Ascension"] = {
	EncounterJournalID = 1186,
	MapID = 1693,
	AtlasMapID = "SpiresofAscensionA",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Kin-Tara
			EncounterJournalID = 2399,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  180097 }, -- Quarterstaff of Discordant Ethic
				{ 2,  180115 }, -- Azure-Venom Choker
				{ 3,  180100 }, -- Forsworn Stalker's Hauberk
				{ 4,  180103 }, -- Winged Hunters' Gloves
				{ 5,  180109 }, -- Kin-Tara's Baleful Cord
				{ 6,  180101 }, -- Warboots of Ruthless Conviction
				{ 8,  183231 }, -- Memory of a Cat-Eye Curio
				{ 9,  183483 }, -- Carnivorous Instinct
				{ 10, 182610 }, -- Ferocious Appetite
				{ 11, 182113 }, -- Fleeting Wind
				{ 12, 182468 }, -- Mortal Combo
				{ 13, 182144 }, -- Nature's Focus
				{ 14, 182317 }, -- Shattered Restoration
				{ 15, 183513 }, -- Stiletto Staccato
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Ventunax
			EncounterJournalID = 2416,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  180095 }, -- Penitent Edge
				{ 2,  180104 }, -- Distorted Construct's Gauntlets
				{ 3,  180110 }, -- Dark Praetorian's Clasp
				{ 4,  180111 }, -- Shadowhirl Waistwrap
				{ 5,  180102 }, -- Dark Stride Footwraps
				{ 6,  180116 }, -- Overcharged Anima Battery
				{ 8,  183338 }, -- Memory of Celerity
				{ 9,  183365 }, -- Memory of the Consuming Wrath
				{ 10, 183508 }, -- Ambidexterity
				{ 11, 181435 }, -- Calculated Strikes
				{ 12, 182478 }, -- Corrupting Leer
				{ 13, 182462 }, -- Expurgation
				{ 14, 181827 }, -- Move with Grace
				{ 15, 181389 }, -- Shivering Core
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Oryphrion
			EncounterJournalID = 2414,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  180112 }, -- The Philosopher
				{ 2,  180106 }, -- Vicious Surge Faceguard
				{ 3,  180113 }, -- Thunderous Echo Vambraces
				{ 4,  180105 }, -- Absonant Construct's Handguards
				{ 5,  180107 }, -- Purge Protocol Legwraps
				{ 6,  180118 }, -- Anima Field Emitter
				{ 7,  180117 }, -- Empyreal Ordnance
				{ 9,  183313 }, -- Memory of the Lightbringer's Tempest
				{ 10, 183392 }, -- Memory of the Thunderlord
				{ 11, 187507 }, -- Adaptive Armor Fragment
				{ 12, 183469 }, -- Front of the Pack
				{ 13, 182187 }, -- Meat Shield
				{ 14, 180944 }, -- Merciless Bonegrinder
				{ 15, 182476 }, -- Resilience of the Hunter
				{ 16, 182753 }, -- Royal Decree
				{ 17, 182471 }, -- Soul Furnace
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Devos, Paragon of Doubt
			EncounterJournalID = 2412,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  180096 }, -- Devos's Cacophonous Poleaxe
				{ 2,  180123 }, -- Drape of Twisted Loyalties
				{ 3,  180099 }, -- Breastplate of Brutal Dissonance
				{ 4,  180098 }, -- Sinister Requiem Vestments
				{ 5,  180114 }, -- Fallen Paragon's Armguards
				{ 6,  180108 }, -- Abyssal Disharmony Breeches
				{ 7,  180119 }, -- Boon of the Archon
				{ 9,  183290 }, -- Memory of Ancient Teachings
				{ 10, 183354 }, -- Memory of the Doom Winds
				{ 11, 183257 }, -- Memory of the Rylakstalker's Fangs
				{ 12, 182649 }, -- Brutal Projectiles
				{ 13, 181698 }, -- Cryo-Freeze
				{ 14, 182340 }, -- Fel Celerity
				{ 15, 182667 }, -- Focused Light
				{ 16, 182135 }, -- Focused Lightning
				{ 17, 182141 }, -- Holy Oration
				{ 18, 183488 }, -- Unstoppable Growth
				{ 19, 181465 }, -- Xuen's Bond
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
	}
}

data["Tazavesh, the Veiled Market"] = {
	EncounterJournalID = 1194,
	MapID = 1989,
	AtlasMapID = "TazaveshA",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Zo'phex the Sentinel
			EncounterJournalID = 2437,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 185824 }, -- Blade of Grievous Harm
				{ 2, 185780 }, -- Interrogator's Flensing Blade
				{ 3, 185793 }, -- Cyphered Gloves
				{ 4, 185815 }, -- Vambraces of Verification
				{ 5, 185816 }, -- Confiscated Bracers of Concealment
				{ 6, 185791 }, -- Knuckle-Dusting Handwraps

				--[[ { 8,  181841 }, -- Reinforced Shell
				{ 9,  182338 }, -- Pure Concentration
				{ 10, 182110 }, -- Crippling Hex
				{ 11, 181962 }, -- Mental Recovery
				{ 12, 183498 }, -- Cloaked in Shadows
				{ 13, 182330 }, -- Demonic Parole
				{ 14, 183468 }, -- Born Anew ]]
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- The Grand Menagerie
			EncounterJournalID = 2454,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 185814 }, -- Auctioneer's Counting Bracers
				{ 2, 185792 }, -- Achillite's Unbreakable Grip
				{ 3, 185809 }, -- Venza's Powderbelt
				{ 4, 185777 }, -- Fang of Alcruux
				{ 5, 185821 }, -- Gluttonous Rondel
				-- { 6,  185840 }, -- Seal of the Panoply
				-- { 7,  185794 }, -- Gavel Pounders
				{ 6, 246282 }, -- Order Bashers
				{ 7, 246281 }, -- Ring of the Panoply

				--[[ { 9,  183044 }, -- Kilrogg's Cunning
				{ 10, 181836 }, -- Spirit Drain
				{ 11, 181512 }, -- Dizzying Tumble
				{ 12, 184587 }, -- Ambuscade
				{ 13, 181469 }, -- Indelible Victory
				{ 14, 181756 }, -- Incantation of Swiftness ]]
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Mailroom Mayhem
			EncounterJournalID = 2436,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  185846 }, -- Miniscule Mailemental in an Envelope
				{ 2,  190652 }, -- Ticking Sack of Terror
				{ 3,  185811 }, -- Package Protector
				{ 4,  185845 }, -- First Class Healing Distributor
				{ 5,  185817 }, -- Bracers of Autonomous Classification
				{ 6,  185787 }, -- Implacable Weatherproof Treads
				{ 7,  185808 }, -- Discount Mail-Order Belt
				{ 8,  185807 }, -- Pan-Dimensional Packing Cord

				--[[ { 10, 181837 }, -- Clear Mind
				{ 11, 182325 }, -- Ravenous Consumption
				{ 12, 182584 }, -- Cheetah's Vigor
				{ 13, 183497 }, -- Recuperator
				{ 14, 182461 }, -- Echoing Blessings
				{ 15, 183465 }, -- Ursine Vigor ]]

				{ 16, 186534, "pet3110" }, -- Gizmo
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Myza's Oasis
			EncounterJournalID = 2452,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 185812 }, -- Acoustically Alluring Censer
				{ 2, 185783 }, -- Yasahm the Riftbreaker
				{ 3, 185802 }, -- Breakbeat Shoulderguards
				{ 4, 185789 }, -- Sabatons of Measured Time
				{ 5, 185842 }, -- Ornately Engraved Amplifier
				{ 6, 185804 }, -- Harmonious Spaulders
				-- { 7,  185806 }, -- Improvisational Cinch
				{ 7, 246287 }, -- Improvisational Girdle

				--[[ { 9,  181464 }, -- Winter's Protection
				{ 10, 182460 }, -- Accrued Vitality
				{ 11, 182106 }, -- Refreshing Waters
				{ 12, 181508 }, -- Fortifying Ingredients
				{ 13, 182656 }, -- Disturb the Peace
				{ 14, 183470 }, -- Born of the Wilds ]]
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- So'azmi
			EncounterJournalID = 2451,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 185778 }, -- First Fist of the So Cartel
				{ 2, 185782 }, -- Robes of Midnight Bargains
				{ 3, 185786 }, -- So'azmi's Fractal Vest
				{ 4, 185836 }, -- Codex of the First Technique
				{ 5, 185798 }, -- Quantum Leapers
				-- { 6,  185843 }, -- Duplicating Drape
				-- { 7,  185800 }, -- Orbitwarp Culottes
				{ 6, 246285 }, -- Fluxphase Culottes

				--[[ { 9,  181826 }, -- Translucent Image
				{ 10, 182132 }, -- Unending Grip
				{ 11, 182449 }, -- Resolute Barrier
				{ 12, 182318 }, -- Viscous Ink
				{ 13, 181707 }, -- Diverted Energy
				{ 14, 182605 }, -- Tactical Retreat ]]
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Hylbrande
			EncounterJournalID = 2448,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 185810 }, -- Skyreaver, Greataxe of the Keepers
				{ 2, 185779 }, -- Spire of Expurgation
				{ 3, 185805 }, -- Hylbrande's Retrofitted Shoulderguards
				{ 4, 185803 }, -- Stoneflesh Spaulders
				-- { 5, 185781 }, -- Drape of Titanic Dreams
				-- { 6, 185790 }, -- Treads of Titanic Deconversion
				-- { 7,  185788 }, -- Codebreaker's Cunning Sandals
				{ 5, 246275 }, -- Codebreaker's Cunning Handwraps
				{ 6, 246280 }, -- Boots of Titanic Deconversion

				--[[ { 9,  182336 }, -- Golden Path
				{ 10, 180943 }, -- Cacophonous Roar
				{ 11, 183467 }, -- Tireless Pursuit
				{ 12, 183501 }, -- Rushed Setup
				{ 13, 181373 }, -- Harm Denial
				{ 14, 182105 }, -- Astral Protection ]]
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Timecap'n Hooktail
			EncounterJournalID = 2449,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 185797 }, -- Rakishly Tipped Tricorne
				{ 2, 185796 }, -- Dragonbane Diadem
				{ 3, 185823 }, -- Fatebreaker, Destroyer of Futures
				{ 4, 185795 }, -- Cowl of Branching Fate
				{ 5, 185841 }, -- Timetwister Tulwar
				{ 6, 185820 }, -- Cabochon of the Infinite Flight
				-- { 7, 185776 }, -- Hooktail's Commanding Gaze
				{ 7, 246283 }, -- Crown of Absolute Command

				--[[ { 9,  183502 }, -- Prepared for All
				{ 10, 182469 }, -- Rejuvenating Wind
				{ 11, 181498 }, -- Grounding Surge
				{ 12, 180842 }, -- Stalwart Guardian
				{ 13, 182466 }, -- Shade of Terror
				{ 14, 181975 }, -- Hardened Bones ]]
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- So'leah
			EncounterJournalID = 2455,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  185822 }, -- Staff of Fractured Spacetime
				{ 2,  185819 }, -- Event Horizon's Edge
				{ 3,  185801 }, -- Anomalous Starlit Breeches
				{ 4,  185799 }, -- Hyperlight Leggings
				{ 5,  185813 }, -- Signet of Collapsing Stars
				{ 6,  190958 }, -- So'leah's Secret Technique
				-- { 7,  185784 }, -- Novaburst Warplate
				-- { 8, 185785 }, -- Embrace of the Relicbinder

				--[[ { 10, 182304 }, -- Divine Call
				{ 11, 182109 }, -- Totemic Surge
				{ 12, 181838 }, -- Charitable Soul
				{ 13, 182316 }, -- Fel Defender
				{ 14, 181510 }, -- Lingering Numbness
				{ 15, 183466 }, -- Innate Resolve
				{ 16, 182480 }, -- Reversal of Fortune ]]

				{ 18, 186638, "mount" }, -- Cartel Master's Gearglider
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
	}
}

data["The Necrotic Wake"] = {
	EncounterJournalID = 1182,
	MapID = 1666,
	AtlasMapID = "TheNecroticWakeA",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Blightbone
			EncounterJournalID = 2395,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178730 }, -- Engorged Worm Smasher
				{ 2,  178735 }, -- Blight Belcher
				{ 3,  178732 }, -- Abominable Visage
				{ 4,  178733 }, -- Blightbone Spaulders
				{ 5,  178734 }, -- Fused Bone Greatbelt
				{ 6,  178731 }, -- Viscera-Stitched Footpads
				{ 7,  178736 }, -- Stitchflesh's Misplaced Signet
				{ 9,  183505 }, -- Maim, Mangle
				{ 10, 181641 }, -- Rising Sun Revival
				{ 11, 182111 }, -- Spiritual Resonance
				{ 12, 183482 }, -- Sudden Ambush
				{ 13, 181709 }, -- Unnerving Focus
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Amarth, The Harvester
			EncounterJournalID = 2391,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178737 }, -- Amarth's Spellblade
				{ 2,  178738 }, -- Rattling Deadeye Hood
				{ 3,  178740 }, -- Reanimator's Mantle
				{ 4,  178741 }, -- Risen Monstrosity Cuffs
				{ 5,  178739 }, -- Legplates of Unholy Frenzy
				{ 6,  178742 }, -- Bottled Flayedwing Toxin
				{ 8,  183387 }, -- Memory of the Deathmaker
				{ 9,  183402 }, -- Bloodletting
				{ 10, 181712 }, -- Depths of Insanity
				{ 11, 181982 }, -- Everfrost
				{ 12, 183481 }, -- Incessant Hunter
				{ 13, 182772 }, -- Infernal Brand
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Surgeon Stitchflesh
			EncounterJournalID = 2392,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178743 }, -- Stitchflesh's Scalpel
				{ 2,  178750 }, -- Encrusted Canopic Lid
				{ 3,  178749 }, -- Vile Butcher's Pauldrons
				{ 4,  178744 }, -- Freshly Embalmed Jerkin
				{ 5,  178748 }, -- Gory Surgeon's Gloves
				{ 6,  178745 }, -- Striders of Restless Malice
				{ 7,  178772 }, -- Satchel of Misbegotten Minions
				{ 8,  178751 }, -- Spare Meat Hook
				{ 10, 183373 }, -- Memory of an Implosive Potential
				{ 11, 181738 }, -- Artifice of the Archmage
				{ 12, 182750 }, -- Carnivorous Stalkers
				{ 13, 182385 }, -- Growing Inferno
				{ 14, 183512 }, -- Planned Execution
				{ 15, 181700 }, -- Scalding Brew
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Nalthor the Rimebinder
			EncounterJournalID = 2396,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178780 }, -- Rimebinder's Runeblade
				{ 2,  178777 }, -- Darkfrost Helmet
				{ 3,  178779 }, -- Undying Chill Shoulderpads
				{ 4,  178782 }, -- Necropolis Lord's Shackles
				{ 5,  178778 }, -- Lichbone Legguards
				{ 6,  178781 }, -- Ritual Commander's Ring
				{ 7,  178783 }, -- Siphoning Phylactery Shard
				{ 9,  182633 }, -- Memory of the Biting Cold
				{ 10, 183278 }, -- Memory of the Cold Front
				{ 11, 182136 }, -- Chilled to the Core
				{ 12, 181974 }, -- Courageous Ascension
				{ 13, 183471 }, -- Deep Allegiance
				{ 14, 182345 }, -- Elysian Dirge
				{ 15, 182321 }, -- Enfeebled Mark
				{ 16, 181600 }, -- Ire of the Ascended
				{ 17, 182440 }, -- Piercing Verdict
				{ 18, 182295 }, -- Proliferation
				{ 19, 182646 }, -- Repeat Decree
				{ 20, 182622 }, -- Resplendent Light
				{ 21, 183492 }, -- Reverberation
				{ 22, 182778 }, -- Ringing Clarity
				{ 23, 181843 }, -- Shining Radiance
				{ 24, 182960 }, -- Soul Tithe
				{ 25, 181759 }, -- Strike with Clarity
				{ 26, 182201 }, -- Unleashed Frenzy
				{ 27, 181383 }, -- Unrelenting Cold
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 29, 181819 }, -- Marrowfang's Reins
			},
		},
	}
}

data["Theater of Pain"] = {
	EncounterJournalID = 1187,
	MapID = 1683,
	AtlasMapID = "TheaterofPainA",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- An Affront of Challengers
			EncounterJournalID = 2397,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178866 }, -- Dessia's Decimating Decapitator
				{ 2,  178799 }, -- Amphitheater Stalker's Hood
				{ 3,  178803 }, -- Plague-Licked Amice
				{ 4,  178795 }, -- Vest of Concealed Secrets
				{ 5,  178800 }, -- Galvanized Oxxein Legguards
				{ 6,  178871 }, -- Bloodoath Signet
				{ 7,  178810 }, -- Vial of Spectral Essence
				{ 9,  183332 }, -- Memory of the Master Assassin's Mark
				{ 10, 181705 }, -- Celestial Effervescence
				{ 11, 183197 }, -- Controlled Destruction
				{ 12, 182441 }, -- Marksman's Advantage
				{ 13, 183503 }, -- Poisoned Katar
				{ 14, 183484 }, -- Unchecked Aggression
				{ 15, 182107 }, -- Vital Accretion
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Gorechop
			EncounterJournalID = 2401,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178793 }, -- Abdominal Securing Chestguard
				{ 2,  178806 }, -- Contaminated Gauze Wristwraps
				{ 3,  178798 }, -- Grips of Overwhelming Beatings
				{ 4,  178869 }, -- Fleshfused Circle
				{ 5,  178808 }, -- Viscera of Coalesced Hatred
				{ 7,  183510 }, -- Count the Odds
				{ 8,  180932 }, -- Fueled by Violence
				{ 9,  181840 }, -- Light's Inspiration
				{ 10, 181866 }, -- Withering Plague
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Xav the Unfallen
			EncounterJournalID = 2390,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178865 }, -- Xav's Pike of Authority
				{ 2,  178789 }, -- Fleshcrafter's Knife
				{ 3,  178864 }, -- Gorebound Predator's Gavel
				{ 4,  178863 }, -- Gorestained Cleaver
				{ 5,  178794 }, -- Triumphant Combatant's Chainmail
				{ 6,  178807 }, -- Pit Fighter's Wristguards
				{ 7,  178801 }, -- Fearless Challenger's Leggings
				{ 9,  183220 }, -- Memory of Razelikh's Defilement
				{ 10, 183300 }, -- Memory of the Magistrate's Judgment
				{ 11, 183385 }, -- Memory of the Unhinged
				{ 12, 180844 }, -- Brutal Vitality
				{ 13, 182383 }, -- Dancing with Fate
				{ 14, 182657 }, -- Deadly Chain
				{ 15, 182559 }, -- Templar's Vindication
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Kul'tharok
			EncounterJournalID = 2389,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178792 }, -- Soulsewn Vestments
				{ 2,  178805 }, -- Girdle of Shattered Dreams
				{ 3,  178796 }, -- Boots of Shuddering Matter
				{ 4,  178870 }, -- Ritual Bone Band
				{ 5,  178809 }, -- Soulletting Ruby
				{ 7,  182617 }, -- Memory of Death's Embrace
				{ 8,  183375 }, -- Memory of the Diabolic Raiment
				{ 9,  182128 }, -- Call of Flame
				{ 10, 182769 }, -- Combusting Engine
				{ 11, 181980 }, -- Embrace Death
				{ 12, 181624 }, -- Swift Transference
				{ 13, 182456 }, -- Wrench Evil
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Mordretha, the Endless Empress
			EncounterJournalID = 2417,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  178867 }, -- Barricade of the Endless Empire
				{ 2,  178868 }, -- Deathwalker's Promise
				{ 3,  178802 }, -- Unyielding Combatant's Pauldrons
				{ 4,  178804 }, -- Fallen Empress's Cord
				{ 5,  178797 }, -- Vanquished Usurper's Footpads
				{ 6,  178872 }, -- Ring of Perpetual Conflict
				{ 7,  178811 }, -- Grim Codex
				{ 9,  183314 }, -- Memory of Cauterizing Shadows
				{ 10, 183225 }, -- Memory of Lycara
				{ 11, 182743 }, -- Focused Malignancy
				{ 12, 182131 }, -- Haunting Apparitions
				{ 13, 181511 }, -- Nether Precision
				{ 14, 182648 }, -- Sharpshooter's Focus
				{ 15, 183476 }, -- Stellar Inspiration
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
	}
}

-- /////////////////////////////////
-- Raid
-- /////////////////////////////////
data["Shadowlands"] = {
	EncounterJournalID = 1192,
	MapID = 1550,
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items =
	{
		{ -- Valinor, the Light of Eons
			EncounterJournalID = 2430,
			[NORMAL_RAID_DIFF] = {
				{ 1,   184132 }, -- Oversized Centurion Helm
				{ 2,   184141 }, -- Shroud of the Penitent
				{ 3,   184136 }, -- Anima-Charged Wristbanding
				{ 4,   184170 }, -- Doubtweaver's Handwraps
				{ 5,   184125 }, -- Servo-Chain Waistguard
				{ 6,   184139 }, -- Valinor's Ground Pounders
				{ 8,   183325 }, -- Memory of Archbishop Benedictus
				{ 9,   183311 }, -- Memory of the Final Verdict
				{ 10,  183353 }, -- Memory of the Windspeaker's Lava Resurgence
				{ 11,  181770 }, -- Bone Marrow Hops
				{ 12,  182706 }, -- Brooding Pool
				{ 13,  182292 }, -- Brutal Grasp
				{ 14,  182962 }, -- Catastrophic Origin
				{ 15,  183473 }, -- Conflux of Elements
				{ 16,  181974 }, -- Courageous Ascension
				{ 17,  183471 }, -- Deep Allegiance
				{ 18,  182651 }, -- Destructive Reverberations
				{ 19,  181539 }, -- Discipline of the Grove
				{ 20,  182345 }, -- Elysian Dirge
				{ 21,  182331 }, -- Empowered Release
				{ 22,  183474 }, -- Endless Thirst
				{ 23,  182321 }, -- Enfeebled Mark
				{ 24,  182347 }, -- Essential Extraction
				{ 25,  183472 }, -- Evolved Swarm
				{ 26,  182129 }, -- Fae Fermata
				{ 27,  182961 }, -- Fatal Decimation
				{ 28,  181981 }, -- Festering Transfusion
				{ 29,  181553 }, -- Gift of the Lich
				{ 30,  182777 }, -- Hallowed Discernment
				{ 101, 182463 }, -- Harrowing Punishment
				{ 102, 181774 }, -- Imbued Reflections
				{ 103, 182288 }, -- Impenetrable Gloom
				{ 104, 182685 }, -- Increased Scrutiny
				{ 105, 181600 }, -- Ire of the Ascended
				{ 106, 183495 }, -- Lashing Scars
				{ 107, 182348 }, -- Lavish Harvest
				{ 108, 182339 }, -- Necrotic Barrage
				{ 109, 182440 }, -- Piercing Verdict
				{ 110, 182295 }, -- Proliferation
				{ 111, 182646 }, -- Repeat Decree
				{ 112, 183492 }, -- Reverberation
				{ 113, 182770 }, -- Righteous Might
				{ 114, 182778 }, -- Ringing Clarity
				{ 115, 183494 }, -- Septic Shock
				{ 116, 182130 }, -- Shattered Perceptions
				{ 117, 181639 }, -- Siphoned Malice
				{ 118, 182964 }, -- Soul Eater
				{ 119, 182960 }, -- Soul Tithe
				{ 120, 182335 }, -- Spirit Attunement
				{ 121, 181759 }, -- Strike with Clarity
				{ 122, 183493 }, -- Sudden Fractures
				{ 123, 182767 }, -- The Long Summer
				{ 124, 182346 }, -- Tumbling Waves
				{ 125, 183463 }, -- Unnatural Malice
				{ 126, 182442 }, -- Veteran's Repute
				{ 127, 181775 }, -- Way of the Fae
				{ 128, 183199 }, -- Withering Ground
			},
		},
		{ -- Mortanis
			EncounterJournalID = 2431,
			[NORMAL_RAID_DIFF] = {
				{ 1,   184128 }, -- Mortanis's Ribcage
				{ 2,   184135 }, -- Shoulderblade Vambraces
				{ 3,   184173 }, -- Bone Crushing Vicegrips
				{ 4,   184133 }, -- Spine Crawler Waistcord
				{ 5,   184140 }, -- Bone-Cleated Footpads
				{ 6,   184143 }, -- Band of the Risen Bonelord
				{ 8,   183341 }, -- Memory of a Guile Charm
				{ 9,   183386 }, -- Memory of Fujieda
				{ 10,  183295 }, -- Memory of Keefer
				{ 11,  181770 }, -- Bone Marrow Hops
				{ 12,  182706 }, -- Brooding Pool
				{ 13,  182292 }, -- Brutal Grasp
				{ 14,  182962 }, -- Catastrophic Origin
				{ 15,  183473 }, -- Conflux of Elements
				{ 16,  181974 }, -- Courageous Ascension
				{ 17,  183471 }, -- Deep Allegiance
				{ 18,  182651 }, -- Destructive Reverberations
				{ 19,  181539 }, -- Discipline of the Grove
				{ 20,  182345 }, -- Elysian Dirge
				{ 21,  182331 }, -- Empowered Release
				{ 22,  183474 }, -- Endless Thirst
				{ 23,  182321 }, -- Enfeebled Mark
				{ 24,  182347 }, -- Essential Extraction
				{ 25,  183472 }, -- Evolved Swarm
				{ 26,  182129 }, -- Fae Fermata
				{ 27,  182961 }, -- Fatal Decimation
				{ 28,  181981 }, -- Festering Transfusion
				{ 29,  181553 }, -- Gift of the Lich
				{ 30,  182777 }, -- Hallowed Discernment
				{ 101, 182463 }, -- Harrowing Punishment
				{ 102, 181774 }, -- Imbued Reflections
				{ 103, 182288 }, -- Impenetrable Gloom
				{ 104, 182685 }, -- Increased Scrutiny
				{ 105, 181600 }, -- Ire of the Ascended
				{ 106, 183495 }, -- Lashing Scars
				{ 107, 182348 }, -- Lavish Harvest
				{ 108, 182339 }, -- Necrotic Barrage
				{ 109, 182440 }, -- Piercing Verdict
				{ 110, 182295 }, -- Proliferation
				{ 111, 182646 }, -- Repeat Decree
				{ 112, 183492 }, -- Reverberation
				{ 113, 182770 }, -- Righteous Might
				{ 114, 182778 }, -- Ringing Clarity
				{ 115, 183494 }, -- Septic Shock
				{ 116, 182130 }, -- Shattered Perceptions
				{ 117, 181639 }, -- Siphoned Malice
				{ 118, 182964 }, -- Soul Eater
				{ 119, 182960 }, -- Soul Tithe
				{ 120, 182335 }, -- Spirit Attunement
				{ 121, 181759 }, -- Strike with Clarity
				{ 122, 183493 }, -- Sudden Fractures
				{ 123, 182767 }, -- The Long Summer
				{ 124, 182346 }, -- Tumbling Waves
				{ 125, 183463 }, -- Unnatural Malice
				{ 126, 182442 }, -- Veteran's Repute
				{ 127, 181775 }, -- Way of the Fae
				{ 128, 183199 }, -- Withering Ground
			},
		},
		{ -- Oranomonos the Everbranching
			EncounterJournalID = 2432,
			[NORMAL_RAID_DIFF] = {
				{ 1,   184126 }, -- Ironroot Bindings
				{ 2,   184172 }, -- Seed-Tender's Handwraps
				{ 3,   184138 }, -- Stonebark Girdle
				{ 4,   184129 }, -- Oranomonos's Diaphanous Leggings
				{ 5,   184127 }, -- Slippers of the Leafy Undergrowth
				{ 6,   184142 }, -- Twisted Witherroot Band
				{ 8,   183274 }, -- Memory of a Fevered Incantation
				{ 9,   183261 }, -- Memory of Surging Shots
				{ 10,  183238 }, -- Memory of the Verdant Infusion
				{ 11,  181770 }, -- Bone Marrow Hops
				{ 12,  182706 }, -- Brooding Pool
				{ 13,  182292 }, -- Brutal Grasp
				{ 14,  182962 }, -- Catastrophic Origin
				{ 15,  183473 }, -- Conflux of Elements
				{ 16,  181974 }, -- Courageous Ascension
				{ 17,  183471 }, -- Deep Allegiance
				{ 18,  182651 }, -- Destructive Reverberations
				{ 19,  181539 }, -- Discipline of the Grove
				{ 20,  182345 }, -- Elysian Dirge
				{ 21,  182331 }, -- Empowered Release
				{ 22,  183474 }, -- Endless Thirst
				{ 23,  182321 }, -- Enfeebled Mark
				{ 24,  182347 }, -- Essential Extraction
				{ 25,  183472 }, -- Evolved Swarm
				{ 26,  182129 }, -- Fae Fermata
				{ 27,  182961 }, -- Fatal Decimation
				{ 28,  181981 }, -- Festering Transfusion
				{ 29,  181553 }, -- Gift of the Lich
				{ 30,  182777 }, -- Hallowed Discernment
				{ 101, 182463 }, -- Harrowing Punishment
				{ 102, 181774 }, -- Imbued Reflections
				{ 103, 182288 }, -- Impenetrable Gloom
				{ 104, 182685 }, -- Increased Scrutiny
				{ 105, 181600 }, -- Ire of the Ascended
				{ 106, 183495 }, -- Lashing Scars
				{ 107, 182348 }, -- Lavish Harvest
				{ 108, 182339 }, -- Necrotic Barrage
				{ 109, 182440 }, -- Piercing Verdict
				{ 110, 182295 }, -- Proliferation
				{ 111, 182646 }, -- Repeat Decree
				{ 112, 183492 }, -- Reverberation
				{ 113, 182770 }, -- Righteous Might
				{ 114, 182778 }, -- Ringing Clarity
				{ 115, 183494 }, -- Septic Shock
				{ 116, 182130 }, -- Shattered Perceptions
				{ 117, 181639 }, -- Siphoned Malice
				{ 118, 182964 }, -- Soul Eater
				{ 119, 182960 }, -- Soul Tithe
				{ 120, 182335 }, -- Spirit Attunement
				{ 121, 181759 }, -- Strike with Clarity
				{ 122, 183493 }, -- Sudden Fractures
				{ 123, 182767 }, -- The Long Summer
				{ 124, 182346 }, -- Tumbling Waves
				{ 125, 183463 }, -- Unnatural Malice
				{ 126, 182442 }, -- Veteran's Repute
				{ 127, 181775 }, -- Way of the Fae
				{ 128, 183199 }, -- Withering Ground
			},
		},
		{ -- Nurgash Muckformed
			EncounterJournalID = 2433,
			[NORMAL_RAID_DIFF] = {
				{ 1,   184144 }, -- Muckformed Chain Choker
				{ 2,   184137 }, -- Sinstone Shoulderpadding
				{ 3,   184131 }, -- Comfortable Slumberwraps
				{ 4,   184171 }, -- Hardened Castle Crushers
				{ 5,   184130 }, -- Nurgash's Belt of Many Sinstones
				{ 6,   184134 }, -- Jingling Stone Stompers
				{ 8,   182638 }, -- Memory of a Frenzied Monstrosity
				{ 9,   183215 }, -- Memory of an Erratic Fel Core
				{ 10,  183376 }, -- Memory of Azj'Aqir's Madness
				{ 11,  181770 }, -- Bone Marrow Hops
				{ 12,  182706 }, -- Brooding Pool
				{ 13,  182292 }, -- Brutal Grasp
				{ 14,  182962 }, -- Catastrophic Origin
				{ 15,  183473 }, -- Conflux of Elements
				{ 16,  181974 }, -- Courageous Ascension
				{ 17,  183471 }, -- Deep Allegiance
				{ 18,  182651 }, -- Destructive Reverberations
				{ 19,  181539 }, -- Discipline of the Grove
				{ 20,  182345 }, -- Elysian Dirge
				{ 21,  182331 }, -- Empowered Release
				{ 22,  183474 }, -- Endless Thirst
				{ 23,  182321 }, -- Enfeebled Mark
				{ 24,  182347 }, -- Essential Extraction
				{ 25,  183472 }, -- Evolved Swarm
				{ 26,  182129 }, -- Fae Fermata
				{ 27,  182961 }, -- Fatal Decimation
				{ 28,  181981 }, -- Festering Transfusion
				{ 29,  181553 }, -- Gift of the Lich
				{ 30,  182777 }, -- Hallowed Discernment
				{ 101, 182463 }, -- Harrowing Punishment
				{ 102, 181774 }, -- Imbued Reflections
				{ 103, 182288 }, -- Impenetrable Gloom
				{ 104, 182685 }, -- Increased Scrutiny
				{ 105, 181600 }, -- Ire of the Ascended
				{ 106, 183495 }, -- Lashing Scars
				{ 107, 182348 }, -- Lavish Harvest
				{ 108, 182339 }, -- Necrotic Barrage
				{ 109, 182440 }, -- Piercing Verdict
				{ 110, 182295 }, -- Proliferation
				{ 111, 182646 }, -- Repeat Decree
				{ 112, 183492 }, -- Reverberation
				{ 113, 182770 }, -- Righteous Might
				{ 114, 182778 }, -- Ringing Clarity
				{ 115, 183494 }, -- Septic Shock
				{ 116, 182130 }, -- Shattered Perceptions
				{ 117, 181639 }, -- Siphoned Malice
				{ 118, 182964 }, -- Soul Eater
				{ 119, 182960 }, -- Soul Tithe
				{ 120, 182335 }, -- Spirit Attunement
				{ 121, 181759 }, -- Strike with Clarity
				{ 122, 183493 }, -- Sudden Fractures
				{ 123, 182767 }, -- The Long Summer
				{ 124, 182346 }, -- Tumbling Waves
				{ 125, 183463 }, -- Unnatural Malice
				{ 126, 182442 }, -- Veteran's Repute
				{ 127, 181775 }, -- Way of the Fae
				{ 128, 183199 }, -- Withering Ground
			},
		},
		{ -- Mor'geth, Tormentor of the Damned
			EncounterJournalID = 2456,
			[NORMAL_RAID_DIFF] = {
				{ 1,  187061 }, -- Shard of Rev
				{ 2,  186360 }, -- Tormented Soul Harness
				{ 3,  186368 }, -- Mor'geth's Gauntlets of Damnation
				{ 4,  186355 }, -- Wristwraps of Anguish
				{ 5,  186372 }, -- Tormentor's Greatbelt
				{ 6,  187447 }, -- Soul Cage Fragment
				{ 7,  186361 }, -- Grips of Unleashed Suffering
				{ 8,  186366 }, -- Stygian Chain Greaves
				{ 9,  186357 }, -- Sorrowful Trousers
				{ 10, 186370 }, -- Caged Legplates
				{ 12, 187507 }, -- Adaptive Armor Fragment
				{ 13, 187506 }, -- Condensed Anima Sphere
			},
		},
		{ -- Antros
			EncounterJournalID = 2468,
			[NORMAL_RAID_DIFF] = {
				{ 1,  190614 }, -- Antros' Entrusted Bascinet
				{ 2,  190616 }, -- Controlled Sequence Clasp
				{ 3,  190618 }, -- Lattice of the Distant Keeper
				{ 4,  190620 }, -- Sav'thul's Calamitous Tantour
				{ 5,  190615 }, -- Cosmic Guardian's Casing
				{ 6,  190617 }, -- Destruction-Core Handlers
				{ 7,  190619 }, -- Antecedent's Aliform Joggers
				{ 8,  190621 }, -- Dealic Deterrent Stockings
				{ 10, 187507 }, -- Adaptive Armor Fragment
				{ 11, 187506 }, -- Condensed Anima Sphere
			},
		},
	}
}

data["Castle Nathria"] = {
	EncounterJournalID = 1190,
	MapID = 1735,
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items =
	{
		{ -- Shriekwing
			EncounterJournalID = 2393,
			[RF_DIFF] = {
				{ 1,  183034 }, -- Cowled Batwing Cloak
				{ 2,  182976 }, -- Double-Chained Utility Belt
				{ 3,  182993 }, -- Chiropteran Leggings
				{ 4,  183027 }, -- Errant Crusader's Greaves
				{ 5,  182979 }, -- Slippers of the Forgotten Heretic
				{ 6,  184016 }, -- Skulker's Wing
				{ 8,  182330 }, -- Demonic Parole
				{ 9,  182656 }, -- Disturb the Peace
				{ 10, 181962 }, -- Mental Recovery
				{ 11, 180944 }, -- Merciless Bonegrinder
				{ 12, 183512 }, -- Planned Execution
				{ 13, 182466 }, -- Shade of Terror
				{ 14, 182109 }, -- Totemic Surge
				{ 15, 182132 }, -- Unending Grip
				{ 16, 181742 }, -- Walk with the Ox
				{ 17, 181866 }, -- Withering Plague
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Huntsman Altimor
			EncounterJournalID = 2429,
			[RF_DIFF] = {
				{ 1,  183040 }, -- Charm of Eternal Winter
				{ 2,  182988 }, -- Master Huntsman's Bandolier
				{ 3,  182996 }, -- Grim Pursuant's Maille
				{ 4,  183018 }, -- Hellhound Cuffs
				{ 5,  182995 }, -- Spell-Woven Tourniquet
				{ 6,  184017 }, -- Bargast's Leash
				{ 7,  183892 }, -- Mystic Anima Spherule
				{ 9,  183258 }, -- Memory of Eagletalon's True Focus
				{ 10, 183235 }, -- Memory of the Natural Order
				{ 11, 183361 }, -- Memory of the Spiritwalker's Tidal Totem
				{ 12, 180933 }, -- Ashen Juggernaut
				{ 13, 183470 }, -- Born of the Wilds
				{ 14, 180943 }, -- Cacophonous Roar
				{ 15, 182110 }, -- Crippling Hex
				{ 16, 181982 }, -- Everfrost
				{ 17, 181942 }, -- Focused Mending
				{ 18, 181510 }, -- Lingering Numbness
				{ 19, 183501 }, -- Rushed Setup
				{ 20, 182648 }, -- Sharpshooter's Focus
				{ 21, 182605 }, -- Tactical Retreat
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Sun King's Salvation
			EncounterJournalID = 2422,
			[RF_DIFF] = {
				{ 1,  183033 }, -- Mantle of Manifest Sins
				{ 2,  182986 }, -- High Torturer's Smock
				{ 3,  182977 }, -- Bangles of Errant Pride
				{ 4,  183007 }, -- Bleakwing Assassin's Grips
				{ 5,  183025 }, -- Stoic Guardsman's Belt
				{ 6,  184019 }, -- Soul Igniter
				{ 7,  184018 }, -- Splintered Heart of Al'ar
				{ 8,  184020 }, -- Tuft of Smoldering Plumage
				{ 9,  183893 }, -- Abominable Anima Spherule
				{ 11, 183304 }, -- Memory of the Shadowbreaker
				{ 12, 183277 }, -- Memory of the Sun King
				{ 13, 180844 }, -- Brutal Vitality
				{ 14, 182584 }, -- Cheetah's Vigor
				{ 15, 182316 }, -- Fel Defender
				{ 16, 181975 }, -- Hardened Bones
				{ 17, 181504 }, -- Infernal Cascade
				{ 18, 182677 }, -- Punish the Guilty
				{ 19, 182736 }, -- Rolling Agony
				{ 20, 182307 }, -- Shielding Words
				{ 21, 182471 }, -- Soul Furnace
				{ 22, 182107 }, -- Vital Accretion
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Artificer Xy'mox
			EncounterJournalID = 2418,
			[RF_DIFF] = {
				{ 1,  182987 }, -- Breastplate of Cautious Calculation
				{ 2,  183019 }, -- Precisely Calibrated Chronometer
				{ 3,  183004 }, -- Shadewarped Sash
				{ 4,  183012 }, -- Greaves of Enigmatic Energies
				{ 5,  183038 }, -- Hyperlight Band
				{ 6,  184021 }, -- Glyph of Assimilation
				{ 7,  183888 }, -- Apogee Anima Bead
				{ 9,  183370 }, -- Memory of the Core of the Balespider
				{ 10, 183296 }, -- Memory of the Last Emperor
				{ 11, 182460 }, -- Accrued Vitality
				{ 12, 183468 }, -- Born Anew
				{ 13, 181837 }, -- Clear Mind
				{ 14, 182126 }, -- High Voltage
				{ 15, 181734 }, -- Magi's Brand
				{ 16, 182441 }, -- Marksman's Advantage
				{ 17, 181843 }, -- Shining Radiance
				{ 18, 181769 }, -- Tempest Barrier
				{ 19, 183479 }, -- Umbral Intensity
				{ 21, 183960 }, -- Portable Pocket Dimension
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Hungering Destroyer
			EncounterJournalID = 2428,
			[RF_DIFF] = {
				{ 1,  183001 }, -- Helm of Insatiable Appetite
				{ 2,  182994 }, -- Epaulets of Overwhelming Force
				{ 3,  183000 }, -- Consumptive Chainmail Carapace
				{ 4,  183009 }, -- Miasma-Lacquered Jerkin
				{ 5,  183028 }, -- Cinch of Infinite Tightness
				{ 6,  182992 }, -- Endlessly Gluttonous Greaves
				{ 7,  183024 }, -- Volatile Shadestitch Legguards
				{ 8,  184022 }, -- Consumptive Infusion
				{ 9,  184023 }, -- Gluttonous Spike
				{ 10, 183891 }, -- Venerated Anima Spherule
				{ 12, 182630 }, -- Memory of Gorefiend's Domination
				{ 13, 183391 }, -- Memory of the Wall
				{ 14, 182755 }, -- Ashen Remains
				{ 15, 181435 }, -- Calculated Strikes
				{ 16, 183498 }, -- Cloaked in Shadows
				{ 17, 181698 }, -- Cryo-Freeze
				{ 18, 181786 }, -- Eternal Hunger
				{ 19, 181827 }, -- Move with Grace
				{ 20, 182622 }, -- Resplendent Light
				{ 21, 181836 }, -- Spirit Drain
				{ 22, 181640 }, -- Tumbling Technique
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Lady Inerva Darkvein
			EncounterJournalID = 2420,
			[RF_DIFF] = {
				{ 1,  183021 }, -- Confidant's Favored Cap
				{ 2,  183026 }, -- Gloves of Phantom Shadows
				{ 3,  183015 }, -- Binding of Warped Desires
				{ 4,  182985 }, -- Memento-Laden Cuisses
				{ 5,  183037 }, -- Ritualist's Treasured Ring
				{ 6,  184025 }, -- Memory of Past Sins
				{ 7,  183889 }, -- Thaumaturgic Anima Bead
				{ 9,  183218 }, -- Memory of a Fortified Fel Flame
				{ 10, 183240 }, -- Memory of the Mother Tree
				{ 11, 183510 }, -- Count the Odds
				{ 12, 182336 }, -- Golden Path
				{ 13, 181466 }, -- Grounding Breath
				{ 14, 181498 }, -- Grounding Surge
				{ 15, 181495 }, -- Jade Bond
				{ 16, 183502 }, -- Prepared for All
				{ 17, 181841 }, -- Reinforced Shell
				{ 18, 182469 }, -- Rejuvenating Wind
				{ 19, 182449 }, -- Resolute Barrier
				{ 20, 180896 }, -- Safeguard
				{ 21, 182317 }, -- Shattered Restoration
				{ 22, 182111 }, -- Spiritual Resonance
				{ 23, 183482 }, -- Sudden Ambush
				{ 24, 182143 }, -- Swirling Currents
				{ 25, 183464 }, -- Tough as Bark
				{ 26, 181826 }, -- Translucent Image
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- The Council of Blood
			EncounterJournalID = 2426,
			[RF_DIFF] = {
				{ 1,  183039 }, -- Noble's Birthstone Pendant
				{ 2,  182989 }, -- Corset of the Deft Duelist
				{ 3,  183014 }, -- Castellan's Chainlink Grips
				{ 4,  183011 }, -- Courtier's Costume Trousers
				{ 5,  183030 }, -- Enchanted Toe-Tappers
				{ 6,  183023 }, -- Sparkling Glass Slippers
				{ 7,  182983 }, -- Stoneguard Attendant's Boots
				{ 8,  184024 }, -- Macabre Sheet Music
				{ 9,  183890 }, -- Zenith Anima Spherule
				{ 11, 183334 }, -- Memory of the Dashing Scoundrel
				{ 12, 183326 }, -- Memory of the Void's Eternal Call
				{ 13, 183402 }, -- Bloodletting
				{ 14, 181834 }, -- Chilled Resilience
				{ 15, 182383 }, -- Dancing with Fate
				{ 16, 182470 }, -- Demonic Momentum
				{ 17, 181512 }, -- Dizzying Tumble
				{ 18, 182461 }, -- Echoing Blessings
				{ 19, 182131 }, -- Haunting Apparitions
				{ 20, 183466 }, -- Innate Resolve
				{ 21, 180847 }, -- Inspiring Presence
				{ 22, 183496 }, -- Nimble Fingers
				{ 23, 181842 }, -- Power Unto Others
				{ 24, 182325 }, -- Ravenous Consumption
				{ 25, 182106 }, -- Refreshing Waters
				{ 26, 182480 }, -- Reversal of Fortune
				{ 27, 181776 }, -- Vicious Contempt
				{ 28, 181464 }, -- Winter's Protection
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Sludgefist
			EncounterJournalID = 2394,
			[RF_DIFF] = {
				{ 1,  182999 }, -- Rampaging Giant's Chestplate
				{ 2,  182984 }, -- Colossal Plate Gauntlets
				{ 3,  183022 }, -- Impossibly Oversized Mitts
				{ 4,  183005 }, -- Heedless Pugilist's Harness
				{ 5,  183016 }, -- Load-Bearing Belt
				{ 6,  182981 }, -- Leggings of Lethal Reverberations
				{ 7,  183006 }, -- Stoneclas Stompers
				{ 8,  184026 }, -- Hateful Chain
				{ 10, 183318 }, -- Memory of a Clear Mind
				{ 11, 183272 }, -- Memory of a Siphoning Storm
				{ 12, 183374 }, -- Memory of Azj'Aqir's Cinders
				{ 13, 183340 }, -- Memory of Greenskin
				{ 14, 182635 }, -- Memory of Koltira
				{ 15, 183309 }, -- Memory of the Ardent Protector
				{ 16, 183389 }, -- Memory of the Berserker's Will
				{ 17, 183233 }, -- Memory of the Frenzyband
				{ 18, 183293 }, -- Memory of the Morning's Tear
				{ 19, 183356 }, -- Memory of the Primal Lava Actuators
				{ 20, 183264 }, -- Memory of the Rylakstalker's Strikes
				{ 21, 181707 }, -- Diverted Energy
				{ 22, 182340 }, -- Fel Celerity
				{ 23, 181373 }, -- Harm Denial
				{ 24, 181455 }, -- Icy Propulsion
				{ 25, 183505 }, -- Maim, Mangle
				{ 26, 183499 }, -- Quick Decisions
				{ 27, 183467 }, -- Tireless Pursuit
				{ 28, 182751 }, -- Tyrant's Soul
				{ 29, 183484 }, -- Unchecked Aggression
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Stone Legion Generals
			EncounterJournalID = 2425,
			[RF_DIFF] = {
				{ 1,   183029 }, -- Wicked Flanker's Gorget
				{ 2,   183032 }, -- Crest of the Legionnaire General
				{ 3,   182998 }, -- Robes of the Cursed Commando
				{ 4,   182991 }, -- Oathsworn Soldier's Gauntlets
				{ 5,   183002 }, -- Ceremonial Parade Legguards
				{ 6,   184027 }, -- Stone Legion Heraldry
				{ 7,   183895 }, -- Apogee Anima Bead
				{ 8,   183894 }, -- Thaumaturgic Anima Bead
				{ 10,  183346 }, -- Memory of an Ancestral Reminder
				{ 11,  183267 }, -- Memory of an Expanded Potential
				{ 12,  183330 }, -- Memory of Bloodfang's Essence
				{ 13,  183367 }, -- Memory of Demonic Synergy
				{ 14,  182627 }, -- Memory of Superstrain
				{ 15,  183213 }, -- Memory of the Anguish of the Collective
				{ 16,  183223 }, -- Memory of the Circle of Life and Death
				{ 17,  183283 }, -- Memory of the Invoker
				{ 18,  183299 }, -- Memory of the Sun's Cycles
				{ 19,  183381 }, -- Memory of the Tormented Kings
				{ 20,  183316 }, -- Memory of the Twins of the Sun Priestess
				{ 21,  183250 }, -- Memory of the Wild Call
				{ 22,  181838 }, -- Charitable Soul
				{ 23,  183076 }, -- Diabolic Bloodstone
				{ 24,  182304 }, -- Divine Call
				{ 25,  182324 }, -- Felfire Haste
				{ 26,  181467 }, -- Flow of Time
				{ 27,  181508 }, -- Fortifying Ingredients
				{ 28,  183469 }, -- Front of the Pack
				{ 29,  182464 }, -- Harmony of the Tortollan
				{ 30,  182133 }, -- Insatiable Appetite
				{ 101, 183497 }, -- Recuperator
				{ 102, 180842 }, -- Stalwart Guardian
				{ 103, 183167 }, -- Strength of the Pack
				{ 104, 182108 }, -- Thunderous Paws
				{ 105, 182134 }, -- Unruly Winds
				{ 106, 183488 }, -- Unstoppable Growth
				{ 107, 182608 }, -- Virtuous Command
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Sire Denathrius
			EncounterJournalID = 2424,
			[RF_DIFF] = {
				{ 1,   182997 }, -- Diadem of Imperious Desire
				{ 2,   182980 }, -- Sadist's Sinister Mask
				{ 3,   183003 }, -- Pauldrons of Fatal Finality
				{ 4,   183020 }, -- Shawl of the Penitent
				{ 5,   183036 }, -- Most Regal Signet of Sire Denathrius
				{ 6,   184028 }, -- Cabalist's Hymnal
				{ 7,   184030 }, -- Dreadfire Vessel
				{ 8,   184029 }, -- Manabound Mirror
				{ 9,   184031 }, -- Sanguine Vintage
				{ 10,  183896 }, -- Abominable Anima Spherule
				{ 11,  183897 }, -- Mystic Anima Spherule
				{ 12,  183898 }, -- Venerated Anima Spherule
				{ 13,  183899 }, -- Zenith Anima Spherule

				{ 16,  183288 }, -- Memory of a Celestial Infusion
				{ 17,  183324 }, -- Memory of a Harmonious Apparatus
				{ 18,  183362 }, -- Memory of a Malefic Wrath
				{ 19,  183344 }, -- Memory of Finality
				{ 20,  183227 }, -- Memory of Oneth
				{ 21,  183214 }, -- Memory of the Chaos Theory
				{ 22,  182636 }, -- Memory of the Deadliest Coil
				{ 23,  183352 }, -- Memory of the Demise of Skybreaker
				{ 24,  183256 }, -- Memory of the Eredun War Order
				{ 25,  183384 }, -- Memory of the Exploiter
				{ 26,  183279 }, -- Memory of the Freezing Winds
				{ 27,  183310 }, -- Memory of the Vanguard's Momentum
				{ 28,  184587 }, -- Ambuscade
				{ 29,  182105 }, -- Astral Protection
				{ 30,  181770 }, -- Bone Marrow Hops
				{ 101, 182706 }, -- Brooding Pool
				{ 102, 182292 }, -- Brutal Grasp
				{ 103, 182962 }, -- Catastrophic Origin
				{ 104, 183473 }, -- Conflux of Elements
				{ 105, 181974 }, -- Courageous Ascension
				{ 106, 183471 }, -- Deep Allegiance
				{ 107, 182651 }, -- Destructive Reverberations
				{ 108, 181539 }, -- Discipline of the Grove
				{ 109, 182345 }, -- Elysian Dirge
				{ 110, 182331 }, -- Empowered Release
				{ 111, 183474 }, -- Endless Thirst
				{ 112, 182321 }, -- Enfeebled Mark
				{ 113, 182347 }, -- Essential Extraction
				{ 114, 183472 }, -- Evolved Swarm
				{ 115, 183500 }, -- Fade to Nothing
				{ 116, 182129 }, -- Fae Fermata
				{ 117, 182961 }, -- Fatal Decimation
				{ 118, 181981 }, -- Festering Transfusion
				{ 119, 182113 }, -- Fleeting Wind
				{ 120, 181553 }, -- Gift of the Lich
				{ 121, 182777 }, -- Hallowed Discernment
				{ 122, 182463 }, -- Harrowing Punishment
				{ 123, 181774 }, -- Imbued Reflections
				{ 124, 182288 }, -- Impenetrable Gloom
				{ 125, 181756 }, -- Incantation of Swiftness
				{ 126, 182685 }, -- Increased Scrutiny
				{ 127, 181469 }, -- Indelible Victory
				{ 128, 181600 }, -- Ire of the Ascended
				{ 129, 183044 }, -- Kilrogg's Cunning
				{ 130, 183495 }, -- Lashing Scars
				{ 201, 182348 }, -- Lavish Harvest
				{ 202, 182448 }, -- Light's Barding
				{ 203, 181840 }, -- Light's Inspiration
				{ 204, 182339 }, -- Necrotic Barrage
				{ 205, 182440 }, -- Piercing Verdict
				{ 206, 182295 }, -- Proliferation
				{ 207, 182646 }, -- Repeat Decree
				{ 208, 183492 }, -- Reverberation
				{ 209, 182770 }, -- Righteous Might
				{ 210, 182778 }, -- Ringing Clarity
				{ 211, 183494 }, -- Septic Shock
				{ 212, 182130 }, -- Shattered Perceptions
				{ 213, 181639 }, -- Siphoned Malice
				{ 214, 182964 }, -- Soul Eater
				{ 215, 182960 }, -- Soul Tithe
				{ 216, 182335 }, -- Spirit Attunement
				{ 217, 181759 }, -- Strike with Clarity
				{ 218, 183493 }, -- Sudden Fractures
				{ 219, 181624 }, -- Swift Transference
				{ 220, 182767 }, -- The Long Summer
				{ 221, 182346 }, -- Tumbling Waves
				{ 222, 183463 }, -- Unnatural Malice
				{ 223, 183465 }, -- Ursine Vigor
				{ 224, 182442 }, -- Veteran's Repute
				{ 225, 182318 }, -- Viscous Ink
				{ 226, 181775 }, -- Way of the Fae
				{ 227, 183199 }, -- Withering Ground
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
	}
}

data["Sanctum of Domination"] = {
	EncounterJournalID = 1193,
	MapID = 1998,
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items =
	{
		{ -- The Tarragrue
			EncounterJournalID = 2435,
			[RF_DIFF] = {
				{ 1,  186381 }, -- Elethium-Bladed Glaive
				{ 2,  186415 }, -- Moriaz's Spare Targe
				{ 3,  186291 }, -- Periapt of Pristine Preservation
				{ 4,  186298 }, -- Smuggler's Plundered Pauldrons
				{ 5,  186303 }, -- Colossus Slayer's Hauberk
				{ 6,  186297 }, -- Clasps of the Unfortunate Troubadour
				{ 7,  186302 }, -- Mistwrap Manacles
				{ 8,  186311 }, -- Cavalier Oathbreaker's Grasps
				{ 9,  186285 }, -- Sorcerer's Headlong Legwraps
				{ 10, 186318 }, -- Champion's Gruesome Greaves
				{ 11, 186281 }, -- Phantasma-Forged Striders
				{ 12, 186422 }, -- Tome of Monstrous Constructions
				{ 14, 182750 }, -- Carnivorous Stalkers
				{ 15, 182610 }, -- Ferocious Appetite
				{ 16, 182113 }, -- Fleeting Wind
				{ 17, 180932 }, -- Fueled by Violence
				{ 18, 183481 }, -- Incessant Hunter
				{ 19, 181376 }, -- Inner Fury
				{ 20, 182344 }, -- Lost in Darkness
				{ 21, 182144 }, -- Nature's Focus
				{ 22, 182139 }, -- Rabid Shadows
				{ 23, 183504 }, -- Well-Placed Steel
				{ 24, 182456 }, -- Wrench Evil
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- The Eye of the Jailer
			EncounterJournalID = 2442,
			[RF_DIFF] = {
				{ 1,  186403 }, -- Stygian Lance of Passage
				{ 2,  186383 }, -- Gazepiercer
				{ 3,  186418 }, -- Guarm's Lost Chew Toy
				{ 4,  186296 }, -- Mawsworn Eviscerator's Cuirass
				{ 5,  186316 }, -- Airborne Abductor's Vambraces
				{ 6,  186288 }, -- Grasps of the Clairvoyant Sage
				{ 7,  186295 }, -- Loyal Kvaldir's Handwraps
				{ 8,  186301 }, -- Coiled Stygian Grapnel
				{ 9,  186306 }, -- Greaves of Extermination
				{ 10, 186423 }, -- Titanic Ocular Gland
				{ 12, 181738 }, -- Artifice of the Archmage
				{ 13, 181963 }, -- Blood Bond
				{ 14, 182478 }, -- Corrupting Leer
				{ 15, 182462 }, -- Expurgation
				{ 16, 183500 }, -- Fade to Nothing
				{ 17, 181840 }, -- Light's Inspiration
				{ 18, 182441 }, -- Marksman's Advantage
				{ 19, 180896 }, -- Safeguard
				{ 20, 181640 }, -- Tumbling Technique
				{ 21, 183486 }, -- Well-Honed Instincts
				{ 23, 186554, "pet3128" }, -- Eye of Allseeing
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 24, 186555, "pet3129" }, -- Eye of Extermination
			},
		},
		{ -- The Nine
			EncounterJournalID = 2439,
			[RF_DIFF] = {
				{ 1,  186404 }, -- Jotungeirr, Destiny's Call
				{ 2,  186385 }, -- Signe's Sonorous Scramaseax
				{ 3,  186384 }, -- Skyja's Revenant Fury
				{ 4,  186286 }, -- Mantle of Arthura's Chosen
				{ 5,  186339 }, -- Brynja's Mournful Wristwraps
				{ 6,  186346 }, -- Kyra's Unending Protectors
				{ 7,  186313 }, -- Agatha's Gothic Greaves
				{ 8,  186307 }, -- Aradne's Lancer Legguards
				{ 9,  186299 }, -- Daschla's Defiant Treads
				{ 10, 186290 }, -- Sworn Oath of the Nine
				{ 11, 186425 }, -- Scrawled Word of Recall
				{ 12, 186424 }, -- Shard of Annhylde's Aegis
				{ 14, 182657 }, -- Deadly Chain
				{ 15, 181845 }, -- Exaltation
				{ 16, 182340 }, -- Fel Celerity
				{ 17, 181736 }, -- Flame Accretion
				{ 18, 182135 }, -- Focused Lightning
				{ 19, 183477 }, -- Precise Alignment
				{ 20, 181641 }, -- Rising Sun Revival
				{ 21, 182753 }, -- Royal Decree
				{ 22, 182384 }, -- Serrated Glaive
				{ 23, 182201 }, -- Unleashed Frenzy
				{ 25, 186656, "mount" }, -- Sanctum Gloomcharger's Reins
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Remnant of Ner'zhul
			EncounterJournalID = 2444,
			[RF_DIFF] = {
				{ 1,  186405 }, -- Gnarled Staff of the Elder Shaman
				{ 2,  186386 }, -- Betrayer's Shadowspike
				{ 3,  186292 }, -- Cap of Writhing Malevolence
				{ 4,  186304 }, -- Crest of the Fallen
				{ 5,  186315 }, -- Dark Tormentor's Gaze
				{ 6,  186287 }, -- Hood of Vengeful Possession
				{ 7,  186378 }, -- Weathered Talisman of the Shadowmoon
				{ 8,  186312 }, -- Cuirass of the Lonely Citadel
				{ 9,  186308 }, -- Grasps of Ancestral Whispers
				{ 10, 186428 }, -- Shadowed Orb of Torment
				{ 11, 186427 }, -- Whispering Shard of Power
				{ 13, 183508 }, -- Ambidexterity
				{ 14, 181705 }, -- Celestial Effervescence
				{ 15, 182206 }, -- Convocation of the Dead
				{ 16, 182752 }, -- Fel Commando
				{ 17, 182464 }, -- Harmony of the Tortollan
				{ 18, 182468 }, -- Mortal Combo
				{ 19, 181842 }, -- Power Unto Others
				{ 20, 181389 }, -- Shivering Core
				{ 21, 182111 }, -- Spiritual Resonance
				{ 22, 183464 }, -- Tough as Bark
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Soulrender Dormazain
			EncounterJournalID = 2445,
			[RF_DIFF] = {
				{ 1,  186407 }, -- Hellscream's Requiem
				{ 2,  186387 }, -- Dormazain's Tenderizer
				{ 3,  186411 }, -- Soulrent Outrider's Recurve
				{ 4,  186305 }, -- Pauldrons of Tyrannical Defiance
				{ 5,  186314 }, -- Ruinous Warchief's Shoulderguards
				{ 6,  186289 }, -- Cloak of Scarred Honor
				{ 7,  186283 }, -- Cruel Overlord's Shackles
				{ 8,  186294 }, -- Agonizing Spiked Belt
				{ 9,  186343 }, -- Ragebound Leg Irons
				{ 10, 186319 }, -- Tormented Shadowcleft Boots
				{ 11, 186337 }, -- Trenchant Warmonger Treads
				{ 12, 186429 }, -- Decanter of Endless Howling
				{ 14, 180844 }, -- Brutal Vitality
				{ 15, 181834 }, -- Chilled Resilience
				{ 16, 183076 }, -- Diabolic Bloodstone
				{ 17, 183489 }, -- Flash of Clarity
				{ 18, 181467 }, -- Flow of Time
				{ 19, 181466 }, -- Grounding Breath
				{ 20, 181847 }, -- Lasting Spirit
				{ 21, 182448 }, -- Light's Barding
				{ 22, 182317 }, -- Shattered Restoration
				{ 23, 183513 }, -- Stiletto Staccato
				{ 24, 182107 }, -- Vital Accretion
				{ 26, 186558, "pet3122" }, -- Irongrasp
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Painsmith Raznal
			EncounterJournalID = 2443,
			[RF_DIFF] = {
				{ 1,  186388 }, -- Cruciform Veinripper
				{ 2,  186392 }, -- Exacting Mindslicer
				{ 3,  186391 }, -- Shadowsteel Demoralizer
				{ 4,  186341 }, -- Shadowsteel Facecage
				{ 5,  186282 }, -- Sacrificer's Sacramental Cassock
				{ 6,  186369 }, -- Guillotine Gauntlets
				{ 7,  186333 }, -- Hangman's Knotbinders
				{ 8,  186293 }, -- Flameclasp-Scorched Legguards
				{ 9,  186323 }, -- Leggings of the Screaming Flames
				{ 10, 186375 }, -- Miniature Breaking Wheel
				{ 11, 186431 }, -- Ebonsoul Vise
				{ 12, 186430 }, -- Tormented Rack Fragment
				{ 14, 182203 }, -- Debilitating Malady
				{ 15, 182754 }, -- Duplicitous Havoc
				{ 16, 182582 }, -- Enkindled Spirit
				{ 17, 183396 }, -- Flame Infusion
				{ 18, 181506 }, -- Master Flame
				{ 19, 183496 }, -- Nimble Fingers
				{ 20, 182125 }, -- Pyroclastic Shock
				{ 21, 182604 }, -- Roaring Fire
				{ 22, 183476 }, -- Stellar Inspiration
				{ 23, 181709 }, -- Unnerving Focus
				{ 24, 181465 }, -- Xuen's Bond
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Guardian of the First Ones
			EncounterJournalID = 2446,
			[RF_DIFF] = {
				{ 1,  186409 }, -- Pylon of the Great Purge
				{ 2,  186393 }, -- Torch of Eternal Knowledge
				{ 3,  186413 }, -- Directional Meltdown Projector
				{ 4,  186416 }, -- Infinity's Last Bulwark
				{ 5,  186374 }, -- Self-Replicating Tissue
				{ 6,  186347 }, -- Ancient Colossus Chassis
				{ 7,  186317 }, -- Disintegration-Proof Waistband
				{ 8,  186284 }, -- Enigmatic Energy Circuit
				{ 9,  186344 }, -- Hyperdense Greaves
				{ 10, 186354 }, -- Sandals of Sacred Symmetry
				{ 11, 186363 }, -- Unstable Energizer Boots
				{ 12, 186433 }, -- Reactive Defense Matrix
				{ 13, 186432 }, -- Salvaged Fusion Amplifier
				{ 16, 187507 }, -- Adaptive Armor Fragment
				{ 17, 183132 }, -- Echoing Call
				{ 18, 181735 }, -- Hack and Slash
				{ 19, 182145 }, -- Heavy Rainfall
				{ 20, 182133 }, -- Insatiable Appetite
				{ 21, 183487 }, -- Layered Mane
				{ 22, 181827 }, -- Move with Grace
				{ 23, 183503 }, -- Poisoned Katar
				{ 24, 181505 }, -- Resplendent Mist
				{ 25, 182307 }, -- Shielding Words
				{ 26, 181769 }, -- Tempest Barrier
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Fatescribe Roh-Kalo
			EncounterJournalID = 2447,
			[RF_DIFF] = {
				{ 1,  186419 }, -- Record of Collapsing Realities
				{ 2,  186330 }, -- Cowl of Haunting Precognition
				{ 3,  186340 }, -- Conjunction-Forged Chainmail
				{ 4,  186320 }, -- Diviner's Draped Finery
				{ 5,  186335 }, -- Fate-Threaded Bindings
				{ 6,  186345 }, -- Demigaunts of Predestination
				{ 7,  186326 }, -- Gloves of Forsaken Purpose
				{ 8,  186352 }, -- Binding of Dark Destinies
				{ 9,  186348 }, -- Fateforged Legplates
				{ 10, 186376 }, -- Oscillating Ouroboros
				{ 11, 186435 }, -- Carved Ivory Keepsake
				{ 12, 186434 }, -- Weave of Warped Fates
				{ 14, 181509 }, -- Arcane Prodigy
				{ 15, 182649 }, -- Brutal Projectiles
				{ 16, 182470 }, -- Demonic Momentum
				{ 17, 182324 }, -- Felfire Haste
				{ 18, 183469 }, -- Front of the Pack
				{ 19, 182684 }, -- Resolute Defender
				{ 20, 183509 }, -- Sleight of Hand
				{ 21, 181867 }, -- Swift Penitence
				{ 22, 181624 }, -- Swift Transference
				{ 23, 182108 }, -- Thunderous Paws
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Kel'Thuzad
			EncounterJournalID = 2440,
			[RF_DIFF] = {
				{ 1,  187542 }, -- Jaithys, the Prison Blade
				{ 2,  186406 }, -- Maledict Opus
				{ 3,  187056 }, -- The Devouring Cold
				{ 4,  186350 }, -- Valorous Visage of Krexus
				{ 5,  186379 }, -- Interplanar Keystone
				{ 6,  186324 }, -- Frame of the False Margrave
				{ 7,  186336 }, -- Spaulders of the Crooked Confidant
				{ 8,  186365 }, -- Bands of the Fallen House
				{ 9,  186351 }, -- Vyraz's Parade Cuffs
				{ 10, 186338 }, -- Ceremonial Construct Clasp
				{ 11, 186322 }, -- Sash of Duplicitous Magics
				{ 12, 186331 }, -- Elite Aranakk Breeches
				{ 13, 186421 }, -- Forbidden Necromantic Tome
				{ 14, 186437 }, -- Relic of the Frozen Wastes
				{ 15, 186436 }, -- Resonant Silver Bell
				{ 16, 182136 }, -- Chilled to the Core
				{ 17, 181698 }, -- Cryo-Freeze
				{ 18, 183202 }, -- Deadly Tandem
				{ 19, 181943 }, -- Eradicating Blow
				{ 20, 183490 }, -- Floral Recycling
				{ 21, 182141 }, -- Holy Oration
				{ 22, 180847 }, -- Inspiring Presence
				{ 23, 183499 }, -- Quick Decisions
				{ 24, 182675 }, -- Untempered Dedication
				{ 25, 182747 }, -- Withering Bolt
				{ 27, 186550, "pet3131" }, -- Mawsworn Minion
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Sylvanas Windrunner
			EncounterJournalID = 2441,
			[RF_DIFF] = {
				{ 1,  186414 }, -- Rae'shalare, Death's Whisper
				{ 2,  186398 }, -- Edge of Night
				{ 3,  186417 }, -- Guard of the Sundered Defender
				{ 4,  186325 }, -- Veil of the Banshee Queen
				{ 5,  186342 }, -- Epaulets of the Master Ranger
				{ 6,  186349 }, -- Spires of Broken Hope
				{ 7,  186439 }, -- Dark Ranger's Quiver
				{ 8,  186334 }, -- Witherheart Studded Breastplate
				{ 9,  186321 }, -- Desecrator's Keening Wristwraps
				{ 10, 186332 }, -- Windrunner's Baldric
				{ 11, 186353 }, -- Greaves of Haunting Ruination
				{ 12, 186377 }, -- Tarnished Insignia of Quel'Thalas
				{ 13, 186438 }, -- Old Warrior's Soul
				{ 16, 180933 }, -- Ashen Juggernaut
				{ 17, 183483 }, -- Carnivorous Instinct
				{ 18, 183511 }, -- Deeper Daggers
				{ 19, 181740 }, -- Evasive Stride
				{ 20, 182385 }, -- Growing Inferno
				{ 21, 182772 }, -- Infernal Brand
				{ 22, 182208 }, -- Lingering Plague
				{ 23, 182138 }, -- Mind Devourer
				{ 24, 182476 }, -- Resilience of the Hunter
				{ 25, 182127 }, -- Shake the Foundations
				{ 26, 182559 }, -- Templar's Vindication
				{ 27, 181383 }, -- Unrelenting Cold
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 29, 186642, "mount" }, -- Vengeance's Reins
			},
		},
	}
}

data["Sepulcher of the First Ones"] = {
	EncounterJournalID = 1195,
	MapID = 2047,
	AtlasMapID = "SepulcheroftheFirstOnesA",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items =
	{
		{ -- Vigilant Guardian
			EncounterJournalID = 2458,
			[NORMAL_RAID_DIFF] = {
				{ 1,  189779 }, -- Key to the Immortal Hearth
				{ 2,  189584 }, -- Sepulcher's Savior
				{ 3,  189775 }, -- Helm of Solemn Vigil
				{ 4,  189774 }, -- Fractured Colossus Core
				{ 5,  189777 }, -- Unstable Giant's Cuffs
				{ 6,  189776 }, -- Girdle of the First Gate
				{ 7,  189771 }, -- Ancient Materium Tassets
				{ 8,  189778 }, -- Legplates of the Slumbering Sentinel
				{ 9,  189770 }, -- Pre-Fabricated Footpads
				{ 10, 189772 }, -- Modified Defense Grid
				{ 11, 188273 }, -- Auxiliary Attendant Chime
				{ 13, 183402 }, -- Bloodletting
				{ 14, 182126 }, -- High Voltage
				{ 15, 181734 }, -- Magi's Brand
				{ 16, 183505 }, -- Maim, Mangle
				{ 17, 180944 }, -- Merciless Bonegrinder
				{ 18, 182622 }, -- Resplendent Light
				{ 19, 182736 }, -- Rolling Agony
				{ 20, 181843 }, -- Shining Radiance
				{ 21, 183479 }, -- Umbral Intensity
				{ 22, 181742 }, -- Walk with the Ox
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Skolex, the Insatiable Ravener
			EncounterJournalID = 2465,
			[NORMAL_RAID_DIFF] = {
				{ 1,  189817 }, -- Rift-Scarred Solcrusher
				{ 2,  189816 }, -- Crystallized Viscera Spike
				{ 3,  189819 }, -- Assimilated Safeguard
				{ 4,  189810 }, -- Ephemera-Softened Exoskeleton
				{ 5,  189814 }, -- Gluttonous Gardbrace
				{ 6,  189813 }, -- Mantle of the Broken Beast
				{ 7,  189815 }, -- Lurking Predator's Camouflage
				{ 8,  189812 }, -- Devourer's Sandblown Hidebinders
				{ 9,  189809 }, -- Skolex's Ravenous Skinguards
				{ 10, 189811 }, -- Infinitely Collapsing Coil
				{ 11, 188267 }, -- Bells of the Endless Feast
				{ 13, 181838 }, -- Charitable Soul
				{ 14, 182110 }, -- Crippling Hex
				{ 15, 182383 }, -- Dancing with Fate
				{ 16, 181980 }, -- Embrace Death
				{ 17, 181508 }, -- Fortifying Ingredients
				{ 18, 182336 }, -- Golden Path
				{ 19, 181469 }, -- Indelible Victory
				{ 20, 183502 }, -- Prepared for All
				{ 21, 182466 }, -- Shade of Terror
				{ 22, 183167 }, -- Strength of the Pack
				{ 23, 183484 }, -- Unchecked Aggression
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Artificer Xy'mox
			EncounterJournalID = 2470,
			[NORMAL_RAID_DIFF] = {
				{ 1,  189829 }, -- Forerunner's Relic Blade
				{ 2,  189830 }, -- Replicated Relic Blade
				{ 3,  189828 }, -- Xy Captain's Crossbow
				{ 4,  189827 }, -- Cartel Xy's Proof of Initiation
				{ 5,  189822 }, -- Imported Illidari Spaulders
				{ 6,  189825 }, -- Veiled Auctioneer's Vambraces
				{ 7,  189824 }, -- Unlicensed Hyperlight Handlers
				{ 8,  189826 }, -- Enforcer's Containment Cinch
				{ 9,  189821 }, -- Illicit Artifact Holster
				{ 10, 189823 }, -- Stolen Nathrian Slippers
				{ 11, 188265 }, -- Cache of Acquired Treasures
				{ 12, 188266 }, -- Pulsating Riftshard
				{ 14, 182128 }, -- Call of Flame
				{ 15, 180935 }, -- Crash the Ramparts
				{ 16, 182667 }, -- Focused Light
				{ 17, 182743 }, -- Focused Malignancy
				{ 18, 181756 }, -- Incantation of Swiftness
				{ 19, 183506 }, -- Lethal Poisons
				{ 20, 181844 }, -- Pain Transformation
				{ 21, 182469 }, -- Rejuvenating Wind
				{ 22, 181836 }, -- Spirit Drain
				{ 23, 183488 }, -- Unstoppable Growth
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Dausegne, the Fallen Oracle
			EncounterJournalID = 2459,
			[NORMAL_RAID_DIFF] = {
				{ 1,  189807 }, -- Discordant Deathblade
				{ 2,  189788 }, -- Maestro's Malice
				{ 3,  189790 }, -- Final Forte
				{ 4,  189787 }, -- Dausegne's Dissonant Halo
				{ 5,  189784 }, -- Epaulets of the Ailing Aria
				{ 6,  189791 }, -- Drape of Mournful Melodies
				{ 7,  189782 }, -- Haunting Hymnal Robes
				{ 8,  189785 }, -- Oracle's Chromatic Cuirass
				{ 9,  189773 }, -- Clasp of Crooked Crescendos
				{ 10, 189793 }, -- Sash of the Silent Sonata
				{ 11, 189786 }, -- Song-Mad Sabatons
				{ 12, 188272 }, -- Resonant Reservoir
				{ 14, 183510 }, -- Count the Odds
				{ 15, 181942 }, -- Focused Mending
				{ 16, 181504 }, -- Infernal Cascade
				{ 17, 181495 }, -- Jade Bond
				{ 18, 182677 }, -- Punish the Guilty
				{ 19, 182648 }, -- Sharpshooter's Focus
				{ 20, 182471 }, -- Soul Furnace
				{ 21, 182751 }, -- Tyrant's Soul
				{ 22, 182134 }, -- Unruly Winds
				{ 23, 181776 }, -- Vicious Contempt
				{ 24, 181866 }, -- Withering Plague
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Prototype Pantheon
			EncounterJournalID = 2460,
			[NORMAL_RAID_DIFF] = {
				{ 1,   189799 }, -- Elysia's Promise
				{ 2,   189800 }, -- Prelude to Pride
				{ 3,   189789 }, -- Pursuit of Victory
				{ 4,   189783 }, -- Sin-Steeped Coronet
				{ 5,   189796 }, -- Duty's Ascendant Breastplate
				{ 6,   189797 }, -- Wristwraps of Night's Renewal
				{ 7,   189794 }, -- Boots of Ceaseless Conflict
				{ 8,   189798 }, -- Moccasins of Dreadful Absolution
				{ 9,   189795 }, -- Winter's Stampeding Striders
				{ 10,  188270 }, -- Elegy of the Eternals
				{ 11,  188271 }, -- The First Sigil
				{ 13,  181770 }, -- Bone Marrow Hops
				{ 14,  182706 }, -- Brooding Pool
				{ 15,  182292 }, -- Brutal Grasp
				{ 16,  182962 }, -- Catastrophic Origin
				{ 17,  183473 }, -- Conflux of Elements
				{ 18,  181974 }, -- Courageous Ascension
				{ 19,  183471 }, -- Deep Allegiance
				{ 20,  182651 }, -- Destructive Reverberations
				{ 21,  181539 }, -- Discipline of the Grove
				{ 22,  182345 }, -- Elysian Dirge
				{ 23,  182331 }, -- Empowered Release
				{ 24,  183474 }, -- Endless Thirst
				{ 25,  182321 }, -- Enfeebled Mark
				{ 26,  182347 }, -- Essential Extraction
				{ 27,  183472 }, -- Evolved Swarm
				{ 28,  182129 }, -- Fae Fermata
				{ 29,  182961 }, -- Fatal Decimation
				{ 30,  181981 }, -- Festering Transfusion
				{ 101, 181553 }, -- Gift of the Lich
				{ 102, 182777 }, -- Hallowed Discernment
				{ 103, 182463 }, -- Harrowing Punishment
				{ 104, 181774 }, -- Imbued Reflections
				{ 105, 182288 }, -- Impenetrable Gloom
				{ 106, 182685 }, -- Increased Scrutiny
				{ 107, 181600 }, -- Ire of the Ascended
				{ 108, 183495 }, -- Lashing Scars
				{ 109, 182348 }, -- Lavish Harvest
				{ 110, 182339 }, -- Necrotic Barrage
				{ 111, 182440 }, -- Piercing Verdict
				{ 112, 182295 }, -- Proliferation
				{ 113, 182646 }, -- Repeat Decree
				{ 114, 183492 }, -- Reverberation
				{ 115, 182770 }, -- Righteous Might
				{ 116, 182778 }, -- Ringing Clarity
				{ 117, 183494 }, -- Septic Shock
				{ 118, 182130 }, -- Shattered Perceptions
				{ 119, 181639 }, -- Siphoned Malice
				{ 120, 182964 }, -- Soul Eater
				{ 121, 182960 }, -- Soul Tithe
				{ 122, 182335 }, -- Spirit Attunement
				{ 123, 181759 }, -- Strike with Clarity
				{ 124, 183493 }, -- Sudden Fractures
				{ 125, 182767 }, -- The Long Summer
				{ 126, 182346 }, -- Tumbling Waves
				{ 127, 183463 }, -- Unnatural Malice
				{ 128, 182442 }, -- Veteran's Repute
				{ 129, 181775 }, -- Way of the Fae
				{ 130, 183199 }, -- Withering Ground
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Lihuvim, Principal Architect
			EncounterJournalID = 2461,
			[NORMAL_RAID_DIFF] = {
				{ 1,  189754 }, -- Genesis Lathe
				{ 2,  189808 }, -- Lihuvim's Severing Scalpel
				{ 3,  189801 }, -- Ephemera-Charged Thinking Cap
				{ 4,  189805 }, -- Bracers of the Inscrutable Inventor
				{ 5,  189804 }, -- Combustible Collaboration Girdle
				{ 6,  189803 }, -- Automa-Tender's Tights
				{ 7,  189802 }, -- Loquacious Keeper's Peridot
				{ 8,  188268 }, -- Architect's Ingenuity Core
				{ 9,  188269 }, -- Pocket Protoforge
				{ 10, 191014 }, -- Dreadful Hand Module
				{ 11, 191015 }, -- Mystic Hand Module
				{ 12, 191016 }, -- Venerated Hand Module
				{ 13, 191017 }, -- Zenith Hand Module
				{ 16, 182755 }, -- Ashen Remains
				{ 17, 181435 }, -- Calculated Strikes
				{ 18, 182140 }, -- Dissonant Echoes
				{ 19, 181982 }, -- Everfrost
				{ 20, 181455 }, -- Icy Propulsion
				{ 21, 183512 }, -- Planned Execution
				{ 22, 182624 }, -- Show of Force
				{ 23, 183482 }, -- Sudden Ambush
				{ 24, 182143 }, -- Swirling Currents
				{ 25, 182608 }, -- Virtuous Command
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Halondrus the Reclaimer
			EncounterJournalID = 2463,
			[NORMAL_RAID_DIFF] = {
				{ 1,  189834 }, -- Guardstaff of the Great Cycle
				{ 2,  189806 }, -- Lightshatter Hatchet
				{ 3,  189781 }, -- Obscured Fractal Prism
				{ 4,  189831 }, -- Ephemera-Stained Sollerets
				{ 5,  189832 }, -- Greatboots of the Roaming Goliath
				{ 6,  189833 }, -- Taciturn Keeper's Lapis
				{ 7,  188264 }, -- Earthbreaker's Impact
				{ 8,  188263 }, -- Reclaimer's Intensity Core
				{ 9,  191018 }, -- Dreadful Leg Module
				{ 10, 191019 }, -- Mystic Leg Module
				{ 11, 191020 }, -- Venerated Leg Module
				{ 12, 191021 }, -- Zenith Leg Module
				{ 14, 182748 }, -- Borne of Blood
				{ 15, 181712 }, -- Depths of Insanity
				{ 16, 183478 }, -- Fury of the Skies
				{ 17, 182137 }, -- Magma Fist
				{ 18, 182187 }, -- Meat Shield
				{ 19, 181511 }, -- Nether Precision
				{ 20, 182621 }, -- One With the Beast
				{ 21, 182325 }, -- Ravenous Consumption
				{ 22, 181944 }, -- Resonant Words
				{ 23, 181700 }, -- Scalding Brew
				{ 24, 183507 }, -- Triple Threat
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Anduin Wrynn
			EncounterJournalID = 2469,
			[NORMAL_RAID_DIFF] = {
				{ 1,  189838 }, -- Beacon of Stormwind
				{ 2,  189835 }, -- Anduin's Princely Vestments
				{ 3,  189836 }, -- Wrists of the Wicked Star
				{ 4,  189837 }, -- King's Wolfheart Waistband
				{ 5,  189840 }, -- Remnant's Blasphemous Scourgebelt
				{ 6,  189841 }, -- Soulwarped Seal of Menethil
				{ 7,  189839 }, -- Soulwarped Seal of Wrynn
				{ 8,  188262 }, -- The Lion's Roar
				{ 9,  191005 }, -- Dreadful Helm Module
				{ 10, 191002 }, -- Mystic Helm Module
				{ 11, 191003 }, -- Venerated Helm Module
				{ 12, 191004 }, -- Zenith Helm Module
				{ 14, 181848 }, -- Accelerated Cold
				{ 15, 182769 }, -- Combusting Engine
				{ 16, 183197 }, -- Controlled Destruction
				{ 17, 182142 }, -- Embrace of Earth
				{ 18, 180932 }, -- Fueled by Violence
				{ 19, 181737 }, -- Nourishing Chi
				{ 20, 183514 }, -- Perforated Veins
				{ 21, 182686 }, -- Powerful Precision
				{ 22, 183480 }, -- Taste for Blood
				{ 23, 182681 }, -- Vengeful Shock
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Lords of Dread
			EncounterJournalID = 2457,
			[NORMAL_RAID_DIFF] = {
				{ 1,  189846 }, -- Alandien's Tortured Twinblades
				{ 2,  189845 }, -- Ruined Crest of Lordaeron
				{ 3,  189847 }, -- Shroud of the Sire's Chosen
				{ 4,  189842 }, -- Cuffs of the Covert Commander
				{ 5,  189844 }, -- Gauntlets of Unseen Guests
				{ 6,  189843 }, -- Grasps of Abducted Fate
				{ 7,  188255 }, -- Heart of the Swarm
				{ 8,  188261 }, -- Intrusive Thoughtcage
				{ 9,  191006 }, -- Dreadful Shoulder Module
				{ 10, 191007 }, -- Mystic Shoulder Module
				{ 11, 191008 }, -- Venerated Shoulder Module
				{ 12, 191009 }, -- Zenith Shoulder Module
				{ 14, 181462 }, -- Coordinated Offensive
				{ 15, 182598 }, -- Demon Muzzle
				{ 16, 181786 }, -- Eternal Hunger
				{ 17, 181461 }, -- Ice Bite
				{ 18, 181962 }, -- Mental Recovery
				{ 19, 183485 }, -- Savage Combatant
				{ 20, 183184 }, -- Stinging Strike
				{ 21, 182109 }, -- Totemic Surge
				{ 22, 182465 }, -- Truth's Wake
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Rygelon
			EncounterJournalID = 2467,
			[NORMAL_RAID_DIFF] = {
				{ 1,  189852 }, -- Antumbra, Shadow of the Cosmos
				{ 2,  189851 }, -- Devastated Worldshard
				{ 3,  191001 }, -- Observer's Umbral Shiv
				{ 4,  189853 }, -- Astral Verdict
				{ 5,  189849 }, -- Interdimensional Manica
				{ 6,  189850 }, -- Handguards of Hidden Realms
				{ 7,  189848 }, -- Treads of Titanic Curiosity
				{ 8,  189854 }, -- Rygelon's Heraldric Ring
				{ 9,  188254 }, -- Grim Eclipse
				{ 10, 191010 }, -- Dreadful Chest Module
				{ 11, 191011 }, -- Mystic Chest Module
				{ 12, 191012 }, -- Venerated Chest Module
				{ 13, 191013 }, -- Zenith Chest Module
				{ 16, 183468 }, -- Born Anew
				{ 17, 180943 }, -- Cacophonous Roar
				{ 18, 182461 }, -- Echoing Blessings
				{ 19, 181498 }, -- Grounding Surge
				{ 20, 183497 }, -- Recuperator
				{ 21, 182368 }, -- Relentless Onslaught
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- The Jailer
			EncounterJournalID = 2464,
			[NORMAL_RAID_DIFF] = {
				{ 1,  189862 }, -- Gavel of the First Arbiter
				{ 2,  189861 }, -- Zovastrum, the Unmaking
				{ 3,  189818 }, -- Domination's Deliverance
				{ 4,  189860 }, -- Forbidden Truth
				{ 5,  189859 }, -- Worldkiller Iris
				{ 6,  189855 }, -- Bindings of the Banished One
				{ 7,  189856 }, -- Runecarver's Twisted Ward
				{ 8,  189857 }, -- Epochal Oppressor's Greaves
				{ 9,  189858 }, -- Legguards of the Ultimate Threat
				{ 10, 188252 }, -- Chains of Domination
				{ 11, 188253 }, -- Scars of Fraternal Strife
				{ 13, 181975 }, -- Hardened Bones
				{ 14, 182131 }, -- Haunting Apparitions
				{ 15, 181510 }, -- Lingering Numbness
				{ 16, 183491 }, -- Ready for Anything
				{ 17, 182449 }, -- Resolute Barrier
				{ 18, 182480 }, -- Reversal of Fortune
				{ 19, 182318 }, -- Viscous Ink
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 21, 190768, "mount" }, -- Fractal Cypher of the Zereth Overseer
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
	}
}
