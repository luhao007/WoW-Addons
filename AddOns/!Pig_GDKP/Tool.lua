local addonName, addonTable = ...;
local GDKPInfo=addonTable.GDKPInfo
function GDKPInfo.ADD_Tool(RaidR)
	local Create, Data, Fun, L, Default, Default_Per= unpack(PIG)
	-----
	local PlayerInfo=Data.PlayerInfo
	local PIGFrame=Create.PIGFrame
	local PIGButton = Create.PIGButton
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGFontString=Create.PIGFontString
	local GnName,GnUI,GnIcon,FrameLevel = unpack(GDKPInfo.uidata)

	--回复YY
	local YYTxt=PIGButton(RaidR,{"TOPRIGHT",RaidR,"TOPRIGHT",-100,-25},{50,22},"语音")
	YYTxt:SetScript("OnClick", function (self)
		PIGSendChatRaidParty(PIGA["GDKP"]["Rsetting"]["YYneirong"])
	end);
	local YYKeyList={}
	local zidonghuifuFFF = CreateFrame("Frame")
	zidonghuifuFFF:SetScript("OnEvent",function(self, event,arg1,arg2,_,_,arg5)			
		local isLeader = UnitIsGroupLeader("player");
		if isLeader then
			if arg5==PlayerInfo.Name then return end
			if not arg1:match("[!Pig]") then
				for i=1,#YYKeyList do
					if arg1:match(YYKeyList[i]) then
						if event=="CHAT_MSG_WHISPER" then
							if IsInRaid() then
								for p=1,40 do
									local name = GetUnitName("raid"..p, true)
									if name~=nil then
										if arg2==name or arg5==name then
											SendChatMessage("[!Pig] "..PIGA["GDKP"]["Rsetting"]["YYneirong"], "WHISPER", nil, arg5);
											break
										end
									end
								end
							elseif IsInGroup() then
								for p=1,4 do
									local name = GetUnitName("party"..p, true)
									if name~=nil then
										if arg2==name or arg5==name then
											SendChatMessage("[!Pig] "..PIGA["GDKP"]["Rsetting"]["YYneirong"], "WHISPER", nil, arg5);
											break
										end
									end
								end
							end
						elseif event=="CHAT_MSG_PARTY" or event=="CHAT_MSG_PARTY_LEADER" then
							SendChatMessage("[!Pig] "..PIGA["GDKP"]["Rsetting"]["YYneirong"], "PARTY");
						elseif event=="CHAT_MSG_RAID" or event=="CHAT_MSG_RAID_LEADER" then
							SendChatMessage("[!Pig] "..PIGA["GDKP"]["Rsetting"]["YYneirong"], "RAID_WARNING");
						end
						break
					end
				end
			end
		end
	end)
	function GDKPInfo.zidonghuifuEvent()
		YYKeyList=PIGA["GDKP"]["Rsetting"]["YYguanjianzi"];
		if PIGA["GDKP"]["Rsetting"]["zidonghuifuVoice"] then
			zidonghuifuFFF:RegisterEvent("CHAT_MSG_WHISPER") 
			zidonghuifuFFF:RegisterEvent("CHAT_MSG_PARTY");
			zidonghuifuFFF:RegisterEvent("CHAT_MSG_PARTY_LEADER");
			zidonghuifuFFF:RegisterEvent("CHAT_MSG_RAID");
			zidonghuifuFFF:RegisterEvent("CHAT_MSG_RAID_LEADER");
		else
			zidonghuifuFFF:UnregisterAllEvents();
		end
	end
	GDKPInfo.zidonghuifuEvent()
	-------------
	local Check=PIGButton(RaidR,{"TOPRIGHT",RaidR,"TOPRIGHT",-30,-25},{50,22},"查账")
	Check:SetScript("OnClick", function (self)
		if self.Box:IsShown() then
			self.Box:Hide()
		else
			self.Box:ShowFun()
		end
	end);
	Check.xuanzhongID=1;
	Check.Box=PIGFrame(Check,{"TOP",RaidR,"TOP",0,-100},{300,200})
	Check.Box:PIGSetBackdrop(1)
	Check.Box:PIGClose()
	Check.Box:SetFrameLevel(FrameLevel+33)
	Check.Box:Hide()
	Check.Box.tongbu_1 = PIGCheckbutton(Check.Box,{"TOPLEFT",Check.Box,"TOPLEFT",20,-20},{"团长:",nil})
	Check.Box.tongbu_1:SetScript("OnClick", function (self)
		self:SetChecked(true)
		Check.xuanzhongID=1;
		Check.Box:tongburen()
	end);
	Check.Box.tongbu_2 = PIGFontString(Check.Box,{"LEFT",Check.Box.tongbu_1.Text,"RIGHT",0,0},NONE,"OUTLINE");

	Check.Box.tongbu_3 = PIGCheckbutton(Check.Box,{"TOPLEFT",Check.Box,"TOPLEFT",20,-50},{"战利品分配者:",nil})
	Check.Box.tongbu_3:SetScript("OnClick", function (self)
		self:SetChecked(true)
		Check.xuanzhongID=2;
		Check.Box:tongburen()
	end);
	Check.Box.tongbu_4 = PIGFontString(Check.Box,{"LEFT",Check.Box.tongbu_3.Text,"RIGHT",0,0},NONE,"OUTLINE");

	local txt1 = "同步上方选定人员的账本到本地\n以供查账，当前已有的记录将被\124cffff0000覆盖\124r"
	Check.Box.biaoti_9 = PIGFontString(Check.Box,{"TOPLEFT",Check.Box,"TOPLEFT",20,-80},txt1,"OUTLINE");
	Check.Box.biaoti_9:SetJustifyH("LEFT")

	Check.Box.save = PIGButton(Check.Box,{"TOP",Check.Box,"TOP",0,-140},{80,24},"同步账本");
	Check.Box.save:HookScript("OnClick",function (self)
		--Check.Box.qiankuan_InfoSave()
	end)
	Check.Box.save:Disable()
	function Check.Box:tongburen()
		Check.Box.tongbu_1:SetChecked(false)
		Check.Box.tongbu_3:SetChecked(false)
		if Check.xuanzhongID==1 then
			Check.Box.tongbu_1:SetChecked(true)
		elseif Check.xuanzhongID==2 then
			Check.Box.tongbu_3:SetChecked(true)
		end
	end
	local function Get_Leader_Loot()
		local Leader,Loot = nil,nil
		for raidIndex=1,40 do
			local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(raidIndex)
			if rank==2 then
				Leader=name
			end
			if isML then
				Loot=name
			end
		end
		return Leader,Loot
	end
	function Check.Box:ShowFun()
		self:tongburen()
		self:Show()
		Check.Box.tongbu_1:Disable()
		Check.Box.tongbu_3:Disable()
		Check.Box.tongbu_2:SetText(NONE)
		Check.Box.tongbu_4:SetText(NONE)
		if IsInGroup(LE_PARTY_CATEGORY_HOME) then
			local Leader,Loot = Get_Leader_Loot()
			if Leader then
				Check.Box.tongbu_1:Enable()
				Check.Box.tongbu_2:SetText(Leader)
			end
			if Loot then
				Check.Box.tongbu_3:Enable()
				Check.Box.tongbu_4:SetText(Loot)
			end
		end 
	end
	-------
	local bufenpei = {
		22726,--埃提耶什的碎片
		45038,--瓦兰奈尔的碎片
		50274,--影霜碎片
		30311,30312,30313,30314,30316,30317,30318,30319,30320,--七武器
		50226,50231,--烂肠的酸性血液/腐面的酸性血液
	}
	local function funbufenpei(itemID)
		if itemID then
			for ix=1,#bufenpei do	
				if itemID == bufenpei[ix] then
					return true
				end
			end
		end
		return false
	end
	local Get_LootMethodID=Fun.Get_LootMethodID
	local autofenffff = CreateFrame("Frame")
	autofenffff.listdata={}
	autofenffff:SetScript("OnEvent",function(self,event,arg1,_,_,_,arg5)
		if event=="LOOT_CLOSED" then
			wipe(self.listdata)
		elseif IsInGroup() then
			local lootmethodID,masterLootPartyID, masterLooterRaidID= Get_LootMethodID();
			if lootmethodID==2 and masterlooterPartyID==0 then
				local lootNum = GetNumLootItems()
				if #self.listdata==0 then
					for x=1,lootNum do
						self.listdata[x]={false,false}
						local link = GetLootSlotLink(x)
						if link then
							local itemID = PIGGetItemInfoInstant(link)
							if itemID then
								if funbufenpei(itemID) then
	
								else
									local lootIcon, lootName, lootQuantity, currencyID, lootQuality, locked, isQuestItem= GetLootSlotInfo(x)
									if locked or isQuestItem or lootQuality<GetLootThreshold() then
										
									else
										self.listdata[x][1]=true
									end
								end
							end
						end
					end
				end
				for x = 1, lootNum do
					if self.listdata[x][1] then
						local link = GetLootSlotLink(x)
						local _, _, lootQuantity= GetLootSlotInfo(x)
						if link and lootQuantity and lootQuantity>0 then
							for ci = 1, GetNumGroupMembers() do
								local candidate = GetMasterLootCandidate(x, ci)
								if candidate == PlayerInfo.Name then
									if CalculateTotalNumberOfFreeBagSlots() > 0 then
										GiveMasterLoot(x, ci);
										if PIGA["GDKP"]["Rsetting"]["autofenMsg"] then
											if not self.listdata[x][2] then
												if lootQuantity>1 then
													PIGSendChatRaidParty("拾取"..link.."×"..lootQuantity)
												else
													PIGSendChatRaidParty("拾取"..link)
												end
												self.listdata[x][2]=true
											end
										end
									end
									break
								end
							end
						end
					end
				end
			end
		end
	end)
	function GDKPInfo.AutoLootfenEvent()
		if PIGA["GDKP"]["Rsetting"]["autofen"] then
			autofenffff:RegisterEvent("LOOT_READY");
			--autofenffff:RegisterEvent("LOOT_OPENED");
			autofenffff:RegisterEvent("LOOT_CLOSED");
		else
			autofenffff:UnregisterAllEvents()
		end
	end
	GDKPInfo.AutoLootfenEvent()
end