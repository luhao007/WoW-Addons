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
				{ 1,  183504 }, -- Well-Placed Steel
				{ 2,  182621 }, -- One With the Beast
				{ 3,  179325 }, -- Hakkari Revenant's Grips
				{ 4,  181737 }, -- Nourishing Chi
				{ 5,  182134 }, -- Unruly Winds
				{ 6,  179331 }, -- Blood-Spattered Scale
				{ 7,  182307 }, -- Shielding Words
				{ 8,  183479 }, -- Umbral Intensity
				{ 9,  179322 }, -- Windscale Moccasins
				{ 10, 179324 }, -- Soulfeather Breeches
				{ 11, 179326 }, -- Girdle of the Soulflayer
				{ 12, 179328 }, -- Bloodspiller
				{ 13, 179330 }, -- Zin'khas, Blade of the Fallen God
				{ 14, 181834 }, -- Chilled Resilience
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
				{ 1,  183369 }, -- Memory of Wilfred's Sigil of Superior Summoning
				{ 2,  180896 }, -- Safeguard
				{ 3,  179338 }, -- Dynamo Doomstompers
				{ 4,  179340 }, -- Supercollider
				{ 5,  179342 }, -- Overwhelming Power Crystal
				{ 6,  183216 }, -- Memory of a Burning Wound
				{ 7,  181509 }, -- Arcane Prodigy
				{ 8,  179335 }, -- Manastorm's Magnificent Threads
				{ 9,  179337 }, -- Techno-Coil Legguards
				{ 10, 179339 }, -- Whizblast Walking Stick
				{ 11, 183271 }, -- Memory of the Infinite Arcane
				{ 12, 182748 }, -- Borne of Blood
				{ 13, 179336 }, -- Rocket Chicken Handlers
				{ 14, 181842 }, -- Power Unto Others

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
				{ 2,  179349 }, -- Dealer Xy'exa's Cape
				{ 3,  182624 }, -- Show of Force
				{ 4,  179344 }, -- Far Traveler's Shoulderpads
				{ 5,  183396 }, -- Flame Infusion
				{ 6,  179348 }, -- Xy Cartel Crossbow
				{ 7,  183265 }, -- Memory of a Wildfire Cluster
				{ 8,  183464 }, -- Tough as Bark
				{ 9,  183509 }, -- Sleight of Hand
				{ 10, 179346 }, -- Breastplate of Fatal Contrivances
				{ 11, 179343 }, -- Sash of Exquisite Acquisitions
				{ 12, 179345 }, -- Spatial Rift Striders
				{ 13, 179350 }, -- Inscrutable Quantum Device
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
				{ 1,  182344 }, -- Lost in Darkness
				{ 2,  183282 }, -- Memory of the Fatal Touch
				{ 3,  179353 }, -- Harness of Twisted Whims
				{ 4,  182736 }, -- Rolling Agony
				{ 5,  183329 }, -- Memory of a Prism of Shadow and Fire
				{ 6,  179354 }, -- Reality-Shatter Vambraces
				{ 7,  181943 }, -- Eradicating Blow
				{ 8,  183350 }, -- Memory of the Great Sundering
				{ 9,  179355 }, -- Death God's Signet
				{ 10, 181467 }, -- Flow of Time
				{ 11, 182684 }, -- Resolute Defender
				{ 12, 183490 }, -- Floral Recycling
				{ 13, 181376 }, -- Inner Fury
				{ 14, 182138 }, -- Mind Devourer
				{ 15, 179352 }, -- Primeval Soul's Ankleguards
				{ 16, 179356 }, -- Shadowgrasp Totem
				{ 17, 179351 }, -- Mueh'zala's Hexthread Sarong
				{ 18, 182145 }, -- Heavy Rainfall
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
				{ 1,  181736 }, -- Flame Accretion
				{ 2,  178813 }, -- Sinlight Shroud
				{ 3,  178830 }, -- Shardskin Sabatons
				{ 4,  178817 }, -- Hood of Refracted Shadows
				{ 5,  182629 }, -- Memory of the Crimson Runes
				{ 6,  182681 }, -- Vengeful Shock
				{ 7,  178827 }, -- Sin Stained Pendant
				{ 8,  183380 }, -- Memory of a Seismic Reverberation
				{ 9,  181848 }, -- Accelerated Cold
				{ 10, 178818 }, -- Halkias's Towering Pillars
				{ 11, 181640 }, -- Tumbling Technique
				{ 12, 181845 }, -- Exaltation
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Echelon
			EncounterJournalID = 2387,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  183487 }, -- Layered Mane
				{ 2,  178815 }, -- Soaring Decimator's Hauberk
				{ 3,  181735 }, -- Hack and Slash
				{ 4,  178834 }, -- Stoneguardian's Morningstar
				{ 5,  183184 }, -- Stinging Strike
				{ 6,  178825 }, -- Pulsating Stoneheart
				{ 7,  182470 }, -- Demonic Momentum
				{ 8,  182127 }, -- Shake the Foundations
				{ 9,  178812 }, -- Wing Commander's Helmet
				{ 10, 183511 }, -- Deeper Daggers
				{ 11, 178833 }, -- Stonefiend Shaper's Mitts
				{ 12, 178819 }, -- Skyterror's Stonehide Leggings
				{ 13, 183349 }, -- Memory of the Deeptremor Stone
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
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
				{ 6,  181963 }, -- Blood Bond
				{ 7,  178814 }, -- Breastplate of Otherworldly Influence
				{ 8,  182675 }, -- Untempered Dedication
				{ 9,  183306 }, -- Memory of the Righteous Bulwark
				{ 10, 181505 }, -- Resplendent Mist
				{ 11, 181867 }, -- Swift Penitence
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12550" }, -- AC: Mythic: Freehold "Pecking Order"
			},
		},
		{ -- Lord Chamberlain
			EncounterJournalID = 2413,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  182685 }, -- Increased Scrutiny
				{ 2,  183495 }, -- Lashing Scars
				{ 3,  181639 }, -- Siphoned Malice
				{ 4,  181461 }, -- Ice Bite
				{ 5,  183275 }, -- Memory of the Firestorm
				{ 6,  182348 }, -- Lavish Harvest
				{ 7,  183500 }, -- Fade to Nothing
				{ 8,  178823 }, -- Waistcord of Dark Devotion
				{ 9,  183477 }, -- Precise Alignment
				{ 10, 178831 }, -- Slippers of Leavened Station
				{ 11, 182288 }, -- Impenetrable Gloom
				{ 12, 183241 }, -- Memory of the Dark Titan
				{ 13, 183076 }, -- Diabolic Bloodstone
				{ 14, 182598 }, -- Demon Muzzle
				{ 15, 178820 }, -- Pauldrons of Unleashed Pride
				{ 16, 178824 }, -- Signet of the False Accuser
				{ 17, 182331 }, -- Empowered Release
				{ 18, 181774 }, -- Imbued Reflections
				{ 19, 182463 }, -- Harrowing Punishment
				{ 20, 182777 }, -- Hallowed Discernment
				{ 21, 181944 }, -- Resonant Words
				{ 22, 182962 }, -- Catastrophic Origin
				{ 23, 182130 }, -- Shattered Perceptions
				{ 24, 182751 }, -- Tyrant's Soul
				{ 25, 178829 }, -- Nathrian Ferula
				{ 26, 183474 }, -- Endless Thirst
				{ 27, 178816 }, -- Nathrian Usurper's Mask
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
				{ 1,  183491 }, -- Ready for Anything
				{ 2,  178704 }, -- Deathshackle Wristwraps
				{ 3,  181466 }, -- Grounding Breath
				{ 4,  178708 }, -- Unbound Changeling
				{ 5,  182143 }, -- Swirling Currents
				{ 6,  182582 }, -- Enkindled Spirit
				{ 7,  178713 }, -- Drustlord's Greataxe
				{ 8,  182686 }, -- Powerful Precision
				{ 9,  181844 }, -- Pain Transformation
				{ 10, 178709 }, -- Scithewood Scepter
				{ 11, 178692 }, -- Soulthorn Visage
				{ 12, 178694 }, -- Wrathbark Greathelm
				{ 13, 178696 }, -- Ingra Maloch's Mantle
				{ 14, 178698 }, -- Rainshadow Hauberk
				{ 15, 178700 }, -- Clasp of Waning Shadow
				{ 16, 183253 }, -- Memory of the Soulforge Embers
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
				{ 1,  181462 }, -- Coordinated Offensive
				{ 2,  181734 }, -- Magi's Brand
				{ 3,  183266 }, -- Memory of the Disciplinary Command
				{ 4,  182754 }, -- Duplicitous Havoc
				{ 5,  178710 }, -- Tanglewood Thorn
				{ 6,  178697 }, -- Prankster's Pauldrons
				{ 7,  183514 }, -- Perforated Veins
				{ 8,  183336 }, -- Memory of the Duskwalker's Patch
				{ 9,  182305 }, -- Crown of Autumnal Flora
				{ 10, 178705 }, -- Tricksprite Gloves
				{ 11, 178707 }, -- Trailspinner Pendant
				{ 12, 178706 }, -- Fogweaver Gauntlets
				{ 13, 178695 }, -- Wintersnap Shoulderguards
				{ 14, 182448 }, -- Light's Barding
				{ 15, 178715 }, -- Mistcaller Ocarina
				{ 16, 178691 }, -- Hood of the Hidden Path
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
				{ 1,  182964 }, -- Soul Eater
				{ 2,  178702 }, -- Bands of the Undergrowth
				{ 3,  182767 }, -- The Long Summer
				{ 4,  178714 }, -- Lakali's Spire of Knowledge
				{ 5,  181539 }, -- Discipline of the Grove
				{ 6,  182206 }, -- Convocation of the Dead
				{ 7,  182384 }, -- Serrated Glaive
				{ 8,  183132 }, -- Echoing Call
				{ 9,  180935 }, -- Crash the Ramparts
				{ 10, 183473 }, -- Conflux of Elements
				{ 11, 178711 }, -- Axe of the Deadgrove
				{ 12, 183229 }, -- Memory of a Timeworn Dreambinder
				{ 13, 182129 }, -- Fae Fermata
				{ 14, 182142 }, -- Embrace of Earth
				{ 15, 182347 }, -- Essential Extraction
				{ 16, 181775 }, -- Way of the Fae
				{ 17, 183199 }, -- Withering Ground
				{ 18, 182335 }, -- Spirit Attunement
				{ 19, 178712 }, -- Acidslough Bulwark
				{ 20, 183494 }, -- Septic Shock
				{ 21, 183463 }, -- Unnatural Malice
				{ 22, 178693 }, -- Cocoonsilk Cowl
				{ 23, 182651 }, -- Destructive Reverberations
				{ 24, 178701 }, -- Gormshell Greaves
				{ 25, 183485 }, -- Savage Combatant
				{ 26, 178699 }, -- Sapgorger Belt
				{ 27, 178703 }, -- Hiveswarm Bracers
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 28, 183623 }, -- Spinemaw Gormling
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
				{ 1,  178762 }, -- Blightborne Chain Legguards
				{ 2,  183506 }, -- Lethal Poisons
				{ 3,  178753 }, -- Surgical Pustule Extractor
				{ 4,  178770 }, -- Slimy Consumptive Organ
				{ 5,  183486 }, -- Well-Honed Instincts
				{ 6,  182465 }, -- Truth's Wake
				{ 7,  181786 }, -- Eternal Hunger
				{ 8,  178773 }, -- Plague Handler's Greathelm
				{ 9,  178760 }, -- Digested Interrogator's Gaze
				{ 10, 178756 }, -- Stradama's Misplaced Slippers
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
				{ 1,  182752 }, -- Fel Commando
				{ 2,  182126 }, -- High Voltage
				{ 3,  181455 }, -- Icy Propulsion
				{ 4,  178759 }, -- Depraved Physician's Mask
				{ 5,  181495 }, -- Jade Bond
				{ 6,  178763 }, -- Malodorous Gristle-Sown Spaulders
				{ 7,  182140 }, -- Dissonant Echoes
				{ 8,  178752 }, -- Sophisticated Bonecracker
				{ 9,  183496 }, -- Nimble Fingers
				{ 10, 178771 }, -- Phial of Putrefaction
				{ 11, 180933 }, -- Ashen Juggernaut
				{ 12, 178775 }, -- Fleshfused Crushers
				{ 13, 178767 }, -- Tortured Assistant's Bindings
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
				{ 2,  178931 }, -- Scarred Bloodbound Girdle
				{ 3,  182368 }, -- Relentless Onslaught
				{ 4,  183345 }, -- Memory of the Rotten
				{ 5,  183167 }, -- Strength of the Pack
				{ 6,  178928 }, -- Domina's Oozing Shiv
				{ 7,  178930 }, -- Mitts of Flawless Duplication
				{ 8,  178932 }, -- Belt of Wretched Manipulations
				{ 9,  178934 }, -- Fastened Venombarb Binds
				{ 10, 182108 }, -- Thunderous Paws
				{ 11, 182208 }, -- Lingering Plague
				{ 12, 183260 }, -- Memory of the Serpentstalker's Trickery
				{ 13, 178933 }, -- Arachnid Cipher Ring
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
				{ 1,  183212 }, -- Memory of a Darkglare Medallion
				{ 2,  182139 }, -- Rabid Shadows
				{ 3,  178764 }, -- Plagueborne Shoulderguards
				{ 4,  182961 }, -- Fatal Decimation
				{ 5,  182442 }, -- Veteran's Repute
				{ 6,  181981 }, -- Festering Transfusion
				{ 7,  178761 }, -- Leggings of the Erudite Scholar
				{ 8,  183319 }, -- Memory of my Crystalline Reflection
				{ 9,  182706 }, -- Brooding Pool
				{ 10, 178757 }, -- Gloves of Obscure Rituals
				{ 11, 181504 }, -- Infernal Cascade
				{ 12, 183493 }, -- Sudden Fractures
				{ 13, 178754 }, -- Poxstorm, Longsword of Pestilence
				{ 14, 182292 }, -- Brutal Grasp
				{ 15, 182637 }, -- Memory of Death's Certainty
				{ 16, 183478 }, -- Fury of the Skies
				{ 17, 181553 }, -- Gift of the Lich
				{ 18, 178774 }, -- Muckwallow Stompers
				{ 19, 182339 }, -- Necrotic Barrage
				{ 20, 182346 }, -- Tumbling Waves
				{ 21, 178755 }, -- Blighted Margrave's Cloak
				{ 22, 182747 }, -- Withering Bolt
				{ 23, 181770 }, -- Bone Marrow Hops
				{ 24, 183472 }, -- Evolved Swarm
				{ 25, 182770 }, -- Righteous Might
				{ 26, 178769 }, -- Infinitely Divisible Ooze
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 27, 181271 }, -- Sludge Feeler
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
				{ 1,  183202 }, -- Deadly Tandem
				{ 2,  178854 }, -- Hungering Devourer's Twinblade
				{ 3,  183480 }, -- Taste for Blood
				{ 4,  181740 }, -- Evasive Stride
				{ 5,  183234 }, -- Memory of a Luffa-Infused Embrace
				{ 6,  182133 }, -- Insatiable Appetite
				{ 7,  181776 }, -- Vicious Contempt
				{ 8,  178853 }, -- Voracious Gorger Spine
				{ 9,  181769 }, -- Tempest Barrier
				{ 10, 183297 }, -- Memory of Xuen
				{ 11, 178844 }, -- Essence Surge Binders
				{ 12, 178846 }, -- Shackles of Alluring Vitality
				{ 13, 178848 }, -- Entwined Gorger Tendril
				{ 14, 178835 }, -- Anima-Splattered Hide
				{ 15, 178836 }, -- Sabatons of the Rushing Juggernaut
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
				{ 1,  181942 }, -- Focused Mending
				{ 2,  182604 }, -- Roaring Fire
				{ 3,  182203 }, -- Debilitating Malady
				{ 4,  178845 }, -- Vambraces of the Depraved Warden
				{ 5,  183499 }, -- Quick Decisions
				{ 6,  178851 }, -- Cloak of Enveloping Manifestations
				{ 7,  182755 }, -- Ashen Remains
				{ 8,  178855 }, -- Sinsmasher
				{ 9,  178859 }, -- Castigator's Mantle
				{ 10, 182464 }, -- Harmony of the Tortollan
				{ 11, 178843 }, -- Executor's Prideful Girdle
				{ 12, 178837 }, -- Sinsoaked Waders
				{ 13, 178849 }, -- Overflowing Anima Cage
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
				{ 2,  183489 }, -- Flash of Clarity
				{ 3,  178841 }, -- Iron Spiked Handgrips
				{ 4,  182608 }, -- Virtuous Command
				{ 5,  181847 }, -- Lasting Spirit
				{ 6,  182137 }, -- Magma Fist
				{ 7,  181506 }, -- Master Flame
				{ 8,  183323 }, -- Memory of Flash Concentration
				{ 9,  178838 }, -- Beryllia's Leggings of Endless Torment
				{ 10, 178842 }, -- Waistguard of Expurged Anguish
				{ 11, 182324 }, -- Felfire Haste
				{ 12, 178847 }, -- Radiant Light Binders
				{ 13, 183303 }, -- Memory of Maraad's Dying Breath
				{ 14, 178850 }, -- Lingering Sunmote
				{ 15, 180847 }, -- Inspiring Presence
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, 180591 }, -- Vial of Roiling Emotions
			},
		},
		{ -- General Kaal
			EncounterJournalID = 2407,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  182677 }, -- Punish the Guilty
				{ 2,  178839 }, -- Wind Dancer's Legguards
				{ 3,  178856 }, -- Kaal's Gloomblade
				{ 4,  183358 }, -- Memory of an Earthen Harmony
				{ 5,  178860 }, -- Cowl of the Devoted General
				{ 6,  181742 }, -- Walk with the Ox
				{ 7,  183289 }, -- Memory of Stormstout
				{ 8,  187506 }, -- Condensed Anima Sphere
				{ 9,  182125 }, -- Pyroclastic Shock
				{ 10, 183507 }, -- Triple Threat
				{ 11, 178857 }, -- Stone General's Edge
				{ 12, 178861 }, -- Decanter of Anima-Charged Winds
				{ 13, 178858 }, -- Wicked Bladewing Pauldrons
				{ 14, 178840 }, -- Guilewind Stone Talons
				{ 15, 178862 }, -- Bladedancer's Armor Kit
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
				{ 1,  182317 }, -- Shattered Restoration
				{ 2,  180101 }, -- Warboots of Ruthless Conviction
				{ 3,  182113 }, -- Fleeting Wind
				{ 4,  182610 }, -- Ferocious Appetite
				{ 5,  180109 }, -- Kin-Tara's Baleful Cord
				{ 6,  183231 }, -- Memory of a Cat-Eye Curio
				{ 7,  182468 }, -- Mortal Combo
				{ 8,  180115 }, -- Azure-Venom Choker
				{ 9,  183513 }, -- Stiletto Staccato
				{ 10, 182144 }, -- Nature's Focus
				{ 11, 180097 }, -- Quarterstaff of Discordant Ethic
				{ 12, 183483 }, -- Carnivorous Instinct
				{ 13, 180100 }, -- Forsworn Stalker's Hauberk
				{ 14, 180103 }, -- Winged Hunters' Gloves
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
				{ 1,  181389 }, -- Shivering Core
				{ 2,  180116 }, -- Overcharged Anima Battery
				{ 3,  183508 }, -- Ambidexterity
				{ 4,  182462 }, -- Expurgation
				{ 5,  180095 }, -- Penitent Edge
				{ 6,  180111 }, -- Shadowhirl Waistwrap
				{ 7,  183338 }, -- Memory of Celerity
				{ 8,  181435 }, -- Calculated Strikes
				{ 9,  180102 }, -- Dark Stride Footwraps
				{ 10, 180104 }, -- Distorted Construct's Gauntlets
				{ 11, 183365 }, -- Memory of the Consuming Wrath
				{ 12, 182478 }, -- Corrupting Leer
				{ 13, 180110 }, -- Dark Praetorian's Clasp
				{ 14, 181827 }, -- Move with Grace
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
				{ 1,  187507 }, -- Adaptive Armor Fragment
				{ 2,  180112 }, -- The Philosopher
				{ 3,  182471 }, -- Soul Furnace
				{ 4,  180118 }, -- Anima Field Emitter
				{ 5,  180105 }, -- Absonant Construct's Handguards
				{ 6,  183392 }, -- Memory of the Thunderlord
				{ 7,  183469 }, -- Front of the Pack
				{ 8,  180106 }, -- Vicious Surge Faceguard
				{ 9,  182753 }, -- Royal Decree
				{ 10, 180113 }, -- Thunderous Echo Vambraces
				{ 11, 180117 }, -- Empyreal Ordnance
				{ 12, 180944 }, -- Merciless Bonegrinder
				{ 13, 182476 }, -- Resilience of the Hunter
				{ 14, 182187 }, -- Meat Shield
				{ 15, 180107 }, -- Purge Protocol Legwraps
				{ 16, 183313 }, -- Memory of the Lightbringer's Tempest
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
				{ 1,  182340 }, -- Fel Celerity
				{ 2,  182135 }, -- Focused Lightning
				{ 3,  183290 }, -- Memory of Ancient Teachings
				{ 4,  181465 }, -- Xuen's Bond
				{ 5,  183488 }, -- Unstoppable Growth
				{ 6,  181698 }, -- Cryo-Freeze
				{ 7,  182667 }, -- Focused Light
				{ 8,  180098 }, -- Sinister Requiem Vestments
				{ 9,  180114 }, -- Fallen Paragon's Armguards
				{ 10, 183257 }, -- Memory of the Rylakstalker's Fangs
				{ 11, 183354 }, -- Memory of the Doom Winds
				{ 12, 182649 }, -- Brutal Projectiles
				{ 13, 180119 }, -- Boon of the Archon
				{ 14, 180123 }, -- Drape of Twisted Loyalties
				{ 15, 180096 }, -- Devos's Cacophonous Poleaxe
				{ 16, 180099 }, -- Breastplate of Brutal Dissonance
				{ 17, 182141 }, -- Holy Oration
				{ 18, 180108 }, -- Abyssal Disharmony Breeches
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
				{ 1,  181841 }, -- Reinforced Shell
				{ 2,  182338 }, -- Pure Concentration
				{ 3,  182110 }, -- Crippling Hex
				{ 4,  185824 }, -- Blade of Grievous Harm
				{ 5,  185780 }, -- Interrogator's Flensing Blade
				{ 6,  185793 }, -- Cyphered Gloves
				{ 7,  185815 }, -- Vambraces of Verification
				{ 8,  181962 }, -- Mental Recovery
				{ 9,  185816 }, -- Confiscated Bracers of Concealment
				{ 10, 185791 }, -- Knuckle-Dusting Handwraps
				{ 11, 183498 }, -- Cloaked in Shadows
				{ 12, 182330 }, -- Demonic Parole
				{ 13, 183468 }, -- Born Anew
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- The Grand Menagerie
			EncounterJournalID = 2454,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  185814 }, -- Auctioneer's Counting Bracers
				{ 2,  183044 }, -- Kilrogg's Cunning
				{ 3,  185792 }, -- Achillite's Unbreakable Grip
				{ 4,  185809 }, -- Venza's Powderbelt
				{ 5,  181836 }, -- Spirit Drain
				{ 6,  185777 }, -- Fang of Alcruux
				{ 7,  181512 }, -- Dizzying Tumble
				{ 8,  184587 }, -- Ambuscade
				{ 9,  181469 }, -- Indelible Victory
				{ 10, 185821 }, -- Gluttonous Rondel
				{ 11, 181756 }, -- Incantation of Swiftness
				{ 12, 185840 }, -- Seal of the Panoply
				{ 13, 185794 }, -- Gavel Pounders
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Mailroom Mayhem
			EncounterJournalID = 2436,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  181837 }, -- Clear Mind
				{ 2,  186534 }, -- Gizmo
				{ 3,  185846 }, -- Miniscule Mailemental in an Envelope
				{ 4,  182325 }, -- Ravenous Consumption
				{ 5,  190652 }, -- Ticking Sack of Terror
				{ 5,  182584 }, -- Cheetah's Vigor
				{ 6,  185811 }, -- Package Protector
				{ 7,  183497 }, -- Recuperator
				{ 8,  185845 }, -- First Class Healing Distributor
				{ 10, 185817 }, -- Bracers of Autonomous Classification
				{ 11, 185787 }, -- Implacable Weatherproof Treads
				{ 12, 182461 }, -- Echoing Blessings
				{ 13, 185808 }, -- Discount Mail-Order Belt
				{ 14, 185807 }, -- Pan-Dimensional Packing Cord
				{ 15, 183465 }, -- Ursine Vigor
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Myza's Oasis
			EncounterJournalID = 2452,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  185812 }, -- Acoustically Alluring Censer
				{ 2,  181464 }, -- Winter's Protection
				{ 3,  182460 }, -- Accrued Vitality
				{ 4,  185783 }, -- Yasahm the Riftbreaker
				{ 5,  182106 }, -- Refreshing Waters
				{ 6,  181508 }, -- Fortifying Ingredients
				{ 7,  182656 }, -- Disturb the Peace
				{ 8,  185802 }, -- Breakbeat Shoulderguards
				{ 9,  185789 }, -- Sabatons of Measured Time
				{ 10, 185806 }, -- Improvisational Cinch
				{ 11, 185842 }, -- Ornately Engraved Amplifier
				{ 12, 183470 }, -- Born of the Wilds
				{ 13, 185804 }, -- Harmonious Spaulders
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- So'azmi
			EncounterJournalID = 2451,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  185782 }, -- Robes of Midnight Bargains
				{ 2,  181826 }, -- Translucent Image
				{ 3,  182132 }, -- Unending Grip
				{ 4,  182449 }, -- Resolute Barrier
				{ 5,  182318 }, -- Viscous Ink
				{ 6,  185843 }, -- Duplicating Drape
				{ 7,  185800 }, -- Orbitwarp Culottes
				{ 8,  181707 }, -- Diverted Energy
				{ 9,  185786 }, -- So'azmi's Fractal Vest
				{ 10, 185836 }, -- Codex of the First Technique
				{ 11, 185778 }, -- First Fist of the So Cartel
				{ 12, 185798 }, -- Quantum Leapers
				{ 13, 182605 }, -- Tactical Retreat
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Hylbrande
			EncounterJournalID = 2448,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  182336 }, -- Golden Path
				{ 2,  180943 }, -- Cacophonous Roar
				{ 3,  185805 }, -- Hylbrande's Retrofitted Shoulderguards
				{ 4,  183467 }, -- Tireless Pursuit
				{ 5,  185779 }, -- Spire of Expurgation
				{ 6,  183501 }, -- Rushed Setup
				{ 7,  181373 }, -- Harm Denial
				{ 8,  185810 }, -- Skyreaver, Greataxe of the Keepers
				{ 9,  185788 }, -- Codebreaker's Cunning Sandals
				{ 10, 185803 }, -- Stoneflesh Spaulders
				{ 11, 185781 }, -- Drape of Titanic Dreams
				{ 12, 182105 }, -- Astral Protection
				{ 13, 185790 }, -- Treads of Titanic Deconversion
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Timecap'n Hooktail
			EncounterJournalID = 2449,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  183502 }, -- Prepared for All
				{ 2,  182469 }, -- Rejuvenating Wind
				{ 3,  181498 }, -- Grounding Surge
				{ 4,  185820 }, -- Cabochon of the Infinite Flight
				{ 5,  180842 }, -- Stalwart Guardian
				{ 6,  182466 }, -- Shade of Terror
				{ 7,  181975 }, -- Hardened Bones
				{ 8,  185797 }, -- Rakishly Tipped Tricorne
				{ 9,  185796 }, -- Dragonbane Diadem
				{ 10, 185776 }, -- Hooktail's Commanding Gaze
				{ 11, 185823 }, -- Fatebreaker, Destroyer of Futures
				{ 12, 185795 }, -- Cowl of Branching Fate
				{ 13, 185841 }, -- Timetwister Tulwar
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- So'leah
			EncounterJournalID = 2455,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  186638 }, -- Cartel Master's Gearglider
				{ 2,  185784 }, -- Novaburst Warplate
				{ 3,  185801 }, -- Anomalous Starlit Breeches
				{ 4,  182304 }, -- Divine Call
				{ 5,  182109 }, -- Totemic Surge
				{ 6,  185822 }, -- Staff of Fractured Spacetime
				{ 7,  181838 }, -- Charitable Soul
				{ 8,  182316 }, -- Fel Defender
				{ 9,  185813 }, -- Signet of Collapsing Stars
				{ 10, 181510 }, -- Lingering Numbness
				{ 11, 185785 }, -- Embrace of the Relicbinder
				{ 12, 185819 }, -- Event Horizon's Edge
				{ 13, 183466 }, -- Innate Resolve
				{ 14, 185799 }, -- Hyperlight Leggings
				{ 15, 182480 }, -- Reversal of Fortune
				{ 16, 190958 }, -- So'leah's Secret Technique
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
				{ 1,  178732 }, -- Abominable Visage
				{ 2,  178734 }, -- Fused Bone Greatbelt
				{ 3,  182111 }, -- Spiritual Resonance
				{ 4,  183482 }, -- Sudden Ambush
				{ 5,  181641 }, -- Rising Sun Revival
				{ 6,  178733 }, -- Blightbone Spaulders
				{ 7,  183505 }, -- Maim, Mangle
				{ 8,  181709 }, -- Unnerving Focus
				{ 9,  178736 }, -- Stitchflesh's Misplaced Signet
				{ 10, 178731 }, -- Viscera-Stitched Footpads
				{ 11, 178730 }, -- Engorged Worm Smasher
				{ 12, 178735 }, -- Blight Belcher
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
				{ 1,  178738 }, -- Rattling Deadeye Hood
				{ 2,  178740 }, -- Reanimator's Mantle
				{ 3,  181712 }, -- Depths of Insanity
				{ 4,  178742 }, -- Bottled Flayedwing Toxin
				{ 5,  182772 }, -- Infernal Brand
				{ 6,  178741 }, -- Risen Monstrosity Cuffs
				{ 7,  183387 }, -- Memory of the Deathmaker
				{ 8,  178739 }, -- Legplates of Unholy Frenzy
				{ 9,  183481 }, -- Incessant Hunter
				{ 10, 181982 }, -- Everfrost
				{ 11, 183402 }, -- Bloodletting
				{ 12, 178737 }, -- Amarth's Spellblade
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
				{ 1,  178749 }, -- Vile Butcher's Pauldrons
				{ 2,  178751 }, -- Spare Meat Hook
				{ 3,  183373 }, -- Memory of an Implosive Potential
				{ 4,  182385 }, -- Growing Inferno
				{ 5,  183512 }, -- Planned Execution
				{ 6,  178744 }, -- Freshly Embalmed Jerkin
				{ 7,  178748 }, -- Gory Surgeon's Gloves
				{ 8,  178750 }, -- Encrusted Canopic Lid
				{ 9,  178772 }, -- Satchel of Misbegotten Minions
				{ 10, 178745 }, -- Striders of Restless Malice
				{ 11, 181700 }, -- Scalding Brew
				{ 12, 178743 }, -- Stitchflesh's Scalpel
				{ 13, 182750 }, -- Carnivorous Stalkers
				{ 14, 181738 }, -- Artifice of the Archmage
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
				{ 1,  182960 }, -- Soul Tithe
				{ 2,  182778 }, -- Ringing Clarity
				{ 3,  183278 }, -- Memory of the Cold Front
				{ 4,  182321 }, -- Enfeebled Mark
				{ 5,  182201 }, -- Unleashed Frenzy
				{ 6,  182345 }, -- Elysian Dirge
				{ 7,  182136 }, -- Chilled to the Core
				{ 8,  182295 }, -- Proliferation
				{ 9,  181974 }, -- Courageous Ascension
				{ 10, 183492 }, -- Reverberation
				{ 11, 178777 }, -- Darkfrost Helmet
				{ 12, 178781 }, -- Ritual Commander's Ring
				{ 13, 181383 }, -- Unrelenting Cold
				{ 14, 182633 }, -- Memory of the Biting Cold
				{ 15, 178783 }, -- Siphoning Phylactery Shard
				{ 16, 178779 }, -- Undying Chill Shoulderpads
				{ 17, 178782 }, -- Necropolis Lord's Shackles
				{ 18, 181843 }, -- Shining Radiance
				{ 19, 178778 }, -- Lichbone Legguards
				{ 20, 182440 }, -- Piercing Verdict
				{ 21, 182622 }, -- Resplendent Light
				{ 22, 183471 }, -- Deep Allegiance
				{ 23, 181759 }, -- Strike with Clarity
				{ 24, 181600 }, -- Ire of the Ascended
				{ 25, 182646 }, -- Repeat Decree
				{ 26, 178780 }, -- Rimebinder's Runeblade
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 27, 181819 }, -- Marrowfang's Reins
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
				{ 1,  182107 }, -- Vital Accretion
				{ 2,  182441 }, -- Marksman's Advantage
				{ 3,  178800 }, -- Galvanized Oxxein Legguards
				{ 4,  183197 }, -- Controlled Destruction
				{ 5,  183484 }, -- Unchecked Aggression
				{ 6,  178866 }, -- Dessia's Decimating Decapitator
				{ 7,  183503 }, -- Poisoned Katar
				{ 8,  181705 }, -- Celestial Effervescence
				{ 9,  183332 }, -- Memory of the Master Assassin's Mark
				{ 10, 178799 }, -- Amphitheater Stalker's Hood
				{ 11, 178795 }, -- Vest of Concealed Secrets
				{ 12, 178803 }, -- Plague-Licked Amice
				{ 13, 178871 }, -- Bloodoath Signet
				{ 14, 178810 }, -- Vial of Spectral Essence
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
				{ 1, 178869 }, -- Fleshfused Circle
				{ 2, 178798 }, -- Grips of Overwhelming Beatings
				{ 3, 183510 }, -- Count the Odds
				{ 4, 180932 }, -- Fueled by Violence
				{ 5, 178806 }, -- Contaminated Gauze Wristwraps
				{ 6, 178808 }, -- Viscera of Coalesced Hatred
				{ 7, 181840 }, -- Light's Inspiration
				{ 8, 181866 }, -- Withering Plague
				{ 9, 178793 }, -- Abdominal Securing Chestguard
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
				{ 1,  178807 }, -- Pit Fighter's Wristguards
				{ 2,  182559 }, -- Templar's Vindication
				{ 3,  182383 }, -- Dancing with Fate
				{ 4,  183300 }, -- Memory of the Magistrate's Judgment
				{ 5,  182657 }, -- Deadly Chain
				{ 6,  178864 }, -- Gorebound Predator's Gavel
				{ 7,  183220 }, -- Memory of Razelikh's Defilement
				{ 8,  183385 }, -- Memory of the Unhinged
				{ 9,  178794 }, -- Triumphant Combatant's Chainmail
				{ 10, 178789 }, -- Fleshcrafter's Knife
				{ 11, 178801 }, -- Fearless Challenger's Leggings
				{ 12, 178863 }, -- Gorestained Cleaver
				{ 13, 178865 }, -- Xav's Pike of Authority
				{ 14, 180844 }, -- Brutal Vitality
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
				{ 1,  182617 }, -- Memory of Death's Embrace
				{ 2,  182769 }, -- Combusting Engine
				{ 3,  182456 }, -- Wrench Evil
				{ 4,  182128 }, -- Call of Flame
				{ 5,  181980 }, -- Embrace Death
				{ 6,  181624 }, -- Swift Transference
				{ 7,  178870 }, -- Ritual Bone Band
				{ 8,  178792 }, -- Soulsewn Vestments
				{ 9,  178796 }, -- Boots of Shuddering Matter
				{ 10, 183375 }, -- Memory of the Diabolic Raiment
				{ 11, 178805 }, -- Girdle of Shattered Dreams
				{ 12, 178809 }, -- Soulletting Ruby
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
				{ 2,  183476 }, -- Stellar Inspiration
				{ 3,  182743 }, -- Focused Malignancy
				{ 4,  183225 }, -- Memory of Lycara
				{ 5,  178802 }, -- Unyielding Combatant's Pauldrons
				{ 6,  178804 }, -- Fallen Empress's Cord
				{ 7,  182648 }, -- Sharpshooter's Focus
				{ 8,  181511 }, -- Nether Precision
				{ 9,  178797 }, -- Vanquished Usurper's Footpads
				{ 10, 183314 }, -- Memory of Cauterizing Shadows
				{ 11, 182131 }, -- Haunting Apparitions
				{ 12, 178868 }, -- Deathwalker's Promise
				{ 13, 178872 }, -- Ring of Perpetual Conflict
				{ 14, 178811 }, -- Grim Codex
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
				{ 1,   183472 }, -- Evolved Swarm
				{ 2,   182346 }, -- Tumbling Waves
				{ 3,   182685 }, -- Increased Scrutiny
				{ 4,   182646 }, -- Repeat Decree
				{ 5,   182339 }, -- Necrotic Barrage
				{ 6,   182347 }, -- Essential Extraction
				{ 7,   182292 }, -- Brutal Grasp
				{ 8,   182442 }, -- Veteran's Repute
				{ 9,   182962 }, -- Catastrophic Origin
				{ 10,  183474 }, -- Endless Thirst
				{ 11,  182348 }, -- Lavish Harvest
				{ 12,  181600 }, -- Ire of the Ascended
				{ 13,  184136 }, -- Anima-Charged Wristbanding
				{ 14,  181553 }, -- Gift of the Lich
				{ 15,  183199 }, -- Withering Ground
				{ 16,  183473 }, -- Conflux of Elements
				{ 17,  182961 }, -- Fatal Decimation
				{ 18,  181774 }, -- Imbued Reflections
				{ 19,  184141 }, -- Shroud of the Penitent
				{ 20,  181759 }, -- Strike with Clarity
				{ 21,  184125 }, -- Servo-Chain Waistguard
				{ 22,  183325 }, -- Memory of Archbishop Benedictus
				{ 23,  182129 }, -- Fae Fermata
				{ 24,  182767 }, -- The Long Summer
				{ 25,  182964 }, -- Soul Eater
				{ 26,  181775 }, -- Way of the Fae
				{ 27,  182345 }, -- Elysian Dirge
				{ 28,  183492 }, -- Reverberation
				{ 29,  183311 }, -- Memory of the Final Verdict
				{ 30,  182463 }, -- Harrowing Punishment
				{ 101, 182130 }, -- Shattered Perceptions
				{ 102, 183463 }, -- Unnatural Malice
				{ 103, 182335 }, -- Spirit Attunement
				{ 104, 184170 }, -- Doubtweaver's Handwraps
				{ 105, 182288 }, -- Impenetrable Gloom
				{ 106, 183493 }, -- Sudden Fractures
				{ 107, 182295 }, -- Proliferation
				{ 108, 184139 }, -- Valinor's Ground Pounders
				{ 109, 182778 }, -- Ringing Clarity
				{ 110, 182706 }, -- Brooding Pool
				{ 111, 182777 }, -- Hallowed Discernment
				{ 112, 181981 }, -- Festering Transfusion
				{ 113, 181974 }, -- Courageous Ascension
				{ 114, 183494 }, -- Septic Shock
				{ 115, 184132 }, -- Oversized Centurion Helm
				{ 116, 182651 }, -- Destructive Reverberations
				{ 117, 182321 }, -- Enfeebled Mark
				{ 118, 182770 }, -- Righteous Might
				{ 119, 183471 }, -- Deep Allegiance
				{ 120, 183353 }, -- Memory of the Windspeaker's Lava Resurgence
				{ 121, 181639 }, -- Siphoned Malice
				{ 122, 183495 }, -- Lashing Scars
				{ 123, 182331 }, -- Empowered Release
				{ 124, 182440 }, -- Piercing Verdict
				{ 125, 181539 }, -- Discipline of the Grove
				{ 126, 182960 }, -- Soul Tithe
				{ 127, 181770 }, -- Bone Marrow Hops
			},
		},
		{ -- Mortanis
			EncounterJournalID = 2431,
			[NORMAL_RAID_DIFF] = {
				{ 1,   183472 }, -- Evolved Swarm
				{ 2,   184173 }, -- Bone Crushing Vicegrips
				{ 3,   182685 }, -- Increased Scrutiny
				{ 4,   183386 }, -- Memory of Fujieda
				{ 5,   182646 }, -- Repeat Decree
				{ 6,   182339 }, -- Necrotic Barrage
				{ 7,   182347 }, -- Essential Extraction
				{ 8,   182292 }, -- Brutal Grasp
				{ 9,   184135 }, -- Shoulderblade Vambraces
				{ 10,  182442 }, -- Veteran's Repute
				{ 11,  182962 }, -- Catastrophic Origin
				{ 12,  183474 }, -- Endless Thirst
				{ 13,  182348 }, -- Lavish Harvest
				{ 14,  181600 }, -- Ire of the Ascended
				{ 15,  184128 }, -- Mortanis's Ribcage
				{ 16,  181553 }, -- Gift of the Lich
				{ 17,  183199 }, -- Withering Ground
				{ 18,  183341 }, -- Memory of a Guile Charm
				{ 19,  181774 }, -- Imbued Reflections
				{ 20,  182331 }, -- Empowered Release
				{ 21,  183473 }, -- Conflux of Elements
				{ 22,  184143 }, -- Band of the Risen Bonelord
				{ 23,  182129 }, -- Fae Fermata
				{ 24,  181759 }, -- Strike with Clarity
				{ 25,  182964 }, -- Soul Eater
				{ 26,  181775 }, -- Way of the Fae
				{ 27,  183295 }, -- Memory of Keefer
				{ 28,  181539 }, -- Discipline of the Grove
				{ 29,  182961 }, -- Fatal Decimation
				{ 30,  182295 }, -- Proliferation
				{ 101, 182130 }, -- Shattered Perceptions
				{ 102, 181639 }, -- Siphoned Malice
				{ 103, 182335 }, -- Spirit Attunement
				{ 104, 181981 }, -- Festering Transfusion
				{ 105, 182288 }, -- Impenetrable Gloom
				{ 106, 183493 }, -- Sudden Fractures
				{ 107, 182777 }, -- Hallowed Discernment
				{ 108, 182463 }, -- Harrowing Punishment
				{ 109, 183463 }, -- Unnatural Malice
				{ 110, 182706 }, -- Brooding Pool
				{ 111, 182651 }, -- Destructive Reverberations
				{ 112, 182778 }, -- Ringing Clarity
				{ 113, 181974 }, -- Courageous Ascension
				{ 114, 183494 }, -- Septic Shock
				{ 115, 183492 }, -- Reverberation
				{ 116, 184140 }, -- Bone-Cleated Footpads
				{ 117, 182321 }, -- Enfeebled Mark
				{ 118, 182770 }, -- Righteous Might
				{ 119, 181770 }, -- Bone Marrow Hops
				{ 120, 182345 }, -- Elysian Dirge
				{ 121, 183471 }, -- Deep Allegiance
				{ 122, 183495 }, -- Lashing Scars
				{ 123, 184133 }, -- Spine Crawler Waistcord
				{ 124, 182440 }, -- Piercing Verdict
				{ 125, 182767 }, -- The Long Summer
				{ 126, 182960 }, -- Soul Tithe
				{ 127, 182346 }, -- Tumbling Waves
			},
		},
		{ -- Oranomonos the Everbranching
			EncounterJournalID = 2432,
			[NORMAL_RAID_DIFF] = {
				{ 1,   183472 }, -- Evolved Swarm
				{ 2,   182346 }, -- Tumbling Waves
				{ 3,   184126 }, -- Ironroot Bindings
				{ 4,   182685 }, -- Increased Scrutiny
				{ 5,   184142 }, -- Twisted Witherroot Band
				{ 6,   182646 }, -- Repeat Decree
				{ 7,   182339 }, -- Necrotic Barrage
				{ 8,   182347 }, -- Essential Extraction
				{ 9,   182292 }, -- Brutal Grasp
				{ 10,  184127 }, -- Slippers of the Leafy Undergrowth
				{ 11,  183261 }, -- Memory of Surging Shots
				{ 12,  182962 }, -- Catastrophic Origin
				{ 13,  183474 }, -- Endless Thirst
				{ 14,  182348 }, -- Lavish Harvest
				{ 15,  183238 }, -- Memory of the Verdant Infusion
				{ 16,  181553 }, -- Gift of the Lich
				{ 17,  183199 }, -- Withering Ground
				{ 18,  181774 }, -- Imbued Reflections
				{ 19,  182331 }, -- Empowered Release
				{ 20,  182442 }, -- Veteran's Repute
				{ 21,  184129 }, -- Oranomonos's Diaphanous Leggings
				{ 22,  182767 }, -- The Long Summer
				{ 23,  182129 }, -- Fae Fermata
				{ 24,  181759 }, -- Strike with Clarity
				{ 25,  182964 }, -- Soul Eater
				{ 26,  181775 }, -- Way of the Fae
				{ 27,  181639 }, -- Siphoned Malice
				{ 28,  181539 }, -- Discipline of the Grove
				{ 29,  181981 }, -- Festering Transfusion
				{ 30,  184138 }, -- Stonebark Girdle
				{ 101, 182130 }, -- Shattered Perceptions
				{ 102, 181770 }, -- Bone Marrow Hops
				{ 103, 182335 }, -- Spirit Attunement
				{ 104, 183463 }, -- Unnatural Malice
				{ 105, 182288 }, -- Impenetrable Gloom
				{ 106, 183493 }, -- Sudden Fractures
				{ 107, 184172 }, -- Seed-Tender's Handwraps
				{ 108, 182778 }, -- Ringing Clarity
				{ 109, 182770 }, -- Righteous Might
				{ 110, 182706 }, -- Brooding Pool
				{ 111, 182777 }, -- Hallowed Discernment
				{ 112, 183492 }, -- Reverberation
				{ 113, 181974 }, -- Courageous Ascension
				{ 114, 183494 }, -- Septic Shock
				{ 115, 182295 }, -- Proliferation
				{ 116, 182651 }, -- Destructive Reverberations
				{ 117, 182321 }, -- Enfeebled Mark
				{ 118, 183274 }, -- Memory of a Fevered Incantation
				{ 119, 182463 }, -- Harrowing Punishment
				{ 120, 182345 }, -- Elysian Dirge
				{ 121, 183471 }, -- Deep Allegiance
				{ 122, 183495 }, -- Lashing Scars
				{ 123, 181600 }, -- Ire of the Ascended
				{ 124, 182440 }, -- Piercing Verdict
				{ 125, 182961 }, -- Fatal Decimation
				{ 126, 182960 }, -- Soul Tithe
				{ 127, 183473 }, -- Conflux of Elements
			},
		},
		{ -- Nurgash Muckformed
			EncounterJournalID = 2433,
			[NORMAL_RAID_DIFF] = {
				{ 1,   183472 }, -- Evolved Swarm
				{ 2,   182346 }, -- Tumbling Waves
				{ 3,   182685 }, -- Increased Scrutiny
				{ 4,   182638 }, -- Memory of a Frenzied Monstrosity
				{ 5,   182331 }, -- Empowered Release
				{ 6,   182339 }, -- Necrotic Barrage
				{ 7,   182347 }, -- Essential Extraction
				{ 8,   182292 }, -- Brutal Grasp
				{ 9,   182442 }, -- Veteran's Repute
				{ 10,  182962 }, -- Catastrophic Origin
				{ 11,  183474 }, -- Endless Thirst
				{ 12,  182348 }, -- Lavish Harvest
				{ 13,  181600 }, -- Ire of the Ascended
				{ 14,  181553 }, -- Gift of the Lich
				{ 15,  183199 }, -- Withering Ground
				{ 16,  184134 }, -- Jingling Stone Stompers
				{ 17,  183215 }, -- Memory of an Erratic Fel Core
				{ 18,  181774 }, -- Imbued Reflections
				{ 19,  183473 }, -- Conflux of Elements
				{ 20,  181539 }, -- Discipline of the Grove
				{ 21,  182767 }, -- The Long Summer
				{ 22,  184137 }, -- Sinstone Shoulderpadding
				{ 23,  182129 }, -- Fae Fermata
				{ 24,  181759 }, -- Strike with Clarity
				{ 25,  182964 }, -- Soul Eater
				{ 26,  181775 }, -- Way of the Fae
				{ 27,  181639 }, -- Siphoned Malice
				{ 28,  183492 }, -- Reverberation
				{ 29,  184130 }, -- Nurgash's Belt of Many Sinstones
				{ 30,  181770 }, -- Bone Marrow Hops
				{ 101, 182130 }, -- Shattered Perceptions
				{ 102, 181981 }, -- Festering Transfusion
				{ 103, 182335 }, -- Spirit Attunement
				{ 104, 182777 }, -- Hallowed Discernment
				{ 105, 182288 }, -- Impenetrable Gloom
				{ 106, 183493 }, -- Sudden Fractures
				{ 107, 184131 }, -- Comfortable Slumberwraps
				{ 108, 182463 }, -- Harrowing Punishment
				{ 109, 183463 }, -- Unnatural Malice
				{ 110, 182706 }, -- Brooding Pool
				{ 111, 182651 }, -- Destructive Reverberations
				{ 112, 184171 }, -- Hardened Castle Crushers
				{ 113, 181974 }, -- Courageous Ascension
				{ 114, 183494 }, -- Septic Shock
				{ 115, 183376 }, -- Memory of Azj'Aqir's Madness
				{ 116, 182646 }, -- Repeat Decree
				{ 117, 182321 }, -- Enfeebled Mark
				{ 118, 182770 }, -- Righteous Might
				{ 119, 182778 }, -- Ringing Clarity
				{ 120, 182345 }, -- Elysian Dirge
				{ 121, 183471 }, -- Deep Allegiance
				{ 122, 183495 }, -- Lashing Scars
				{ 123, 182295 }, -- Proliferation
				{ 124, 182440 }, -- Piercing Verdict
				{ 125, 182961 }, -- Fatal Decimation
				{ 126, 182960 }, -- Soul Tithe
				{ 127, 184144 }, -- Muckformed Chain Choker
			},
		},
		{ -- Mor'geth, Tormentor of the Damned
			EncounterJournalID = 2456,
			[NORMAL_RAID_DIFF] = {
				{ 1,  187507 }, -- Adaptive Armor Fragment
				{ 2,  187061 }, -- Shard of Rev
				{ 3,  186360 }, -- Tormented Soul Harness
				{ 4,  187506 }, -- Condensed Anima Sphere
				{ 5,  186368 }, -- Mor'geth's Gauntlets of Damnation
				{ 6,  186355 }, -- Wristwraps of Anguish
				{ 7,  186372 }, -- Tormentor's Greatbelt
				{ 8,  187447 }, -- Soul Cage Fragment
				{ 9,  186361 }, -- Grips of Unleashed Suffering
				{ 10, 186366 }, -- Stygian Chain Greaves
				{ 11, 186357 }, -- Sorrowful Trousers
				{ 12, 186370 }, -- Caged Legplates
			},
		},
		{ -- Antros
			EncounterJournalID = 2468,
			[NORMAL_RAID_DIFF] = {
				{ 1,  187507 }, -- Adaptive Armor Fragment
				{ 2,  190614 }, -- Antros' Entrusted Bascinet
				{ 3,  190616 }, -- Controlled Sequence Clasp
				{ 4,  190618 }, -- Lattice of the Distant Keeper
				{ 5,  190620 }, -- Sav'thul's Calamitous Tantour
				{ 6,  187506 }, -- Condensed Anima Sphere
				{ 7,  190615 }, -- Cosmic Guardian's Casing
				{ 8,  190617 }, -- Destruction-Core Handlers
				{ 9,  190619 }, -- Antecedent's Aliform Joggers
				{ 10, 190621 }, -- Dealic Deterrent Stockings
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
				{ 1,  182109 }, -- Totemic Surge
				{ 2,  182979 }, -- Slippers of the Forgotten Heretic
				{ 3,  184016 }, -- Skulker's Wing
				{ 4,  183512 }, -- Planned Execution
				{ 5,  182466 }, -- Shade of Terror
				{ 6,  182132 }, -- Unending Grip
				{ 7,  183034 }, -- Cowled Batwing Cloak
				{ 8,  182976 }, -- Double-Chained Utility Belt
				{ 9,  182993 }, -- Chiropteran Leggings
				{ 10, 183027 }, -- Errant Crusader's Greaves
				{ 11, 181962 }, -- Mental Recovery
				{ 12, 180944 }, -- Merciless Bonegrinder
				{ 13, 182656 }, -- Disturb the Peace
				{ 14, 181866 }, -- Withering Plague
				{ 15, 182330 }, -- Demonic Parole
				{ 16, 181742 }, -- Walk with the Ox
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
				{ 1,  182995 }, -- Spell-Woven Tourniquet
				{ 2,  182988 }, -- Master Huntsman's Bandolier
				{ 3,  181942 }, -- Focused Mending
				{ 4,  182605 }, -- Tactical Retreat
				{ 5,  183361 }, -- Memory of the Spiritwalker's Tidal Totem
				{ 6,  183892 }, -- Mystic Anima Spherule
				{ 7,  183501 }, -- Rushed Setup
				{ 8,  183470 }, -- Born of the Wilds
				{ 9,  182110 }, -- Crippling Hex
				{ 10, 183018 }, -- Hellhound Cuffs
				{ 11, 181982 }, -- Everfrost
				{ 12, 180933 }, -- Ashen Juggernaut
				{ 13, 184017 }, -- Bargast's Leash
				{ 14, 181510 }, -- Lingering Numbness
				{ 15, 183040 }, -- Charm of Eternal Winter
				{ 16, 182996 }, -- Grim Pursuant's Maille
				{ 17, 183258 }, -- Memory of Eagletalon's True Focus
				{ 18, 180943 }, -- Cacophonous Roar
				{ 19, 183235 }, -- Memory of the Natural Order
				{ 20, 182648 }, -- Sharpshooter's Focus
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
				{ 1,  184018 }, -- Splintered Heart of Al'ar
				{ 2,  183007 }, -- Bleakwing Assassin's Grips
				{ 3,  182736 }, -- Rolling Agony
				{ 4,  181504 }, -- Infernal Cascade
				{ 5,  184019 }, -- Soul Igniter
				{ 6,  182977 }, -- Bangles of Errant Pride
				{ 7,  182307 }, -- Shielding Words
				{ 8,  184020 }, -- Tuft of Smoldering Plumage
				{ 9,  183893 }, -- Abominable Anima Spherule
				{ 10, 182677 }, -- Punish the Guilty
				{ 11, 182471 }, -- Soul Furnace
				{ 12, 182986 }, -- High Torturer's Smock
				{ 13, 181975 }, -- Hardened Bones
				{ 14, 183025 }, -- Stoic Guardsman's Belt
				{ 15, 183277 }, -- Memory of the Sun King
				{ 16, 183033 }, -- Mantle of Manifest Sins
				{ 17, 182107 }, -- Vital Accretion
				{ 18, 183304 }, -- Memory of the Shadowbreaker
				{ 19, 180844 }, -- Brutal Vitality
				{ 20, 182584 }, -- Cheetah's Vigor
				{ 21, 182316 }, -- Fel Defender
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
				{ 1,  183960 }, -- Portable Pocket Dimension
				{ 2,  183468 }, -- Born Anew
				{ 3,  183038 }, -- Hyperlight Band
				{ 4,  181837 }, -- Clear Mind
				{ 5,  183019 }, -- Precisely Calibrated Chronometer
				{ 6,  183004 }, -- Shadewarped Sash
				{ 7,  183012 }, -- Greaves of Enigmatic Energies
				{ 8,  183888 }, -- Apogee Anima Bead
				{ 9,  181734 }, -- Magi's Brand
				{ 10, 181769 }, -- Tempest Barrier
				{ 11, 183296 }, -- Memory of the Last Emperor
				{ 12, 181843 }, -- Shining Radiance
				{ 13, 182126 }, -- High Voltage
				{ 14, 184021 }, -- Glyph of Assimilation
				{ 15, 183370 }, -- Memory of the Core of the Balespider
				{ 16, 182460 }, -- Accrued Vitality
				{ 17, 183479 }, -- Umbral Intensity
				{ 18, 182987 }, -- Breastplate of Cautious Calculation
				{ 19, 182441 }, -- Marksman's Advantage
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
				{ 1,  181786 }, -- Eternal Hunger
				{ 2,  184022 }, -- Consumptive Infusion
				{ 3,  182755 }, -- Ashen Remains
				{ 4,  183391 }, -- Memory of the Wall
				{ 5,  183891 }, -- Venerated Anima Spherule
				{ 6,  181698 }, -- Cryo-Freeze
				{ 7,  181640 }, -- Tumbling Technique
				{ 8,  181435 }, -- Calculated Strikes
				{ 9,  183024 }, -- Volatile Shadestitch Legguards
				{ 10, 183028 }, -- Cinch of Infinite Tightness
				{ 11, 183001 }, -- Helm of Insatiable Appetite
				{ 12, 181827 }, -- Move with Grace
				{ 13, 183009 }, -- Miasma-Lacquered Jerkin
				{ 14, 182622 }, -- Resplendent Light
				{ 15, 184023 }, -- Gluttonous Spike
				{ 16, 183498 }, -- Cloaked in Shadows
				{ 17, 182992 }, -- Endlessly Gluttonous Greaves
				{ 18, 182994 }, -- Epaulettes of Overwhelming Force
				{ 19, 181836 }, -- Spirit Drain
				{ 20, 183000 }, -- Consumptive Chainmail Carapace
				{ 21, 182630 }, -- Memory of Gorefiend's Domination
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
				{ 1,  183026 }, -- Gloves of Phantom Shadows
				{ 2,  182317 }, -- Shattered Restoration
				{ 3,  182449 }, -- Resolute Barrier
				{ 4,  182143 }, -- Swirling Currents
				{ 5,  183015 }, -- Binding of Warped Desires
				{ 6,  181841 }, -- Reinforced Shell
				{ 7,  183240 }, -- Memory of the Mother Tree
				{ 8,  182469 }, -- Rejuvenating Wind
				{ 9,  180896 }, -- Safeguard
				{ 10, 181466 }, -- Grounding Breath
				{ 11, 182985 }, -- Memento-Laden Cuisses
				{ 12, 183218 }, -- Memory of a Fortified Fel Flame
				{ 13, 183482 }, -- Sudden Ambush
				{ 14, 181495 }, -- Jade Bond
				{ 15, 183021 }, -- Confidant's Favored Cap
				{ 16, 181498 }, -- Grounding Surge
				{ 17, 183889 }, -- Thaumaturgic Anima Bead
				{ 18, 183037 }, -- Ritualist's Treasured Ring
				{ 19, 183464 }, -- Tough as Bark
				{ 20, 184025 }, -- Memory of Past Sins
				{ 21, 183502 }, -- Prepared for All
				{ 22, 182111 }, -- Spiritual Resonance
				{ 23, 183510 }, -- Count the Odds
				{ 24, 182336 }, -- Golden Path
				{ 25, 181826 }, -- Translucent Image
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
				{ 1,  183890 }, -- Zenith Anima Spherule
				{ 2,  182131 }, -- Haunting Apparitions
				{ 3,  182383 }, -- Dancing with Fate
				{ 4,  182480 }, -- Reversal of Fortune
				{ 5,  183011 }, -- Courtier's Costume Trousers
				{ 6,  182461 }, -- Echoing Blessings
				{ 7,  183023 }, -- Sparkling Glass Slippers
				{ 8,  181512 }, -- Dizzying Tumble
				{ 9,  183039 }, -- Noble's Birthstone Pendant
				{ 10, 181834 }, -- Chilled Resilience
				{ 11, 183326 }, -- Memory of the Void's Eternal Call
				{ 12, 181842 }, -- Power Unto Others
				{ 13, 183334 }, -- Memory of the Dashing Scoundrel
				{ 14, 182470 }, -- Demonic Momentum
				{ 15, 183466 }, -- Innate Resolve
				{ 16, 182106 }, -- Refreshing Waters
				{ 17, 184024 }, -- Macabre Sheet Music
				{ 18, 180847 }, -- Inspiring Presence
				{ 19, 183030 }, -- Enchanted Toe-Tappers
				{ 20, 182983 }, -- Stoneguard Attendant's Boots
				{ 21, 183014 }, -- Castellan's Chainlink Grips
				{ 22, 182989 }, -- Corset of the Deft Duelist
				{ 23, 182325 }, -- Ravenous Consumption
				{ 24, 181776 }, -- Vicious Contempt
				{ 25, 181464 }, -- Winter's Protection
				{ 26, 183496 }, -- Nimble Fingers
				{ 27, 183402 }, -- Bloodletting
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
				{ 1,  182340 }, -- Fel Celerity
				{ 2,  183340 }, -- Memory of Greenskin
				{ 3,  184026 }, -- Hateful Chain
				{ 4,  182635 }, -- Memory of Koltira
				{ 5,  183356 }, -- Memory of the Primal Lava Actuators
				{ 6,  183484 }, -- Unchecked Aggression
				{ 7,  181373 }, -- Harm Denial
				{ 8,  183499 }, -- Quick Decisions
				{ 9,  183318 }, -- Memory of a Clear Mind
				{ 10, 182981 }, -- Leggings of Lethal Reverberations
				{ 11, 183016 }, -- Load-Bearing Belt
				{ 12, 183309 }, -- Memory of the Ardent Protector
				{ 13, 183272 }, -- Memory of a Siphoning Storm
				{ 14, 183022 }, -- Impossibly Oversized Mitts
				{ 15, 181707 }, -- Diverted Energy
				{ 16, 183005 }, -- Heedless Pugilist's Harness
				{ 17, 183505 }, -- Maim, Mangle
				{ 18, 183467 }, -- Tireless Pursuit
				{ 19, 183389 }, -- Memory of the Berserker's Will
				{ 20, 182999 }, -- Rampaging Giant's Chestplate
				{ 21, 182751 }, -- Tyrant's Soul
				{ 22, 182984 }, -- Colossal Plate Gauntlets
				{ 23, 183374 }, -- Memory of Azj'Aqir's Cinders
				{ 24, 183006 }, -- Stoneclas Stompers
				{ 25, 181455 }, -- Icy Propulsion
				{ 26, 183293 }, -- Memory of the Morning's Tear
				{ 27, 183233 }, -- Memory of the Frenzyband
				{ 28, 183264 }, -- Memory of the Rylakstalker's Strikes
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
				{ 1,   183346 }, -- Memory of an Ancestral Reminder
				{ 2,   183299 }, -- Memory of the Sun's Cycles
				{ 3,   182134 }, -- Unruly Winds
				{ 4,   183213 }, -- Memory of the Anguish of the Collective
				{ 5,   183032 }, -- Crest of the Legionnaire General
				{ 6,   183497 }, -- Recuperator
				{ 7,   183316 }, -- Memory of the Twins of the Sun Priestess
				{ 8,   182324 }, -- Felfire Haste
				{ 9,   183167 }, -- Strength of the Pack
				{ 10,  182608 }, -- Virtuous Command
				{ 11,  183002 }, -- Ceremonial Parade Legguards
				{ 12,  183223 }, -- Memory of the Circle of Life and Death
				{ 13,  181467 }, -- Flow of Time
				{ 14,  183381 }, -- Memory of the Tormented Kings
				{ 15,  184027 }, -- Stone Legion Heraldry
				{ 16,  181838 }, -- Charitable Soul
				{ 17,  183894 }, -- Thaumaturgic Anima Bead
				{ 18,  181508 }, -- Fortifying Ingredients
				{ 19,  183469 }, -- Front of the Pack
				{ 20,  183367 }, -- Memory of Demonic Synergy
				{ 21,  182304 }, -- Divine Call
				{ 22,  182627 }, -- Memory of Superstrain
				{ 23,  183076 }, -- Diabolic Bloodstone
				{ 24,  183029 }, -- Wicked Flanker's Gorget
				{ 25,  182108 }, -- Thunderous Paws
				{ 26,  183250 }, -- Memory of the Wild Call
				{ 27,  182998 }, -- Robes of the Cursed Commando
				{ 28,  183488 }, -- Unstoppable Growth
				{ 29,  183267 }, -- Memory of an Expanded Potential
				{ 30,  183283 }, -- Memory of the Invoker
				{ 101, 182991 }, -- Oathsworn Soldier's Gauntlets
				{ 102, 182464 }, -- Harmony of the Tortollan
				{ 103, 183895 }, -- Apogee Anima Bead
				{ 104, 182133 }, -- Insatiable Appetite
				{ 105, 183330 }, -- Memory of Bloodfang's Essence
				{ 106, 180842 }, -- Stalwart Guardian
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
				{ 1,   181553 }, -- Gift of the Lich
				{ 2,   183474 }, -- Endless Thirst
				{ 3,   182347 }, -- Essential Extraction
				{ 4,   184030 }, -- Dreadfire Vessel
				{ 5,   181840 }, -- Light's Inspiration
				{ 6,   184031 }, -- Sanguine Vintage
				{ 7,   182777 }, -- Hallowed Discernment
				{ 8,   181539 }, -- Discipline of the Grove
				{ 9,   183492 }, -- Reverberation
				{ 10,  182778 }, -- Ringing Clarity
				{ 11,  182318 }, -- Viscous Ink
				{ 12,  183493 }, -- Sudden Fractures
				{ 13,  182636 }, -- Memory of the Deadliest Coil
				{ 14,  182335 }, -- Spirit Attunement
				{ 15,  183494 }, -- Septic Shock
				{ 16,  183256 }, -- Memory of the Eredun War Order
				{ 17,  182129 }, -- Fae Fermata
				{ 18,  183288 }, -- Memory of a Celestial Infusion
				{ 19,  182288 }, -- Impenetrable Gloom
				{ 20,  182685 }, -- Increased Scrutiny
				{ 21,  183463 }, -- Unnatural Malice
				{ 22,  183352 }, -- Memory of the Demise of Skybreaker
				{ 23,  183495 }, -- Lashing Scars
				{ 24,  183384 }, -- Memory of the Exploiter
				{ 25,  182130 }, -- Shattered Perceptions
				{ 26,  182448 }, -- Light's Barding
				{ 27,  183020 }, -- Shawl of the Penitent
				{ 28,  183036 }, -- Most Regal Signet of Sire Denathrius
				{ 29,  183465 }, -- Ursine Vigor
				{ 30,  183227 }, -- Memory of Oneth
				{ 101, 182767 }, -- The Long Summer
				{ 102, 182339 }, -- Necrotic Barrage
				{ 103, 181974 }, -- Courageous Ascension
				{ 104, 182292 }, -- Brutal Grasp
				{ 105, 183324 }, -- Memory of a Harmonious Apparatus
				{ 106, 183896 }, -- Abominable Anima Spherule
				{ 107, 184587 }, -- Ambuscade
				{ 108, 182706 }, -- Brooding Pool
				{ 109, 183003 }, -- Pauldrons of Fatal Finality
				{ 110, 183500 }, -- Fade to Nothing
				{ 111, 183897 }, -- Mystic Anima Spherule
				{ 112, 182770 }, -- Righteous Might
				{ 113, 181770 }, -- Bone Marrow Hops
				{ 114, 183310 }, -- Memory of the Vanguard's Momentum
				{ 115, 183199 }, -- Withering Ground
				{ 116, 182961 }, -- Fatal Decimation
				{ 117, 182321 }, -- Enfeebled Mark
				{ 118, 181469 }, -- Indelible Victory
				{ 119, 183898 }, -- Venerated Anima Spherule
				{ 120, 183279 }, -- Memory of the Freezing Winds
				{ 121, 181624 }, -- Swift Transference
				{ 122, 182295 }, -- Proliferation
				{ 123, 183214 }, -- Memory of the Chaos Theory
				{ 124, 182962 }, -- Catastrophic Origin
				{ 125, 182997 }, -- Diadem of Imperious Desire
				{ 126, 182105 }, -- Astral Protection
				{ 127, 183899 }, -- Zenith Anima Spherule
				{ 128, 181756 }, -- Incantation of Swiftness
				{ 129, 182346 }, -- Tumbling Waves
				{ 130, 183344 }, -- Memory of Finality
				{ 201, 182651 }, -- Destructive Reverberations
				{ 202, 183471 }, -- Deep Allegiance
				{ 203, 182442 }, -- Veteran's Repute
				{ 204, 181774 }, -- Imbued Reflections
				{ 205, 182463 }, -- Harrowing Punishment
				{ 206, 182646 }, -- Repeat Decree
				{ 207, 182331 }, -- Empowered Release
				{ 208, 182980 }, -- Sadist's Sinister Mask
				{ 209, 182440 }, -- Piercing Verdict
				{ 210, 183472 }, -- Evolved Swarm
				{ 211, 182345 }, -- Elysian Dirge
				{ 212, 182964 }, -- Soul Eater
				{ 213, 184028 }, -- Cabalist's Hymnal
				{ 214, 182348 }, -- Lavish Harvest
				{ 215, 183044 }, -- Kilrogg's Cunning
				{ 216, 181981 }, -- Festering Transfusion
				{ 217, 182113 }, -- Fleeting Wind
				{ 218, 183473 }, -- Conflux of Elements
				{ 219, 183362 }, -- Memory of a Malefic Wrath
				{ 220, 181600 }, -- Ire of the Ascended
				{ 221, 184029 }, -- Manabound Mirror
				{ 222, 181759 }, -- Strike with Clarity
				{ 223, 181775 }, -- Way of the Fae
				{ 224, 181639 }, -- Siphoned Malice
				{ 225, 182960 }, -- Soul Tithe
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
				{ 1,  182344 }, -- Lost in Darkness
				{ 2,  186285 }, -- Sorcerer's Headlong Legwraps
				{ 3,  182139 }, -- Rabid Shadows
				{ 4,  186297 }, -- Clasps of the Unfortunate Troubadour
				{ 5,  181376 }, -- Inner Fury
				{ 6,  183504 }, -- Well-Placed Steel
				{ 7,  182144 }, -- Nature's Focus
				{ 8,  183481 }, -- Incessant Hunter
				{ 9,  186422 }, -- Tome of Monstrous Constructions
				{ 10, 186318 }, -- Champion's Gruesome Greaves
				{ 11, 186415 }, -- Moriaz's Spare Targe
				{ 12, 180932 }, -- Fueled by Violence
				{ 13, 182610 }, -- Ferocious Appetite
				{ 14, 186303 }, -- Colossus Slayer's Hauberk
				{ 15, 186281 }, -- Phantasma-Forged Striders
				{ 16, 186311 }, -- Cavalier Oathbreaker's Grasps
				{ 17, 182750 }, -- Carnivorous Stalkers
				{ 18, 186381 }, -- Elethium-Bladed Glaive
				{ 19, 186302 }, -- Mistwrap Manacles
				{ 20, 182113 }, -- Fleeting Wind
				{ 21, 182456 }, -- Wrench Evil
				{ 22, 186298 }, -- Smuggler's Plundered Pauldrons
				{ 23, 186291 }, -- Periapt of Pristine Preservation
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
				{ 1,  186316 }, -- Airborne Abductor's Vambraces
				{ 2,  186301 }, -- Coiled Stygian Grapnel
				{ 3,  181640 }, -- Tumbling Technique
				{ 4,  186418 }, -- Guarm's Lost Chew Toy
				{ 5,  186554 }, -- Eye of Allseeing
				{ 6,  186403 }, -- Stygian Lance of Passage
				{ 7,  183500 }, -- Fade to Nothing
				{ 8,  182462 }, -- Expurgation
				{ 9,  182478 }, -- Corrupting Leer
				{ 10, 186295 }, -- Loyal Kvaldir's Handwraps
				{ 11, 186423 }, -- Titanic Ocular Gland
				{ 12, 181963 }, -- Blood Bond
				{ 13, 183486 }, -- Well-Honed Instincts
				{ 14, 181738 }, -- Artifice of the Archmage
				{ 15, 186306 }, -- Greaves of Extermination
				{ 16, 186288 }, -- Grasps of the Clairvoyant Sage
				{ 17, 182441 }, -- Marksman's Advantage
				{ 18, 186296 }, -- Mawsworn Eviscerator's Cuirass
				{ 19, 180896 }, -- Safeguard
				{ 20, 181840 }, -- Light's Inspiration
				{ 21, 186383 }, -- Gazepiercer
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
		{ -- The Nine
			EncounterJournalID = 2439,
			[RF_DIFF] = {
				{ 1,  182340 }, -- Fel Celerity
				{ 2,  182135 }, -- Focused Lightning
				{ 3,  181736 }, -- Flame Accretion
				{ 4,  186425 }, -- Scrawled Word of Recall
				{ 5,  181845 }, -- Exaltation
				{ 6,  186313 }, -- Agatha's Gothic Greaves
				{ 7,  186286 }, -- Mantle of Arthura's Chosen
				{ 8,  182384 }, -- Serrated Glaive
				{ 9,  183477 }, -- Precise Alignment
				{ 10, 182753 }, -- Royal Decree
				{ 11, 181641 }, -- Rising Sun Revival
				{ 12, 186290 }, -- Sworn Oath of the Nine
				{ 13, 186299 }, -- Daschla's Defiant Treads
				{ 14, 186384 }, -- Skyja's Revenant Fury
				{ 15, 186307 }, -- Aradne's Lancer Legguards
				{ 16, 186404 }, -- Jotungeirr, Destiny's Call
				{ 17, 182657 }, -- Deadly Chain
				{ 18, 186346 }, -- Kyra's Unending Protectors
				{ 19, 186385 }, -- Signe's Sonorous Scramaseax
				{ 20, 186339 }, -- Brynja's Mournful Wristwraps
				{ 21, 186424 }, -- Shard of Annhylde's Aegis
				{ 22, 186656 }, -- Sanctum Gloomcharger's Reins
				{ 23, 182201 }, -- Unleashed Frenzy
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
				{ 1,  186308 }, -- Grasps of Ancestral Whispers
				{ 2,  186312 }, -- Cuirass of the Lonely Citadel
				{ 3,  186378 }, -- Weathered Talisman of the Shadowmoon
				{ 4,  181705 }, -- Celestial Effervescence
				{ 5,  182752 }, -- Fel Commando
				{ 6,  182206 }, -- Convocation of the Dead
				{ 7,  181842 }, -- Power Unto Others
				{ 8,  186287 }, -- Hood of Vengeful Possession
				{ 9,  183464 }, -- Tough as Bark
				{ 10, 186428 }, -- Shadowed Orb of Torment
				{ 11, 182468 }, -- Mortal Combo
				{ 12, 186427 }, -- Whispering Shard of Power
				{ 13, 183508 }, -- Ambidexterity
				{ 14, 186386 }, -- Betrayer's Shadowspike
				{ 15, 186315 }, -- Dark Tormentor's Gaze
				{ 16, 181389 }, -- Shivering Core
				{ 17, 186292 }, -- Cap of Writhing Malevolence
				{ 18, 182111 }, -- Spiritual Resonance
				{ 19, 186405 }, -- Gnarled Staff of the Elder Shaman
				{ 20, 186304 }, -- Crest of the Fallen
				{ 21, 182464 }, -- Harmony of the Tortollan
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
				{ 1,  186343 }, -- Ragebound Leg Irons
				{ 2,  182317 }, -- Shattered Restoration
				{ 3,  186289 }, -- Cloak of Scarred Honor
				{ 4,  186305 }, -- Pauldrons of Tyrannical Defiance
				{ 5,  186387 }, -- Dormazain's Tenderizer
				{ 6,  181834 }, -- Chilled Resilience
				{ 7,  181466 }, -- Grounding Breath
				{ 8,  186337 }, -- Trenchant Warmonger Treads
				{ 9,  186558 }, -- Irongrasp
				{ 10, 186314 }, -- Ruinous Warchief's Shoulderguards
				{ 11, 186411 }, -- Soulrent Outrider's Recurve
				{ 12, 183489 }, -- Flash of Clarity
				{ 13, 186294 }, -- Agonizing Spiked Belt
				{ 14, 183076 }, -- Diabolic Bloodstone
				{ 15, 181467 }, -- Flow of Time
				{ 16, 186429 }, -- Decanter of Endless Howling
				{ 17, 181847 }, -- Lasting Spirit
				{ 18, 182107 }, -- Vital Accretion
				{ 19, 186319 }, -- Tormented Shadowcleft Boots
				{ 20, 182448 }, -- Light's Barding
				{ 21, 186283 }, -- Cruel Overlord's Shackles
				{ 22, 180844 }, -- Brutal Vitality
				{ 23, 183513 }, -- Stiletto Staccato
				{ 24, 186407 }, -- Hellscream's Requiem
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
				{ 1,  182604 }, -- Roaring Fire
				{ 2,  181709 }, -- Unnerving Focus
				{ 3,  181465 }, -- Xuen's Bond
				{ 4,  186282 }, -- Sacrificer's Sacramental Cassock
				{ 5,  183496 }, -- Nimble Fingers
				{ 6,  186391 }, -- Shadowsteel Demoralizer
				{ 7,  186333 }, -- Hangman's Knotbinders
				{ 8,  186430 }, -- Tormented Rack Fragment
				{ 9,  182125 }, -- Pyroclastic Shock
				{ 10, 182582 }, -- Enkindled Spirit
				{ 11, 186375 }, -- Miniature Breaking Wheel
				{ 12, 182203 }, -- Debilitating Malady
				{ 13, 186392 }, -- Exacting Mindslicer
				{ 14, 186431 }, -- Ebonsoul Vise
				{ 15, 186369 }, -- Guillotine Gauntlets
				{ 16, 181506 }, -- Master Flame
				{ 17, 186293 }, -- Flameclasp-Scorched Legguards
				{ 18, 182754 }, -- Duplicitous Havoc
				{ 19, 186323 }, -- Leggings of the Screaming Flames
				{ 20, 186388 }, -- Cruciform Veinripper
				{ 21, 186341 }, -- Shadowsteel Facecage
				{ 22, 183476 }, -- Stellar Inspiration
				{ 23, 183396 }, -- Flame Infusion
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
				{ 1,  183487 }, -- Layered Mane
				{ 2,  186374 }, -- Self-Replicating Tissue
				{ 3,  186409 }, -- Pylon of the Great Purge
				{ 4,  186413 }, -- Directional Meltdown Projector
				{ 5,  183503 }, -- Poisoned Katar
				{ 6,  186363 }, -- Unstable Energizer Boots
				{ 7,  186433 }, -- Reactive Defense Matrix
				{ 8,  186344 }, -- Hyperdense Greaves
				{ 9,  186317 }, -- Disintegration-Proof Waistband
				{ 10, 183132 }, -- Echoing Call
				{ 11, 187507 }, -- Adaptive Armor Fragment
				{ 12, 182307 }, -- Shielding Words
				{ 13, 181505 }, -- Resplendent Mist
				{ 14, 182133 }, -- Insatiable Appetite
				{ 15, 181827 }, -- Move with Grace
				{ 16, 181769 }, -- Tempest Barrier
				{ 17, 182145 }, -- Heavy Rainfall
				{ 18, 186284 }, -- Enigmatic Energy Circuit
				{ 19, 186432 }, -- Salvaged Fusion Amplifier
				{ 20, 186416 }, -- Infinity's Last Bulwark
				{ 21, 186354 }, -- Sandals of Sacred Symmetry
				{ 22, 186393 }, -- Torch of Eternal Knowledge
				{ 23, 186347 }, -- Ancient Colossus Chassis
				{ 24, 181735 }, -- Hack and Slash
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
				{ 1,  186320 }, -- Diviner's Draped Finery
				{ 2,  182108 }, -- Thunderous Paws
				{ 3,  181624 }, -- Swift Transference
				{ 4,  186340 }, -- Conjunction-Forged Chainmail
				{ 5,  186348 }, -- Fateforged Legplates
				{ 6,  183469 }, -- Front of the Pack
				{ 7,  186434 }, -- Weave of Warped Fates
				{ 8,  182470 }, -- Demonic Momentum
				{ 9,  186376 }, -- Oscillating Ouroboros
				{ 10, 186435 }, -- Carved Ivory Keepsake
				{ 11, 186419 }, -- Record of Collapsing Realities
				{ 12, 183509 }, -- Sleight of Hand
				{ 13, 186326 }, -- Gloves of Forsaken Purpose
				{ 14, 182649 }, -- Brutal Projectiles
				{ 15, 182684 }, -- Resolute Defender
				{ 16, 186352 }, -- Binding of Dark Destinies
				{ 17, 186345 }, -- Demigaunts of Predestination
				{ 18, 182324 }, -- Felfire Haste
				{ 19, 181509 }, -- Arcane Prodigy
				{ 20, 181867 }, -- Swift Penitence
				{ 21, 186335 }, -- Fate-Threaded Bindings
				{ 22, 186330 }, -- Cowl of Haunting Precognition
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
				{ 1,  186436 }, -- Resonant Silver Bell
				{ 2,  183499 }, -- Quick Decisions
				{ 3,  186324 }, -- Frame of the False Margrave
				{ 4,  186421 }, -- Forbidden Necromantic Tome
				{ 5,  186336 }, -- Spaulders of the Crooked Confidant
				{ 6,  186406 }, -- Maledict Opus
				{ 7,  181698 }, -- Cryo-Freeze
				{ 8,  182136 }, -- Chilled to the Core
				{ 9,  182675 }, -- Untempered Dedication
				{ 10, 182747 }, -- Withering Bolt
				{ 11, 186437 }, -- Relic of the Frozen Wastes
				{ 12, 181943 }, -- Eradicating Blow
				{ 13, 187056 }, -- The Devouring Cold
				{ 14, 186322 }, -- Sash of Duplicitous Magics
				{ 15, 182141 }, -- Holy Oration
				{ 16, 186351 }, -- Vyraz's Parade Cuffs
				{ 17, 180847 }, -- Inspiring Presence
				{ 18, 186338 }, -- Ceremonial Construct Clasp
				{ 19, 183490 }, -- Floral Recycling
				{ 20, 186365 }, -- Bands of the Fallen House
				{ 21, 186350 }, -- Valorous Visage of Krexus
				{ 22, 183202 }, -- Deadly Tandem
				{ 23, 186379 }, -- Interplanar Keystone
				{ 24, 186331 }, -- Elite Aranakk Breeches
				{ 25, 186550 }, -- Mawsworn Minion
				{ 26, 187542 }, -- Jaithys, the Prison Blade
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
				{ 1,  182127 }, -- Shake the Foundations
				{ 2,  182476 }, -- Resilience of the Hunter
				{ 3,  186417 }, -- Guard of the Sundered Defender
				{ 4,  181740 }, -- Evasive Stride
				{ 5,  183511 }, -- Deeper Daggers
				{ 6,  186398 }, -- Edge of Night
				{ 7,  186414 }, -- Rae'shalare, Death's Whisper
				{ 8,  186325 }, -- Veil of the Banshee Queen
				{ 9,  182772 }, -- Infernal Brand
				{ 10, 182559 }, -- Templar's Vindication
				{ 11, 186438 }, -- Old Warrior's Soul
				{ 12, 186349 }, -- Spires of Broken Hope
				{ 13, 186353 }, -- Greaves of Haunting Ruination
				{ 14, 186332 }, -- Windrunner's Baldric
				{ 15, 182385 }, -- Growing Inferno
				{ 16, 186334 }, -- Witherheart Studded Breastplate
				{ 17, 186377 }, -- Tarnished Insignia of Quel'Thalas
				{ 18, 186342 }, -- Epaulettes of the Master Ranger
				{ 19, 186439 }, -- Dark Ranger's Quiver
				{ 20, 186321 }, -- Desecrator's Keening Wristwraps
				{ 21, 182138 }, -- Mind Devourer
				{ 22, 180933 }, -- Ashen Juggernaut
				{ 23, 182208 }, -- Lingering Plague
				{ 24, 183483 }, -- Carnivorous Instinct
				{ 25, 181383 }, -- Unrelenting Cold
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
				{ 1,  183402 }, -- Bloodletting
				{ 2,  188273 }, -- Auxiliary Attendant Chime
				{ 3,  182736 }, -- Rolling Agony
				{ 4,  189777 }, -- Unstable Giant's Cuffs
				{ 5,  189770 }, -- Pre-Fabricated Footpads
				{ 6,  189774 }, -- Fractured Colossus Core
				{ 7,  189778 }, -- Legplates of the Slumbering Sentinel
				{ 8,  189584 }, -- Sepulcher's Savior
				{ 9,  181734 }, -- Magi's Brand
				{ 10, 183505 }, -- Maim, Mangle
				{ 11, 181742 }, -- Walk with the Ox
				{ 12, 189775 }, -- Helm of Solemn Vigil
				{ 13, 189779 }, -- Key to the Immortal Hearth
				{ 14, 182622 }, -- Resplendent Light
				{ 15, 189771 }, -- Ancient Materium Tassets
				{ 16, 189772 }, -- Modified Defense Grid
				{ 17, 181843 }, -- Shining Radiance
				{ 18, 182126 }, -- High Voltage
				{ 19, 183479 }, -- Umbral Intensity
				{ 20, 189776 }, -- Girdle of the First Gate
				{ 21, 180944 }, -- Merciless Bonegrinder
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
				{ 1,  189811 }, -- Infinitely Collapsing Coil
				{ 2,  189815 }, -- Lurking Predator's Camouflage
				{ 3,  189819 }, -- Assimilated Safeguard
				{ 4,  181980 }, -- Embrace Death
				{ 5,  181469 }, -- Indelible Victory
				{ 6,  189812 }, -- Devourer's Sandblown Hidebinders
				{ 7,  181508 }, -- Fortifying Ingredients
				{ 8,  183167 }, -- Strength of the Pack
				{ 9,  181838 }, -- Charitable Soul
				{ 10, 189809 }, -- Skolex's Ravenous Skinguards
				{ 11, 182466 }, -- Shade of Terror
				{ 12, 188267 }, -- Bells of the Endless Feast
				{ 13, 182110 }, -- Crippling Hex
				{ 14, 189810 }, -- Ephemera-Softened Exoskeleton
				{ 15, 189814 }, -- Gluttonous Gardbrace
				{ 16, 189817 }, -- Rift-Scarred Solcrusher
				{ 17, 189813 }, -- Mantle of the Broken Beast
				{ 18, 183502 }, -- Prepared for All
				{ 19, 183484 }, -- Unchecked Aggression
				{ 20, 182383 }, -- Dancing with Fate
				{ 21, 182336 }, -- Golden Path
				{ 22, 189816 }, -- Crystallized Viscera Spike
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
				{ 1,  181844 }, -- Pain Transformation
				{ 2,  188265 }, -- Cache of Acquired Treasures
				{ 3,  189823 }, -- Stolen Nathrian Slippers
				{ 4,  189827 }, -- Cartel Xy's Proof of Initiation
				{ 5,  183488 }, -- Unstoppable Growth
				{ 6,  181756 }, -- Incantation of Swiftness
				{ 7,  189824 }, -- Unlicensed Hyperlight Handlers
				{ 8,  189828 }, -- Xy Captain's Crossbow
				{ 9,  180935 }, -- Crash the Ramparts
				{ 10, 189821 }, -- Illicit Artifact Holster
				{ 11, 189825 }, -- Veiled Auctioneer's Vambraces
				{ 12, 189829 }, -- Forerunner's Relic Blade
				{ 13, 188266 }, -- Pulsating Riftshard
				{ 14, 182128 }, -- Call of Flame
				{ 15, 182469 }, -- Rejuvenating Wind
				{ 16, 183506 }, -- Lethal Poisons
				{ 17, 189822 }, -- Imported Illidari Spaulders
				{ 18, 189826 }, -- Enforcer's Containment Cinch
				{ 19, 189830 }, -- Replicated Relic Blade
				{ 20, 181836 }, -- Spirit Drain
				{ 21, 182743 }, -- Focused Malignancy
				{ 22, 182667 }, -- Focused Light
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
				{ 1,  189784 }, -- Epaulets of the Ailing Aria
				{ 2,  189788 }, -- Maestro's Malice
				{ 3,  189773 }, -- Clasp of Crooked Crescendos
				{ 4,  181504 }, -- Infernal Cascade
				{ 5,  189785 }, -- Oracle's Chromatic Cuirass
				{ 6,  189793 }, -- Sash of the Silent Sonata
				{ 7,  181776 }, -- Vicious Contempt
				{ 8,  182648 }, -- Sharpshooter's Focus
				{ 9,  189782 }, -- Haunting Hymnal Robes
				{ 10, 189786 }, -- Song-Mad Sabatons
				{ 11, 189790 }, -- Final Forte
				{ 12, 182134 }, -- Unruly Winds
				{ 13, 181866 }, -- Withering Plague
				{ 14, 182677 }, -- Punish the Guilty
				{ 15, 183510 }, -- Count the Odds
				{ 16, 188272 }, -- Resonant Reservoir
				{ 17, 182471 }, -- Soul Furnace
				{ 18, 189791 }, -- Drape of Mournful Melodies
				{ 19, 189787 }, -- Dausegne's Dissonant Halo
				{ 20, 181942 }, -- Focused Mending
				{ 21, 181495 }, -- Jade Bond
				{ 22, 189807 }, -- Discordant Deathblade
				{ 23, 182751 }, -- Tyrant's Soul
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
				{ 1,   183472 }, -- Evolved Swarm
				{ 2,   182346 }, -- Tumbling Waves
				{ 3,   189796 }, -- Duty's Ascendant Breastplate
				{ 4,   182685 }, -- Increased Scrutiny
				{ 5,   182646 }, -- Repeat Decree
				{ 6,   182339 }, -- Necrotic Barrage
				{ 7,   182347 }, -- Essential Extraction
				{ 8,   182292 }, -- Brutal Grasp
				{ 9,   189797 }, -- Wristwraps of Night's Renewal
				{ 10,  182442 }, -- Veteran's Repute
				{ 11,  182962 }, -- Catastrophic Origin
				{ 12,  183474 }, -- Endless Thirst
				{ 13,  182348 }, -- Lavish Harvest
				{ 14,  181600 }, -- Ire of the Ascended
				{ 15,  189798 }, -- Moccasins of Dreadful Absolution
				{ 16,  181553 }, -- Gift of the Lich
				{ 17,  183199 }, -- Withering Ground
				{ 18,  188271 }, -- The First Sigil
				{ 19,  189789 }, -- Pursuit of Victory
				{ 20,  181774 }, -- Imbued Reflections
				{ 21,  189783 }, -- Sin-Steeped Coronet
				{ 22,  182961 }, -- Fatal Decimation
				{ 23,  189799 }, -- Elysia's Promise
				{ 24,  182331 }, -- Empowered Release
				{ 25,  182129 }, -- Fae Fermata
				{ 26,  182767 }, -- The Long Summer
				{ 27,  182964 }, -- Soul Eater
				{ 28,  181775 }, -- Way of the Fae
				{ 29,  181639 }, -- Siphoned Malice
				{ 30,  181539 }, -- Discipline of the Grove
				{ 101, 189800 }, -- Prelude to Pride
				{ 102, 189795 }, -- Winter's Stampeding Striders
				{ 103, 182130 }, -- Shattered Perceptions
				{ 104, 183493 }, -- Sudden Fractures
				{ 105, 182335 }, -- Spirit Attunement
				{ 106, 183471 }, -- Deep Allegiance
				{ 107, 182288 }, -- Impenetrable Gloom
				{ 108, 181981 }, -- Festering Transfusion
				{ 109, 181770 }, -- Bone Marrow Hops
				{ 110, 183463 }, -- Unnatural Malice
				{ 111, 182778 }, -- Ringing Clarity
				{ 112, 182706 }, -- Brooding Pool
				{ 113, 182777 }, -- Hallowed Discernment
				{ 114, 189794 }, -- Boots of Ceaseless Conflict
				{ 115, 181974 }, -- Courageous Ascension
				{ 116, 183494 }, -- Septic Shock
				{ 117, 183492 }, -- Reverberation
				{ 118, 182651 }, -- Destructive Reverberations
				{ 119, 182321 }, -- Enfeebled Mark
				{ 120, 182770 }, -- Righteous Might
				{ 121, 182463 }, -- Harrowing Punishment
				{ 122, 182345 }, -- Elysian Dirge
				{ 123, 182295 }, -- Proliferation
				{ 124, 183495 }, -- Lashing Scars
				{ 125, 181759 }, -- Strike with Clarity
				{ 126, 182440 }, -- Piercing Verdict
				{ 127, 188270 }, -- Elegy of the Eternals
				{ 128, 182960 }, -- Soul Tithe
				{ 129, 183473 }, -- Conflux of Elements
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
				{ 1,  188269 }, -- Pocket Protoforge
				{ 2,  182755 }, -- Ashen Remains
				{ 3,  182608 }, -- Virtuous Command
				{ 4,  189804 }, -- Combustible Collaboration Girdle
				{ 5,  189808 }, -- Lihuvim's Severing Scalpel
				{ 6,  182624 }, -- Show of Force
				{ 7,  182140 }, -- Dissonant Echoes
				{ 8,  189801 }, -- Ephemera-Charged Thinking Cap
				{ 9,  181435 }, -- Calculated Strikes
				{ 10, 183482 }, -- Sudden Ambush
				{ 11, 181982 }, -- Everfrost
				{ 12, 189754 }, -- Genesis Lathe
				{ 13, 189802 }, -- Loquacious Keeper's Peridot
				{ 14, 191015 }, -- Mystic Hand Module
				{ 15, 189805 }, -- Bracers of the Inscrutable Inventor
				{ 16, 191017 }, -- Zenith Hand Module
				{ 17, 188268 }, -- Architect's Ingenuity Core
				{ 18, 182143 }, -- Swirling Currents
				{ 19, 181455 }, -- Icy Propulsion
				{ 20, 183512 }, -- Planned Execution
				{ 21, 189803 }, -- Automa-Tender's Tights
				{ 22, 191016 }, -- Venerated Hand Module
				{ 23, 191014 }, -- Dreadful Hand Module
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
				{ 1,  191020 }, -- Venerated Leg Module
				{ 2,  181511 }, -- Nether Precision
				{ 3,  182325 }, -- Ravenous Consumption
				{ 4,  183507 }, -- Triple Threat
				{ 5,  191021 }, -- Zenith Leg Module
				{ 6,  182748 }, -- Borne of Blood
				{ 7,  189832 }, -- Greatboots of the Roaming Goliath
				{ 8,  191018 }, -- Dreadful Leg Module
				{ 9,  182621 }, -- One With the Beast
				{ 10, 183478 }, -- Fury of the Skies
				{ 11, 182137 }, -- Magma Fist
				{ 12, 188263 }, -- Reclaimer's Intensity Core
				{ 13, 189833 }, -- Taciturn Keeper's Lapis
				{ 14, 189806 }, -- Lightshatter Hatchet
				{ 15, 191019 }, -- Mystic Leg Module
				{ 16, 188264 }, -- Earthbreaker's Impact
				{ 17, 181944 }, -- Resonant Words
				{ 18, 181700 }, -- Scalding Brew
				{ 19, 189834 }, -- Guardstaff of the Great Cycle
				{ 20, 189781 }, -- Obscured Fractal Prism
				{ 21, 181712 }, -- Depths of Insanity
				{ 22, 189831 }, -- Ephemera-Stained Sollerets
				{ 23, 182187 }, -- Meat Shield
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
				{ 1,  182681 }, -- Vengeful Shock
				{ 2,  181848 }, -- Accelerated Cold
				{ 3,  191005 }, -- Dreadful Helm Module
				{ 4,  183197 }, -- Controlled Destruction
				{ 5,  189835 }, -- Anduin's Princely Vestments
				{ 6,  189839 }, -- Soulwarped Seal of Wrynn
				{ 7,  188262 }, -- The Lion's Roar
				{ 8,  182686 }, -- Powerful Precision
				{ 9,  191002 }, -- Mystic Helm Module
				{ 10, 181737 }, -- Nourishing Chi
				{ 11, 189836 }, -- Wrists of the Wicked Star
				{ 12, 189840 }, -- Remnant's Blasphemous Scourgebelt
				{ 13, 191003 }, -- Venerated Helm Module
				{ 14, 180932 }, -- Fueled by Violence
				{ 15, 182769 }, -- Combusting Engine
				{ 16, 189841 }, -- Soulwarped Seal of Menethil
				{ 17, 189837 }, -- King's Wolfheart Waistband
				{ 18, 191004 }, -- Zenith Helm Module
				{ 19, 182142 }, -- Embrace of Earth
				{ 20, 189838 }, -- Beacon of Stormwind
				{ 21, 183514 }, -- Perforated Veins
				{ 22, 183480 }, -- Taste for Blood
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
				{ 1,  188261 }, -- Intrusive Thoughtcage
				{ 2,  181786 }, -- Eternal Hunger
				{ 3,  191009 }, -- Zenith Shoulder Module
				{ 4,  182465 }, -- Truth's Wake
				{ 5,  189847 }, -- Shroud of the Sire's Chosen
				{ 6,  191006 }, -- Dreadful Shoulder Module
				{ 7,  181462 }, -- Coordinated Offensive
				{ 8,  181962 }, -- Mental Recovery
				{ 9,  183485 }, -- Savage Combatant
				{ 10, 189844 }, -- Gauntlets of Unseen Guests
				{ 11, 182598 }, -- Demon Muzzle
				{ 12, 191007 }, -- Mystic Shoulder Module
				{ 13, 189842 }, -- Cuffs of the Covert Commander
				{ 14, 189845 }, -- Ruined Crest of Lordaeron
				{ 15, 183184 }, -- Stinging Strike
				{ 16, 188255 }, -- Heart of the Swarm
				{ 17, 189843 }, -- Grasps of Abducted Fate
				{ 18, 191008 }, -- Venerated Shoulder Module
				{ 19, 182109 }, -- Totemic Surge
				{ 20, 181461 }, -- Ice Bite
				{ 21, 189846 }, -- Alandien's Tortured Twinblades
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
				{ 1,  189850 }, -- Handguards of Hidden Realms
				{ 2,  183468 }, -- Born Anew
				{ 3,  191013 }, -- Zenith Chest Module
				{ 4,  182461 }, -- Echoing Blessings
				{ 5,  189851 }, -- Devastated Worldshard
				{ 6,  191010 }, -- Dreadful Chest Module
				{ 7,  180943 }, -- Cacophonous Roar
				{ 8,  189848 }, -- Treads of Titanic Curiosity
				{ 9,  189852 }, -- Antumbra, Shadow of the Cosmos
				{ 10, 191011 }, -- Mystic Chest Module
				{ 11, 181498 }, -- Grounding Surge
				{ 12, 189854 }, -- Rygelon's Heraldric Ring
				{ 13, 189849 }, -- Interdimensional Manica
				{ 14, 189853 }, -- Astral Verdict
				{ 15, 188254 }, -- Grim Eclipse
				{ 16, 182368 }, -- Relentless Onslaught
				{ 17, 191012 }, -- Venerated Chest Module
				{ 18, 183497 }, -- Recuperator
				{ 19, 191001 }, -- Observer's Umbral Shiv
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
				{ 1,  183491 }, -- Ready for Anything
				{ 2,  182131 }, -- Haunting Apparitions
				{ 3,  182480 }, -- Reversal of Fortune
				{ 4,  189862 }, -- Gavel of the First Arbiter
				{ 5,  182318 }, -- Viscous Ink
				{ 6,  189855 }, -- Bindings of the Banished One
				{ 7,  189859 }, -- Worldkiller Iris
				{ 8,  189856 }, -- Runecarver's Twisted Ward
				{ 9,  189860 }, -- Forbidden Truth
				{ 10, 188252 }, -- Chains of Domination
				{ 11, 182449 }, -- Resolute Barrier
				{ 12, 189818 }, -- Domination's Deliverance
				{ 13, 181975 }, -- Hardened Bones
				{ 14, 189857 }, -- Epochal Oppressor's Greaves
				{ 15, 189861 }, -- Zovastrum, the Unmaking
				{ 16, 188253 }, -- Scars of Fraternal Strife
				{ 17, 181510 }, -- Lingering Numbness
				{ 18, 189858 }, -- Legguards of the Ultimate Threat
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
	}
}
