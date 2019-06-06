-- check: https://pastebin.com/C6u8LcQq
--resurrection
-- Respawn Timer
-- use: https://github.com/Atkana/tes3mp-scripts/tree/master/0.7/kanaRevive
local message = logicHandler.GetChatName(self.pid) .. " " .. deathReason .. "."
    message = message .. "\n"
	 tes3mp.SendMessage(self.pid, message, true)
	     local resurrectionTime = 10 -- + self.data.stats.level 

    if config.playersRespawn == true then
	  self.resurrectTimerId = tes3mp.CreateTimerEx("OnDeathTimeExpiration",  time.seconds(resurrectionTime), "i", self.pid)
        logicHandler.RunConsoleCommandOnPlayer(self.pid, "tvm")
        logicHandler.RunConsoleCommandOnPlayer(self.pid, "tm")

		if tes3mp.GetCell(self.pid) == "Vivec, Arena Pit" then
		tes3mp.MessageBox(self.pid, -1, color.White .. "You will respawn in " .. color.Yellow
        .. resurrectionTime .. color.White .. " seconds." )    
        tes3mp.StartTimer(self.resurrectTimerId)

        elseif self.data.customVariables.rageLevel == 0 then
		tes3mp.MessageBox(self.pid, -1, color.White .. "You will respawn in " .. color.Yellow
        .. resurrectionTime .. color.White .. " seconds." )    
        tes3mp.StartTimer(self.resurrectTimerId)
		elseif self.data.customVariables.rageLevel > 0 then
        local expTotal = self.data.customVariables.rageExp
        local nextLevel = math.floor(100 *((self.data.customVariables.rageLevel + 1) ^ 2.5) / 2)
		local currentLevel = math.floor(100 *((self.data.customVariables.rageLevel) ^ 2.5) / 2)
        local expLoss = math.floor((nextLevel - currentLevel)*.075)
        local newExpTotal =  math.floor(expTotal - expLoss)
        self.data.customVariables.rageExp = newExpTotal

        tes3mp.MessageBox(self.pid, -1, color.White .. "You will respawn in " .. color.Yellow
        .. resurrectionTime .. color.White .. " seconds\nYou lost " .. color.Red .. expLoss .. " experience" )    
        tes3mp.StartTimer(self.resurrectTimerId)
    else
        tes3mp.SendMessage(self.pid, "You have died permanently.", false)
        end
    end
end
MainGUI = 8784956
 
 
 
 
            elseif idGui == MainGUI then -- Main
                if tonumber(data) == 0 and Players[pid].data.stats.healthCurrent <= 0 then --revive
                    Players[pid]:Resurrect()
                    return true
 
                elseif tonumber(data) == 1 and Players[pid].data.stats.healthCurrent <= 0 then --wait
                    Players[pid].ReviveMeTimer = tes3mp.CreateTimerEx("OnReviveTimeExperiation", time.seconds(60), "i", pid)
                    tes3mp.StartTimer(Players[pid].ReviveMeTimer)
                    return true
                end
            end
