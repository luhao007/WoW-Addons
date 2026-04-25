local _, PD = ...;
-------------
local FramePlusfun=PD.FramePlusfun
function FramePlusfun.PetStable()
	if PIG_MaxTocversion(50000) then return end
	if not PIGA["FramePlus"]["PetStable"] then return end
	if FramePlusfun.PetStableOK then return end
	FramePlusfun.PetStableOK=true
	local Fun=PD.Fun
	local function UpdateFrame()	
		local WWW = PetStableFrame:GetWidth()
		local HHH = PetStableFrame:GetHeight()
		local NewWWW = WWW*2
		print(NewWWW)
		PetStablePrevPageButton:ClearAllPoints()
		PetStableNextPageButton:ClearAllPoints()
		PetStableCurrentPage:ClearAllPoints()
		PetStableFrame:SetWidth(NewWWW);
		PetStableFrame:SetHeight(HHH*1.38);
		PetStableFrameInset:SetWidth(NewWWW);
		PetStablePetInfo:ClearAllPoints();
		PetStableModelScene:ClearAllPoints();
		
		local NUMALL=NUM_PET_STABLE_PAGES*NUM_PET_STABLE_SLOTS
		for i=1,NUMALL do
			local ButtonUI=_G["PetStableStabledPet"..i]
			if ButtonUI then
				ButtonUI:ClearAllPoints();
				if i==1 then
					ButtonUI:SetPoint("TOPLEFT",PetStableFrame,"TOPLEFT",120,-36);
				end
			else
				ButtonUI = CreateFrame("Button","PetStableStabledPet"..i,PetStableFrame, "PetStableSlotTemplate",i);
			end
			ButtonUI:SetScale(0.8)
			if i>1 then
				local newhang = (i > 12) and ((i - 1) % 12 == 0)
				if newhang then
					ButtonUI:SetPoint("TOPLEFT",_G["PetStableStabledPet"..(i-12)],"BOTTOMLEFT",0,-5);
				else
					ButtonUI:SetPoint("LEFT", _G["PetStableStabledPet"..(i-1)],"RIGHT",5,0);
				end
			end
		end

		-- if Fun.IsElvUI() then
		-- 	C_Timer.After(0.1,function()
		-- 		MacroFrame:SetWidth(NewWWW);
		-- 	end)
		-- end
		-- local NewHHH = HHH*1.63
		-- MacroFrame:SetHeight(NewHHH);
		
		-- hooksecurefunc(MacroPopupFrame, "OkayButton_OnClick", function(self)
		-- 	if InCombatLockdown() then return end
		-- 	local macroFrame = self:GetMacroFrame();
		-- 	local NewName= self.BorderBox.IconSelectorEditBox:GetText();
		-- 	C_Timer.After(0.02,function()
		-- 		local macroSlotIndex=0
		-- 		local AccMacros, CharMacros = GetNumMacros();
		-- 		local SelectedTab = PanelTemplates_GetSelectedTab(MacroFrame)
		-- 		if SelectedTab==1 then
		-- 			for Index=1,MAX_ACCOUNT_MACROS do
		-- 				local Name, Icon, Body = GetMacroInfo(Index);
		-- 				if Name then
		-- 					if NewName == Name and Body =="" then
		-- 						macroSlotIndex=Index
		-- 						break
		-- 					end
		-- 				end
		-- 			end
		-- 		else
		-- 			for Index=MAX_ACCOUNT_MACROS+1,MAX_ACCOUNT_MACROS+CharMacros do
		-- 				local Name, Icon, Body = GetMacroInfo(Index);
		-- 				if Name then
		-- 					if NewName == Name and Body =="" then
		-- 						macroSlotIndex=Index-MAX_ACCOUNT_MACROS
		-- 						break
		-- 					end
		-- 				end
		-- 			end
		-- 		end
		-- 		if macroSlotIndex>0 then
		-- 			macroFrame:SelectMacro(macroSlotIndex);
		-- 			macroFrame:Update(retainScrollPosition);
		-- 		end
		-- 	end)			
		-- end)
	end
    --UpdateFrame()
end