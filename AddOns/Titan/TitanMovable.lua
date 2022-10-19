--[[ File
NAME: TitanMovable.lua
DESC: Contains the routines to adjust the Blizzard frames to make room for the Titan bars the user has selected.
There are a select set of Blizzard frames at the top of screen and at the bottom of the screen that Titan will move.
Each frame adjusted has an entry in MData which is local and not directly accessible via addons.
However addons can tell Titan to not adjust some or all frames using TitanUtils_AddonAdjust(frame, bool). 
Addons that replace all or parts of the Blizzard UI use this.

The user can turn turn on / off the adjusting of all top frames or all bottom frames.
:DESC

NOTE: The Override Bar has changed over time. Titan has had to evolve with it, making several attempts to
create a reasonable fix to minimize the impact to the player.
Titan Panel hooks 3 areas:
- OverrideActionBar show 
- OverrideActionBar hide
- ActionBarController_UpdateAll
This covers various quests and other situations that replace the main menu bar temporarily.

When the player uses bottom bar(s), the bars are hidden while the override is active then
put back when the bar is removed.

While on some quests where the player is in a vehicle, they could be knocked out of said vehicle.
If Titan shows the bottom bar, the main menu could be unusable. Titan will wait for the player to be out of
combat while in a vehicle.
On some quests (for example, some turtle quests in BfA) it takes seconds for the player to fall out of combat
at the end of the quest. This will cause Titan bars to be delayed before appearing.
:NOTE

NOTE: Some quests replace the menu bar with an Override Bar which causes Titan Panel
to hide the bottom bar(s). 
When the menu bar is active again Titan needs to show the bottom bar(s).
A check is made when :
- Override is hidden (hook)
- Vehicle exit (event)
- Combat over (event)
All three are needed to show bottom bar(s) because the order is not guaranteed. Some quests do not use Override bar.
:NOTE

NOTE: When the player is in their class hall, Titan will hide the top bars to not conflict with the Class Command Bar.
:NOTE

NOTE: Vehicle enter and leave have become complicated because a vehicle could be a flight path or a quest.
On vehicle enter Titan closes any Titan menus and states the menu bar as 'user controlled' but does not close bottom bars(s).
Stating 'user controlled' is for quests using a vehicle but does not impact flights. 
Closing bottom bars will be done on Override show / ActionBarController_UpdateAll invocation 
Closing the bottom bars on flights would be inconsistent and remove player functionality.
:NOTE

--]]
-- Globals

-- Locals
local _G = getfenv(0);
local InCombatLockdown = _G.InCombatLockdown;
local hooks_done = false;

local move_count = 0

--[[ Titan
Declare the Ace routines
 local AceTimer = LibStub("AceTimer-3.0")
 i.e. TitanPanelAce.ScheduleTimer("LDBToTitanSetText", TitanLDBRefreshButton, 2);
 or
 i.e. TitanPanelAce:ScheduleTimer(TitanLDBRefreshButton, 2);

 Be careful that the 'self' is proper to cancel timers!!!
--]]
local TitanPanelAce = LibStub("AceAddon-3.0"):NewAddon("TitanPanel", "AceHook-3.0", "AceTimer-3.0")

--Determines the optimal magic number based on resolution
--local menuBarTop = 55;
--local width, height = string.match((({GetScreenResolutions()})[GetCurrentResolution()] or ""), "(%d+).-(%d+)");
--if ( tonumber(width) / tonumber(height ) > 4/3 ) then
	--Widescreen resolution
--	menuBarTop = 75;
--end

--[[From Resike to prevent tainting stuff to override the SetPoint calls securely.
hooksecurefunc(FrameRef, "SetPoint", function(self)
	if self.moving then
		return
	end
	self.moving = true
	self:SetMovable(true)
	self:SetUserPlaced(true)
	self:ClearAllPoints()
	self:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	self:SetMovable(false)
	self.moving = nil
end)
--]]

--[[ local
NAME: f_list table
DESC: Holds the list of frames Titan may adjust with additional data. 
Each record contains:
name - frame name (string) to adjust
user_movable - true if Blizzard allows the user to move the frame via its UI
debug - set true if debugging the adjust of that frame
:DESC
NOTE:
- The index MUST be the frame name as used by MData.
:NOTE
--]]
local f_list = {
	PlayerFrame = {name = "PlayerFrame", place = TITAN_PANEL_PLACE_TOP, user_movable = true, debug = false},
	TargetFrame = {name = "TargetFrame", place = TITAN_PANEL_PLACE_TOP, user_movable = true, debug = false},
	PartyMemberFrame1 = {name = "PartyMemberFrame1", place = TITAN_PANEL_PLACE_TOP, user_movable = false, debug = false},
	TicketStatusFrame = {name = "TicketStatusFrame", place = TITAN_PANEL_PLACE_TOP, user_movable = false, debug = false},
	BuffFrame = {name = "BuffFrame", place = TITAN_PANEL_PLACE_TOP, user_movable = false, debug = false},
	MinimapCluster = {name = "MinimapCluster", place = TITAN_PANEL_PLACE_TOP, user_movable = false, debug = false},
	MultiBarRight = {name = "MultiBarRight", place = TITAN_PANEL_PLACE_BOTTOM, user_movable = false, debug = false},
	MicroButtonAndBagsBar = {name = "MicroButtonAndBagsBar", place = TITAN_PANEL_PLACE_BOTTOM, user_movable = false, debug = false},
	MainMenuBar = {name = "MainMenuBar", place = TITAN_PANEL_PLACE_BOTTOM, user_movable = false, debug = false},
	ExtraActionBarFrame = {name = "ExtraActionBarFrame", place = TITAN_PANEL_PLACE_BOTTOM, user_movable = false, debug = false},
}

--[[ local
NAME: DoAdjust
DESC: See if Titan should adjust based only on its own flags.
VAR: place   - top or bottom
OUT: boolean - true to adjust, false if not
--]]
local function DoAdjust(place, force)
	local res = false -- assume we will not adjust
	-- force is passed to cover cases where the user has just deselected both top or bottom bars
	-- When that happens we need to adjust

	-- We did it to ourselves - if (Aux)ScreenAdjust is true / 1 it means the user wants Titan to NOT adjust...
	if place == TITAN_PANEL_PLACE_TOP or place == TITAN_PANEL_PLACE_BOTH then
		if TitanPanelGetVar("ScreenAdjust") == 1 then
			-- do not adjust
		else
			if force then
				res = true
			elseif TitanPanelGetVar("Bar_Show") or TitanPanelGetVar("Bar2_Show") then
				res = true
			end
		end
	elseif place == TITAN_PANEL_PLACE_BOTTOM or place == TITAN_PANEL_PLACE_BOTH then
		if TitanPanelGetVar("AuxScreenAdjust") == 1 then
			-- do not adjust
		else
			if force then
				res = true
			elseif TitanPanelGetVar("AuxBar_Show") or TitanPanelGetVar("AuxBar2_Show") then
				res = true
			end
		end
	end
	return res
end

--[[ local
NAME: VisibleBars
DESC: Get the x axis offset if XP or another bar are shown
VAR: None
OUT: int - X axis offset, in pixels
--]]
local function VisibleBars()
	-- A valid frame and point is required
	-- Determine a proper X offset using the given point (position)
	local ret = 0 -- In case player at max level (no XP gain) and nothing else shown
	if ( StatusTrackingBarManager:GetNumberVisibleBars() == 2 ) then
		ret = 17;
	elseif ( StatusTrackingBarManager:GetNumberVisibleBars() == 1 ) then
		ret = 14;
	end

	return ret
end

--[[ Titan
NAME: TitanMovable_MenuBar_Disable
DESC: Handle the main menu bar so Blizzard does not get upset.
VAR: None
OUT: None
NOTE:
- Needed because 8.0 made changes to the menu bar processing
- Tell Blizzard that the bar is NOT user placed so when Blizzard makes it reappear, it is working
:NOTE
--]]
function TitanMovable_MenuBar_Disable()
	if DoAdjust(TITAN_PANEL_PLACE_BOTTOM, false) then
		MainMenuBar:SetMovable(true);
		MainMenuBar:SetUserPlaced(false);
	end

	if TITAN_PANEL_VARS.debug.movable then
		TitanDebug ("_MenuBar_Disable :"
			.." likely UNIT_ENTERED_VEHICLE"
			)
	end
end

--[[ Titan
NAME: TitanMovable_MenuBar_Enable
DESC: Handle the main menu bar so Blizzard does not get upset.
VAR: None
OUT: None
NOTE:
- Needed because 8.0 made changes to the menu bar processing
- Tell Blizzard that the bar is user placed IF NOT in combat to prevent 'bouncing' of the bar if users use a bottom Titan bar
- This is called for the various events Titan handles that do / may hide the main menu bar
- IF TitanMovable_MenuBar_Disable was called, this must be called before having Titan adjust frames. The 'is user placed' is required to work around a Blizzard 'feature' that adjusts the main menu bar while in combat.
:NOTE
--]]
function TitanMovable_MenuBar_Enable()
	if InCombatLockdown() or UnitInVehicle("player") then
		-- wait until out of combat...
		-- if player is in vehicle then do not set user is placed,
		-- needed whether in taxi or other vehicle that may replace the main menu bar
	else
		if DoAdjust(TITAN_PANEL_PLACE_BOTTOM, false) then
			MainMenuBar:SetMovable(true);
			MainMenuBar:SetUserPlaced(true);
			MainMenuBar:SetMovable(false);
		end
	end
end

--[[ API
NAME: TitanMovable_GetPanelYOffset
DESC: Get the Y axis offset Titan needs (1 or 2 bars) at the given position - top or bottom.
VAR: framePosition - TITAN_PANEL_PLACE_TOP or TITAN_PANEL_PLACE_BOTTOM
OUT: Y axis offset, in pixels
NOTE:
- The preferred method to determine the Y offset needed to use TitanUtils_GetBarAnchors()
which provides anchors (frames) for an addon to use.
:NOTE
--]]
function TitanMovable_GetPanelYOffset(framePosition) -- used by other addons
	-- Both top & bottom are figured out but only the
	-- requested position is returned
	local barnum_top = 0
	local barnum_bot = 0
	-- If user has the top adjust set then determine the
	-- top offset
	if not TitanPanelGetVar("ScreenAdjust") then
		if TitanPanelGetVar("Bar_Show") then
			barnum_top = 1
		end
		if TitanPanelGetVar("Bar2_Show") then
			barnum_top = 2
		end
	end
	-- If user has the top adjust set then determine the
	-- bottom offset
	if not TitanPanelGetVar("AuxScreenAdjust") then
		if TitanPanelGetVar("AuxBar_Show") then
			barnum_bot = 1
		end
		if TitanPanelGetVar("AuxBar2_Show") then
			barnum_bot = 2
		end
	end
	local scale = TitanPanelGetVar("Scale")
	-- return the requested offset
	-- 0 will be returned if the user has no bars showing
	-- or the scale is not valid
	if scale and framePosition then
		if framePosition == TITAN_PANEL_PLACE_TOP and barnum_top > 0 then
			return (-TITAN_PANEL_BAR_HEIGHT * scale)*(barnum_top);
		elseif framePosition == TITAN_PANEL_PLACE_BOTTOM and barnum_bot > 0 then
			return (TITAN_PANEL_BAR_HEIGHT * scale)*(barnum_bot)
				-1 -- no idea why -1 is needed... seems anchoring to bottom is off a pixel
		end
	end
	return 0
end

--[[ local
NAME: TitanMovableFrame_GetXOffset
DESC: Get the x axis offset Titan needs to adjust the given frame.
VAR: frame - frame object
VAR: point - "LEFT" / "RIGHT" / "TOP" / "BOTTOM" / "CENTER"
OUT: int - X axis offset, in pixels
--]]
local function TitanMovableFrame_GetXOffset(frame, point)
	-- A valid frame and point is required
	-- Determine a proper X offset using the given point (position)
	local ret = 0 -- In case the inputs were invalid or the point was not relevant to the frame then return 0
	if frame and point then
		if point == "LEFT" and frame:GetLeft() and UIParent:GetLeft() then
			ret = frame:GetLeft() - UIParent:GetLeft();
		elseif point == "RIGHT" and frame:GetRight() and UIParent:GetRight() then
			ret = frame:GetRight() - UIParent:GetRight();			
		elseif point == "TOP" and frame:GetTop() and UIParent:GetTop() then
			ret = frame:GetTop() - UIParent:GetTop();
		elseif point == "BOTTOM" and frame:GetBottom() and UIParent:GetBottom() then
			ret = frame:GetBottom() - UIParent:GetBottom();
		elseif point == "CENTER" and frame:GetLeft() and frame:GetRight() 
				and UIParent:GetLeft() and UIParent:GetRight() then
			local framescale = frame.GetScale and frame:GetScale() or 1;
			ret = (frame:GetLeft()* framescale + frame:GetRight()
				* framescale - UIParent:GetLeft() - UIParent:GetRight()) / 2;
		end
	end

	return ret
end

--[[ local
NAME: SetPosition
DESC: Adjust a given frame with the passed in values.
VAR: frame - Text string of the frame name
VAR: ... - list of frame position info
NOTE: 
Swiped & modified from Vrul on wowinterface forum (https://www.wowinterface.com/forums/showthread.php?t=56519)

The table UIPARENT_MANAGED_FRAME_POSITIONS does not hold all Blizzard frames.
It is cleared for each frame in case the frame is in or might be in the table in the future.

Titan does not control the frames as other addons so we honor a user placed frame
:NOTE
--]]
local function SetPosition(frame, ...)
	local fname = frame:GetName()
	local um = false
	if f_list[fname] and f_list[fname].user_movable then
		um = true
	else
		um = false
	end

    if type(frame) == 'string' then
        UIPARENT_MANAGED_FRAME_POSITIONS[frame] = nil
        frame = _G[frame]
    end
    if type(frame) == 'table' and type(frame.IsObjectType) == 'function' and frame:IsObjectType('Frame') then
		if um then
			-- Back off if the user has moved them via the UI
		else
			-- Titan does not set in case the user needs to 
			UIPARENT_MANAGED_FRAME_POSITIONS[fname] = nil
        end

        frame:SetMovable(true)          -- allow frame to move
-- Titan honors a user placed frame so we don't need this
--        frame:SetUserPlaced(true)       -- tell Blizzard to back off
-- Since Titan adjusts rather than controls some frames, 
-- Titan does not need to set these
--        frame:SetDontSavePosition(true) 
--        frame:SetAttribute('ignoreFramePositionManager', true)
--        frame.ignoreFramePositionManager = true
        if ... then
            frame:ClearAllPoints()
            frame:SetPoint(...)
        end
		-- Need to add in case user (not an addon) wants to move this frames
		if um then
			-- do nothing
		else
			frame:SetMovable(false)         -- lock frame from moving
		end
    end
end

--[[ local
NAME: CheckConflicts
DESC: Check for other addons that control UI elements. Tell Titan to back off the frames the addon controls or can control.
VAR: <none>
NOTE: 
This is messy routine because the internals of each addon must be known to check for the frames that are controlled.
Some addons use different names where Titan uses the Blizzard frame names
:NOTE
--]]
local function CheckConflicts()
	local addon = "Bartender4"
	if (IsAddOnLoaded(addon)) then -- user has enabled
--		TitanDebug (addon.." active : Titan will not adjust frames that "..addon.." could control")
		-- Check would be : BT4Bar<BT bar name>.config.enabled to check if the frame exists and if it is enabled in BT4
		TitanMovable_AddonAdjust("MainMenuBar", true)
		TitanMovable_AddonAdjust("MicroButtonAndBagsBar", true)
		TitanMovable_AddonAdjust("MultiBarRight", true)
		TitanMovable_AddonAdjust("ExtraActionBarFrame", true)
		TitanMovable_AddonAdjust("OverrideActionBar", true) -- not sure about this one...
    end
	addon = "ElvUI"
	if (IsAddOnLoaded(addon)) then -- user has enabled
--		TitanDebug (addon.." active : Titan will not adjust frames that "..addon.." could control")
		-- ElvUI controls the whole UI
		TitanMovable_AddonAdjust("PlayerFrame", true)
		TitanMovable_AddonAdjust("TargetFrame", true)
		TitanMovable_AddonAdjust("PartyMemberFrame1", true)
		TitanMovable_AddonAdjust("TicketStatusFrame", true)
		TitanMovable_AddonAdjust("BuffFrame", true)
		TitanMovable_AddonAdjust("MinimapCluster", true)
		TitanMovable_AddonAdjust("MultiBarRight", true)
		TitanMovable_AddonAdjust("OverrideActionBar", true)
		TitanMovable_AddonAdjust("MicroButtonAndBagsBar", true)
		TitanMovable_AddonAdjust("MainMenuBar", true)
		TitanMovable_AddonAdjust("ExtraActionBarFrame", true)
    end
end

--[[ local
NAME: MoveFrame
DESC: Adjust the given frame. Expected are frames where :GetPoint works
VAR: frame_ptr - Text string of the frame name
VAR: start_y - Any offset due to the specific frame
VAR: top_bottom - Frame is at top or bottom, expecting Titan constant for top or bottom
VAR: force - Force the adjust; passed through
OUT: None
--]]
local function MoveFrame(frame_ptr, start_y, top_bottom, force)
	local frame = _G[frame_ptr]
	local y = 0
	local op = "?"

	if frame and (frame:IsUserPlaced() or
			frame.MALockPointHook  -- Allow MoveAnything to be used w/o error
		)
	then
		-- skip this frame
		op = "skip - MoveAnything"
	else
		if DoAdjust(top_bottom, force) and frame:IsShown() then
			local scale = TitanPanelGetVar("Scale")
			y = TitanMovable_GetPanelYOffset(top_bottom) 
				+ (start_y or 0)
			local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
			-- check for nil which will cause an error
			if point and relativeTo and relativePoint and xOfs then -- do not care about yOfs
				-- should be safe...
				SetPosition(frame, point, relativeTo:GetName(), relativePoint, xOfs, y)
				op = "move - y "..tostring(y)
			else
				op = "skip - :GetPoint invalid"
				-- do not proceed
			end
		else
			--[[
			Some frames such as the ticket frame may not be visible or even created
			--]]
			op = "skip - adj "..tostring(DoAdjust(top_bottom, force)).." shown "..tostring(frame:IsShown())
		end
	end
	
	if f_list[frame_ptr] and f_list[frame_ptr].debug then
		TitanDebug ("MoveFrame"
		.." "..tostring(frame_ptr)
		.." "..tostring(op)
		)
	end
end

--[[ local
NAME: MoveMenuFrame
DESC: Adjust the MainMenuBar frame. Needed because :GetPoint does NOT always work for MainMenuBar. 
This is modeled after MoveFrame to keep it similar.
Titan sets the IsUserPlaced for the MainMenuBar frame so Titan needs to adjust.
VAR: frame_ptr - Text string of the frame name
VAR: start_y - Any offset due to the specific frame
VAR: top_bottom - Frame is at top or bottom, expecting Titan constant for top or bottom
VAR: force - Force the adjust; passed through
OUT: None
--]]
local function MoveMenuFrame(frame_ptr, start_y, top_bottom, force)
	local frame = _G[frame_ptr]
	local adj = false
	if frame and (frame:IsUserPlaced() 
			or frame.MALockPointHook  -- Allow MoveAnything to be used w/o error
		)
		and DoAdjust(top_bottom, force)
	then
		local yOffset = TitanMovable_GetPanelYOffset(top_bottom) -- includes scale adjustment
			+ VisibleBars()
		local xOfs = TitanPanelGetVar("MainMenuBarXAdj")

		SetPosition(frame, "BOTTOM", "UIParent", "BOTTOM", xOfs, yOffset)
		adj = true
	else
		-- Unknown frame...
	end
end

--[[ Titan
NAME: Titan_FCF_UpdateDockPosition
DESC: Secure post hook to help adjust the chat / log frame.
VAR:  None
OUT:  None
NOTE:
- This is required because Blizz adjusts the chat frame relative to other frames so some of the Blizz code is copied.
- If in combat or if the user has moved the chat frame then no action is taken.
- The frame is adjusted in the Y axis only.
- See See FCF_UpdateDockPosition if this is no longer working - This routine may need to change.
:NOTE
--]]
local function Titan_FCF_UpdateDockPosition() -- See FCF_UpdateDockPosition
	if not Titan__InitializedPEW
	or not TitanPanelGetVar("LogAdjust") 
	or TitanPanelGetVar("AuxScreenAdjust") then 
		return 
	end
	
	if not InCombatLockdown() or (InCombatLockdown() 
	and not _G["DEFAULT_CHAT_FRAME"]:IsProtected()) then
		local panelYOffset = TitanMovable_GetPanelYOffset(TITAN_PANEL_PLACE_BOTTOM);
		local scale = TitanPanelGetVar("Scale");
		if scale then
			panelYOffset = panelYOffset + (24 * scale) -- after 3.3.5 an additional adjust was needed. why? idk
		end

		if ( DEFAULT_CHAT_FRAME:IsUserPlaced() ) then
			return;
		end
		
		local chatOffset = 85 + panelYOffset; -- Titan change to adjust Y offset
		if ( GetNumShapeshiftForms() > 0 or HasPetUI() or PetHasActionBar() ) then
			if ( MultiBarBottomLeft:IsShown() ) then
				chatOffset = chatOffset + 55;
			else
				chatOffset = chatOffset + 15;
			end
		elseif ( MultiBarBottomLeft:IsShown() ) then
			chatOffset = chatOffset + 15;
		end
		DEFAULT_CHAT_FRAME:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 
			32, chatOffset);
		FCF_DockUpdate();
	end
end

--[[ Titan
NAME: Titan_ContainerFrames_Relocate
DESC: Secure post hook to help adjust the bag frames.
VAR:  None
OUT:  None
NOTE:
- The frame is adjusted in the Y axis only.
- The Blizz routine "ContainerFrames_Relocate" should be examined for any conditions it checks and any changes to the SetPoint.
If Blizz changes the anchor points the SetPoint here must change as well!!
The Blizz routine calculates X & Y offsets to UIParent (screen) so there is not need to store the prior offsets.
Like the Blizz routine we search through the visible bags. Unlike the Blizz routine we only care about the first of each column to adjust for Titan.
This way the Blizz code does not need to be copied here.
:NOTE
--]]
local function Titan_ContainerFrames_Relocate()
	if not TitanPanelGetVar("BagAdjust") then 
		return 
	end

	local panelYOffset = TitanMovable_GetPanelYOffset(TITAN_PANEL_PLACE_BOTTOM)
	local off_y = 10000 -- something ridiculously high
	local bottom_y = 0
	local right_x = 0
	local frame = {}

	for index, frameName in ipairs(ContainerFrame1.bags) do
		frame = _G[frameName];
		if frame:GetBottom() then bottom_y = frame:GetBottom() end
		if ( bottom_y < off_y ) then
			-- Start a new column
			right_x = frame:GetRight()
			frame:ClearAllPoints();		
			frame:SetPoint("BOTTOMRIGHT", frame:GetParent(), 
				"BOTTOMLEFT", -- changed because we are taking the current x value
				right_x, -- x is not adjusted
				bottom_y + panelYOffset -- y
			)
		end
		off_y = bottom_y
	end
end

local function calc_bars() -- extra action button
	local res = 0
	local out = ""
	local main = 0
	local left = 0
	local pet = 0
	local stance = 0
	local cast = 0
	local poss = 0
	local vehicle = 0
	-- This covers the basic UI where there is no pet or extras
	if MainMenuBar and MainMenuBar:IsShown() then
		main = MainMenuBar:GetHeight()
		out = MainMenuBar
	end
	-- Add the left bottom; the right bottom does not change Y
	if MultiBarBottomLeft and MultiBarBottomLeft:IsShown() then
		left = MultiBarBottomLeft:GetHeight()
		out = MainMenuBar
	end
	-- These should be mutually exclusive...
	if PetActionBarFrame and PetActionBarFrame:IsShown() then
		pet = PetActionBarFrame:GetHeight();
		out = PetActionBarFrame
	end
	if StanceBarFrame and StanceBarFrame:IsShown() then
		stance = StanceBarFrame:GetHeight();
		out = StanceBarFrame
	end
	if MultiCastActionBarFrame and MultiCastActionBarFrame:IsShown() then
		cast = MultiCastActionBarFrame:GetHeight();
		out = MultiCastActionBarFrame
	end
	if PossessBarFrame and PossessBarFrame:IsShown() then
		poss = PossessBarFrame:GetHeight();
		out = PossessBarFrame
	end
	if MainMenuBarVehicleLeaveButton and MainMenuBarVehicleLeaveButton:IsShown() then
		vehicle = MainMenuBarVehicleLeaveButton:GetHeight();
		out = MainMenuBarVehicleLeaveButton
	end

	res = main + left + pet + stance + cast + poss + vehicle

	return res
end
XXZZ_calc_bars = calc_bars

--[[ local
NAME: MData table
DESC: MData is a local table that holds each frame Titan may need to adjust. It controls the offsets needed to make room for the Titan bar(s).
Each frame can be adjusted by modifying its 'move' function.
The f_list and MData MUST have matching index so the name and move function correspond.
Each record contains:
move - function to adjust that frame
addonAdj - true if another addon is taking responsibility of adjusting this frame, if false Titan will use the user settings to adjust or not
:DESC
NOTE:
- f_list MUST have frame name as the index so the extra data can be used.
- MoveFrame calculates and offsets for the Titan bars, if shown
- When calculating the initial Y offset, consider the points and relative points of the frame being adjusted. See the move function for specific frame adjustments
- Of course Blizzard had to make the MainMenuBar act differently <sigh>. :GetPoint() does not work on it so a special helper routine was needed.
- The move function sets info in the frame itself. It so inside the move because some frames, such as the ticket frame, may not be created until needed.
:NOTE
--]]
local MData = {
	[1] = {
		frameName = "PlayerFrame",
		move = function (force)
			MoveFrame("PlayerFrame", 0, TITAN_PANEL_PLACE_TOP, force) 
			end, 
		addonAdj = false, },
	[2] = {
		frameName = "TargetFrame", 
		move = function (force) 
			MoveFrame("TargetFrame", 0, TITAN_PANEL_PLACE_TOP, force)  
			end, 
		addonAdj = false, },
	[3] = {
		frameName = "PartyMemberFrame1",
		move = function (force) 
			MoveFrame("PartyMemberFrame1", 0, TITAN_PANEL_PLACE_TOP, force)  
			end, 
		addonAdj = false, },
	[4] = {
		frameName = "TicketStatusFrame", 
		move = function (force) 
			MoveFrame("TicketStatusFrame", 0, TITAN_PANEL_PLACE_TOP, force)  
			end, 
		addonAdj = false, },
	[5] = {
		frameName = "BuffFrame", 
		move = function (force) 
			-- The main frames have no adjustment (tops align) to UIParent.
			-- But we need to properly adjust for
			-- 1) When user does not use either top bar
			-- 2) Y if GM Ticket is visible

			-- Use IsShown rather than IsVisible. In some cases (after closing
			-- full screen map) the ticket may not yet be visible.
			local yOffset = 0
			local y = TitanMovable_GetPanelYOffset(TITAN_PANEL_PLACE_TOP)
			if y == 0 then
				-- covers case where user disables both top bars
				yOffset = BUFF_FRAME_BASE_EXTENT -- From BuffFrame.lua 
					* -1 -- adjust 'down' on screen
			else
				if TicketStatusFrame:IsShown()
				and TitanPanelGetVar("TicketAdjust") 
				then
					yOffset = (-TicketStatusFrame:GetHeight())
				else
					yOffset = TitanPanelGetVar("BuffIconVerticalAdj")  -- -13 (8.x)
				end
			end
			MoveFrame("BuffFrame", yOffset, TITAN_PANEL_PLACE_TOP, force) 
			end, 
		addonAdj = false, },
	[6] = {
		frameName = "MinimapCluster", 
		move = function (force) 
			local yOffset = 0
			if MinimapBorderTop 
			and not MinimapBorderTop:IsShown() then
				yOffset = yOffset + (MinimapBorderTop:GetHeight() * 3/5) - 5
			end
			MoveFrame("MinimapCluster", yOffset, TITAN_PANEL_PLACE_TOP, force)  
			end, 
		addonAdj = false, },
	[7] = {
		frameName = "MultiBarRight", 
		move = function (force) 
			MoveFrame("MultiBarRight", 0, TITAN_PANEL_PLACE_BOTTOM, force)  
			end, 
		addonAdj = false, },
	[8] = {
		frameName = "MicroButtonAndBagsBar", 
		move = function (force) 
			MoveFrame("MicroButtonAndBagsBar", 0, TITAN_PANEL_PLACE_BOTTOM, force)  
			end, 
		addonAdj = false, },
	[9] = {
		frameName = "MainMenuBar", -- MainMenuBar
		move = function (force) 
			MoveMenuFrame("MainMenuBar", 0, TITAN_PANEL_PLACE_BOTTOM, force)  
			end, 
		addonAdj = false, },
	[10] = {
		frameName = "ExtraActionBarFrame",
		move = function (force)
			-- Only spend cycles if the frame is shown.
			if ExtraActionBarFrame
			and ExtraActionBarFrame:IsShown() then
				--[=[ 
				Need to calc Y because Y depends on what else is shown
				The extra action button is calculated from the center of the screen so this needs more effort than the other buttons
				Look at UIParent.lua for logic (UIParent_ManageFramePosition)
				--]=]
				local actionBarOffset = 45;
				local menuBarTop = 55;
				local overrideActionBarTop = 40;
				local petBattleTop = 60;
				
				local start_y = ExtraAbilityContainer:GetHeight() -- 18 -- FramePositionDelegate:UIParentManageFramePositions
				local rel_start = UIParent:GetHeight() / 2 -- CENTER of UIParent
				local yOfs = 0 
				local yOfs1 = 0 
				yOfs = (rel_start * -1) -- bottom of screen
					+ calc_bars() -- offset of WoW bars shown
					+ start_y -- center of extra action button
				MoveFrame("ExtraAbilityContainer", yOfs, TITAN_PANEL_PLACE_BOTTOM, force)
			end 
			end,
		addonAdj = false, },
}

--[[ Titan
NAME: TitanMovable_AdjustTimer
DESC: Cancel then add the given timer. The timer must be in TitanTimers.
VAR: ttype - The timer type (string) as defined in TitanTimers
OUT:  None
--]]
function TitanMovable_AdjustTimer(ttype)
	local timer = TitanTimers[ttype]
	if timer then
		TitanPanelAce.CancelAllTimers(timer.obj)
		TitanPanelAce.ScheduleTimer(timer.obj, timer.callback, timer.delay)
	end
end

--[[ Titan
NAME: TitanMovable_AddonAdjust
DESC: Set the given frame to be adjusted or not by another addon. This is called from TitanUtils for a developer API.
VAR: frame - frame name (string)
VAR: bool - true (addon will adjust) or false (Titan will use its settings) 
OUT:  None
--]]
function TitanMovable_AddonAdjust(frame, bool)
	for i = 1,#MData,1 do
		local fData = MData[i]
		local fName = nil
		if fData then
			fName = fData.frameName;
		end

		if (frame == fName) then
			fData.addonAdj = bool
		end
	end
end

--[[ local
NAME: TitanMovableFrame_MoveFrames
DESC: Loop through MData calling each frame's 'move' function for each Titan controlled frame.
Then update the chat and open bag frames.
OUT: None
--]]
local function TitanMovableFrame_MoveFrames(place, force)
	local move_count = 0 -- debug
	local str = "" -- debug
	local force = force or false
	--[[
	Setting the MainMenuBar as user placed is needed because in 8.0.0 because Blizzard changed something in the 
	way they controlled the frame. With Titan Panel and bottom bars enabled the MainMenuBar
	would 'bounce'. Figuring out the true root cause was a bust.
	This idea of user placed came from a Titan user who is an addon developer.
	However setting user placed causes the main menu bar to not act as we desire due to the way Blizzard coded the bar.
	For now we will try to minimize the side effects...
	
	Later Titan checks rely on the user placed flag so it needs to be set early.
	--]]
	if DoAdjust(TITAN_PANEL_PLACE_BOTTOM, force) then
		TitanMovable_MenuBar_Enable()
	end

	if not InCombatLockdown() then
		for i = 1,#MData,1 do
			if MData[i] then
				if MData[i].addonAdj then
					-- An addon has taken control of the frame so skip
				else
					local md = MData[i]
					if place == f_list[md.frameName].place or place == TITAN_PANEL_PLACE_BOTH then
						-- Adjust the frame per MData
						md.move(force)
					end
				end
			end
		end

		Titan_FCF_UpdateDockPosition(); -- chat
		UpdateContainerFrameAnchors(); -- Move bags as needed
	else
		-- nothing to do
	end
end

--[[ local
NAME: Titan_AdjustUIScale
DESC: Adjust the scale of Titan bars and plugins to the user selected scaling. This is called by the secure post hooks to the 'Video Options Frame'.
VAR:  None
OUT:  None
--]]
local function Titan_AdjustUIScale()	
	Titan_AdjustScale()
end

--[[ Titan
NAME: TitanPanel_AdjustFrames
DESC: Adjust the frames for the Titan visible bars.
This is a shell for the actual Movable routine used by other Titan routines and secure hooks
VAR:  force - Force an adjust such as when the user changes bars shown
VAR:  reason - Debug to determine where and why an adjust is requested
OUT:  None
NOTE:
:NOTE
--]]
function TitanPanel_AdjustFrames(force, reason)
	if TITAN_PANEL_VARS.debug.movable then
		TitanDebug ("_AdjustFrames :"
			.." f: "..tostring(force)
			.." r: '"..tostring(reason).."'"
			)
	end

	local f = false -- do not require the parameter
	if force == true then -- but force it to be boolean
		f = true
	else
		f = false
	end

	-- Adjust frame positions top and bottom based on user choices
	if hooks_done then
		TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_BOTH, f)
	end
end

--[[ Titan
NAME: Titan_AdjustScale
DESC: Update the bars and plugins to the user selected scale.
VAR:  None
OUT:  None
NOTE:
- Ensure Titan has done its initialization before this is run.
:NOTE
--]]
function Titan_AdjustScale()
	-- Only adjust if Titan is fully initialized
	if Titan__InitializedPEW then 
		TitanPanel_SetScale();
		
		TitanPanel_ClearAllBarTextures()
		TitanPanel_CreateBarTextures()

		for idx,v in pairs (TitanBarData) do
			TitanPanel_SetTexture(TITAN_PANEL_DISPLAY_PREFIX..TitanBarData[idx].name
				, TITAN_PANEL_PLACE_TOP);
		end

		TitanPanel_AdjustFrames(false, "_AdjustScale ")
		TitanPanel_RefreshPanelButtons();
	end
end

--[[ Titan
=============
NAME: Titan_Hook_*
DESC: Set of routines to front the adjust the frames routine.
VAR:  None
OUT:  None
NOTE:
This group of Titan_Hook_* is :
- to debug moving of frames when TitanPanel_AdjustFrames hooks trigger
- just in case there is specific processing needed per hook
- used when hooks and callbacks are needed

These may be called from any Titan Panel code
:NOTE
--]]

function Titan_Hook_Frames() -- UIParent_ManageFramePositions hook
	--[[ 
	This is the routine that will be called the most. It is the general purpose routine for WoW frames.
	As Blizzard has changed (or in some cases added) ways to handle the various bars it has across expansions,
	this routine has had to become more complex. 
	Especially to handle the main menu bar processing along with override bar which also handles 'in vehicle' bars.
	The processing is needed to sometimes handle hiding or delaying Titan bars to not interfere with the normal WoW
	bars - top or bottom.
	
	This can hide top or bottom bars to avoid conflicts visually or functionally with WoW bars.
	When a normal adjust is requested, this calls TitanPanelBarButton_DisplayBarsWanted rather than 
	TitanPanel_AdjustFrames because bars to show bars that may have been hidden in a prior invocation. It is
	a touch 'heavy' but will force bars back if hidden for any reason.
	--]]
--	TitanPanel_AdjustFrames(false, "Hook UIParent_ManageFramePositions ")
	local reason = "Hook UIParent_* - "
	--[[
	Code from ActionBarController.lua ActionBarController_UpdateAll modified for Titan
	This hook relies on _UpdateAll calling UIParent_ManageFramePositions near the end of its processing
	--]]
	-- If we have a skinned vehicle bar
	--	or skinned override bar then likely the OverrideActionBar is active
	-- If user does not want bottom bar adjust do not hide the bottom bar for vehicles.
	-- When a user is using an action bar replacement (Bartender or ElvUI), hiding the bottom bar may not make sense.
	if ((HasVehicleActionBar() and UnitVehicleSkin("player") and UnitVehicleSkin("player") ~= "")
	or (HasOverrideActionBar() and GetOverrideBarSkin() and GetOverrideBarSkin() ~= 0)) 
	then -- Override bar in place; hide Titan bottom bar(s)
		if (TitanPanelGetVar("AuxScreenAdjust") == 1) then
			-- do nothing, the user has turned off adjust
		else
			reason = reason.."skinned override bar"
			TitanPanelBarButton_HideBottomBars()
			
			-- Blizzard could have updated player frame or other
			TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_TOP, false)
		end
		
	-- If we have a non-skinned override bar of some sort, use the MainMenuBarArtFrame
	elseif ( HasBonusActionBar() or HasOverrideActionBar() or HasVehicleActionBar() or HasTempShapeshiftActionBar() or C_PetBattles.IsInBattle() ) then
		reason = reason.."non-skinned override bar"
		-- BonusActionBar is rogue in stealth
		-- TitanPanelBarButton_HideBottomBars()
	elseif ( OrderHallCommandBar and OrderHallCommandBar:IsShown() ) then
		reason = reason.."Order Hall bar"
		-- Override bar in place; hide Titan bottom bar(s)
		TitanPanelBarButton_HideAllBars()
	else
		if InCombatLockdown() or UnitVehicleSkin("player") then
			reason = reason.."waiting..."
			--[[
			wait until out of combat just in case...
			Putting back a bar (especially bottom bar) in combat could cause the 
			main menu bar to not work as expected.
			--]]
		else
			reason = reason.."Adjust"
			-- Overkill but bottom bars could have been hidden
			TitanPanelBarButton_DisplayBarsWanted("Hook _Frames*")
		end
	end

	if TITAN_PANEL_VARS.debug.movable then
		TitanDebug (tostring(reason)
		.." c: "..tostring(InCombatLockdown())
		.." b1: "..tostring(TitanPanelGetVar("AuxBar_Show"))
		.." b2: "..tostring(TitanPanelGetVar("AuxBar2_Show"))
		.." vb+: "..tostring((HasVehicleActionBar() and UnitVehicleSkin("player") and UnitVehicleSkin("player") ~= "") and true or false)
		.." ob+: "..tostring((HasOverrideActionBar() and GetOverrideBarSkin() and GetOverrideBarSkin() ~= 0) and true or false)
		.." bb: "..tostring(HasBonusActionBar())
		.." ob: "..tostring(HasOverrideActionBar())
		.." sb: "..tostring(HasTempShapeshiftActionBar())
		.." pb: "..tostring(C_PetBattles.IsInBattle())
		)
	end
end

function Titan_Hook_Ticket_Show()
	TitanPanel_AdjustFrames(false, "Hook TicketStatusFrame Show ")
end

function Titan_Hook_Ticket_Hide()
	TitanPanel_AdjustFrames(false, "Hook TicketStatusFrame Hide ")
end

function Titan_Hook_Target()
	TitanPanel_AdjustFrames(false, "Hook TargetFrame_Update ")
end

function Titan_Hook_Map()
	TitanPanel_AdjustFrames(false, "Hook WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton ")
end

function Titan_Hook_PEW()
	TitanPanel_AdjustFrames(false, "Hook PEW Config timer")
end

function Titan_Hook_SpecSwitch()
	TitanPanel_AdjustFrames(false, "Hook SpecSwitch Config timer ")
end

function Titan_Hook_MoveAdj() -- in config but not used
	TitanPanel_AdjustFrames(false, "Hook MoveAdj Config timer ")
end

function Titan_Hook_Vehicle() -- in config but not used
	TitanPanel_AdjustFrames(false, "Hook Vehicle Config timer ")
end

-- =============

--[[ Titan
NAME: TitanMovable_SecureFrames
DESC: Once Titan is initialized create the post hooks we need to help adjust frames properly.
VAR:  None
OUT:  None
NOTE:
- The secure post hooks are required because Blizz adjusts frames Titan is interested in at times other than the events Titan registers for.
- This used to be inline code but was moved to a routine to avoid errors as Titan loaded.
:NOTE
--]]
function TitanMovable_SecureFrames()
	if not TitanPanelAce:IsHooked("FCF_UpdateDockPosition", Titan_FCF_UpdateDockPosition) then
		TitanPanelAce:SecureHook("FCF_UpdateDockPosition", Titan_FCF_UpdateDockPosition) -- FloatingChatFrame
	end
	if not TitanPanelAce:IsHooked("UIParent_ManageFramePositions", Titan_Hook_Frames) then
		TitanPanelAce:SecureHook("UIParent_ManageFramePositions", Titan_Hook_Frames) -- UIParent.lua
		TitanPanel_AdjustFrames(true, "Hook First UIParent_ManageFramePositions")
	end

	if not TitanPanelAce:IsHooked(TicketStatusFrame, "Show", Titan_Hook_Ticket_Show) then
		TitanPanelAce:SecureHook(TicketStatusFrame, "Show", Titan_Hook_Ticket_Show) -- HelpFrame.xml
		TitanPanelAce:SecureHook(TicketStatusFrame, "Hide", Titan_Hook_Ticket_Hide) -- HelpFrame.xml
		TitanPanelAce:SecureHook("TargetFrame_Update", Titan_Hook_Target) -- TargetFrame.lua
		TitanPanelAce:SecureHook("UpdateContainerFrameAnchors", Titan_ContainerFrames_Relocate) -- ContainerFrame.lua
		TitanPanelAce:SecureHook(WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton, "Show", Titan_Hook_Map) -- WorldMapFrame.lua

--		TitanPanelAce:SecureHook("OrderHall_CheckCommandBar", Titan_Hook_OrderHall)
	end

	if not TitanPanelAce:IsHooked("VideoOptionsFrameOkay_OnClick", Titan_AdjustUIScale) then
		--[[
		Properly Adjust UI Scale if set
		Note: These are the least intrusive hooks we could think of, to properly adjust the Titan Bar(s)
		without having to resort to a SetCvar secure hook. Any addon using SetCvar should make sure to use the 3rd
		argument in the API call and trigger the CVAR_UPDATE event with an appropriate argument so that other addons
		can detect this behavior and fire their own functions (where applicable).
		--]]
		TitanPanelAce:SecureHook("VideoOptionsFrameOkay_OnClick", Titan_AdjustUIScale) -- VideoOptionsFrame.lua
		TitanPanelAce:SecureHook(VideoOptionsFrame, "Hide", Titan_AdjustUIScale) -- VideoOptionsFrame.xml
	end
	
	-- Check for other addons that control UI frames. Tell Titan to back off of the frames these addons could control
	CheckConflicts()
	
	hooks_done = true
end

--[[
	TitanDebug ("MoveFrame :"
		.." "..tostring(frame:GetName())
		.." point:"..tostring(point)
		.." relativeTo:"..tostring(relativeTo:GetName())
		.." relativePoint:"..tostring(relativePoint)
		.." xOfs:"..tostring(xOfs)
		.." y:"..tostring(y)
		.." adj:"..tostring(DoAdjust(top_bottom, force))
		.." tb:"..tostring(top_bottom)
		.." f:"..tostring(force)
		)
	end
--]]