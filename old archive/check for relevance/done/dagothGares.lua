-- cant remember
-- stop players from getting corprus when not at that quest i guess
-- use this instead: https://github.com/Learwolf/tes3mp-Scripts/blob/master/tes3mp-server/server/scripts/custom/lear/prematureCorpusFix.lua
MainQuestRequiredKills = {}

MainQuestRequiredKills = function(pid) 

if refId == "dagoth_gares" and tes3mp.GetCell(pid) == "Ilunibi, Soul's Rattle" and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a2_2_6thhouse", index = 5 }, true) and
menuHelper.effects.setDataVariable("MQ corprus"), == nil then 
			
		Players[pid].currentCustomMenu = "dagoth gares"
        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
end
end

return MainQuestRequiredKills
