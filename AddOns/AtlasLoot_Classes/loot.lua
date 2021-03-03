-- AtlasLoot_Classes

-- loot.lua:
-- Loot tables for AtlasLoot_Classes 

local addonName, addonTable = ...

local AtlasLoot = _G.AtlasLoot

--if we are running with AtlasLoot before v8, cancel
if AtlasLoot and ATLASLOOT_VERSION_NUM then
  return
end

local data = AtlasLoot.ItemDB:Add(addonName)

--COLORS and CLASS ICONS
local function colorstr(class) return "|c"..RAID_CLASS_COLORS[class].colorStr end
local function coords(class) local c = CLASS_ICON_TCOORDS[class] return ":"..c[1]..":"..c[2]..":"..c[3]..":"..c[4] end
local COLOR_PET_FAMILY = "|cFFFFFFFF"

--FACTIONS
local HORDE_DIFF = data:AddDifficulty("Horde")
local ALLIANCE_DIFF = data:AddDifficulty("Alliance")

--DEATH KNIGHT
local DK_DIFF = data:AddDifficulty("Death Knight")
local DK_BLOOD_DIFF = data:AddDifficulty("Blood")
local DK_FROST_DIFF = data:AddDifficulty("Frost")
local DK_UNHOLY_DIFF = data:AddDifficulty("Unholy")
local DK_PET_DIFF = data:AddDifficulty("Raise Dead")
local DK_RUNEFORGING_DIFF = data:AddDifficulty("Runeforging")

--DEMON HUNTER
local DH_DIFF = data:AddDifficulty("Demon Hunter")
local DH_HAVOC_DIFF = data:AddDifficulty("Havoc")
local DH_VENGEANCE_DIFF = data:AddDifficulty("Vengeance")

--DRUID
local DRUID_DIFF = data:AddDifficulty("Druid")
local DRUID_BALANCE_DIFF = data:AddDifficulty("Balance")
local DRUID_FERAL_DIFF = data:AddDifficulty("Feral")
local DRUID_GUARDIAN_DIFF = data:AddDifficulty("Guardian")
local DRUID_RESTO_DIFF = data:AddDifficulty("Restoration")

--HUNTER
local HUNTER_DIFF = data:AddDifficulty("Hunter")
local HUNTER_BM_DIFF = data:AddDifficulty("Beast Mastery")
local HUNTER_MM_DIFF = data:AddDifficulty("Marksmanship")
local HUNTER_SV_DIFF = data:AddDifficulty("Survival")
--Hunter Pets
local HUNTER_PET_SPEC_DIFF = data:AddDifficulty("Specialization")
local HUNTER_PET_FAMILY_DIFF = data:AddDifficulty("Family")
local HUNTER_PET_EXOTICFAMILY_DIFF = data:AddDifficulty("Exotic")

--MAGE
local MAGE_DIFF = data:AddDifficulty("Mage")
local MAGE_ARCANE_DIFF = data:AddDifficulty("Arcane")
local MAGE_FIRE_DIFF = data:AddDifficulty("Fire")
local MAGE_FROST_DIFF = data:AddDifficulty("Frost")
--Teleports
local MAGE_TELEPORT_DIFF = data:AddDifficulty("Teleportation")
local MAGE_ALLIANCE_DIFF = data:AddDifficulty("Alliance")
local MAGE_HORDE_DIFF = data:AddDifficulty("Horde")
--Mage Pets
local MAGE_PET_DIFF = data:AddDifficulty("Water Elemental")


--MONK
local MONK_DIFF = data:AddDifficulty("Monk")
local MONK_BM_DIFF = data:AddDifficulty("Brewmaster")
local MONK_MW_DIFF = data:AddDifficulty("Mistweaver")
local MONK_WW_DIFF = data:AddDifficulty("Windwalker")

--PALADIN
local PALADIN_DIFF = data:AddDifficulty("Paladin")
local PALADIN_HOLY_DIFF = data:AddDifficulty("Holy")
local PALADIN_PROT_DIFF = data:AddDifficulty("Protection")
local PALADIN_RET_DIFF = data:AddDifficulty("Retribution")

--PRIEST
local PRIEST_DIFF = data:AddDifficulty("Priest")
local PRIEST_DISC_DIFF = data:AddDifficulty("Discipline")
local PRIEST_HOLY_DIFF = data:AddDifficulty("Holy")
local PRIEST_SHADOW_DIFF = data:AddDifficulty("Shadow")

--ROGUE
local ROGUE_DIFF = data:AddDifficulty("Rogue")
local ROGUE_ASS_DIFF = data:AddDifficulty("Assassination")
local ROGUE_OUTLAW_DIFF = data:AddDifficulty("Outlaw")
local ROGUE_SUBTLETY_DIFF = data:AddDifficulty("Subtlety")

--SHAMAN
local SHAMAN_DIFF = data:AddDifficulty("Shaman")
local SHAMAN_ELE_DIFF = data:AddDifficulty("Elemental")
local SHAMAN_ENH_DIFF = data:AddDifficulty("Enhancement")
local SHAMAN_RESTO_DIFF = data:AddDifficulty("Restoration")
--local SHAMAN_PET_DIFF = data:AddDifficulty("Pet Abilities")

--WARLOCK
local WARLOCK_DIFF = data:AddDifficulty("Warlock")
local WARLOCK_AFF_DIFF = data:AddDifficulty("Affliction")
local WARLOCK_DEMO_DIFF = data:AddDifficulty("Demonology")
local WARLOCK_DESTRO_DIFF = data:AddDifficulty("Destruction")
local WARLOCK_PET_DIFF = data:AddDifficulty("Summon Demon")
local WARLOCK_GRIM_DIFF = data:AddDifficulty("Grimoire of Supremacy")

--WARRIOR
local WARRIOR_DIFF = data:AddDifficulty("Warrior")
local WARRIOR_ARMS_DIFF = data:AddDifficulty("Arms")
local WARRIOR_FURY_DIFF = data:AddDifficulty("Fury")
local WARRIOR_PROT_DIFF = data:AddDifficulty("Protection")

--GLYPHS
local GLYPH_DIFF = data:AddDifficulty("Cosmetic")

--CONTENT TYPES
local CLASSES_CONTENT = data:AddContentType("Classes", {0.0, 0.0, 0.0, 1})
local RACIAL_CONTENT = data:AddContentType("Racial Traits", {0.0, 0.0, 0.0, 1})

--TABLE TYPE
local SPELL_ITTYPE = data:AddItemTableType("ClassesSpell")


--also needed to set when setting [ATLASLOOT_IT_HORDE] or [ATLASLOOT_IT_ALLIANCE]
--otherwise it won't show for both factions
local FACTION_INFO_IS_SET_ID = 998
--unused so far
local IGNORE_THIS_BUTTON_ID = 999



-------------------
--DEATH KNIGHT
-------------------

data["CLASS_DK"] = {
  name = "Death Knight",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("DEATHKNIGHT"),
	  [DK_DIFF] = {
        { 1, { id = 50977, level = "55" }, }, --DeathGate
        { 2, { id = 49576, level = "55" }, }, --DeathGrip
        { 3, { id = 49998, level = "55" }, }, --DeathStrike
		{ 4, { id = 53428, level = "55" }, }, --Runeforging	
		{ 5, { id = 48707, level = "57" }, }, --AntiMagicShell
		{ 6, { id = 48792, level = "57" }, }, --IceboundFortitude
		{ 7, { id = 56222, level = "58" }, }, --DarkCommand
		{ 8, { id = 212552, level = "60" }, }, --WraithWalk
		{ 9, { id = 47528, level = "62" }, }, --MindFreeze
        { 10, { id = 3714, level = "66" }, }, --PathofFrost
		{ 11, { id = 111673, level = "69" }, }, --ControlUndead
        { 12, { id = 61999, level = "72" }, }, --RaiseAlly
		--Passives
		{ 16, { id = 82246, level = "1"}, }, --Parry
		{ 17, { id = 51986, level = "61", rank = "Passive " }, }, -- OnaPaleHorse
		--Skills
        { 19, { id = 76282}, }, --Armor
        { 20, { id = 76292}, }, --Weapon
		--Class Books
		{ 22, { id = 127344, rank = "Necrophilic Tome: Corpse Explosion" }, }, --CorpseExplosion
      }, 
      [DK_BLOOD_DIFF] = {
	   --Active
        { 1, { id = 221562, level = "1"}, }, --Asphyxiate
		{ 2, { id = 206930, level = "1" }, }, --HeartStrike
        { 3, { id = 195182, level = "55" }, }, --Marrowrend
        { 4, { id = 50842, level = "56" }, }, --BloodBoil
        { 5, { id = 43265, level = "56" }, }, --DeathandDecay
		{ 6, { id = 49028, level = "57" }, }, --DancingRuneWeapon
		{ 7, { id = 195292, level = "58" }, }, --DeathsCaress
        { 8, { id = 55233, level = "60" }, }, --VampiricBlood
		{ 9, { id = 108199, level = "64" }, }, --GorefriendGrasp
		--Passives
        { 16, { id = 48263, level = "55", rank = "Passive " }, }, --VeteranoftheThirdWar
		{ 17, { id = 81136, level = "63", rank = "Passive " }, },	--CrimsonScourge
		{ 18, { id = 161797, level = "76", rank = "Passive " }, }, --Riposte
        { 19, { id = 77513, level = "78", rank = "Passive " }, }, --Mastery: BloodShield	
		--Skills
		{ 21, { id = 86537, level = "55" }, }, --PlateSpecialization	
      },
      [DK_FROST_DIFF] = {
		--Active
        { 1, { id = 49143, level = "55" }, }, --FrostStrike
        { 2, { id = 49184, level = "55" }, }, --HowlingBlast
        { 3, { id = 49020, level = "55" }, }, --Obliterate
        { 4, { id = 47568, level = "57" }, }, --EmpowerRuneWeapon
        { 5, { id = 51271, level = "57" }, }, --PillarofFrost
        { 6, { id = 196770, level = "57" }, }, --RemorselessWinter		
        { 7, { id = 45524, level = "63" }, }, --ChainsofIce
		--Passive
		{ 16, { id = 674, level = "1"}, }, --DualWield
        { 17, { id = 81229, level = "1", rank = "Passive " }, }, --RunicEmpowerment
		{ 18, { id = 51128, level = "56", rank = "Passive " }, }, --KillingMachine
		{ 19, { id = 178819, level = "58", rank = "Passive" }, },	--DarkSuccor
		{ 20, { id = 59057, level = "59", rank = "Passive " }, }, --Rime
		{ 21, { id = 77514, level = "78", rank = "Passive " }, }, --Mastery: FrozenHeart	
		--Skills
		{ 23, { id = 86113, level = "55" }, }, --PlateSpecialization
	  },
      [DK_UNHOLY_DIFF] = {
		--Active
        { 1, { id = 47541, level = "55" }, }, --DeathCoil
        { 2, { id = 85948, level = "55" }, }, --FesteringStrike
        { 3, { id = 77575, level = "55" }, }, --Outbreak
        { 4, { id = 46584, level = "55" }, }, --RaiseDead
        { 5, { id = 55090, level = "55" }, }, --ScourgeStrike
        { 6, { id = 43265, level = "56" }, }, --DeathandDecay
        { 7, { id = 45524, level = "63" }, },	--ChainsofIcece
        { 8, { id = 63560, level = "74" }, }, --DarkTransformation
        { 9, { id = 49206, level = "75" }, },	--SummonGargoyle
        { 10, { id = 42650, level = "82" }, }, --ArmyoftheDead
		--Passives
		{ 16, { id = 197147, level = "1", rank = "Passive" }, }, --FesteringWound
		{ 17, { id = 51462, level = "1", rank = "Passive " }, }, --RunicCorruption
		{ 18, { id = 178819, level = "58", rank = "Passive" }, }, --DarkSuccor
		{ 19, { id = 49530, level = "64", rank = "Passive" }, }, --SuddenDoom
		{ 20, { id = 77515, level = "78", rank = "Passive " }, }, --Mastery: Dreadblade
		--Skills
		{ 22, { id = 86536, level = "55" }, }, --PlateSpecialization
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [DK_BLOOD_DIFF] = {
		--Tier 1
        { 1, { id = 195679, level = "56" }, }, --Bloodworms 
        { 2, { id = 221536, level = "56" }, }, --Heartbreaker
        { 3, { id = 206931, level = "56" }, }, --Blooddrinker 
		--Tier 2
        { 5, { id = 194662, level = "57" }, }, --RapidDecomposition 
        { 6, { id = 246426, level = "57" }, }, --HeartofIce
        { 7, { id = 211078, level = "57" }, }, --SpectralDeflection 
		--Tier 3
        { 9, { id = 219786, level = "58" }, }, --Ossuary 
        { 10, { id = 221699, level = "58" }, },--BloodTap 
        { 11, { id = 205727, level = "58" }, }, --AntiMagicBarrier 
		--Tier 4
        { 13, { id = 206940, level = "60" }, }, --MarkofBlood 
        { 14, { id = 205723, level = "60" }, }, --RedThirst 
        { 15, { id = 219809, level = "60" }, }, --Tombstone 
		--Tier 5
        { 16, { id = 206970, level = "75" }, }, --TighteningGrasp 
        { 17, { id = 206960, level = "75" }, }, --TrembleBeforeMe 
        { 18, { id = 219779, level = "75" }, }, --MarchoftheDamned 
		--Tier 6
        { 20, { id = 206967, level = "90" }, }, --WilloftheNecropolis 
        { 21, { id = 194679, level = "90" }, }, --RuneTap 
        { 22, { id = 206974, level = "90" }, }, --FoulBulwark 
		--Tier 7
        { 24, { id = 194844, level = "100" }, }, --Bonestorm 
        { 25, { id = 206977, level = "100" }, }, --Blood Mirror 
        { 26, { id = 114556, level = "100" }, }, --Purgatory
      },
      [DK_FROST_DIFF] = {
	    --Tier 1
        { 1, { id = 207057, level = "56" }, }, --ShatteringStrikes 
        { 2, { id = 194878, level = "56" }, }, --IcyTalons 
        { 3, { id = 207104, level = "56" }, }, --RunicAttentuation 
		--Tier 2
        { 5, { id = 207060, level = "57" }, }, --FreezingFog 
        { 6, { id = 207061, level = "57" }, }, --MurderousEfficiency 
        { 7, { id = 57330, level = "57" }, }, --HornofWinter 
		--Tier 3
        { 9, { id = 207126, level = "58" }, }, --Icecap 
        { 10, { id = 194913, level = "58" }, }, --GlacialAdvance 
        { 11, { id = 207142, level = "58" }, }, --Avalanche 
		--Tier 4
        { 13, { id = 207161, level = "60" }, }, --AbominationMight 
        { 14, { id = 207167, level = "60" }, }, --BlindingSleet 
        { 15, { id = 207170, level = "60" }, }, --WinterisComing 
		--Tier 5
        { 16, { id = 207188, level = "75" }, }, --VolatileShielding 
        { 17, { id = 207200, level = "75" }, }, --Permafrost 
        { 18, { id = 253593, level = "75" }, }, --InexorableAssault 
		--Tier 6
        { 20, { id = 207230, level = "90" }, }, --Frostscythe 
        { 21, { id = 194909, level = "90" }, }, --FrozenPulse
        { 22, { id = 194912, level = "90" }, }, --GatheringStorm 
		--Tier 7
        { 24, { id = 207256, level = "100" }, }, --Obliteration 
        { 25, { id = 152279, level = "100" }, }, --BreathofSindragosa
        { 26, { id = 207127, level = "100" }, }, --HungeringRuneWeapon
      },
      [DK_UNHOLY_DIFF] = {
		--Tier 1
        { 1, { id = 194916, level = "56" }, }, --AllWillServe 
        { 2, { id = 207264, level = "56" }, }, --BurstingSores 
        { 3, { id = 207269, level = "56" }, }, --EbonFever 
		--Tier 2
        { 5, { id = 207317, level = "57" }, }, --Epidemic  
        { 6, { id = 194917, level = "57" }, }, --PestilentPustules  
        { 7, { id = 194918, level = "57" }, }, --BlightedRuneWeapon 
		--Tier 3
        { 9, { id = 207289, level = "58" }, }, --UnholyFrenzy 
        { 10, { id = 207305, level = "58" }, }, --Castigator  
        { 11, { id = 207311, level = "58" }, }, --ClawingShadows  
		--Tier 4
        { 13, { id = 207313, level = "60" }, }, --SludgeBelcher  
        { 14, { id = 108194, level = "60" }, }, --Asphyxiate 
        { 15, { id = 207316, level = "60" }, }, --DebilitatingInfestation 
		--Tier 5  
        { 16, { id = 207321, level = "75" }, }, --SpellEater 
        { 17, { id = 207319, level = "75" }, }, --CorpseShield 
        { 18, { id = 212763, level = "75" }, }, --LingeringApparition 
		--Tier 6
        { 20, { id = 198943, level = "90" }, }, --ShadowInfusion 
        { 21, { id = 207346, level = "90" }, }, --Necrosis 
        { 22, { id = 207272, level = "90" }, }, --InfectedClaws 
		--Tier 7
        { 24, { id = 207349, level = "100" }, }, --DarkArbiter 
        { 25, { id = 152280, level = "100" }, }, --Defile 
        { 26, { id = 130736, level = "100" }, }, --SoulReaper
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [DK_BLOOD_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195338, level = "2" }, }, --RelentlessAssault  
        { 6, { id = 207018, level = "16" }, }, --MurderousIntent  
        { 7, { id = 195389, level = "34" }, }, --SoftendedBlows 
		--Tier 3
        { 9, { id = 201995, level = "4" }, }, --CadaverousPallor 
        { 10, { id = 77606, level = "19", rank = "Honor Talent" }, }, --DarkSimulacrum  
        { 11, { id = 51052, level = "37" }, }, --AntiMagicZone  
		--Tier 4
        { 13, { id = 199720, level = "6" }, }, --DecomposingAura  
        { 14, { id = 199719, level = "22" }, }, --HeartstopAura 
        { 15, { id = 199642, level = "40" }, }, --NecroticAura 
		--Tier 5  
        { 16, { id = 202727, level = "8" }, }, --UnholyCommand 
        { 17, { id = 202731, level = "25" }, }, --WalkingDead 
        { 18, { id = 47476, level = "43" }, }, --Strangulate 
		--Tier 6
        { 20, { id = 233412, level = "10" }, }, --LastDance 
        { 21, { id = 233411, level = "28" }, }, --BloodforBlood 
        { 22, { id = 203173, level = "46" }, }, --DeathChain 
      },
      [DK_FROST_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 201995, level = "4" }, }, --CadaverousPallor 
        { 10, { id = 77606, level = "19", rank = "Honor Talent" }, }, --DarkSimulacrum  
        { 11, { id = 51052, level = "37" }, }, --AntiMagicZone  
		--Tier 4
        { 13, { id = 199720, level = "6" }, }, --DecomposingAura  
        { 14, { id = 199719, level = "22" }, }, --HeartstopAura 
        { 15, { id = 199642, level = "40" }, }, --NecroticAura 
		--Tier 5  
        { 16, { id = 204080, level = "8" }, }, --Deathchill 
        { 17, { id = 204135, level = "25" }, }, --FrozenCenter 
        { 18, { id = 233396, level = "43" }, }, --Delirium 
		--Tier 6
        { 20, { id = 204132, level = "10" }, }, --TundraStalker 
        { 21, { id = 233394, level = "28" }, }, --OverpoweredRuneWEapon 
        { 22, { id = 204160, level = "46" }, }, --ChillStreak 
      },
      [DK_UNHOLY_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 201995, level = "4" }, }, --CadaverousPallor 
        { 10, { id = 77606, level = "19", rank = "Honor Talent" }, }, --DarkSimulacrum  
        { 11, { id = 51052, level = "37" }, }, --AntiMagicZone  
		--Tier 4
        { 13, { id = 199720, level = "6" }, }, --DecomposingAura  
        { 14, { id = 199719, level = "22" }, }, --HeartstopAura 
        { 15, { id = 199642, level = "40" }, }, --NecroticAura 
		--Tier 5  
        { 16, { id = 199722, level = "8" }, }, --CryptFever
        { 17, { id = 199724, level = "25" }, }, --Pandemic 
        { 18, { id = 199725, level = "43" }, }, --WanderingPlague 
		--Tier 6
        { 20, { id = 201934, level = "10" }, }, --UnholyMutation 
        { 21, { id = 210128, level = "28" }, }, --Reanimation 
        { 22, { id = 223829, level = "46" }, }, --NecroticStrike 
      },
    },
-- Commenting out the artifact traits for now. Hope to add them later!
--   {
--     name = "Artifact Traits",
--     CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--     [DK_BLOOD_DIFF] = {
--
--     },
--      [DK_FROST_DIFF] = {
--
--      },
--      [DK_UNHOLY_DIFF] = {
--
--      },
--    },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\inv_glyph_minordeathknight",
      [GLYPH_DIFF] = {
        { 1, 212524 }, --CrackedIce
        { 2, 212526 }, --DryIce
		{ 3, 58642 }, --FoulMenagerie
		{ 4, 219000 }, --theBloodWraith
		{ 5, 218989 }, --theChilledShell
		{ 6, 218979 }, --theCrimsonShell
		{ 7, 58640 }, --theGeist
		{ 8, 146652 }, --theSkeleton
		{ 9, 219007 }, --theUnholyWraith
		{ 10, 219011 }, --theWraithWalker
      },
    },
	{
      name = "Pet Abilities",
      CoinTexture = "texture:Interface\\Icons\\spell_shadow_animatedead",
      [DK_PET_DIFF] = {  
		--Ghoul
        { 1, { id = 47468, rank = COLOR_PET_FAMILY.."Ghoul"}, }, --Claw
		{ 2, { id = 47481, rank = COLOR_PET_FAMILY.."Ghoul"}, }, --Gnaw
		{ 3, { id = 47484, rank = COLOR_PET_FAMILY.."Ghoul"}, }, --Huddle
		{ 4, { id = 47482, rank = COLOR_PET_FAMILY.."Ghoul"}, }, --Leap
		--Abomination
        { 6, { id = 212333, rank = COLOR_PET_FAMILY.."Abomination"}, }, --Cleaver
		{ 7, { id = 212468, rank = COLOR_PET_FAMILY.."Abomination"}, }, --Hook
		{ 8, { id = 212384, rank = COLOR_PET_FAMILY.."Abomination"}, }, --ProtectiveBile
		{ 9, { id = 212336, rank = COLOR_PET_FAMILY.."Abomination"}, }, --Smash
		--Risen Skulker
		{ 11, { id = 212423, rank = COLOR_PET_FAMILY.."Risen Skulker"}, }, --SkulkerShot
		--Passive
		{ 13, 62137 }, --Avoidance
		--Dark Transformation 
		--Ghoul
		{ 16, { id = 91778, rank = "Claw: Dark Transformation"}, }, --SweepingClaws
        { 17, { id = 91797, rank = "Gnaw: Dark Transformation "}, }, --MonstrousBlow
        { 18, { id = 91837, rank = "Huddle: Dark Transformation"}, }, --PutridBulwark
        { 19, { id = 91802, rank = "Leap: Dark Transformation"}, }, --ShamblingRush
		--Abomination
		{ 21, { id = 212338, rank = "Cleaver: Dark Transformation"}, }, --VileGas
        { 22, { id = 212470, rank = "Hook: Dark Transformation"}, }, --FleshHook
        { 23, { id = 212383, rank = "Protective Bile: Dark Transformation"}, }, --GastricBloat
		{ 24, { id = 212337, rank = "Smash: Dark Transformation"}, }, --PowerfulSmash
		},	
	},
	{
      name = "Runeforging",
      CoinTexture = "texture:Interface\\Icons\\spell_deathknight_frozenruneweapon"..coords("DEATHKNIGHT"),
      [DK_RUNEFORGING_DIFF] = {
        { 1, { id = 53428, level = "55" }, }, --Runeforging
        { 3, { id = 53343, level = "55" }, }, --Razorice
        { 4, { id = 53344, level = "70" }, }, --FallenCrusader
        { 5, { id = 62158, level = "72" }, }, --StoneskinGargoyle
      },
	},
  },
 }
 
-------------------
--DEMON HUNTER
-------------------

data["CLASS_DH"] = {
  name = "Demon Hunter",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("DEMONHUNTER"),
	  [DH_DIFF] = {
		--Active
        { 1, { id = 188499}, }, --BladeDance
        { 2, { id = 198589}, }, --Blur
        { 3, { id = 179057}, }, --ChaosNova
        { 4, { id = 162794}, }, --ChaosStrike
        { 5, { id = 183752}, }, --Consume Magic
        { 6, { id = 198013}, }, --EyeBeam
        { 7, { id = 195072}, }, --FelRush
        { 8, { id = 131347}, }, --Glide
        { 9, { id = 217832}, }, --Imprison
        { 10, { id = 191427}, }, --Metamorphosis
        { 11, { id = 214743}, }, --SoulCarver
        { 12, { id = 188501}, }, --SpectralSight
        { 13, { id = 185123}, }, --ThrowGlaive
        { 14, { id = 198793}, }, --VengefulRetreat
		--Passives
		{ 16, { id = 221351}, }, --CriticalStrikes
		{ 17, { id = 196055, rank = "Passive"}, }, --DoubleJump
        { 18, { id = 203724, rank = "Passive " }, }, --Parry
		--Skills
		{ 20, { id = 202782, rank = "Passive"}, }, --Armor
        { 21, { id = 202783}, }, --Weapon
      }, 
      [DH_HAVOC_DIFF] = {
		--Active
        { 1, { id = 162243, level = "1"}, }, --DemonBite
        { 2, { id = 196718, level = "100" }, }, --Darkness
		--Passives
		{ 16, { id = 185164, level = "1", rank = "Passive"}, }, --Mastery: DemonicPresence
		{ 17, { id = 178940, level = "1", rank = "Passive"}, }, --ShatteredSouls
		--Skills
		{ 19, { id = 178976}, }, -- LeatherSpecialization
      },
      [DH_VENGEANCE_DIFF] = {
		--Active
	    { 1, { id = 203720, level = "1"}, }, --DemonSpikes
        { 3, { id = 204021, level = "1"}, }, --FieryBrand
		{ 4, { id = 178740, level = "1"}, }, --ImmolationAura
        { 5, { id = 189110, level = "1"}, }, --InfernalStrike
		{ 6, { id = 187827, level = "1"}, }, --Metamorphosis
		{ 7, { id = 203782, level = "1"}, }, --Shear
        { 8, { id = 204596, level = "1"}, }, --SigilofFlame
        { 11, { id = 228477, level = "1"}, }, --SoulCleave		
        { 12, { id = 204157, level = "1"}, }, --ThrowGlaive
		{ 13, { id = 185245, level = "1"}, }, -- Torment  
        { 10, { id = 202137, level = "101" }, }, --SigilofSilence
		{ 2, { id = 218256, level = "103" }, }, --EmpowerWards   
	    { 9, { id = 207684, level = "105" }, }, --SigilofMisery		
		--Passives
		{ 16, { id = 203513, rank = "Passive"}, }, --DemonicWards
        { 17, { id = 203747, rank = "Passive"}, },	--Mastery: FelBlood		 
        { 18, { id = 204254, rank = "Passive"}, },	--ShatteredSouls
		{ 19, { id = 203783, rank = "Passive"}, }, --ShearPassive
		{ 20, { id = 212613, rank = "Passive"}, }, --VengeanceDemonHunter		
		{ 21, { id = 207197, level = "76", rank = "Passive"}, }, --Riposte	
		--Skills
		{ 23, { id = 226359}, }, --LeatherSpecialization	
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [DH_HAVOC_DIFF] = {
		--Tier 1
        { 1, { id = 192939, level = "99" }, }, --FelMastery
        { 2, { id = 232893, level = "99" }, }, --Felblade
        { 3, { id = 203550, level = "99" }, }, --BlindFury
		--Tier 2
        { 5, { id = 203551, level = "100" }, }, --Prepared
        { 6, { id = 203555, level = "100" }, }, --DemonBlades
        { 7, { id = 206478, level = "100" }, }, --DemonicAppetite
		--Tier 3
        { 9, { id = 206475, level = "102" }, }, --ChaosCleave
        { 10, { id = 206416, level = "102" }, }, --FirstBlood
        { 11, { id = 206473, level = "102" }, }, --Bloodlet
		--Tier 4
        { 13, { id = 196555, level = "104" }, }, --Netherwalk
        { 14, { id = 205411, level = "104" }, }, --DesperateInstincts
        { 15, { id = 204909, level = "104" }, }, --SoulRending
		--Tier 5
        { 16, { id = 206476, level = "106" }, }, --Momentum
        { 17, { id = 211881, level = "106" }, }, --FelEruption
        { 18, { id = 206491, level = "106" }, }, --Nemesis
		--Tier 6
        { 20, { id = 203556, level = "108" }, }, --MasteroftheGlaive
        { 21, { id = 206477, level = "108" }, }, --UnleashedPower 
        { 22, { id = 193897, level = "108" }, }, --DemonReborn 
		--Tier 7
        { 24, { id = 211048, level = "110" }, }, --ChaosBlades 
        { 25, { id = 211053, level = "110" }, }, --FelBarrage 
        { 26, { id = 213410, level = "110" }, }, --Demonic
      },
      [DH_VENGEANCE_DIFF] = {
		--Tier 1
        { 1, { id = 207550, level = "99" }, }, --AbyssalStrike
        { 2, { id = 207548, level = "99" }, }, --AgonizingFlames
        { 3, { id = 209400, level = "99" }, }, --RazorSpikes
		--Tier 2
        { 5, { id = 207697, level = "100" }, }, --FeastofSouls 
        { 6, { id = 227174, level = "100" }, }, --Fallout 
        { 7, { id = 207739, level = "100" }, }, --BurningAlive 
		--Tier 3
        { 9, { id = 232893, level = "102" }, }, --Felblade 
        { 10, { id = 227322, level = "102" }, }, --FlameCrash  
        { 11, { id = 211881, level = "102" }, }, --FelEruption 
		--Tier 4
        { 13, { id = 218612, level = "104" }, }, --FeedtheDemon 
        { 14, { id = 209795, level = "104" }, }, --Fracture 
        { 15, { id = 217996, level = "104" }, }, --SoulRending 
		--Tier 5
        { 16, { id = 207666, level = "106" }, }, --ConcentratedSigils 
        { 17, { id = 202138, level = "106" }, }, --SigilofChains 
        { 18, { id = 209281, level = "106" }, }, --QuickenedSigils 
		--Tier 6
        { 20, { id = 212084, level = "108" }, }, --FelDevestation 
        { 21, { id = 203753, level = "108" }, }, --BladeTurning 
        { 22, { id = 218679, level = "108" }, }, --SpiritBomb 
		--Tier 7
        { 24, { id = 209258, level = "110" }, }, --LastResort
        { 25, { id = 236189, level = "110" }, }, --DemonicInfusion 
        { 26, { id = 227225, level = "110" }, }, --SoulBarrier
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [DH_HAVOC_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 211509, level = "4" }, }, --Solitude 
        { 10, { id = 203468, level = "19" }, }, --Glimpse  
        { 11, { id = 227635, level = "37" }, }, --CoverofDarkness  
		--Tier 4
        { 13, { id = 205603, level = "6" }, }, --UnendingHatred  
        { 14, { id = 205604, level = "22" }, }, --ReverseMagic 
        { 15, { id = 206649, level = "40" }, }, --EyeofLeotheras 
		--Tier 5  
        { 16, { id = 235893, level = "8" }, }, --DemonicOrigins
        { 17, { id = 235903, level = "25" }, }, --ManaRift 
        { 18, { id = 205598, level = "43" }, }, --AwakentheDemonWithin 
		--Tier 6
        { 20, { id = 205596, level = "10" }, }, --Detainment 
        { 21, { id = 206803, level = "28" }, }, --RainfromAbove 
        { 22, { id = 203704, level = "46" }, }, --ManaBreak 
      },
      [DH_VENGEANCE_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195338, level = "2" }, }, --RelentlessAssault  
        { 6, { id = 207029, level = "16" }, }, --Tormentor  
        { 7, { id = 195389, level = "34" }, }, --SoftendedBlows 
		--Tier 3
        { 9, { id = 211509, level = "4" }, }, --Solitude 
        { 10, { id = 205628, level = "19" }, }, --RainofChaos  
        { 11, { id = 211489, level = "37" }, }, --SigilMastery  
		--Tier 4
        { 13, { id = 213480, level = "6" }, }, --UnendingHatred  
        { 14, { id = 205604, level = "22" }, }, --ReverseMagic 
        { 15, { id = 206649, level = "40" }, }, --EyeofLeotheras 
		--Tier 5  
        { 16, { id = 205626, level = "8" }, }, --EverlastingHunt
        { 17, { id = 205625, level = "25" }, }, --CleansedbyFlame 
        { 18, { id = 205627, level = "43" }, }, --JaggedSpikes 
		--Tier 6
        { 20, { id = 205629, level = "10" }, }, --DemonicTrample 
        { 21, { id = 205596, level = "28" }, }, --Detainment 
        { 22, { id = 205630, level = "46" }, }, --IllidansGrasp 
      },
    },
--    {
--      name = "Artifact Traits",
--      CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--      [DH_HAVOC_DIFF] = {
--
--      },
--      [DH_VENGEANCE_DIFF] = {
--
--      },
--    },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\70_inscription_glyph_demonhunter_minor",
      [GLYPH_DIFF] = {
        { 1, 219831 }, --CracklingFlames 
        { 2, 220083 }, --FallowWings 
		{ 3, 220831 }, --FearsomeMetamorphosis 
		{ 4, 219713 }, --FelTouched Souls 
		{ 5, 220228 }, --FelWings 
		{ 6, 220240 }, --FelEnemies
		{ 7, 219744 }, --ManaTouchedSouls 
		{ 8, 220244 }, --ShadowEnemies 
		{ 9, 220226 }, --TatteredWings
      },
    },
  },
 }
 
-------------------
--DRUID
-------------------

data["CLASS_DRUID"] = {
  name = "Druid",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("DRUID"),
	  [DRUID_DIFF] = {
		--Active
		{ 1, { id = 5225, level = "1" }, }, --TrackHumanoids	
        { 2, { id = 8921, level = "3" }, }, --Moonfire 
        { 3, { id = 8936, level = "5" }, }, --Regrowth
        { 4, { id = 768, level = "8" }, }, --CatForm
        { 5, { id = 1850, level = "8" }, }, --Dash
        { 6, { id = 5487, level = "10" }, }, --BearForm 		
        { 7, { id = 6795, level = "13" }, }, --Growl
        { 8, { id = 50769, level = "14" }, }, --Revive
        { 9, { id = 18960, level = "14" }, }, --TeleportMoonglade
		{ 10, { id = 164815, level = "16" }, }, --Sunfire 
        { 11, { id = 783, level = "18" }, }, --TravelForm
        { 12, { id = 339, level = "24" }, }, --EntanglingRoots 
        { 13, { id = 20484, level = "42" }, }, --Rebirth
        { 14, { id = 165962, level = "58" }, }, --FlightForm
		--Passive
        { 16, { id = 125972, level = "6", rank = "Passive " }, }, --FelineGrace		
		--Skills
        { 18, { id = 76300, rank = "Passive"}, }, --Armor
        { 19, { id = 76275, rank = "Passive"}, },	--Weapon		
		--Class Hall
		{ 21, { id = 193753, rank = "Replaces Teleport: Moonglade"}, }, --Dreamwalk	
		--Class Books
		{ 23, { id = 127757, rank = "Tome of the Wilds: Charm Woodland Creatures" }, }, --CharmWoodlandCreature
		{ 24, { id = 164862, rank = "Tome of the Wilds: Flap" }, }, --Flap
		{ 25, { id = 210065, rank = "Tome of the Wilds: Track Beasts" }, }, --TrackBeasts
        { 26, { id = 114282, rank = ", Tome of the Wilds: Treant Form" }, }, --TreantForm		
		{ 27, { id = 210053, rank = ", Tome of the Wilds: Stag Form" }, }, --StagForm
      }, 
      [DRUID_BALANCE_DIFF] = {
		--Active
        { 1, { id = 190984, level = "1" }, }, --SolarWrath 
        { 2, { id = 78674, level = "10" }, }, --Starsurge 
        { 3, { id = 194153, level = "12" }, }, --LunarStrike
		{ 4, { id = 24858, level = "16" }, }, --MoonkinForm 
		{ 5, { id = 5215, level = "16" }, }, --Prowl 
        { 6, { id = 93402, level = "16" }, }, --Sunfire
        { 7, { id = 2782, level = "22" }, }, --RemoveCorruption
		{ 8, { id = 22812, level = "26" }, }, --Barkskin
        { 9, { id = 191034, level = "40" }, }, --Starfall 	
		{ 10, { id = 194223, level = "48" }, }, --CelestialAlignment
        { 11, { id = 29166, level = "50" }, }, --Innervate
		{ 12, { id = 78675, level = "80" }, }, --SolarBeam
		--Passive
        { 16, { id = 108299, level = "10", rank = "Passive " }, }, --KillerInstinct
        { 17, { id = 197524, level = "34", rank = "Passive " }, }, --AstralInfluence
        { 18, { id = 77492, level = "78", rank = "Passive " }, }, --Mastery: Starlight
		--Skills
		{ 20, { id = 86104, level = "50", rank = "Passive " }, }, --LeatherSpecialization	
      },
      [DRUID_FERAL_DIFF] = {
		--Active
        { 1, { id = 22568, level = "10" }, }, --FerociousBite 
		{ 2, { id = 5221, level = "10" }, }, --Shred 
        { 3, { id = 1822, level = "12" }, }, --Rake 
        { 4, { id = 106832, level = "12" }, }, --Thrash 
        { 5, { id = 5217, level = "13" }, }, --TigerFury 
		{ 6, { id = 5215, level = "16" }, }, --Prowl 
        { 7, { id = 1079, level = "20" }, }, --Rip 	
        { 8, { id = 2782, level = "22" }, }, --RemoveCorruption 
        { 9, { id = 213764, level = "32" }, },	--Swipe	
        { 10, { id = 61336, level = "36"}, }, --SurvivalInstincts	
        { 11, { id = 106951, level = "40" }, }, --Berserk 
        { 12, { id = 106898, level = "50" }, }, --StampedingRoar		
        { 13, { id = 22570, level = "63" }, }, -- Maim
        { 14, { id = 106839, level = "70" }, },	--SkullBash		
		--Passive
		{ 16, { id = 157447, level = "1"}, }, --Critical Strikes
		{ 17, { id = 33873, level = "10", rank = "Passive " }, }, --NurturingInstinct
        { 18, { id = 131768, level = "34", rank = "Passive "  }, }, --FelineSwiftness
        { 19, { id = 16864, level = "48", rank = "Passive " }, }, --OmenofClarity	
        { 20, { id = 48484, level = "54", rank = "Passive " }, }, --InfectedWounds
        { 21, { id = 77493, level = "78", rank = "Passive " }, }, --Mastery: RazorClaws
        { 22, { id = 16974, level = "80", rank = "Passive " }, }, --PredatorySwiftness
		--Skills
        { 24, { id = 86097, level = "50", rank = "Passive " }, }, --LeatherSpecialization
      },
      [DRUID_GUARDIAN_DIFF] = {
		--Active
        { 1, { id = 33917, level = "10" }, }, --Mangle
        { 2, { id = 6807, level = "10" }, }, --Maul 
        { 3, { id = 106832, level = "12" }, }, --Thrash 
		{ 4, { id = 5215, level = "16" }, }, --Prowl 
        { 5, { id = 2782, level = "22" }, }, --RemoveCorruption 
        { 6, { id = 22812, level = "26" }, }, --Barkskin 
        { 7, { id = 99, level = "28" }, }, --IncapacitatingRoar 
        { 8, { id = 213764, level = "32" }, }, --Swipe 
        { 9, { id = 61336, level = "36" }, }, --SurvivalInstincts  
        { 10, { id = 22842, level = "40" }, },	--FrenziedRegeneration 
        { 11, { id = 192081, level = "44" }, }, --Ironfur 
	    { 12, { id = 106898, level = "50" }, }, --StampedingRoar 
        { 13, { id = 106839, level = "70" }, },	--SkullBash 
		--Passive
        { 16, { id = 157447, level = "1" }, }, --CriticalStrikes
        { 17, { id = 33873, level = "10", rank = "Passive " }, }, --NurturingInstinct
        { 18, { id = 16931, level = "34", rank = "Passive " }, },	--ThickHide 
        { 19, { id = 210706, level = "48", rank = "Passive " }, },	--Gore 
        { 20, { id = 231065, level = "65", rank = "Passive " }, }, --LightningReflexes 
        { 21, { id = 155783, level = "78", rank = "Passive " }, },	--Mastery: NatureGuardian		
		--Skills
        { 23, { id = 86096, level = "50", rank = "Passive " }, }, --LeatherSpecialization 
      },
	  [DRUID_RESTO_DIFF] = {
		--Active
		{ 1, { id = 5176, level = "1" }, }, --Solar Wrath
        { 2, { id = 774, level = "10" }, }, --Rejuvenation
		{ 3, { id = 18562, level = "12" }, }, --Swiftmend		
		{ 4, { id = 5215, level = "16" }, }, --Prowl 
        { 5, { id = 93402, level = "16" }, }, --Sunfire
        { 6, { id = 33763, level = "20" }, }, --Lifebloom
        { 7, { id = 88423, level = "22" }, }, --Nature's Cure 
        { 8, { id = 5185, level = "24" }, }, --Healing Touch      
		{ 9, { id = 22812, level = "26" }, }, --Barkskin 
		{ 10, { id = 48438, level = "40" }, },	--WildGrowth 
        { 11, { id = 29166, level = "50" }, },	--Innervate 
        { 12, { id = 102342, level = "54" }, },	--Ironbark   
		{ 13, { id = 102793, level = "63" }, },	--UrsolVortex	
        { 14, { id = 212040, level = "66" }, },	--Revitalize     		
		{ 15, { id = 145205, level = "70" }, },	--Effloresence
        { 16, { id = 740, level = "80" }, }, --Tranquility
		--Passive
		{ 18, { id = 137012, level = "1", rank = "Hidden Passive " }, }, --RestorationDruid  
		{ 19, { id = 108299, level = "10", rank = "Passive " }, }, --KillerInstinct  
		{ 20, { id = 145108, level = "34", rank = "Passive " }, }, --YseraGift 
        { 21, { id = 113043, level = "48", rank = "Passive " }, },	--OmenofClarity 
		{ 22, { id = 48500, level = "56", rank = "Passive " }, }, --LivingSeed 
		{ 23, { id = 77495, level = "78", rank = "Passive " }, }, --Mastery: Harmony
		--Skills
		{ 25, { id = 86093, level = "50", rank = "Passive " }, }, -- LeatherSpecialization 
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [DRUID_BALANCE_DIFF] = {
		--Tier 1
        { 1, { id = 205636, level = "15" }, }, --ForceNature
        { 2, { id = 202425, level = "15" }, }, --WarriorofElune 
        { 3, { id = 202345, level = "15" }, }, --Starlord  
		--Tier 2
        { 5, { id = 108238, level = "30" }, }, --Renewal 
        { 6, { id = 102280, level = "30" }, }, --DisplacerBeast 
        { 7, { id = 102401, level = "30" }, }, --WildCharge 
		--Tier 3
        { 9, { id = 202157, level = "45" }, }, --FeralAffinity 
        { 10, { id = 197491, level = "45" }, }, --GuardianAffinity 
        { 11, { id = 197492, level = "45" }, }, --RestorationAffinity 
		--Tier 4
        { 13, { id = 5211, level = "60" }, },  --MightyBash 
        { 14, { id = 102359, level = "60" }, }, --MassEntanglement 
        { 15, { id = 132469, level = "60" }, }, --Typhoon 
		--Tier 5
        { 16, { id = 114107, level = "75" }, }, --SouloftheForest 
        { 17, { id = 102560, level = "75" }, }, --IncarnationChosenofElune 
        { 18, { id = 202347, level = "75" }, }, --StellarFlare 
		--Tier 6
        { 20, { id = 202342, level = "90" }, }, --ShootingStars
        { 21, { id = 202359, level = "90" }, }, --AstralCommunion 
        { 22, { id = 202360, level = "90" }, }, --BlessingoftheAncients
		--Tier 7
        { 24, { id = 202770, level = "100" }, }, --FuryofElune 
        { 25, { id = 202354, level = "100" }, }, --StellarDrift
        { 26, { id = 202430, level = "100" }, }, --NaturesBalance
      },
      [DRUID_FERAL_DIFF] = {
		--Tier 1
        { 1, { id = 202021, level = "15" }, }, --Predator 
        { 2, { id = 202022, level = "15" }, }, --BloodScent  
        { 3, { id = 155580, level = "15" }, }, --LunarInspiration
		--Tier 2
        { 5, { id = 108238, level = "30" }, }, --Renewal 
        { 6, { id = 102280, level = "30" }, }, --DisplacerBeast 
        { 7, { id = 102401, level = "30" }, }, --WildCharge 
		--Tier 3
        { 9, { id = 197488, level = "45" }, }, --BalanceAffinity 
        { 10, { id = 217615, level = "45" }, }, --GuardianAffinity
        { 11, { id = 197492, level = "45" }, }, --RestorationAffinity
		--Tier 4
        { 13, { id = 5211, level = "60" }, }, --MightyBash 
        { 14, { id = 102359, level = "60" }, }, --MassEntanglement
        { 15, { id = 132469, level = "60" }, }, --Typhoon
		--Tier 5
        { 16, { id = 158476, level = "75" }, }, --SouloftheForest
        { 17, { id = 102543, level = "75" }, }, --IncarnationKingoftheJungle 
        { 18, { id = 202032, level = "75" }, }, --JaggedWounds
		--Tier 6
        { 20, { id = 202031, level = "90" }, }, --Sabertooth
        { 21, { id = 202028, level = "90" }, }, --BrutalSlash
        { 22, { id = 52610, level = "90" }, }, --SavageRoar
		--Tier 7
        { 24, { id = 236068, level = "100" }, }, --MomentofClarity
        { 25, { id = 155672, level = "100" }, }, --Bloodtalons
        { 26, { id = 202060, level = "100" }, }, --ElunesGuidance
      },
      [DRUID_GUARDIAN_DIFF] = {
		--Tier 1
        { 1, { id = 203953, level = "15" }, }, --Brambles
        { 2, { id = 155835, level = "15" }, }, --BrstlingFur
        { 3, { id = 203962, level = "15" }, }, --BloodFrenzy  
		--Tier 2
        { 5, { id = 204012, level = "30" }, }, --GutturalRoars
        { 6, { id = 236748, level = "30" }, }, --IntimidatingRoar
        { 7, { id = 102401, level = "30" }, }, --WildCharge
		--Tier 3
        { 9, { id = 197488, level = "45" }, }, --BalanceAffinity
        { 10, { id = 202155, level = "45" }, }, --FeralAffinity
        { 11, { id = 197492, level = "45" }, }, --RestorationAffinity
		--Tier 4
        { 13, { id = 5211, level = "60" }, }, --MightyBash
        { 14, { id = 102359, level = "60" }, }, --MassEntanglement
        { 15, { id = 132469, level = "60" }, }, --Typhoon
		--Tier 5
        { 16, { id = 158477, level = "75" }, }, --SouloftheForest
        { 17, { id = 102558, level = "75" }, }, --IncarnationGuardianofUrsoc
        { 18, { id = 203964, level = "75" }, }, --GalacticGuardian
		--Tier 6
        { 20, { id = 203974, level = "90" }, }, --Earthwarden
        { 21, { id = 155578, level = "90" }, }, --GuardianofElune
        { 22, { id = 203965, level = "90" }, }, --SurvivaloftheFittest
		--Tier 7
        { 24, { id = 204053, level = "100" }, }, --RendandTear
        { 25, { id = 204066, level = "100" }, }, --LunarBeam
        { 26, { id = 80313, level = "100" }, }, --Pulverize
      },
	  [DRUID_RESTO_DIFF] = {
		--Tier 1
        { 1, { id = 200383, level = "15" }, }, --Prosperity
        { 2, { id = 102351, level = "15" }, }, --CenarionWard
        { 3, { id = 207383, level = "15" }, }, --Abundance
		--Tier 2
        { 5, { id = 108238, level = "30" }, }, --Renewal
        { 6, { id = 102280, level = "30" }, }, --DisplacerBeast
        { 7, { id = 102401, level = "30" }, }, --WildCharge
		--Tier 3
        { 9, { id = 197632, level = "45" }, }, --BalanceAffinity
        { 10, { id = 197490, level = "45" }, }, --FeralAffinity
        { 11, { id = 197491, level = "45" }, }, --GuardianAffinity
		--Tier 4
        { 13, { id = 5211, level = "60" }, }, --MightyBash
        { 14, { id = 102359, level = "60" }, }, --MassEntanglement
        { 15, { id = 132469, level = "60" }, }, --Typhoon
		--Tier 5
        { 16, { id = 158478, level = "75" }, }, --SouloftheForest
        { 17, { id = 33891, level = "75" }, }, --IncarnationTreeofLfife
        { 18, { id = 200390, level = "75" }, }, --Cultivation
		--Tier 6
        { 20, { id = 207385, level = "90" }, }, --SpringBlossom
        { 21, { id = 197073, level = "90" }, }, --InnerPeace
        { 22, { id = 155675, level = "90" }, }, --Germination
		--Tier 7
        { 24, { id = 155577, level = "100" }, }, --MomentofClarity
        { 25, { id = 197061, level = "100" }, }, --Stonebark 
        { 26, { id = 197721, level = "100" }, }, --Flourish
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [DRUID_BALANCE_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 213551, level = "2" }, }, --TrainofThought  
        { 6, { id = 213552, level = "16" }, }, --MindQuickness  
        { 7, { id = 213553, level = "34" }, }, --Initiation 
		--Tier 3
        { 9, { id = 233752, level = "4" }, }, --IronfeatherArmor 
        { 10, { id = 209730, level = "19" }, }, --ProtectoroftheGrove  
        { 11, { id = 233754, level = "37" }, }, --CelestialGuardian  
		--Tier 4
        { 13, { id = 200567, level = "6" }, }, --CrescentBurn  
        { 14, { id = 200726, level = "22" }, }, --CelestialDownpour 
        { 15, { id = 233750, level = "40" }, }, --Eclipse 
		--Tier 5  
        { 16, { id = 200549, level = "8" }, }, --PricklingThorns
        { 17, { id = 232546, level = "25" }, }, --DyingStars 
        { 18, { id = 209740, level = "43" }, }, --MoonkinAura 
		--Tier 6
        { 20, { id = 209753, level = "10" }, }, --Cyclone 
        { 21, { id = 233755, level = "28" }, }, --DeepRoots 
        { 22, { id = 209749, level = "46" }, }, --FaerieSwarm 
      },
      [DRUID_FERAL_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 236019, level = "4" }, }, --ToothandClaw 
        { 10, { id = 209730, level = "19" }, }, --ProtectoroftheGrove  
        { 11, { id = 236696, level = "37" }, }, --Thorns  
		--Tier 4
        { 13, { id = 205673, level = "6" }, }, --SavageMomentum  
        { 14, { id = 213200, level = "22" }, }, --FreedomoftheHerd 
        { 15, { id = 236012, level = "40" }, }, --MalornesSwiftness 
		--Tier 5  
        { 16, { id = 203052, level = "8" }, }, --KingoftheJungle
        { 17, { id = 236026, level = "25", rank = "Honor Talent" }, }, --EnragedMaim 
        { 18, { id = 236023, level = "43" }, }, --EarthenGrasp 
		--Tier 6
        { 20, { id = 203224, level = "10" }, }, --FreshWound 
        { 21, { id = 236020, level = "28" }, }, --FerociousWound 
        { 22, { id = 203242, level = "46" }, }, --RipandTear 
      },
      [DRUID_GUARDIAN_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195338, level = "2" }, }, --RelentlessAssault  
        { 6, { id = 207017, level = "16" }, }, --AlphaChallenge  
        { 7, { id = 201259, level = "34" }, }, --Toughness 
		--Tier 3
        { 9, { id = 236148, level = "4" }, }, --RoaringSpeed 
        { 10, { id = 236144, level = "19" }, }, --MasterShapeshifter  
        { 11, { id = 236012, level = "37" }, }, --MalornesSwiftness  
		--Tier 4
        { 13, { id = 236180, level = "6" }, }, --DenMother  
        { 14, { id = 202043, level = "22" }, }, --ProtectorofthePack 
        { 15, { id = 201664, level = "40" }, }, --DemoralizingRoar 
		--Tier 5  
        { 16, { id = 236153, level = "8" }, }, --RagingFrenzy
        { 17, { id = 213951, level = "25" }, }, --ClanDefender 
        { 18, { id = 202110, level = "43" }, }, --SharpenedClaws 
		--Tier 6
        { 20, { id = 228431, level = "10" }, }, --ChargingBash 
        { 21, { id = 202226, level = "28" }, }, --EntanglingClaws 
        { 22, { id = 202246, level = "46" }, }, --Overrun 
      },
	  [DRUID_RESTO_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195330, level = "2" }, }, --DefenderoftheWeak  
        { 6, { id = 195483, level = "16" }, }, --VimandVigor  
        { 7, { id = 195606, level = "34" }, }, --InnerRenewal 
		--Tier 3
        { 9, { id = 233673, level = "4" }, }, --Disentanglement 
        { 10, { id = 203727, level = "19" }, }, --Thorns  
        { 11, { id = 209690, level = "37" }, }, --DruidoftheClaw  
		--Tier 4
        { 13, { id = 33786, level = "6" }, }, --Cyclone  
        { 14, { id = 200931, level = "22" }, }, --EncroachingVines 
        { 15, { id = 206852, level = "40" }, }, --DeepRoots 
		--Tier 5  
        { 16, { id = 203454, level = "8" }, }, --FortifiedBark
        { 17, { id = 203374, level = "25" }, }, --Nourish 
        { 18, { id = 203399, level = "43" }, }, --Revitalize 
		--Tier 6
        { 20, { id = 203553, level = "10" }, }, --FocusedGrowth 
        { 21, { id = 203624, level = "28" }, }, --EarlySpring 
        { 22, { id = 203651, level = "46" }, }, --Overgrowth 
      },
    },
--    {
--      name = "Artifact Traits",
--      CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--     [DRUID_BALANCE_DIFF] = {
--
--      },
--     [DRUID_FERAL_DIFF] = {
--
--      },
--      [DRUID_GUARDIAN_DIFF] = {
--
--      },
--	  [DRUID_RESTO_DIFF] = {
--
--      },
--    },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\inv_glyph_minordruid",
      [GLYPH_DIFF] = {
        { 1, 233059 }, --AutumnalBloom 
        { 2, 114301 }, --Stars
		{ 3, 131113 }, --theCheetah 
		{ 4, 224122 }, --theDoe
		{ 5, 210333 }, --theFeralChameleon 
		{ 6, 219093 }, --theForestPath 
		{ 7, 114333 }, --theOrca 
		{ 8, 219062 }, --theSentinel 
		{ 9, 171803 }, --theSun 
		{ 10, 107059 }, --theUrsolChampion 
		{ 11, 233275 }, --TwilightBloom
      },
    },
  },
 }
 
-------------------
--HUNTER
-------------------

data["CLASS_HUNTER"] = {
  name = "Hunter",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("HUNTER"),
	  [HUNTER_DIFF] = {
		--Actives
		{ 1, { id = 6197, level = "18" }, }, --EagleEye
		{ 2, { id = 186257, level = "22" }, }, --AspectoftheCheetah
		{ 3, { id = 5384, level = "28" }, }, --FeignDeath
		{ 4, { id = 210000, level = "32" }, }, --WakeUp
		{ 5, { id = 1543, level = "38" }, }, --Flare
		{ 6, { id = 186265, level = "70" }, }, --AspectoftheTurtle
		--Pet Utility	
		{ 8, { id = 982, level = "1" }, }, --RevivePet
        { 9, { id = 2641, level = "10" }, }, --DismissPet
        { 10, { id = 1462, level = "13" }, }, --BeastLore	
		{ 11, { id = 6991, level = "13" }, }, --FeedPet		
		{ 12, { id = 1515, level = "13" }, }, --TameBeast
		{ 13, { id = 136, level = "14" }, }, --MendPet
		--Call Pet
        { 16, { id = 883, level = "1" }, }, --Call Pet 1
		{ 17, { id = 83242, level = "13" }, }, --CallPet2
		{ 18, { id = 83243, level = "34" }, }, --CallPet3
		{ 19, { id = 83244, level = "57" }, }, --CallPet4
        { 20, { id = 83245, level = "80" }, }, --CallPet5 
		--Passive
		{ 22, { id = 157443, level = "1" }, }, --CriticalStrikes
		{ 23, { id = 93321, level = "10" }, }, --ControlPet
		--Skills
        { 25, { id = 76250}, }, --ArmorSkills
		{ 26, { id = 86538}, }, --MailSpecialization
        { 27, { id = 76249}, }, --Weapon Skills
		--Mecha-Bond Imprint Matrix		
		{ 101, { id = 205154, level = "1", rank = "Mecha-Bond Imprint Matrix" }, }, --MechaBondImprintMatrix
		{ 102, { id = 229533, level = "1", rank = "Mecha-Bond Imprint Matrix" }, }, -- TrackMechanicals
		--Class Books
        { 104, { id = 61648, level = "40", rank = "The Art of Concealment" }, },	--AspectoftheChameleon	
		{ 105, { id = 125050, level = "40", rank = "Pet Training Manual" }, },  --Fetch
		{ 106, { id = 127933, level = "40", rank = "Fireworks Instruction Manual" }, },	--Fireworks
        { 107, { id = 209997, level = "40", rank = "Pet Training Manual" }, },	--PlayDead
		--Tomes
		{ 109, { id = 138430, level = "90", rank = "Ancient Tome of Dinomancy" }, }, --AncientZandalariKnowledge
		{ 110, { id = 242155, level = "110", rank = "Tome of Hybrid Kinship" }, }, --Hybrid Kinship
		--Hunter Tracking
		{ 116, { id = 1494, level = "4" }, }, --TrackBeasts
        { 117, { id = 19878, level = "4" }, }, --TrackDemons
        { 118, { id = 19879, level = "4" }, }, --TrackDragonkin
        { 119, { id = 19880, level = "4" }, }, --TrackElementsl		
        { 120, { id = 19882, level = "4" }, }, --TrackGiants
        { 121, { id = 19885, level = "4" }, }, --TrackHidden	
        { 122, { id = 19883, level = "4" }, }, --TrackHumanoids
        { 123, { id = 19884, level = "4" }, }, --TrackUndead
      }, 
      [HUNTER_BM_DIFF] = {
		--Actives
        { 1, { id = 193455, level = "1"}, }, --CobraShot
        { 2, { id = 5116, level = "4" }, }, --ConcussiveShot
        { 3, { id = 34026, level = "10" }, }, --KillCommand
		{ 4, { id = 120679, level = "12" }, }, --DireBeast
        { 5, { id = 2643, level = "16" }, }, --MultiShot  
		{ 6, { id = 187650, level = "18" }, }, --FreezingTrap
		{ 7, { id = 109304, level = "24" }, }, --Exhilaration
	    { 8, { id = 193530, level = "26" }, }, --AspectoftheWild
		{ 9, { id = 147362, level = "32" }, }, --Countershot
		{ 10, { id = 187698, level = "36" }, }, --TarTrap  
		{ 11, { id = 19574, level = "40" }, }, --BestialWrath
		{ 12, { id = 34477, level = "42" }, },	--Misdirection
		{ 13, { id = 781, level = "45" }, }, --Disengage		
		--Passives
		{ 16, { id = 53270, level = "10", rank = "Hidden Passive " }, }, --ExoticBeasts
		{ 17, { id = 185789, level = "20", rank = "Passive " }, }, --WildCall
		{ 18, { id = 56315, level = "44", rank = "Passive " }, }, --KindredSpirits
		{ 19, { id = 115939, level = "50", rank = "Passive " }, }, --BeastCleave
        { 20, { id = 76657, level = "78", rank = "Passive " }, }, --Mastery: MasterofBeasts	
      },
      [HUNTER_MM_DIFF] = {
		--Actives
		{ 1, { id = 193455, level = "1" }, }, --CobraShot
        { 2, { id = 5116, level = "4" }, }, --ConcussiveShot
        { 3, { id = 185358, level = "10" }, },	--ArcaneShot
		{ 4, { id = 19434, level = "12" }, },	--AimedShot
        { 5, { id = 2643, level = "16" }, }, --MultiShot
		{ 6, { id = 187650, level = "18" }, }, --FreezingTrap
        { 7, { id = 185901, level = "20" }, }, --MarkedShot
		{ 8, { id = 109304, level = "24" }, }, --Exhilaration
        { 9, { id = 186387, level = "26" }, }, --BurstingShot
        { 10, { id = 147362, level = "32" }, }, --Countershot
		{ 11, { id = 187698, level = "36" }, }, --TarTrap  
        { 12, { id = 193526, level = "40" }, }, --Trueshot
        { 13, { id = 34477, level = "42" }, }, --Misdirection
		{ 14, { id = 781, level = "45" }, }, --Disengage		
		--Passive
		{ 16, { id = 185987, level = "20", rank = "Passive " }, }, --HuntersMark
		{ 17, { id = 231554, level = "44", rank = "Passive " }, }, --MarksmanFocus
		{ 18, { id = 35110, level = "50", rank = "Passive " }, }, --Bombardment
        { 19, { id = 212658, level = "58", rank = "Passive " }, },	--HuntingParty
        { 20, { id = 193468, level = "78", rank = "Passive " }, },	--Mastery: SniperTraining		
      },
      [HUNTER_SV_DIFF] = {
		--Active
		{ 1, { id = 190925, level = "10" }, }, --Harpoon
        { 2, { id = 186270, level = "10" }, }, --RaptorStrike 
        { 3, { id = 195645, level = "10" }, }, --WingClip  
        { 4, { id = 202800, level = "12" }, }, --FlankingStrike  
		{ 5, { id = 193265, level = "14" }, }, --HatchetToss 
		{ 6, { id = 187650, level = "18" }, }, --FreezingTrap
        { 7, { id = 190928, level = "20" }, }, -- MongooseBite
		{ 8, { id = 109304, level = "24" }, }, --Exhilaration
        { 9, { id = 185855, level = "26" }, }, --Lacerate 
        { 10, { id = 187707, level = "32" }, }, --Muzzle  		
		{ 11, { id = 187698, level = "36" }, }, --TarTrap  
        { 12, { id = 186289, level = "40" }, }, --AspectoftheEagle 
        { 13, { id = 187708, level = "42" }, },	--Carve  
		{ 14, { id = 191433, level = "50" }, }, --ExplosiveTrap	
		--Passive
		{ 16, { id = 164856, level = "16", rank = "Passive " }, }, --Survivalist 
		{ 17, { id = 234955, level = "44", rank = "Passive " }, }, --Waylay
		{ 18, { id = 191334, level = "78", rank = "Passive " }, }, --Mastery: HuntingCompanion
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [HUNTER_BM_DIFF] = {
		--Tier 1 
        { 1, { id = 204308, level = "15" }, }, --BigGameHunter 
        { 2, { id = 194397, level = "15" }, }, --WayoftheCobra 
        { 3, { id = 193532, level = "15" }, }, --DireStable 
		--Tier 2
        { 5, { id = 199530, level = "30" }, }, --Stomp 
        { 6, { id = 217200, level = "30" }, }, --DireFrenzy 
        { 7, { id = 53209, level = "30" }, }, --Chimaera Shot 
		--Tier 3
        { 9, { id = 109215, level = "45" }, }, --Posthaste 
        { 10, { id = 199523, level = "45" }, }, --Farstrider 
        { 11, { id = 199921, level = "45" }, }, --Trailblazer 
		--Tier 4 
        { 13, { id = 199528, level = "60" }, }, --OnewiththePack
        { 14, { id = 194306, level = "60" }, }, --BestialFury 
        { 15, { id = 130392, level = "60" }, }, --BlinkStrikes
		--Tier 5
        { 16, { id = 109248, level = "75" }, }, --BindingShot 
        { 17, { id = 19386, level = "75" }, }, --WyvernSting 
        { 18, { id = 19577, level = "75" }, }, --Intimidation
		--Tier 6
        { 20, { id = 131894, level = "90" }, }, --AMurderofCrows
        { 21, { id = 120360, level = "90" }, }, --Barrage 
        { 22, { id = 194386, level = "90" }, }, --Volley
		--Tier 7
        { 24, { id = 201430, level = "100" }, }, --Stampede
        { 25, { id = 199532, level = "100" }, }, --KillerCobra 
        { 26, { id = 191384, level = "100" }, }, --AspectoftheBeast
      },
      [HUNTER_MM_DIFF] = {
		--Tier 1
        { 1, { id = 155228, level = "15" }, }, --LoneWolf 
        { 2, { id = 193533, level = "15" }, }, --SteadyFocus 
        { 3, { id = 53238, level = "15" }, }, --CarefulAim 
		--Tier 2
        { 5, { id = 194595, level = "30" }, }, --LockandLoad 
        { 6, { id = 194599, level = "30" }, }, --BlackArrow
        { 7, { id = 199527, level = "30" }, }, --TrueAim 
		--Tier 3
        { 9, { id = 109215, level = "45" }, }, --Posthaste 
        { 10, { id = 199523, level = "45" }, }, --Farstrider 
        { 11, { id = 199921, level = "45" }, }, --Trailblazer 
		--Tier 4
        { 13, { id = 212431, level = "60" }, }, --ExplosiveShot 
        { 14, { id = 206817, level = "60" }, }, --Sentinel 
        { 15, { id = 234588, level = "60" }, }, --PatientSniper 
		--Tier 5
        { 16, { id = 109248, level = "75" }, }, --BindingShot 
        { 17, { id = 19386, level = "75" }, }, --WyvernSting 
        { 18, { id = 199483, level = "75" }, }, --Camouflage
		--Tier 6
        { 20, { id = 131894, level = "90" }, }, --AMurderofCrows 
        { 21, { id = 120360, level = "90" }, }, --Barrage 
        { 22, { id = 194386, level = "90" }, }, --Volley 
		--Tier 7
        { 24, { id = 214579, level = "100" }, }, --Sidewinders 
        { 25, { id = 198670, level = "100" }, }, --PiercingShot 
        { 26, { id = 199522, level = "100" }, }, --TrickShot
      },
      [HUNTER_SV_DIFF] = {
		--Tier 1
        { 1, { id = 204315, level = "15" }, }, --AnimalInstincts 
        { 2, { id = 200163, level = "15" }, }, --ThrowingAxes 
        { 3, { id = 201082, level = "15" }, }, --WayoftheMokNathal 
		--Tier 2
        { 5, { id = 206505, level = "30" }, }, --AMurderofCrows 
        { 6, { id = 201075, level = "30" }, }, --MortalWounds 
        { 7, { id = 201078, level = "30" }, }, --SnakeHunter 
		--Tier 3
        { 9, { id = 109215, level = "45" }, }, --Posthaste 
        { 10, { id = 781, level = "45" }, }, --Disengage 
        { 11, { id = 199921, level = "45" }, }, --Trailblazer 
		--Tier 4
        { 13, { id = 194277, level = "60" }, }, --Caltrops 
        { 14, { id = 236698, level = "60" }, }, --GuerillaTactics 
        { 15, { id = 162488, level = "60" }, }, --SteelTrap 
		--Tier 5
        { 16, { id = 191241, level = "75" }, }, --StickyBomb 
        { 17, { id = 200108, level = "75" }, }, --RangerNet 
        { 18, { id = 199483, level = "75" }, }, --Camouflage 
		--Tier 6
        { 20, { id = 212436, level = "90" }, }, --Butchery 
        { 21, { id = 194855, level = "90" }, }, --DragonsfireGrenade 
        { 22, { id = 87935, level = "90" }, }, --SerpentSting 
		--Tier 7
        { 24, { id = 194407, level = "100" }, }, --SpittingCobra 
        { 25, { id = 199543, level = "100" }, }, --ExpertTrapper 
        { 26, { id = 191384, level = "100" }, }, --AspectoftheBeast
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [HUNTER_BM_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 213538, level = "2" }, }, --Quickshots  
        { 6, { id = 213539, level = "16" }, }, --Initiation  
        { 7, { id = 213543, level = "34" }, }, --FocusedFire 
		--Tier 3
        { 9, { id = 202589, level = "4" }, }, --DragonscaleArmor 
        { 10, { id = 202624, level = "19" }, }, --CatlikeReflexes  
        { 11, { id = 202746, level = "37" }, }, --SurvivalTactics  
		--Tier 4
        { 13, { id = 202797, level = "6" }, }, --ViperSting  
        { 14, { id = 202900, level = "22", rank = "Honor Talent" }, }, --ScorpidSting 
        { 15, { id = 202914, level = "40", rank = "Honor Talent" }, }, --SpiderSting 
		--Tier 5  
        { 16, { id = 212668, level = "8" }, }, --TheBeastWithin
        { 17, { id = 212669, level = "25" }, }, --SeparationAnxiety 
        { 18, { id = 204190, level = "43" }, }, --WildProtector 
		--Tier 6
        { 20, { id = 208652, level = "10" }, }, --DireBeastHawk 
        { 21, { id = 205691, level = "28", rank = "Honor Talent" }, }, --DireBeastBasilisk
        { 22, { id = 248518, level = "46" }, }, --Interlope 
      },
      [HUNTER_MM_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 213538, level = "2" }, }, --Quickshot  
        { 6, { id = 213539, level = "16" }, }, --Initiation  
        { 7, { id = 213543, level = "34" }, }, --FocusedFire 
		--Tier 3
        { 9, { id = 202589, level = "4" }, }, --DragonscaleArmor 
        { 10, { id = 202624, level = "19" }, }, --CatlikeReflexes  
        { 11, { id = 202746, level = "37" }, }, --SurvivalTactics  
		--Tier 4
        { 13, { id = 202797, level = "6" }, }, --ViperSting  
        { 14, { id = 202900, level = "22", rank = "Honor Talent" }, }, --ScorpidSting 
        { 15, { id = 202914, level = "40", rank = "Honor Talent" }, }, --SpiderSting 
		--Tier 5  
        { 16, { id = 209793, level = "8" }, }, --TNT
        { 17, { id = 213691, level = "25" }, }, --ScatterShot 
        { 18, { id = 236776, level = "43", rank = "Honor Talent" }, }, --HiExplosiveTrap 
		--Tier 6
        { 20, { id = 203129, level = "10" }, }, --TrueshotMastery 
        { 21, { id = 248443, level = "28" }, }, --RangersFinesse 
        { 22, { id = 203155, level = "46" }, }, --SniperShot 
      },
      [HUNTER_SV_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 202589, level = "4" }, }, --DragonscaleArmor 
        { 10, { id = 202624, level = "19" }, }, --CatlikeReflexes  
        { 11, { id = 202746, level = "37" }, }, --SurvivalTactics  
		--Tier 4
        { 13, { id = 202797, level = "6" }, }, --ViperSting  
        { 14, { id = 202900, level = "22", rank = "Honor Talent" }, }, --ScorpidSting 
        { 15, { id = 202914, level = "40", rank = "Honor Talent" }, }, --SpiderSting 
		--Tier 5  
        { 16, { id = 203235, level = "8" }, }, --HuntingPack
        { 17, { id = 212640, level = "25", rank = "Honor Talent" }, }, --MendingBandage 
        { 18, { id = 53271, level = "43", rank = "Honor Talent" }, }, --MastersCall
		--Tier 6
        { 20, { id = 203264, level = "10" }, }, --StickyTar 
        { 21, { id = 203340, level = "28" }, }, --DiamondIce 
        { 22, { id = 212638, level = "46" }, }, --TrackersNet 
      },
    },
--    {
--      name = "Artifact Traits",
--      CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--      [HUNTER_BM_DIFF] = {
--
--      },
--      [HUNTER_MM_DIFF] = {
--
--      },
--      [HUNTER_SV_DIFF] = {
--
--      },
--   },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\inv_glyph_minorhunter",
      [GLYPH_DIFF] = {
        { 1, 212407 }, --Arachnophobia 
        { 2, 57870 }, --LesserProportion 
		{ 3, 212410 }, --NesingwarysNemesis 
		{ 4, 212462 }, --StellarFlare
		{ 5, 126193 }, --theBullseye 
		{ 6, 219183 }, --theDireStable 
		{ 7, 212451 }, --theGoblinAntiGravFlare
		{ 8, 212358 }, --theHeadhunter 
		{ 9, 212354 }, --theHook 
		{ 10, 212439 }, --theSkullseye
		{ 11, 212339 }, --theTrident
      },
    },
	{
      name = "Pet Abilities",
      CoinTexture = "texture:Interface\\Icons\\ability_druid_ferociousbite",
	 [HUNTER_PET_SPEC_DIFF] = {	
	--Ferocity 			
        { 1, { id = 61684, rank = "" }, }, --Dash
        { 2, { id = 55709, rank = "" }, }, --Heart of the Phoenix
	    { 3, { id = 53184, rank = "Ferocity Passive" }, }, --Spiked Collar
	--Tenacity
        { 5, { id = 61685, rank = "" }, }, --Charge
        { 6, { id = 53478, rank = "" }, }, --LastStand
        { 7, { id = 63900, rank = "" }, }, --Thunderstomp
        { 8, { id = 53482, rank = "Tenacity Passive" }, }, --BloodoftheRhino
        { 9, { id = 61688, rank = "Tenacity Passive" }, }, --GreatStamina
	--Cunning
        { 11, { id = 53490, rank = "" }, }, --Bullheaded
        { 12, { id = 61684, rank = "" }, }, --Dash
        { 13, { id = 53480, rank = "" }, }, --RoarofSacrifice
        { 14, { id = 53497, rank = "Cunning Passive" }, }, --Cornered
        { 15, { id = 19596, rank = "Cunning Passive" }, }, --BoarSpeed
	--Basic Abilities  	
        { 16, { id = 17253, rank = "", name = "Bite" }, }, --Bite
        { 17, { id = 16827, rank = "", name = "Claw" }, }, --Claw
        { 18, { id = 49966, rank = "", name = "Smack" }, }, --Smack
        { 20, { id = 2649, rank = "", name = "Growl" }, }, --Growl	
    --Passives		
		{ 22, { id = 65220, rank = "", name = "Avoidance" }, }, --Avoidance
        { 23, { id = 20782, rank = "Passive", name = "Combat Experience" }, }, --CombatExperience	
		{ 24, { id = 191336, rank = "Passive", name = "" }, }, --HuntingCompanion(Survival)	
      },
     [HUNTER_PET_FAMILY_DIFF] = {	
		--Basilisk
        { 1, { id = 159733, rank = COLOR_PET_FAMILY.."Basilisk" }, }, --StoneScales
		--Bear
		{ 2, { id = 94019, rank = COLOR_PET_FAMILY.."Bear" }, }, --Rest
		--Beetle
		{ 3, { id = 90339, rank = COLOR_PET_FAMILY.."Beetle" }, }, --HardenCarapace
		--Bird of Prey
		{ 4, { id = 94022, rank = COLOR_PET_FAMILY.."Bird of Prey" }, }, --Trick
		--Carrion Bird
		{ 5, { id = 24423, rank = COLOR_PET_FAMILY.."Carrion Bird" }, }, --BloodyScreech
		--Cat
		{ 6, { id = 24450, rank = COLOR_PET_FAMILY.."Cat" }, }, --Prowl
		--Crab
		{ 7, { id = 159926, rank = COLOR_PET_FAMILY.."Crab" }, }, --HardenShell
		--Crane
		{ 8, { id = 159931, rank = COLOR_PET_FAMILY.."Crane" }, }, --GiftofChiJi
		{ 9, { id = 126259, rank = COLOR_PET_FAMILY.."Crane" }, }, --Trick
		--Crocolisk
		{ 10, { id = 50433, rank = COLOR_PET_FAMILY.."Crocolisk" }, }, --AnkleCrack
		--Direhorn
        { 11, { id = 137798, rank = COLOR_PET_FAMILY.."Direhorn" }, }, --ReflectiveArmorPlating
		--Feathermane
        { 12, { id = 160007, rank = COLOR_PET_FAMILY.."Feathermane" }, }, --Updraft
		--Fox
		{ 13, { id = 160011, rank = COLOR_PET_FAMILY.."Fox" }, }, --AgileReflexes
		{ 14, { id = 90347, rank = COLOR_PET_FAMILY.."Fox" }, }, --Play
		--Monkey
		{ 15, { id = 160044, rank = COLOR_PET_FAMILY.."Monkey" }, }, --PrimalAgility
		--Moth
		{ 16, { id = 159956, rank = COLOR_PET_FAMILY.."Moth" }, }, --DustofLife
		--Nether Ray
		{ 17, { id = 160452, rank = COLOR_PET_FAMILY.."Nether Ray" }, }, --Netherwinds
		--Riverbeast
		{ 18, { id = 160018, rank = COLOR_PET_FAMILY.."Riverbeast" }, }, --GruesomeBite
		--Rodent
		{ 19, { id = 126364, rank = COLOR_PET_FAMILY.."Rodent" }, }, --Rest
		--Scorpid
		{ 20, { id = 160060, rank = COLOR_PET_FAMILY.."Scorpid" }, }, --DeadlySting
		--Spider
		{ 21, { id = 160067, rank = COLOR_PET_FAMILY.."Spider" }, }, --WebSpray
		--Turtle
		{ 22, { id = 26064, rank = COLOR_PET_FAMILY.."Turtle" }, }, --ShellShield
		--Warp Stalker
		{ 23, { id = 35346, rank = COLOR_PET_FAMILY.."Warp Stalker" }, }, --WarpTime
      },
     [HUNTER_PET_EXOTICFAMILY_DIFF] = {	
		--Chimaera
        { 1, { id = 54644, rank = COLOR_PET_FAMILY.."Chimaera" }, }, --FrostBreath
        { 2, { id = 92380, rank = COLOR_PET_FAMILY.."Chimaera" }, }, --FroststormBreath
		--Clefthoof
        { 3, { id = 160057, rank = COLOR_PET_FAMILY.."Clefthoof" }, }, --ThickHide
		--Core Hound
        { 4, { id = 90355, rank = COLOR_PET_FAMILY.."Core Hound" }, }, --AncientHysteria
        { 5, { id = 159788, rank = COLOR_PET_FAMILY.."Core Hound" }, }, --MoltenHide
		--Devilsaur
        { 6, { id = 159953, rank = COLOR_PET_FAMILY.."Devilsaur" }, }, --Feast
		{ 7, { id = 54680, rank = COLOR_PET_FAMILY.."Devilsaur" }, }, --MonstrousBite
		--Quilen
        { 8, { id = 126393, rank = COLOR_PET_FAMILY.."Quilen" }, }, --EternalGuardian
        { 9, { id = 160049, rank = COLOR_PET_FAMILY.."Quilen" }, }, --StoneArmor
		--Rylak
		{ 10, { id = 160007, rank = COLOR_PET_FAMILY.."Rylak" }, }, --Updraft
		--Shale Spider
		{ 11, { id = 160063, rank = COLOR_PET_FAMILY.."Shale Spider" }, }, --Solid Shell
		--Silithid
        { 12, { id = 160065, rank = COLOR_PET_FAMILY.."Silithid" }, }, --TendonRip
		--Spirit Beast
        { 13, { id = 90361, rank = COLOR_PET_FAMILY.."Spirit Beast" }, }, --SpiritMend
        { 14, { id = 90328, rank = COLOR_PET_FAMILY.."Spirit Beast" }, }, --SpiritWalk
		--Water Strider
        { 15, { id = 126311, rank = COLOR_PET_FAMILY.."Water Strider" }, }, --SurfaceTrot
		--Worm
        { 16, { id = 93433, rank = COLOR_PET_FAMILY.."Worm" }, }, --BurrowAttack
      },
    },
  },
 }
 
-------------------
--MAGE
-------------------

data["CLASS_MAGE"] = {
  name = "Mage",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("MAGE"),
	  [MAGE_DIFF] = {
		--Actives
		{ 1, { id = 122, level = "5" }, }, --FrostNova
		{ 2, { id = 118, level = "8" }, }, --Polymorph
		{ 3, { id = 190336, level = "13" }, }, --ConjureRefreshment
		{ 4, { id = 1953, level = "16" }, }, --Blink
		{ 5, { id = 2139, level = "22" }, }, --Counterspell
		{ 6, { id = 130, level = "38" }, }, --SlowFall
		{ 7, { id = 45438, level = "50" }, }, --IceBlock		
		{ 8, { id = 30449, level = "70" }, }, --Spellsteal
		{ 9, { id = 80353, level = "80" }, }, --TimeWarp
		--Skills
        { 11, { id = 76276}, }, --ArmorSkills
        { 12, { id = 76298}, }, --WeaponSkills
		{ 13, { id = 89744}, }, --Wizardry	
		--PolymorphTomes
		{ 16, { id = 161354, level = "1" }, }, --Monkey	
		{ 17, { id = 161355, level = "1" }, }, --Penguin
		{ 18, { id = 161353, level = "1" }, }, --PolarBearCub			
		{ 19, { id = 126819, level = "1" }, }, --Porcupine	
		{ 20, { id = 61305, level = "60" }, }, --BlackCat
		{ 21, { id = 61721, level = "60" }, }, --Rabbit	
		{ 22, { id = 28271, level = "60" }, }, --Turtle
		--Class Trainer
		{ 24, { id = 56384, rank = "Passive, Class Trainer" }, },	--ArcaneMomentum	
		--Class Books
		{ 26, { id = 131784, level = "49", rank = "Mystical Tome" }, },	--Illusion
		{ 27, { id = 210086, level = "58", rank = "Mystical Tome" }, },	--ArcaneLinguist
      }, 
      [MAGE_ARCANE_DIFF] = {
		--Actives
	    { 1, { id = 44425, level = "10" }, }, --ArcaneBarrage
		{ 2, { id = 30451, level = "10" }, }, --ArcaneBlast
        { 3, { id = 5143, level = "12" }, }, --ArcaneMissiles
        { 4, { id = 1449, level = "18"}, }, --ArcaneExplosion
		{ 5, { id = 12051, level = "20" }, }, --Evocation
		{ 6, { id = 195676, level = "24" }, }, --Displacement
        { 7, { id = 235450, level = "26" }, }, --PrismaticBarrier 		
        { 8, { id = 31589, level = "32" }, }, --Slow 			
		{ 9, { id = 12042, level = "40" }, }, --ArcanePower
		{ 10, { id = 66, level = "42" }, }, --Invisibility	
		{ 11, { id = 195676, level = "48" }, }, --Displacement	
		{ 12, { id = 205025, level = "54" }, },	--PresenceofMind
        { 13, { id = 110959, level = "65" }, }, --GreaterInvisibility	
		--Passives
        { 16, { id = 190740, level = "78", rank = "Passive " }, }, --Mastery: Savant  
      },
      [MAGE_FIRE_DIFF] = {
		--Actives
		{ 1, { id = 108853, level = "3" }, }, --FireBlast
		{ 2, { id = 133, level = "10" }, }, --Fireball
		{ 3, { id = 11366, level = "12" }, },	--Pyroblast
        { 4, { id = 2948, level = "18" }, }, --Scorch
		{ 5, { id = 2120, level = "20" }, }, --Flamestrike		
	    { 6, { id = 235313, level = "26" }, }, --Blazing Barrier
	    { 7, { id = 31661, level = "18"}, }, --DragonBreath
		{ 8, { id = 190319, level = "40" }, }, --Combustion
		{ 9, { id = 66, level = "42" }, }, --Invisibility	
		--Passives
 		{ 16, { id = 117216, level = "10", rank = "Passive " }, }, --CriticalMass
 		{ 17, { id = 195283, level = "14", rank = "Passive " }, }, --HotStreak	
 		{ 18, { id = 157642, level = "35", rank = "Passive " }, }, --EnhancedPyrotechnics
 		{ 19, { id = 86949, level = "52", rank = "Passive " }, }, --Cauterize 		
		{ 20, { id = 12846, level = "78", rank = "Passive " }, }, --Mastery: Ignite 
	},
      [MAGE_FROST_DIFF] = {
		--Actives
		{ 1, { id = 116, level = "1" }, }, --Frostbolt
		{ 2, { id = 108853, level = "3" }, }, --FireBlast
        { 3, { id = 30455, level = "10" }, }, --IceLance
		{ 4, { id = 31687, level = "12" }, }, --SummonWaterElemental
	    { 5, { id = 190356, level = "18" }, }, --Blizzard
		{ 6, { id = 44614, level = "20" }, }, --Flurry
		{ 7, { id = 11426, level = "26" }, },	--IceBarrier
        { 8, { id = 120, level = "34" }, }, --ConeofCold
        { 9, { id = 12472, level = "40" }, }, --IcyVeins
		{ 10, { id = 66, level = "42" }, }, --Invisibility	
        { 11, { id = 235219, level = "52"}, }, --ColdSnap
        { 12, { id = 84714, level = "57" }, }, --FrozenOrb		
		--Passives
        { 16, { id = 12982, level = "14", rank = "Passive " }, }, --Shatter
		{ 17, { id = 112965, level = "24", rank = "Passive " }, }, --FingersofFrost
		{ 18, { id = 190447, level = "28", rank = "Passive " }, }, --BrainFreeze
        { 19, { id = 76613, level = "78", rank = "Passive " }, }, --Mastery: Icicles 
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [MAGE_ARCANE_DIFF] = {
		--Tier 1 
        { 1, { id = 205022, level = "15" }, }, --ArcaneFamiliar
        { 2, { id = 236628, level = "15" }, }, --Amplificiation
        { 3, { id = 205035, level = "15" }, }, --WordsofPower 
		--Tier 2
        { 5, { id = 212653, level = "30" }, }, --Shimmer 
        { 6, { id = 236457, level = "30" }, }, --Slipstream
        { 7, { id = 235463, level = "30" }, }, --Mana hield
		--Tier 3
        { 9, { id = 55342, level = "45" }, }, --MirrorImage 
        { 10, { id = 116011, level = "45" }, }, --RuneofPower 
        { 11, { id = 1463, level = "45" }, }, --IncanterFlow 
		--Tier 4 
        { 13, { id = 157980, level = "60" }, }, --Supernova
        { 14, { id = 205032, level = "60" }, }, --ChargedUp 
        { 15, { id = 205028, level = "60" }, }, --Resonance
		--Tier 5
        { 16, { id = 235711, level = "75" }, }, --ChronoShift
        { 17, { id = 113724, level = "75" }, }, --RingofFrost
        { 18, { id = 205036, level = "75" }, }, --IceWard
		--Tier 6
        { 20, { id = 114923, level = "90" }, }, --Nether Tempest
        { 21, { id = 157976, level = "90" }, }, --UnstableMagic
        { 22, { id = 205039, level = "90" }, }, --Erosion
		--Tier 7
        { 24, { id = 155147, level = "100" }, }, --Overpowered
        { 25, { id = 234302, level = "100" }, }, --TemporalFlux
        { 26, { id = 153626, level = "100" }, }, --ArcaneOrb
      },
      [MAGE_FIRE_DIFF] = {
		--Tier 1
        { 1, { id = 205020, level = "15" }, }, --Pyromaniac
        { 2, { id = 205023, level = "15" }, }, --Conflagration 
        { 3, { id = 205026, level = "15" }, }, --Firestarter
		--Tier 2
        { 5, { id = 212653, level = "30" }, }, --Shimmer 
        { 6, { id = 157981, level = "30" }, }, --BlastWave
        { 7, { id = 235365, level = "30" }, }, --BlazingSoul
		--Tier 3
        { 9, { id = 55342, level = "45" }, }, --MirrorImage 
        { 10, { id = 116011, level = "45" }, }, --RuneofPower 
        { 11, { id = 1463, level = "45" }, }, --IncanterFlow 
		--Tier 4
        { 13, { id = 235870, level = "60" }, }, --AlexstraszaFury
        { 14, { id = 205029, level = "60" }, }, --FlameOn 
        { 15, { id = 205033, level = "60" }, }, --ControlledBurn
		--Tier 5
        { 16, { id = 236058, level = "75" }, }, --FreneticSpeed 
        { 17, { id = 113724, level = "75" }, }, --RingofFrost 
        { 18, { id = 205036, level = "75" }, }, --IceWard
		--Tier 6
        { 20, { id = 44457, level = "90" }, }, --LivingBomb
        { 21, { id = 157976, level = "90" }, }, --UnstableMagic 
        { 22, { id = 205037, level = "90" }, }, --FlamePatch 
		--Tier 7
        { 24, { id = 155148, level = "100" }, }, --Kindling 
        { 25, { id = 198929, level = "100" }, }, --Cinderstorm 
        { 26, { id = 153561, level = "100" }, }, --Meteor
      },
      [MAGE_FROST_DIFF] = {
		--Tier 1
        { 1, { id = 205021, level = "15" }, }, --RayofFrost
        { 2, { id = 205024, level = "15" }, }, --LonelyWinter 
        { 3, { id = 205027, level = "15" }, }, --BoneChilling
		--Tier 2
        { 5, { id = 212653, level = "30" }, }, --Shimmer
        { 6, { id = 108839, level = "30" }, }, --IceFloes
        { 7, { id = 235297, level = "30" }, }, --GlacialInsulation
		--Tier 3
        { 9, { id = 55342, level = "45" }, }, --MirrorImage 
        { 10, { id = 116011, level = "45" }, }, --RuneofPower 
        { 11, { id = 1463, level = "45" }, }, --IncanterFlow 
		--Tier 4
        { 13, { id = 157997, level = "60" }, }, --IceNova 
        { 14, { id = 205030, level = "60" }, }, --FrozeTouch
        { 15, { id = 56377, level = "60" }, }, --SplittingIce 
		--Tier 5
        { 16, { id = 235224, level = "75" }, }, --FrigidWinds
        { 17, { id = 113724, level = "75" }, }, --RingofFrost 
        { 18, { id = 205036, level = "75" }, }, --IceWard 
		--Tier 6
        { 20, { id = 112948, level = "90" }, }, --FrostBomb 
        { 21, { id = 157976, level = "90" }, }, --UnstableMagic
        { 22, { id = 205038, level = "90" }, }, --ArcticGale
		--Tier 7
        { 24, { id = 155149, level = "100" }, }, --ThermalVoid
        { 25, { id = 199786, level = "100" }, }, --GlacialSpike 
        { 26, { id = 153595, level = "100" }, }, --CometStorm
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [MAGE_ARCANE_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 213542, level = "2" }, }, --TrainofThought
        { 6, { id = 213540, level = "16" }, }, --MindQuickness  
        { 7, { id = 213541, level = "34" }, }, --Initiation 
		--Tier 3
        { 9, { id = 198062, level = "4" }, }, --NetherwindArmor 
        { 10, { id = 198063, level = "19" }, }, --BurningDetermination  
        { 11, { id = 198064, level = "37" }, }, --PrismaticCloak  
		--Tier 4
        { 13, { id = 198111, level = "6" }, }, --TemporalShield  
        { 14, { id = 236788, level = "22" }, }, --DampenedMagic 
        { 15, { id = 198100, level = "40" }, }, --Kelptomania 
		--Tier 5  
        { 16, { id = 198155, level = "8" }, }, --ConcentratedPower
        { 17, { id = 198151, rank = "Honor Talent", level = "25" }, }, --TormentoftheWeak 
        { 18, { id = 210805, level = "43" }, }, --TimeAnomaly 
		--Tier 6
        { 20, { id = 210476, level = "10" }, }, --MasterofEscape 
        { 21, { id = 213220, level = "28" }, }, --RewindTime 
        { 22, { id = 198158, level = "46" }, }, --MassInvisibility 
      },
      [MAGE_FIRE_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 213542, level = "2" }, }, --TrainofThought
        { 6, { id = 213540, level = "16" }, }, --MindQuickness  
        { 7, { id = 213541, level = "34" }, }, --Initiation 
		--Tier 3
        { 9, { id = 198062, level = "4" }, }, --NetherwindArmor 
        { 10, { id = 198063, level = "19" }, }, --BurningDetermination  
        { 11, { id = 198064, level = "37" }, }, --PrismaticCloak  
		--Tier 4
        { 13, { id = 198111, level = "6" }, }, --TemporalShield  
        { 14, { id = 236788, level = "22" }, }, --DampenedMagic 
        { 15, { id = 198100, level = "40" }, }, --Kelptomania 
		--Tier 5  
        { 16, { id = 203275, level = "8" }, }, --Tinder
        { 17, { id = 203280, level = "25" }, }, --WorldinFlames 
        { 18, { id = 203282, level = "43" }, }, --FlareUp 
		--Tier 6
        { 20, { id = 203283, level = "10" }, }, --Firestarter 
        { 21, { id = 203284, level = "28" }, }, --Flamecannon 
        { 22, { id = 203286, level = "46" }, }, --GreaterPyroblast 
      },
      [MAGE_FROST_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 213542, level = "2" }, }, --TrainofThought
        { 6, { id = 213540, level = "16" }, }, --MindQuickness  
        { 7, { id = 213541, level = "34" }, }, --Initiation 
		--Tier 3
        { 9, { id = 198062, level = "4" }, }, --NetherwindArmor 
        { 10, { id = 198063, level = "19" }, }, --BurningDetermination  
        { 11, { id = 198064, level = "37" }, }, --PrismaticCloak  
		--Tier 4
        { 13, { id = 198111, level = "6" }, }, --TemporalShield  
        { 14, { id = 236788, level = "22" }, }, --DampenedMagic 
        { 15, { id = 198100, level = "40" }, }, --Kelptomania 
		--Tier 5  
        { 16, { id = 198126, level = "8" }, }, --ChilledtotheBone
        { 17, { id = 198120, level = "25" }, }, --Frostbite 
        { 18, { id = 198123, level = "43" }, }, --DeepShatter 
		--Tier 6
        { 20, { id = 198148, level = "10" }, }, --ConcentratedCoolness 
        { 21, { id = 206431, level = "28" }, }, --BurstofCold 
        { 22, { id = 198144, level = "46" }, }, --IceForm 
      },
    },
--    {
--      name = "Artifact Traits",
--      CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--      [MAGE_ARCANE_DIFF] = {
--
--      },
--      [MAGE_FIRE_DIFF] = {
--
--      },
--     [MAGE_FROST_DIFF] = {
--
--      },
--    },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\inv_glyph_minormage",
      [GLYPH_DIFF] = {
        { 1, 56382 }, --Crittermorph
		{ 2, 146662 }, --Evaporation 
		{ 3, 219630 }, --PolymorphicProportions
		{ 4, 219592 }, --Smolder
		{ 5, 219573 }, --Sparkles
		{ 6, 146976 }, --UnboundElemental
      },
    },
	{
      name = "Pet Abilities",
      CoinTexture = "texture:Interface\\Icons\\spell_frost_summonwaterelemental_2",
      [MAGE_PET_DIFF] = {  
		--Active
		{ 1, { id = 31707, level = "10", rank = "Pet " }, }, --Waterbolt
		{ 2, { id = 231596, level = "32" }, }, --Freeze
        { 3, { id = 231598, level = "35" }, }, --WaterJet		
		--Passive
		{ 5, { id = 65220, level = "1"}, }, --Avoidance
		},	
	},
	{
      name = "Teleportation",
      CoinTexture = "texture:Interface\\Icons\\spell_arcane_teleporthalloftheguardian",
      [MAGE_ALLIANCE_DIFF] = {
		--Alliance Teleports
		{ 1, { id = 3565, level = "17", rank = "Faction: Alliance " }, }, --Darnassus
		{ 2, { id = 32271, level = "17", rank = "Faction: Alliance " }, }, --Exodar			
		{ 3, { id = 3562, level = "17", rank = "Faction: Alliance " }, }, --Ironforge
		{ 4, { id = 3561, level = "17", rank = "Faction: Alliance " }, }, --Stormwind
		{ 5, { id = 49359, level = "17", rank = "Faction: Alliance " }, }, --Theramore
		
		{ 7, { id = 33690, level = "62", rank = "Faction: Alliance " }, }, --ShattrathAlliance		
		{ 8, { id = 53140, level = "71", rank = "Attunement to Dalaran " }, }, --DalaranNorthrend		
		{ 9, { id = 88342, level = "85", rank = "Faction: Alliance " }, }, --TolBarad
		{ 10, { id = 132621, level = "90", rank = "Faction: Alliance " }, }, --ValeAlliance
		{ 11, { id = 120145, level = "90", rank = "Ancient Tome of Teleport" }, }, --AncientDalaran				
		{ 12, { id = 176248, level = "92", rank = "Faction: Alliance " }, }, --Stormshield
		
		{ 14, { id = 224869, level = "105" }, }, --DalaranBrokenIsles		
		{ 15, { id = 193759, rank = "Legion Class Hall" }, }, --HallGuardian	
		--Alliance Portals
		{ 16, { id = 11419, level = "42", rank = "Faction: Alliance " }, }, --Darnassus
		{ 17, { id = 32266, level = "42", rank = "Faction: Alliance " }, }, --Exodar
		{ 18, { id = 11416, level = "42", rank = "Faction: Alliance " }, }, --Ironforge
		{ 19, { id = 10059, level = "42", rank = "Faction: Alliance " }, }, --Stormwind
		{ 20, { id = 49360, level = "42", rank = "Faction: Alliance " }, }, --Theramore
		
		{ 22, { id = 33691, level = "66", rank = "Faction: Alliance " }, }, --ShattrathAlliance	
		{ 23, { id = 53142, level = "74" }, }, --Portal: Dalaran - Northrend	
		{ 24, { id = 88345, level = "85", rank = "Faction: Alliance " }, }, --TolBarad
		{ 25, { id = 132620, level = "90", rank = "Faction: Alliance " }, }, --ValeAlliance
		{ 26, { id = 120146, level = "90", rank = "Ancient Tome of Portal" }, }, --AncientDalaran	
		{ 27, { id = 176246, level = "92", rank = "Faction: Alliance " }, }, --Stormshield
		
		{ 29, { id = 224871, level = "110" }, }, --DalaranBrokenIslands	


      },
      [MAGE_HORDE_DIFF] = {
		--Horde Teleports
		{ 1, { id = 3567, level = "17", rank = "Faction: Horde " }, }, --Orgrimmar
		{ 2, { id = 32272, level = "17", rank = "Faction: Horde " }, }, --Silvermoon
		{ 3, { id = 3566, level = "17", rank = "Faction: Horde " }, }, --ThunderBluff
		{ 4, { id = 3563, level = "17", rank = "Faction: Horde " }, }, --Undercity		
		{ 5, { id = 49358, level = "52", rank = "Faction: Horde " }, }, --Stonard
		
		{ 7, { id = 35715, level = "62", rank = "Faction: Horde " }, }, --ShattrathHorde		
		{ 8, { id = 53140, level = "71", rank = "Attunement to Dalaran " }, }, --DalaranNorthrend
		{ 9, { id = 88344, level = "85", rank = "Faction: Horde " }, }, --TolBarad
		{ 10, { id = 132627, level = "90", rank = "Faction: Horde " }, }, --ValeHorde
		{ 11, { id = 120145, level = "90", rank = "Ancient Tome of Teleport" }, }, --AncientDalaran	
		{ 12, { id = 176242, level = "92", rank = "Faction: Horde " }, }, --TWarspear
		
		{ 14, { id = 224869, level = "105" }, }, --DalaranBrokeIsles
		{ 15, { id = 193759, rank = "Legion Class Hall" }, }, --HallGuardian	
		--Horde Portals
		{ 16, { id = 11417, level = "42", rank = "Faction: Horde " }, }, --Orgrimmar
		{ 17, { id = 32267, level = "42", rank = "Faction: Horde " }, }, --Silvermoon
		{ 18, { id = 11420, level = "42", rank = "Faction: Horde " }, }, --ThunderBluff
		{ 19, { id = 11418, level = "42", rank = "Faction: Horde " }, }, --Undercity		
		{ 20, { id = 49361, level = "52", rank = "Faction: Horde "}, }, --Stonard		

		{ 22, { id = 35717, level = "66", rank = "Faction: Horde " }, }, --ShattrathHorde			
		{ 23, { id = 53142, level = "74" }, }, --DalaranNorthrend	
		{ 24, { id = 88346, level = "85", rank = "Faction: Horde " }, }, --TolBarad	
		{ 25, { id = 132626, level = "90", rank = "Faction: Horde " }, }, --ValeHorde
		{ 26, { id = 120146, level = "90", rank = "Ancient Tome of Portal" }, }, --AncientDalaran	
		{ 27, { id = 176244, level = "92", rank = "Faction: Horde " }, }, --Warspear
		
		{ 29, { id = 224871, level = "110" }, }, --DalaranBrokenIsles
      },
	},
  },
 }
 
-------------------
--MONK
-------------------

data["CLASS_MONK"] = {
  name = "Monk",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("MONK"),
	  [MONK_DIFF] = {
		--Actives
		{ 1, { id = 100780, level = "1" }, }, --TigerPalm
		{ 2, { id = 100784, level = "3" }, }, --BlackoutKick
		{ 3, { id = 109132, level = "5" }, }, --Roll
		{ 4, { id = 115546, level = "13" }, }, --Provoke
		{ 5, { id = 115178, level = "14" }, }, --Resuscitate
		{ 6, { id = 126892, level = "14" }, }, --ZenPilgrimage		
		{ 7, { id = 117952, level = "18" }, }, --CracklingJadeLightning
		{ 8, { id = 115078, level = "25" }, }, --Paralysis
		{ 9, { id = 101643, level = "80" }, }, --Transcendence
		{ 10, { id = 119996, level = "80" }, }, --TrancendenceTransfer
		--Passives
		{ 16, { id = 116812, rank = "Passive"}, }, --Parry	
		--Skills
        { 18, { id = 106904}, }, --Armor
		{ 19, { id = 106902}, }, --Weapon	
		--Class Books
		{ 21, { id = 125883, level = "70", rank = "Mediation Manual: Zen Flight" }, }, --ZenFlight
      }, 
      [MONK_BM_DIFF] = {
		--Actives
		{ 1, { id = 116694, level = "8" }, }, --Effuse
	    { 2, { id = 205523, level = "10" }, }, --BlackoutStrike
		{ 3, { id = 121253, level = "10" }, }, --KegSmash
		{ 4, { id = 115308, level = "20" }, }, --IronskinBrew
        { 5, { id = 218164, level = "22"}, }, --Detox
		{ 6, { id = 119582, level = "28" }, },	--PurifyingBrew
        { 7, { id = 116705, level = "35" }, }, --SpearHandStrike 
		{ 8, { id = 115181, level = "40" }, }, --BreathofFire
        { 9, { id = 115072, level = "50" }, }, --ExpelHarm
		{ 10, { id = 115203, level = "55" }, }, --FortifyingBrew
        { 11, { id = 115176, level = "65" }, }, --ZenMeditation 			
		--Passives
        { 16, { id = 157445, level = "1" }, }, --CritStrikes 
        { 17, { id = 245013, level = "10", rank = "Passive " }, }, --BrewmastersBalance 
		{ 18, { id = 115069, level = "16", rank = "Passive " }, }, --Stagger 
		{ 19, { id = 124502, level = "32", rank = "Passive " }, }, --GiftoftheOx
		{ 20, { id = 216519, level = "70", rank = "Passive " }, }, --CelestialFortune
        { 21, { id = 117906, level = "78", rank = "Passive " }, }, --Mastery: ElusiveBrawler
		--Skills
		{ 23, { id = 120225, level = "50" }, }, --LeatherSpecialization 
      },
      [MONK_MW_DIFF] = {
		--Actives
		{ 1, { id = 116694, level = "8" }, }, --Effuse
        { 2, { id = 107428, level = "10" }, }, --RisingSunKick
		{ 3, { id = 124682, level = "12" }, }, --EnvelopingMist
		{ 4, { id = 115151, level = "20" }, }, --RenewingMist
	    { 5, { id = 115450, level = "22" }, }, --Detox
		{ 6, { id = 116670, level = "28" }, },	--Vivify
		{ 7, { id = 116849, level = "35" }, }, --LifeCocoon		
        { 8, { id = 191837, level = "40"}, }, --EssenceFont
		{ 9, { id = 101546, level = "40" }, }, --SpinningCraneKick
		{ 10, { id = 116680, level = "50" }, }, --ThunderFocusTea
		{ 11, { id = 243435, level = "55" }, }, --FortifyingBrew
		{ 12, { id = 212051, level = "66" }, }, --Reawaken
		{ 13, { id = 115310, level = "70" }, },	--Revival	
		--Passives	
		{ 16, { id = 193884, level = "10", rank = "Passive " }, }, --SoothingMist
		{ 17, { id = 116645, level = "10", rank = "Passive " }, }, --TeachingsoftheMonastery
		{ 18, { id = 117907, level = "78", rank = "Passive " }, }, --Mastery: GustofMists 
		--Skills
		{ 20, { id = 120224, level = "50" }, }, --LeatherSpecialization 	
	},
      [MONK_WW_DIFF] = {
		--Actives
		{ 1, { id = 116694, level = "8" }, }, --Effuse
		{ 2, { id = 107428, level = "10" }, },	--RisingSunKickck
		{ 3, { id = 116095, level = "16" }, }, --Disable
		{ 4, { id = 113656, level = "20" }, }, --FistofFury
		{ 5, { id = 108853, level = "22" }, }, --Detox
        { 6, { id = 115080, level = "32" }, }, --TouchofDeath
        { 7, { id = 116705, level = "35" }, }, --SpearHandSTrike
        { 8, { id = 101546, level = "40" }, }, --SpinningCraneKick
        { 9, { id = 101545, level = "48" }, }, --FlyingSerpentKick
		{ 10, { id = 137639, level = "50" }, }, --StormEarthFire	
		{ 11, { id = 122470, level = "50" }, }, --TouchofKarma	
		--Passives
        { 16, { id = 157445, level = "1" }, }, --CritStrikes 
        { 17, { id = 124146, level = "1", rank = "Passive" }, }, --DualWield
        { 18, { id = 128595, level = "20", rank = "Passive" }, }, --CombatConditioning
	    { 19, { id = 116092, level = "28", rank = "Passive" }, }, --Afterlife
        { 20, { id = 157411, level = "38", rank = "Passive" }, }, --Windwalking
        { 21, { id = 220357, level = "40", rank = "Hidden" }, }, --CycloneStrikes 		
        { 22, { id = 137384, level = "42", rank = "Passive"}, }, --ComboBreaker
        { 23, { id = 115636, level = "78", rank = "Passive" }, }, --Mastery: ComboStrikes 
		--Skills
        { 25, { id = 120227, level = "50" }, }, --LeatherSpecialization
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [MONK_BM_DIFF] = {
		--Tier 1 
        { 1, { id = 123986, level = "15" }, }, --Chiburst
        { 2, { id = 196607, level = "15" }, }, --EyeoftheTiger
        { 3, { id = 115098, level = "15" }, }, --ChiWave 
		--Tier 2
        { 5, { id = 115008, level = "30" }, }, --ChiTorpedo 
        { 6, { id = 116841, level = "30" }, }, --TigersLust
        { 7, { id = 115173, level = "30" }, }, --Celerity
		--Tier 3
        { 9, { id = 196721, level = "45" }, }, --LightBrewing 
        { 10, { id = 115399, level = "45" }, }, --BlackOxBrew 
        { 11, { id = 196719, level = "45" }, }, --GiftoftheMists
		--Tier 4 
        { 13, { id = 116844, level = "60" }, }, --RingofPeace
        { 14, { id = 115315, level = "60" }, }, --SummonBlackOx 
        { 15, { id = 119381, level = "60" }, }, --LegSweep
		--Tier 5
        { 16, { id = 122281, level = "75" }, }, --HealingElixir
        { 17, { id = 237076, level = "75" }, }, --MysticVitality
        { 18, { id = 122278, level = "75" }, }, --DampenHarm
		--Tier 6
        { 20, { id = 116847, level = "90" }, }, --RushingJadeWind
        { 21, { id = 132578, level = "90" }, }, --InvokeNiuzao
        { 22, { id = 196730, level = "90" }, }, --SpecialDelivery
		--Tier 7
        { 24, { id = 196738, level = "100" }, }, --ElusiveDance
        { 25, { id = 196736, level = "100" }, }, --BlackoutCombo
        { 26, { id = 196737, level = "100" }, }, --HighTolerance
      },
      [MONK_MW_DIFF] = {
		--Tier 1
        { 1, { id = 123986, level = "15" }, }, --ChiBurst
        { 2, { id = 124081, level = "15" }, }, --ZenPulse 
        { 3, { id = 115098, level = "15" }, }, --ChiWave
		--Tier 2
        { 5, { id = 115008, level = "30" }, }, --ChiTorpedo 
        { 6, { id = 116841, level = "30" }, }, --TigersLust
        { 7, { id = 115173, level = "30" }, }, --Celerity
		--Tier 3
        { 9, { id = 197915, level = "45" }, }, --Lifecycles
        { 10, { id = 210802, level = "45" }, }, --SpiritofCrane
        { 11, { id = 197900, level = "45" }, }, --MistWrap
		--Tier 4
        { 13, { id = 116844, level = "60" }, }, --RingofPeace
        { 14, { id = 198898, level = "60" }, }, --SongofChiJi 
        { 15, { id = 119381, level = "60" }, }, --LegSweep
		--Tier 5
        { 16, { id = 122281, level = "75" }, }, --HealingElixir
        { 17, { id = 122783, level = "75" }, }, --DiffuseMagic
        { 18, { id = 122278, level = "75" }, }, --DampenHarm
		--Tier 6
        { 20, { id = 196725, level = "90" }, }, --RefreshingJadeWind
        { 21, { id = 198664, level = "90" }, }, --InvokeChiJi 
        { 22, { id = 115313, level = "90" }, }, --SummonJadeSerpent
		--Tier 7
        { 24, { id = 197908, level = "100" }, }, --ManaTea
        { 25, { id = 197895, level = "100" }, }, --FocusedThunder 
        { 26, { id = 210804, level = "100" }, }, --RisingThunder
      },
      [MONK_WW_DIFF] = {
		--Tier 1
        { 1, { id = 123986, level = "15" }, }, --ChiBurst
        { 2, { id = 196607, level = "15" }, }, --EyeoftheTiger
        { 3, { id = 115098, level = "15" }, }, --ChiWave
		--Tier 2
        { 5, { id = 115008, level = "30" }, }, --ChiTorpedo
        { 6, { id = 116841, level = "30" }, }, --TigerLust
        { 7, { id = 115173, level = "30" }, }, --Celerity
		--Tier 3
        { 9, { id = 115288, level = "45" }, }, --EnergizingElixir
        { 10, { id = 115396, level = "45" }, }, --Ascension
        { 11, { id = 121817, level = "45" }, }, --Power Strikes
		--Tier 4
        { 13, { id = 116844, level = "60" }, }, --RingofPeace
        { 14, { id = 115315, level = "60" }, }, --SummonBlackOx
        { 15, { id = 119381, level = "60" }, }, --LegSweep
		--Tier 5
        { 16, { id = 122281, level = "75" }, }, --HealingElixir
        { 17, { id = 122783, level = "75" }, }, --DiffuseMagic
        { 18, { id = 122278, level = "75" }, }, --DampenHarm
		--Tier 6
        { 20, { id = 116847, level = "90" }, }, --RushingJade 
        { 21, { id = 123904, level = "90" }, }, --InvokeXuen
        { 22, { id = 196740, level = "90" }, }, --HitCombo
		--Tier 7
        { 24, { id = 196743, level = "100" }, }, --ChiOrbit
        { 25, { id = 152175, level = "100" }, }, --WhirlingDragonPunch 
        { 26, { id = 152173, level = "100" }, }, --Serenity
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [MONK_BM_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195338, level = "2" }, }, --RelentlessAssault  
        { 6, { id = 207025, level = "16" }, }, --Admonishment  
        { 7, { id = 195389, level = "34" }, }, --SoftenedBlow 
		--Tier 3
        { 9, { id = 232876, rank = "Honor Talent", level = "4" }, }, --NiuzaosEssence 
        { 10, { id = 216255, level = "19" }, }, --Eminence  
        { 11, { id = 201201, level = "37" }, }, --FastFeet  
		--Tier 4
        { 13, { id = 205147, rank= "Honor Talent", level = "6" }, }, --EerieFermentation  
        { 14, { id = 202107, level = "22" }, }, --Microbrew 
        { 15, { id = 202126, level = "40" }, }, --HotTrub
		--Tier 5  
        { 16, { id = 202200, level = "8" }, }, --GuidedMeditation
        { 17, { id = 202162, level = "25" }, }, --Guard 
        { 18, { id = 213658, level = "43" }, }, --CraftNimbleBrew 
		--Tier 6
        { 20, { id = 202272, level = "10" }, }, --IncendiaryBreath 
        { 21, { id = 202335, level = "28" }, }, --DoubleBarrel 
        { 22, { id = 202370, level = "46" }, }, --MightyOxKick 
      },
      [MONK_MW_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195330, level = "2" }, }, --DefenderoftheWeak  
        { 6, { id = 195483, level = "16" }, }, --VimandVigor  
        { 7, { id = 209584, level = "34" }, }, --ZenFocusTea 
		--Tier 3
        { 9, { id = 159534, rank = "Honor Talent", level = "4" }, }, --YulonsGift 
        { 10, { id = 216255, level = "19" }, }, --Eminence  
        { 11, { id = 201201, level = "37" }, }, --FastFeet  
		--Tier 4
        { 13, { id = 216074, level = "6" }, }, --SurgeofMist  
        { 14, { id = 216113, level = "22" }, }, --WayoftheCrane 
        { 15, { id = 209520, level = "40" }, }, --AncientMistweaverARts 
		--Tier 5  
        { 16, { id = 202424, level = "8" }, }, --Chrysalis
        { 17, { id = 202428, level = "25" }, }, --CounteractMagic 
        { 18, { id = 202577, level = "43" }, }, --DomeofMist 
		--Tier 6
        { 20, { id = 216913, level = "10" }, }, --FortuneTurned 
        { 21, { id = 202523, level = "28" }, }, --RefreshingBreeze 
        { 22, { id = 205234, level = "46" }, }, --HealingSphere 
      },
      [MONK_WW_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 232879, rank = "Honor Talent", level = "4" }, }, --YulonsGift 
        { 10, { id = 216255, level = "19" }, }, --Eminence  
        { 11, { id = 201201, level = "37" }, }, --FastFeet  
		--Tier 4
        { 13, { id = 233765, rank = "Honor Talent", level = "6" }, }, --ControltheMists  
        { 14, { id = 201318, level = "22" }, }, --FortifyingBrew 
        { 15, { id = 201325, level = "40" }, }, --ZenMoment 
		--Tier 5  
        { 16, { id = 206743, rank = "Honor Talent", level = "8" }, }, --TigerStyle
        { 17, { id = 201769, level = "25" }, }, --DisablingReach 
        { 18, { id = 201372, level = "43" }, }, --RidetheWind 
		--Tier 6
        { 20, { id = 205003, level = "10" }, }, --HeavyHandedStrikes 
        { 21, { id = 233759, rank = "Honor Talent", level = "28" }, }, --GrappleWeapon 
        { 22, { id = 247483, level = "46" }, }, --TigerEyeBrew 
      },
    },
--    {
--      name = "Artifact Traits",
--      CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--      [MONK_BM_DIFF] = {
--
--      },
--      [MONK_MW_DIFF] = {
--
--      },
--      [MONK_WW_DIFF] = {
--
--      },
--    },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\inv_glyph_minormonk",
      [GLYPH_DIFF] = {
        { 1, 219513 }, --CracklingCraneLightning
		{ 2, 219510 }, --CracklingOxLightning 
		{ 3, 125931 }, --CracklingTigerLightning
		{ 4, 125872 }, --FightingPose
		{ 5, 125732 }, --Honor
		{ 6, 125151 }, --RisingTigerKick
		{ 7, 219557 }, --YulonsGrace
      },
    },
  },
 }
 
-------------------
--PALADIN
-------------------

data["CLASS_PALADIN"] = {
  name = "Paladin",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("PALADIN"),
	  [PALADIN_DIFF] = {
        { 1, { id = 35395, level = "1" }, }, --CrusaderStrike
        { 2, { id = 20271, level = "3" }, }, --Judgment
		{ 3, { id = 62124, level = "12" }, }, --HandofReckoning	
		{ 4, { id = 7328, level = "14" }, }, --Redemption
		{ 5, { id = 642, level = "18" }, }, --DivineShield
		{ 6, { id = 190784, level = "28" }, }, --DivineSteed
		{ 7, { id = 1044, level = "38" }, }, --BlessingofFreedom
        { 8, { id = 633, level = "55" }, }, --LayonHands
		--Passives
		{ 16, { id = 107, level = "1" }, }, --Block
		{ 17, { id = 115675, level = "1", rank = "Passive" }, }, --BoundlessConvinction
		{ 18, { id = 82242, level = "1", rank = "Passive" }, }, --Parry
		{ 19, { id = 32223, level = "44", rank = "Passive" }, }, --HeartoftheCrusader
		--Skills
        { 21, { id = 76271, rank = "Passive" }, }, --Armor
        { 22, { id = 76294, rank = "Passive" }, }, --Weapon
		--Class Books
		{ 24, { id = 121183, level = "40", rank = "Divine Tome: Contemplation" }, }, --Contemplation
      }, 
      [PALADIN_HOLY_DIFF] = {
		--Active
        { 1, { id = 19750, level = "5" }, }, --FlashofLight
        { 2, { id = 853, level = "8" }, }, --HammerofJustice
        { 3, { id = 82326, level = "10" }, }, --HolyShock
        { 4, { id = 26573, level = "14" }, }, --Consecration
        { 5, { id = 53563, level = "20" }, }, --BeaconofLight
        { 6, { id = 4987, level = "22" }, }, --Cleanse		
        { 7, { id = 82326, level = "25" }, }, --HolyLight
        { 8, { id = 498, level = "32" }, }, --DivineProtection
        { 9, { id = 85222, level = "40" }, }, --LightofDawn
        { 10, { id = 1022, level = "48" }, }, --BlessingofProtection
        { 11, { id = 183998, level = "50" }, }, --LightoftheMartyr
        { 12, { id = 6940, level = "56" }, }, --BlessingofSacrifice		
        { 13, { id = 212056, level = "66" }, }, --Absolution
        { 14, { id = 31821, level = "70" }, }, --AuraMastery
        { 15, { id = 31842, level = "80" }, }, --AvengingWrath
		--Passive
		{ 16, { id = 53576, level = "35", rank = "Passive" }, },	--InfusionofLight
		{ 17, { id = 227068, level = "63", rank = "Passive" }, }, --Righteousness
		{ 18, { id = 183997, level = "78", rank = "Passive" }, }, --Mastery: Lightbringer	
		--Skills
		{ 20, { id = 86103, level = "55" }, }, --PlateSpecialization
      },
      [PALADIN_PROT_DIFF] = {
		--Active
        { 1, { id = 19750, level = "5" }, }, --FlashofLight
        { 2, { id = 853, level = "8" }, }, --HammerofJustice
        { 3, { id = 31935, level = "10" }, }, --AvengersShield
        { 4, { id = 53595, level = "10" }, }, --HammeroftheRighteous
        { 5, { id = 26573, level = "14" }, }, --Consecration
        { 6, { id = 53600, level = "20" }, }, --ShieldoftheRighteous		
        { 7, { id = 213644, level = "22" }, }, --CleanseToxins
        { 8, { id = 498, level = "32" }, }, --DivineProtection
        { 9, { id = 96231, level = "35" }, }, --Rebuke
        { 10, { id = 184092, level = "40" }, }, --LightoftheProtector
        { 11, { id = 1022, level = "48" }, }, --BlessingofProtection
        { 12, { id = 31850, level = "50" }, }, --ArdentDefender
        { 13, { id = 6940, level = "56" }, }, --BlessingofSacrifice		
        { 14, { id = 86659, level = "70" }, }, --GuardianofAncientKings
        { 15, { id = 31884, level = "80" }, }, --AvengingWrath
		--Passive
		{ 16, { id = 53592, level = "10", rank = "Passive " }, }, --GuardedbytheLight
		{ 17, { id = 25780, level = "10", rank = "Passive " }, }, --RighteousFury
		{ 18, { id = 85043, level = "25", rank = "Passive" }, },  --GrandCrusader
		{ 19, { id = 105424, level = "28", rank = "Passive " }, }, --JudgmentsoftheWise
		{ 20, { id = 161800, level = "65", rank = "Passive " }, }, --Riposte
		{ 21, { id = 76671, level = "78", rank = "Passive " }, }, --Mastery: DivineBulwark	
		--Skills
		{ 23, { id = 86102, level = "55" }, }, --PlateSpecialization
	},
      [PALADIN_RET_DIFF] = {
		--Active
        { 1, { id = 19750, level = "5" }, }, --FlashofLight
        { 2, { id = 853, level = "8" }, }, --HammerofJustice
        { 3, { id = 85256, level = "10" }, }, --TemplarsVerdict
        { 4, { id = 184575, level = "20" }, }, --BladeofJustice
        { 5, { id = 213644, level = "22" }, }, --CleanseToxins
        { 6, { id = 183218, level = "24" }, }, --HandofHindrance		
        { 7, { id = 184662, level = "32" }, }, --ShieldofVengeance
        { 8, { id = 96231, level = "35" }, }, --Rebuke
        { 9, { id = 53385, level = "40" }, }, --DivineStorm
        { 10, { id = 1022, level = "48" }, }, --BlessingofProtection
        { 11, { id = 203538, level = "58" }, }, --GreaterBlessingofKings
        { 12, { id = 203539, level = "65" }, }, --GreaterBlessingofWisdom		
        { 13, { id = 31884, level = "80" }, }, --AvengingWrath
		--Passive
		{ 16, { id = 183435, level = "70", rank = "Passive " }, }, --Retribution
		{ 17, { id = 76672, level = "78", rank = "Passive " }, }, --Mastery: DivineBulwark	
		--Skills
		{ 19, { id = 86539, level = "55" }, }, --PlateSpecialization
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [PALADIN_HOLY_DIFF] = {
		--Tier 1 
        { 1, { id = 223306, level = "15" }, }, --BestowFaith
        { 2, { id = 114158, level = "15" }, }, --LightsHammer
        { 3, { id = 196926, level = "15" }, }, --CrusadersMight 
		--Tier 2
        { 5, { id = 230332, level = "30" }, }, --Cavalier 
        { 6, { id = 114154, level = "30" }, }, --UnbreakableSpirit
        { 7, { id = 214202, level = "30" }, }, --RuleofLaw
		--Tier 3
        { 9, { id = 198054, level = "45" }, }, --FistofJustice 
        { 10, { id = 20066, level = "45" }, }, --Repentance 
        { 11, { id = 115750, level = "45" }, }, --BlindingLight
		--Tier 4 
        { 13, { id = 183425, level = "60" }, }, --DevotionAura
        { 14, { id = 183416, level = "60" }, }, --AuraoofSacrifice 
        { 15, { id = 183415, level = "60" }, }, --AuraofMercy
		--Tier 5
        { 16, { id = 197646, level = "75" }, }, --DivinePurpose
        { 17, { id = 105809, level = "75" }, }, --HolyAvenger
        { 18, { id = 114165, level = "75" }, }, --HolyPrism
		--Tier 6
        { 20, { id = 196923, level = "90" }, }, --FerventMartyr
        { 21, { id = 53376, level = "90" }, }, --SanctifiedWrath
        { 22, { id = 183778, level = "90" }, }, --JudgmentofLight
		--Tier 7
        { 24, { id = 156910, level = "100" }, }, --BeaconofFaith
        { 25, { id = 197446, level = "100" }, }, --BeaconoftheLightbringer
        { 26, { id = 200025, level = "100" }, }, --BeaconofVirtue
      },
      [PALADIN_PROT_DIFF] = {
		--Tier 1
        { 1, { id = 152261, level = "15" }, }, --HolyShield
        { 2, { id = 204019, level = "15" }, }, --BlessedHammer 
        { 3, { id = 203785, level = "15" }, }, --ConcencratedHammer
		--Tier 2
        { 5, { id = 203776, level = "30" }, }, --FirstAvenger 
        { 6, { id = 204035, level = "30" }, }, --BastionofLight
        { 7, { id = 204023, level = "30" }, }, --CrusadersJudgement
		--Tier 3
        { 9, { id = 198054, level = "45" }, }, --FistofJustice 
        { 10, { id = 20066, level = "45" }, }, --Repentance 
        { 11, { id = 115750, level = "45" }, }, --BlindingLight
		--Tier 4
        { 13, { id = 204018, level = "60" }, }, --BlessingofSpellwarding
        { 14, { id = 230332, level = "60" }, }, --Cavalier 
        { 15, { id = 203797, level = "60" }, }, --RetributionAura
		--Tier 5
        { 16, { id = 213652, level = "75" }, }, --HandoftheProtector
        { 17, { id = 204139, level = "75" }, }, --KnightTemplar
        { 18, { id = 204077, level = "75" }, }, --FinalStand
		--Tier 6
        { 20, { id = 204150, level = "90" }, }, --AegisofLight
        { 21, { id = 204054, level = "90" }, }, --ConsecratedGround 
        { 22, { id = 183778, level = "90" }, }, --JudgmentofLight
		--Tier 7
        { 24, { id = 204074, level = "100" }, }, --RighteousProtector
        { 25, { id = 152262, level = "100" }, }, --Seraphim 
        { 26, { id = 203791, level = "100" }, }, --LastDefender
      },
      [PALADIN_RET_DIFF] = {
		--Tier 1
        { 1, { id = 198038, level = "15" }, }, --FinalVerdict
        { 2, { id = 213757, level = "15" }, }, --ExecutionSentence
        { 3, { id = 205228, level = "15" }, }, --Consecration
		--Tier 2
        { 5, { id = 203316, level = "30" }, }, --TheFiresofJustice
        { 6, { id = 217020, level = "30" }, }, --Zeal
        { 7, { id = 218178, level = "30" }, }, --GreaterJudgment
		--Tier 3
        { 9, { id = 234299, level = "45" }, }, --FistofJustice 
        { 10, { id = 20066, level = "45" }, }, --Repentance 
        { 11, { id = 115750, level = "45" }, }, --BlindingLight
		--Tier 4
        { 13, { id = 202271, level = "60" }, }, --VirtuesBlade
        { 14, { id = 231832, level = "60" }, }, --BladeofWrath
        { 15, { id = 198034, level = "60" }, }, --DivineHammer
		--Tier 5
        { 16, { id = 215661, level = "75" }, }, --JusticarsVengeance
        { 17, { id = 205191, level = "75" }, }, --EyeforanEye
        { 18, { id = 210191, level = "75" }, }, --WordofGlory
		--Tier 6
        { 20, { id = 213313, level = "90" }, }, --DivineIntervention 
        { 21, { id = 230332, level = "90" }, }, --Cavalier
        { 22, { id = 183778, level = "90" }, }, --JudgmentofLight
		--Tier 7
        { 24, { id = 223817, level = "100" }, }, --DivinePurpose
        { 25, { id = 231895, level = "100" }, }, --Crusade 
        { 26, { id = 210220, level = "100" }, }, --HolyWrath
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [PALADIN_HOLY_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195330, level = "2" }, }, --DefenderoftheWeak  
        { 6, { id = 195483, level = "16" }, }, --VimandVigor  
        { 7, { id = 210294, level = "34" }, }, --DivineFavor 
		--Tier 3
        { 9, { id = 199324, level = "4" }, }, --DivineVision 
        { 10, { id = 199325, level = "19" }, }, --UnboundFreedom  
        { 11, { id = 199330, level = "37" }, }, --CleansetheWeak  
		--Tier 4
        { 13, { id = 199422, level = "6" }, }, --HolyRitual  
        { 14, { id = 199424, level = "22" }, }, --PureofHeart 
        { 15, { id = 216327, level = "40" }, }, --LightsGrace 
		--Tier 5  
        { 16, { id = 199441, level = "8" }, }, --AvengingLight
        { 17, { id = 199452, level = "25" }, }, --UltimateSacrifice 
        { 18, { id = 210378, level = "43" }, }, --DarkestBeforetheDawn 
		--Tier 6
        { 20, { id = 199456, level = "10" }, }, --SpreadingtheWord 
        { 21, { id = 199454, level = "28" }, }, --BlessedHands 
        { 22, { id = 216331, level = "46" }, }, --AvengingCrusader 
      },
      [PALADIN_PROT_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195338, level = "2" }, }, --RelentlessAssault  
        { 6, { id = 207028, level = "16" }, }, --Inquisition  
        { 7, { id = 195389, level = "34" }, }, --SoftenedBlows 
		--Tier 3
        { 9, { id = 215652, level = "4" }, }, --ShieldofVirtue 
        { 10, { id = 199325, level = "19" }, }, --UnboundFreedom  
        { 11, { id = 210341, level = "37" }, }, --WarriorofLight  
		--Tier 4
        { 13, { id = 199422, level = "6" }, }, --HolyRitual  
        { 14, { id = 236186, rank = "Honor Talent", level = "22" }, }, --CleansingLight 
        { 15, { id = 199428, level = "40" }, }, --Luminescence 
		--Tier 5  
        { 16, { id = 216868, level = "8" }, }, --HallowedGround
        { 17, { id = 216855, level = "25" }, }, --GuardedbytheLight 
        { 18, { id = 216853, level = "43" }, }, --SacredDuty 
		--Tier 6
        { 20, { id = 216860, level = "10" }, }, --JudgementsofthePure 
        { 21, { id = 199542, level = "28" }, }, --SteedofGlory 
        { 22, { id = 228049, level = "46" }, }, --GuardianoftheForgottenQueen 
      },
      [PALADIN_RET_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 204979, level = "4" }, }, --Jurisdiction 
        { 10, { id = 199325, level = "19" }, }, --UnboundFreedom  
        { 11, { id = 204934, level = "37" }, }, --LawandOrder  
		--Tier 4
        { 13, { id = 199422, level = "6" }, }, --HolyRitual  
        { 14, { id = 236186, rank = "Honor Talent", level = "22" }, }, --CleansingLight 
        { 15, { id = 199428, level = "40" }, }, --Luminescence 
		--Tier 5  
        { 16, { id = 210323, level = "8" }, }, --VengeanceAura
        { 17, { id = 210256, level = "25" }, }, --BlessingofSanctuary 
        { 18, { id = 204927, level = "43" }, }, --SeraphimsBlessing 
		--Tier 6
        { 20, { id = 204898, level = "10" }, }, --Lawbringer 
        { 21, { id = 204914, level = "28" }, }, --DivinePunisher 
        { 22, { id = 204939, level = "46" }, }, --HammerofReckoning 
      },
    },
--    {
--      name = "Artifact Traits",
--      CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--      [PALADIN_HOLY_DIFF] = {
--
--      },
--      [PALADIN_PROT_DIFF] = {
--
--      },
--      [PALADIN_RET_DIFF] = {
--
--      },
--    },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\inv_glyph_minorpaladin",
      [GLYPH_DIFF] = {
        { 1, 57954 }, --FireFromHeavens
		{ 2, 146959 }, --PillarofLight 
		{ 3, 89401 }, --LuminousCharger
		{ 4, 212642 }, --TheQueen
		{ 5, 231996 }, --TrustedSteed
		{ 6, 57979 }, --WingedVengeance
		{ 7, 254475 }, --GoldenChargersBridle
		{ 8, 254465 }, --ValorousChargersBridle
		{ 9, 254467 }, --VengefulChargersBridle
		{ 10, 254469 }, --VigilantChargersBridle
      },
    },
  },
 }

-------------------
--PRIEST
-------------------

data["CLASS_PRIEST"] = {
  name = "Priest",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("PRIEST"),
	  [PRIEST_DIFF] = {
        { 1, { id = 585, level = "1" }, }, --Smite
        { 2, { id = 2006, level = "14" }, }, --Resurrection
        { 3, { id = 9484, level = "34" }, }, --ShackleUndead
		{ 4, { id = 605, level = "42" }, }, --MindControl	
		{ 5, { id = 586, level = "44" }, }, --Fade
		{ 6, { id = 528, level = "56" }, }, --DispelMagic
		{ 7, { id = 32375, level = "80" }, }, --MassDispel
		--Skills
        { 16, { id = 76279}, }, --Armor
        { 17, { id = 89745}, }, --Mysticism
        { 18, { id = 76301}, }, --Weapon
      }, 
      [PRIEST_DISC_DIFF] = {
		--Active
        { 1, { id = 589, level = "3" }, }, --ShadowWordPain
        { 2, { id = 2061, level = "5" }, }, --FlashHeal
        { 3, { id = 17, level = "8" }, }, --PowerWordShield
        { 4, { id = 47540, level = "10" }, }, --Penance
        { 5, { id = 2096, level = "13" }, }, --MindVision
        { 6, { id = 8122, level = "18" }, }, --PsychicScream		
        { 7, { id = 527, level = "22" }, }, --Purify
        { 8, { id = 200829, level = "24" }, }, --Plea
        { 9, { id = 186263, level = "28" }, }, --ShadowMend
        { 10, { id = 1706, level = "32" }, }, --Levitate
        { 11, { id = 34433, level = "40" }, }, --Shadowfiend
        { 12, { id = 33206, level = "48" }, }, --PainSuppression
        { 13, { id = 47536, level = "50" }, }, --Rapture		
        { 14, { id = 194509, level = "52" }, }, --PowerWordRadiance
        { 15, { id = 73325, level = "63" }, }, --LeapofFaith
        { 16, { id = 212036, level = "66" }, }, --MassResurrection
        { 17, { id = 62618, level = "70" }, }, --PowerWordBarrier
		--Passive
		{ 19, { id = 81749, level = "20", rank = "Passive " }, }, --Atonement
		{ 20, { id = 45243, level = "38", rank = "Passive " }, }, --FocusedWill
		{ 21, { id = 77484, level = "78", rank = "Passive " }, }, --Mastery: Absolution	
      },
      [PRIEST_HOLY_DIFF] = {
		--Active
        { 1, { id = 2061, level = "5" }, }, --FlashHeal
        { 2, { id = 14914, level = "10" }, }, --HolyFire
        { 3, { id = 2050, level = "10" }, }, --HolyWordSerenity
        { 4, { id = 139, level = "12" }, }, --Renew
        { 5, { id = 88625, level = "18" }, }, --HolyWordChastise		
        { 6, { id = 527, level = "22" }, }, --Purify
        { 7, { id = 2060, level = "24" }, }, --Heal
        { 8, { id = 132157, level = "26" }, }, --HolyNova
        { 9, { id = 596, level = "28" }, }, --PrayerofHealing
        { 10, { id = 1706, level = "32" }, }, --Levitate
        { 11, { id = 34861, level = "40" }, }, --HolyWordSanctify
        { 12, { id = 47788, level = "48" }, }, --GuardianSpirit
        { 13, { id = 33076, level = "50" }, }, --PrayerofMending		
        { 14, { id = 19236, level = "52" }, }, --DesperatePrayer
        { 15, { id = 73325, level = "63" }, }, --LeapofFaith
        { 16, { id = 212036, level = "66" }, }, --MassResurrection
        { 17, { id = 64843, level = "70" }, }, --DivineHymn
		--Passive
		{ 19, { id = 63733, level = "20", rank = "Passive " }, }, --Serendipity
		{ 20, { id = 20711, level = "32", rank = "Passive " }, }, --SpiritofRedemption
		{ 21, { id = 45243, level = "38", rank = "Passive " }, }, --FocusedWill
		{ 22, { id = 77485, level = "78", rank = "Passive " }, }, --Mastery: EchoofLight	
	},
      [PRIEST_SHADOW_DIFF] = {
		--Active
        { 1, { id = 589, level = "3" }, }, --ShadowWordPain
        { 2, { id = 17, level = "8" }, }, --PowerWordShield
        { 3, { id = 8092, level = "10" }, }, --MindBlast
        { 4, { id = 15407, level = "10" }, }, --MindFlay
        { 5, { id = 232698, level = "12" }, }, --Shadowform		
        { 6, { id = 2096, level = "13" }, }, --MindVision
        { 7, { id = 8122, level = "18" }, }, --PsychicScream
        { 8, { id = 228260, level = "20" }, }, --VoidEruption
        { 9, { id = 213634, level = "22" }, }, --PurifyDisease
        { 10, { id = 34914, level = "24" }, }, --VampiricTouch
        { 11, { id = 186263, level = "28" }, }, --ShadowMend
		{ 12, { id = 1706, level = "32" }, }, --Levitate
        { 13, { id = 34433, level = "40" }, }, --Shadowfiend
        { 14, { id = 47585, level = "48" }, }, --Dispersion
        { 15, { id = 32379, level = "50" }, }, --ShadowWordDeath		
        { 16, { id = 15487, level = "52" }, }, --Silence
        { 17, { id = 15286, level = "70" }, }, --VampiricEmbrace
		--Passive
		{ 19, { id = 228266, level = "20", rank = "Passive" }, }, --VoidBolt
		{ 20, { id = 228264, level = "20", rank = "Passive" }, }, --Voidform
		{ 21, { id = 234702, level = "26", rank = "Passive" }, }, --MindSear
		{ 22, { id = 78203, level = "38", rank = "Passive" }, }, --ShadowyApparitions
		{ 23, { id = 77486, level = "78", rank = "Passive" }, }, --Mastery: Madness	
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [PRIEST_DISC_DIFF] = {
		--Tier 1 
        { 1, { id = 109142, level = "15" }, }, --TwistofFate
        { 2, { id = 193134, level = "15" }, }, --Castigation
        { 3, { id = 214621, level = "15" }, }, --Schism 
		--Tier 2
        { 5, { id = 121536, level = "30" }, }, --AngelicFeather 
        { 6, { id = 64129, level = "30" }, }, --BodyandSoul
        { 7, { id = 193063, level = "30" }, }, --Masochism
		--Tier 3
        { 9, { id = 204263, level = "45" }, }, --ShiningForce 
        { 10, { id = 196704, level = "45" }, }, --PsychicVoice 
        { 11, { id = 205367, level = "45" }, }, --DominantMind
		--Tier 4 
        { 13, { id = 129250, level = "60" }, }, --PowerWordSolace
        { 14, { id = 197045, level = "60" }, }, --ShieldDiscipline 
        { 15, { id = 123040, level = "60" }, }, --Mindbender
		--Tier 5
        { 16, { id = 246393, level = "75" }, }, --Sanctuary
        { 17, { id = 152118, level = "75" }, }, --ClarityofWill
        { 18, { id = 204065, level = "75" }, }, --ShadowCovenant
		--Tier 6
        { 20, { id = 204197, level = "90" }, }, --PurgetheWicked
        { 21, { id = 110744, level = "90" }, }, --DivineStar
        { 22, { id = 120517, level = "90" }, }, --Halo
		--Tier 7
        { 24, { id = 10060, level = "100" }, }, --PowerInfusion
        { 25, { id = 200309, level = "100" }, }, --Grace
        { 26, { id = 246287, level = "100" }, }, --Evangelism
      },
      [PRIEST_HOLY_DIFF] = {
		--Tier 1
        { 1, { id = 200128, level = "15" }, }, --TrailofLight
        { 2, { id = 200153, level = "15" }, }, --EnduringRenewal 
        { 3, { id = 193155, level = "15" }, }, --Enlightenment
		--Tier 2
        { 5, { id = 121536, level = "30" }, }, --AngelicFeather 
        { 6, { id = 214121, level = "30" }, }, --BodyandMind
        { 7, { id = 235189, level = "30" }, }, --Perseverance
		--Tier 3
        { 9, { id = 204263, level = "45" }, }, --ShiningForce
        { 10, { id = 200199, level = "45" }, }, --Censure
        { 11, { id = 196707, level = "45" }, }, --Afterlife
		--Tier 4
        { 13, { id = 196985, level = "60" }, }, --LightoftheNaaru
        { 14, { id = 200209, level = "60" }, }, --GuardianAngel 
        { 15, { id = 64901, level = "60" }, }, --SymbolofHope
		--Tier 5
        { 16, { id = 109186, level = "75" }, }, --SurgeofLight
        { 17, { id = 32546, level = "75" }, }, --BindingHeal
        { 18, { id = 197034, level = "75" }, }, --Piety
		--Tier 6
        { 20, { id = 197031, level = "90" }, }, --Divinity
        { 21, { id = 110744, level = "90" }, }, --DivineStar 
        { 22, { id = 120517, level = "90" }, }, --Halo
		--Tier 7
        { 24, { id = 200183, level = "100" }, }, --Apotheosis
        { 25, { id = 193157, level = "100" }, }, --Benediction 
        { 26, { id = 204883, level = "100" }, }, --CircleofHealing
      },
      [PRIEST_SHADOW_DIFF] = {
		--Tier 1
        { 1, { id = 109142, level = "15" }, }, --TwistofFate
        { 2, { id = 193195, level = "15" }, }, --FortressoftheMind
        { 3, { id = 205351, level = "15" }, }, --ShadowWordVoid
		--Tier 2
        { 5, { id = 193173, level = "30" }, }, --Mania
        { 6, { id = 64129, level = "30" }, }, --BodyandSoul
        { 7, { id = 193063, level = "30" }, }, --Masochism
		--Tier 3
        { 9, { id = 205369, level = "45" }, }, --MindBomb
        { 10, { id = 196704, level = "45" }, }, --PsychicVoice
        { 11, { id = 205367, level = "45" }, }, --DominantMind
		--Tier 4
        { 13, { id = 199849, level = "60" }, }, --LingeringInsanity
        { 14, { id = 199853, level = "60" }, }, --ReaperofSouls
        { 15, { id = 205371, level = "60" }, }, --VoidRay
		--Tier 5
        { 16, { id = 199855, level = "75" }, }, --Sanlayn
        { 17, { id = 155271, level = "75" }, }, --AuspiciousSpirits
        { 18, { id = 162452, level = "75" }, }, --ShadowyInsight
		--Tier 6
        { 20, { id = 10060, level = "90" }, }, --PowerInfusion 
        { 21, { id = 238558, level = "90" }, }, --Misery
        { 22, { id = 200174, level = "90" }, }, --Mindbender
		--Tier 7
        { 24, { id = 193225, level = "100" }, }, --LegacyoftheVoid
        { 25, { id = 205385, level = "100" }, }, --ShadowCrash 
        { 26, { id = 193223, level = "100" }, }, --SurrendertoMadness
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [PRIEST_DISC_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195330, level = "2" }, }, --DefenderoftheWeak  
        { 6, { id = 195483, level = "16" }, }, --VimandVigor  
        { 7, { id = 195606, level = "34" }, }, --InnerRenewal 
		--Tier 3
        { 9, { id = 196162, level = "4" }, }, --Purification 
        { 10, { id = 213654, level = "19" }, }, --SpiritualCleansing  
        { 11, { id = 196439, level = "37" }, }, --PurifiedResolve  
		--Tier 4
        { 13, { id = 215768, level = "6" }, }, --SearingLight  
        { 14, { id = 209780, rank = "Honor Talent", level = "22" }, }, --Premonition 
        { 15, { id = 214205, level = "40" }, }, --Trinity 
		--Tier 5  
        { 16, { id = 197535, level = "8" }, }, --StrengthofSoul
        { 17, { id = 236499, level = "25" }, }, --UltimateRadiance 
        { 18, { id = 197590, level = "43" }, }, --DomeofLight 
		--Tier 6
        { 20, { id = 211681, level = "10" }, }, --PowerWordFortitude 
        { 21, { id = 197862, level = "28" }, }, --Archangel 
        { 22, { id = 197871, level = "46" }, }, --DarkArchangel 
      },
      [PRIEST_HOLY_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195330, level = "2" }, }, --DefenderoftheWeak  
        { 6, { id = 195483, level = "16" }, }, --VimandVigor  
        { 7, { id = 196762, level = "34" }, }, --InnerFocus 
		--Tier 3
        { 9, { id = 196162, level = "4" }, }, --Purification 
        { 10, { id = 213654, level = "19" }, }, --SpiritualCleansing  
        { 11, { id = 213610, level = "37" }, }, --HolyWard  
		--Tier 4
        { 13, { id = 196611, level = "6" }, }, --DeliveredfromEvil  
        { 14, { id = 221661, level = "22" }, }, --HolyConcentration 
        { 15, { id = 213602, level = "40" }, }, --GreaterFade 
		--Tier 5  
        { 16, { id = 235587, level = "8" }, }, --MiracleWorker
        { 17, { id = 196559, level = "25" }, }, --RapidMending 
        { 18, { id = 215960, level = "43" }, }, --GreaterHeal 
		--Tier 6
        { 20, { id = 196602, level = "10" }, }, --DivineAttendent 
        { 21, { id = 215982, level = "28" }, }, --SpiritoftheRedeemer 
        { 22, { id = 197268, level = "46" }, }, --RayofHope 
      },
      [PRIEST_SHADOW_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 213548, level = "2" }, }, --TrainofThought  
        { 6, { id = 213549, level = "16" }, }, --MindQuickness  
        { 7, { id = 213550, level = "34" }, }, --Initiation 
		--Tier 3
        { 9, { id = 199144, level = "4" }, }, --VoidShield 
        { 10, { id = 199131, level = "19" }, }, --PureShadow  
        { 11, { id = 199388, rank = "Honor Talent", level = "37" }, }, --FleetingEmbrace  
		--Tier 4
        { 13, { id = 199259, level = "6" }, }, --DriventoMadness  
        { 14, { id = 228630, rank = "Honor Talent", level = "22" }, }, --VoidOrigins 
        { 15, { id = 199408, rank = "Honor Talent", level = "40" }, }, --EdgeofInsanity 
		--Tier 5  
        { 16, { id = 199445, rank = "Honor Talent", level = "8" }, }, --MindTrauma
        { 17, { id = 199572, rank = "Honor Talent", level = "25" }, }, --ShadowMania 
        { 18, { id = 199484, level = "43" }, }, --PsychicLink 
		--Tier 6
        { 20, { id = 211522, level = "10" }, }, --Psyfiend 
        { 21, { id = 215776, level = "28" }, }, --LastWord 
        { 22, { id = 108968, rank = "Honor Talent", level = "46" }, }, --VoidShift 
      },
    },
--    {
--      name = "Artifact Traits",
--      CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--      [PRIEST_DISC_DIFF] = {
--
--      },
--      [PRIEST_HOLY_DIFF] = {
--
--      },
--      [PRIEST_SHADOW_DIFF] = {
--
--      },
--    },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\inv_glyph_minorpriest",
      [GLYPH_DIFF] = {
        { 1, 219669 }, --GhostlyFade
		{ 2, 147072 }, --InspiredHymns 
		{ 3, 57986 }, --ShackleUndead
		{ 4, 107906 }, --Shadow
		{ 5, 126745 }, --ShadowyFriends
		{ 6, 120581 }, --theHeavens
		{ 7, 147776 }, --theSha
		{ 8, 126094 }, --theValkyr
      },
    },
  },
 }
 
-------------------
--ROGUE
-------------------

data["CLASS_ROGUE"] = {
  name = "Rogue",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("ROGUE"),
	  [ROGUE_DIFF] = {
        { 1, { id = 1784, level = "5" }, }, --Stealth
        { 2, { id = 1833, level = "8" }, }, --CheapShot
		{ 3, { id = 921, level = "13" }, }, --PickPocket
        { 4, { id = 6770, level = "14" }, }, --Sap
        { 5, { id = 185311, level = "16" }, }, --CrimsonVial
        { 6, { id = 1766, level = "18" }, }, --Kick
        { 7, { id = 2094, level = "24" }, }, --Blind
        { 8, { id = 1804, level = "24" }, }, --PickLock
		{ 9, { id = 2983, level = "32" }, }, --Sprint
        { 10, { id = 1725, level = "38" }, }, --Distract		
		{ 11, { id = 1966, level = "44" }, }, --Feint
		{ 12, { id = 114018, level = "68" }, }, --ShroudofConcealment
		{ 13, { id = 57934, level = "70" }, }, --TricksoftheTrade
		{ 14, { id = 31224, level = "80" }, }, --CloakofShadows
		--Passives
		{ 16, { id = 157442, level = "1"}, }, --CriticalStrikes
		{ 17, { id = 82245, level = "1"}, }, --Parry
		{ 18, { id = 2836, level = "42"}, }, --DetectTraps
		{ 19, { id = 31209, level = "58"}, }, --FleetFooted
		{ 20, { id = 1860, level = "62"}, }, --SafeFall		
		--Skills
        { 22, { id = 76273}, }, --Armor
        { 23, { id = 86092}, }, --LeatherSpecialization
        { 24, { id = 76297}, }, --Weapon
		--Class Books
		{ 26, { id = 56814, level = "50", rank = "Dirty Tricks, Vol 1: Detection" }, }, --Detection
      }, 
      [ROGUE_ASS_DIFF] = {
		--Active
        { 1, { id = 1752, level = "1" }, }, --SinisterStrike
        { 2, { id = 196819, level = "3" }, }, --Eviscerate
        { 3, { id = 2823, level = "10" }, }, --DeadlyPoison
        { 4, { id = 185565, level = "10" }, }, --PoisonedKnife		
        { 5, { id = 703, level = "12" }, }, --Garrote
        { 6, { id = 1943, level = "20" }, }, --Rupture
        { 7, { id = 36554, level = "22" }, }, --Shadowstep
        { 8, { id = 5277, level = "26" }, }, --Evasion		
        { 9, { id = 408, level = "34" }, }, --KidneyShot
        { 10, { id = 32645, level = "36" }, }, --Envenom
		{ 11, { id = 3408, level = "38" }, }, --CripplingPoison
        { 12, { id = 1329, level = "40" }, }, --Mutilate
        { 13, { id = 1856, level = "48" }, }, --Vanish
        { 14, { id = 8679, level = "54" }, }, --WoundPoison
        { 15, { id = 79140, level = "56" }, }, --Vendetta		
        { 16, { id = 51723, level = "63" }, }, --FanofKnives
		--Passive
		{ 18, { id = 84601, level = "10", rank = "Passive" }, }, --AssassinsResolve
		{ 19, { id = 14117, level = "10", rank = "Passive " }, }, --ImprovedPoisons
		{ 20, { id = 51667, level = "20", rank = "Passive " }, }, --CuttotheChase
		{ 21, { id = 14190, level = "28", rank = "Passive" }, }, --SealFate
		{ 22, { id = 79134, level = "50", rank = "Passive " }, }, --VenomousWounds
		{ 23, { id = 76803, level = "78", rank = "Passive " }, }, --Mastery: PotentPoisons	
      },
      [ROGUE_OUTLAW_DIFF] = {
		--Active
        { 1, { id = 2098, level = "10" }, }, --RunThrough
        { 2, { id = 193315, level = "10" }, }, --SaberSlash
        { 3, { id = 185763, level = "12" }, }, --PistolShot
        { 4, { id = 199804, level = "20" }, }, --BetweentheEyes
        { 5, { id = 8676, level = "22" }, }, --Ambush
        { 6, { id = 199754, level = "26" }, }, --Riposte		
        { 7, { id = 1776, level = "34" }, }, --Gouge
        { 8, { id = 193316, level = "40" }, }, --RolltheBones
        { 9, { id = 1856, level = "48" }, }, --Vanish
        { 10, { id = 79096, level = "50" }, }, --RestlessBlades
        { 11, { id = 199740, level = "54" }, }, --Bribe
        { 12, { id = 13750, level = "56" }, }, --AdrenalineRush		
        { 13, { id = 13877, level = "63" }, }, --BladeFlurry
		--Passive
		{ 16, { id = 14161, level = "28", rank = "Passive" }, }, --Ruthlessness
		{ 17, { id = 199804, level = "42", rank = "Passive " }, }, --BetweentheEyes
		{ 18, { id = 35551, level = "50", rank = "Passive " }, }, --CombatPotency
		{ 19, { id = 79096, level = "50", rank = "Passive " }, }, --RestlessBlades
		{ 20, { id = 76806, level = "78", rank = "Passive " }, }, --Mastery: MainGauche	
	},
      [ROGUE_SUBTLETY_DIFF] = {
		--Active
        { 1, { id = 53, level = "10" }, }, --Backstab
        { 2, { id = 114014, level = "10" }, }, --ShurikenToss		
        { 3, { id = 185438, level = "12" }, }, --Shadowstrike
        { 4, { id = 195452, level = "20" }, }, --Nightblade
        { 5, { id = 36554, level = "22" }, }, --Shadowstep
        { 6, { id = 5277, level = "26" }, }, --Evasion		
        { 7, { id = 408, level = "34" }, }, --KidneyShot
        { 8, { id = 212283, level = "36" }, }, --SymbolsofDeath
        { 9, { id = 185313, level = "40" }, }, --ShadowDance
        { 10, { id = 1856, level = "48" }, }, --Vanish
        { 11, { id = 121471, level = "56" }, }, --ShadowBlades	
        { 12, { id = 197835, level = "63" }, }, --ShurikenStorm
        { 13, { id = 245639, level = "70" }, }, --ShurikenCombo
		--Passive
		{ 16, { id = 79152, level = "10", rank = "Passive" }, }, --EnergeticRecovery
		{ 17, { id = 196912, level = "28", rank = "Passive" }, }, --ShadowTechniques
		{ 18, { id = 185314, level = "54", rank = "Passive " }, }, --DeepeningShadows
		{ 19, { id = 76808, level = "78", rank = "Passive " }, }, --Mastery: Executioner	
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [ROGUE_ASS_DIFF] = {
		--Tier 1 
        { 1, { id = 196864, level = "15" }, }, --MasterPoisoner
        { 2, { id = 193640, level = "15" }, }, --ElaboratePlanning
        { 3, { id = 16511, level = "15" }, }, --Hemorrhage 
		--Tier 2
        { 5, { id = 14062, level = "30" }, }, --Nightstalker 
        { 6, { id = 108208, level = "30" }, }, --Subterfuge
        { 7, { id = 108209, level = "30" }, }, --ShadowFocus
		--Tier 3
        { 9, { id = 193531, level = "45" }, }, --DeeperStratagem 
        { 10, { id = 114015, level = "45" }, }, --Anticipation 
        { 11, { id = 14983, level = "45" }, }, --Vigor
		--Tier 4 
        { 13, { id = 108211, level = "60" }, }, --LeechingPoison
        { 14, { id = 79008, level = "60" }, }, --Elusiveness 
        { 15, { id = 31230, level = "60" }, }, --CheatDeath
		--Tier 5
        { 16, { id = 196861, level = "75" }, }, --Thuggee
        { 17, { id = 131511, level = "75" }, }, --PreyontheWeak
        { 18, { id = 154904, level = "75" }, }, --InternalBleeding
		--Tier 6
        { 20, { id = 245388, level = "90" }, }, --ToxicBlade
        { 21, { id = 193539, level = "90" }, }, --Alacrity
        { 22, { id = 200806, level = "90" }, }, --Exsanguinate
		--Tier 7
        { 24, { id = 152152, level = "100" }, }, --VenomRush
        { 25, { id = 137619, level = "100" }, }, --MarkedforDeath
        { 26, { id = 152150, level = "100" }, }, --DeathfromAbove
      },
      [ROGUE_OUTLAW_DIFF] = {
		--Tier 1
        { 1, { id = 196937, level = "15" }, }, --GhostlyStrike
        { 2, { id = 200733, level = "15" }, }, --Swordmaster 
        { 3, { id = 196938, level = "15" }, }, --QuickDraw
		--Tier 2
        { 5, { id = 195457, level = "30" }, }, --GrapplingHook 
        { 6, { id = 196924, level = "30" }, }, --AcrobaticStrikes
        { 7, { id = 196922, level = "30" }, }, --HitandRun
		--Tier 3
        { 9, { id = 193531, level = "45" }, }, --DeeperStratagem 
        { 10, { id = 114015, level = "45" }, }, --Anticipation 
        { 11, { id = 14983, level = "45" }, }, --Vigor
		--Tier 4
        { 13, { id = 193546, level = "60" }, }, --IronStomach
        { 14, { id = 79008, level = "60" }, }, --Elusiveness 
        { 15, { id = 31230, level = "60" }, }, --CheatDeath
		--Tier 5
        { 16, { id = 199743, level = "75" }, }, --Parley
        { 17, { id = 131511, level = "75" }, }, --PreyontheWeak
        { 18, { id = 108216, level = "75" }, }, --DirtyTricks
		--Tier 6
        { 20, { id = 185767, level = "90" }, }, --CannonballBarrage
        { 21, { id = 193539, level = "90" }, }, --Alacrity 
        { 22, { id = 51690, level = "90" }, }, --KillingSpree
		--Tier 7
        { 24, { id = 5171, level = "100" }, }, --SliceandDice
        { 25, { id = 137619, level = "100" }, }, --MarkedforDeath 
        { 26, { id = 152150, level = "100" }, }, --DeathfromAbove
      },
      [ROGUE_SUBTLETY_DIFF] = {
		--Tier 1
        { 1, { id = 31223, level = "15" }, }, --MasterofSubtlety
        { 2, { id = 193537, level = "15" }, }, --Weaponmaster
        { 3, { id = 200758, level = "15" }, }, --Gloomblade
		--Tier 2
        { 5, { id = 14062, level = "30" }, }, --Nightstalker
        { 6, { id = 108208, level = "30" }, }, --Subterfuge
        { 7, { id = 108209, level = "30" }, }, --ShadowFocus
		--Tier 3
        { 9, { id = 193531, level = "45" }, }, --DeeperStratagem 
        { 10, { id = 114015, level = "45" }, }, --Anticipation 
        { 11, { id = 14983, level = "45" }, }, --Vigor
		--Tier 4
        { 13, { id = 200759, level = "60" }, }, --SoothingDarkness
        { 14, { id = 79008, level = "60" }, }, --Elusiveness
        { 15, { id = 31230, level = "60" }, }, --CheatDeath
		--Tier 5
        { 16, { id = 196951, level = "75" }, }, --StrikefromtheShadows
        { 17, { id = 131511, level = "75" }, }, --PreyontheWeak
        { 18, { id = 200778, level = "75" }, }, --TangledShadow
		--Tier 6
        { 20, { id = 245687, level = "90" }, }, --DarkShadow 
        { 21, { id = 193539, level = "90" }, }, --Alacrity
        { 22, { id = 238104, level = "90" }, }, --EnvelopingShadows
		--Tier 7
        { 24, { id = 196976, level = "100" }, }, --MasterofShadows
        { 25, { id = 137619, level = "100" }, }, --MarkedforDeath 
        { 26, { id = 152150, level = "100" }, }, --DeathfromAbove
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [ROGUE_ASS_DIFF] = {
	    --Tier 1
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 197000, level = "4" }, }, --Maneuverability 
        { 10, { id = 197007, level = "19" }, }, --IntenttoKill  
        { 11, { id = 248744, level = "37" }, }, --Shiv  
		--Tier 4
        { 13, { id = 198032, level = "6" }, }, --HonorAmongThieves  
        { 14, { id = 198020, level = "22" }, }, --TurntheTables 
        { 15, { id = 206317, level = "40" }, }, --UnfairAdvantage 
		--Tier 5  
        { 16, { id = 197044, level = "8" }, }, --DeadlyBrew
        { 17, { id = 197050, level = "25" }, }, --MindnumbingPoison 
        { 18, { id = 206328, level = "43" }, }, --Neurotoxin 
		--Tier 6
        { 20, { id = 198092, level = "10" }, }, --CreepingVenom 
        { 21, { id = 198128, level = "28" }, }, --FlyingDaggers 
        { 22, { id = 198145, level = "46" }, }, --SystemShock 
      },
      [ROGUE_OUTLAW_DIFF] = {
		--Tier 1
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 197000, level = "4" }, }, --Maneuverability 
        { 10, { id = 209752, level = "19" }, }, --BoardingParty  
        { 11, { id = 248744, level = "37" }, }, --Shiv  
		--Tier 4
        { 13, { id = 198032, level = "6" }, }, --HonorAmongThieves  
        { 14, { id = 198020, level = "22" }, }, --TurntheTables 
        { 15, { id = 221622, level = "40" }, }, --ThickasThieves 
		--Tier 5  
        { 16, { id = 198265, level = "8" }, }, --TakeYourCut
        { 17, { id = 212217, level = "25" }, }, --ControlisKing 
        { 18, { id = 212210, level = "43" }, }, --DrinkUpMeHearties 
		--Tier 6
        { 20, { id = 212035, level = "10" }, }, --CheapTricks 
        { 21, { id = 207777, level = "28" }, }, --Dismantle 
        { 22, { id = 198529, rank = "Honor Talent", level = "46" }, }, --PlunderArmor 
      },
      [ROGUE_SUBTLETY_DIFF] = {
		--Tier 1
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 197000, level = "4" }, }, --Maneuverability 
        { 10, { id = 197899, rank = "Honor Talent", level = "19" }, }, --Silhouette  
        { 11, { id = 248744, level = "37" }, }, --Shiv  
		--Tier 4
        { 13, { id = 198032, level = "6" }, }, --HonorAmongThieves  
        { 14, { id = 248762, level = "22" }, }, --ThievesGambit 
        { 15, { id = 212182, level = "40" }, }, --SmokeBomb 
		--Tier 5  
        { 16, { id = 198952, rank = "Honor Talent", level = "8" }, }, --VeilofMidnight
        { 17, { id = 198675, rank = "Honor Talent", level = "25" }, }, --DaggerintheDark 
        { 18, { id = 213981, level = "43" }, }, --ColdBlood 
		--Tier 6
        { 20, { id = 216883, level = "10" }, }, --PhantomAssassin 
        { 21, { id = 212081, level = "28" }, }, --ThiefsBargain 
        { 22, { id = 207736, level = "46" }, }, --ShadowyDuel 
      },
    },
--    {
--      name = "Artifact Traits",
--      CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--      [ROGUE_ASS_DIFF] = {
--
--      },
--     [ROGUE_OUTLAW_DIFF] = {
--
--      },
--      [ROGUE_SUBTLETY_DIFF] = {
--
--      },
--    },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\inv_glyph_minorrogue",
      [GLYPH_DIFF] = {
        { 1, 219693 }, --Blackout
		{ 2, 220279 }, --Burnout 
		{ 3, 63268 }, --Disguise
		{ 4, 219678 }, --FlashBang
      },
    },
  },
 }
 
-------------------
--SHAMAN
-------------------

data["CLASS_SHAMAN"] = {
  name = "Shaman",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("SHAMAN"),
	  [SHAMAN_DIFF] = {
        { 1, { id = 2484, level = "8" }, }, --EarthbindTotem
        { 2, { id = 6196, level = "13" }, }, --FarSight
        { 3, { id = 2008, level = "14" }, }, --AncestralSpirit
		{ 4, { id = 2645, level = "16" }, }, --GhostWolf	
		{ 5, { id = 546, level = "32" }, }, --WaterWalking
		{ 6, { id = 51514, level = "42" }, }, --Hex
		{ 7, { id = 556, level = "44" }, }, --AstralRecall
		{ 8, { id = 2825, level = "50", rank = "Faction: Horde" }, }, --Bloodlust
		{ 9, { id = 32182, level = "50", rank = "Faction: Alliance" }, }, --Heroism
		{ 10, { id = 108271, level = "52" }, }, --Astral Shift
        { 11, { id = 370, level = "63" }, }, --Purge
		--Passives
		{ 16, { id = 107, level = "1"}, }, --Block
		{ 17, { id = 20608, level = "26" }, }, -- Reincarnation
		--Skills
        { 19, { id = 76272}, }, --Armor
        { 20, { id = 76296}, }, --Weapon
		--Class Books
		{ 22, { id = 211015, level ="42", rank = "Tome of Hex: Cockroach" }, }, --Hex:Cockroach
		{ 23, { id = 210873, level ="42", rank = "Tome of Hex: Compy" }, }, --Hex:Compy
		{ 24, { id = 211004, level ="42", rank = "Tome of Hex: Spider" }, }, --Hex:Spider
      }, 
      [SHAMAN_ELE_DIFF] = {
		--Active
        { 1, { id = 188196, level = "1" }, }, --LightningBolt
        { 2, { id = 188389, level = "3" }, }, --FlameShock
        { 3, { id = 8004, level = "5" }, }, --HealingSurge
        { 4, { id = 8042, level = "10" }, }, --EarthShock
        { 5, { id = 51505, level = "12" }, }, --LavaBurst
        { 6, { id = 57994, level = "18" }, }, --WindShear
        { 7, { id = 51886, level = "22" }, }, --CleanseSpirit		
        { 8, { id = 51490, level = "24" }, }, --Thunderstorm
        { 9, { id = 188443, level = "28" }, }, --ChainLightning
        { 10, { id = 198103, level = "36" }, }, --EarthElemental
        { 11, { id = 196840, level = "38" }, }, --FrostShock
        { 12, { id = 61882, level = "48" }, }, --Earthquake
        { 13, { id = 198067, level = "56" }, }, --FireElemental		
		--Passive
		{ 16, { id = 190493, level = "1", rank = "Passive " }, }, --Fulmination
		{ 18, { id = 60188, level = "34", rank = "Passive" }, },  --ElementalFury
		{ 19, { id = 77756, level = "40", rank = "Passive " }, }, --LavaSurge
		{ 20, { id = 168534, level = "78", rank = "Passive " }, }, --Mastery: ElementalOverload	
		{ 21, { id = 16164, level = "80", rank = "Passive " }, }, --ElementalFocus
		--Skills
		{ 23, { id = 86108, level = "55" }, }, --MailSpecialization
      },
      [SHAMAN_ENH_DIFF] = {
		--Active
        { 1, { id = 187837, level = "1" }, }, --LightningBolt
        { 2, { id = 188070, level = "5" }, }, --HealingSurge
        { 3, { id = 60103, level = "10" }, }, --LavaLash
        { 4, { id = 193786, level = "10" }, }, --Rockbiter
        { 5, { id = 193796, level = "12" }, }, --Flametongue
        { 6, { id = 57994, level = "18" }, }, --WindShear
        { 7, { id = 17364, level = "20" }, }, --Stormstrike
        { 8, { id = 187874, level = "28" }, }, --CrashLightning
        { 9, { id = 51533, level = "36" }, }, --FeralSpirit
        { 10, { id = 196834, level = "38" }, }, --Frostbrand
        { 11, { id = 58875, level = "80" }, }, --Spiritwalk		
		--Passive
		{ 16, { id = 86629, level = "10", rank = "Passive " }, }, --DualWield
		{ 17, { id = 33757, level = "24", rank = "Passive" }, },  --Windfury
		{ 18, { id = 187880, level = "40", rank = "Passive " }, }, --MaelstromWeapon
		{ 19, { id = 201845, level = "48", rank = "Passive " }, }, --Stormbringer
		{ 20, { id = 195255, level = "70", rank = "Passive " }, }, --Stormlash
		{ 21, { id = 77223, level = "78", rank = "Passive " }, }, --Mastery: EnhancedElements	
		--Skills
		{ 23, { id = 86099, level = "55" }, }, --MailSpecialization
	},
      [SHAMAN_RESTO_DIFF] = {
		--Active
        { 1, { id = 403, level = "1" }, }, --LightningBolt
        { 2, { id = 188838, level = "3" }, }, --FlameShock
        { 3, { id = 8004, level = "5" }, }, --HealingSurge
        { 4, { id = 61295, level = "10" }, }, --Riptide
        { 5, { id = 51505, level = "12" }, }, --LavaBurst
        { 6, { id = 57994, level = "18" }, }, --WindShear
        { 7, { id = 1064, level = "20" }, }, --ChainHeal
        { 8, { id = 77130, level = "22" }, }, --PurifySpirit		
        { 9, { id = 77472, level = "24" }, }, --HealingWave
        { 10, { id = 421, level = "28" }, }, --ChainLightning
        { 11, { id = 79206, level = "36" }, }, --SpiritwalkersGrace
        { 12, { id = 73920, level = "40" }, }, --HealingRain
        { 13, { id = 98008, level = "56" }, }, --SpiritlinkTotem
        { 14, { id = 212048, level = "66" }, }, --AncestralVision	
        { 15, { id = 108280, level = "80" }, }, --HealingTideTotem			
		--Passive
		{ 16, { id = 231785, level = "34", rank = "Passive" }, },  --TidalWaves
		{ 17, { id = 77756, level = "40", rank = "Passive " }, }, --LavaSurge
		{ 18, { id = 16196, level = "48", rank = "Passive " }, }, --Resurgence
		{ 19, { id = 77226, level = "78", rank = "Passive " }, }, --Mastery: DeepHealing	
		--Skills
		{ 21, { id = 86100, level = "55" }, }, --MailSpecialization
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [SHAMAN_ELE_DIFF] = {
		--Tier 1 
        { 1, { id = 201909, level = "15" }, }, --PathofFlame
        { 2, { id = 170374, level = "15" }, }, --EarthenRage
        { 3, { id = 210643, level = "15" }, }, --TotemMastery 
		--Tier 2
        { 5, { id = 192063, level = "30" }, }, --GustofWind 
        { 6, { id = 108281, level = "30" }, }, --AncestralGuidance
        { 7, { id = 192077, level = "30" }, }, --WindRushTotem
		--Tier 3
        { 9, { id = 192058, level = "45" }, }, --LightningSurgeTotem 
        { 10, { id = 51485, level = "45" }, }, --EarthgrabTotem 
        { 11, { id = 196932, level = "45" }, }, --VoodooTotem
		--Tier 4 
        { 13, { id = 210707, level = "60" }, }, --Aftershock
        { 14, { id = 192087, level = "60" }, }, --AncestralSwiftness 
        { 15, { id = 16166, level = "60" }, }, --ElementalMastery
		--Tier 5
        { 16, { id = 192235, level = "75" }, }, --ElementalFusion
        { 17, { id = 117013, level = "75" }, }, --PrimalElementalist
        { 18, { id = 117014, level = "75" }, }, --ElementalBlast
		--Tier 6
        { 20, { id = 192222, level = "90" }, }, --LiquidMagmaTotem
        { 21, { id = 192249, level = "90" }, }, --StormElemental
        { 22, { id = 108283, level = "90" }, }, --EchooftheElements
		--Tier 7
        { 24, { id = 114050, level = "100" }, }, --Ascendance
        { 25, { id = 210689, level = "100" }, }, --LightningRod
        { 26, { id = 210714, level = "100" }, }, --Icefury
      },
      [SHAMAN_ENH_DIFF] = {
		--Tier 1
        { 1, { id = 201898, level = "15" }, }, --Windsong
        { 2, { id = 201900, level = "15" }, }, --HotHand 
        { 3, { id = 197992, level = "15" }, }, --Landslide
		--Tier 2
        { 5, { id = 215864, level = "30" }, }, --Rainfall 
        { 6, { id = 196884, level = "30" }, }, --FeralLunge
        { 7, { id = 192077, level = "30" }, }, --WindRushTotem
		--Tier 3
        { 9, { id = 192058, level = "45" }, }, --LightningSurgeTotem 
        { 10, { id = 51485, level = "45" }, }, --EarthgrabTotem 
        { 11, { id = 196932, level = "45" }, }, --VoodooTotem
		--Tier 4
        { 13, { id = 192106, level = "60" }, }, --LightningShield
        { 14, { id = 192087, level = "60" }, }, --AncestralSwiftness 
        { 15, { id = 210853, level = "60" }, }, --Hailstorm
		--Tier 5
        { 16, { id = 192234, level = "75" }, }, --Tempest
        { 17, { id = 210727, level = "75" }, }, --Overcharge
        { 18, { id = 210731, level = "75" }, }, --EmpoweredStormlash
		--Tier 6
        { 20, { id = 192246, level = "90" }, }, --CrashingStorm
        { 21, { id = 197211, level = "90" }, }, --FuryofAir 
        { 22, { id = 197214, level = "90" }, }, --Sundering
		--Tier 7
        { 24, { id = 114051, level = "100" }, }, --Ascendance
        { 25, { id = 246035, level = "100" }, }, --Boulderfist 
        { 26, { id = 188089, level = "100" }, }, --EarthenSpike
      },
      [SHAMAN_RESTO_DIFF] = {
		--Tier 1
        { 1, { id = 200071, level = "15" }, }, --Undulation
        { 2, { id = 73685, level = "15" }, }, --UnleashLife
        { 3, { id = 200072, level = "15" }, }, --Torrent
		--Tier 2
        { 5, { id = 192063, level = "30" }, }, --GustofWind
        { 6, { id = 192088, level = "30" }, }, --GracefulSpirit
        { 7, { id = 192077, level = "30" }, }, --WindRushTotem
		--Tier 3
        { 9, { id = 192058, level = "45" }, }, --LightningSurgeTotem 
        { 10, { id = 51485, level = "45" }, }, --EarthgrabTotem 
        { 11, { id = 196932, level = "45" }, }, --VoodooTotem
		--Tier 4
        { 13, { id = 197464, level = "60" }, }, --CrashingWaves
        { 14, { id = 108281, level = "60" }, }, --AncestralGuidance
        { 15, { id = 200076, level = "60" }, }, --Deluge
		--Tier 5
        { 16, { id = 207399, level = "75" }, }, --AncestralProtectionTotem
        { 17, { id = 198838, level = "75" }, }, --EarthenShieldTotem
        { 18, { id = 207401, level = "75" }, }, --AncestralVigor
		--Tier 6
        { 20, { id = 197467, level = "90" }, }, --BottomlessDepths 
        { 21, { id = 157153, level = "90" }, }, --CloudburstTotem
        { 22, { id = 108283, level = "90" }, }, --EchooftheElements
		--Tier 7
        { 24, { id = 114052, level = "100" }, }, --Ascendance
        { 25, { id = 197995, level = "100" }, }, --Wellspring 
        { 26, { id = 157154, level = "100" }, }, --HighTide
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [SHAMAN_ELE_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 213545, level = "2" }, }, --TrainofThought  
        { 6, { id = 213546, level = "16" }, }, --MindQuickness  
        { 7, { id = 213547, level = "34" }, }, --Initiation 
		--Tier 3
        { 9, { id = 204330, level = "4" }, }, --SkyfuryTotem 
        { 10, { id = 204331, level = "19" }, }, --CounterstrikeTotem  
        { 11, { id = 204332, level = "37" }, }, --WindfuryTotem  
		--Tier 4
        { 13, { id = 204247, level = "6" }, }, --PurifyingWaters  
        { 14, { id = 204261, level = "22" }, }, --SpectralRecovery 
        { 15, { id = 204264, level = "40" }, }, --SwellingWaves 
		--Tier 5  
        { 16, { id = 204389, level = "8" }, }, --FireandIce
        { 17, { id = 204385, level = "25" }, }, --ElementalAttunement 
        { 18, { id = 204393, level = "43" }, }, --ControlofLava 
		--Tier 6
        { 20, { id = 204398, level = "10" }, }, --Earthfury 
        { 21, { id = 204403, level = "28" }, }, --TravelingStorms 
        { 22, { id = 204437, level = "46" }, }, --LightningLasso 
      },
      [SHAMAN_ENH_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 204330, level = "4" }, }, --SkyfuryTotem 
        { 10, { id = 204331, level = "19" }, }, --CounterstrikeTotem  
        { 11, { id = 204332, level = "37" }, }, --WindfuryTotem  
		--Tier 4
        { 13, { id = 204247, level = "6" }, }, --PurifyingWaters 
        { 14, { id = 204261, level = "22" }, }, --SpectralRecovery 
        { 15, { id = 210918, level = "40" }, }, --EtherealForm 
		--Tier 5  
        { 16, { id = 204349, level = "8" }, }, --ForkedLightning
        { 17, { id = 211062, level = "25" }, }, --StaticCling 
        { 18, { id = 204357, level = "43" }, }, --RidetheLightning 
		--Tier 6
        { 20, { id = 193876, level = "10" }, }, --Shamanism 
        { 21, { id = 204365, level = "28" }, }, --LeaderoftheClan 
        { 22, { id = 204366, level = "46" }, }, --Thundercharge 
      },
      [SHAMAN_RESTO_DIFF] = {
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195330, level = "2" }, }, --DefenderoftheWeak  
        { 6, { id = 195483, level = "16" }, }, --VimandVigor  
        { 7, { id = 195606, level = "34" }, }, --CalmingWaters 
		--Tier 3
        { 9, { id = 204330, level = "4" }, }, --SkyfuryTotem 
        { 10, { id = 204331, level = "19" }, }, --CounterstrikeTotem  
        { 11, { id = 204332, level = "37" }, }, --WindfuryTotem  
		--Tier 4
        { 13, { id = 204247, level = "6" }, }, --PurifyingWaters  
        { 14, { id = 236501, level = "22" }, }, --Tidebringer 
        { 15, { id = 204264, level = "40" }, }, --SwellingWaves 
		--Tier 5  
        { 16, { id = 204268, level = "8" }, }, --VoodooMastery
        { 17, { id = 206642, level = "25" }, }, --Electrocute 
        { 18, { id = 204336, level = "43" }, }, --GroundingTotem 
		--Tier 6
        { 20, { id = 204269, level = "10" }, }, --RipplingWaters 
        { 21, { id = 204288, level = "28" }, }, --Earthshield 
        { 22, { id = 204293, level = "46" }, }, --SpiritLink 
      },
    },
--    {
--      name = "Artifact Traits",
--      CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--      [SHAMAN_ELE_DIFF] = {
--
--      },
--      [SHAMAN_ENH_DIFF] = {
--
--      },
--      [SHAMAN_RESTO_DIFF] = {
--
--      },
--    },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\inv_glyph_minorshaman",
      [GLYPH_DIFF] = {
        { 1, 219213 }, --Critterhex
		{ 2, 63279 }, --Deluge 
		{ 3, 212636 }, --Flickering
		{ 4, 147784 }, --LingeringAncestors
		{ 5, 212635 }, --Pebbles
		{ 6, 147783 }, --SpiritRaptors
		{ 7, 212631 }, --SpectralRaptor
		{ 8, 58135 }, --SpectralWolf
      },
    },
  },
 }

 
-------------------
--WARLOCK
-------------------

data["CLASS_WARLOCK"] = {
  name = "Warlock",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("WARLOCK"),
	  [WARLOCK_DIFF] = {
        { 1, { id = 5782, level = "16" }, }, --Fear
        { 2, { id = 6201, level = "18" }, }, --CreateHealthstone
		{ 3, { id = 755, level = "22" }, }, --HealthFunnel
		{ 4, { id = 126, level = "24" }, }, --EyeofKilrogg
		{ 5, { id = 5697, level = "24" }, }, --UnendingBreath
		{ 6, { id = 710, level = "32" }, }, --Banish
		{ 7, { id = 119898, level = "38" }, }, --CommandDemon
        { 8, { id = 698, level = "42" }, }, --RitualofSummoning
		{ 9, { id = 20707, level = "44" }, }, --Soulstone
		{ 10, { id = 104773, level = "54" }, }, --UnendingResolve
		{ 11, { id = 1098, level = "56" }, }, --EnslaveDemon
		{ 12, { id = 29893, level = "66" }, }, --CreateSoulwell
        { 13, { id = 111771, level = "80" }, }, --DemonicGateway
		--Summons
		{ 16, { id = 688, level = "5" }, }, --SummonImp
		{ 17, { id = 697, level = "20" }, }, --SummonVoidwalker
		{ 18, { id = 712, level = "28" }, }, --SummonSuccubus	
        { 19, { id = 691, level = "36" }, }, --SummonFelhunter
		{ 20, { id = 18540, level = "50" }, }, --SummonDoomguard	
        { 21, { id = 1122, level = "58" }, }, --SummonInfernal		
		--Passives
		{ 23, { id = 108370, level = "34", rank = "Passive " }, }, --SoulLeech
		--Skills
        { 25, { id = 76277}, }, --Armor
        { 26, { id = 86091}, }, --Nethermancy
        { 27, { id = 76299}, }, --Weapon
      }, 
      [WARLOCK_AFF_DIFF] = {
		--Active
        { 1, { id = 172, level = "3" }, }, --Corruption
        { 2, { id = 1454, level = "8" }, }, --LifeTap
		{ 3, { id = 980, level = "10" }, }, --Agony	
		{ 4, { id = 198590, level = "13" }, }, --DrainSoul
		{ 5, { id = 30108, level = "14" }, }, --UnstableAffliction
		{ 6, { id = 27243, level = "38" }, }, --SeedofCorruption
		--Passives
		{ 16, { id = 77215, level = "78", rank = "Passive " }, }, --Mastery: PotentAfflictions	
      },
      [WARLOCK_DEMO_DIFF] = {
		--Active
        { 1, { id = 686, level = "1" }, }, --ShadowBolt
        { 2, { id = 1454, level = "8" }, }, --LifeTap
		{ 3, { id = 105174, level = "10" }, }, --HandofGuldan	
		{ 4, { id = 193396, level = "12" }, }, --DemonicEmpowerment
		{ 5, { id = 234153, level = "13" }, }, --DrainLife
		{ 6, { id = 104316, level = "14" }, }, --CallDreadstalkers
		{ 7, { id = 603, level = "26" }, }, --Doom
		{ 8, { id = 30146, level = "40" }, }, --SummonFelguard
		{ 9, { id = 193440, level = "48" }, }, --Demonwrath
		--Passives
		{ 16, { id = 108415, level = "52", rank = "Passive " }, }, --SoulLink	
		{ 17, { id = 77219, level = "78", rank = "Passive" }, }, --Mastery: MasterDemonologist	
	},
      [WARLOCK_DESTRO_DIFF] = {
		--Active
        { 1, { id = 686, level = "1" }, }, --ShadowBolt
        { 2, { id = 1454, level = "8" }, }, --LifeTap
		{ 3, { id = 17962, level = "10" }, }, --Conflagrate	
		{ 4, { id = 348, level = "10" }, }, --Immolate	
		{ 5, { id = 116858, level = "12" }, }, --ChaosBolt	
		{ 6, { id = 234153, level = "13" }, }, --DrainLife
		{ 7, { id = 29722, level = "14" }, }, --Incinerate
		{ 8, { id = 5740, level = "26" }, }, --RainofFire
		{ 9, { id = 80240, level = "40" }, }, --Havoc
		--Passives
		{ 16, { id = 77220, level = "78", rank = "Passive " }, }, --Mastery: ChaoticEnergies	
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [WARLOCK_AFF_DIFF] = {
		--Tier 1 
        { 1, { id = 48181, level = "15" }, }, --Haunt
        { 2, { id = 196102, level = "15" }, }, --WritheinAgony
        { 3, { id = 235155, level = "15" }, }, --MaleficGrasp 
		--Tier 2
        { 5, { id = 196105, level = "30" }, }, --Contagion 
        { 6, { id = 196103, level = "30" }, }, --AbsoluteCorruption
        { 7, { id = 235157, level = "30" }, }, --EmpoweredLifeTap
		--Tier 3
        { 9, { id = 48018, level = "45" }, }, --DemonicCircle 
        { 10, { id = 6789, level = "45" }, }, --MortalCoil 
        { 11, { id = 5484, level = "45" }, }, --HowlofTerror
		--Tier 4 
        { 13, { id = 205179, level = "60" }, }, --PhantomSingularity
        { 14, { id = 196226, level = "60" }, }, --SowtheSeeds 
        { 15, { id = 196098, level = "60" }, }, --SoulHarvest
		--Tier 5
        { 16, { id = 219272, level = "75" }, }, --DemonSkin
        { 17, { id = 111400, level = "75" }, }, --BurningRush
        { 18, { id = 108416, level = "75" }, }, --DarkPact
		--Tier 6
        { 20, { id = 152107, level = "90" }, }, --GrimoireofSupremacy
        { 21, { id = 108501, level = "90" }, }, --GrimoireofService
        { 22, { id = 108503, level = "90" }, }, --GrimoireofSacrifice
		--Tier 7
        { 24, { id = 234876, level = "100" }, }, --DeathsEmbrace
        { 25, { id = 63106, level = "100" }, }, --SiphonLife
        { 26, { id = 215941, level = "100" }, }, --SoulConduit
      },
      [WARLOCK_DEMO_DIFF] = {
		--Tier 1
        { 1, { id = 196269, level = "15" }, }, --ShadowyInspiration
        { 2, { id = 205181, level = "15" }, }, --Shadowflame 
        { 3, { id = 205145, level = "15" }, }, --DemonicCalling
		--Tier 2
        { 5, { id = 196270, level = "30" }, }, --ImpendingDoom 
        { 6, { id = 196272, level = "30" }, }, --ImprovedDreadstalkers
        { 7, { id = 196277, level = "30" }, }, --Implosion
		--Tier 3
        { 9, { id = 48018, level = "45" }, }, --DemonicCircle
        { 10, { id = 6789, level = "45" }, }, --MortalCoil
        { 11, { id = 30283, level = "45" }, }, --Shadowfury
		--Tier 4
        { 13, { id = 196283, level = "60" }, }, --HandofDoom
        { 14, { id = 196605, level = "60" }, }, --PowerTrip 
        { 15, { id = 196098, level = "60" }, }, --SoulHarvest
		--Tier 5
        { 16, { id = 219272, level = "75" }, }, --DemonSkin
        { 17, { id = 111400, level = "75" }, }, --BurningRush
        { 18, { id = 108416, level = "75" }, }, --DarkPact
		--Tier 6
        { 20, { id = 152107, level = "90" }, }, --GrimoireofSupremacy
        { 21, { id = 108501, level = "90" }, }, --GrimoireofService
        { 22, { id = 171975, level = "90" }, }, --GrimoireofSynergy
		--Tier 7
        { 24, { id = 205180, level = "100" }, }, --SummonDarkglare
        { 25, { id = 157695, level = "100" }, }, --Demonbolt 
        { 26, { id = 215941, level = "100" }, }, --SoulConduit
      },
      [WARLOCK_DESTRO_DIFF] = {
		--Tier 1
        { 1, { id = 196406, level = "15" }, }, --Backdraft
        { 2, { id = 205184, level = "15" }, }, --RoaringBlaze
        { 3, { id = 17877, level = "15" }, }, --Shadowburn
		--Tier 2
        { 5, { id = 205148, level = "30" }, }, --ReverseEntropy
        { 6, { id = 196412, level = "30" }, }, --Eradication
        { 7, { id = 235157, level = "30" }, }, --EmpoweredLifeTap
		--Tier 3
        { 9, { id = 48018, level = "45" }, }, --DemonicCircle
        { 10, { id = 6789, level = "45" }, }, --MortalCoil
        { 11, { id = 30283, level = "45" }, }, --Shadowfury
		--Tier 4
        { 13, { id = 152108, level = "60" }, }, --Cataclysm
        { 14, { id = 196408, level = "60" }, }, --FireandBrimstone
        { 15, { id = 196098, level = "60" }, }, --SoulHarvest
		--Tier 5
        { 16, { id = 219272, level = "75" }, }, --DemonSkin
        { 17, { id = 111400, level = "75" }, }, --BurningRush
        { 18, { id = 108416, level = "75" }, }, --DarkPact
		--Tier 6
        { 20, { id = 152107, level = "90" }, }, --GrimoireofSupremacy
        { 21, { id = 108501, level = "90" }, }, --GrimoireofService
        { 22, { id = 108503, level = "90" }, }, --GrimoireofSacrifice
		--Tier 7
        { 24, { id = 196410, level = "100" }, }, --WreakHavoc
        { 25, { id = 196447, level = "100" }, }, --ChannelDemonfire 
        { 26, { id = 215941, level = "100" }, }, --SoulConduit
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [WARLOCK_AFF_DIFF] = {
		--Tier 1
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 213545, level = "2" }, }, --TrainofThought  
        { 6, { id = 213546, level = "16" }, }, --MindQuickness  
        { 7, { id = 213547, level = "34" }, }, --Initiation 
		--Tier 3
        { 9, { id = 199890, rank = "Honor Talent", level = "4" }, }, --CurseofTongues 
        { 10, { id = 199892, level = "19" }, }, --CurseofWeakness  
        { 11, { id = 199954, level = "37" }, }, --CurseofFragility  
		--Tier 4
        { 13, { id = 221711, level = "6" }, }, --EssenceDrain  
        { 14, { id = 221703, level = "22" }, }, --CastingCircle 
        { 15, { id = 212295, level = "40" }, }, --NetherWard 
		--Tier 5  
        { 16, { id = 213400, level = "8" }, }, --EndlessAffliction
        { 17, { id = 212356, level = "25" }, }, --Soulshatter 
        { 18, { id = 248813, level = "43" }, }, --Nightfall 
		--Tier 6
        { 20, { id = 248855, level = "10" }, }, --GatewayMastery 
        { 21, { id = 212371, level = "28" }, }, --RotandDecay 
        { 22, { id = 234877, level = "46" }, }, --CurseofShadows 
      },
      [WARLOCK_DEMO_DIFF] = {
		--Tier 1
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 213545, level = "2" }, }, --TrainofThought  
        { 6, { id = 213546, level = "16" }, }, --MindQuickness  
        { 7, { id = 213547, level = "34" }, }, --Initiation 
		--Tier 3
        { 9, { id = 199890, rank = "Honor Talent", level = "4" }, }, --CurseofTongues 
        { 10, { id = 199892, level = "19" }, }, --CurseofWeakness  
        { 11, { id = 199954, level = "37" }, }, --CurseofFragility  
		--Tier 4
        { 13, { id = 221711, level = "6" }, }, --EssenceDrain  
        { 14, { id = 221703, level = "22" }, }, --CastingCircle 
        { 15, { id = 212295, level = "40" }, }, --NetherWard 
		--Tier 5  
        { 16, { id = 212618, level = "8" }, }, --PleasureThroughPain
        { 17, { id = 212619, level = "25" }, }, --CallFelhunter 
        { 18, { id = 212623, level = "43" }, }, --SingeMagic 
		--Tier 6
        { 20, { id = 212628, level = "10" }, }, --MasterSummoner 
        { 21, { id = 212459, level = "28" }, }, --CallFelLord 
        { 22, { id = 201996, level = "46" }, }, --CallObserver 
      },
      [WARLOCK_DESTRO_DIFF] = {
		--Tier 1
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 213545, level = "2" }, }, --TrainofThought  
        { 6, { id = 213546, level = "16" }, }, --MindQuickness  
        { 7, { id = 213547, level = "34" }, }, --Initiation 
		--Tier 3
        { 9, { id = 199890, rank = "Honor Talent", level = "4" }, }, --CurseofTongues 
        { 10, { id = 199892, level = "19" }, }, --CurseofWeakness  
        { 11, { id = 199954, level = "37" }, }, --CurseofFragility  
		--Tier 4
        { 13, { id = 221711, level = "6" }, }, --EssenceDrain  
        { 14, { id = 221703, level = "22" }, }, --CastingCircle 
        { 15, { id = 212295, level = "40" }, }, --NetherWard 
		--Tier 5  
        { 16, { id = 212282, level = "8" }, }, --Cremation
        { 17, { id = 233577, level = "25" }, }, --FocusedChaos 
        { 18, { id = 212284, level = "43" }, }, --Firestone 
		--Tier 6
        { 20, { id = 233581, level = "10" }, }, --EntrenchedinFlame 
        { 21, { id = 200586, level = "28" }, }, --FelFissure 
        { 22, { id = 200546, level = "46" }, }, --BaneofHavoc 
      },
    },
--    {
--      name = "Artifact Traits",
--      CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--      [WARLOCK_AFF_DIFF] = {
--
--      },
--      [WARLOCK_DEMO_DIFF] = {
--
--      },
--      [WARLOCK_DESTRO_DIFF] = {
--
--      },
--    },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\inv_glyph_minorwarlock",
      [GLYPH_DIFF] = {
        { 1, 63312 }, --CrimsonBanish
        { 2, 246975 }, --EmberShards
        { 3, 246997 }, --FelTouchedShards
		{ 4, 56246 }, --Felguard 
        { 5, 246972 }, --FloatingShards
		{ 6, 58094 }, --Soulwell
		{ 7, 219459 }, --Abyssal
		{ 8, 211910 }, --DemonEye
		{ 9, 219424 }, --FelImp
		{ 10, 211899 }, --InquisitorsEye
        { 11, 219450 }, --Observer
		{ 12, 240270 }, --ShadowSuccubus 
		{ 13, 219436 }, --Shivarra
		{ 14, 219455 }, --Terrorguard
		{ 15, 219445 }, --Voidlord
		{ 16, 219467 }, --Wrathguard
		{ 17, 240264 }, --OrbofFelTemptress
      },
	},
	{
      name = "Pet Abilities",
      CoinTexture = "texture:Interface\\Icons\\ability_warlock_demonicempowerment",
	 [WARLOCK_PET_DIFF] = {	
		--Imp
        { 1, { id = 119899, rank = COLOR_PET_FAMILY.."Imp"}, }, --CauterizeMaster
		{ 2, { id = 3110, rank = COLOR_PET_FAMILY.."Imp"}, }, --Firebolt
		{ 3, { id = 89792, rank = COLOR_PET_FAMILY.."Imp"}, }, --Flee
		{ 4, { id = 89808, rank = COLOR_PET_FAMILY.."Imp"}, }, --SingeMagic
		--Voidwalker
        { 6, { id = 3716, rank = COLOR_PET_FAMILY.."Voidwalker"}, }, --ConsumingShadows
		{ 7, { id = 17767, rank = COLOR_PET_FAMILY.."Voidwalker"}, }, --ShadowBulwark
		{ 8, { id = 115232, rank = COLOR_PET_FAMILY.."Voidwalker"}, }, --ShadowShield
		{ 9, { id = 17735, rank = COLOR_PET_FAMILY.."Voidwalker"}, }, --Suffering
		{ 10, { id = 112042, rank = COLOR_PET_FAMILY.."Voidwalker"}, }, --ThreateningPresence
	    { 11, { id = 117225, rank = "Passive"}, }, --VoidReflexes
		--Felhunter
        { 13, { id = 19505, rank = COLOR_PET_FAMILY.."Felhunter"}, }, --DevourMagic
		{ 14, { id = 54049, rank = COLOR_PET_FAMILY.."Felhunter"}, }, --ShadowBite
		{ 15, { id = 19647, rank = COLOR_PET_FAMILY.."Felhunter"}, }, --SpellLock
		--Succubus
        { 16, { id = 7814, rank = COLOR_PET_FAMILY.."Succubus"}, }, --LashofPain
		{ 17, { id = 7870, rank = COLOR_PET_FAMILY.."Succubus"}, }, --LessserInvisibility
		{ 18, { id = 6358, rank = COLOR_PET_FAMILY.."Succubus"}, }, --Seduction
		{ 19, { id = 6360, rank = COLOR_PET_FAMILY.."Succubus"}, }, --Whiplash
		--Felguard
        { 21, { id = 89766, rank = COLOR_PET_FAMILY.."Felguard"}, }, --AxeToss
		{ 22, { id = 89751, rank = COLOR_PET_FAMILY.."Felguard"}, }, --Felstorm
		{ 23, { id = 30213, rank = COLOR_PET_FAMILY.."Felguard"}, }, --LegionStrike
		{ 24, { id = 30151, rank = COLOR_PET_FAMILY.."Felguard"}, }, --Pursuit
		{ 25, { id = 134477, rank = COLOR_PET_FAMILY.."Felguard"}, }, --ThreateningPresence
	    { 26, { id = 117225, rank = "Passive"}, }, --VoidReflexes
		--Basic
	    { 28, { id = 32233 }, }, --Avoidance
      },
     [WARLOCK_GRIM_DIFF] = {	
		--Doomguard
        { 1, { id = 170995, rank = COLOR_PET_FAMILY.."Doomguard" }, }, --Cripple
        { 2, { id = 85692, rank = COLOR_PET_FAMILY.."Doomguard" }, }, --DoomBolt
        { 3, { id = 171138, rank = COLOR_PET_FAMILY.."Doomguard" }, }, --ShadowLock
		--Infernal
		{ 5, { id = 171011, rank = COLOR_PET_FAMILY.."Infernal" }, }, --BurningPresence
		{ 6, { id = 19483, rank = COLOR_PET_FAMILY.."Infernal" }, }, --Immolation
		{ 7, { id = 171017, rank = COLOR_PET_FAMILY.."Infernal" }, }, --MeteorStrike
		{ 8, { id = 171014, rank = COLOR_PET_FAMILY.."Infernal" }, }, --Seethe		
		{ 9, { id = 171021, rank = COLOR_PET_FAMILY.."Infernal" }, }, --TorchMagic
      },
    },
  },
 }
 
-------------------
--WARRIOR
-------------------

data["CLASS_WARRIOR"] = {
  name = "Warrior",
  ContentType = CLASSES_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Abilities",
      CoinTexture = "texture:Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"..coords("WARRIOR"),
	  [WARRIOR_DIFF] = {
        { 1, { id = 100, level = "3" }, }, --Charge
        { 2, { id = 355, level = "13" }, }, --Taunt
        { 3, { id = 57755, level = "17" }, }, --HeroicThrow
		{ 4, { id = 6552, level = "24" }, }, --Pummel	
		{ 5, { id = 6544, level = "26" }, }, --HeroicLeap
		--Passives
		{ 16, { id = 107, level = "1"}, }, --Block
		{ 17, { id = 3127, level = "1", rank = "Passive" }, }, --Parry
		--Skills
        { 19, { id = 76268, rank = "Passive"}, }, --Armor
        { 20, { id = 76290, rank = "Passive"}, }, --Weapon
      }, 
      [WARRIOR_ARMS_DIFF] = {
		--Active
        { 1, { id = 1464, level = "1" }, }, --Slam
        { 2, { id = 34428, level = "5" }, }, --VictoryRush
		{ 3, { id = 163201, level = "8" }, }, --Execute	
		{ 4, { id = 12294, level = "10" }, }, --MortalStrike	
		{ 5, { id = 167105, level = "20" }, }, --ColossusSmash	
		{ 6, { id = 845, level = "22" }, }, --Cleave
		{ 7, { id = 1715, level = "32" }, }, --Hamstring
		{ 8, { id = 118038, level = "36" }, }, --DiebytheSword
		{ 9, { id = 1680, level = "40" }, }, --Whirlwind
		{ 10, { id = 18499, level = "42" }, }, --BerserkerRage	
		{ 11, { id = 1719, level = "50" }, }, --BattleCry
		{ 12, { id = 227847, level = "65" }, }, --Bladestorm
		{ 13, { id = 5246, level = "70" }, }, --IntimidatingShout
		{ 14, { id = 97462, level = "80" }, }, --CommandingShout
		--Passives
		{ 16, { id = 184783, level = "34", rank = "Passive " }, }, --Tactician	
		{ 17, { id = 76838, level = "78", rank = "Passive " }, }, --Mastery: ColossalMight	
		--Skills
		{ 19, { id = 86113, level = "55" }, }, --PlateSpecialization
      },
      [WARRIOR_FURY_DIFF] = {
		--Active
		{ 1, { id = 5308, level = "8" }, }, --Execute	
		{ 2, { id = 23881, level = "10" }, }, --Bloodthirst	
		{ 3, { id = 100130, level = "10" }, }, --FuriousSlash	
		{ 4, { id = 184367, level = "12" }, }, --Rampage	
		{ 5, { id = 85288, level = "20" }, }, --RagingBlow	
		{ 6, { id = 12323, level = "32" }, }, --PiercingHowl
		{ 7, { id = 184364, level = "36" }, }, --EnragedRegeneration
		{ 8, { id = 190411, level = "40" }, }, --Whirlwind
		{ 9, { id = 18499, level = "42" }, }, --BerserkerRage	
		{ 10, { id = 1719, level = "50" }, }, --BattleCry
		{ 11, { id = 5246, level = "70" }, }, --IntimidatingShout
		{ 12, { id = 97462, level = "80" }, }, --CommandingShout
		--Passives
		{ 16, { id = 231842, level = "1", rank = "Passive " }, }, --DualWield
		{ 17, { id = 46917, level = "10", rank = "Passive " }, }, --TitansGrip
		{ 18, { id = 184361, level = "14", rank = "Passive " }, }, --Enrage
		{ 19, { id = 76856, level = "78", rank = "Passive " }, }, --Mastery: UnshackledFury	
		--Skills
		{ 21, { id = 86113, level = "55" }, }, --PlateSpecialization
	},
      [WARRIOR_PROT_DIFF] = {
		--Active
        { 1, { id = 34428, level = "5" }, }, --VictoryRush
		{ 2, { id = 20243, level = "10" }, }, --Devastate	
		{ 3, { id = 23922, level = "10" }, }, --ShieldSlam	
		{ 4, { id = 6343, level = "14" }, }, --ThunderClap	
		{ 5, { id = 2565, level = "20" }, }, --ShieldBlock
		{ 6, { id = 6572, level = "22" }, }, --Revenge
		{ 7, { id = 198304, level = "28" }, }, --Intercept
		{ 8, { id = 12975, level = "32" }, }, --LastStand
		{ 9, { id = 190456, level = "40" }, }, --IgnorePain
		{ 10, { id = 18499, level = "42" }, }, --BerserkerRage	
		{ 11, { id = 1160, level = "48" }, }, --DemoralizingShout
		{ 12, { id = 1719, level = "50" }, }, --BattleCry
		{ 13, { id = 871, level = "55" }, }, --ShieldWall
		{ 14, { id = 23920, level = "80" }, }, --SpellReflection
		--Passives
		{ 16, { id = 71, level = "9", rank = "Passive " }, }, --DefensiveStance
		{ 17, { id = 29144, level = "10", rank = "Passive " }, }, --UnwaveringSentinel
		{ 18, { id = 84608, level = "60", rank = "Passive " }, }, --BastionofDefense
		{ 19, { id = 161798, level = "65", rank = "Passive " }, }, --Riposte
		{ 20, { id = 76857, level = "78", rank = "Passive " }, }, --Mastery: CriticalBlock	
		--Skills
		{ 22, { id = 86113, level = "55" }, }, --PlateSpecialization
      },
	},
    {
      name = "Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_marksmanship",
      [WARRIOR_ARMS_DIFF] = {
		--Tier 1 
        { 1, { id = 202297, level = "15" }, }, --Dauntless
        { 2, { id = 7384, level = "15" }, }, --Overpower
        { 3, { id = 202161, level = "15" }, }, --SweepingStrikes 
		--Tier 2
        { 5, { id = 46968, level = "30" }, }, --Shockwave 
        { 6, { id = 107570, level = "30" }, }, --StormBolt
        { 7, { id = 103827, level = "30" }, }, --DoubleTime
		--Tier 3
        { 9, { id = 215538, level = "45" }, }, --Trauma 
        { 10, { id = 772, level = "45" }, }, --Rend 
        { 11, { id = 107574, level = "45" }, }, --Avatar
		--Tier 4 
        { 13, { id = 29838, level = "60" }, }, --SecondWind
        { 14, { id = 202163, level = "60" }, }, --BoundingStride 
        { 15, { id = 197690, level = "60" }, }, --DefensiveStance
		--Tier 5
        { 16, { id = 202316, level = "75" }, }, --FervorofBattle
        { 17, { id = 202593, level = "75" }, }, --MortalCombo
        { 18, { id = 202612, level = "75" }, }, --TitanicMight
		--Tier 6
        { 20, { id = 227266, level = "90" }, }, --DeadlyCalm
        { 21, { id = 248621, level = "90" }, }, --InForTheKill
        { 22, { id = 207982, level = "90" }, }, --FocusedRage
		--Tier 7
        { 24, { id = 152278, level = "100" }, }, --AngerManagement
        { 25, { id = 203179, level = "100" }, }, --OpportunityStrikes
        { 26, { id = 152277, level = "100" }, }, --Ravager
      },
      [WARRIOR_FURY_DIFF] = {
		--Tier 1
        { 1, { id = 215556, level = "15" }, }, --WarMachine
        { 2, { id = 202296, level = "15" }, }, --EndlessRage 
        { 3, { id = 215568, level = "15" }, }, --FreshMeat
		--Tier 2
        { 5, { id = 46968, level = "30" }, }, --Shockwave 
        { 6, { id = 107570, level = "30" }, }, --StormBolt
        { 7, { id = 103827, level = "30" }, }, --DoubleTime
		--Tier 3
        { 9, { id = 215569, level = "45" }, }, --WreckingBall
        { 10, { id = 206320, level = "45" }, }, --Outburst
        { 11, { id = 107574, level = "45" }, }, --Avatar
		--Tier 4
        { 13, { id = 202224, level = "60" }, }, --FuriousCharge
        { 14, { id = 202163, level = "60" }, }, --BoundingStride 
        { 15, { id = 208154, level = "60" }, }, --Warpaint
		--Tier 5
        { 16, { id = 206315, level = "75" }, }, --Massacre
        { 17, { id = 215571, level = "75" }, }, --FrothingBerserker
        { 18, { id = 202922, level = "75" }, }, --Carnage
		--Tier 6
        { 20, { id = 12292, level = "90" }, }, --Bloodbath
        { 21, { id = 206313, level = "90" }, }, --Frenzy 
        { 22, { id = 215573, level = "90" }, }, --InnerRage
		--Tier 7
        { 24, { id = 46924, level = "100" }, }, --Bladestorm
        { 25, { id = 202751, level = "100" }, }, --RecklessAbandon 
        { 26, { id = 118000, level = "100" }, }, --DragonRoar
      },
      [WARRIOR_PROT_DIFF] = {
		--Tier 1
        { 1, { id = 46968, level = "15" }, }, --Shockwave
        { 2, { id = 107570, level = "15" }, }, --StormBolt
        { 3, { id = 103828, level = "15" }, }, --Warbringer
		--Tier 2
        { 5, { id = 202168, level = "30" }, }, --ImpendingVictory
        { 6, { id = 205484, level = "30" }, }, --InspiringPresence
        { 7, { id = 223657, level = "30" }, }, --Safeguard
		--Tier 3
        { 9, { id = 202288, level = "45" }, }, --RenewedFury
        { 10, { id = 202560, level = "45" }, }, --BestServedCold
        { 11, { id = 107574, level = "45" }, }, --Avatar
		--Tier 4
        { 13, { id = 223662, level = "60" }, }, --WarlordsChallenge
        { 14, { id = 202163, level = "60" }, }, --BoundingStride
        { 15, { id = 203201, level = "60" }, }, --CracklingThunder
		--Tier 5
        { 16, { id = 236279, level = "75" }, }, --Devastator
        { 17, { id = 202561, level = "75" }, }, --NeverSurrender
        { 18, { id = 202095, level = "75" }, }, --Indomitable
		--Tier 6
        { 20, { id = 202572, level = "90" }, }, --Vengeance 
        { 21, { id = 202603, level = "90" }, }, --IntotheFray
        { 22, { id = 202743, level = "90" }, }, --BoomingVoice
		--Tier 7
        { 24, { id = 152278, level = "100" }, }, --AngerManagement
        { 25, { id = 203177, level = "100" }, }, --HeavyRepercussions 
        { 26, { id = 228920, level = "100" }, }, --Ravager
      },
    },
    {
      name = "Honor Talents",
      CoinTexture = "texture:Interface\\Icons\\ability_pvp_gladiatormedallion",
      [WARRIOR_ARMS_DIFF] = {
		--Tier 1
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 198490, level = "4" }, }, --DeathRow 
        { 10, { id = 236077, rank = "Honor Talent", level = "19" }, }, --Disarm  
        { 11, { id = 198500, level = "37" }, }, --DeathSentence  
		--Tier 4
        { 13, { id = 198614, level = "6" }, }, --RageMachine  
        { 14, { id = 216890, level = "22" }, }, --SpellReflection 
        { 15, { id = 235941, level = "40" }, }, --MasterandCommander 
		--Tier 5  
        { 16, { id = 198765, level = "8" }, }, --PainTrain
        { 17, { id = 236273, level = "25" }, }, --Duel 
        { 18, { id = 236320, rank = "Honor Talent", level = "43" }, }, --WarBanner 
		--Tier 6
        { 20, { id = 236308, rank = "Honor Talent", level = "10" }, }, --StormofDestruction 
        { 21, { id = 198807, level = "28" }, }, --ShadowoftheColossus 
        { 22, { id = 198817, level = "46" }, }, --SharpenBlade 
      },
      [WARRIOR_FURY_DIFF] = {
		--Tier 1
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195416, level = "2" }, }, --Hardiness  
        { 6, { id = 195282, level = "16" }, }, --ReinforcedArmor  
        { 7, { id = 195425, level = "34" }, }, --Sparring 
		--Tier 3
        { 9, { id = 198490, level = "4" }, }, --DeathRow 
        { 10, { id = 236077, rank = "Honor Talent", level = "19" }, }, --Disarm  
        { 11, { id = 198500, level = "37" }, }, --DeathSentence  
		--Tier 4
        { 13, { id = 198614, level = "6" }, }, --RageMachine  
        { 14, { id = 216890, level = "22" }, }, --SpellReflection 
        { 15, { id = 235941, level = "40" }, }, --MasterandCommander 
		--Tier 5  
        { 16, { id = 199148, level = "8" }, }, --Barbarian
        { 17, { id = 213857, level = "25" }, }, --BattleTrance 
        { 18, { id = 199202, level = "43" }, }, --ThirstforBattle 
		--Tier 6
        { 20, { id = 199204, level = "10" }, }, --Slaughterhouse 
        { 21, { id = 198877, level = "28" }, }, --EndlessRage 
        { 22, { id = 199261, level = "46" }, }, --DeathWish 
      },
      [WARRIOR_PROT_DIFF] = {
		--Tier 1
	    { 1, { id = 208683, level = "1" }, }, --GladiatorsMedallion 
        { 2, { id = 214027, level = "13" }, }, --Adaptation 
        { 3, { id = 196029, level = "31" }, }, --Relentless 
		--Tier 2
        { 5, { id = 195338, level = "2" }, }, --RelentlessAssault  
        { 6, { id = 205800, level = "16" }, }, --Oppressor  
        { 7, { id = 195389, level = "34" }, }, --SoftendedBlows 
		--Tier 3
        { 9, { id = 213915, level = "4" }, }, --MassSpellReflection 
        { 10, { id = 199127, level = "19" }, }, --SwordandBoard  
        { 11, { id = 213871, level = "37" }, }, --Bodyguard  
		--Tier 4
        { 13, { id = 198614, level = "6" }, }, --RageMachine  
        { 14, { id = 236236, rank = "Honor Talent", level = "22" }, }, --Disarm 
        { 15, { id = 198621, level = "40" }, }, --ReadyforBattle 
		--Tier 5  
        { 16, { id = 199037, level = "8" }, }, --LeaveNoManBehind
        { 17, { id = 199023, level = "25" }, }, --MoraleKiller 
        { 18, { id = 198912, rank = "Honor Talent", level = "43" }, }, --ShieldBash 
		--Tier 6
        { 20, { id = 199045, level = "10" }, }, --Thunderstruck 
        { 21, { id = 199086, level = "28" }, }, --Warpath 
        { 22, { id = 206572, level = "46" }, }, --DragonCharge 
      },
    },
--    {
--      name = "Artifact Traits",
--      CoinTexture = "texture:Interface\\Icons\\inv_scroll_11",
--      [WARRIOR_ARMS_DIFF] = {
--
--      },
--      [WARRIOR_FURY_DIFF] = {
--
--     },
--      [WARRIOR_PROT_DIFF] = {
--
--      },
--    },
	{
      name = "Glyphs",
      CoinTexture = "texture:Interface\\Icons\\inv_glyph_minorwarrior",
      [GLYPH_DIFF] = {
        { 1, 115946 }, --BurningAnger
		{ 2, 228378 }, --FallingThunder 
		{ 3, 58099 }, --GushingWound
		{ 4, 115943 }, --HawkFeast
		{ 5, 58104 }, --MightyVictory
		{ 6, 211829 }, --BlazingSavior
		{ 7, 123779 }, --BlazingTrail
		{ 8, 146974 }, --Weaponmaster
		{ 9, 68164 }, --ThunderStrike
      },
    },
  },
 }


-------------------
--RACIALS
-------------------

--ALLIANCE 

data["ALLIANCE_RACIALS"] = {
  name = "Alliance",
  ContentType = RACIAL_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Draenei",
      CoinTexture = "texture:Interface\\Icons\\achievement_character_draenei_male",
      [ALLIANCE_DIFF] = {
        { 1, 28875 }, --Gemcutting
        { 2, 6562 }, --HeroicPresence 
		{ 3, 59221 }, --ShadowResistance
		{ 4, 59545 }, --GiftoftheNaaru
        { 6, 668 }, --LanguageCommon
		{ 7, 29932 }, --LanguageDranei
      },
    },
    {
      name = "Dwarf",
      CoinTexture = "texture:Interface\\Icons\\achievement_character_dwarf_male",
      [ALLIANCE_DIFF] = {
        { 1, 92682 }, --Explorer
        { 2, 20596 }, --FrostResist
		{ 3, 59224 }, --MightofMountain
		{ 4, 20594 }, --Stoneform
		{ 6, 668 }, --LanguageCommon 
		{ 7, 672 }, --LanguageDwarvem
      },
    },
    {
      name = "Gnome",
      CoinTexture = "texture:Interface\\Icons\\achievement_character_gnome_female",
      [ALLIANCE_DIFF] = {
        { 1, 20592 }, --ArcaneResistance 
        { 2, 20593 }, --EngineeringSpecialization 
        { 3, 20589 }, --EscapeArtist
        { 4, 92680 }, --NimbleFingers
        { 6, 20591 }, --ExpansiveMind
        { 7, { id = 154747, rank = colorstr("DEATHKNIGHT").."Death Knight" }, }, --ExpansiveMInd
		{ 8, { id = 227057, rank = colorstr("HUNTER").."Hunter" }, }, --ExpansiveMInd
        { 9, { id = 154744, rank = colorstr("MONK").."Monk, " ..colorstr("ROGUE").."Rogue" }, }, --ExpansiveMInd
        { 10, { id = 154746, rank = colorstr("WARRIOR").."Warrior" }, },  --ExpansiveMInd  
        { 12, 668 }, --LanguageCommon 
        { 13, 7340 }, --LanguageGnomish
      },
    },
    {
      name = "Human",
      CoinTexture = "texture:Interface\\Icons\\achievement_character_human_male",
      [ALLIANCE_DIFF] = {
        { 1, 20599 }, --Diplomacy
        { 2, 59752 }, --EveryManforHimself 
        { 3, 20598 }, --TheHumanSpirit
        { 5, 668 }, --LanguageCommon
      },
    },
    {
      name = "Lighforged Draenei",
      CoinTexture = "texture:Interface\\Icons\\achievement_alliedrace_lightforgeddraenei",
      [ALLIANCE_DIFF] = {
        { 1, 255653 }, --Demonbane
        { 2, 259930 }, --ForgeofLight 
		{ 3, 255651 }, --HolyResistance
		{ 4, 255647 }, --LightsJudgement
		{ 5, 255652 }, --LightsReckoning
        { 7, 668 }, --LanguageCommon
		{ 8, 29932 }, --LanguageDranei
      },
    },
    {
      name = "Night Elf",
      CoinTexture = "texture:Interface\\Icons\\achievement_character_nightelf_male",
      [ALLIANCE_DIFF] = {
        { 1, 20583 }, --NatureResist
        { 2, 20582 }, --Quickness
        { 3, 58984 }, --Shadowmeld
        { 4, 154748 }, --TouchofElune
        { 5, 20585 }, --Wisp Spirit 
        { 7, 668 }, --LanguageCommon
        { 8, 671 }, --LanguageDarnassian
      },
    },
    {
      name = "Pandaren",
      CoinTexture = "texture:Interface\\Icons\\achievement_character_pandaren_female",
      [ALLIANCE_DIFF] = {
        { 1, 107076 }, --Bouncy
        { 2, 107072 }, --Epicurean 
        { 3, 107073 }, --Gourmand 
        { 4, 107074 }, --InnerPeace 
        { 5, 107079 }, --QuakingPalm 
        { 7, 668 }, --LanguageCommon 
        { 8, 108127 }, --LanguagePandarenNeutral
      },
	},
    {
      name = "Void Elf",
      CoinTexture = "texture:Interface\\Icons\\achievement_alliedrace_voidelf",
      [ALLIANCE_DIFF] = {
        { 1, 255668 }, --ChillofNight
        { 2, 255669 }, --EntropicEmbrace 
        { 3, 255667 }, --EtherealConnection 
        { 4, 255670 }, --PreternaturalCharm 
        { 5, 256948 }, --SpatialRift 
        { 7, 668 }, --LanguageCommon 
        { 8, 262454 }, --LanguageThalassianAlliance
      },
	},
    {
      name = "Worgen",
      CoinTexture = "texture:Interface\\Icons\\achievement_worganhead",
      [ALLIANCE_DIFF] = {
        { 1, 68976 }, --Aberration 
        { 2, 94293 }, --AlteredForm 
        { 3, 68992 }, --Darkflight 
        { 4, 68978 }, --Flayer 
        { 5, 87840 }, --RunningWild 
        { 6, 68996 }, --TwoForms 
        { 7, 68975 }, --Viciousness 
        { 9, 668 }, --LanguageCommon 
        { 10, 69270 }, --LanguageGilnean
      },
    },
  },
}

--HORDE 

data["HORDE_RACIALS"] = {
  name = "Horde",
  ContentType = RACIAL_CONTENT,
  TableType = SPELL_ITTYPE,
  items = {
    {
      name = "Blood Elf",
      CoinTexture = "texture:Interface\\Icons\\achievement_character_bloodelf_female",
      [HORDE_DIFF] = {
        { 1, 154742 }, --ArcaneAcuity 
        { 2, 28877 }, --ArcaneAffinity 
        { 3, 822 }, --ArcaneResistance
        { 5, 28730 }, --ArcaneTorrent
        { 6, { id = 50613, rank = colorstr("DEATHKNIGHT").."Death Knight" }, }, --ArcaneTorrent
		{ 7, { id = 202719, rank = colorstr("DEMONHUNTER").."Demon Hunter" }, }, --ArcaneTorrent 
        { 8, { id = 80483, rank = colorstr("HUNTER").."Hunter" }, }, --ArcaneTorrent 
        { 9, { id = 25046, rank = colorstr("MONK").."Monk, " ..colorstr("ROGUE").."Rogue" }, }, --ArcaneTorrent
        { 10, { id = 69179, rank = colorstr("WARRIOR").."Warrior" }, }, --ArcaneTorrent
        { 12, 669 }, --LanguageOrcish 
        { 13, 813 }, --LanguageThallasian
      },
    },
    {
      name = "Goblin",
      CoinTexture = "texture:Interface\\Icons\\achievement_goblinhead",
      [HORDE_DIFF] = {
        { 1, 69044 }, --BestDealsAnywhere 
        { 2, 69045 }, --BetterLivingThroughChemistry 
        { 3, 69046 }, --PackHobgoblin 
        { 4, 69041 }, --RocketBarrage 
        { 5, 69070 }, --RocketJump 
        { 6, 69042 }, --TimeisMoney 
        { 8, 669 }, --LanguageOrcish 
        { 9, 69269 }, --LanguageGoblin
      },
    },
    {
      name = "Highmountain Tauren",
      CoinTexture = "texture:Interface\\Icons\\achievement_alliedrace_highmountaintauren",
      [HORDE_DIFF] = {
        { 1, 255654 }, --BullRush 
        { 2, 255658 }, --Mountaineer 
        { 3, 255655 }, --PrideofIronhorn  
        { 4, 255659 }, --RuggedTenacity 
        { 5, 255656 }, --WasteNotWantNot 
        { 7, 669 }, --LanguageOrcish
        { 8, 670 }, --LanguageTaurahe
      },
    },
    {
      name = "Nightborne",
      CoinTexture = "texture:Interface\\Icons\\achievement_alliedrace_nightborne",
      [HORDE_DIFF] = {
        { 1, 255663 }, --AncientHistory
        { 2, 260364 }, --ArcanePulse
        { 3, 255664 }, --ArcaneResistance
        { 4, 255661 }, --Cantrips
        { 5, 255665 }, --MagicalAffinity
        { 7, 669 }, --LanguageOrcish
        { 8, 262439 }, --LanguageShalassian
      },
    },
    {
      name = "Orc",
      CoinTexture = "texture:Interface\\Icons\\achievement_character_orc_male",
      [HORDE_DIFF] = {
	    { 1, 21563 }, --Command 
        { 2, 20573 }, --Hardiness
        { 4, { id = 20572, rank = colorstr("DEATHKNIGHT").."DK, "..colorstr("HUNTER").."Hunter, "..colorstr("ROGUE").."Rogue, "..colorstr("WARRIOR").."Warrior" }, }, --BloodFury
        { 5, { id = 33697, rank = colorstr("MONK").."Monk, "..colorstr("SHAMAN").."Shaman" }, }, --BloodFury
        { 6, { id = 33702, rank = colorstr("MAGE").."Mage, "..colorstr("WARLOCK").."Warlock" }, }, --BloodFury
        { 8, 669 }, --LanguageOrcish
      },
    },

    {
      name = "Pandaren",
      CoinTexture = "texture:Interface\\Icons\\achievement_guild_classypanda",
      [HORDE_DIFF] = {
        { 1, 107076 }, --Bouncy
        { 2, 107072 }, --Epicurean
        { 3, 107073 }, --Gourmand
        { 4, 107074 }, --InnerPeace
        { 5, 107079 }, --QuakingPalm
        { 7, 669 }, --LanguageOrcish
        { 8, 108127 }, --LanguagePandarenNeutral
      },
    },
    {
      name = "Tauren",
      CoinTexture = "texture:Interface\\Icons\\achievement_character_tauren_male",
      [HORDE_DIFF] = {
        { 1, 154743 }, --Brawn 
        { 2, 20552 }, --Cultivation 
        { 3, 20550 }, --Endurance  
        { 4, 20551 }, --NatureResist 
        { 5, 20549 }, --WarStomp 
        { 7, 669 }, --LanguageOrcish
        { 8, 670 }, --LanguageTaurahe
      },
    },
    {
      name = "Troll",
      CoinTexture = "texture:Interface\\Icons\\achievement_character_troll_female",
      [HORDE_DIFF] = {
        { 1, 20557 }, --BeastSlaying 
        { 2, 26297 }, --Berserking
        { 3, 58943 }, --DaVoodooShuffle 
        { 4, 20555 }, --Regeneration 
        { 6, 669 }, --LanguageOrcish
        { 7, 7341 }, --LanguageTroll
      },
    },
    {
      name = "Undead",
      CoinTexture = "texture:Interface\\Icons\\achievement_character_undead_female",
      [HORDE_DIFF] = {
        { 1, 20577 }, --Cannibalize 
        { 2, 20579 }, --ShadowResistance
        { 3, 5227 }, --TouchoftheGrave 
        { 4, 7744 }, --WilloftheForsaken
        { 6, 669 }, --LanguageOrcish
        { 7, 17737 }, --LanguageGutterspeak
      },
    },
  },
}
