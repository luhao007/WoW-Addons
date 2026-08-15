LBIS = {}
LBIS.L = {};
local L = LBIS.L;
LBIS.ENGLISH_CLASS = {};

local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to 
 -- avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});

local CLASS_NAMES = {};
if FillLocalizedClassList then
	FillLocalizedClassList(CLASS_NAMES)
elseif LocalizedClassList then
	CLASS_NAMES = LocalizedClassList()
else
	-- Fallback for Midnight
	for i = 1, GetNumClasses() do
		local className, classFile = GetClassInfo(i)
		if classFile then
			CLASS_NAMES[classFile] = className
		end
	end
end
L["Druid"] = CLASS_NAMES.DRUID;
L["Hunter"] = CLASS_NAMES.HUNTER;
L["Mage"] = CLASS_NAMES.MAGE;
L["Paladin"] = CLASS_NAMES.PALADIN;
L["Priest"] = CLASS_NAMES.PRIEST;
L["Rogue"] = CLASS_NAMES.ROGUE;
L["Shaman"] = CLASS_NAMES.SHAMAN;
L["Warlock"] = CLASS_NAMES.WARLOCK;
L["Warrior"] = CLASS_NAMES.WARRIOR;
L["Death Knight"] = CLASS_NAMES.DEATHKNIGHT;
L["Monk"] = CLASS_NAMES.MONK;

LBIS.ENGLISH_CLASS[CLASS_NAMES.DRUID] =  "Druid";
LBIS.ENGLISH_CLASS[CLASS_NAMES.HUNTER] =  "Hunter";
LBIS.ENGLISH_CLASS[CLASS_NAMES.MAGE] =  "Mage";
LBIS.ENGLISH_CLASS[CLASS_NAMES.PALADIN] =  "Paladin";
LBIS.ENGLISH_CLASS[CLASS_NAMES.PRIEST] =  "Priest";
LBIS.ENGLISH_CLASS[CLASS_NAMES.ROGUE] =  "Rogue";
LBIS.ENGLISH_CLASS[CLASS_NAMES.SHAMAN] =  "Shaman";
LBIS.ENGLISH_CLASS[CLASS_NAMES.WARLOCK] =  "Warlock";
LBIS.ENGLISH_CLASS[CLASS_NAMES.WARRIOR] =  "Warrior";
LBIS.ENGLISH_CLASS[CLASS_NAMES.DEATHKNIGHT] =  "DeathKnight";
LBIS.ENGLISH_CLASS[CLASS_NAMES.MONK] =  "Monk";
-- Retail classes not in original MoP version
if CLASS_NAMES.DEMONHUNTER then
	L["Demon Hunter"] = CLASS_NAMES.DEMONHUNTER;
	LBIS.ENGLISH_CLASS[CLASS_NAMES.DEMONHUNTER] = "DemonHunter";
end
if CLASS_NAMES.EVOKER then
	L["Evoker"] = CLASS_NAMES.EVOKER;
	LBIS.ENGLISH_CLASS[CLASS_NAMES.EVOKER] = "Evoker";
end

-- Retail spec names (not in original MoP addon)
-- These use the defaultFunc fallback for non-English clients,
-- returning the English key as-is. This is acceptable since
-- the addon's spec registration uses these as lookup keys.
L["Feral"] = "Feral";
L["Guardian"] = "Guardian";
L["Outlaw"] = "Outlaw";
L["Havoc"] = "Havoc";
L["Vengeance"] = "Vengeance";
L["Devourer"] = "Devourer";
L["Devastation"] = "Devastation";
L["Preservation"] = "Preservation";
L["Augmentation"] = "Augmentation";
