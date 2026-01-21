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
--物品卖价
local function ItemSell_Tooltip(self, data1, data2, laiyuan)
	if PIGA["Tooltip"]["ItemSell"] then
		local Newlink
		if laiyuan=="Hyperlink" then
			Newlink=data1
		else
			local _, link = self:GetItem()
			Newlink=link
		end
		if Newlink then
			local itemSellG = select(11, GetItemInfo(Newlink))
			if itemSellG and itemSellG > 0 then
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
				elseif laiyuan=="Auction" then
					-- local name, texture, count = GetAuctionItemInfo(data1, data2);
					-- new_stackCount=count or 1
				end
				local tishitxyx=GetMoneyString(itemSellG)
				if new_stackCount>1 then
					tishitxyx=GetMoneyString(itemSellG*new_stackCount).."("..AUCTION_HOUSE_HEADER_UNIT_PRICE..tishitxyx..")"
				end
				self:AddDoubleLine("卖店价:",tishitxyx,0.8,0.8,0.8,0.8,0.8,0.8)--SELL_PRICE..
				self:Show()
			end
		end
	end
end
function TooltipPlusfun.Tooltip_ItemSell()
	--处理系统卖价
	local old_GameTooltip_OnTooltipAddMoney=GameTooltip_OnTooltipAddMoney
	if PIGA["Tooltip"]["ItemSell"] then
		GameTooltip_OnTooltipAddMoney=function(self, cost, maxcost)
			--禁用系统的卖家显示
		end
	else
		GameTooltip_OnTooltipAddMoney=old_GameTooltip_OnTooltipAddMoney
	end
end
function TooltipPlusfun.InfoPlus()
	local SetTooltipOfflineG=addonTable.BusinessInfo.SetTooltipOfflineG
	local SetTooltipQita_Num=addonTable.BusinessInfo.SetTooltipQita_Num
	local function add_Tooltip_ExtData(tooltip,link)
		local name=tooltip:GetName()
		if not name then return end
		local frame, text
		for i = tooltip:NumLines(), 1, -1 do
			frame = _G[name .. "TextLeft" .. i]
			if frame then
				text = frame:GetText()
				if text and text:match("^|c%x%x%x%x%x%x%x%xID:") then
					return
				end
			end
		end
		local itemStackCount,_, _, _, classID, subClassID, _, expacID = select(8, GetItemInfo(link))
		if PIGA["Tooltip"]["ItemMaxCount"] or PIGA["Tooltip"]["IDinfo"] then
			if PIGA["Tooltip"]["ItemMaxCount"] then
				if itemStackCount and itemStackCount>1 then
				    tooltip:AddLine("|cffffcf00最大堆叠|r "..itemStackCount)
				end
			end
			if PIGA["Tooltip"]["IDinfo"] then
				local itemID = GetItemInfoInstant(link)
				if itemID then
					local expacID = expacID or 254
				    tooltip:AddDoubleLine("|cffd33c54ID:|r "..itemID,banbendata[expacID])    
				end
			end
		end
		if PIGA["Tooltip"]["ItemLevel"] then
			local effectiveILvl = GetDetailedItemLevelInfo(link)
			if effectiveILvl then
				local ILvltxt=string.format(ITEM_LEVEL,effectiveILvl)
				local ISduibi=tooltip==ShoppingTooltip1 or tooltip==ShoppingTooltip2 or tooltip==ItemRefShoppingTooltip1 or tooltip==ItemRefShoppingTooltip2
				if PIG_MaxTocversion(50000) then
					local txtUI,txtUI_r
					if ISduibi then
						txtUI = _G[tooltip:GetName().."TextLeft3"]
						txtUI_r = _G[tooltip:GetName().."TextRight3"]
					else
						txtUI = _G[tooltip:GetName().."TextLeft2"]
						txtUI_r = _G[tooltip:GetName().."TextRight2"]
					end
					if txtUI and txtUI_r then
						local Oldtxt = txtUI:GetText()
			    		if Oldtxt and Oldtxt~=" " then
				    		txtUI:SetText('|cffffcf00'..ILvltxt..'|r'.."\n"..Oldtxt)
				    		txtUI:SetSpacing(2)	
			        	end
						local Oldtxt2_r = txtUI_r:GetText()
						if Oldtxt2_r and Oldtxt~=" " then
							txtUI_r:SetText("\n"..Oldtxt2_r)
							txtUI_r:SetSpacing(4)
						end
					end
				else
					local classID=select(12, GetItemInfo(link))
		            if classID~=2 and classID~=4 and classID~=19 then
						local txtUI = _G[tooltip:GetName().."TextLeft2"]
						local Oldtxt = txtUI:GetText()
		        		if Oldtxt and Oldtxt~=" " then
		        			txtUI:SetText('|cffffcf00'..ILvltxt..'|r'.."\n"..Oldtxt)
		        			--txtUI:SetFormattedText('|cffffcf00'..ILvltxt..'|r'.."\n"..Oldtxt)
		            		txtUI:SetSpacing(2)
		            	else
		            		tooltip:AddLine('|cffffcf00'..ILvltxt..'|r')
		            	end
		            	 local txtUI_r = _G[tooltip:GetName().."TextRight2"]
						txtUI_r:SetSpacing(3)
						local Oldtxt2_r = txtUI_r:GetText()
						if Oldtxt2_r then
							txtUI_r:SetText(' '.."\n"..Oldtxt2_r)
							--txtUI_r:SetFormattedText(' '.."\n"..Oldtxt2_r)
						end
		           	end
				end
			end
		end
		local itemID = GetItemInfoInstant(link)
		SetTooltipOfflineG(tooltip,itemID)
		SetTooltipQita_Num(tooltip,itemID)
		tooltip:Show()
	end
	local function TooltipSetItem(self)
		local _, link = self:GetItem()
		if link then
			add_Tooltip_ExtData(self,link)
		end
	end
	local function TooltipHookScript(self,fun,hookfun)
		self:HookScript(fun,hookfun)
	end
	--卖价
	hooksecurefunc(GameTooltip, "SetBagItem", function(self, bag, slot)
		ItemSell_Tooltip(self, bag, slot,"Bag")
	end)
	hooksecurefunc(GameTooltip, "SetQuestItem", function(self, questType, index)
		ItemSell_Tooltip(self, questType, index,"Quest")
	end)
	hooksecurefunc(GameTooltip, "SetQuestLogItem", function(self, questType, index)
		ItemSell_Tooltip(self, questType, index,"QuestLog")
	end)
	-- hooksecurefunc(GameTooltip, "SetLootItem", function(self, lootIndex)
	-- 	ItemSell_Tooltip(self, lootIndex, nil,"LootItem")
	-- end)
	-- hooksecurefunc(GameTooltip, "SetLootRollItem", function(self, rollID)
	-- 	ItemSell_Tooltip(self, rollID, nil,"RollItem")
	-- end)
	hooksecurefunc(GameTooltip, "SetHyperlink", function(self, link)
		ItemSell_Tooltip(GameTooltip, link, nil,"Hyperlink")
	end)
	TooltipPlusfun.Tooltip_ItemSell()
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
				ItemSell_Tooltip(GameTooltip, type, index,"Auction")
			end
		end)
   		hooksecurefunc(GameTooltip, "SetTradeSkillItem", function(self, tradeItemIndex, reagentIndex)
			ItemSell_Tooltip(self, tradeItemIndex, reagentIndex,"TradeSkillItem")
		end)
		--物品等级
   		-- if PIG_MaxTocversion(50000) then
		-- 	hooksecurefunc("GameTooltip_ShowCompareItem", function(self, anchorFrame)
		-- 		if not PIGA["Tooltip"]["ItemLevel"] then return end
		-- 		local tooltip, anchorFrame, shoppingTooltip1, shoppingTooltip2 = GameTooltip_InitializeComparisonTooltips(self, anchorFrame);
		-- 		local _, link1 = shoppingTooltip1:GetItem()
		-- 		if link1 then
		-- 			local classID=select(12, GetItemInfo(link1))
		-- 			if classID==2 or classID==4 then
		-- 				local txtUI_1 = _G[shoppingTooltip1:GetName().."TextLeft3"]
		-- 				txtUI_1:SetSpacing(2)
		-- 				local Oldtxt1 = txtUI_1:GetText()
		-- 				local effectiveILvl1 = GetDetailedItemLevelInfo(link1)
		-- 				txtUI_1:SetText('|cffffcf00'.."物品等级 "..effectiveILvl1..'|r'.."\n"..Oldtxt1)
		-- 	            --txtUI_1:SetFormattedText('|cffffcf00'.."物品等级 "..effectiveILvl1..'|r'.."\n"..Oldtxt1)
		-- 	            txtUI_1:SetJustifyH("LEFT")
		-- 	            local txtUI_1_r = _G[shoppingTooltip1:GetName().."TextRight3"]
		-- 				txtUI_1_r:SetSpacing(2)
		-- 				local Oldtxt1_r = txtUI_1_r:GetText()
		-- 				if Oldtxt1_r then
		-- 					txtUI_1_r:SetText(' '.."\n"..Oldtxt1_r)
		-- 					--txtUI_1_r:SetFormattedText(' '.."\n"..Oldtxt1_r)
		-- 				end
		-- 	            shoppingTooltip1:Show()
		-- 	        end
		-- 		end
		-- 		local _, link2 = shoppingTooltip2:GetItem()
		-- 		if link2 then
		-- 			local classID=select(12, GetItemInfo(link2))
		-- 			if classID==2 or classID==4 then
		-- 				local txtUI_2 = _G[shoppingTooltip2:GetName().."TextLeft3"]
		-- 				txtUI_2:SetSpacing(2)
		-- 				local Oldtxt2 = txtUI_2:GetText()
		-- 				local effectiveILvl2 = GetDetailedItemLevelInfo(link2)
		-- 				txtUI_2:SetText('|cffffcf00'.."物品等级 "..effectiveILvl2..'|r'.."\n"..Oldtxt2)
		-- 	            --txtUI_2:SetFormattedText('|cffffcf00'.."物品等级 "..effectiveILvl2..'|r'.."\n"..Oldtxt2)
		-- 	            txtUI_2:SetJustifyH("LEFT")
		-- 	            local txtUI_2_r = _G[shoppingTooltip2:GetName().."TextRight3"]
		-- 				txtUI_2_r:SetSpacing(2)
		-- 				local Oldtxt2_r = txtUI_2_r:GetText()
		-- 				if Oldtxt2_r then
		-- 					txtUI_2_r:SetText(' '.."\n"..Oldtxt2_r)
		-- 					--txtUI_2_r:SetFormattedText(' '.."\n"..Oldtxt2_r)
		-- 				end
		-- 	            shoppingTooltip2:Show()
		-- 	        end
		-- 		end
		-- 	end)
		-- end
		TooltipHookScript(GameTooltip, "OnTooltipSetItem", TooltipSetItem)
		TooltipHookScript(ItemRefTooltip, "OnTooltipSetItem", TooltipSetItem)
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
		--处理聊天框物品
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
					add_Tooltip_ExtData(ItemRefTooltip,link)
					ItemSell_Tooltip(ItemRefTooltip, link, nil,"ItemRef")
				end
			end
		end)
	else
		--处理物品
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(self, data)
			if not PIGA["Tooltip"]["ItemLevel"] and not PIGA["Tooltip"]["IDinfo"] then return end
			local ItemID = data["id"]
			if ItemID then
				add_Tooltip_ExtData(self,ItemID)
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
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.PetAction,  function(self)
			if not PIGA["Tooltip"]["IDinfo"] then return end
			local displayedName = _G[self:GetName().."TextLeft"..1]:GetText()
			if displayedName then
				local name, icon, castTime, minRange, maxRange, spellID = PIGGetSpellInfo(displayedName)
				if spellID then
					self:AddDoubleLine("|cffd33c54ID:|r "..spellID,"")
				end
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
	   	if TooltipData and TooltipData.guid then
	   		TooltipF.pigplusBorder:SetAtlas(GetItemQualityBorder(C_Item.GetItemQualityByID(TooltipData.guid) or 1))
	   		TooltipF.pigplusicon:SetTexture(C_Item.GetItemIconByID(TooltipData.id) or 134400);
	   	end
	else
		TooltipF.pigplusBorder:SetPoint("BOTTOMLEFT",TooltipF,"TOPLEFT", 4, -2);
		local _, linkd = TooltipF:GetItem()
		if linkd then
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
			add_ShowCompareItemIcon(self,nil,true)
		end)
		hooksecurefunc(TooltipComparisonManager, "CompareItem", function(comparisonItem, tooltip, anchorFrame)
		   	local shoppingTooltip1, shoppingTooltip2 = unpack(anchorFrame.shoppingTooltips)
		   	add_ShowCompareItemIcon(shoppingTooltip1,true,true)
			add_ShowCompareItemIcon(shoppingTooltip2,true,true)
		end)
	end
end