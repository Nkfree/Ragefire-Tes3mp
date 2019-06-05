tutorialKills = {}

tutorialKills.ProcessLatestKill = function(pid, refId)

--local cellDescription = tes3mp.GetCell(pid)
--local refId = tes3mp.GetKillRefId(pid, tes3mp.GetKillChangesSize(pid) - 1)

if refId == "skeleton entrance" and Players[pid].data["bonemeal"] == nil then 
		Players[pid].data.bonemeal = 0
		tes3mp.SendMessage(pid, color.Yellow .. "Beginner Tip: " .. color.Gray .. "Bonemeal " .. color.Yellow .. " can be used to " .. color.Yellow .. "craft "..
								 color.Yellow .. "certain types of armor.\n" .. 
		  color.White .. "Type " .. color.Gold .. "/craft " .. color.White .. "to access the " .. color.Gold .. "crafting " .. color.White .. "menu.\n",false)
		tes3mp.MessageBox(pid, -1, color.White .. "View " .. color.LightGreen .. "chat " .. color.White .. "window to see new tip")
	
	elseif refId == "guar_feral" and Players[pid].data["guarhide"] == nil then 
		Players[pid].data.guarhide = 0
		tes3mp.SendMessage(pid, color.Yellow .. "Beginner Tip: " .. color.Yellow .. "Use Guar Hides to make " .. 
		 color.Gray .. "leather.\n" .. color.White .. "Type " .. color.Gold .. "/leather " .. color.White .. "to access the " .. 
		  color.Coral .. "leather " .. color.White .. "menu.\n",false)
		tes3mp.MessageBox(pid, -1, color.White .. "View " .. color.LightGreen .. "chat " .. color.White .. "window to see new tip")
	
	elseif refId == "alit" and Players[pid].data["alithide"] == nil then 
		Players[pid].data.alithide = 0
		tes3mp.SendMessage(pid, color.Yellow .. "Beginner Tip: " .. color.Yellow .. "Use Alit Hides to make " .. 
		 color.Gray .. "leather.\n" .. color.White .. "Type " .. color.Gold .. "/leather " .. color.White .. "to access the " .. 
		  color.Coral .. "leather " .. color.White .. "menu.\n",false)
		tes3mp.MessageBox(pid, -1, color.White .. "View " .. color.LightGreen .. "chat " .. color.White .. "window to see new tip")
		
	elseif refId == "centurion_spider" and Players[pid].data["centurionspider"] == nil then 
		Players[pid].data.centurionspider = 0
		tes3mp.SendMessage(pid, color.Yellow .. "Beginner Tip: " .. color.Yellow .. "Use scrap metal to " .. color.Gray .. "craft " .. 
		 color.Yellow .. "Dwarven Armor.\n",false)
		tes3mp.MessageBox(pid, -1, color.White .. "View " .. color.LightGreen .. "chat " .. color.White .. "window to see new tip")

	elseif refId == "kagouti" and Players[pid].data["kagouti"] == nil then 
		Players[pid].data.kagouti = 0
		tes3mp.SendMessage(pid, color.Yellow .. "Beginner Tip: " .. color.Yellow .. "Use Kagouti Hides  to make " .. color.Gray .. "leather.\n" .. 
		 color.White .. "Type " .. color.Gold .. "/leather " .. color.White .. "to access the " .. 
		  color.Coral .. "leather " .. color.White .. "menu.\n",false)
		tes3mp.MessageBox(pid, -1, color.White .. "View " .. color.LightGreen .. "chat " .. color.White .. "window to see new tip")
	elseif refId == "divayth fyr" and Players[pid].data["banned"] == nil then 
		Players[pid].data.banned = 0
	elseif refId == "calvario" then
		logicHandler.RunConsoleCommandOnPlayer(pid, 'journal "B3_ZainabBride" 20')
		logicHandler.RunConsoleCommandOnPlayer(pid, 'journal "B3_ZainabBride" 25')
end
end

tutorialKills.Decide = function(eventStatus, pid, cellDescription)

        local uniqueIndex = tes3mp.GetActorRefNum(0) .. "-" .. tes3mp.GetActorMpNum(0)

	if tes3mp.DoesActorHavePlayerKiller(0) then

			if LoadedCells[cellDescription].data.objectData[uniqueIndex] ~= nil then
					local refId = LoadedCells[cellDescription].data.objectData[uniqueIndex].refId
					tutorialKills.ProcessLatestKill(pid, refId)
			end
	end

end

customEventHooks.registerHandler("OnActorDeath", tutorialKills.Decide)