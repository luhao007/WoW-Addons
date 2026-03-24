--
-- Copyright (c) 2026 by RaiderIO, Inc.
-- All rights reserved.
--
local provider={name=...,data=1,region="cn",date="2026-03-10T08:01:18Z",currentSeasonId=0,numCharacters=6,keystoneMilestoneLevels={15,12,10,7,4,2},db={}}
local F

F = function() provider.db["卡德加"]={0,"自寻死路丨"} end F()
F = function() provider.db["冰风岗"]={30,"灵魂复苏"} end F()
F = function() provider.db["无尽之海"]={60,"九点二十一","整活大師","札皮"} end F()
F = function() provider.db["凤凰之神"]={150,"土豆汉堡包"} end F()

F = nil
RaiderIO.AddProvider(provider)
