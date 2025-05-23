local addon_name, addon_env = ...
if not addon_env.load_this then return end

-- [AUTOLOCAL START]
local C_Garrison = C_Garrison
local CreateFrame = CreateFrame
local Enum_GarrisonFollowerType_FollowerType_6_0_GarrisonFollower = Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower
local GARRISON_CURRENCY = GARRISON_CURRENCY
local GetFollowerAbilities = C_Garrison.GetFollowerAbilities
local GetFollowerInfoForBuilding = C_Garrison.GetFollowerInfoForBuilding
local GetItemInfo = GetItemInfo
local GetLandingPageShipmentInfo = C_Garrison.GetLandingPageShipmentInfo
local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS
local RED_FONT_COLOR_CODE = RED_FONT_COLOR_CODE
local pairs = pairs
local print = print
local tinsert = table.insert
local type = type
local wipe = wipe
-- [AUTOLOCAL END]

local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
local MissionPageFollowers = MissionPage.Followers
local FollowerTab = GarrisonMissionFrame.FollowerTab

local c_garrison_cache = addon_env.c_garrison_cache
local Widget = addon_env.Widget
local event_frame = addon_env.event_frame
local event_handlers = addon_env.event_handlers

local tts = LibStub:GetLibrary("LibTTScan-1.0", true)

hooksecurefunc("GarrisonMissionButton_SetRewards", function(self, rewards, numRewards)
   local index = 1
   local Rewards = self.Rewards
   for id, reward in pairs(rewards) do
      local button = Rewards[index]
      local item_id = reward.itemID
      if item_id and reward.quantity == 1 then
         local _, link, itemRarity, itemLevel = GetItemInfo(item_id)
         local text
         if itemRarity and itemLevel and itemLevel >= 500 then
            text = ITEM_QUALITY_COLORS[itemRarity].hex .. itemLevel
         end
         if not text and tts then
            text = tts.GetItemArtifactPower(item_id)
         end
         if text then
            local Quantity = button.Quantity
            Quantity:SetText(text)
            Quantity:Show()
         end
      end
      index = index + 1
   end
end)

local upgrade_buttons_parent = CreateFrame("Frame", nil, FollowerTab.ItemWeapon)

tinsert(addon_env.upgrade_items, { parent = upgrade_buttons_parent, anchor = FollowerTab.ItemWeapon, 114128, 114129, 114131, 114616, 114081, 114622, 120302 })
tinsert(addon_env.upgrade_items, { parent = upgrade_buttons_parent, anchor = FollowerTab.ItemArmor,  114745, 114808, 114822, 114807, 114806, 114746, 120301 })

local upgrade_item_strength = addon_env.upgrade_item_strength
upgrade_item_strength[114128] = 3
upgrade_item_strength[114129] = 6
upgrade_item_strength[114131] = 9
upgrade_item_strength[114616] = 615
upgrade_item_strength[114081] = 630
upgrade_item_strength[114622] = 645
upgrade_item_strength[114745] = 3
upgrade_item_strength[114808] = 6
upgrade_item_strength[114822] = 9
upgrade_item_strength[114807] = 615
upgrade_item_strength[114806] = 630
upgrade_item_strength[114746] = 645

addon_env.UpgradeItems_InitButtons()
addon_env.UpgradeItems_InitEvents(GarrisonMissionFrame, upgrade_buttons_parent)

local mechanic_id = {}
for idx, data in pairs (C_Garrison.GetAllEncounterThreats(Enum_GarrisonFollowerType_FollowerType_6_0_GarrisonFollower)) do
   tinsert(mechanic_id, data.id)
end

local function DrawAbilityCounters(frame, followerID, followerInfo)
   local self = FollowerTab
   local abilities = followerInfo.abilities or GetFollowerAbilities(followerID)

   for i=1, #abilities do
      local ability = abilities[i]

      local abilityFrame = self.AbilitiesFrame.Abilities[i]

      abilityFrame.Name:SetText(ability.name .. '!')
   end
end

-- Mission party's 3 followers: warning text frame
addon_env.child_frame_cache.MissionPageFollowerWarning = addon_env.BuildChildFrameCache(function(mission_page_follower_frame)
   local warning = mission_page_follower_frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
   warning:SetWidth(185)
   warning:SetHeight(1)
   warning:SetPoint("BOTTOM", mission_page_follower_frame, "TOP", 0, -68)
   return warning
end)

-- Mission party's 3 followers: follower's current XP
addon_env.child_frame_cache.MissionPageFollowerXP = addon_env.BuildChildFrameCache(function(mission_page_follower_frame)
   return Widget{type = "Texture", parent = mission_page_follower_frame, SubLayer = 3, Width = 104, Height = 200, BOTTOMLEFT = {55, 2}, Color = { 0.212, 0, 0.337, 1 }, Hide = true }
end)

-- Mission party's 3 followers: follower's XP gain base
addon_env.child_frame_cache.MissionPageFollowerXPGainBase = addon_env.BuildChildFrameCache(function(mission_page_follower_frame)
   return Widget{type = "Texture", parent = mission_page_follower_frame, SubLayer = 2, Width = 104, Height = 4, BOTTOMLEFT = {55, 2}, Color = { 0.6, 1, 0, 1 }, Hide = true }
end)

-- Mission party's 3 followers: follower's XP gain bonus
addon_env.child_frame_cache.MissionPageFollowerXPGainBonus = addon_env.BuildChildFrameCache(function(mission_page_follower_frame)
   return Widget{type = "Texture", parent = mission_page_follower_frame, SubLayer = 1, Width = 104, Height = 4, BOTTOMLEFT = {55, 2}, Color = { 0, 0.75, 1, 1 }, Hide = true }
end)

local shipment_followers = {}
local function CheckPartyForProfessionFollowers(self) -- self == MissionFrame
   if not self:IsVisible() then return end

   local MissionPage = self.MissionTab.MissionPage
   local MissionPageFollowers = MissionPage.Followers

   local party_followers_count = #MissionPageFollowers
   local present
   for idx = 1, party_followers_count do
      local mission_page_follower_frame = MissionPageFollowers[idx]
      local follower = mission_page_follower_frame.info
      if follower then present = true end
      addon_env.child_frame_cache.MissionPageFollowerWarning[mission_page_follower_frame]:Hide()
      local xp_bar = addon_env.child_frame_cache.MissionPageFollowerXP[mission_page_follower_frame]
      if (not follower or follower.xp == 0 or follower.levelXP == 0) then
         xp_bar:Hide()
         addon_env.child_frame_cache.MissionPageFollowerXPGainBase[mission_page_follower_frame]:Hide()
         addon_env.child_frame_cache.MissionPageFollowerXPGainBonus[mission_page_follower_frame]:Hide()
      else
         xp_bar:SetWidth((follower.xp/follower.levelXP) * 104)
         xp_bar:Show()
      end
   end
   if not present then return end

   local requested = addon_env.ThrottleRequestLandingPageShipmentInfo()
   if requested then return end

   wipe(shipment_followers)
   local buildings = c_garrison_cache.GetBuildings
   for idx = 1, #buildings do
      local building = buildings[idx]
      local buildingID = building.buildingID;
      if buildingID then
         local nameLanding, texture, shipmentCapacity, shipmentsReady, shipmentsTotal, creationTime, duration, timeleftString, itemName, itemIcon, itemQuality, itemID = GetLandingPageShipmentInfo(buildingID)
         -- Level 2
         -- No follower
         -- Have follower in possible list
         -- GMM_dumpl("name, texture, shipmentCapacity, shipmentsReady, shipmentsTotal, creationTime, duration, timeleftString, itemName, itemIcon, itemQuality, itemID", C_Garrison.GetLandingPageShipmentInfo(buildingID))
         -- GMM_dumpl("id, name, texPrefix, icon, description, rank, currencyID, currencyQty, goldQty, buildTime, needsPlan, isPrebuilt, possSpecs, upgrades, canUpgrade, isMaxLevel, hasFollowerSlot, knownSpecs, currSpec, specCooldown, isBuilding, startTime, buildDuration, timeLeftStr, canActivate", C_Garrison.GetOwnedBuildingInfo(buildingID))
         if shipmentCapacity and shipmentCapacity > 0 then
            local plotID = building.plotID
            local id, name, texPrefix, icon, description, rank, currencyID, currencyQty, goldQty, buildTime, needsPlan, isPrebuilt, possSpecs, upgrades, canUpgrade, isMaxLevel, hasFollowerSlot, knownSpecs, currSpec, specCooldown, isBuilding, startTime, buildDuration, timeLeftStr, canActivate = C_Garrison.GetOwnedBuildingInfo(plotID)
            -- print(nameLanding, hasFollowerSlot, rank, shipmentsReady)
            if hasFollowerSlot and rank and rank > 1 then -- TODO: check if just hasFollowerSlot is enough
               local followerName, level, quality, displayID, followerID, garrFollowerID, status, portraitIconID = GetFollowerInfoForBuilding(plotID)
               if not followerName then
                  local possible_followers = c_garrison_cache.GetPossibleFollowersForBuilding[plotID]
                  if #possible_followers > 0 then
                     for idx = 1, #possible_followers do
                        local possible_follower = possible_followers[idx]
                        for party_idx = 1, party_followers_count do
                           local party_follower = MissionPageFollowers[party_idx].info
                           if party_follower and possible_follower.followerID == party_follower.followerID then
                              shipment_followers[party_idx .. 'b'] = name
                              shipment_followers[party_idx .. 'r'] = shipmentsTotal and (shipmentsTotal - shipmentsReady)
                              shipment_followers[party_idx .. 't'] = timeleftString
                           end
                        end
                     end
                  end
               end
            end
         end
      end
   end

   for idx = 1, party_followers_count do
      local mission_page_follower_frame = MissionPageFollowers[idx]
      local warning = addon_env.child_frame_cache.MissionPageFollowerWarning[mission_page_follower_frame]
      local building_name = shipment_followers[idx .. 'b']
      local time_left = shipment_followers[idx .. 't']
      local incomplete_shipments = shipment_followers[idx .. 'r']
      if building_name then
         if time_left then
            warning:SetFormattedText("%s%s %s (%d)", RED_FONT_COLOR_CODE, time_left, building_name, incomplete_shipments)
         else
            warning:SetFormattedText("%s%s", YELLOW_FONT_COLOR_CODE, building_name)
         end
         warning:Show()
      end
   end
end
addon_env.CheckPartyForProfessionFollowers = function() CheckPartyForProfessionFollowers(GarrisonMissionFrame) end
hooksecurefunc(GarrisonMissionFrame, "UpdateMissionParty", CheckPartyForProfessionFollowers)

local function MissionPage_WarningInit(MissionFrame)
   for idx = 1, #MissionPageFollowers do
      -- force pre-init here?
   end
end

local function GarrisonInitUI()
   local follower_type = Enum_GarrisonFollowerType_FollowerType_6_0_GarrisonFollower
   local o = addon_env.InitGMMFollowerOptions({
      follower_type                = follower_type,
      gmm_prefix                   = "",
      ilevel_max                   = 675
   })

   addon_env.MissionPage_ButtonsInit(follower_type)
   MissionPage_WarningInit(GarrisonMissionFrame)
   hooksecurefunc(GarrisonMissionFrame, "ShowMission", addon_env.ShowMission_More)

   addon_env.MissionList_ButtonsInit(follower_type)
   local MissionList_Update_More = addon_env.MissionList_Update_More
   local function GarrisonMissionFrame_MissionList_Update_More()
      MissionList_Update_More(GarrisonMissionFrame.MissionTab.MissionList, GarrisonMissionFrame_MissionList_Update_More, "MissionList", follower_type, GARRISON_CURRENCY)
   end

   hooksecurefunc(GarrisonMissionFrame.MissionTab.MissionList,           "Update", GarrisonMissionFrame_MissionList_Update_More)
   hooksecurefunc(GarrisonMissionFrame.MissionTab.MissionList.ScrollBox, "Update", GarrisonMissionFrame_MissionList_Update_More)

   -- hooksecurefunc(GarrisonMissionFrame.FollowerList, "UpdateData", addon_env.GarrisonFollowerList_Update_More)

   GarrisonInitUI = nil
end
GarrisonInitUI()
