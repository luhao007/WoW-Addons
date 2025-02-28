-- DemonHunterHavoc.lua
-- January 2025

if UnitClassBase( "player" ) ~= "DEMONHUNTER" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State

local strformat, wipe = string.format, table.wipe
local GetSpellInfo = ns.GetUnpackedSpellInfo
local IsSpellOverlayed = IsSpellOverlayed
local GetSpellCastCount = C_Spell.GetSpellCastCount
local spec = Hekili:NewSpecialization( 577 )

spec:RegisterResource( Enum.PowerType.Fury, {
    mainhand_fury = {
        talent = "demon_blades",
        swing = "mainhand",

        last = function ()
            local swing = state.swings.mainhand
            local t = state.query_time

            return swing + floor( ( t - swing ) / state.swings.mainhand_speed ) * state.swings.mainhand_speed
        end,

        interval = "mainhand_speed",

        stop = function () return state.time == 0 or state.swings.mainhand == 0 end,
        value = function () return state.talent.demonsurge.enabled and state.buff.metamorphosis.up and 10 or 7 end,
    },

    offhand_fury = {
        talent = "demon_blades",
        swing = "offhand",

        last = function ()
            local swing = state.swings.offhand
            local t = state.query_time

            return swing + floor( ( t - swing ) / state.swings.offhand_speed ) * state.swings.offhand_speed
        end,

        interval = "offhand_speed",

        stop = function () return state.time == 0 or state.swings.offhand == 0 end,
        value = function () return state.talent.demonsurge.enabled and state.buff.metamorphosis.up and 10 or 7 end,
    },

    -- Immolation Aura now grants 20 up front, then 4 per second with burning hatred talent.
    immolation_aura = {
        talent  = "burning_hatred",
        aura    = "immolation_aura",

        last = function ()
            local app = state.buff.immolation_aura.applied
            local t = state.query_time

            return app + floor( t - app )
        end,

        interval = 1,
        value = 4
    },

    student_of_suffering = {
        talent  = "student_of_suffering",
        aura    = "student_of_suffering",

        last = function ()
            local app = state.buff.student_of_suffering.applied
            local t = state.query_time

            return app + floor( t - app )
        end,

        interval = function () return spec.auras.student_of_suffering.tick_time end,
        value = 5
    },

    tactical_retreat = {
        talent  = "tactical_retreat",
        aura    = "tactical_retreat",

        last = function ()
            local app = state.buff.tactical_retreat.applied
            local t = state.query_time

            return app + floor( t - app )
        end,

        interval = function() return class.auras.tactical_retreat.tick_time end,
        value = 8
    },

    eye_beam = {
        talent = "blind_fury",
        aura   = "eye_beam",

        last = function ()
            local app = state.buff.eye_beam.applied
            local t = state.query_time

            return app + floor( ( t - app ) / state.haste ) * state.haste
        end,

        interval = function() return state.haste end,
        value = function() return 20 * state.talent.blind_fury.rank end
    },
} )

-- Talents
spec:RegisterTalents( {
    -- DemonHunter
    aldrachi_design          = {  90999, 391409, 1 }, -- Increases your chance to parry by 3%.
    aura_of_pain             = {  90933, 207347, 1 }, -- Increases the critical strike chance of Immolation Aura by 6%.
    blazing_path             = {  91008, 320416, 1 }, -- Fel Rush gains an additional charge.
    bouncing_glaives         = {  90931, 320386, 1 }, -- Throw Glaive ricochets to 1 additional target.
    champion_of_the_glaive   = {  90994, 429211, 1 }, -- Throw Glaive has 2 charges and 10 yard increased range.
    chaos_fragments          = {  95154, 320412, 1 }, -- Each enemy stunned by Chaos Nova has a 30% chance to generate a Lesser Soul Fragment.
    chaos_nova               = {  90993, 179057, 1 }, -- Unleash an eruption of fel energy, dealing 7,335 Chaos damage and stunning all nearby enemies for 2 sec.
    charred_warblades        = {  90948, 213010, 1 }, -- You heal for 3% of all Fire damage you deal.
    collective_anguish       = {  95152, 390152, 1 }, -- Eye Beam summons an allied Vengeance Demon Hunter who casts Fel Devastation, dealing 43,890 Fire damage over 2.2 sec. Dealing damage heals you for up to 3,188 health.
    consume_magic            = {  91006, 278326, 1 }, -- Consume 1 beneficial Magic effect removing it from the target.
    darkness                 = {  91002, 196718, 1 }, -- Summons darkness around you in an 8 yd radius, granting friendly targets a 15% chance to avoid all damage from an attack. Lasts 8 sec. Chance to avoid damage increased by 100% when not in a raid.
    demon_muzzle             = {  90928, 388111, 1 }, -- Enemies deal 8% reduced magic damage to you for 8 sec after being afflicted by one of your Sigils.
    demonic                  = {  91003, 213410, 1 }, -- Eye Beam causes you to enter demon form for 5 sec after it finishes dealing damage.
    disrupting_fury          = {  90937, 183782, 1 }, -- Disrupt generates 30 Fury on a successful interrupt.
    erratic_felheart         = {  90996, 391397, 2 }, -- The cooldown of Fel Rush is reduced by 10%.
    felblade                 = {  95150, 232893, 1 }, -- Charge to your target and deal 22,671 Fire damage. Demon Blades has a chance to reset the cooldown of Felblade. Generates 40 Fury.
    felfire_haste            = {  90939, 389846, 1 }, -- Fel Rush increases your movement speed by 10% for 8 sec.
    flames_of_fury           = {  90949, 389694, 2 }, -- Sigil of Flame deals 35% increased damage and generates 1 additional Fury per target hit.
    illidari_knowledge       = {  90935, 389696, 1 }, -- Reduces magic damage taken by 5%.
    imprison                 = {  91007, 217832, 1 }, -- Imprisons a demon, beast, or humanoid, incapacitating them for 1 min. Damage may cancel the effect. Limit 1.
    improved_disrupt         = {  90938, 320361, 1 }, -- Increases the range of Disrupt to 10 yds.
    improved_sigil_of_misery = {  90945, 320418, 1 }, -- Reduces the cooldown of Sigil of Misery by 30 sec.
    infernal_armor           = {  91004, 320331, 2 }, -- Immolation Aura increases your armor by 20% and causes melee attackers to suffer 2,212 Fire damage.
    internal_struggle        = {  90934, 393822, 1 }, -- Increases your mastery by 4.5%.
    live_by_the_glaive       = {  95151, 428607, 1 }, -- When you parry an attack or have one of your attacks parried, restore 2% of max health and 10 Fury. This effect may only occur once every 5 sec.
    long_night               = {  91001, 389781, 1 }, -- Increases the duration of Darkness by 3 sec.
    lost_in_darkness         = {  90947, 389849, 1 }, -- Spectral Sight has 5 sec reduced cooldown and no longer reduces movement speed. 
    master_of_the_glaive     = {  90994, 389763, 1 }, -- Throw Glaive has 2 charges and snares all enemies hit by 50% for 6 sec.
    pitch_black              = {  91001, 389783, 1 }, -- Reduces the cooldown of Darkness by 120 sec.
    precise_sigils           = {  95155, 389799, 1 }, -- All Sigils are now placed at your target's location.
    pursuit                  = {  90940, 320654, 1 }, -- Mastery increases your movement speed.
    quickened_sigils         = {  95149, 209281, 1 }, -- All Sigils activate 1 second faster.
    rush_of_chaos            = {  95148, 320421, 2 }, -- Reduces the cooldown of Metamorphosis by 30 sec.
    shattered_restoration    = {  90950, 389824, 1 }, -- The healing of Shattered Souls is increased by 10%.
    sigil_of_misery          = {  90946, 207684, 1 }, -- Place a Sigil of Misery at the target location that activates after 1 sec. Causes all enemies affected by the sigil to cower in fear, disorienting them for 15 sec.
    sigil_of_spite           = {  90997, 390163, 1 }, -- Place a demonic sigil at the target location that activates after 1 sec. Detonates to deal 120,957 Chaos damage and shatter up to 3 Lesser Soul Fragments from enemies affected by the sigil. Deals reduced damage beyond 5 targets.
    soul_rending             = {  90936, 204909, 2 }, -- Leech increased by 6%. Gain an additional 6% leech while Metamorphosis is active.
    soul_sigils              = {  90929, 395446, 1 }, -- Afflicting an enemy with a Sigil generates 1 Lesser Soul Fragment. 
    swallowed_anger          = {  91005, 320313, 1 }, -- Consume Magic generates 20 Fury when a beneficial Magic effect is successfully removed from the target.
    the_hunt                 = {  90927, 370965, 1 }, -- Charge to your target, striking them for 153,784 Chaos damage, rooting them in place for 1.5 sec and inflicting 119,447 Chaos damage over 6 sec to up to 5 enemies in your path. The pursuit invigorates your soul, healing you for 10% of the damage you deal to your Hunt target for 20 sec.
    unrestrained_fury        = {  90941, 320770, 1 }, -- Increases maximum Fury by 20.
    vengeful_bonds           = {  90930, 320635, 1 }, -- Vengeful Retreat reduces the movement speed of all nearby enemies by 70% for 3 sec.
    vengeful_retreat         = {  90942, 198793, 1 }, -- Remove all snares and vault away. Nearby enemies take 2,865 Physical damage.
    will_of_the_illidari     = {  91000, 389695, 1 }, -- Increases maximum health by 5%.

    -- Havoc
    a_fire_inside            = {  95143, 427775, 1 }, -- Immolation Aura has 1 additional charge, 30% chance to refund a charge when used, and deals Chaos damage instead of Fire. You can have multiple Immolation Auras active at a time.
    accelerated_blade        = {  91011, 391275, 1 }, -- Throw Glaive deals 60% increased damage, reduced by 30% for each previous enemy hit.
    blind_fury               = {  91026, 203550, 2 }, -- Eye Beam generates 40 Fury every second, and its damage and duration are increased by 10%.
    burning_hatred           = {  90923, 320374, 1 }, -- Immolation Aura generates an additional 40 Fury over 10 sec.
    burning_wound            = {  90917, 391189, 1 }, -- Demon Blades and Throw Glaive leave open wounds on your enemies, dealing 20,193 Chaos damage over 15 sec and increasing damage taken from your Immolation Aura by 40%. May be applied to up to 3 targets.
    chaos_theory             = {  91035, 389687, 1 }, -- Blade Dance causes your next Chaos Strike within 8 sec to have a 14-30% increased critical strike chance and will always refund Fury.
    chaotic_disposition      = {  95147, 428492, 2 }, -- Your Chaos damage has a 7.77% chance to be increased by 17%, occurring up to 3 total times.
    chaotic_transformation   = {  90922, 388112, 1 }, -- When you activate Metamorphosis, the cooldowns of Blade Dance and Eye Beam are immediately reset.
    critical_chaos           = {  91028, 320413, 1 }, -- The chance that Chaos Strike will refund 20 Fury is increased by 30% of your critical strike chance.
    cycle_of_hatred          = {  91032, 258887, 1 }, -- Activating Eye Beam reduces the cooldown of your next Eye Beam by 5.0 sec, stacking up to 20 sec.
    dancing_with_fate        = {  91015, 389978, 2 }, -- The final slash of Blade Dance deals an additional 25% damage.
    dash_of_chaos            = {  93014, 427794, 1 }, -- For 2 sec after using Fel Rush, activating it again will dash back towards your initial location.
    deflecting_dance         = {  93015, 427776, 1 }, -- You deflect incoming attacks while Blade Dancing, absorbing damage up to 15% of your maximum health.
    demon_blades             = {  91019, 203555, 1 }, -- Your auto attacks deal an additional 3,423 Shadow damage and generate 7-12 Fury.
    demon_hide               = {  91017, 428241, 1 }, -- Magical damage increased by 3%, and Physical damage taken reduced by 5%.
    desperate_instincts      = {  93016, 205411, 1 }, -- Blur now reduces damage taken by an additional 10%. Additionally, you automatically trigger Blur with 50% reduced cooldown and duration when you fall below 35% health. This effect can only occur when Blur is not on cooldown.
    essence_break            = {  91033, 258860, 1 }, -- Slash all enemies in front of you for 75,406 Chaos damage, and increase the damage your Chaos Strike and Blade Dance deal to them by 80% for 4 sec. Deals reduced damage beyond 8 targets.
    exergy                   = {  91021, 206476, 1 }, -- The Hunt and Vengeful Retreat increase your damage by 5% for 20 sec.
    eye_beam                 = {  91018, 198013, 1 }, -- Blasts all enemies in front of you, for up to 322,392 Chaos damage over 1.8 sec. Deals reduced damage beyond 5 targets. When Eye Beam finishes fully channeling, your Haste is increased by an additional 10% for 10 sec.
    fel_barrage              = {  95144, 258925, 1 }, -- Unleash a torrent of Fel energy, rapidly consuming Fury to inflict 9,316 Chaos damage to all enemies within 12 yds, lasting 8 sec or until Fury is depleted. Deals reduced damage beyond 5 targets.
    first_blood              = {  90925, 206416, 1 }, -- Blade Dance deals 60,036 Chaos damage to the first target struck.
    furious_gaze             = {  91025, 343311, 1 }, -- When Eye Beam finishes fully channeling, your Haste is increased by an additional 10% for 10 sec.
    furious_throws           = {  93013, 393029, 1 }, -- Throw Glaive now costs 25 Fury and throws a second glaive at the target.
    glaive_tempest           = {  91035, 342817, 1 }, -- Launch two demonic glaives in a whirlwind of energy, causing 80,232 Chaos damage over 3 sec to all nearby enemies. Deals reduced damage beyond 8 targets.
    growing_inferno          = {  90916, 390158, 1 }, -- Immolation Aura's damage increases by 10% each time it deals damage.
    improved_chaos_strike    = {  91030, 343206, 1 }, -- Chaos Strike damage increased by 10%.
    improved_fel_rush        = {  93014, 343017, 1 }, -- Fel Rush damage increased by 20%.
    inertia                  = {  91021, 427640, 1 }, -- The Hunt and Vengeful Retreat cause your next Fel Rush or Felblade to empower you, increasing damage by 18% for 5 sec.
    initiative               = {  91027, 388108, 1 }, -- Damaging an enemy before they damage you increases your critical strike chance by 10% for 5 sec. Vengeful Retreat refreshes your potential to trigger this effect on any enemies you are in combat with.
    inner_demon              = {  91024, 389693, 1 }, -- Entering demon form causes your next Chaos Strike to unleash your inner demon, causing it to crash into your target and deal 56,855 Chaos damage to all nearby enemies. Deals reduced damage beyond 5 targets.
    insatiable_hunger        = {  91019, 258876, 1 }, -- Demon's Bite deals 50% more damage and generates 5 to 10 additional Fury.
    isolated_prey            = {  91036, 388113, 1 }, -- Chaos Nova, Eye Beam, and Immolation Aura gain bonuses when striking 1 target.  Chaos Nova: Stun duration increased by 2 sec.  Eye Beam: Deals 30% increased damage.  Immolation Aura: Always critically strikes.
    know_your_enemy          = {  91034, 388118, 2 }, -- Gain critical strike damage equal to 40% of your critical strike chance.
    looks_can_kill           = {  90921, 320415, 1 }, -- Eye Beam deals guaranteed critical strikes.
    mortal_dance             = {  93015, 328725, 1 }, -- Blade Dance now reduces targets' healing received by 50% for 6 sec.
    netherwalk               = {  93016, 196555, 1 }, -- Slip into the nether, increasing movement speed by 100% and becoming immune to damage, but unable to attack. Lasts 6 sec.
    ragefire                 = {  90918, 388107, 1 }, -- Each time Immolation Aura deals damage, 30% of the damage dealt by up to 3 critical strikes is gathered as Ragefire. When Immolation Aura expires you explode, dealing all stored Ragefire damage to nearby enemies.
    relentless_onslaught     = {  91012, 389977, 1 }, -- Chaos Strike has a 10% chance to trigger a second Chaos Strike.
    restless_hunter          = {  91024, 390142, 1 }, -- Leaving demon form grants a charge of Fel Rush and increases the damage of your next Blade Dance by 50%.
    scars_of_suffering       = {  90914, 428232, 1 }, -- Increases Versatility by 4% and reduces threat generated by 8%.
    screaming_brutality      = {  90919, 1220506, 1 }, -- Blade Dance automatically triggers Throw Glaive on your primary target for 100% damage and each slash has a 50% chance to Throw Glaive an enemy for 35% damage.
    serrated_glaive          = {  91013, 390154, 1 }, -- Enemies hit by Chaos Strike or Throw Glaive take 15% increased damage from Chaos Strike and Throw Glaive for 15 sec.
    shattered_destiny        = {  91031, 388116, 1 }, -- The duration of your active demon form is extended by 0.1 sec per 12 Fury spent.
    soulscar                 = {  91012, 388106, 1 }, -- Throw Glaive causes targets to take an additional 80% of damage dealt as Chaos over 6 sec.
    tactical_retreat         = {  91022, 389688, 1 }, -- Vengeful Retreat has a 5 sec reduced cooldown and generates 80 Fury over 10 sec.
    trail_of_ruin            = {  90915, 258881, 1 }, -- The final slash of Blade Dance inflicts an additional 19,218 Chaos damage over 4 sec.
    unbound_chaos            = {  91020, 347461, 1 }, -- The Hunt and Vengeful Retreat increase the damage of your next Fel Rush or Felblade by 300%. Lasts 12 sec.

    -- Aldrachi Reaver
    aldrachi_tactics         = {  94914, 442683, 1 }, -- The second enhanced ability in a pattern shatters an additional Soul Fragment.
    army_unto_oneself        = {  94896, 442714, 1 }, -- Felblade surrounds you with a Blade Ward, reducing damage taken by 10% for 5 sec.
    art_of_the_glaive        = {  94915, 442290, 1, "aldrachi_reaver" }, -- Consuming 6 Soul Fragments or casting The Hunt converts your next Throw Glaive into Reaver's Glaive.  Reaver's Glaive: Throw a glaive enhanced with the essence of consumed souls at your target, dealing 46,361 Physical damage and ricocheting to 3 additional enemies. Begins a well-practiced pattern of glaivework, enhancing your next Chaos Strike and Blade Dance. The enhanced ability you cast first deals 10% increased damage, and the second deals 20% increased damage.
    evasive_action           = {  94911, 444926, 1 }, -- Vengeful Retreat can be cast a second time within 3 sec.
    fury_of_the_aldrachi     = {  94898, 442718, 1 }, -- When enhanced by Reaver's Glaive, Blade Dance casts 3 additional glaive slashes to nearby targets. If cast after Chaos Strike, cast 6 slashes instead.
    incisive_blade           = {  94895, 442492, 1 }, -- Chaos Strike deals 10% increased damage.
    incorruptible_spirit     = {  94896, 442736, 1 }, -- Each Soul Fragment you consume shields you for an additional 15% of the amount healed.
    keen_engagement          = {  94910, 442497, 1 }, -- Reaver's Glaive generates 20 Fury.
    preemptive_strike        = {  94910, 444997, 1 }, -- Throw Glaive deals 3,443 Physical damage to enemies near its initial target.
    reavers_mark             = {  94903, 442679, 1 }, -- When enhanced by Reaver's Glaive, Chaos Strike applies Reaver's Mark, which causes the target to take 7% increased damage for 20 sec. If cast after Blade Dance, Reaver's Mark is increased to 14%.
    thrill_of_the_fight      = {  94919, 442686, 1 }, -- After consuming both enhancements, gain Thrill of the Fight, increasing your attack speed by 15% for 20 sec and your damage and healing by 20% for 10 sec.
    unhindered_assault       = {  94911, 444931, 1 }, -- Vengeful Retreat resets the cooldown of Felblade.
    warblades_hunger         = {  94906, 442502, 1 }, -- Consuming a Soul Fragment causes your next Chaos Strike to deal 6,886 additional Physical damage. Felblade consumes up to 5 nearby Soul Fragments.
    wounded_quarry           = {  94897, 442806, 1 }, -- Expose weaknesses in the target of your Reaver's Mark, causing your Physical damage to any enemy to also deal 20% of the damage dealt to your marked target as Chaos. 

    -- Fel-Scarred
    burning_blades           = {  94905, 452408, 1 }, -- Your blades burn with Fel energy, causing your Chaos Strike, Throw Glaive, and auto-attacks to deal an additional 50% damage as Fire over 6 sec.
    demonic_intensity        = {  94901, 452415, 1 }, -- Activating Metamorphosis greatly empowers Eye Beam, Immolation Aura, and Sigil of Flame. Demonsurge damage is increased by 10% for each time it previously triggered while your demon form is active.
    demonsurge               = {  94917, 452402, 1, "felscarred" }, -- Metamorphosis now also causes Demon Blades to generate 5 additional Fury. While demon form is active, the first cast of each empowered ability induces a Demonsurge, causing you to explode with Fel energy, dealing 28,790 Fire damage to nearby enemies.
    enduring_torment         = {  94916, 452410, 1 }, -- The effects of your demon form persist outside of it in a weakened state, increasing Chaos Strike and Blade Dance damage by 15%, and Haste by 5%.
    flamebound               = {  94902, 452413, 1 }, -- Immolation Aura has 2 yd increased radius and 30% increased critical strike damage bonus.
    focused_hatred           = {  94918, 452405, 1 }, -- Demonsurge deals 50% increased damage when it strikes a single target. Each additional target reduces this bonus by 10%.
    improved_soul_rending    = {  94899, 452407, 1 }, -- Leech granted by Soul Rending increased by 2% and an additional 2% while Metamorphosis is active.
    monster_rising           = {  94909, 452414, 1 }, -- Agility increased by 8% while not in demon form.
    pursuit_of_angriness     = {  94913, 452404, 1 }, -- Movement speed increased by 1% per 10 Fury.
    set_fire_to_the_pain     = {  94899, 452406, 1 }, -- 5% of all non-Fire damage taken is instead taken as Fire damage over 6 sec. Fire damage taken reduced by 10%.
    student_of_suffering     = {  94902, 452412, 1 }, -- Sigil of Flame applies Student of Suffering to you, increasing Mastery by 18.0% and granting 5 Fury every 2 sec, for 6 sec.
    untethered_fury          = {  94904, 452411, 1 }, -- Maximum Fury increased by 50.
    violent_transformation   = {  94912, 452409, 1 }, -- When you activate Metamorphosis, the cooldowns of your Sigil of Flame and Immolation Aura are immediately reset.
    wave_of_debilitation     = {  94913, 452403, 1 }, -- Chaos Nova slows enemies by 60% and reduces attack and cast speed 15% for 5 sec after its stun fades. 
} )

-- PvP Talents
spec:RegisterPvpTalents( { 
    blood_moon        = 5433, -- (355995) 
    cleansed_by_flame =  805, -- (205625) 
    cover_of_darkness = 1206, -- (357419) 
    detainment        =  812, -- (205596) 
    glimpse           =  813, -- (354489) 
    illidans_grasp    = 5691, -- (205630) You strangle the target with demonic magic, stunning them in place and dealing 120,508 Shadow damage over 5 sec while the target is grasped. Can move while channeling. Use Illidan's Grasp again to toss the target to a location within 20 yards.
    rain_from_above   =  811, -- (206803) You fly into the air out of harm's way. While floating, you gain access to Fel Lance allowing you to deal damage to enemies below. 
    reverse_magic     =  806, -- (205604) Removes all harmful magical effects from yourself and all nearby allies within 10 yards, and sends them back to their original caster if possible.
    sigil_mastery     = 5523, -- (211489) 
    unending_hatred   = 1218, -- (213480) 
} )

-- Auras
spec:RegisterAuras( {
    -- $w1 Soul Fragments consumed. At $?a212612[$442290s1~][$442290s2~], Reaver's Glaive is available to cast.
    art_of_the_glaive = {
        id = 444661,
        duration = 30.0,
        max_stack = 6
    },
    -- Dodge chance increased by $s2%.
    -- https://wowhead.com/beta/spell=188499
    blade_dance = {
        id = 188499,
        duration = 1,
        max_stack = 1
    },
    -- Damage taken reduced by $s1%.
    blade_ward = {
        id = 442715,
        duration = 5.0,
        max_stack = 1
    },
    blazing_slaughter = {
        id = 355892,
        duration = 12,
        max_stack = 20
    },
    -- Versatility increased by $w1%.
    -- https://wowhead.com/beta/spell=355894
    blind_faith = {
        id = 355894,
        duration = 20,
        max_stack = 1
    },
    -- Dodge increased by $s2%. Damage taken reduced by $s3%.
    -- https://wowhead.com/beta/spell=212800
    blur = {
        id = 212800,
        duration = 10,
        max_stack = 1
    },
    -- https://www.wowhead.com/spell=453177
    burning_blades = {
        id = 453177,
        duration = 6,
        max_stack = 1
    },
    -- Talent: Taking $w1 Chaos damage every $t1 seconds.  Damage taken from $@auracaster's Immolation Aura increased by $s2%.
    -- https://wowhead.com/beta/spell=391191
    burning_wound_391191 = {
        id = 391191,
        duration = 15,
        tick_time = 3,
        max_stack = 1
    },
    burning_wound_346278 = {
        id = 346278,
        duration = 15,
        tick_time = 3,
        max_stack = 1
    },
    burning_wound = {
        alias = { "burning_wound_391191", "burning_wound_346278" },
        aliasMode = "first",
        aliasType = "buff"
    },
    -- Talent: Stunned.
    -- https://wowhead.com/beta/spell=179057
    chaos_nova = {
        id = 179057,
        duration = function () return talent.isolated_prey.enabled and active_enemies == 1 and 4 or 2 end,
        type = "Magic",
        max_stack = 1
    },
    chaos_theory = {
        id = 390195,
        duration = 8,
        max_stack = 1
    },
    chaotic_blades = {
        id = 337567,
        duration = 8,
        max_stack = 1
    },
    cycle_of_hatred = {
        id = 1214887,
        duration = 3600,
        max_stack = 4
    },
    darkness = {
        id = 196718,
        duration = function () return pvptalent.cover_of_darkness.enabled and 10 or 8 end,
        max_stack = 1
    },
    death_sweep = {
        id = 210152,
        duration = 1,
        max_stack = 1
    },
    -- https://www.wowhead.com/spell=427901
    -- Deflecting Dance Absorbing 1180318 damage.
    deflecting_dance = {
        id = 427901,
        duration = 1,
        max_stack = 1
    },
    demon_soul = {
        id = 347765,
        duration = 15,
        max_stack = 1
    },
    -- https://www.wowhead.com/spell=452416
    -- Demonsurge Damage of your next Demonsurge is increased by 40%.
    demonsurge = {
        id = 452416,
        duration = 12,
        max_stack = 10
    },
    -- Fake buffs for demonsurge damage procs
    demonsurge_abyssal_gaze = {},
    demonsurge_annihilation = {},
    demonsurge_consuming_fire = {},
    demonsurge_death_sweep = {},
    demonsurge_hardcast = {},
    demonsurge_sigil_of_doom = {},
    -- TODO: This aura determines sigil pop time.
    elysian_decree = {
        id = 390163,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1,
        copy = "sigil_of_spite"
    },
    -- https://www.wowhead.com/spell=453314
    -- Enduring Torment Chaos Strike and Blade Dance damage increased by 10%. Haste increased by 5%.
    enduring_torment = {
        id = 453314,
        duration = 3600,
        max_stack = 1
    },
    essence_break = {
        id = 320338,
        duration = 4,
        max_stack = 1,
        copy = "dark_slash" -- Just in case.
    },
    -- Vengeful Retreat may be cast again.
    evasive_action = {
        id = 444929,
        duration = 3.0,
        max_stack = 1,
    },
    -- https://wowhead.com/beta/spell=198013
    eye_beam = {
        id = 198013,
        duration = function () return 2 * ( 1 + 0.1 * talent.blind_fury.rank ) * haste end,
        generate = function( t )
            if buff.casting.up and buff.casting.v1 == 198013 then
                t.applied  = buff.casting.applied
                t.duration = buff.casting.duration
                t.expires  = buff.casting.expires
                t.stack    = 1
                t.caster   = "player"
                forecastResources( "fury" )
                return
            end

            t.applied  = 0
            t.duration = class.auras.eye_beam.duration
            t.expires  = 0
            t.stack    = 0
            t.caster   = "nobody"
        end,
        tick_time = 0.2,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Unleashing Fel.
    -- https://wowhead.com/beta/spell=258925
    fel_barrage = {
        id = 258925,
        duration = 8,
        tick_time = 0.25,
        max_stack = 1
    },
    -- Legendary.
    fel_bombardment = {
        id = 337849,
        duration = 40,
        max_stack = 5,
    },
    -- Legendary
    fel_devastation = {
        id = 333105,
        duration = 2,
        max_stack = 1,
    },
    furious_gaze = {
        id = 343312,
        duration = 10,
        max_stack = 1,
    },
    -- Talent: Stunned.
    -- https://wowhead.com/beta/spell=211881
    fel_eruption = {
        id = 211881,
        duration = 4,
        max_stack = 1
    },
    -- Talent: Movement speed increased by $w1%.
    -- https://wowhead.com/beta/spell=389847
    felfire_haste = {
        id = 389847,
        duration = 8,
        max_stack = 1,
        copy = 338804
    },
    -- Branded, dealing $204021s1% less damage to $@auracaster$?s389220[ and taking $w2% more Fire damage from them][].
    -- https://wowhead.com/beta/spell=207744
    fiery_brand = {
        id = 207744,
        duration = 10,
        max_stack = 1
    },
    -- Talent: Battling a demon from the Theater of Pain...
    -- https://wowhead.com/beta/spell=391430
    fodder_to_the_flame = {
        id = 391430,
        duration = 25,
        max_stack = 1,
        copy = { 329554, 330910 }
    },
    -- The demon is linked to you.
    fodder_to_the_flame_chase = {
        id = 328605,
        duration = 3600,
        max_stack = 1,
    },
    -- This is essentially the countdown before the demon despawns (you can Imprison it for a long time).
    fodder_to_the_flame_cooldown = {
        id = 342357,
        duration = 120,
        max_stack = 1,
    },
    -- Falling speed reduced.
    -- https://wowhead.com/beta/spell=131347
    glide = {
        id = 131347,
        duration = 3600,
        max_stack = 1
    },
    -- Burning nearby enemies for $258922s1 $@spelldesc395020 damage every $t1 sec.$?a207548[    Movement speed increased by $w4%.][]$?a320331[    Armor increased by $w5%. Attackers suffer $@spelldesc395020 damage.][]
    -- https://wowhead.com/beta/spell=258920
    immolation_aura_1 = {
        id = 258920,
        duration = function() return talent.felfire_heart.enabled and 8 or 6 end,
        tick_time = 1,
        max_stack = 1
    },
    immolation_aura_2 = {
        id = 427912,
        duration = function() return talent.felfire_heart.enabled and 8 or 6 end,
        tick_time = 1,
        max_stack = 1
    },
    immolation_aura_3 = {
        id = 427913,
        duration = function() return talent.felfire_heart.enabled and 8 or 6 end,
        tick_time = 1,
        max_stack = 1
    },
    immolation_aura_4 = {
        id = 427914,
        duration = function() return talent.felfire_heart.enabled and 8 or 6 end,
        tick_time = 1,
        max_stack = 1
    },
    immolation_aura_5 = {
        id = 427915,
        duration = function() return talent.felfire_heart.enabled and 8 or 6 end,
        tick_time = 1,
        max_stack = 1
    },
    immolation_aura = {
        alias = { "immolation_aura_1", "immolation_aura_2", "immolation_aura_3", "immolation_aura_4", "immolation_aura_5" },
        aliasMode = "longest",
        aliasType = "buff",
        max_stack = 5
    },
    -- Talent: Incapacitated.
    -- https://wowhead.com/beta/spell=217832
    imprison = {
        id = 217832,
        duration = 60,
        mechanic = "sap",
        type = "Magic",
        max_stack = 1
    },
    -- Damage done increased by $w1%.
    inertia_damage_buff = { -- find out what simc is gonna use
        id = 427641,
        duration = 5,
        max_stack = 1,
        copy = "inertia"
    },
    -- https://www.wowhead.com/spell=1215159
    -- Inertia Your next Fel Rush or Felblade increases your damage by 18% for 5 sec.
    inertia_prep_buff = { -- find out what simc is gonna use
        id = 1215159,
        duration = 12,
        max_stack = 1,
        copy = "inertia_trigger"
    },
    initiative = {
        id = 391215,
        duration = 5,
        max_stack = 1
    },
    initiative_tracker = {
        duration = 3600,
        max_stack = 1
    },
    inner_demon = {
        id = 337313,
        duration = 10,
        max_stack = 1,
        copy = 390145
    },
    -- Talent: Movement speed reduced by $s1%.
    -- https://wowhead.com/beta/spell=213405
    master_of_the_glaive = {
        id = 213405,
        duration = 6,
        mechanic = "snare",
        max_stack = 1
    },
    -- Chaos Strike and Blade Dance upgraded to $@spellname201427 and $@spellname210152.  Haste increased by $w4%.$?s235893[  Versatility increased by $w5%.][]$?s204909[  Leech increased by $w3%.][]
    -- https://wowhead.com/beta/spell=162264
    metamorphosis = {
        id = 162264,
        duration = 20,
        max_stack = 1,
        --[[meta = {
            extended_by_demonic = function ()
                return false -- disabled in 8.0:  talent.demonic.enabled and ( buff.metamorphosis.up and buff.metamorphosis.duration % 15 > 0 and buff.metamorphosis.duration > ( action.eye_beam.cast + 8 ) )
            end,
        },--]]
    },
    exergy = {
        id = 208628,
        duration = 30, -- extends up to 30
        max_stack = 1,
        copy = "momentum"
    },
    -- Agility increased by $w1%.
    monster_rising = {
        id = 452550,
        duration = 3600,
        max_stack = 1,
    },
    -- Stunned.
    -- https://wowhead.com/beta/spell=200166
    metamorphosis_stun = {
        id = 200166,
        duration = 3,
        type = "Magic",
        max_stack = 1
    },
    -- Dazed.
    -- https://wowhead.com/beta/spell=247121
    metamorphosis_daze = {
        id = 247121,
        duration = 3,
        type = "Magic",
        max_stack = 1
    },
    misery_in_defeat = {
        id = 391369,
        duration = 5,
        max_stack = 1,
    },
    -- Talent: Healing effects received reduced by $w1%.
    -- https://wowhead.com/beta/spell=356608
    mortal_dance = {
        id = 356608,
        duration = 6,
        max_stack = 1
    },
    -- Talent: Immune to damage and unable to attack.  Movement speed increased by $s3%.
    -- https://wowhead.com/beta/spell=196555
    netherwalk = {
        id = 196555,
        duration = 6,
        max_stack = 1
    },
    -- $w3
    pursuit_of_angriness = {
        id = 452404,
        duration = 0.0,
        tick_time = 1.0,
        max_stack = 1,
    },
    ragefire = {
        id = 390192,
        duration = 30,
        max_stack = 1,
    },
    rain_from_above_immune = {
        id = 206803,
        duration = 1,
        tick_time = 1,
        max_stack = 1,
        copy = "rain_from_above_launch"
    },
    rain_from_above = { -- Gliding/floating.
        id = 206804,
        duration = 10,
        max_stack = 1
    },
    reavers_glaive = {
        -- no id, fake buff
        duration = 3600,
        max_Stack = 1
    },
    restless_hunter = {
        id = 390212,
        duration = 12,
        max_stack = 1
    },
    -- Damage taken from Chaos Strike and Throw Glaive increased by $w1%.
    serrated_glaive = {
        id = 390155,
        duration = 15,
        max_stack = 1,
    },
    -- Taking $w1 Fire damage every $t1 sec.
    set_fire_to_the_pain = {
        id = 453286,
        duration = 6.0,
        tick_time = 1.0,
    },
    -- Movement slowed by $s1%.
    -- https://wowhead.com/beta/spell=204843
    sigil_of_chains = {
        id = 204843,
        duration = function() return 6 + talent.extended_sigils.rank + ( talent.precise_sigils.enabled and 2 or 0 ) end,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Suffering $w2 $@spelldesc395020 damage every $t2 sec.
    -- https://wowhead.com/beta/spell=204598
    sigil_of_flame_dot = {
        id = 204598,
        duration = function() return ( talent.felfire_heart.enabled and 8 or 6 ) + talent.extended_sigils.rank + ( talent.precise_sigils.enabled and 2 or 0 ) end,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Sigil of Flame is active.
    -- https://wowhead.com/beta/spell=389810
    sigil_of_flame = {
        id = 389810,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1,
        copy = 204596
    },
    -- Talent: Disoriented.
    -- https://wowhead.com/beta/spell=207685
    sigil_of_misery_debuff = {
        id = 207685,
        duration = function() return 15 + talent.extended_sigils.rank + ( talent.precise_sigils.enabled and 2 or 0 ) end,
        mechanic = "flee",
        type = "Magic",
        max_stack = 1
    },
    sigil_of_misery = { -- TODO: Model placement pop.
        id = 207684,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1
    },
    -- Silenced.
    -- https://wowhead.com/beta/spell=204490
    sigil_of_silence_debuff = {
        id = 204490,
        duration = function() return 6 + talent.extended_sigils.rank + ( talent.precise_sigils.enabled and 2 or 0 ) end,
        type = "Magic",
        max_stack = 1
    },
    sigil_of_silence = { -- TODO: Model placement pop.
        id = 202137,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1
    },
    -- Consume to heal for $210042s1% of your maximum health.
    -- https://wowhead.com/beta/spell=203795
    soul_fragment = {
        id = 203795,
        duration = 20,
        max_stack = 1
    },
    -- Talent: Suffering $w1 Chaos damage every $t1 sec.
    -- https://wowhead.com/beta/spell=390181
    soulscar = {
        id = 390181,
        duration = 6,
        tick_time = 2,
        max_stack = 1
    },
    -- Can see invisible and stealthed enemies.  Can see enemies and treasures through physical barriers.
    -- https://wowhead.com/beta/spell=188501
    spectral_sight = {
        id = 188501,
        duration = 10,
        max_stack = 1
    },
    -- Mastery increased by ${$w1*$mas}.1%. ; Generating $453236s1 Fury every $t2 sec.
    student_of_suffering = {
        id = 453239,
        duration = 6,
        tick_time = 2.0,
        max_stack = 1,
    },
    tactical_retreat = {
        id = 389890,
        duration = 8,
        tick_time = 1,
        max_stack = 1
    },
    -- Talent: Suffering $w1 $@spelldesc395042 damage every $t1 sec.
    -- https://wowhead.com/beta/spell=345335
    the_hunt_dot = {
        id = 370969,
        duration = function() return set_bonus.tier31_4pc > 0 and 12 or 6 end,
        tick_time = 2,
        type = "Magic",
        max_stack = 1,
        copy = 345335
    },
    -- Talent: Marked by the Demon Hunter, converting $?c1[$345422s1%][$345422s2%] of the damage done to healing.
    -- https://wowhead.com/beta/spell=370966
    the_hunt = {
        id = 370966,
        duration = 30,
        max_stack = 1,
        copy = 323802
    },
    the_hunt_root = {
        id = 370970,
        duration = 1.5,
        max_stack = 1,
        copy = 323996
    },
    -- Attack Speed increased by $w1%
    thrill_of_the_fight = {
        id = 442695,
        duration = 20.0,
        max_stack = 1,
    },
    -- Taunted.
    -- https://wowhead.com/beta/spell=185245
    torment = {
        id = 185245,
        duration = 3,
        max_stack = 1
    },
    -- Talent: Suffering $w1 Chaos damage every $t1 sec.
    -- https://wowhead.com/beta/spell=258883
    trail_of_ruin = {
        id = 258883,
        duration = 4,
        tick_time = 1,
        type = "Magic",
        max_stack = 1
    },
    unbound_chaos = {
        id = 347462,
        duration = 20,
        max_stack = 1,
        -- copy = "inertia_trigger"
    },
    vengeful_retreat_movement = {
        duration = 1,
        max_stack = 1,
        generate = function( t )
            if action.vengeful_retreat.lastCast > query_time - 1 then
                t.applied  = action.vengeful_retreat.lastCast
                t.duration = 1
                t.expires  = action.vengeful_retreat.lastCast + 1
                t.stack    = 1
                t.caster   = "player"
                return
            end

            t.applied  = 0
            t.duration = 1
            t.expires  = 0
            t.stack    = 0
            t.caster   = "nobody"
        end,
    },
    -- Talent: Movement speed reduced by $s1%.
    -- https://wowhead.com/beta/spell=198813
    vengeful_retreat = {
        id = 198813,
        duration = 3,
        max_stack = 1,
        copy = "vengeful_retreat_snare"
    },
    -- Your next $?a212612[Chaos Strike]?s263642[Fracture][Shear] will deal $442507s1 additional Physical damage.
    warblades_hunger = {
        id = 442503,
        duration = 30.0,
        max_stack = 1,
    },

    -- Conduit
    exposed_wound = {
        id = 339229,
        duration = 10,
        max_stack = 1,
    },

    -- PvP Talents
    chaotic_imprint_shadow = {
        id = 356656,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_nature = {
        id = 356660,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_arcane = {
        id = 356658,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_fire = {
        id = 356661,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_frost = {
        id = 356659,
        duration = 20,
        max_stack = 1,
    },
    -- Conduit
    demonic_parole = {
        id = 339051,
        duration = 12,
        max_stack = 1
    },
    glimpse = {
        id = 354610,
        duration = 8,
        max_stack = 1,
    },
} )


local sigils = setmetatable( {}, {
    __index = function( t, k )
        t[ k ] = 0
        return t[ k ]
    end
} )

spec:RegisterStateFunction( "create_sigil", function( sigil )
    sigils[ sigil ] = query_time + activation_time
    if sigil == "sigil_of_spite" or "elysian_decree" then return end

    local effect = ( "sigil_of_" .. sigil )
    applyDebuff( "target", effect )
    debuff[ effect ].applied = debuff[ effect ].applied + 1
    debuff[ effect ].expires = debuff[ effect ].expires + 1
end )

spec:RegisterStateExpr( "soul_fragments", function ()
    return GetSpellCastCount(232893) -- only works with Reaver hero tree
end )

spec:RegisterStateTable( "fragments", {
    real = 0,
    realTime = 0,
} )

spec:RegisterStateFunction( "queue_fragments", function( num, extraTime )
    fragments.real = fragments.real + num
    fragments.realTime = GetTime() + 1.25 + ( extraTime or 0 )
end )

spec:RegisterStateFunction( "purge_fragments", function()
    fragments.real = 0
    fragments.realTime = 0
end )

local last_darkness = 0
-- local last_metamorphosis = 0
-- local last_eye_beam = 0

spec:RegisterStateExpr( "darkness_applied", function ()
    return max( class.abilities.darkness.lastCast, last_darkness )
end )

--[[spec:RegisterStateExpr( "metamorphosis_applied", function ()
    return max( class.abilities.darkness.lastCast, last_metamorphosis )
end )--]]

--[[spec:RegisterStateExpr( "eye_beam_applied", function ()
    return max( class.abilities.eye_beam.lastCast, last_eye_beam )
end )--]]

spec:RegisterStateExpr( "extended_by_demonic", function ()
    return buff.metamorphosis.up and buff.metamorphosis.extended_by_demonic
end )

local activation_time = function ()
    return talent.quickened_sigils.enabled and 1 or 2
end

spec:RegisterStateExpr( "activation_time", activation_time )

local sigil_placed = function ()
    return sigils.flame > query_time
end

spec:RegisterStateExpr( "sigil_placed", sigil_placed )

spec:RegisterStateExpr( "meta_cd_multiplier", function ()
    return 1
end )


local furySpent = 0

local FURY = Enum.PowerType.Fury
local lastFury = -1

spec:RegisterUnitEvent( "UNIT_POWER_FREQUENT", "player", nil, function( event, unit, powerType )
    if powerType == "FURY" and state.set_bonus.tier30_2pc > 0 then
        local current = UnitPower( "player", FURY )

        if current < lastFury - 3 then
            furySpent = ( furySpent + lastFury - current )
        end

        lastFury = current
    end
end )

spec:RegisterStateExpr( "fury_spent", function ()
    if set_bonus.tier30_2pc == 0 then return 0 end
    return furySpent
end )

local queued_frag_modifier = 0
local initiative_actual, initiative_virtual = {}, {}

local death_events = {
    UNIT_DIED               = true,
    UNIT_DESTROYED          = true,
    UNIT_DISSIPATES         = true,
    PARTY_KILL              = true,
    SPELL_INSTAKILL         = true,
}

spec:RegisterHook( "COMBAT_LOG_EVENT_UNFILTERED", function( _, subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName )
    if sourceGUID == GUID then
        if subtype == "SPELL_CAST_SUCCESS" then
            -- Fracture:  Generate 2 frags.
            if spellID == 263642 then
                queue_fragments( 2 )
            end

            -- Shear:  Generate 1 frag.
            if spellID == 203782 then
                queue_fragments( 1 )
            end

            if spellID == 198793 and talent.initiative.enabled then
                wipe( initiative_actual )
            end

        elseif spellID == 203981 and fragments.real > 0 and ( subtype == "SPELL_AURA_APPLIED" or subtype == "SPELL_AURA_APPLIED_DOSE" ) then
            fragments.real = fragments.real - 1

        elseif state.set_bonus.tier30_2pc > 0 and subtype == "SPELL_AURA_APPLIED" and spellID == 408737 then
            furySpent = max( 0, furySpent - 175 )

        elseif state.talent.initiative.enabled and subtype == "SPELL_DAMAGE" then
            initiative_actual[ destGUID ] = true
        end
    elseif destGUID == GUID and ( subtype == "SPELL_DAMAGE" or subtype == "SPELL_PERIODIC_DAMAGE" ) then
        initiative_actual[ sourceGUID ] = true

    elseif death_events[ subtype ] then
        initiative_actual[ destGUID ] = nil
    end
end, false )

spec:RegisterEvent( "PLAYER_REGEN_ENABLED", function()
    wipe( initiative_actual )
end )

spec:RegisterHook( "UNIT_ELIMINATED", function( id )
    initiative_actual[ id ] = nil
end )

-- Gear Sets
spec:RegisterGear( "tier29", 200345, 200347, 200342, 200344, 200346 )
spec:RegisterAura( "seething_chaos", {
    id = 394934,
    duration = 6,
    max_stack = 1
} )

-- Tier 30
spec:RegisterGear( "tier30", 202527, 202525, 202524, 202523, 202522 )
-- 2 pieces (Havoc) : Every 175 Fury you spend, gain Seething Fury, increasing your Agility by 8% for 6 sec.
-- TODO: Track Fury spent toward Seething Fury.  New expressions: seething_fury_threshold, seething_fury_spent, seething_fury_deficit.
spec:RegisterAura( "seething_fury", {
    id = 408737,
    duration = 6,
    max_stack = 1
} )
-- 4 pieces (Havoc) : Each time you gain Seething Fury, gain 15 Fury and the damage of your next Eye Beam is increased by 15%, stacking 5 times.
spec:RegisterAura( "seething_potential", {
    id = 408754,
    duration = 60,
    max_stack = 5
} )

spec:RegisterGear( "tier31", 207261, 207262, 207263, 207264, 207266, 217228, 217230, 217226, 217227, 217229 )
-- (2) Blade Dance automatically triggers Throw Glaive on your primary target for $s3% damage and each slash has a $s2% chance to Throw Glaive an enemy for $s1% damage.
-- (4) Throw Glaive reduces the remaining cooldown of The Hunt by ${$s1/1000}.1 sec, and The Hunt's damage over time effect lasts ${$s2/1000} sec longer.

spec:RegisterGear( "tww2", 229316, 229314, 229319, 229317, 229315 )
spec:RegisterAuras( {
    -- 2-set
    -- Winning Streak! Increase the DPS of Blade Dance and Chaos Strike by 3% stacking pu to 10 times. Blade Dance and Chaos Strike have 15% chance of removing Winning Streak! .
    winning_streak = {
        id = 1217011,
        duration = 3600,
        max_stack = 10
        },
    --4-set
    -- Winning Streak persists for 7s after being cancelled. Entering Demon Form sacrifices all Winning Streak! stacks to gain 0% (?) Crit Strike Chance per stack consumed. Lasts 15s
    necessary_sacrifice = {
    id = 1217055,
    duration = 15,
    max_stack = 10
    },
    -- https://www.wowhead.com/spell=1220706
    -- Winning Streak! Ending a Winning Streak! Blade Dance and Chaos Strike damage increased by 6%.
    winning_streak_temporary = {
        id = 1220706,
        duration = 7,
        max_stack = 10
    },

} )

spec:RegisterGear( "tww1", 212068, 212066, 212065, 212064, 212063 )
spec:RegisterAura( "blade_rhapsody", {
    id = 454628,
    duration = 12,
    max_stack = 1
} )



local sigil_types = {
    chains         = "sigil_of_chains" ,
    flame          = "sigil_of_flame"  ,
    misery         = "sigil_of_misery" ,
    silence        = "sigil_of_silence",
    spite          = "sigil_of_spite",
    elysian_decree = "elysian_decree"
}

spec:RegisterHook( "reset_precast", function ()
    -- last_metamorphosis = nil
    last_infernal_strike = nil

    wipe( initiative_virtual )
    active_dot.initiative_tracker = 0

    for k, v in pairs( initiative_actual ) do
        initiative_virtual[ k ] = v

        if k == target.unit then
            applyDebuff( "target", "initiative_tracker" )
        else
            active_dot.initiative_tracker = active_dot.initiative_tracker + 1
        end
    end

    for s, a in ipairs( sigil_types ) do
        local activation = ( action[ a ].lastCast or 0 ) + ( talent.quickened_sigils.enabled and 2 or 1 )
        if activation > now then sigils[ s ] = activation
        else sigils[ s ] = 0 end
    end

    last_darkness = 0
    -- last_metamorphosis = 0
    -- last_eye_beam = 0

    local rps = 0

    if equipped.convergence_of_fates then
        rps = rps + ( 3 / ( 60 / 4.35 ) )
    end

    if equipped.delusions_of_grandeur then
        -- From SimC model, 1/13/2018.
        local fps = 10.2 + ( talent.demonic.enabled and 1.2 or 0 )

        -- SimC uses base haste, we'll use current since we recalc each time.
        fps = fps / haste

        -- Chaos Strike accounts for most Fury expenditure.
        fps = fps + ( ( fps * 0.9 ) * 0.5 * ( 40 / 100 ) )

        rps = rps + ( fps / 30 ) * ( 1 )
    end

    meta_cd_multiplier = 1 / ( 1 + rps )

    if IsSpellKnownOrOverridesKnown( 442294 ) then
        applyBuff( "reavers_glaive" )
        if Hekili.ActiveDebug then Hekili:Debug( "Applied Reaver's Glaive." ) end
    end

    if talent.demonsurge.enabled and buff.metamorphosis.up then
        local metaRemains = buff.metamorphosis.remains

        if IsSpellOverlayed( 201427 ) then applyBuff( "demonsurge_annihilation", metaRemains ) end
        if IsSpellOverlayed( 210152 ) then applyBuff( "demonsurge_death_sweep", metaRemains ) end

        if talent.demonic_intensity.enabled then

            if IsSpellOverlayed( 452497 ) then applyBuff( "demonsurge_abyssal_gaze", metaRemains ) end
            if IsSpellOverlayed( 452487 ) then applyBuff( "demonsurge_consuming_fire", metaRemains ) end
            if IsSpellOverlayed( 469991 ) then applyBuff( "demonsurge_sigil_of_doom", metaRemains ) end

            -- setCooldown( "eye_beam", max( cooldown.abyssal_gaze.remains, cooldown.eye_beam.remains, buff.metamorphosis.remains ) ) -- To support cooldown.eye_beam.up checks in SimC priority.
        end

        if Hekili.ActiveDebug then
            Hekili:Debug( "Demon Surge status:\n" ..
                -- " - Hardcast " .. ( buff.demonsurge_hardcast.up and "ACTIVE" or "INACTIVE" ) .. "\n" ..
                -- " - Demonic " .. ( buff.demonsurge_demonic.up and "ACTIVE" or "INACTIVE" ) .. "\n" ..
                " - Abyssal Gaze " .. ( buff.demonsurge_abyssal_gaze.up and "ACTIVE" or "INACTIVE" ) .. "\n" ..
                " - Annihilation " .. ( buff.demonsurge_annihilation.up and "ACTIVE" or "INACTIVE" ) .. "\n" ..
                " - Consuming Fire " .. ( buff.demonsurge_consuming_fire.up and "ACTIVE" or "INACTIVE" ) .. "\n" ..
                " - Death Sweep " .. ( buff.demonsurge_death_sweep.up and "ACTIVE" or "INACTIVE" ) .. "\n" ..
                " - Sigil of Doom " .. ( buff.demonsurge_sigil_of_doom.up and "ACTIVE" or "INACTIVE" ) )
        end
    end

    fury_spent = nil
end )


spec:RegisterHook( "runHandler", function( action )
    local ability = class.abilities[ action ]

    if ability.startsCombat and not debuff.initiative_tracker.up then
        applyBuff( "initiative" )
        applyDebuff( "target", "initiative_tracker" )
    end
end )


spec:RegisterHook( "advance_end", function( time )
    if query_time - time < sigils.flame and query_time >= sigils.flame then
        -- SoF should've applied.
        applyDebuff( "target", "sigil_of_flame", debuff.sigil_of_flame.duration - ( query_time - sigils.flame ) )
        active_dot.sigil_of_flame = active_enemies
        sigils.flame = 0
    end
end )


spec:RegisterHook( "spend", function( amt, resource )
    if set_bonus.tier30_2pc == 0 or amt < 0 or resource ~= "fury" then return end

    fury_spent = fury_spent + amt
    if fury_spent > 175 then
        fury_spent = fury_spent - 175
        applyBuff( "seething_fury" )
        if set_bonus.tier30_4pc > 0 then
            gain( 15, "fury" )
            applyBuff( "seething_potential" )
        end
    end
end )




spec:RegisterGear( "tier19", 138375, 138376, 138377, 138378, 138379, 138380 )
spec:RegisterGear( "tier20", 147130, 147132, 147128, 147127, 147129, 147131 )
spec:RegisterGear( "tier21", 152121, 152123, 152119, 152118, 152120, 152122 )
    spec:RegisterAura( "havoc_t21_4pc", {
        id = 252165,
        duration = 8
    } )

spec:RegisterGear( "class", 139715, 139716, 139717, 139718, 139719, 139720, 139721, 139722 )

spec:RegisterGear( "convergence_of_fates", 140806 )

spec:RegisterGear( "achor_the_eternal_hunger", 137014 )
spec:RegisterGear( "anger_of_the_halfgiants", 137038 )
spec:RegisterGear( "cinidaria_the_symbiote", 133976 )
spec:RegisterGear( "delusions_of_grandeur", 144279 )
spec:RegisterGear( "kiljaedens_burning_wish", 144259 )
spec:RegisterGear( "loramus_thalipedes_sacrifice", 137022 )
spec:RegisterGear( "moarg_bionic_stabilizers", 137090 )
spec:RegisterGear( "prydaz_xavarics_magnum_opus", 132444 )
spec:RegisterGear( "raddons_cascading_eyes", 137061 )
spec:RegisterGear( "sephuzs_secret", 132452 )
spec:RegisterGear( "the_sentinels_eternal_refuge", 146669 )

spec:RegisterGear( "soul_of_the_slayer", 151639 )
spec:RegisterGear( "chaos_theory", 151798 )
spec:RegisterGear( "oblivions_embrace", 151799 )


do
    local wasWarned = false

    spec:RegisterEvent( "PLAYER_REGEN_DISABLED", function ()
        if state.talent.demon_blades.enabled and not state.settings.demon_blades_acknowledged and not wasWarned then
            Hekili:Notify( "|cFFFF0000WARNING!|r  Fury from Demon Blades is forecasted very conservatively.\nSee /hekili > Havoc for more information." )
            wasWarned = true
        end
    end )
end


local TriggerDemonic = setfenv( function( )

    local demonicExtension = 7

    if buff.metamorphosis.up then
        buff.metamorphosis.expires = buff.metamorphosis.expires + demonicExtension
    else
        applyBuff( "metamorphosis", demonicExtension )
        if talent.inner_demon.enabled then
            applyBuff( "inner_demon" )
        end
        stat.haste = stat.haste + 10
        -- Fel-Scarred
        if talent.demonsurge.enabled then
            local metaRemains = buff.metamorphosis.remains
            applyBuff( "demonsurge_annihilation", metaRemains )
            applyBuff( "demonsurge_death_sweep", metaRemains)
        end
    end

end, state )

-- Abilities
spec:RegisterAbilities( {
    annihilation = {
        id = 201427,
        known = 162794,
        flash = { 201427, 162794 },
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 40,
        spendType = "fury",

        startsCombat = true,
        texture = 1303275,

        bind = "chaos_strike",
        buff = "metamorphosis",

        handler = function ()
            spec.abilities.chaos_strike.handler()
            -- Felscarred
            if talent.demonic_intensity.enabled and buff.demonsurge_annihilation.up then
                addStack( "demonsurge" )
                removeBuff( "demonsurge_annihilation" )
            end
        end,
    },

    -- Strike $?a206416[your primary target for $<firstbloodDmg> Chaos damage and ][]all nearby enemies for $<baseDmg> Physical damage$?s320398[, and increase your chance to dodge by $193311s1% for $193311d.][. Deals reduced damage beyond $199552s1 targets.]
    blade_dance = {
        id = 188499,
        flash = { 188499, 210152 },
        cast = 0,
        cooldown = 10,
        hasteCD = true,
        gcd = "spell",
        school = "physical",

        spend = function() return 35 * ( buff.blade_rhapsody.up and 0.5 or 1 ) end,
        spendType = "fury",

        startsCombat = true,

        bind = "death_sweep",
        nobuff = "metamorphosis",

        handler = function ()
            -- Standard and Talents
            applyBuff( "blade_dance" )
            removeBuff( "restless_hunter" )
            setCooldown( "death_sweep", action.blade_dance.cooldown )
            if talent.chaos_theory.enabled then applyBuff( "chaos_theory" ) end
            if talent.screaming_brutality.enabled then spec.abilities.throw_glaive.handler() end
            if talent.mortal_dance.enabled then applyDebuff( "target", "mortal_dance" ) end

            -- TWW
            if set_bonus.tww1 >= 2 then removeBuff( "blade_rhapsody") end

            -- Hero Talents
            if buff.glaive_flurry.up then
                removeBuff( "glaive_flurry" )
                if talent.thrill_of_the_fight.enabled and buff.rending_strike.down then
                    applyBuff( "thrill_of_the_fight" )
                end
            end
        end,

        copy = "blade_dance1"
    },

    -- Increases your chance to dodge by $212800s2% and reduces all damage taken by $212800s3% for $212800d.
    blur = {
        id = 198589,
        cast = 0,
        cooldown = function () return 60 + ( conduit.fel_defender.mod * 0.001 ) end,
        gcd = "off",
        school = "physical",

        startsCombat = false,

        toggle = "defensives",

        handler = function ()
            applyBuff( "blur" )
        end,
    },

    -- Talent: Unleash an eruption of fel energy, dealing $s2 Chaos damage and stunning all nearby enemies for $d.$?s320412[    Each enemy stunned by Chaos Nova has a $s3% chance to generate a Lesser Soul Fragment.][]
    chaos_nova = {
        id = 179057,
        cast = 0,
        cooldown = 45,
        gcd = "spell",
        school = "chromatic",

        spend = 25,
        spendType = "fury",

        talent = "chaos_nova",
        startsCombat = true,

        toggle = "cooldowns",

        handler = function ()
            applyDebuff( "target", "chaos_nova" )
        end,
    },

    -- Slice your target for ${$222031s1+$199547s1} Chaos damage. Chaos Strike has a ${$min($197125h,100)}% chance to refund $193840s1 Fury.
    chaos_strike = {
        id = 162794,
        flash = { 162794, 201427 },
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "chaos",

        spend = 40,
        spendType = "fury",

        startsCombat = true,

        bind = "annihilation",
        nobuff = "metamorphosis",

        cycle = function () return ( talent.burning_wound.enabled or legendary.burning_wound.enabled ) and "burning_wound" or nil end,

        handler = function ()
            removeBuff( "inner_demon" )
            if buff.chaos_theory.up then
                gain( 20, "fury" )
                removeBuff( "chaos_theory" )
            end
            
            -- Reaver
            if buff.rending_strike.up then
                applyDebuff( "target", "reavers_mark" )
                removeBuff( "rending_strike" )
                if talent.thrill_of_the_fight.enabled and buff.glaive_flurry.down then
                    applyBuff( "thrill_of_the_fight" )
                end
            end
            removeBuff( "warblades_hunger" )

            -- Legacy
            removeBuff( "chaotic_blades" )
        end,
    },

    -- Talent: Consume $m1 beneficial Magic effect removing it from the target$?s320313[ and granting you $s2 Fury][].
    consume_magic = {
        id = 278326,
        cast = 0,
        cooldown = 10,
        gcd = "spell",
        school = "chromatic",

        startsCombat = false,
        talent = "consume_magic",

        toggle = "interrupts",

        usable = function () return buff.dispellable_magic.up end,
        handler = function ()
            removeBuff( "dispellable_magic" )
            if talent.swallowed_anger.enabled then gain( 20, "fury" ) end
        end,
    },

    -- Summons darkness around you in a$?a357419[ 12 yd][n 8 yd] radius, granting friendly targets a $209426s2% chance to avoid all damage from an attack. Lasts $d.; Chance to avoid damage increased by $s3% when not in a raid.
    darkness = {
        id = 196718,
        cast = 0,
        cooldown = 300,
        gcd = "spell",
        school = "physical",

        talent = "darkness",
        startsCombat = false,

        toggle = "defensives",

        handler = function ()
            last_darkness = query_time
            applyBuff( "darkness" )
        end,
    },


    death_sweep = {
        id = 210152,
        known = 188499,
        flash = { 210152, 188499 },
        cast = 0,
        cooldown = 9,
        hasteCD = true,
        gcd = "spell",

        spend = function() return 35 * ( buff.blade_rhapsody.up and 0.5 or 1 ) end,
        spendType = "fury",

        startsCombat = true,
        texture = 1309099,

        bind = "blade_dance",
        buff = "metamorphosis",

        handler = function ()
            spec.abilities.blade_dance.handler()
            applyBuff( "death_sweep" )
            setCooldown( "blade_dance", action.death_sweep.cooldown )

            -- Hero Talents
            if talent.demonic_intensity.enabled and buff.demonsurge_death_sweep.up then
                addStack( "demonsurge" )
                removeBuff( "demonsurge_death_sweep" )
            end
        end,
    },

    -- Quickly attack for $s2 Physical damage.    |cFFFFFFFFGenerates $?a258876[${$m3+$258876s3} to ${$M3+$258876s4}][$m3 to $M3] Fury.|r
    demons_bite = {
        id = 162243,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "physical",

        spend = function () return talent.insatiable_hunger.enabled and -25 or -20 end,
        spendType = "fury",

        startsCombat = true,

        notalent = "demon_blades",
        cycle = function () return ( talent.burning_wound.enabled or legendary.burning_wound.enabled ) and "burning_wound" or nil end,

        handler = function ()
            if talent.burning_wound.enabled then applyDebuff( "target", "burning_wound" ) end
        end,
    },

    -- Interrupts the enemy's spellcasting and locks them from that school of magic for $d.|cFFFFFFFF$?s183782[    Generates $218903s1 Fury on a successful interrupt.][]|r
    disrupt = {
        id = 183752,
        cast = 0,
        cooldown = 15,
        gcd = "off",
        school = "chromatic",

        startsCombat = true,

        toggle = "interrupts",

        debuff = "casting",
        readyTime = state.timeToInterrupt,

        handler = function ()
            interrupt()
            if talent.disrupting_fury.enabled then gain( 30, "fury" ) end
        end,
    },

    -- Talent: Slash all enemies in front of you for $s1 Chaos damage, and increase the damage your Chaos Strike and Blade Dance deal to them by $320338s1% for $320338d. Deals reduced damage beyond $s2 targets.
    essence_break = {
        id = 258860,
        cast = 0,
        cooldown = 40,
        gcd = "spell",
        school = "chromatic",

        talent = "essence_break",
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "essence_break" )
            active_dot.essence_break = max( 1, active_enemies )
        end,

        copy = "dark_slash"
    },

    -- Blasts all enemies in front of you,$?s320415[ dealing guaranteed critical strikes][] for up to $<dmg> Chaos damage over $d. Deals reduced damage beyond $s5 targets.$?s343311[; When Eye Beam finishes fully channeling, your Haste is increased by an additional $343312s1% for $343312d.][]
    eye_beam = {
        id = 198013,
        cast = function () return ( talent.blind_fury.enabled and 3 or 2 ) * haste end,
        channeled = true,
        cooldown = 40,
        gcd = "spell",
        school = "chromatic",

        spend = 30,
        spendType = "fury",

        talent = "eye_beam",
        startsCombat = true,
        nobuff = function () return talent.demonic_intensity.enabled and "metamorphosis" or nil end,

        start = function ()
            -- last_eye_beam = query_time
            applyBuff( "eye_beam" )
            if talent.cycle_of_hatred.enabled then
                reduceCooldown( "eye_beam", 5 * talent.cycle_of_hatred.rank * buff.cycle_of_hatred.stack )
                addStack( "cycle_of_hatred" )
                setCooldown( "abyssal_gaze", action.eye_beam.cooldown )
            end

            if talent.demonic.enabled then TriggerDemonic() end

        end,

        finish = function ()
            if talent.furious_gaze.enabled then applyBuff( "furious_gaze" ) end
        end,

        bind = "abyssal_gaze"
    },

    abyssal_gaze = {
        id = 452497,
        known = 198013,
        cast = function () return ( talent.blind_fury.enabled and 3 or 2 ) * haste end,
        channeled = true,
        cooldown = 40,
        gcd = "spell",
        school = "chromatic",

        spend = 30,
        spendType = "fury",

        talent = "demonic_intensity",
        buff = "metamorphosis",
        startsCombat = true,

        start = function ()
            -- last_eye_beam = query_time
            applyBuff( "eye_beam" )
            if talent.cycle_of_hatred.enabled then
                reduceCooldown( "abyssal_gaze", 5 * talent.cycle_of_hatred.rank * buff.cycle_of_hatred.stack )
                addStack( "cycle_of_hatred" )
                setCooldown( "eye_beam", action.abyssal_gaze.cooldown )
            end

            if talent.demonic_intensity.enabled and buff.demonsurge_abyssal_gaze.up then
                addStack( "demonsurge" )
                removeBuff( "demonsurge_abyssal_gaze" )
            end

            if talent.demonic.enabled then TriggerDemonic() end

            removeBuff( "seething_potential" )
        end,

        finish = function ()
            if talent.furious_gaze.enabled then applyBuff( "furious_gaze" ) end
        end,

        bind = "eye_beam"
    },

    -- Talent: Unleash a torrent of Fel energy over $d, inflicting ${(($d/$t1)+1)*$258926s1} Chaos damage to all enemies within $258926A1 yds. Deals reduced damage beyond $258926s2 targets.
    fel_barrage = {
        id = 258925,
        cast = 3,
        channeled = true,
        cooldown = 90,
        gcd = "spell",
        school = "chromatic",

        spend = 10,
        spendType = "fury",

        talent = "fel_barrage",
        startsCombat = false,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "fel_barrage" )
        end,
    },

    -- Impales the target for $s1 Chaos damage and stuns them for $d.
    fel_eruption = {
        id = 211881,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "chromatic",

        spend = 10,
        spendType = "fury",

        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "fel_eruption" )
        end,
    },


    fel_lance = {
        id = 206966,
        cast = 1,
        cooldown = 0,
        gcd = "spell",

        pvptalent = "rain_from_above",
        buff = "rain_from_above",

        startsCombat = true,
    },

    -- Rush forward, incinerating anything in your path for $192611s1 Chaos damage.
    fel_rush = {
        id = 195072,
        cast = 0,
        charges = function() return talent.blazing_path.enabled and 2 or nil end,
        cooldown = function () return ( legendary.erratic_fel_core.enabled and 7 or 10 ) * ( 1 - 0.1 * talent.erratic_felheart.rank ) end,
        recharge = function () return talent.blazing_path.enabled and ( ( legendary.erratic_fel_core.enabled and 7 or 10 ) * ( 1 - 0.1 * talent.erratic_felheart.rank ) ) or nil end,
        gcd = "off",
        icd = 0.5,
        school = "physical",

        startsCombat = true,
        nodebuff = "rooted",

        readyTime = function ()
            if prev[1].fel_rush then return 3600 end
            if ( settings.fel_rush_charges or 1 ) == 0 then return end
            return ( ( 1 + ( settings.fel_rush_charges or 1 ) ) - cooldown.fel_rush.charges_fractional ) * cooldown.fel_rush.recharge
        end,

        handler = function ()
            setDistance( 5 )
            setCooldown( "global_cooldown", 0.25 )

            if buff.unbound_chaos.up then removeBuff( "unbound_chaos" ) end
            if buff.inertia_prep_buff.up then
                removeBuff( "inertia_prep_buff" )
                applyBuff( "inertia_damage_buff" )
            end
            if conduit.felfire_haste.enabled then applyBuff( "felfire_haste" ) end
        end,
    },

    -- Talent: Charge to your target and deal $213243sw2 $@spelldesc395020 damage.    $?s203513[Shear has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r]?a203555[Demon Blades has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r][Demon's Bite has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r]
    felblade = {
        id = 232893,
        cast = 0,
        cooldown = 15,
        hasteCD = true,
        gcd = "spell",
        school = "physical",

        spend = -40,
        spendType = "fury",

        talent = "felblade",
        startsCombat = true,
        nodebuff = "rooted",

        handler = function ()
            setDistance( 5 )
            if buff.unbound_chaos.up then removeBuff( "unbound_chaos" ) end
            if buff.inertia_prep_buff.up then
                removeBuff( "inertia_prep_buff" )
                applyBuff( "inertia_damage_buff" )
            end
            if talent.warblades_hunger.enabled then
                if buff.art_of_the_glaive.stack + soul_fragments >= 6 then
                    applyBuff( "reavers_glaive" )
                else
                    addStack( "art_of_the_glaive", soul_fragments )
                end
                addStack( "warblades_hunger", soul_fragments )
            end
        end,
    },

    -- Talent: Launch two demonic glaives in a whirlwind of energy, causing ${14*$342857s1} Chaos damage over $d to all nearby enemies. Deals reduced damage beyond $s2 targets.
    glaive_tempest = {
        id = 342817,
        cast = 0,
        cooldown = 25,
        gcd = "spell",
        school = "magic",

        spend = 30,
        spendType = "fury",

        talent = "glaive_tempest",
        startsCombat = true,

        handler = function ()
        end,
    },

    -- Engulf yourself in flames, $?a320364 [instantly causing $258921s1 $@spelldesc395020 damage to enemies within $258921A1 yards and ][]radiating ${$258922s1*$d} $@spelldesc395020 damage over $d.$?s320374[    |cFFFFFFFFGenerates $<havocTalentFury> Fury over $d.|r][]$?(s212612 & !s320374)[    |cFFFFFFFFGenerates $<havocFury> Fury.|r][]$?s212613[    |cFFFFFFFFGenerates $<vengeFury> Fury over $d.|r][]
    immolation_aura = {
        id = function() return talent.demonic_intensity.enabled and buff.metamorphosis.up and 452487 or 258920 end,
        known = 258920,
        cast = 0,
        cooldown = function() return 30 * haste end,
        charges = function()
            if talent.a_fire_inside.enabled then return 2 end
        end,
        recharge = function()
            if talent.a_fire_inside.enabled then return 30 * haste end
        end,
        gcd = "spell",
        school = function() return talent.a_fire_inside.enabled and "chaos" or "fire" end,

        spend = -20,
        spendType = "fury",

        startsCombat = false,
        texture = function() return talent.demonic_intensity.enabled and buff.metamorphosis.up and 135794 or 1344649 end,

        handler = function ()

            if talent.demonic_intensity.enabled and buff.demonsurge_consuming_fire.up then
                removeBuff( "demonsurge_consuming_fire" )
                addStack( "demonsurge" )
            end
            applyBuff( "immolation_aura" )

            if talent.ragefire.enabled then applyBuff( "ragefire" ) end
        end,

        copy = { 258920, 427917, "consuming_fire", 452487 }
    },

    -- Talent: Imprisons a demon, beast, or humanoid, incapacitating them for $d. Damage will cancel the effect. Limit 1.
    imprison = {
        id = 217832,
        cast = 0,
        gcd = "spell",
        school = "shadow",

        talent = "imprison",
        startsCombat = false,

        handler = function ()
            applyDebuff( "target", "imprison" )
        end,
    },

    -- Leap into the air and land with explosive force, dealing $200166s2 Chaos damage to enemies within 8 yds, and stunning them for $200166d. Players are Dazed for $247121d instead.    Upon landing, you are transformed into a hellish demon for $162264d, $?s320645[immediately resetting the cooldown of your Eye Beam and Blade Dance abilities, ][]greatly empowering your Chaos Strike and Blade Dance abilities and gaining $162264s4% Haste$?(s235893&s204909)[, $162264s5% Versatility, and $162264s3% Leech]?(s235893&!s204909[ and $162264s5% Versatility]?(s204909&!s235893)[ and $162264s3% Leech][].
    metamorphosis = {
        id = 191427,
        cast = 0,
        cooldown = function () return ( 180 - ( 30 * talent.rush_of_chaos.rank ) )  end,
        gcd = "spell",
        school = "physical",

        startsCombat = false,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "metamorphosis", buff.metamorphosis.remains + 20 ) -- it extends demonic now
            -- last_metamorphosis = query_time

            setDistance( 5 )

            if talent.chaotic_transformation.enabled then
                setCooldown( "eye_beam", 0 )
                setCooldown( "abyssal_gaze", 0 )
                setCooldown( "blade_dance", 0 )
                setCooldown( "death_sweep", 0 )
            end

            if talent.demonsurge.enabled then
                removeBuff( "demonsurge" )
                applyBuff( "demonsurge_annihilation", buff.metamorphosis.remains )
                applyBuff( "demonsurge_death_sweep", buff.metamorphosis.remains )
                if talent.violent_transformation.enabled then
                    setCooldown( "sigil_of_flame", 0 )
                    gainCharges( "immolation_aura", 1 )
                    if talent.demonic_intensity.enabled then
                        gainCharges( "consuming_fire", 1 )
                        setCooldown( "sigil_of_doom", 0 )
                    end
                end
                if talent.demonic_intensity.enabled then
                    applyBuff( "demonsurge_abyssal_gaze", buff.metamorphosis.remains )
                    applyBuff( "demonsurge_consuming_fire", buff.metamorphosis.remains )
                    applyBuff( "demonsurge_sigil_of_doom", buff.metamorphosis.remains )
                end
            end

            stat.haste = stat.haste + 10
            -- Legacy
            if covenant.venthyr then
                applyDebuff( "target", "sinful_brand" )
                active_dot.sinful_brand = active_enemies
            end

        end,

        --[[meta = {
            adjusted_remains = function ()
                -- if level < 116 and ( equipped.delusions_of_grandeur or equipped.convergeance_of_fates ) then
                    return cooldown.metamorphosis.remains * meta_cd_multiplier
                end

                return cooldown.metamorphosis.remains
            end
        }--]]
    },

    -- Talent: Slip into the nether, increasing movement speed by $s3% and becoming immune to damage, but unable to attack. Lasts $d.
    netherwalk = {
        id = 196555,
        cast = 0,
        cooldown = 180,
        gcd = "spell",
        school = "physical",

        talent = "netherwalk",
        startsCombat = false,

        toggle = "interrupts",

        handler = function ()
            applyBuff( "netherwalk" )
            setCooldown( "global_cooldown", buff.netherwalk.remains )
        end,
    },


    rain_from_above = {
        id = 206803,
        cast = 0,
        cooldown = 60,
        gcd = "spell",

        pvptalent = "rain_from_above",

        startsCombat = false,
        texture = 1380371,

        handler = function ()
            applyBuff( "rain_from_above" )
        end,
    },


    reverse_magic = {
        id = 205604,
        cast = 0,
        cooldown = 60,
        gcd = "spell",

        -- toggle = "cooldowns",
        pvptalent = "reverse_magic",

        startsCombat = false,
        texture = 1380372,

        debuff = "reversible_magic",

        handler = function ()
            if debuff.reversible_magic.up then removeDebuff( "player", "reversible_magic" ) end
        end,
    },


    -- Talent: Place a Sigil of Flame at your location that activates after $d.    Deals $204598s1 Fire damage, and an additional $204598o3 Fire damage over $204598d, to all enemies affected by the sigil.    |CFFffffffGenerates $389787s1 Fury.|R
    sigil_of_flame = {
        id = function ()
            if talent.precise_sigils.enabled then return 389810 end
            return 204596
        end,
        known = 204596,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "fire",

        spend = -30,
        spendType = "fury",

        startsCombat = false,
        texture = 1344652,
        nobuff = function () return talent.demonic_intensity.enabled and "metamorphosis" or nil end,

        sigil_placed = function() return sigil_placed end,

        handler = function ()
            create_sigil( "flame" )
            if talent.student_of_suffering.enabled then applyBuff( "student_of_suffering" ) end
            setCooldown( "sigil_of_doom", action.sigil_of_doom.cooldown )
            if talent.flames_of_fury.enabled then gain( talent.flames_of_fury.rank * active_enemies, "fury" ) end
        end,

        copy = { 204596, 204513, 389810 },
        bind = "sigil_of_doom"
    },

    sigil_of_doom = {
        id = 452490,
        known = 204596,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "chaos",

        spend = -30,
        spendType = "fury",

        talent = "demonic_intensity",
        buff = "metamorphosis",

        startsCombat = false,
        texture = 1121022,

        sigil_placed = function() return sigil_placed end,

        handler = function ()
            create_sigil( "flame" )
            setCooldown( "sigil_of_flame", action.sigil_of_doom.cooldown )
            if talent.demonic_intensity.enabled and buff.demonsurge_sigil_of_doom.up then
                removeBuff( "demonsurge_sigil_of_doom" )
                addStack( "demonsurge" )
            end
            if talent.flames_of_fury.enabled then gain( talent.flames_of_fury.rank * active_enemies, "fury" ) end
            if talent.student_of_suffering.enabled then applyBuff( "student_of_suffering" ) end

        end,

        bind = "sigil_of_flame"
    },

    -- Talent: Place a Sigil of Misery at your location that activates after $d.    Causes all enemies affected by the sigil to cower in fear. Targets are disoriented for $207685d.
    sigil_of_misery = {
        id = function ()
            if talent.precise_sigils.enabled then return 389813 end
            if talent.concentrated_sigils.enabled then return 202140 end
            return 207684
        end,
        known = 207684,
        cast = 0,
        cooldown = function () return 120 * ( pvptalent.sigil_mastery.enabled and 0.75 or 1 ) end,
        gcd = "spell",
        school = "physical",

        talent = "sigil_of_misery",
        startsCombat = false,

        toggle = function()
            if talent.misery_in_defeat.enabled then return "cooldowns" end
            return "interrupts"
        end,

        handler = function ()
            create_sigil( "misery" )
        end,

        copy = { 389813, 207684, 202140 }
    },

    -- Place a demonic sigil at the target location that activates after $d.; Detonates to deal $389860s1 Chaos damage and shatter up to $s3 Lesser Soul Fragments from
    sigil_of_spite = {
        id = function()
            if talent.precise_sigils.enabled then return 389815 end
            return 390163
        end,
        known = 390163,
        cast = 0.0,
        cooldown = function() return 60 * ( pvptalent.sigil_mastery.enabled and 0.75 or 1 ) end,
        gcd = "spell",

        talent = "sigil_of_spite",
        startsCombat = false,

        sigil_placed = function() return sigil_placed end,

        handler = function ()
            create_sigil( "spite" )
        end,

        copy = { 390163, 389815 }
    },

    -- Allows you to see enemies and treasures through physical barriers, as well as enemies that are stealthed and invisible. Lasts $d.    Attacking or taking damage disrupts the sight.
    spectral_sight = {
        id = 188501,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "physical",

        startsCombat = false,

        handler = function ()
            applyBuff( "spectral_sight" )
        end,
    },

    -- Talent / Covenant (Night Fae): Charge to your target, striking them for $370966s1 $@spelldesc395042 damage, rooting them in place for $370970d and inflicting $370969o1 $@spelldesc395042 damage over $370969d to up to $370967s2 enemies in your path.     The pursuit invigorates your soul, healing you for $?c1[$370968s1%][$370968s2%] of the damage you deal to your Hunt target for $370966d.
    the_hunt = {
        id = function() return talent.the_hunt.enabled and 370965 or 323639 end,
        cast = 1,
        cooldown = function() return talent.the_hunt.enabled and 90 or 180 end,
        gcd = "spell",
        school = "nature",

        startsCombat = true,
        toggle = "cooldowns",
        nodebuff = "rooted",

        handler = function ()
            applyDebuff( "target", "the_hunt" )
            applyDebuff( "target", "the_hunt_dot" )
            setDistance( 5 )

            if talent.exergy.enabled then
                applyBuff( "exergy", min( 30, buff.exergy.remains + 20 ) )
            elseif talent.inertia.enabled then -- talent choice node, only 1 or the other
                applyBuff( "inertia_prep_buff" )
            end
            if talent.unbound_chaos.enabled then applyBuff( "unbound_chaos" ) end

            -- Hero Talents
            if talent.art_of_the_glaive.enabled then applyBuff( "reavers_glaive" ) end

            -- Legacy
            if legendary.blazing_slaughter.enabled then
                applyBuff( "immolation_aura" )
                applyBuff( "blazing_slaughter" )
            end
        end,

        copy = { 370965, 323639 }
    },

    -- Throw a demonic glaive at the target, dealing $337819s1 Physical damage. The glaive can ricochet to $?$s320386[${$337819x1-1} additional enemies][an additional enemy] within 10 yards.
    throw_glaive = {
        id = 185123,
        known = 185123,
        cast = 0,
        charges = function () return talent.champion_of_the_glaive.enabled and 2 or nil end,
        cooldown = 9,
        recharge = function () return talent.champion_of_the_glaive.enabled and 9 or nil end,
        gcd = "spell",
        school = "physical",

        spend = function() return talent.furious_throws.enabled and 25 or 0 end,
        spendType = "fury",

        startsCombat = true,
        nobuff = "reavers_glaive",

        readyTime = function ()
            if ( settings.throw_glaive_charges or 1 ) == 0 then return end
            return ( ( 1 + ( settings.throw_glaive_charges or 1 ) ) - cooldown.throw_glaive.charges_fractional ) * cooldown.throw_glaive.recharge
        end,

        handler = function ()
            if talent.burning_wound.enabled then applyDebuff( "target", "burning_wound" ) end
            if talent.champion_of_the_glaive.enabled then applyDebuff( "target", "master_of_the_glaive" ) end
            if talent.serrated_glaive.enabled then applyDebuff( "target", "serrated_glaive" ) end
            if talent.soulscar.enabled then applyDebuff( "target", "soulscar" ) end
            if set_bonus.tier31_4pc > 0 then reduceCooldown( "the_hunt", 2 ) end
        end,

        bind = "reavers_glaive"
    },

    reavers_glaive = {
        id = 442294,
        cast = 0,
        charges = function () return talent.champion_of_the_glaive.enabled and 2 or nil end,
        cooldown = 9,
        recharge = function () return talent.champion_of_the_glaive.enabled and 9 or nil end,
        gcd = "spell",
        school = "physical",
        known = 442290,

        spend = function() return talent.keen_engagement.enabled and -20 or nil end,
        spendType = function() return talent.keen_engagement.enabled and "fury" or nil end,

        startsCombat = true,
        buff = "reavers_glaive",

        handler = function ()
            removeBuff( "reavers_glaive" )
            if talent.master_of_the_glaive.enabled then applyDebuff( "target", "master_of_the_glaive" ) end
            applyBuff( "rending_strike" )
            applyBuff( "glaive_flurry" )
        end,

        bind = "throw_glaive"
    },

    -- Taunts the target to attack you.
    torment = {
        id = 185245,
        cast = 0,
        cooldown = 8,
        gcd = "off",
        school = "shadow",

        startsCombat = false,

        handler = function ()
            applyBuff( "torment" )
        end,
    },

    -- Talent: Remove all snares and vault away. Nearby enemies take $198813s2 Physical damage$?s320635[ and have their movement speed reduced by $198813s1% for $198813d][].$?a203551[    |cFFFFFFFFGenerates ${($203650s1/5)*$203650d} Fury over $203650d if you damage an enemy.|r][]
    vengeful_retreat = {
        id = 198793,
        cast = 0,
        cooldown = function () return talent.tactical_retreat.enabled and 20 or 25 end,
        gcd = "off",

        startsCombat = true,
        nodebuff = "rooted",

        readyTime = function ()
            if settings.retreat_and_return == "fel_rush" or settings.retreat_and_return == "either" and not talent.felblade.enabled then
                return max( 0, cooldown.fel_rush.remains - 1 )
            end
            if settings.retreat_and_return == "felblade" and talent.felblade.enabled then
                return max( 0, cooldown.felblade.remains - 0.4 )
            end
            if settings.retreat_and_return == "either" then
                return max( 0, min( cooldown.felblade.remains, cooldown.fel_rush.remains ) - 1 )
            end
        end,

        handler = function ()

            -- Standard effects/Talents
            applyBuff( "vengeful_retreat_movement" )
            if cooldown.fel_rush.remains < 1 then setCooldown( "fel_rush", 1 ) end
            if talent.vengeful_bonds.enabled then
                applyDebuff( "target", "vengeful_retreat" )
                applyDebuff( "target", "vengeful_retreat_snare" )
            end

            if talent.tactical_retreat.enabled then applyBuff( "tactical_retreat" ) end
            if talent.exergy.enabled then
                applyBuff( "exergy", min( 30, buff.exergy.remains + 20 ) )
            elseif talent.inertia.enabled then -- talent choice node, only 1 or the other
                applyBuff( "inertia_prep_buff" )
            end
            if talent.unbound_chaos.enabled then applyBuff( "unbound_chaos" ) end

            -- Hero Talents
            if talent.unhindered_assault.enabled then setCooldown( "felblade", 0 ) end
            if talent.evasive_action.enabled then
                if buff.evasive_action.down then applyBuff( "evasive_action" )
                else
                    removeBuff( "evasive_action" )
                    setCooldown( "vengeful_retreat", 0 )
                end
            end

            -- PvP
            if pvptalent.glimpse.enabled then applyBuff( "glimpse" ) end
        end,
    }
} )


spec:RegisterRanges( "disrupt", "felblade", "fel_eruption", "torment", "throw_glaive", "the_hunt" )

spec:RegisterOptions( {
    enabled = true,

    aoe = 3,
    cycle = false,

    nameplates = true,
    nameplateRange = 10,
    rangeFilter = false,

    damage = true,
    damageExpiration = 8,

    potion = "tempered_potion",

    package = "Havoc",
} )


spec:RegisterSetting( "demon_blades_text", nil, {
    name = function()
        return strformat( "|cFFFF0000WARNING!|r  If using the %s talent, Fury gains from your auto-attacks will be forecasted conservatively and updated when you "
            .. "actually gain resources.  This prediction can result in Fury spenders appearing abruptly since it was not guaranteed that you'd have enough Fury on "
            .. "your next melee swing.", Hekili:GetSpellLinkWithTexture( 203555 ) )
    end,
    type = "description",
    width = "full"
} )

spec:RegisterSetting( "demon_blades_acknowledged", false, {
    name = function()
        return strformat( "I understand that Fury generation from %s is unpredictable.", Hekili:GetSpellLinkWithTexture( 203555 ) )
    end,
    desc = function()
        return strformat( "If checked, %s will not trigger a warning when entering combat.", Hekili:GetSpellLinkWithTexture( 203555 ) )
    end,
    type = "toggle",
    width = "full",
    arg = function() return false end,
} )


-- Fel Rush
spec:RegisterSetting( "fel_rush_head", nil, {
    name = Hekili:GetSpellLinkWithTexture( 195072, 20 ),
    type = "header"
} )

spec:RegisterSetting( "fel_rush_warning", nil, {
    name = strformat( "The %s, %s, and/or %s talents require the use of %s.  If you do not want |W%s|w to be recommended to trigger these talents, you may want to "
        .. "consider a different talent build.\n\n"
        .. "You can reserve |W%s|w charges to ensure recommendations will always leave you with charge(s) available to use, but failing to use |W%s|w may ultimately "
        .. "cost you DPS.", Hekili:GetSpellLinkWithTexture( 388113 ), Hekili:GetSpellLinkWithTexture( 206476 ), Hekili:GetSpellLinkWithTexture( 347461 ),
        Hekili:GetSpellLinkWithTexture( 195072 ), spec.abilities.fel_rush.name, spec.abilities.fel_rush.name, spec.abilities.fel_rush.name ),
    type = "description",
    width = "full",
} )

spec:RegisterSetting( "fel_rush_charges", 0, {
    name = strformat( "Reserve %s Charges", Hekili:GetSpellLinkWithTexture( 195072 ) ),
    desc = strformat( "If set above zero, %s will not be recommended if it would leave you with fewer (fractional) charges.", Hekili:GetSpellLinkWithTexture( 195072 ) ),
    type = "range",
    min = 0,
    max = 2,
    step = 0.1,
    width = "full"
} )

spec:RegisterSetting( "fel_rush_filler", true, {
    name = strformat( "%s: Filler and Movement", Hekili:GetSpellLinkWithTexture( 195072 ) ),
    desc = strformat( "When enabled, %s may be recommended as a filler ability or for movement.\n\n"
        .. "These recommendations may occur with %s talented, when your other abilities are on cooldown, and/or because you are out of range of your target.",
        Hekili:GetSpellLinkWithTexture( 195072 ), Hekili:GetSpellLinkWithTexture( 203555 ) ),
    type = "toggle",
    width = "full"
} )

-- Throw Glaive
spec:RegisterSetting( "throw_glaive_head", nil, {
    name = Hekili:GetSpellLinkWithTexture( 185123, 20 ),
    type = "header"
} )

spec:RegisterSetting( "throw_glaive_charges_text", nil, {
    name = strformat( "You can reserve charges of %s to ensure that it is always available for %s or |W|T1385910:0::::64:64:4:60:4:60|t |cff71d5ff%s (affix)|r|w procs. "
        .. "If set to your maximum charges (2 with %s, 1 otherwise), |W%s|w will never be recommended.  Failing to use |W%s|w when appropriate may impact your DPS.",
        Hekili:GetSpellLinkWithTexture( 185123 ), Hekili:GetSpellLinkWithTexture( 391429 ), GetSpellInfo( 396363 ) or "Thundering", Hekili:GetSpellLinkWithTexture( 389763 ),
        spec.abilities.throw_glaive.name, spec.abilities.throw_glaive.name ),
    type = "description",
    width = "full",
} )

spec:RegisterSetting( "throw_glaive_charges", 0, {
    name = strformat( "Reserve %s Charges", Hekili:GetSpellLinkWithTexture( 185123 ) ),
    desc = strformat( "If set above zero, %s will not be recommended if it would leave you with fewer (fractional) charges.", Hekili:GetSpellLinkWithTexture( 185123 ) ),
    type = "range",
    min = 0,
    max = 2,
    step = 0.1,
    width = "full"
} )

--[[ Retired 20240712:
spec:RegisterSetting( "footloose", true, {
    name = strformat( "%s before %s", Hekili:GetSpellLinkWithTexture( 185123 ) , Hekili:GetSpellLinkWithTexture( 188499 ) ),
    desc = strformat( "When enabled, %s may be recommended without having %s on cooldown.\n\n"
        .. "This setting deviates from the default SimulationCraft profile, but performs equally on average with higher top-end damage.",
        Hekili:GetSpellLinkWithTexture( 185123 ) , Hekili:GetSpellLinkWithTexture( 188499 ) ),
    type = "toggle",
    width = "full"
} ) ]]

-- Vengeful Retreat
spec:RegisterSetting( "retreat_head", nil, {
    name = Hekili:GetSpellLinkWithTexture( 198793, 20 ),
    type = "header"
} )

spec:RegisterSetting( "retreat_warning", nil, {
    name = strformat( "The %s, %s, and/or %s talents require the use of %s.  If you do not want |W%s|w to be recommended to trigger the benefit of these talents, you "
        .. "may want to consider a different talent build.", Hekili:GetSpellLinkWithTexture( 388108 ),Hekili:GetSpellLinkWithTexture( 206476 ),
        Hekili:GetSpellLinkWithTexture( 389688 ), Hekili:GetSpellLinkWithTexture( 198793 ), spec.abilities.vengeful_retreat.name ),
    type = "description",
    width = "full",
} )

spec:RegisterSetting( "retreat_and_return", "off", {
    name = strformat( "%s: %s and %s", Hekili:GetSpellLinkWithTexture( 198793 ), Hekili:GetSpellLinkWithTexture( 195072 ), Hekili:GetSpellLinkWithTexture( 232893 ) ),
    desc = function()
        return strformat( "When enabled, %s will |cFFFF0000NOT|r be recommended unless either %s or %s are available to quickly return to your current target.  This "
            .. "requirement applies to all |W%s|w and |W%s|w recommendations, regardless of talents.\n\n"
            .. "If |W%s|w is not talented, its cooldown will be ignored.\n\n"
            .. "This option does not guarantee that |W%s|w or |W%s|w will be the first recommendation after |W%s|w but will ensure that either/both are available immediately.",
            Hekili:GetSpellLinkWithTexture( 198793 ), Hekili:GetSpellLinkWithTexture( 195072 ), Hekili:GetSpellLinkWithTexture( 232893 ),
            spec.abilities.fel_rush.name, spec.abilities.vengeful_retreat.name, spec.abilities.felblade.name,
            spec.abilities.fel_rush.name, spec.abilities.felblade.name, spec.abilities.vengeful_retreat.name )
    end,
    type = "select",
    values = {
        off = "Disabled (default)",
        fel_rush = "Require " .. Hekili:GetSpellLinkWithTexture( 195072 ),
        felblade = "Require " .. Hekili:GetSpellLinkWithTexture( 232893 ),
        either = "Either " .. Hekili:GetSpellLinkWithTexture( 195072 ) .. " or " .. Hekili:GetSpellLinkWithTexture( 232893 )
    },
    width = "full"
} )

spec:RegisterSetting( "retreat_filler", false, {
    name = strformat( "%s: Filler and Movement", Hekili:GetSpellLinkWithTexture( 198793 ) ),
    desc = function()
        return strformat( "When enabled, %s may be recommended as a filler ability or for movement.\n\n"
            .. "These recommendations may occur with %s talented, when your other abilities being on cooldown, and/or because you are out of range of your target.",
            Hekili:GetSpellLinkWithTexture( 198793 ), Hekili:GetSpellLinkWithTexture( 203555 ) )
    end,
    type = "toggle",
    width = "full"
} )

spec:RegisterPack( "Havoc", 20250225, [[Hekili:S3Z2YjosY(T4yJddYUnliG(Ygg2io7lNTJtmV49zazqyRObeRKO7XNWbF7NQkDRUKzwLeI27UZ8YmUrLYkRSY7zwLwmAX)yXJBcYcx8R(d9No03)Jdg(LXtg5V4XSxpgU4XJbR)wWZS)4qWE2)9)j47XR5)6R7Id2WF704tjRzp5XO9N2fKffF4VLeSnBXJpDkAx2F)WINGNHrSx9y46f)60p9Pfp(s0MnH5JnmLnb8XE)q)79)4F58Q(7JoeN4DE1JVEy95v)ik7f2FhT)VXqKK4Tr7ytFWA(uNo4ys4649pfKD3S)83dsIcEAx4h44(SSKOdFlmB0Y0SWK4OnPF47b7ov97dgn4LGu2ddYgeC41LBoME(RodvFmO63kOM88sgK2eUn40USzd)q8XzjHPHzWVBA0Zr7wgVD52DSxgEmr73hNV9Sm4usWhI2o7PtB3oq73hSj(hho)1ZF9p9NoVQaoS3ojmli55Wm2yYIxgKLX4k(WUOdHlxVz2Opu8qgmz7uBcfa(PtjhIo88YFeF6WMbjH7dIoKYN2SGDHhYuFEVIFCt4EgI80Uagxqp(0)9WLBI1g8d9zmo72TmFwtN)xh7Dj47n5)RbrPlFkoTBqXzqOyn6zSzhDynFpMTdxW(iiHjHh2WbzkJz6BHITMEIh88Ua(0UD3PKKxhC6yV1XX74pEGaVwUj4W6q(V)86ks)SHV9w58oiFk7Xyq((s(ygXwwbzVSm9hHHh1jMhJw)TLNoUCBsWZ7zKGpCknKXTTL)MmIjJET9uYRpm7tSz4fMqWYSKWWbb72KeS(LOLjHbFpmbF5VnC3YNcsyapuLguqWLEEV(vluPFTCf(aFLSp43U9t96xSXeEiCFuy68zSnROKWnLBi3LeeTzz435WpyZM0bRz7AzV9M(phDOgOqpD(xg6jHu7zSD7Jto(sCAuAjA92BAiJV3BVj2gLxdNo617gn0E2OE3OpNH)wuAwQc30MO0KthZK)joKtoL(sLy(PdpX5lxU(LG4uoNbWVQtg9ZjJXhmusWgpJmMoFy(AdyemnpIXSmlAF4dt96rtJMpAOm6lWNc2(QLGM0q5AWqwOVmx(M0z(aBaYtwWHdrVeLJ8x9jlxyiDzoGQMov4wlOJQbi7LKODcD(zVWEVONFjJj1VhsAyYDgiP3D18S83)fgZVX7n272XsJl81WLpfgS3CCLAgtFHPOnKlLXK2YIo8kdageinTqB4m5iAVmgPp8ilqiMGOnsdhM3aR0J9anTJE9u3jFyCVBk42v3fhSlinBjtP4MhM2RW6xyAAid3w(eBOFtSV92B5Osj5tLJ)NiFXKRmDAUp9sDDaBwZ)Nl3XuMLBfOCN1(iJpYMOeojcG5KJ5iQAuEK6(dx5Rqr1OP96dOLFctlVGMjm(NEIPyBqk3NIhMkJVv(HLEmktSjIYnuYNuUVVpi5BvkdN5FFHi1)8eZ2lB5UzPa2PkSmNoysCKnMYM)QTkzJO6lWthLblGJI67VLc8COTLzwfYyIyr2)gtB4sBca2WNRy4WdxCQhQIjvqC30c2DvMHCjsGhucKPCFkL9ccGUGJc(t6HmP4RO2ozp8zs1IeKqXVNMDIf5vMGTL9VdzXT88aDjra8P2tp22y6A22y4glw5zkcW324pSpcJuLBgL(1u6bc3CcHjQ)kn(4XDmPGdnyjNtMPplnAt4LkpykHz8tvR6PypAoHXKM5RNb(wjxYIikjlkqwXOgn8o)54UkQgut4b2Y)edzczSfbaHjunPrS5KJs9W37MZimsrV8WWbJF7n1FWNGzAM0qbzR4wdCX315FKzXtNAv8Vd)TWKNF1AaamNBLiWaIOYECtovGASygV88Q3sHKNLME1Cfu77KyTYfbRnVBKWKEgpRoThsoRz(E9RZXsfIy4gjBTIoQ5(d9mNbFGzW3PzWCuSzOIyB6iR19yIiFlOT(d7cJ31mJk5HakuzbRIAiMi2E5U)GyUYkoZFLpWDdDDwUqoihAZ0xPkdKJAf)dnB)qcttiCnyAxfs7D(pGoleAtj0LEVAGIYujfDaek9QuJyX(fKjVknpkixLiHs2T8qD4JP(NR)xo2FjDBaEwB(cgbqRL6gVMzCw7TXDvv79AFgJawt2WzigEaCeFNF61f)RTUO4kcA8uvOLWW0VBnO41M9DffDv0DnPseoeVEAX(GRKIoMblkyVQmBE9k0fZt4SG6fSB(ObdhAHyYtEFpTepmLEzI5TvPJ8EGr3l8CsA7dYJl7APbCcxE)N5kr0ZphMimo33ICwvQ(QDpqzGwDFXDxuh)hs0vCeLBTkHNR76tP3mCP0SO1S91GdPBJt2l4EXah42ynldmWqt9vL(47gFlMpU2EzglINHGVMC)T(GY4JhwMpR1VUEhpOWLSzN9EmbTdF72rJ9KfgkdoucH0dTS2FoQbX93f1J(lnGjSno49nhLF9VBkX(d2t6rd98nosHBGABju70UnfUUenDB9UrlowWPtL56UXxIDfl8CF0ZD9VOreuLeQEUeYW8P850CHBI(LeYp)7CDTSDeaB6k(biXntNr2z1LRQiX7gvqP5vGulGnbYGedSWDoEDYzbUVnADu28jklKIk9KfU)itQgiqMlqwqLKz6hJ2mnUhTQrXQl(K4Nzctpxu)PYOktYkRPu(AIIScMGtIc1KLCkSKtyoYy2WK84Z39WzpT4P6n5qZ8URprsNNyRw3cHh7fwfdm889HX41hEV5T3048uaq2ljX)qQYJASdJQYU0PKO4tPlfJpLABfxmSYsxokn)Z1zDttpTfV91nW0njxWiv5wIaaruaVKluswTPCz(mpGCVRr0RPLmRdLdcZNnCaDOuLmTYKR8ILU8POSqk2nSSDOMgjuwkcInr1f(mJUcgL5OIKBzUPQlw0GCA((UEOq8GK1bhyOuCcZ4wwRyPfn)1iE45vaUYCoBguuEj0rrSmM5penxti2kk2VKfoYjwG1XNjTG6TvTxRsaZS7g8QhhwyyaUTmUSfcIoW0yTuiBOLJNeMH)DSLNODCctiL3Ml5ffCJA451d1jC1GtqRCrHP(6MEyPe8ls4uEDJM64wp1sIzufRLtQ(DFKFFS6VdwdcOsCOP9YdpTnnLTepCn5sfvx68)nInUpcFmMF11tKghooRRhEHq1YRfbZBFBCVunasnlHbyKByWCPaAXGJX8FcjfLJNIWUIYzP45Q88eD47XFJTd)Bmslt7)s(BNxKUJX)GTxfDy7P0iPMC0CkbqWzsfUuE2uBIxER8hXMZIi6uBK3W)5POJhd50Znl)NNcdpWB4Pd8tfWBVv9qEsewZ3o5UyY5e3hLjysQgr63cs28k7LFMTrhcIv8EoG5VX(IItAmF5gGGYRrbtD5pKlcxg2ooFYC49VCLJsbAZ(ntSbmo5YiuEGNhfIiKZtZs1Z5hZabIeC4vp5x0YmpYYmde9VYmpsDM9uzFMpIxxD9i41yXWPUenaMouHL9u5hqyXeXt4gtknLeMutqjvwc230i4guGKNgXHfMGduhvXlHKcnvrFo0waQWRfKHreqXgjaKb2MOL0Zb7iccLVBewHG4UyXwM(n6OIhnLONbEyQoRoIg5QDZ0DXzvh3jlUCxLTb9OeW61iqpsiO13ZxC4z4evtIXIEk3HwcoJBSjhQoaKDl5mUQzuZw(kDFtX)N6McadU7Bk(UVPaj0FJnvAQd4s2uGttn4Ms5zEanfK8X1Lv5wCmHGA5BrN2t06ykVrXXnih5ARljn13N8)pizSj97o4QVeHXB4DAQdz4KvUKxJ7sbez4b7Z8tvqqwCYYthvDFTAwktxMUyQ1QfAKDmsmHNqLLm0b80Wj32F32F0)vF)bF828d44sMKAwO3TJ8VTFFW2Zgw5XTdhmE8DJ88UlNpqRiwId6WTFm)Hz8fW6a5ISERu5fOPWRzXaZeo0wyvzYWhdmGNql54pLQeJ2RkxAwXRzgGTUowGU3guMwol66i8tVMMYisph8)f(ZDMvK8WNAeFBGHPuyZOqe7DXo2Xo0bE(iNsYg086AhfKXOKnZQVbt303XWGNwzjBejt6FXFxrzsgnCiOj(VmK6mRIBIFcrHoaqh621vGH(dntGfolLzLu0kqfeWCULnmydgJlWuHjBIJ37iIqqQulbSg(Jv(xA5n(BDFL7pvkrVF805db6Y7stoJLkqVSTnPcVv3G5fwCMp6ZnqebfXg(tfX0K1(xeYLzHvUmglAzqSxu2rxX6GnVDOBTFMWeOMnBSTLjd5Qo(5TVOxQAl4LSVF64wpQhkYYvHQBqdz4R5Bnwq3Jo0X(EZX3euQaB9G4g(rSRtMl83Ed2TsPYiW7oGW4Kx7bxQPkkMzQNLkfGYdro5TZg6Hw5mBTYOLgMZZGsP3QBUC02Cgf0mwzm5GE)AzFcmoSYPM6HpmCW062GwRGKABeQfcr(wirVKf4TYI1vlrGmeysFmgJBa4vlepL)jUJMEe1Bx6YpGkguBmIsDvTbHWqNVzJjQFqPSWY1)giAjHFtDlsr2v5Ta5SSCjX9sTt5NOQCXbXFBGz(gWb6Szx0iO(gbi4Wr4fLZVGalhM77mpPr0LLU(3zhVaFpIdbUmhxEMZu51GADhTjqkgcIgG3iaIjEOmO6742OVZNIR7xVUnYn7kf7hzAWufhXTEWp9VGkBjpuFiBwnGV)3XmvoSDBeFk5MT7uDSeZi5NvzlZi9tMQA0TeVM)h75Dac)aubzHhyMD4w(GOhOUJ3CIy8HqS)khXotU77gt0DEeYptT5HDLZhiD6kYR1VPDjDjcvLAvF5(nw3fmIEEcX)ApKJzgBwW8IN(uq5vDnCyJ0iNpxlxSj6nOKPbxTS0EPWZmdjU0kNun3xzxs)rGJE1fe2(OHMM2TEQa8BGYf9w8Tu7y8jHrf4gkVl9DI2bOcA6BVXrOQR1qXz)hx8(HPkX7Nxiia1BinjoMVaMgxaxGBVOM8hh3SWZBhXWSJy2bXQEqqDR9GtW6uXaQZPV1GgizbTkqGzT6DRhXr2Z0fjThq4)jSOqsBw(fp3DLn0jWdAtEIkdZRQ475YYuPGrAWLYmZgoyurT6N0RFFWSVzTpZbf5iJwbEIqMh7nslAdbtWby7GbO7UdMZlEa7Nas)qoscK9dvcIfkSgDPibNtmZYLKdlkMEQqyWCfsKNm4DQ6Bk5HomhGXfB6YeB2qJsIEcBrsNSXP7EckPt1yTLs93ZnUjIeq9rxC)XzovS7yjT7aizYlXIRhsUqa5eWU(flVMp4PmrsSVu(24WNKlwmF20kn(Zqt)GhrJd3fuVBajFW0kAH)UaBKOEkPlWSdtQSROG4qQ(KRCi0oiBArBml0le4AvVMxIbehKd4Zltt7KnGfPwG2oxCly6bSA8Hy2DDq1A7Q9bsS5aAK9SQ4TkOdXP8BI0PZtHdI66VdaWjg32XqDhOqjrteJB6vDg21(d5TEgGIm8KlcY52imNqYNq)C7sOgYj7crVUvdJ2VZKRjaqnmLXLToQYdaaQxN)c2l9B19MasfQmsG9Nq(wmyKzh4CkHuLbIkDJ4WmI1Zz(E2UmAG3TPooJo7oTz)cdpvWnkT0TFKAscjYXUfJVKizzc3H3OANegW8z0HQMkyqcXPw(3KnIoby0bPyeifKLkNZDkPchqShIiPxJi67ZOY6YalmH7dcOan1D1H5jKwjgnjRdgsItXerNiDUTRimE2k3nEbkbPXq7PgezKOOi8(Xr9zaKndJh0URzX5jWxUkPolEKRxH9yX3KQjJg6pAXJ)iqyRpDXJ)JxcpVkA)X4KSZR2gNCE1VKdLF58Qe(bIJxyIvPX7zdJ)9fAFqg)hywCoWckzW5V()YmAFEL)F58Q)w8b2ujE8Vy4TkdCzXqpyq4bE7FTHnG(J(npBquB)rdSApTHWwHNqdYQc7ndU)bo3X48ymUnH7JgSA5r43myDX44KRiDDkmSn0XRbDJNJb)p2H0xey1j0HpHS3jsUK(MwEgNqG0N7WvmcSucltdIkpddUFPdXreyDX44OHDisIbSlhlhDLfGE3MGlWG7ieT1YjdsdOkDrAdbBNOay01s79ie13xoRhI(WRgGBNKhMw7IKgPVBv8ZnfCkPCsdMQFsnXamIfG2TOruC3DcTiAD7SjWhrHzNiRHb8Ro2FXcZ(ikl1sTIUYnTRsxmGFTub5FT9YdBcKIR1qaQoIxmGED8378xbcuT4tg8V0frQUT(SePHBspPH(H2z7uyw71Vab0GV(JBQv02QThbCxej(6zqgrkOTl(o1mmQ5T27LxNAXS7ca7F3WlOtLTU4n0hBqNNg0l6LQzPyezGd5Ac9RfCFVXAZB6id4coe3W62b9RfCF3W6U20iIt7cNukU6y0GT8JAkyViByyo42kDCyo12cDC(i(eDX2wXaSsP91aSAz)BiGV4ak9rCZODBria7YdnWaWxKMXRl0VwW99gRBNMrxX62b9RfC)zH1OrK2gPpeGD5kF6sx8rJxUDHF4)ZXDvSPPDKamV1Vy1KDRdKxxOFTG77nw3ovcUI1Td6xl4(ZcRrCof(8MQj5apiuriKuwF5YMia(N4AOZIbbBcUG008UHZDSHIXxRC6Jb4oJa9UnbxaxdoiBHzz0TUMhG5vgVUilyxxOFTG77nw3olyUI1Td6xl4(ZcRXQ3xhRrgzAm(ugQnhgphDcWsDMYfGGg0vFikOXCAOlkK7KUuj1eSgaQB3mXMMwMMsWQSEmjCD8(NcAyDwnWSkns87y)0SGm(DS)YnhH0ibmevVxqfbTcCWHqT(vPLnGcGKJYlmZ0Aqn(yy(x5GugEFGgu)lZvOUdlBgU(N)xdCTIY3L9Fjw5S7m9dGSYLgFAgFmwHgUux47wDxKW8kevjYmDH95cjSBhN2vA37A1B)iWTZc76A0)peDoBhZ1DnBMw0ZWtl46UwChOfiO1XmBaXk)uywqm)g(8lMoRGnoNMgPick)EfzmfWJ5Qc(Ma4geStZX6gaChaR8N3jaqQ9yhXvhak)QrIpe3bQBmF4JZPPzKdChWJ5Qc(Ma4gKvJMJ1na4oaws(eJh7iU6aqXy(mQ841rZh(00g68vf4wbBhlxIpnwXE7kx7wGxbw8AAfP)bXdMSymgfSUBlp5vf4oaw7Ke4X4ew3UnYRkWTc22AsWrSUTG3kGBRFuoI3Tf8va2iNRxibrdV7AW7aGDWWgM1YlcOywlXbANiKtcEhS44OXyYPHN1lGpiPWZf(GDAcBN(LRkWRaRrI(UqPunSURbVda2HquWeMUiGIjmHdu7cto4ebj4DqyYr33iNgxfMSmyNMW25)Yvf4vGf)gbO1PS5QDC4ePmFB8UDX)i6WZ8KINeKEE1pcty)oJxEtEnwY4dl)o358QDrPzNx90PSYXDiwKV9thug9Mn8bZ4IcEkin8VC(RNxDp7N539AGPQNxjJFPlst)LE89HH6fNiVRz6Z7(lJiSdizxGTxZlkgeyFH8eDzxA3L9sDhEQ)6YEbadyDwjnWVmqAd22LLbadyD3sVl5fXo7UDs7LGDs46e5C0d86fRMgbWxHsBHovDb1h7aJv(vArN)R4NBk46GECcR5UBKwSZF9Vl8MGdGpQ6Rc3HHfpk(Rf)JfpMFz)X(RFDe)FMpYfpM)vFyXJfqEX)9ISf)QpFe1)YJRtIy8KrblESs(s3q65v9yif3)OTgF3hoV6T3ylhsgDX7R)Yf(yEE1dZoVA4GrNx5jgh)UV(8Q5mZELtB)k4dYTlg2noHdvo4cFXMRmeJVYPC8JVwDbDCaxkPNuxPK5ti8fMBj9QpjoZFFKV2eLaaSNBQwT3yB16vZVP)XezXJsFnr48Mm2VX2z)uuVlZ7iEatru53qbzsn(EHdB6ABe5Du05vZkzcn2Ou)SwutbkVi85R0jORuY9D1Lfchu9mk)UCncIlh9fpoAihfMIIcSTvOgWsMAFq6Axxtgd1YUJ41hPjn070qmioiVvlKyihGZKu8uheuXeKG5n(KnPavBc1Gx9tUbt5PW0qpeHCoQbJaF2gcGkgA8HCxI(dEEY1SEKdwAIwj7gmlkxTekZBFqqwnDRZ)oCimWmYq9AP(Z8hGOvyotTW08rubn2p5JrIYNBVs1TnCJ6lD7g1noSxHVLqRkfEbWK470va2NoKYDFoou)berEJMEH7HG(JqrFywTc0e9RlHS8cQEuDBVedKEUWLvQ8E4gjnRME(vjiO8jkPGGw6Q2ufYx5hIfb5d3DturyPap0tIHf(tC74d14(TAxvYtlX6a3VfA7OwmZ33bpSK2cuTj75O52r4UIW)iPiSImzOj(GiPOYtzWYPkijAiCbsG7mc2Nsfx1xMO8Xzrmz4Eyyv9xFCpnKd1r7m8R8qWBPec)TRwS9jSGqikxtk06nEbTWQZgoQa2bB24F7BumFa9DMqE5B89vG2MVdUN5rPFGX(pLMeI7UKaK6F3x0u24G7YsueXeIB2Vqur7ZctZNX1sFUze5fa3oTdoeaUJYSmu8DT48QBv8qYCdUs3dLNDw1FBnGzc)6Y9HdiOAfMzLiRX9p12(qZdUwH(l2WW9mbhVG)q1ysFrYixHBV45BONnNevwtQFEDelkC)fWzCAVwhauH7lPatWT4JQbhnBlQQoX4(PLMKyRCizhaz7PEXwUVjwN4oh0E6k(AvYLfPKOiqeCheSsBEqsttpA1ioOKKYixrgaTKYndls6FJDum3bQlAQnLvt0woa3RVsHDAvQ0Qkyq3qlSUkXAjZSi2wT6kM1SgJ7RFJTJaU5a4Ua1c6tY5yxoobTeT)z5XP6GU6a)Ika3x)v)rECz8NjURKRs0VevnMn9PHz1W57bmAm7P8)A3Pqyhhu1lb6gdOGxXZ4YCvCq5rzXjWLt9GKNzoyVwmuyBYc0C5HG9m8lFWqLOW(ARGtc4uEzOBvEmG6pyEQ8PY3YizcZ4k4v(8TFE1DNxb(jCpNyy(zChA6WgjZfQVmeYReeXyoCaYaIVQZpY0G6cbCd4sEMi)j5pwhdd)nEfOeIl17JsaVkH)vm3rPjNoMPjayjt5GPbc4jy7M(Y7MmrC9ZpSCobhwtcbgPY3f(84gCv)kpnudHtXeUDpcF9Xfy7RkaUPk9Ke8g4Hfyjv9)CrofLOKPrhadu11rQim7LKOD7kVPm2g98lzmfF7PuzmrOhaD55v(4k(KYSKHcXXI3k)pUZMthMVBpx8ZXtA0W4oGk9nYAfqnpG8w(4VLPVi22mkNNBWJ5R4XgMKYNdDoUhkjg3uPdqn5sd2fKMTmVlcZf)7r6YpF6Zrz5TkznbMjVQrjBO75QN8Ur9NxPjOPKm90LuPnlGH75)JL8ULiVNjkmuvYeAPkfGcELRDI6gQgPmsX3RmKmAAjzhXnGjdBuwSix5f9lcD5nOJ(dkrc1g7Yf0VVsfewx7sLkaIshuXpj5RHaR0PDY1Fn50bucIMplez7hMNThrEHHDwrlAfkhyvyKaDFDoVhJvCnXsTgvvcBAoXeG3vQSRprgSRCWe3jOPwtxTU3GyJLXGMY2xow4AGyumejpej4Vq5OR45(tq)wPtqeVSj9Hpt)Pg2YNqzWRqgH(mRzc0b)vfQCTXMupiBfUOWyAPBVdKRC(qxYQYd)v74SNQl5uv6XsfPALuUPYhWFwH6nLEiZT6IbTSKfV3bJScDT3xnBta1gJy)7obuMth4gwn4DOcwy9SiTsUc6VsEmEG3oIJZxqMpW3QmXmTxdv6O0jb3c2CUOtFkCOYHcuQ3broNcH55c1k7Nwt6QCy2Ta5qmCu4NK3zOUvG6k0sd9RCUy7oM5E9anQOVJKRbELpgfhqQrmNQzktJ2KVLcmcFPrOe9dme4uk8ZEfuiDcci1RWfvhwLQhk8tB(npiLwNFOxPy(L2OPJ90zEsoePA5a19rFPyfCPNujkVlSNMQsHq38DYgliYkPGNxpBCO(7vh2aIVkTZzxl1A2SJg5rxUM)MUnFCa4sfMP6SqBDfSRLLQk(wA7cvU6IOBU1Pmm3m4dwlGen6rzd9E9KMjBjLOMXiAMT6aOIjaKz16zoWLUXb8Z6HIYg7TDdsmym9dCfe6j3f06gs45qGOKTqZBkJciqhqerHODb4ww6xVICGquSSyXRfGnnbilqAU3PVpebDFzi68pKuiPTi0Cr6pCEP1oV4zLffpSrBSOggRuyciuWHYGNVPdMRgAJmwTuADaYPk(NR0trf3YTbVCBs(MvWUCN4hmCi9(hrqXXP5RCG8pp1bsspxJ)Xm)bw45SgbmD0qw1dk39m2JZxMzw5u6y6qpUwlTQNP6tnw)Wza)ooi2X)HE0Mm)oRhvnc862JbKLgzZvnIG1KNl56zwPx3Wd1XkRNUGb98RX6HNK1Pc9IJfux7Xm7cqly99q1ndOA(2QkVHOgE8q5Y5O3DOmsW3eaz0yWu1GDWsQwk6rPRhmg9GldA2o97kLgjyUTXwp5tKSAnufQFPDFNzKSpQE2XcDUnRABrA2jfRhDfNtPjacZz9uS6aKwssevx2kxuU78(XrXUpIq7AIP7YGvPY2r1bPYTKDmxQym9bBGSYjMQaiF(pmj3K53Ij5cUachDhIOndp1reUwoFguJjv06ag9Qs9mRDEygB5yby0gA4n024w0x)Cc1jEZ2WCAFDuMGGorTB(QoNBJXZGX1lkj5nTI(dklC)rM(Cbk1OcDowtPODdKc6w8jXqs43Nz1KTY87H9DNIYdXXMbQ9)3Exn7242aHFw6fd7eKT2kolsbACp0hHC3ggEd2gGDBc8QCDF2ROef1WHFZps2zRl2ElWIrIC4mdNF(MHQytXa0n1hF7PDurcHX13sgB18IZ7ACekmzY(RnxMEfM8a(mE0Chy1KnHgSVUIUHGBJndFM2FNaWQBLTCwt6VWeL(LyNM98CfjuZrYu51YgyPFI)7tyCN5abRaF7xlRyvrWshApELE5MmmD8hvfTshyuKleKB4T4A(bagG)Pxmjdaoats38WYpCNkmC(9ih8WSJwHgHPMXbkcXLUmDdkcsMB4ZTsz09X9rXGMLAatkmDiTkY6mwpkC9F5ty0x90eET2as)trKovP(ROX3C)Xd7)7gs1lhBmbkCyF92ht31FBNuDcrSKLFj7rlZJcJNBdWY0)ALxPFGVwv2xJl4f(AhFs87rk0OM))uXu9yBpsOLxvq)d5BuBwUgCFIYTRTu)FDmb5G9kvltH(de1ap5wRXOIlbgYZeOGNnGm1ls9OdGxSQv6TvSWMzhaJfuf7z98dZSwlG6SrnPyQKiCUoaUYOCLrKHbQ3Xudl911CgAMLCMv0PrxrrypJ)0sKPKulYkui5tI0Kw8mvNBVOZJafw2l5gv2JhW)M5jzLrfyMvW48iabspImv2sZiiQtZuTt3A2L0vixSVkKmbmYC2BoDMHeTCJ7uwvoOC4fUzoghrtPZbQGuY)trBvt0D2PHlAzNzNNIqkRvl9FerqL6yk52D1sJJYPMhpPSOs7JkIM6ZJgnTEYKKMK8qbor4ws4nVAq3ewNBCISOjMv1Zg9ME4iPlD3gcf9W2YBzbkv5L((QUInnJm2KGtT4XRUrDNM3IttbGsTL9)IjNUyYuyrLTL1Kf1bpqr79rPN4X9qjEcp)N117ZTD8q4p(AihfT4(HASkI)0Sz5jeLaDAfnESxhnB3q(Ys8VasBiP6U0IAgjhd9jg9Onz72(f)HyM32hvJJ)uYcXWc6byWX1DWw)WHzU8BEbx9HG3(XzJS)8ZY8PrdlmjFyM62GSTItODBr0crYVPszqCsFJI2CLSfA(JKPP0niBlFufuqNXurMzGAz2ivQbbGTtvJwd)acZmdGd)gIGYJIZqw7iofVr4bjxbD)2UoKT3g(HWckec7p)1MLq3mBjXecvyOr1T0N(e1GQOGvFln5c2NyUJQ2I4WVVbkL30QQaqyhAcg3cYOd2GtuqPnZgoM(h67))a0kmHkbXSf1NhocCqgY7TAknHnfW6PzE0fBYQuyFqQVKvqPG7NFUimu2Qo8inyTICl7RFAVvn)oZnxIpqDi1LTBIwNsOd0S5tj2k9GMOzHgi2l3ctiScetQAfWgvllmBpItguB3UmBzR02iTSEE2iTclcppLwsC38Ynev1snNXfba3NuYmjsgIwPNkiEIlxzNDSvn9yMwQ2nBNR33OspRs5z3w(mWjDup4DeLvwi0H6RozPWWd9fXfT7VHFsLIrHPNUYBFiSzOLpHMABeNMuojXwYgSa)XcNYTZ9i66WiFgdo41I7C(JrRGskPv2yVtv0vroAyMeVS7aj71gekH7N3xF9Pa1HFDr391tdiKkEWD8mBu5xS1uSN8TxF6WZ7)YUiEw2cYAAI0wmxkTyGEQXjC3TKXoO62MWUe90JGiXaeIEgDhCxmoWnIEmKXXzRb62Pf6roGI6V8YtAJip33CBL35MaY)rZTvLZTfizJW)EFhvbfqDb5jBN9gDlRSrMp2npkzlbjnp5nbwEHfDw)YFU2VK3xT2RyRB38lw8NS37civoCOzImlr4a5PpfEbMwNmLfEOYO5dIiK)Hozc7kR3PpIQKSOBfkfdCHKvJHZDI6ZZP5aynmij0HxYr52hlpD4apQCY5cdtb1Px3892YEp8(TlqllvCy1kv3rDaYIJOymcIJfJt8y7KL8PIYIDcTVZFQ6IM43(Yl1KDAastyCdvxMCdqHItIBGFy8y4gK05umghCdvNvUbTA9JXnuTvhDoMX)69l2SzxWaO(6lbXbMnHTS)7yTEv4z2zWeZZPLVd)cnmOKlXWP2KKfONdlyV9jz)0FZaVaDJRO7lxN3M4MuHeuMnjOMSWklnuPsSF4FG6n1NBivnQNE54U3Gi22EogP74w43vT7Gn6u)12)O6dFS932xhGS(UgfA1DnJMqJpOQF4ZTaumuV8vTnD0Uo9)QE)bUUNjMvsbriZ3v439dQoSgpSpVRiCvhQBgOyH8GTRHSHCv3MALfyZQSDIdFAxd)4ZgOTUiOnA5x0aoXsr9cFS4m)fFoTHRVfIvadic)dEMXryGrofHZobJCtlEoCTmUJc4FdAUsYq2HrVNCenTUeGhkMaITwIX1bJ3uKuRR5OXfbljJ8kc3n0tevjKkuoGYy7GvN9EWf5QLlnSJ83wkZ(Y18Rzk5AjIrzdU0xZ7hWtftnah1NaMiCManUBDlWCa(DxYDAx196SQ3MRJOe6bkqmCetCWxiHWYrOLKSl4QjlOGlVUDYBi2WNoBQ9NdXAEtFFmzoyrrT5iM9UHxfXGJOtm8IzFOJbhpQTtO5(VRuPzk4BZC5S8cy5a0ijRy3CfDjSbX0lQaAVjjSuu2UAOIdQ1cRnsbYBj6WWn997NlL3NR9H6mLcG3S4mwVKQI(FlwJradUrVGOUmvUOMznasobYoTw0SilY4vqAYng)l32L73oHycL7aR)D0bNVbDIIOOj4tYB1)1lh3(yJnw)z7VS9Fo]] )