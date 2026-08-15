local addonName, addonTable = ...;
local format=string.format
---判断秘密值
function PIGisSecret(value)
	if (issecretvalue and issecretvalue(value)) or (issecrettable and issecrettable(value)) then
		return true 
	end
	return false
end
--判断硬核
function PIGIsHardcore()
	return PIG_MaxTocversion(20000) and C_GameRules.IsHardcoreActive()
end
--插件版本信息
local version, internalVersion, date, tocversion, versionType, buildType = GetBuildInfo()
function PIG_MaxTocversion(ver,max)
	if type(ver)=="string" then
		if ver=="old" then
			if tocversion<20000 then
				return true
			end
		end
		return false
	else
		local maxver = ver or 60000
		if max then
			if tocversion>maxver then
				return true
			else
				return false
			end
		else
			if tocversion<maxver then
				return true
			else
				return false
			end
		end
	end
end

--获取移速
local SPEED7 = BASE_MOVEMENT_SPEED*0.01-0.00001
local NumberAbbrevOptions = {
    breakpointData = {
        { breakpoint = 0, significandDivisor = SPEED7, fractionDivisor = 1, abbreviation = "%", abbreviationIsGlobal = false}
    }
}
function PIGGetUnitSpeed(uix,unit)
	local currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed(unit);
	if PIG_MaxTocversion() then
		local yisuv = Round(currentSpeed/BASE_MOVEMENT_SPEED*100)
		uix:SetText(yisuv..'%')
		if yisuv>=100 then
			uix:SetTextColor(0,1,0,1);
		elseif yisuv==0 then
			uix:SetTextColor(0.5,0.5,0.5,1);
		else
			uix:SetTextColor(1,0,0,1);
		end
	else
		uix:SetText(AbbreviateNumbers(currentSpeed, NumberAbbrevOptions))
	end
end
---
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns and C_AddOns.IsAddOnLoaded
function PIGIsAddOnLoaded(name)
	return IsAddOnLoaded(name)
end
local GetAddOnInfo=GetAddOnInfo or C_AddOns and C_AddOns.GetAddOnInfo
function PIGGetAddOnInfo(id)
	return GetAddOnInfo(id)
end
local EnableAddOn=EnableAddOn or C_AddOns and C_AddOns.EnableAddOn
function PIGEnableAddOn(id)
	return EnableAddOn(id)
end
local GetAddOnMetadata=C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata
function PIGGetAddOnMetadata(addonName, shuxing)
	return GetAddOnMetadata(addonName, shuxing)
end

local PIG_GetAddOnEnableState=C_AddOns and C_AddOns.GetAddOnEnableState
if PIG_GetAddOnEnableState==nil then
	local _GetAddOnEnableState = _G.GetAddOnEnableState;
	PIG_GetAddOnEnableState = function(addon, name)
		return _GetAddOnEnableState(name, addon);
	end
end
PIGGetAddOnEnableState=PIG_GetAddOnEnableState
---
local voiceID = C_TTSSettings.GetVoiceOptionID(0)
function PIG_PlaySoundFile(url,index)
	local voiceTxt = url[2]
	if url[3]=="AI" then
		if index then voiceTxt=index end
		C_VoiceChat.SpeakText(voiceID, voiceTxt, 2, 100, true)
	else
		if index then voiceTxt=url[2]:format(index) end
		PlaySoundFile(voiceTxt, "Master")
	end
end
--公会刷新
local GuildRoster=C_GuildInfo and C_GuildInfo.GuildRoster or GuildRoster
function PIG_GuildRoster()
	GuildRoster()
end
---组队邀请
local InviteUnit=C_PartyInfo and C_PartyInfo.InviteUnit or InviteUnit
function PIG_InviteUnit(name)
	InviteUnit(name)
end
--队伍转换
local ConvertToRaid=C_PartyInfo and C_PartyInfo.ConvertToRaid or ConvertToRaid
function PIG_ConvertToRaid()
	ConvertToRaid()
end
local ConvertToParty=C_PartyInfo and C_PartyInfo.ConvertToParty or ConvertToParty
function PIG_ConvertToParty()
	ConvertToParty()
end
---职业信息
function PIGGetClassInfo(id)
	if C_CreatureInfo and C_CreatureInfo.GetClassInfo then
		local classInfo=C_CreatureInfo.GetClassInfo(id)
		if classInfo then
			return classInfo["className"],classInfo["classFile"],id
		end
	else
		local className, classFile=GetClassInfo(id)
		if className then
			return className, classFile, id
		end
	end
end
---种族ICON
function PIGGetIconForRole(role)
	if role=="NONE" then
		return "UI-LFG-RoleIcon-Pending"
	else
		return GetIconForRole(role)
	end
end

function PIG_GetDifficultyInfo(difficultyId)
	local name, groupType, isHeroic, isChallengeMode, displayHeroic, displayMythic, toggleDifficultyID, isLFR, minPlayers, maxPlayers= GetDifficultyInfo(difficultyId)
	if difficultyId==244 then
		name=name:gsub(FROM_RAID, "")
	end
	return name, groupType, isHeroic, isChallengeMode, displayHeroic, displayMythic, toggleDifficultyID, isLFR, minPlayers, maxPlayers
end

function PIGGetMerchantItemInfo(index)
	local name, price, stackCount, numAvailable, spellID, texture
	if C_MerchantFrame and C_MerchantFrame.GetItemInfo then
		local info = C_MerchantFrame.GetItemInfo(index);
		if info then
			name=info.name
			price=info.price
			stackCount=info.stackCount
			numAvailable=info.numAvailable
			spellID=info.spellID
			texture=info.texture
		end
	else
		local name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost, currencyID, spellID=GetMerchantItemInfo(index)
		name=name
		price=price
		numAvailable=numAvailable
		stackCount=quantity
		spellID=spellID
		texture=texture
	end
	return name, price, stackCount, numAvailable, spellID, texture
end

--技能信息====================
function PIGprint(msg,colour)
	if colour=="R" then
		print("|cff00FFFF[!Pig] |r|cffFF0000"..msg.."|r");
	elseif colour=="G" then
		print("|cff00FFFF[!Pig] |r|cff00FF00"..msg.."|r");
	else
		print("|cff00FFFF[!Pig] |r|cffFFFF00"..msg.."|r");
	end
end
function PIG_GetSpellBookType()
	if Enum.SpellBookSpellBank and Enum.SpellBookSpellBank.Player then
		return Enum.SpellBookSpellBank.Player
	else
		return BOOKTYPE_SPELL
	end
end
function PIGGetSpellInfo(SpellID)
	if C_Spell and C_Spell.GetSpellInfo then
		local spellInfo = C_Spell.GetSpellInfo(SpellID)
		if spellInfo then
			return spellInfo.name,spellInfo.iconID,spellInfo.castTime,spellInfo.minRange,spellInfo.maxRange,spellInfo.spellID,spellInfo.originalIconID
		end
	else
		local name, rank, icon, castTime, minRange, maxRange, spellID, originalIcon= GetSpellInfo(SpellID)
		return name, icon, castTime, minRange, maxRange, spellID, originalIcon,rank
	end
end
function PIGGetSpellTabInfo(SpellID)
	if C_SpellBook and C_SpellBook.GetSpellBookSkillLineInfo then
		local spellInfo = C_SpellBook.GetSpellBookSkillLineInfo(SpellID)
		if spellInfo then
			return spellInfo.name,spellInfo.iconID,spellInfo.itemIndexOffset,spellInfo.numSpellBookItems,spellInfo.isGuild,spellInfo.shouldHide,spellInfo.specID,spellInfo.offSpecID
		end
	else
		local name, texture, offset, numSlots, isGuild, offspecID= GetSpellTabInfo(SpellID)
		return name, texture, offset, numSlots, isGuild, offspecID
	end
end
function PIGGetSpellBookItemInfo(index, bookType)
	if C_SpellBook and C_SpellBook.GetSpellBookItemInfo then
		local spellInfo = C_SpellBook.GetSpellBookItemInfo(index, bookType)
		if spellInfo then
			return spellInfo.itemType,spellInfo.spellID
		end
	else
		local spellType, id= GetSpellBookItemInfo(index, bookType)
		return spellType, id
	end
end
function PIGGetSpellCooldown(SpellID)
	if C_Spell and C_Spell.GetSpellCooldown then
		local spellInfo = C_Spell.GetSpellCooldown(SpellID)
		if spellInfo then
			return spellInfo.startTime,spellInfo.duration,spellInfo.isEnabled,spellInfo.modRate
		end
	else
		local start, duration, enabled, modRate= GetSpellCooldown(SpellID)
		return start, duration, enabled, modRate
	end
end

--物品信息=========
local GetItemInfo=C_Item and C_Item.GetItemInfo or GetItemInfo
function PIGGetItemInfo(Item)
	return GetItemInfo(Item)
end
local GetDetailedItemLevelInfo=C_Item and C_Item.GetDetailedItemLevelInfo or GetDetailedItemLevelInfo
function PIGGetDetailedItemLevelInfo(Item)
	return GetDetailedItemLevelInfo(Item)
end
local GetItemInfoInstant=C_Item and C_Item.GetItemInfoInstant or GetItemInfoInstant
function PIGGetItemInfoInstant(Item)
	return GetItemInfoInstant(Item)
end
local GetItemSpell=C_Item and C_Item.GetItemSpell or GetItemSpell
function PIGGetItemSpell(Item)
	return GetItemSpell(Item)
end
--背包物品信息===============
local GetContainerNumFreeSlots=C_Container and C_Container.GetContainerNumFreeSlots or GetContainerNumFreeSlots
function PIGGetContainerNumFreeSlots(bag)
	return GetContainerNumFreeSlots(bag)
end
function PIGGetContainerItemInfo(bag, slot)
	if C_Container and C_Container.GetContainerItemInfo then
		local ItemInfo = C_Container.GetContainerItemInfo(bag, slot)
		if ItemInfo then
			return ItemInfo.itemID,ItemInfo.hyperlink,ItemInfo.iconFileID,ItemInfo.stackCount,ItemInfo.quality,ItemInfo.hasNoValue,ItemInfo.hasLoot,ItemInfo.isLocked,ItemInfo.isBound
		end
	else
		local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound = GetContainerItemInfo(bag, slot)
		return itemID, itemLink, icon, stackCount, quality, noValue, lootable, locked, isBound
	end
end
local GetContainerItemID=C_Container and C_Container.GetContainerItemID or GetContainerItemID
function PIGGetContainerItemID(bag, slot)
	return GetContainerItemID(bag, slot)
end
local GetContainerItemLink=C_Container and C_Container.GetContainerItemLink or GetContainerItemLink
function PIGGetContainerItemLink(bag, slot)
	return GetContainerItemLink(bag, slot)
end
local GetContainerItemCooldown=C_Container and C_Container.GetContainerItemCooldown or GetContainerItemCooldown
function PIGGetContainerItemCooldown(bag, slot)
	return GetContainerItemCooldown(bag, slot)
end
local GetContainerNumSlots=C_Container and C_Container.GetContainerNumSlots or GetContainerNumSlots
function PIGGetContainerNumSlots(bag)
	return GetContainerNumSlots(bag)
end
local UseContainerItem=C_Container and C_Container.UseContainerItem or UseContainerItem
function PIGUseContainerItem(bag, slot)
	if BankFrame.GetActiveBankType then
		UseContainerItem(bag, slot, nil, BankFrame:GetActiveBankType(), BankFrame:IsShown() and BankFrame.selectedTab == 2);
	else
		UseContainerItem(bag, slot, nil, BankFrame:IsShown() and (BankFrame.selectedTab == 2));
	end
end
local PickupContainerItem=C_Container and C_Container.PickupContainerItem or PickupContainerItem
function PIGPickupContainerItem(bag, slot)
	PickupContainerItem(bag, slot);
end
local SplitContainerItem=C_Container and C_Container.SplitContainerItem or SplitContainerItem
function PIGSplitContainerItem(bag, slot)
	SplitContainerItem(bag, slot);
end

--聊天消息=============
function PIGSendBNetTell(displayName)
	if ChatFrame_SendBNetTell then
		ChatFrame_SendBNetTell(displayName)
	else
		ChatFrameUtil.SendBNetTell(displayName)
	end
end
function PIGSendTell(displayName)
	if ChatFrame_SendTell then
		ChatFrame_SendTell(displayName)
	else
		ChatFrameUtil.SendTell(displayName)
	end
end

function PIGChatFrameAddChannel(ChatFrame,channel)--订购一个聊天框以显示先前加入的聊天频道
	if ChatFrame.AddChannel then
		ChatFrame:AddChannel(channel)
	else
		ChatFrame_AddChannel(ChatFrame, channel)
	end
end
function PIGChatFrameRemoveChannel(ChatFrame,channel)
	ChatFrame:RemoveChannel(channel)
end
function PIGSendChatRaidParty(txt,GroupLeader,extinfo)
	local Newtxt="[!Pig] "..txt
	if extinfo=="nopig" then
		Newtxt=txt
	end
	if GroupLeader then--限制队长和团长
		if UnitIsGroupLeader("player") then
			if IsInRaid() then
				if extinfo=="W" then
					SendChatMessage(Newtxt, "RAID_WARNING")
				else
					SendChatMessage(Newtxt, "RAID");
				end
			elseif IsInGroup() then
				SendChatMessage(Newtxt, "PARTY");
			end
		end
	else
		if IsInRaid() then
			SendChatMessage(Newtxt, "RAID");
		elseif IsInGroup() then
			SendChatMessage(Newtxt, "PARTY");
		else
			if extinfo=="print" then
				print("|cff00FFFF[!Pig] |r"..txt)
			end
		end
	end
end
local SendAddonMessage=C_ChatInfo and C_ChatInfo.SendAddonMessage or SendAddonMessage
function PIGSendAddonMessage(biaotou,txt,chatType, target)
	SendAddonMessage(biaotou,txt,chatType, target)
end
function PIGSendAddonRaidParty(biaotou,txt)
	if IsInRaid() then
		PIGSendAddonMessage(biaotou,txt,"RAID")
	elseif IsInGroup() then
		PIGSendAddonMessage(biaotou,txt,"PARTY")
	end
end