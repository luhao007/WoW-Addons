-- **************************************************************************
-- * TitanBag.lua
-- *
-- * By: The Titan Panel Development Team
-- **************************************************************************

local TITAN_VOLUME_ID = "Volume";
local TITAN_VOLUME_FRAME_SHOW_TIME = 0.5;
local TITAN_VOLUME_ARTWORK_PATH = "Interface\\AddOns\\TitanVolume\\Artwork\\";
local _G = getfenv(0);
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)

function TitanPanelVolumeButton_OnLoad(self)
	self.registry = {
		id = TITAN_VOLUME_ID,
		category = "Built-ins",
		version = TITAN_VERSION,
		menuText = L["TITAN_VOLUME_MENU_TEXT"],
		tooltipTitle = VOLUME, --L["TITAN_VOLUME_TOOLTIP"],
		tooltipTextFunction = "TitanPanelVolumeButton_GetTooltipText",
		iconWidth = 32,
		iconButtonWidth = 18,
		savedVariables = {
			OverrideBlizzSettings = false,
			VolumeMaster = 1,
			VolumeAmbience = 0.5,
			VolumeDialog = 0.5,
			VolumeSFX = 0.5,
			VolumeMusic = 0.5,
--			VolumeOutboundChat = 1,
--			VolumeInboundChat = 1,
			DisplayOnRightSide = 1,
		}
	};
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function TitanPanelVolumeButton_OnEvent(self, event, a1, ...)
	if event == "PLAYER_ENTERING_WORLD" and TitanGetVar(TITAN_VOLUME_ID, "OverrideBlizzSettings") then
		-- Override Blizzard's volume CVar settings
		if TitanGetVar(TITAN_VOLUME_ID, "VolumeMaster") then SetCVar("Sound_MasterVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeMaster")) TitanPanelVolume_SetVolumeIcon() end
		if TitanGetVar(TITAN_VOLUME_ID, "VolumeAmbience") then SetCVar("Sound_AmbienceVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeAmbience")) end
		if TitanGetVar(TITAN_VOLUME_ID, "VolumeDialog") then SetCVar("Sound_DialogVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeDialog")) end
		if TitanGetVar(TITAN_VOLUME_ID, "VolumeSFX") then SetCVar("Sound_SFXVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeSFX")) end
		if TitanGetVar(TITAN_VOLUME_ID, "VolumeMusic") then SetCVar("Sound_MusicVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeMusic")) end
--		if TitanGetVar(TITAN_VOLUME_ID, "VolumeOutboundChat") then SetCVar("OutboundChatVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeOutboundChat")) end
--		if TitanGetVar(TITAN_VOLUME_ID, "VolumeInboundChat") then SetCVar("InboundChatVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeInboundChat")) end
	end
end

function TitanPanelVolumeButton_OnShow()
	TitanPanelVolume_SetVolumeIcon();
end

function TitanPanelVolumeButton_OnEnter()
	-- Confirm master volume value
	TitanPanelMasterVolumeControlSlider:SetValue(1 - GetCVar("Sound_MasterVolume"));
	TitanPanelAmbienceVolumeControlSlider:SetValue(1 - GetCVar("Sound_AmbienceVolume"));
	TitanPanelDialogVolumeControlSlider:SetValue(1 - GetCVar("Sound_DialogVolume"));
	TitanPanelSoundVolumeControlSlider:SetValue(1 - GetCVar("Sound_SFXVolume"));
	TitanPanelMusicVolumeControlSlider:SetValue(1 - GetCVar("Sound_MusicVolume"));
--	TitanPanelMicrophoneVolumeControlSlider:SetValue(1 - GetCVar("OutboundChatVolume"));
--	TitanPanelSpeakerVolumeControlSlider:SetValue(1 - GetCVar("InboundChatVolume"));
	TitanPanelVolume_SetVolumeIcon();
end

-- 'Master'
function TitanPanelMasterVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(OPTION_TOOLTIP_MASTER_VOLUME, TitanPanelVolume_GetVolumeText(GetCVar("Sound_MasterVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelMasterVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelMasterVolumeControlSlider_OnShow(self)
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("Sound_MasterVolume")));
	_G[self:GetName().."High"]:SetText(LOW);
	_G[self:GetName().."Low"]:SetText(HIGH);
	self:SetMinMaxValues(0, 1);
	self:SetValueStep(0.01);
	self:SetObeyStepOnDrag(true) -- since 5.4.2 (Mists of Pandaria)
	self:SetValue(1 - GetCVar("Sound_MasterVolume"));

	local position = TitanUtils_GetRealPosition(TITAN_VOLUME_ID);

	TitanPanelVolumeControlFrame:SetPoint("BOTTOMRIGHT", TITAN_PANEL_DISPLAY_PREFIX..TitanUtils_GetWhichBar(TITAN_VOLUME_ID), "TOPRIGHT", 0, 0);
	if (position == TITAN_PANEL_PLACE_TOP) then
		TitanPanelVolumeControlFrame:ClearAllPoints();
		TitanPanelVolumeControlFrame:SetPoint("TOPLEFT", TITAN_PANEL_DISPLAY_PREFIX..TitanUtils_GetWhichBar(TITAN_VOLUME_ID), "BOTTOMLEFT", UIParent:GetRight() - TitanPanelVolumeControlFrame:GetWidth(), -4);
	else
		TitanPanelVolumeControlFrame:ClearAllPoints();
		TitanPanelVolumeControlFrame:SetPoint("BOTTOMLEFT", TITAN_PANEL_DISPLAY_PREFIX..TitanUtils_GetWhichBar(TITAN_VOLUME_ID), "TOPLEFT", UIParent:GetRight() - TitanPanelVolumeControlFrame:GetWidth(), 0);
	end

end

function TitanPanelMasterVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));

	SetCVar("Sound_MasterVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeMaster", 1 - self:GetValue())

	TitanPanelVolume_SetVolumeIcon();

	-- Update GameTooltip
	if (self.tooltipText) then
		self.tooltipText = TitanOptionSlider_TooltipText(OPTION_TOOLTIP_MASTER_VOLUME, TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

function TitanPanelUnifiedVolumeControlSlider_OnMouseWheel(self, a1)
local tempval = self:GetValue();
if a1 == -1 then
	  self:SetValue(tempval + 0.01);
	end

	if a1 == 1 then
	  self:SetValue(tempval - 0.01);
	end
end


-- 'Music'
function TitanPanelMusicVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(OPTION_TOOLTIP_MUSIC_VOLUME, TitanPanelVolume_GetVolumeText(GetCVar("Sound_MusicVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelMusicVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelMusicVolumeControlSlider_OnShow(self)
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("Sound_MusicVolume")));
	_G[self:GetName().."High"]:SetText(LOW);
	_G[self:GetName().."Low"]:SetText(HIGH);
	self:SetMinMaxValues(0, 1);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("Sound_MusicVolume"));
end

function TitanPanelMusicVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));

	SetCVar("Sound_MusicVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeMusic", 1 - self:GetValue())

	-- Update GameTooltip
	if (self.tooltipText) then
		self.tooltipText = TitanOptionSlider_TooltipText(OPTION_TOOLTIP_MUSIC_VOLUME, TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

-- 'Sound'
function TitanPanelSoundVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(OPTION_TOOLTIP_SOUND_VOLUME, TitanPanelVolume_GetVolumeText(GetCVar("Sound_SFXVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelSoundVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelSoundVolumeControlSlider_OnShow(self)
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("Sound_SFXVolume")));
	_G[self:GetName().."High"]:SetText(LOW);
	_G[self:GetName().."Low"]:SetText(HIGH);
	self:SetMinMaxValues(0, 1);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("Sound_SFXVolume"));
end

function TitanPanelSoundVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));

	SetCVar("Sound_SFXVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeSFX", 1 - self:GetValue())

	-- Update GameTooltip
	if (self.tooltipText) then
		self.tooltipText = TitanOptionSlider_TooltipText(OPTION_TOOLTIP_SOUND_VOLUME, TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

-- 'Ambience'
function TitanPanelAmbienceVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(OPTION_TOOLTIP_ENABLE_AMBIENCE, TitanPanelVolume_GetVolumeText(GetCVar("Sound_AmbienceVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelAmbienceVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelAmbienceVolumeControlSlider_OnShow(self)
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("Sound_AmbienceVolume")));
	_G[self:GetName().."High"]:SetText(LOW);
	_G[self:GetName().."Low"]:SetText(HIGH);
	self:SetMinMaxValues(0, 1);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("Sound_AmbienceVolume"));
end

function TitanPanelAmbienceVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
local tempval = self:GetValue();

	SetCVar("Sound_AmbienceVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeAmbience", 1 - self:GetValue())

	-- Update GameTooltip
	if (self.tooltipText) then
--		self.tooltipText = TitanOptionSlider_TooltipText(L["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		self.tooltipText = TitanOptionSlider_TooltipText(OPTION_TOOLTIP_ENABLE_AMBIENCE, TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

function TitanPanelVolume_GetVolumeText(volume)
	return tostring(floor(100 * volume + 0.5)) .. "%";
end

-- 'Dialog'
function TitanPanelDialogVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(OPTION_TOOLTIP_DIALOG_VOLUME, TitanPanelVolume_GetVolumeText(GetCVar("Sound_DialogVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelDialogVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelDialogVolumeControlSlider_OnShow(self)
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("Sound_DialogVolume")));
	_G[self:GetName().."High"]:SetText(LOW);
	_G[self:GetName().."Low"]:SetText(HIGH);
	self:SetMinMaxValues(0, 1);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("Sound_DialogVolume"));
end

function TitanPanelDialogVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
local tempval = self:GetValue();

	SetCVar("Sound_DialogVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeDialog", 1 - self:GetValue())

	-- Update GameTooltip
	if (self.tooltipText) then
--		self.tooltipText = TitanOptionSlider_TooltipText(L["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		self.tooltipText = TitanOptionSlider_TooltipText(OPTION_TOOLTIP_DIALOG_VOLUME, TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

function TitanPanelVolume_GetVolumeText(volume)
	return tostring(floor(100 * volume + 0.5)) .. "%";
end

--[[
-- 'Microphone'
function TitanPanelMicrophoneVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(L["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(GetCVar("OutboundChatVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelMicrophoneVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelMicrophoneVolumeControlSlider_OnShow(self)
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("OutboundChatVolume")));
	_G[self:GetName().."High"]:SetText(LOW);
	_G[self:GetName().."Low"]:SetText(HIGH);
	self:SetMinMaxValues(-1.50, 0.75);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("OutboundChatVolume"));
end

function TitanPanelMicrophoneVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));

	SetCVar("OutboundChatVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeOutboundChat", 1 - self:GetValue())

	-- Update GameTooltip
	if (self.tooltipText) then
		self.tooltipText = TitanOptionSlider_TooltipText(L["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

-- 'Speaker'
function TitanPanelSpeakerVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(L["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(GetCVar("InboundChatVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelSpeakerVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelSpeakerVolumeControlSlider_OnShow(self)
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("InboundChatVolume")));
	_G[self:GetName().."High"]:SetText(LOW);
	_G[self:GetName().."Low"]:SetText(HIGH);
	self:SetMinMaxValues(0, 1);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("InboundChatVolume"));
end

function TitanPanelSpeakerVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));

	SetCVar("InboundChatVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeInboundChat", 1 - self:GetValue())

	-- Update GameTooltip
	if (self.tooltipText) then
		self.tooltipText = TitanOptionSlider_TooltipText(L["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end
]]--

function TitanPanelVolumeControlFrame_OnLoad(self)
	_G[self:GetName().."Title"]:SetText(VOLUME);
	_G[self:GetName().."MasterTitle"]:SetText(MASTER_VOLUME);
	_G[self:GetName().."MusicTitle"]:SetText(MUSIC_VOLUME);
	_G[self:GetName().."SoundTitle"]:SetText(SOUND_VOLUME);
	_G[self:GetName().."AmbienceTitle"]:SetText(AMBIENCE_VOLUME);
	_G[self:GetName().."DialogTitle"]:SetText(DIALOG_VOLUME);
--	_G[self:GetName().."MicrophoneTitle"]:SetText(L["TITAN_VOLUME_MICROPHONE_CONTROL_TITLE"]);
--	_G[self:GetName().."SpeakerTitle"]:SetText(L["TITAN_VOLUME_SPEAKER_CONTROL_TITLE"]);
--[[
Blizzard decided to remove direct Backdrop API in 9.0 (Shadowlands)
so inherit the template (XML)
and set the values in the code (Lua)

9.5 The tooltip template was removed from the GameTooltip.
--]]
	TitanPanelRightClickMenu_SetCustomBackdrop(self)
end

function TitanPanelVolumeControlFrame_OnUpdate(self, elapsed)
	TitanUtils_CheckFrameCounting(self, elapsed);
end

function TitanPanelVolume_SetVolumeIcon()
	local icon = _G["TitanPanelVolumeButtonIcon"];
	local masterVolume = tonumber(GetCVar("Sound_MasterVolume"));
	if (masterVolume <= 0) then
		icon:SetTexture(TITAN_VOLUME_ARTWORK_PATH.."TitanVolumeMute");
	elseif (masterVolume < 0.33) then
		icon:SetTexture(TITAN_VOLUME_ARTWORK_PATH.."TitanVolumeLow");
	elseif (masterVolume < 0.66) then
		icon:SetTexture(TITAN_VOLUME_ARTWORK_PATH.."TitanVolumeMedium");
	else
		icon:SetTexture(TITAN_VOLUME_ARTWORK_PATH.."TitanVolumeHigh");
	end
end

function TitanPanelVolumeButton_GetTooltipText()
	local volumeMasterText = TitanPanelVolume_GetVolumeText(GetCVar("Sound_MasterVolume"));
	local volumeSoundText = TitanPanelVolume_GetVolumeText(GetCVar("Sound_SFXVolume"));
	local volumeMusicText = TitanPanelVolume_GetVolumeText(GetCVar("Sound_MusicVolume"));
	local volumeAmbienceText = TitanPanelVolume_GetVolumeText(GetCVar("Sound_AmbienceVolume"));
	local volumeDialogText = TitanPanelVolume_GetVolumeText(GetCVar("Sound_DialogVolume"));
--	local volumeMicrophoneText = TitanPanelVolume_GetVolumeText(GetCVar("OutboundChatVolume"));
--	local volumeSpeakerText = TitanPanelVolume_GetVolumeText(GetCVar("InboundChatVolume"));
	return ""..
		MASTER_VOLUME.."\t"..TitanUtils_GetHighlightText(volumeMasterText).."\n"..
		SOUND.." "..VOLUME.."\t"..TitanUtils_GetHighlightText(volumeSoundText).."\n"..
		MUSIC_VOLUME.."\t"..TitanUtils_GetHighlightText(volumeMusicText).."\n"..
		AMBIENCE_VOLUME.."\t"..TitanUtils_GetHighlightText(volumeAmbienceText).."\n"..
		DIALOG_VOLUME.."\t"..TitanUtils_GetHighlightText(volumeDialogText).."\n"..
--		L["TITAN_VOLUME_MICROPHONE_TOOLTIP_VALUE"].."\t"..TitanUtils_GetHighlightText(volumeMicrophoneText).."\n"..
--		L["TITAN_VOLUME_SPEAKER_TOOLTIP_VALUE"].."\t"..TitanUtils_GetHighlightText(volumeSpeakerText).."\n"..
		TitanUtils_GetGreenText(L["TITAN_VOLUME_TOOLTIP_HINT1"]).."\n"..
		TitanUtils_GetGreenText(L["TITAN_VOLUME_TOOLTIP_HINT2"]);
end

function TitanPanelRightClickMenu_PrepareVolumeMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_VOLUME_ID].menuText);

	local info = {};
	info.notCheckable = true
	info.text = L["TITAN_VOLUME_MENU_AUDIO_OPTIONS_LABEL"];
	info.func = function()
		ShowUIPanel(VideoOptionsFrame);
		end
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	info.text = L["TITAN_VOLUME_MENU_OVERRIDE_BLIZZ_SETTINGS"];
	info.notCheckable = false
	info.func = function()
		TitanToggleVar(TITAN_VOLUME_ID, "OverrideBlizzSettings");
	end
	info.checked = TitanGetVar(TITAN_VOLUME_ID, "OverrideBlizzSettings");
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_VOLUME_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end
