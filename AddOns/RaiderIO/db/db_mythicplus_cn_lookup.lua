--
-- Copyright (c) 2026 by RaiderIO, Inc.
-- All rights reserved.
--
local provider={name=...,data=1,region="cn",date="2026-03-10T08:01:18Z",currentSeasonId=0,numCharacters=6,keystoneMilestoneLevels={15,12,10,7,4,2},lookup={},recordSizeInBytes=30,encodingOrder={1,2,5,6,9,10,11,12,14,15}}
local F

-- chunk size: 180
F = function() provider.lookup[1] = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0" end F()

F = nil
RaiderIO.AddProvider(provider)
