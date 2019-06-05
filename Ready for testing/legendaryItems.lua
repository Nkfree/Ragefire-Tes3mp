--disable players from looting creatures multiple times

legendaryItems = {}

legendaryItems.ProcessLatestKill = function(pid, refId)

--local cellDescription = tes3mp.GetCell(pid)


if refId == "dremora_lord_a" and tes3mp.GetCell(pid) == "Bal Fell, Inner Shrine" then 
		Players[pid].data.legendaryTenPace = 0
	
	elseif refId == "steam_protector" and tes3mp.GetCell(pid) == "Mudan, Central Vault" then 
		Players[pid].data.legendaryDragonBone = 0
		
	elseif refId == "dagoth_gares" and tes3mp.GetCell(pid) == "Ilunibi, Soul's Rattle" then 
		Players[pid].data.legendaryRandagulf = 0
		
	elseif refId == "golden_saint_b" and tes3mp.GetCell(pid) == "Ibar-Dad" then 
		Players[pid].data.legendaryEleidon = 0
		
	elseif refId == "ascended_sleeper_boss" and tes3mp.GetCell(pid) == "Mamaea, Shrine of Pitted Dreams" then 
		Players[pid].data.legendaryFang = 0
		
	elseif refId == "dremora_lord_a" and tes3mp.GetCell(pid) == "Falas Ancestral Tomb" then 
		Players[pid].data.legendaryDenstagmer = 0
		
	elseif refId == "skeleton_king" and tes3mp.GetCell(pid) == "Senim Ancestral Tomb" then 
		Players[pid].data.legendaryPhynaster = 0
-- Goldbrand				
	elseif refId == "dreugh_overlord_gb" then 
		Players[pid].data.legendaryGoldbrand = 0

-- MainQuest
	--[[elseif refId == "calvario" and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B3_ZainabBride", index = 20 }, true) then 
						Players[pid].currentCustomMenu = "already looted this"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				
	elseif refId == "calvario" and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B3_ZainabBride", index = 5 }, true) then 
					logicHandler.RunConsoleCommandOnPlayer(pid, 'journal "B3_ZainabBride" 20')]]--

end
end

legendaryItems.Decide = function(eventStatus, pid, cellDescription)

        local uniqueIndex = tes3mp.GetActorRefNum(0) .. "-" .. tes3mp.GetActorMpNum(0)

if tes3mp.DoesActorHavePlayerKiller(0) then

				local refId = self.data.objectData[uniqueIndex].refId
				legendaryItems.ProcessLatestKill = function(pid, refId)
end

end

customEventHooks.registerHandler("OnActorDeath", legendaryItems.Decide)

