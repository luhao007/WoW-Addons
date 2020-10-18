-- Titan [SimulationCraft]
-- Description: Titan plug-in to open Simulation Craft
-- Author: r1fT
-- Version: v1.0.5.70100-alpha5

local _G = getfenv(0);
local TITAN_SIMULATIONCRAFT_ID = "SimulationCraft";
local TITAN_SIMULATIONCRAFT_VER = "v1.0.5.70100-alpha5";
local updateTable = {TITAN_SIMULATIONCRAFT_ID, TITAN_PANEL_UPDATE_BUTTON};
local buttonlabel = "Titan Panel [|cff00ff00SimulationCraft|r]"
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local AceTimer = LibStub("AceTimer-3.0")
local OverallAvg
local EquippedAvg

function GetItemLevel(iLink)
    name, link, quality, iLvl, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(iLink);
    if(iLvl == nil)then
        ilvl = 0;
    end
    return iLvl;
 end

function TitanPanelSimulationCraftButton_OnLoad(self)
	self.registry = {
		id = TITAN_SIMULATIONCRAFT_ID,
		version = TITAN_SIMULATIONCRAFT_VER,
		category = "Information",
		menuText = "Titan Panel [|cff00ff00SimulationCraft|r]",
		buttonTextFunction = "TitanPanelSimulationCraftButton_GetButtonText", 
		tooltipTitle = "|cff00ff00SimulationCraft|r",
		tooltipTextFunction = "TitanPanelSimulationCraftButton_GetTooltipText", 
		icon = "Interface\\Addons\\titan-simulationcraft\\Icon",
		iconWidth = 16,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			DisplayOnRightSide = true
		},
		savedVariables = {
			ShowIcon = 1,
			DisplayOnRightSide = true
		}
	};
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function TitanPanelSimulationCraftButton_OnEvent(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") and (not self:IsEventRegistered("PLAYER_EQUIPMENT_CHANGED")) then
		self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	end

	if event == "PLAYER_EQUIPMENT_CHANGED" then
		self:SetScript("OnUpdate", TitanPanelSimulationCraftButton_OnUpdate)
	end
end

function TitanPanelSimulationCraftButton_OnUpdate(self)
	TitanPanelPluginHandle_OnUpdate(updateTable)
	self:SetScript("OnUpdate", nil)
end

function TitanPanelSimulationCraftButton_OnClick(self, button)
	if (button == "LeftButton") then
		local editbox=ChatEdit_ChooseBoxForSend(DEFAULT_CHAT_FRAME);
		ChatEdit_ActivateChat(editbox);
		editbox:SetText("/simc");
		ChatEdit_OnEnterPressed(editbox);
	end
end

function TitanPanelSimulationCraftButton_GetButtonText(id)
	return buttonlabel, "|r"
end

function Pawn_round(num, n)
	local mult = 10^(n or 0)
	return math.floor(num * mult + 0.5) / mult
end

function TitanPanelSimulationCraftButton_GetTooltipText()
	SimCItems = "\n";
	SimCInvSlot = INVSLOT_HEAD
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Helm: 	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Helm: 	|cFFFFFFFFNone|r \n";
	end
	SimCInvSlot = INVSLOT_NECK
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Neck:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Neck: 	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_SHOULDER
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Shoulder: 	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Shoulder: 	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_BACK
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Back:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Back:	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_CHEST
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Chest:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Chest:	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_WAIST
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Waist:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Waist:	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_LEGS
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Legs:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Legs:	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_FEET
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Feet:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Feet:	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_WRIST
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Wrist:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Wrist:	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_HAND
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Hands:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Hands:	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_FINGER1
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Ring:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Ring:	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_FINGER2
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Ring:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Ring:	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_TRINKET1
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Trinket:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Trinket:	|cFFFFFFFFNone\n";
	end
	SimCInvSlot = INVSLOT_TRINKET2
	if GetInventoryItemLink("player", SimCInvSlot) ~= nil then
		iLink = GetInventoryItemLink("player", SimCInvSlot);
		iLvl = GetItemLevel(iLink);
		SimCItems = SimCItems.."Trinket:	"..iLink.." - |cFFFFFFFF"..iLvl.."|r \n";
		if PawnVersion ~= nil then
			Pawn_calc = PawnGetItemDataForInventorySlot(SimCInvSlot, false);
			Pawn_output = PawnGetAllItemValues(Pawn_calc.Stats,Pawn_calc.Level,Pawn_calc.SocketBonusStats);
			for key, value in pairs(Pawn_output) do
				for k, v in pairs(value) do
					if (v ~= 0) then
						if (k % 2 == 0) then
							SimCItems = SimCItems.."	|cFF00FF00"..Pawn_round(v, 1).."|r \n"
						else
							SimCItems = SimCItems.."   |cFFFFFFFF*"..v.."|r"
						end
					else
						break
					end
				end
			end
		end
	else
		SimCItems = SimCItems.."Trinket:	|cFFFFFFFFNone\n";
	end
	EquippedAvg = string.format("%d",select(2,GetAverageItemLevel("player")));
	SimCItems = SimCItems.."\nAverage Item Level: |cFF0055FF"..EquippedAvg.."|r \n";
	SimCItems = SimCItems.."|cff00ff00Left-click for SimulationCraft export.|r";
	return SimCItems
end

function TitanPanelRightClickMenu_PrepareSimulationCraftMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_SIMULATIONCRAFT_ID].menuText);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_SIMULATIONCRAFT_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end


