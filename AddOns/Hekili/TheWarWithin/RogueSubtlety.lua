-- RogueSubtlety.lua
-- August 2025
-- Patch 11.2

if UnitClassBase( "player" ) ~= "ROGUE" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 261 )

---- Local function declarations for increased performance
-- Strings
local strformat = string.format
-- Tables
local insert, remove, sort, wipe = table.insert, table.remove, table.sort, table.wipe
-- Math
local abs, ceil, floor, max, sqrt = math.abs, math.ceil, math.floor, math.max, math.sqrt

-- Common WoW APIs, comment out unneeded per-spec
-- local GetSpellCastCount = C_Spell.GetSpellCastCount
-- local GetSpellInfo = C_Spell.GetSpellInfo
local GetSpellInfo = ns.GetUnpackedSpellInfo
-- local GetPlayerAuraBySpellID = C_UnitAuras.GetPlayerAuraBySpellID
-- local FindUnitBuffByID, FindUnitDebuffByID = ns.FindUnitBuffByID, ns.FindUnitDebuffByID
-- local IsSpellOverlayed = C_SpellActivationOverlay.IsSpellOverlayed
-- local IsSpellKnownOrOverridesKnown = C_SpellBook.IsSpellInSpellBook
-- local IsActiveSpell = ns.IsActiveSpell

-- Specialization-specific local functions (if any)
local GetUnitChargedPowerPoints = GetUnitChargedPowerPoints

spec:RegisterResource( Enum.PowerType.Energy, {
    shadow_techniques = {
        last = function () return state.query_time end,
        interval = function () return state.time_to_sht[5] end,
        value = 7,
        stop = function () return state.time_to_sht[5] == 0 or state.time_to_sht[5] == 3600 end,
    }
} )

spec:RegisterResource( Enum.PowerType.ComboPoints )

-- Talents
spec:RegisterTalents( {

    -- Rogue
    acrobatic_strikes              = {  90752,  455143, 1 }, -- Auto-attacks increase auto-attack damage and movement speed by $s1% for $s2 sec, stacking up to $s3%
    airborne_irritant              = {  90741,  200733, 1 }, -- Blind has $s1% reduced cooldown, $s2% reduced duration, and applies to all nearby enemies
    alacrity                       = {  90751,  193539, 2 }, -- Your finishing moves have a $s1% chance per combo point to grant $s2% Haste for $s3 sec, stacking up to $s4 times
    atrophic_poison                = {  90763,  381637, 1 }, -- Coats your weapons with a Non-Lethal Poison that lasts for $s1 |$s2hour:hrs;. Each strike has a $s3% chance of poisoning the enemy, reducing their damage by $s4% for $s5 sec
    blackjack                      = {  90686,  379005, 1 }, --
    blind                          = {  90684,    2094, 1 }, -- Blinds all enemies near the target, causing them to wander disoriented for $s1 sec. Damage may interrupt the effect. Limit $s2
    cheat_death                    = {  90742,   31230, 1 }, -- Fatal attacks instead reduce you to $s1% of your maximum health. For $s2 sec afterward, you take $s3% reduced damage. Cannot trigger more often than once per $s4 min
    cloak_of_shadows               = {  90697,   31224, 1 }, -- Provides a moment of magic immunity, instantly removing all harmful spell effects. The cloak lingers, causing you to resist harmful spells for $s1 sec
    cold_blood                     = {  90748,  382245, 1 }, -- Increases the critical strike chance of your next damaging ability by $s1%
    deadened_nerves                = {  90743,  231719, 1 }, -- Physical damage taken reduced by $s1%
    deadly_precision               = {  90760,  381542, 1 }, -- Increases the critical strike chance of your attacks that generate combo points by $s1%
    deeper_stratagem               = {  90750,  193531, 1 }, -- Gain $s1 additional max combo point. Your finishing moves that consume more than $s2 combo points have increased effects, and your finishing moves deal $s3% increased damage
    echoing_reprimand              = {  90638,  470669, 1 }, -- After consuming a supercharged combo point, your next Backstab also strikes the target with an Echoing Reprimand dealing $s$s2 Physical damage
    elusiveness                    = {  90742,   79008, 1 }, -- Evasion also reduces damage taken by $s1%, and Feint also reduces non-area-of-effect damage taken by $s2%
    evasion                        = {  90764,    5277, 1 }, -- Increases your dodge chance by $s1% for $s2 sec
    featherfoot                    = {  94563,  423683, 1 }, -- Sprint increases movement speed by an additional $s1% and has $s2 sec increased duration
    fleet_footed                   = {  90762,  378813, 1 }, -- Movement speed increased by $s1%
    forced_induction               = {  90638,  470668, 1 }, -- Increase the bonus granted when a damaging finishing move consumes a supercharged combo point by $s1
    gouge                          = {  90741,    1776, 1 }, -- Gouges the eyes of an enemy target, incapacitating for $s1 sec. Damage may interrupt the effect. Must be in front of your target. Awards $s2 combo point
    graceful_guile                 = {  94562,  423647, 1 }, -- Feint has $s1 additional charge
    improved_ambush                = {  90692,  381620, 1 }, -- Shadowstrike generates $s1 additional combo point
    improved_sprint                = {  90746,  231691, 1 }, -- Reduces the cooldown of Sprint by $s1 sec
    improved_wound_poison          = {  90637,  319066, 1 }, -- Wound Poison can now stack $s1 additional times
    iron_stomach                   = {  90744,  193546, 1 }, -- Increases the healing you receive from Crimson Vial, healing potions, and healthstones by $s1%
    leeching_poison                = {  90758,  280716, 1 }, -- Adds a Leeching effect to your Lethal poisons, granting you $s1% Leech
    lethality                      = {  90749,  382238, 2 }, -- Critical strike chance increased by $s1%. Critical strike damage bonus of your attacks that generate combo points increased by $s2%
    master_poisoner                = {  90636,  378436, 1 }, -- Increases the non-damaging effects of your weapon poisons by $s1%
    nimble_fingers                 = {  90745,  378427, 1 }, -- Energy cost of Feint and Crimson Vial reduced by $s1
    numbing_poison                 = {  90763,    5761, 1 }, -- Coats your weapons with a Non-Lethal Poison that lasts for $s1 |$s2hour:hrs;. Each strike has a $s3% chance of poisoning the enemy, clouding their mind and slowing their attack and casting speed by $s4% for $s5 sec
    recuperator                    = {  90640,  378996, 1 }, -- Slice and Dice heals you for up to $s1% of your maximum health per $s2 sec
    rushed_setup                   = {  90754,  378803, 1 }, -- The Energy costs of Kidney Shot, Cheap Shot, Sap, and Distract are reduced by $s1%
    shadowheart                    = { 101714,  455131, 1 }, --
    shadowrunner                   = {  90687,  378807, 1 }, -- While Stealth or Shadow Dance is active, you move $s1% faster
    shiv                           = {  90740,    5938, 1 }, -- Attack with your off-hand, dealing $s$s2 Physical damage, dispelling all enrage effects and applying a concentrated form of your active Non-Lethal poison. Awards $s3 combo point
    soothing_darkness              = {  90691,  393970, 1 }, -- You are healed for $s1% of your maximum health over $s2 sec after activating Vanish
    stillshroud                    = {  94561,  423662, 1 }, --
    subterfuge                     = {  90688,  108208, 2 }, -- Abilities requiring Stealth can be used for $s1 sec after Stealth breaks. Combat benefits requiring Stealth persist for an additional $s2 sec after Stealth breaks
    supercharger                   = {  90639,  470347, 2 }, -- Symbols of Death supercharges $s1 combo point. Damaging finishing moves consume a supercharged combo point to function as if they spent $s2 additional combo points
    superior_mixture               = {  94567,  423701, 1 }, --
    thistle_tea                    = {  90756,  381623, 1 }, -- Restore $s1 Energy. Mastery increased by $s2% for $s3 sec. When your Energy is reduced below $s4, drink a Thistle Tea
    thrill_seeking                 = {  90695,  394931, 1 }, -- Shadowstep has $s1 additional charge
    tight_spender                  = {  90692,  381621, 1 }, -- Energy cost of finishing moves reduced by $s1%
    tricks_of_the_trade            = {  90686,   57934, 1 }, -- Redirects all threat you cause to the targeted party or raid member, beginning with your next damaging attack within the next $s1 sec and lasting $s2 |$s3hour:hrs;
    unbreakable_stride             = {  90747,  400804, 1 }, --
    vigor                          = {  90759,   14983, 2 }, -- Increases your maximum Energy by $s1 and Energy regeneration by $s2%
    virulent_poisons               = {  90760,  381543, 1 }, --
    without_a_trace                = { 101713,  382513, 1 }, -- Vanish has $s1 additional charge

    -- Subtlety
    cloaked_in_shadows             = {  90733,  382515, 1 }, --
    danse_macabre                  = {  90730,  382528, 1 }, -- Shadow Dance increases the damage of your attacks that generate or spend combo points by $s1%, increased by an additional $s2% for each different attack used
    dark_brew                      = {  90719,  382504, 1 }, --
    dark_shadow                    = {  90732,  245687, 2 }, -- Shadow Dance increases damage by an additional $s1%
    death_perception               = {  90706,  469642, 2 }, -- Symbols of Death has $s1 additional charge and increases damage by an additional $s2%
    deepening_shadows              = {  90724,  185314, 1 }, -- Your finishing moves reduce the remaining cooldown on Shadow Dance by $s1 sec per combo point spent
    deeper_daggers                 = {  90721,  382517, 1 }, -- Eviscerate and Black Powder increase your Shadow damage dealt by $s1% for $s2 sec
    double_dance                   = { 101715,  394930, 1 }, -- Shadow Dance has $s1 additional charge
    ephemeral_bond                 = {  90725,  426563, 1 }, -- Increases healing received by $s1%
    exhilarating_execution         = {  90711,  428486, 1 }, --
    fade_to_nothing                = {  90733,  382514, 1 }, -- Movement speed increased by $s1% and damage taken reduced by $s2% for $s3 sec after gaining Stealth, Vanish, or Shadow Dance
    finality                       = {  90720,  382525, 2 }, --
    find_weakness                  = {  90690,   91023, 1 }, -- Your Stealth abilities reveal a flaw in your target's defenses, causing all your attacks to bypass $s1% of that enemy's armor for $s2 sec
    flagellation                   = {  90718,  384631, 1 }, -- Lash the target for $s$s3 Shadow damage, causing each combo point spent within $s4 sec to lash for an additional $s$s5 Dealing damage with Flagellation increases your Mastery by $s6%, persisting $s7 sec after their torment fades
    gloomblade                     = {  90699,  200758, 1 }, -- Punctures your target with your shadow-infused blade for $s$s2 Shadow damage, bypassing armor. Critical strikes apply Find Weakness for $s3 sec. Awards $s4 combo point
    goremaws_bite                  = {  94581,  426591, 1 }, -- Lashes out at the target, inflicting $s$s2 Shadow damage and causing your next $s3 finishing moves to cost no Energy. Awards $s4 combo points
    improved_backstab              = {  90739,  319949, 1 }, -- Backstab has $s1% increased critical strike chance. When you are behind your target, Backstab critical strikes now also expose a flaw in their defenses, applying Find Weakness for $s2 sec
    improved_shadow_dance          = {  90734,  393972, 1 }, -- Shadow Dance has $s1 sec increased duration
    improved_shadow_techniques     = {  90736,  394023, 1 }, --
    improved_shuriken_storm        = {  90710,  319951, 1 }, -- Shuriken Storm has an additional $s1% chance to crit, and its critical strikes apply Find Weakness for $s2 sec
    inevitability                  = {  90704,  382512, 1 }, -- Backstab and Shadowstrike extend the duration of your Symbols of Death by $s1 sec
    lingering_shadow               = {  90731,  382524, 1 }, --
    master_of_shadows              = {  90735,  196976, 1 }, --
    night_terrors                  = {  94582,  277953, 1 }, --
    perforated_veins               = {  90707,  382518, 1 }, --
    planned_execution              = {  90703,  382508, 1 }, --
    premeditation                  = {  90737,  343160, 1 }, -- After entering Stealth, your next combo point generating ability generates full combo points
    quick_decisions                = {  90728,  382503, 1 }, --
    relentless_strikes             = {  90709,   58423, 1 }, -- Your finishing moves generate $s1 Energy per combo point spent
    replicating_shadows            = {  90717,  382506, 1 }, -- Rupture deals an additional $s1% damage as Shadow and applies to $s2 additional nearby enemy
    secret_stratagem               = {  90722,  394320, 1 }, -- Gain $s1 additional max combo point. Your finishing moves that consume more than $s2 combo points have increased effects, and your finishing moves deal $s3% increased damage
    secret_technique               = {  90715,  280719, 1 }, -- Finishing move that creates shadow clones of yourself. You and your shadow clones each perform a piercing attack on all enemies near your target, dealing Physical damage to the primary target and reduced damage to other targets. $s8 point : $s$s9 total damage $s10 points: $s$s11 total damage $s12 points: $s$s13 total damage $s14 points: $s$s15 total damage $s16 points: $s$s17 total damage $s18 points: $s$s19 total damage $s20 points: $s$s21 total damage Cooldown is reduced by $s22 sec for every combo point you spend
    shadow_blades                  = {  90726,  121471, 1 }, -- Draws upon surrounding shadows to empower your weapons, causing your attacks to deal $s1% additional damage as Shadow and causing your combo point generating abilities to generate full combo points for $s2 sec
    shadow_focus                   = {  90727,  108209, 1 }, --
    shadowcraft                    = {  94580,  426594, 1 }, -- While Symbols of Death is active, your Shadow Techniques triggers $s1% more frequently, stores $s2 additional combo point, and finishing moves can use those stored when there are enough to refresh full combo points
    shadowed_finishers             = {  90723,  382511, 1 }, -- Eviscerate and Black Powder deal an additional $s1% damage as Shadow to targets with your Find Weakness active
    shot_in_the_dark               = {  90698,  257505, 1 }, -- After entering Stealth or Shadow Dance, your next Cheap Shot is free
    shrouded_in_darkness           = {  90700,  382507, 1 }, -- Shroud of Concealment increases the movement speed of allies by $s1% and leaving its area no longer cancels the effect
    shuriken_tornado               = {  90716,  277925, 1 }, -- Focus intently, then release a Shuriken Storm every sec for the next $s1 sec
    silent_storm                   = {  90714,  385722, 1 }, --
    swift_death                    = {  90701,  394309, 1 }, -- Symbols of Death has $s1 sec reduced cooldown
    terrifying_pace                = {  94582,  428387, 1 }, --
    the_first_dance                = {  90735,  382505, 1 }, -- Remaining out of combat for $s1 sec increases the duration of your next Shadow Dance by $s2 sec
    the_rotten                     = {  90705,  382015, 1 }, -- After activating Symbols of Death, your next $s1 attacks that generate combo points deal $s2% increased damage and are guaranteed to critically strike
    veiltouched                    = {  90713,  382017, 1 }, --
    warning_signs                  = {  90703,  426555, 1 }, --
    weaponmaster                   = {  90738,  193537, 1 }, -- Backstab and Shadowstrike have a $s1% chance to hit the target twice each time they deal damage

    -- Deathstalker
    bait_and_switch                = {  95106,  457034, 1 }, --
    clear_the_witnesses            = {  95110,  457053, 1 }, -- Your next Shuriken Storm after applying Deathstalker's Mark deals an additional $s$s2 Plague damage and generates $s3 additional combo point
    corrupt_the_blood              = {  95108,  457066, 1 }, --
    darkest_night                  = {  95142,  457058, 1 }, -- When you consume the final Deathstalker's Mark from a target or your target dies, gain $s1 Energy and your next Eviscerate cast with maximum combo points is guaranteed to critically strike, deals $s2% additional damage, and applies $s3 stacks of Deathstalker's Mark to the target
    deathstalkers_mark             = {  95136,  457052, 1 }, -- Shadowstrike from Stealth or Shadow Dance applies $s2 stacks of Deathstalker's Mark to your target. When you spend $s3 or more combo points on attacks against a Marked target you consume an application of Deathstalker's Mark, dealing $s$s4 Plague damage and increasing the damage of your next Backstab or Shadowstrike by $s5%. You may only have one target Marked at a time
    ethereal_cloak                 = {  95106,  457022, 1 }, --
    fatal_intent                   = {  95135,  461980, 1 }, --
    follow_the_blood               = {  95131,  457068, 1 }, --
    hunt_them_down                 = {  95132,  457054, 1 }, --
    lingering_darkness             = {  95109,  457056, 1 }, -- After Shadow Blades expires, gain $s1 sec of $s2% increased Shadow damage
    momentum_of_despair            = {  95131,  457067, 1 }, --
    shadewalker                    = {  95123,  457057, 1 }, --
    shroud_of_night                = {  95123,  457063, 1 }, --
    singular_focus                 = {  95117,  457055, 1 }, --
    symbolic_victory               = {  95109,  457062, 1 }, --

    -- Trickster
    cloud_cover                    = {  95116,  441429, 1 }, --
    coup_de_grace                  = {  95115,  441423, 1 }, -- After $s1 strikes with Unseen Blade, your next Eviscerate will be performed as a Coup de Grace, functioning as if it had consumed $s2 additional combo points. If the primary target is Fazed, gain $s3 stacks of Flawless Form
    devious_distractions           = {  95133,  441263, 1 }, -- Secret Technique applies Fazed to any targets struck
    disorienting_strikes           = {  95118,  441274, 1 }, -- Secret Technique has $s1% reduced cooldown and allows your next $s2 strikes of Unseen Blade to ignore its cooldown
    dont_be_suspicious             = {  95134,  441415, 1 }, --
    flawless_form                  = {  95111,  441321, 1 }, -- Unseen Blade and Secret Technique increase the damage of your finishing moves by $s1% for $s2 sec. Multiple applications may overlap
    flickerstrike                  = {  95137,  441359, 1 }, --
    mirrors                        = {  95141,  441250, 1 }, --
    nimble_flurry                  = {  95128,  441367, 1 }, -- Your auto-attacks, Backstab, Shadowstrike, and Eviscerate also strike up to $s1 additional nearby targets for $s2% of normal damage while Flawless Form is active
    no_scruples                    = {  95116,  441398, 1 }, -- Finishing moves have $s1% increased chance to critically strike Fazed targets
    smoke                          = {  95141,  441247, 1 }, -- You take $s1% reduced damage from Fazed targets
    so_tricky                      = {  95134,  441403, 1 }, -- Tricks of the Trade's threat redirect duration is increased to $s1 hour
    surprising_strikes             = {  95121,  441273, 1 }, -- Attacks that generate combo points deal $s1% increased critical strike damage to Fazed targets
    thousand_cuts                  = {  95137,  441346, 1 }, -- Slice and Dice grants $s1% additional attack speed and gives your auto-attacks a chance to refresh your opportunity to strike with Unseen Blade
    unseen_blade                   = {  95140,  441146, 1 }, -- Backstab and Shadowstrike now also strike with an Unseen Blade dealing $s1 damage. Targets struck are Fazed for $s2 sec. Fazed enemies take $s3% more damage from you and cannot parry your attacks. This effect may occur once every $s4 sec
} )

-- PvP Talents
spec:RegisterPvpTalents( {
    control_is_king                = 5529, -- (354406)
    dagger_in_the_dark             =  846, -- (198675)
    death_from_above               = 3462, -- (269513) Finishing move that empowers your weapons with energy to perform a deadly attack. You leap into the air and Eviscerate your target on the way back down, with such force that it has a $s1% stronger effect
    dismantle                      = 5406, -- (207777) Disarm the enemy, preventing the use of any weapons or shield for $s1 sec
    distracting_mirage             = 5411, -- (354661)
    maneuverability                = 3447, -- (197000)
    preemptive_maneuver            = 5698, -- (1219122)
    silhouette                     =  856, -- (197899)
    smoke_bomb                     = 1209, -- (359053)
    thick_as_thieves               = 5409, -- (221622)
    thiefs_bargain                 =  146, -- (354825)
} )

-- Auras
spec:RegisterAuras( {
    -- Disoriented.
    blind = {
        id = 2094,
        duration = function() return 60 * ( talent.airborne_irritant.enabled and 0.6 or 1 ) end,
        max_stack = 1
    },
    darkest_night = {
        id = 457280,
        duration = 30,
        max_stack = 1
    },
    danse_macabre = {
        id = 393969,
        duration = function () return talent.subterfuge.enabled and 9 or 8 end,
        max_stack = 10
    },
    deeper_daggers = {
        id = 383405,
        duration = 8,
        max_stack = 1,
        copy = 341550 -- Conduit version.
    },
    exhilarating_execution = {
        id = 428488,
        duration = 10,
        max_stack = 1
    },
    fade_to_nothing = {
        id = 386237,
        duration = 8,
        max_stack = 1
    },
    finality_black_powder = {
        id = 385948,
        duration = 30,
        max_stack = 1
    },
    finality_eviscerate = {
        id = 385949,
        duration = 30,
        max_stack = 1
    },
    finality_rupture = {
        id = 385951,
        duration = 30,
        max_stack = 1
    },
    flagellation = {
        id = 323654,
        duration = 12,
        max_stack = 30
    },
    flagellation_buff = {
        id = 384631,
        duration = 12,
        max_stack = 30
    },
    flagellation_persist = {
        id = 394758,
        duration = 12,
        max_stack = 30,
        copy = 345569
    },
    -- Your finishing moves cost no Energy.
    goremaws_bite = {
        id = 426593,
        duration = 30,
        max_stack = 3
    },
    lingering_darkness = {
        id = 457273,
        duration = 30,
        max_stack = 1
    },
    -- Talent: $?s200758[Gloomblade][Backstab] deals an additional $s1% damage as Shadow.
    -- https://wowhead.com/beta/spell=385960
    lingering_shadow = {
        id = 385960,
        duration = 18,
        tick_time = 1,
        max_stack = 50
    },
    master_of_shadows = {
        id = 196980,
        duration = 3,
        max_stack = 1
    },
    perforated_veins = {
        id = 394254,
        duration = 3600,
        max_stack = 4
    },
    poised_shadows = {
        id = 455573,
        duration = 30,
        max_stack = 1
    },
    premeditation = {
        id = 343173,
        duration = 3600,
        max_stack = 1
    },
    secret_technique = {
        duration = 1.3,
        max_stack = 1,
        generate = function( t )
            local applied = action.secret_technique.lastCast
            local expires = applied + 1.3

            if query_time < expires then
                t.name = t.name or GetSpellInfo( 280719 ) or "secret_technique"
                t.count = 1
                t.applied = applied
                t.duration = 1.3
                t.expires = expires
                t.caster = "player"
                return
            end

            t.name = t.name or GetSpellInfo( 280719 ) or "secret_technique"
            t.count = 0
            t.applied = 0
            t.duration = 1.3
            t.expires = 0
            t.caster = "nobody"
        end
    },
    -- Talent: Combo point generating abilities generate $s2 additional combo point and deal $s1% additional damage as Shadow.
    -- https://wowhead.com/beta/spell=121471
    shadow_blades = {
        id = 121471,
        duration = 16,
        max_stack = 1
    },
    shadow_dance = {
        id = 185422,
        duration = function() return 6 + ( talent.improved_shadow_dance.rank * 2 ) + ( buff.first_dance.up and 4 or 0 ) end,
        max_stack = 1,
        copy = 185313
    },
    shadow_techniques = {
        id = 196911,
        duration = 3600,
        max_stack = 14
    },
    shot_in_the_dark = {
        id = 257506,
        duration = 3600,
        max_stack = 1
    },
    -- Talent: Releasing a Shuriken Storm every sec.
    -- https://wowhead.com/beta/spell=277925
    shuriken_tornado = {
        id = 277925,
        duration = 4,
        max_stack = 1
    },
    silent_storm = {
        id = 385727,
        duration = 3600,
        max_stack = 1
    },
    subterfuge = {
        id = 115192,
        duration = function() return 3 * talent.subterfuge.rank end,
        max_stack = 1
    },
    supercharged_combo_points = {
        -- todo: Find a way to find a true buff / ID for this as a failsafe? Currently fully emulated.
        duration = 3600,
        max_stack = function() return combo_points.max end,
        copy = { "supercharge", "supercharged", "supercharger" }
    },
    symbols_of_death = {
        id = 212283,
        duration = 10,
        max_stack = 1
    },
    the_first_dance_prep = {
        id = 470677,
        duration = 6,
        max_stack = 1,
        copy = "first_dance_prep"
    },
    -- Talent: Your next Shadowstrike or $?s200758[Gloomblade][Backstab] deals $s3% increased damage, generates $s1 additional combo points, and is guaranteed to critically strike.
    -- https://wowhead.com/beta/spell=394203
    the_first_dance = {
        id = 470678,
        duration = 3600,
        max_stack = 1,
        copy = "first_dance"
    },
    the_rotten = {
        id = 394203,
        duration = 30,
        max_stack = 1,
        copy = 341134
    },

    -- Azerite Powers
    blade_in_the_shadows = {
        id = 279754,
        duration = 60,
        max_stack = 10
    },
    nights_vengeance = {
        id = 273424,
        duration = 8,
        max_stack = 1
    },
    perforate = {
        id = 277720,
        duration = 12,
        max_stack = 1
    },
    replicating_shadows = {
        id = 286131,
        duration = 1,
        max_stack = 50
    },

    -- Conduit
    perforated_veins_conduit = {
        id = 341572,
        duration = 12,
        max_stack = 6
    },

    -- Legendaries (Shadowlands)
    deathly_shadows = {
        id = 341202,
        duration = 15,
        max_stack = 1
    },
    master_assassins_mark = {
        id = 340094,
        duration = 4,
        max_stack = 1
    },
} )

local true_stealth_change, emu_stealth_change = 0, 0
local last_mh, last_oh, last_shadow_techniques, swings_since_sht, sht = 0, 0, 0, 0, {} -- Shadow Techniques
local danse_ends, danse_macabre_actual = 0, {}

spec:RegisterEvent( "UPDATE_STEALTH", function ()
    true_stealth_change = GetTime()
end )

spec:RegisterCombatLogEvent( function( _, subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName, _, amount, interrupt, a, b, c, d, offhand, multistrike )
    if not sourceGUID == state.GUID then return end

    if subtype == "SPELL_ENERGIZE" and spellID == 196911 then
        last_shadow_techniques = GetTime()
        swings_since_sht = 0

    elseif subtype:sub( 1, 5 ) == "SWING" and not multistrike then
        if subtype == "SWING_MISSED" then
            offhand = spellName
        end

        local now = GetTime()

        if now > last_shadow_techniques + 3 then
            swings_since_sht = swings_since_sht + 1
        end

        if offhand then last_mh = GetTime()
        else last_mh = GetTime() end
    end

    if state.talent.danse_macabre.enabled and subtype == "SPELL_CAST_SUCCESS" then
        if spellID == 185313 then
            -- Start fresh with each Shadow Dance.
            wipe( danse_macabre_actual )
            danse_ends = GetTime() + 8

        elseif danse_ends > GetTime() then
            local ability = class.abilities[ spellName ] -- use spellName to capture spellID variants

            if ability then
                danse_macabre_actual[ ability.key ] = true
            end
        end
    end
end )

spec:RegisterStateTable( "time_to_sht", setmetatable( {}, {
    __index = function( t, k )
        local n = tonumber( k )
        n = n - ( n % 1 )

        if not n or n > 5 then return 3600 end

        if n <= swings_since_sht then return 0 end

        local mh_speed = swings.mainhand_speed
        local mh_next = ( swings.mainhand > now - 3 ) and ( swings.mainhand + mh_speed ) or now + ( mh_speed * 0.5 )

        local oh_speed = swings.offhand_speed
        local oh_next = ( swings.offhand > now - 3 ) and ( swings.offhand + oh_speed ) or now

        table.wipe( sht )

        if mh_speed and mh_speed > 0 then
            for i = 1, 4 do
                insert( sht, mh_next + ( i * mh_speed ) )
            end
        end

        if oh_speed and oh_speed > 0 then
            for i = 1, 4 do
                insert( sht, oh_next + ( i * oh_speed ) )
            end
        end

        local i = 1

        while( sht[i] ) do
            if sht[i] < last_shadow_techniques + 3 then
                table.remove( sht, i )
            else
                i = i + 1
            end
        end

        if #sht > 0 and n - swings_since_sht < #sht then
            table.sort( sht )
            return max( 0, sht[ n - swings_since_sht ] - query_time )
        else
            return 3600
        end
    end
} ) )

spec:RegisterStateTable( "time_to_sht_plus", setmetatable( {}, {
    __index = function( t, k )
        local n = tonumber( k )
        n = n - ( n % 1 )

        if not n or n > 5 then return 3600 end
        local val = time_to_sht[k]

        -- Time of next attack instead.
        if val == 0 then
            local last = swings.mainhand
            local speed = swings.mainhand_speed
            local swing = 3600

            if last > 0 and speed > 0 then
                swing = last + ( ceil( ( query_time - last ) / speed ) * speed ) - query_time
            end

            last = swings.offhand
            speed = swings.offhand_speed

            if last > 0 and speed > 0 then
                swing = min( swing, last + ( ceil( ( query_time - last ) / speed ) * speed ) - query_time )
            end

            return swing
        end

        return val
    end,
} ) )

spec:RegisterStateExpr( "bleeds", function ()
    return ( debuff.garrote.up and 1 or 0 ) + ( debuff.rupture.up and 1 or 0 )
end )

spec:RegisterStateExpr( "cp_max_spend", function ()
    return combo_points.max
end )

spec:RegisterStateExpr( "effective_combo_points", function ()
    local c = combo_points.current or 0
    if not talent.coup_de_grace.enabled and not talent.supercharger.enabled and not covenant.kyrian then return c end

    if c > 0 and buff.supercharged_combo_points.up then
        c = c + ( talent.forced_induction.enabled and 3 or 2 )
    end

    if talent.coup_de_grace.enabled and this_action == "coup_de_grace" and buff.coup_de_grace.up then c = c + 5 end
    return c
end )

spec:RegisterHook( "spend", function( amt, resource )
    if amt > 0 and resource == "combo_points" then
        if talent.relentless_strikes.enabled and amt > 0 then
            gain( 5 * effective_combo_points, "energy" )
        end

        if effective_combo_points > 4 and debuff.deathstalkers_mark.up then
            removeDebuffStack( "target", "deathstalkers_mark" )
            if debuff.deathstalkers_mark.down and talent.darkest_night.enabled then
                    gain( 40, "energy" )
                    applyBuff( "darkest_night" )
                end
            applyBuff( "deathstalkers_mark_buff" )
        end

        if talent.alacrity.rank > 1 and effective_combo_points > 9 then addStack( "alacrity" ) end
        if talent.secret_technique.enabled then reduceCooldown( "secret_technique", amt ) end
        if talent.deepening_shadows.enabled then reduceCooldown( "shadow_dance", amt * effective_combo_points ) end
        if talent.supercharger.enabled and buff.supercharged_combo_points.up then removeStack( "supercharged_combo_points" ) end

        -- Legacy
        if legendary.obedience.enabled and buff.flagellation_buff.up then reduceCooldown( "flagellation", amt ) end
    end
end )

local Shadowcraft = setfenv( function ()

    if buff.shadow_techniques.stack >= combo_points.max then
        gain( combo_points.max, "combo_points" )
        removeStack( "shadow_techniques", combo_points.max )
    end

end, state )

local function st_gain( token )
    local amount = action[ token ].cp_gain
    local st_addl_gain = max( 0, min( combo_points.deficit - amount, buff.shadow_techniques.stack ) )

    if st_addl_gain > 0 then
        removeStack( "shadow_techniques", st_addl_gain )
        amount = amount + st_addl_gain
    end

    gain( amount, "combo_points" )
end

setfenv( st_gain, state )
-- spec:RegisterHook( "spendResources", comboSpender )

spec:RegisterStateExpr( "mantle_duration", function()
    if stealthed.mantle then
        return cooldown.global_cooldown.remains + buff.master_assassins_initiative.duration
    elseif buff.master_assassins_initiative.up then
        return buff.master_assassins_initiative.remains
    end
    return 0
end )

spec:RegisterStateExpr( "ssw_refund_offset", function()
    return target.maxR
end )

spec:RegisterStateExpr( "master_assassin_remains", function ()
    if not legendary.mark_of_the_master_assassin.enabled then return 0 end

    if stealthed.mantle then return cooldown.global_cooldown.remains + 4
    elseif buff.master_assassins_mark.up then return buff.master_assassins_mark.remains end
    return 0
end )

-- We need to break stealth when we start combat from an ability.
spec:RegisterHook( "runHandler", function( ability )
    local a = class.abilities[ ability ]

    if stealthed.mantle and ( not a or a.startsCombat ) then
        if talent.subterfuge.enabled then
            applyBuff( "subterfuge" )
        end

        if legendary.mark_of_the_master_assassin.enabled then
            applyBuff( "master_assassins_mark" )
        end

        if buff.stealth.up then
            setCooldown( "stealth", 2 )
        end

        removeBuff( "stealth" )
        removeBuff( "vanish" )
        removeBuff( "shadowmeld" )
    end

    if buff.shadow_dance.up and talent.danse_macabre.enabled and not danse_macabre_tracker[ a.key ] then
        danse_macabre_tracker[ a.key ] = true
        addStack( "danse_macabre" )
    end

    if buff.cold_blood.up and ( not a or a.startsCombat ) then
        removeBuff( "cold_blood" )
    end

    class.abilities.apply_poison = class.abilities[ action.apply_poison_actual.next_poison ]
end )

local ExpireSepsis = setfenv( function ()
    applyBuff( "sepsis_buff" )

    if legendary.toxic_onslaught.enabled then
        applyBuff( "adrenaline_rush", 10 )
        applyDebuff( "target", "vendetta", 10 )
    end
end, state )

local TriggerLingeringDarkness = setfenv( function ()
    applyBuff( "lingering_darkness" )
end, state )

local TriggerLingeringShadow = setfenv( function ()
    applyBuff( "lingering_shadow" )
end, state )

spec:RegisterStateTable( "danse_macabre_tracker", setmetatable( {}, {
    __index = function( t, k )
        return false
    end,
} ) )

spec:RegisterStateExpr( "used_for_danse", function()
    if not talent.danse_macabre.enabled or buff.shadow_dance.down then return false end
    return danse_macabre_tracker[ this_action ]
end )

spec:RegisterHook( "reset_precast", function( amt, resource )

    -- Supercharged Combo Point handling
    local cPoints = GetUnitChargedPowerPoints( "player" )
    if talent.supercharger.enabled and cPoints then
        local charged = 0
        for _, point in pairs( cPoints ) do
            charged = charged + 1
        end
        if charged > 0 then applyBuff( "supercharged_combo_points", nil, charged ) end
    end

    if talent.danse_macabre.enabled then
        wipe( danse_macabre_tracker )
        if buff.shadow_dance.up then
            for k in pairs( danse_macabre_actual ) do
                danse_macabre_tracker[ k ] = true
            end
        end
        if Hekili.ActiveDebug then
            Hekili:Debug( "Danse Tracker @ Reset:" )
            for k, v in pairs( danse_macabre_tracker ) do
                Hekili:Debug( "  " .. k .. " = " .. tostring( v ) )
            end
        end
    end

    if debuff.sepsis.up then
        state:QueueAuraExpiration( "sepsis", ExpireSepsis, debuff.sepsis.expires )
    end

    if buff.shuriken_tornado.up then
        if prev_gcd[1].shuriken_tornado then
            class.abilities.shuriken_storm.handler()
            if buff.shadow_dance.up and talent.danse_macabre.enabled and not danse_macabre_tracker.shuriken_storm then
                danse_macabre_tracker.shuriken_storm = true
            end
        end
        local moment = buff.shuriken_tornado.expires - 0.02
        while( moment > query_time ) do
            state:QueueAuraEvent( "shuriken_tornado", class.abilities.shuriken_storm.handler, moment, "AURA_PERIODIC" )
            moment = moment - 1
        end
    end

    class.abilities.apply_poison = class.abilities[ action.apply_poison_actual.next_poison ]

    if buff.cold_blood.up then setCooldown( "cold_blood", action.cold_blood.cooldown ) end

    if talent.lingering_darkness.enabled and buff.shadow_blades.up then
        state:QueueAuraEvent( "lingering_darkness", TriggerLingeringDarkness, buff.shadow_blades.expires, "AURA_EXPIRATION" )
    end

    if talent.lingering_shadow.enabled and buff.shadow_dance.up then
        state:QueueAuraEvent( "lingering_shadow", TriggerLingeringShadow, buff.shadow_dance.expires, "AURA_EXPIRATION" )
    end

    if buff.first_dance_prep.up then
        applyBuff( "first_dance" )
        buff.first_dance.applied = query_time + buff.first_dance_prep.remains
    end

    if prev_gcd[1].coup_de_grace then removeBuff( "coup_de_grace" ); removeBuff( "escalating_blade" ) end
    if buff.escalating_blade.stack == 4 then applyBuff( "coup_de_grace" ); removeBuff( "escalating_blade" ) end
end )

spec:RegisterHook( "step", function()
    if Hekili.ActiveDebug then
        Hekili:Debug( "Danse Tracker @ Step:" )
        for k, v in pairs( danse_macabre_tracker ) do
            Hekili:Debug( "  " .. k .. " = " .. tostring( v ) )
        end
    end
end )

spec:RegisterUnitEvent( "UNIT_POWER_UPDATE", "player", nil, function( event, unit, resource )
    if resource == "COMBO_POINTS" then
        Hekili:ForceUpdate( event, true )
    end
end )

spec:RegisterGear({
    -- The War Within
    tww3 = {
        items = { 237667, 237665, 237663, 237664, 237662 },
        auras = {
            deaths_study = {
                id = 1239232,
                duration = spec.auras.symbols_of_death.duration,
                max_stack = 1
            },
            tww3_trickster_4pc = {
                -- id = 999998,
                duration = 5,
                max_stack = 1,
                generate = function( t )
                    local cdg = buff.coup_de_grace
                    if set_bonus.tww3 >= 4 and cdg.up and cdg.remains <= 10 then
                        -- Only treat this as the "trickster window" version if it's the 5s duration .. use 10s just as a safety net. The other version of the aura is 3600
                        t.name = "tww3_trickster_4pc"
                        t.count = 1
                        t.expires = cdg.expires
                        t.applied = cdg.expires - 5
                        t.caster = "player"
                    else
                        t.name = "tww3_trickster_4pc"
                        t.count = 0
                        t.expires = 0
                        t.applied = 0
                        t.caster = "nobody"
                    end
                end
            }
        }
    },
    tww2 = {
        items = { 229290, 229288, 229289, 229287, 229292 },
        auras = {
            -- 2-set
            -- https://www.wowhead.com/spell=1218439
            winning_streak = {
                id = 121843,
                duration = 3600,
                max_stack = 8
            }
        }
    },
    tww1 = {
        items = { 212039, 212037, 212041, 212038, 212036 }
    },
    -- Dragonflight
    tier31 = {
        items = { 207234, 207235, 207236, 207237, 207239, 217208, 217210, 217206, 217207, 217209 }
    },
    tier30 = {
        items = { 202500, 202498, 202497, 202496, 202495 }
    },
    tier29 = {
        items = { 200369, 200371, 200372, 200373, 200374 },
        auras = {
            honed_blades = {
                id = 394894,
                duration = 15,
                max_stack = 7
            },
            masterful_finish = {
                id = 395003,
                duration = 3,
                max_stack = 1
            }
        }
    },

    -- Legion / Old Sets / Other
    tier21 = {
        items = { 152163, 152165, 152161, 152160, 152162, 152164 }
    },
    tier20 = {
        items = { 147172, 147174, 147170, 147169, 147171, 147173 }
    },
    tier19 = {
        items = { 138332, 138338, 138371, 138326, 138329, 138335 }
    },

    mantle_of_the_master_assassin = {
        items = { 144236 },
        auras = {
            master_assassins_initiative = {
                id = 235027,
                duration = 5
            }
        }
    },
    shadow_satyrs_walk = {
        items = { 137032 }
    },
    soul_of_the_shadowblade = {
        items = { 150936 }
    },
    the_dreadlords_deceit = {
        items = { 137021 },
        auras = {
            the_dreadlords_deceit = {
                id = 228224,
                duration = 3600,
                max_stack = 20,
                copy = 208693
            }
        }
    },
    the_first_of_the_dead = {
        items = { 151818 },
        auras = {
            the_first_of_the_dead = {
                id = 248210,
                duration = 2
            }
        }
    },
    will_of_valeera = {
        items = { 137069 },
        auras = {
            will_of_valeera = {
                id = 208403,
                duration = 5
            }
        }
    },
    insignia_of_ravenholdt = {
        items = { 137049 }
    },
    cinidaria_the_symbiote = {
        items = { 133976 }
    },
    denial_of_the_halfgiants = {
        items = { 137100 }
    }
} )

-- Abilities
spec:RegisterAbilities( {
    -- Stab the target, causing 632 Physical damage. Damage increased by 20% when you are behind your target, and critical strikes apply Find Weakness for 10 sec. Awards 1 combo point.
    backstab = {
        id = 53,
        cast = 0,
        cooldown = 0,
        gcd = "totem",
        school = "physical",

        spend = function () return 40 * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 ) end,
        spendType = "energy",

        startsCombat = true,
        notalent = "gloomblade",

        cp_gain = function ()
            if buff.shadow_blades.up or buff.premeditation.up then return combo_points.max end
            return 1
        end,

        used_for_danse = function()
            if not talent.danse_macabre.enabled or buff.shadow_dance.down then return false end
            return danse_macabre_tracker.backstab
        end,

        handler = function ()

            if talent.perforated_veins.enabled then
                if buff.perforated_veins.stack < 4 then
                    addStack( "perforated_veins" )
                else removeBuff( "perforated_veins" )
                end
            end

            if buff.the_rotten.up and talent.improved_backstab.enabled then
                removeStack( "the_rotten" )
                applyDebuff( "target", "find_weakness" )
            end

            if talent.inevitability.enabled and buff.symbols_of_death.up then
                buff.symbols_of_death.expires = buff.symbols_of_death.expires + 0.5
            end

            st_gain( "backstab" )

            removeBuff( "premeditation" )
            removeBuff( "the_rotten" )
            removeBuff( "honed_blades" )

            if azerite.perforate.enabled and buff.perforate.up then
                -- We'll assume we're attacking from behind if we've already put up Perforate once.
                addStack( "perforate" )
                gainChargeTime( "shadow_blades", 0.5 )
            end
        end,

        bind = "gloomblade"
    },

    -- Talent: Finishing move that launches explosive Black Powder at all nearby enemies dealing Physical damage. Deals reduced damage beyond 8 targets. All nearby targets with your Find Weakness suffer an additional 20% damage as Shadow. 1 point : 135 damage 2 points: 271 damage 3 points: 406 damage 4 points: 541 damage 5 points: 676 damage 6 points: 812 damage
    black_powder = {
        id = 319175,
        cast = 0,
        cooldown = 0,
        gcd = "totem",
        school = "physical",

        spend = function ()
            if buff.goremaws_bite.up then return 0 end
            return 35 * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 )
        end,
        spendType = "energy",

        startsCombat = true,

        usable = function () return combo_points.current > 0, "requires combo_points" end,

        used_for_danse = function()
            if not talent.danse_macabre.enabled or buff.shadow_dance.down then return false end
            return danse_macabre_tracker.black_powder
        end,

        handler = function ()
            removeBuff( "masterful_finish" )

            if talent.symbolic_victory.enabled and buff.symbolic_victory.up then removeBuff( "symbolic_victory" ) end

            if buff.finality_black_powder.up then removeBuff( "finality_black_powder" )
            elseif talent.finality.enabled then applyBuff( "finality_black_powder" ) end

            if set_bonus.tier29_2pc > 0 then applyBuff( "honed_blades", nil, effective_combo_points ) end

            spend( combo_points.current, "combo_points" )
            if talent.shadowcraft.enabled and buff.symbols_of_death.up then Shadowcraft() end

            if talent.deeper_daggers.enabled or conduit.deeper_daggers.enabled then applyBuff( "deeper_daggers" ) end
        end
    },

    -- Stuns the target for 4 sec. Awards 1 combo point.
    cheap_shot = {
        id = 1833,
        cast = 0,
        cooldown = 0,
        gcd = "totem",
        school = "physical",

        spend = function ()
            if buff.shot_in_the_dark.up then return 0 end
            return 40 * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 ) * ( 1 + conduit.rushed_setup.mod * 0.01 )
        end,
        spendType = "energy",

        startsCombat = true,
        nodebuff = "cheap_shot",

        usable = function ()
            if boss then return false, "cheap_shot assumed unusable in boss fights" end
            return stealthed.all, "not stealthed"
        end,

        cp_gain = function()
            if buff.shadow_blades.up or buff.premeditation.up then return combo_points.max end
            return 1
        end,

        handler = function ()
            applyDebuff( "target", "find_weakness" )
            applyDebuff( "target", "cheap_shot" )
            removeBuff( "shot_in_the_dark" )

            st_gain( "cheap_shot" )
            removeBuff( "premeditation" )

            if buff.the_rotten.up then removeStack( "the_rotten" ) end
        end
    },

    -- Finishing move that disembowels the target, causing damage per combo point. Targets with Find Weakness suffer an additional 20% damage as Shadow. 1 point : 273 damage 2 points: 546 damage 3 points: 818 damage 4 points: 1,091 damage 5 points: 1,363 damage 6 points: 1,636 damage
    eviscerate = {
        id = 196819,
        cast = 0,
        cooldown = 0,
        gcd = "totem",
        school = "physical",

        spend = function ()
            if buff.goremaws_bite.up then return 0 end
            return 35 * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 )
        end,
        spendType = "energy",

        startsCombat = true,
        usable = function () return combo_points.current > 0, "requires combo points" end,
        nobuff = "coup_de_grace",
        texture = 132292,

        used_for_danse = function()
            if not talent.danse_macabre.enabled or buff.shadow_dance.down then return false end
            return danse_macabre_tracker.eviscerate
        end,

        handler = function ()
            removeBuff( "masterful_finish" )
            removeBuff( "nights_vengeance" )

            if buff.finality_eviscerate.up then removeBuff( "finality_eviscerate" )
            elseif talent.finality.enabled then applyBuff( "finality_eviscerate" ) end

            if buff.darkest_night.up and combo_points.deficit == 0 then
                applyDebuff( "target", "deathstalkers_mark", nil, debuff.deathstalkers_mark.stack + 3 )
            end

            if talent.symbolic_victory.enabled and buff.symbolic_victory.up then removeBuff( "symbolic_victory" ) end

            if set_bonus.tier29_2pc > 0 then applyBuff( "honed_blades", nil, effective_combo_points ) end

            if buff.slice_and_dice.up then
                buff.slice_and_dice.expires = buff.slice_and_dice.expires + effective_combo_points * 3
            else applyBuff( "slice_and_dice", effective_combo_points * 3 ) end

            spend( combo_points.current, "combo_points" )
            if talent.shadowcraft.enabled and buff.symbols_of_death.up then Shadowcraft() end

            if talent.deeper_daggers.enabled or conduit.deeper_daggers.enabled then applyBuff( "deeper_daggers" ) end
        end,

        bind = "coup_de_grace",
        copy = { 196819, 328082 }
    },

    -- Finishing move that disembowels the target, causing damage per combo point. Targets with Find Weakness suffer an additional 20% damage as Shadow. 1 point : 273 damage 2 points: 546 damage 3 points: 818 damage 4 points: 1,091 damage 5 points: 1,363 damage 6 points: 1,636 damage
    coup_de_grace = {
        id = 441776,
        known = 196819,
        cast = 0,
        cooldown = 0,
        gcd = "totem",
        school = "physical",

        spend = function ()
            if buff.goremaws_bite.up then return 0 end
            return 35 * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 )
        end,
        spendType = "energy",

        startsCombat = true,
        usable = function () return combo_points.current > 0, "requires combo points" end,
        buff = "coup_de_grace",
        texture = 5927656,

        used_for_danse = function()
            if not talent.danse_macabre.enabled or buff.shadow_dance.down then return false end
            return danse_macabre_tracker.eviscerate
        end,

        handler = function ()
            if debuff.fazed.up then addStack( "flawless_form", nil, 5 ) end

            if set_bonus.tww3 >= 4 and buff.tww3_trickster_4pc.down  then
                applyBuff( "coup_de_grace", 5 ) -- recast within 5 seconds
                applyBuff( "tww3_trickster_4pc" )
                applyBuff( "escalating_blade", 5, 4 )
            else
                removeBuff( "coup_de_grace" )
                removeBuff( "escalating_blade" )
                removeBuff( "tww3_trickster_4pc" )
            end

            class.abilities.eviscerate.handler()
        end,

        bind = "eviscerate"
    },

    -- TODO: Does Flagellation generate combo points with Shadow Blades?
    flagellation = {
        id = function() return talent.flagellation.enabled and 384631 or 323654 end,
        cast = 0,
        cooldown = 90,
        gcd = "spell",

        spend = 0,
        spendType = "energy",

        startsCombat = true,
        texture = 6035318,

        toggle = "cooldowns",

        indicator = function ()
            if settings.cycle and args.cycle_targets == 1 and active_enemies > 1 and target.time_to_die < longest_ttd then
                return "cycle"
            end
        end,

        handler = function ()
            applyBuff( talent.flagellation.enabled and "flagellation_buff" or "flagellation" )
            applyDebuff( "target", "flagellation" )
        end,

        copy = { 384631, 323654 }
    },

    -- Talent: Punctures your target with your shadow-infused blade for 760 Shadow damage, bypassing armor. Critical strikes apply Find Weakness for 10 sec. Awards 1 combo point.
    gloomblade = {
        id = 200758,
        cast = 0,
        cooldown = 0,
        gcd = "totem",
        school = "shadow",

        spend = function ()
            return 40 * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 )
        end,
        spendType = "energy",

        talent = "gloomblade",
        startsCombat = true,

        cp_gain = function()
            if buff.shadow_blades.up or buff.premeditation.up then return combo_points.max
            else return 1 end
        end,

        handler = function ()
            st_gain( "gloomblade" )
            removeBuff( "premeditation" )

            if buff.the_rotten.up then removeStack( "the_rotten" ) end
        end,

        bind = "backstab"
    },

    -- Lashes out at the target, inflicting $426592s1 Shadow damage and causing your next $426593u finishing moves to cost no Energy.; Awards $220901s1 combo $lpoint:points;.
    goremaws_bite = {
        id = 426591,
        cast = 0,
        cooldown = 45,
        gcd = "totem",

        spend = function() return 25  * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 ) end,
        spendType = "energy",

        talent = "goremaws_bite",
        startsCombat = true,

        cp_gain = function()
            if buff.shadow_blades.up or buff.premeditation.up then return combo_points.max end
            return 3
        end,

        handler = function()
            st_gain( "goremaws_bite" )
            removeBuff( "premeditation" )

            applyBuff( "goremaws_bite" )
            if buff.the_rotten.up then removeStack( "the_rotten" ) end
        end
    },

    -- Talent: Finishing move that creates shadow clones of yourself. You and your shadow clones each perform a piercing attack on all enemies near your target, dealing Physical damage to the primary target and reduced damage to other targets. 1 point : 692 total damage 2 points: 1,383 total damage 3 points: 2,075 total damage 4 points: 2,767 total damage 5 points: 3,458 total damage 6 points: 4,150 total damage Cooldown is reduced by 1 sec for every combo point you spend.
    secret_technique = {
        id = 280719,
        cast = 0,
        cooldown = 60,
        gcd = "totem",
        school = "physical",

        spend = function ()
            if buff.goremaws_bite.up then return 0 end
            return 30 * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 )
        end,
        spendType = "energy",

        talent = "secret_technique",
        startsCombat = true,

        usable = function () return combo_points.current > 0, "requires combo_points" end,
        handler = function ()
            applyBuff( "secret_technique" ) -- fake buff for APL logic.
            if talent.goremaws_bite.enabled and buff.goremaws_bite.up then removeStack( "goremaws_bite" ) end
            spend( combo_points.current, "combo_points" )
            if talent.shadowcraft.enabled and buff.symbols_of_death.up then Shadowcraft() end
        end
    },

    -- Draws upon surrounding shadows to empower your weapons, causing your attacks to deal $s1% additional damage as Shadow and causing your combo point generating abilities to generate full combo points for $d.
    shadow_blades = {
        id = 121471,
        cast = 0,
        cooldown = function () return 90 * ( essence.vision_of_perfection.enabled and 0.87 or 1 ) * ( pvptalent.thiefs_bargain.enabled and 0.8 or 1 ) end,
        gcd = "off",
        school = "physical",

        talent = "shadow_blades",
        startsCombat = false,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "shadow_blades" )

        end
    },

    -- Talent: Allows use of all Stealth abilities and grants all the combat benefits of Stealth for $d$?a245687[, and increases damage by $s2%][]. Effect not broken from taking damage or attacking.$?s137035[    If you already know $@spellname185313, instead gain $394930s1 additional $Lcharge:charges; of $@spellname185313.][]
    shadow_dance = {
        id = 185313,
        cast = 0,
        charges = function () if talent.double_dance.enabled then return 2 end end,
        cooldown = 60,
        recharge = function () if talent.double_dance.enabled then return 60 end end,
        gcd = "off",

        startsCombat = false,

        toggle = "cooldowns",
        nobuff = "shadow_dance",

        usable = function ()
            if state.spec.subtlety then return end
            return not stealthed.all, "not used in stealth"
        end,
        handler = function ()
            applyBuff( "shadow_dance" )

            if talent.danse_macabre.enabled then
                applyBuff( "danse_macabre" )
                wipe( danse_macabre_tracker )
            end
            if talent.master_of_shadows.enabled then applyBuff( "master_of_shadows" ) end
            if talent.premeditation.enabled then applyBuff( "premeditation" ) end
            if talent.shot_in_the_dark.enabled then applyBuff( "shot_in_the_dark" ) end
            if talent.silent_storm.enabled then applyBuff( "silent_storm" ) end
            if talent.soothing_darkness.enabled then applyBuff( "soothing_darkness" ) end

            if state.spec.subtlety and set_bonus.tier30_2pc > 0 then
                applyBuff( "symbols_of_death", 6 )
                if debuff.rupture.up then debuff.rupture.expires = debuff.rupture.expires + 4 end
            end

            if azerite.the_first_dance.enabled then
                gain( 2, "combo_points" )
                applyBuff( "the_first_dance" )
            end
        end
    },

    -- Strike the target, dealing 1,118 Physical damage. While Stealthed, you strike through the shadows and appear behind your target up to 25 yds away, dealing 25% additional damage. Awards 3 combo points.
    shadowstrike = {
        id = 185438,
        cast = 0,
        cooldown = 0,
        gcd = "totem",
        school = "physical",

        spend = function ()
            return ( 45 - ( azerite.blade_in_the_shadows.enabled and 2 or 0 ) ) * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 )
        end,
        spendType = "energy",

        startsCombat = true,
        cycle = function () return talent.find_weakness.enabled and "find_weakness" or nil end,

        cp_gain = function ()
            if buff.shadow_blades.up or buff.premeditation.up then return combo_points.max end
            return 2 + ( talent.improved_ambush.enabled and 1 or 0 )
        end,

        usable = function () return stealthed.all or buff.sepsis_buff.up, "requires stealth or sepsis_buff" end,

        used_for_danse = function()
            if not talent.danse_macabre.enabled or buff.shadow_dance.down then return false end
            return danse_macabre_tracker.shadowstrike
        end,

        handler = function ()
            st_gain( "shadowstrike" )

            if buff.the_rotten.up then
                removeStack( "the_rotten" )
                if talent.improved_backstab.enabled then
                    applyDebuff( "target", "find_weakness" )
                end
            end


            if buff.premeditation.up then
                removeBuff( "premeditation" )
            end

            if talent.deathstalkers_mark.enabled and stealthed.all then
                applyDebuff( "target", "deathstalkers_mark", nil, 3 )
                if talent.clear_the_witnesses.enabled then applyBuff( "clear_the_witnesses" ) end
            end

            if buff.sepsis_buff.up then removeBuff( "sepsis_buff" ) end
            if conduit.perforated_veins.enabled then
                addStack( "perforated_veins" )
            end
            if azerite.blade_in_the_shadows.enabled then addStack( "blade_in_the_shadows" ) end


        end,

        bind = "ambush"
    },

    -- Talent: Attack with your off-hand, dealing 386 Physical damage, dispelling all enrage effects and applying a concentrated form of your Crippling Poison, reducing movement speed by 70% for 5 sec. Awards 1 combo point.
    shiv = {
        id = 5938,
        cast = 0,
        charges = function() if talent.lightweight_shiv.enabled then return 2 end end,
        cooldown = 25,
        recharge = function() if talent.lightweight_shiv.enabled then return 25 end end,
        gcd = "totem",
        school = "physical",

        spend = function ()
            if buff.goremaws_bite.up or talent.tiny_toxic_blade.enabled or legendary.tiny_toxic_blade.enabled then return 0 end
            return 30
        end,
        spendType = "energy",

        talent = "shiv",
        startsCombat = true,

        cp_gain = function ()
            if buff.shadow_blades.up or buff.premeditation.up then return combo_points.max end
            return 1
        end,

        handler = function ()
            st_gain( "shiv" )
            removeBuff( "premeditation" )
            removeDebuff( "target", "dispellable_enrage" )
            if talent.improved_shiv.enabled then applyDebuff( "target", "shiv" ) end
        end
    },

    -- Sprays shurikens at all enemies within 13 yards, dealing 369 Physical damage. Deals reduced damage beyond 8 targets. Critical strikes with Shuriken Storm apply Find Weakness for 10 sec. Awards 1 combo point per target hit.
    shuriken_storm = {
        id = 197835,
        cast = 0,
        cooldown = 0,
        gcd = "totem",
        school = "physical",

        spend = function ()
            return 45 * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 )
        end,
        spendType = "energy",

        nobuff = "shuriken_tornado",

        startsCombat = true,
        cp_gain = function()
            if buff.shadow_blades.up or buff.premeditation.up then return combo_points.max end
            return active_enemies + ( buff.clear_the_witnesses and 1 or 0 )
        end,

        used_for_danse = function()
            if not talent.danse_macabre.enabled or buff.shadow_dance.down then return false end
            return danse_macabre_tracker.shuriken_storm
        end,

        handler = function ()
            st_gain( "shuriken_storm" )

            if talent.clear_the_witnesses.enabled then removeBuff( "clear_the_witnesses" ) end
            if talent.premeditation.enabled then removeBuff( "premeditation" ) end

            if buff.the_rotten.up then
                removeStack( "the_rotten" )
                if talent.improved_shuriken_storm.enabled then
                    applyDebuff( "target", "find_weakness" )
                end
            end

            if buff.silent_storm.up then
                applyDebuff( "target", "find_weakness" )
                active_dot.find_weakness = active_enemies
                removeBuff( "silent_storm" )
            end
        end
    },

    -- Talent: Focus intently, then release a Shuriken Storm every sec for the next 4 sec.
    shuriken_tornado = {
        id = 277925,
        cast = 0,
        cooldown = 60,
        gcd = "totem",
        school = "physical",

        spend = function () return 60 * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 ) end,
        spendType = "energy",

        talent = "shuriken_tornado",
        startsCombat = true,

        handler = function ()
            applyBuff( "shuriken_tornado" )
            if buff.shadow_dance.up and talent.danse_macabre.enabled and not danse_macabre_tracker.shuriken_storm then
                danse_macabre_tracker.shuriken_storm = true
            end

            local moment = buff.shuriken_tornado.expires - 0.02
            while( moment > query_time ) do
                state:QueueAuraEvent( "shuriken_tornado", class.abilities.shuriken_storm.handler, moment, "AURA_PERIODIC" )
                moment = moment - 1
            end
        end
    },

    -- Throws a shuriken at an enemy target for 230 Physical damage. Awards 1 combo point.
    shuriken_toss = {
        id = 114014,
        cast = 0,
        cooldown = 0,
        gcd = "totem",
        school = "physical",

        spend = function () return 40 * ( ( talent.shadow_focus.enabled and ( buff.shadow_dance.up or buff.stealth.up ) ) and 0.95 or 1 ) end,
        spendType = "energy",

        startsCombat = true,
        cp_gain = function()
            if buff.shadow_blades.up or buff.premeditation.up then return combo_points.max end
            return 1
        end,

        handler = function ()
            st_gain( "shuriken_toss" )

            removeBuff( "premeditation" )
            removeStack( "the_rotten" )
        end
    },

    -- Invoke ancient symbols of power, generating 40 Energy and increasing damage done by 10% for 10 sec.
    symbols_of_death = {
        id = 212283,
        cast = 0,
        charges = function() if talent.death_perception.enabled then return talent.death_perception.rank + 1 end end,
        cooldown = function() return 30 - ( 5 * talent.swift_death.rank ) end,
        recharge = function() if talent.death_perception.enabled then return 30 - ( 5 * talent.swift_death.rank ) end end,
        gcd = "off",
        school = "physical",

        spend = -40,
        spendType = "energy",
        toggle = "essences",

        startsCombat = false,

        handler = function ()
            applyBuff( "symbols_of_death" )

            if talent.symbolic_victory.enabled then
                applyBuff( "symbolic_victory" )
            end

            if set_bonus.tww1 >= 2 then
                applyBuff( "poised_shadows" )
            end

            if talent.the_rotten.enabled or legendary.the_rotten.enabled then applyBuff( "the_rotten" ) end
            if talent.supercharger.enabled then addStack( "supercharged_combo_points", nil, talent.supercharger.rank ) end
        end,
    }
} )

spec:RegisterRanges( "pick_pocket", "sinister_strike", "blind", "shadowstep" )

spec:RegisterOptions( {
    enabled = true,

    aoe = 3,
    cycle = false,

    nameplates = true,
    nameplateRange = 10,
    rangeFilter = false,

    canFunnel = true,
    funnel = false,

    damage = true,
    damageExpiration = 6,

    potion = "tempered_potion",

    package = "Subtlety",
} )

spec:RegisterSetting( "priority_rotation", false, {
    name = "Subtlety Rogue is able to do funnel damage. Head over to |cFFFFD100Toggles|r to learn how to turn the feature on and off. " ..
    "If funnel is enabled, the default priority will recommend building combo points with |T1375677:0|t Shuriken Storm and spending on single-target finishers in order to do priority damage.\n\n",
    desc = "",
    type = "description",
    fontSize = "medium",
    width = "full"
})

spec:RegisterSetting( "allow_shadowmeld", nil, {
    name = strformat( "Allow %s", Hekili:GetSpellLinkWithTexture( 58984 ) ),  -- Shadowmeld
    desc = strformat( "If checked, %s can be recommended for Night Elves when its conditions are met. Your stealth-based abilities can be used in Shadowmeld, even if your action bar does not change. " ..
                      "%s can only be recommended in boss fights or when you are in a group (to avoid resetting combat).",
                      Hekili:GetSpellLinkWithTexture( 58984 ), Hekili:GetSpellLinkWithTexture( 58984 )
    ),
    type = "toggle",
    width = "full",
    get = function () return not Hekili.DB.profile.specs[ 261 ].abilities.shadowmeld.disabled end,
    set = function ( _, val )
        Hekili.DB.profile.specs[ 261 ].abilities.shadowmeld.disabled = not val
    end,
} )

spec:RegisterSetting( "solo_vanish", true, {
    name = strformat( "Allow %s When Solo", Hekili:GetSpellLinkWithTexture( 1856 ) ),  -- Vanish
    desc = strformat( "If enabled, %s can be recommended even when you are alone, |cFFFF0000which may reset combat|r.", Hekili:GetSpellLinkWithTexture( 1856 ) ),
    type = "toggle",
    width = "full"
} )

spec:RegisterSetting( "vanish_charges_reserved", 0, {
    name = strformat( "Reserve %s Charges", Hekili:GetSpellLinkWithTexture( 1856 ) ),
    desc = strformat( "If set above zero, %s will not be recommended if it would leave you with fewer than this number of (fractional) charges.", Hekili:GetSpellLinkWithTexture( 1856 ) ),
    type = "range",
    min = 0,
    max = 2,
    step = 0.1,
    width = 1.5
} )

spec:RegisterSetting( "rupture_duration", 12, {
    name = strformat( "%s Duration", Hekili:GetSpellLinkWithTexture( 1943 ) ),
    desc = strformat( "If set above 0, %s will not be recommended if the target will die within the timeframe specified.\n\n"
        .. "Popular guides suggest using that a target should live at least 12 seconds for %s to be worth using.\n\n",
        Hekili:GetSpellLinkWithTexture( 1943 ), class.specs[ 259 ].abilities.rupture.name ),
    type = "range",
    min = 0,
    max = 18,
    step = 0.1,
    width = 1.5,
} )

spec:RegisterPack( "Subtlety", 20250807, [[Hekili:nZZAVTno2(BXyaCTBtCSLBs7wehGD7Gb3PyUdgmE2D)WfBKLLOT1gzjpIsnJxy4F73ZHupiPousoTDUxGI4AjYdpVFrs)4Sh)Thxg4LXE8NDM6C703p9DtMn)w4JhxMD8a7XLh88FYBl8FI92d)Dz(6Siw2r8fhJs8cqaWtYt9HxUll7a)d3CZ2WSD5RN4NS)gE4(8iVSWKy)uVnz439VzDuY6BY2XE2l9zyOHX38x9XH8lPHjPHzh)PqEg)Ma2gV8OSBst2MZC5fl8eecpUCDEyu2pg)4Ak0)Do3bi1bMp847Mb4vyqatowghM81xFE1VTJDE1)0lf(JafoVAjZJNaFo)8NqGD903F90B)W5v)qykp78Q)6V8tN)05p1(CDkN7BVE6DWCxgU)JWFpg7x(I5x7CRLxiMX)mj9jV0K84GZR2KalrA(HS8uyb5h82dFLHOueisIK81ZR8tsIcsEowbsZ(qbWxHmy5Y94YiKVIcSnHrrWN)Sq8ZI9whXcE8V94spHya(m13lM5MLKMYIZKST0WdYx(B7c5NxHW68QCEUxu0rehIZ8cJHx8XcSHxU2XSTrm)mCroVkCpOqbtmBNh8xFVCodg4wqHWlQMs4pUewVmwAOhIFS0ThNaQdH(HWKEyX5vZU98Q3CEvXRszBbXBgiTr6XGioKhXzQujmU5QJlkC7UmU7)opy7Eb1Qn03Qo01EBDt24MLg6)exFGcUKqHTIXwolEgZlkBNbG1W1NaasHJkYMKdaKyz1Z5ZEa7bEl()IYzOnXMnt478aoOBGxSpBs(HZRoD68k5BKOH(d)SxCihFMaEUsJ8seUK8)AIfbEPpX4zUXixV6vi0(mZfKN7drfcug)(ZRgEE1aqxXlcKlGu(quOpOZhV1vcF(KcmtmYIHLhZzSy31rEbSY3RrCpfEWTWOcPWBVykC05vbja(iHXKmq2b4KKqkh8e1L58QXcmCuPKaOdMRxCGBqOc)XKjC)c0HYQXQy)EWildWwGVIi)DxmYtlEKm6weqJQnoNSrX7div2lT7V)8Q7MkGuhd8bWf7uvjwaZlBN7bgedr4IPVsvdwdN5NYqdXF(DxmxPsYizmILHxYzOzzJLmMA9t95QsdsaCC)6Kio6)qqW1MfjCUyyBqoURkd1zQkbM65h6f5Yb)6iv((lMkHaYRtCpKaQqfQxZA1YuilvNcAw(o5uyB2WK6RnhYDDj50eB7cC9pGe0FXGG0I68X6qdL0Npe6Xv(fxmCKmaxby9d4imNn1sioihKKa3n5PhnwOFvWL1IavzuBibMzg)SJPuV4Suolf9AiaJZfbgR6K1WFtyktqGcWBgjPVyjcwEwk8CKtlaLz4ano3pMX2dAaJ(T0W4Nyz8XLjnMLY883XGSA4qStVy((WmaduXKUCUiDf2Q5IiTGAS32IIKHPp)Y5azNWsr9AxpUplgzShDbjv((hxczQa2UBC36hGX3liT2Mrn1rgUOukQsXUINKlmhMz6CVel37f4(75Grf3Dpeebt)vzTgP6tkcwj4Xqet06oMXvCmvz4tmOsFtSFpp8WbwWelCtLiBd6ZOrywjQTmkTifotR802LGVmazdMdYlndjuRLi0vNzWbRmmkEVWYWLhLa5FkDBQgoVrqJUqxfQQ7fZrHdxmIjzotQyJaxm4OEGxDmIGFwh8QTfhmGX)dxHnH8sZapg8sNlJx68NjVCgfVC2)NWlDe8Y(fZROuWLLfsypcynNxfFQQarjazXZClcu6ygOudt(HqSmbHBRFnpI1AqynuWEMfDKaXLKwcmd)dG5(F4cf9hhuNnnecXpj)aKWL7wiehJu(ksB0nJ5Vloe8COjINQXY2i4ccULzKFd5gGDNx9li6DE1FlpmkaJ21R8wWgBicB7yMvGHajkILEfOtCaIDWXkXrF6HBoV6ysowzDS4zq53jzsbhdQdEsVfCTQ7i6FGOM3dPmuw41SQxVdhIoIIio(TML(ErzUMLSDlGlBYJJzrgSILp7bkfzad)qr)JoVknjRO5iihjd7xtjmHhXXoh0ir0Yz7wo5xwv4AHsu8XSZJ7I5qGk10E01hbQdRm9qE7rvP8MfKNwWfqJkQyh1JqRuQg(VEzTcWHKvysOuoKBHvqI9p0fdOBY72oBztwLhaIwNvWnc3yyhvO5Q0zlnL3)NLhtd38VoVs0wruZSwpfST(mt4GZOhGpVJbK0h)E4nE4tLRby(d5NcUeWqfGrpl95q0baSEaDIVoiNjnucYHm(q2YwGFCiY7iAq85W0KySdyNxPYSQWCxEIWUMwA7YeTzRRWMIK1Mxk07kRFyStnlZwBO1DcOeKQPARcOrDhs)nK5GOOdvOgj0T34H0lHZmIQRk6mrT2LrihkhnLJTStv6Qn)31TbcBqnQuQxp1aRTIQYCZApSszBszatqOewfhMQmfTghr2GJH2BRvrtcs3IgTH7X2n7geYeMcQXGVJY5td2tpjD1x2WHVvmcDFosG1V2m3djzOXYiOzeaO3WJ(raufRah9Hq0)X2f8v(l(7IgN)FXEkmk8ACVoc3e6R69Wd9oa(kQ2pbnNXT1vTHk8iDRFR0M0I2MTNww7uTTSkNe1K1mO8Vpes1a8n99E7bfrAT(aMuv17)afHwO(1TBMhkQION(zWHrvc6uQwpsRwsR5v969Qw3ssq(ps1QcT26wPYHV8elflao9jnX6OUAZR1UdtTY3Qw(txAu2bqpsw3Ik3y12555)eyu(CGSfpM1OQvrAp0hUG4ouTUxGG1yh7ZHCFwQSzezYMt2Y2V5dONRS)DwBckrRZAujtR9VUrvu1DU1iWvnq0IbCauXGsck6wL9WGIzkOMOCETQwQxyr3XT3)75t7iaunp7qI4tIiPAIE6ivAgYZNCBNMJwuil0yAjEjocs3KcimvVFATQ5P1kn7kYimVwUHPVwfOTUPl9O447fBqNUjIDyoUVY8fsuvXY2uyrLnaroxMcTADAX(n0UHrPmeYaFpliu6JwtDtlhrQW4g6)ARIwtK0wqOuDEgMIaZtB5uEov8tvNbMM03AirTNx(8lqi5O0PDvLpP)n1El1IFovMIzr9IxHr7H3b108pe7tn2VdXl2ZIcS1MXsbSUUPUO0OUH2m17JTaYqERwCqO8l3n4bhPqKRADzPrNg7rSvFuMniZwdkLd7IS8M2UNC5XTqc63ovtXfpEoS0n5BzD1FV71dnkpacT73MyDvHP(rdzUP(LqxrOwk7TwlkKRHKiGSNw3V(5PP(1A(puPiOvg0OwCgnYIZiRQa1ktdK9f0DtskctoRzRQlmvBvXShX3T4f9lE1RLnBHmi2lEEBLlxCWqYsdFIrvzqyCG7Zmp5UCLAS9IdBkLmtW2U8LGAh2Pdi6scThEtqeTSFD9RmGUcgimJO5hkj60vg)JSiQTMVCNUaZR9QJ(ZCfThBIxqqPEQIAqoQbeJhHTyGg7reAqm4L6I(TFomdzQ1hae7vEPMWhj6sHtCaP23wzW2uI7N0fBTJuBNyGTuo3CkprMBeNDhrkb(GQAHGOAhthk1C71k3pcLIiKDP5ncQ512CQ2QqXELJ9qHVmZ)NJafi0vW(U54wnsKiFiUOs0RJIXh(IOxZDG0WSi75NNxCGhHh7(2d(uLvs4VU5kjplo0k51iqwRNRMEf3FBc6k7zU76WIT)x7WwQejXyD1oxO1jdOoirIeFgl9fgt5Po(2jZEC5ZEPXGtzoEczLN01K0SIDU9vfNn0xHTk83ZdtrvgEYESpD5zj79YWh4VZd8SZNC(t)uym8Qz4bc(JjXWYjE)RQ2JdlNCcL9Xw4k)vY29)Q(EKlEv9s)ollT5bpOCjSEYeGbmA2Fm(BbKRH57TatZT2VbmjgGo2(1dYvW0zQomtoWKBXaykJhM8xnq692OdDdPZO(Hf3D6e9euh2IfQBr(PtsTCQoUnSZkEEyAj1(nbt)QIOtWdTpHbz1gxFzMKZTQoOULLekdgVwtjZgqDAhOnEDVaABBLmbE36G75c2y)yBZyrzmFtbFNaMyJMBZL0LI3VuWxb43(TqRXgq)I0VTJPVmwW3yW3jGFPQC9eVFPGx4Q7hfE5q49UYTvrEzDqFyqYn5z7ssFCP8cbDinztiUf(F33DE1FA3ERZFcxULvW(JiSrwX(9yYC49w6d4jy6V4SHnxo4Vh8g)bmYz59Ycjvj1XNu5k)nlUr9uhbtfG2xWPdIEjkh6v45JyrJTY7kXbeyH2jwQpaQq0wFOuka0SRc3SG2mC4Ob0g9No1hV9QJQH20dlAXmA8xcb5Osqo2iOzwiicS5HwidlyAzDw1ArQpS(r49Ys976uyXekOlQAVkY3P(Qxv8GQRDLu9U(ua9R4XXrCyDwZIWgGxRykVnDg1(jMUn8ROC7c8JJNuWYsWNOxEwl0OYjOOBc1mXoz6B147dlE)Wb2VpxdjkX2oQP0S(cmBeXzA50jYtdY4HJK0H5DXYeLVFHZ4wypImpBHXmKof5tNgvPRsT5D3F30HToGhMpDOLTDJIl2cjOC3pkzJKL2pKI8gF60aQ7)uXGB2smqrjHZhQT7d37mTfoSy7CkWm16eUFXS(uoXdlE3PtwliHwJ77uVgRkyM5zMvIH(bCXukU5qQtO(wgHo9QuevVnpQJU6Ab1NrxDjFSnysbMke0VGp2xtDFmHXFo5jW84pGqiXWyWvPiwyYZSu3W4n5y3rq4rJba4ACxHuXl0RFimGY4iKrVqW3Uj0chsLTfZU1KKcsCTSkG)s(t2Oe7G3gTy)6cDLY9lsgZNWxMuIsEYcSUKnVqmiWhnW6neQWOICxgalPoUJpGF1bDnM6O59Trwp4mD8LWT5xjUSfLPzi4NJQuUBKzYIzdP95rVMcKPnW5OLzMEFGu6Ab1UVGuk6u1o0jnvmiyNUiyNVUe8mTm3(6tWgUK1UomD7Gw54iG8LbnA3ocDZR4s3GvEyWfqKom0xwBW(Q2hScgiX(y3nDk228cE0l7wN09AG3OelYMEG6teOigbTON9c1FIq7uj3PBjuL3M8PM71vzc9gMnJhoqFZFvvOlOKH0ZSjruV)e2c88IxTMlM62WCL2U0vefQLnoh4Ed15NWdi56g4BvnaASxkKtFBCR4hwcozDFd7Yh0I5Muc8Ok4PslGJotwDZICMxPurLa8GMBEnHwGEbAvuo92upCKjka5(mWgkqUATRgyNZoOTnBUjt1EChAZTgBRCVyv2rxteAKZBM)AYkBUG1rxbPmjnTnbMGtqOijre9T8TXmVLUsS(GVIjsULUVe)feUUu35vzg6n3VwG2BZPNDV6nYdOAKqKDm0ss55MwR4aIZfnjhCOzTH1YhbeiY(U(mqBIlYZJCfpx98pF6e6ayirIwZNwOc0Ak(fRGPHTiMhTjFL)65tUTMQu6Fst)hZl9FqHkNorCgMH5mfZ(pR5Pw(0P27LbmZRND7RhyRHgDMGZ9VVUpeMZESD(nu9W4gSvvtaTAIv5x1QgI2tqRpnG0NM5cQC2EPJ3xLOCba1pKWMGtLbBAbI(oAps49OG3k7Y52ctW)m(naRMWWKdX2vO9RsgsBmTFAWEaeNVHP8tcMnii(jbRXln(DaRX71(X)QGp8)pV(MQOowIYBm7PwfpwCRUUk5WcXvx9kqcckQWmxmW8ERw0aoX1E8Q6B85IUuNMbr8BVnnZMwB7QoaWxcHxM7h1(k(gI4yvBgWycoJPlfnt(IladkQjVYLeWRSx56fZO05zWfjzBQvUdHTefyO1S6mYtquAtZlZ41LEtURfCNibql0s9JBSryeloMU1RvDinEOcv3irhhDBSl)kp2U4Hk5TkYr3eHi7nkDt9ZupI82U1IeyMwL9QLEvCBg7Wocyx2mKoDYmS3uI1FTYvOtxI3u0sNdXOMvHm0EM4JSTZiKXsBKem20ikjyZb2AVtAiyP8ruF)9ejz1HCWQdnIcflIJ0JR7snAP0oR68vemk9U(jtnPgx0sezSfzy3PATW5TALLPCnxS0IdBfdxXXUJSTk1VU1u4MAJZi3K168eEyXBNw6(u96QyPpD3RwMcfphLkgq3s5oItn6J)Vd]] )