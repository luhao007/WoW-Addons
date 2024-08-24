-- $Id: Collections.lua 18 2022-12-12 16:40:25Z arithmandar $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local _, private = ...
local AtlasLoot = _G.AtlasLoot
local data = private.data
local AL = AtlasLoot.Locales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", {
	Item = {
		item1bonus = "Scaling",
		addDifficultyBonus = true,
	},
}, 1)
-- change sortorder for factions
local ALLIANCE_DIFF, HORDE_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
end

--local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local NORMAL_ITTYPE = data:GetItemTableType("Item")
local I_A_ITTYPE  = data:AddItemTableType("Item", "Achievement")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")

local COLLECTION_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTION_COLOR)
--local FACTION_CONTENT = data:AddContentType(AL["Factions"], ATLASLOOT_FACTION_COLOR)
--local MOUNT_CONTENT = data:AddContentType(AL["Mounts"], ATLASLOOT_COLLECTION_COLOR)


-- /////////////////////////////////
-- Faction
-- /////////////////////////////////
--[[
	-- rep info ("f1435rep3" = Unfriendly rep @ Shado-Pan Assault)
	1. Hated
	2. Hostile
	3. Unfriendly
	4. Neutral
	5. Friendly
	6. Honored
	7. Revered
	8. Exalted
	-- if rep index is in between 11 and 16, means it has friendship reputation
]]

data["SHADOWLANDSFACTIONS"] = {
	name = FACTION,
	ContentType = COLLECTION_CONTENT,
	items = { 
		{ -- The Ascended
			FactionID = 2407,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2407rep5" }, -- Friendly
				{ 2, 173051, }, -- Contract: The Ascended
				{ 3, 183098, [PRICE_EXTRA_ITTYPE] = "money:760" }, -- Technique: Codex of the Still Mind
				
				{ 5, "f2407rep6" }, -- Honored
				{ 6, 184756, [PRICE_EXTRA_ITTYPE] = "money:1816968" }, -- Smoothed Loop of Contemplation
				{ 7, 183094, [PRICE_EXTRA_ITTYPE] = "money:199500" }, -- Plans: Shadowsteel Helm
				
				{ 9, "f2407rep7" }, -- Revered
				{ 10, 183103, [PRICE_EXTRA_ITTYPE] = "money:17650000" }, -- Technique: Contract: The Ascended
				{ 11, 184732, [PRICE_EXTRA_ITTYPE] = "money:1556738" }, -- Manacles of Burden
				{ 12, 184734, [PRICE_EXTRA_ITTYPE] = "money:1567831" }, -- Bracers of Regret
				{ 13, 184735, [PRICE_EXTRA_ITTYPE] = "money:1573227" }, -- Wristclasps of Shame
				{ 14, 184733, [PRICE_EXTRA_ITTYPE] = "money:1562284" }, -- Wristclamps of Remorse
				
				{ 16, "f2407rep8" }, -- Exalted
				{ 17, 184351, [PRICE_EXTRA_ITTYPE] = "money:12500000" }, -- Illusion: Devoted Spirit
				{ 18, 183097, [PRICE_EXTRA_ITTYPE] = "money:38" }, -- Schematic: PHA7-YNX
				{ 19, 184729, [PRICE_EXTRA_ITTYPE] = "money:3091417" }, -- Masque of the Path
				{ 20, 184728, [PRICE_EXTRA_ITTYPE] = "money:3080285" }, -- Casque of the Path
				{ 21, 184730, [PRICE_EXTRA_ITTYPE] = "money:3102549" }, -- Cowl of the Path
				{ 22, 184731, [PRICE_EXTRA_ITTYPE] = "money:3113380" }, -- Gorget of the Path
				{ 23, 178991, [PRICE_EXTRA_ITTYPE] = "money:95000" }, -- Tabard of the Ascended
			},
		},
		-- thanks for serious2 added below
		{ -- Court of Harvesters
			FactionID = 2413,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2413rep5" }, -- Friendly
				{ 2, 177665, [PRICE_EXTRA_ITTYPE] = "money:250000" }, --Spectral Handkerchief
				{ 4, "f2413rep6" }, -- Honored
				{ 5, 183900, [PRICE_EXTRA_ITTYPE] = "money:13500000" }, --Sinvyr Tea Set
				{ 6, 183099, [PRICE_EXTRA_ITTYPE] = "money:13500000" }, --Design: Revitalizing Jewel Doublet
				{ 7, 184723, [PRICE_EXTRA_ITTYPE] = "money:1520000" }, --Bedazzled Belt
				{ 8, 184720, [PRICE_EXTRA_ITTYPE] = "money:1520000" }, --Reflective Waistguard
				{ 9, 184721, [PRICE_EXTRA_ITTYPE] = "money:1520000" }, --Flourished Cummerbund
				{ 10, 184722, [PRICE_EXTRA_ITTYPE] = "money:1520000" }, --Ostentatious Buckle
				{ 12, "f2413rep7" }, -- Revered
				{ 13, 180593, [PRICE_EXTRA_ITTYPE] = "PetCharm:250" }, --Court Messenger Scroll
				{ 14, 183708, [PRICE_EXTRA_ITTYPE] = "reservoiranima:3500" }, --Glittering Gold Sinstone Chain
				{ 15, 182668, [PRICE_EXTRA_ITTYPE] = "money:17650000" }, --Recipe: Feast of Gluttonous Hedonism
				{ 16, 183102, [PRICE_EXTRA_ITTYPE] = "money:17650000" }, --Technique: Contract: Court of Harvesters
				{ 17, 184724, [PRICE_EXTRA_ITTYPE] = "money:2370000" }, --Courtier's Pauldron
				{ 18, 184726, [PRICE_EXTRA_ITTYPE] = "money:2370000" }, --Courtier's Mantle
				{ 19, 184727, [PRICE_EXTRA_ITTYPE] = "money:2370000" }, --Courtier's Shoulderguard
				{ 20, 184725, [PRICE_EXTRA_ITTYPE] = "money:2370000" }, --Courtier's Shoulderplate
				{ 22, "f2413rep8" }, -- Exalted
				{ 23, 183518, [PRICE_EXTRA_ITTYPE] = "money:300000000" }, --Court Sinrunner
				{ 24, 182207, [PRICE_EXTRA_ITTYPE] = "money:12500000" }, --Illusion: Sinsedge
				{ 25, 179282, [PRICE_EXTRA_ITTYPE] = "money:2500000" }, --Court of Harvesters Tabard
				{ 26, 184755, [PRICE_EXTRA_ITTYPE] = "money:1980000" }, --Reinforced High Collar
			},
		},				
		{ -- Court of Night
			FactionID = 2464,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2464rep5" }, -- Friendly
				{ 2, 182182, [PRICE_EXTRA_ITTYPE] = "reservoiranima:1500:gratefuloffering:5" }, --Lupine Soul
				{ 3, 182174, [PRICE_EXTRA_ITTYPE] = "reservoiranima:1500:gratefuloffering:5" }, --Leonine Soul
				{ 4, 180636, [PRICE_EXTRA_ITTYPE] = "PetCharm:250:gratefuloffering:5" }, --Willowbreeze
				{ 5, 182664, [PRICE_EXTRA_ITTYPE] = "PetCharm:250:gratefuloffering:5" }, --Stemmins
				{ 7, "f2464rep6" }, -- Honored
				{ 8, 181308, [PRICE_EXTRA_ITTYPE] = "reservoiranima:3500:gratefuloffering:5" }, --Winterwoven Bulb
				{ 9, 181312, [PRICE_EXTRA_ITTYPE] = "reservoiranima:3500:gratefuloffering:5" }, --Winterwoven Pack
				{ 11, "f2464rep7" }, -- Revered
				{ 12, 183053, [PRICE_EXTRA_ITTYPE] = "reservoiranima:5000:gratefuloffering:5" }, --Umbral Scythehorn
				{ 13, 180415, [PRICE_EXTRA_ITTYPE] = "reservoiranima:5000:gratefuloffering:5" }, --Winterborn Runestag
				{ 16, "f2464rep8" }, -- Exalted
				{ 17, 184115, [PRICE_EXTRA_ITTYPE] = "reservoiranima:25000:gratefuloffering:5" }, --Ensemble: Winterborn Raiment
				{ 18, 184117, [PRICE_EXTRA_ITTYPE] = "reservoiranima:25000:gratefuloffering:5" }, --Ensemble: Winterborn Warbark
				{ 19, 184116, [PRICE_EXTRA_ITTYPE] = "reservoiranima:25000:gratefuloffering:5" }, --Ensemble: Winterborn Guise
				{ 20, 184114, [PRICE_EXTRA_ITTYPE] = "reservoiranima:25000:gratefuloffering:5" }, --Ensemble: Winterborn Regalia
			},			
		},
		{ -- Death's Advance
			FactionID = 2470,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2470rep5" }, -- Friendly
				{ 2, 186453, [PRICE_EXTRA_ITTYPE] = "stygia:1000" }, --Vault Anima Tracker
				{ 3, 186453, [PRICE_EXTRA_ITTYPE] = "stygia:1000" }, --Korthian Armaments
				{ 5, "f2470rep6" }, -- Honored
				{ 6, 186543, [PRICE_EXTRA_ITTYPE] = "PetCharm:50:stygia:1500" }, --Domestic Aunian
				{ 7, 186598, [PRICE_EXTRA_ITTYPE] = "stygia:2000" }, --Recipe: Crafter's Mark III
				{ 8, 187411, [PRICE_EXTRA_ITTYPE] = "stygia:500" }, --Mantle of Death's Advance
				{ 9, 187540, [PRICE_EXTRA_ITTYPE] = "stygia:2000" }, --Cincture of Enveloping Death
				{ 10, 187538, [PRICE_EXTRA_ITTYPE] = "stygia:2000" }, --Gloves of Advancing Death
				{ 11, 187541, [PRICE_EXTRA_ITTYPE] = "stygia:2000" }, --Chain of Encircling Death
				{ 12, 187539, [PRICE_EXTRA_ITTYPE] = "stygia:2000" }, --Gauntlets of Death's Guardian
				{ 13, 187218, [PRICE_EXTRA_ITTYPE] = "stygia:1000" }, --Tome of Origins
				{ 16, "f2470rep7" }, -- Revered
				{ 17, 186724, [PRICE_EXTRA_ITTYPE] = "stygia:2500" }, --Technique: Contract: Death's Advance
				{ 18, 186647, [PRICE_EXTRA_ITTYPE] = "stygia:5000" }, --Amber Shardhide
				{ 101, "f2470rep8" }, -- Exalted
				{ 102, 186997, [PRICE_EXTRA_ITTYPE] = "stygia:3000" }, --Death's Advance Tabard
				{ 103, 186517, [PRICE_EXTRA_ITTYPE] = "stygia:6000" }, --Ensemble: Battlefield Messenger's Regalia
				{ 104, 186504, [PRICE_EXTRA_ITTYPE] = "stygia:6000" }, --Ensemble: Frontline Necromancer's Vestments
				{ 105, 186499, [PRICE_EXTRA_ITTYPE] = "stygia:6000" }, --Ensemble: Garb of Fall's Promise
				{ 106, 186512, [PRICE_EXTRA_ITTYPE] = "stygia:6000" }, --Ensemble: Renathal's Field Inquisitor's Vestments
				{ 107, 186511, [PRICE_EXTRA_ITTYPE] = "stygia:6000" }, --Ensemble: Renathal's Battlefield Attire
				{ 108, 186480, [PRICE_EXTRA_ITTYPE] = "stygia:1000" }, --Battle-Hardened Aquilon
				{ 109, 186490, [PRICE_EXTRA_ITTYPE] = "stygia:1000" }, --Battlefield Swarmer Harness
				{ 110, 186495, [PRICE_EXTRA_ITTYPE] = "stygia:1000" }, --Winter Wilderling Harness
				{ 111, 186477, [PRICE_EXTRA_ITTYPE] = "stygia:1000" }, --Pale Gravewing
			},			
		},				
		{ -- The Archivists' Codex
			FactionID = 2472,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2472rep17" }, -- Rank1
				{ 2, 187508, }, -- Trained Gromit Carrier
				{ 4, "f2472rep18" }, -- Rank2
				{ 5, 186714, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:100" }, --Research Report: All-Seeing Crystal
				{ 6, 187145, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:800" }, --Treatise: Recognizing Stygia and its Uses
				{ 8, "f2472rep19" }, -- Rank3
				{ 9, 186718, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:50" }, -- Teleporter Repair Kit
				{ 11, "f2472rep20" }, -- Rank4
				{ 12, 186731, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:100" }, -- Repaired Riftkey
				{ 13, 186991, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:2000" }, -- Transmute: Stones to Ore
				{ 14, 186470, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:2500" }, -- Recipe: Crafter's Mark of the Chained Isle
				{ 15, 187706, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:1000" }, -- Treatise: Bonds of Stygia in Mortals
				{ 16, "f2472rep21" }, -- Rank5
				{ 17, 187409, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:500" }, -- Cloak of the Korthian Scholar
				{ 18, 186716, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:1000" }, -- Research Report: Ancient Shrines
				{ 19, 186722, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:1500" }, -- Treatise: The Study of Anima and Harnessing Every Drop
				{ 101, "f2472rep22" }, -- Rank6
				{ 102, 186648, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:5000" }, -- Soaring Razorwing
				{ 103, 187535, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:4000" }, -- Attendant Scholar's Waistcord
				{ 104, 187537, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:4000" }, -- Subtle Mortality Manipulators
				{ 105, 187534, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:4000" }, -- Korthite Crystal Waistguard
				{ 106, 187536, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:4000" }, -- Prototype Guardian Grips
				{ 107, 186721, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:2000" }, -- Treatise: Relics Abound in the Shadowlands
				{ 108, 187148, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:3000" }, -- Death-Bound Shard
				{ 109, 187134, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:5000" }, -- Alloy-Warping Facetor
				{ 110, 186717, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:4000" }, -- Research Report: Adaptive Alloys
				{ 111, 187138, [PRICE_EXTRA_ITTYPE] = "catalogedresearch:8000" }, -- Research Report: First Alloys				
			},
		},
		{ -- The Avowed
			FactionID = 2439,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2439rep6" }, -- Honored
				{ 2, 182660, [PRICE_EXTRA_ITTYPE] = "sinstonefragments:35" }, --Recipe: Shadestone
				{ 3, 184222, [PRICE_EXTRA_ITTYPE] = "sinstonefragments:350" }, --Lemet's Requisition Orders
				{ 5, "f2439rep7" }, -- Revered
				{ 6, 184219, [PRICE_EXTRA_ITTYPE] = "sinstonefragments:600" }, --Treatise on Sinstone Fragment Acquisition
				{ 7, 182890, [PRICE_EXTRA_ITTYPE] = "sinstonefragments:500" }, --Rapid Recitation Quill
				{ 8, 180940, [PRICE_EXTRA_ITTYPE] = "sinstonefragments:500" }, --Ebony Crypt Keeper's Mantle
				{ 10, "f2439rep8" }, -- Exalted
				{ 11, 184220, [PRICE_EXTRA_ITTYPE] = "sinstonefragments:1200" }, --Encyclopedia of Sinstone Fragment Recovery
				{ 12, 182954, [PRICE_EXTRA_ITTYPE] = "sinstonefragments:2000" }, --Inquisition Gargon
				{ 13, 184221, [PRICE_EXTRA_ITTYPE] = "sinstonefragments:1000" }, --Archivist's Quill
				{ 14, 184218, [PRICE_EXTRA_ITTYPE] = "sinstonefragments:1000" }, --Vulgarity Arbiter
			},
		},
		{ -- The Undying Army
			FactionID = 2410,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2410rep5" }, -- Friendly
				{ 2, 183112, [PRICE_EXTRA_ITTYPE] = "PetCharm:250" }, --Animated Radius
				{ 4, "f2410rep6" }, -- Honored
				{ 5, 184741, [PRICE_EXTRA_ITTYPE] = "money:1550000" }, --Apprentice Necromancer's Gloves
				{ 6, 184739, [PRICE_EXTRA_ITTYPE] = "money:1500000" }, --Pallid Stitched Gloves
				{ 7, 184742, [PRICE_EXTRA_ITTYPE] = "money:1560000" }, --Rattling Bonefists
				{ 8, 184740, [PRICE_EXTRA_ITTYPE] = "money:1560000" }, --Fortified Jawcrackers
				{ 9, 183095, [PRICE_EXTRA_ITTYPE] = "money:13500000" }, --Plans: Shadowsteel Pauldrons
				{ 10, 183101, [PRICE_EXTRA_ITTYPE] = "money:1910000" }, --Pattern: Shadowlace Cloak
				{ 11, 183858, [PRICE_EXTRA_ITTYPE] = "money:1910000" }, --Schematic: Wormhole Generator: Shadowlands
				{ 16, "f2410rep7" }, -- Revered
				{ 17, 181272, [PRICE_EXTRA_ITTYPE] = "money:17650000" }, --Toenail
				{ 18, 183104, [PRICE_EXTRA_ITTYPE] = "money:17650000" }, --Technique: Contract: The Undying Army
				{ 19, 184744, [PRICE_EXTRA_ITTYPE] = "money:1990000" }, --Gnarled Boneloop
				{ 20, 183244, [PRICE_EXTRA_ITTYPE] = "money:10450000" }, --Memory of the Rattle of the Maw
				{ 101, "f2410rep8" }, -- Exalted
				{ 102, 184736, [PRICE_EXTRA_ITTYPE] = "money:3020000" }, --Robe of the March Warden
				{ 103, 184745, [PRICE_EXTRA_ITTYPE] = "money:3210000" }, --Tunic of the March Warden
				{ 104, 184738, [PRICE_EXTRA_ITTYPE] = "money:3040000" }, --Chainmail of the March Warden
				{ 105, 184737, [PRICE_EXTRA_ITTYPE] = "money:3030000" }, --Chestplate of the March Warden
				{ 106, 183189, [PRICE_EXTRA_ITTYPE] = "money:12500000" }, --Illusion: Undying Spirit
				{ 107, 182082, [PRICE_EXTRA_ITTYPE] = "money:300000000" }, --Lurid Bloodtusk
				{ 108, 180456, [PRICE_EXTRA_ITTYPE] = "money:2500000" }, --Colors of the Undying Army
				{ 109, 181807, [PRICE_EXTRA_ITTYPE] = "money:5000000" }, --Barbarous Osteowings
				{ 110, 181808, [PRICE_EXTRA_ITTYPE] = "money:5000000" }, --Death Fetish
			},
		},
		{ -- The Wild Hunt
			FactionID = 2465,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2465rep5" }, -- Friendly
				{ 2, 180641, [PRICE_EXTRA_ITTYPE] = "PetCharm:250" }, --Floofa
				{ 4, "f2465rep6" }, -- Honored
				{ 5, 182168, [PRICE_EXTRA_ITTYPE] = "reservoiranima:1500" }, --Crane Soul
				{ 6, 183100, [PRICE_EXTRA_ITTYPE] = "money:11470000" }, --Pattern: Heavy Desolate Armor Kit
				{ 7, 183096, [PRICE_EXTRA_ITTYPE] = "money:11470000" }, --Formula: Sacred Shard
				{ 8, 184754, [PRICE_EXTRA_ITTYPE] = "money:2060000" }, --Glitterwing Scarf
				{ 10, "f2465rep7" }, -- Revered
				{ 11, 183093, [PRICE_EXTRA_ITTYPE] = "money:15000000" }, --Technique: Contract: The Wild Hunt
				{ 12, 183106, [PRICE_EXTRA_ITTYPE] = "money:15000000" }, --Recipe: Eternal Cauldron
				{ 13, 181309, [PRICE_EXTRA_ITTYPE] = "reservoiranima:3500" }, --Faewoven Pack
				{ 14, 184747, [PRICE_EXTRA_ITTYPE] = "money:2060000" }, --Gamekeeper's Slippers
				{ 15, 184746, [PRICE_EXTRA_ITTYPE] = "money:2060000" }, --Gametender's Muckstompers
				{ 16, 184748, [PRICE_EXTRA_ITTYPE] = "money:2060000" }, --Gametender's Wading Boots
				{ 17, 184749, [PRICE_EXTRA_ITTYPE] = "money:2060000" }, --Gametender's Bramblewards
				{ 19, "f2465rep8" }, -- Exalted
				{ 20, 183134, [PRICE_EXTRA_ITTYPE] = "money:10620000" }, --Illusion: Hunt's Favor
				{ 21, 184752, [PRICE_EXTRA_ITTYPE] = "money:4390000" }, --Gormscale Leggings
				{ 22, 184753, [PRICE_EXTRA_ITTYPE] = "money:4390000" }, --Tree-Scaler's Britches
				{ 23, 184751, [PRICE_EXTRA_ITTYPE] = "money:4390000" }, --Cycle-Tender's Pantaloons
				{ 24, 184750, [PRICE_EXTRA_ITTYPE] = "money:4390000" }, --Amber-Plated Legguards
				{ 25, 180729, [PRICE_EXTRA_ITTYPE] = "money:255000000" }, --Duskflutter Ardenmoth
				{ 26, 178336, [PRICE_EXTRA_ITTYPE] = "money:2120000" }, --Tabard of the Wild Hunt
			},
		},
		{ -- Ve'nari
			FactionID = 2432,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2432rep23" }, -- Dubious
				{ 2, 180817, [PRICE_EXTRA_ITTYPE] = "stygia:60" }, --Cypher of Relocation
				{ 4, "f2432rep24" }, -- Apprehensive
				{ 5, 184620, [PRICE_EXTRA_ITTYPE] = "stygia:527" }, --Vessel of Unfortunate Spirits
				{ 6, 184615, [PRICE_EXTRA_ITTYPE] = "stygia:800" }, --Extradimensional Pockets
				{ 7, 180953, [PRICE_EXTRA_ITTYPE] = "stygia:205" }, --Soultwinning Scepter
				{ 8, 181245, [PRICE_EXTRA_ITTYPE] = "stygia:165" }, --Oil of Ethereal Force
				{ 10, "f2432rep25" }, -- Tentative
				{ 11, 184617, [PRICE_EXTRA_ITTYPE] = "stygia:1135" }, --Bangle of Seniority
				{ 12, 184605, [PRICE_EXTRA_ITTYPE] = "stygia:666" }, --Sigil of the Unseen
				{ 13, 184653, [PRICE_EXTRA_ITTYPE] = "stygia:1050" }, --Animated Levitating Chain
				{ 14, 180949, [PRICE_EXTRA_ITTYPE] = "stygia:1650" }, --Animaflow Stabilizer
				{ 15, 184651, [PRICE_EXTRA_ITTYPE] = "stygia:230" }, --Maw-Touched Miasma
				{ 16, 184664, [PRICE_EXTRA_ITTYPE] = "stygia:210" }, --Sticky-Fingered Skeletal Hand
				{ 19, "f2432rep26" }, -- Ambivalent
				{ 20, 184588, [PRICE_EXTRA_ITTYPE] = "stygia:775" }, --Soul-Stabilizing Talisman
				{ 21, 184621, [PRICE_EXTRA_ITTYPE] = "stygia:1025" }, --Ritual Prism of Fortune
				{ 22, 184652, [PRICE_EXTRA_ITTYPE] = "stygia:3760" }, --Phantasmic Infuser
				{ 23, 183248, [PRICE_EXTRA_ITTYPE] = "stygia:4986" }, --Memory of Jailer's Eye
				{ 101, "f2432rep27" }, -- Cordial
				{ 102, 184619, [PRICE_EXTRA_ITTYPE] = "stygia:1330" }, --Loupe of Unusual Charm
				{ 103, 184618, [PRICE_EXTRA_ITTYPE] = "stygia:1575" }, --Rank Insignia: Acquisitionist
				{ 104, 183870, [PRICE_EXTRA_ITTYPE] = "stygia:300" }, --Recipe: Crafter's Mark II
				{ 106, "f2432rep28" }, -- Appreciative
				{ 107, 180952, [PRICE_EXTRA_ITTYPE] = "stygia:1525" }, --Possibility Matrix
				{ 108, 184901, [PRICE_EXTRA_ITTYPE] = "stygia:875" }, --Broker Traversal Enhancer
			},
		},
	}
}

data["MOUNTS"] = {
	name = AL["Mounts"],
	ContentType = COLLECTION_CONTENT,
	TableType = NORMAL_ITTYPE,
	items = 
	{
		{
			name = AL["Mounts"],
			[NORMAL_DIFF] = {
				{   1, 180263, "mount" }, -- Dreamlight Runestag
				{   2, 180413, "mount" }, -- Shadeleaf Runestag
				{   3, 180414, "mount" }, -- Wakener's Runestag
				{   4, 180415, "mount" }, -- Winterborn Runestag
				{   5, 180461, "mount" }, -- Horrid Dredwing
				{   6, 180581, "mount" }, -- Hopecrusher Gargon
				{   7, 180582, "mount" }, -- Endmire Flyer Tether
				{   8, 180721, "mount" }, -- Enchanted Dreamlight Runestag
				{   9, 180722, "mount" }, -- Enchanted Shadeleaf Runestag
				{  10, 180723, "mount" }, -- Enchanted Wakener's Runestag
				{  11, 180724, "mount" }, -- Enchanted Winterborn Runestag
				{  12, 180725, "mount" }, -- Spinemaw Gladechewer
				{  13, 180726, "mount" }, -- Pale Acidmaw
				{  14, 180727, "mount" }, -- Shimmermist Runner
				{  15, 180728, "mount" }, -- Swift Gloomhoof
				{  16, 180729, "mount" }, -- Duskflutter Ardenmoth
				{  17, 180730, "mount" }, -- Wild Glimmerfur Prowler
				{  18, 180731, "mount" }, -- Wildseed Cradle
				{  19, 180748, "mount" }, -- Silky Shimmermoth
				{  20, 180761, "mount" }, -- Phalynx of Loyalty
				{  21, 180762, "mount" }, -- Phalynx of Humility
				{  22, 180763, "mount" }, -- Phalynx of Courage
				{  23, 180764, "mount" }, -- Phalynx of Purity
				{  24, 180765, "mount" }, -- Eternal Phalynx of Purity
				{  25, 180766, "mount" }, -- Eternal Phalynx of Courage
				{  26, 180767, "mount" }, -- Eternal Phalynx of Loyalty
				{  27, 180768, "mount" }, -- Eternal Phalynx of Humility
				{  28, 180772, "mount" }, -- Silverwind Larion
				{  29, 180773, "mount" }, -- Sundancer
				{  30, 180945, "mount" }, -- Crypt Gargon
				{ 101, 180948, "mount" }, -- Battle Gargon Vrednic
				{ 102, 181300, "mount" }, -- Gruesome Flayedwing
				{ 103, 181316, "mount" }, -- Silvertip Dredwing
				{ 104, 181317, "mount" }, -- Dauntless Duskrunner
				{ 105, 181815, "mount" }, -- Armored Bonehoof Tauralus
				{ 106, 181817 }, -- Deathbringer's Flayedwing
				{ 107, 181818, "mount" }, -- Chewed Reins of the Callow Flayedwing
				{ 108, 181819, "mount"}, -- Marrowfang's Reins
				{ 109, 181820, "mount" }, -- Armored Chosen Tauralus
				{ 110, 181821, "mount" }, -- Armored Plaguerot Tauralus
				{ 111, 181822, "mount" }, -- Armored War-Bred Tauralus
				{ 112, 182074, "mount" }, -- Chosen Tauralus
				{ 113, 182075, "mount" }, -- Bonehoof Tauralus
				{ 114, 182076, "mount" }, -- Plaguerot Tauralus
				{ 115, 182077, "mount" }, -- War-Bred Tauralus
				{ 116, 182078, "mount" }, -- Bonesewn Fleshroc
				{ 117, 182079, "mount" }, -- Slime-Covered Reins of the Hulking Deathroc
				{ 118, 182080, "mount" }, -- Predatory Plagueroc
				{ 119, 182081, "mount" }, -- Reins of the Colossal Slaughterclaw
				{ 120, 182082, "mount" }, -- Lurid Bloodtusk
				{ 121, 182083 }, -- Bonecleaver's Skullboar
				{ 122, 182084, "mount" }, -- Gorespine
				{ 123, 182085, "mount" }, -- Blisterback Bloodtusk
				{ 124, 182209, "mount" }, -- Desire's Battle Gargon
				{ 125, 182332, "mount" }, -- Gravestone Battle Armor
				{ 126, 182589, "mount" }, -- Loyal Gorger
				{ 127, 182596, "mount" }, -- Rampart Screecher
				{ 128, 182614, "mount" }, -- Blanchy's Reins
				{ 129, 182650, "mount" }, -- Arboreal Gulper
				{ 130, 182717, "mount" }, -- Sintouched Deathwalker
				{ 201, 182954, "mount" }, -- Inquisition Gargon
				{ 202, 183052, "mount" }, -- Darkwarren Hardshell
				{ 203, 183053, "mount" }, -- Umbral Scythehorn
				{ 204, 183518, "mount" }, -- Court Sinrunner
				{ 205, 183615, "mount" }, -- Warstitched Darkhound
				{ 206, 183617, "mount" }, -- Chittering Animite
				{ 207, 183618, "mount" }, -- Highwind Darkmane
				{ 208, 183715, "mount" }, -- Sinfall Gargon
				{ 209, 183740, "mount" }, -- Gilded Prowler
				{ 210, 183741, "mount" }, -- Ascended Skymane
				{ 211, 183798, "mount" }, -- Silessa's Battle Harness
				{ 212, 183800, "mount" }, -- Amber Ardenmoth
				{ 213, 183801, "mount" }, -- Vibrant Flutterwing
				{ 214, 183937, "mount" }, -- Sinful Gladiator's Soul Eater
				{ 215, 184013, "mount" }, -- Vicious War Spider
				{ 216, 184014, "mount" }, -- Vicious War Spider
				{ 217, 184062, "mount" }, -- Gnawed Reins of the Battle-Bound Warhound
				{ 218, 184160, "mount" }, -- Bulbous Necroray
				{ 219, 184161, "mount" }, -- Infested Necroray
				{ 220, 184162, "mount" }, -- Pestilent Necroray
				{ 221, 184166, "mount" }, -- Corridor Creeper
				{ 222, 184167, "mount" }, -- Mawsworn Soulhunter
				{ 223, 184168, "mount" }, -- Bound Shadehound
				{ 224, 184183, "mount" }, -- Voracious Gorger
				{ 225, 185973 }, -- Chain of Bahmethra
				{ 226, 185996, "mount" }, -- Harvester's Dredwing Saddle
				{ 227, 186000, "mount" }, -- Legsplitter War Harness
				{ 228, 186103, "mount" }, -- Undying Darkhound's Harness
				{ 229, 186177, "mount" }, -- Unchained Gladiator's Soul Eater
				{ 230, 186178, "mount" }, -- Vicious War Gorm
				{ 301, 186179, "mount" }, -- Vicious War Gorm
				{ 302, 186469, "mount" }, -- Illidari Doomhawk
				{ 303, 186476, "mount" }, -- Sinfall Gravewing
				{ 304, 186477, "mount" }, -- Pale Gravewing
				{ 305, 186478, "mount" }, -- Obsidian Gravewing
				{ 306, 186479, "mount" }, -- Mastercraft Gravewing
				{ 307, 186480, "mount" }, -- Battle-Hardened Aquilon
				{ 308, 186482, "mount" }, -- Elysian Aquilon
				{ 309, 186483, "mount" }, -- Forsworn Aquilon
				{ 310, 186485, "mount" }, -- Ascendant's Aquilon
				{ 311, 186487, "mount" }, -- Maldraxxian Corpsefly Harness
				{ 312, 186488, "mount" }, -- Regal Corpsefly Harness
				{ 313, 186489, "mount" }, -- Lord of the Corpseflies
				{ 314, 186490, "mount" }, -- Battlefield Swarmer Harness
				{ 315, 186491 }, -- Spring Wilderling Harness
				{ 316, 186492, "mount" }, -- Summer Wilderling Harness
				{ 317, 186493, "mount" }, -- Ardenweald Wilderling Harness
				{ 318, 186494, "mount" }, -- Autumnal Wilderling Harness
				{ 319, 186495, "mount" }, -- Winter Wilderling Harness
				{ 320, 186637, "mount" }, -- Tazavesh Gearglider
				{ 321, 186638, "mount" }, -- Cartel Master's Gearglider
				{ 322, 186639 }, -- Pilfered Gearglider
				{ 323, 186640 }, -- Silver Gearglider
				{ 324, 186641 }, -- Tamed Mauler Harness
				{ 325, 186642 }, -- Vengeance's Reins
				{ 326, 186643 }, -- Reins of the Wanderer
				{ 327, 186644, "mount" }, -- Beryl Shardhide
				{ 328, 186645, "mount" }, -- Crimson Shardhide
				{ 329, 186646, "mount" }, -- Darkmaul
				{ 330, 186647, "mount" }, -- Amber Shardhide
				{ 401, 186648, "mount" }, -- Soaring Razorwing
				{ 402, 186649, "mount" }, -- Fierce Razorwing
				{ 403, 186651, "mount" }, -- Dusklight Razorwing
				{ 404, 186652, "mount" }, -- Garnet Razorwing
				{ 405, 186653, "mount" }, -- Bracer of Hrestimorak
				{ 406, 186654, "mount" }, -- Bracelet of Salaranga
				{ 407, 186655, "mount" }, -- Mawsworn Charger's Reins
				{ 408, 186656, "mount" }, -- Sanctum Gloomcharger's Reins
				{ 409, 186657, "mount" }, -- Soulbound Gloomcharger's Reins
				{ 410, 186659, "mount" }, -- Fallen Charger's Reins
				{ 411, 186713, "mount" }, -- Nilganihmaht Control Ring
				{ 412, 187183, "mount" }, -- Rampaging Mauler
				{ 413, 187525, "mount" }, -- Soultwisted Deathwalker
				{ 414, 187595, "mount" }, -- Favor of the Val'sharah Hippogryph
				{ 415, 187629, "mount" }, -- Heartlight Stone
				{ 416, 187630, "mount" }, -- Curious Crystalsniffer
				{ 417, 187631, "mount" }, -- Darkened Vombata
				{ 418, 187632, "mount" }, -- Adorned Vombata
				{ 419, 187638, "mount" }, -- Deathrunner
				{ 420, 187639, "mount" }, -- Pale Regal Cervid
				{ 421, 187640, "mount" }, -- Anointed Protostag Reins
				{ 422, 187641, "mount" }, -- Reins of the Sundered Zerethsteed
				{ 423, 187642, "mount" }, -- Vicious Warstalker
				{ 424, 187644, "mount" }, -- Vicious Warstalker
				{ 425, 187660, "mount" }, -- Vespoid Flutterer
				{ 426, 187663, "mount" }, -- Bronzewing Vespoid
				{ 427, 187664, "mount" }, -- Forged Spiteflyer
				{ 428, 187665, "mount" }, -- Buzz
				{ 429, 187666, "mount" }, -- Desertwing Hunter
				{ 430, 187667, "mount" }, -- Mawdapted Raptora
				{ 501, 187668, "mount" }, -- Raptora Swooper
				{ 502, 187669, "mount" }, -- Serenade
				{ 503, 187670, "mount" }, -- Bronze Helicid
				{ 504, 187671, "mount" }, -- Unsuccessful Prototype Fleetpod
				{ 505, 187672, "mount" }, -- Scarlet Helicid
				{ 506, 187673, "mount" }, -- Cryptic Aurelid
				{ 507, 187675, "mount" }, -- Shimmering Aurelid
				{ 508, 187676, "mount" }, -- Deepstar Polyp
				{ 509, 187677, "mount" }, -- Genesis Crawler
				{ 510, 187678, "mount" }, -- Tarachnid Creeper
				{ 511, 187679, "mount" }, -- Ineffable Skitterer
				{ 512, 187680, "mount" }, -- Vicious War Croaker
				{ 513, 187681, "mount" }, -- Vicious War Croaker
				{ 514, 187682, "mount" }, -- Wastewarped Deathwalker
				{ 515, 187683, "mount" }, -- Goldplate Bufonid
				{ 516, 188674, "mount" }, -- Mage-Bound Spelltome
				{ 517, 188696, "mount" }, -- Sturdy Soulsteel Mawrat Harness
				{ 518, 188700, "mount" }, -- Sturdy Silver Mawrat Harness
				{ 519, 188736, "mount" }, -- Sturdy Gilded Mawrat Harness
				{ 520, 188808, "mount" }, -- Patient Bufonid
				{ 521, 188809, "mount" }, -- Prototype Leaper
				{ 522, 188810, "mount" }, -- Russet Bufonid
				{ 523, 189507, "mount" }, -- Cosmic Gladiator's Soul Eater
				{ 524, 190170, "mount" }, -- Jigglesworth, Sr.
				{ 525, 190580, "mount" }, -- Heartbond Lupine
				{ 526, 190581, "mount" }, -- Nether-Gorged Greatwyrm
				{ 527, 190765, "mount" }, -- Iska's Mawrat Leash
				{ 528, 190766, "mount" }, -- Spectral Mawrat's Tail
				{ 529, 190768, "mount" }, -- Fractal Cypher of the Zereth Overseer
				{ 530, 190771, "mount" }, -- Fractal Cypher of the Carcinized Zerethsteed
				{ 601, 191123, "mount" }, -- Grimhowl's Face Axe
				{ 602, 191290, "mount" }, -- Eternal Gladiator's Soul Eater
				{ 603, 191566, "mount" }, -- Elusive Emerald Hawkstrider
				{ 604, 192557, "mount" }, -- Restoration Deathwalker
			},
		},
	},
}

data["TABARDS"] = {
	name = AL["Tabards"],
	ContentType = COLLECTION_CONTENT,
	TableType = I_A_ITTYPE,
	items = {
		{ -- Shadowlands
			name = EXPANSION_NAME8,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, 168100, [PRICE_EXTRA_ITTYPE] = "money:25" }, -- Alliance Tabard
				{ 2, 178336, [PRICE_EXTRA_ITTYPE] = "money:2250000" }, -- Tabard of the Wild Hunt
				{ 3, 178991, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Tabard of the Ascended
				{ 4, 179282, [PRICE_EXTRA_ITTYPE] = "money:2500000" }, -- Court of Harvesters Tabard
				{ 5, 180431, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Sinful Gladiator's Tabard
				{ 6, 180456, [PRICE_EXTRA_ITTYPE] = "money:2500000"}, -- Colors of the Undying Army
				{ 7, 185303, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Unchained Gladiator's Tabard
				{ 8, 186777, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Cosmic Gladiator's Tabard
				{ 9, 186997, [PRICE_EXTRA_ITTYPE] = "stygia:3000" }, -- Death's Advance Tabard
				{ 10, 190611, [PRICE_EXTRA_ITTYPE] = "money:8000000" }, -- Tabard of the Enlightened
				{ 11, 192206 }, -- Eternal Gladiator's Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 178120, [PRICE_EXTRA_ITTYPE] = "money:25" }, -- Horde Tabard
			},
		},
	},
}
