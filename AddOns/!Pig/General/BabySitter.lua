local _, PD = ...;
local GeneralFun=PD.GeneralFun
-----------------
local GNopen=PIG_MaxTocversion(40000)
function GeneralFun.BabySitter()
	if not GNopen then return end
	local L=PD.locale
	local Data=PD.Data
	--------
	local Create=PD.Create
	local PIGFrame=Create.PIGFrame
	local PIGButton=Create.PIGButton
	local PIGEnter=Create.PIGEnter
	local PIGDiyBut=Create.PIGDiyBut
	local PIGSlider=Create.PIGSlider
	local PIGCheckbutton_R=Create.PIGCheckbutton
	local PIGCheckbutton_R=Create.PIGCheckbutton_R
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGFontString=Create.PIGFontString
	--
	local Fun=PD.Fun
	local ActionFun=Fun.ActionFun
	local bagData=Data.bagData
	local PlayerInfo=Data.PlayerInfo
	local zhanshitouzhiOK
	--远程武器弹药
	local function GetammoMinNum(ammoMin1, ammoMin2)
		PIGA["CombatPlus"]["ammoMin1"]=ammoMin1 or PIGA["CombatPlus"]["ammoMin1"]
		PIGA["CombatPlus"]["ammoMin2"]=ammoMin2 or PIGA["CombatPlus"]["ammoMin2"]
		return PIGA["CombatPlus"]["ammoMin1"] or 60,PIGA["CombatPlus"]["ammoMin2"] or 600
	end
	local function event_Script()
		if not GeneralFun.ammotips then return end
		local resting = IsResting()
		if resting then
			local tipsShow=false
			local tipsShowicon=134400
			local itemId= GetInventoryItemID("player", 18)
			if itemId then
				local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subclassID = PIGGetItemInfoInstant(itemId) 
				if classID==2 then--武器
					local ammoMin1,ammoMin2 = GetammoMinNum()
					if subclassID==16 then--投掷
						local xxxx = GetInventoryItemCount("player", 18)
						GeneralFun.ammotips:SetNormalTexture(135426)--投掷刀
						GeneralFun.ammotips.t:SetText(ACTION_SPELL_ENERGIZE..INVTYPE_THROWN..WEAPON)
						GeneralFun.ammotips:SetShown(xxxx<ammoMin1)
					elseif subclassID==2 or subclassID==3 or subclassID==18 then--弓/枪/弩
						tipsShowicon=132382
						local xxxx = GetInventoryItemCount("player", 0)
						if xxxx<ammoMin2 then
							tipsShow=true
						end
						if subclassID==3 then
							tipsShowicon=132384
						end
						GeneralFun.ammotips:SetNormalTexture(tipsShowicon)
						GeneralFun.ammotips.t:SetText(ACTION_SPELL_ENERGIZE..AMMOSLOT)
						GeneralFun.ammotips:SetShown(tipsShow)
					end	
				end
			else
				tipsShowicon=135426
				if GeneralFun.classId==3 then
					tipsShow,tipsShowicon=true,136520
				elseif GeneralFun.classId==4 then
					tipsShow=true
				elseif GeneralFun.classId==1 and zhanshitouzhiOK then
					tipsShow=true
				end
				if tipsShow then
					GeneralFun.ammotips:SetNormalTexture(tipsShowicon)
					GeneralFun.ammotips.t:SetText(L["BABY_TISPAMMO1"])
					GeneralFun.ammotips:Show()
				end
			end
		end
	end
	local function Class_Load()
		local numSkills = GetNumSkillLines();
		for x=1,numSkills do
			local skillName = GetSkillLineInfo(x);
			if skillName==INVTYPE_THROWN..WEAPON then
				zhanshitouzhiOK=true
				break
			end
		end
		event_Script()
	end	
	local function AmmotipsFun(ly)
		if PIG_MaxTocversion(20000,true) then return end
		if not PIGA["CombatPlus"]["ammotips"] then return end
		if GeneralFun.ammotips then return end
		local classId=PlayerInfo.ClassData.classId
		GeneralFun.classId=classId
		--职业编号1战士/2圣骑士/3猎人/4盗贼/5牧师/6死亡骑士/7萨满祭司/8法师/9术士/10武僧/11德鲁伊/12恶魔猎手
		if not classId and classId~=1 and classId~=3 and classId~=4 then return end
		local ammotips=CreateFrame("Button", nil, UIParent)
		GeneralFun.ammotips=ammotips
		ammotips:SetSize(30,30);
		ammotips:SetPoint("TOP",UIParent,"TOP",-80,-200);
		ammotips:Hide();
		ammotips:SetFrameStrata("LOW")
		ammotips.t = PIGFontString(ammotips,{"LEFT",ammotips,"RIGHT", 0, 0},"","OUTLINE",24)
		ammotips.t:SetTextColor(1, 0, 0, 1);
		--
		if ly then Class_Load() end
		ammotips:RegisterEvent("PLAYER_ENTERING_WORLD")
		ammotips:RegisterEvent("PLAYER_UPDATE_RESTING");
		ammotips:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
		ammotips:RegisterEvent("UNIT_INVENTORY_CHANGED","player");
		ammotips:HookScript("OnEvent", function(self,event,arg1,arg2,arg3)
			self:Hide()
			if event=="PLAYER_ENTERING_WORLD" then
				Class_Load()
			elseif event=="PLAYER_UPDATE_RESTING" or event=="UNIT_INVENTORY_CHANGED" then
				C_Timer.After(0.4,event_Script)
			elseif event=="PLAYER_EQUIPMENT_CHANGED" then
				if arg1==18 or arg1==0 then 
					C_Timer.After(0.4,event_Script)
				end
			end
		end)
	end
	--呼吸提示
	local function SubmergedFun(ly)
		if PIG_MaxTocversion(20000,true) then return end
		local warnUI = CreateFrame("Frame", nil, UIParent);
		warnUI:SetAllPoints(UIParent)
		warnUI.alltex = warnUI:CreateTexture(nil, "BACKGROUND");
		warnUI.alltex:SetTexture("Interface/FullScreenTextures/LowHealth");
		warnUI.alltex:SetBlendMode("ADD")
		warnUI.alltex:SetAllPoints(warnUI)
		warnUI:Hide()
		warnUI.pulseAnim = warnUI:CreateAnimationGroup()
		warnUI.pulseAnim.AlphaAnim = warnUI.pulseAnim:CreateAnimation("Alpha")
		warnUI.pulseAnim.AlphaAnim:SetFromAlpha(1)
		warnUI.pulseAnim.AlphaAnim:SetToAlpha(0.2)
		warnUI.pulseAnim.AlphaAnim:SetDuration(0.5236)
		warnUI.t = PIGFontString(warnUI,{"CENTER",warnUI,"CENTER", 0, 40},"","OUTLINE",28)
		warnUI.t:SetTextColor(1, 1, 0, 1);
		for index=1, MIRRORTIMER_NUMTIMERS do
			_G["MirrorTimer"..index]:HookScript("OnHide", function(self)
				warnUI:Hide()
			end)
			_G["MirrorTimer"..index]:HookScript("OnUpdate", function(self,elapsed)
				if self.timer=="BREATH" then
					if self.value<10 then
						warnUI:Show()
						warnUI.pulseAnim:Play()
						warnUI.t:SetText(L["BABY_TISPSUBMERGED1"])
					else
						warnUI:Hide()
						warnUI.pulseAnim:Stop()
					end
				elseif self.timer=="EXHAUSTION" then
					if self.value<10 then
						warnUI:Show()
						warnUI.pulseAnim:Play()
						warnUI.t:SetText(L["BABY_TISPSUBMERGED2"])
					else
						warnUI:Hide()
						warnUI.pulseAnim:Stop()
					end
				end
			end)
		end
	end
	--宠物喂食
	local function PetHappinessFun()
		local _, classId = UnitClassBase("player");
		if classId~=3 then return end
		if PIG_MaxTocversion(40000,true) then return end
		if not PIGA["CombatPlus"]["PetHappiness"] then return end
		if PetFrameHappiness.Action_l then return end
		local Tooltip = KEY_BUTTON1.."-|cff00FFFF"..L["BABY_PETHAPPINESS2"].."|r\r|r"..KEY_BUTTON2.."-|cff00FFFF"..L["BABY_PETHAPPINESS3"].."|r"
		local butW = PetFrameHappiness:GetWidth()
		local Action_l=PIGDiyBut(mubiaoUI,nil,{butW,butW,nil,nil,132165},nil,"SecureActionButtonTemplate")
		ActionFun.PIGUseKeyDown(Action_l)
		PetFrameHappiness.Action_l=Action_l
		Action_l:SetAttribute("type1", "spell");
		PIGEnter(Action_l,Tooltip)
		Action_l.Count = PIGFontString(Action_l,{"BOTTOMRIGHT", Action_l, "BOTTOMRIGHT", 0, 1},nil,"OUTLINE")
		Action_l.Count:SetTextColor(1, 1, 1, 1);
		---
		Action_l.Bar = CreateFrame("StatusBar", nil, Action_l);
		Action_l.Bar:SetStatusBarTexture("interface/chatframe/chatframebackground.blp")
		Action_l.Bar:SetStatusBarColor(0, 0.8, 0 ,0.5);
		Action_l.Bar:SetSize(102,20);
		Action_l.Bar:SetPoint("TOPRIGHT",Action_l,"BOTTOMRIGHT",-3,-1);
		Action_l.Bar:Hide()
		Action_l.Bar.bg = Action_l.Bar:CreateTexture(nil, "BACKGROUND");
		Action_l.Bar.bg:SetTexture("interface/characterframe/ui-party-background.blp");
		Action_l.Bar.bg:SetPoint("TOPLEFT",Action_l.Bar,"TOPLEFT",0,0);
		Action_l.Bar.bg:SetPoint("BOTTOMRIGHT",Action_l.Bar,"BOTTOMRIGHT",0,0);
		Action_l.Bar.bg:SetAlpha(0.6)
		Action_l.Bar.txt = PIGFontString(Action_l.Bar,{"CENTER",Action_l.Bar,"CENTER", 0, 0},"","OUTLINE")
		Action_l.Bar.txt:SetTextColor(1, 1, 1 ,0.9);
		Action_l.Bar.spellicon = Action_l.Bar:CreateTexture();
		Action_l.Bar.spellicon:SetSize(20,20);
		Action_l.Bar.spellicon:SetPoint("RIGHT",Action_l.Bar,"LEFT",-0.6, 0);
		Action_l.Bar.spellicon:SetTexture(132165);
		local function Update_bar()
			for j = 1, 4, 1 do
				local Aura=C_UnitAuras.GetAuraDataByIndex("pet", j)
				if Aura and Aura.spellId==1539 then
					Action_l.Bar:SetMinMaxValues(0, Aura.duration)
					local time=floor(Aura.expirationTime-GetTime())
					Action_l.Bar.txt:SetText(time.."/"..Aura.duration)
					Action_l.Bar:SetValue(time);
					Action_l.Bar:Show()
					return
				end
			end
			Action_l.Bar:Hide()
		end
		Action_l.Bar.oldtime=0
		Action_l.Bar:HookScript("OnUpdate",  function (self,sss)
			self.oldtime=self.oldtime+sss
			if self.oldtime>0.2 then
				self.oldtime=0
				Update_bar()
			end
		end);
		Action_l.Bar:RegisterUnitEvent("UNIT_AURA","pet");
		Action_l.Bar:HookScript("OnEvent",  function (self,event)
			Update_bar()
		end);
		--
		local butNum = {1,20,butW*1.6,10}
		local function add_SeleceFoodF()
			if Action_l.SeleceFoodF then return end
			Action_l.SeleceFoodF = PIGFrame(Action_l,{"TOPLEFT",Action_l, "TOPRIGHT", 0, 0},{(butNum[3]+2)*butNum[4]+6,(butNum[3]+2)*4+8})
			Action_l.SeleceFoodF:PIGSetBackdrop()
			Action_l.SeleceFoodF:Hide()
			Action_l.SeleceFoodF:PIGClose(butW*1.2,butW*1.2)
			Action_l.SeleceFoodF.Close:SetPoint("TOPRIGHT",Action_l.SeleceFoodF,"TOPRIGHT",butW*1.2,0);
			Action_l.SeleceFoodF.ButLsit={}
			for i=1,butNum[1] do
				local butx=PIGDiyBut(Action_l.SeleceFoodF,{"TOPLEFT", Action_l.SeleceFoodF, "TOPLEFT", 0, -(i-1)*butNum[3]},{butNum[3],butNum[3],nil,nil,132165})
				Action_l.SeleceFoodF.ButLsit[i]=butx
				butx.Count = PIGFontString(butx,{"BOTTOMRIGHT", butx, "BOTTOMRIGHT", 0, 1},0,"OUTLINE")
				butx.Count:SetTextColor(1, 1, 1, 1);
				butx.liv = PIGFontString(butx,{"TOPLEFT", butx, "TOPLEFT", 1, 0},0,"OUTLINE")
				butx.liv:SetTextColor(1, 1, 1, 1);
				butx:HookScript("OnClick", function(self)
					PIGA_Per["CombatPlus"]["PetFoodList"][i]=nil
					Action_l.SeleceFoodF:ShowItemList()
				end);
				butx:Hide()
				Action_l.SeleceFoodF.ButLsit[i].ButLsit={}
				for ix=1,butNum[2] do
					local butxx=PIGDiyBut(Action_l.SeleceFoodF,nil,{butNum[3],butNum[3],nil,nil,132165})
					Action_l.SeleceFoodF.ButLsit[i].ButLsit[ix]=butxx
					if ix==1 then
						butxx:SetPoint("LEFT", butx, "LEFT", 4, -4);
					else
						local _,tmp2 = math.modf((ix-1)/butNum[4])
						if tmp2==0 then
							butxx:SetPoint("TOP", Action_l.SeleceFoodF.ButLsit[i].ButLsit[ix-butNum[4]], "BOTTOM", 0, -2);
						else
							butxx:SetPoint("LEFT", Action_l.SeleceFoodF.ButLsit[i].ButLsit[ix-1], "RIGHT", 2, 0);
						end
					end
					butxx.Count = PIGFontString(butxx,{"BOTTOMRIGHT", butxx, "BOTTOMRIGHT", 0, 1},0,"OUTLINE")
					butxx.Count:SetTextColor(1, 1, 1, 1);
					butxx.liv = PIGFontString(butxx,{"TOPLEFT", butxx, "TOPLEFT", 1, 0},0,"OUTLINE")
					butxx.liv:SetTextColor(1, 1, 1, 1);
					butxx.selectz = butxx:CreateTexture("OVERLAY");
					butxx.selectz:SetDrawLayer("OVERLAY", 3)
					butxx.selectz:SetTexture(136814);
					butxx.selectz:SetPoint("TOPLEFT", butxx, "TOPLEFT",butW*0.16,-butW*0.16);
					butxx.selectz:SetPoint("BOTTOMRIGHT", butxx, "BOTTOMRIGHT",-butW*0.16,butW*0.16);
					butxx:HookScript("OnEnter", function(self)
						if self.bag and self.slot then
							GameTooltip:ClearLines();
							GameTooltip:SetOwner(self, "ANCHOR_NONE");
							GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT",0,0);
							GameTooltip:SetBagItem(self.bag,self.slot);
							GameTooltip:Show();
						end
					end);
					butxx:HookScript("OnLeave", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);	
					butxx:HookScript("OnClick", function(self)
						PIGA_Per["CombatPlus"]["PetFoodList"][i]=self.itemID
						Action_l.SeleceFoodF:ShowItemList()
					end); 
				end
			end
			function Action_l.SeleceFoodF:ShowItemList()
				self:Show()
				for i=1,butNum[1] do
					local butx=self.ButLsit[i]
					butx:Disable()
					butx.icon:SetTexture(132165)
					butx.Count:SetText("")
					butx.liv:SetText("")
					for ix=1,butNum[2] do
						self.ButLsit[i].ButLsit[ix].selectz:Hide()
						self.ButLsit[i].ButLsit[ix]:Hide()
					end
				end
				Action_l:GetBagItemData()
				local cfitem=PIGA_Per["CombatPlus"]["PetFoodList"]
				for i=1,butNum[1] do
					if cfitem[i] then
						local butx=self.ButLsit[i]
						butx:Enable()
						local itemID, itemType, itemSubType, itemEquipLoc, icon= PIGGetItemInfoInstant(cfitem[i]) 
						butx.icon:SetTexture(icon)
						local effectiveILvl, isPreview, baseILvl = PIGGetDetailedItemLevelInfo(cfitem[i])
						butx.liv:SetText(effectiveILvl)
						local ItemCount = C_Item.GetItemCount(cfitem[i])
						if ItemCount>0 then
							butx.Count:SetText(ItemCount)
						else
							butx.Count:SetText("|cffff00000|r")
						end
					end
					local bagnumx = #Action_l.BagItmes
					for ix=1,bagnumx do
						local butxx=self.ButLsit[i].ButLsit[ix]
						butxx:Show()
						local itemID, itemLink, icon, stackCount, quality=PIGGetContainerItemInfo(Action_l.BagItmes[ix][1],Action_l.BagItmes[ix][2])
						butxx.icon:SetTexture(icon)
						butxx.Count:SetText(stackCount)
						local effectiveILvl, isPreview, baseILvl = PIGGetDetailedItemLevelInfo(itemID)
						butxx.liv:SetText(effectiveILvl)
						butxx.itemID=itemID
						butxx.bag=Action_l.BagItmes[ix][1]
						butxx.slot=Action_l.BagItmes[ix][2]
						if itemID==cfitem[i] then
							butxx.selectz:Show()
						end
					end
				end
				Action_l:PIGSetActionItemID()
			end
		end
		--
		local function GetFoodType()
			local list = {}
			local StableFoodList = {GetStablePetFoodTypes(0)}
			for k,v in pairs(StableFoodList) do
				if FoodIndex[v] then
					for kk,vv in pairs(FoodList[FoodIndex[v]]) do
						list[kk]=vv
					end
				end
			end
			return list
		end
		local function IsFoodType(itemID)
			local FoodData=GetFoodType()
			for k,v in pairs(FoodData) do
				if k==itemID then
					return itemID,v
				end
			end
			return false
		end
		local function IsItemOK(itemID,duibidata)
			for i=1,#duibidata do
				if itemID==duibidata[i][3] then
					return true
				end
			end
			return false
		end
		Action_l.BagItmes={}
		function Action_l:GetBagItemData()
			wipe(self.BagItmes)
			for bag=1,#bagData["bagID"] do
				for slot=1,PIGGetContainerNumSlots(bagData["bagID"][bag]) do
					local itemID = PIGGetContainerItemID(bagData["bagID"][bag],slot)
					if itemID then
						local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subclassID = PIGGetItemInfoInstant(itemID) 
						if classID==0 or classID==7 then
							if not IsItemOK(itemID,self.BagItmes) then
								table.insert(self.BagItmes,{bagData["bagID"][bag],slot,itemID})
							end
						end
					end
				end
			end
		end
		Action_l:GetBagItemData()
		function Action_l:PIGResetAction()
			self.itemID=nil
			self.slotID=nil
			self.itemID=nil
			self.icon:SetTexture(132165);
			self.icon:SetVertexColor(0.5, 0.5, 0.5) 
			self.Count:SetText("|cffff00000|r");
		end
		function Action_l:PIGSetIconCount()
			self.icon:SetVertexColor(0.5, 0.5, 0.5) 
			if self.itemID then
				if C_Item and C_Item.GetItemIconByID then
					local icon = C_Item.GetItemIconByID(self.itemID)
					self.icon:SetTexture(icon)
				end
				local ItemCount = C_Item.GetItemCount(self.itemID)
				self.Count:SetText(ItemCount or 0)
				local usable, noMana = IsUsableSpell(6991)	
				if usable then self.icon:SetVertexColor(1, 1, 1) end
			end	
		end
		function Action_l:PIGSetActionItemID()
			self:PIGResetAction()
			if self:IsSetFoodList() then
				self:GetBagItemData()
				local cfitem=PIGA_Per["CombatPlus"]["PetFoodList"]
				for i=1,butNum[1] do
					if cfitem[i] then
						for ix=1,#Action_l.BagItmes do
							if cfitem[i]==Action_l.BagItmes[ix][3] then
								self.bagID=Action_l.BagItmes[ix][1]
								self.slotID=Action_l.BagItmes[ix][2]
								self.itemID=Action_l.BagItmes[ix][3]
								self:PIGSetIconCount()
								return
							end
						end
					end
				end
			end
		end
		function Action_l:PIGSetSpellName()
			if IsPlayerSpell(6991) then
				local SpellName = GetSpellInfo(6991);
				self.SpellName=SpellName
				self:SetAttribute("spell1", self.SpellName);
				return true
			end
			return false
		end
		function Action_l:IsSetFoodList()
			local cfitem=PIGA_Per["CombatPlus"]["PetFoodList"]
			for i=1,butNum[1] do
				if cfitem[i] then
					return true
				end
			end
			return false
		end
		-- print(GetPetLoyalty())
		-- print(GetPetHappiness())
		-- print(GetPetFoodTypes())
		Action_l:HookScript("PreClick",  function (self,button)
			if InCombatLockdown() then return end
			if button=="LeftButton" then
				if not self:PIGSetSpellName() then
					PIGErrorMsg("<"..self.SpellName..">"..SPELL_FAILED_SKILL_LINE_NOT_KNOWN)
					return
				end
				if not self:IsSetFoodList() then
					PIGErrorMsg(L["BABY_PETHAPPINESS4"])
					return
				end
				self:PIGSetActionItemID()
				if self.itemID then
					self:SetAttribute("target-bag", self.bagID);
					self:SetAttribute("target-slot", self.slotID);
				else
					PIGErrorMsg(L["BABY_PETHAPPINESS5"] )
					return
				end
			end
		end);
		Action_l:SetScript("PostClick",  function (self)
			self:SetAttribute("target-bag", nil);
			self:SetAttribute("target-slot", nil);
		end);
		local WowHeight=GetScreenHeight();
		Action_l:HookScript("OnClick", function(self,button,arg1)
			if button=="RightButton" and arg1==false then
				add_SeleceFoodF()
				if self.SeleceFoodF:IsShown() then
					self.SeleceFoodF:Hide()
				else
					local offset1 = self:GetBottom();
					self.SeleceFoodF:ClearAllPoints();
					if offset1>(WowHeight*0.5) then
						self.SeleceFoodF:SetPoint("TOPLEFT",Action_l, "TOPRIGHT", 0, 0)
					else
						self.SeleceFoodF:SetPoint("BOTTOMLEFT",Action_l, "BOTTOMRIGHT", 0, 0)
					end
					self.SeleceFoodF:SetFrameStrata("HIGH")
					self.SeleceFoodF:ShowItemList()
				end
			end
		end); 
		Action_l:RegisterEvent("PLAYER_ENTERING_WORLD")
		Action_l:RegisterEvent("PLAYER_REGEN_DISABLED")
		Action_l:RegisterEvent("PLAYER_REGEN_ENABLED")
		Action_l:RegisterEvent("UNIT_PET")
		Action_l:HookScript("OnEvent",  function (self,event)
			if event=="PLAYER_ENTERING_WORLD" then
				self:RegisterEvent("BAG_UPDATE");
			end
			self:PIGSetActionItemID()
		end);
		local function Update_PointXY()
			if Fun.IsNDui() then
				if not oUF_Pet then return C_Timer.After(0.01,Update_PointXY) end
				Action_l:SetParent(oUF_Pet)
				Action_l:SetPoint("LEFT", oUF_Pet, "RIGHT", 1, 0);
			elseif Fun.IsElvUI() then
				if not ElvUF_Pet then return C_Timer.After(0.01,Update_PointXY) end
				Action_l:SetParent(ElvUF_Pet)
				Action_l:SetPoint("LEFT", ElvUF_Pet, "RIGHT", 1, 0);
			else
				Action_l:SetParent(PetFrameHappiness)
				Action_l:SetPoint("LEFT", PetFrameHappiness, "RIGHT", 1, 0);
			end
		end
		Update_PointXY()
	end
	AmmotipsFun()
	SubmergedFun()
	PetHappinessFun()
	--------
	function GeneralFun.addOptions_BabySitter()
		local TabBbbyF =PIGOptionsList_R(GeneralFun.NR,L["BABY_TABNAME"],90)
		TabBbbyF:HookScript("OnShow", function(self)
			if PIG_MaxTocversion(40000) then
				if not TabBbbyF.PetHappiness then  
					TabBbbyF.PetHappiness = PIGCheckbutton_R(TabBbbyF,{L["BABY_PETHAPPINESS"],L["BABY_PETHAPPINESS1"]},true)
					TabBbbyF.PetHappiness:SetScript("OnClick", function (self)
						if self:GetChecked() then
							PIGA["CombatPlus"]["PetHappiness"]=true;
							PetHappinessFun()
						else
							PIGA["CombatPlus"]["PetHappiness"]=false;
							PIG_OptionsUI.RLUI:Show()
						end
					end)
					TabBbbyF.PetHappiness:SetChecked(PIGA["CombatPlus"]["PetHappiness"])
				end
			end
			if PIG_MaxTocversion(20000) then
				if not TabBbbyF.ammotips then
					TabBbbyF.Submerged = PIGCheckbutton_R(TabBbbyF,{L["BABY_TISPSUBMERGED"]},true)
					TabBbbyF.Submerged:SetScript("OnClick", function (self)
						if self:GetChecked() then
							PIGA["CombatPlus"]["Submerged"]=true;
							SubmergedFun(true)
						else
							PIGA["CombatPlus"]["Submerged"]=false;
							PIG_OptionsUI.RLUI:Show()
						end
					end)
					TabBbbyF.Submerged:SetChecked(PIGA["CombatPlus"]["Submerged"])

					TabBbbyF.ammotips = PIGCheckbutton_R(TabBbbyF,{L["BABY_TISPAMMO"]},true)
					TabBbbyF.ammotips:SetScript("OnClick", function (self)
						if self:GetChecked() then
							PIGA["CombatPlus"]["ammotips"]=true;
							AmmotipsFun(true)
						else
							PIGA["CombatPlus"]["ammotips"]=false;
							PIG_OptionsUI.RLUI:Show()
						end
					end)
					TabBbbyF.ammotips:SetChecked(PIGA["CombatPlus"]["ammotips"])
					TabBbbyF.ammotips.CZ = PIGButton(TabBbbyF.ammotips,{"LEFT",TabBbbyF.ammotips.Text,"RIGHT",10,0},{60,22},RESET);  
					TabBbbyF.ammotips.CZ:SetScript("OnClick", function ()
						GetammoMinNum(PD.Default["CombatPlus"]["ammoMin1"],PD.Default["CombatPlus"]["ammoMin2"])
						event_Script()
						TabBbbyF.ammotips.Minnum1:PIGSetValue(GetammoMinNum(arg1))
						TabBbbyF.ammotips.Minnum2:PIGSetValue(select(2,GetammoMinNum(nil,arg1)))
					end);
					
					TabBbbyF.ammotips.Minnum1 = PIGSlider(TabBbbyF.ammotips,{"TOPLEFT",TabBbbyF.ammotips.Text,"BOTTOMLEFT",6,-2},{1,2000,1,{["Right"]="投掷武器少于:%d"}},400)
					function TabBbbyF.ammotips.Minnum1:PIGOnValueChange(arg1)
						GetammoMinNum(arg1)
						event_Script()
					end
					TabBbbyF.ammotips.Minnum1:PIGSetValue(GetammoMinNum(arg1))
					
					TabBbbyF.ammotips.Minnum2 = PIGSlider(TabBbbyF.ammotips,{"TOPLEFT",TabBbbyF.ammotips.Minnum1,"BOTTOMLEFT",0,-2},{1,2000,1,{["Right"]="弓箭/弹药少于:%d"}},400)
					function TabBbbyF.ammotips.Minnum2:PIGOnValueChange(arg1)
						GetammoMinNum(nil,arg1)
						event_Script()
					end
					TabBbbyF.ammotips.Minnum2:PIGSetValue(select(2,GetammoMinNum(nil,arg1)))
				end		
			end
		end)
	end
end