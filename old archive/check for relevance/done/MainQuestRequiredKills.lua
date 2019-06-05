--should be same result as https://github.com/Schnibbsel/tes3mpRagefire/blob/master/scriptsToBePorted/OwnScriptFiles/dagothGares.lua
MainQuestRequiredKills = {}

MainQuestRequiredKills.ProcessLatestKill = function(pid, refId)

if refId == "dagoth_gares" and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a2_2_6thhouse", index = 5 }, true)
	and Players[pid].data.mqCorprus == nil then
		
		Players[pid].currentCustomMenu = "dagoth gares"
        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
end
end

return MainQuestRequiredKills
