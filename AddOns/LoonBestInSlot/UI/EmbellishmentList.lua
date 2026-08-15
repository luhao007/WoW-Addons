LBIS.EmbellishmentList = {};

local function createItemRow(f, embEntry, embSource)

    LBIS:GetItemInfo(embEntry.GearId, function(gearItem)
        local window = LBIS.BrowserWindow.Window;

        if gearItem == nil or gearItem.Name == nil then return end

        -- Crafted gear icon + name (left side)
        local b = CreateFrame("Button", nil, f);
        b:SetSize(32, 32);
        local bt = b:CreateTexture();
        bt:SetAllPoints();
        bt:SetTexture(gearItem.Texture);
        b:SetPoint("TOPLEFT", 5, -5);

        LBIS:SetTooltipOnButton(b, gearItem);

        local itemText = f:CreateFontString(nil, nil, "GameFontNormal");
        itemText:SetText(gearItem.Name);
        itemText:SetJustifyH("LEFT");
        itemText:SetPoint("TOPLEFT", b, "TOPRIGHT", 5, -2);

        -- Slot info below item name
        local slotText = f:CreateFontString(nil, nil, "GameFontNormalSmall");
        slotText:SetText("|cff888888Crafted Gear|r");
        slotText:SetPoint("TOPLEFT", itemText, "BOTTOMLEFT", 0, -2);

        -- Embellishment reagent (right side)
        if embEntry.EmbId and embEntry.EmbId > 0 then
            LBIS:GetItemInfo(embEntry.EmbId, function(embItem)
                if embItem == nil or embItem.Name == nil then return end

                local b2 = CreateFrame("Button", nil, f);
                b2:SetSize(32, 32);
                local bt2 = b2:CreateTexture();
                bt2:SetAllPoints();
                bt2:SetTexture(embItem.Texture);
                b2:SetPoint("TOPLEFT", (window.ScrollFrame:GetWidth() / 2), -5);

                LBIS:SetTooltipOnButton(b2, embItem);

                local embText = f:CreateFontString(nil, nil, "GameFontNormal");
                embText:SetText("|cffff8800" .. embItem.Name .. "|r");
                embText:SetJustifyH("LEFT");
                embText:SetPoint("TOPLEFT", b2, "TOPRIGHT", 5, -2);

                local embLabel = f:CreateFontString(nil, nil, "GameFontNormalSmall");
                embLabel:SetText("|cff888888Embellishment|r");
                embLabel:SetPoint("TOPLEFT", embText, "BOTTOMLEFT", 0, -2);
            end);
        else
            -- No embellishment, just show source
            local sourceText = f:CreateFontString(nil, nil, "GameFontNormal");
            sourceText:SetText("|cff33ADFFCrafted|r");
            sourceText:SetJustifyH("LEFT");
            sourceText:SetWidth(window.ScrollFrame:GetWidth() / 2);
            sourceText:SetPoint("TOPLEFT", (window.ScrollFrame:GetWidth() / 2), -5);
        end
    end);

    return 46;
end

function LBIS.EmbellishmentList:UpdateItems()

    LBIS.BrowserWindow.Window.SlotDropDown:Hide();
    LBIS.BrowserWindow.Window.PhaseDropDown:Hide();
    LBIS.BrowserWindow.Window.RankDropDown:Hide();
    LBIS.BrowserWindow.Window.SourceDropDown:Hide();
    LBIS.BrowserWindow.Window.RaidDropDown:Hide();

    LBIS.BrowserWindow:UpdateItemsForSpec(function(point)

        local specEmbs = LBIS.EmbellishmentsBySpecAndId[(LBIS:ResolveSelectedSpec())];

        if specEmbs == nil then
            LBIS.BrowserWindow.Window.ShowUnavailable();
            return;
        end

        for gearId, embEntry in pairs(specEmbs) do
            local embSource = LBIS.EmbellishmentSources and LBIS.EmbellishmentSources[gearId]
            if embSource then
                point = LBIS.BrowserWindow:CreateItemRow(embEntry, embSource, LBISSettings.SelectedSpec.."_emb_"..gearId, point, createItemRow)
            end
        end
    end);
end
