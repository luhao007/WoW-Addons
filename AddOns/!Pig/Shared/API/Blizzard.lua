local addonName, addonTable = ...;

----
function PIGisSecret(value)
	if (issecretvalue and issecretvalue(value)) or (issecrettable and issecrettable(value)) then
		return true 
	end
	return false
end
function PIGIsHardcore()
	return PIG_MaxTocversion(20000) and C_GameRules.IsHardcoreActive()
end
local version, internalVersion, date, tocversion, versionType, buildType = GetBuildInfo()
function PIG_MaxTocversion(ver,max)
	if type(ver)=="string" then
		if ver=="old" then
			if tocversion<60000 then
				if tocversion<20000 or tocversion>40000 then
					return true
				end
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
---
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns and C_AddOns.IsAddOnLoaded
function PIGIsAddOnLoaded(name)
	return IsAddOnLoaded(name)
end
---------
function PIGGetAddOnInfo(id)
	local GetAddOnInfo=GetAddOnInfo or C_AddOns and C_AddOns.GetAddOnInfo
	return GetAddOnInfo(id)
end

local PIG_GetAddOnEnableState=C_AddOns and C_AddOns.GetAddOnEnableState
if PIG_GetAddOnEnableState==nil then
	local _GetAddOnEnableState = _G.GetAddOnEnableState;
	PIG_GetAddOnEnableState = function(addon, name)
		return _GetAddOnEnableState(name, addon);
	end
end
PIGGetAddOnEnableState=PIG_GetAddOnEnableState
function PIGGetAddOnMetadata(addonName, shuxing)
	local GetAddOnMetadata=GetAddOnMetadata or C_AddOns and C_AddOns.GetAddOnMetadata
	return GetAddOnMetadata(addonName, shuxing)
end
local voiceID = C_TTSSettings.GetVoiceOptionID(0)
function PIG_PlaySoundFile(url)
	if url[3] then
		if PIG_MaxTocversion() then
			C_VoiceChat.SpeakText(voiceID, url[2], 1, 2, 100)
		else
			C_VoiceChat.SpeakText(voiceID, url[2], 2, 100, false)
		end
	else
		PlaySoundFile(url[2], "Master")
	end
end
----
local InviteUnit=C_PartyInfo and C_PartyInfo.InviteUnit or InviteUnit
function PIG_InviteUnit(name)
	InviteUnit(name)
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

--获取背包信息===============
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
	if PIG_MaxTocversion("old") then
		ChatFrame_AddChannel(ChatFrame, channel)
	else
		ChatFrame:AddChannel(channel)
	end
end
function PIGChatFrameRemoveChannel(ChatFrame,channel)
	if PIG_MaxTocversion("old") then
		ChatFrame_RemoveChannel(ChatFrame,channel);
	else
		ChatFrame:RemoveChannel(channel)
	end
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
local SendAddonMessage=SendAddonMessage or C_ChatInfo and C_ChatInfo.SendAddonMessage
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