local addonName, PD = ...;
PD.Audio={
	Data={
		["Countdown"]={--倒计时读秒1-5语音
			{"12345(AI)","1","AI"},
		},
		["EndAudio"]={--倒计时结束语音
			{"攻击(AI)","攻击","AI"},
		},
		["QuestEnd"]={--任务完成
			{"任务完成(AI)","任务完成","AI"},
		},
		["FollowMsg"]={--有关注消息
			{"有关注消息(AI)","有关注消息","AI"},
		},
		["HardcoreDeaths"]={--硬核吃席
			{"吃大席(AI)","吃大席","AI"},
		},
		["GDKP_Start"]={--金团助手物品开拍
			{"有物品开拍(AI)","有物品开拍","AI"},
		},
		["GDKP_End"]={--金团助手拍卖结束
			{"拍卖结束(AI)","拍卖结束","AI"},
		},
	},
	AddFun=function(data)
		for k,list in pairs(data) do
			for i=1,#list do
				table.insert(PD.Audio.Data[k],1,list[i])
			end
		end
	end,
	IsAudioNumMaxV=function(index,AudioData)
		if not AudioData[index] or index>#AudioData then
			return 1
		else
			return index
		end
	end,
}