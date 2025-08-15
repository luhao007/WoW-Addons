-- PriestDiscipline.lua
-- August 2025
-- Patch 11.2

if UnitClassBase( "player" ) ~= "PRIEST" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State
local spec = Hekili:NewSpecialization( 256 )

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
-- local GetSpellInfo = ns.GetUnpackedSpellInfo
-- local GetPlayerAuraBySpellID = C_UnitAuras.GetPlayerAuraBySpellID
-- local FindUnitBuffByID, FindUnitDebuffByID = ns.FindUnitBuffByID, ns.FindUnitDebuffByID
-- local IsSpellOverlayed = C_SpellActivationOverlay.IsSpellOverlayed
-- local IsSpellKnownOrOverridesKnown = C_SpellBook.IsSpellInSpellBook
-- local IsActiveSpell = ns.IsActiveSpell

-- Specialization-specific local functions (if any)

spec:RegisterResource( Enum.PowerType.Mana )

-- Talents
spec:RegisterTalents( {

    -- Priest
    angelic_bulwark                = {  82675,  108945, 1 }, -- When an attack brings you below $s1% health, you gain an absorption shield equal to $s2% of your maximum health for $s3 sec. Cannot occur more than once every $s4 sec
    angelic_feather                = {  82703,  121536, 1 }, -- Places a feather at the target location, granting the first ally to walk through it $s1% increased movement speed for $s2 sec. Only $s3 feathers can be placed at one time
    angels_mercy                   = {  82678,  238100, 1 }, -- Reduces the cooldown of Desperate Prayer by $s1 sec
    apathy                         = {  82689,  390668, 1 }, -- Your Mind Blast critical strikes reduce your target's movement speed by $s1% for $s2 sec
    benevolence                    = {  82676,  415416, 1 }, -- Increases the healing of your spells by $s1%
    binding_heals                  = {  82678,  368275, 1 }, -- $s1% of Flash Heal healing on other targets also heals you
    blessed_recovery               = {  82720,  390767, 1 }, -- After being struck by a melee or ranged critical hit, heal $s1% of the damage taken over $s2 sec
    body_and_soul                  = {  82706,   64129, 1 }, -- Power Word: Shield and Leap of Faith increase your target's movement speed by $s1% for $s2 sec
    cauterizing_shadows            = {  82687,  459990, 1 }, -- When your Shadow Word: Pain expires or is refreshed with less than $s1 sec remaining, a nearby ally within $s2 yards is healed for $s3
    crystalline_reflection         = {  82681,  373457, 2 }, -- Power Word: Shield instantly heals the target for $s1 and reflects $s2% of damage absorbed
    death_and_madness              = {  82711,  321291, 1 }, -- If your Shadow Word: Death fails to kill a target at or below $s1% health, its cooldown is reset. Cannot occur more than once every $s2 sec
    dispel_magic                   = {  82715,     528, 1 }, -- Dispels Magic on the enemy target, removing $s1 beneficial Magic effect
    divine_star                    = {  82682,  110744, 1 }, -- Throw a Divine Star forward $s2 yds, healing allies in its path for $s3 and dealing $s$s4 Holy damage to enemies. After reaching its destination, the Divine Star returns to you, healing allies and damaging enemies in its path again. Healing reduced beyond $s5 targets
    dominate_mind                  = {  82710,  205364, 1 }, -- Controls a mind up to $s1 level above yours for $s2 sec while still controlling your own mind. Does not work versus Demonic, Mechanical, or Undead beings or players. This spell shares diminishing returns with other disorienting effects
    essence_devourer               = {  82674,  415479, 1 }, -- Attacks from your Shadowfiend siphon life from enemies, healing a nearby injured ally for $s1. Attacks from your Mindbender siphon life from enemies, healing a nearby injured ally for $s2
    focused_mending                = {  82719,  372354, 1 }, -- Prayer of Mending does $s1% increased healing to the initial target
    from_darkness_comes_light      = {  82707,  390615, 1 }, -- Each time Shadow Word: Pain deals damage, the healing of your next Flash Heal is increased by $s1%, up to a maximum of $s2%
    halo                           = {  82682,  120517, 1 }, -- Creates a ring of Holy energy around you that quickly expands to a $s2 yd radius, healing allies for $s3 and dealing $s$s4 Holy damage to enemies. Healing reduced beyond $s5 targets
    holy_nova                      = {  82701,  132157, 1 }, -- An explosion of holy light around you deals up to $s$s2 Holy damage to enemies and up to $s3 healing to allies within $s4 yds, reduced if there are more than $s5 targets
    improved_fade                  = {  82686,  390670, 2 }, -- Reduces the cooldown of Fade by $s1 sec
    improved_flash_heal            = {  82714,  393870, 1 }, -- Increases healing done by Flash Heal by $s1%
    improved_purify                = {  82705,  390632, 1 }, -- Purify additionally removes all Disease effects
    inspiration                    = {  82696,  390676, 1 }, -- Reduces your target's physical damage taken by $s1% for $s2 sec after a critical heal with Flash Heal or Penance
    leap_of_faith                  = {  82716,   73325, 1 }, -- Pulls the spirit of a party or raid member, instantly moving them directly in front of you
    lights_inspiration             = {  82679,  373450, 2 }, -- Increases the maximum health gained from Desperate Prayer by $s1%
    manipulation                   = {  82672,  459985, 1 }, -- You take $s1% less damage from enemies affected by your Shadow Word: Pain
    mass_dispel                    = {  82699,   32375, 1 }, -- Dispels magic in a $s1 yard radius, removing all harmful Magic from $s2 friendly targets and $s3 beneficial Magic effect from $s4 enemy targets. Potent enough to remove Magic that is normally undispellable
    mental_agility                 = {  82698,  341167, 1 }, -- Reduces the mana cost of Purify and Mass Dispel by $s1% and Dispel Magic by $s2%
    mind_control                   = {  82710,     605, 1 }, -- Controls a mind up to $s1 level above yours for $s2 sec. Does not work versus Demonic, Undead, or Mechanical beings. Shares diminishing returns with other disorienting effects
    move_with_grace                = {  82702,  390620, 1 }, -- Reduces the cooldown of Leap of Faith by $s1 sec
    petrifying_scream              = {  82695,   55676, 1 }, -- Psychic Scream causes enemies to tremble in place instead of fleeing in fear
    phantasm                       = {  82556,  108942, 1 }, -- Activating Fade removes all snare effects
    phantom_reach                  = {  82673,  459559, 1 }, -- Increases the range of most spells by $s1%
    power_infusion                 = {  82694,   10060, 1 }, -- Infuses the target with power for $s1 sec, increasing haste by $s2%. Can only be cast on players
    power_word_life                = {  82676,  373481, 1 }, -- A word of holy power that heals the target for $s1 million. Only usable if the target is below $s2% health
    prayer_of_mending              = {  82718,   33076, 1 }, -- Places a ward on an ally that heals them for $s1 the next time they take damage, and then jumps to another ally within $s2 yds. Jumps up to $s3 times and lasts $s4 sec after each jump
    protective_light               = {  82707,  193063, 1 }, -- Casting Flash Heal on yourself reduces all damage you take by $s1% for $s2 sec
    psychic_voice                  = {  82695,  196704, 1 }, -- Reduces the cooldown of Psychic Scream by $s1 sec
    renew                          = {  82717,     139, 1 }, -- Fill the target with faith in the light, healing for $s1 over $s2 sec
    rhapsody                       = {  82700,  390622, 1 }, -- Every $s1 sec, the damage of your next Holy Nova is increased by $s2% and its healing is increased by $s3%. Stacks up to $s4 times
    sanguine_teachings             = {  82691,  373218, 1 }, -- Increases your Leech by $s1%
    sanlayn                        = {  82690,  199855, 1 }, --  Sanguine Teachings Sanguine Teachings grants an additional $s3% Leech.  Vampiric Embrace Reduces the cooldown of Vampiric Embrace by $s6 sec, increases its healing done by $s7%
    shackle_undead                 = {  82693,    9484, 1 }, -- Shackles the target undead enemy for $s1 sec, preventing all actions and movement. Damage will cancel the effect. Limit $s2
    shadow_word_death              = {  82712,   32379, 1 }, -- A word of dark binding that inflicts $s$s2 Shadow damage to your target. If your target is not killed by Shadow Word: Death, you take backlash damage equal to $s3% of your maximum health. Damage increased by $s4% to targets below $s5% health
    shadowfiend                    = {  82713,   34433, 1 }, -- Summons a shadowy fiend to attack the target for $s1 sec. Generates $s2% Mana each time the Shadowfiend attacks
    sheer_terror                   = {  82708,  390919, 1 }, -- Increases the amount of damage required to break your Psychic Scream by $s1%
    spell_warding                  = {  82720,  390667, 1 }, -- Reduces all magic damage taken by $s1%
    surge_of_light                 = {  82677,  109186, 1 }, -- Your healing spells and Smite have a $s1% chance to make your next Flash Heal instant and cost $s2% less mana. Stacks to $s3
    throes_of_pain                 = {  82709,  377422, 2 }, -- Shadow Word: Pain deals an additional $s1% damage. When an enemy dies while afflicted by your Shadow Word: Pain, you gain $s2% Mana
    tithe_evasion                  = {  82688,  373223, 1 }, -- Shadow Word: Death deals $s1% less damage to you
    translucent_image              = {  82685,  373446, 1 }, -- Fade reduces damage you take by $s1%
    twins_of_the_sun_priestess     = {  82683,  373466, 1 }, -- Power Infusion also grants you its effect at $s1% value when used on an ally. If no ally is targeted, it will grant its effect at $s2% value to a nearby ally, preferring damage dealers
    twist_of_fate                  = {  82684,  390972, 2 }, -- After damaging or healing a target below $s1% health, gain $s2% increased damage and healing for $s3 sec
    unwavering_will                = {  82697,  373456, 2 }, -- While above $s1% health, the cast time of your Flash Heal and Smite are reduced by $s2%
    vampiric_embrace               = {  82691,   15286, 1 }, -- Fills you with the embrace of Shadow energy for $s1 sec, causing you to heal a nearby ally for $s2% of any single-target Shadow spell damage you deal
    void_shield                    = {  82692,  280749, 1 }, -- When cast on yourself, $s1% of damage you deal refills your Power Word: Shield
    void_shift                     = {  82674,  108968, 1 }, -- Swap health percentages with your ally. Increases the lower health percentage of the two to $s1% if below that amount
    void_tendrils                  = {  82708,  108920, 1 }, -- Summons shadowy tendrils, rooting all enemies within $s1 yards for $s2 sec or until the tendril is killed
    words_of_the_pious             = {  82721,  377438, 1 }, -- For $s1 sec after casting Power Word: Shield, you deal $s2% additional damage and healing with Smite and Holy Nova

    -- Discipline
    abyssal_reverie                = {  82583,  373054, 2 }, -- Atonement heals for $s1% more when activated by Shadow spells
    atonement                      = {  82594,   81749, 1 }, -- Power Word: Shield, Flash Heal, Renew, Power Word: Radiance, and Power Word: Life apply Atonement to your target for $s1 sec. Your spell damage heals all targets affected by Atonement for $s2% of the damage done. Healing increased by $s3% when not in a raid
    blaze_of_light                 = {  82568,  215768, 2 }, -- The damage of Smite and Penance is increased by $s1%, and Penance increases or decreases your target's movement speed by $s2% for $s3 sec
    borrowed_time                  = {  82600,  390691, 2 }, -- Casting Power Word: Shield increases your Haste by $s1% for $s2 sec
    bright_pupil                   = {  82591,  390684, 1 }, -- Reduces the cooldown of Power Word: Radiance by $s1 sec
    castigation                    = {  82575,  193134, 1 }, -- Penance fires one additional bolt of holy light over its duration
    dark_indulgence                = {  82596,  372972, 1 }, -- Mind Blast has a $s1% chance to grant Power of the Dark Side and its mana cost is reduced by $s2%
    divine_aegis                   = {  82602,   47515, 1 }, -- Direct critical heals create a protective shield on the target, absorbing $s1% of the amount healed. Lasts $s2 sec
    divine_procession              = {  82599,  472361, 1 }, -- Smite extends the duration of an active Atonement by $s1 sec
    encroaching_shadows            = {  82590,  472568, 1 }, -- Shadow Word: Pain Spreads to $s1 nearby enemies when you cast Penance on the target
    enduring_luminescence          = {  82591,  390685, 1 }, -- Reduces the cast time of Power Word: Radiance by $s1% and causes it to apply Atonement at an additional $s2% of its normal duration
    eternal_barrier                = {  86730,  238135, 1 }, -- Power Word: Shield absorbs $s1% additional damage and lasts $s2 sec longer
    evangelism                     = {  82598,  472433, 1 }, -- Extends Atonement on all allies by $s1 sec and heals for $s2 million, split evenly among them
    expiation                      = {  82585,  390832, 2 }, -- Mind Blast and Shadow Word: Death consume $s1 sec of Shadow Word: Pain, dealing damage equal to $s2% of the amount consumed
    harsh_discipline               = {  82572,  373180, 2 }, -- Power Word: Radiance causes your next Penance to fire $s1 additional bolts, stacking up to $s2 charges
    indemnity                      = {  82576,  373049, 1 }, -- Atonements granted by Power Word: Shield last an additional $s1 sec
    inescapable_torment            = {  82586,  373427, 1 }, -- Penance, Mind Blast and Shadow Word: Death cause your Mindbender or Shadowfiend to teleport behind your target, slashing up to $s2 nearby enemies for $s$s3 Shadow damage and extending its duration by $s4 sec
    inner_focus                    = {  82601,  390693, 1 }, -- Flash Heal, Power Word: Shield, Penance, Power Word: Radiance, and Power Word: Life have a $s1% increased chance to critically heal
    lenience                       = {  82567,  238063, 1 }, -- Atonement reduces damage taken by $s1%
    lights_promise                 = {  82592,  322115, 1 }, -- Power Word: Radiance gains an additional charge
    luminous_barrier               = {  82564,  271466, 1 }, -- Create a shield on all allies within $s2 yards, absorbing $s$s3 million damage on each of them for $s4 sec. Absorption decreased beyond $s5 targets
    malicious_intent               = {  82580,  372969, 1 }, -- Increases the duration of Schism by $s1 sec
    mindbender                     = {  82584,  123040, 1 }, -- Summons a Mindbender to attack the target for $s1 sec. Generates $s2% Mana each time the Mindbender attacks
    overloaded_with_light          = {  82573,  421557, 1 }, -- Ultimate Penitence emits an explosion of light, healing up to $s1 allies around you for $s2 and applying Atonement at $s3% of normal duration
    pain_and_suffering             = {  82578,  390689, 2 }, -- Increases the damage of Shadow Word: Pain by $s1% and increases its duration by $s2 sec
    pain_suppression               = {  82587,   33206, 1 }, -- Reduces all damage taken by a friendly target by $s1% for $s2 sec. Castable while stunned
    pain_transformation            = {  82588,  372991, 1 }, -- Pain Suppression also heals your target for $s1% of their maximum health and applies Atonement
    painful_punishment             = {  82597,  390686, 1 }, -- Each Penance bolt extends the duration of Shadow Word: Pain on enemies hit by $s1 sec
    power_of_the_dark_side         = {  82595,  198068, 1 }, -- Shadow Word: Pain has a chance to empower your next Penance with Shadow, increasing its effectiveness by $s1%
    power_word_barrier             = {  82564,   62618, 1 }, -- Summons a holy barrier to protect all allies at the target location for $s1 sec, reducing all damage taken by $s2% and preventing damage from delaying spellcasting
    power_word_radiance            = {  82593,  194509, 1 }, -- A burst of light heals the target and $s1 injured allies within $s2 yards for $s3, and applies Atonement for $s4% of its normal duration
    protector_of_the_frail         = {  82588,  373035, 1 }, -- Pain Suppression gains an additional charge. Power Word: Shield reduces the cooldown of Pain Suppression by $s1 sec
    revel_in_darkness              = {  82566,  373003, 1 }, -- Shadow Word: Pain deals $s1% additional damage and spreads to $s2 additional target when you cast Penance to its target
    sanctuary                      = {  92225,  231682, 1 }, -- Smite prevents the next $s1 damage dealt by the enemy
    schism                         = {  82579,  424509, 1 }, -- Mind Blast fractures the enemy's mind, increasing your spell damage to the target by $s1% for $s2 sec
    shadow_covenant                = {  82581,  314867, 1 }, -- Casting Mindbender enters you into a shadowy pact, transforming Halo, Divine Star, and Penance into Shadow spells and increasing the damage and healing of your Shadow spells by $s1% while active
    shield_discipline              = {  82589,  197045, 1 }, -- When your Power Word: Shield is completely absorbed, you restore $s1% of your maximum mana
    twilight_corruption            = {  82582,  373065, 1 }, -- Shadow Covenant increases Shadow spell damage and healing by an additional $s1%
    twilight_equilibrium           = {  82571,  390705, 1 }, -- Your damaging Shadow spells increase the damage of your next Holy spell cast within $s1 sec by $s2%. Your damaging Holy spells increase the damage of your next Shadow spell cast within $s3 sec by $s4%
    ultimate_penitence             = {  82577,  421453, 1 }, -- Ascend into the air and unleash a massive barrage of Penance bolts, causing $s1 million Holy damage to enemies or $s2 million healing to allies over $s3 sec. While ascended, gain a shield for $s4% of your health. In addition, you are unaffected by knockbacks or crowd control effects
    void_summoner                  = {  82570,  390770, 1 }, -- Reduces the cooldown of Shadowfiend or Mindbender by $s1%
    weal_and_woe                   = {  82569,  390786, 1 }, -- Your Penance bolts increase the damage of your next Smite by $s1%, or the absorb of your next Power Word: Shield by $s2%. Stacks up to $s3 times

    -- Oracle
    assured_safety                 = {  94691,  440766, 1 }, -- Power Word: Shield casts apply $s1 stacks of Prayer of Mending to your target
    clairvoyance                   = {  94687,  428940, 1 }, -- Casting Premonition of Solace invokes Clairvoyance, expanding your mind and opening up all possibilities of the future.  Premonition of Clairvoyance Grants Premonition of Insight, Piety, and Solace at $s3% effectiveness
    desperate_measures             = {  94690,  458718, 1 }, -- Desperate Prayer lasts an additional $s1 sec. Angelic Bulwark's absorption effect is increased by $s2% of your maximum health
    divine_feathers                = {  94675,  440670, 1 }, -- Your Angelic Feathers increase movement speed by an additional $s1%. When an ally walks through your Angelic Feather, you are also granted $s2% of its effect
    fatebender                     = {  94700,  440743, 1 }, -- Increases the effects of Premonition by $s1%
    foreseen_circumstances         = {  94689,  440738, 1 }, -- Pain Suppression reduces damage taken by an additional $s1%
    miraculous_recovery            = {  94679,  440674, 1 }, -- Reduces the cooldown of Power Word: Life by $s1 sec and allows it to be usable on targets below $s2% health
    perfect_vision                 = {  94700,  440661, 1 }, -- Reduces the cooldown of Premonition by $s1 sec
    preemptive_care                = {  94674,  440671, 1 }, -- Increases the duration of Atonement and Renew by $s1 sec
    premonition                    = {  94683,  428924, 1 }, -- Gain access to a spell that gives you an advantage against your fate. Premonition rotates to the next spell when cast.  Premonition of Insight Reduces the cooldown of your next $s4 spell casts by $s5 sec.  Premonition of Piety Increases your healing done by $s8% and causes $s9% of overhealing on players to be redistributed to up to $s10 nearby allies for $s11 sec.  Premonition of Solace Your next single target healing spell grants your target a shield that absorbs $s$s14 million damage and reduces their damage taken by $s15% for $s16 sec
    preventive_measures            = {  94698,  440662, 1 }, -- Power Word: Shield absorbs $s2% additional damage$s$s3 All damage dealt by Penance, Smite and Holy Nova increased by $s4%
    prophets_will                  = {  94690,  433905, 1 }, -- Your Flash Heal and Power Word: Shield are $s1% more effective when cast on yourself
    save_the_day                   = {  94675,  440669, 1 }, -- For $s1 sec after casting Leap of Faith you may cast it a second time for free, ignoring its cooldown
    twinsight                      = {  94673,  440742, 1 }, -- $s1 additional Penance bolts are fired at an enemy within $s2 yards when healing an ally with Penance, or fired at an ally within $s3 yards when damaging an enemy with Penance
    waste_no_time                  = {  94679,  440681, 1 }, -- Premonition causes your next Power Word: Radiance cast to be instant and cost $s1% less mana

    -- Voidweaver
    collapsing_void                = {  94694,  448403, 1 }, -- Each time Penance damages or heals, Entropic Rift is empowered, increasing its damage and size by $s2%. After Entropic Rift ends it collapses, dealing $s$s3 Shadow damage split amongst enemy targets within $s4 yds
    dark_energy                    = {  94693,  451018, 1 }, -- While Entropic Rift is active, you move $s1% faster
    darkening_horizon              = {  94695,  449912, 1 }, -- Void Blast increases the duration of Entropic Rift by $s1 sec, up to a maximum of $s2 sec
    depth_of_shadows               = { 100212,  451308, 1 }, -- Shadow Word: Death has a high chance to summon a Shadowfiend for $s1 sec when damaging targets below $s2% health
    devour_matter                  = {  94668,  451840, 1 }, -- Shadow Word: Death consumes absorb shields from your target, dealing $s$s2 extra damage to them and granting you $s3% mana if a shield was present
    embrace_the_shadow             = {  94696,  451569, 1 }, -- You absorb $s1% of all magic damage taken. Absorbing Shadow damage heals you for $s2% of the amount absorbed
    entropic_rift                  = {  94684,  447444, 1 }, -- Mind Blast tears open an Entropic Rift that follows the enemy for $s2 sec. Enemies caught in its path suffer $s$s3 Shadow damage every $s4 sec while within its reach
    inner_quietus                  = {  94670,  448278, 1 }, -- Power Word: Shield absorbs $s1% additional damage
    no_escape                      = {  94693,  451204, 1 }, -- Entropic Rift slows enemies by up to $s1%, increased the closer they are to its center
    void_blast                     = {  94703,  450405, 1 }, -- Entropic Rift upgrades Smite into Void Blast while it is active. Void Blast: Sends a blast of cosmic void energy at the enemy, causing $s$s2 Shadow damage
    void_empowerment               = {  94695,  450138, 1 }, -- Summoning an Entropic Rift extends the duration of your $s1 shortest Atonements by $s2 sec
    void_infusion                  = {  94669,  450612, 1 }, -- Atonement healing with Void Blast is $s1% more effective
    void_leech                     = {  94696,  451311, 1 }, -- Every $s1 sec siphon an amount equal to $s2% of your health from an ally within $s3 yds if they are higher health than you
    voidheart                      = {  94692,  449880, 1 }, -- While Entropic Rift is active, your Atonement healing is increased by $s1%
    voidwraith                     = { 100212,  451234, 1 }, -- Transform your Shadowfiend or Mindbender into a Voidwraith. Voidwraith Summon a Voidwraith for $s3 sec that casts Void Flay from afar. Void Flay deals bonus damage to high health enemies, up to a maximum of $s4% if they are full health. Generates $s5% Mana each time the Voidwraith attacks
} )

-- Auras
spec:RegisterAuras( {
    apathy = {
        id = 390669,
        duration = 4,
        max_stack = 1
    },
    archangel = {
        id = 197862,
        duration = 15,
        max_stack = 1
    },
    atonement = {
        id = 194384,
        duration = 15,
        max_stack = 1,
        dot = "buff",
        friendly = true
    },
    body_and_soul = {
        id = 65081,
        duration = 3,
        max_stack = 1
    },
    borrowed_time = {
        id = 390692,
        duration = 4,
        max_stack = 1
    },
    dark_archangel = {
        id = 197871,
        duration = 8,
        max_stack = 1
    },
    death_and_madness_debuff = {
        id = 322098,
        duration = 7,
        max_stack = 1
    },
    depth_of_the_shadows = {
        id = 390617,
        duration = 15,
        max_stack = 50
    },
    desperate_prayer = {
        id = 19236,
        duration = 10,
        tick_time = 1,
        max_stack = 1
    },
    dominate_mind = {
        id = 205364,
        duration = 30,
        max_stack = 1
    },
    fade = {
        id = 586,
        duration = 10,
        max_stack = 1
    },
    focused_will = {
        id = 45242,
        duration = 8,
        max_stack = 1
    },
    from_darkness_comes_light = {
        id = 390617,
        duration = 30,
        max_stack = 20
    },
    harsh_discipline = {
        id = 373183,
        duration = 30,
        max_stack = 2,
        copy = "harsh_discipline_ready"
    },
    inspiration = {
        id = 390677,
        duration = 15,
        max_stack = 1
    },
    leap_of_faith = {
        id = 73325,
        duration = 1.5,
        max_stack = 1
    },
    levitate = {
        id = 1706,
        duration = 600,
        max_stack = 1
    },
    -- Absorbs $w1 damage.
    luminous_barrier = {
        id = 271466,
        duration = 10.0,
        max_stack = 1,
        dot = "buff"
    },
    mind_control = {
        id = 605,
        duration = 30,
        max_stack = 1
    },
    mind_soothe = {
        id = 453,
        duration = 20,
        max_stack = 1
    },
    mind_vision = {
        id = 2096,
        duration = 60,
        max_stack = 1
    },
    mindgames = {
        id = 375901,
        duration = function() return talent.shattered_perceptions.enabled and 7 or 5 end,
        max_stack = 1
    },
    pain_suppression = {
        id = 33206,
        duration = 8,
        max_stack = 1,
        dot = "buff",
        shared = "player"
    },
    power_of_the_dark_side = {
        id = 198069,
        duration = 20,
        max_stack = 1
    },
    power_word_barrier = { -- TODO: Check for totem to help correct for remaining time.
        id = 81782,
        duration = 12,
        max_stack = 1
    },
    power_word_fortitude = {
        id = 21562,
        duration = 3600,
        max_stack = 1,
        shared = "player", -- use anyone's buff on the player
        dot = "buff",
        friendly = true
    },
    power_word_shield = {
        id = 17,
        duration = function() return 15 + ( 5 * talent.eternal_barrier.rank ) end,
        tick_time = 1,
        max_stack = 1,
        dot = "buff",
        friendly = true
    },
    prayer_of_mending = {
        id = 41635,
        duration = 30,
        max_stack = 5,
        dot = "buff",
        friendly = true
    },
    premonition_of_insight = {
        id = 428933,
        duration = 20,
        max_stack = 3
    },
    premonition_of_piety = {
        id = 428930,
        duration = 15,
        max_stack = 1
    },
    premonition_of_solace = {
        id = 428934,
        duration = 20,
        max_stack = 1
    },
    premonition_of_solace_absorb = {
        id = 443526,
        duration = 15,
        max_stack = 1,
        dot = "buff",
        friendly = true
    },
    psychic_scream = {
        id = 8122,
        duration = 8,
        max_stack = 1
    },
    --[[purge_the_wicked = {
        id = 204213,
        duration = 20,
        tick_time = function () return 2 * haste end,
        max_stack = 1
    },--]]
    --[[rapture = {
        id = 47536,
        duration = 8,
        max_stack = 3
    },--]]
    renew = {
        id = 139,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
        dot = "buff",
        friendly = true
    },
    schism = {
        id = 214621,
        duration = function() return talent.malicious_intent.enabled and 15 or 9 end,
        max_stack = 1
    },
    shackle_undead = {
        id = 9484,
        duration = 50,
        max_stack = 1
    },
    shadow_covenant = {
        id = 322105,
        duration = 7,
        max_stack = 1
    },
    shadow_word_pain = {
        id = 589,
        duration = 16,
        tick_time = 2,
        max_stack = 1
    },
    shadowfiend = {
        id = 34433,
        duration = 15,
        type = "Magic",
        max_stack = 1,
        generate = function( t, auraType )
            if auraType == "debuff" then return end

            local remains = pet.shadowfiend.remains
            if remains == 0 then return end

            t.expires = query_time + remains
            t.applied = t.expires - 15
            t.count = 1
        end
    },
    mindbender = {
        duration = 15,
        max_stack = 1,
        generate = function( t, auraType )
            if auraType == "debuff" then return end

            local remains = pet.mindbender.remains
            if remains == 0 then return end

            t.expires = query_time + remains
            t.applied = t.expires - 15
            t.count = 1
        end
    },
    voidwraith = {
        duration = 15,
        max_stack = 1,
        generate = function( t, auraType )
            if auraType == "debuff" then return end

            local remains = pet.voidwraith.remains
            if remains == 0 then return end

            t.expires = query_time + remains
            t.applied = t.expires - 15
            t.count = 1
        end
    },
    shield_of_absolution = {
        id = 394624,
        duration = 15,
        max_stack = 1,
        dot = "buff",
        friendly = true
    },
    surge_of_light = {
        id = 114255,
        duration = 20,
        max_stack = 2
    },
    tools_of_the_cloth = {
        id = 390933,
        duration = 12,
        max_stack = 1
    },
    twilight_equilibrium_holy_amp = {
        id = 390706,
        duration = 6,
        max_stack = 1
    },
    twilight_equilibrium_shadow_amp = {
        id = 390707,
        duration = 6,
        max_stack = 1
    },
    twist_of_fate = {
        id = 390978,
        duration = 8,
        max_stack = 1
    },
    ultimate_penitence = {
        id = 421453,
        duration = 6,
        max_stack = 1,
        copy = 421454,
        dot = "buff",
        friendly = true
    },
    vampiric_embrace = {
        id = 15286,
        duration = 15,
        tick_time = 0.5,
        max_stack = 1
    },
    void_tendrils = {
        id = 108920,
        duration = 0.5,
        max_stack = 1
    },
    waste_no_time = {
        id = 440683,
        duration = 20,
        max_stack = 1
    },
    weal_and_woe = {
        id = 390787,
        duration = 20,
        max_stack = 7
    },
    words_of_the_pious = {
        id = 390933,
        duration = 12,
        max_stack = 1
    },
    wrath_unleashed = {
        id = 390782,
        duration = 15,
        max_stack = 1
    },
    light_weaving = {
        id = 394609,
        duration = 15,
        max_stack = 1
    },
} )

spec:RegisterGear({
    -- The War Within
    tww3 = {
        items = { 237710, 237708, 237709, 237712, 237707 },
        auras = {
            -- Oracle
            visionary_velocity = {
                id = 1239609,
                duration = 10,
                max_stack = 10
            },
            -- Voidweaver
            overflowing_void = {
                id = 1237615,
                duration = 3600,
                max_stack = 1
            },
        }
    },
    tww2 = {
        items = { 229334, 229332, 229337, 229335, 229333 }
    },
    tww1 = {
        items = { 212084, 212083, 212081, 212086, 212082 },
        auras = {
            darkness_from_light = {
                id = 455033,
                duration = 30,
                max_stack = 3
            }
        }
    },
    -- Dragonflight
    tier29 = {
        items = { 200327, 200329, 200324, 200326, 200328 }
    },
    tier30 = {
        items = { 202543, 202542, 202541, 202545, 202540 },
        auras = {
            radiant_providence = {
                id = 410638,
                duration = 3600,
                max_stack = 2
            }
        }
    },
    tier31 = {
        items = { 207279, 207280, 207281, 207282, 207284, 217202, 217204, 217205, 217201, 217203 }
    }
} )

spec:RegisterStateTable( "priest", {
    self_power_infusion = true
} )

local holy_schools = {
    holy = true,
    holyfire = true
}

local entropic_rift_expires = 0
local er_extensions = 0

spec:RegisterHook( "COMBAT_LOG_EVENT_UNFILTERED", function( _, subtype, _, sourceGUID, _, _, _, _, _, _, _, spellID )
    if sourceGUID ~= GUID then return end

    if ( subtype == "SPELL_AURA_APPLIED" or subtype == "SPELL_AURA_REFRESH" ) and spellID == 450193 then
        entropic_rift_expires = GetTime() + 8 -- Assuming it will re-refresh from VT ticks and be caught by SPELL_AURA_REFRESH.
        er_extensions = 0
        return

    elseif state.talent.darkening_horizon.enabled and subtype == "SPELL_CAST_SUCCESS" and er_extensions < 3 and spellID == 450405 and entropic_rift_expires > GetTime() then
        entropic_rift_expires = entropic_rift_expires + 1
        er_extensions = er_extensions + 1
    end

end, false )

spec:RegisterStateExpr( "rift_extensions", function()
    return er_extensions
end )

local premonitions = {
    insight = "premonition_of_insight",
    piety = "premonition_of_piety",
    solace = "premonition_of_solace",
    clairvoyance = "premonition_of_clairvoyance"
}

spec:RegisterHook( "reset_precast", function ()
    if talent.premonition.enabled then
        local charge = min( cooldown.premonition_of_insight.charge, cooldown.premonition_of_solace.charge, cooldown.premonition_of_piety.charge, cooldown.premonition_of_clairvoyance.charge )
        local start = max( cooldown.premonition_of_insight.recharge_began, cooldown.premonition_of_solace.recharge_began, cooldown.premonition_of_piety.recharge_began, cooldown.premonition_of_clairvoyance.recharge_began )
        local duration = talent.perfect_vision.enabled and 45 or 60

        for _, v in pairs( premonitions ) do
            local cd = cooldown[ v ]
            cd.charge = charge
            cd.recharge_began = start
            cd.duration = duration
            cd.recharge = duration
        end
    end

    if buff.voidheart.up then
        applyBuff( "entropic_rift", buff.voidheart.remains )
    elseif entropic_rift_expires > query_time then
        applyBuff( "entropic_rift", entropic_rift_expires - query_time )
    end

    local vwRemains = cooldown.voidwraith.true_remains
    if vwRemains > cooldown.shadowfiend.remains then
        setCooldown( "shadowfiend", vwRemains )
    end

    rift_extensions = nil
end )

spec:RegisterHook( "TALENTS_UPDATED", function()
    -- For ability/cooldown, Mindbender takes precedent.
    local sf = talent.mindbender.enabled and "mindbender_actual" or talent.voidwraith.enabled and "voidwraith" or "shadowfiend_actual"

    class.abilities.shadowfiend = class.abilities[ sf ]
    class.abilities.mindbender = class.abilities[ sf ]

    rawset( cooldown, "shadowfiend", cooldown[ sf ] )
    rawset( cooldown, "mindbender", cooldown[ sf ] )
    rawset( cooldown, "fiend", cooldown[ sf ] )

    -- For totem/pet/buff, Voidwraith takes precedent.
    sf = talent.voidwraith.enabled and "voidwraith" or talent.mindbender.enabled and "mindbender" or "shadowfiend"

    class.totems.fiend = spec.totems[ sf ]
    totem.fiend = totem[ sf ]
    pet.fiend = pet[ sf ]
    buff.fiend = buff[ sf ]
end )

spec:RegisterTotems( {
    mindbender = {
        id = 136214,
        copy = "mindbender_actual"
    },
    shadowfiend = {
        id = 136199,
        copy = "shadowfiend_actual"
    },
    voidwraith = {
        id = 615099
    },
} )

spec:RegisterHook( "runHandler", function( action )
    if talent.twilight_equilibrium.enabled then
        local ability = class.abilities[ action ]
        if not ability then return end
        local school = ability.school

        if school and ability.damage then
            if holy_schools[ school ] and ( buff.twilight_equilibrium_holy_amp.up or buff.twilight_equilibrium_shadow_amp.down ) then
                removeBuff( "twilight_equilibrium_holy_amp" )
                applyBuff( "twilight_equilibrium_shadow_amp" )
            elseif school == "shadow" and ( buff.twilight_equilibrium_shadow_amp.up or buff.twilight_equilibrium_holy_amp.down )  then
                removeBuff( "twilight_equilibrium_shadow_amp" )
                applyBuff( "twilight_equilibrium_holy_amp" )
            end
        end
    end
end )

local InescapableTorment = setfenv( function ()
    if buff.mindbender.up then buff.mindbender.expires = buff.mindbender.expires + 0.7
    elseif buff.shadowfiend.up then buff.shadowfiend.expires = buff.shadowfiend.expires + 0.7
    elseif buff.voidwraith.up then buff.voidwraith.expires = buff.voidwraith.expires + 0.7
    end
end, state )

local insight_value = 7

spec:RegisterHook( "runHandler", function( a )
    -- Note: setCooldown will have already run in regular ability flow.
    if buff.premonition_of_insight.up then
        reduceCooldown( a, insight_value )
        removeStack( "premonition_of_insight" )
        if set_bonus.tww3_oracle >= 4 then addStack( "visionary_velocity" ) end
    end
end )

local Solace = setfenv( function ()
    if buff.premonition_of_solace.down then return end
    applyBuff( "premonition_of_solace_absorb" )
    removeBuff( "premonition_of_solace" )
end, state )

-- Abilities
spec:RegisterAbilities( {
    archangel = {
        id = 197862,
        cast = 0,
        cooldown = 60,
        gcd = "spell",
        school = "holy",

        pvptalent = "archangel",
        startsCombat = false,
        texture = 458225,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "archangel" )
        end,
    },


    dark_archangel = {
        id = 197871,
        cast = 0,
        cooldown = 60,
        gcd = "spell",
        school = "shadow",

        pvptalent = "dark_archangel",
        startsCombat = false,
        texture = 1445237,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "dark_arkangel" )
        end,
    },


    divine_star = {
        id = function() return buff.shadow_covenant.up and 122121 or 110744 end,
        known = 110744,
        flash = { 122121, 110744 },
        cast = 0,
        cooldown = 15,
        gcd = "spell",
        school = function() return buff.shadow_covenant.up and "shadow" or "holy" end,
        damage = 1,

        spend = 0.02,
        spendType = "mana",

        talent = "divine_star",
        startsCombat = true,
        texture = function() return buff.shadow_covenant.up and 631519 or 537026 end,

        handler = function ()
        end,

        copy = { 122121, 110744 }
    },


    evangelism = {
        id = 472433,
        cast = 0,
        cooldown = 90,
        gcd = "spell",
        school = "holy",

        talent = "evangelism",
        startsCombat = false,
        texture = 135895,

        toggle = "cooldowns",

        handler = function ()
            if buff.atonement.up then buff.atonement.expires = buff.atonement.expires + 6 end
        end,
    },


    flash_heal = {
        id = 2061,
        cast = 1.5,
        cooldown = 0,
        gcd = "spell",
        school = "holy",

        spend = function() return 0.04 * ( buff.surge_of_light.up and 0.5 or 1 )end,
        spendType = "mana",

        startsCombat = false,
        texture = 135907,

        handler = function ()
            removeBuff( "from_darkness_comes_light" )
            removeStack( "surge_of_light" )
            if talent.protective_light.enabled then applyBuff( "protective_light" ) end
            Solace()
            applyBuff( "atonement" )
        end,
    },


    halo = {
        id = function() return buff.shadow_covenant.up and 120644 or 120517 end,
        known = 120517,
        flash = { 120644, 120517 },
        cast = 1.5,
        cooldown = 40,
        gcd = "spell",
        school = function() return buff.shadow_covenant.up and "shadow" or "holy" end,
        damage = 1,

        spend = 0.03,
        spendType = "mana",

        talent = "halo",
        startsCombat = false,
        texture = function() return buff.shadow_covenant.up and 632353 or 632352 end,

        handler = function ()
        end,

        copy = { 120644, 120517 }
    },

    -- Embrace the light, reducing the mana cost of healing spells by $s1%.
    inner_light_and_shadow = {
        id = 356085,
        cast = 0,
        cooldown = 6,
        gcd = "spell",

        spend = 0.010,
        spendType = "mana",

        pvptalent = "inner_light_and_shadow",
        startsCombat = false,

        handler = function()
            if buff.inner_shadow.up then
                removeBuff( "inner_shadow" )
                applyBuff( "inner_light" )
            else
                removeBuff( "inner_light" )
                applyBuff( "inner_shadow" )
            end
        end,

        copy = { "inner_light", "inner_shadow", 355897, 355898 }

        -- Effects:
        -- #0: { 'type': APPLY_AURA, 'subtype': ADD_PCT_MODIFIER, 'points': -10.0, 'target': TARGET_UNIT_CASTER, 'modifies': POWER_COST, }
        -- #1: { 'type': APPLY_AURA, 'subtype': ADD_PCT_MODIFIER, 'points': -10.0, 'target': TARGET_UNIT_CASTER, 'modifies': IGNORE_SHAPESHIFT, }
        -- #2: { 'type': APPLY_AURA, 'subtype': ADD_PCT_MODIFIER, 'points': -10.0, 'target': TARGET_UNIT_CASTER, 'modifies': POWER_COST, }
        -- #3: { 'type': APPLY_AURA, 'subtype': OVERRIDE_ACTIONBAR_SPELLS_TRIGGERED, 'points': 355898.0, 'value': 355897, 'schools': ['physical', 'nature', 'frost', 'shadow'], 'value1': 2, 'target': TARGET_UNIT_CASTER, }
    },

    --[[ lights_wrath = {
        id = 373178,
        cast = function() return talent.wrath_unleashed.enabled and 1.5 or 2.5 end,
        cooldown = 90,
        gcd = "spell",
        school = "holyfire",
        damage = 1,

        talent = "lights_wrath",
        startsCombat = false,
        texture = 1271590,

        toggle = "cooldowns",

        handler = function ()
        end,
    }, ]]

    -- Talent: Create a shield on all allies within $A1 yards, absorbing $s1 damage on each of them for $d.; Absorption increased by $s2% when not in a raid.
    luminous_barrier = {
        id = 271466,
        cast = 0.0,
        cooldown = 180.0,
        gcd = "spell",

        spend = 0.040,
        spendType = 'mana',

        talent = "luminous_barrier",
        startsCombat = false,

        handler = function()
            applyBuff( "luminous_barrier" )
            active_dot.luminous_barrier = group_members
        end,
    },

    -- Talent: Summons a Mindbender to attack the target for $d.     |cFFFFFFFFGenerates ${$123051m1/100}.1% mana each time the Mindbender attacks.|r
    mindbender = {
        id = function() return state.spec.shadow and 200174 or 123040 end,
        known = 34433,
        flash = { 34433, 123040, 200174, 451235 },
        cast = 0,
        cooldown = function() return talent.void_summoner.enabled and 30 or 60 end,
        gcd = "spell",
        school = "shadow",

        talent = "mindbender",
        startsCombat = true,
        texture = 136214,

        handler = function ()
            local sf = talent.voidwraith.enabled and "voidwraith" or "mindbender"
            summonPet( sf, 12 )
            applyBuff( sf )
            if talent.shadow_covenant.enabled then applyBuff( "shadow_covenant" ) end
        end,

        bind = { "shadowfiend", "voidwraith" },
        copy = { "mindbender_actual", 123040, 200174 }
    },

    shadowfiend = {
        id = 34433,
        flash = { 34433, 123040, 200174, 451235 },
        cast = 0,
        cooldown = function() return talent.void_summoner.enabled and 90 or 180 end,
        gcd = "spell",
        school = "shadow",

        toggle = "cooldowns",

        notalent = function() return talent.mindbender.enabled and "mindbender" or "voidwraith" end,

        startsCombat = true,
        texture = 136199,

        handler = function ()
            summonPet( "shadowfiend" )
            applyBuff( "shadowfiend" )

            if talent.shadow_covenant.enabled then applyBuff( "shadow_covenant" ) end
        end,

        bind = { "mindbender", "voidwraith" },
        copy = "shadowfiend_actual"
    },

    voidwraith = {
        id = 451235,
        known = 34433,
        flash = { 34433, 123040, 200174, 451235 },
        cast = 0,
        cooldown = function() return talent.void_summoner.enabled and 90 or 180 end,
        gcd = "spell",
        school = "shadow",

        toggle = "cooldowns",

        talent = "voidwraith",
        notalent = "mindbender",

        startsCombat = true,
        texture = 615099,

        handler = function ()
            summonPet( "voidwraith" )
            applyBuff( "voidwraith" )

            if talent.shadow_covenant.enabled then applyBuff( "shadow_covenant" ) end
        end,

        bind = { "shadowfiend", "mindbender" },
    },

    mind_blast = {
        id = 8092,
        cast = 1.5,
        cooldown = 9,
        gcd = "spell",
        school = "shadow",
        damage = 1,

        spend = function() return talent.dark_indulgence.enabled and 0.0015 or 0.0025 end,
        spendType = "mana",

        startsCombat = true,
        texture = 136224,

        handler = function ()
            if talent.entropic_rift.enabled then
                applyBuff( "entropic_rift" )
                if talent.voidheart.enabled then applyBuff( "voidheart" ) end
            end
            if talent.manipulation.enabled then
                reduceCooldown( "mindgames", 0.5 * talent.manipulation.rank )
            end
            if talent.inescapable_torment.enabled then InescapableTorment() end

            local swp_reduction = 3 * talent.expiation.rank
            if swp_reduction > 0 then debuff.shadow_word_pain.expires = max( 0, debuff.shadow_word_pain.expires - swp_reduction ) end
        end,
    },

    -- Reduces all damage taken by a friendly target by $s1% for $d. Castable while stunned.
    pain_suppression = {
        id = 33206,
        cast = 0.0,
        charges = function() if talent.protector_of_the_frail.enabled then return 2 end end,
        cooldown = 180,
        recharge = function() if talent.protector_of_the_frail.enabled then return 180 end end,
        gcd = "off",

        spend = 0.016,
        spendType = 'mana',

        talent = "pain_suppression",
        startsCombat = false,

        handler = function()
            applyBuff( "pain_suppression" )

            if talent.pain_transformation.enabled then
                gain( 0.15 * health.max, "health" )
                applyBuff( "atonement" )
            end
        end,

        -- Effects:
        -- #0: { 'type': APPLY_AURA, 'subtype': MOD_DAMAGE_PERCENT_TAKEN, 'points': -40.0, 'schools': ['physical', 'holy', 'fire', 'nature', 'frost', 'shadow', 'arcane'], 'target': TARGET_UNIT_TARGET_ALLY, }

        -- Affected by:
        -- protector_of_the_frail[373035] #2: { 'type': APPLY_AURA, 'subtype': MOD_MAX_CHARGES, 'points': 1.0, 'target': TARGET_UNIT_CASTER, }
    },

    penance = {
        id = function() return buff.shadow_covenant.up and 400169 or 47540 end,
        known = 47540,
        flash = { 400169, 47540 },
        cast = 2,
        channeled = true,
        breakable = true,
        cooldown = 9,
        gcd = "spell",
        school = function() return buff.shadow_covenant.up and "shadow" or "holy" end,
        damage = 1,
        bolts = function() return 3 + talent.castigation.rank + ( buff.harsh_discipline.up and ( buff.harsh_discipline.stack * talent.harsh_discipline.rank ) or 0 ) end,

        spend = function()
            if buff.harsh_discipline.up then return 0 end
            return 0.016 * ( buff.inner_light.up and 0.9 or 1 )
        end,
        spendType = "mana",

        startsCombat = true,
        texture = function() return buff.shadow_covenant.up and 1394892 or 237545 end,

        start = function ()
            removeBuff( "power_of_the_dark_side" )
            removeStack( "harsh_discipline" )

            if set_bonus.tier29_4pc > 0 then applyBuff( "shield_of_absolution" ) end
            if talent.inescapable_torment.enabled then InescapableTorment() end
            if talent.manipulation.enabled then reduceCooldown( "mindgames", 0.5 * talent.manipulation.rank ) end

            if debuff.shadow_word_pain.up then
                if talent.painful_punishment.enabled then
                    debuff.shadow_word_pain.expires = debuff.shadow_word_pain.expires + ( 1.5 * spec.abilities.penance.bolts )
                end
                if talent.encroaching_shadows.enabled then
                    active_dot.shadow_word_pain = max( active_enemies, ( active_dot.shadow_word_pain + 2 + talent.revel_in_darkness.rank ) )
                end
            end

            Solace()

            if talent.weal_and_woe.enabled then
                addStack( "weal_and_woe", spec.abilities.penance.bolts )
            end
            if talent.void_summoner.enabled then
                reduceCooldown( "mindbender", 4 )
            end

            setCooldown( buff.shadow_covenant.up and "penance" or "dark_reprimand", action.penance.cooldown )
        end,

        copy = { 47540, 186720, 400169, "dark_reprimand" }

    },

    power_infusion = {
        id = 10060,
        cast = 0,
        cooldown = 120,
        gcd = "off",
        school = "holy",

        toggle = "cooldowns",
        talent = "power_infusion",
        startsCombat = false,
        indicator = function () return group and ( talent.twins_of_the_sun_priestess.enabled or legendary.twins_of_the_sun_priestess.enabled ) and "cycle" or nil end,

        handler = function ()
            applyBuff( "power_infusion" )
            stat.haste = stat.haste + 0.25
        end,
    },

    -- Summons a holy barrier to protect all allies at the target location for $d, reducing all damage taken by $81782s2% and preventing damage from delaying spellcasting.
    power_word_barrier = {
        id = 62618,
        cast = 0,
        cooldown = 180,
        gcd = "spell",
        school = "holy",

        spend = 0.04,
        spendType = "mana",

        talent = "power_word_barrier",
        startsCombat = false,

        handler = function()
            applyBuff( "power_word_barrier" )
        end,

        -- Effects:
        -- #0: { 'type': CREATE_AREATRIGGER, 'subtype': NONE, 'value': 1489, 'schools': ['physical', 'frost', 'arcane'], 'radius': 8.0, 'target': TARGET_UNIT_DEST_AREA_ALLY, }
    },


    power_word_radiance = {
        id = 194509,
        cast = function() return ( buff.radiant_providence.up or buff.waste_no_time.up ) and 0 or ( 2 * ( talent.enduring_luminescence.enabled and 0.7 or 1 ) ) end,
        charges = function() if talent.lights_promise.enabled then return 2 end end,
        cooldown = function() return 18 - ( 3 * talent.bright_pupil.rank ) end,
        recharge = function() if talent.lights_promise.enabled then return 18 - ( 3 * talent.bright_pupil.rank ) end end,
        gcd = "spell",
        school = "radiant",

        spend = function() return 0.05 * ( buff.waste_no_time.up and 0.85 or 1 ) end,
        spendType = "mana",

        talent = "power_word_radiance",
        startsCombat = false,
        texture = 1386546,

        handler = function ()
            if buff.atonement.down then
                applyBuff( "atonement", ( ( talent.enduring_luminescence.enabled and 0.7 or 0.6 ) * class.auras.atonement.duration ) + ( buff.radiant_providence.up and 3 or 0 ) )
                active_dot.atonement = min( active_dot.atonement + 3, group_members )
            else
                active_dot.atonement = min( active_dot.atonement + 4, group_members )
            end

            if talent.harsh_discipline.enabled then addStack( "harsh_discipline" ) end

            if buff.radiant_providence.up then
                removeStack( "radiant_providence" )
            elseif buff.waste_no_time.up then
                removeStack( "waste_no_time" )
            end
        end,
    },

    power_word_shield = {
        id = 17,
        cast = 0,
        cooldown = 7.5,
        gcd = "spell",

        spend = 0.03,
        spendType = "mana",

        startsCombat = false,
        texture = 135940,

        handler = function ()
            applyBuff( "power_word_shield" )
            applyBuff( "atonement" )
            removeBuff( "weal_and_woe" )

            if talent.borrowed_time.enabled then
                applyBuff( "borrowed_time" )
            end

            if talent.words_of_the_pious.enabled then
                applyBuff( "words_of_the_pious" )
            end

            if talent.body_and_soul.enabled then
                applyBuff( "body_and_soul" )
            end
        end,
    },

    premonition_of_insight = {
        id = 428933,
        cast = 0,
        charges = 2,
        cooldown = function() return talent.perfect_vision.enabled and 45 or 60 end,
        recharge = function() return action.premonition_of_insight.cooldown end,
        gcd = "off",

        talent = "premonition",

        handler = function()
            applyBuff( "premonition_of_insight", nil, 3 )

            spendCharges( "premonition_of_clairvoyance", 1 )
            spendCharges( "premonition_of_piety", 1 )
            spendCharges( "premonition_of_solace", 1 )
        end,
    },

    premonition_of_clairvoyance = {
        id = 440725,
        cast = 0,
        charges = 2,
        cooldown = function() return talent.perfect_vision.enabled and 45 or 60 end,
        recharge = function() return action.premonition_of_insight.cooldown end,
        gcd = "off",

        talent = "premonition",

        handler = function()
            applyBuff( "premonition_of_insight" )
            applyBuff( "premonition_of_piety" )
            applyBuff( "premonition_of_solace" )

            spendCharges( "premonition_of_insight", 1 )
            spendCharges( "premonition_of_piety", 1 )
            spendCharges( "premonition_of_solace", 1 )
        end,
    },

    premonition_of_piety = {
        id = 428930,
        cast = 0,
        charges = 2,
        cooldown = function() return talent.perfect_vision.enabled and 45 or 60 end,
        recharge = function() return action.premonition_of_insight.cooldown end,
        gcd = "off",

        talent = "premonition",

        handler = function()
            applyBuff( "premonition_of_piety" )

            spendCharges( "premonition_of_clairvoyance", 1 )
            spendCharges( "premonition_of_insight", 1 )
            spendCharges( "premonition_of_solace", 1 )
        end,
    },

    premonition_of_solace = {
        id = 428934,
        cast = 0,
        charges = 2,
        cooldown = function() return talent.perfect_vision.enabled and 45 or 60 end,
        recharge = function() return action.premonition_of_insight.cooldown end,
        gcd = "off",

        talent = "premonition",

        handler = function()
            applyBuff( "premonition_of_solace" )

            spendCharges( "premonition_of_clairvoyance", 1 )
            spendCharges( "premonition_of_insight", 1 )
            spendCharges( "premonition_of_piety", 1 )
        end,
    },

    renew = {
        id = 139,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "holy",

        spend = 0.02,
        spendType = "mana",

        talent = "renew",
        startsCombat = false,
        texture = 135953,

        handler = function ()
            applyBuff( "renew" )
            Solace()

            applyBuff( "atonement" )
        end,
    },

    shadow_word_pain = {
        id = 589,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "shadow",
        damage = 1,

        spend = 0,
        spendType = "mana",

        -- notalent = "purge_the_wicked",
        startsCombat = true,
        texture = 136207,
        cycle = "shadow_word_pain",

        handler = function ()
            applyDebuff( "target", "shadow_word_pain" )
        end,
    },

    smite = {
        id = function() return state.spec.discipline and talent.void_blast.enabled and buff.entropic_rift.up and 450215 or 585 end,
        known = 585,
        cast = function() return 1.5 * haste * ( set_bonus.tww3 >= 2 and state.spec.discipline and talent.void_blast.enabled and buff.entropic_rift.up and 0.8 or 1 ) end,
        cooldown = 0,
        gcd = "spell",
        school = "holy",
        damage = 1,

        spend = 0,
        spendType = "mana",

        startsCombat = true,
        texture = function()
            return buff.entropic_rift.up and 4914668 or 135924
        end,

        handler = function ()
            if talent.weal_and_woe.enabled then
                removeBuff( "weal_and_woe" )
            end
            if talent.manipulation.enabled then
                reduceCooldown( "mindgames", 0.5 * talent.manipulation.rank )
            end

            if talent.darkening_horizon.enabled and rift_extensions < 3 then
                buff.entropic_rift.expires = buff.entropic_rift.expires + 1
                if buff.voidheart.up then buff.voidheart.expires = buff.voidheart.expires + 1 end
                rift_extensions = rift_extensions + 1
            end

            if set_bonus.tww3_voidweaver >= 4 then removeBuff( "overflowing_void" ) end
        end,

        copy = { 585, "void_blast", 450215, 450405, 450983 }
    },

    -- Ascend into the air and unleash a massive barrage of Penance bolts, causing $<penancedamage> Holy damage to enemies or $<penancehealing> healing to allies over $421434d.; While ascended, gain a shield for $s1% of your health. In addition, you are unaffected by knockbacks or crowd control effects.
    ultimate_penitence = {
        id = 421453,
        cast = 1.5,
        cooldown = 240,
        gcd = "spell",

        talent = "ultimate_penitence",
        startsCombat = true,

        handler = function()
            applyBuff( "ultimate_penitence" )
        end,

        -- Effects:
        -- #0: { 'type': DUMMY, 'subtype': NONE, 'target': TARGET_UNIT_TARGET_ANY, }
        -- #1: { 'type': UNKNOWN, 'subtype': NONE, 'points': 2.0, 'value': 852, 'schools': ['fire', 'frost', 'arcane'], 'target': TARGET_UNIT_CASTER, 'target2': TARGET_DEST_CASTER, }
        -- #2: { 'type': APPLY_AURA, 'subtype': SCHOOL_ABSORB, 'value': 127, 'schools': ['physical', 'holy', 'fire', 'nature', 'frost', 'shadow', 'arcane'], 'target': TARGET_UNIT_CASTER, }
    },
} )

spec:RegisterSetting( "experimental_msg", nil, {
    type = "description",
    name = "|cFFFF0000WARNING|r:  Healer support in this addon is focused on DPS output only.  This is more useful for solo content or downtime when your healing output is less critical in a group/encounter.  Use at your own risk.",
    width = "full",
} )

spec:RegisterRanges( "penance", "smite", "dispel_magic" )

spec:RegisterOptions( {
    enabled = true,

    aoe = 3,
    cycle = false,

    nameplates = false,
    nameplateRange = 40,
    rangeFilter = false,

    damage = true,
    damageExpiration = 8,

    potion = "tempered_potion",

    package = "Discipline",

    strict = false
} )

spec:RegisterSetting( "sw_death_protection", 50, {
    name = "|T136149:0|t Shadow Word: Death Health Threshold",
    desc = "If set above 0, the addon will not recommend |T136149:0|t Shadow Word: Death while your health percentage is below this threshold.  This setting can help keep you from killing yourself.",
    type = "range",
    min = 0,
    max = 100,
    step = 0.1,
    width = "full",
} )

spec:RegisterPack( "Discipline", 20250810, [[Hekili:TZvBZTnos6FlPsDoszSuSLFjZLYXxD34DVjtnZUPgLTY3SefjLfVqrQJKYo(kx63(1naiiELeKIYj52BlVtSjbb6UrJUF6ga9TNE7NUDAGxr4T)TjNm5It(5tpz8PNEYztU82PfpUj82PB88)I3DWVK4Tg(V3eL7hTjokH8QhJt9cWUipDBMp8OvffBYF3BEZDrfR2UySF663KhTEBSxruAIFM3Yc8V9FZTtxSnkU4dj3UW84FXTt92wSkn72PtJw)lqphfeesBEyU)Tt)1qV4WSDZ3KfLMfvefMVBUxw4U538XPJwM6Vnpmy380K4h39B7(nSZhDY5JMC272n)pdxNEp0Yp(PpZE35Jo5TJo7e4DFAf8Ip7bD8Nbwik52PXr5f5eXu4sVTXfWV(3iITWeVfXHb3(FaKQpYF3o13loEg9pMHFh9RNrfD(PPXbPpKKFBbWTk9q6gqigwu1v37LfHVf)T4TW)8IDZxSD5YXfpefhD3QIzH)3GimArw021ZwLg)4mV1BgVDZU5hTBETnoFLhqhSMtgjgfweoljfMzb67SwtFooE7M)0t7Mx(1JlhsYSAw0gAN)jw3SB(FPQF2npkNYwrj3TBoTx3npWBnr)uInOVezKZ7rgrsk3tSb2Nwyc8vilCrRzHcyTrsXyMG3h02t8G)USpKPYFpfPJPmXzzJPKj)lQiSyO5ZYHMHK2LTM0kxfWiULrHjbC5jr0Rs1OoQeb)NHEbGmRifuck8YkQ0fQi(nR8YLKN(EjZazsygN2FBRP9te7qgzMVjmooFwW2mInUzR9(k25)SHo3liOMoFI7D()AR7C6lgVokjy2IyVCqx4RH(BbLSIO1HUpYNEsBgAh6ZPW0kmPe5XvAd8Y(YmGo3gFxyIFOfL2n48SVZmis6QgTDwQXi)hsZcMfe6vSsr4PXcg(a91rniOn5G4zMAjEskNvWxmZdKUR9cscZZvAu2DHfJxb(KHpFJpSa8QDZN0I1lNAYHJt8loLFhmc5nXNcnS1ZgM8I4e1feDpGvAgANQj6tQPTMcn5KWjkCLxCAtKgTnTMMm5DyzCkcQZkvnWIxGYoF38rc(DTta7MpC383SB(D(bJjgAKmFmaDcaUDf70sNi0oR6L0(5)8xUb0ZbXZU5Vh8lMd)kaBfqyUS0hE539qi2xPBJH1gjH4ke0tfGhL0LeN(fikZKWVIUUieYdGUjo27Mt9gtFA4xbWgXHaS0bNEbHgpDcLAoD8fe6ycHWYzodbJIemVQue6DpnRWq3(wJ96OZgFMtD8ae0Zqrncqupta6YPDYjR0u1VKUnPGi1kB6XLcWTRxGHaGtbaHmAzgTt9I3nplCTxuIaclFWNagIW9ErXQ(N4nwI0BVlCUAPOuOXXXK3CqefT0WcXImOdMLUCgeA0wazPfVJF6VFZF)DvAWZc)6Mq)cuvKI98U7EKoDYCJ(g0Plk0GOPwdg5pg1xjcppcgRIiF8TbB9PRw8YlFtsWOi4bltZW5Ghe52YbDgBqMX7aRIWzHX5HmCwmqrySsMaD0sLiVyFmk0quDawNTER)kQor5IAW9xXkQUKQHaCb9kpmIr)TzzW0aQpXvKgdHkgYwFB2CeDruqimvc(GGMfTuStPJp2KhcjpafOEjpQUydBXMSuyMOGhxHq0jJB2Wmry2kyqn0FckOCC9SzBoM(bKF0EnDTqUS5C7QmeZ5xzX3aVVgQmTp1FvuoeX1hvqlsvRAfeRoijQaCiilm8wg5lSkT1m6Fu2zoIocz)wH4QdSVoUstIb9wXzYwlfW1HEXp49i8oapkZnXYOmCz(0p)UBuLonGvgLsTc5N7sP6fb9UGI8ZrKo0gwD6iYElY(ZksNbVEg(QRCJqg6uidQlsd9tr4f4eelJDZFyvyszhHli8WgqPnWSiH0P2jzZxG3jVK7c7W8BRWn7(8RE8O(RqYhesxdiSovrg8VheWS5)ay0h90u2A0He2lWum2nMwFRoaVg6QgdhEIjW59aJtn3BL6MjcsJijiQmU1(RiaE5AY0FoL4cX5XCe5lOlimkOYcPF2mQFzNC7q(PYzNBuYvLuIo34wh0ZCGvvsXXutVKmKOLwVcmmMyc2BARORqltWKJPPzIPig6b9sU5lXWSnzNv89TWcRI07gsVag1GUrL7TMtaK9BvuhDG9jHYBIVjVO7m8VcFUkJQNAbKdBv8ogsdVf3i3ydFDycgQuzWV01ecHhQc82c8A6cT7jcwaY)hydrqAYRkkhPp9xQ8zDCfuKLEqunW38pOHuLVgyYxLx67kknrmgamgSW8qmh2EKOsYlgbXPGbx4dmEwuQcqFmrdq8KUhtLTmSyerUTiAadgxZT9q4iTj6ZAFyBg3CaoD9tvdOWRLtDLKkXFLI8Jf6FzozkNwwaY0F9gmMQWnJUUumm66CsqdJUgFNsCXIsEm9n84u48CNIUsVRewjWNk0YEazkqns3puJUF50hQBsSUlMCKgdWKplvMsnKFnUpMBxuZCSk0N)edXdi10TzO1i1K9ikNmM)KZA)wvAkEuZ5xS5as5n1WK49s7(u5wwG0C73vs7JdzHXevq1SCy8za6772n)ge8ljrGeq2KSafwuGzpd8CdmtkeQuwvUgkTGs2rDjC2KnwBSM2B(dbvlc6eMA5U5hMfag3b0N3faDcXKvX9awuIM3ZeXa8aRWOkez1rMFiHDeAyfK4A7SxWFpSylI6FvSpgABhMWOhMOo7Zgcuvh1Vr1ayrW7W)gTJN8k8Fj6Y4Ran9e8bE3J)fHzGVRKxW3KIFb(AgTPcXXE(voRti5SoT4Qa4pQIv006C26)QL3e4lcRWnXGwGQFwR2h6UZHsjvWPDhUmLccbOiNrHwWLN3PT8UgU02M9vVEEtRvQj(dw6tq04ml6TuNG1bsyD5eGQOSUOBoVvWJ2NDPCFfM14E782F2TQj3zg2Jgnufv6rYikGNtiO2JaQLOj(JQ1r7Ml8hTbhHUsL2z0HqmvlfRK4DkjSg7TFuWvCUXd91ZkUIZ7ugcBsQB)OION9jrdtVYmsuv7enNX3Z7oCPAzR96yYyiZBGULuIXLtQrafqpXUmBO6GOO7quAwu0A0EMKc8orL)Jk2PU9aU5EYoGTZDkXu6agSMzBZBk)NwHwnX)pmfhhvuGP7FbYp5rR3GNx4i)JrSQGbc6PfzrkovBnZRP0uzW3qA4xjjKf(L1PRjzssCFWkZnlE0uYR(C88spg01yMNsbIED0)dlK4YuNGnCtAEEeA2u1BuLiXQrkt5IYy(YXdqbNHp8P3x2DObpqx0(Cz1bxSmnDQl2s1EQIsPx2uwKjT3BBdRr0wDtg)kbqRqUvxN9JIh4l(2NARl60w03GqV(9)DqDrJlz)UPO)vdjZsINeTWR5DhMnXdwu62I8OGqQPp5wuP0lPAZjo8ioXPomX3fylB0lrZ(oVy)WK225M2VT6pBOiUO7P7RojHtGeAiBhwHpul8aljc4I9dpC74ZVT584I2FSnnCUMCj0wvjJoKc6XAcjktOv7vFWQBAR0COqEnQKtDpdyAD3pk(fV0iuONv)Ix2DWi1j2B6Kr5KfjD)CBtIb7Qn4fJUuL350Eaemww72Sv5l70PBCpKrFh7H6YUJJQEzHtAeA(OQ2aAubPfMLVS7yoCGpE(DZCz3ro4a)OLac7rC52SI50gC5EChifZvE1gqR5KuNzLDtk8EcfP69wt0OE0pebDi5iFrysqyg5kywYnzBtSEfNrFoZWZtbHmu9xBWbh)YKsgA(JvUSMon2Y3lvvhZ(I7VPYHCnikK4xfEZj4fF51yicY3lUnGtOXsN(f(52dJikY)lepySiOYcxMfcF(cmzmvTIk7XUA524zB2MeLVADOO4xocS6AjTxnsMINHltN0HUCY7L(PA(qDSrr)BvXhij6LIF0SoO0fRMTnh1SnWSmOAIKiEdi0KkGbxn(rguYPLAt6dG6i5M3eoJ0A0z(yuYkVSrtmFLWLqRKkfYvgsEQ(Q3BrgJiKMSeo)jVv1Hy1a2LrZuM)u4qvpx7nhkeA3qNpucYKhpYI3Q6hAVPojv2AIWt3yu5jUV0E0fe7roSbI1T2SAHGQZQ9Mt1MhCmdr2MkS77QrQRQlXDcM0B2Db1r2vWvRK0wXf8BR1)txgybnQNBLMFMyrN3e8WEkYB4c8PGtF)01l8QkpkCZoedNKECzAwruX2a9pVQ2Out1vr4uFQg4on3FK7G3Mq8WEwEtBZzNdoFELHGEvBZHaIFamorAe9MUoAefiybzdAcVhb1wUzhyeipUonl8FtrJ0wfROqVeVilqqx75uvhrobcXfMN)4h2vDPHFicJasNru3qSwTwrfRrDichOPk5uv7GPBvOxmzQKef6sG8ht8rbpv9KY8F8dImNG)4sPitKR6LPCGa54m4RxNBCSkavLVq0ACF0OCELtF53Z99J7didWAzBPk8vOvnOWlrJYLNLFHjFLnFsHPBsPt1Ud3Mc)GJZ1em9QJKRXnLkHC8VKDEAg1Au(y6jmc55Z0TfBhYXZaLjz2wHavmDBhPIl5(WQB(ELdBWGDtWzoeeIa6YMWy0FdFT6GtmGh4BjLPPdoXQoODyl1Qd23mrdQz2X48nAXGCmhA1QitPbPUTW8GtRCuVA1MOVrIYMHx24LcRwngTQA0HBbOnj9ZNBiR6Lnfl8HGekTaQvNGEogCfRBA1fOdhnCWvOpSEuOBvNIPys8xfgkqnsWg)V2MZobq0BpigPq22eY2qzPmNqa)soQyElsjL7K0KGiIrrJ(5PvUg9Lzsb3XQElgwkO0mPGg1f2kTEIyRf1VuA3zITJSiqPbN3CSTvz1UMGtfcZnZliIwUrKMr(i0dKtFpgzhj726r1jQav)LH8k6w4wUneec9(WmsiL0AP65aVn9bVmC3tHjfsLnnA9gsHGIuVEEfRIM(QYtBi6vjpf3CCVTfPy9TkGCEbtUlmF8UF73jBo(Px(ommKeyWiVpf8Ds8mXobpVAqT1VRrcQ9KwyO2Dn8FHLW0xrfw9rx(MYUCmwZx)aroGK)fLbOHhgZ8cKpHz8nH(yTH4smXgPlJI5Beu(yEMo(P3)gt52a7EwBHwOwrypg3SI3Zt3Hytl5cAtkOvu0Jt38(8WIJj7C07FHt1M0JQPzmjeRiM(BVC3CxksPLQP0YuATenTPYKTJKZtpjA7d5ENjqXQOATKh2qxjobrQfsZHsNQDQHNcaz6XCczidNZf(u7dQ8oRjpYwsYZtpzlbpwhf7RdLhXta26LLlaBB34feW6g63pMEXTL2G2JJwYfO0AbvhP5QbBY(3fm61YoJtMQl3aNd8yjiFu2bSEBK1CLBDcsTHFhqchz7iTCKwG4xbak7lc28PnqGqR21L(AiTDT9e1qesGrFnSA3RpHXJKkhCXW)F16ShRwN2N6eQAL4CfPsTYMT6bayLy6iZOhOI6PDEt7CeQ5iQvFzLEmN1fKEuylFRQbN2zf7hYdM0iA5X8y(kxfQwYrlDds)xYn6H4hhMu)NGISzBn8PJ3bwEZqI0EOpTb2tfAo67rGCduFilCYRQllidje9h7gGefStsewvLcfOSb2oanvgxSR(o0bg4p6QlZw6H2y5)uu0x9Cg9Xnn4ax0yjUSx4UMbmvBXRusrt79URZ1JvgYNjXsD8DVixgE0atipF6jJz48QMhUHwH4sMcCUWu2lcyHOuyJZRBo(fRF71V)ufEy)RKH9nBQPanWk7iCpxbo7ixA3vta9LbdoDKt96Otho0G8w6gZ2GL2HOLCxgRRoLrzU049MQiQbsLeL(yASUqMSuUjfTayOqt6GnXFLeuupq9gJ8sTmrksVIfishi0)5PEmw30bBNDQdFTHupwBuxA4ImpPp86sVwAvNrfO7KPREVwjAxQODz8CinKmM(NK8eRxaijSYH7(W1sEQAnhl2xCjgFAtlWYRpHLL3AVDCTms18Tly0WP1NvygXlpxOJkxpM)6GLZBK(fWKaWJfe4bQkf2W0vzzvsMLTtY)0KVTQxI073DQwVeNbiX1CWQ9EDs8iGCWC8AdgOMt1JQ74bHiC0(GxOEkDgoupbXx)(jNWJeDFkrF7RCW6(ayJGB8o)9CsrhzB)kuH4DqR6D7dh3UuTBwrsxLBFOOMYc)(tdSRWqTE6nDbfQYnISD5s2HVGIPx23LNUgKQvkV)q5jXaz)9OdfxlcC7d3kbOS(Ti00g(XtVWU2En2FMi6wT9LLCt12l21YUwpWDUVjOMmevTdm)FMcUw9wxRePMc2u3zRXSkvc73qoCekjB9z6KKnsQQxihOQuw8F(ltAoOtxvkB(rYvGmv)9ONGVVREy7HiUfwYnL1)bQg(4Mcnh8Yb2H1bHlRFdk27ka2(Zw1gbJb)s7B4u9ljznEQMC2qibla6R8D3eqEzMPfjQ3yLr5hfRUMO7FmS72hvZQ9s4Sx2sW9j1WkYdJfXdiF0sBIY12O(GSBHbMEXMxpruMsAuT1bQ(ISClqM6n6kmywm7AQEsPyVvLIfhsLYReDK53(fbcwzlPoYCnJANYjCYC3JN1r6Hrx0Cx1JpI)m5ZUEJeE15RxSJ5p1L(vCXjwFJi5lw5KweefE9GtgF2RRTMrHhCJxWQtuaSnHkef(CQuvVEpvbWt)DhnOUQ)0v735PI8)uN)OB2hkdEHz9aBIoIvkISZYhkC9kyjk0q(ZvoG1cX7AD99rnv6MoYMu6k(PvTAel3Hm3ze2xWKKWp)vmGKB(4uauXVJyga7mpK5rRVh674kMIafpTSdGmX05JPBr7NFjK3jOZzV8vLNIzG(XCkeUt)O1s2u4CAcDqHuoUh60TBplKCwB9IcqhIfiEIJzd2Ap8GarUNjy)trcHDbpbilcVlkHUr(4W4vsX(p6JjkHCgvbdKKKsGddo9cTESQUgbrv(mcFjm)s(7zvSPv9b3MFQ(g1EIcU19zA(3mS2DpQNxHOGKx10e9qGHwNU41oKR9Hd7rPqTXHkoo4(l4OnfrhGUtucFLMjnHlWxEASNCyp79euVoFqwXYoSgUCvs5F7yUhCzgU8AQICvDN5IR43Zu2OBUI0unECxSmTikGajrVuBuUzwsVRu7yWleHgqpunG3r9hw5wVO8Yic(EjP(tQgHC97pZ8iQPK1JdSqFBD8nQ1vxmacR)3lA1m5i50R)7(d487KVXZVwgF3NF3psZ(6rnuthwnijhj15v4Gm6we39kFBZqFdhsYgfw7hv5IcWHye6NL0pdlEBHcZ(nqDu)WM)svSXDJ4Wu(zvgGyn2)UgO)(TmKuRlQgwq10Ybh1gAuV0(IIAK1eKvVebtXlmeyIWF(kRLv0gV2uW5EcAqceDRfcGxssoEqhRCLMhC5AQynHiuwsSQYwILgCK61VPXsCatl2CnP0gzxWixlvoYQouVWtAUl5LVs796tpvLjdJ1IYR5y8j1kMB)F)d]] )
