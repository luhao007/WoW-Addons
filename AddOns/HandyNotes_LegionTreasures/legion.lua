local myname, ns = ...

ns.CHEST = 'Treasure Chest'
ns.CHEST_SM = 'Small Treasure Chest'
ns.CHEST_GLIM = 'Glimmering Treasure Chest'

ns.hiddenConfig = {
    groupsHiddenByZone = true,
}

ns.defaultsOverride = {
    show_on_minimap = true,
    groupsHidden = {junk=true,},
}

ns.groups["junk"] = "Junk"
