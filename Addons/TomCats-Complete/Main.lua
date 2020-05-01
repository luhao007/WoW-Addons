local addon = select(2, ...)
local TomCatsAddOns = {
    { name = "TomCats", version = "1.0.12" },
    { name = "Coordinates", version = "2.1.0" },
    { name = "TomCats-ArathiHighlandsRares", version = "1.2.11" },
    { name = "TomCats-Complete", version = "1.4.3" },
    { name = "TomCats-Coordinates", version = "2.0.5" },
    { name = "TomCats-DarkshoreRares", version = "1.2.11" },
    { name = "TomCats-HallowsEnd", version = "1.2.7" },
    { name = "TomCats-Hivemind", version = "0.1.6" },
    { name = "TomCats-LunarFestival", version = "1.0.21" },
    { name = "TomCats-LoveIsInTheAir", version = "1.0.14" },
    { name = "TomCats-WarfrontsCommandCenter", version = "1.2.7" },
    { name = "TomCats-Noblegarden", version = "1.0.5" },
    { name = "TomCats-ChildrensWeek", version = "1.0.6" },
    { name = "TomCats-Mechagon", version = "1.0.11" },
    { name = "TomCats-Nazjatar", version = "1.0.12" }
}
if (TomCats and TomCats.Register) then
    TomCats:Register(
        {
            name = "Complete",
            version = "1.4.3"
        }
    )
    TomCats.installed = {}
    local missing = false
    for i = 1, #TomCatsAddOns do
        local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(TomCatsAddOns[i].name)
        if (loadable == "MISSING") then
            if (not missing) then
                missing = true
                --print("One or more TomCat's Tours addons are missing from your installation:")
            end
            --print("- " .. name)
        end
    end
    if (missing) then
        --print("Please check your settings on Twitch for TomCat's Tours: Complete")
    end
end
