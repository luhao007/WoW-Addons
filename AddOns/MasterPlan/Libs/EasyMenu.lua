local _, T = ...

local onBrokenListOpen do
	local HOOK_LEVEL, OPEN_DROPDOWN_LIST_OWNER = 1
	local function SubList_OnShow(list)
		local uipScale = OPEN_DROPDOWN_LIST_OWNER == UIDROPDOWNMENU_OPEN_MENU and UIParent:GetScale()
		if uipScale and (list:GetScale()-uipScale)^2 > 1e-9 then
			-- This *should* happen right in the middle of ToggleDropDownMenu, before it tries
			-- to check whether the menu is off-screen and adjusts anchors.
			list:SetScale(uipScale)
		end
	end
	function onBrokenListOpen(owner)
		OPEN_DROPDOWN_LIST_OWNER = owner
		while HOOK_LEVEL < UIDROPDOWNMENU_MAXLEVELS do
			local list = _G["DropDownList" .. HOOK_LEVEL + 1]
			if not list then break end
			list:HookScript("OnShow", SubList_OnShow)
			HOOK_LEVEL = HOOK_LEVEL + 1
		end
	end
end
function T.UIDropDownMenu_FixScale(self, anchor, ox, oy)
	local uipScale, list = DropDownList1:IsShown() and UIParent:GetScale(), DropDownList1
	if uipScale and (DropDownList1:GetScale() - uipScale)^2 > 1e-9 then
		-- BUG: If uiScale < UIParent:GetScale(), UIDD overcompensates while clamping list to screen
		DropDownList1:SetScale(uipScale)
		if anchor ~= "cursor" then
			local point, relativePoint, relativeTo = self.point or "TOPLEFT", self.relativePoint or "BOTTOMLEFT", self.relativeTo or self
			DropDownList1:ClearAllPoints()
			DropDownList1:SetPoint(point, relativeTo, relativePoint, ox, oy)
			local l, b, w, h = DropDownList1:GetScaledRect()
			local r, t = GetScreenWidth()*uipScale - l - w, GetScreenHeight()*uipScale - b - h
			if l < 0 then
				ox = ox - l/uipScale
			elseif r < 0 then
				ox = ox + r/uipScale
			end
			if b < 0 then
				oy = oy - b/uipScale
			elseif t < 0 then
				oy = oy + t/uipScale
			end
			DropDownList1:SetPoint(point, relativeTo, relativePoint, ox, oy)
		end
		onBrokenListOpen(self)
	end
end
local function EasyMenu_Initialize(_, level, menuList)
	for i=1, #menuList do
		local value = menuList[i]
		if value.text then
			value.index = i
			UIDropDownMenu_AddButton(value, level)
		elseif value.separator then
			UIDropDownMenu_AddSeparator(level)
		end
	end
end
function T.EasyMenu(menuList, menuFrame, anchor, x, y, displayMode, autoHideDelay)
	if displayMode == "MENU" then
		menuFrame.displayMode = displayMode
	end
	UIDropDownMenu_Initialize(menuFrame, EasyMenu_Initialize, displayMode, nil, menuList)
	ToggleDropDownMenu(1, nil, menuFrame, anchor, x, y, menuList, nil, autoHideDelay)
	T.UIDropDownMenu_FixScale(menuFrame, anchor, x, y)
end