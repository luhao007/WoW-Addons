local addonName, PD = ...;
-------------------
local Create = {}
PD.Create=Create
----
Create.pig64='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
Create.FontUrl="Fonts/ARHei.ttf"
Create.bgFile = "interface/chatframe/chatframebackground.blp"
--Create.edgeFile = "Interface/Buttons/WHITE8X8"
Create.edgeFile = "Interface/AddOns/"..addonName.."/Media/Border256.blp"
Create.edgeSize = 6
Create.BackdropColor={0.08, 0.08, 0.08, 0.5}
Create.BackdropBorderColor={0.4, 0.4, 0.4, 0.8}
Create.BackdropData={bgFile = Create.bgFile, tile = true, tileSize = 0,edgeFile = Create.edgeFile, edgeSize = Create.edgeSize}