local _, PD = ...;
local FramePlusfun=PD.FramePlusfun
-----------------------------------
function FramePlusfun.Tracking()
	if PIG_MaxTocversion(20000,true) then return end
	if not PIGA["FramePlus"]["Tracking"] then return end
	if FramePlusfun.TrackingOpen then return end
	FramePlusfun.TrackingOpen=true
	local Create=PD.Create
	local PIGDownMenu=Create.PIGDownMenu
	local Fun = PD.Fun
	local IsElvUI=Fun.IsElvUI
	local IsNDui=Fun.IsNDui
	
	local fujiFrame = MiniMapTracking or MiniMapTrackingFrame
	fujiFrame:SetScale(0.82)
	local WidthH = fujiFrame:GetWidth()
	local IconWidthH = MiniMapTrackingIcon:GetWidth()
	fujiFrame:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 8,-56);
	fujiFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	fujiFrame:RegisterEvent("MINIMAP_UPDATE_TRACKING");
	fujiFrame:HookScript("OnEvent", function(self,event,...)
		fujiFrame:Show();
		local icon = GetTrackingTexture();
		if ( icon ) then
			MiniMapTrackingIcon:SetTexture(icon);
			MiniMapTrackingIcon:Show();
			if IsElvUI() or IsNDui() then

			else
				if fujiFrame.search then fujiFrame.search:Hide() end
			end
		else
			MiniMapTrackingIcon:Hide();
			if IsElvUI() or IsNDui() then

			else
				if not fujiFrame.search then
					fujiFrame.search = fujiFrame:CreateTexture(nil, "BORDER");
					fujiFrame.search:SetAtlas("None")
					fujiFrame.search:SetSize(IconWidthH,IconWidthH);
					fujiFrame.search:SetPoint("CENTER",fujiFrame,"CENTER",2,-2);
				end
				fujiFrame.search:Show()
			end
		end
	end)
	---
	local spells ={2383,2580}
	local _, classId = UnitClassBase("player");
	if classId==3 then
		local class3spells ={1494,19883,19884,19885,19880,19878,19882,19879}
		for i=1,#class3spells do
			table.insert(spells,class3spells[i])
		end
	elseif classId==2 then
		table.insert(spells,5502)
	elseif classId==9 then
		table.insert(spells,5500)
	elseif classId==11 then
		table.insert(spells,5225)
	end
	local raceName, raceFile, raceID = UnitRace("player")
	if raceID==3 then
		table.insert(spells,2481)
	end
	local xiala=PIGDownMenu(fujiFrame,{"TOPLEFT",fujiFrame, "CENTER", -80,-10},nil,"EasyMenu")
	xiala:SetAllPoints()
	xiala.Button:SetHighlightTexture(136477);
	local HighlightTex=xiala.Button:GetHighlightTexture()
	HighlightTex:SetPoint("TOPLEFT",xiala.Button,"TOPLEFT",2,-2);
	HighlightTex:SetPoint("BOTTOMRIGHT",xiala.Button,"BOTTOMRIGHT",4,-4);
	xiala.Button:HookScript("OnClick", function(self, button)
		if button=="RightButton" then
			CancelTrackingBuff();
		end
	end)
	function xiala:PIGDownMenu_Update_But(level, menuList)
		local info = {}
		local Bufficon = GetTrackingTexture()
		for i=1,#spells,1 do
			local spellName = PIGGetSpellInfo(spells[i])
		    info.text, info.arg1 = spellName, spells[i]
		    info.icon = GetSpellTexture(spells[i])
		    info.checked = Bufficon==info.icon
		    if IsPlayerSpell(spells[i]) then
		    	info.enabled=nil
				info.func = function()
					CastSpellByID(spells[i])
					PIGCloseDropDownMenus()
				end
			else
				info.func=nil
				info.enabled=true
			end
			self:PIGDownMenu_AddButton(info)
		end 
	end
end