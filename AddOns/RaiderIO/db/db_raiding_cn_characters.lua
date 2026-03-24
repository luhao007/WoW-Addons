--
-- Copyright (c) 2026 by RaiderIO, Inc.
-- All rights reserved.
--
local provider={["name"]=...,["data"]=2,["region"]="cn",["date"]="2026-03-10T08:00:48Z",["numCharacters"]=6,["recordSizeInBytes"]=14,["encodingOrder"]={1,4},["currentRaids"]={{["id"]=16340,["mapId"]=2912,["name"]="MN Tier 1 (VS / DR / MQD)",["shortName"]="VS/DR/MQD",["bossCount"]=9,["ordinal"]=1}},["previousRaids"]={},["db"]={}}
local F

F = function() provider.db["卡德加"]={0,"自寻死路丨"} end F()
F = function() provider.db["冰风岗"]={14,"灵魂复苏"} end F()
F = function() provider.db["无尽之海"]={28,"九点二十一","整活大師","札皮"} end F()
F = function() provider.db["凤凰之神"]={70,"土豆汉堡包"} end F()

F = nil
RaiderIO.AddProvider(provider)
