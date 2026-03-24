--
-- Copyright (c) 2026 by RaiderIO, Inc.
-- All rights reserved.
--
local provider={name=...,data=3,region="tw",date="2026-03-15T06:41:24Z",numCharacters=29192,lookup={},recordSizeInBytes=2,encodingOrder={0,1,3}}
local F

-- chunk size: 2
F = function() provider.lookup[1] = "\4\4" end F()

F = nil
RaiderIO.AddProvider(provider)
