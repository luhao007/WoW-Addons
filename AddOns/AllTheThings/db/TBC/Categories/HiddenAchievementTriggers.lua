---@diagnostic disable: deprecated
local appName, _ = ...;
local x=_.CreateExpansion;
--STRUCTURE_REPLACEMENTS
_.Categories.HiddenAchievementTriggers={
x(1),x(2,{awp=20000})};
