guiHandler = {}

function guiHandler.ShowMemberMenu(pid)
	local extraOption = (partySystem.utils.IsPlayerPartyLeader(pid) and "Leader actions;" or "")
	tes3mp.CustomMessageBox(pid,5700,Players[pid].data.customVariables.partyName.." Party Menu",extraOption.."Teleport to a member;Show the party member list;Send a message to members;Leave the party;Close")
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
		tes3mp.ListBox(pid,5740,color.Gold.."Select the player to kick:",guiHandler.CreateMemberList(Players[pid].data.customVariables.partyName,"kickPlayer",pid))
	else
		partySystem.SendMessage(pid,"There is no one to kick!",false)			
		guiHandler.ShowLeaderMenu(pid)
	end
end

function guiHandler.LeaderOptionCedeLeadership(pid)
	if partySystem.utils.GetPlayerParty(pid)["partySize"] > 1 then
		tes3mp.ListBox(pid,5740,color.Gold.."Choose a player to cede leadership to:",guiHandler.CreateMemberList(Players[pid].data.customVariables.partyName,"cedeLeadership",pid))
	else
		partySystem.SendMessage(pid,"There is no one to cede leadership to!",false)			
		guiHandler.ShowLeaderMenu(pid)
	end
end

function guiHandler.LeaderOptionBack(pid)
	guiList[pid] = nil
	tes3mp.CustomMessageBox(pid,5700,Players[pid].data.customVariables.partyName.." Party Menu","Leader actions;Teleport to a member;Show the party member list;Send a message to members;Leave the party;Close")		
end

function guiHandler.CreatePendingRequestList(partyName, pid)
	local pidList = ""
	guiList[pid] = {}
	if partySystem.utils.PartyExists(partyName) and partySystem.utils.DynamicPartyExists(partyName) then
		for requestingPid, _ in pairs (dynamicPartyTable[partyName]["pendingJoinRequestPids"]) do
			local node = Players[requestingPid].name.." ("..requestingPid..")\n"
			pidList = pidList..node
			guiList[pid][#guiList[pid]+1] = requestingPid
		end
	end
	return pidList
end

function guiHandler.CreatePendingInvitesList(pid)
	local partyList = ""
	guiList[pid] = {}
	for partyName, _ in pairs (inviteTable[pid]) do
		if partySystem.utils.PartyExists(partyName) and partySystem.utils.DynamicPartyExists(partyName) then
			local leaderName = partyTable[partyName]["leaderName"] 
			local partySize = partyTable[partyName]["partySize"]
			partyList = partyList..partyName.." ("..leaderName..") - "..dynamicPartyTable[partyName]["onlineMembersCount"].."/"..partySize.."\n"
			guiList[pid][#guiList[pid]+1] = partyName
		end
	end	
	return partyList
end

function guiHandler.LeaderOptionViewPendingRequests(pid)
	tes3mp.ListBox(pid,5745,"Pending requests (click on one to respond):",guiHandler.CreatePendingRequestList(Players[pid].data.customVariables.partyName,pid))
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
	optionsList = "Back"
	guiList[pid] = {guiHandler.LeaderOptionBack}
	for _, _ in pairs (dynamicPartyTable[Players[pid].data.customVariables.partyName]["pendingJoinRequestPids"]) do
		optionsList = "View pending join requests;"..optionsList
		table.insert(guiList[pid], 1, guiHandler.LeaderOptionViewPendingRequests)		
		break
	end
	optionsList = "Kick a player;Cede leadership;"..optionsList
	table.insert(guiList[pid],1,guiHandler.LeaderOptionCedeLeadership)
	table.insert(guiList[pid],1,guiHandler.LeaderOptionKickPlayer)
	--[[if GOLD_SPLIT then 
		local goldSplitting = (partySystem.utils.GetPlayerParty(pid)["goldSplitting"] and "On" or "Off")
		optionsList = "Gold splitting - "..goldSplitting..";"..optionsList
		table.insert(guiList[pid], 1, guiHandler.LeaderOptionGoldSplitting)
	end
	if LOOT_SHUFFLE then 
		local lootShuffle = (partySystem.utils.GetPlayerParty(pid)["lootShuffle"] and "On" or "Off")
		optionsList = "Loot shuffle - "..lootShuffle..";"..optionsList
		table.insert(guiList[pid], 1, guiHandler.LeaderOptionLootShuffle)
	end]]--
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
			local colour = (dynamicPartyTable[partyName]["memberPids"][leaderName] and color.Gold or color.Grey)
			memberList = memberList..colour..leaderName.." (Leader)".." - ".. onlineStatus.."\n" 
		elseif listmode == "teleport" then			
			local leaderName = partyTable[partyName]["leaderName"]
			if Players[pid].data.login.name ~= leaderName and dynamicPartyTable[partyName]["memberPids"][leaderName] then
				memberList = memberList..color.Gold..leaderName.." (Leader)\n" 
				guiList[pid][1] = leaderName
			end
		end
		for playerName, playerData in pairs(partyTable[partyName]["memberList"]) do
			if playerName ~= partyTable[partyName]["leaderName"] then
				if dynamicPartyTable[partyName]["memberPids"][playerName] then
					if listmode ~= "teleport" or Players[pid].data.login.name ~= playerName then
						onlineArray[#onlineArray+1] = playerName
					end
				elseif listmode ~= "teleport" then
					offlineArray[#offlineArray+1] = playerName
				end
			end
		end
		for playerIndex, playerName in ipairs(onlineArray) do
			local onlineStatus = ""
			if listmode ~= "teleport" then onlineStatus = " - Online" end
			memberList = memberList..color.Gold..playerName..onlineStatus.."\n"
			if listmode ~= "memberList" then guiList[pid][#guiList[pid]+1] = playerName end
		end
		for playerIndex, playerName in ipairs(offlineArray) do
			memberList = memberList..color.Grey..playerName.." - Offline\n" 
			if listmode ~= "memberList" then guiList[pid][#guiList[pid]+1] = playerName end
		end
		guiList[pid][#guiList[pid]+1] = listmode
	end
	return memberList
end

function guiHandler.CreatePartyList()
	local partyList = ""
	local sortedPartyTable = {}

    for partyName, data in pairs(partyTable) do
        table.insert(sortedPartyTable, data)
        sortedPartyTable[#sortedPartyTable]["partyName"] = partyName
    end
	
	table.sort(sortedPartyTable, function(a,b) return a["partySize"] > b["partySize"] end) --Sort the party list by the total number of members
	for _, partyData in ipairs(sortedPartyTable) do		
		local colour = color.Grey
		local onlineMembers = 0
		if partySystem.utils.DynamicPartyExists(partyData["partyName"]) then 
			onlineMembers = dynamicPartyTable[partyData["partyName"]]["onlineMembersCount"]
			colour = color.Gold
		end
		partyList = partyList..colour..partyData["partyName"].." ("..partyData["leaderName"]..") - "..onlineMembers.."/"..partyData["partySize"].."\n"
	end
	return partyList
end

function guiHandler.CreateJoinablePartyList(pid)
	local partyList = ""
	guiList[pid] = {}
	for partyName, partyData in pairs(dynamicPartyTable) do		
		if partySystem.utils.PartyExists(partyName) then
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
	elseif guiList[pid] and guiList[pid]["pendingJoinRequest"] and guiList[pid]["partyName"] then
		tes3mp.CustomMessageBox(pid,5711,"Cancel the pending request to join "..guiList[pid]["partyName"].."?","Yes;No")
	else		
		local optionsList = "Close"
		if inviteTable[pid] then optionsList = "Show pending party invitations;"..optionsList end	
		optionsList = "Create a party;Join a party;"..optionsList
		tes3mp.CustomMessageBox(pid,5710,"Welcome to the Party System.",optionsList)
	end
end

function guiHandler.OnGUIAction(pid, idGui, data)

	if idGui == 5710 or idGui == 5711 or idGui == 5720 or idGui == 5730 or idGui == 5735 or idGui == 5736 then --Does not require the player to be a member
		if idGui == 5710 then --Create/join party
			local optionsTable = {
				function (pid)
					tes3mp.InputDialog(pid,5720,"What name should the party have?","")	
				end,
				function (pid)
					local partyList = guiHandler.CreateJoinablePartyList(pid)
					if partyList ~= "" then
						tes3mp.ListBox(pid,5730,"Party Name (Leader's Name) - Members Online/Total Members",partyList)
					else
						partySystem.SendMessage(pid,"There are no joinable parties at the moment.",false)			
					end
				end
			}
			if inviteTable[pid] then 
				table.insert(optionsTable, function(pid) tes3mp.ListBox(pid,5735,"Pending invitations (click on one to respond):\nParty Name (Leader's Name) - Members Online/Total Members",guiHandler.CreatePendingInvitesList(pid))end)					
			end
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
					partySystem.CreateParty(data, pid)
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
						guiList[pid] = { ["pendingJoinRequest"] = true, ["partyName"] = partyName } -- Now save the one selected party
						partySystem.SendJoinRequest(guiList[pid]["partyName"],partyTable[guiList[pid]["partyName"]]["leaderName"],pid)
						partySystem.SendMessage(pid,"A request to join "..guiList[pid]["partyName"].." has been sent to "..partyTable[guiList[pid]["partyName"]]["leaderName"]..".", false)				
					else
						partySystem.SendMessage(pid,"You can't join the party right now - the leader has gone offline!", false)				
					end
				else
					partySystem.SendMessage(pid,"You can't join the party - it no longer exists!", false)
				end
			end
		end

		if idGui == 5735 then --Show the party invites list			
			if tonumber(data) < #guiList[pid] then
				guiList[pid] = guiList[pid][tonumber(data)+1]
				tes3mp.CustomMessageBox(pid,5736,"How to respond to the invitation to "..guiList[pid].."?","Approve;Deny")
			else
				guiList[pid] = nil
			end
	    end

	   	if idGui == 5736 then --Respond to a party invite through GUI
	    	if tonumber(data) == 0 then			
				partySystem.AddToParty(guiList[pid],pid)
	    	elseif tonumber(data) == 1 then
                if tableHelper.getCount(inviteTable[pid]) > 1 then
                    inviteTable[pid][guiList[pid]] = nil                                
                else
                    inviteTable[pid] = nil
                end
				partySystem.SendMessage(pid, "You have rejected the invitation to join "..guiList[pid]..".", false)       
	    	end
	    	guiList[pid] = nil
	    end

	elseif (idGui == 5700 or idGui == 5701 or idGui == 5705 or idGui == 5740 or idGui == 5745 or idGui == 5746) and partySystem.utils.PlayerPartyCheck(pid) then
		if idGui == 5700 then
			local optionsTable = {  --Getting rid of an if chain -- Main member menu
				function (pid)		
					local memberList = guiHandler.CreateMemberList(Players[pid].data.customVariables.partyName,"teleport",pid) 		
					if #guiList[pid] > 1 then
						tes3mp.ListBox(pid,5740,"Choose the player to teleport to:",memberList)
					else
						partySystem.SendMessage(pid, "There is no one to teleport to!",false)
						guiList[pid] = nil
					end
				end,
				function (pid)
				 	tes3mp.ListBox(pid,5740,color.Gold..guiHandler.CreateMemberListCaption(pid),guiHandler.CreateMemberList(Players[pid].data.customVariables.partyName,"memberList",pid))
				end,
				function (pid)
				 	tes3mp.InputDialog(pid,5705,"Type your message:","")
				end,
				partySystem.LeaveParty
			}

			if partySystem.utils.IsPlayerPartyLeader(pid) then										
				table.insert(optionsTable,1,guiHandler.ShowLeaderMenu)
			end

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

		if idGui == 5740 then --Show the Member List
			if tonumber(data) < #guiList[pid] - 1 then --last index is the list mode
				if guiList[pid][#guiList[pid]] == "kickPlayer" then
					partySystem.KickPlayer(guiList[pid][tonumber(data)+1],pid)
				elseif guiList[pid][#guiList[pid]] == "cedeLeadership" then				
					partySystem.CedeLeadership(guiList[pid][tonumber(data)+1],pid, false)
				elseif guiList[pid][#guiList[pid]] == "leaderLeaving" then				
					partySystem.CedeLeadership(guiList[pid][tonumber(data)+1],pid, true)
				elseif guiList[pid][#guiList[pid]] == "teleport" then
					partySystem.TeleportToPlayer(guiList[pid][tonumber(data)+1],pid)
				else
					guiHandler.ShowMemberMenu(pid)					
				end
			else
				guiHandler.ShowMemberMenu(pid)					
			end
			guiList[pid] = nil
		end

		if idGui == 5745 then --Show the pending request pid list			
			if tonumber(data) < #guiList[pid] then
				guiList[pid] = guiList[pid][tonumber(data)+1]
				tes3mp.CustomMessageBox(pid,5746,"Let "..Players[guiList[pid]].name.." into the party?","Yes;No")
			else
				guiList[pid] = nil
				guiHandler.ShowLeaderMenu(pid)
			end
	    end

	    if idGui == 5746 then --Respond to a pending request through GUI
	    	if tonumber(data) == 0 then			
				partySystem.AddToParty(Players[pid].data.customVariables.partyName,guiList[pid])
	    	elseif tonumber(data) == 1 then
				dynamicPartyTable[Players[pid].data.customVariables.partyName]["pendingJoinRequestPids"][guiList[pid]] = nil       
                guiList[guiList[pid]] = nil --Use the leader's guiList which contains the pid of the player to reject to nil that player's guiList which contains their pending request details
                partySystem.SendMessage(guiList[pid], "Your request has been rejected!",false)
	    	end
	    	guiList[pid] = nil
	    end
	end
end -- end OnGUIAction 

return guiHandler