local _, PD = ...;
local Create=PD.Create
local PIGFontString=Create.PIGFontString
local Fun=PD.Fun
local Update_LootType=Fun.Update_LootType

local Data=PD.Data

local PigLayoutFun=PD.PigLayoutFun
local HHH=PigLayoutFun.HHH
local SetEvent_MenuList=PigLayoutFun.SetEvent_MenuList
local ListEventFun=PigLayoutFun.ListEventFun

--信息条左
local function ClearScriptList(butui)
	butui:SetScript("OnClick", nil);
	butui:SetScript("OnMouseDown", nil);
	butui:SetScript("OnMouseUp", nil);
	butui:SetScript("PostClick", nil);
end
local InfoList_L = {
	["Index"]={"LOOT","LOOT_THRESHOLD","DURABILITY","YISU"},
	["Tips"] = {
		["LOOT"]=LOOT_METHOD,
		["LOOT_THRESHOLD"]=LOOT_THRESHOLD,
		["DIFFICULTY"]=INSTANCE.."难度",
		["DURABILITY"]=DURABILITY,--"耐久"
		["YISU"]="移速",
	},
	["Icon"] ={
		["LOOT"]={"txt",16},
		["LOOT_THRESHOLD"]={"txt",16},
		["DIFFICULTY"]={"txt",26,{0,1,0}},
		["DURABILITY"]={"icontxt",34,{136465,HHH-2,HHH-2}},
		["YISU"]={"icontxt",34,{132307,HHH-5,HHH-5}},
	},
	["Click"] = {},
	["Event"] ={
		["LOOT"]=function(butui) 
			Update_LootType(butui,function(txtxx) butui.Text:SetText(txtxx) end,true) 
		end,
		["LOOT_THRESHOLD"]=function(butui,fujiUIx,set)
			butui:HookScript("OnMouseDown", function(self)
				if self.menu then
					self.menu:ClearAllPoints()
					self.menu:SetPoint("TOPLEFT",self,"BOTTOMLEFT",0,1)
			    end
			end);
			function butui:UpdateExt_ON()
				local shujux=Data.Quality[GetLootThreshold()]
				butui.Text:SetText(shujux.Name)
			end
			function butui:UpdateExt_OFF()
				local shujux=Data.Quality[GetLootThreshold()]
				butui.Text:SetText("\124cff555555N/A\124r")
			end
			butui:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
			SetEvent_MenuList(butui)
			if set then ListEventFun(butui) end
			butui:SetupMenu(function(dropdown, rootDescription)
				rootDescription:SetTag("PIG_MENU_LOOT_THRESHOLD");
				local function IsSelected(Threshold)
					return GetLootThreshold() == Threshold;
				end
				local function SetSelected(Threshold)
					SetLootThreshold(Threshold);
				end
				rootDescription:CreateRadio(Data.Quality[2].Name, IsSelected, SetSelected, 2);
				rootDescription:CreateRadio(Data.Quality[3].Name, IsSelected, SetSelected, 3);
				rootDescription:CreateRadio(Data.Quality[4].Name, IsSelected, SetSelected, 4);
			end);
		end,
		["DIFFICULTY"]=function(butui,fujiUIx,set)
			butui:HookScript("OnMouseDown", function(self)
				if self.menu then
					self.menu:ClearAllPoints()
					self.menu:SetPoint("TOPLEFT",self,"BOTTOMLEFT",0,1)
			    end
			end);
			butui:SetupMenu(function(dropdown, rootDescription)
				rootDescription:SetTag("PIG_MENU_DIFFICULTY");
				local function IsSelected(difficultyID)
					if IsInRaid() then
						return GetRaidDifficultyID() == difficultyID;
					else
						return GetDungeonDifficultyID() == difficultyID;
					end
				end
				local function SetSelected(difficultyID)
					if IsInRaid() then
						return SetRaidDifficultyID(difficultyID)
					else
						return SetDungeonDifficultyID(difficultyID)
					end
					C_Timer.After(1,function() ListEventFun(butui) end)
				end
				if PIG_MaxTocversion(50000,true) then
					rootDescription:CreateRadio(PLAYER_DIFFICULTY1, IsSelected, SetSelected, 1);
					rootDescription:CreateRadio(PLAYER_DIFFICULTY2, IsSelected, SetSelected, 2);
					rootDescription:CreateRadio(PLAYER_DIFFICULTY6, IsSelected, SetSelected, 23);
				else
					if IsInRaid() then
						if PIG_MaxTocversion(40000) and PIG_MaxTocversion(30000,true) then
							local name244=PIG_GetDifficultyInfo(244)
							rootDescription:CreateRadio(name244, IsSelected, SetSelected, 244);
						else
							rootDescription:CreateRadio(RAID_DIFFICULTY1, IsSelected, SetSelected, 3);
							rootDescription:CreateRadio(RAID_DIFFICULTY2, IsSelected, SetSelected, 4);
							rootDescription:CreateRadio(RAID_DIFFICULTY3, IsSelected, SetSelected, 5);
							rootDescription:CreateRadio(RAID_DIFFICULTY4, IsSelected, SetSelected, 6);
						end
					else
						rootDescription:CreateRadio(PLAYER_DIFFICULTY1, IsSelected, SetSelected, 1);
						rootDescription:CreateRadio(PLAYER_DIFFICULTY2, IsSelected, SetSelected, 2);
					end
				end
			end);
			function butui:UpdateExt_ON()
				if IsInRaid() then
					local DifficultyID=GetRaidDifficultyID()
					local name= PIG_GetDifficultyInfo(DifficultyID)
					self.Text:SetText(self.namelist[DifficultyID] or name)
				else
					local name = PIG_GetDifficultyInfo(GetDungeonDifficultyID())
					self.Text:SetText(self.namelist[DifficultyID] or name)
				end
			end
			function butui:UpdateExt_OFF()
				local DifficultyID=GetDungeonDifficultyID()
				butui:Enable()
				local name = PIG_GetDifficultyInfo(DifficultyID)
				self.Text:SetText(self.namelist[DifficultyID] or name)
			end
			butui.namelist={[5]="10H",[6]="25H",[150]="N/A",[244]="25泰坦"}
			butui:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
			SetEvent_MenuList(butui)
			if set then ListEventFun(butui) end
		end,
		["DURABILITY"]=function(butui,fujiUIx,set)
			ClearScriptList(butui)
			butui.Text:SetPoint("LEFT",butui.icon,"RIGHT", -3, 0);
			butui:RegisterEvent("PLAYER_ENTERING_WORLD")
			butui:RegisterEvent("UPDATE_INVENTORY_DURABILITY");--耐久变化
			butui:RegisterEvent("CONFIRM_XP_LOSS");--虚弱复活
			butui:RegisterEvent("UPDATE_INVENTORY_ALERTS");--耐久图标变化或其他
			local function UpdateDurabilityV(self)
				local zhuangbeinaijiuhezhi={0,0};
				for id = 1, 19, 1 do
					local current, maximum = GetInventoryItemDurability(id);
					if current~=nil then
						zhuangbeinaijiuhezhi[1]=zhuangbeinaijiuhezhi[1]+current;
						zhuangbeinaijiuhezhi[2]=zhuangbeinaijiuhezhi[2]+maximum;
					end
				end
				if zhuangbeinaijiuhezhi[1]>0 and zhuangbeinaijiuhezhi[2]>0 then
					local naijiubaifenbi=floor(zhuangbeinaijiuhezhi[1]/zhuangbeinaijiuhezhi[2]*100);
					self.Text:SetText(naijiubaifenbi.."%");
					if naijiubaifenbi>79 then
						self.Text:SetTextColor(0,1,0, 1);
					elseif  naijiubaifenbi>59 then
						self.Text:SetTextColor(1,215/255,0, 1);
					elseif  naijiubaifenbi>39 then
						self.Text:SetTextColor(1,140/255,0, 1);
					elseif  naijiubaifenbi>19 then
						self.Text:SetTextColor(1,69/255,0, 1);
					else
						self.Text:SetTextColor(1,0,0, 1);
					end
				else
					self.Text:SetText("N/A");
				end
			end
			butui:SetScript("OnEvent", UpdateDurabilityV)
			if set then UpdateDurabilityV(butui) end
		end,
		["YISU"]=function(butui)
			ClearScriptList(butui)
			butui.cachedSpeed = 0
			butui:SetScript("OnUpdate", function (self, elapsed)
				self.cachedSpeed = self.cachedSpeed + elapsed
	            if self.cachedSpeed >0.1 then
	                self.cachedSpeed = 0
					PIGGetUnitSpeed(butui.Text,"player")
				end
			end)
		end,	
	},
}
PigLayoutFun.ButDropList["DIFFICULTY"]="DropdownButton"
PigLayoutFun.ButDropList["LOOT_THRESHOLD"]="DropdownButton"
if PIG_MaxTocversion(20000,true) then
	table.insert(InfoList_L.Index,3,"DIFFICULTY")
end
if PIG_MaxTocversion(100000,true) then
	InfoList_L.Icon["LOOT"][2]=20
end
----
local function SetShowTXT(butui,labelTxt)
	ClearScriptList(butui)
	if labelTxt then
		butui.label = PIGFontString(butui,{"LEFT",butui,"LEFT", 1, 0},labelTxt,PIGA["PigLayout"]["TopBar"]["FontMiaobian"])
		butui.label:SetTextColor(0, 1, 0, 1);
		butui.Text:SetPoint("LEFT",butui.label,"RIGHT", 0, 0);
	end
end
--信息条右
local InfoList_R = {
	["Index"]= {"FPS","PING_B","PING_W"},--,"TIME"
	["Tips"] = {
		["FPS"]="帧数",
		["PING_B"]="延迟(本地)",
		["PING_W"]="延迟(世界)",
		["TIME"]="切换12H/24H",
	},
	["Icon"] = {
		["XY"]={"txt",50},
		["FPS"]={"txt",36},
		["PING_B"]={"txt",40},
		["PING_W"]={"txt",40},
		["TIME"]={"txt",30},
	},
	["Click"] = {
		["TIME"]=function(butui,button)
			if GetCVarBool("timeMgrUseMilitaryTime") then
				SetCVar("timeMgrUseMilitaryTime","0")
			else
				SetCVar("timeMgrUseMilitaryTime","1")
			end
		end,
	},
	["Event"] ={
		["FPS"]=function(butui)
			SetShowTXT(butui,"FPS:")
			butui.fpsTime = 0;
			butui:SetScript("OnUpdate", function (self,elapsed)
				local timeLeft = self.fpsTime - elapsed
				if timeLeft <= 0 then
					self.fpsTime = 0.25;
					self.Text:SetFormattedText("%.0f", GetFramerate());
				else
					self.fpsTime = timeLeft;
				end
			end)
		end,
		["PING_B"]=function(butui)
			SetShowTXT(butui,"本地:")
			butui.fpsTime = 0;
			butui.Tooltip=butui.Tooltip.."\n此连接传输聊天数据、拍卖行资料、公会聊天和信息、\n一些插件数据以及少量其他数据。此连接传输的数据量较小。"
			butui:SetScript("OnUpdate", function (self,elapsed)
				local timeLeft = self.fpsTime - elapsed
				if timeLeft <= 0 then
					self.fpsTime = 0.25;
					local bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats();
					self.Text:SetText(latencyHome);
				else
					self.fpsTime = timeLeft;
				end
			end)
		end,
		["PING_W"]=function(butui)
			SetShowTXT(butui,"世界:")
			butui.fpsTime = 0;
			butui.Tooltip=butui.Tooltip.."\n此连接传输如战斗信息、附近角色（属性、装备、附魔等）、\nNPC、生物、施法、职业等。进入人口稠密的区域将大大\n增加此连接传输的数据量，并增加延迟。"
			butui:SetScript("OnUpdate", function (self,elapsed)
				local timeLeft = self.fpsTime - elapsed
				if timeLeft <= 0 then
					self.fpsTime = 0.25;
					local bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats();
					self.Text:SetText(latencyWorld);
				else
					self.fpsTime = timeLeft;
				end
			end)
		end,
		["TIME"]=function(butui)
			butui.Text:SetPoint("CENTER", 0, 1.4);
			butui.MR_TextPoint[4]=1.4
			Create.PIGSetFont(butui.Text,15,PIGA["PigLayout"]["TopBar"]["FontMiaobian"])
			butui.timeallUI = CreateFrame("Frame",nil,butui)
			butui.timeallUI.oldtime=0
			butui.timeallUI:HookScript("OnUpdate", function (self,elapsed)
				self.oldtime=self.oldtime+elapsed
				if self.oldtime>1 then
					self.oldtime=0
					butui.Text:SetText(GameTime_GetLocalTime());
				end
			end)
		end,
	},
}
local barname="信息条"
local GNLsitsName={"topInfoL","topInfoR"}
PigLayoutFun.GNLsits[GNLsitsName[1]]={["barname"]=barname,["barname1"]="(左)",["MenuData"]=InfoList_L,["OptionsTop"]={0},["PointXY"]={"TOPLEFT",12,0}}
PigLayoutFun.GNLsits[GNLsitsName[2]]={["barname"]=barname,["barname1"]="(右)",["MenuData"]=InfoList_R,["OptionsTop"]={-250},["PointXY"]={"BOTTOMLEFT",12,0}}
function PigLayoutFun.InfoBarFun()
	for i=1,#GNLsitsName do
		PigLayoutFun.add_barUI(GNLsitsName[i])
	end
end
function PigLayoutFun.addOptions_InfoBar()
	PigLayoutFun.add_Options(GNLsitsName,barname)
end