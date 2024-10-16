local AutoTeam = ALPTRematch
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local utils = ALPTRematch.utils
local modeName = {"混合", "练宠", "练级"} --模式名称，只是改文字描述，实际作用不会变，练级模式只会加载有升级位的队伍
local defaultconfig = {
    enable = true, --是否启用
    enableBattleTimer = true, --战斗时间计时，同时统计纯战斗时间和战斗间隔
    enableXpLog = false, --经验获取计算，预估升级时间
    logToFile = false, --记录部分日志到文件，通过插件机制记录到WTF\Account\账号名\SavedVariables\zAutoLoadPetTeam_Rematch.lua中，每次进游戏会清空
    showTeamCount = {true, true, true}, --1 显示在两次复活间的换队次数,只能技能cd时计数,2 全局计数 3 队伍全局计数
    useRematchLoadingDone = false, --是否Rematch的加载完成事件
    mode = 1, --当前模式，对应上面的 1 ，2 ，3
    showTeamMessage = true, --显示换队信息
    loadAfterBattle = 0.04, --战斗后加载队伍，设置为0时关闭,其他值为延时时间(秒)
    loadRetries = 50, --有可用队伍但加载失败时，重试次数
    loadRetryInteval = 0.004, --加载重试间隔(秒)
    defaultTeam = {}, --未找到预设队伍时的默认队伍
    alternates = "毛绒雷象", --练级队列为空时，替补练级宠位置
    petGroups = {}, --自定义宠物组,可将整组用于队伍替补
    showOptionButton = true,
    forceLoadWhenHealOk = true,
    selectWhenTarget = true,
    selectAfterBattle = true,

    gossipOptions = {
        ["2"] = "巴库歇克",
        ["3"] = "",
        ["4"] = ""
    },

    loadHighest = true,
    loadHighestIgnoreProp = true,

    monitorShow = 1,
    rematchEx = {
        useTeamMenu = true,
        showSetButton = 2,
        useGroupMenu = true,
        fillSaveAsTeamName = true,
        useRigthCage = true
    },
    macros = {
        ["ALPTButton1"] = {
            name="普通劳模",
            autointeract = false,
            healPet = true,
            useBandage = true,
            target = true,
            autoConfirm = true,
            waitTeam = true,
            selectGossip = true,
            useTdScript = false,
            userHarp = false,
            debug = false,
            waitTimeout = 10

        },
        ["ALPTButton2"] = {
            autointeract = false,
            healPet = true,
            useBandage = true,
            target = true,
            autoConfirm = true,
            waitTeam = true,
            selectGossip = true,
            useTdScript = false,
            userHarp = false,
            debug = false,
            waitTimeout = 10
        },
        ["ALPTButton3"] = {
            autointeract = false,
            healPet = true,
            useBandage = true,
            target = true,
            autoConfirm = true,
            waitTeam = true,
            selectGossip = true,
            useTdScript = false,
            userHarp = false,
            debug = false,
            waitTimeout = 10
        },
        ["ALPTButton4"] = {
            autointeract = false,
            healPet = true,
            useBandage = true,
            target = true,
            autoConfirm = true,
            waitTeam = true,
            selectGossip = true,
            useTdScript = false,
            userHarp = false,
            debug = false,
            waitTimeout = 10
        },
        ["ALPTButton5"] = {
            autointeract = false,
            healPet = true,
            useBandage = true,
            target = true,
            autoConfirm = true,
            waitTeam = true,
            selectGossip = true,
            useTdScript = false,
            userHarp = false,
            debug = false,
            waitTimeout = 10
        }
    },
    debug = false --调试模式，会显示完整队列信息
}

local config = {}

StaticPopupDialogs["APLT_RELOADUI"] = {
    text = "确定要重置配置么，您以前的设置修改将丢失?",
    button1 = ACCEPT,
    button2 = CANCEL,
    OnAccept = function()
        utils:SetConfig(defaultconfig)
        C_UI.Reload()
    end,
    hideOnEscape = 1
}

local function tcopy(to, from)
    for k, v in pairs(from) do
        if type(v) == "table" then
            if to[k] and type(to[k]) == "table" then
            else
                to[k] = {}
            end
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end
function pairsByKeys(t)
    local a = {}

    for n in pairs(t) do
        a[#a + 1] = n
    end

    table.sort(a)

    local i = 0

    return function()
        i = i + 1
        return a[i], t[a[i]]
    end
end

local petGroupSize = 0
local newOrder
do
    local current = 0
    function newOrder()
        current = current + 1
        return current
    end
end

local function colorize(s, color)
    if color and s then
        return string.format(
            "|cff%02x%02x%02x%s|r",
            (color.r or 1) * 255,
            (color.g or 1) * 255,
            (color.b or 1) * 255,
            s
        )
    else
        return s
    end
end
local red = {r = 1.0, g = 0.2, b = 0.2}
local blue = {r = 0.0, g = 0.44, b = 0.87}

AutoTeam.options = {
    type = "group",
    childGroups = "tab",
    name = "参数设置",
    plugins = {},
    args = {
        generaloptions = {
            type = "group",
            name = "一般选项",
            order = newOrder(),
            args = {
                base = {
                    type = "group",
                    name = "全局设置",
                    order = 1,
                    inline = true,
                    args = {
                        enable = {
                            type = "toggle",
                            name = "启动自动换队",
                            width = "double",
                            desc = "请在Rematch中维护目标的队伍列表",
                            order = newOrder(),
                            get = function()
                                return config.enable
                            end,
                            set = function()
                                config.enable = not config.enable
                            end
                        },
                        gamemode = {
                            type = "select",
                            name = "换队模式",
                            values = {
                                [1] = modeName[1],
                                [2] = modeName[2],
                                [3] = modeName[3]
                            },
                            get = function()
                                return config.mode
                            end,
                            set = function(info, val)
                                config.mode = val
                            end,
                            order = newOrder()
                        },

                        selectWhenTarget = {
                            type = "toggle",
                            name = "选中目标时换队",
                            width = "double",
                            desc = "选中目标时更换队伍",
                            order = newOrder(),
                            get = function()
                                return config.selectWhenTarget
                            end,
                            set = function()
                                config.selectWhenTarget = not config.selectWhenTarget
                            end
                        },
                        selectAfterBattle = {
                            type = "toggle",
                            name = "对战结束后换队",
                            width = "double",
                            desc = "对战后尝试更换队伍",
                            order = newOrder(),
                            get = function()
                                return config.selectAfterBattle
                            end,
                            set = function()
                                config.selectAfterBattle = not config.selectAfterBattle
                            end
                        },
                        forceLoadWhenHealOk = {
                            type = "toggle",
                            name = "如果复活可用，直接加载第一队",
                            width = "double",
                            desc = "对于持续对战，第一队一般是最快的，复活可用的情况下优先第一队可提高效率",
                            order = newOrder(),
                            get = function()
                                return config.forceLoadWhenHealOk
                            end,
                            set = function()
                                config.forceLoadWhenHealOk = not config.forceLoadWhenHealOk
                            end
                        },
                        
                        useRematchLoadingDone = {
                            type = "toggle",
                            width = "double",
                            name = "触发Rematch加载事件",
                            desc = "队伍加载后，触发Rematch自身的加载完成事件，如显示当前队伍窗体等",
                            order = newOrder(),
                            get = function()
                                return config.useRematchLoadingDone
                            end,
                            set = function()
                                config.useRematchLoadingDone = not config.useRematchLoadingDone
                            end
                        },
                        monitorShow = {
                            type = "select",
                            name = "显示升级监控面板",
                            desc = "整合zPetBattleLevelUpMonitor",
                            style = "radio",
                            values = {
                                [0] = "不显示",
                                [1] = "战斗中显示",
                                [2] = "一直显示"
                            },
                            get = function()
                                return config.monitorShow
                            end,
                            set = function(info, val)
                                config.monitorShow = val
                                AutoTeam:toggleMonitor()
                            end,
                            order = newOrder()
                        },            
                    }
                },
                timer = {
                    type = "group",
                    name = "信息输出",
                    order = newOrder(),
                    inline = true,
                    args = {
                        showTeamMessage = {
                            type = "toggle",
                            name = "显示换队信息",
                            order = newOrder(),
                            width = 1.5,
                            get = function()
                                return config.showTeamMessage
                            end,
                            set = function()
                                config.showTeamMessage = not config.showTeamMessage
                            end
                        },
                        enableBattleTimer = {
                            type = "toggle",
                            name = "显示战斗计时",
                            desc = "战斗时间计时，同时统计纯战斗时间和战斗间隔",
                            width = 1.5,
                            order = newOrder(),
                            get = function()
                                return config.enableBattleTimer
                            end,
                            set = function()
                                config.enableBattleTimer = not config.enableBattleTimer
                            end
                        },
                        enableXpLog = {
                            type = "toggle",
                            name = "预估升级时间",
                            desc = "计算经验获取，预估升级时间",
                            width = 1.5,
                            order = newOrder(),
                            get = function()
                                return config.enableXpLog
                            end,
                            set = function()
                                config.enableXpLog = not config.enableXpLog
                            end
                        },
                        showTeamCount1 = {
                            type = "toggle",
                            width = 1.5,
                            name = "显示两次复活间的换队次数",
                            order = newOrder(),
                            get = function()
                                return config.showTeamCount[1]
                            end,
                            set = function()
                                config.config.showTeamCount[1] = not config.config.showTeamCount[1]
                            end
                        },
                        showTeamCount2 = {
                            type = "toggle",
                            width = 1.5,
                            name = "显示全局换队次数",
                            order = newOrder(),
                            get = function()
                                return config.showTeamCount[2]
                            end,
                            set = function()
                                config.showTeamCount[2] = not config.showTeamCount[2]
                            end
                        },
                        showTeamCount3 = {
                            type = "toggle",
                            width = 1.5,
                            name = "显示队伍全局加载次数",
                            order = newOrder(),
                            get = function()
                                return config.showTeamCount[3]
                            end,
                            set = function()
                                config.showTeamCount[3] = not config.showTeamCount[3]
                            end
                        }
                    }
                },
                alternates = {
                    type = "group",
                    name = "替补设置",
                    inline = true,
                    order = newOrder(),
                    args = {
                        defaultTeam = {
                            order = newOrder(),
                            type = "input",
                            width = "double",
                            name = "目标未设置队伍时，加载指定的队伍",
                            desc = "只能一个队伍",
                            set = function(info, val)
                                if val and val ~= nil then
                                    config.defaultTeam = {val}
                                else
                                    config.defaultTeam = {}
                                end
                            end,
                            get = function()
                                return (config.defaultTeam and config.defaultTeam[1]) or ""
                            end
                        },
                        alternates = {
                            order = newOrder(),
                            type = "input",
                            width = "double",
                            name = "练级队列为空时，替补练级宠",
                            desc = "练级队列为空时，替补练级宠位置\n让练宠队伍也可以继续练级\n只能一只，推荐毛绒雷象或机械宠",
                            set = function(info, val)
                                config.alternates = val
                                AutoTeam:UpdateAlternates()
                            end,
                            get = function()
                                return config.alternates or ""
                            end
                        }
                    }
                },
                loaddelay = {
                    type = "group",
                    name = "延时设置",
                    inline = true,
                    order = newOrder(),
                    args = {
                        loadAfterBattle = {
                            order = newOrder(),
                            type = "range",
                            width = "full",
                            name = "战斗后延时加载队伍（毫秒）",
                            desc = "战斗后直接加载队伍成功率很低，根据自身网络增加延时",
                            min = 10,
                            max = 1000,
                            step = 10,
                            get = function()
                                return config.loadAfterBattle * 1000
                            end,
                            set = function(_, val)
                                config.loadAfterBattle = val / 1000
                            end
                        },
                        loadRetryInteval = {
                            order = newOrder(),
                            type = "range",
                            width = "full",
                            name = "加载重试间隔（毫秒）",
                            desc = "加载失败后再次加载的时间间隔",
                            min = 1,
                            max = 50,
                            step = 1,
                            get = function()
                                return config.loadRetryInteval * 1000
                            end,
                            set = function(_, val)
                                config.loadRetryInteval = val / 1000
                            end
                        },
                        loadRetries = {
                            order = newOrder(),
                            type = "range",
                            width = "full",
                            name = "重试次数",
                            desc = "有可用队伍但加载失败时，重试次数",
                            min = 1,
                            max = 200,
                            step = 1,
                            get = function()
                                return config.loadRetries
                            end,
                            set = function(_, val)
                                config.loadRetries = val
                            end
                        }
                    }
                },
                debugs = {
                    type = "group",
                    name = "调试参数",
                    inline = true,
                    order = newOrder(),
                    args = {
                        debugmode = {
                            type = "toggle",
                            name = "输出调试信息",
                            desc = "在聊天框输出换队过程",
                            order = newOrder(),
                            get = function()
                                return config.debug
                            end,
                            set = function()
                                config.debug = not config.debug
                            end
                        },
                        logToFile = {
                            type = "toggle",
                            name = "记录战斗日志",
                            order = newOrder(),
                            get = function()
                                return config.logToFile
                            end,
                            set = function()
                                config.logToFile = not config.logToFile
                            end
                        },
                        desc = {
                            type = "description",
                            name = "战斗日志会通过插件机制记录到SavedVariables\\zAutoLoadPetTeam_Rematch.lua中\n每次进游戏会清空",
                            order = newOrder()
                        }
                    }
                }
            }
        },
        rematchex = {
            type = "group",
            name = "Rematch扩展",
            order = newOrder(),
            childGroups = "tab",
            args = {
                desc = {
                    type = "description",
                    name = RED_FONT_COLOR_CODE .. "本页选项需要重载界面才能完全生效" .. FONT_COLOR_CODE_CLOSE,
                    order = newOrder()
                },
                setbutton = {
                    type = "toggle",
                    name = "在Rematch面板上显示插件设置按钮",
                    width = "double",
                    order = newOrder(),
                    get = function()
                        return config.showOptionButton
                    end,
                    set = function()
                        config.showOptionButton = not config.showOptionButton
                        AutoTeam:ShowOptionButton()
                    end
                },
                useTeamMenu = {
                    type = "toggle",
                    name = "启用队伍右键“换队参数设置”",
                    width = "full",
                    order = newOrder(),
                    get = function()
                        return config.rematchEx.useTeamMenu
                    end,
                    set = function()
                        config.rematchEx.useTeamMenu = not config.rematchEx.useTeamMenu
                    end
                },
                showSetButton = {
                    type = "select",
                    name = "在队伍上显示“换队参数设置”按钮",
                    style = "radio",
                    values = {
                        [0] = "不显示",
                        [1] = "一直显示",
                        [2] = "有设置过的显示"
                    },
                    get = function()
                        return config.rematchEx.showSetButton
                    end,
                    set = function(info, val)
                        config.rematchEx.showSetButton = val
                    end,
                    order = newOrder()
                },
                useGroupMenu = {
                    type = "toggle",
                    name = "在宠物列表右键添加“添加到宠物组”选项",
                    width = "full",
                    order = newOrder(),
                    get = function()
                        return config.rematchEx.useGroupMenu
                    end,
                    set = function()
                        config.rematchEx.useGroupMenu = not config.rematchEx.useGroupMenu
                    end
                },
                useRigthCage = {
                    type = "toggle",
                    name = "宠物列表按Ctrl+右键时直接装笼",
                    width = "full",
                    order = newOrder(),
                    get = function()
                        return config.rematchEx.useRigthCage
                    end,
                    set = function()
                        config.rematchEx.useRigthCage = not config.rematchEx.useRigthCage
                    end
                },
                blankline = {
                    type = "description",
                    name = "\n",
                    order = newOrder()
                },
                reset = {
                    type = "execute",
                    name = "重载界面",
                    order = newOrder(),
                    width = "full",
                    func = function()
                        C_UI.Reload()
                    end
                }
            }
        },
        petgroup = {
            type = "group",
            name = "宠物组",
            order = newOrder(),
            childGroups = "tab",
            args = {}
        },
        gossipOption = {
            type = "group",
            name = "目标选项",
            order = newOrder(),
            childGroups = "tab",
            args = {
                blankline1 = {
                    type = "description",
                    name = "\n",
                    order = newOrder()
                },
                gossipOption2 = {
                    type = "input",
                    name = "以下目标使用第二个对话选项开始战斗(多个逗号分割开)",
                    order = newOrder(),
                    width = "full",
                    get = function()
                        return config.gossipOptions["2"] or ""   
                    end,
                    set = function(info, val)
                        config.gossipOptions["2"] = val
                    end
                },
                blankline2 = {
                    type = "description",
                    name = "\n",
                    order = newOrder()
                },
                gossipOption3 = {
                    type = "input",
                    name = "以下目标使用第三个对话选项开始战斗(多个逗号分割开)",
                    order = newOrder(),
                    width = "full",
                    get = function()
                        return config.gossipOptions["3"] or ""
                    end,
                    set = function(info, val)
                        config.gossipOptions["3"] = val
                    end
                },
                blankline3 = {
                    type = "description",
                    name = "\n",
                    order = newOrder()
                },
                gossipOption4 = {
                    type = "input",
                    name = "以下目标使用第四个对话选项开始战斗(多个逗号分割开)",
                    order = newOrder(),
                    width = "full",
                    get = function()
                        return config.gossipOptions["4"] or ""
                    end,
                    set = function(info, val)
                        config.gossipOptions["4"] = val
                    end
                },

            }
        },
        macrogroup = {
            type = "group",
            name = "宏按钮",
            order = newOrder(),
            args = {}
        },
        reset = {
            type = "group",
            name = "重置",
            order = newOrder(),
            childGroups = "tab",
            args = {
                reset = {
                    type = "execute",
                    name = "重置配置",
                    order = newOrder(),
                    func = function()
                        local dialog = StaticPopup_Show("APLT_RELOADUI")
                        if dialog then
                            oldstrata = dialog:GetFrameStrata()
                            dialog:SetFrameStrata("TOOLTIP")
                        end
                    end
                }
            }
        }
    }
}

function AutoTeam:HasGroup()
    return petGroupSize > 0
end
function AutoTeam:NotifyChange()
    if AceConfigRegistry.NotifyChange then
        AceConfigRegistry:NotifyChange("AutoTeam")
    end
    AutoTeam:updatePetGroup()
end

function AutoTeam:NewGroup(name)
    if config.petGroups[name] then
        print(RED_FONT_COLOR_CODE .. "[" .. name .. "] 已存在" .. FONT_COLOR_CODE_CLOSE)
    else
        config.petGroups[name] = {}
        config.GroupIndexs[#config.GroupIndexs+1] = name
        config.GroupPetIndexs[name] = {}

        AutoTeam:InitGroups()
        AutoTeam:InitGroupMenu()
    end
end
function AutoTeam:RemoveGroup(name)
    config.petGroups[name] = nil
    config.GroupPetIndexs[name] = nil
    local indexs = config.GroupIndexs
    for m = 1, #indexs do
        if indexs[m] == name then
            table.remove(indexs,m)
            break
        end
    end
    AutoTeam:InitGroups()
    AutoTeam:InitGroupMenu()
end
function AutoTeam:GetPetGroups()
    return config.petGroups,config.GroupIndexs,config.GroupPetIndexs
end

function AutoTeam:AddGroupPet(group, val, petName)
    local spId
    if petName then
        spId = val
    else
        for petID in utils:AllOwnedPets() do
            local speciesID,speciesName,canBattle = utils:GetPetSpecInfo(petID)
            if canBattle and speciesName == val then
                spId = speciesID
                petName = speciesName
                break
            end
        end
    end
    if spId then
        local petGroup = config.petGroups[group]
        if not petGroup[spId] then
            petGroup[spId] = {1, 1, 1}
            local indexs = config.GroupPetIndexs[group]
            indexs[#indexs+1] = spId

            AutoTeam:InitGroups()
            print(NORMAL_FONT_COLOR_CODE .. "已添加 [" .. petName .. "] 到 [" .. group .. "]" .. FONT_COLOR_CODE_CLOSE)
        else
            print(NORMAL_FONT_COLOR_CODE .. "[" .. petName .. "] 已在组 [" .. group .. "] 中" .. FONT_COLOR_CODE_CLOSE)
        end
        return
    end
    print(RED_FONT_COLOR_CODE .. "未找到可用宠物[" .. val .. "]" .. FONT_COLOR_CODE_CLOSE)
end

function AutoTeam:RemoveGroupPet(group, speciesID)
    config.petGroups[group][speciesID] = nil
    local indexs = config.GroupPetIndexs[group] 
    for m = 1, #indexs do
        if indexs[m] == speciesID then
            table.remove(indexs,m)
            break
        end
    end
    AutoTeam:InitGroups()
end
function AutoTeam:moveGroupUp(group, speciesID)
    local indexs = config.GroupPetIndexs[group] 
    for m = 1, #indexs do
        if indexs[m] == speciesID then
            if m >1 then
                local sp = indexs[m-1]
                indexs[m-1] = speciesID
                indexs[m] = sp
            end
            break
        end
    end
    AutoTeam:InitGroups()
end
function AutoTeam:moveGroupDown(group, speciesID)
    local indexs = config.GroupPetIndexs[group] 
    for m = 1, #indexs do
        if indexs[m] == speciesID then
            if m < #indexs then
                local sp = indexs[m+1]
                indexs[m+1] = speciesID
                indexs[m] = sp
            end
            break
        end
    end
    AutoTeam:InitGroups()
end
function AutoTeam:InitGroups()
    local options = AutoTeam.options.args.petgroup
    options.args = {
        create = {
            type = "input",
            name = "新建分组",
            width = "double",
            order = newOrder(),
            set = function(info, val)
                AutoTeam:NewGroup(val)
            end
        },
        desc = {
            type = "description",
            name = " 宠物组内的宠物可以互相替补，支持条件过滤",
            width = "double",
            order = newOrder()
        }
    }
    petGroupSize = 0

    for m = 1, #config.GroupIndexs do
        local groupName = config.GroupIndexs[m]
        local petGroup = config.petGroups[groupName]
        petGroupSize = petGroupSize + 1
        local groupOptionKey = "group" .. petGroupSize
        options.args[groupOptionKey] = {
            type = "group",
            name = groupName,
            order = newOrder(),
            args = {
                add = {
                    type = "input",
                    name = "输入名称或在Rematch宠物列表右键添加宠物",
                    width = "double",
                    order = newOrder(),
                    set = function(info, val)
                        AutoTeam:AddGroupPet(groupName, val)
                        AutoTeam:updatePetGroup()
                    end
                },
                desc = {
                    type = "description",
                    name = "          ",
                    width = "1",
                    order = newOrder()
                },
                delete = {
                    type = "execute",
                    name = "删除分组",
                    order = newOrder(),
                    func = function()
                        AutoTeam:RemoveGroup(groupName)
                        AutoTeam:updatePetGroup()
                    end
                }
            }
        }
        local petIndexs = config.GroupPetIndexs[groupName]
        for n = 1, #petIndexs do
            local speciesID = petIndexs[n]
            local skills = petGroup[speciesID]
            local speciesName = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
            local idTable = C_PetJournal.GetPetAbilityList(speciesID)
            local numCollected = C_PetJournal.GetNumCollectedInfo(speciesID)
            options.args[groupOptionKey].args["pet" .. speciesID] = {
                type = "group",
                name = colorize("(" .. numCollected .. ")" .. speciesName, blue),
                order = newOrder(),
                args = {
                    skill1 = {
                        type = "select",
                        name = "技能一",
                        style = "radio",
                        values = {
                            [1] = C_PetJournal.GetPetAbilityInfo(idTable[1]),
                            [2] = C_PetJournal.GetPetAbilityInfo(idTable[4])
                        },
                        get = function()
                            return skills[1]
                        end,
                        set = function(info, val)
                            skills[1] = val
                            AutoTeam:updatePetGroup()
                        end,
                        order = newOrder()
                    },
                    skill2 = {
                        type = "select",
                        name = "技能二",
                        style = "radio",
                        values = {
                            [1] = C_PetJournal.GetPetAbilityInfo(idTable[2]),
                            [2] = C_PetJournal.GetPetAbilityInfo(idTable[5])
                        },
                        get = function()
                            return skills[2]
                        end,
                        set = function(info, val)
                            skills[2] = val
                            AutoTeam:updatePetGroup()
                        end,
                        order = newOrder()
                    },
                    skill3 = {
                        type = "select",
                        name = "技能三",
                        style = "radio",
                        values = {
                            [1] = C_PetJournal.GetPetAbilityInfo(idTable[3]),
                            [2] = C_PetJournal.GetPetAbilityInfo(idTable[6])
                        },
                        get = function()
                            return skills[3]
                        end,
                        set = function(info, val)
                            skills[3] = val
                            AutoTeam:updatePetGroup()
                        end,
                        order = newOrder()
                    },
                    desc = {
                        type = "description",
                        name = "\n",
                        order = newOrder()
                    },
                    delete = {
                        type = "execute",
                        name = "从分组中移除",
                        order = newOrder(),
                        width = 1,
                        func = function()
                            AutoTeam:RemoveGroupPet(groupName, speciesID)
                            AutoTeam:updatePetGroup()
                        end
                    },
                    moveUp = {
                        type = "execute",
                        name = "上移一位",
                        order = newOrder(),
                        width = 1,
                        func = function()
                            AutoTeam:moveGroupUp(groupName, speciesID)
                            AutoTeam:updatePetGroup()
                        end
                    },
                    moveDown = {
                        type = "execute",
                        name = "下移一位",
                        order = newOrder(),
                        width = 1,
                        func = function()
                            AutoTeam:moveGroupDown(groupName, speciesID)
                            AutoTeam:updatePetGroup()
                        end
                    }
                }
            }
        end
    end
end

function AutoTeam:InitMacroOptions()
    local options = AutoTeam.options.args.macrogroup
    for key, macro in pairsByKeys(config.macros) do
        options.args[key] = {
            type = "group",
            name = macro.name or key,
            order = newOrder(),
            args = {
                desc = {
                    type = "description",
                    name = "宏按钮可以根据条件执行不同的命令,只能绑定快捷键使用，\n" ..
                        RED_FONT_COLOR_CODE .. "所有命令战斗中不会执行" .. FONT_COLOR_CODE_CLOSE,
                    width = "full",
                    order = newOrder()
                },
                macroname = {
                    type = "input",
                    name = "显示名称",
                    desc = "修改左侧的显示名称，和运行无关",
                    order = newOrder(),
                    get = function()
                        return macro.name or key
                    end,
                    set = function(info, val)
                        macro.name = val
                        AutoTeam:InitMacroOptions()
                    end
                },
                debug = {
                    type = "toggle",
                    name = "输出调试信息",
                    width = 1,
                    order = newOrder(),
                    get = function()
                        return macro.debug
                    end,
                    set = function()
                        macro.debug = not macro.debug
                    end
                },
                macrokey = {
                    type = "keybinding",
                    name = "绑定快捷键",
                    width = "2",
                    order = newOrder(),
                    get = function()
                        return macro.keybinding
                    end,
                    set = function(info, val)
                        macro.keybinding = val
                        AutoTeam:UpdateMacroButton()
                    end
                },
 
                info = {
                    type = "description",
                    name = NORMAL_FONT_COLOR_CODE .. "以下条件按顺序判断" .. FONT_COLOR_CODE_CLOSE,
                    order = newOrder()
                },
                autointeract = {
                    type = "toggle",
                    name = "自动开启点击移动",
                    width = "full",
                    order = newOrder(),
                    get = function()
                        return macro.autointeract
                    end,
                    set = function()
                        macro.autointeract = not macro.autointeract
                    end
                },
                

                useTdScript = {
                    type = "toggle",
                    name = "如果在宠物战斗中，点击tdBattlePetScript的自动按钮",
                    width = "full",
                    order = newOrder(),
                    get = function()
                        return macro.useTdScript
                    end,
                    set = function()
                        macro.useTdScript = not macro.useTdScript
                    end
                },

                userHarp = {
                    type = "toggle",
                    name = "使用法夜竖琴",
                    width = "full",
                    order = newOrder(),
                    get = function()
                        return macro.userHarp
                    end,
                    set = function()
                        macro.userHarp = not macro.userHarp
                    end
                },

                checkItemId = {
                    type = "input",
                    name = "如果没有此物品BUFF",
                    desc = "输入物品的ID，不是BUFF的ID",
                    order = newOrder(),
                    get = function()
                        return (macro.checkItemId or "") .. ""
                    end,
                    set = function(info, val)
                        if not tonumber(val) then
                            macro.checkItemId = ""
                        else
                            macro.checkItemId = tonumber(val)
                        end
                    end
                },
                customScript = {
                    type = "input",
                    name = "执行此命令(输入“use”为使用该物品)",
                    desc = "输入完整的宏命令，如果太长请单独建宏来中转",
                    width = 2.5,
                    order = newOrder(),
                    get = function()
                        return macro.customScript or ""
                    end,
                    set = function(info, val)
                        macro.customScript = val
                    end
                },
                healPet = {
                    type = "toggle",
                    name = "如果复活可用，复活战斗宠物",
                    width = "full",
                    order = newOrder(),
                    get = function()
                        return macro.healPet
                    end,
                    set = function()
                        macro.healPet = not macro.healPet
                    end
                },
                useBandage = {
                    type = "toggle",
                    name = "如果复活不可用但队伍失效，使用宠物绷带(如果有)",
                    width = "full",
                    order = newOrder(),
                    get = function()
                        return macro.useBandage
                    end,
                    set = function()
                        macro.useBandage = not macro.useBandage
                    end
                },
 
                target = {
                    type = "toggle",
                    name = "如果未选中目标，选中之前选中的可对战目标",
                    width = "full",
                    order = newOrder(),
                    get = function()
                        return macro.target
                    end,
                    set = function()
                        macro.target = not macro.target
                    end
                },
                autoConfirm = {
                    type = "toggle",
                    name = "如果弹出确认提示，选择“是”",
                    width = "full",
                    order = newOrder(),
                    get = function()
                        return macro.autoConfirm
                    end,
                    set = function()
                        macro.autoConfirm = not macro.autoConfirm
                    end
                },
                waitTeam = {
                    type = "toggle",
                    name = "如果队伍不可用，等待队伍生效",
                    width = "double",
                    order = newOrder(),
                    get = function()
                        return macro.waitTeam
                    end,
                    set = function()
                        macro.waitTeam = not macro.waitTeam
                    end
                },
                waitTimeout = {
                    type = "execute",
                    type = "input",
                    name = "等待超时重试(秒)",
                    desc = "超过此时间后，尝试重新加载队伍\n0为不重试",
                    order = newOrder(),
                    get = function()
                        return (macro.waitTimeout or "0") .. ""
                    end,
                    set = function(info, val)
                        if not tonumber(val) then
                            macro.waitTimeout = 0
                        else
                            macro.waitTimeout = tonumber(val)
                        end
                    end
                },
                selectGossip = {
                    type = "toggle",
                    name = "如果对话面板打开，进行对话开始战斗",
                    width = "full",
                    order = newOrder(),
                    get = function()
                        return macro.selectGossip
                    end,
                    set = function()
                        macro.selectGossip = not macro.selectGossip
                    end
                },
                extraScript = {
                    type = "toggle",
                    name = "额外执行命令",
                    width = 1,
                    order = newOrder(),
                    get = function()
                        return macro.extraScript
                    end,
                    set = function()
                        macro.extraScript = not macro.extraScript
                    end
                },
                extraScriptCmd = {
                    type = "execute",
                    type = "input",
                    name = "命令行",
                    width = 2.5,
                    order = newOrder(),
                    get = function()
                        return macro.extraScriptCmd or ""
                    end,
                    set = function(info, val)
                        macro.extraScriptCmd = val
                    end
                }
            }
        }
    end
end

function AutoTeam:OpenOptions(window)
    if InCombatLockdown() then
        return
    end
    AutoTeam:InitGroups()
    AutoTeam:InitMacroOptions()
    AceConfigDialog:SetDefaultSize("AutoTeam", 900, 600)
    AceConfigDialog:Open("AutoTeam")
end

local optionButton = nil
function AutoTeam:ShowOptionButton()
    if not config.showOptionButton then
        optionButton:Hide()
    else
        optionButton:Show()
    end
end

function AutoTeam:CheckCFG(key)
    local cfg = utils.alpt[key]
    cfg.changed = true;
    if cfg.disabled then
      return
    end
    if type(cfg.noAlt) == "boolean" then
      cfg.noAlt = {cfg.noAlt, cfg.noAlt, cfg.noAlt}
    end
    if cfg.noAlt and (cfg.noAlt[1] or cfg.noAlt[2] or cfg.noAlt[3]) then
      return
    end
    if cfg.healthCheck and (cfg.healthCheck[1] ~= 100 or cfg.healthCheck[2] ~= 100 or cfg.healthCheck[3] ~= 100) then
      return
    end
    if cfg.ignoreBreed and (cfg.ignoreBreed[1] or cfg.ignoreBreed[2] or cfg.ignoreBreed[3]) then
      return
    end
    if cfg.highest and (cfg.highest[1] or cfg.highest[2] or cfg.highest[3]) then
      return
    end
    if cfg.lowest and (cfg.lowest[1] or cfg.lowest[2] or cfg.lowest[3]) then
        return
      end
    if cfg.minLvl and (cfg.minLvl[1] ~= 25 or cfg.minLvl[2] ~= 25 or cfg.minLvl[3] ~= 25) then
      return
    end

    if cfg.useGroup and (cfg.useGroup[1] or cfg.useGroup[2] or cfg.useGroup[3]) then
      return
    end
  
    if cfg.groups and (cfg.groups[1] ~= "无" or cfg.groups[2] ~= "无" or cfg.groups[3] ~= "无") then
      return
    end
  
    if
      cfg.hp and
        (cfg.hp[1][1] ~= 0 or cfg.hp[1][2] ~= 9999 or cfg.hp[2][1] ~= 0 or cfg.hp[2][2] ~= 9999 or cfg.hp[3][1] ~= 0 or
          cfg.hp[3][2] ~= 9999)
     then
      return
    end
  
    if
      cfg.speed and
        (cfg.speed[1][1] ~= 0 or cfg.speed[1][2] ~= 999 or cfg.speed[2][1] ~= 0 or cfg.speed[2][2] ~= 999 or
          cfg.speed[3][1] ~= 0 or
          cfg.speed[3][2] ~= 999)
     then
      return
    end
  
    if
      cfg.speed and
        (cfg.attack[1][1] ~= 0 or cfg.attack[1][2] ~= 999 or cfg.attack[2][1] ~= 0 or cfg.attack[2][2] ~= 999 or
          cfg.attack[3][1] ~= 0 or
          cfg.attack[3][2] ~= 999)
     then
      return
    end
    cfg.changed = false;
  end
    
  function AutoTeam:FixTeamConfig(teamKey)
    local cfg = utils.alpt[teamKey]
    if not cfg then
      cfg = {}
    end
  
    if not cfg.disabled then
      cfg.disabled = false
    end
    if type(cfg.noAlt) == "boolean" then
      cfg.noAlt = {cfg.noAlt, cfg.noAlt, cfg.noAlt}
    end
    if not cfg.noAlt then
      cfg.noAlt = {}
    end
    if not cfg.healthCheck then
      cfg.healthCheck = {}
    end
    if not cfg.ignoreBreed then
      cfg.ignoreBreed = {}
    end
    if not cfg.highest then
      cfg.highest = {}
    end
    if not cfg.lowest then
        cfg.lowest = {}
      end
    
    if not cfg.minLvl then
      cfg.minLvl = {}
    end
    if not cfg.useGroup then
      cfg.useGroup = {}
    end
    if not cfg.groups then
      cfg.groups = {}
    end
    if not cfg.hp then
      cfg.hp = {}
    end
    if not cfg.speed then
      cfg.speed = {}
    end
    if not cfg.attack then
      cfg.attack = {}
    end
  
    for i = 1, 3 do
      cfg.noAlt[i] = cfg.noAlt[i] or false
      cfg.healthCheck[i] = cfg.healthCheck[i] or 100
      cfg.ignoreBreed[i] = cfg.ignoreBreed[i] or false
      cfg.highest[i] = cfg.highest[i] or false
      cfg.lowest[i] = cfg.lowest[i] or false
      cfg.minLvl[i] = cfg.minLvl[i] or 25
      cfg.useGroup[i] = cfg.useGroup[i] or false
      cfg.groups[i] = cfg.groups[i] or "无"
      cfg.hp[i] = cfg.hp[i] or {0, 9999}
      cfg.speed[i] = cfg.speed[i] or {0, 999}
      cfg.attack[i] = cfg.attack[i] or {0, 999}
    end
    utils.alpt[teamKey] = cfg
    AutoTeam:CheckCFG(teamKey)
    return cfg
  end
  function AutoTeam:InitOptions()
    tcopy(config, defaultconfig)
    tcopy(config, utils.alptconfig or defaultconfig)
    utils:SetConfig(config)

    for k,v in pairs(utils.alpt) do
        AutoTeam:FixTeamConfig(k)
    end

    petGroupSize = 0
    if not config.GroupIndexs then
        config.GroupIndexs  = {}
        config.GroupPetIndexs  = {}
        for groupName, petGroup in pairs(config.petGroups) do
            petGroupSize = petGroupSize + 1
            config.GroupIndexs[petGroupSize] = groupName
            config.GroupPetIndexs[groupName] = {}
            local idx = 0;
            for speciesID, skills in pairs(petGroup) do
                idx = idx + 1;
                config.GroupPetIndexs[groupName][idx] = speciesID
            end
        end
    end
    petGroupSize = #config.GroupIndexs
    
    LibStub("AceConfig-3.0"):RegisterOptionsTable("AutoTeam", AutoTeam.options)

    optionButton = CreateFrame("Button", "AutoTeamOptionButton", Rematch.toolbar, "RematchToolbarButtonTemplate")
    local texture = C_Spell.GetSpellInfo(195112).iconID
    optionButton:SetPoint("TOPLEFT", 430, 0)
    optionButton:SetNormalTexture(texture)
    optionButton:SetPushedTexture(texture)
    optionButton:SetWidth(32)
    optionButton:SetHeight(32)
    optionButton:SetFrameLevel(1000)
    optionButton:SetScript(
        "OnClick",
        function()
            AutoTeam:OpenOptions()
        end
    )
    AutoTeam:ShowOptionButton()
  end
