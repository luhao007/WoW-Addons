local addonName, addonTable = ...;

local Create=addonTable.Create
local PIGFontString=Create.PIGFontString
--
local Fun=addonTable.Fun
local _GetTooltipLevel=Fun._GetTooltipLevel
--创建元素-染色/装等
function Fun.CZ_ItemButtonZLVranse(ItemButton)
	if not ItemButton then return end
	if ItemButton.ZLV then ItemButton.ZLV:SetText("") end
	if ItemButton.ranse then ItemButton.ranse:Hide() end
end
function Fun.Update_ItemButtonZLVranse(ly,ItemButton,data1,data2,data3)
	if not ItemButton then return end
	if PIGA["BagBank"]["wupinLV"] then
		if not ItemButton.ZLV then
			ItemButton.ZLV = PIGFontString(ItemButton,{"TOPLEFT", ItemButton, "TOPLEFT", -1, 0.4},nil,"THICKOUTLINE",14)
			ItemButton.ZLV:SetDrawLayer("OVERLAY", 7)
			ItemButton.ZLV:SetTextColor(0, 1, 1, 1);
		end
		ItemButton.ZLV:SetText("");
		if ly=="C" then
			if data2~=0 and data2~=4 and data2~=19 then
				local itemLink = GetInventoryItemLink(data1, data2)
				if itemLink then
					local Newquality = GetInventoryItemQuality(data1, data2)
					local r, g, b = GetItemQualityColor(Newquality or 1);
		    		ItemButton.ZLV:SetTextColor(r, g, b);
					_GetTooltipLevel(data1,{data2},function(ItemLevel)
						ItemButton.ZLV:SetText(ItemLevel)
					end)
				end
			end
		elseif ly=="B" then
			local itemID, itemLink, icon, stackCount, quality=PIGGetContainerItemInfo(data1,data2)
			if itemLink then
				local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subClassID = GetItemInfoInstant(itemLink)
				if classID==2 or classID==4 then
					local r, g, b = GetItemQualityColor(quality or 1);
					ItemButton.ZLV:SetTextColor(r, g, b);
					_GetTooltipLevel("bag",{data1,data2},function(ItemLevel)
						ItemButton.ZLV:SetText(ItemLevel);
					end)
				end
			end
		elseif ly=="L" or ly=="YC" then
			if data1 then
				local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subClassID = GetItemInfoInstant(data1)
				if classID==2 or classID==4 then
					if ly=="L" or (ly=="YC" and data3~=0 and data3~=4 and data3~=19) then
						local r, g, b = GetItemQualityColor(data2 or 1);
						ItemButton.ZLV:SetTextColor(r, g, b);
						_GetTooltipLevel("link",{data1},function(ItemLevel)
							ItemButton.ZLV:SetText(ItemLevel);
						end)
					end
				end
			end
		end
	end
	if PIGA["BagBank"]["wupinRanse"] then
		if not ItemButton.ranse then
			local Width123=ItemButton:GetWidth()
			ItemButton.ranse = ItemButton:CreateTexture(nil, "OVERLAY");
		    ItemButton.ranse:SetTexture("Interface/Buttons/UI-ActionButton-Border");
		    ItemButton.ranse:SetBlendMode("ADD");
		    ItemButton.ranse:SetPoint("TOPLEFT", ItemButton, "TOPLEFT", -Width123*0.4, Width123*0.4);
		    ItemButton.ranse:SetPoint("BOTTOMRIGHT", ItemButton, "BOTTOMRIGHT", Width123*0.4, -Width123*0.4);
		    ItemButton.ranse:Hide()
		end
		ItemButton.ranse:Hide()
		local Newquality
		if ly=="C" then
			Newquality = GetInventoryItemQuality(data1, data2)
		elseif ly=="B" then
			local itemID, itemLink, icon, stackCount, quality=PIGGetContainerItemInfo(data1, data2)
			Newquality=quality
		elseif ly=="L" or ly=="YC" then
			Newquality=data2
		end
	    if Newquality and Newquality>1 then
	        local r, g, b = GetItemQualityColor(Newquality);
	        ItemButton.ranse:SetVertexColor(r, g, b);
			ItemButton.ranse:Show()
		end
	end
end
