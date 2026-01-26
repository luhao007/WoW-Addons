local _, ns = ...
local L = ns.L

if not BigWigsAPI or not BigWigsAPI.RegisterCountdown then
	return
end

local COUNTDOWN_ID = "中文语音：景久"
local COUNTDOWN_NAME = "中文语音：景久"

local path = "Interface\\AddOns\\WYJJDB\\Media\\sound\\%d.ogg"

BigWigsAPI:RegisterCountdown(COUNTDOWN_ID, COUNTDOWN_NAME, {
	path:format(1),
	path:format(2),
	path:format(3),
	path:format(4),
	path:format(5),
	path:format(6),
	path:format(7),
	path:format(8),
	path:format(9),
	path:format(10),
})
