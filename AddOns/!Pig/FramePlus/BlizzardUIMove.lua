local _, addonTable = ...;
local Create=addonTable.Create
local PIGFontString=Create.PIGFontString
local Fun=addonTable.Fun
local FramePlusfun=addonTable.FramePlusfun
--------
local hookedFrames = {}
local FramesCombatLock = {}
local function PIG_SetPoint(UIname,MovingUI)
	if not UIname or not MovingUI or not PIGA["Blizzard_UI"][UIname] then return end
	local uixy=PIGA["Blizzard_UI"][UIname]["Point"]
	if uixy and uixy[1] and uixy[2] and uixy[3] and uixy[4] and not uixy[5] then
		local point, relativePoint, offsetX, offsetY=unpack(uixy)
		MovingUI:ClearAllPoints();
		MovingUI:SetPoint(point or "CENTER", UIParent, relativePoint or "CENTER", offsetX or 0, offsetY or 0);
		hookedFrames[UIname] = true
	else
		PIGA["Blizzard_UI"][UIname]["Point"]=nil
		hookedFrames[UIname] = nil
	end
end
local function PIG_SetPointSpecial(UIname,MovingUI)
	if UIname=="WorldMapFrame" then
		hooksecurefunc(WorldMapFrame, "OnFrameSizeChanged", function(self)
			if PIGA["Blizzard_UI"]["WorldMapFrame"] and PIGA["Blizzard_UI"]["WorldMapFrame"]["Point"] then
				PIG_SetPoint(UIname,MovingUI)
			end
		end)
	elseif UIname=="PlayerSpellsFrame" then
		--PlayerSpellsFrame:SetIgnoreParentScale(false)
	end
end
local function PIG_SetScale(UIname,MovingUI)
	if not UIname or not MovingUI then return end
	if not PIGA["Blizzard_UI"][UIname] then return end
	local ScaleV=PIGA["Blizzard_UI"][UIname]["Scale"]
	if ScaleV and ScaleV~=1 then
		MovingUI:SetScale(ScaleV);
	end
end
local function funxx(UIname,MovingUI)
	MovingUI:EnableMouse(true)
	MovingUI:SetMovable(true)
	MovingUI:SetClampedToScreen(true)
	PIG_SetScale(UIname,MovingUI)
	if PIGA["FramePlus"]["BlizzardUI_Move_Save"] then
		MovingUI.ignoreFramePositionManager = true;
		MovingUI:SetAttribute("ignoreFramePositionManager", true);
		PIG_SetPoint(UIname,MovingUI)
		PIG_SetPointSpecial(UIname,MovingUI)
   	end
end
local function MovingFun_1(protection,UIname,ClickF,MovingUI)
	ClickF:RegisterForDrag("LeftButton")
    ClickF:HookScript("OnDragStart",function()
    	if protection and InCombatLockdown() then 
			PIG_OptionsUI:ErrorMsg("战斗中无法移动")
			return
		end
        MovingUI:StartMoving();
    end)
    ClickF:HookScript("OnDragStop",function()
    	if protection and InCombatLockdown() then 
			PIG_OptionsUI:ErrorMsg("战斗中无法移动")
			return
		end
        MovingUI:StopMovingOrSizing()
        if PIGA["FramePlus"]["BlizzardUI_Move_Save"] then
        	PIGA["Blizzard_UI"][UIname]=PIGA["Blizzard_UI"][UIname] or {}
        	local point, relativeTo, relativePoint, offsetX, offsetY = MovingUI:GetPoint()
			if point and relativePoint and offsetX and offsetY then
				local offsetX = floor(offsetX*100+0.5)*0.01
				local offsetY = floor(offsetY*100+0.5)*0.01
				PIGA["Blizzard_UI"][UIname]["Point"]={point, relativePoint, offsetX, offsetY}
				PIG_SetPoint(UIname,MovingUI)
			end
       	end
    end)
	if protection and InCombatLockdown() then
		MovingUI:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		funxx(UIname,MovingUI)
	end
	MovingUI:HookScript("OnEvent", function(self, event)
		if event=="PLAYER_REGEN_ENABLED" then
			funxx(UIname,self)
		end
	end)
end
local function add_Movebiaoti(oldbiaoti)
	local Movebiaoti = CreateFrame("Frame", nil, oldbiaoti);
	Movebiaoti:SetPoint("TOPLEFT",oldbiaoti,"TOPLEFT",0,0);
	Movebiaoti:SetPoint("BOTTOMRIGHT",oldbiaoti,"BOTTOMRIGHT",0,0);
	Movebiaoti:EnableMouse(true)
	return Movebiaoti
end
local function MovingFun(protection,UIname,ClickFname)
	if PIGA["FramePlus"]["BlizzardUI_Not"][UIname] then return end
	local MovingUI=_G[UIname]
	if MovingUI then
		if ClickFname then
			if type(ClickFname)=="table" then
				local uixxF=_G[ClickFname[1]]
				if uixxF then
					local uixxFxx=uixxF[ClickFname[2]]
					if uixxFxx then
						if UIname=="ContainerFrameCombinedBags" then		
							MovingFun_1(protection,UIname,add_Movebiaoti(uixxFxx),MovingUI)
						else
							MovingFun_1(protection,UIname,uixxFxx,MovingUI)
						end
					else
						MovingFun_1(protection,UIname,uixxF,MovingUI)
					end
				end
			else
				local ClickF=_G[ClickFname]
				if ClickF then
					MovingFun_1(protection,UIname,ClickF,MovingUI)
				end
			end
		else
			if UIname=="CollectionsJournal" then
        		if WardrobeTransmogFrame then
            		local checkBox = _G.WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox;
				    local label = checkBox.Label;
				    label:ClearAllPoints();
				    label:SetPoint('LEFT', checkBox, 'RIGHT', 2, 1);
				    label:SetPoint('RIGHT', checkBox, 'RIGHT', 160, 1);
				end
			end
			MovingFun_1(protection,UIname,MovingUI,MovingUI)
		end
	end
end
local function MovingFunEvent(protection,event,UIname,ClickFname)
	Fun.IsAddOnLoaded(event,function()
		MovingFun(protection,UIname,ClickFname)
	end)
end
function FramePlusfun.BlizzardUI_Move()
	if not PIGA['FramePlus']['BlizzardUI_Move'] then return end
	local BlizzardUIList=FramePlusfun.BlizzardUIList
	for i=1,#BlizzardUIList do
		local protection,event,ui,tuoui,uiname=unpack(BlizzardUIList[i])
		FramesCombatLock[ui]=protection
		if event then
			MovingFunEvent(protection,event,ui,tuoui)
		else
			MovingFun(protection,ui,tuoui)
		end
	end
	if PIGA["FramePlus"]["BlizzardUI_Move_Save"] then
	    -- hooksecurefunc("ShowUIPanel", function(frame)
	    --     if not frame or not frame.GetName then return end
	    --     local uiName = frame:GetName()
	    --     if uiName and hookedFrames[uiName] then
	    --     	if FramesCombatLock[uiName] and InCombatLockdown() then return end
	    --         PIG_SetPoint(uiName, frame)
	    --     end
	    -- end)
		local oldOpenFrame={}
		hooksecurefunc("UpdateUIPanelPositions", function(frame)
			if frame then
				if not frame.GetName then return end
	            local uiName = frame:GetName()
	            if uiName and hookedFrames[uiName] then
	            	oldOpenFrame[uiName]=true
	            	if FramesCombatLock[uiName] and InCombatLockdown() then return end
	            	PIG_SetPoint(uiName, frame)
	            	for olduiname,_ in pairs(oldOpenFrame) do
	            		if olduiname~=uiName then
		            		if _G[olduiname] and _G[olduiname]:IsShown() then
		            			if FramesCombatLock[olduiname] and InCombatLockdown() then return end
		            			PIG_SetPoint(olduiname, _G[olduiname])
		            		end
		            	end
	            	end
	            end
	        else
				for olduiname,_ in pairs(oldOpenFrame) do
            		if _G[olduiname] and _G[olduiname]:IsShown() then
            			if FramesCombatLock[olduiname] and InCombatLockdown() then return end
            			PIG_SetPoint(olduiname, _G[olduiname])
            		end
	        	end		
	        end
		end)
	end
end