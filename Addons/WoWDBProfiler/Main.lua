-- LUA API ------------------------------------------------------------

local _G = getfenv(0)

local pairs = _G.pairs
local tostring = _G.tostring
local tonumber = _G.tonumber

local bit = _G.bit
local math = _G.math
local table = _G.table

local next = _G.next
local select = _G.select
local type = _G.type
local unpack = _G.unpack

local C_Timer = _G.C_Timer
local GetCurrencyInfo = _G.GetCurrencyInfo


-- ADDON NAMESPACE ----------------------------------------------------

local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local WDP = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME, "AceConsole-3.0", "AceEvent-3.0")

local deformat = LibStub("LibDeformat-3.0")
local HereBeDragons = LibStub("HereBeDragons-2.0")

local DatamineTT = _G.CreateFrame("GameTooltip", "WDPDatamineTT", _G.UIParent, "GameTooltipTemplate")
DatamineTT:SetOwner(_G.WorldFrame, "ANCHOR_NONE")


-- SIMPLE CONSTANTS ----------------------------------------------------------

local AF = private.ACTION_TYPE_FLAGS
local CLIENT_LOCALE = _G.GetLocale()
local DB_VERSION = 19
local DEBUGGING = false
local EVENT_DEBUG = false

-- Timer durations in seconds
local DELAY_PROCESS_ITEMS = 30
local DELAY_PROCESS_WORLD_QUESTS = 90
local DELAY_UPDATE_TARGET_LOCATION = 0.5

local ITEM_ID_TIMBER = 114781

local LOOT_SLOT_CURRENCY = _G.LOOT_SLOT_CURRENCY
local LOOT_SLOT_ITEM = _G.LOOT_SLOT_ITEM
local LOOT_SLOT_MONEY = _G.LOOT_SLOT_MONEY

--local LOOT_SOURCE_ID_UNKNOWN = 1 -- Technically unused right now, but has future use potential
--local LOOT_SOURCE_ID_REDUNDANT = 3 -- Technically unused right now, but has future use potential
local LOOT_SOURCE_ID_GARRISON_CACHE = 10

local OBJECT_ID_ANVIL = 192628
local OBJECT_ID_FISHING_BOBBER = 35591
local OBJECT_ID_FORGE = 1685

local PLAYER_CLASS, PLAYER_CLASS_ID = _G.select(2, _G.UnitClass("player"))
local PLAYER_FACTION = _G.UnitFactionGroup("player")
local PLAYER_GUID
local PLAYER_LEVEL = _G.UnitLevel("player")
local PLAYER_NAME = _G.UnitName("player")
local PLAYER_RACE = _G.select(2, _G.UnitRace("player"))

local SPELL_ID_UPDATE_INTERACTIONS = 161006

local UI_MAP_COSMIC = 946

local ALLOWED_LOCALES = {
    enUS = true,
    enGB = true,
    enTW = true,
    enCN = true,
}

local DATABASE_DEFAULTS = {
    char = {},
    global = {
        config = {
            minimap_icon = {
                hide = true,
            },
        },
        items = {},
        npcs = {},
        objects = {},
        quests = {},
        spells = {},
        world_quests = {},
        zones = {},
    }
}

local EVENT_MAPPING = {
    AUCTION_HOUSE_CLOSED = "ResumeChatLootRecording",
    AUCTION_HOUSE_SHOW = true, -- also triggers StopChatLootRecording
    BANKFRAME_CLOSED = "ResumeChatLootRecording",
    BANKFRAME_OPENED = true, -- also triggers StopChatLootRecording
    BATTLEFIELDS_SHOW = true,
    BLACK_MARKET_ITEM_UPDATE = true,
    BONUS_ROLL_RESULT = true,
    CHAT_MSG_CURRENCY = true,
    CHAT_MSG_LOOT = true,
    CHAT_MSG_MONSTER_SAY = "RecordQuote",
    CHAT_MSG_MONSTER_WHISPER = "RecordQuote",
    CHAT_MSG_MONSTER_YELL = "RecordQuote",
    CHAT_MSG_SYSTEM = true,
    COMBAT_LOG_EVENT_UNFILTERED = true,
    COMBAT_TEXT_UPDATE = true,
    CURSOR_UPDATE = true,
    GARRISON_MISSION_NPC_CLOSED = "ResumeChatLootRecording",
    GARRISON_MISSION_NPC_OPENED = "StopChatLootRecording",
    GARRISON_SHIPYARD_NPC_CLOSED = "ResumeChatLootRecording",
    GARRISON_SHIPYARD_NPC_OPENED = "StopChatLootRecording",
    GOSSIP_CLOSED = "ResumeChatLootRecording",
    GOSSIP_SHOW = true, -- also triggers StopChatLootRecording
    GROUP_ROSTER_UPDATE = true,
    GUILDBANKFRAME_CLOSED = "ResumeChatLootRecording",
    GUILDBANKFRAME_OPENED = true, -- also triggers StopChatLootRecording
    ISLAND_AZERITE_GAIN = true,
    ISLAND_COMPLETED = true,
    ITEM_TEXT_BEGIN = true,
    ITEM_UPGRADE_MASTER_OPENED = true,
    LOOT_CLOSED = true,
    LOOT_OPENED = true,
    LOOT_SLOT_CLEARED = "HandleBadChatLootData",
    MAIL_CLOSED = "ResumeChatLootRecording",
    MAIL_SHOW = true, -- also triggers StopChatLootRecording
    MERCHANT_CLOSED = true, -- also triggers ResumeChatLootRecording
    MERCHANT_SHOW = "UpdateMerchantItems", -- also triggers StopChatLootRecording
    MERCHANT_UPDATE = "UpdateMerchantItems",
    PET_BAR_UPDATE = true,
    --PET_JOURNAL_LIST_UPDATE = true,
    PLAYER_REGEN_DISABLED = true,
    PLAYER_REGEN_ENABLED = true,
    PLAYER_TARGET_CHANGED = true,
    QUEST_COMPLETE = true,
    QUEST_DETAIL = true,
    QUEST_LOG_UPDATE = true,
    QUEST_PROGRESS = true,
    SHOW_LOOT_TOAST = true,
    SPELL_CONFIRMATION_PROMPT = true,
    TAXIMAP_OPENED = true,
    TRADE_CLOSED = "ResumeChatLootRecording",
    TRADE_SHOW = "StopChatLootRecording",
    TRADE_SKILL_SHOW = true,
    TRAINER_CLOSED = true,
    TRAINER_SHOW = true,
    TRANSMOGRIFY_OPEN = true,
    UNIT_PET = true,
    UNIT_QUEST_LOG_CHANGED = true,
    UNIT_SPELLCAST_FAILED = "HandleSpellFailure",
    UNIT_SPELLCAST_FAILED_QUIET = "HandleSpellFailure",
    UNIT_SPELLCAST_INTERRUPTED = "HandleSpellFailure",
    UNIT_SPELLCAST_SENT = true,
    UNIT_SPELLCAST_SUCCEEDED = true,
    VOID_STORAGE_OPEN = true,
}


-- VARIABLES ----------------------------------------------------------

local anvil_spell_ids = {}
local currently_drunk
local char_db
local global_db
local group_member_guids = {}
local group_owner_guids_to_pet_guids = {}
local group_pet_guids = {}
local in_instance
local item_process_timer_handle
local faction_standings = {}
local forge_spell_ids = {}
local languages_known = {}
local boss_loot_toasting = {}
local container_loot_toasting
local loot_toast_container_id
local raid_boss_id
local loot_toast_container_timer_handle
local loot_toast_data
local loot_toast_data_timer_handle
local name_to_id_map = {}
local killed_boss_id_timer_handle
local killed_npc_id
local target_location_timer_handle
local last_timber_spell_id
local last_garrison_cache_object_id
local block_chat_loot_data
local chat_loot_data = {}
local chat_loot_timer_handle
local world_quest_timer_handle
local world_quest_event_timestamp = 0
local killed_npcs_in_island = {}
local island_difficulty_token
local current_target_id
local current_loot


-- Data for our current action. Including possible values as a reference.
local current_action = {
    identifier = nil,
    loot_label = nil,
    loot_list = nil,
    loot_sources = nil,
    map_level = nil,
    spell_label = nil,
    target_type = nil,
    x = nil,
    y = nil,
    zone_data = nil,
}


-- Timer prototypes
local ClearKilledNPC, ClearKilledBossID, ClearLootToastContainerID, ClearLootToastData, ClearChatLootData


-- HELPERS ------------------------------------------------------------

local function Debug(message, ...)
    if not DEBUGGING or not message then
        return
    end

    if ... then
        local args = { ... }

        for index = 1, #args do
            args[index] = tostring(args[index])
        end
        _G.print(message:format(unpack(args)))
    else
        _G.print(message)
    end
end


local function InitializeCurrentLoot()
    current_loot = {
        list = {},
        sources = {},
        identifier = current_action.identifier,
        label = current_action.loot_label or "drops",
        map_level = current_action.map_level,
        object_name = current_action.object_name,
        spell_label = current_action.spell_label,
        target_type = current_action.target_type,
        x = current_action.x,
        y = current_action.y,
        zone_data = current_action.zone_data,
    }

    table.wipe(current_action)
end


local TradeSkillExecutePer
do
    local header_list = {}

    function TradeSkillExecutePer(iter_func)
        if not _G.TradeSkillFrame or not _G.TradeSkillFrame:IsVisible() then
            return
        end

        local recipes = _G.C_TradeSkillUI.GetAllRecipeIDs()

        if recipes and (#recipes > 0) then
            for i = 1, #recipes do
                if iter_func(_G.C_TradeSkillUI.GetRecipeInfo(recipes[i]).name, recipes[i]) then
                    break
                end
            end
        end
    end
end -- do-block


local ActualCopperCost
do
    local BARTERING_SPELL_ID = 83964

    function ActualCopperCost(copper_cost, rep_standing)
        if not copper_cost or copper_cost == 0 then
            return 0
        end
        local modifier = 1

        if _G.IsSpellKnown(BARTERING_SPELL_ID) then
            modifier = modifier - 0.1
        end

        if rep_standing then
            if PLAYER_RACE == "Goblin" then
                modifier = modifier - private.STANDING_DISCOUNTS["EXALTED"]
            elseif private.STANDING_DISCOUNTS[rep_standing] then
                modifier = modifier - private.STANDING_DISCOUNTS[rep_standing]
            end
        end
        return math.floor(copper_cost / modifier)
    end
end -- do-block


local function InstanceDifficultyToken()
    -- Sometimes, instance information is returned when not in an instance. This check protects against that.
    if _G.IsInInstance() then
        local _, instance_type, instance_difficulty, _, _, _, is_dynamic = _G.GetInstanceInfo()

        if not instance_type or instance_type == "" then
            instance_type = "NONE"
        end
        return ("%s:%d:%s"):format(instance_type:upper(), instance_difficulty, tostring(is_dynamic))
    end
    return "NONE:0:false"
end


local function CurrentLocationData()
    local x, y, current_area_id, map_level, map_file, is_micro_dungeon = HereBeDragons:GetPlayerZonePosition(false)
    local zone_name = _G.GetRealZoneText()

    -- Remove micro-dungeon-ness by translating back to the parent world map (at floor 0) if possible
    if (is_micro_dungeon and x and y and current_area_id and map_level and map_level > 0) then
        x, y = HereBeDragons:TranslateZoneCoordinates(x, y, current_area_id, map_level, current_area_id, 0, false)
        map_level = 0
    end

    -- Put coordinates into expected format (as integers, they don't get a billion decimals output in the SavedVariables)
    local x_int = nil
    if (x and type(x) == "number") then
        x_int = _G.floor(x * 1000)

        -- Limit precision to 0.2
        if x_int % 2 ~= 0 then
            x_int = x_int + 1
        end

        -- Prevent out of bounds coordinates
        if (x_int < 0 or x_int > 1000) then
            x_int = nil
        end
    end
    local y_int = nil
    if (y and type(y) == "number") then
        y_int = _G.floor(y * 1000)

        -- Limit precision to 0.2
        if y_int % 2 ~= 0 then
            y_int = y_int + 1
        end

        -- Prevent out of bounds coordinates
        if (y_int < 0 or y_int > 1000) then
            y_int = nil
        end
    end

    return zone_name, current_area_id, x_int, y_int, map_level, InstanceDifficultyToken()
end


local function DBEntry(data_type, unit_id)
    if not data_type or not unit_id then
        return
    end
    local category = global_db[data_type]

    if not category then
        category = {}
        global_db[data_type] = category
    end
    local unit = category[unit_id]

    if not unit then
        unit = {}
        category[unit_id] = unit
    end
    return unit
end

private.DBEntry = DBEntry

local NPCEntry
do
    local npc_prototype = {}
    local npc_meta = {
        __index = npc_prototype
    }

    function NPCEntry(identifier)
        local npc = DBEntry("npcs", identifier)
        return npc and _G.setmetatable(npc, npc_meta) or nil
    end

    function npc_prototype:EncounterData(difficulty_token)
        self.encounter_data = self.encounter_data or {}
        self.encounter_data[difficulty_token] = self.encounter_data[difficulty_token] or {}
        self.encounter_data[difficulty_token].stats = self.encounter_data[difficulty_token].stats or {}

        return self.encounter_data[difficulty_token]
    end
end


local UpdateDBEntryLocation
do
    -- Fishing node coordinate code based on code in GatherMate2 with permission from Kagaro.
    local function FishingCoordinates(x, y, yard_width, yard_height)
        local facing = _G.GetPlayerFacing()

        if not facing then
            return x, y
        end
        local rad = facing + math.pi
        return x + math.sin(rad) * 15 / yard_width, y + math.cos(rad) * 15 / yard_height
    end


    function UpdateDBEntryLocation(entry_type, identifier)
        if not identifier then
            return
        end
        local zone_name, area_id, x, y, map_level, difficulty_token = CurrentLocationData()
        if not (zone_name and area_id and x and y and map_level) then
            if not (_G.IsInInstance()) then
                Debug("UpdateDBEntryLocation: Missing current location data - %s, %s, %s, %s, %s.", tostring(zone_name), tostring(area_id), tostring(x), tostring(y), tostring(map_level))
            end
            return
        end
        local entry = DBEntry(entry_type, identifier)
        entry[difficulty_token] = entry[difficulty_token] or {}
        entry[difficulty_token].locations = entry[difficulty_token].locations or {}

        local zone_token = ("%s:%d"):format(zone_name, area_id)
        local zone_data = entry[difficulty_token].locations[zone_token]

        if not zone_data then
            zone_data = {}
            entry[difficulty_token].locations[zone_token] = zone_data
        end

        -- Special case for Fishing.
        if current_action.spell_label == "FISHING" then
            local _, q_vector = _G.C_Map.GetWorldPosFromMapPos(area_id, _G.CreateVector2D(0,0))
            local _, w_vector = _G.C_Map.GetWorldPosFromMapPos(area_id, _G.CreateVector2D(1,1))
            local yard_width, yard_height = q_vector.y - w_vector.y, q_vector.x - w_vector.x

            if yard_width > 0 and yard_height > 0 then
                x, y = FishingCoordinates(x, y, yard_width, yard_height)
                current_action.x = x
                current_action.y = y
            end
        end
        local location_token = ("%d:%d:%d"):format(map_level, x, y)

        zone_data[location_token] = zone_data[location_token] or true
        return zone_data
    end
end -- do-block


local function CurrencyLinkToID(currency_link)
    if not currency_link then
        return nil
    end
    return tonumber(tostring(currency_link):match("currency:(%d+)"))
end


local function ItemLinkToID(item_link)
    if not item_link then
        return
    end
    return tonumber(tostring(item_link):match("item:(%d+)"))
end

private.ItemLinkToID = ItemLinkToID

local function UnitTypeIsNPC(unit_type)
    return unit_type == private.UNIT_TYPES.NPC or unit_type == private.UNIT_TYPES.VEHICLE
end


local ParseGUID
do
    local UNIT_TYPES = private.UNIT_TYPES

    local NPC_ID_MAPPING = {
        [62164] = 63191, -- Garalon
    }


    local function MatchUnitTypes(unit_type_name)
        if not unit_type_name then
            return UNIT_TYPES.UNKNOWN
        end

        for def, text in next, UNIT_TYPES do
            if unit_type_name == text then
                return UNIT_TYPES[def]
            end
        end
        return UNIT_TYPES.UNKNOWN
    end


    function ParseGUID(guid)
        if not guid then
            return
        end

        -- We might want to use some of this new information later, but leaving the returns alone for now
        local guid_pieces = { ("-"):split(guid) }
        local unit_type_name, unk_field, server_id, instance_id, zone_uid, unit_id, spawn_uid, player_uid = guid_pieces[1]

        local unit_type = MatchUnitTypes(unit_type_name)

        -- Creatures, GameObjects, Vehicles, and Vignettes
        if unit_type ~= UNIT_TYPES.PLAYER and unit_type ~= UNIT_TYPES.PET and unit_type ~= UNIT_TYPES.ITEM then
            unk_field, server_id, instance_id, zone_uid, unit_id, spawn_uid = guid_pieces[2], guid_pieces[3], guid_pieces[4], guid_pieces[5], guid_pieces[6], guid_pieces[7]

            local id_mapping = NPC_ID_MAPPING[unit_id]

            if id_mapping and UnitTypeIsNPC(unit_type) then
                unit_id = id_mapping
            end

        -- Players
        elseif unit_type == UNIT_TYPES.PLAYER then
            server_id, player_uid = guid_pieces[2], guid_pieces[3]

        -- Items
        elseif unit_type == UNIT_TYPES.ITEM then
            server_id, unk_field, spawn_uid = guid_pieces[2], guid_pieces[3], guid_pieces[4]
        end

        -- Pets and other (i.e. do nothing)
        return unit_type, unit_id
    end

    private.ParseGUID = ParseGUID
end -- do-block


local function HandleItemUse(item_link, bag_index, slot_index)
    if not item_link then
        return
    end
    local item_id = ItemLinkToID(item_link)

    if not bag_index or not slot_index then
        for new_bag_index = 0, _G.NUM_BAG_FRAMES do
            for new_slot_index = 1, _G.GetContainerNumSlots(new_bag_index) do
                if item_id == ItemLinkToID(_G.GetContainerItemLink(new_bag_index, new_slot_index)) then
                    bag_index = new_bag_index
                    slot_index = new_slot_index
                    break
                end
            end
        end
    end

    local any_loot = false

    -- Check if Blizzard has marked this item as officially having a chance of containing loot
    if bag_index and slot_index then
        local _, _, _, _, _, is_lootable = _G.GetContainerItemInfo(bag_index, slot_index)
        if is_lootable then
            any_loot = true
        end
    end

    -- Check if we've marked this item as one Blizzard provides bad is_lootable data for
    if private.CONTAINER_ITEM_ID_LIST[item_id] ~= nil then
        any_loot = true
    end

    -- Going to block 'chat-loot data' at this level for now because I don't think we actually want normal item containers being recorded in these scenarios either.
    if any_loot and not block_chat_loot_data then
        -- For item containers that open instantly with no spell cast
        if (private.CONTAINER_ITEM_ID_LIST[item_id] == true) and ((not _G.GetNumLootItems()) or (_G.GetNumLootItems() == 0)) then
            ClearChatLootData()
            Debug("HandleItemUse: Beginning chat-based loot timer for item with ID %d.", item_id)
            chat_loot_timer_handle = C_Timer.NewTimer(1.5, ClearChatLootData)
            chat_loot_data.category = AF.ITEM
            chat_loot_data.identifier = item_id
        -- For normal item containers
        else
            table.wipe(current_action)
            current_loot = nil
            current_action.target_type = AF.ITEM
            current_action.identifier = item_id
            current_action.loot_label = "contains"
        end
    end
end


local UnitFactionStanding
local UpdateFactionData
do
    local MAX_FACTION_INDEX = 1000

    local STANDING_NAMES = {
        "HATED",
        "HOSTILE",
        "UNFRIENDLY",
        "NEUTRAL",
        "FRIENDLY",
        "HONORED",
        "REVERED",
        "EXALTED",
    }


    function UnitFactionStanding(unit)
        local unit_name = _G.UnitName(unit)
        UpdateFactionData()
        DatamineTT:ClearLines()
        DatamineTT:SetUnit(unit)

        for line_index = 1, DatamineTT:NumLines() do
            local faction_name = _G["WDPDatamineTTTextLeft" .. line_index]:GetText():trim()

            if faction_name and faction_name ~= unit_name and faction_standings[faction_name] then
                return faction_name, faction_standings[faction_name]
            end
        end
    end


    function UpdateFactionData()
        for faction_index = 1, MAX_FACTION_INDEX do
            local faction_name, _, current_standing, _, _, _, _, _, is_header = _G.GetFactionInfo(faction_index)

            if faction_name then
                faction_standings[faction_name] = STANDING_NAMES[current_standing]
            elseif not faction_name then
                break
            end
        end
    end
end -- do-block


local GenericLootUpdate, LootTable
do
    function LootTable(entry, loot_type, top_field)
        if top_field then
            entry[top_field] = entry[top_field] or {}
            entry[top_field][loot_type] = entry[top_field][loot_type] or {}
            return entry[top_field][loot_type]
        end
        entry[loot_type] = entry[loot_type] or {}
        return entry[loot_type]
    end

    function GenericLootUpdate(data_type, top_field)
        local loot_type = current_loot.label
        local loot_count = ("%s_count"):format(loot_type)
        local source_list = {}

        if current_loot.sources then
            for source_guid, loot_data in pairs(current_loot.sources) do
                local source_id

                if current_loot.target_type == AF.ITEM then
                    -- Items return the player as the source, so we need to use the item's ID (disenchant, milling, etc)
                    source_id = current_loot.identifier
                else
                    local _, unit_ID = ParseGUID(source_guid)
                    if unit_ID then
                        if current_loot.target_type == AF.OBJECT then
                            source_id = ("%s:%s"):format(current_loot.spell_label, unit_ID)
                        else
                            source_id = unit_ID
                        end
                    end
                end
                local entry = DBEntry(data_type, source_id)

                if entry then
                    local loot_table = LootTable(entry, loot_type, top_field)

                    if not source_list[source_id] then
                        if top_field then
                            entry[top_field][loot_count] = (entry[top_field][loot_count] or 0) + 1
                        elseif not container_loot_toasting then
                            entry[loot_count] = (entry[loot_count] or 0) + 1
                        end
                        source_list[source_id] = true
                    end
                    UpdateDBEntryLocation(data_type, source_id)

                    if current_loot.target_type == AF.ZONE then
                        for item_id, quantity in pairs(loot_data) do
                            table.insert(loot_table, ("%d:%d"):format(item_id, quantity))
                        end
                    else
                        for loot_token, quantity in pairs(loot_data) do
                            local label, currency_id = (":"):split(loot_token)

                            if label == "currency" and currency_id then
                                -- Convert currency_id back into number from string
                                currency_id = tonumber(currency_id) or 0
                                if currency_id ~= 0 then
                                    table.insert(loot_table, ("currency:%d:%d"):format(quantity, currency_id))
                                end
                            elseif loot_token == "money" then
                                table.insert(loot_table, ("money:%d"):format(quantity))
                            else
                                table.insert(loot_table, ("%d:%d"):format(loot_token, quantity))
                            end
                        end
                    end
                end
            end
        end

        -- This is used for Gas Extractions.
        if #current_loot.list <= 0 then
            return
        end
        local entry

        -- At this point we only have a name if it's an object.
        -- (As of 5.x, the above statement is almost never true, but there are a few cases, like gas extractions.)
        if current_loot.target_type == AF.OBJECT then
            entry = DBEntry(data_type, ("%s:%s"):format(current_loot.spell_label, current_loot.object_name))
        else
            entry = DBEntry(data_type, current_loot.identifier)
        end

        if not entry then
            return
        end
        local loot_table = LootTable(entry, loot_type, top_field)

        if current_loot.identifier then
            if not source_list[current_loot.identifier] then
                if top_field then
                    entry[top_field][loot_count] = (entry[top_field][loot_count] or 0) + 1
                else
                    entry[loot_count] = (entry[loot_count] or 0) + 1
                end
                source_list[current_loot.identifier] = true
            end
        end

        for index = 1, #current_loot.list do
            table.insert(loot_table, current_loot.list[index])
        end
    end
end -- do-block


local ReplaceKeywords
do
    local KEYWORD_SUBSTITUTIONS = {
        class = PLAYER_CLASS,
        name = PLAYER_NAME,
        race = PLAYER_RACE,
    }


    function ReplaceKeywords(text)
        if not text or text == "" then
            return ""
        end

        for category, lookup in pairs(KEYWORD_SUBSTITUTIONS) do
            local category_format = ("<%s>"):format(category)
            text = text:gsub(lookup, category_format):gsub(lookup:lower(), category_format)
        end
        return text
    end
end -- do-block


-- TIMERS -------------------------------------------------------------

function ClearKilledNPC()
    killed_npc_id = nil
end


function ClearKilledBossID()
    if killed_boss_id_timer_handle then
        killed_boss_id_timer_handle:Cancel()
        killed_boss_id_timer_handle = nil
    end

    table.wipe(boss_loot_toasting)
    raid_boss_id = nil
end


function ClearLootToastContainerID()
    if loot_toast_container_timer_handle then
        loot_toast_container_timer_handle:Cancel()
        loot_toast_container_timer_handle = nil
    end

    container_loot_toasting = false
    loot_toast_container_id = nil
end


function ClearLootToastData()
    if loot_toast_data_timer_handle then
        loot_toast_data_timer_handle:Cancel()
        loot_toast_data_timer_handle = nil
    end

    if loot_toast_data then
        table.wipe(loot_toast_data)
    end
end


function ClearChatLootData()
    if not chat_loot_timer_handle then
        table.wipe(chat_loot_data)
        return
    end
    Debug("ClearChatLootData: Ending chat-based loot timer.")
    chat_loot_timer_handle:Cancel()
    chat_loot_timer_handle = nil
    
    -- Slimmed down (and more importantly, separate) versions of GenericLootUpdate, specifically for chat_loot_data
    -- First version is for special item containers that 'push' loot without using a loot window
    if chat_loot_data.identifier and chat_loot_data.loot and chat_loot_data.category == AF.ITEM and private.CONTAINER_ITEM_ID_LIST[chat_loot_data.identifier] ~= nil then
        local entry = DBEntry("items", chat_loot_data.identifier)

        if entry then
            local loot_table = LootTable(entry, "contains")
            entry["contains_count"] = (entry["contains_count"] or 0) + 1

            for loot_token, quantity in pairs(chat_loot_data.loot) do
                local label, currency_id = (":"):split(loot_token)

                if label == "currency" and currency_id then
                    -- Convert currency_id back into number from string
                    currency_id = tonumber(currency_id) or 0
                    if currency_id ~= 0 then
                        table.insert(loot_table, ("currency:%d:%d"):format(quantity, currency_id))
                    end
                elseif loot_token == "money" then
                    table.insert(loot_table, ("money:%d"):format(quantity))
                else
                    table.insert(loot_table, ("%d:%d"):format(loot_token, quantity))
                end
            end
        end
    -- Second version is for Island Expeditions. This code is flawed (by design).
    elseif chat_loot_data.loot and chat_loot_data.category == AF.NPC then
        -- Iterate over all NPCs killed in an island expedition (at least by your team)
        for island_npc_id, kill_count in pairs(killed_npcs_in_island) do
            local npc = NPCEntry(island_npc_id)
            if npc then
                -- Create needed npc fields if required
                local loot_label = "drops"
                local encounter_data = npc:EncounterData(InstanceDifficultyToken())
                encounter_data[loot_label] = encounter_data[loot_label] or {}
                encounter_data.loot_counts = encounter_data.loot_counts or {}
                encounter_data.loot_counts[loot_label] = (encounter_data.loot_counts[loot_label] or 0) + kill_count

                for loot_token, quantity in pairs(chat_loot_data.loot) do
                    local label, currency_id = (":"):split(loot_token)

                    -- Only support items
                    if (label ~= "currency" or not currency_id) and (loot_token ~= "money") then
                        -- Ignore certain items (dubloon bags)
                        if not private.IGNORED_ISLAND_REWARDS[tonumber(loot_token)] then
                            table.insert(encounter_data[loot_label], ("%d:%d"):format(loot_token, quantity))
                        end
                    end
                end
            end
        end
    end
    table.wipe(killed_npcs_in_island)
    table.wipe(chat_loot_data)
end


-- METHODS ------------------------------------------------------------

function WDP:OnInitialize()
    local db = LibStub("AceDB-3.0"):New("WoWDBProfilerData", DATABASE_DEFAULTS, "Default")
    private.db = db
    global_db = db.global
    char_db = db.char

    local raw_db = _G.WoWDBProfilerData
    local build_num = tonumber(private.build_num)

    -- Get current region from API (flawed)
    local current_region = _G.GetCurrentRegionName() or "XX"

    -- Wipe all data if DB version or build number changed
    if (raw_db.version and raw_db.version < DB_VERSION) or (raw_db.build_num and raw_db.build_num < build_num) then
        for entry in pairs(DATABASE_DEFAULTS.global) do
            global_db[entry] = {}
        end
    end
    -- Wipe World Quest data if region changed
    if raw_db.region and raw_db.region ~= current_region and global_db["world_quests"] then
        global_db["world_quests"] = {}
    end

    raw_db.build_num = build_num
    raw_db.region = current_region
    raw_db.version = DB_VERSION

    private.InitializeCommentSystem()
    self:RegisterChatCommand("comment", private.ProcessCommentCommand)
end


function WDP:EventDispatcher(...)
    local event_name = ...

    if DEBUGGING then
        if event_name == "COMBAT_LOG_EVENT_UNFILTERED" then
            Debug(event_name)
        else
            Debug(...)
        end
    end
    local func = EVENT_MAPPING[event_name]

    if type(func) == "boolean" then
        self[event_name](self, ...)
    elseif type(func) == "function" then
        self[func](self, ...)
    end
end


function WDP:OnEnable()
    PLAYER_GUID = _G.UnitGUID("player")

    for event_name, mapping in pairs(EVENT_MAPPING) do
        if EVENT_DEBUG then
            self:RegisterEvent(event_name, "EventDispatcher")
        else
            self:RegisterEvent(event_name, (type(mapping) ~= "boolean") and mapping or nil)
        end
    end

    -- Gather known languages
    for index = 1, _G.GetNumLanguages() do
        languages_known[_G.GetLanguageByIndex(index)] = true
    end

    -- These timers loop indefinitely using Lua's infinity constant
    item_process_timer_handle = C_Timer.NewTicker(DELAY_PROCESS_ITEMS, WDP.ProcessItems, nil)
    target_location_timer_handle = C_Timer.NewTicker(DELAY_UPDATE_TARGET_LOCATION, WDP.UpdateTargetLocation, nil)
    world_quest_timer_handle = C_Timer.NewTicker(DELAY_PROCESS_WORLD_QUESTS, WDP.ProcessWorldQuests, nil)

    _G.hooksecurefunc("UseContainerItem", function(bag_index, slot_index, target_unit)
        if target_unit then
            return
        end
        HandleItemUse(_G.GetContainerItemLink(bag_index, slot_index), bag_index, slot_index)
    end)

    _G.hooksecurefunc("UseItemByName", function(identifier, target_unit)
        if target_unit then
            return
        end
        local _, item_link = _G.GetItemInfo(identifier)
        HandleItemUse(item_link)
    end)

    self:GROUP_ROSTER_UPDATE()
end


-- Record data for a specific quest ID; reward data must be available or nothing will be recorded
-- When we reach this point, we've already checked for a valid mapID, questID, quest data, and worldQuestType
local function RecordWorldQuestData(quest_id, api_data_table)
    local xp, _ = _G.GetQuestLogRewardXP(quest_id)

    -- Ensure we have location data and rewards (barely readable so putting it on multiple lines)
    -- (Honor is built in to the quest; it is not a sign rewards have been loaded)
    if not api_data_table or not api_data_table.x or not api_data_table.y or not api_data_table.mapID or not
      (xp > 0 or _G.GetNumQuestLogRewardCurrencies(quest_id) > 0
      or _G.GetNumQuestLogRewards(quest_id) > 0 or _G.GetQuestLogRewardMoney(quest_id) > 0) then
    --or _G.GetQuestLogRewardArtifactXP(quest_id) > 0)
        return
    end

    local entry = DBEntry("world_quests", quest_id)
    if entry then

        -- Record location
        entry["location"] = {}
        entry["location"]["world_map_id"] = api_data_table.mapID
        entry["location"]["x"] = api_data_table.x * 100
        entry["location"]["y"] = api_data_table.y * 100

        -- Record simple rewards (XP, money, artifact XP, honor)
        entry["rewards"] = {}
        entry["rewards"]["xp"] = tonumber(xp) or 0
        entry["rewards"]["money"] = tonumber(_G.GetQuestLogRewardMoney(quest_id)) or 0
        --local actualXP, scaling = _G.GetQuestLogRewardArtifactXP(quest_id)
        --entry["rewards"]["artifact_xp"] = ("%d:%d"):format(tonumber(actualXP) or 0, tonumber(scaling) or 0)
        entry["rewards"]["honor"] = tonumber(_G.GetQuestLogRewardHonor(quest_id)) or 0

        -- Record currencies
        entry["rewards"]["currency_count"] = tonumber(_G.GetNumQuestLogRewardCurrencies(quest_id)) or 0

        -- Create currency rewards sub-table and fill
        if entry["rewards"]["currency_count"] > 0 then
            entry["rewards"]["currencies"] = {}
            for i = 1, entry["rewards"]["currency_count"] do
                local name, texture_path, quantity, currency_id = _G.GetQuestLogRewardCurrencyInfo(i, quest_id)
                table.insert(entry["rewards"]["currencies"], ("%d:%d"):format(quantity, currency_id))
            end
        end

        -- Record items
        entry["rewards"]["item_count"] = tonumber(_G.GetNumQuestLogRewards(quest_id)) or 0

        -- Create item rewards sub-table and fill
        if entry["rewards"]["item_count"] > 0 then
            entry["rewards"]["items"] = {}
            for i = 1, entry["rewards"]["item_count"] do
                local item_name, item_texture, quantity, quality, is_usable, item_id = _G.GetQuestLogRewardInfo(i, quest_id)
                table.insert(entry["rewards"]["items"], ("%d:%d"):format(item_id, quantity))
            end
        end

        -- Record time remaining
        entry["estimated_end_time"] = _G.GetServerTime() + ((_G.C_TaskQuest.GetQuestTimeLeftMinutes(quest_id) or 0) * 60)
    end
end


function WDP:ProcessWorldQuests()
    -- Ignore if player is low level (there are some world quests before max level now, but we can collect enough data from 110s alone still)
    if _G.UnitLevel("player") < 110 then return end

    -- Check all first-order continents
    local continents = C_Map.GetMapChildrenInfo(UI_MAP_COSMIC, Enum.UIMapType.Continent, true);
    for i, continentInfo in ipairs(continents) do
        
        -- Get continent data for World Quests
        local continent_api_data = C_TaskQuest.GetQuestsForPlayerByMapID(continentInfo.mapID)

        -- If the continent has WQ data, continue
        if continent_api_data and type(continent_api_data) == "table" and #continent_api_data > 0 then
            -- Iterate over zones on continents
            local zones = C_Map.GetMapChildrenInfo(continentInfo.mapID, Enum.UIMapType.Zone)
            for j, zoneInfo in ipairs(zones) do

                -- Get zone data for World Quests
                local zone_api_data = C_TaskQuest.GetQuestsForPlayerByMapID(zoneInfo.mapID);

                -- Iterate over the questIDs for each zone, doing preload reward requests and creating SavedVariables entries
                if zone_api_data and type(zone_api_data) == "table" and #zone_api_data > 0 then
                    for k = 1, #zone_api_data do

                        -- Check if we had a valid API table returned to us
                        if zone_api_data[k] and type(zone_api_data[k]) == "table" and zone_api_data[k].questId then
                            local quest_id = tonumber(zone_api_data[k].questId) or 0

                            -- Check if we have quest data and the quest is within this zone directly
                            if quest_id > 0 and _G.HaveQuestData(quest_id) and QuestUtils_IsQuestWorldQuest(quest_id) and zone_api_data[k].mapID == zoneInfo.mapID then
                                _G.C_TaskQuest.RequestPreloadRewardData(quest_id)
                                RecordWorldQuestData(quest_id, zone_api_data[k])
                            end
                        end
                    end
                end
            end
        end
    end
end


local function RecordItemData(item_id, item_link, process_bonus_ids, durability)
    local _, _, item_string = item_link:find("^|%x+|H(.+)|h%[.+%]")
    local item

    if item_string then
        local item_results = { (":"):split(item_string) }

        local suffix_id = tonumber(item_results[8]) or 0
        local unique_id = tonumber(item_results[9]) or 0
        --local level = tonumber(item_results[10])
        --local specialization_id = tonumber(item_results[11])
        --local upgrade_type_id = tonumber(item_results[12])
        local instance_difficulty_id = tonumber(item_results[13]) or 0
        local num_bonus_ids = tonumber(item_results[14]) or 0
        -- upgrade_value is optional in 6.2! can be detected using upgrade_type_id, but it's just as easy to check like this
        local upgrade_value = tonumber(item_results[15 + num_bonus_ids]) or 0

        local unk_item_field_1 = tonumber(item_results[16 + num_bonus_ids]) or 0
        local unk_item_field_2 = tonumber(item_results[17 + num_bonus_ids]) or 0
        --if unk_item_field_1 > 0 then Debug("unk_item_field_1 for %s is non-zero, specifically %d.", item_link, unk_item_field_1) end
        --if unk_item_field_2 > 0 then Debug("unk_item_field_2 for %s is non-zero, specifically %d.", item_link, unk_item_field_2) end

        -- If there is anything special (non-zero) for this item then we need to make note of everything
        if math.max(suffix_id, instance_difficulty_id, num_bonus_ids, upgrade_value) ~= 0 then
            item = DBEntry("items", item_id)
            item.suffix_id = suffix_id
            item.unique_id = bit.band(unique_id, 0xFFFF)
            item.instance_difficulty_id = instance_difficulty_id
            item.upgrade_value = upgrade_value

            if process_bonus_ids then

                -- Get ready for bonus IDs
                if not item.seen_bonuses then
                    item.seen_bonuses = {}
                end

                if num_bonus_ids > 0 then
                    -- We want the bonus ID combo output to be in the form ["bonusID1:bonusID2:bonusID3"] = true
                    -- And sorted numerically with the smallest bonusID first
                    local sorted_bonus_string = ""
                    local min_bonus_id_array = {}
                    for iterations = 1, num_bonus_ids do
                        -- Find minimum of this iteration
                        local min_bonus_id = 100000
                        for bonus_index = 1, num_bonus_ids do
                            local temp_bonus_id = tonumber(item_results[14 + bonus_index])
                            if temp_bonus_id and (not min_bonus_id_array[temp_bonus_id]) and (temp_bonus_id < min_bonus_id) then
                                min_bonus_id = temp_bonus_id
                            end
                        end

                        -- Keep track of already processed IDs
                        min_bonus_id_array[min_bonus_id] = true

                        -- Build string
                        if iterations == 1 then
                            sorted_bonus_string = sorted_bonus_string .. tostring(min_bonus_id)
                        else
                            sorted_bonus_string = sorted_bonus_string .. ":" .. tostring(min_bonus_id)
                        end
                    end

                    item.seen_bonuses[sorted_bonus_string] = true
                    Debug("RecordItemData: Recorded bonus IDs %s for item %d.", sorted_bonus_string, item_id)
                else
                    item.seen_bonuses["0"] = true
                end
            end
        end
    end

    if durability and durability > 0 then
        item = item or DBEntry("items", item_id)
        item.durability = durability
    end
end


function WDP:ProcessItems()
    for slot_index = _G.INVSLOT_FIRST_EQUIPPED, _G.INVSLOT_LAST_EQUIPPED do
        local item_id = _G.GetInventoryItemID("player", slot_index)

        if item_id and item_id > 0 then
            local _, max_durability = _G.GetInventoryItemDurability(slot_index)
            RecordItemData(item_id, _G.GetInventoryItemLink("player", slot_index), false, max_durability)
        end
    end

    for bag_index = 0, _G.NUM_BAG_SLOTS do
        for slot_index = 1, _G.GetContainerNumSlots(bag_index) do
            local item_id = _G.GetContainerItemID(bag_index, slot_index)

            if item_id and item_id > 0 then
                local _, max_durability = _G.GetContainerItemDurability(bag_index, slot_index)
                RecordItemData(item_id, _G.GetContainerItemLink(bag_index, slot_index), false, max_durability)
            end
        end
    end
end


local function TargetedNPC()
    if not _G.UnitExists("target") or _G.UnitPlayerControlled("target") or currently_drunk then
        current_target_id = nil
        return
    end
    local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("target"))

    if not unit_idnum or not UnitTypeIsNPC(unit_type) then
        return
    end
    current_target_id = unit_idnum

    local npc = NPCEntry(unit_idnum)
    local _, class_token = _G.UnitClass("target")
    npc.class = class_token
    npc.faction = UnitFactionStanding("target")
    npc.genders = npc.genders or {}
    npc.genders[private.GENDER_NAMES[_G.UnitSex("target")] or "UNDEFINED"] = true
    npc.is_pvp = _G.UnitIsPVP("target") and true or nil
    npc.reaction = ("%s:%s:%s"):format(_G.UnitLevel("player"), _G.UnitFactionGroup("player"), private.REACTION_NAMES[_G.UnitReaction("player", "target")])

    local encounter_data = npc:EncounterData(InstanceDifficultyToken()).stats
    local npc_level = ("level_%d"):format(_G.UnitLevel("target"))
    local level_data = encounter_data[npc_level]

    if not level_data then
        level_data = {}
        encounter_data[npc_level] = level_data
    end
    level_data.max_health = level_data.max_health or _G.UnitHealthMax("target")

    -- May not capture as much data as it could, since the API changed in Legion to report multiple types of power
    if not level_data.power then
        local max_power = _G.UnitPowerMax("target")

        if max_power > 0 then
            local power_type = _G.UnitPowerType("target")
            level_data.power = ("%s:%d"):format(private.POWER_TYPE_NAMES[tostring(power_type)] or power_type, max_power)
        end
    end
    name_to_id_map[_G.UnitName("target")] = unit_idnum
    return npc, unit_idnum
end


do
    local COORD_MAX = 5

    function WDP:UpdateTargetLocation()
        if currently_drunk or not _G.UnitExists("target") or _G.UnitPlayerControlled("target") or (_G.UnitIsTapDenied("target") and not _G.UnitIsDead("target")) then
            return
        end

        for index = 1, 4 do
            if not _G.CheckInteractDistance("target", index) then
                return
            end
        end
        local npc = TargetedNPC()

        if not npc then
            return
        end
        local zone_name, area_id, x, y, map_level, difficulty_token = CurrentLocationData()
        if not (zone_name and area_id and x and y and map_level) then
            if not (_G.IsInInstance()) then
                Debug("UpdateTargetLocation: Missing current location data - %s, %s, %s, %s, %s.", tostring(zone_name), tostring(area_id), tostring(x), tostring(y), tostring(map_level))
            end
            return
        end
        local npc_data = npc:EncounterData(difficulty_token).stats[("level_%d"):format(_G.UnitLevel("target"))]
        local zone_token = ("%s:%d"):format(zone_name, area_id)
        npc_data.locations = npc_data.locations or {} -- TODO: Fix this. It is broken. Possibly something to do with the timed updates.

        local zone_data = npc_data.locations[zone_token]

        if not zone_data then
            zone_data = {}
            npc_data.locations[zone_token] = zone_data
        end

        for location_token in pairs(zone_data) do
            local loc_level, loc_x, loc_y = (":"):split(location_token)
            loc_level = tonumber(loc_level)

            if map_level == loc_level and math.abs(x - loc_x) <= COORD_MAX and math.abs(y - loc_y) <= COORD_MAX then
                return
            end
        end
        zone_data[("%d:%d:%d"):format(map_level, x, y)] = true
    end
end -- do-block


function WDP:HandleBadChatLootData(...)
    ClearChatLootData()
end


-- EVENT HANDLERS -----------------------------------------------------

-- This function (and the following function) are to stop 'HandleItemUse' from triggering when you put an item that would normally be opened into the bank, guild bank, etc.
function WDP:StopChatLootRecording(event_name)
    if not block_chat_loot_data then
        Debug("%s: Pausing chat-based loot recording.", event_name)
        ClearChatLootData()
        block_chat_loot_data = true
    end
end


function WDP:ResumeChatLootRecording(event_name)
    if block_chat_loot_data then
        Debug("%s: Resuming chat-based loot recording.", event_name)
        block_chat_loot_data = false
    end
end


-- For now, bonus roll data only pollutes the true drop percentages. We still want to capture the data from SPELL_CONFIRMATION_PROMPT because of legendary quest items though.
function WDP:BONUS_ROLL_RESULT(event_name)
    Debug("%s: Bonus roll detected; stopping loot recording for this boss to avoid recording bonus loot.", event_name)
    ClearKilledBossID()
    ClearLootToastContainerID()
end


-- Store all known killed NPCs during an island in a table
function WDP:ISLAND_AZERITE_GAIN(event_name, amount, gained_by_player, faction_index, gained_by, gained_from)
    -- Exit now if GUID is not for an NPC
    local unit_type, unit_id = ParseGUID(gained_from)
    if not UnitTypeIsNPC(unit_type) then
        return
    end
    
    -- Otherwise, store the NPC ID in the island kill table (if it already exists there, increment its count by 1)
    Debug("%s: Recording killed island NPC with ID #%d.", event_name, unit_id)
    if killed_npcs_in_island[unit_id] then
        killed_npcs_in_island[unit_id] = killed_npcs_in_island[unit_id] + 1
    else
        killed_npcs_in_island[unit_id] = 1
    end
end


-- Start chat loot timer for NPCs (and store general island information)
function WDP:ISLAND_COMPLETED(event_name)
    island_difficulty_token = InstanceDifficultyToken()

    Debug("%s: Beginning chat-based loot timer for Island Expedition rewards.", event_name, item_id)
    chat_loot_timer_handle = C_Timer.NewTimer(1.5, ClearChatLootData)
    chat_loot_data.category = AF.NPC
    chat_loot_data.identifier = 0
end


function WDP:BLACK_MARKET_ITEM_UPDATE(event_name)
    if not ALLOWED_LOCALES[CLIENT_LOCALE] then
        return
    end
    local num_items = _G.C_BlackMarket.GetNumItems() or 0

    for index = 1, num_items do
        local name, texture, quantity, item_type, is_usable, level, level_type, seller_name, min_bid, min_increment, current_bid, has_high_bid, num_bids, time_left, item_link, market_id = _G.C_BlackMarket.GetItemInfoByIndex(index);

        if item_link then
            DBEntry("items", ItemLinkToID(item_link)).black_market = seller_name or "UNKNOWN"
        end
    end
end


local function UpdateUnitPet(unit_guid, unit_id)
    local current_pet_guid = group_owner_guids_to_pet_guids[unit_guid]

    if current_pet_guid then
        group_owner_guids_to_pet_guids[unit_guid] = nil
        group_pet_guids[current_pet_guid] = nil
    end
    local pet_guid = _G.UnitGUID(unit_id .. "pet")

    if pet_guid then
        group_owner_guids_to_pet_guids[unit_guid] = pet_guid
        group_pet_guids[pet_guid] = true
    end
end


function WDP:GROUP_ROSTER_UPDATE(event_name)
    local is_raid = _G.IsInRaid()
    local unit_type = is_raid and "raid" or "party"
    local group_size = is_raid and _G.GetNumGroupMembers() or _G.GetNumSubgroupMembers()

    table.wipe(group_member_guids)

    for index = 1, group_size do
        local unit_id = unit_type .. index
        local unit_guid = _G.UnitGUID(unit_id)

        group_member_guids[unit_guid] = true
        UpdateUnitPet(unit_guid, unit_id)
    end
    group_member_guids[PLAYER_GUID] = true
end


function WDP:UNIT_PET(event_name, unit_id)
    UpdateUnitPet(_G.UnitGUID(unit_id), unit_id)
end


function WDP:SHOW_LOOT_TOAST(event_name, loot_type, item_link, quantity, spec_ID, sex_ID, is_personal, loot_source)
    if not loot_type or (loot_type ~= "item" and loot_type ~= "money" and loot_type ~= "currency") then
        Debug("%s: loot_type is %s. Item link is %s, and quantity is %d.", event_name, loot_type, item_link, quantity)
        return
    end

    -- Need information on the most recent args, so using this complete debug statement for now
    Debug("%s: loot_type: %s, item_link: %s, quantity: %s, spec_ID: %s, sex_ID: %s, is_personal: %s, loot_source: %s", event_name, loot_type, item_link, quantity, spec_ID, sex_ID, is_personal, loot_source)

    -- Handle Garrison cache specially
    if loot_source and (loot_source == LOOT_SOURCE_ID_GARRISON_CACHE) and last_garrison_cache_object_id then
        -- Record location data for cache
        UpdateDBEntryLocation("objects", ("OPENING:%d"):format(last_garrison_cache_object_id))

        -- Add drop data
        local currency_id = CurrencyLinkToID(item_link)
        if currency_id and currency_id ~= 0 then
            -- Check for top level object data
            local object_entry = DBEntry("objects", ("OPENING:%d"):format(last_garrison_cache_object_id))
            local difficulty_token = InstanceDifficultyToken()
            if object_entry[difficulty_token] then
                -- Increment loot count
                object_entry[difficulty_token]["opening_count"] = (object_entry[difficulty_token]["opening_count"] or 0) + 1

                Debug("%s: %d X %d", event_name, currency_id, quantity)
                object_entry[difficulty_token]["opening"] = object_entry[difficulty_token]["opening"] or {}
                table.insert(object_entry[difficulty_token]["opening"], ("currency:%d:%d"):format(quantity, currency_id))
            else
                Debug("%s: When handling the Garrison cache, the top level loot data was missing for objectID %d.", event_name, last_garrison_cache_object_id)
            end
        else
            Debug("%s: Currency ID is nil or 0, from currency link %s", event_name, item_link)
        end

        -- Wipe object ID until future mouseover
        last_garrison_cache_object_id = nil
    elseif raid_boss_id then
        local npc = NPCEntry(raid_boss_id)
        if npc then
            local loot_label = "drops"
            local encounter_data = npc:EncounterData(InstanceDifficultyToken())
            encounter_data[loot_label] = encounter_data[loot_label] or {}
            encounter_data.loot_counts = encounter_data.loot_counts or {}

            if loot_type == "item" then
                local item_id = ItemLinkToID(item_link)
                if item_id then
                    Debug("%s: %s X %d (%d)", event_name, item_link, quantity, item_id)
                    RecordItemData(item_id, item_link, true)
                    table.insert(encounter_data[loot_label], ("%d:%d"):format(item_id, quantity))
                else
                    Debug("%s: ItemID is nil, from item link %s", event_name, item_link)
                    return
                end
            elseif loot_type == "money" then
                Debug("%s: money X %d", event_name, quantity)
                table.insert(encounter_data[loot_label], ("money:%d"):format(quantity))
            elseif loot_type == "currency" then
                local currency_id = CurrencyLinkToID(item_link)
                if currency_id and currency_id ~= 0 then
                    Debug("%s: %d X %d", event_name, currency_id, quantity)
                    table.insert(encounter_data[loot_label], ("currency:%d:%d"):format(quantity, currency_id))
                else
                    Debug("%s: Currency ID is nil or 0, from currency link %s", event_name, item_link)
                    return
                end
            end

            if not boss_loot_toasting[raid_boss_id] then
                encounter_data.loot_counts[loot_label] = (encounter_data.loot_counts[loot_label] or 0) + 1
                boss_loot_toasting[raid_boss_id] = true -- Do not count further loots until timer expires or another boss is killed
            end
        end
    elseif loot_toast_container_id then
        InitializeCurrentLoot()

        -- Fake the loot characteristics to match that of an actual container item
        current_loot.identifier = loot_toast_container_id
        current_loot.label = "contains"
        current_loot.target_type = AF.ITEM

        current_loot.sources[loot_toast_container_id] = current_loot.sources[loot_toast_container_id] or {}

        if loot_type == "item" then
            local item_id = ItemLinkToID(item_link)
            if item_id then
                Debug("%s: %s X %d (%d)", event_name, item_link, quantity, item_id)
                RecordItemData(item_id, item_link, true)
                current_loot.sources[loot_toast_container_id][item_id] = (current_loot.sources[loot_toast_container_id][item_id] or 0) + quantity
            else
                Debug("%s: ItemID is nil, from item link %s", event_name, item_link)
                current_loot = nil
                return
            end
        elseif loot_type == "money" then
            Debug("%s: money X %d", event_name, quantity)
            current_loot.sources[loot_toast_container_id]["money"] = (current_loot.sources[loot_toast_container_id]["money"] or 0) + quantity
        elseif loot_type == "currency" then
            local currency_id = CurrencyLinkToID(item_link)
            if currency_id and currency_id ~= 0 then
                Debug("%s: %d X %d", event_name, currency_id, quantity)
                local currency_token = ("currency:%d"):format(currency_id)
                current_loot.sources[loot_toast_container_id][currency_token] = (current_loot.sources[loot_toast_container_id][currency_token] or 0) + quantity
            else
                Debug("%s: Currency ID is nil or 0, from currency link %s", event_name, item_link)
                current_loot = nil
                return
            end
        end

        GenericLootUpdate("items")
        current_loot = nil
        container_loot_toasting = true -- Do not count further loots until timer expires or another container is opened
    elseif loot_source and chat_loot_timer_handle and chat_loot_data.category == AF.ITEM then
        -- Handle currency loot toasts for chat-based loot (we do this instead of reading currency chat messages because the chat messages are very delayed)
        if loot_type == "currency" then
            local currency_id = CurrencyLinkToID(item_link)
            if currency_id and currency_id ~= 0 then
                -- Verify that we're still assigning data to the right items
                if chat_loot_data.category == AF.ITEM and chat_loot_data.identifier and (private.CONTAINER_ITEM_ID_LIST[chat_loot_data.identifier] ~= nil) then
                    Debug("%s: Captured currency for chat-based loot recording. %d X %d", event_name, currency_id, quantity)
                    local currency_token = ("currency:%d"):format(currency_id)
                    chat_loot_data.loot = chat_loot_data.loot or {}
                    chat_loot_data.loot[currency_token] = (chat_loot_data.loot[currency_token] or 0) + quantity
                else -- If not, cancel the timer and wipe the loot table early
                    Debug("%s: Canceled chat-based loot recording because we would have assigned the wrong loot!", event_name)
                    ClearChatLootData()
                end
            else
                Debug("%s: Currency ID is nil or 0, from currency link %s", event_name, item_link)
            end
        -- Handle money loot toasts for chat-based loot (we do this instead of reading money chat messages because the chat messages are very delayed)
        elseif loot_type == "money" then
            -- Verify that we're still assigning data to the right items
            if chat_loot_data.category == AF.ITEM and chat_loot_data.identifier and (private.CONTAINER_ITEM_ID_LIST[chat_loot_data.identifier] ~= nil) then
                Debug("%s: Captured money for chat-based loot recording. money X %d", event_name, quantity)
                chat_loot_data.loot = chat_loot_data.loot or {}
                chat_loot_data.loot["money"] = (chat_loot_data.loot["money"] or 0) + quantity
            else -- If not, cancel the timer and wipe the loot table early
                Debug("%s: Canceled chat-based loot recording because we would have assigned the wrong loot!", event_name)
                ClearChatLootData()
            end
        end
    else
        Debug("%s: NPC and Container are nil, storing loot toast data for 5 seconds.", event_name)

        loot_toast_data = loot_toast_data or {}
        loot_toast_data[#loot_toast_data + 1] = { loot_type, item_link, quantity }

        local item_id = ItemLinkToID(item_link)
        if item_id then
            RecordItemData(item_id, item_link, true)
        end

        loot_toast_data_timer_handle = C_Timer.NewTimer(5, ClearLootToastData)
    end
end


do
    local CHAT_MSG_CURRENCY_UPDATE_FUNCS = {
        [AF.NPC] = function(currency_id, quantity)
            Debug("CHAT_MSG_CURRENCY: AF.NPC currency:%d (%d)", currency_id, quantity)
        end,
        [AF.ZONE] = function(currency_id, quantity)
            Debug("CHAT_MSG_CURRENCY: AF.ZONE currency:%d (%d)", currency_id, quantity)
            InitializeCurrentLoot()
            current_loot.list[1] = ("currency:%d:%d"):format(quantity, currency_id)
            GenericLootUpdate("zones")
            current_loot = nil
        end,
    }


    function WDP:CHAT_MSG_CURRENCY(event_name, message)
        local category

        local currency_link, quantity = deformat(message, _G.CURRENCY_GAINED_MULTIPLE)
        if not currency_link then
            quantity, currency_link = 1, deformat(message, _G.CURRENCY_GAINED)
        end
        local currency_id = CurrencyLinkToID(currency_link)

        if not currency_id or currency_id == 0 then
            return
        end

        -- Set update category
        if current_action.spell_label == "FISHING" then
            category = AF.ZONE
        elseif raid_boss_id then
            category = AF.NPC
        end

        -- Take action based on update category
        local update_func = CHAT_MSG_CURRENCY_UPDATE_FUNCS[category]
        if not category or not update_func then
            return
        end
        update_func(currency_id, quantity)
    end


    local CHAT_MSG_LOOT_UPDATE_FUNCS = {
        -- Handle chat loot data from item containers
        [AF.ITEM] = function(item_id, quantity)
            -- Verify that we're still assigning data to the right items
            if chat_loot_data.identifier and (private.CONTAINER_ITEM_ID_LIST[chat_loot_data.identifier] ~= nil) then
                Debug("CHAT_MSG_LOOT: AF.ITEM %d (%d)", item_id, quantity)
                chat_loot_data.loot = chat_loot_data.loot or {}
                chat_loot_data.loot[item_id] = (chat_loot_data.loot[item_id] or 0) + quantity
            else -- If not, cancel the timer and wipe the loot table early
                Debug("CHAT_MSG_LOOT: We would have assigned the wrong loot!")
                ClearChatLootData()
            end
        end,
        -- Handle chat loot data from island expedition rewards
        [AF.NPC] = function(item_id, quantity)
            Debug("CHAT_MSG_LOOT: AF.NPC %d (%d)", item_id, quantity)
            chat_loot_data.loot = chat_loot_data.loot or {}
            chat_loot_data.loot[item_id] = (chat_loot_data.loot[item_id] or 0) + quantity
        end,
        -- Handle logging spells for objects
        [AF.OBJECT] = function(item_id, quantity)
            Debug("CHAT_MSG_LOOT: AF.OBJECT %d (%d)", item_id, quantity)
            -- Check for top level object data
            local object_entry = DBEntry("objects", ("OPENING:%s"):format(private.LOGGING_SPELL_ID_TO_OBJECT_ID_MAP[last_timber_spell_id]))
            local difficulty_token = InstanceDifficultyToken()
            if object_entry[difficulty_token] then
                -- Increment loot count
                object_entry[difficulty_token]["opening_count"] = (object_entry[difficulty_token]["opening_count"] or 0) + 1

                -- Add drop data
                object_entry[difficulty_token]["opening"] = object_entry[difficulty_token]["opening"] or {}
                table.insert(object_entry[difficulty_token]["opening"], ("%d:%d"):format(item_id, quantity))
            else
                Debug("CHAT_MSG_LOOT: When handling timber, the top level data was missing for objectID %s.", private.LOGGING_SPELL_ID_TO_OBJECT_ID_MAP[last_timber_spell_id])
            end
        end,
        -- Handle fishing loot table population
        [AF.ZONE] = function(item_id, quantity)
            Debug("CHAT_MSG_LOOT: AF.ZONE %d (%d)", item_id, quantity)
            InitializeCurrentLoot()
            current_loot.list[1] = ("%d:%d"):format(item_id, quantity)
            GenericLootUpdate("zones")
            current_loot = nil
        end,
    }


    function WDP:CHAT_MSG_LOOT(event_name, message)
        local category

        local item_link, quantity = deformat(message, _G.LOOT_ITEM_PUSHED_SELF_MULTIPLE)
        if not item_link then
            quantity, item_link = 1, deformat(message, _G.LOOT_ITEM_PUSHED_SELF)
        end
        local item_id = ItemLinkToID(item_link)

        if not item_id then
            return
        end

        -- Set update category
        if last_timber_spell_id and item_id == ITEM_ID_TIMBER then
            category = AF.OBJECT
        -- Changed from ~= "EXTRACT_GAS" because of some occassional bad data, and, as far as I know, no benefit.
        elseif current_action.spell_label == "FISHING" then
            category = AF.ZONE
        elseif not raid_boss_id and chat_loot_timer_handle and chat_loot_data.category == AF.NPC then
            category = AF.NPC
        elseif not raid_boss_id and chat_loot_timer_handle and chat_loot_data.category == AF.ITEM then
            category = AF.ITEM
        end

        -- We still want to record the item's data, even if it doesn't need its drop location recorded
        RecordItemData(item_id, item_link, true)

        -- Take action based on update category
        local update_func = CHAT_MSG_LOOT_UPDATE_FUNCS[category]
        if not category or not update_func or private.BLACKLISTED_ITEMS[item_id] then
            return
        end
        update_func(item_id, quantity)
    end
end


function WDP:RecordQuote(event_name, message, source_name, language_name)
    if not ALLOWED_LOCALES[CLIENT_LOCALE] or not source_name or not name_to_id_map[source_name] or (language_name ~= "" and not languages_known[language_name]) then
        return
    end
    local npc = NPCEntry(name_to_id_map[source_name])
    npc.quotes = npc.quotes or {}
    npc.quotes[event_name] = npc.quotes[event_name] or {}
    npc.quotes[event_name][ReplaceKeywords(message)] = true
end


do
    local SOBER_MATCH = _G.DRUNK_MESSAGE_ITEM_SELF1:gsub("%%s", ".+")

    local DRUNK_COMPARES = {
        _G.DRUNK_MESSAGE_SELF2,
        _G.DRUNK_MESSAGE_SELF3,
        _G.DRUNK_MESSAGE_SELF4,
    }

    local DRUNK_MATCHES = {
        (_G.DRUNK_MESSAGE_SELF2:gsub("%%s", ".+")),
        (_G.DRUNK_MESSAGE_SELF3:gsub("%%s", ".+")),
        (_G.DRUNK_MESSAGE_SELF4:gsub("%%s", ".+")),
    }

    local RECIPE_MATCH = _G.ERR_LEARN_RECIPE_S:gsub("%%s", "(.*)")


    local function RecordDiscovery(tradeskill_name, tradeskill_index)
        if tradeskill_name == private.discovered_recipe_name then
            DBEntry("spells", tonumber(_G.C_TradeSkillUI.GetRecipeLink(tradeskill_index):match("^|c%x%x%x%x%x%x%x%x|H%w+:(%d+)"))).discovery = ("%d:%d"):format(private.previous_spell_id, private.profession_level)

            private.discovered_recipe_name = nil
            private.profession_level = nil
            private.previous_spell_id = nil

            return true
        end
    end


    local function IterativeRecordDiscovery()
        TradeSkillExecutePer(RecordDiscovery)
    end


    function WDP:CHAT_MSG_SYSTEM(event_name, message)
        -- This code no longer works, as of Patch 7.0.3, because Blizzard unified the text from quest rewards and loot to match (and now there is no way to distinguish between them)
        --[[
        -- Removed in Patch 7.0.3; previously used to determine if a system message was a quest reward or not
        local ERR_QUEST_REWARD_ITEM_MULT_IS = _G.ERR_QUEST_REWARD_ITEM_MULT_IS or "Received %d of item: %s."
        local ERR_QUEST_REWARD_ITEM_S = _G.ERR_QUEST_REWARD_ITEM_S or "Received item: %s."

        local item_link, quantity = deformat(message, ERR_QUEST_REWARD_ITEM_MULT_IS)
        if not item_link then
            quantity, item_link = 1, deformat(message, ERR_QUEST_REWARD_ITEM_S)
        end
        local item_id = ItemLinkToID(item_link)

        if item_id then
            -- If it was a quest message (that we can decode), parse its link
            RecordItemData(item_id, item_link, true)
        else
            -- If it isn't a quest message, check the other uses of system messages
        end
        ]]--

        if not private.trainer_shown then
            local recipe_name = message:match(RECIPE_MATCH)

            if recipe_name and private.previous_spell_id then
                local profession_name, prof_level = _G.C_TradeSkillUI.GetTradeSkillLine()

                if profession_name == _G.UNKNOWN then
                    return
                end
                private.discovered_recipe_name = recipe_name
                private.profession_level = prof_level

                C_Timer.After(0.2, IterativeRecordDiscovery)
            end
        end

        if currently_drunk then
            if message == _G.DRUNK_MESSAGE_SELF1 or message:match(SOBER_MATCH) then
                currently_drunk = nil
            end
            return
        end

        for index = 1, #DRUNK_MATCHES do
            if message == DRUNK_COMPARES[index] or message:match(DRUNK_MATCHES[index]) then
                currently_drunk = true
                break
            end
        end
    end
end


do
    local FLAGS_NPC = bit.bor(_G.COMBATLOG_OBJECT_TYPE_GUARDIAN, _G.COMBATLOG_OBJECT_CONTROL_NPC)
    local FLAGS_NPC_CONTROL = bit.bor(_G.COMBATLOG_OBJECT_AFFILIATION_OUTSIDER, _G.COMBATLOG_OBJECT_CONTROL_NPC)

    local function RecordNPCSpell(sub_event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id)
        if not spell_id or private.BLACKLISTED_SPELLS[spell_id] then
            return
        end
        local source_type, source_id = ParseGUID(source_guid)

        if not source_id or not UnitTypeIsNPC(source_type) then
            return
        end

        if bit.band(FLAGS_NPC_CONTROL, source_flags) == FLAGS_NPC_CONTROL and bit.band(FLAGS_NPC, source_flags) ~= 0 then
            local encounter_data = NPCEntry(source_id):EncounterData(InstanceDifficultyToken())
            encounter_data.spells = encounter_data.spells or {}
            encounter_data.spells[spell_id] = (encounter_data.spells[spell_id] or 0) + 1
        end
    end

    local HEAL_BATTLE_PETS_SPELL_ID = 125801

    local previous_combat_event = {}

    local COMBAT_LOG_FUNCS = {
        SPELL_AURA_APPLIED = RecordNPCSpell,
        SPELL_CAST_START = RecordNPCSpell,
        SPELL_CAST_SUCCESS = function(sub_event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id)
            if spell_id == HEAL_BATTLE_PETS_SPELL_ID then
                local unit_type, unit_idnum = ParseGUID(source_guid)

                if unit_idnum and UnitTypeIsNPC(unit_type) then
                    NPCEntry(unit_idnum).stable_master = true
                end
            end
            RecordNPCSpell(sub_event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id)
        end,
        UNIT_DIED = function(sub_event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id)
            local unit_type, unit_idnum = ParseGUID(dest_guid)

            if not unit_idnum or not UnitTypeIsNPC(unit_type) then
                --Debug("%s: %s is not an NPC, or has no ID.", sub_event, dest_name or _G.UNKNOWN) -- we really don't need to know this
                ClearKilledNPC()
                private.harvesting = nil
                return
            end

            if source_guid == "" then
                source_guid = nil
            end
            local killer_guid = source_guid or previous_combat_event.source_guid
            local killer_name = source_name or previous_combat_event.source_name

            if not previous_combat_event.party_damage then
                --Debug("%s: %s was killed by %s (not group member or pet).", sub_event, dest_name or _G.UNKNOWN, killer_name or _G.UNKNOWN) -- broken in Patch 5.4
                table.wipe(previous_combat_event)
                ClearKilledNPC()
            else
                --Debug("%s: %s was killed by %s.", sub_event, dest_name or _G.UNKNOWN, killer_name or _G.UNKNOWN) -- broken in Patch 5.4
            end
            killed_npc_id = unit_idnum
            C_Timer.After(0.1, ClearKilledNPC)
        end,
    }


    local NON_DAMAGE_EVENTS = {
        SPELL_AURA_APPLIED = true,
        SPELL_AURA_REMOVED = true,
        SPELL_AURA_REMOVED_DOSE = true,
        SPELL_CAST_FAILED = true,
        SWING_MISSED = true,
    }

    local DAMAGE_EVENTS = {
        RANGE_DAMAGE = true,
        SPELL_BUILDING_DAMAGE = true,
        SPELL_DAMAGE = true,
        SPELL_PERIODIC_DAMAGE = true,
        SWING_DAMAGE = true,
    }


    function WDP:COMBAT_LOG_EVENT_UNFILTERED(event_name, time_stamp, sub_event, hide_caster, source_guid, source_name, source_flags, source_raid_flags, dest_guid, dest_name, dest_flags, dest_raid_flags, spell_id, ...)
        time_stamp, sub_event, hide_caster, source_guid, source_name, source_flags, source_raid_flags, dest_guid, dest_name, dest_flags, dest_raid_flags, spell_id = CombatLogGetCurrentEventInfo()

        local combat_log_func = COMBAT_LOG_FUNCS[sub_event]

        if not combat_log_func then
            if DAMAGE_EVENTS[sub_event] then
                table.wipe(previous_combat_event)
                previous_combat_event.source_name = source_name

                if source_guid ~= dest_guid and (in_instance or group_member_guids[source_guid] or group_pet_guids[source_guid]) then
                    previous_combat_event.party_damage = true
                end
            end
            return
        end
        combat_log_func(sub_event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id)

        if NON_DAMAGE_EVENTS[sub_event] then
            table.wipe(previous_combat_event)
        end
    end


    local DIPLOMACY_SPELL_ID = 20599
    local MR_POP_RANK1_SPELL_ID = 78634
    local MR_POP_RANK2_SPELL_ID = 78635
    local TRADING_PACT_SPELL_ID = 170200


    function WDP:COMBAT_TEXT_UPDATE(event_name, message_type, faction_name, amount)
        if message_type ~= "FACTION" or not killed_npc_id then
            return
        end
        UpdateFactionData()

        if not faction_name or not faction_standings[faction_name] then
            return
        end
        local npc = NPCEntry(killed_npc_id)
        ClearKilledNPC()

        if not npc then
            private.harvesting = nil
            return
        end
        npc.harvested = private.harvesting
        private.harvesting = nil

        local modifier = 1

        -- Check for modifiers from known spells
        if _G.IsSpellKnown(DIPLOMACY_SPELL_ID) then
            modifier = modifier + 0.1
        end
        if _G.IsSpellKnown(MR_POP_RANK2_SPELL_ID) then
            modifier = modifier + 0.1
        elseif _G.IsSpellKnown(MR_POP_RANK1_SPELL_ID) then
            modifier = modifier + 0.05
        end
        if _G.IsSpellKnown(TRADING_PACT_SPELL_ID) then
            modifier = modifier + 0.2
        end

        -- Determine faction ID
        local faction_ID
        for pseudo_faction_name, faction_data_table in pairs(private.FACTION_DATA) do
            if faction_name == faction_data_table[3] then
                -- Check ignore flag
                if faction_data_table[2] then
                    return
                end
                faction_ID = faction_data_table[1]
                break
            end
        end
        if faction_ID and faction_ID > 0 then
            -- Check for modifiers from Commendations (applied directly to the faction, account-wide)
            local _, _, _, _, _, _, _, _, _, _, _, _, _, _, has_bonus_rep_gain = GetFactionInfoByID(faction_ID)
            if has_bonus_rep_gain then
                modifier = modifier + 1
            end
        end

        -- Check for modifiers from buffs
        for buff_name, buff_data_table in pairs(private.REP_BUFFS) do
            if _G.UnitBuff("player", buff_name) then
                local modded_faction = buff_data_table.faction

                if not modded_faction or faction_name == modded_faction then
                    if buff_data_table.ignore then
                        -- Some buffs from tabards convert all rep of other factions into rep for a specific faction.
                        -- We can't know what faction the rep was orginally from, so we must ignore the data entirely in these cases.
                        return
                    else
                        modifier = modifier + buff_data_table.modifier
                    end
                end
            end
        end

        npc.reputations = npc.reputations or {}
        npc.reputations[("%s:%s"):format(faction_name, faction_standings[faction_name])] = math.floor(amount / modifier)
    end
end -- do-block


function WDP:CURSOR_UPDATE(event_name)
    if current_action.fishing_target or _G.Minimap:IsMouseOver() then
        return
    end
    local text = _G["GameTooltipTextLeft1"]:GetText()

    -- Handle Fishing
    if (current_action.spell_label == "FISHING") then
        if not text or text == "Fishing Bobber" then
            text = "NONE"
        else
            current_action.fishing_target = true
        end
        current_action.identifier = ("%s:%s"):format(current_action.spell_label, text)
     -- Handle Garrison Cache
    elseif private.GARRISON_CACHE_OBJECT_NAME_TO_OBJECT_ID_MAP[text] then
        last_garrison_cache_object_id = private.GARRISON_CACHE_OBJECT_NAME_TO_OBJECT_ID_MAP[text]
    end
end


function WDP:ITEM_TEXT_BEGIN(event_name)
    local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("npc"))

    if not unit_idnum or unit_type ~= private.UNIT_TYPES.OBJECT or _G.UnitName("npc") ~= _G.ItemTextGetItem() then
        return
    end
    UpdateDBEntryLocation("objects", unit_idnum)
end


do
    local LOOT_OPENED_VERIFY_FUNCS = {
        -- Item containers can be AOE-looted in Patch 5.4.2 if the user clicks fast enough, but this verification still works as long as they both have loot.
        [AF.ITEM] = function()
            local locked_item_id

            for bag_index = 0, _G.NUM_BAG_FRAMES do
                for slot_index = 1, _G.GetContainerNumSlots(bag_index) do
                    local _, _, is_locked, _, _, is_lootable = _G.GetContainerItemInfo(bag_index, slot_index)

                    if is_locked and is_lootable then
                        locked_item_id = ItemLinkToID(_G.GetContainerItemLink(bag_index, slot_index))
                        break
                    end
                end

                if locked_item_id then
                    break
                end
            end

            if (not current_action.spell_label == "DISENCHANT") and (not locked_item_id or (current_action.identifier and current_action.identifier ~= locked_item_id)) then
                return false
            end
            current_action.identifier = locked_item_id
            return true
        end,
        [AF.NPC] = function()
            return not _G.IsFishingLoot()
        end,
        [AF.OBJECT] = function()
            return not _G.IsFishingLoot()
        end,
        [AF.ZONE] = function()
            current_action.zone_data = UpdateDBEntryLocation("zones", current_action.identifier)
            return _G.IsFishingLoot()
        end,
    }


    local LOOT_OPENED_UPDATE_FUNCS = {
        [AF.ITEM] = function()
            GenericLootUpdate("items")
        end,
        [AF.NPC] = function()
            local difficulty_token = InstanceDifficultyToken()
            local loot_label = current_loot.label
            local source_list = {}

            for source_guid, loot_data in pairs(current_loot.sources) do
                local _, source_id = ParseGUID(source_guid)
                local npc = NPCEntry(source_id)

                if npc then
                    local encounter_data = npc:EncounterData(difficulty_token)
                    encounter_data[loot_label] = encounter_data[loot_label] or {}

                    if not source_list[source_guid] then
                        encounter_data.loot_counts = encounter_data.loot_counts or {}
                        encounter_data.loot_counts[loot_label] = (encounter_data.loot_counts[loot_label] or 0) + 1
                        source_list[source_guid] = true
                    end

                    for loot_token, quantity in pairs(loot_data) do
                        local loot_type, currency_id = (":"):split(loot_token)

                        if loot_type == "currency" and currency_id then
                            -- Convert currency_id back into number from string
                            currency_id = tonumber(currency_id) or 0
                            if currency_id ~= 0 then
                                table.insert(encounter_data[loot_label], ("currency:%d:%d"):format(quantity, currency_id))
                            end
                        elseif loot_token == "money" then
                            table.insert(encounter_data[loot_label], ("money:%d"):format(quantity))
                        else
                            table.insert(encounter_data[loot_label], ("%d:%d"):format(loot_token, quantity))
                        end
                    end
                end
            end
        end,
        [AF.OBJECT] = function()
            GenericLootUpdate("objects", InstanceDifficultyToken())
        end,
        [AF.ZONE] = function()
            if not (current_loot.map_level and current_loot.x and current_loot.y and current_loot.zone_data) then
                return
            end
            local location_token = ("%d:%d:%d"):format(current_loot.map_level, current_loot.x, current_loot.y)

            -- This will start life as a boolean true.
            if type(current_loot.zone_data[location_token]) ~= "table" then
                current_loot.zone_data[location_token] = {
                    drops = {}
                }
            end
            local loot_count = ("%s_count"):format(current_loot.label)
            current_loot.zone_data[location_token][loot_count] = (current_loot.zone_data[location_token][loot_count] or 0) + 1

            if current_loot.sources then
                for source_guid, loot_data in pairs(current_loot.sources) do
                    for item_id, quantity in pairs(loot_data) do
                        table.insert(current_loot.zone_data[location_token].drops, ("%d:%d"):format(item_id, quantity))
                    end
                end
            end

            if #current_loot.list <= 0 then
                return
            end

            for index = 1, #current_loot.list do
                table.insert(current_loot.zone_data[location_token].drops, current_loot.list[index])
            end
        end,
    }

    -- Prevent opening the same loot window multiple times from recording data multiple times.
    local loot_guid_registry = {}


    function WDP:LOOT_CLOSED(event_name)
        ClearChatLootData()
        current_loot = nil
        table.wipe(current_action)
    end


    local function ExtrapolatedCurrentActionFromLootData(event_name)
        local log_source = event_name .. "- ExtrapolatedCurrentActionFromLootData"
        local previous_spell_label = current_action.spell_label
        local extrapolated_guid_registry = {}
        local num_guids = 0
        table.wipe(current_action)

        if _G.IsFishingLoot() then
            -- Set up a proper 'fishing' current_action table
            local zone_name, area_id, x, y, map_level, instance_token = CurrentLocationData()
            if not (zone_name and area_id and x and y and map_level) then
                if not (_G.IsInInstance()) then
                    Debug("%s: Missing current location data - %s, %s, %s, %s, %s.", log_source, tostring(zone_name), tostring(area_id), tostring(x), tostring(y), tostring(map_level))
                end
                return
            end
            current_action.instance_token = instance_token
            current_action.map_level = map_level
            current_action.x = x
            current_action.y = y
            current_action.zone_data = ("%s:%d"):format(zone_name, area_id)
            current_action.spell_label = "FISHING"
            current_action.loot_label = "fishing"
            current_action.identifier = "FISHING:NONE"
            current_action.target_type = AF.ZONE

            Debug("%s: Fishing loot detected.", log_source)
            return true
        end

        -- Loot extrapolation cannot handle objects that need special spell labels (like HERBALISM or MINING) (MIND_CONTROL is okay)
        if previous_spell_label and private.SPELL_FLAGS_BY_LABEL[previous_spell_label] and not private.NON_LOOT_SPELL_LABELS[previous_spell_label] then
            Debug("%s: Problematic spell label %s found. Loot extrapolation for this set of loot would have run an increased risk of introducing bad data into the system.", log_source, private.previous_spell_id)
            return false
        end

        for loot_slot = 1, _G.GetNumLootItems() do
            local loot_info = {
                _G.GetLootSourceInfo(loot_slot)
            }

            for loot_index = 1, #loot_info, 2 do
                local source_guid = loot_info[loot_index]

                if not extrapolated_guid_registry[source_guid] then
                    local unit_type, unit_idnum = ParseGUID(source_guid)

                    if unit_type and unit_idnum then
                        extrapolated_guid_registry[source_guid] = {
                            unit_type,
                            unit_idnum
                        }

                        num_guids = num_guids + 1
                    end
                end
            end
        end

        if num_guids == 0 then
            Debug("%s: No GUIDs found in loot. Blank loot window?", log_source)
            return false
        end

        local num_npcs = 0
        local num_objects = 0
        local num_itemcontainers = 0

        for source_guid, guid_data in pairs(extrapolated_guid_registry) do
            local unit_type = guid_data[1]
            local loot_label = (unit_type == private.UNIT_TYPES.OBJECT) and "opening" or (UnitTypeIsNPC(unit_type) and "drops") or ((unit_type == private.UNIT_TYPES.ITEM) and "contains")

            if loot_label then
                local unit_idnum = guid_data[2]

                if loot_guid_registry[loot_label] and loot_guid_registry[loot_label][source_guid] then
                    Debug("%s: Previously scanned loot for unit with GUID %s and identifier %s.", log_source, source_guid, unit_idnum)
                elseif unit_type == private.UNIT_TYPES.OBJECT and unit_idnum ~= OBJECT_ID_FISHING_BOBBER then
                    current_action.loot_label = loot_label
                    current_action.spell_label = "OPENING"
                    current_action.target_type = AF.OBJECT
                    current_action.identifier = unit_idnum
                    num_objects = num_objects + 1
                elseif UnitTypeIsNPC(unit_type) then
                    current_action.loot_label = loot_label
                    current_action.target_type = AF.NPC
                    current_action.identifier = unit_idnum
                    num_npcs = num_npcs + 1
                elseif unit_type == private.UNIT_TYPES.ITEM then
                    current_action.loot_label = loot_label
                    current_action.target_type = AF.ITEM
                    -- current_action.identifier assigned during loot verification.
                    num_itemcontainers = num_itemcontainers + 1
                end
            else
                -- Bail here; not only do we not know what this unit is, but we don't want to attribute loot to something that doesn't actually drop it.
                Debug("%s: Unit with GUID %s has unsupported type for looting.", log_source, source_guid)
                return false
            end
        end

        if not current_action.target_type then
            Debug("%s: Failure to obtain target_type.", log_source)
            return false
        end

        -- We can't figure out what dropped the loot. This shouldn't ever happen, but hey - Blizzard does some awesome stuff on occasion.
        if (num_npcs > 0 and num_objects + num_itemcontainers > 0) or (num_objects > 0 and num_npcs + num_itemcontainers > 0) or (num_itemcontainers > 0 and num_npcs + num_objects > 0) then
            Debug("%s: Mixed target types are not supported. NPCs - %d, Objects - %d, Item Containers - %d.", log_source, num_npcs, num_objects, num_itemcontainers)
            return false
        end

        return true
    end


    function WDP:LOOT_OPENED(event_name)
        ClearChatLootData()

        if current_loot then
            current_loot = nil
            Debug("%s: Previous loot did not process in time for this event. Attempting to extrapolate current_action from loot data.", event_name)

            if not ExtrapolatedCurrentActionFromLootData(event_name) then
                Debug("%s: Unable to extrapolate current_action. Aborting attempts to handle loot for now.", event_name)
                return
            end
        end

        if not current_action.target_type then
            if not ExtrapolatedCurrentActionFromLootData(event_name) then
                Debug("%s: Unable to extrapolate current_action. Aborting attempts to handle loot for now.", event_name)
                return
            end
        end
        local verify_func = LOOT_OPENED_VERIFY_FUNCS[current_action.target_type]
        local update_func = LOOT_OPENED_UPDATE_FUNCS[current_action.target_type]

        if not verify_func or not update_func then
            Debug("%s: The current action's target type is unsupported or nil.", event_name)
            return
        end

        if type(verify_func) == "function" and not verify_func() then
            Debug("%s: The current action type, %s, is supported but has failed loot verification.", event_name, private.ACTION_TYPE_NAMES[current_action.target_type])
            return
        end
        local guids_used = {}

        InitializeCurrentLoot()
        loot_guid_registry[current_loot.label] = loot_guid_registry[current_loot.label] or {}

        for loot_slot = 1, _G.GetNumLootItems() do
            local texture_filedata_id, item_text, slot_quantity, quality, locked = _G.GetLootSlotInfo(loot_slot)
            local slot_type = _G.GetLootSlotType(loot_slot)
            local loot_info = { _G.GetLootSourceInfo(loot_slot) }
            local loot_link = _G.GetLootSlotLink(loot_slot)

            -- Odd index is GUID, even is count.
            for loot_index = 1, #loot_info, 2 do
                local source_guid = loot_info[loot_index]

                if not loot_guid_registry[current_loot.label][source_guid] then
                    local loot_quantity = loot_info[loot_index + 1]
                    -- There is a new bug in 5.4.0 that causes GetLootSlotInfo() to (rarely) return nil values for slot_quantity.
                    if slot_quantity then
                        -- We need slot_quantity to account for an old bug where loot_quantity is sometimes '1' for stacks of items, such as cloth.
                        if slot_quantity > loot_quantity then
                            loot_quantity = slot_quantity
                        end
                        local source_type, source_id = ParseGUID(source_guid)
                        local source_key = ("%s:%d"):format(source_type, source_id)

                        if slot_type == LOOT_SLOT_ITEM then
                            if loot_link then
                                local item_id = ItemLinkToID(loot_link)
                                Debug("GUID: %s - Type:ID: %s - ItemID: %d - Amount: %d (%d)", loot_info[loot_index], source_key, item_id, loot_info[loot_index + 1], slot_quantity)
                                current_loot.sources[source_guid] = current_loot.sources[source_guid] or {}
                                current_loot.sources[source_guid][item_id] = (current_loot.sources[source_guid][item_id] or 0) + loot_quantity
                                guids_used[source_guid] = true
                            else
                                Debug("%s: Loot link is nil for loot slot %d of the entity with GUID %s and Type:ID: %s.", event_name, loot_slot, loot_info[loot_index], source_key)
                            end
                        elseif slot_type == LOOT_SLOT_MONEY then
                            Debug("GUID: %s - Type:ID: %s - Money - Amount: %d (%d)", loot_info[loot_index], source_key, loot_info[loot_index + 1], slot_quantity)
                            if current_loot.target_type == AF.ZONE then
                                table.insert(current_loot.list, ("money:%d"):format(loot_quantity))
                            else
                                current_loot.sources[source_guid] = current_loot.sources[source_guid] or {}
                                current_loot.sources[source_guid]["money"] = (current_loot.sources[source_guid]["money"] or 0) + loot_quantity
                                guids_used[source_guid] = true
                            end
                        elseif slot_type == LOOT_SLOT_CURRENCY then
                            -- Same bug with GetLootSlotInfo() will screw up currency when it happens, so we won't process this slot's loot.
                            if loot_link then
                                local currency_id = CurrencyLinkToID(loot_link)
                                Debug("GUID: %s - Type:ID: %s - Currency: %d - Amount: %d (%d)", loot_info[loot_index], source_key, currency_id, loot_info[loot_index + 1], slot_quantity)
                                if current_loot.target_type == AF.ZONE then
                                    table.insert(current_loot.list, ("currency:%d:%d"):format(loot_quantity, currency_id))
                                else
                                    local currency_token = ("currency:%d"):format(currency_id)

                                    current_loot.sources[source_guid] = current_loot.sources[source_guid] or {}
                                    current_loot.sources[source_guid][currency_token] = (current_loot.sources[source_guid][currency_token] or 0) + loot_quantity
                                    guids_used[source_guid] = true
                                end
                            else
                                Debug("%s: Loot link is nil for loot slot %d of the entity with GUID %s and Type:ID: %s.", event_name, loot_slot, loot_info[loot_index], source_key)
                            end
                        end
                    else
                        -- If this is nil, then the item's quantity could be wrong if loot_quantity is wrong, so we won't process this slot's loot.
                        Debug("%s: Slot quantity is nil for loot slot %d of the entity with GUID %s and Type:ID: %s.", event_name, loot_slot, loot_info[loot_index], source_key)
                    end
                end
            end
        end

        for guid in pairs(guids_used) do
            loot_guid_registry[current_loot.label][guid] = true
        end
        update_func()
    end
end -- do-block


function WDP:MAIL_SHOW(event_name)
    WDP:StopChatLootRecording(event_name)
    local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("npc"))

    if not unit_idnum or unit_type ~= private.UNIT_TYPES.OBJECT then
        return
    end
    UpdateDBEntryLocation("objects", unit_idnum)
end


do
    local POINT_MATCH_PATTERNS = {
        ("^%s$"):format(_G.ITEM_REQ_ARENA_RATING:gsub("%%d", "(%%d+)")), -- May no longer be necessary
        ("^%s$"):format(_G.ITEM_REQ_ARENA_RATING_3V3:gsub("%%d", "(%%d+)")), -- May no longer be necessary
        ("^%s$"):format(_G.ITEM_REQ_ARENA_RATING_5V5:gsub("%%d", "(%%d+)")), -- May no longer be necessary
        ("^%s$"):format(_G.ITEM_REQ_ARENA_RATING_BG:gsub("%%d", "(%%d+)")),
        ("^%s$"):format(_G.ITEM_REQ_ARENA_RATING_3V3_BG:gsub("%%d", "(%%d+)")),
    }

    local ITEM_REQ_REPUTATION_MATCH = "Requires (.-) %- (.*)"
    local ITEM_REQ_QUEST_MATCH1 = "Requires: .*"
    local ITEM_REQ_QUEST_MATCH2 = "Must have completed: .*"

    local current_merchant
    local merchant_standing

    function WDP:MERCHANT_CLOSED(event_name)
        WDP:ResumeChatLootRecording(event_name)
        current_merchant = nil
        merchant_standing = nil
    end


    function WDP:UpdateMerchantItems(event_name)
        if not current_merchant or event_name == "MERCHANT_SHOW" then
            WDP:StopChatLootRecording(event_name)
            local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("npc"))

            if not unit_idnum or not UnitTypeIsNPC(unit_type) then
                return
            end
            local _, faction_standing = UnitFactionStanding("npc")
            merchant_standing = faction_standing
            current_merchant = NPCEntry(unit_idnum)
            current_merchant.sells = current_merchant.sells or {}
        end
        local current_filters = _G.GetMerchantFilter()
        _G.SetMerchantFilter(_G.LE_LOOT_FILTER_ALL)
        _G.MerchantFrame_Update()

        local num_items = _G.GetMerchantNumItems()

        for item_index = 1, num_items do
            local _, _, copper_price, stack_size, num_available, _, extended_cost = _G.GetMerchantItemInfo(item_index)
            local item_id = ItemLinkToID(_G.GetMerchantItemLink(item_index))

            DatamineTT:ClearLines()
            DatamineTT:SetMerchantItem(item_index)

            if not item_id then
                local item_name, item_link = DatamineTT:GetItem()
                item_id = ItemLinkToID(item_link)
                -- GetMerchantItemLink() still ocassionally fails as of Patch 6.0.2. It fails so badly that debug functions cause considerable slowdown.
            end

            if item_id and item_id > 0 then
                local price_string = ActualCopperCost(copper_price, merchant_standing)

                local num_lines = DatamineTT:NumLines()

                for line_index = 1, num_lines do
                    local current_line = _G["WDPDatamineTTTextLeft" .. line_index]

                    if not current_line then
                        break
                    end
                    local faction, reputation = current_line:GetText():match(ITEM_REQ_REPUTATION_MATCH)

                    if faction or reputation then
                        DBEntry("items", item_id).req_reputation = ("%s:%s"):format(faction:gsub("-", ""), reputation:upper())
                        break
                    end
                end

                for line_index = 1, num_lines do
                    local current_line = _G["WDPDatamineTTTextLeft" .. line_index]

                    if not current_line then
                        break
                    end
                    local line_text = current_line:GetText()
                    local quest_name = line_text:match(ITEM_REQ_QUEST_MATCH1) or line_text:match(ITEM_REQ_QUEST_MATCH2)

                    if quest_name then
                        DBEntry("items", item_id).req_quest = ("%s"):format(quest_name:gsub("(.+): ", ""), quest_name)
                        break
                    end
                end

                if extended_cost then
                    local battleground_rating = 0
                    local personal_rating = 0
                    local required_season_amount

                    for line_index = 1, num_lines do
                        local current_line = _G["WDPDatamineTTTextLeft" .. line_index]

                        if not current_line then
                            break
                        end
                        required_season_amount = current_line:GetText():match("Requires earning a total of (%d+)\n(.-) for the season.")

                        for match_index = 1, #POINT_MATCH_PATTERNS do
                            local match1, match2 = current_line:GetText():match(POINT_MATCH_PATTERNS[match_index])
                            personal_rating = personal_rating + (match1 or 0)
                            battleground_rating = battleground_rating + (match2 or 0)

                            if match1 or match2 then
                                break
                            end
                        end
                    end
                    local currency_list = {}
                    local item_count = _G.GetMerchantItemCostInfo(item_index)

                    -- Keeping this around in case Blizzard makes the two ratings (personal and battleground) diverge at some point
                    --price_string = ("%s:%s:%s:%s"):format(price_string, battleground_rating, personal_rating, required_season_amount or 0)
                    price_string = ("%s:%s:%s"):format(price_string, personal_rating, required_season_amount or 0)

                    for cost_index = 1, item_count do
                        -- The third return (Blizz calls "currency_link") of GetMerchantItemCostItem only returns item links as of Patch 5.3.0.
                        local texture_id, amount_required, hyperlink, name = _G.GetMerchantItemCostItem(item_index, cost_index)

                        -- Try to get item ID
                        local item_id = ItemLinkToID(hyperlink)

                        -- FUTURE: At some point, we should make the output from these two cases (item_id vs currency_id) slightly different, so that WoWDB doesn't have to guess if it is a currency or item
                        -- Handle cases when the additional cost is another item
                        if item_id and item_id > 0 then
                            currency_list[#currency_list + 1] = ("(%s:%d)"):format(amount_required, item_id)
                        else
                            -- Try to get currency ID
                            local currency_id = CurrencyLinkToID(hyperlink)
                            if currency_id and currency_id > 0 then
                                currency_list[#currency_list + 1] = ("(%s:%d)"):format(amount_required, currency_id)
                            else
                                Debug("UpdateMerchantItems: Failed to get item ID and failed to get currency ID for item index %d and cost index %d", item_index, cost_index)
                            end
                        end
                    end

                    for currency_index = 1, #currency_list do
                        price_string = ("%s:%s"):format(price_string, currency_list[currency_index])
                    end
                end
                current_merchant.sells[item_id] = ("%s:%s:[%s]"):format(num_available, stack_size, price_string)
            end
        end

        if _G.CanMerchantRepair() then
            current_merchant.can_repair = true
        end
        _G.SetMerchantFilter(current_filters)
        _G.MerchantFrame_Update()
    end
end -- do-block


function WDP:PET_BAR_UPDATE(event_name)
    if not private.NON_LOOT_SPELL_LABELS[current_action.spell_label] then
        return
    end
    local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("pet"))

    if not unit_idnum or not UnitTypeIsNPC(unit_type) then
        return
    end
    NPCEntry(unit_idnum).mind_control = true
    table.wipe(current_action)
end


-- This function produces data currently unused by wowdb.com, and it causes unneeded bloat in the raw lua DB.
--[[local LPJ = LibStub("LibPetJournal-2.0")
function WDP:PET_JOURNAL_LIST_UPDATE(event_name)
    if DEBUGGING then
        return
    end

    local num_pets = LPJ:NumPets()

    for index, pet_id in LPJ:IteratePetIDs() do
        local _, _, is_owned, _, level, _, _, name, icon, pet_type, npc_id, _, _, is_wild = _G.C_PetJournal.GetPetInfoByIndex(index)

        if is_owned then
            local health, max_health, attack, speed, rarity = _G.C_PetJournal.GetPetStats(pet_id)

            if rarity then
                local rarity_name = _G["BATTLE_PET_BREED_QUALITY" .. rarity]
                local npc = NPCEntry(npc_id)
                npc.wild_pet = is_wild or nil
                npc.battle_pet_data = npc.battle_pet_data or {}
                npc.battle_pet_data[rarity_name] = npc.battle_pet_data[rarity_name] or {}
                npc.battle_pet_data[rarity_name]["level_" .. level] = npc.battle_pet_data[rarity_name]["level_" .. level] or {}

                local data = npc.battle_pet_data[rarity_name]["level_" .. level]
                data.max_health = max_health
                data.attack = attack
                data.speed = speed
            end
        end
    end
end]]--


function WDP:PLAYER_REGEN_DISABLED(event_name)
    private.in_combat = true
end


function WDP:PLAYER_REGEN_ENABLED(event_name)
    private.in_combat = nil
end


function WDP:PLAYER_TARGET_CHANGED(event_name)
    if not TargetedNPC() then
        return
    end
    current_action.target_type = AF.NPC
    self:UpdateTargetLocation()
end


do
    local function UpdateQuestJuncture(point)
        local unit_name = _G.UnitName("questnpc")

        if not unit_name then
            return
        end
        local unit_type, unit_id = ParseGUID(_G.UnitGUID("questnpc"))
        Debug("UpdateQuestJuncture: Updating quest juncture for %s.", ("%s:%d"):format(private.UNIT_TYPE_NAMES[unit_type], unit_id))
        if unit_type == private.UNIT_TYPES.OBJECT then
            UpdateDBEntryLocation("objects", unit_id)
        end
        local quest = DBEntry("quests", _G.GetQuestID())
        quest[point] = quest[point] or {}
        quest[point][("%s:%d"):format(private.UNIT_TYPE_NAMES[unit_type], unit_id)] = true

        return quest
    end


    function WDP:QUEST_COMPLETE(event_name)
        local quest = UpdateQuestJuncture("end")

        if not quest then
            return
        end

        if ALLOWED_LOCALES[CLIENT_LOCALE] then
            quest.reward_text = ReplaceKeywords(_G.GetRewardText())
        end
        -- Make sure the quest NPC isn't erroneously recorded as giving reputation for quests which award it.
        ClearKilledNPC()
    end


    function WDP:QUEST_DETAIL(event_name)
        local quest = UpdateQuestJuncture("begin")

        if not quest then
            return
        end
        quest.classes = quest.classes or {}
        quest.classes[PLAYER_CLASS] = true

        quest.races = quest.races or {}
        quest.races[(PLAYER_RACE == "Pandaren") and ("%s_%s"):format(PLAYER_RACE, PLAYER_FACTION or "Neutral") or PLAYER_RACE] = true
    end
end -- do-block


function WDP:QUEST_LOG_UPDATE(event_name)
    local selected_quest = _G.GetQuestLogSelection() -- Save current selection to be restored when we're done.
    local entry_index, processed_quests = 1, 0
    local _, num_quests = _G.GetNumQuestLogEntries()

    while processed_quests <= num_quests do
        local _, _, _, is_header, _, _, _, quest_id = _G.GetQuestLogTitle(entry_index)

        if quest_id == 0 then
            processed_quests = processed_quests + 1
        elseif not is_header then
            _G.SelectQuestLogEntry(entry_index);

            local quest = DBEntry("quests", quest_id)
            quest.timer = _G.GetQuestLogTimeLeft()
            quest.can_share = _G.GetQuestLogPushable() and true or nil
            processed_quests = processed_quests + 1
        end
        entry_index = entry_index + 1
    end
    _G.SelectQuestLogEntry(selected_quest)
    self:UnregisterEvent("QUEST_LOG_UPDATE")
end


function WDP:QUEST_PROGRESS(event_name)
    if not ALLOWED_LOCALES[CLIENT_LOCALE] then
        return
    end
    DBEntry("quests", _G.GetQuestID()).progress_text = ReplaceKeywords(_G.GetProgressText())
end


function WDP:UNIT_QUEST_LOG_CHANGED(event_name, unit_id)
    if unit_id ~= "player" then
        return
    end
    self:RegisterEvent("QUEST_LOG_UPDATE")
end


do
    local TRADESKILL_TOOLS = {
        Anvil = anvil_spell_ids,
        Forge = forge_spell_ids,
    }


    local function RegisterTools(tradeskill_name, tradeskill_index)
        local link = _G.C_TradeSkillUI.GetRecipeLink(tradeskill_index)

        if link then
            local spell_id = tonumber(link:match("^|c%x%x%x%x%x%x%x%x|H%w+:(%d+)"))
            local required_tool = _G.C_TradeSkillUI.GetRecipeTools(tradeskill_index)

            if required_tool then
                for tool_name, registry in pairs(TRADESKILL_TOOLS) do
                    if required_tool:find(tool_name) then
                        registry[spell_id] = true
                    end
                end
            end
        end
    end


    function WDP:TRADE_SKILL_SHOW(event_name)
        local profession_name, prof_level = _G.C_TradeSkillUI.GetTradeSkillLine()

        if profession_name == _G.UNKNOWN then
            return
        end
        TradeSkillExecutePer(RegisterTools)
    end
end -- do-block


function WDP:TRAINER_CLOSED(event_name)
    private.trainer_shown = nil
end


function WDP:TRAINER_SHOW(event_name)
    local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("npc"))
    local trainer = NPCEntry(unit_idnum)

    if not trainer then
        return
    end
    local _, trainer_standing = UnitFactionStanding("npc")
    trainer.teaches = trainer.teaches or {}

    private.trainer_shown = true

    -- Get the initial trainer filters
    local available = _G.GetTrainerServiceTypeFilter("available") and 1 or 0
    local unavailable = _G.GetTrainerServiceTypeFilter("unavailable") and 1 or 0
    local used = _G.GetTrainerServiceTypeFilter("used") and 1 or 0

    -- Clear the trainer filters
    _G.SetTrainerServiceTypeFilter("available", 1)
    _G.SetTrainerServiceTypeFilter("unavailable", 1)
    _G.SetTrainerServiceTypeFilter("used", 1)

    for index = 1, _G.GetNumTrainerServices(), 1 do
        local spell_name, rank_name, _, _, required_level = _G.GetTrainerServiceInfo(index)

        if spell_name then
            DatamineTT:ClearLines()
            DatamineTT:SetTrainerService(index)

            local _, spell_id = DatamineTT:GetSpell()

            if spell_id then
                local class_professions = trainer.teaches[PLAYER_CLASS]

                if not class_professions then
                    trainer.teaches[PLAYER_CLASS] = {}
                    class_professions = trainer.teaches[PLAYER_CLASS]
                end
                local profession, min_skill = _G.GetTrainerServiceSkillReq(index)
                profession = profession or "General"

                local profession_skills = class_professions[profession]

                if not profession_skills then
                    class_professions[profession] = {}
                    profession_skills = class_professions[profession]
                end
                profession_skills[spell_id] = ("%d:%d:%d"):format(required_level, min_skill, _G.GetTrainerServiceCost(index))
            end
        end
    end
    -- Reset the filters to what they were before
    _G.SetTrainerServiceTypeFilter("available", available or 0)
    _G.SetTrainerServiceTypeFilter("unavailable", unavailable or 0)
    _G.SetTrainerServiceTypeFilter("used", used or 0)
end


function WDP:UNIT_SPELLCAST_SENT(event_name, unit_id, spell_name, spell_rank, target_name, spell_line)
    if private.tracked_line or unit_id ~= "player" then
        return
    end
    local spell_label = private.SPELL_LABELS_BY_NAME[spell_name]

    if not spell_label then
        return
    end

    Debug("UNIT_SPELLCAST_SENT: %s was cast.", spell_name)
    local item_name, item_link = _G.GameTooltip:GetItem()
    local unit_name, unit_id = _G.GameTooltip:GetUnit()

    if not unit_name and _G.UnitName("target") == target_name then
        unit_name = target_name
        unit_id = "target"
    end
    local spell_flags = private.SPELL_FLAGS_BY_LABEL[spell_label]
    local zone_name, area_id, x, y, map_level, instance_token = CurrentLocationData()
    if not (zone_name and area_id and x and y and map_level) then
        if not (_G.IsInInstance()) then
            Debug("%s: Missing current location data - %s, %s, %s, %s, %s.", event_name, tostring(zone_name), tostring(area_id), tostring(x), tostring(y), tostring(map_level))
        end
        return
    end

    table.wipe(current_action)
    current_action.instance_token = instance_token
    current_action.map_level = map_level
    current_action.x = x
    current_action.y = y
    current_action.zone_data = ("%s:%d"):format(zone_name, area_id)
    current_action.spell_label = spell_label

    if not private.NON_LOOT_SPELL_LABELS[spell_label] then
        current_action.loot_label = spell_label:lower()
    end

    if unit_name and unit_name == target_name and not item_name then
        if bit.band(spell_flags, AF.NPC) == AF.NPC then
            if not unit_id or unit_name ~= target_name then
                return
            end
            current_action.target_type = AF.NPC
        end
    elseif bit.band(spell_flags, AF.ITEM) == AF.ITEM then
        current_action.target_type = AF.ITEM

        if item_name and item_name == target_name then
            current_action.identifier = ItemLinkToID(item_link)
        elseif target_name and target_name ~= "" then
            local _, item_link = _G.GetItemInfo(target_name)
            current_action.identifier = ItemLinkToID(item_link)
        end
    elseif not item_name and not unit_name then
        if bit.band(spell_flags, AF.OBJECT) == AF.OBJECT then
            if target_name == "" then
                return
            end
            current_action.object_name = target_name
            current_action.target_type = AF.OBJECT
        elseif bit.band(spell_flags, AF.ZONE) == AF.ZONE then
            current_action.target_type = AF.ZONE
        end
    end
    private.tracked_line = spell_line
end


-- Triggered by bonus roll prompts, disenchant prompts, and in a few other rare circumstances
function WDP:SPELL_CONFIRMATION_PROMPT(event_name, spell_id, confirm_type, text, duration, currency_id_cost)
    if private.RAID_BOSS_BONUS_SPELL_ID_TO_NPC_ID_MAP[spell_id] then
        ClearKilledBossID()
        ClearLootToastContainerID()
        raid_boss_id = private.RAID_BOSS_BONUS_SPELL_ID_TO_NPC_ID_MAP[spell_id]
    else
        Debug("%s: Spell ID %d is not a known raid boss 'Bonus' spell.", event_name, spell_id)
        return
    end

    -- Assign existing loot data to boss if it exists
    if loot_toast_data then
        local npc = NPCEntry(raid_boss_id)
        if npc then
            -- Create needed npc fields if required
            local loot_label = "drops"
            local encounter_data = npc:EncounterData(InstanceDifficultyToken())
            encounter_data[loot_label] = encounter_data[loot_label] or {}
            encounter_data.loot_counts = encounter_data.loot_counts or {}

            for index = 1, #loot_toast_data do
                local data = loot_toast_data[index]
                local loot_type = data[1]
                local hyperlink = data[2]
                local quantity = data[3]

                if loot_type == "item" then
                    local item_id = ItemLinkToID(hyperlink)
                    Debug("%s: Assigned stored item loot data - %s - %d:%d", event_name, hyperlink, item_id, quantity)
                    table.insert(encounter_data[loot_label], ("%d:%d"):format(item_id, quantity))
                elseif loot_type == "money" then
                    Debug("%s: Assigned stored money loot data - money:%d", event_name, quantity)
                    table.insert(encounter_data[loot_label], ("money:%d"):format(quantity))
                elseif loot_type == "currency" then
                    local currency_id = CurrencyLinkToID(hyperlink)
                    Debug("%s: Assigned stored currency loot data - %s - currency:%d (%d)", event_name, hyperlink, currency_id, quantity)
                    table.insert(encounter_data[loot_label], ("currency:%d:%d"):format(quantity, currency_id))
                end
            end

            if not boss_loot_toasting[raid_boss_id] then
                encounter_data.loot_counts[loot_label] = (encounter_data.loot_counts[loot_label] or 0) + 1
                boss_loot_toasting[raid_boss_id] = true -- Do not count further loots until timer expires or another boss is killed
            end
        else
            Debug("%s: NPC is nil, but we have stored loot data...", event_name)
        end
    end

    ClearLootToastData()
    killed_boss_id_timer_handle = C_Timer.NewTimer(5, ClearKilledBossID)
end


function WDP:UNIT_SPELLCAST_SUCCEEDED(event_name, unit_id, spell_name, spell_rank, spell_line, spell_id)
    if unit_id ~= "player" then
        return
    end
    private.tracked_line = nil
    private.previous_spell_id = spell_id

    -- For spells cast when Logging
    if private.LOGGING_SPELL_ID_TO_OBJECT_ID_MAP[spell_id] then
        last_timber_spell_id = spell_id
        UpdateDBEntryLocation("objects", ("OPENING:%s"):format(private.LOGGING_SPELL_ID_TO_OBJECT_ID_MAP[spell_id]))
        return
    end

    -- For spells cast by items that always trigger loot toasts
    if private.LOOT_TOAST_CONTAINER_SPELL_ID_TO_ITEM_ID_MAP[spell_id] then
        ClearKilledBossID()
        ClearLootToastContainerID()
        ClearLootToastData()

        loot_toast_container_id = private.LOOT_TOAST_CONTAINER_SPELL_ID_TO_ITEM_ID_MAP[spell_id]
        loot_toast_container_timer_handle = C_Timer.NewTimer(1, ClearLootToastContainerID) -- we need to assign a handle here to cancel it later
        return
    end

    -- For spells cast by items that don't usually trigger loot toasts
    if not block_chat_loot_data and (private.DELAYED_CONTAINER_SPELL_ID_TO_ITEM_ID_MAP[spell_id] or (private.DELAYED_CONTAINER_SPELL_ID_TO_ITEM_ID_BY_CLASS_ID_MAP[spell_id] and private.DELAYED_CONTAINER_SPELL_ID_TO_ITEM_ID_BY_CLASS_ID_MAP[spell_id][PLAYER_CLASS_ID])) then
        -- Set up timer
        ClearChatLootData()
        Debug("%s: Beginning chat-based loot timer for spellID %d", event_name, spell_id)
        chat_loot_timer_handle = C_Timer.NewTimer(1.5, ClearChatLootData)
        if (private.DELAYED_CONTAINER_SPELL_ID_TO_ITEM_ID_BY_CLASS_ID_MAP[spell_id] and private.DELAYED_CONTAINER_SPELL_ID_TO_ITEM_ID_BY_CLASS_ID_MAP[spell_id][PLAYER_CLASS_ID]) then
            chat_loot_data.identifier = private.DELAYED_CONTAINER_SPELL_ID_TO_ITEM_ID_BY_CLASS_ID_MAP[spell_id][PLAYER_CLASS_ID]
        else
            chat_loot_data.identifier = private.DELAYED_CONTAINER_SPELL_ID_TO_ITEM_ID_MAP[spell_id]
        end
        return
    end

    -- For Ephemeral Crystals (uses a combination of mouseover text and a 'Update Interactions' spell cast to detect the object - this is incredibly hacky but there is no alternative)
    local text = _G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText() or nil
    if spell_id == SPELL_ID_UPDATE_INTERACTIONS and text and text == "Ephemeral Crystal" then
        Debug("%s: Detected location for an Ephemeral Crystal.", event_name)
        for index = 1, #private.EPHEMERAL_CRYSTAL_OBJECT_IDS do
            UpdateDBEntryLocation("objects", private.EPHEMERAL_CRYSTAL_OBJECT_IDS[index])
        end
    end

    if anvil_spell_ids[spell_id] then
        UpdateDBEntryLocation("objects", OBJECT_ID_ANVIL)
    elseif forge_spell_ids[spell_id] then
        UpdateDBEntryLocation("objects", OBJECT_ID_FORGE)
    elseif spell_name:match("^Harvest.+") then
        killed_npc_id = current_target_id
        private.harvesting = true -- Used to track which NPCs can be harvested (can we get this from CreatureCache instead?)
    end
end


function WDP:HandleSpellFailure(event_name, unit_id, spell_name, spell_rank, spell_line, spell_id)
    if unit_id ~= "player" then
        return
    end

    if private.tracked_line == spell_line then
        private.tracked_line = nil
    end
    table.wipe(current_action)
end


do
    local function SetUnitField(field, required_type)
        local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("npc"))

        if not unit_idnum or (required_type and unit_type ~= required_type) then
            return
        end

        if UnitTypeIsNPC(unit_type) then
            NPCEntry(unit_idnum)[field] = true
        elseif unit_type == private.UNIT_TYPES.OBJECT then
            DBEntry("objects", unit_idnum)[field] = true
            UpdateDBEntryLocation("objects", unit_idnum)
        end
    end


    function WDP:AUCTION_HOUSE_SHOW(event_name)
        WDP:StopChatLootRecording(event_name)
        SetUnitField("auctioneer", private.UNIT_TYPES.NPC)
    end


    function WDP:BANKFRAME_OPENED(event_name)
        WDP:StopChatLootRecording(event_name)
        SetUnitField("banker", private.UNIT_TYPES.NPC)
    end


    function WDP:BATTLEFIELDS_SHOW(event_name)
        SetUnitField("battlemaster", private.UNIT_TYPES.NPC)
    end


    local GOSSIP_SHOW_FUNCS = {
        [private.UNIT_TYPES.NPC] = function(unit_idnum)
            local gossip_options = { _G.GetGossipOptions() }

            for index = 2, #gossip_options, 2 do
                if gossip_options[index] == "binder" then
                    SetUnitField("innkeeper", private.UNIT_TYPES.NPC)
                    return
                end
            end
        end,
        [private.UNIT_TYPES.OBJECT] = function(unit_idnum)
            UpdateDBEntryLocation("objects", unit_idnum)
        end,
    }


    function WDP:GOSSIP_SHOW(event_name)
        WDP:StopChatLootRecording(event_name)
        local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("npc"))
        if not unit_idnum then
            return
        end

        if GOSSIP_SHOW_FUNCS[unit_type] then
            GOSSIP_SHOW_FUNCS[unit_type](unit_idnum)
        end
    end


    function WDP:GUILDBANKFRAME_OPENED(event_name)
        WDP:StopChatLootRecording(event_name)
        SetUnitField("guild_bank", private.UNIT_TYPES.OBJECT)
    end


    function WDP:ITEM_UPGRADE_MASTER_OPENED(event_name)
        SetUnitField("item_upgrade_master", private.UNIT_TYPES.NPC)
    end


    function WDP:TAXIMAP_OPENED(event_name)
        SetUnitField("flight_master", private.UNIT_TYPES.NPC)
    end


    function WDP:TRANSMOGRIFY_OPEN(event_name)
        SetUnitField("transmogrifier", private.UNIT_TYPES.NPC)
    end


    function WDP:VOID_STORAGE_OPEN(event_name)
        SetUnitField("void_storage", private.UNIT_TYPES.NPC)
    end
end -- do-block
