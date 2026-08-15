local addonName, PD = ...;
local L =PD.locale
local Create=PD.Create
local PIGFrame=Create.PIGFrame
local PIGLine=Create.PIGLine
local PIGButton = Create.PIGButton
local PIGDiyBut=Create.PIGDiyBut
local PIGCheckbutton=Create.PIGCheckbutton
local PIGFontString=Create.PIGFontString
----
local Fun = PD.Fun
local Data=PD.Data
-------------
local UIname,julidi = "PIG_ExportImportUI",-26
Data.ExportImportUIname=UIname
local daoruTXT,daochuTXT = L["CONFIG_IMPORT"],L["CONFIG_DERIVE"]

local EIUI=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,0},{800, 600},UIname,true)
EIUI:PIGSetBackdrop(1)
EIUI:PIGSetMovableNoSave()
EIUI:PIGClose()
EIUI:SetFrameStrata("HIGH")
EIUI:SetFrameLevel(999);
EIUI.biaoti=PIGFontString(EIUI,{"TOP", EIUI, "TOP", 0, -3})
---
EIUI.tishitxt = PIGFontString(EIUI,{"TOPLEFT",EIUI,"TOPLEFT",6,julidi-4},daoruTXT)
EIUI.tishitxt:SetTextColor(0, 1, 0, 1);
EIUI.zifunumV=PIGFontString(EIUI,{"LEFT",EIUI.tishitxt,"RIGHT",0,0},0)
EIUI.zifunumV:SetTextColor(1, 1, 1, 0.4)
EIUI.daoruBut = PIGButton(EIUI,{"TOPRIGHT",EIUI,"TOPRIGHT",-40,julidi},{80,20},L["CONFIG_DAORU"])
EIUI.daoruBut:Hide();
EIUI.Append = PIGCheckbutton(EIUI,{"TOPRIGHT",EIUI,"TOPRIGHT",-280,julidi-2},{"导入保留原数据"})
EIUI.Append:Hide();
EIUI.Clear=PIGDiyBut(EIUI,{"LEFT",EIUI.zifunumV,"RIGHT",0,-1},{18})
EIUI.Clear:SetScript("OnClick", function (self)
	EIUI.NR.textArea:SetText("")
end)
---
EIUI.NR=PIGFrame(EIUI)
EIUI.NR:SetPoint("TOPLEFT", EIUI, "TOPLEFT", 4, -54)
EIUI.NR:SetPoint("BOTTOMRIGHT", EIUI, "BOTTOMRIGHT", -4, 4)
EIUI.NR:PIGSetBackdrop()
EIUI.NR.scroll = CreateFrame("ScrollFrame", nil, EIUI.NR, "UIPanelScrollFrameTemplate")
EIUI.NR.scroll:SetPoint("TOPLEFT", EIUI.NR, "TOPLEFT", 6, -6)
EIUI.NR.scroll:SetPoint("BOTTOMRIGHT", EIUI.NR, "BOTTOMRIGHT", -26, 6)
EIUI.NR.textArea = CreateFrame("EditBox", nil, EIUI.NR.scroll)
EIUI.NR.textArea:SetFontObject(ChatFontNormal);
EIUI.NR.textArea:SetWidth(EIUI.NR:GetWidth()-40)
EIUI.NR.textArea:SetMultiLine(true)
EIUI.NR.textArea:SetMaxLetters(999999)
EIUI.NR.textArea:EnableMouse(true)
EIUI.NR.textArea:SetScript("OnEscapePressed", function(self)
	self:ClearFocus()
	EIUI:Hide();
end)
EIUI.NR.textArea:SetScript("OnTextChanged", function(self)
	local NdataT = self:GetText()
	local NdataT = NdataT:gsub("%s+", "")
	EIUI.zifunumV:SetText(#NdataT)
	if NdataT=="" then
		EIUI.daoruBut:Disable()
	else
		EIUI.daoruBut:Enable()
	end
end)
EIUI.NR.scroll:SetScrollChild(EIUI.NR.textArea)
----
EIUI.TabL=PIGFrame(EIUI,{"RIGHT",EIUI,"LEFT",0,0},{78, 600})
EIUI.TabL:Hide()
EIUI.TabL.Copy = PIGButton(EIUI.TabL,{"TOP",EIUI.TabL,"TOP",-4,julidi},{70,22},"select all")
EIUI.TabL.Copy:SetScript("OnClick", function (self)
	EIUI.NR.textArea:HighlightText()
end)
EIUI.TabL.zhunma = PIGButton(EIUI.TabL,{"TOP",EIUI.TabL.Copy,"BOTTOM",0,-10},{70,22},"cmd_1")
EIUI.TabL.zhunma:SetScript("OnClick", function (self)
	local data = EIUI.NR.textArea:GetText()
	local Ndata = Fun.Base64_encod(data)
	EIUI.NR.textArea:SetText(Ndata)
end)
EIUI.TabL.huanyuan = PIGButton(EIUI.TabL,{"TOP",EIUI.TabL.zhunma,"BOTTOM",0,-10},{70,22},"cmd_2")
EIUI.TabL.huanyuan:SetScript("OnClick", function (self)
	local data = EIUI.NR.textArea:GetText()
	local Ndata = Fun.Base64_decod(data)
	EIUI.NR.textArea:SetText(Ndata)
end)
function EIUI:Show_HideFun(debug)
	self.NR.textArea:SetText("")
	if self:IsShown() then
		self:Hide()
	else
		self:Show()
		self.TabL:SetShown(debug)
	end
end

---序列化
local strbyte, strchar, gsub, gmatch, format,tconcat = string.byte, string.char, string.gsub, string.gmatch, string.format,table.concat
local type, tostring, tonumber, assert, pcall = type, tostring, tonumber,assert, pcall
local pairs, next, select, frexp, inf = pairs, next, select, math.frexp, math.huge
local error = function(msg) PIGprint("|cffFF0000"..msg.."|r") end
local versions,versionsV = "!P","02"
local biaptou =versions..versionsV
--冒号压缩
local rep = string.rep
local function ColonCompressor(data)
    if type(data) ~= "string" then
        return data
    end
    local result = data
    for count = 9, 4, -1 do
        local colonStr = rep(":", count)
        local marker = "#" .. count
        result = result:gsub(colonStr, marker)
    end
    return result
end
local function ColonDecompress(data)
    if type(data) ~= "string" then
        return data
    end
    local result = data
    result = result:gsub("#([4-9])", function(count)
        count = tonumber(count)
        return rep(":", count)
    end)
    return result
end
--序列化部分 ===============
local function SerializeStringHelper(ch)
    local n = strbyte(ch)
    if n == 30 then return "\126\122"
    elseif n <= 32 then return "\126"..strchar(n+64)
    elseif n == 94 then return "\126\125"
    elseif n == 124 then return "\126\127"
    elseif n == 126 then return "\126\124"
    elseif n == 127 then return "\126\123"
    else assert(false) end
end
local function SerializeStringWithPool(v, res, nres, pool, list)
    local idx = pool[v]
    if idx then
        res[nres+1] = "^R"
        res[nres+2] = format("%x", idx)
        return nres + 2
    else
        local newIdx = #list + 1
        pool[v] = newIdx
        list[newIdx] = v
        res[nres+1] = "^S"
        res[nres+2] = gsub(v, "[%c \94\124\126\127]", SerializeStringHelper)
        return nres + 2
    end
end
local function SerializeValue(v, res, nres, pool, list)
    local t = type(v)
    if t == "string" then
        return SerializeStringWithPool(v, res, nres, pool, list)
    elseif t == "number" then
        if v == v and v >= -2147483648 and v <= 2147483647 and v % 1 == 0 then
            res[nres+1] = "^I"
            res[nres+2] = format("%x", v < 0 and (0x100000000 + v) or v)
            return nres + 2
        else
            local str = tostring(v)
            if tonumber(str) == v then
                res[nres+1] = "^N"
                res[nres+2] = str
                return nres + 2
            elseif v == inf or v == -inf then
                res[nres+1] = "^N"
                res[nres+2] = v == inf and "inf" or "-inf"
                return nres + 2
            else
                local m, e = frexp(v)
                local mantissa = format("%.0f", m * 2^53)
                mantissa = gsub(mantissa, "0+$", "")
                res[nres+1] = "^F"
                res[nres+2] = mantissa
                res[nres+3] = "^f"
                res[nres+4] = tostring(e - 53)
                return nres + 4
            end
        end
    elseif t == "table" then
        if next(v) == nil then
            res[nres+1] = "^E"
            return nres + 1
        end
        res[nres+1] = "^T"
        nres = nres + 1
        for k, val in pairs(v) do
            nres = SerializeValue(k, res, nres, pool, list)
            nres = SerializeValue(val, res, nres, pool, list)
        end
        res[nres+1] = "^t"
        return nres + 1
    elseif t == "boolean" then
        res[nres+1] = v and "^B" or "^b"
        return nres + 1
    elseif t == "nil" then
        res[nres+1] = "^Z"
        return nres + 1
    else
        error("Unable to serialize the value of type '"..t.."'")
    end
end
local function Serialize(...)
    local pool = {}
    local list = {}
    local res = {"^1"}
    local nres = 1
    for i = 1, select("#", ...) do
        nres = SerializeValue(select(i, ...), res, nres, pool, list)
    end
    res[nres+1] = "^^"
    return tconcat(res, "", 1, nres+1)
end
--反序列化 ====================
local function DeserializeStringHelper(escape)
    if escape < "~\122" then
        return strchar(strbyte(escape, 2, 2) - 64)
    elseif escape == "~\122" then return "\030"
    elseif escape == "~\123" then return "\127"
    elseif escape == "~\124" then return "\126"
    elseif escape == "~\125" then return "\94"
    elseif escape == "~\127" then return "\124"
    end
    error("DeserializeStringHelper got called for '"..escape.."'?!?")
end
local function DeserializeNumberHelper(number)
    if number == "-inf" then return -inf
    elseif number == "inf" then return inf
    else return tonumber(number) end
end
local function DeserializeValue(iter, single, ctl, data, pool)
    if not single then ctl, data = iter() end
    if not ctl then error("Supplied data misses AceSerializer terminator ('^^')") end
    if ctl == "^^" then return end
    local res
    if ctl == "^S" then
        res = gsub(data, "~.", DeserializeStringHelper)
        pool[#pool + 1] = res
    elseif ctl == "^R" then
        local idx = tonumber(data, 16)
        res = pool[idx]
        if not res then error("Invalid string pool reference: "..data) end
        
    elseif ctl == "^E" then
        res = {}
    elseif ctl == "^I" then
        local n = tonumber(data, 16)
        if n > 2147483647 then n = n - 0x100000000 end
        res = n
    elseif ctl == "^N" then
        res = DeserializeNumberHelper(data)
        if not res then error("Number of invalid serializations: '"..tostring(data).."'") end
    elseif ctl == "^F" then
        local ctl2, e = iter()
        if ctl2 ~= "^f" then error("Invalid serialized floating point number, expected '^f', not '"..tostring(ctl2).."'") end
        local m = tonumber(data)
        e = tonumber(e)
        if not (m and e) then error("Invalid serialized floating-point number") end
        res = m * (2^e)
    elseif ctl == "^B" then res = true
    elseif ctl == "^b" then res = false
    elseif ctl == "^Z" then res = nil
    elseif ctl == "^T" then
        res = {}
        local k, val
        while true do
            ctl, data = iter()
            if ctl == "^t" then break end
            k = DeserializeValue(iter, true, ctl, data, pool)
            if k == nil then error("Invalid AceSerializer format (no end-of-table flag)") end
            ctl, data = iter()
            val = DeserializeValue(iter, true, ctl, data, pool)
            if val == nil then error("Invalid AceSerializer format (no end-of-table flag)") end
            res[k] = val
        end
    else
        error("Invalid AceSerializer control code '"..ctl.."'")
    end
    if not single then
        return res, DeserializeValue(iter, nil, nil, nil, pool)
    else
        return res
    end
end
local function Deserialize(str)
    str = gsub(str, "[%c ]", "")
    local iter = gmatch(str, "(^.)([^^]*)")
    local ctl, data = iter()
    if not ctl and data~="^1" then
        return false, "Unknown data"
    end
    local pool = {}
    return pcall(DeserializeValue, iter, nil, nil, nil, pool)
end
----
local lyListVChu={["Config"]="01",["SellBuy"]="02",}
local lyListVRu={}
for k,v in pairs(lyListVChu) do
    lyListVRu[v]=k
end
function PD.Fun.Config_CHU(ly,ConfigData,ConfigData1)
	EIUI:Show_HideFun()
	EIUI.daoruBut:Hide();
	EIUI.Append:Hide();
	EIUI.biaoti:SetText(L["CONFIG_DAOCHU"]..L["CONFIG_TABNAME"]);
	EIUI.tishitxt:SetText(daochuTXT);
	local newtxt=biaptou..lyListVChu[ly]..ColonCompressor(Serialize(ConfigData))
	if ConfigData1 then
		newtxt=newtxt.."@"..ColonCompressor(Serialize(ConfigData1))
	end
	EIUI.NR.textArea:SetText(newtxt)
	EIUI.NR.textArea:HighlightText()
end
function PD.Fun.Config_RU(ly,RuFun)
	EIUI:Show_HideFun()
	EIUI.daoruBut:Show();
	EIUI.Append:SetShown(ly~="Config");
	EIUI.biaoti:SetText(L["CONFIG_DAORU"]..L["CONFIG_TABNAME"]);
	EIUI.tishitxt:SetText(daoruTXT);
	EIUI.NR.textArea:SetText("")
    EIUI.Ruly=ly
	EIUI.RuFun=RuFun
end
EIUI.daoruBut:SetScript("OnClick", function(self, button)
	local str = EIUI.NR.textArea:GetText()
	local newvn = str:sub(1,2)
	if newvn==versions then
		local verx = str:sub(3,4)
		if tonumber(verx)<tonumber(versionsV) then
			PIGErrorMsg("此"..addonName.."字符串已过期", "R")
			return
		end
	else
		PIGErrorMsg("请导入"..addonName..ADDONS.."字符串", "R")
		return
	end
    local lyID = str:sub(5,6)
    if EIUI.Ruly~=lyListVRu[lyID] then
        PIGErrorMsg("字符串非"..EIUI.Ruly, "R")
        return
    end
	if EIUI.Ruly=="Config" then
		local str, str_Per = strsplit("@", str:sub(7));
		str = ColonDecompress(str)
		local success, config = Deserialize(str)
		str_Per = ColonDecompress(str_Per)
		local success_Per, config_Per = Deserialize(str_Per)
		if success and success_Per then
			EIUI.RuFun(config, config_Per)
			ReloadUI()
		else
			PIGErrorMsg(L["CONFIG_DERIVEERROR"], "R")
		end
	else
		str = ColonDecompress(str:sub(7))
		local success, config = Deserialize(str)
		if success then
			EIUI.RuFun(config,EIUI.Append:GetChecked())
			EIUI:Hide()
			PIGErrorMsg(L["CONFIG_DERIVEEOK"], "G")
		else
			PIGErrorMsg(L["CONFIG_DERIVEERROR"], "R")
		end
	end
end)