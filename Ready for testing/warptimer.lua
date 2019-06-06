-- was used to warp players to partymembers?
-- needs GroupParty.lua


		--party teleport




		
warptimer = {}

warptimer.warp = function(pid, cmd)
						local currentTime = os.time()
    
				   
						if GroupParty.IsParty(pid) ~= true then
							tes3mp.SendMessage(pid, "You aren't in a party.\n",false)
						
						elseif Players[pid].data.customVariables.lastWarp == nil or
							currentTime >= Players[pid].data.customVariables.lastWarp + config.warpInterval and GroupParty.IsParty(pid) then
									
								local partyId = GroupParty.WhichParty(pid)
								
								tes3mp.SendMessage(pid, color.LightGreen .. "You have " .. color.BlueViolet .. "warped " .. color.LightGreen .. "to your teammate.\n", false)
								local partyId = GroupParty.WhichParty(pid)
									for i, p in pairs(Partytable[partyId].player) do
										if p.pd ~= pid then
											logicHandler.TeleportToPlayer (pid,pid,p.pd)
											--break
										
										
							 
											Players[pid].data.customVariables.lastWarp = currentTime
							 

											Players[pid].warpReminderTimerId = tes3mp.CreateTimerEx("OnWarpReminderTimeExpiration", time.seconds(config.warpInterval), "i", pid)
											tes3mp.StartTimer(Players[pid].warpReminderTimerId)
											break
										end 
									end
						else
							local remainingMinutes = math.floor((Players[pid].data.customVariables.lastWarp + config.warpInterval - currentTime) / 60)
							local message = color.DarkGray .. "You cannot use " .. color.Gold .. "/warp " .. color.DarkGray .. "again for another "
				 
								if remainingMinutes > 1 then
									message = message .. color.Gold .. remainingMinutes .. color.DarkGray .. " minutes."
								else
									message = message .. " minute."
								end
			 
							message = message .. "\n"
							tes3mp.SendMessage(pid, message, false)
						end
		
		
end

function OnWarpReminderTimeExpiration(pid)
	if Players[pid] ~= nil then
		Players[pid]:Message( color.DarkGray .. "You can now use " .. color.Gold .. "/warp " .. color.DarkGray .. "again.\n")
	end
end


customCommandHooks.registerCommand("warp", rageExp.Help)
		
	
		