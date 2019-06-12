------------------
-- Version: 1.0 --
------------------

-- Settings
displayGlobalWanted = true -- whether or not to display the global messages in chat when a player's wanted status changes
displayGlobalClearedBounty = true -- whether or not to display a global message when a player clears their bounty
displayGlobalBountyClaim = true -- whether or not to display a global message when another player claims a bounty
bountyItem = "gold_001" -- item used as bounty, in case you use a custom currency
require("color")

criminals = {}
criminals.OnLogin = function(eventStatus, pid) -- set the criminal level as a custom variable for players based on their bounty
    if Players[pid].data.customVariables.Skvysh == nil then
        Players[pid].data.customVariables.Skvysh = {}
    end
    if Players[pid].data.customVariables.Skvysh.criminal == nil then
        local criminal
        local bounty = Players[pid].data.fame.bounty
        if bounty >= 5000 then
            criminal = 3
        elseif bounty >= 1000 then
            criminal = 2
        elseif bounty >= 500 then
            criminal = 1
        else
            criminal = 0
        end
        Players[pid].data.customVariables.Skvysh.criminal = criminal
    end
end

criminals.IsCriminal = function(pid) -- get criminal prefix for chat messages
    local bounty = tes3mp.GetBounty(pid)
    local prefix = ""
    if bounty >= 5000 then
        prefix = color.Red .. "[Fugitive] " .. color.Default
    elseif bounty >= 1000 then
        prefix = color.Salmon .. "[Criminal] " .. color.Default
    elseif bounty >= 500 then
        prefix = color.LightSalmon .. "[Thief] " .. color.Default
    end
    return prefix
end

criminals.GetNewCriminalLevel = function(pid) -- get the criminal level based on current bounty and previous level
    local bounty = tes3mp.GetBounty(pid)
    local previousCriminal = Players[pid].data.customVariables.Skvysh.criminal
    local criminal
    if bounty >= 5000 then
        if previousCriminal ~= 3 then
            criminal = 3
        end
    elseif bounty >= 1000 then
        if previousCriminal ~= 2 then
            criminal = 2
        end
    elseif bounty >= 500 then
        if previousCriminal ~= 1 then
            criminal = 1
        end
    elseif bounty == 0 then
        if previousCriminal ~= 0 then
            criminal = 0
        end
    end
    if criminal == nil then
        criminal = -1
    else
        Players[pid].data.customVariables.Skvysh.criminal = criminal
    end
    return criminal
end

criminals.UpdateBounty = function(eventStatus, pid) -- display global messages if needed when a criminal level changes
    local message
    local playerName = tes3mp.GetName(pid)
    local criminal = criminals.GetNewCriminalLevel(pid)
    if criminal > 0 then
        if displayGlobalWanted == true then
            message = color.Crimson .. "[Alert] " .. color.Brown .. playerName .. " " .. color.Default
            if criminal == 1 then
                message = message .. "has been declared a thief.\n"
            elseif criminal == 2 then
                message = message .. "is now a wanted criminal.\n"
            elseif criminal == 3 then
                message = message .. "has a death warrant. This criminal scum shall be killed on sight.\n"
            else
                message = ""
            end
            tes3mp.SendMessage(pid, message, true)
        end
    elseif criminal == 0 then
        if displayGlobalClearedBounty == true then
            message = color.Green .. "[Notice] " .. color.Brown .. playerName .. " " .. color.Default
            message = message .. "has cleared their bounty.\n"
            tes3mp.SendMessage(pid, message, true)
        end
    end
end

criminals.ProcessBountyReward = function(pid, killer) -- give rewards for claiming a bounty
    local playerName = tes3mp.GetName(pid)
    local lastPid = tes3mp.GetLastPlayerId()
    local killerPid = -1
    local currentBounty = tes3mp.GetBounty(pid)
    local newBounty
    local reward
    local message
    if currentBounty >= 500 then -- don't want newbies losing gold over petty theft
        for i = 0, lastPid do
            if Players[i] ~= nil and Players[i]:IsLoggedIn() then
                if tostring(Players[i].name) == tostring(killer) then
                    killerPid = Players[i].pid -- get killer's PID, assuming it was an actual player
                    break
                end
            end
        end
        if killerPid ~= -1 then -- if a killer was found
            if bountyItem ~= "" then
                if tableHelper.containsKeyValue(Players[pid].data.inventory, "refId", bountyItem, true) then
                    itemIndex = tableHelper.getIndexByNestedKeyValue(Players[pid].data.inventory, "refId", bountyItem)
                    itemCount = Players[pid].data.inventory[itemIndex].count -- find how much gold the player has
                else
                    itemCount = 0
                end
                if itemCount >= currentBounty then -- if a bounty can be fully cleared, do so
                    newBounty = 0
                    reward = currentBounty
                else
                    newBounty = currentBounty - itemCount -- otherwise, clear it only partially
                    reward = itemCount
                end
                local structuredItem = { refId = bountyItem, count = reward, charge = -1 } -- give the reward to the killer
                table.insert(Players[killerPid].data.inventory, structuredItem)
                if itemCount ~= 0 then -- if the player actually has gold
                    Players[pid].data.inventory[itemIndex].count = Players[pid].data.inventory[itemIndex].count - reward --remove the gold
                    if Players[pid].data.inventory[itemIndex].count == 0 then
                        Players[pid].data.inventory[itemIndex] = nil
                    end
                    if displayGlobalBountyClaim == true then -- display messages
                        local message2 = killer .. " " .. tostring(reward)
                        message = color.Brown .. killer .. color.Default .. " has claimed a bounty of " .. tostring(reward) .. " by killing " .. color.Brown .. Players[pid].name .. color.Default .. ".\n"
                        tes3mp.SendMessage(pid, message, true)
                    else
                        message = color.Brown .. "You" .. color.Default .. " have claimed a bounty of " .. tostring(reward) .. " by killing " .. color.Brown .. Players[pid].name .. color.Default .. ".\n"
                        tes3mp.SendMessage(killerPid, message, false)
                    end
                    if newBounty == 0 then -- display additional message to let people know the player is no longer a criminal
                        if displayGlobalClearedBounty == true then
                            message = color.Green .. "[Notice] " .. color.Brown .. playerName .. " " .. color.Default
                            message = message .. "no longer has a bounty on their head.\n"
                            tes3mp.SendMessage(pid, message, true)
                        end
                    end
                    Players[pid].data.fame.bounty = newBounty -- set new bounty
                    tes3mp.SetBounty(pid, Players[pid].data.fame.bounty)
                    tes3mp.SendBounty(pid)
                    Players[pid]:LoadInventory() -- save inventories for both players
                    Players[pid]:LoadEquipment()
                    Players[pid]:Save()
                    Players[killerPid]:LoadInventory()
                    Players[killerPid]:LoadEquipment()
                    Players[killerPid]:Save()
                    criminals.GetNewCriminalLevel(pid)
                end
            end
        end
    end
end

criminals.OnDeath = function(eventStatus, pid)
	if tes3mp.DoesPlayerHavePlayerKiller(pid) then
			local killerPid = tes3mp.GetPlayerKillerPid(pid)
			criminals.ProcessBountyReward(pid, logicHandler.GetChatName(killerPid))
	end
end

customEventHooks.registerHandler("OnPlayerDeath", criminals.OnDeath)
customEventHooks.registerHandler("OnPlayerFinishLogin", criminals.OnLogin)
customEventHooks.registerHandler("OnPlayerBounty", criminals.UpdateBounty) 
