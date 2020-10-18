if (TomCats and TomCats.ReconcileVersionInfo) then
	TomCats.ReconcileVersionInfo({
		messageID = 1587481734,
		encoded = "ft8VmWG8m9mIXnArsiOYr9w4Ia8j5LfhAzL089GZL+Zf3+2N2dmIE16fDIYBAQUAAgEEAwMBBAYEAQQIBQEEBgYBBAYHAQQXCAECCAkCBgAKAQADCwEDBAwAAQYNAQASDgEAGg8BAAY="
	})
end
local _, addon = ...
local TCL = addon.TomCatsLibs
TCL.Charms.scope = "account"
local chocolates = 0
local AP
local safeLoot = true
local lootAttempted = false
local primed = false
if (TomCats and TomCats.Register) then
    TomCats:Register(
            {
--                slashCommands = {
--                    {
--                        command = "NOBLEGARDEN TOGGLE",
--                        desc = "Toggle Noblegarden Window",
--                        func = toggleUI
--                    }
--                },
                name = "Noblegarden",
                version = "01.00.06"
            }
    )
end
-- disable until next year
if (true) then return end
local function toggleUI()
end
local function BAG_UPDATE()
    local eggs = GetItemCount(45072, true)
    if (eggs > 0 and (not primed)) then
        primed = true
        C_Timer.After(1,BAG_UPDATE)
        return
    end
    primed = false
    if (safeLoot) then
        local origState = GetCVar("autoLootDefault")
        chocolates = GetItemCount(44791, true)
        for bagId = 0, 4 do
            for slot = 1, GetContainerNumSlots(bagId) do
                local itemLink = GetContainerItemLink(bagId, slot)
                if (itemLink) then
                    local itemId = GetItemInfoInstant(itemLink)
                    if (itemId == 45072) then
                        if (origState == "0") then
                            SetCVar("autoLootDefault","1")
                        end
                        UseContainerItem(bagId, slot)
                        if (not (GetCVar("autoLootDefault") == origState)) then
                            SetCVar("autoLootDefault", origState)
                        end
                        return
                    end
                end
            end
        end
    else
        lootAttempted = true
    end
end
local function UNIT_SPELLCAST_START()
    safeLoot = false
end
local function UNIT_SPELLCAST_STOP()
    safeLoot = true
    if (lootAttempted) then
        lootAttempted = false
        BAG_UPDATE()
    end
end
local function toggleUI()
end
local function ADDON_LOADED(_, _, arg1)
    if (arg1 == addon.name) then
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
        TCL.Events.RegisterEvent("BAG_UPDATE", BAG_UPDATE)
        TCL.Events.RegisterEvent("UNIT_SPELLCAST_START", UNIT_SPELLCAST_START)
        TCL.Events.RegisterEvent("UNIT_SPELLCAST_STOP", UNIT_SPELLCAST_STOP)
        addon.savedVariables.account.preferences = addon.savedVariables.account.preferences or { }
        AP = addon.savedVariables.account.preferences
        addon.charm = TCL.Charms.Create({
            name = "TomCats-NoblegardenMinimapButton",
            iconTexture = "Interface\\AddOns\\TomCats-Noblegarden\\images\\noblegarden-icon",
            backgroundColor = { 0.0,0.0,0.0,1.0 },
            handler_onclick = toggleUI
        })
        addon.charm.tooltip = {
            Show = function(this)
                GameTooltip:ClearLines()
                GameTooltip:SetOwner(this, "ANCHOR_LEFT")
                GameTooltip:SetText("TomCat's Tours:", 1, 1, 1)
                GameTooltip:AddLine("Noblegarden", nil, nil, nil, true)
                GameTooltip:AddLine(" ", nil, nil, nil, true)
                GameTooltip:AddLine("You have:\n".. chocolates .. " Noblegarden Chocolates", nil, nil, nil, true)
                GameTooltip:AddLine(" ", nil, nil, nil, true)
                GameTooltip:AddLine("Egg auto-looting enabled", nil, nil, nil, true)
                GameTooltip:AddLine(" ", nil, nil, nil, true)
                GameTooltip:AddLine("Keep your addons updated for more features as they are added", nil, nil, nil, true)
                GameTooltip:Show()
            end,
            Hide = function()
                GameTooltip:Hide()
            end
        }
        if ("01.00.06" ~= AP["lastVersionSeen"]) then
            --addon.charm.MinimapLoopPulseAnim:Play()
        end
    end
end
TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)
