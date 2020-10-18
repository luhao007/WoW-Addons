-- Author: Ketho (EU-Boulderfist)
-- License: Public Domain

if IsAddOnLoaded("DynamicCam") then
	print("DynamicCam is more advanced, disabling FasterCamera...")
	DisableAddOn("FasterCamera", true)
	return
end

local NAME, S = ...
local L = S.L

local ACR = LibStub("AceConfigRegistry-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local db

-- anything bigger than 1 could be a custom zoom increment from another addon
-- @param func		the prehooked function to call
-- @param increment	the increment in yards to zoom
local function CameraZoom(func, increment)
	local isCloseUp = GetCameraZoom() < 6 and db.increment >= 2
	func(increment > 1 and increment or isCloseUp and 2 or db.increment)
end

local oldZoomIn = CameraZoomIn
local oldZoomOut = CameraZoomOut

function CameraZoomIn(v)
	CameraZoom(oldZoomIn, v)
end

function CameraZoomOut(v)
	CameraZoom(oldZoomOut, v)
end

-- multi-passenger mounts / quest vehicles
local oldVehicleZoomIn = VehicleCameraZoomIn
local oldVehicleZoomOut = VehicleCameraZoomOut

function VehicleCameraZoomIn(v)
	CameraZoom(oldVehicleZoomIn, v)
end

function VehicleCameraZoomOut(v)
	CameraZoom(oldVehicleZoomOut, v)
end

local base = 15
local maxfactor = 2.6

local defaults = {
	db_version = 2.1,
	increment = 4,
	speed = 20,
	distance = maxfactor,
}

local options = {
	type = "group",
	name = format("%s |cffADFF2F%s|r", NAME, GetAddOnMetadata(NAME, "Version")),
	args = {
		group1 = {
			type = "group", order = 1,
			name = " ",
			inline = true,
			args = {
				increment = {
					type = "range", order = 1,
					width = "double", descStyle = "",
					name = L.ZOOM_INCREMENT,
					get = function(i) return db.increment end,
					set = function(i, v) db.increment = v end,
					min = 1, max = 10, softMax = 5, step = .5,
				},
				spacing1 = {type = "description", order = 2, name = "\n"},
				speed = {
					type = "range", order = 3,
					width = "double", descStyle = "",
					name = L.ZOOM_SPEED,
					get = function(i) return tonumber(GetCVar("cameraZoomSpeed")) end,
					set = function(i, v) db.speed = v; SetCVar("cameraZoomSpeed", v) end,
					min = 1, max = 50, step = 1,
				},
				spacing2 = {type = "description", order = 4, name = "\n"},
				distance = {
					type = "range", order = 5,
					width = "double", desc = OPTION_TOOLTIP_MAX_FOLLOW_DIST,
					name = MAX_FOLLOW_DIST,
					get = function(i) return GetCVar("cameraDistanceMaxZoomFactor") * base end,
					set = function(i, v) db.distance = v / base; SetCVar("cameraDistanceMaxZoomFactor", v / base) end,
					min = base, max = base * maxfactor, step = 1.5, -- cvar gets rounded to 1 decimal
				},
			},
		},
		info = {
			type = "description", order = 2,
			name = function() return format(" %s = |cffADFF2F%.1f|r", L.DISTANCE, GetCameraZoom()) end,
			fontSize = "medium",
		},
	},
}

local f = CreateFrame("Frame")

function f:OnEvent(event, addon)
	if addon == NAME then
		if not FasterCameraDB2 or FasterCameraDB2.db_version < defaults.db_version then
			FasterCameraDB2 = CopyTable(defaults)
		end
		db = FasterCameraDB2
		
		ACR:RegisterOptionsTable(NAME, options)
		ACD:AddToBlizOptions(NAME, NAME)
		ACD:SetDefaultSize(NAME, 420, 330)
		
		C_Timer.After(1, function()
			-- not actually necessary to override from savedvars
			-- but better to do this if other addons also set it
			SetCVar("cameraDistanceMaxZoomFactor", db.distance)
			SetCVar("cameraZoomSpeed", db.speed)
		end)
		
		self:UnregisterEvent(event)
	end
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", f.OnEvent)

local function UpdateDistanceACD() -- AceGUI distance
	ACR:NotifyChange(NAME) -- hide that initial flicker
	C_Timer.NewTicker(.5, function(self)
		if ACD.OpenFrames.FasterCamera then
			if not ACD.OpenFrames.FasterCamera.frame:IsMouseOver() and not GetCurrentKeyBoardFocus() then
				ACR:NotifyChange(NAME)
			end
		else
			self:Cancel()
		end
	end)
end

local PanelTicker

local function UpdateDistancePanel() -- InterfaceOptionsFrame distance
	local panel = InterfaceOptionsFramePanelContainer.displayedPanel
	if panel.name == NAME and not PanelTicker then
		PanelTicker = C_Timer.NewTicker(.5, function(self)
			if panel:IsVisible() and panel.name == NAME then
				if not panel:IsMouseOver() and not GetCurrentKeyBoardFocus() then
					panel:Hide()
					panel:Show() -- refresh
				end
			else
				self:Cancel()
				PanelTicker = nil
			end
		end)
	end
end

hooksecurefunc("InterfaceOptionsList_DisplayPanel", UpdateDistancePanel) -- navigating to FasterCamera panel
InterfaceOptionsFrame:HookScript("OnShow", UpdateDistancePanel) -- opening straight to FasterCamera panel

for i, v in pairs({"fc", "fastercam", "fastercamera"}) do
	_G["SLASH_FASTERCAMERA"..i] = "/"..v
end

function SlashCmdList.FASTERCAMERA()
	if not ACD.OpenFrames.FasterCamera then
		ACD:Open(NAME)
		UpdateDistanceACD()
	end
end

local dataobject = {
	type = "launcher",
	icon = "Interface\\Icons\\inv_misc_spyglass_03",
	text = NAME,
	OnClick = function()
		if ACD.OpenFrames.FasterCamera then
			ACD:Close(NAME)
		else
			ACD:Open(NAME)
			UpdateDistanceACD()
		end
	end,
	OnTooltipShow = function(tt)
		tt:AddLine("|cffADFF2F"..NAME.."|r")
		tt:AddDoubleLine( MAX_FOLLOW_DIST, format("%.1f", GetCameraZoom()) )
	end,
}

LibStub("LibDataBroker-1.1"):NewDataObject(NAME, dataobject)
