--20250324 内置风纪区玩家备注wa的简易功能 用以识别作恶玩家
--https://bbs.nga.cn/read.php?tid=26042932


-- 配置
local roster = {
    "CN,1,052F53AE,0,NGA风纪区标记:大土亢",
    "CN,1,0567B34D,0,NGA风纪区标记:大土亢",
    "CN,1,04F59AE5,0,NGA风纪区标记:大土亢",
    "CN,1,05E1532E,0,NGA风纪区标记:大土亢",
    "CN,1,04F40222,0,NGA风纪区标记:大土亢",
    "CN,1,0564FB96,0,NGA风纪区标记:大土亢",
    "CN,1,04D81C83,0,NGA风纪区标记:大土亢",
    "CN,1,045BB8BA,0,NGA风纪区标记:大土亢",
    "CN,1,0415F526,0,NGA风纪区标记:大土亢",
    "CN,1,042CA3DC,0,NGA风纪区标记:大土亢",
    "CN,1,046ADC96,0,NGA风纪区标记:大土亢",
    "CN,1,04163525,1,NGA风纪区标记:大土亢",
    "CN,1,05463B37,1,NGA风纪区标记:大土亢",
    "CN,1,04364940,1,NGA风纪区标记:大土亢",
    "CN,1,03F7C7E3,1,NGA风纪区标记:大土亢",
    "CN,1,03EF9D45,1,NGA风纪区标记:大土亢",
    "CN,1,05509AFC,1,NGA风纪区标记:大土亢",
    "CN,1,03F98190,1,NGA风纪区标记:大土亢",
    "CN,1,04BF2CAD,1,NGA风纪区标记:大土亢",
    "CN,1,0541F0B4,1,NGA风纪区标记:大土亢",
    "CN,1,0502238E,1,NGA风纪区标记:大土亢",
    "CN,1,04E478D7,1,NGA风纪区标记:大土亢",
    "CN,1,040BB0E3,1,NGA风纪区标记:大土亢",
    "CN,1,04127CA6,1,NGA风纪区标记:大土亢",
    "CN,1,04653F20,1,NGA风纪区标记:大土亢",
    "CN,1,04F1FBD7,1,NGA风纪区标记:大土亢",
}
-- 名单字符串转配置
local decode = function(message, separator)
    local roster = {}
    for line in string.gmatch(message, string.format("([^%s]*)%s?", separator, separator)) do
        local record = string.gsub(line, separator, "")
        if record and not (record == "") then
            roster[table.getn(roster) + 1] = record
        end
    end
    return roster
end



-- 检查输出结果
local PerformCompare = function(self)
    for i = 1, GetNumGroupMembers() - 1 do
        local groupMemberUnitID = string.format("party%d", i)
        local groupMemberUnitName = UnitName(groupMemberUnitID)
        local groupMemberUnitGUID = UnitGUID(groupMemberUnitID)
        for index, line in pairs(roster) do
            local regionName, projectId, charactarGUID, charactarWantedLevel, charactarRemark = unpack(decode(line, ","))
            if regionName == GetCurrentRegionName() and tonumber(projectId) == WOW_PROJECT_ID and tonumber(charactarWantedLevel) < 3 and groupMemberUnitGUID then
                for groupMemberCharactarGUID in string.gmatch(groupMemberUnitGUID, "Player-.*-(.*)") do
                    if groupMemberCharactarGUID == charactarGUID then
                        local message = string.format("集合石提醒: %s(%s) %s", groupMemberUnitName, groupMemberUnitGUID, charactarRemark)
                        RaidNotice_AddMessage(RaidWarningFrame, message, ChatTypeInfo["RAID_WARNING"])
                        SendChatMessage(message, "PARTY")
                    end
                end
            end
        end
    end
end


-- 监视队友人员变动
local GROUP_ROSTER_UPDATE = CreateFrame("Frame")
GROUP_ROSTER_UPDATE:SetScript("OnEvent", function(self, event)
        if event == "GROUP_ROSTER_UPDATE" then
            PerformCompare()
        end
end)
GROUP_ROSTER_UPDATE:RegisterEvent("GROUP_ROSTER_UPDATE")
