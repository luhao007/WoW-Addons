local addonName, PD = ...;
PD.Audio={
	Data={
		["Countdown"]={--倒计时语音
			{"1(AI)","1",true},
		},
		["QuestEnd"]={--任务完成
			{"任务完成(AI)","任务完成",true},
		},
		["FollowMsg"]={--有关注消息
			{"有关注消息(AI)","有关注消息",true},
		},
		["HardcoreDeaths"]={--硬核吃席
			{"吃大席(AI)","吃大席",true},
		},
		["GDKP_Start"]={--金团助手物品开拍
			{"有物品开拍(AI)","有物品开拍",true},
		},
		["GDKP_End"]={--金团助手拍卖结束
			{"拍卖结束(AI)","拍卖结束",true},
		},
	},
	AddFun=function(data)
		for k,list in pairs(data) do
			for i=1,#list do
				table.insert(PD.Audio.Data[k],1,list[i])
			end
		end
	end,
}