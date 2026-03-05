local addonName, addonTable = ...;

local Create=addonTable.Create
local PIGFontString=Create.PIGFontString
--
local Fun=addonTable.Fun
local _GetTooltipLevel=Fun._GetTooltipLevel
--创建元素-染色/装等
function Fun.CZ_ItemButtonZLVranse(framef)
	if framef.ZLV then framef.ZLV:SetText("") end
	if framef.ranse then framef.ranse:Hide() end
end
function Fun.Update_ItemButtonZLVranse(ly,framef,data1,data2)
	if PIGA["FramePlus"]["Character_ItemLevel"] then
		if not framef.ZLV then
			framef.ZLV = PIGFontString(framef,{"TOPLEFT", framef, "TOPLEFT", -1, 0.4},nil,"THICKOUTLINE",14)
			framef.ZLV:SetDrawLayer("OVERLAY", 7)
			framef.ZLV:SetTextColor(0, 1, 1, 1);
		end
		framef.ZLV:SetText("");
		if ly=="C" then
			local itemLink = GetInventoryItemLink(data1, data2)
			if itemLink then
				_GetTooltipLevel(data1,{data2},function(ItemLevel)
					framef.ZLV:SetText(ItemLevel)
					local Newquality = GetInventoryItemQuality(data1, data2)
					local r, g, b = GetItemQualityColor(Newquality);
		    		framef.ZLV:SetTextColor(r, g, b);
				end)
				
			end
		elseif ly=="B" then
			local itemID, itemLink, icon, stackCount, quality=PIGGetContainerItemInfo(data1,data2)
			if itemLink then
				Newquality=quality
				local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subClassID = GetItemInfoInstant(itemLink)
				if classID==2 or classID==4 then
					_GetTooltipLevel("bag",{data1,data2},function(ItemLevel)
						framef.ZLV:SetText(ItemLevel);
						local r, g, b = GetItemQualityColor(quality);
						framef.ZLV:SetTextColor(r, g, b);
					end)
				end
			end
		elseif ly=="L" then
			if data1 then
				local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subClassID = GetItemInfoInstant(data1)
				if classID==2 or classID==4 then
					_GetTooltipLevel("link",{data1},function(ItemLevel)
						framef.ZLV:SetText(ItemLevel);
						local r, g, b = GetItemQualityColor(data2);
						framef.ZLV:SetTextColor(r, g, b);
					end)
				end
			end
		end
	end
	if PIGA["FramePlus"]["Character_ItemColor"] then
		if not framef.ranse then
			local Width123=framef:GetWidth()
			framef.ranse = framef:CreateTexture(nil, "OVERLAY");
		    framef.ranse:SetTexture("Interface/Buttons/UI-ActionButton-Border");
		    framef.ranse:SetBlendMode("ADD");
		    framef.ranse:SetPoint("TOPLEFT", framef, "TOPLEFT", -Width123*0.4, Width123*0.4);
		    framef.ranse:SetPoint("BOTTOMRIGHT", framef, "BOTTOMRIGHT", Width123*0.4, -Width123*0.4);
		    framef.ranse:Hide()
		end
		framef.ranse:Hide()
		local Newquality
		if ly=="C" then
			Newquality = GetInventoryItemQuality(data1, data2)
		elseif ly=="B" then
			local itemID, itemLink, icon, stackCount, quality=PIGGetContainerItemInfo(data1, data2)
			Newquality=quality
		elseif ly=="L" then
			Newquality=data2
		end
	    if Newquality and Newquality>1 then
	        local r, g, b = GetItemQualityColor(Newquality);
	        framef.ranse:SetVertexColor(r, g, b);
			framef.ranse:Show()
		end
	end
end
