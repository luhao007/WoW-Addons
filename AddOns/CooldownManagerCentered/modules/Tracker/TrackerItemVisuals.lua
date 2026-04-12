local _, ns = ...

local DB = ns.TrackerDB
local ItemsData = ns.TrackerItemsData

local ItemVisuals = ns.TrackerItemVisuals or {}
ns.TrackerItemVisuals = ItemVisuals

local FALLBACK_ICON = 134400
local ITEM_COOLDOWN_TRIGGER_THRESHOLD = 0.1
local WILDCARD_SLOT_TRINKET1 = ItemsData.WILDCARD_SLOT_TRINKET1 or "trinket1"
local WILDCARD_SLOT_TRINKET2 = ItemsData.WILDCARD_SLOT_TRINKET2 or "trinket2"

local activeStartByEntry = {}
local activeUntilByEntry = {}
local lastItemCooldownRemainingByEntry = {}

local desaturationCurve = C_CurveUtil.CreateCurve()
desaturationCurve:AddPoint(0, 0)
desaturationCurve:AddPoint(0.001, 1)

local function BuildEntryKey(kind, id)
    if not kind or id == nil then
        return nil
    end
    return kind .. ":" .. tostring(id)
end

local function NormalizeSpellID(spellID)
    if not spellID then
        return nil
    end
    return C_Spell.GetBaseSpell(spellID) or spellID
end

local function SpellIDsMatch(a, b)
    if not a or not b then
        return false
    end
    if a == b then
        return true
    end
    local baseA = NormalizeSpellID(a)
    local baseB = NormalizeSpellID(b)
    return baseA ~= nil and baseB ~= nil and baseA == baseB
end

local function CollectTrackedItemCandidates()
    local tracked = {}
    local db = DB.GetDB and DB.GetDB() or nil

    if db and db.itemSettings then
        for itemID, settings in pairs(db.itemSettings) do
            if settings and settings.state then
                tracked[itemID] = true
            end
        end
    end

    if ItemsData and ItemsData.GetWildcardSlotItemID and DB.GetWildcardSlotState then
        local slotIDs = { WILDCARD_SLOT_TRINKET1, WILDCARD_SLOT_TRINKET2 }
        for _, slotID in ipairs(slotIDs) do
            if DB.GetWildcardSlotState(slotID) ~= nil then
                local itemID = ItemsData:GetWildcardSlotItemID(slotID)
                if itemID then
                    tracked[itemID] = true
                end
            end
        end
    end

    return tracked
end

local function GetCustomActiveSwipeColor()
    return {
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customActiveColor_r)
            or DB.DEFAULT_AURA_SWIPE_COLOR[1],
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customActiveColor_g)
            or DB.DEFAULT_AURA_SWIPE_COLOR[2],
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customActiveColor_b)
            or DB.DEFAULT_AURA_SWIPE_COLOR[3],
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customActiveColor_a)
            or DB.DEFAULT_AURA_SWIPE_COLOR[4],
    }
end

local function GetCooldownSwipeColor()
    return {
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customCDSwipeColor_r)
            or DB.DEFAULT_COOLDOWN_SWIPE_COLOR[1],
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customCDSwipeColor_g)
            or DB.DEFAULT_COOLDOWN_SWIPE_COLOR[2],
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customCDSwipeColor_b)
            or DB.DEFAULT_COOLDOWN_SWIPE_COLOR[3],
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customCDSwipeColor_a)
            or DB.DEFAULT_COOLDOWN_SWIPE_COLOR[4],
    }
end

local function ApplyCustomActiveOverlay(frame, startTime, duration)
    if not frame or not frame.Cooldown or duration <= 0 or not startTime then
        return
    end

    local now = GetTime()
    if startTime < (now - duration) then
        return
    end

    frame.Cooldown:SetSwipeColor(unpack(GetCustomActiveSwipeColor()))
    frame.Cooldown:SetCooldown(startTime, duration)
    frame.Cooldown:SetDrawSwipe(true)
end

function ItemVisuals:GetEntryIcon(kind, id)
    if kind == "wildcardSlots" and ItemsData and ItemsData.GetWildcardSlotItemID then
        local itemID = ItemsData:GetWildcardSlotItemID(id)
        if itemID then
            return C_Item.GetItemIconByID(itemID) or FALLBACK_ICON
        end
        return FALLBACK_ICON
    end
    if kind == "spell" then
        return C_Spell.GetSpellTexture(id) or FALLBACK_ICON
    end

    return C_Item.GetItemIconByID(id) or FALLBACK_ICON
end

function ItemVisuals:ApplyItemIcon(frame, itemID)
    if not frame or not frame.Icon then
        return
    end
    frame.Icon:SetTexture(C_Item.GetItemIconByID(itemID) or FALLBACK_ICON)
end

function ItemVisuals:ApplyEntryIcon(frame, kind, id)
    if not frame or not frame.Icon then
        return
    end
    frame.Icon:SetTexture(self:GetEntryIcon(kind, id))
end

function ItemVisuals:SetEmptySlot(frame)
    if not frame then
        return
    end
    if frame.Icon then
        frame.Icon:SetTexture(nil)
        frame.Icon:SetAtlas("cdm-empty", true)
        frame.Icon:SetDesaturated(false)
    end
    if frame.Cooldown then
        CooldownFrame_Clear(frame.Cooldown)
    end
end

function ItemVisuals:ClearCooldown(frame, desaturation)
    if not frame then
        return
    end
    if frame.Cooldown then
        CooldownFrame_Clear(frame.Cooldown)
        frame.Cooldown:SetDrawSwipe(false)
    end
    if desaturation ~= nil and frame.Icon then
        frame.Icon:SetDesaturation(desaturation)
    end
end

function ItemVisuals:GetCustomActiveDuration(kind, id)
    return DB.GetCustomActiveDuration(kind, id) or 0
end

function ItemVisuals:IsEntryActive(kind, id)
    local key = BuildEntryKey(kind, id)
    if not key then
        return false
    end

    local activeUntil = activeUntilByEntry[key] or 0
    if activeUntil <= GetTime() then
        activeUntilByEntry[key] = nil
        activeStartByEntry[key] = nil
        return false
    end

    return true
end

function ItemVisuals:SetEntryActiveNow(kind, id)
    local duration = self:GetCustomActiveDuration(kind, id)
    if duration <= 0 then
        return false
    end

    local key = BuildEntryKey(kind, id)
    if not key then
        return false
    end

    local now = GetTime()
    activeStartByEntry[key] = now
    activeUntilByEntry[key] = now + duration
    C_Timer.After(duration + 0.05, function()
        if ns.TrackerItemViewer and ns.TrackerItemViewer.RefreshItemViewerFrames then
            ns.TrackerItemViewer:RefreshItemViewerFrames()
        end
    end)

    return true
end

function ItemVisuals:MarkSpellCastActive(spellID)
    local matched = false
    if self:SetEntryActiveNow("spell", spellID) then
        matched = true
    end

    local baseSpellID = C_Spell.GetBaseSpell(spellID) or spellID
    if baseSpellID ~= spellID and self:SetEntryActiveNow("spell", baseSpellID) then
        matched = true
    end

    return matched
end

function ItemVisuals:MarkItemCastActive(spellID)
    if not spellID then
        return false
    end

    local matched = false
    local itemCandidates = CollectTrackedItemCandidates()
    for itemID in pairs(itemCandidates) do
        if self:GetCustomActiveDuration("item", itemID) > 0 then
            local _, itemSpellID = C_Item.GetItemSpell(itemID)
            if itemSpellID and SpellIDsMatch(itemSpellID, spellID) then
                if self:SetEntryActiveNow("item", itemID) then
                    matched = true
                end
            end
        end
    end

    return matched
end

function ItemVisuals:UpdateSpellCooldown(frame, spellID)
    if not frame or not frame.Cooldown then
        return false
    end

    local overrideSpellID = C_Spell.GetOverrideSpell(spellID) or spellID

    if self:IsEntryActive("spell", spellID) then
        local entryKey = BuildEntryKey("spell", spellID)
        local duration = self:GetCustomActiveDuration("spell", spellID)
        local startTime = entryKey and activeStartByEntry[entryKey] or nil
        frame.count:SetText("")
        frame.Icon:SetDesaturation(0)
        ApplyCustomActiveOverlay(frame, startTime, duration)
        return true
    end

    frame.Cooldown:SetSwipeColor(unpack(GetCooldownSwipeColor()))

    local spellCharges = C_Spell.GetSpellCharges(overrideSpellID)
    local hasCharges = spellCharges and spellCharges.maxCharges > 1
    if hasCharges then
        frame.count:SetText(spellCharges.currentCharges)
    else
        frame.count:SetText("")
    end

    local desaturation = 0
    local spellCooldownInfo = C_Spell.GetSpellCooldown(overrideSpellID)
    local isOnGCD = spellCooldownInfo and spellCooldownInfo.isOnGCD

    local cooldownDuration = C_Spell.GetSpellCooldownDuration(overrideSpellID)
    if hasCharges then
        local chargeDuration = C_Spell.GetSpellChargeDuration(overrideSpellID)
        frame.Cooldown:SetCooldownFromDurationObject(chargeDuration)
    else
        if frame.showGCD or not isOnGCD then
            frame.Cooldown:SetCooldownFromDurationObject(cooldownDuration)
            frame.Cooldown:SetDrawSwipe(true)
        end
    end
    if not isOnGCD then
        desaturation = cooldownDuration:EvaluateRemainingDuration(desaturationCurve)
    end

    frame.Icon:SetDesaturation(desaturation)

    return true
end

function ItemVisuals:UpdateItemCooldown(frame, itemID)
    if not frame or not frame.Cooldown then
        return false
    end
    local count = 0
    local classID = select(6, GetItemInfoInstant(itemID))
    if classID == Enum.ItemClass.Consumable then
        count = C_Item.GetItemCount(itemID, false, true)
    end

    if count > 1 then
        frame.count:SetText(count)
    else
        frame.count:SetText("")
    end

    local startTime, duration = C_Item.GetItemCooldown(itemID)

    local _, spellID = C_Item.GetItemSpell(itemID)
    local customDuration = self:GetCustomActiveDuration("item", itemID)
    local hasCustomActive = customDuration > 0

    local cooldownRemaining = startTime + duration - GetTime()

    local entryKey = BuildEntryKey("item", itemID)
    local previousRemaining = entryKey and lastItemCooldownRemainingByEntry[entryKey] or nil
    if entryKey then
        lastItemCooldownRemainingByEntry[entryKey] = cooldownRemaining
    end

    if
        hasCustomActive
        and not spellID
        and previousRemaining ~= nil
        and cooldownRemaining > ITEM_COOLDOWN_TRIGGER_THRESHOLD
        and previousRemaining <= ITEM_COOLDOWN_TRIGGER_THRESHOLD
    then
        self:SetEntryActiveNow("item", itemID)
    end

    if hasCustomActive and self:IsEntryActive("item", itemID) then
        local entryKey = BuildEntryKey("item", itemID)
        local startTime = entryKey and activeStartByEntry[entryKey] or nil
        frame.Icon:SetDesaturation(0)
        ApplyCustomActiveOverlay(frame, startTime, customDuration)
        return true
    end

    frame.Cooldown:SetSwipeColor(unpack(GetCooldownSwipeColor()))

    local isOnGCD = spellID and C_Spell.GetSpellCooldown(spellID).isOnGCD
    if not isOnGCD or frame.showGCD and cooldownRemaining > 0.03 and duration > 0 then
        frame.Cooldown:SetCooldown(startTime, duration)
        frame.Cooldown:SetDrawSwipe(true)
        if cooldownRemaining > 2 then
            frame.Icon:SetDesaturation(1)
        end
    end
    if duration == 0 then
        frame.Icon:SetDesaturation(0)
    end

    return true
end

function ItemVisuals:UpdateEntryCooldown(frame, kind, id)
    if kind == "wildcardSlots" and ItemsData and ItemsData.GetWildcardSlotItemID then
        local itemID = ItemsData:GetWildcardSlotItemID(id)
        if not itemID then
            if frame.count then
                frame.count:SetText("")
            end
            if frame.Cooldown then
                CooldownFrame_Clear(frame.Cooldown)
                frame.Cooldown:SetDrawSwipe(false)
            end
            if frame.Icon then
                frame.Icon:SetDesaturation(0)
            end
            return true
        end
        return self:UpdateItemCooldown(frame, itemID)
    end
    if kind == "spell" then
        return self:UpdateSpellCooldown(frame, id)
    end

    local entryKey = BuildEntryKey(kind, id)
    if entryKey and kind ~= "item" then
        lastItemCooldownRemainingByEntry[entryKey] = nil
    end

    return self:UpdateItemCooldown(frame, id)
end
