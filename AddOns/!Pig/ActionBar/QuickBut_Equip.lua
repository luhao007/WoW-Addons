local addonName, PD = ...;
local Create = PD.Create
Create.PIGaddQuickBut(4,{
	Open=function()
		return PIGA["QuickBut"]["Open"] and PIGA["QuickBut"]["Equip"]
	end,
	Icon=133122,
	Tooltip = KEY_BUTTON1.."-|cff00FFFF展开切换按钮|r\n"..KEY_BUTTON2.."-|cff00FFFF卸下身上有耐久装备|r",
	fun=function(AutoEquip,QuickButUI)
		if PIG_MaxTocversion(30000) and not PIGA["FramePlus"]["Character_Shuxing"] then return end	
		local PIGFrame=Create.PIGFrame
		local PIGQuickBut=Create.PIGQuickBut
		local PIGCheckbutton=Create.PIGCheckbutton
		local PIGCheckbutton_R=Create.PIGCheckbutton_R
		local PIGFontString=Create.PIGFontString
		--
		local Data=PD.Data
		local Fun=PD.Fun
		local InvSlot=Data.InvSlot
		---1装备按钮
		local PIG_EquipmentData = {
			["anniushu"]=MAX_EQUIPMENT_SETS_PER_PLAYER+2,
			["zhuangbeixilieID"]=Data.InvSlot.Name,
			["NumTexCoord"]=Data.EquipmentPIG["NumTexCoord"],
			["Equip_Save"]=Data.EquipmentPIG["Equip_Save"],
			["Equip_Use"]=Data.EquipmentPIG["Equip_Use"],
		};
		-------
		local ClickTooltip ="《"..CHARACTER_INFO.."C键》界面管理配装"
		--local AutoEquip=PIGQuickBut(GnUI,Tooltip,Icon)
		AutoEquip.tips = PIGFontString(AutoEquip,nil,"没有已保存的配装，\n"..ClickTooltip,"OUTLINE");
		AutoEquip.tips:SetTextColor(1, 0, 0, 1)
		AutoEquip.tips:Hide()
		--
		local talentSpecInfoCache = {
			[1]	= {},
			[2]	= {},
		};
		local TALENT_UI_SPECS = {
			[1] = {
				name = TALENT_SPEC_PRIMARY,
				color = "FFFF00",
			},
			[2] = {
				name = TALENT_SPEC_SECONDARY,
				color = "00FFFF",
			},
		};
		local butW = QuickButUI.butWWW
		local AutoEquipList = PIGFrame(AutoEquip,{"BOTTOM",AutoEquip,"TOP",0,0},{butW, butW})
		AutoEquipList:SetFrameLevel(23)
		AutoEquipList.ButList={}
		local function add_hangUI(cunzainum)
			if not AutoEquipList.ButList[cunzainum] then
				local EquipBut = PIGFrame(AutoEquipList,nil,{butW, butW-4})
				EquipBut:Hide()
				AutoEquipList.ButList[cunzainum]=EquipBut
				EquipBut:PIGSetBackdrop(0.2,0.2)
				EquipBut.NormalTex = EquipBut:CreateTexture(nil, "OVERLAY");
				if PIG_MaxTocversion(30000) and cunzainum<=MAX_EQUIPMENT_SETS_PER_PLAYER then
					EquipBut.NormalTex:SetTexture("interface/timer/bigtimernumbers.blp");
				end
				EquipBut.NormalTex:SetAllPoints(EquipBut)
				EquipBut.Highlight = EquipBut:CreateTexture(nil, "Highlight");
				EquipBut.Highlight:SetTexture(130718);
				EquipBut.Highlight:SetAllPoints(EquipBut)
				EquipBut.Highlight:SetBlendMode("ADD")
				EquipBut.Down = EquipBut:CreateTexture(nil, "OVERLAY");
				EquipBut.Down:SetTexture(130839);
				EquipBut.Down:SetAllPoints(EquipBut)
				EquipBut.Down:Hide();
				EquipBut.name = PIGFontString(EquipBut,nil,nil,"OUTLINE")
				EquipBut.name:SetTextColor(1, 1, 1, 1)

				EquipBut:HookScript("OnMouseDown", function (self)
					self.Down:Show();
					GameTooltip:ClearLines();
					GameTooltip:Hide() 
				end);
				EquipBut:HookScript("OnMouseUp", function (self,button)
					self.Down:Hide();
					PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
					if self.mode==1 then
						if PIG_MaxTocversion(30000) then
							if button=="LeftButton" then
								PIG_EquipmentData.Equip_Use(self.id)
							else
								PIG_EquipmentData.Equip_Save(self.id)
							end
						else
							if self.id and self.id>=0 then
								local name = C_EquipmentSet.GetEquipmentSetInfo(self.id)
								if button=="LeftButton" then
									if IsShiftKeyDown() then
										PIGA_Per["QuickBut"]["TalentEquip"][1]=self.id
										PIGErrorMsg(name..KEY_BINDINGS_MAC..TALENT_SPEC_PRIMARY)
									else
										if InCombatLockdown() then PIGErrorMsg(CANNOT_UNEQUIP_COMBAT) return end
										C_EquipmentSet.UseEquipmentSet(self.id)
										PIGErrorMsg("更换<"..name..">配装成功")
									end
								else
									if IsShiftKeyDown() then
										PIGA_Per["QuickBut"]["TalentEquip"][2]=self.id
										PIGErrorMsg(name..KEY_BINDINGS_MAC..TALENT_SPEC_SECONDARY)
									else
										--C_EquipmentSet.UnassignEquipmentSetSpec(i-1)
										C_EquipmentSet.SaveEquipmentSet(self.id)
										PIGErrorMsg("当前装备已保存到<"..name..">配装")
									end
								end
							-- else
							-- 	if InCombatLockdown() then
							-- 		PIGErrorMsg(CANNOT_UNEQUIP_COMBAT)
							-- 	else
							-- 		ShowUIPanel(CharacterFrame);
							-- 		if PIG_MaxTocversion() then
							-- 			GearManagerDialog:Show();
							-- 			GearManagerDialogSaveSet_OnClick()
							-- 		else
							-- 			PaperDollFrame_SetSidebar(self, 3);
							-- 			GearManagerPopupFrame.mode=1;
							-- 			PaperDollFrame.EquipmentManagerPane.selectedSetID = nil;
							-- 			--GearManagerPopupFrame.setID=self.id;
							-- 			PaperDollFrame_ClearIgnoredSlots();
							-- 			PaperDollEquipmentManagerPane_Update();
							-- 			PaperDollFrame_IgnoreSlot(4);
							-- 			PaperDollFrame_IgnoreSlot(19);
							-- 			GearManagerPopupFrame:Show();
							-- 			GearManagerPopupFrame:Update()
							-- 		end
							-- 	end
							end
						end
					else
						if button=="LeftButton" then
							if self.active then
								PIGErrorMsg(TALENT_UI_SPECS[self.id].name..ACTIVE_PETS,"R")
							else
								if PIGA_Per["QuickBut"]["TalentEquip"][self.id] then
									if PIG_MaxTocversion(30000) then
										PIG_EquipmentData.Equip_Use(self.id)
									else
										C_EquipmentSet.UseEquipmentSet(PIGA_Per["QuickBut"]["TalentEquip"][self.id])
									end
								end
								C_SpecializationInfo.SetActiveSpecGroup(self.id);
								PIGErrorMsg("更换<"..TALENT_UI_SPECS[self.id].name..">+配装")
							end
						else
							C_SpecializationInfo.SetActiveSpecGroup(self.id);
							PIGErrorMsg("更换<"..TALENT_UI_SPECS[self.id].name)
						end
					end
					AutoEquipList:Hide()
				end);
				EquipBut:HookScript("OnEnter", function (self)
					if AutoRuneListUI and AutoRuneListUI:IsShown() then AutoEquip.xuyaoShow=true;AutoRuneListUI:Hide() end
					AutoEquipList:Show()
					GameTooltip:ClearLines();
					GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",20,0);
					if self.mode==1 then
						GameTooltip:AddLine(KEY_BUTTON1.."-|cff00FFFF切换配装|r\n"..KEY_BUTTON2.."-|cff00FFFF保存配装|r\nShift+"..KEY_BUTTON1.."-|cff00FFFF"..KEY_BINDINGS_MAC..TALENT_SPEC_PRIMARY.."|r\nShift+"..KEY_BUTTON2.."-|cff00FFFF"..KEY_BINDINGS_MAC..TALENT_SPEC_SECONDARY.."|r")
					else
						GameTooltip:AddLine(KEY_BUTTON1.."-|cff00FFFF切换天赋+配装|r\n"..KEY_BUTTON2.."-|cff00FFFF切换天赋|r")
					end
					GameTooltip:Show();
				end);
				EquipBut:HookScript("OnLeave", function ()
					GameTooltip:ClearLines();
					GameTooltip:Hide()
					AutoEquipList:Hide()
				end);
			end
		end
		--
		AutoEquipList:HookScript("OnEnter", function(self,button)
			if AutoRuneListUI and AutoRuneListUI:IsShown() then AutoEquip.xuyaoShow=true;AutoRuneListUI:Hide() end
			AutoEquipList:Show()
		end)
		AutoEquipList:HookScript("OnLeave", function(self,button)
			AutoEquipList:Hide()
		end)
		AutoEquipList:HookScript("OnHide", function(self)
			if AutoEquip.xuyaoShow then AutoRuneListUI:Show() end
		end)
		AutoEquip:SetScript("OnEnter", function(self)
			self.cunzainum=0
			if AutoRuneListUI and AutoRuneListUI:IsShown() then AutoEquip.xuyaoShow=true;AutoRuneListUI:Hide() end
			for _,but in pairs(AutoEquipList.ButList) do
				but:Hide()
			end
			if PIG_MaxTocversion(30000) then
				local DataXXX = PIGA_Per["QuickBut"]["EquipList"]
				for id = 1, MAX_EQUIPMENT_SETS_PER_PLAYER do
					if DataXXX[id] then
						self.cunzainum=self.cunzainum+1
						add_hangUI(self.cunzainum)
						local fujikj = AutoEquipList.ButList[self.cunzainum]
						if DataXXX[id][2] then
							fujikj.mode=1
							fujikj:Show()
							fujikj.id=id
							fujikj.NormalTex:SetTexCoord(PIG_EquipmentData.NumTexCoord[id][1],PIG_EquipmentData.NumTexCoord[id][2],PIG_EquipmentData.NumTexCoord[id][3],PIG_EquipmentData.NumTexCoord[id][4]);
							fujikj.name:SetText(DataXXX[id][1]);
						end
					end
				end
			else
				local equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs()
				for id = 1, #equipmentSetIDs do
					if equipmentSetIDs[id] then
						self.cunzainum=self.cunzainum+1
						add_hangUI(self.cunzainum)
						local fujikj = AutoEquipList.ButList[self.cunzainum]
						fujikj.mode=1
						fujikj:Show()
						fujikj.id=equipmentSetIDs[id]
						local name, iconFileID = C_EquipmentSet.GetEquipmentSetInfo(equipmentSetIDs[id])
						fujikj.NormalTex:SetTexture(iconFileID);
						fujikj.name:SetText(name);
					end
				end
			end
			local numTalentGroups = PIG_MaxTocversion(40000) and GetNumTalentGroups(false, false) or GetNumSpecGroups()
			local activeTalentGroup= C_SpecializationInfo.GetActiveSpecGroup(false, false)
			if numTalentGroups>1 then
				for GroupID=1,numTalentGroups do	
					self.cunzainum=self.cunzainum+1
					add_hangUI(self.cunzainum)
					local fujikj = AutoEquipList.ButList[self.cunzainum]
					fujikj.mode=2
					fujikj.id=GroupID
					fujikj.active=GroupID==activeTalentGroup
					fujikj:Show()
					TalentFrame_UpdateSpecInfoCache(talentSpecInfoCache[GroupID],  nil, nil, GroupID)
					local specInfoCache = talentSpecInfoCache[GroupID];
					if ( specInfoCache.primaryTabIndex and specInfoCache.primaryTabIndex > 0 ) then
						fujikj.NormalTex:SetTexture(specInfoCache[specInfoCache.primaryTabIndex].icon);
					else
						fujikj.NormalTex:SetTexture("Interface/Icons/Ability_Marksmanship");
					end
					local spec = TALENT_UI_SPECS[GroupID];
					local tishixx=GroupID==activeTalentGroup and "|cff00FF00("..ACTIVE_PETS..")|r" or ""
					local newEQname="未绑定配装"
					if PIGA_Per["QuickBut"]["TalentEquip"][GroupID] then
						local EQname= C_EquipmentSet.GetEquipmentSetInfo(PIGA_Per["QuickBut"]["TalentEquip"][GroupID])
						if EQname then
							newEQname=EQname
						end
					end
					fujikj.name:SetText("|cff"..TALENT_UI_SPECS[GroupID].color..spec.name..tishixx.."|r\n"..newEQname)
				end
			end
			AutoEquipList:SetShown(self.cunzainum>0)
			self.tips:SetShown(self.cunzainum==0)
			QuickButUI:UpdatePointJustify(AutoEquip,{AutoEquipList,AutoEquip.tips},butW)
		end)
		AutoEquip:HookScript("OnLeave", function(self)
			AutoEquipList:Hide()
			self.tips:Hide()
		end)
		AutoEquip:HookScript("OnClick", function(self,button)
			if button=="LeftButton" then
				PIGErrorMsg("右键卸下全部有耐久装备\n"..ClickTooltip)
			else
				if InCombatLockdown() then PIGErrorMsg(CANNOT_UNEQUIP_COMBAT) return end
				PIG_EquipmentData.InventoryNum={}
				for inv = 1, 19 do
					if PIG_EquipmentData.zhuangbeixilieID[inv][4] then
						if GetInventoryItemID("player",inv) then
							table.insert(PIG_EquipmentData.InventoryNum,inv)
						end
					end
				end
				PIG_EquipmentData.konggelist={}
				for bagID=0,4 do
					local numberOfFreeSlots, bagType = PIGGetContainerNumFreeSlots(bagID)
					if numberOfFreeSlots>0 and bagType==0 then
						for ff=1,PIGGetContainerNumSlots(bagID) do
							if PIGGetContainerItemID(bagID, ff) then
							else
								table.insert(PIG_EquipmentData.konggelist,{bagID,ff})
								if #PIG_EquipmentData.konggelist>=#PIG_EquipmentData.InventoryNum then
									break
								end
							end
						end
					end
					if #PIG_EquipmentData.konggelist>=#PIG_EquipmentData.InventoryNum then
						break
					end
				end
				for xuhao = 1, #PIG_EquipmentData.konggelist do
					local invv = PIG_EquipmentData.InventoryNum[xuhao]
					local isLocked2 = IsInventoryItemLocked(invv)
					if not isLocked2 then
						PickupInventoryItem(invv)
						PIGPickupContainerItem(PIG_EquipmentData.konggelist[xuhao][1], PIG_EquipmentData.konggelist[xuhao][2])
					end
				end
				if #PIG_EquipmentData.konggelist<#PIG_EquipmentData.InventoryNum then
					PIGErrorMsg(ERR_EQUIPMENT_MANAGER_BAGS_FULL)
				else
					PIGErrorMsg("已卸下全部有耐久装备")
				end
				AutoEquipList:Hide()
			end
		end);
	end,
})