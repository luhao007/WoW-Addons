local mod	= DBM:NewMod(2740, "DBM-Raids-Midnight", 1, 1308)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("20251006042845")
--mod:SetCreatureID()--Yes, they're all used
mod:SetEncounterID(3183)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2913)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(

--)

--TODO. Not a damn thing
