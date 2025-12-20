--[===[ File
This file contains the 'Titan ID' Titan or TitanClassic. Used to set up libs, locale, ...
Different folders are required because Titan used Titan as a name (& folder) for the Classic WoW versions.
The saved variables for Classic WoW are in TitanClassic.lua - not Titan.lua.

--]===]
--[[
Way back different Titan used TitanClassic as a name (& folder) for Classic versions - Classic BC and Era.
TITAN_ID was set to Titan or TitanClassic depending on the expansion the player was loading.

For Titan 8.* we decided to combine code into one version rather than fighting to release potentially three distinct WoW versions - Retail; <xpac> Classic; and Classic Era.
However the saved variables for Classic WoW are in TitanClassic.lua - not Titan.lua.

For Burning Crusades; Legion; and Cataclysm this worked because the API was very close to Classic Era.
However when Mists of Pandaria came out, the API was much closer to retail than Classic Era.
--]]

TITAN_ID = "Titan"

