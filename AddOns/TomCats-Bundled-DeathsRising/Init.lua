local addon = select(2,...)

function addon.split(inputstr, delimiter)
    local t={}
    delimiter = delimiter or "."
    for str in string.gmatch(inputstr, "([^" .. delimiter .. "]+)") do
        table.insert(t, str)
    end
    return t
end
addon.params = {
    ["Vignette MapID"] = 118,
    ["Map Name"] = "Icecrown",
    ["Timer Delay"] = 5,
    ["Minimap Icon"] = "Interface\\ICONS\\achievement_reputation_argentcrusader",
    ["Icon BGColor"] = addon.split("@iconColor@",","),
    ["Title Line 1"] = "Rares of Death's Rising",
    ["Title Line 2"] = ""
}

function addon.getLocalVars()
    return addon.TomCatsLibs.Data, addon.TomCatsLibs.Locales, addon.params
end

addon.TomCatsLibs.Data["Map Canvases"] = { "WorldMapFrame", "BattlefieldMapFrame" }
