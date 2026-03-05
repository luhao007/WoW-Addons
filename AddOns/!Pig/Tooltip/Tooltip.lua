local _, addonTable = ...;
local find = _G.string.find
local gsub = _G.string.gsub
local Fun=addonTable.Fun
local TooltipPlusfun=addonTable.TooltipPlusfun
local GetItemInfo=GetItemInfo or C_Item and C_Item.GetItemInfo
local GetItemInfoInstant=GetItemInfoInstant or C_Item and C_Item.GetItemInfoInstant
local GetDetailedItemLevelInfo=GetDetailedItemLevelInfo or C_Item and C_Item.GetDetailedItemLevelInfo
---------
local Create=addonTable.Create
local PIGFontString=Create.PIGFontString
local banbendata = {
	[0]=EXPANSION_NAME0,[1]=EXPANSION_NAME1,[2]=EXPANSION_NAME2,[3]=EXPANSION_NAME3,[4]=EXPANSION_NAME4,
	[5]=EXPANSION_NAME5,[6]=EXPANSION_NAME6,[7]=EXPANSION_NAME7,[8]=EXPANSION_NAME8,[8]=EXPANSION_NAME8,
	[9]=EXPANSION_NAME9,[10]=EXPANSION_NAME10,[11]=EXPANSION_NAME11,[254]="",
}
local extinfoList={
	["lv"]=ITEM_LEVEL,
	["max"]=MAXIMUM..ACTION_SPELL_AURA_APPLIED_DOSE..": ",
	["info"]=ITEMS.."ID: ",
	["auc"]=AUCTIONS..AUCTION_BROWSE_UNIT_PRICE_SORT..": ",
}
function TooltipPlusfun.InfoPlus()
	--卖价/AH价钱
	local SetTooltipOfflineG=addonTable.BusinessInfo.SetTooltipOfflineG
	local SetTooltipQita_Num=addonTable.BusinessInfo.SetTooltipQita_Num
	local function ItemTooltipLevel(tooltip,link,classID)
		if not PIGA["Tooltip"]["ItemLevel"] then return end
		local name=tooltip:GetName()
		if not name then return end
		local effectiveILvl = GetDetailedItemLevelInfo(link)
		if effectiveILvl then
			local ILvltxt=string.format(extinfoList.lv,effectiveILvl)
			local ISduibi=tooltip==ShoppingTooltip1 or tooltip==ShoppingTooltip2 or tooltip==ItemRefShoppingTooltip1 or tooltip==ItemRefShoppingTooltip2
			if PIG_MaxTocversion(50000) or (classID~=2 and classID~=4 and classID~=19) then
				local txtUI
				if ISduibi then
				    txtUI = _G[tooltip:GetName().."TextLeft2"]				
				else
					txtUI = _G[tooltip:GetName().."TextLeft1"]
				end
				if txtUI then
					local Oldtxt = txtUI:GetText()
		    		if Oldtxt and Oldtxt~=" " then
			    		txtUI:SetText(txtUI:GetText()..'\n|cffffcf00'..ILvltxt..'|r')
			    		txtUI:SetJustifyH("LEFT")
		        	end
				end
			end
		end
	end
	local function ItemTooltipData(tooltip, data1, data2, laiyuan)
		local Newlink
		if laiyuan=="Hyperlink" then
			Newlink=data1
		else
			if tooltip.GetItem then
				local _, link = tooltip:GetItem()
				if link then
					Newlink=link
				end
			else
				local TooltipData=tooltip:GetTooltipData()
				if TooltipData and TooltipData.guid then
					Newlink=C_Item.GetItemLinkByGUID(TooltipData.guid)
	   			end
			end
		end
		if not Newlink then return end
		local itemStackCount,_, _, sellPrice, classID, subClassID, _, expacID = select(8, GetItemInfo(Newlink))
		ItemTooltipLevel(tooltip,Newlink,classID)
		if PIGA["Tooltip"]["ItemMaxCount"] or PIGA["Tooltip"]["IDinfo"] then
			local addtxt_L,addtxt_R="",""
			if PIGA["Tooltip"]["IDinfo"] then
				local itemID = GetItemInfoInstant(Newlink)
				if itemID then
					local expacID = expacID or 254
					addtxt_L="|cffd33c54"..extinfoList.info.."|r|cffffffff"..itemID.."|r"
					addtxt_R=banbendata[expacID] 
				end
			end
			if PIGA["Tooltip"]["ItemMaxCount"] then
				if itemStackCount and itemStackCount>1 then
					if PIGA["Tooltip"]["IDinfo"] then
						addtxt_L=addtxt_L.."  (|cffd33c54"..extinfoList.max.."|r|cffffffff"..itemStackCount..")".."|r"
					else
						addtxt_L="|cffd33c54"..extinfoList.max.."|r "..itemStackCount
					end
				end
			end
			tooltip:AddDoubleLine(addtxt_L,addtxt_R)    
		end
		if PIGA["Tooltip"]["ItemSell"] then
			if sellPrice and sellPrice > 0 then
				local new_stackCount = 1
				if laiyuan=="Bag" then
					local itemID, itemLink, icon, stackCount=PIGGetContainerItemInfo(data1, data2)
					new_stackCount=stackCount
				elseif laiyuan=="Quest" then
					local _, _, count = GetQuestItemInfo(data1, data2)
					new_stackCount=count or 1
				elseif laiyuan=="QuestLog" then
					local _, _, count = GetQuestLogRewardInfo(data2)
					new_stackCount=count or 1
				elseif laiyuan=="TradeSkillItem" then
					if data1 and data2 then
						local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(data1, data2);
						new_stackCount=reagentCount or 1
					else
						local skillName, skillType, numAvailable, isExpanded, altVerb = GetTradeSkillInfo(data1);
						new_stackCount=numAvailable or 1
					end
				elseif laiyuan=="Loot" then
					local lootIcon, lootName, lootQuantity, currencyID, lootQuality, locked, isQuestItem, questID, isActive, isCoin = GetLootSlotInfo(data1)
					new_stackCount=lootQuantity or 1
				elseif laiyuan=="Roll" then
					
					--new_stackCount=lootQuantity or 1
				elseif laiyuan=="Auction" then
					-- local name, texture, count = GetAuctionItemInfo(data1, data2);
					-- new_stackCount=count or 1
				elseif  laiyuan=="Inventory" then

				elseif  laiyuan=="Inbox" then
					local name, itemID, texture, count, quality, canUse  = GetInboxItem(data1, data2 or 1)
					new_stackCount=count or 1
				elseif laiyuan=="Merchant" then
					local info = C_MerchantFrame.GetItemInfo(data1);
					new_stackCount=info and info.stackCount or 1
				else
					--print(laiyuan)
				end
				local tishitxyx=AUCTION_BROWSE_UNIT_PRICE_SORT..GetMoneyString(sellPrice)
				if new_stackCount>1 then
					tishitxyx="("..AUCTION_HOUSE_TOTAL_PRICE_LABEL..GetMoneyString(sellPrice*new_stackCount)..")"..tishitxyx
				end
				tooltip:AddDoubleLine("卖店"..AUCTION_PRICE..":",tishitxyx,0.8,0.8,0.8,0.8,0.8,0.8)--SELL_PRICE..
			end
		end
		local AHGL,AHGR=SetTooltipOfflineG(tooltip,Newlink)
		if AHGL then
			tooltip:AddDoubleLine(AHGL,AHGR,0,1,1,0,1,1)
		end
		local tispData,playerNum=SetTooltipQita_Num(tooltip,Newlink)
		if tispData and playerNum>0 then
			for i=1,#tispData do
				local txtrrr
				for ix=1,#tispData[i][2] do
					txtrrr=txtrrr and txtrrr.." "..tispData[i][2][ix][1].."|cffFFFFFF"..tispData[i][2][ix][2].."|r" or tispData[i][2][ix][1].."|cffFFFFFF"..tispData[i][2][ix][2].."|r"
				end
				tooltip:AddDoubleLine(tispData[i][1],txtrrr)
			end
			tooltip:AddDoubleLine(ITEMS..FROM_TOTAL,"|cffFFFFFF"..playerNum.."|r")
		end
		tooltip:Show()
	end
	
	if PIGA["Tooltip"]["ItemSell"] and PIG_MaxTocversion(30000,true) and PIG_MaxTocversion(100000) then
		GameTooltip_OnTooltipAddMoney=function() end
	end
	hooksecurefunc(GameTooltip, "SetBagItem", function(self, bag, slot)
		ItemTooltipData(self, bag, slot,"Bag")
	end)
	hooksecurefunc(GameTooltip, "SetQuestItem", function(self, questType, index)
		ItemTooltipData(self, questType, index,"Quest")
	end)
	hooksecurefunc(GameTooltip, "SetQuestLogItem", function(self, questType, index)
		ItemTooltipData(self, questType, index,"QuestLog")
	end)
	hooksecurefunc(GameTooltip, "SetInventoryItem", function(self, unit, invSlot)
		ItemTooltipData(self, unit, invSlot,"Inventory")
	end)
	hooksecurefunc(GameTooltip, "SetInboxItem", function(self, index, attachIndex)
		ItemTooltipData(self, index, attachIndex,"Inbox")
	end)
	hooksecurefunc(GameTooltip, "SetLootItem", function(self, lootIndex)
		ItemTooltipData(self, lootIndex, nil,"Loot")
	end)
	hooksecurefunc(GameTooltip, "SetLootRollItem", function(self, rollID)
		ItemTooltipData(self, rollID, nil,"Roll")
	end)
	hooksecurefunc(GameTooltip, "SetHyperlink", function(self, link)
		ItemTooltipData(GameTooltip, link, nil,"Hyperlink")
	end)
	hooksecurefunc(GameTooltip, "SetMerchantItem", function(self, index)
		ItemTooltipData(self, index, nil,"Merchant")
	end)
   	if PIG_MaxTocversion() then
   		Fun.IsAddOnLoaded("Blizzard_AuctionUI", function()
   			AuctionFrameItem_OnEnter=function(self, type, index)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				if ( index <= 0 ) then
					local itemID = C_WowTokenPublic.GetListedAuctionableTokenInfo(index + C_WowTokenPublic.GetNumListedAuctionableTokens());
					GameTooltip:SetItemByID(itemID);
				else
					local hasCooldown, speciesID, level, breedQuality, maxHealth, power, speed, name = GameTooltip:SetAuctionItem(type, index);
					if(speciesID and speciesID > 0) then
						BattlePetToolTip_Show(speciesID, level, breedQuality, maxHealth, power, speed, name);
						return;
					end
				end
				ItemTooltipData(GameTooltip, type, index,"Auction")
			end
		end)
   		hooksecurefunc(GameTooltip, "SetTradeSkillItem", function(self, tradeItemIndex, reagentIndex)
			ItemTooltipData(self, tradeItemIndex, reagentIndex,"TradeSkillItem")
		end)
		--聊天框物品
		hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
			if link:find("^spell:") then
				if PIGA["Tooltip"]["IDinfo"] then
					local id = link:gsub(":0","")
					local id = id:gsub("spell:","")
					ItemRefTooltip:AddDoubleLine("|cffd33c54SpellID:|r "..id,"")
					ItemRefTooltip:Show()
				end
			elseif link:find("^item:") then
				if PIG_MaxTocversion() then
					ItemTooltipData(ItemRefTooltip, link)
				end
			end
		end)
		--物品等级/堆叠/ID
		local function TooltipSetItem(self)
			local _, link = self:GetItem()
			if link then
				ItemTooltipData(self, link, nil,"Hyperlink")
			end
		end
		local function TooltipHookScript(self,fun,hookfun)
			self:HookScript(fun,hookfun)
		end
		TooltipHookScript(ItemRefShoppingTooltip1, "OnTooltipSetItem", TooltipSetItem)
		TooltipHookScript(ItemRefShoppingTooltip2, "OnTooltipSetItem", TooltipSetItem)
		TooltipHookScript(ShoppingTooltip1, "OnTooltipSetItem", TooltipSetItem)
		TooltipHookScript(ShoppingTooltip2, "OnTooltipSetItem", TooltipSetItem)

		--处理技能
		GameTooltip:HookScript("OnTooltipSetSpell", function(self)
			if not PIGA["Tooltip"]["IDinfo"] then return end
			local _,id = self:GetSpell()
			if id then
				self:AddDoubleLine("|cffd33c54SpellID:|r "..id,"")
				self:Show()
			end
		end)
		--处理收藏
		hooksecurefunc(GameTooltip, "SetToyByItemID", function(self,itemID)
			if itemID then
				self:AddDoubleLine("|cffd33c54ID:|r "..itemID,"")
			end
			self:Show()
		end)
		--处理天赋
		hooksecurefunc(GameTooltip, "SetTalent", function(self,talentTree,tfID,inspect,pet,Group,...)
			self:AddDoubleLine("|cffd33c54TalentID:|r "..talentTree,"")
			self:Show()
		end)
		---处理BUFF/DEBUFF
		local function UnitBuff_Tooltip(self, unit, index, filter)
			if not PIGA["Tooltip"]["IDinfo"] then return end
			local _, icon, count, debuffType, duration, expires, caster,_,_,spellID = UnitAura(unit, index, filter) 
		    if spellID then
		    	if caster then
			        local _, class = UnitClass(caster) 
			        local color = PIG_CLASS_COLORS[class];
			        local name = GetUnitName(caster, true)
			        self:AddDoubleLine("|cffd33c54SpellID:|r "..spellID.."\124r","来自: \124c"..color.colorStr..name.."\124r")
				else
					self:AddDoubleLine("|cffd33c54SpellID:|r "..spellID.."\124r","来自: \124cff48cba0未知\124r")
				end
				self:Show() 
		    end 
		end
		hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, unit, index, filter)
			UnitBuff_Tooltip(self, unit, index, filter)
		end)
		hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self, unit, index, filter)
			UnitBuff_Tooltip(self, unit, index, filter)
		end)
		hooksecurefunc(GameTooltip, "SetUnitAura", function(self, unit, index, filter)
			UnitBuff_Tooltip(self, unit, index, filter) 
		end)
	else
		--处理物品
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
			if not PIGA["Tooltip"]["ItemLevel"] and not PIGA["Tooltip"]["IDinfo"] then return end
			local ItemID = data["id"]
			if ItemID then
				local ISduibi=tooltip==ItemRefTooltip or tooltip==ShoppingTooltip1 or tooltip==ShoppingTooltip2 or tooltip==ItemRefShoppingTooltip1 or tooltip==ItemRefShoppingTooltip2
				if ISduibi then
					ItemTooltipData(tooltip, ItemID)
				end
			end
		end)
		-- TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(self, data)
		-- 	if (C_PetBattles.IsInBattle()) then
		--         return
		--     end
		--     print(TooltipUtil.GetDisplayedUnit(self))
		-- end)
		--处理BUFF
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.UnitAura, function(self, data)
			if not PIGA["Tooltip"]["IDinfo"] then return end
			if data and data.id then
				self:AddDoubleLine("|cffd33c54ID:|r "..data.id,"")
				self:Show()
			end
		end)
		--处理技能
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function(self)
			if not PIGA["Tooltip"]["IDinfo"] then return end
			local _,id = self:GetSpell()
			if id then
				self:AddDoubleLine("|cffd33c54ID:|r "..id,"")
				self:Show()
			end
		end)
		--处理宠物动作条技能
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.PetAction,  function(self,data)
			if not PIGA["Tooltip"]["IDinfo"] then return end
			if data.lines and data.lines[1] and data.lines[1].tooltipID then
				self:AddDoubleLine("|cffd33c54ID:|r "..data.lines[1].tooltipID,"")
			end
		end)
		--处理收藏
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Toy, function(self, data)
			if not PIGA["Tooltip"]["IDinfo"] then return end
			if data and data.id then
				self:AddDoubleLine("|cffd33c54ID:|r "..data.id,"")
				self:Show()
			end
		end)
	end
end

function TooltipPlusfun.Point()
	local morenCF = {
		["PointOpen"]=PIGA["Tooltip"]["PointOpen"],
		["Point"]=PIGA["Tooltip"]["Point"],
		["PointX"]=PIGA["Tooltip"]["PointX"],
		["PointY"]=PIGA["Tooltip"]["PointY"],
	}
	function TooltipPlusfun.SetPointCF(laiyuan)
		morenCF.PointOpen=PIGA["Tooltip"]["PointOpen"]
		if laiyuan then
			PIGA["Tooltip"]["Point"]=addonTable.Default["Tooltip"]["Point"]
			PIGA["Tooltip"]["PointX"]=addonTable.Default["Tooltip"]["PointX"]
			PIGA["Tooltip"]["PointY"]=addonTable.Default["Tooltip"]["PointY"]
		end
		morenCF.Point=PIGA["Tooltip"]["Point"]
		morenCF.PointX=PIGA["Tooltip"]["PointX"]
		morenCF.PointY=PIGA["Tooltip"]["PointY"]
	end
	hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
		if not morenCF.PointOpen then return end
		tooltip:SetOwner(parent, "ANCHOR_NONE");
		tooltip:ClearAllPoints();
		if morenCF.Point==1 then
			tooltip:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -CONTAINER_OFFSET_X-13+morenCF.PointX, CONTAINER_OFFSET_Y+morenCF.PointY);
		elseif morenCF.Point==2 then
			tooltip:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -CONTAINER_OFFSET_X+13+morenCF.PointX, CONTAINER_OFFSET_Y+morenCF.PointY);
		elseif morenCF.Point==3 then
			tooltip:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", -CONTAINER_OFFSET_X+13+morenCF.PointX, CONTAINER_OFFSET_Y+morenCF.PointY);
		elseif morenCF.Point==4 then
			tooltip:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -CONTAINER_OFFSET_X - 13+morenCF.PointX, CONTAINER_OFFSET_Y+morenCF.PointY);
		elseif morenCF.Point==5 then
			tooltip:SetOwner(parent, "ANCHOR_CURSOR",morenCF.PointX,morenCF.PointY);
		elseif morenCF.Point==6 then
			tooltip:SetOwner(parent, "ANCHOR_CURSOR_LEFT",morenCF.PointX,morenCF.PointY);
		elseif morenCF.Point==7 then 
			tooltip:SetOwner(parent, "ANCHOR_CURSOR_RIGHT",morenCF.PointX,morenCF.PointY);
		end
	end)
end

local GetItemQualityBorder=addonTable.Fun.GetItemQualityBorder
local function add_ShowCompareItemIcon(TooltipF,duibiUI,retail)
	if not TooltipF.pigplusicon then
		TooltipF.pigplusBorder = TooltipF:CreateTexture(nil, "ARTWORK")
		TooltipF.pigplusBorder:SetSize(30,30);
		TooltipF.pigplusicon = TooltipF:CreateTexture(nil, "BORDER")
		TooltipF.pigplusicon:SetPoint("TOPLEFT",TooltipF.pigplusBorder,"TOPLEFT", 0, 0);
		TooltipF.pigplusicon:SetPoint("BOTTOMRIGHT",TooltipF.pigplusBorder,"BOTTOMRIGHT", 0, 0);
		if duibiUI and not retail then
			TooltipF.tisptxt = PIGFontString(TooltipF,{"BOTTOMLEFT", TooltipF.pigplusBorder,"BOTTOMRIGHT",0,2},"已装备","OUTLINE")
			TooltipF.tisptxt:SetTextColor(0, 1, 0, 1)
		end
	end
	if retail then
		if duibiUI then
			TooltipF.pigplusBorder:SetPoint("BOTTOMLEFT",TooltipF,"TOPLEFT", 70, -2);
		else
			TooltipF.pigplusBorder:SetPoint("BOTTOMLEFT",TooltipF,"TOPLEFT", 4, -2);
		end
		local TooltipData=TooltipF:GetTooltipData()
	   	if TooltipData and TooltipData.guid or TooltipData and TooltipData.hyperlink then
	   		TooltipF.pigplusBorder:SetAtlas(GetItemQualityBorder(C_Item.GetItemQualityByID(TooltipData.guid or TooltipData.hyperlink) or 1))
	   		TooltipF.pigplusicon:SetTexture(C_Item.GetItemIconByID(TooltipData.guid or TooltipData.hyperlink) or 134400);
	   	end
	else
		local _, linkd = TooltipF:GetItem()
		if linkd then
			TooltipF.pigplusBorder:SetPoint("BOTTOMLEFT",TooltipF,"TOPLEFT", 4, -2);
			TooltipF.pigplusBorder:SetAtlas(GetItemQualityBorder(C_Item.GetItemQualityByID(linkd) or 1))
			TooltipF.pigplusicon:SetTexture(C_Item.GetItemIconByID(linkd) or 134400);
		end
	end
end
function TooltipPlusfun.CompareItemPlus()
	if not PIGA["Tooltip"]["CompareItemPlus"] then return end
	GameTooltip:HookScript("OnShow", function(self)
		if self.pigplusicon then
			self.pigplusBorder:SetTexture("")
			self.pigplusicon:SetTexture("")
		end
	end)
	if PIG_MaxTocversion() then
		GameTooltip:HookScript("OnTooltipSetItem", function(self)
			add_ShowCompareItemIcon(self)
		end)
		hooksecurefunc("GameTooltip_ShowCompareItem", function(self, anchorFrame)
			local tooltip, anchorFrame, shoppingTooltip1, shoppingTooltip2 = GameTooltip_InitializeComparisonTooltips(self, anchorFrame);
			add_ShowCompareItemIcon(shoppingTooltip1,true)
			add_ShowCompareItemIcon(shoppingTooltip2,true)
		end)
	else
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(self, data)
			add_ShowCompareItemIcon(self,self==ShoppingTooltip1 or self==ShoppingTooltip2 or self==ItemRefShoppingTooltip1 or self==ItemRefShoppingTooltip2,true)
		end)
	end
end