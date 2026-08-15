local addonName, addonTable = ...;
local char=string.char
local sub = _G.string.sub
local gsub = _G.string.gsub
local match = _G.string.match
local lower= _G.string.lower
----
local Fun=addonTable.Fun

local GetItemInfo=GetItemInfo or C_Item and C_Item.GetItemInfo
--------------------
local TooltipUI = CreateFrame("GameTooltip", "PIG_TooltipUI", UIParent, "GameTooltipTemplate")
TooltipUI:SetOwner(UIParent, "ANCHOR_NONE")
local TooltipGetItemLevel = CreateFrame("GameTooltip", "PIG_TooltipGetItemLevel", UIParent, "GameTooltipTemplate")
TooltipGetItemLevel:SetOwner(UIParent, "ANCHOR_NONE")
-----------------
local function GetItemLinkJJ(ItemLink)
    local msg = "";
    if ItemLink ~= nil then
        local ItemLink1 = ItemLink:match("\124Hitem:([%w:%-]+)\124h%[");
        if ItemLink1 then
            if ItemLink1:match("Player%-") then
                local Player1,Player2 = ItemLink1:match("([%w:]+)Player%-([%w%-]+:)");
            	local msgjj = Fun.yasuo_NumberString(Player1)
                msg=msgjj..":"
            else
                msg = Fun.yasuo_NumberString(ItemLink1)
            end
        end
    else
        msg="^" 
    end
    return msg;
end
Fun.GetItemLinkJJ=GetItemLinkJJ
function Fun.GetEquipmTXT(kaishi,jieshu)
    local kaishi,jieshu = kaishi or 1, jieshu or 19
    local msg = "";
    for slot = kaishi,jieshu do
        local item = GetInventoryItemLink("player", slot);
        local slotD = GetItemLinkJJ(item)
        if slot==jieshu then
            msg = msg..slot.."-"..slotD;
        else
            msg = msg..slot.."-"..slotD.."+";
        end
    end
    return msg;
end

local PIGGetColorKey=Fun.PIGGetColorKey
local function HY_ItemLinkJJ(ItemJJ)
    local yes=ItemJJ:match("|"..PIGGetColorKey().."|Hitem:")
    if yes then
        return ItemJJ
    else
        local Player
        if ItemJJ:match("Player%-") then
            local Player1,Player2 = ItemJJ:match("([%w:]+)Player%-([%w%-]+:)");
            ItemJJ=Player1
            Player="Player-"..Player2
        end
        local Itemhy = Fun.jieya_NumberString(ItemJJ)
        if Player then
            return "item:"..Itemhy..Player
        else
            return "item:"..Itemhy
        end
    end
end
Fun.HY_ItemLinkJJ=HY_ItemLinkJJ
function Fun.HY_EquipmTXT(msg)
    local Data = {}
    if msg and msg~="" then
        local list = {strsplit("+", msg)}
        for i=1,#list do
            local xuhao,link = strsplit("-", list[i])
            if link=="^" or link=="" then
                Data[tonumber(xuhao)]=nil
            else
                Data[tonumber(xuhao)]=HY_ItemLinkJJ(link)
            end
        end
    end
    return Data
end
---
local function HY_ShowItemLink(But,itemID,itemlin,New)
    if But and itemlin then
        if not New then But.zhixingnum=0 end
        local Linktxt=HY_ItemLinkJJ(itemlin)
        local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID=GetItemInfo(Linktxt);
        if itemLink then
            if But.itemID==itemID then
                But:ShowInfoFun(itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID)
            end
        else
            if not New then But.zhixingnum=0 end
            But.zhixingnum=But.zhixingnum+1
            if But:IsVisible() and But.zhixingnum<10 then
                C_Timer.After(0.04,function()
                    HY_ShowItemLink(But,itemID,itemlin,true)
                end)
            end
        end
    end
end
Fun.HY_ShowItemLink=HY_ShowItemLink
local function PIGShowItemLink(But,itemID,SetFun,New)  
    if But and itemID and SetFun then  
        local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID=GetItemInfo(itemID);
        if itemLink and itemQuality and itemTexture then
            if But.itemID==itemID then
                SetFun(itemLink,itemQuality,itemTexture,itemType,itemSubType,itemEquipLoc,classID, subclassID)
            end
        else
            if not New then But.zhixingnum=0 end
            But.zhixingnum=But.zhixingnum+1
            if But:IsVisible() and But.zhixingnum<10 then
                C_Timer.After(0.04,function()
                    PIGShowItemLink(But,itemID,SetFun,true)
                end)
            end
        end
    end
end
Fun.PIGShowItemLink=PIGShowItemLink

--获取鼠标提示物品信息
local MATCH_ITEM_LEVEL = ITEM_LEVEL:gsub('%%d', '(%%d+)')
local MATCH_ITEM_LEVEL_ALT = ITEM_LEVEL_ALT:gsub('%%d(%s?)%(%%d%)', '%%d+%1%%((%%d+)%%)')
local function addtaodataxx(datax,taoname,maxnum)
    for i=1,#datax do
        if taoname==datax[i][1] then
            datax[i][2]=datax[i][2]+1
            if maxnum>datax[i][3] then
               datax[i][3]=maxnum
            end
            return false
        end
    end
    return true
end
function Fun.Update_ListTaoName(Parent)
    local datax = {}
    for SlotID,SlotBut in pairs(Parent.ListHang) do
        if Parent.SlotOKs[SlotID].tao then
            local taoname,minnum,maxnum,quality=unpack(Parent.SlotOKs[SlotID].tao)
            if addtaodataxx(datax,taoname,maxnum) then
                tinsert(datax,{taoname,1,maxnum,quality})
            end
        end
    end
    return datax
end
-----
local function _IsLyunit(ly)
    -- if ly=="player" or ly=="target" then
    --     return true
    -- end
    -- if #ly>4 then
    --     local text2 = ly:sub(1,5):lower()
    --     if text2=="party" then
    --         return true
    --     end
    -- elseif #ly>3 then
    --     local text1 = ly:sub(1,4):lower()
    --     if text1=="raid" then
    --         return true
    --     end
    -- end
    -- return false
    return true
end
local function _GetQuality(ly,info)
    local quality
    if ly=="bag" then
        if info[1]==-1 then
            quality=GetInventoryItemQuality("player", BankButtonIDToInvSlotID(info[2]))
        else
            quality=select(5, PIGGetContainerItemInfo(info[1], info[2]))
        end
    elseif ly=="link" then
        quality = C_Item.GetItemQualityByID(info[1])
    elseif _IsLyunit(ly) then
        quality = GetInventoryItemQuality(ly, info[1])
    end
    return quality or 1
end
local oldtoc=PIG_MaxTocversion(50000)
local function _GetDetailedItemLevelInfo(ly,info,GetTaoZ)
    local ItemLink
    if ly=="bag" then
        if info[1]==-1 then
            ItemLink=GetInventoryItemLink("player", BankButtonIDToInvSlotID(info[2]))
        else
            ItemLink=PIGGetContainerItemLink(info[1], info[2])
        end
    elseif ly=="link" then
        ItemLink=info[1]
    elseif _IsLyunit(ly) then
        ItemLink=GetInventoryItemLink(ly, info[1])
    end
    if ItemLink then
        local classID=select(6,PIGGetItemInfoInstant(ItemLink))
        if (classID==2 or classID==4) then
            if GetTaoZ then return false end
            if oldtoc then
                return true,PIGGetDetailedItemLevelInfo(ItemLink)
            else
                return false
            end
        else
            return true,PIGGetDetailedItemLevelInfo(ItemLink)
        end
    else
        return true
    end 
end

local function _GetItemLevel(ly,info,GetTaoZ)
    local stopfun,ItemLevelV,taodata=_GetDetailedItemLevelInfo(ly,info,GetTaoZ)
    if stopfun then return ItemLevelV,taodata end  
    TooltipGetItemLevel:SetOwner(UIParent, "ANCHOR_NONE")
    TooltipGetItemLevel:ClearLines();
    local Iteminfo
    if ly=="bag" then
        if info[1]==-1 then
            Iteminfo = TooltipGetItemLevel:SetInventoryItem("player", BankButtonIDToInvSlotID(info[2]));
        else
            Iteminfo = TooltipGetItemLevel:SetBagItem(info[1], info[2])
        end
    elseif ly=="link" then
        Iteminfo = TooltipGetItemLevel:SetHyperlink(info[1])
    elseif _IsLyunit(ly) then
        Iteminfo = TooltipGetItemLevel:SetInventoryItem(ly, info[1])
    end
    TooltipGetItemLevel:Show()
    if TooltipGetItemLevel.GetTooltipData then
        if not Iteminfo then return end
        local t_lsit = Iteminfo and TooltipGetItemLevel:GetTooltipData()
        if t_lsit then
            local text1 = t_lsit.lines[1]
            local errorText = text1 and text1.leftText
            if errorText == RETRIEVING_ITEM_INFO then
                return "RETRIEVING"
            end
            if GetTaoZ then
                local itemLevel_1,taodata
                for ix=2,#t_lsit.lines do
                    local text = t_lsit.lines[ix] and t_lsit.lines[ix].leftText
                    if text and text ~= '' then
                        if not itemLevel_1 then
                            local itemLevel = text:match(MATCH_ITEM_LEVEL_ALT) or text:match(MATCH_ITEM_LEVEL)
                            if itemLevel then
                                itemLevel_1=tonumber(itemLevel) or 1
                            end
                        end
                        local newText=text:gsub("（","(");
                        local newText=newText:gsub("）",")");
                        local kaishi,jieshu,taoname,minnum,maxnum = newText:find("(.+)%((%d)/(%d)%)")
                        if taoname and minnum and maxnum then
                            if maxnum=="0" or tonumber(minnum)>tonumber(maxnum) then return "RETRIEVING" end
                            taodata={taoname,tonumber(minnum),tonumber(maxnum),_GetQuality(ly,info)}
                        end
                    end
                end
                TooltipGetItemLevel:Hide()
                return itemLevel_1,taodata
            else
                local colormode = GetCVarBool('colorblindmode')
                local numLines = (colormode and 21 or 20) or (colormode and 4 or 3)
                for x = 2, numLines do
                    local text = t_lsit.lines[x]
                    if text and text.leftText and text.leftText ~= '' then
                        local itemLevel = text.leftText:match(MATCH_ITEM_LEVEL_ALT) or text.leftText:match(MATCH_ITEM_LEVEL)
                        if itemLevel then
                            TooltipGetItemLevel:Hide()
                            return tonumber(itemLevel)
                        end
                    end
                end
            end
        end
    else
        local txtNum = TooltipGetItemLevel:NumLines()
        if not txtNum or txtNum and txtNum==0 then return end
        local hangname = TooltipGetItemLevel:GetName()
        local text = _G[hangname.."TextLeft" .. 1]:GetText()
        if text == RETRIEVING_ITEM_INFO then
            return "RETRIEVING"
        end
        if GetTaoZ then
            local itemLevel_1,taodata
            for g = 2, txtNum do
                local text = _G[hangname.."TextLeft" .. g]:GetText()
                if text and text ~= '' then
                    if not itemLevel_1 then
                        if oldtoc then
                            local stopfun,ItemLevelV=_GetDetailedItemLevelInfo(ly,info)
                            itemLevel_1=ItemLevelV
                        else
                            local itemLevel = text:match(MATCH_ITEM_LEVEL_ALT) or text:match(MATCH_ITEM_LEVEL)
                            if itemLevel then
                                itemLevel_1=tonumber(itemLevel) or 0
                            end
                        end
                    end
                    local newText=text:gsub("（","(");
                    local newText=newText:gsub("）",")");
                    local kaishi,jieshu,taoname,minnum,maxnum = newText:find("(.+)%((%d)/(%d)%)")
                    if taoname and minnum and maxnum then
                        if maxnum=="0" or tonumber(minnum)>tonumber(maxnum) then return "RETRIEVING" end
                        taodata={taoname,tonumber(minnum),tonumber(maxnum),_GetQuality(ly,info)}
                    end
                end
            end
            TooltipGetItemLevel:Hide()
            return itemLevel_1,taodata
        else
            local colormode = GetCVarBool('colorblindmode')
            local numLines = (colormode and 21 or 20) or (colormode and 4 or 3)
            for g = 2, txtNum do
                local text = _G[hangname.."TextLeft" .. g]:GetText()
                if text and text ~= '' then
                    local itemLevel = text:match(MATCH_ITEM_LEVEL_ALT) or text:match(MATCH_ITEM_LEVEL)
                    if itemLevel then
                        TooltipGetItemLevel:Hide()
                        return tonumber(itemLevel)
                    end
                end
            end
        end
    end
end
function Fun.PIGGetItemLevel(link)
    local ItemLevel = _GetItemLevel("link", {link})
    if ItemLevel and ItemLevel~="RETRIEVING" then
        return ItemLevel
    end
end
function Fun._GetTooltipLevel(ly,info,callback,count,GetTaoZ)
    count = count or 0
    local itemLevel,taodata = _GetItemLevel(ly,info,GetTaoZ)
    if itemLevel == "RETRIEVING" and count < 10 then
        C_Timer.After(0.05, function()
            Fun._GetTooltipLevel(ly,info,callback,count+1,GetTaoZ)
        end)
    else
        callback(itemLevel ~= "RETRIEVING" and itemLevel or 1,taodata)
    end
end
--自定义平均装等
function Fun._GetAverageItemLevel(Parent)
    Parent.wuqiLV={{0,"null"},{0,"null"},{0,"null"},0}
    for Slot,But in pairs(Parent.ListHang) do
        if Slot~=16 and Slot~=17 and Slot~=18 then
            if But.iLv then
                Parent.wuqiLV[4] = Parent.wuqiLV[4] + But.iLv
            end
        end
    end
    --INVTYPE_2HWEAPON--双手
    --INVTYPE_WEAPONMAINHAND--主手
    --INVTYPE_SHIELD--副手
    --INVTYPE_WEAPON--单手
    if Parent.ListHang[16] and Parent.ListHang[16].iLv then
        Parent.wuqiLV[1][1] = Parent.ListHang[16].iLv or 0
        Parent.wuqiLV[1][2]=Parent.ListHang[16].itemEquipLoc
    end
   if Parent.ListHang[17] and Parent.ListHang[17].iLv then
        Parent.wuqiLV[2][1] = Parent.ListHang[17].iLv or 0
        Parent.wuqiLV[2][2]=Parent.ListHang[17].itemEquipLoc
    end
    if oldtoc then
        if Parent.ListHang[18] and Parent.ListHang[18].iLv then
            Parent.wuqiLV[3][1] = Parent.ListHang[18].iLv
        end
        --新计算方式(主+副手/远程*2取其大者)
        if Parent.wuqiLV[1][1]>0 or Parent.wuqiLV[2][1]>0 or Parent.wuqiLV[3][1]>0 then
            if Parent.wuqiLV[1][2] == "INVTYPE_2HWEAPON" and Parent.wuqiLV[2][2] == "INVTYPE_2HWEAPON" then--泰坦之握双持双手
                local zuizhongwuqiLV = Parent.wuqiLV[1][1]+Parent.wuqiLV[2][1]
                Parent.wuqiLV[4] = Parent.wuqiLV[4] + zuizhongwuqiLV
            else
                if Parent.wuqiLV[1][2] == "INVTYPE_2HWEAPON" then--单双手武器
                    local zuizhongwuqiLV = 0
                    if Parent.zhiyeID==3 then
                        local wuqizuidaV = max(Parent.wuqiLV[1][1],Parent.wuqiLV[3][1])
                        zuizhongwuqiLV = wuqizuidaV*2
                    else
                        zuizhongwuqiLV = Parent.wuqiLV[1][1]*2
                    end
                    Parent.wuqiLV[4] = Parent.wuqiLV[4] + zuizhongwuqiLV
                else
                    local zuizhongwuqiLV = 0
                    if Parent.zhiyeID==3 then
                        if Parent.wuqiLV[3][1]>Parent.wuqiLV[1][1] and Parent.wuqiLV[3][1]>Parent.wuqiLV[2][1] then
                            zuizhongwuqiLV = Parent.wuqiLV[3][1]*2
                        else
                            zuizhongwuqiLV = Parent.wuqiLV[1][1]+Parent.wuqiLV[2][1]
                        end
                    else
                        zuizhongwuqiLV = Parent.wuqiLV[1][1]+Parent.wuqiLV[2][1]
                    end
                    Parent.wuqiLV[4] = Parent.wuqiLV[4] + zuizhongwuqiLV
                end
            end
        end
    else
        if Parent.wuqiLV[1][2] == "INVTYPE_RANGED" or Parent.wuqiLV[1][2] == "INVTYPE_RANGEDRIGHT" or Parent.wuqiLV[1][2] == "INVTYPE_2HWEAPON" then--远程/双手武器
            Parent.wuqiLV[4] = Parent.wuqiLV[4] + Parent.wuqiLV[1][1]+Parent.wuqiLV[1][1]
        else
            Parent.wuqiLV[4] = Parent.wuqiLV[4] + Parent.wuqiLV[1][1]+Parent.wuqiLV[2][1]
        end
    end
    local pingjunLvl = Parent.wuqiLV[4]/16
    if pingjunLvl>0 then
        return string.format("%.2f",pingjunLvl)
    end
    return "??"
end

--获取宝石默认图标
local GEM_EMPTY_SOCKET= {
    ["EMPTY_SOCKET_META"]      = 136257,  -- 多彩
    ["EMPTY_SOCKET_RED"]       = 136258,  -- 红色
    ["EMPTY_SOCKET_YELLOW"]    = 136259,  -- 黄色
    ["EMPTY_SOCKET_BLUE"]      = 136256,  -- 蓝色
    ["EMPTY_SOCKET_PRISMATIC"] = 458977,  -- 棱彩 (可变色插槽)
    ["EMPTY_SOCKET"]           = 136260,  -- 通用空插槽
    ["EMPTY_SOCKET_COGWHEEL"]  = 407324,  -- 
    ["EMPTY_SOCKET_HYDRAULIC"] = 407325,  --煞化
    ["EMPTY_SOCKET_PUNCHCARD_BLUE"]  = 2958629,  -- 铭文卡-蓝色
    ["EMPTY_SOCKET_PUNCHCARD_RED"]   = 2958630,  -- 铭文卡-红色
    ["EMPTY_SOCKET_PUNCHCARD_YELLOW"] = 2958631, -- 铭文卡-黄色
    ["EMPTY_SOCKET_DOMINATION"] = 4095404, -- 支配插槽 (Domination)
    ["EMPTY_SOCKET_GREEN"] = 136256,  -- 蓝色槽常被用作绿色（旧版兼容）
    ["EMPTY_SOCKET_FIBER"] = 136256,
}
function Fun._Get_GEM_EMPTY_SOCKET(key)
    if GEM_EMPTY_SOCKET[key] then
        return GEM_EMPTY_SOCKET[key]
    end
    return 55655
end

--获取品质边框
local QualityBorder={
    [1]="loottoast-itemborder-white",
    [2]="loottoast-itemborder-green",
    [3]="loottoast-itemborder-blue",
    [4]="loottoast-itemborder-purple",
    [5]="loottoast-itemborder-orange",
    [6]="loottoast-itemborder-gold",
    [7]="loottoast-itemborder-heirloom",
}
function Fun.GetItemQualityBorder(id)
    if QualityBorder[id] then
        return QualityBorder[id]
    end
    return QualityBorder[1]
end