local L = select(2, ...).TomCatsLibs.Locales
select(2, ...).TomCatsLibs.Data.loadData(
	"QuestChoiceInfo",
	{ "choiceID", "questionText", "numOptions", "uiTextureKitID", "hideWarboardHeader", "keepOpenAfterChoice", "soundKitID"},
	{
		{ 508, L["Warfronts"], 2, 261, false, false, 0},
		{ 509, L["Warfronts"], 2, 262, false, false, 0},
	}
)
