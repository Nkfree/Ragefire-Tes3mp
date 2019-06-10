MainQuestRequiredKills = {}

MainQuestRequiredKills.ProcessLatestKill = function(pid, refId)

if refId == "dagoth_gares" and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a2_2_6thhouse", index = 5 }, true)
	and Players[pid].data.mqCorprus == nil then
		
		Players[pid].currentCustomMenu = "dagoth gares"
        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
end
end

MainQuestRequiredKills.Decide = function(eventStatus, pid, cellDescription)

if eventStatus.validCustomHandlers then --check if some other script made this event obsolete

        local uniqueIndex = tes3mp.GetActorRefNum(0) .. "-" .. tes3mp.GetActorMpNum(0)

	if tes3mp.DoesActorHavePlayerKiller(0) then

			if LoadedCells[cellDescription].data.objectData[uniqueIndex] ~= nil then
					local refId = LoadedCells[cellDescription].data.objectData[uniqueIndex].refId
					MainQuestRequiredKills.ProcessLatestKill(pid, refId)
			end
	end
end
end

customEventHooks.registerHandler("OnActorDeath", MainQuestRequiredKills.Decide )