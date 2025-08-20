local addonName, private = ...
local Details, DetailsFramework = Details, DetailsFramework

---@type detailsmythicplus
local addon = private.addon

local L = DetailsFramework.Language.GetLanguageTable(addonName)
local openRaidLib = LibStub:GetLibrary("LibOpenRaid-1.0")

--player keystone icon, keystone text
local keystoneTextureSize = 45 --the icon is a square
local keystoneDefaultTexture = 4352494 --when no keystone is found, this texture is shown
local noKeystoneAlpha = 0.3 --when no keystone is found, decrease the alpha of the icon and text to this value

---@param self df_blizzbutton
---@param button scoreboard_button
local function OnEnterLineBreakdownButton(self, button)
    local text = button.button.text
    text.originalColor = {text:GetTextColor()}
    DetailsFramework:SetFontSize(text, addon.profile.font.row_size)
    DetailsFramework:SetFontColor(text, addon.profile.font.hover_color)
    DetailsFramework:SetFontOutline(text, addon.profile.font.hover_outline)

    if (button.OnMouseEnter) then
        button.OnMouseEnter(self, button)
    end
end

local function OnLeaveLineBreakdownButton(self)
    local text = self.MyObject.button.text
    DetailsFramework:SetFontSize(text, addon.profile.font.row_size)
    DetailsFramework:SetFontOutline(text, addon.profile.font.regular_outline)
    DetailsFramework:SetFontColor(text, text.originalColor)
    GameCooltip:Hide()
end

local function DoPlayerTooltip(playerData, owner, renderContent, rightHeaderColumn, r, g, b)
    GameCooltip:Preset(2)

    local classColor = RAID_CLASS_COLORS[playerData.class]
    GameCooltip:AddLine(addon.PreparePlayerName(playerData.name), rightHeaderColumn, nil, classColor.r, classColor.g, classColor.b, 1, r, g, b, 1)
    if (playerData.spec) then
        GameCooltip:AddIcon(select(4, GetSpecializationInfoByID(playerData.spec)), 1, 1, 18, 18)
    end
    GameCooltip:AddLine("")
    renderContent()
    GameCooltip:SetOwner(owner)
    GameCooltip:SetOption("LeftPadding", -3)
    GameCooltip:SetOption("RightPadding", 2)
    GameCooltip:SetOption("LinePadding", -2)
    GameCooltip:SetOption("LineYOffset", 0)
    GameCooltip:SetOption("TextSize", Details.tooltip.fontsize)
    GameCooltip:SetOption("TextFont",  Details.tooltip.fontface)
    GameCooltip:SetOption("FixedWidth", false)
    GameCooltip:Show()
end

---@param self scoreboard_button
local showCrowdControlTooltip = function(self, playerData)
    if (playerData.ccCasts == 0) then
        return
    end

    DoPlayerTooltip(playerData, self.widget, function ()
        for spellName, totalUses in pairs(playerData.ccSpellsUsed) do
            local ccText = totalUses
            if (addon.profile.show_cc_cast_tooltip_percentage) then
                ccText =  ccText .. " (" .. math.floor(totalUses / playerData.ccCasts * 100) .. "%)"
            end

            local spellInfo = C_Spell.GetSpellInfo(spellName)
            if (not spellInfo) then
                local spellId = openRaidLib.GetCCSpellIdBySpellName(spellName)
                if (spellId) then
                    spellInfo = C_Spell.GetSpellInfo(spellId)
                end
            end

            GameCooltip:AddLine(spellInfo.name or spellName, ccText)
            Details:AddTooltipBackgroundStatusbar(nil, 100, false, {0.1, 0.1, 0.1, 0.2})

            -- set icon width to 0.00001 as workaround to ensure row height is consistent
            GameCooltip:AddIcon(spellInfo and spellInfo.iconID or 134400, 1, 1, spellInfo and 18 or 0.00001, 18, 0.1, 0.9, 0.1, 0.9)
        end
    end, L["SCOREBOARD_TOOLTIP_CC_CAST_HEADER"])
end

local function OpenLineBreakdown(playerData, mainAttribute, subAttribute)
    if (not playerData or not playerData.name or not playerData.combatUid) then
        return
    end

    local combat = Details:GetCombatByUID(playerData.combatUid)
    if (not combat) then
        return
    end

    Details:OpenSpecificBreakdownWindow(combat, playerData.name, mainAttribute, subAttribute)
end

local function calculateHighest(keyName, ignoreValue)
    return function (allPlayerData)
        local highest = {}
        for _, playerData in pairs(allPlayerData) do
            if (playerData[keyName] ~= ignoreValue) then
                if (highest[1] == nil or math.floor(playerData[keyName]) > math.floor(highest[1][keyName])) then
                    highest = {playerData}
                elseif math.floor(highest[1][keyName]) == math.floor(playerData[keyName]) then
                    table.insert(highest, playerData)
                end
            end
        end

        return highest
    end
end

local function calculateLowest(keyName, ignoreValue)
    return function (allPlayerData)
        local lowest = {}
        for _, playerData in pairs(allPlayerData) do
            if (playerData[keyName] ~= ignoreValue) then
                if (lowest[1] == nil or math.floor(playerData[keyName]) < math.floor(lowest[1][keyName])) then
                    lowest = {playerData}
                elseif math.floor(lowest[1][keyName]) == math.floor(playerData[keyName]) then
                    table.insert(lowest, playerData)
                end
            end
        end

        return lowest
    end
end

---@param line scoreboard_line
local CreateLootSquare = function(line)
    ---@type details_lootsquare
    local lootSquare = CreateFrame("frame", "$parentLootSquare", line)
    lootSquare:SetSize(46, 46)
    lootSquare:SetFrameLevel(line:GetFrameLevel()+10)
    lootSquare:Hide()

    lootSquare:SetScript("OnEnter", function(self)
        if (self.itemLink) then
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
            GameTooltip:SetHyperlink(self.itemLink)
            GameTooltip:Show()

            self:SetScript("OnUpdate", function()
                if (IsShiftKeyDown()) then
                    GameTooltip_ShowCompareItem()
                else
                    GameTooltip_HideShoppingTooltips(GameTooltip)
                end
            end)
        end
    end)

    lootSquare:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        self:SetScript("OnUpdate", nil)
    end)

    local lootIcon = lootSquare:CreateTexture("$parentLootIcon", "artwork")
    lootIcon:SetSize(46, 46)
    lootIcon:SetPoint("center", lootSquare, "center", 0, 0)
    lootIcon:SetTexture([[Interface\ICONS\INV_Misc_QuestionMark]])
    lootSquare.LootIcon = lootIcon

    local lootIconBorder = lootSquare:CreateTexture("$parentLootSquareBorder", "overlay")
    lootIconBorder:SetTexture([[Interface\COMMON\WhiteIconFrame]])
    lootIconBorder:SetTexCoord(0, 1, 0, 1)
    lootIconBorder:SetSize(46, 46)
    lootIconBorder:SetPoint("center", lootIcon, "center", 0, 0)
    lootSquare.LootIconBorder = lootIconBorder

    local lootItemLevel = lootSquare:CreateFontString("$parentLootItemLevel", "overlay", "GameFontNormal")
    lootItemLevel:SetPoint("bottom", lootSquare, "bottom", 0, 0)
    lootItemLevel:SetTextColor(1, 1, 1)
    DetailsFramework:SetFontSize(lootItemLevel, 11)
    lootSquare.LootItemLevel = lootItemLevel

    local lootItemLevelBackgroundTexture = lootSquare:CreateTexture("$parentItemLevelBackgroundTexture", "artwork")
    lootItemLevelBackgroundTexture:SetTexture([[Interface\Cooldown\LoC-ShadowBG]])
    lootItemLevelBackgroundTexture:SetPoint("bottomleft", lootSquare, "bottomleft", -7, 1)
    lootItemLevelBackgroundTexture:SetPoint("bottomright", lootSquare, "bottomright", 7, -11)
    lootItemLevelBackgroundTexture:SetHeight(10)
    lootSquare.LootItemLevelBackgroundTexture = lootItemLevelBackgroundTexture

    return lootSquare
end

do -- player likes
    local column = addon.ScoreboardColumn:Create("player-likes", "", 34, function (line)
        local texture = line:CreateTexture("$parentRankTexture", "ARTWORK")
        texture:SetSize(30, 30)

        local hint = line:CreateTexture("$parentRankTextureHint", "OVERLAY")
        hint:SetAtlas("UI-HUD-Minimap-Arrow-QuestTracking")
        hint:SetPoint("TOPRIGHT", texture, "TOPRIGHT", 5, 5)
        hint:SetSize(16, 16)
        hint:Hide()

        texture.Hint = hint
        texture.Line = line
        line.LikeHint = hint

        return texture
    end)

    column:SetOnRender(function (frame, playerData)
        local likes = 1
        for _, liked in pairs(playerData.likedBy or {}) do
            if (liked) then
                likes = likes + 1
            end
        end

        frame:SetAtlas("Professions-ChatIcon-Quality-Tier" .. likes)
    end)

    addon.RegisterScoreboardColumn(column)
end

do -- player portrait
    local column = addon.ScoreboardColumn:Create("player-portrait", "", 60, function (line)
        local lineHeight = line:GetHeight()
        local playerPortrait = Details:CreatePlayerPortrait(line, "$parentPortrait")
        ---@cast playerPortrait playerportrait
        playerPortrait.Portrait:SetSize(lineHeight-2, lineHeight-2)
        playerPortrait:SetSize(lineHeight-2, lineHeight-2)
        playerPortrait.RoleIcon:SetSize(18, 18)
        playerPortrait.RoleIcon:ClearAllPoints()
        playerPortrait.RoleIcon:SetPoint("bottomleft", playerPortrait.Portrait, "bottomright", -9, -2)

        return playerPortrait
    end)

    column:SetOnRender(function (frame, playerData)
        SetPortraitTexture(frame.Portrait, playerData.unitId)
        local portraitTexture = frame.Portrait:GetTexture()
        frame.Portrait:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
        if (not portraitTexture) then
            local class = playerData.class
            frame.Portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
            frame.Portrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]))
        end

        local role = playerData.role
        if (role == "TANK" or role == "HEALER" or role == "DAMAGER") then
            frame.RoleIcon:SetAtlas(GetMicroIconForRole(role), TextureKitConstants.IgnoreAtlasSize)
            frame.RoleIcon:Show()
        else
            frame.RoleIcon:Hide()
        end
    end)

    addon.RegisterScoreboardColumn(column)
end

do -- spec icon
    local column = addon.ScoreboardColumn:Create("spec-icon", "", 25, function (line)
        --texture to show the specialization of the player
        local specIcon = line:CreateTexture(nil, "overlay")
        specIcon:SetSize(20, 20)
        return specIcon
    end)

    column:SetOnRender(function (frame, playerData)
        if (playerData.spec) then
            frame:SetTexture(select(4, GetSpecializationInfoByID(playerData.spec)))
        end
    end)

    addon.RegisterScoreboardColumn(column)
end

do -- Player name
    local column = addon.ScoreboardColumn:Create("player-name", L["SCOREBOARD_TITLE_PLAYER_NAME"], 110, function (line)
        return line:CreateFontString(nil, "overlay", "GameFontNormal")
    end, false)

    ---@param playerData scoreboard_playerdata
    column:SetOnRender(function (frame, playerData)
        local classColor = RAID_CLASS_COLORS[playerData.class]
        frame:SetTextColor(classColor.r, classColor.g, classColor.b)
        frame:SetText(addon.PreparePlayerName(playerData.name))
    end)

    addon.RegisterScoreboardColumn(column)
end

do -- Like button
    local likeButtonTemplate = "OPTIONS_CIRCLEBUTTON_TEMPLATE"

    local column = addon.ScoreboardColumn:Create("player-like-button", "", 50, function (line)
        local frame = DetailsFramework:CreateButton(line, function (self)
            if (self.MyObject.OnClick) then
                self.MyObject:OnClick()
            end
        end, 35, 22, nil, nil, nil, nil, nil, nil, nil, likeButtonTemplate, {font = "GameFontNormal", size = 12})

        frame:SetScript("OnEnter", function ()
            line.LikeHint:Show()
        end)
        frame:SetScript("OnLeave", function ()
            line.LikeHint:Hide()
        end)
        return frame
    end)

    column:SetOnRender(function (frame, playerData)
        local myName = UnitName("player")
        if (addon.profile.last_run_id ~= playerData.runId or myName == playerData.name or (playerData.likedBy and playerData.likedBy[myName]) or not addon.Compress.HasLastRun()) then
            frame.OnClick = nil
            frame:Hide()

            return
        end

        frame.OnClick = function()
            addon.LikePlayer(playerData.name)
            frame:Hide()
        end
        frame:SetText(L["SCOREBOARD_BUTTON_GG"])
        frame:Show()
    end)

    addon.RegisterScoreboardColumn(column)
end

do -- keystone
    local column = addon.ScoreboardColumn:Create("keystone", L["SCOREBOARD_TITLE_KEYSTONE"], 60, function (line)
        local keystoneDungeonIcon = line:CreateTexture("$parentDungeonIconTexture", "artwork")
        keystoneDungeonIcon:SetTexCoord(36/512, 375/512, 50/512, 290/512)
        keystoneDungeonIcon:SetSize(keystoneTextureSize, keystoneTextureSize)
        keystoneDungeonIcon:SetAlpha(0.932)
        keystoneDungeonIcon.KeystoneMapId = 0
        DetailsFramework:SetMask(keystoneDungeonIcon, [[Interface\FrameGeneral\UIFrameIconMask]])

        keystoneDungeonIcon:SetScript("OnEnter", function(self)
            if (self.KeystoneMapId <= 0) then
                return
            end

            local name, _, timeLimit = C_ChallengeMode.GetMapUIInfo(self.KeystoneMapId)

            GameCooltip:Preset(2)
            GameCooltip:SetOwner(self, "bottom", "top", 0, -4)
            GameCooltip:AddLine(name, DetailsFramework:IntegerToTimer(timeLimit))
            GameCooltip:SetOption("TextSize", Details.tooltip.fontsize)
            GameCooltip:SetOption("TextFont",  Details.tooltip.fontface)
            GameCooltip:SetOption("FixedWidth", false)
            GameCooltip:Show()
        end)
        keystoneDungeonIcon:SetScript("OnLeave", function()
            GameCooltip:Hide()
        end)

        local keystoneDungeonBorderTexture = line:CreateTexture("$parentDungeonIconBorderTexture", "border")
        keystoneDungeonBorderTexture:SetTexture([[Interface\AddOns\Details\images\end_of_mplus.png]], nil, nil, "TRILINEAR")
        keystoneDungeonBorderTexture:SetTexCoord(441/512, 511/512, 81/512, 151/512)
        keystoneDungeonBorderTexture:SetDrawLayer("border", 0)
        keystoneDungeonBorderTexture:SetSize(keystoneTextureSize+2, keystoneTextureSize+2)
        keystoneDungeonBorderTexture:SetPoint("center", keystoneDungeonIcon, "center", 0, 0)
        keystoneDungeonBorderTexture:SetAlpha(1)
        keystoneDungeonBorderTexture:SetVertexColor(0, 0, 0, 0.3)
        keystoneDungeonIcon.DungeonBorderTexture = keystoneDungeonBorderTexture

        local keystoneDungeonLevelFontstring = line:CreateFontString("$parentDungeonLevelFontstring", "overlay", "GameFontNormal")
        keystoneDungeonLevelFontstring:SetPoint("bottom", keystoneDungeonIcon, "bottom", 0, -2)
        DetailsFramework:SetFontSize(keystoneDungeonLevelFontstring, 15)
        keystoneDungeonIcon.KeystoneDungeonLevel = keystoneDungeonLevelFontstring

        local keystoneDungeonLevelBackgroundTexture = line:CreateTexture("$parentDungeonLevelBackgroundTexture", "artwork", nil, 6)
        keystoneDungeonLevelBackgroundTexture:SetTexture([[Interface\Cooldown\LoC-ShadowBG]])
        keystoneDungeonLevelBackgroundTexture:SetPoint("bottomleft", keystoneDungeonIcon, "bottomleft", -10, -2)
        keystoneDungeonLevelBackgroundTexture:SetPoint("bottomright", keystoneDungeonIcon, "bottomright", 10, -15)
        keystoneDungeonLevelBackgroundTexture:SetHeight(12)
        keystoneDungeonIcon.KeystoneDungeonLevelBackground = keystoneDungeonLevelBackgroundTexture

        return keystoneDungeonIcon
    end)

    column:SetOnRender(function (frame, playerData)
        --safe run for feature in test
        local okay, errorText = pcall(function()
            --keystone texture and level
            local keystoneTexture = frame
            local keystoneLevel = frame.KeystoneDungeonLevel
            local keystoneLevelBackground = frame.KeystoneDungeonLevelBackground

            keystoneTexture:SetTexture(playerData.keystoneIcon)
            if (playerData.keystoneIcon ~= keystoneDefaultTexture) then
                keystoneTexture.KeystoneMapId = playerData.keystoneMapId
                keystoneTexture:SetTexCoord(36/512, 375/512, 50/512, 290/512)
                keystoneTexture:SetAlpha(1)
                keystoneTexture:SetDesaturated(false)
                keystoneTexture:SetTexture(playerData.keystoneIcon)
                keystoneLevel:SetAlpha(1)
                keystoneLevelBackground:SetAlpha(1)
            else
                keystoneTexture.KeystoneMapId = 0
                keystoneTexture:SetTexCoord(0, 1, 0, 1)
                keystoneTexture:SetAlpha(noKeystoneAlpha)
                keystoneTexture:SetDesaturated(true)
                keystoneTexture:SetTexture(keystoneDefaultTexture)
                keystoneLevel:SetAlpha(noKeystoneAlpha)
                keystoneLevelBackground:SetAlpha(noKeystoneAlpha)
            end

            if (tonumber(playerData.keystoneLevel) == 0) then
                keystoneLevel:SetText("")
            else
                keystoneLevel:SetText(playerData.keystoneLevel)
            end

            --the scoreboard open after the local player open the loot cache.
            --as consequence, the addon doesn't know if other players has opened as well.
            --if a player loots the first keystone, the scoreboard won't know about it, so schedule updates to verify that.

            local didPrintLog = false
            ---@param thisPlayerData scoreboard_playerdata
            local looperCallback = function(thisPlayerData)
                local playerName = thisPlayerData.name
                if (UnitExists(playerName)) then
                    local unitKeystoneInfo = openRaidLib.GetKeystoneInfo(playerName)
                    if (unitKeystoneInfo) then
                        keystoneTexture:SetTexCoord(36/512, 375/512, 50/512, 290/512)
                        keystoneTexture:SetAlpha(1)
                        keystoneTexture:SetDesaturated(false)
                        keystoneTexture:SetTexture(playerData.keystoneIcon)
                        keystoneLevel:SetAlpha(1)
                        keystoneLevelBackground:SetAlpha(1)
                        keystoneLevel:SetText(playerData.keystoneLevel)

                        --log (debug)
                        if (not didPrintLog) then
                            private.log("Keystone Update Okay, Name:", playerName or "ERROR", "keystoneLevel:", playerData.keystoneLevel or "ERROR", "keystoneIcon:", playerData.keystoneIcon or "ERROR")
                            didPrintLog = true
                        end
                    end
                end
            end

            local loopAmount = 30
            local looperEndCallback = function()end
            local checkPointCallback = function() return addon.IsScoreboardOpen() end --if the scoreboard is hidden, interrupt the loop
            local keystoneUpdateSchedule = DetailsFramework.Schedules.NewLooper(1, looperCallback, loopAmount, looperEndCallback, checkPointCallback, playerData)
            --add to the timer list to be stopped when a scoreboard update is triggered
            addon.temporaryTimers[#addon.temporaryTimers + 1] = keystoneUpdateSchedule
        end)

        if (not okay) then
            print("|cFFFFFF00Details Mythic+ Key Stone Update ERROR:|r ", errorText)
        end
    end)
    addon.RegisterScoreboardColumn(column)
end

do -- M+ score
    local column = addon.ScoreboardColumn:Create("mythic-score", L["SCOREBOARD_TITLE_SCORE"], 90, function (line)
        return line:CreateFontString(nil, "overlay", "GameFontNormal")
    end)

    column:SetOnRender(function (frame, playerData)
        ---@cast playerData scoreboard_playerdata
        frame:SetText(playerData.score)
        local gainedScore = playerData.score - playerData.previousScore
        local text = ""
        if (gainedScore >= 1) then
            local textToFormat = "%d (+%d)"
            text = textToFormat:format(playerData.score, gainedScore)
        else
            local textToFormat = "%d"
            text = textToFormat:format(playerData.score)
        end
        frame:SetText(text)
        frame:SetTextColor(playerData.scoreColor.r, playerData.scoreColor.g, playerData.scoreColor.b)
    end)

    addon.RegisterScoreboardColumn(column)
end

do -- Loot
    local column = addon.ScoreboardColumn:Create("loot", L["SCOREBOARD_TITLE_LOOT"], 80, CreateLootSquare)

    column:SetOnRender(function (frame, playerData)
        frame:Hide()
        if (not playerData.loot or playerData.loot == "") then
            return
        end

        local item = Item:CreateFromItemLink(playerData.loot)
        item:ContinueOnItemLoad(function()
            local r, g, b = C_Item.GetItemQualityColor(item:GetItemQuality())
            frame.itemLink = playerData.loot
            frame.LootIcon:SetTexture(item:GetItemIcon())
            frame.LootIconBorder:SetVertexColor(r, g, b, 1)
            frame.LootItemLevel:SetText(item:GetCurrentItemLevel())

            --update size
            frame.LootIcon:SetSize(32, 32)
            frame.LootIconBorder:SetSize(32, 32)
            frame:Show()
        end)
    end)

    addon.RegisterScoreboardColumn(column)
end

do -- Deaths
    local column = addon.ScoreboardColumn:Create("deaths", L["SCOREBOARD_TITLE_DEATHS"], 80, function (line)
        return line:CreateFontString(nil, "overlay", "GameFontNormal")
    end)

    column:SetOnRender(function (frame, playerData, isBest)
        frame:SetText(math.floor(playerData.deaths))
        DetailsFramework:SetFontSize(frame, addon.profile.font.row_size)
        DetailsFramework:SetFontOutline(frame, addon.profile.font.regular_outline)
        DetailsFramework:SetFontColor(frame, isBest and addon.profile.font.standout_color or addon.profile.font.regular_color)
    end)

    column:SetCalculateBestLine(calculateLowest("deaths"))
    addon.RegisterScoreboardColumn(column)
end

do -- Damage taken
    local column = addon.ScoreboardColumn:Create("damage-taken",  L["SCOREBOARD_TITLE_DAMAGE_TAKEN"], 100, function (line)
        ---@type scoreboard_button
        local frame = DetailsFramework:CreateButton(line, function (self)
            if (self.MyObject.OnClick) then
                self.MyObject:OnClick()
            end
        end, 80, 22, nil, nil, nil, nil, nil, nil, nil, nil, {font = "GameFontNormal", size = 12})

        frame:SetHook("OnEnter", OnEnterLineBreakdownButton)
        frame:SetHook("OnLeave", OnLeaveLineBreakdownButton)
        frame.button.text:ClearAllPoints()
        frame.button.text:SetPoint("left", frame.button, "left")
        frame.button.text.originalColor = {frame.button.text:GetTextColor()}

        return frame
    end)

    column:SetOnRender(function (frame, playerData, isBest)
        frame.OnMouseEnter = function (self)
            if (#playerData.damageTakenFromSpells == 0) then
                return
            end
            DoPlayerTooltip(playerData, self, function ()
                ---@class spell_hit_player : table
                ---@field spellId number
                ---@field amount number
                ---@field damagerName string
                ---
                ---@type spell_hit_player[]
                local spellsThatHitThisPlayer = playerData.damageTakenFromSpells

                for _, spellData in pairs(spellsThatHitThisPlayer) do
                    local spellId = spellData.spellId
                    local amount = spellData.amount
                    local sourceName = spellData.damagerName

                    local spellName, _, spellIcon = Details.GetSpellInfo(spellId)
                    if (spellName and spellIcon) then
                        local spellAmount = Details:Format(amount)
                        GameCooltip:AddLine(spellName .. " (" .. sourceName .. ")", spellAmount)
                        GameCooltip:AddIcon(spellIcon, 1, 1, 18, 18, 0.1, 0.9, 0.1, 0.9)
                        Details:AddTooltipBackgroundStatusbar(nil, 100, false, {0.1, 0.1, 0.1, 0.2})
                    end
                end

                if (Details:GetCombatByUID(playerData.combatUid)) then
                    GameCooltip:AddLine("")
                    GameCooltip:AddLine(L["SCOREBOARD_TOOLTIP_OPEN_BREAKDOWN"], nil, nil, 1, 1, 1, 1, nil, nil, nil, nil)
                end
            end, L["SCOREBOARD_TOOLTIP_DAMAGE_TAKEN_HEADER"])
        end
        frame.OnClick = function () OpenLineBreakdown(playerData, DETAILS_ATTRIBUTE_DAMAGE, DETAILS_SUBATTRIBUTE_DAMAGETAKEN) end
        frame:SetText(Details:Format(math.floor(playerData.damageTaken)))

        DetailsFramework:SetFontSize(frame.button.text, addon.profile.font.row_size)
        DetailsFramework:SetFontOutline(frame.button.text, addon.profile.font.regular_outline)
        DetailsFramework:SetFontColor(frame.button.text, isBest and addon.profile.font.standout_color or addon.profile.font.regular_color)
    end)

    column:SetCalculateBestLine(calculateLowest("damageTaken"))
    addon.RegisterScoreboardColumn(column)
end

do -- DPS
    local column = addon.ScoreboardColumn:Create("dps", L["SCOREBOARD_TITLE_DPS"], 100, function (line)
        ---@type scoreboard_button
        local frame = DetailsFramework:CreateButton(line, function (self)
            if (self.MyObject.OnClick) then
                self.MyObject:OnClick()
            end
        end, 80, 22, nil, nil, nil, nil, nil, nil, nil, nil, {font = "GameFontNormal", size = 12})

        frame:SetHook("OnEnter", OnEnterLineBreakdownButton)
        frame:SetHook("OnLeave", OnLeaveLineBreakdownButton)
        frame.button.text:ClearAllPoints()
        frame.button.text:SetPoint("left", frame.button, "left")
        frame.button.text.originalColor = {frame.button.text:GetTextColor()}

        return frame
    end)

    column:SetOnRender(function (frame, playerData, isBest)
        frame.OnMouseEnter = function (self)
            if (#playerData.damageDoneBySpells == 0) then
                return
            end
            DoPlayerTooltip(playerData, self, function ()
                local i = 0
                for _, spellData in pairs(playerData.damageDoneBySpells) do
                    i = i + 1
                    if (i > 7) then
                        break
                    end
                    local spellId = spellData[1]
                    local amount = spellData[2]

                    local spellName, _, spellIcon = Details.GetSpellInfo(spellId)
                    if (spellName and spellIcon) then
                        local spellAmount = Details:Format(amount)
                        GameCooltip:AddLine(spellName, spellAmount)
                        GameCooltip:AddIcon(spellIcon, 1, 1, 18, 18, 0.1, 0.9, 0.1, 0.9)
                        Details:AddTooltipBackgroundStatusbar(nil, 100, false, {0.1, 0.1, 0.1, 0.2})
                    end
                end

                if (Details:GetCombatByUID(playerData.combatUid)) then
                    GameCooltip:AddLine("")
                    GameCooltip:AddLine(L["SCOREBOARD_TOOLTIP_OPEN_BREAKDOWN"], nil, nil, 1, 1, 1, 1, nil, nil, nil, nil)
                end
            end, L["SCOREBOARD_TOOLTIP_DAMAGE_DONE_HEADER"])
        end
        frame.OnClick = function () OpenLineBreakdown(playerData, DETAILS_ATTRIBUTE_DAMAGE, DETAILS_SUBATTRIBUTE_DPS) end
        frame:SetText(Details:Format(math.floor(playerData.dps)))

        DetailsFramework:SetFontSize(frame.button.text, addon.profile.font.row_size)
        DetailsFramework:SetFontOutline(frame.button.text, addon.profile.font.regular_outline)
        DetailsFramework:SetFontColor(frame.button.text, isBest and addon.profile.font.standout_color or addon.profile.font.regular_color)
    end)

    column:SetCalculateBestLine(calculateHighest("dps", 0))
    addon.RegisterScoreboardColumn(column)
end

do -- HPS
    local column = addon.ScoreboardColumn:Create("hps", L["SCOREBOARD_TITLE_HPS"], 100, function (line)
        ---@type scoreboard_button
        local frame = DetailsFramework:CreateButton(line, function (self)
            if (self.MyObject.OnClick) then
                self.MyObject:OnClick()
            end
        end, 80, 22, nil, nil, nil, nil, nil, nil, nil, nil, {font = "GameFontNormal", size = 12})

        frame:SetHook("OnEnter", OnEnterLineBreakdownButton)
        frame:SetHook("OnLeave", OnLeaveLineBreakdownButton)
        frame.button.text:ClearAllPoints()
        frame.button.text:SetPoint("left", frame.button, "left")
        frame.button.text.originalColor = {frame.button.text:GetTextColor()}

        return frame
    end)

    column:SetOnRender(function (frame, playerData, isBest)
        frame.OnMouseEnter = function (self)
            if (#playerData.healDoneBySpells == 0) then
                return
            end
            DoPlayerTooltip(playerData, self, function ()
                local i = 0
                for _, spellData in pairs(playerData.healDoneBySpells) do
                    i = i + 1
                    if (i > 7) then
                        break
                    end
                    local spellId = spellData[1]
                    local amount = spellData[2]

                    local spellName, _, spellIcon = Details.GetSpellInfo(spellId)
                    if (spellName and spellIcon) then
                        local spellAmount = Details:Format(amount)
                        GameCooltip:AddLine(spellName, spellAmount)
                        GameCooltip:AddIcon(spellIcon, 1, 1, 18, 18, 0.1, 0.9, 0.1, 0.9)
                        Details:AddTooltipBackgroundStatusbar(nil, 100, false, {0.1, 0.1, 0.1, 0.2})
                    end
                end

                if (Details:GetCombatByUID(playerData.combatUid)) then
                    GameCooltip:AddLine("")
                    GameCooltip:AddLine(L["SCOREBOARD_TOOLTIP_OPEN_BREAKDOWN"], nil, nil, 1, 1, 1, 1, nil, nil, nil, nil)
                end
            end, L["SCOREBOARD_TOOLTIP_HEALING_DONE_HEADER"])
        end
        frame.OnClick = function () OpenLineBreakdown(playerData, DETAILS_ATTRIBUTE_HEAL, DETAILS_SUBATTRIBUTE_HPS) end
        frame:SetText(Details:Format(math.floor(playerData.hps)))

        DetailsFramework:SetFontSize(frame.button.text, addon.profile.font.row_size)
        DetailsFramework:SetFontOutline(frame.button.text, addon.profile.font.regular_outline)
        DetailsFramework:SetFontColor(frame.button.text, isBest and addon.profile.font.standout_color or addon.profile.font.regular_color)
    end)

    column:SetCalculateBestLine(calculateHighest("hps", 0))
    addon.RegisterScoreboardColumn(column)
end

do -- Interrupts
    local column = addon.ScoreboardColumn:Create("interrupts", L["SCOREBOARD_TITLE_INTERRUPTS"], 100, function (line)
        ---@type scoreboard_button
        local frame = DetailsFramework:CreateButton(line, function () end, 80, 22, nil, nil, nil, nil, nil, nil, nil, nil, {font = "GameFontNormal", size = 12})

        frame:SetHook("OnEnter", OnEnterLineBreakdownButton)
        frame:SetHook("OnLeave", OnLeaveLineBreakdownButton)
        frame.button.text:ClearAllPoints()
        frame.button.text:SetPoint("left", frame.button, "left")
        frame.button.text.originalColor = {frame.button.text:GetTextColor()}

        return frame
    end)

    column:SetOnRender(function (frame, playerData, isBest)
        frame.OnMouseEnter = function (self)
            local interrupts = math.floor(playerData.interrupts)
            local overlaps = playerData.interruptCastOverlapDone or 0
            local casts = math.floor(playerData.interruptCasts)
            if (casts == 0) then
                return
            end

            local missed = casts - overlaps - interrupts
            local interruptText = interrupts
            local overlapText = overlaps
            local missedText = missed
            if (addon.profile.show_interrupt_tooltip_percentage) then
                if (interrupts > 0) then
                    interruptText = interruptText .. " (" .. (math.floor((interrupts / casts) * 100)) .. "%)"
                end
                if (overlaps > 0) then
                    overlapText = overlapText .. " (" .. (math.floor((overlaps / casts) * 100)) .. "%)"
                end
                if (missed > 0) then
                    missedText = missedText .. " (" .. (math.floor((missed / casts) * 100)) .. "%)"
                end
            end

            local ttLines = {
                {L["SCOREBOARD_TOOLTIP_INTERRUPT_SUCCESS_LABEL"], interruptText},
                {L["SCOREBOARD_TOOLTIP_INTERRUPT_OVERLAP_LABEL"], overlapText},
                {L["SCOREBOARD_TOOLTIP_INTERRUPT_MISSED_LABEL"], missedText},
            }

            DoPlayerTooltip(playerData, self, function ()
                for _, ttLine in pairs(ttLines) do
                    GameCooltip:AddLine(ttLine[1], ttLine[2])
                    -- set icon width to 0.00001 as workaround to ensure row height is consistent
                    GameCooltip:AddIcon(134400, 1, 1, 0.00001, 18, 0.1, 0.9, 0.1, 0.9)
                    Details:AddTooltipBackgroundStatusbar(nil, 100, false, {0.1, 0.1, 0.1, 0.2})
                end
            end, L["SCOREBOARD_TOOLTIP_INTERRUPTS_HEADER"])
        end

        ---@cast playerData scoreboard_playerdata
        frame:SetText(math.floor(playerData.interrupts) .. " / " .. math.floor(playerData.interruptCasts))

        DetailsFramework:SetFontSize(frame.button.text, addon.profile.font.row_size)
        DetailsFramework:SetFontOutline(frame.button.text, addon.profile.font.regular_outline)
        DetailsFramework:SetFontColor(frame.button.text, isBest and addon.profile.font.standout_color or addon.profile.font.regular_color)
    end)

    column:SetCalculateBestLine(calculateHighest("interrupts", 0))
    addon.RegisterScoreboardColumn(column)
end

do -- Dispels
    local column = addon.ScoreboardColumn:Create("dispels", L["SCOREBOARD_TITLE_DISPELS"], 80, function (line)
        return line:CreateFontString(nil, "overlay", "GameFontNormal")
    end)

    column:SetOnRender(function (frame, playerData, isBest)
        frame:SetText(math.floor(playerData.dispels))
        DetailsFramework:SetFontSize(frame, addon.profile.font.row_size)
        DetailsFramework:SetFontOutline(frame, addon.profile.font.regular_outline)
        DetailsFramework:SetFontColor(frame, isBest and addon.profile.font.standout_color or addon.profile.font.regular_color)
    end)

    column:SetCalculateBestLine(calculateHighest("dispels", 0))
    addon.RegisterScoreboardColumn(column)
end

do -- CC casts
    local column = addon.ScoreboardColumn:Create("cc-casts", L["SCOREBOARD_TITLE_CC_CASTS"], 80, function (line)
        ---@type scoreboard_button
        local frame = DetailsFramework:CreateButton(line, function () end, 80, 22, nil, nil, nil, nil, nil, nil, nil, nil, {font = "GameFontNormal", size = 12})

        frame:SetHook("OnEnter", OnEnterLineBreakdownButton)
        frame:SetHook("OnLeave", OnLeaveLineBreakdownButton)
        frame.button.text:ClearAllPoints()
        frame.button.text:SetPoint("left", frame.button, "left")
        frame.button.text.originalColor = {frame.button.text:GetTextColor()}

        return frame
    end)

    column:SetOnRender(function (frame, playerData, isBest)
        frame.OnMouseEnter = function () showCrowdControlTooltip(frame, playerData) end
        frame:SetText(math.floor(playerData.ccCasts))
        DetailsFramework:SetFontSize(frame.button.text, addon.profile.font.row_size)
        DetailsFramework:SetFontOutline(frame.button.text, addon.profile.font.regular_outline)
        DetailsFramework:SetFontColor(frame.button.text, isBest and addon.profile.font.standout_color or addon.profile.font.regular_color)
    end)

    column:SetCalculateBestLine(calculateHighest("ccCasts", 0))
    addon.RegisterScoreboardColumn(column)
end
