guiHandler = {}

function guiHandler.ShowMemberMenu(pid)
	local extraOption = (partySystem.utils.IsPlayerPartyLeader(pid) and "Leader actions;" or "Teleport to the leader;")
	tes3mp.CustomMessageBox(pid,5700,Players[pid].data.customVariables.partyName.." Party Menu",extraOption.."Show the party member list;Send a message to members;Leave the party;Close")
end

function guiHandler.ShowLeaderMenu(pid)
	tes3mp.CustomMessageBox(pid,5701,Players[pid].data.customVariables.partyName.." Party Menu",guiHandler.CreateLeaderOptionsList(pid))
end

function guiHandler.LeaderOptionGoldSplitting(pid)
	partySystem.lootSharing.ToggleGoldSplitting(pid)
	guiHandler.ShowLeaderMenu(pid)
end

function guiHandler.LeaderOptionLootShuffle(pid)
	partySystem.lootSharing.ToggleLootShuffle(pid)
	guiHandler.ShowLeaderMenu(pid)
end

function guiHandler.LeaderOptionKickPlayer(pid)
	if partySystem.utils.GetPlayerParty(pid)["partySize"] > 1 then
		tes3mp.ListBox(pid,5740,"Select the player to kick:",guiHandler.CreateMemberList(Players[pid].data.customVariables.partyName,"kickPlayer",pid))
	else
		partySystem.SendMessage(pid,"There is no one to kick!",false)			
		guiHandler.ShowLeaderMenu(pid)
	end
end

function guiHandler.LeaderOptionCedeLeadership(pid)
	if partySystem.utils.GetPlayerParty(pid)["partySize"] > 1 then
		tes3mp.ListBox(pid,5740,"Choose a player to cede leadership to:",guiHandler.CreateMemberList(Players[pid].data.customVariables.partyName,"cedeLeadership",pid))
	else
		partySystem.SendMessage(pid,"There is no one to cede leadership to!",false)			
		guiHandler.ShowLeaderMenu(pid)
	end
end

function guiHandler.LeaderOptionBack(pid)
	guiList[pid] = nil
	tes3mp.CustomMessageBox(pid,5700,Players[pid].data.customVariables.partyName.." Party Menu","Leader actions;Show the party member list;Send a message to members;Leave the party;Close")		
end

function guiHandler.CreateMemberListCaption(pid)
	local caption = Players[pid].data.customVariables.partyName.." Member List\n"	
	if LOOT_SHUFFLE then caption = caption.."Loot shuffle - "..(partySystem.utils.GetPlayerParty(pid)["lootShuffle"] and "On" or "Off") end
	if LOOT_SHUFFLE and GOLD_SPLIT then caption = caption.." | " end
	if GOLD_SPLIT then caption = caption.."Gold splitting - "..(partySystem.utils.GetPlayerParty(pid)["goldSplitting"] and "On" or "Off") end
	if LOOT_SHUFFLE or GOLD_SPLIT then caption = caption.."\n" end
	return caption
end

function guiHandler.CreateLeaderOptionsList(pid)
	optionsList = "Kick a player;Cede leadership;Back"
	guiList[pid] = {guiHandler.LeaderOptionKickPlayer, guiHandler.LeaderOptionCedeLeadership, guiHandler.LeaderOptionBack}
	if GOLD_SPLIT then 
		local goldSplitting = (partySystem.utils.GetPlayerParty(pid)["goldSplitting"] and "On" or "Off")
		optionsList = "Gold splitting - "..goldSplitting..";"..optionsList
		table.insert(guiList[pid], 1, guiHandler.LeaderOptionGoldSplitting)
	end
	if LOOT_SHUFFLE then 
		local lootShuffle = (partySystem.utils.GetPlayerParty(pid)["lootShuffle"] and "On" or "Off")
		optionsList = "Loot shuffle - "..lootShuffle..";"..optionsList
		table.insert(guiList[pid], 1, guiHandler.LeaderOptionLootShuffle)
	end
	return optionsList
end

function guiHandler.CreateMemberList(partyName,listmode,pid)
	local memberList = ""		
	guiList[pid] = {}
	if partySystem.utils.PartyExists(partyName) and partySystem.utils.DynamicPartyExists(partyName) then
		local onlineArray = {}
		local offlineArray = {}
		if listmode == "memberList" then
			local leaderName = partyTable[partyName]["leaderName"]
			local onlineStatus = (dynamicPartyTable[partyName]["memberPids"][leaderName] and "Online" or "Offline")
			memberList = memberList..leaderName.." (Leader)".." - ".. onlineStatus.."\n" 
		end
		for playerName, playerData in pairs(partyTable[partyName]["memberList"]) do
			if playerName ~= partyTable[partyName]["leaderName"] then
				if dynamicPartyTable[partyName]["memberPids"][playerName] then
					onlineArray[#onlineArray+1] = playerName
				else	
					offlineArray[#offlineArray+1] = playerName
				end
			end
		end
		for playerIndex, playerName in ipairs(onlineArray) do
			memberList = memberList..playerName.." - Online\n" 
			if listmode ~= "memberList" then guiList[pid][#guiList[pid]+1] = playerName end
		end
		for playerIndex, playerName in ipairs(offlineArray) do
			memberList = memberList..playerName.." - Offline\n" 
			if listmode ~= "memberList" then guiList[pid][#guiList[pid]+1] = playerName end
		end
		guiList[pid][#guiList[pid]+1] = listmode
	end
	return memberList
end

function guiHandler.CreatePartyList(pid,listmode)
	local partyList = ""
	guiList[pid] = {}
	for partyName, partyData in pairs(dynamicPartyTable) do		
		if partyTable[partyName] then
			local leaderName = partyTable[partyName]["leaderName"] 
			if partyData["memberPids"][leaderName] then --The leader has to be online
				local partySize = partyTable[partyName]["partySize"]
				partyList = partyList..partyName.." ("..leaderName..") - "..partyData["onlineMembersCount"].."/"..partySize.."\n"
				guiList[pid][#guiList[pid]+1] = partyName
			end
		else
			tes3mp.LogMessage(enumerations.log.ERROR, "No corresponding record in partySystem.json for the dynamic party table "..partyName.." was found!")
		end
	end
	return partyList
end

function guiHandler.ShowMenu(pid)
	if partySystem.utils.PlayerPartyCheck(pid) then
		guiHandler.ShowMemberMenu(pid)		
	else		
		if guiList[pid] and guiList[pid]["pendingJoinRequest"] and guiList[pid]["partyName"] then
			tes3mp.CustomMessageBox(pid,5711,"Cancel the pending request to join "..guiList[pid]["partyName"].."?","Yes;No")
		else
			tes3mp.CustomMessageBox(pid,5710,"Welcome to the Party System.","Create a party;Join a party;Close")
		end
	end
end

function guiHandler.OnGUIAction(pid, idGui, data)

	if idGui == 5710 or idGui == 5711 or idGui == 5720 or idGui == 5730 then --Does not require the player to be a member
		if idGui == 5710 then --Create/join party
			local optionsTable = {
				function (pid)
					tes3mp.InputDialog(pid,5720,"What name should the party have?","")	
				end,
				function (pid)
					local partyList = guiHandler.CreatePartyList(pid)
					if partyList ~= "" then
						tes3mp.ListBox(pid,5730,"Party Name (Leader's Name) - Members Online/Total Members",partyList)
					else
						partySystem.SendMessage(pid,"There are no joinable parties at the moment.",false)			
					end
				end
			}
			local choice = tonumber(data) + 1 
			if choice <= #optionsTable then optionsTable[choice](pid) end
		end

		if idGui == 5711 then --Cancelling a pending request
			if tonumber(data) == 0 then			
				partySystem.SendMessage(pid, "You have cancelled your request to join "..guiList[pid]["partyName"].."!",false)	
				partySystem.DeletePendingRequest(pid)
			end
		end

		if idGui == 5720 then --Create a party
			if data ~= "" then
				if not partyTable[data] then				
					partySystem.CreateParty(pid,data)
				else
					partySystem.SendMessage(pid, "A party with this name already exists!",false)	
				end
			else
				partySystem.SendMessage(pid, "Invalid name entered!",false)
			end
		end

		if idGui == 5730 then --Party List Selection
			if tonumber(data) < #guiList[pid] then				
				local partyName = guiList[pid][tonumber(data)+1]
				if partySystem.utils.DynamicPartyExists(partyName) and partySystem.utils.PartyExists(partyName) then
					if partySystem.utils.IsPlayerDynamicPartyMember(partyName, partyTable[partyName]["leaderName"]) then				
					    if dynamicPartyTable[partyName]["pendingJoinRequestPid"] == -1 then				
							guiList[pid] = { ["pendingJoinRequest"] = true, ["partyName"] = partyName } -- Now save the one selected party
							partySystem.SendJoinRequest(guiList[pid]["partyName"],partyTable[guiList[pid]["partyName"]]["leaderName"],pid)
							partySystem.SendMessage(pid,"A request to join "..guiList[pid]["partyName"].." has been sent to "..partyTable[guiList[pid]["partyName"]]["leaderName"]..".", false)				
						else
							partySystem.SendMessage(pid,"Somebody already has a pending request to join "..guiList[pid][tonumber(data)+1].."! Try again shortly.", false)				
							guiList[pid] = nil
						end			
					else
						partySystem.SendMessage(pid,"You can't join the party right now - the leader has gone offline!", false)				
					end
				else
					partySystem.SendMessage(pid,"You can't join the party - it no longer exists!", false)
				end
			end
		end

	elseif (idGui == 5700 or idGui == 5701 or idGui == 5705 or idGui == 5731 or idGui == 5740) and partySystem.utils.PlayerPartyCheck(pid) then
		if idGui == 5700 then
			local optionsTable = {  --Getting rid of an if chain -- Main member menu
				function (pid) 
					if partySystem.utils.IsPlayerPartyLeader(pid) then										
						guiHandler.ShowLeaderMenu(pid)
					else					
						partySystem.TeleportToLeader(pid)
					end		    
				 end, 
				function (pid)
				 	tes3mp.ListBox(pid,5740,guiHandler.CreateMemberListCaption(pid),guiHandler.CreateMemberList(Players[pid].data.customVariables.partyName,"memberList",pid))
				end,
				function (pid)
				 	tes3mp.InputDialog(pid,5705,"Type your message:","")
				end,
				function (pid)
				   partySystem.LeaveParty(pid)
				end
			}

			local choice = tonumber(data) + 1 
			if choice <= #optionsTable then optionsTable[choice](pid) end
		end

		if idGui == 5701 then --Leader party menu
			local choice = tonumber(data) + 1
		    if choice <= #guiList[pid] then guiList[pid][choice](pid) end
		end

		if idGui == 5705 then --Sending messages
			if partySystem.utils.DynamicPartyCheck(pid) then
				partySystem.SendToParty(Players[pid].data.customVariables.partyName, data, Players[pid].data.login.name)
				guiHandler.ShowMemberMenu(pid)
			end
		end

		if idGui == 5731 then --Accept a pending request
			local pendingJoinRequestPid = partySystem.utils.GetPlayerDynamicParty(pid)["pendingJoinRequestPid"]
			if pendingJoinRequestPid > -1 then
				if tonumber(data) == 0 then
					partySystem.AddToParty(Players[pid].data.customVariables.partyName,pendingJoinRequestPid)
				else					
					partySystem.SendMessage(pendingJoinRequestPid,"Your request has been rejected!",false)
				end
				partySystem.utils.GetPlayerDynamicParty(pid)["pendingJoinRequestPid"] = -1			
				guiList[pendingJoinRequestPid] = nil
			else
				partySystem.SendMessage(pid,"The request is no longer valid!",false)
			end
		end

		if idGui == 5740 then --Show Member List
			if tonumber(data) < #guiList[pid] - 1 then --last index is the list mode
				if guiList[pid][#guiList[pid]] == "kickPlayer" then
					partySystem.KickPlayer(guiList[pid][tonumber(data)+1],pid)
				elseif guiList[pid][#guiList[pid]] == "cedeLeadership" then				
					partySystem.CedeLeadership(guiList[pid][tonumber(data)+1],pid, false)
				elseif guiList[pid][#guiList[pid]] == "leaderLeaving" then				
					partySystem.CedeLeadership(guiList[pid][tonumber(data)+1],pid, true)
				else
					guiHandler.ShowMemberMenu(pid)					
				end
			else
				guiHandler.ShowMemberMenu(pid)					
			end
			guiList[pid] = nil
		end
	end
end -- end OnGUIAction 

return guiHandler
