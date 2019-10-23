local _, addon = ...
local progress = addon.new_module("progress")

-- ---------------------------------------------------------------------------------------------------------------------
local main

-- ---------------------------------------------------------------------------------------------------------------------
local last_kill
local last_quantity

-- ---------------------------------------------------------------------------------------------------------------------
local function resolve_npc_id(guid)
  local target_type, _, _, _, _, npc_id = strsplit("-", guid)
  if target_type == "Vehicle" or target_type == "Creature" and npc_id then
    return tonumber(npc_id)
  end
end

-- ---------------------------------------------------------------------------------------------------------------------
local function update_progress_value(npc_id, value)
  -- resolve npc progress data
  local npc_progress = addon.c("npc_progress")
  if npc_progress == nil then
    npc_progress = {}
  end

  if not npc_progress[npc_id] then
    npc_progress[npc_id] = {}
  end

  -- add 1 to the current value weight
  if npc_progress[npc_id][value] == nil then
    npc_progress[npc_id][value] = 1
  else
    npc_progress[npc_id][value] = npc_progress[npc_id][value] + 1
  end

  -- reduce the weight of all other values so the current one will eventually overtake the most seen one
  for val, occurrences in pairs(npc_progress[npc_id]) do
    if val ~= value then
      npc_progress[npc_id][val] = occurrences * 0.80
    end
  end

  addon.set_config_value("npc_progress", npc_progress)
end

-- ---------------------------------------------------------------------------------------------------------------------
local function get_progress_value(npc_id)
  -- resolve npc progress data
  local npc_progress = addon.c("npc_progress")
  if not npc_progress then
    return
  end

  if not npc_progress[npc_id] then
    return
  end

  -- get progress value
  local value, occurrences = nil, -1
  for val, val_occurrences in pairs(npc_progress[npc_id]) do
    if val_occurrences > occurrences then
      value, occurrences = val, val_occurrences
    end
  end

  return value
end

-- ---------------------------------------------------------------------------------------------------------------------
local function on_combat_log_event_unfiltered()
  local _, sub_event, _, _, _, _, _, dest_guid = CombatLogGetCurrentEventInfo()
  -- skip if not a party kill event
  if sub_event ~= "PARTY_KILL" then
    return
  end

  -- skip if not in cm
  if not main.is_in_cm() then
    return
  end

  -- setup
  if not last_kill then
    last_kill = {}
  end

  local kill_time = GetTime() * 1000

  if not last_kill[1] or last_kill[1] == nil then
    last_kill[1] = kill_time
  end

  -- resolve last_kill data
  local npc_id = resolve_npc_id(dest_guid)
  if npc_id then
    local valid = ((kill_time) - last_kill[1]) > 100
    last_kill = {kill_time, npc_id, valid}
  end
end

-- ---------------------------------------------------------------------------------------------------------------------
local function on_scenario_criteria_update()
  -- check if we have an run
  local current_run = main.get_current_run()
  if not current_run then
    return
  end

  -- resolve enemy forces quantity
  local _, _, steps = C_Scenario.GetStepInfo()
  if not steps or steps <= 0 then
    return
  end

  local _, _, _, _, final_value, _, _, quantity = C_Scenario.GetCriteriaInfo(steps)
  local quantity_number = string.sub(quantity, 1, string.len(quantity) - 1)
  quantity_number = tonumber(quantity_number)

  -- set last_quantity if not set (first kill after start / restart will not be calculated)
  if last_quantity == nil then
    last_quantity = quantity_number
    return
  end

  if last_quantity >= final_value or quantity_number >= final_value then
    return
  end

  -- resolve progress
  local delta = quantity_number - last_quantity
  if delta > 0 and last_kill then
    local timestamp, npc_id, valid = unpack(last_kill)

    if timestamp and npc_id and delta and valid then
      if (GetTime() * 1000) - timestamp <= 600 then
        update_progress_value(npc_id, delta)
      end
    end
  end

  last_quantity = quantity_number
end

-- ---------------------------------------------------------------------------------------------------------------------
local function on_tooltip_set_unit(tooltip)
  -- check if tooltip must be updated
  if not addon.c("progress_tooltip") then
    return
  end

  local unit = select(2, tooltip:GetUnit())
  if not unit then
    return
  end

  if not main.is_in_cm() then
    return
  end

  if not UnitCanAttack("player", unit) or UnitIsDead(unit) then
    return
  end

  -- resolve value
  local guid = UnitGUID(unit)
  local npc_id = resolve_npc_id(guid)
  if not npc_id then
    return
  end

  local value = get_progress_value(npc_id)
  if not value then
    return
  end

  -- calculate percent
  local _, _, steps = C_Scenario.GetStepInfo()
  if not steps or steps <= 0 then
    return
  end

  local _, _, _, _, final_value = C_Scenario.GetCriteriaInfo(steps)
  local quantity_percent = (value / final_value) * 100
  local mult = 10 ^ 2
  quantity_percent = math.floor(quantity_percent * mult + 0.5) / mult
  if (quantity_percent > 100) then
    quantity_percent = 100
  end

  -- create tooltip info
  local name = C_Scenario.GetCriteriaInfo(steps)

  local absolute_number = ""
  if addon.c("show_absolute_numbers") then
    absolute_number = " (+" .. value .. ")"
  end

  GameTooltip:AddDoubleLine(name .. ": +" .. quantity_percent .. "%" .. absolute_number)
  GameTooltip:Show()
end

-- ---------------------------------------------------------------------------------------------------------------------
function progress.on_challenge_mode_start()
  last_kill = nil
  last_quantity = nil
end

-- ---------------------------------------------------------------------------------------------------------------------
function progress.on_player_entering_world()
  last_kill = nil
  last_quantity = nil
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Init
function progress:init()
  main = addon.get_module("main")
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Enable
function progress:enable()
  -- register events
  addon.register_event("COMBAT_LOG_EVENT_UNFILTERED", on_combat_log_event_unfiltered)
  addon.register_event("SCENARIO_CRITERIA_UPDATE", on_scenario_criteria_update)

  -- hook into tooltip
  GameTooltip:HookScript("OnTooltipSetUnit", on_tooltip_set_unit)
end
