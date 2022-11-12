--[[ File
NAME: TitanMovable.lua
DESC: Contains the routines to adjust the Blizzard frames to make room for the Titan bars the user has selected.

DragonFlight introduced an Edit Mode for the user to move various frames where they want them.
However two UI elements were not included: 
- XP / Status bar (with the reputation bar above)
- menu & bag buttons

This greatly chanegd the work Titan needed to do.
Now Titan only needs to allow the user to manually adjust the two UI elements themselves.

:DESC

NOTE: 
- All secure hooks were removed from Movable.
- All timers were removed from Movable.
:NOTE

--]]
-- Globals

-- Locals
local _G = getfenv(0);
local InCombatLockdown = _G.InCombatLockdown;
local hooks_done = false;

local move_count = 0

local function Titan_AdjustFrame(frame_str, flag, offset)	
	local frame = _G[frame_str]
	local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
	if point and relativeTo and relativePoint and xOfs then
		-- Check if user has requested... We can get here via player entering world
		if TitanPanelGetVar(flag) then
			frame:ClearAllPoints()
			frame:SetPoint(point, relativeTo:GetName(), relativePoint, xOfs, TitanPanelGetVar(offset))
			op = "move - y "..tostring(y)
		else
			-- User has not reqeuested Titan do anything.
			op = "skip - User has not asked Titan to move XP / Status bar"
		end
	else
		op = "skip - :GetPoint invalid"
		-- do not proceed
	end
end

--[[ API
NAME: TitanMovable_GetPanelYOffset
DESC: Get the Y axis offset Titan needs (1 or 2 bars) at the given position - top or bottom.
VAR: framePosition - TITAN_PANEL_PLACE_TOP or TITAN_PANEL_PLACE_BOTTOM
OUT: Y axis offset, in pixels
NOTE:
- As of DragonFlight this may not be as useful. Leaving to not break any addons.

- The preferred method to determine the Y offset needed to use TitanUtils_GetBarAnchors()
which provides anchors (frames) for an addon to use.
:NOTE
--]]
function TitanMovable_GetPanelYOffset(framePosition) -- used by other addons
	-- Both top & bottom are figured out but only the
	-- requested position is returned
	local barnum_top = 0
	local barnum_bot = 0
	-- If user has the top set then determine the top offset
	if TitanPanelGetVar("Bar_Show") then
		barnum_top = 1
	end
	if TitanPanelGetVar("Bar2_Show") then
		barnum_top = 2
	end
	-- If user has the bottom set then determine the bottom offset
	if TitanPanelGetVar("AuxBar_Show") then
		barnum_bot = 1
	end
	if TitanPanelGetVar("AuxBar2_Show") then
		barnum_bot = 2
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

-- =============
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

-- DF Titan no longer react to hooks to move frames
	-- Adjust frame positions top and bottom based on user choices
			Titan_AdjustFrame("MicroButtonAndBagsBar", "MenuAndBagVerticalAdjOn", "MenuAndBagVerticalAdj")
			Titan_AdjustFrame("StatusTrackingBarManager", "XPBarVerticalAdjOn", "XPBarVerticalAdj")

--[[
	if hooks_done then
		if reason == "Init: PEW (Player Entering World)"
		or reason == "MenuAndBagVerticalAdj" then 
			Titan_AdjustFrame("MicroButtonAndBagsBar", "MenuAndBagVerticalAdjOn", "MenuAndBagVerticalAdj")
		end
		if reason == "Init: PEW (Player Entering World)"
		or reason == "XPBarVerticalAdj" then 
			Titan_AdjustFrame("StatusTrackingBarManager", "XPBarVerticalAdjOn", "XPBarVerticalAdj")
		end
	end
--]]
end

--[[ Titan
NAME: TitanMovable_SecureFrames
DESC: Once Titan is initialized get info we need to help adjust frames properly.
VAR:  None
OUT:  None
--]]
function TitanMovable_SecureFrames()

	-- Save the original Y offest for the few frames the user may want to adjust via Titan
	local point, relativeTo, relativePoint, xOfs, yOfs, frame

---[=[	
	frame = _G["MicroButtonAndBagsBar"]
	point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
	frame.original_y = yOfs
--]=]

---[=[
	frame = _G["StatusTrackingBarManager"]
	point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
	frame.original_y = yOfs
--]=]

	hooks_done = true

	-- On start, adjust according to the user settings
	TitanPanel_AdjustFrames(true, "Init: PEW (Player Entering World)")
	
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