partySystem = {utils = require("partySystem/utils"), lootSharing = require("partySystem/lootSharing"), guiHandler = require("partySystem/guiHandler")}
local jsonInterface = require("jsonInterface")
partyTable = jsonInterface.load("partySystem.json") 
dynamicPartyTable = {} --Reponsible for managing players during one session
guiList = {}
inviteTable = {}
LOOT_SHUFFLE = false --Enable or disable loot sharing options globally here. Disabling and re-enabling them is safe and will not corrupt any data.
GOLD_SPLIT = false

--Dynamic Party Management

function partySystem.HandleJoinCommands(cmd, pid)

	local pidInput = tonumber(cmd[2])
    if pid ~= pidInput then
        if Players[pidInput] then
            if partySystem.utils.IsPlayerInAnyParty(pid) then
                if partySystem.utils.PlayerPartyCheck(pid) and partySystem.utils.IsPlayerPartyLeader(pid) and partySystem.utils.DynamicPartyCheck(pid) then
                    if not partySystem.utils.GetPlayerDynamicParty(pid)["pendingJoinRequestPids"][pidInput] and (cmd[1] == "accept" or cmd[1] == "reject") then                            
                        partySystem.SendMessage(pid, "There is no pending request from that pid!", false)
                    elseif not partySystem.utils.IsPlayerInAnyParty(pidInput) then
                        if cmd[1] == "accept" then
                            partySystem.AddToParty(Players[pid].data.customVariables.partyName,pidInput)
                        elseif cmd[1] == "reject" then
                            dynamicPartyTable[Players[pid].data.customVariables.partyName]["pendingJoinRequestPids"][pidInput] = nil       
                            guiList[pidInput] = nil
                            partySystem.SendMessage(pid, "Rejected "..Players[pidInput].name..".",false)
                            partySystem.SendMessage(pidInput, "Your request has been rejected!", false)
                        else
                            if not inviteTable[pidInput] then inviteTable[pidInput] = {} end
                            if not inviteTable[pidInput][Players[pid].data.customVariables.partyName] then
                                inviteTable[pidInput][Players[pid].data.customVariables.partyName] = true --Storing pids doesn't work - Imagine a situation where the leader cedes leadership and then leaves. Acecpting that invite causes a segfault.
                                partySystem.SendMessage(pid, "Invitation sent to "..Players[pidInput].name..".", false)
                                partySystem.SendMessage(pidInput, 'You have been invited to join '..Players[pid].data.customVariables.partyName..'. Type "/accept '..pid..'" (or the pid of any other member) to approve it or "/reject '..pid..'" to deny it.', false)
                            else
                                partySystem.SendMessage(pid, "That player already has a pending invitation to your party!", false)    
                            end
                        end
                    else partySystem.SendMessage(pid, "Cannot accept that request - the player already is in a party!", false)
                    end                            
                else partySystem.SendMessage(pid, "You cannot use that command!", false)
                end
            elseif cmd[1] == "accept" or cmd[1] == "reject" then
                if partySystem.utils.IsPlayerInAnyParty(pidInput) then
                    if inviteTable[pid] and inviteTable[pid][Players[pidInput].data.customVariables.partyName] then            
                        if cmd[1] == "accept" then
                            if partySystem.utils.CompletePlayerPartyCheck(pidInput) then                                                        
                                partySystem.AddToParty(Players[pidInput].data.customVariables.partyName,pid)                    
                            end
                        else
                            if tableHelper.getCount(inviteTable[pid]) > 1 then
                                inviteTable[pid][Players[pidInput].data.customVariables.partyName] = nil                                
                            else
                                inviteTable[pid] = nil
                            end
                            partySystem.SendMessage(pid, "You have rejected the invitation to join "..Players[pidInput].data.customVariables.partyName..".", false)       
                        end
                    else partySystem.SendMessage(pid, "You do not have an invitation to that player's party!",false)               
                    end
                else partySystem.SendMessage(pid, "That player is not in any party!",false)
                end
            else partySystem.SendMessage(pid, "You cannot use that command!",false)   
            end
        else partySystem.SendMessage(pid, "That pid is not in-game!",false)
        end
    else partySystem.SendMessage(pid, "You cannot "..cmd[1].." yourself!",false)
    end
end

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
			dynamicPartyTable[Players[pid].data.customVariables.partyName] = { ["pendingJoinRequestPids"] = {}, ["onlineMembersCount"] = 1, ["memberPids"] = { [Players[pid].data.login.name] = pid } }
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
		if partySystem.utils.DynamicPartyExists(guiList[pid]["partyName"]) and dynamicPartyTable[guiList[pid]["partyName"]]["pendingJoinRequestPids"][pid] then
			dynamicPartyTable[guiList[pid]["partyName"]]["pendingJoinRequestPids"][pid] = nil
			guiList[pid] = nil
		end
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
	if not sendToAll and not Players[pid] then
		tes3mp.LogMessage(enumerations.log.ERROR, "Tried sending a message to a player who is not in-game.")
	else
		tes3mp.SendMessage(pid, color.RebeccaPurple.."[PartySystem] "..color.Default..message.."\n", sendToAll)
	end
end

--Core party management

function partySystem.CreateParty(partyName, pid)	
	partySystem.DeletePendingRequest(pid)
	if inviteTable[pid] then inviteTable[pid] = nil end
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
	if Players[joinerPid] then
		partyTable[partyName]["memberList"][Players[joinerPid].data.login.name] = true
		Players[joinerPid].data.customVariables.partyName = partyName
		partyTable[partyName]["partySize"] = partyTable[partyName]["partySize"] + 1
		jsonInterface.save("partySystem.json", partyTable)
		partySystem.ToggleMemberOnlineStatus(joinerPid)	
		if inviteTable[joinerPid] then inviteTable[joinerPid] = nil end --Handle pending requests and invites
		partySystem.DeletePendingRequest(joinerPid)
		partySystem.SendToParty(partyName, Players[joinerPid].name.." has joined the party!")
	end
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
		dynamicPartyTable[partyName]["pendingJoinRequestPids"][joinerPid] = true
		partySystem.SendMessage(leaderPid, Players[joinerPid].name..' is requesting to join the party. Type "/accept '..joinerPid..'" to approve or "/reject '..joinerPid..'" to deny it.', false)
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

function partySystem.TeleportToPlayer(targetPlayerName,pid)	
	if partySystem.utils.PlayerPartyCheck(pid) and partySystem.utils.DynamicPartyExists(Players[pid].data.customVariables.partyName) and partySystem.utils.IsPlayerDynamicPartyMember(Players[pid].data.customVariables.partyName,targetPlayerName) then 			
		local targetPlayerPid = partySystem.utils.GetPlayerDynamicParty(pid)["memberPids"][targetPlayerName]
		logicHandler.TeleportToPlayer(pid, pid, targetPlayerPid)
	else
		partySystem.SendMessage(pid, "That person is offline!", false)
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