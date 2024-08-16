BuildEnv(...)

local function defaultcvar()
  local W, F, E, L = unpack(_G.WindTools)
  local S = W.Modules.Skins
  local ES = E.Skins
  
  local hooksecurefunc = hooksecurefunc
  local pairs = pairs
  local type = type
  
  local CreateFrame = CreateFrame
  local LibStub = LibStub
  
  local MTSAddon
  local NEG
  local module
  
  local function SkinViaRawHook(object, method, func, noLabel)
      local NetEaseGUI = LibStub("NetEaseGUI-2.0")
      local module = NetEaseGUI and NetEaseGUI:GetClass(object)
      if module and module[method] then
          local original = module[method]
          module[method] = function(self, ...)
              original(self, ...)
              if noLabel then
                  func(self, ...)
              else
                  if not self.__windSkin then
                      func(self, ...)
                      self.__windSkin = true
                  end
              end
          end
      end
  end
  
  local function SkinDropDown(self)
      if self.__windSkin then
          return
      end
      self:StripTextures()
      self:CreateBackdrop("Transparent")
      self.backdrop:ClearAllPoints()
      self.backdrop:SetOutside(self, 1, -3)
      S:ESProxy("HandleNextPrevButton", self.MenuButton, "down")
      self.__windSkin = true
  end
  
  local function SkinListTitle(self)
      if self.__windSkin then
          return
      end
      
      for _, button in pairs(self.sortButtons) do
          button:StripTextures()
          S:ESProxy("HandleButton", button, nil, nil, nil, true, "Transparent")
          button.backdrop:ClearAllPoints()
          button.backdrop:SetOutside(button, -2, 0)
      end
      
      local scrollBar = self:GetScrollBar()
      
      if scrollBar then
          S:ESProxy("HandleNextPrevButton", scrollBar.ScrollUpButton, "up")
          S:ESProxy("HandleNextPrevButton", scrollBar.ScrollDownButton, "down")
          S:ESProxy("HandleScrollBar", scrollBar)
      end
      
      self.__windSkin = true
  end
  
  function S:MeetingStone()
      --if not E.private.WT.skins.enable or not E.private.WT.skins.addons.meetingStone then
      --return
      --end
      
      local NetEaseEnv = LibStub("NetEaseEnv-1.0")
      local NetEaseGUI = LibStub("NetEaseGUI-2.0")
      local MTSAddon = LibStub("AceAddon-3.0"):GetAddon("MeetingStone")
      
      if not NetEaseEnv or not NetEaseGUI then
          return
      end
      
      for k in pairs(NetEaseEnv._NSInclude) do
          if type(k) == "table" then
              NEG = k
          end
      end
      
      if not NEG then
          return
      end
      
      -- Main Panel
      local MainPanel = NEG.MainPanel or MTSAddon and MTSAddon:GetModule("MainPanel")
      if MainPanel then
          S:ESProxy("HandlePortraitFrame", MainPanel)
          self:CreateShadow(MainPanel)
          self:MerathilisUISkin(MainPanel)
          MainPanel.PortraitFrame:Hide()
          local close =
          CreateFrame("Button", "WTMeetingStoneCloseButton", MainPanel, "UIPanelCloseButton, BackdropTemplate")
          close:Point("TOPRIGHT", MainPanel.backdrop, "TOPRIGHT", 2, 4)
          close:SetScript("OnClick", MainPanel.CloseButton:GetScript("OnClick"))
          S:ESProxy("HandleCloseButton", close)
          MainPanel.CloseButton:Kill()
          MainPanel.CloseButton = close
      end
      
      -- Tabs
      SkinViaRawHook(
          "BottomTabButton",
          "SetStatus",
          function(self)
              self.tActiveLeft:StripTextures()
              self.tActiveRight:StripTextures()
              self.tActiveMid:StripTextures()
              self.tLeft:StripTextures()
              self.tRight:StripTextures()
              self.tMid:StripTextures()
              self:GetHighlightTexture():StripTextures()
              self:CreateBackdrop("Transparent")
              self.backdrop:Point("TOPLEFT", 6, E.PixelMode and -1 or -3)
              self.backdrop:Point("BOTTOMRIGHT", -6, 3)
              S:CreateBackdropShadow(self)
          end
      )
      
      -- DropMenu
      SkinViaRawHook(
          "DropMenu",
          "Open",
          function(self, level)
              level = level or 1
              local menu = self.menuList[level]
              if menu and not menu.__windSkin then
                  menu:StripTextures()
                  menu:SetTemplate()
                  self.__windSkin = true
              end
          end,
          true
      )
      
      -- DropMenuItem
      SkinViaRawHook(
          "DropMenuItem",
          "SetHasArrow",
          function(self)
              if self.Arrow then
                  self.Arrow:SetTexture(E.Media.Textures.ArrowUp)
                  self.Arrow:SetRotation(ES.ArrowRotation.right)
                  self.Arrow:SetVertexColor(1, 1, 1)
              end
          end
      )
      
      -- Scroll Bar
      SkinViaRawHook(
          "PageScrollBar",
          "Constructor",
          function(self)
              S:ESProxy("HandleScrollBar", self)
          end
      )
      
      -- List elements
      SkinViaRawHook(
          "ListView",
          "UpdateItems",
          function(self)
              for i = 1, #self.buttons do
                  local button = self:GetButton(i)
                  if button:IsShown() and not button.__windSkin then
                      button:StripTextures()
                      if button.Icon then -- prevent cause error in ElvUI Skin functions
                          button.Icon.GetTexture = button.Icon.GetTexture or E.noop
                      end
                      S:ESProxy("HandleButton", button, nil, nil, nil, true, "Transparent")
                      
                      local selectedTex = button.backdrop:CreateTexture(nil)
                      local classColor = E:ClassColor(E.myclass)
                      selectedTex:SetTexture(E.media.blankTex)
                      selectedTex:SetVertexColor(classColor.r, classColor.g, classColor.b, 0.25)
                      selectedTex:SetInside()
                      selectedTex:Hide()
                      button.backdrop.selectedTex = selectedTex
                      
                      hooksecurefunc(
                          button,
                          "SetChecked",
                          function(_, isChecked)
                              if isChecked then
                                  selectedTex:Show()
                              else
                                  selectedTex:Hide()
                              end
                          end
                      )
                      
                      button.__windSkin = true
                  end
              end
          end,
          true
      )
      
      -- Browse Panel (查找活动)
      local BrowsePanel = NEG.BrowsePanel or MTSAddon and MTSAddon:GetModule("BrowsePanel", true)
      if BrowsePanel then
          -- Check Buttons: Auto join (自动进组) / Double Click Join (双击加入)
          for _, child in pairs({BrowsePanel:GetChildren()}) do
              if child.GetObjectType and child:GetObjectType() == "CheckButton" then
                  S:ESProxy("HandleCheckBox", child)
              end
          end
          
          -- Refresh (重置)
          if BrowsePanel.RefreshButton then
              S:ESProxy("HandleButton", BrowsePanel.RefreshButton, nil, nil, nil, true, "Transparent")
              BrowsePanel.RefreshButton.backdrop:ClearAllPoints()
              BrowsePanel.RefreshButton.backdrop:SetOutside(BrowsePanel.RefreshButton, -1, -1)
          end
          
          -- Meeting Stone EX element (大秘境)
          if BrowsePanel.ExSearchButton then
              S:ESProxy("HandleButton", BrowsePanel.ExSearchButton, nil, nil, nil, true, "Transparent")
              BrowsePanel.ExSearchButton.backdrop:ClearAllPoints()
              BrowsePanel.ExSearchButton.backdrop:SetOutside(BrowsePanel.ExSearchButton, -1, -1)
          end
          
          -- Advanced Filter (高级过滤)
          if BrowsePanel.AdvButton then
              S:ESProxy("HandleButton", BrowsePanel.AdvButton, nil, nil, nil, true, "Transparent")
              BrowsePanel.AdvButton.backdrop:ClearAllPoints()
              BrowsePanel.AdvButton.backdrop:SetOutside(BrowsePanel.AdvButton, -1, -1)
              if BrowsePanel.AdvButton.Shine then
                  BrowsePanel.AdvButton.Shine:Hide()
              end
          end
          
          -- Auto Complete Frame (活动搜索框)
          if BrowsePanel.AutoCompleteFrame then
              BrowsePanel.AutoCompleteFrame:StripTextures()
              BrowsePanel.AutoCompleteFrame:CreateBackdrop()
              BrowsePanel.AutoCompleteFrame.backdrop:ClearAllPoints()
              BrowsePanel.AutoCompleteFrame.backdrop:SetOutside(BrowsePanel.AutoCompleteFrame, 2, 2)
              local scrollBar = BrowsePanel.AutoCompleteFrame:GetScrollBar()
              
              if scrollBar then
                  S:ESProxy("HandleNextPrevButton", scrollBar.ScrollUpButton, "up")
                  S:ESProxy("HandleNextPrevButton", scrollBar.ScrollDownButton, "down")
                  S:ESProxy("HandleScrollBar", scrollBar)
              end
          end
          
          if BrowsePanel.SignUpButton then
              S:ESProxy("HandleButton", BrowsePanel.SignUpButton, nil, nil, nil, true, "Transparent")
          end
          
          if BrowsePanel.ActivityDropdown then
              SkinDropDown(BrowsePanel.ActivityDropdown)
          end
          
          if BrowsePanel.ActivityList then
              SkinListTitle(BrowsePanel.ActivityList)
          end
          
          if BrowsePanel.NoResultBlocker then
              S:ESProxy("HandleButton", BrowsePanel.NoResultBlocker.Button, nil, nil, nil, true, "Transparent")
              F.SetFontOutline(BrowsePanel.NoResultBlocker.Label)
          end
          
          if BrowsePanel.AdvFilterPanel then
              local panel = BrowsePanel.AdvFilterPanel
              S:ESProxy("HandlePortraitFrame", panel)
              S:CreateShadow(panel)
              for _, child in pairs {panel:GetChildren()} do
                  if child.GetObjectType and child:GetObjectType() == "Button" then
                      if child.GetText and child:GetText() ~= "" and child:GetText() ~= nil then
                          S:ESProxy("HandleButton", child, nil, nil, nil, true, "Transparent")
                          child.backdrop:ClearAllPoints()
                          child.backdrop:SetOutside(child, -1, 0)
                      else
                          S:ESProxy("HandleCloseButton", child)
                      end
                  end
              end
              
              for _, child in pairs {panel.Inset:GetChildren()} do
                  if child.Check and child.MaxBox and child.MinBox then
                      S:ESProxy("HandleCheckBox", child.Check)
                      child.MaxBox:StripTextures()
                      S:ESProxy("HandleEditBox", child.MaxBox)
                      child.MinBox:StripTextures()
                      S:ESProxy("HandleEditBox", child.MinBox)
                  end
              end
          end
          
          -- Meeting Stone EX element (大秘境过滤)
          if BrowsePanel.ExSearchPanel then
              local panel = BrowsePanel.ExSearchPanel
              S:ESProxy("HandlePortraitFrame", panel)
              S:CreateShadow(panel)
              for _, child in pairs {panel:GetChildren()} do
                  if child.GetObjectType and child:GetObjectType() == "Button" then
                      if child.GetText and child:GetText() ~= "" and child:GetText() ~= nil then
                          S:ESProxy("HandleButton", child, nil, nil, nil, true, "Transparent")
                          child.backdrop:ClearAllPoints()
                          child.backdrop:SetOutside(child, -1, 0)
                      else
                          S:ESProxy("HandleCloseButton", child)
                      end
                  end
              end
              
              for _, child in pairs {panel.Inset:GetChildren()} do
                  if child.Check then
                      S:ESProxy("HandleCheckBox", child.Check)
                  end
              end
          end
      end
      
      -- Manager Panel (管理活动)
      local ManagerPanel = NEG.ManagerPanel or MTSAddon and MTSAddon:GetModule("ManagerPanel", true)
      if ManagerPanel then
          for _, child in pairs {ManagerPanel:GetChildren()} do
              if child.CreateWidget then
                  ManagerPanel.LeftPart = child
              elseif child.ApplicantList then
                  ManagerPanel.RightPart = child
              end
          end
          
          if ManagerPanel.RefreshButton then
              S:ESProxy("HandleButton", ManagerPanel.RefreshButton, nil, nil, nil, true, "Transparent")
              ManagerPanel.RefreshButton.backdrop:ClearAllPoints()
              ManagerPanel.RefreshButton.backdrop:SetOutside(ManagerPanel.RefreshButton, -1, -2)
          end
          
          for _, child in pairs {ManagerPanel.LeftPart:GetChildren()} do
              if child:GetNumRegions() == 3 then
                  for _, region in pairs {child:GetRegions()} do
                      if region.GetObjectType and region:GetObjectType() == "Texture" then
                          if region.GetTexture then
                              local tex = region:GetTexture()
                              if tex and tex == "Interface\\FriendsFrame\\UI-ChannelFrame-VerticalBar" then
                                  child:StripTextures()
                                  break
                              end
                          end
                      end
                  end
              end
          end
          
          if ManagerPanel.LeftPart and ManagerPanel.LeftPart.CreateButton then
              S:ESProxy("HandleButton", ManagerPanel.LeftPart.CreateButton, nil, nil, nil, true, "Transparent")
          end
          
          if ManagerPanel.LeftPart and ManagerPanel.LeftPart.DisbandButton then
              S:ESProxy("HandleButton", ManagerPanel.LeftPart.DisbandButton, nil, nil, nil, true, "Transparent")
          end
          
          if ManagerPanel.LeftPart and ManagerPanel.LeftPart.CreateWidget then
              for _, child in pairs {ManagerPanel.LeftPart.CreateWidget:GetChildren()} do
                  for _, subChild in pairs {child:GetChildren()} do
                      if subChild.MenuButton and subChild.Text then
                          SkinDropDown(subChild)
                      elseif subChild.tLeft and subChild.tRight then
                          for _, region in pairs {subChild:GetRegions()} do
                              if region.GetObjectType and region:GetObjectType() == "Texture" then
                                  if region.GetTexture then
                                      local tex = region:GetTexture()
                                      if tex and tex == "Interface\\Common\\Common-Input-Border" then
                                          region:StripTextures()
                                      end
                                  end
                              end
                          end
                          S:ESProxy("HandleEditBox", subChild)
                          subChild.backdrop:ClearAllPoints()
                          subChild.backdrop:SetOutside(subChild, -1, -2)
                      elseif subChild:GetObjectType() == "CheckButton" then
                          S:ESProxy("HandleCheckBox", subChild)
                      end
                  end
              end
          end
          
          if ManagerPanel.RightPart and ManagerPanel.RightPart.ApplicantList then
              SkinListTitle(ManagerPanel.RightPart.ApplicantList)
          end
      end
      
      -- Recent Panel (最近玩友)
      local RecentPanel = NEG.RecentPanel or MTSAddon and MTSAddon:GetModule("RecentPanel", true)
      if RecentPanel then
          if RecentPanel.ActivityDropdown then
              SkinDropDown(RecentPanel.ActivityDropdown)
          end
          
          if RecentPanel.ClassDropdown then
              SkinDropDown(RecentPanel.ClassDropdown)
          end
          
          if RecentPanel.RoleDropdown then
              SkinDropDown(RecentPanel.RoleDropdown)
          end
          
          if RecentPanel.SearchInput then
              for _, region in pairs {RecentPanel.SearchInput:GetRegions()} do
                  if region.GetObjectType and region:GetObjectType() == "Texture" then
                      if region.GetTexture then
                          local tex = region:GetTexture()
                          if tex and tex == "Interface\\Common\\Common-Input-Border" then
                              region:StripTextures()
                          end
                      end
                  end
              end
              S:ESProxy("HandleEditBox", RecentPanel.SearchInput)
          end
          
          if RecentPanel.BatchDeleteButton then
              S:ESProxy("HandleButton", RecentPanel.BatchDeleteButton, nil, nil, nil, true, "Transparent")
          end
          
          if RecentPanel.MemberList then
              SkinListTitle(RecentPanel.MemberList)
          end
      end
      
      -- Broker Panel (悬浮框)
      local DataBroker = NEG.DataBroker or MTSAddon and MTSAddon:GetModule("DataBroker", true)
      if DataBroker then
          local BrokerPanel = DataBroker.BrokerPanel
          if BrokerPanel then
              BrokerPanel:SetBackdrop(nil)
              BrokerPanel:CreateBackdrop("Transparent")
              self:CreateBackdropShadow(BrokerPanel)
              self:MerathilisUISkin(BrokerPanel)
          end
      end
      
      -- Meeting Stone EX element (屏蔽玩家列表)
      local IgnoreListPanel = NEG.IgnoreListPanel or MTSAddon and MTSAddon:GetModule("IgnoreListPanel", true)
      if IgnoreListPanel then
          if IgnoreListPanel.IgnoreList then
              SkinListTitle(IgnoreListPanel.IgnoreList)
          end
          
          for _, child in pairs {IgnoreListPanel:GetChildren()} do
              if child.GetObjectType and child:GetObjectType() == "Button" and child.Left and child.Right then
                  S:ESProxy("HandleButton", child)
              end
          end
      end
  end
  
  S:AddCallbackForAddon("MeetingStone")
  S:AddCallbackForAddon("MeetingStonePlus", "MeetingStone")
  S:DisableAddOnSkin("MeetingStone")
  
end

local once = true
local frame = CreateFrame("FRAME", "defaultcvar") 
frame:RegisterEvent("ADDON_LOADED") 
local function eventHandler(self, event, addOnName)
    local useWindSkin = Profile:GetUseWindSkin()
    if once and C_AddOns.IsAddOnLoaded("ElvUI_WindTools") and C_AddOns.IsAddOnLoaded("MeetingStone") and useWindSkin then
        defaultcvar()
        once = false
    end
end 
frame:SetScript("OnEvent", eventHandler)

