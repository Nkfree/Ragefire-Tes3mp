
EasyTWM = {}
TWTable = {}

-- needs only Tournaments install
EasyTWM.CheckJSON = function()
				
	if tes3mp.GetCaseInsensitiveFilename(os.getenv("MOD_DIR").."/","TWM.json") == "invalid" then
		
		TWTable = { players = {}, team = {}}
		TWTable.team["Imperial"] = {score = 0 }
		TWTable.team["Almsivi"] = {score = 0 }
		TWTable.team["Dagoth"] = {score = 0 }
		TWTable.team["Indoril"] = {score = 0 }
			
		jsonInterface.save("TWM.json", TWTable)
		
	else
		TWTable = jsonInterface.load("TWM.json")
	end
	
end

--[[EasyTWM.RegisterTeam = function(pid,team)
if TWTable.players[Players[pid].name].team ~= nil then
	tes3mp.SendMessage(pid,"You cant change Team.",false)
else

	if team == "red" then
	TWTable.players[Players[pid].name] = {team = "red"}
	tes3mp.SendMessage(pid,"Enter valid Team.",false)
	elseif team == "blue" then
	TWTable.players[Players[pid].name] = {team = "red"}
	tes3mp.SendMessage(pid,"Enter valid Team.",false)
	elseif team == "violet" then
	TWTable.players[Players[pid].name] = {team = "red"}
	tes3mp.SendMessage(pid,"Enter valid Team.",false)
	elseif team == "teamo" then
	TWTable.players[Players[pid].name] = {team = "red"}
	tes3mp.SendMessage(pid,"Enter valid Team.",false)
	else
	tes3mp.SendMessage(pid,"Enter valid Team.",false)
	end

jsonInterface.save("TWM.json", TWTable) 
end
end
]]
EasyTWM.AddRewards = function(team)
if team == "imperial" then
for pid, pl in pairs(Players) do
	for id, journalItem in pairs(Players[pid].data.journal) do
	if journalItem.quest == "tie_fw_02_joinil" and journalItem.index >= 5 then
		table.insert(Players[pid].data.inventory,{refId = "tie_factionwar_token", count = 100 , charge = -1})
		Players[pid]:Save()
		Players[pid]:Load()
		Players[pid]:LoadInventory()
		Players[pid]:LoadEquipment()
		tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."You got 100 Tokens\n",false)
		break
	end
	end
end

elseif team == "daogth" then
for pid, pl in pairs(Players) do
	for id, journalItem in pairs(Players[pid].data.journal) do
	if journalItem.quest == "tie_fw_02_joinhd" and journalItem.index >= 5 then
		table.insert(Players[pid].data.inventory,{refId = "tie_factionwar_token", count = 100 , charge = -1})
		Players[pid]:Save()
		Players[pid]:Load()
		Players[pid]:LoadInventory()
		Players[pid]:LoadEquipment()
		tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."You got 100 Tokens\n",false)
		break
	end
	end
end
		
		
elseif team == "indoril" then
for pid, pl in pairs(Players) do
	for id, journalItem in pairs(Players[pid].data.journal) do
	if journalItem.quest == "tie_fw_02_joinhi" and journalItem.index >= 5 then
		table.insert(Players[pid].data.inventory,{refId = "tie_factionwar_token", count = 100 , charge = -1})
		Players[pid]:Save()
		Players[pid]:Load()
		Players[pid]:LoadInventory()
		Players[pid]:LoadEquipment()
		tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."You got 100 Tokens\n",false)
		break
		end
	end
end

elseif team == "almsivi" then
for pid, pl in pairs(Players) do
	for id, journalItem in pairs(Players[pid].data.journal) do
	if journalItem.quest == "tie_fw_02_joinao" and journalItem.index >= 5 then
		table.insert(Players[pid].data.inventory,{refId = "tie_factionwar_token", count = 100 , charge = -1})
		Players[pid]:Save()
		Players[pid]:Load()
		Players[pid]:LoadInventory()
		Players[pid]:LoadEquipment()
		tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."You got 100 Tokens\n",false)
		break
	end
	end
end
end

-- reset scores
TWTable.team["Imperial"] = {score = 0 }
TWTable.team["Almsivi"] = {score = 0 }
TWTable.team["Dagoth"] = {score = 0 }
TWTable.team["Indoril"] = {score = 0 }
	
jsonInterface.save("TWM.json", TWTable) -- do i need this?
end

EasyTWM.Kill = function(pid)

EasyTWM.CheckJSON()
--tes3mp.SendMessage(pid,tes3mp.GetDeathReason(pid).." is deathreason\n",true)
			if logicHandler.GetPlayerByName(tes3mp.GetDeathReason(pid)) ~= nil and logicHandler.GetPlayerByName(tes3mp.GetDeathReason(pid)) ~= Players[pid] then
				local pl = logicHandler.GetPlayerByName(tes3mp.GetDeathReason(pid))
				local newpid = pl.pid
				
				for id, journalItem in pairs(Players[newpid].data.journal) do
					if journalItem.quest == "tie_fw_02_joinao" and journalItem.index >= 5 then
						TWTable.team["Almsivi"].score = TWTable.team["Almsivi"].score + 1
						tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."Almsivi Order scored\n",true)
						break
					elseif journalItem.quest == "tie_fw_02_joinhd" and journalItem.index >= 5 then
						TWTable.team["Dagoth"].score = TWTable.team["Dagoth"].score + 1
						tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."House Dagoth scored\n",true)
						break
					elseif journalItem.quest == "tie_fw_02_joinhi" and journalItem.index >= 5 then
						TWTable.team["Indoril"].score = TWTable.team["Indoril"].score + 1
						tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."House Indoril scored\n",true)
						break
					elseif journalItem.quest == "tie_fw_02_joinil" and journalItem.index >= 5 then
						TWTable.team["Imperial"].score = TWTable.team["Imperial"].score + 1
						tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."Imperial League scored\n",true)
						break
					end
				end
				
				--CheckScores
				if TWTable.team["Imperial"].score >=  10 then
					tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."Team Imperial won the World Match all Winners get RewardTokens and Points are reset\n",true)
					local str = "imperial"
					EasyTWM.AddRewards(str)
				elseif TWTable.team["Almsivi"].score  >=  10 then
					tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."Team Almsivi won the World Match all Winners get RewardTokens and Points are reset\n",true)
					local str = "almsivi"
					EasyTWM.AddRewards(str)
				elseif TWTable.team["Dagoth"].score  >=  10 then
					tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."Team Dagoth won the World Match all Winners get RewardTokensand Points are reset\n",true)
					local str = "dagoth"
					EasyTWM.AddRewards(str)
				elseif TWTable.team["Indoril"].score >=  10 then
					tes3mp.SendMessage(pid,color.MediumSeaGreen.."[WorldMatch]"..color.Default.."Team Indoril won the World Match all Winners get RewardTokens and Points are reset\n",true)
					local str = "indoril"
					EasyTWM.AddRewards(str)
				end
				
				
			end
			
jsonInterface.save("TWM.json", TWTable) 	
		
end

return EasyTWM