local _, PD = ...;
-------------
local FramePlusfun=PD.FramePlusfun
function FramePlusfun.PetStable()
	if PIG_MaxTocversion(50000) or PIG_MaxTocversion(59999,true) then return end
	if not PIGA["FramePlus"]["PetStable"] then return end
	if FramePlusfun.PetStableOK then return end
	FramePlusfun.PetStableOK=true
	local Fun=PD.Fun
	local function UpdateFrame()	
		local WWW = PetStableFrame:GetWidth()
		local HHH = PetStableFrame:GetHeight()
		PetStablePrevPageButton:ClearAllPoints()
		PetStableNextPageButton:ClearAllPoints()
		PetStableCurrentPage:ClearAllPoints()
		PetStableFrame:SetWidth(WWW*1.90);
		PetStableFrame:SetHeight(HHH*1.322);
		PetStableFrameStableBg:ClearAllPoints();
		PetStableFrameInset:SetPoint("BOTTOMRIGHT",PetStableFrame,"BOTTOMRIGHT",-6,6)
		PetStableFrameModelBg:SetSize(325,286);
		local NUMALL,HANGnum,HANGnum2=NUM_PET_STABLE_PAGES*NUM_PET_STABLE_SLOTS,10,19
		local function PetButtons(btn)
			local E= unpack(ElvUI)
			local p = E.PixelMode and 1 or 2
			local button = _G[btn]
			local icon = _G[btn..'IconTexture']
			local highlight = button:GetHighlightTexture()
			button:StripTextures()

			if button.Checked then
				button.Checked:SetColorTexture(unpack(E.media.rgbvaluecolor))
				button.Checked:SetAllPoints(icon)
				button.Checked:SetAlpha(0.3)
			end

			if highlight then
				highlight:SetColorTexture(1, 1, 1, 0.3)
				highlight:SetAllPoints(icon)
			end

			if icon then
				icon:SetTexCoords()
				icon:ClearAllPoints()
				icon:Point('TOPLEFT', p, -p)
				icon:Point('BOTTOMRIGHT', -p, p)

				button:OffsetFrameLevel(2)
				button:SetTemplate(nil, true)
			end
		end
		for i=1,NUMALL do
			local ButtonUI=_G["PetStableStabledPet"..i]
			if ButtonUI then
				ButtonUI:ClearAllPoints();
				if i==1 then
					ButtonUI:SetPoint("TOPLEFT",PetStableFrame,"TOPLEFT",492,-36);
				end
			else
				ButtonUI = CreateFrame("Button","PetStableStabledPet"..i,PetStableFrame, "PetStableSlotTemplate",i);
			end
			if i>10 then
				local petSlot = PetStable_GetPetSlot(i, true);
				ButtonUI.petSlot=petSlot
				if Fun.IsElvUI() then
					PetButtons("PetStableStabledPet"..i)
				elseif Fun.IsNDui() then
					local B, C, L, DB = unpack(NDui)
					local x1, x2, y1, y2 = unpack(DB.TexCoord)
					local bu = _G["PetStableStabledPet"..i]
					bu:SetNormalTexture(0)
					bu:SetPushedTexture(0)
					bu.Checked:SetTexture(DB.pushedTex)
					bu:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)
					bu:DisableDrawLayer("BACKGROUND")
					_G["PetStableStabledPet"..i.."IconTexture"]:SetTexCoord(x1, x2, y1, y2)
					B.CreateBDFrame(bu, .25)
				end
			end
			ButtonUI:SetScale(0.86)
			if i>1 then
				if i<81 then
					local newhang = (i > HANGnum) and ((i - 1) % HANGnum == 0)
					if newhang then
						ButtonUI:SetPoint("TOPLEFT",_G["PetStableStabledPet"..(i-HANGnum)],"BOTTOMLEFT",0,-5);
					else
						ButtonUI:SetPoint("LEFT", _G["PetStableStabledPet"..(i-1)],"RIGHT",5,0);
					end
				else
					if i==81 then
						ButtonUI:SetPoint("TOPLEFT",PetStableFrame,"TOPLEFT",114,-372);
					else
						local newhang = (i > HANGnum2) and ((i - 1-80) % HANGnum2 == 0)
						if newhang then
							ButtonUI:SetPoint("TOPLEFT",_G["PetStableStabledPet"..(i-HANGnum2)],"BOTTOMLEFT",0,-5);
						else
							ButtonUI:SetPoint("LEFT", _G["PetStableStabledPet"..(i-1)],"RIGHT",5,0);
						end
					end
				end
			end
		end
		hooksecurefunc("PetStable_Update", function(updateModel)
			for i=1,NUMALL do
				local button = _G["PetStableStabledPet"..i];
				local petSlot = PetStable_GetPetSlot(i, false);
				PetStable_UpdateSlot(button, petSlot);
			end
		end)
	end
    UpdateFrame()
end