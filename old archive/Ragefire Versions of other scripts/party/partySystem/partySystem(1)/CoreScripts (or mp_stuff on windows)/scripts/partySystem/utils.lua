utils = {}

function utils.PlayerPartyCheck(pid)
 	if utils.IsPlayerInAnyParty(pid) and utils.PlayerPartyExists(pid) and utils.IsPlayerPartyMember(pid) then return true
 	else return false
 	end
end

function utils.DynamicPartyCheck(pid)
	if utils.DynamicPartyExists(Players[pid].data.customVariables.partyName) 
	and utils.IsPlayerDynamicPartyMember(Players[pid].data.customVariables.partyName,Players[pid].data.login.name) then return true
	else return false
	end
end

function utils.CompletePlayerPartyCheck(pid)
	if utils.PlayerPartyCheck(pid) and utils.DynamicPartyCheck(pid) then return true
	else return false
	end
end

function utils.GetPlayerParty(pid)
	return partyTable[Players[pid].data.customVariables.partyName]
end

function utils.GetPlayerDynamicParty(pid)
	return dynamicPartyTable[Players[pid].data.customVariables.partyName]
end

function utils.GetPartyMember(pid)
	return utils.GetPlayerParty(pid)["memberList"][Players[pid].data.login.name]
end

function utils.PartyExists(partyName)
	if partyName then
		if partyTable[partyName] then return true
		else
			tes3mp.LogMessage(enumerations.log.ERROR, "No corresponding record in partySystem.json for the dynamic party table "..partyName.." was found!")
			return false
		end
	else
		tes3mp.LogMessage(enumerations.log.ERROR, "Nil value passed to utils.PartyExists!")
	end
end

function utils.PlayerPartyExists(pid)
	if utils.GetPlayerParty(pid) then return true
	else
		tes3mp.LogMessage(enumerations.log.ERROR, "[PartySystem]Player "..Players[pid].name.."'s recorded party does not exist in partySystem.json!")
		return false
	end	
end

function utils.DynamicPartyExists(partyName)
	if partyName then
		if dynamicPartyTable[partyName] then return true
		else
			tes3mp.LogMessage(enumerations.log.ERROR, "The dynamic party table "..partyName.." does not exist!")
			return false
		end
	else
		tes3mp.LogMessage(enumerations.log.ERROR, "Nil value passed to utils.DynamicPartyExists!")
	end
end

function utils.IsPlayerPartyMember(pid)
	if utils.GetPartyMember(pid) then return true
	else
		partySystem.SendMessage(pid, "You were kicked out of "..Players[pid].data.customVariables.partyName.." while you were away!", false)
		Players[pid].data.customVariables.partyName = ""
		return false
	end
end

function utils.IsPlayerDynamicPartyMember(partyName,playerName)
	if partyName and playerName then
		if dynamicPartyTable[partyName]["memberPids"][playerName] then return true
		else
			tes3mp.LogMessage(enumerations.log.ERROR, "No player status for"..playerName.." found in the dynamic party "..partyName.."!")
			return false
		end
	else
		tes3mp.LogMessage(enumerations.log.ERROR, "Nil value(s) passed to utils.IsPlayerDynamicPartyMember!")
	end
end

function utils.IsPlayerPartyLeader(pid)
	return Players[pid].data.login.name == utils.GetPlayerParty(pid)["leaderName"]
end

function utils.IsPlayerInAnyParty(pid)
	if Players[pid].data.customVariables.partyName then
		return Players[pid].data.customVariables.partyName ~= ""
	else
		Players[pid].data.customVariables.partyName = ""
		tes3mp.LogMessage(enumerations.log.ERROR, Players[pid].data.login.name.." did not have the partyName custom variable! It has been created for them.")
		return false
	end
end

return utils