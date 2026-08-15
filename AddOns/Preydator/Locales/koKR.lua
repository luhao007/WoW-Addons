---@diagnostic disable
-- Preydator: koKR (Korean) localization
-- Note: This locale requires Korean character input from a native speaker.
if GetLocale() ~= "koKR" then return end
local L = _G.PreydatorL

-- L["No Sign in These Fields"]   = ""
-- L["AMBUSH"]                    = ""
-- L["Scent in the Wind"]         = ""
-- L["Blood in the Shadows"]      = ""
-- L["Echoes of the Kill"]        = ""
-- L["Feast of the Fang"]         = ""

-- Difficulty names — used to identify difficulty from adventure-map pin descriptions.
-- AI-TRANSLATED: These values have not been verified against live WoW koKR client text.
-- A native speaker should confirm these match what the game actually shows in pin descriptions.
L["Normal"]    = "일반"
L["Hard"]      = "어려움"
L["Nightmare"] = "악몽"
