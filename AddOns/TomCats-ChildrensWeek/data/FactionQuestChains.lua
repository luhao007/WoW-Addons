local addon = select(2, ...)
local D = addon.TomCatsLibs.Data

addon.TomCatsLibs.Data.loadData(
        "Faction Quest Chains",
        { "ID", "Faction", "Quest Chain" },
        {
            { 1, "Alliance", D["Quest Chains"][1] }, -- Human
            { 2, "Horde", D["Quest Chains"][2] }, -- Orcish
            { 3, "Alliance", D["Quest Chains"][3] }, -- Draenei
            { 4, "Horde", D["Quest Chains"][4] }, -- Blood Elf
            { 5, "Alliance", D["Quest Chains"][5] }, -- Oracle
            { 6, "Horde", D["Quest Chains"][5] }, -- Oracle
            { 7, "Alliance", D["Quest Chains"][6] }, -- Wolvar
            { 8, "Horde", D["Quest Chains"][6] }, -- Wolvar
            { 9, "Alliance", D["Quest Chains"][7] }, -- Kul Tiran
            { 10, "Horde", D["Quest Chains"][8] }, -- Zandalari
        }
)
