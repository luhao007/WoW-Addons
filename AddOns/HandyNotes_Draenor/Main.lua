HandyNotes_Draenor = LibStub("AceAddon-3.0"):GetAddon("HandyNotes_Draenor")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)

local nodes = HandyNotes_Draenor.nodes
local info = {}
local ClickedMapFile = nil
local ClickedCoord = nil


local function GetRewardNameByID(ID)

    if ID == "824" or ID == "823" then

        local Reward = C_CurrencyInfo.GetCurrencyInfo(ID)

        if Reward ~= nil then
            return Reward.name
        end

    else

       local Reward = GetItemInfo(ID)

       if Reward ~= nil then
            return Reward
        end

    end

    return nil

end

local function GetRewardLinkByID(ID)

    if ID == "824" or ID == "823" then

        local Reward = C_CurrencyInfo.GetCurrencyInfo(ID)

        if Reward ~= nil then
            return Reward.name
        end

    else

       local _, Reward = GetItemInfo(ID)

       if Reward ~= nil then
            return Reward
        end
    end

    return nil

end

local function GetRewardIconByID(ID)

    if ID == "824" or ID == "823" then
         local _, _, Icon = C_CurrencyInfo.GetCurrencyInfo(ID)

         if Icon ~= nil then
            return Icon
         end
    else
         local _, _, _, _, Icon = GetItemInfoInstant(ID)

         if Icon ~= nil then
            return Icon
         end
    end

    return "Interface\\Icons\\TRADE_ARCHAEOLOGY_CHESTOFTINYGLASSANIMALS"
end

local function generateMenu(button, level)

    if (level ~= nil) then 

        if (level == 1) then
            info.isTitle = 1
            info.text = "HandyNotes: Draenor"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            
            info.disabled = nil
            info.isTitle = nil
            info.notCheckable = 0
            info.text = "Remove POI from Map"
            info.func = DisablePOI
            info.arg1 = ClickedMapFile
            info.arg2 = ClickedCoord
            UIDropDownMenu_AddButton(info, level)
            
            if HandyNotes_Draenor.db.profile.Integration.TomTom.Loaded == true then
                info.notCheckable = 0
                info.text = "Create TomTom Waypoint"
                info.func = TomTomCreateArrow
                info.arg1 = ClickedMapFile
                info.arg2 = ClickedCoord
                UIDropDownMenu_AddButton(info, level)
            end

            if HandyNotes_Draenor.db.profile.Integration.DBM.Loaded == true then
                if HandyNotes_Draenor.db.profile.Integration.DBM.ArrowCreated == false then
                    info.notCheckable = 0
                    info.text = "Create DBM-Arrow"
                    info.func = DBMCreateArrow
                    info.arg1 = ClickedMapFile
                    info.arg2 = ClickedCoord
                    UIDropDownMenu_AddButton(info, level)
                else
                    info.notCheckable = 0
                    info.text = "Hide DBM-Arrow"
                    info.func = DBMHideArrow
                    UIDropDownMenu_AddButton(info, level)
                end
            end

            info.text = "Restore removed POI's"
            info.func = ResetPOIDatabase
            info.arg1 = nil
            info.arg2 = nil
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)

            info.text = CLOSE
            info.func = function() CloseDropDownMenus() end
            info.arg1 = nil
            info.arg2 = nil
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            
        end
    end
end

function ResetPOIDatabase()
    wipe(HandyNotes_Draenor.db.char)
    HandyNotes_Draenor:Refresh()
end

function DisablePOI(button, mapFile, coord)

    local POI = nodes[mapFile][coord][2]

    if (POI ~= nil) then
        HandyNotes_Draenor.db.char[POI] = true;
    end

    HandyNotes_Draenor:Refresh()
end

function TomTomCreateArrow(button, mapFile, coord)
    if HandyNotes_Draenor.db.profile.Integration.TomTom.Loaded == true then
        local mapId = HandyNotes:GetMapFiletoMapID(mapFile)
        local x, y = HandyNotes:getXY(coord)

        local Zone = nodes[mapFile][coord][1]
        local ID = nodes[mapFile][coord][2]
        local Name = nodes[mapFile][coord][3]
        local Loot = nodes[mapFile][coord][4]
        local Note = nodes[mapFile][coord][5]
        local Icon = nodes[mapFile][coord][6]
        local Tag = nodes[mapFile][coord][7]
        local ItemID = nodes[mapFile][coord][8]
        local AchievementID = nodes[mapFile][coord][10]
        local AchievementCriteriaIndex = nodes[mapFile][coord][9]

        local ArrowDescription = ""

        if Name ~= nil then
            if Zone ~= nil then
                ArrowDescription = ArrowDescription.."\n"..Name;
                ArrowDescription = ArrowDescription.."\n"..Zone;

                if ItemID ~= nil and ItemID ~= "nil" then
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription..GetRewardLinkByID(ItemID)
                else
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription..Loot
                end

                if Note ~= nil and Note ~= "nil" then
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription.."\n"..Note
                end
            end
        end

        TomTom:AddMFWaypoint(mapId, nil, x, y, {
            title = ArrowDescription,
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

function DBMCreateArrow(button, mapFile, coord)
    if HandyNotes_Draenor.db.profile.Integration.DBM.Loaded == true then

        if HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote == nil then
        
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote = DBMArrow:CreateFontString(nil, "OVERLAY", "GameTooltipText")
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote:SetWidth(400)
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote:SetHeight(100)
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote:SetPoint("CENTER", DBMArrow, "CENTER", 0, -70)
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote:SetTextColor(1, 1, 1, 1)
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote:SetJustifyH("CENTER")
            DBMArrow.Desc = HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote

        end

        local x, y = HandyNotes:getXY(coord)

        local Zone = nodes[mapFile][coord][1]
        local ID = nodes[mapFile][coord][2]
        local Name = nodes[mapFile][coord][3]
        local Loot = nodes[mapFile][coord][4]
        local Note = nodes[mapFile][coord][5]
        local Icon = nodes[mapFile][coord][6]
        local Tag = nodes[mapFile][coord][7]
        local ItemID = nodes[mapFile][coord][8]
        local AchievementID = nodes[mapFile][coord][10]
        local AchievementCriteriaIndex = nodes[mapFile][coord][9]

        local ArrowDescription = ""

        if Name ~= nil then
            if Zone ~= nil then
                ArrowDescription = ArrowDescription.."\n"..Name;
                ArrowDescription = ArrowDescription.."\n"..Zone;

                if ItemID ~= nil and ItemID ~= "nil" then
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription..GetRewardLinkByID(ItemID)
                else
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription..Loot
                end

                if Note ~= nil and Note ~= "nil" then
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription.."\n"..Note
                end
            end
        end

		if not DBMArrow.Desc:IsShown() then
			DBMArrow.Desc:Show()
		end

		DBMArrow.Desc:SetText(ArrowDescription)
        DBM.Arrow:ShowRunTo(x * 100, y * 100, nil, nil, true)

        HandyNotes_Draenor.db.profile.Integration.DBM.ArrowCreated = true
    end
end

function DBMHideArrow()
    DBM.Arrow:Hide(true)
    HandyNotes_Draenor.db.profile.Integration.DBM.ArrowCreated = false
end

function HandyNotes_Draenor:OnEnter(mapFile, coord)

    local Zone = nodes[mapFile][coord][1]
    local ItemHeader = nodes[mapFile][coord][3]
    local ItemDescription = nodes[mapFile][coord][4]
    local ItemNote = nodes[mapFile][coord][5]
    local ItemID = nodes[mapFile][coord][8]

    local Reward = GetRewardLinkByID(ItemID)

    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

    if self:GetCenter() > UIParent:GetCenter() then
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end

    if Reward == nil and ItemID ~= "nil" then

        HandyNotes_Draenor:RegisterEvent("GET_ITEM_INFO_RECEIVED", function()

            Reward = GetRewardLinkByID(ItemID)

            tooltip:SetText(ItemHeader) 

            if ItemNote ~= "nil" and HandyNotes_Draenor.db.profile.Settings.General.ShowNotes == true then
                tooltip:AddLine(" ")
                tooltip:AddLine("Note")
                tooltip:AddLine(ItemNote, 1, 1, 1, 1)
            end

            tooltip:AddLine(" ")
            tooltip:AddLine("Reward")

            if Reward ~= nil then
                tooltip:AddLine(Reward, 1, 1, 1, 1)
            else
                tooltip:AddLine(ItemDescription, 1, 1, 1, 1)
            end

            HandyNotes_Draenor:UnregisterEvent("GET_ITEM_INFO_RECEIVED")

            tooltip:Show()

        end)

    else

        tooltip:SetText(ItemHeader)

        if ItemNote ~= "nil" and HandyNotes_Draenor.db.profile.Settings.General.ShowNotes == true then
            tooltip:AddLine(" ")
            tooltip:AddLine("Note")
            tooltip:AddLine(ItemNote, 1, 1, 1, 1)
        end

        tooltip:AddLine(" ")
        tooltip:AddLine("Reward")

        if Reward ~= nil then
            tooltip:AddLine(Reward, 1, 1, 1, 1)
        else
            tooltip:AddLine(ItemDescription, 1, 1, 1, 1)
        end

        tooltip:Show()

    end
end

function HandyNotes_Draenor:OnClick(button, down, mapFile, coord)
    if button == "RightButton" and down then
        ClickedMapFile = mapFile
        ClickedCoord = coord
        ToggleDropDownMenu(1, nil, HandyNotes_DraenorDropdownMenu, self, 0, 0)
    end
end

function HandyNotes_Draenor:OnLeave()
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

function HandyNotes_Draenor:WorldEnter()

    HandyNotes_Draenor.db.profile.Integration.DBM.Loaded = IsAddOnLoaded("DBM-Core")
    HandyNotes_Draenor.db.profile.Integration.TomTom.Loaded = IsAddOnLoaded("TomTom")
    
    local HandyNotes_DraenorDropdownMenu = CreateFrame("Frame", "HandyNotes_DraenorDropdownMenu")
    HandyNotes_DraenorDropdownMenu.displayMode = "MENU"
    HandyNotes_DraenorDropdownMenu.initialize = generateMenu
    
    self:RegisterWithHandyNotes()

    if HandyNotes.plugins["HandyNotes_Draenor"] == nil then
        HandyNotes:RegisterPluginDB("HandyNotes_Draenor", self, HandyNotes_Draenor.options)
    end

end

function HandyNotes_Draenor:RegisterWithHandyNotes()
    local function iter(t, prestate)

        if t ~= nil then

            local state, value = next(t, prestate)

            while state do

                local Zone = value[1]
                local ID = value[2]
                local Name = value[3]
                local Loot = value[4]
                local Note = value[5]
                local Icon = value[6]
                local Tag = value[7]
                local ItemID = value[8]
                local AchievementID = value[10]
                local AchievementCriteriaIndex = value[9]

                if ID then

                    if Tag == "Rare" then

                        if self.db.profile.Zones[Zone]["Rares"] then

                            if self.db.profile.Settings.Rares.ShowAlreadyKilled == true or not self.db.char[ID] then

                                if C_QuestLog.IsQuestFlaggedCompleted(ID) == false then

                                    if AchievementCriteriaIndex ~= nil and AchievementCriteriaIndex ~= "nil" then

                                        local _, _, Completed = GetAchievementCriteriaInfoByID(10070, AchievementCriteriaIndex)

                                        if Completed == false then
                                            return state, nil, self.DefaultIcons[Icon], self.db.profile.Settings.Rares.IconScale, self.db.profile.Settings.Rares.IconAlpha
                                        end

                                    else
                                        return state, nil, self.DefaultIcons[Icon], self.db.profile.Settings.Rares.IconScale, self.db.profile.Settings.Rares.IconAlpha
                                    end

                                end

                            end

                        end

                    elseif Tag == "Treasure" then

                        if self.db.profile.Zones[Zone]["Treasures"] then

                            if self.db.profile.Settings.Treasures.ShowAlreadyCollected == true or not self.db.char[ID] then

                                if C_QuestLog.IsQuestFlaggedCompleted(ID) == false then

                                    if ItemID ~= nil and ItemID ~= "nil" then
                                        return state, nil, GetRewardIconByID(ItemID), self.db.profile.Settings.Treasures.IconScale, self.db.profile.Settings.Treasures.IconAlpha
                                    else
                                        return state, nil, self.DefaultIcons[Icon], self.db.profile.Settings.Treasures.IconScale, self.db.profile.Settings.Treasures.IconAlpha
                                    end

                                end

                            end

                        end

                    elseif Tag == "Treasure-Quest" then

                        if self.db.profile.Zones[Zone]["Treasures"] then

                            if self.db.profile.Settings.Treasures.ShowAlreadyCollected == true or not self.db.char[ID] then

                                if self.db.profile.Settings.Treasures.ShowAlreadyCollected == false then

                                    if C_QuestLog.IsQuestFlaggedCompleted(AchievementCriteriaIndex) then

                                        if ItemID ~= nil and ItemID ~= "nil" then
                                            return state, nil, GetRewardIconByID(ItemID), self.db.profile.Settings.Treasures.IconScale, self.db.profile.Settings.Treasures.IconAlpha
                                        end

                                    end

                                else
                                    if ItemID ~= nil and ItemID ~= "nil" then
                                        return state, nil, GetRewardIconByID(ItemID), self.db.profile.Settings.Treasures.IconScale, self.db.profile.Settings.Treasures.IconAlpha
                                    end
                                end

                            end

                        end

                    elseif string.match(Tag, "Mount_") then

                        if self.db.profile.Mounts[Tag] and not self.db.char[ID] then

                            return state, nil, self.DefaultIcons[Icon], self.db.profile.Settings.Rares.IconScale, self.db.profile.Settings.Rares.IconAlpha

                        end

                    end
                    
                end

                state, value = next(t, state)
            end
        end
    end

    function HandyNotes_Draenor:GetNodes(mapFile, isMinimapUpdate, dungeonLevel)
        return iter, nodes[mapFile], nil
    end

    self:RegisterBucketEvent({ "LOOT_CLOSED" }, 2, function()
        self:Refresh();
    end)

    self:Refresh()
end

function HandyNotes_Draenor:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_Draenor")
end