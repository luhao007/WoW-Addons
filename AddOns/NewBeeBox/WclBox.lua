local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("ADDON_LOADED")


eventFrame:SetScript("OnEvent", function(self, event, addonName)
  if event == "PLAYER_LOGIN" then
    WclBoxGlobal = {}
    WclBoxCharacter = {}

    -- Unregister the PLAYER_LOGIN event after handling it
    eventFrame:UnregisterEvent("PLAYER_LOGIN")
  end

  -- 处理插件加载事件 加载WA字符串
  if event == "ADDON_LOADED" then
    if addonName == "NewBeeBox" then
      if WeakAuras and WeakAuras.AddCompanionData and WagoAppCompanionData then
        -- 如果WagoAppCompanionData中不存在ids属性则添加
        if not WagoAppCompanionData.ids then
          WagoAppCompanionData["ids"] = {}
        end
        -- 如果没有slug属性则添加
        if not WagoAppCompanionData.slugs then
          WagoAppCompanionData["slugs"] = {}
        end
        -- 如果没有uids属性则添加
        if not WagoAppCompanionData.uids then
          WagoAppCompanionData["uids"] = {}
        end

        WeakAuras.AddCompanionData(WagoAppCompanionData)
      end
    end
  end
end)

