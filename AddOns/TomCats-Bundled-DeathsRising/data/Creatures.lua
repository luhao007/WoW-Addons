local TCL = select(2, ...).TomCatsLibs
TCL.Data.loadData(
	"Creatures",
	{ "Creature ID", "Vignette ID", "Location", "Tracking ID", "Loot", },
		{
			{ 174048, 4530, { 0.442, 0.491 }, 62326, { items = { 183673, 183200, 183616, } }, }, -- Elder Nadox
			{ 174049, 4531, { 0.296, 0.622 }, 62327, { items = { 50074, 183678, 183679, 183677, 183661, 183625, 183200, 183616, } }, }, -- Prince Taldaram
			{ 174050, 4532, { 0.675, 0.580 }, 62328, { items = { 183681, 183200, 183616, } }, }, -- Krik'thir the Gatewatcher
			{ 174051, 4533, { 0.583, 0.394 }, 62329, { items = { 183669, 183626, 183200, 183616, } }, }, -- Trollgore
			{ 174052, 4534, { 0.778, 0.661 }, 62330, { items = { 183671, 183672, 183627, 183200, 183616, } }, }, -- Novos the Summoner
			{ 174053, 4535, { 0.801, 0.612 }, 62331, { items = { 183686, 183685, 183684, 183200, 183616, } }, }, -- The Prophet Tharon'ja
			{ 174054, 4536, { 0.502, 0.879 }, 62332, { items = { 183664, 183665, 183666, 183200, 183616, } }, }, -- Falric
			{ 174055, 4537, { 0.582, 0.834 }, 62333, { items = { 183687, 183663, 183662, 183200, 183616, } }, }, -- Marwyn
			{ 174056, 4538, { 0.586, 0.725 }, 62334, { items = { 183666, 183631, 183630, 183200, 183616, } }, }, -- Forgemaster Garfrost
			{ 174057, 4539, { 0.472, 0.661 }, 62335, { items = { 183674, 183633, 183632, 183200, 183616, } }, }, -- Scourgelord Tyrannus
			{ 174058, 4540, { 0.707, 0.384 }, 62336, { items = { 183675, 183639, 183635, 183634, 183200, 183616, } }, }, -- Bronjahm
			{ 174059, 4541, { 0.648, 0.221 }, 62337, { items = { 183638, 183637, 183636, 183200, 183616, } }, }, -- The Black Knight
			{ 174060, 4542, { 0.540, 0.447 }, 62338, { items = { 50074, 183678, 183679, 183677, 183661, 183625, 183200, 183616, } }, }, -- Prince Keleseth
			{ 174061, 4543, { 0.524, 0.526 }, 62339, { items = { 183668, 183659, 183658, 183200, 183616, } }, }, -- Ingvar the Plunderer
			{ 174062, 4544, { 0.578, 0.561 }, 62340, { items = { 44151, 183670, 183656, 183657, 183200, 183616, } }, }, -- Skadi the Ruthless
			{ 174063, 4545, { 0.511, 0.785 }, 62341, { items = { 183641, 183653, 183655, 183200, 183616, } }, }, -- Lady Deathwhisper
			{ 174064, 4546, { 0.571, 0.303 }, 62342, { items = { 183649, 183650, 183651, 183200, 183616, } }, }, -- Professor Putricide
			{ 174065, 4547, { 0.497, 0.327 }, 62343, { items = { 183646, 183647, 183648, 183200, 183616, } }, }, -- Blood Queen Lana'thel
			{ 174066, 4548, { 0.365, 0.674 }, 62344, { items = { 183643, 183644, 183645, 183200, 183616, } }, }, -- Patchwerk
			{ 174067, 4549, { 0.316, 0.705 }, 62345, { items = { 183642, 183676, 183200, 183616, } }, }, -- Noth the Plaguebringer
		}
)

local L = TCL.Locales

for creatureID, creature in pairs(TCL.Data["Creatures"].records) do
	local key = creatureID .. "_DESC"
	local description = L[key]
	if description ~= key then
		if L.IsTranslationNeeded(key) then
			description = "(" .. L["Translator_Needed"] .. ")\n" .. description
		end
		creature["Description"] = description
	end
end
