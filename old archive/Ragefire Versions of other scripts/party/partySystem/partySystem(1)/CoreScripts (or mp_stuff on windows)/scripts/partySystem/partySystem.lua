---Party system by Dale---

partySystem = {utils = require("partySystem/utils"), lootSharing = require("partySystem/lootSharing"), guiHandler = require("partySystem/guiHandler")}
local jsonInterface = require("jsonInterface")
partyTable = jsonInterface.load("partySystem.json") 
dynamicPartyTable = {} --Reponsible for managing players during one session
guiList = {}
LOOT_SHUFFLE = true --Enable or disable loot sharing options globally here. Disabling and re-enabling them is safe and will not corrupt any data.
GOLD_SPLIT = true

--Dynamic Party Management

function partySystem.ToggleMemberOnlineStatus(pid)
	if partySystem.utils.PlayerPartyExists(pid) and partySystem.utils.IsPlayerPartyMember(pid) then
		local playerDynamicParty = partySystem.utils.GetPlayerDynamicParty(pid) --Has the party already been created this session?
		if playerDynamicParty then
			if playerDynamicParty["memberPids"][Players[pid].data.login.name] then
				playerDynamicParty["memberPids"][Players[pid].data.login.name] = nil
				playerDynamicParty["onlineMembersCount"] = playerDynamicParty["onlineMembersCount"] - 1
			else
				playerDynamicParty["memberPids"][Players[pid].data.login.name] = pid
				playerDynamicParty["onlineMembersCount"] = dynamicPartyTable[Players[pid].data.customVariables.partyName]["onlineMembersCount"] + 1 					--in the rare event of the leader logging out just as a pending request was sent, show the popup to them on relogging				
			end																											
		else																											
			dynamicPartyTable[Players[pid].data.customVariables.partyName] = { ["pendingJoinRequestPid"] = -1, ["onlineMembersCount"] = 1, ["memberPids"] = { [Players[pid].data.login.name] = pid } }
		end			
	end
end

function partySystem.HandlePlayerOnlineStatus(pid)
	if partySystem.utils.IsPlayerInAnyParty(pid) then
		partySystem.ToggleMemberOnlineStatus(pid)	
	end
end

function partySystem.DeletePendingRequest(pid) --Pending requests have to be deleted on a player disconnecting to prevent segfaults
	if guiList[pid] and guiList[pid]["pendingJoinRequest"] then
		if partySystem.utils.DynamicPartyExists(guiList[pid]["partyName"]) then
			dynamicPartyTable[guiList[pid]["partyName"]]["pendingJoinRequestPid"] = -1
			guiList[pid] = nil
		end --If the leader is disconnecting, remove any pending requests for his party
	elseif partySystem.utils.PlayerPartyCheck(pid) and partySystem.utils.IsPlayerPartyLeader(pid) and partySystem.utils.DynamicPartyCheck(pid)
	and partySystem.utils.GetPlayerDynamicParty(pid)["pendingJoinRequestPid"] ~= -1 then
		tes3mp.LogMessage(enumerations.log.ERROR, partySystem.utils.GetPlayerDynamicParty(pid)["pendingJoinRequestPid"])
		guiList[partySystem.utils.GetPlayerDynamicParty(pid)["pendingJoinRequestPid"]] = nil
		dynamicPartyTable[Players[pid].data.customVariables.partyName]["pendingJoinRequestPid"] = -1
	end
end

--Messaging

function partySystem.SendToParty(partyName, message, speakerName)
	speakerName = speakerName or ""
	local colour = color.Default
	if speakerName ~= "" then 
		if speakerName == partyTable[partyName]["leaderName"] then colour = color.Gold end
		speakerName = speakerName..": "
	end
	local fullMessage = color.RebeccaPurple.."[PartySystem] "..colour..speakerName..color.Default..message.."\n"
	for playerName, playerPid in pairs(dynamicPartyTable[partyName]["memberPids"]) do
		tes3mp.SendMessage(playerPid, fullMessage, false)
	end
end

function partySystem.SendMessage(pid,message,sendToAll)
	tes3mp.SendMessage(pid, color.RebeccaPurple.."[PartySystem] "..color.Default..message.."\n", sendToAll)
end

--Core party management

function partySystem.CreateParty(pid, partyName)	
	partyTable[partyName] = { ["leaderName"] = Players[pid].data.login.name, ["partySize"] = 1, ["lootShuffle"] = LOOT_SHUFFLE, ["goldSplitting"] = GOLD_SPLIT, ["memberList"] = { [Players[pid].data.login.name] = true } }
	jsonInterface.save("partySystem.json", partyTable)
	Players[pid].data.customVariables.partyName = partyName
	partySystem.ToggleMemberOnlineStatus(pid)
	partySystem.SendMessage(pid,"A party named "..partyName.." has been succesfully created!",true)
end

function partySystem.DisbandParty(partyName,pid)
	partySystem.ToggleMemberOnlineStatus(pid)
	Players[pid].data.customVariables.partyName = ""
	partyTable[partyName] = nil
	jsonInterface.save("partySystem.json", partyTable)
	partySystem.SendMessage(pid,"The party named "..partyName.." has been disbanded!",true)
end

function partySystem.AddToParty(partyName, joinerPid)
	partyTable[partyName]["memberList"][Players[joinerPid].name] = true
	Players[joinerPid].data.customVariables.partyName = partyName
	partyTable[partyName]["partySize"] = partyTable[partyName]["partySize"] + 1
	jsonInterface.save("partySystem.json", partyTable)
	partySystem.ToggleMemberOnlineStatus(joinerPid)
	partySystem.SendToParty(partyName, Players[joinerPid].name.." has joined the party!")
end

function partySystem.RemoveFromParty(partyName, pid)
	partySystem.ToggleMemberOnlineStatus(pid)
	partyTable[partyName]["memberList"][Players[pid].data.login.name] = nil
	Players[pid].data.customVariables.partyName = ""
	partyTable[partyName]["partySize"] = partyTable[partyName]["partySize"] - 1
	jsonInterface.save("partySystem.json", partyTable)
end

--Member actions

function partySystem.SendJoinRequest(partyName, leaderName, joinerPid)
	if partySystem.utils.PartyExists(partyName) and partySystem.utils.DynamicPartyExists(partyName) and partySystem.utils.IsPlayerDynamicPartyMember(partyName,leaderName) then
		local leaderPid = dynamicPartyTable[partyName]["memberPids"][leaderName]
		dynamicPartyTable[partyName]["pendingJoinRequestPid"] = joinerPid		
		tes3mp.CustomMessageBox(leaderPid,5731,Players[joinerPid].name.." is requesting to join the party. Do you accept?","Yes;No")
	end
end

function partySystem.LeaveParty(pid)
	if partySystem.utils.PlayerPartyCheck(pid) then
		local partyName = Players[pid].data.customVariables.partyName
		if partySystem.utils.IsPlayerPartyLeader(pid) then
			if partyTable[partyName]["partySize"] > 1 then --Is there anyone else to assign leadership to?				
				tes3mp.ListBox(pid,5740,"Choose a player to cede leadership to:",guiHandler.CreateMemberList(partyName,"leaderLeaving",pid))
			else
				partySystem.DisbandParty(partyName,pid)
			end
		else
			partySystem.RemoveFromParty(partyName, pid)			
			partySystem.SendToParty(partyName,Players[pid].name.." has left the party!")
			partySystem.SendMessage(pid, "You have left the party!", false)
		end
	else
		tes3mp.LogMessage(enumerations.log.ERROR, "[PartySystem]Tried removing "..Players[pid].name.." from a party, but they are not a member!")
	end
end

function partySystem.TeleportToLeader(pid)	
	if partySystem.utils.PlayerPartyCheck(pid) and not partySystem.utils.IsPlayerPartyLeader(pid) then
		local leaderName = partySystem.utils.GetPlayerParty(pid)["leaderName"] 
		if partySystem.utils.DynamicPartyExists(Players[pid].data.customVariables.partyName) and partySystem.utils.IsPlayerDynamicPartyMember(Players[pid].data.customVariables.partyName,leaderName) then 			
			local leaderPid = partySystem.utils.GetPlayerDynamicParty(pid)["memberPids"][leaderName]
 			logicHandler.TeleportToPlayer(pid, pid, leaderPid)
 		else
 			partySystem.SendMessage(pid, "The leader is offline!", false)
 		end
 	else
 		tes3mp.LogMessage(enumerations.log.ERROR, "Player tried teleporting to the leader, but they are the leader themselves!")
 	end
end

--Leader actions

function partySystem.KickPlayer(playerName,leaderPid)
	local partyName = Players[leaderPid].data.customVariables.partyName
	if partyTable[partyName]["memberList"][playerName] then 
		if partySystem.utils.DynamicPartyExists(partyName) and partySystem.utils.IsPlayerDynamicPartyMember(partyName, playerName) then
			local playerPid = dynamicPartyTable[partyName]["memberPids"][playerName]
			partySystem.ToggleMemberOnlineStatus(playerPid)
			Players[playerPid].data.customVariables.partyName = ""	
			partySystem.SendMessage(playerPid, "You have been kicked out of the party!", false)			
		end
		partyTable[partyName]["memberList"][playerName] = nil
		partyTable[partyName]["partySize"] = partyTable[partyName]["partySize"] - 1
		jsonInterface.save("partySystem.json", partyTable)
		partySystem.SendToParty(partyName,playerName.." has been kicked out of the party!")
	else
		tes3mp.LogMessage(enumerations.log.ERROR, "[PartySystem]Tried kicking "..Players[pid].name.." from "..partyName.." but they are not a member!")
	end
end

function partySystem.CedeLeadership(newLeaderName,formerLeaderPid,leaderLeaving)
	local partyName = Players[formerLeaderPid].data.customVariables.partyName
	partyTable[partyName]["leaderName"] = newLeaderName	
	local leavingPart =  ""
	if leaderLeaving then
		partySystem.RemoveFromParty(partyName, formerLeaderPid)
		partySystem.SendMessage(formerLeaderPid, "You have left the party!", false)
		leavingPart =  "left the party and " 
	end
	partySystem.SendToParty(partyName, Players[formerLeaderPid].name.." has "..leavingPart.."ceded leadership to "..newLeaderName.."!")	
end

return partySystem
