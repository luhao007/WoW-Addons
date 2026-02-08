 -----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSWaypoints = private.NewLib("RareScannerWaypoints")

-- RareScanner database libraries
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner general libraries
local RSUtils = private.ImportLib("RareScannerUtils")

---============================================================================
-- Ingame waypoints
---============================================================================

local function AddWaypoint(mapID, x, y)
	if (mapID and mapID ~= "" and x and y) then
		local fixedX = RSUtils.FixCoord(x)
		local fixedY = RSUtils.FixCoord(y)
		
		if (fixedX and fixedY) then
			C_Map.ClearUserWaypoint();
			C_SuperTrack.SetSuperTrackedUserWaypoint(false);
			
			C_Timer.After(0.5, function()
				local uiMapPoint = UiMapPoint.CreateFromCoordinates(mapID, fixedX, fixedY);
				if (uiMapPoint) then
					C_Map.SetUserWaypoint(uiMapPoint);
					C_SuperTrack.SetSuperTrackedUserWaypoint(true);
				end
			end)
		end
	end
end

function RSWaypoints.AddWorldMapWaypoint(mapID, x, y)
	if (not RSConfigDB.IsAddingWorldMapIngameWaypoints()) then
		return
	end
	
	AddWaypoint(mapID, x, y)
end

function RSWaypoints.AddWaypoint(mapID, x, y)
	if (not RSConfigDB.IsWaypointsSupportEnabled()) then
		return
	end
	
	AddWaypoint(mapID, x, y)
end

function RSWaypoints.AddAutomaticWaypoint(mapID, x, y, manuallyFired)
	if (not manuallyFired and not RSConfigDB.IsAddingWaypointsAutomatically()) then
		return
	end

	AddWaypoint(mapID, x, y)
end