
EasyTDM = {}

DeathTable = {}

-- needs only Tournaments install



TourCells = {}
TourCells[1] ={name = "Battle Arena, Akulakhan's Chamber", posx1 = 4214.208 , posy1 = 7660.447 , posz1 =  12959.345, rotz1 =  199.6, posx2 =  4473.970, posy2 = 3999.291 , posz2 =  10897.777, rotz2 = 180.0, posx3 =  4500.776, posy3 =  590.232, posz3 =  11075.682, rotz3 = 0.0, posx4 =  4411.528, posy4 = 1852.277 , posz4 = 12823.406 , rotz4 = 0.0}
TourCells[2] ={name =  "Battle Arena, Corprusarium Bowels", posx1 =  1630.333, posy1 =  5292.603, posz1 =  12047.228, rotz1 = 91.7, posx2 =  3990.182, posy2 =  1210.167, posz2 =  12533.382, rotz2 = 0.0, posx3 =  5519.125, posy3 = 2465.216 , posz3 =  12158.934, rotz3 = 354.3, posx4 =  5495.532, posy4 =  6072.017, posz4 =  12151.918, rotz4 = 183.3}
TourCells[3] ={name = "Battle Arena, Deadlands", posx1 =  4162.793, posy1 =  12743.217, posz1 =  12489.900, rotz1 =154.7, posx2 = 12437.063 , posy2 = -2602.201 , posz2 = 12679.355 , rotz2 = 331.4, posx3 = -2896.341 , posy3 =  7294.696, posz3 = 12498.292 , rotz3 = 199.6, posx4 = -12080.883 , posy4 = 3390.771 , posz4 = 12510.095 , rotz4 = 91.7}
TourCells[4] ={name =  "Battle Arena, Mortrag Glacier: Huntsman's Hall", posx1 =  4493.607, posy1 =  785.625, posz1 =  12670.806, rotz1 = 0.0, posx2 =  3845.120, posy2 =  8828.088, posz2 =  11841.036, rotz2 = 143.2, posx3 =  2266.890, posy3 =  5923.399, posz3 =  11693.582, rotz3 = 91.7, posx4 =  6239.799, posy4 =  6231.265, posz4 =  11960.652, rotz4 =268.3 }
TourCells[5] ={name =  "Battle Arena, Mortrag Glacier: Inner Ring", posx1 =  4553.411, posy1 =  2356.553, posz1 =  13175.127, rotz1 = 68.8, posx2 =  5978.582, posy2 =  3360.474, posz2 =  13263.314, rotz2 = 279.8, posx3 =  3237.989, posy3 =  5580.063, posz3 =  13124.533, rotz3 = 228.2, posx4 =  4142.776, posy4 = 4039.530, posz4 = 13481.558 , rotz4 = 0.0}
TourCells[6] ={name =  "Battle Arena, Mortrag Glacier: Outer Ring", posx1 =  5550.802, posy1 =  4588.720, posz1 =  13180.021, rotz1 = 233.9  , posx2 =  5445.629, posy2 = 5210.154 , posz2 =  13223.804, rotz2 = 308.4, posx3 = 2533.650 , posy3 = 3070.501 , posz3 =  13272.353, rotz3 = 314.2, posx4 =  4115.340, posy4 = 4162.906 , posz4 =  13214.957, rotz4 = 354.3}
TourCells[7] ={name =  "Battle Arena, Norenen-dur: Basilica of Divine Whispers", posx1 =  4129.345, posy1 =  2099.139, posz1 =  12173.396, rotz1 = 0.0, posx2 =  2006.547, posy2 =  4291.812, posz2 = 12766.807 , rotz2 = 57.3, posx3 =  4590.631, posy3 = 5146.762 , posz3 = 12493.234 , rotz3 = 182.4, posx4 =  5849.084, posy4 = 5104.787 , posz4 =  13251.521, rotz4 = 262.6}
TourCells[8] ={name =  "Battle Arena, Norenen-dur: Citadel of Myn Dhrur", posx1 = 4222.068 , posy1 = 1339.074 , posz1 = 12230.088 , rotz1 = 354.3, posx2 =  2443.908, posy2 =  3.000, posz2 =  12294.756, rotz2 = 51.6, posx3 =  5265.786, posy3 =  2066.965, posz3 = 12601.823 , rotz3 = 22.9, posx4 =  1740.290, posy4 =  4256.987, posz4 =  12269.545, rotz4 = 45.8}
TourCells[9] ={name =  "Battle Arena, Norenen-dur: The Grand Stair", posx1 =  3925.097, posy1 =  2502.948, posz1 = 11997.063 , rotz1 = 0.0, posx2 =  5426.603, posy2 =  5107.462, posz2 = 11409.960 , rotz2 = 262.6, posx3 =  5260.300, posy3 =  5537.011, posz3 =  13190.652, rotz3 = 211.0, posx4 =  3792.816, posy4 =  3143.593, posz4 =  12861.240, rotz4 = 216.8}
TourCells[10] ={name =  "Battle Arena, Mysterious Tomb", posx1 =  5418.834, posy1 =  2492.970, posz1 =  12086.826, rotz1 = 0.0, posx2 =  3100.540, posy2 =  4769.215, posz2 = 12086.826 , rotz2 = 90.0, posx3 = 4371.919 , posy3 =  7897.863, posz3 =  12108.203, rotz3 = 180.0, posx4 = 4376.219 , posy4 = 6346.992 , posz4 =12664.490  , rotz4 =180.0 }
TourCells[11] ={name =  "Battle Arena, Old Mournhold: Battlefield", posx1 =  -12.195, posy1 =  3659.669, posz1 =  12329.307, rotz1 = 154.7, posx2 =  4694.852, posy2 = 5074.514 , posz2 = 11147.805 , rotz2 = 80.2, posx3 = 4645.702 , posy3 =  1900.486, posz3 =  11603.379, rotz3 =17.2 , posx4 =  4324.587, posy4 =  7564.778, posz4 = 13056.330 , rotz4 = 180.0}
TourCells[12] ={name =  "Battle Arena, Redoran Home", posx1 = 2776.327 , posy1 =  6537.829, posz1 = 12057.774 , rotz1 = 180.0, posx2 = 2226.877 , posy2 = 5152.594 , posz2 =  12448.771, rotz2 = 85.9, posx3 =  2257.466, posy3 = 3925.687 , posz3 =  12629.478, rotz3 = 182.4, posx4 = 5332.522 , posy4 = 1493.682 , posz4 = 11849.959 , rotz4 = 0.0}
TourCells[13] ={name = "Battle Arena, Rotheran Arena", posx1 =  4291.880, posy1 =  4903.073, posz1 = 14524.686 , rotz1 =  270.0, posx2 =  4679.927, posy2 =  4023.030, posz2 = 14524.686 , rotz2 =270.0 , posx3 =  3981.871, posy3 = 3364.364 , posz3 = 14524.686 , rotz3 = 0.0, posx4 =  5257.667, posy4 =  4022.161, posz4 = 15123.622 , rotz4 =270.0 }
TourCells[14] ={name =  "Battle Arena, Royal Palace: Throne Room", posx1 =  4614.167, posy1 =  4590.426, posz1 =  14566.802, rotz1 = 180.0 , posx2 =  4094.121, posy2 =  5078.498, posz2 =  14566.802, rotz2 = 180.0, posx3 =  4094.012, posy3 =  3156.587, posz3 =  14566.802, rotz3 = 0.0, posx4 =  3564.083, posy4 = 3672.581 , posz4 =  14566.802, rotz4 =0.0 }
TourCells[15] ={name =  "Battle Arena, Shrine of Azura", posx1 =  5803.321, posy1 = 3091.864 , posz1 = 13051.762 , rotz1 =  270.0, posx2 =  5820.208, posy2 = 5115.080 , posz2 = 13051.762 , rotz2 =270.0 , posx3 =  3375.487, posy3 =  5121.576, posz3 =  13127.762, rotz3 = 90.0, posx4 = 3374.470 , posy4 = 3069.023 , posz4 = 13127.762  , rotz4 = 90.0}
TourCells[16] ={name =  "Battle Arena, Tukushapal", posx1 = 2038.155 , posy1 =  5248.669, posz1 =  12259.330, rotz1 = 90.0, posx2 = 4751.959 , posy2 =  3156.328, posz2 =  11786.263, rotz2 = 251.1, posx3 = 6078.547 , posy3 =  2090.599, posz3 = 11786.263 , rotz3 =85.0 , posx4 =  3715.078, posy4 = 6218.612 , posz4 =  11787.263, rotz4 = 96.4}
TourCells[17] ={name =  "Battle Arena, Vivec: Arena Pit", posx1 =  5097.427, posy1 = 4175.627 , posz1 =  11964.599, rotz1 = 270.0 , posx2 =  3527.771, posy2 = 4159.909 , posz2 =  11964.599, rotz2 = 90.0, posx3 = 4321.269 , posy3 = 3482.818 , posz3 = 11964.599 , rotz3 = 0.0, posx4 =  4318.189, posy4 = 4880.841 , posz4 = 11964.599 , rotz4 =180.0 }
TourCells[18] ={name = "Battle Arena, Vvardenfell's Grand Colosseum", posx1 = 5212.604 , posy1 = 4081.471 , posz1 =  11791.943, rotz1 = 270.0, posx2 =4117.708  , posy2 = 3151.748 , posz2 =  11791.943, rotz2 = 0.0, posx3 =  3048.586, posy3 =  4085.720, posz3 =  11791.943, rotz3 = 90.0, posx4 =  4123.914, posy4 =  5037.487, posz4 = 11791.943 , rotz4 =180.0 }
TourCells[19] ={name = "Battle Arena, Bamz-Amschend: Skybreak Gallery", posx1 = 2750.620, posy1 = 5606.576, posz1 = 12276.275, rotz1 = 135.3, posx2 = 5394.532, posy2 = 2934.057, posz2 = 12276.275, rotz2 = 318.7,posx3 = 5393.860, posy3 = 5608.836, posz3 = 12276.275, rotz3 = 227.0,posx4 = 2762.884, posy4 = 2950.325, posz4 = 12276.275, rotz4 = 43.7}
TourCells[20] ={name = "Battle Arena, Zaintiraris: Shrine", posx1 = 2684.148, posy1 = 3055.675, posz1 = 13578.130, rotz1 = 44.9, posx2 = 2702.102, posy2 = 5159.510, posz2 = 13578.130, rotz2 = 130.8,posx3 = 5310.930, posy3 = 5154.259, posz3 = 13578.130, rotz3 = 222.5,posx4 = 5304.194, posy4 = 3064.123, posz4 = 13578.130, rotz4 = 314.2}



EasyTDM.StartTDM = function(tab)
tdmIsRunning = "yes"
DeathTable = tab

DeathTable.team = {}
DeathTable.team["Almsivi"] = {score = 0}
DeathTable.team["Dagoth"] = {score = 0}
DeathTable.team["Indoril"] = {score = 0}
DeathTable.team["Imperial"] = {score = 0}

for pid, value in pairs(DeathTable.play) do
	--tes3mp.SendMessage(p,color.Aquamarine.."[Tournament]"..color.Default.."Tournament Starts. Participants will be teleported\n",false)
	tes3mp.SendMessage(pid,color.Aquamarine.."[Tournament]"..color.Default.."Tournament is DeathMatch. FIGHT EACH OTHER\n",false)
end



--tes3mp.SendMessage(pid,"Deathmatch starts",true)
local timer = tes3mp.CreateTimer("EndofTDM",time.seconds(600))
tes3mp.StartTimer(timer)
end


function EndofTDM()
--get winner and rewards
if tournament == "active" then

					local winnerscore = 0
					--local winner = ""

						-- Players get Rewards here for highest kills
					for team, value in pairs(DeathTable.team) do
						if value.score > winnerscore then
							winnerscore = value.score
						end
					end
						
						
						
				if DeathTable.team["Imperial"].score >=  winnerscore then
					--tes3mp.SendMessage(pid,"Team Imperial won the Contest all Players get RewardTokens\n",true)
					local str = "imperial"
					EasyTDM.AddRewards(str)
					DeathTable.Winner = str
					--EndofTDM()
				elseif DeathTable.team["Almsivi"].score  >=  winnerscore then
					--tes3mp.SendMessage(pid,"Team Almsivi won the Contest all Players get RewardTokens\n",true)
					local str = "almsivi"
					EasyTDM.AddRewards(str)
					DeathTable.Winner = str
					--EndofTDM()
				elseif DeathTable.team["Dagoth"].score  >= winnerscore then
					--tes3mp.SendMessage(pid,"Team Dagoth won the Contest all Players get RewardTokens\n",true)
					local str = "dagoth"
					EasyTDM.AddRewards(str)
					DeathTable.Winner = str
					--EndofTDM()
				elseif DeathTable.team["Indoril"].score >=  winnerscore then
					--tes3mp.SendMessage(pid,"Team Indoril won the Contest all Players get RewardTokens\n",true)
					local str = "indoril"
					EasyTDM.AddRewards(str)
					DeathTable.Winner = str
					--EndofTDM()
				end







local List = ""
	
	for team, value in pairs(DeathTable.team) do
		List = List..team.." got "..tostring(value.score).." Points \n"
	end
for pid, value in pairs(DeathTable.play) do	
	if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then
		tes3mp.Resurrect(pid,0)
		tes3mp.ListBox(pid,334,"Ending ScoreBoard:",List)
	else
		table.remove(DeathTable.play, pid)
	end
end

tdmIsRunning = "no"
Tournament.EndofTour(DeathTable) -- teleports back. last Action in here
--DeathTable = {} -- do i need this?
end
end

EasyTDM.AddRewards = function(team) -- adds the rewards

for pid, value in pairs(DeathTable.play) do--rewards for all
	if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then
		table.insert(Players[pid].data.inventory,{refId = "p_restore_health_e", count = 2 , charge = -1})
		table.insert(Players[pid].data.inventory,{refId = "p_restore_magicka_e", count = 2 , charge = -1})
		table.insert(Players[pid].data.inventory,{refId = "p_restore_fatigue_e", count = 2 , charge = -1})
		table.insert(Players[pid].data.inventory,{refId = "gold_001", count = 250 , charge = -1})
		Players[pid]:Save()
		Players[pid]:Load()
		Players[pid]:LoadInventory()
		Players[pid]:LoadEquipment()
		tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.."You got Potions and Gold for participating.\n",false)
	else
		table.remove(DeathTable.play, pid)
	end
		
end


--rewards for winner
if team == "imperial" then
for pid, pl in pairs(Players) do
	for id, journalItem in pairs(Players[pid].data.journal) do
	if journalItem.quest == "tie_fw_02_joinil" and journalItem.index >= 5 then
		table.insert(Players[pid].data.inventory,{refId = "tie_factionwar_token", count = 100 , charge = -1})
		Players[pid]:Save()
		Players[pid]:Load()
		Players[pid]:LoadInventory()
		Players[pid]:LoadEquipment()
		tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.."You got 100 Tokens for Winning\n",false)
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
		tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.."You got 100 Tokens for Winning\n",false)
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
		tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.."You got 100 Tokens for Winning\n",false)
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
		tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.."You got 100 Tokens for Winning\n",false)
		break
	end
	end
end
end

end

EasyTDM.Kill = function(pid)

       
if tes3mp.DoesPlayerHavePlayerKiller(pid) then
				--local pl = logicHandler.GetPlayerByName(tes3mp.GetDeathReason(pid))
				local newpid = tes3mp.GetPlayerKillerPid(pid)
		
			if DeathTable.play[pid].team ~= DeathTable.play[newpid].team then
				for id, journalItem in pairs(Players[newpid].data.journal) do
					if journalItem.quest == "tie_fw_02_joinao" and journalItem.index >= 5 then
						DeathTable.team["Almsivi"].score = DeathTable.team["Almsivi"].score + 1
						tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.."Almsivi Order scored\n",true)
						break
					elseif journalItem.quest == "tie_fw_02_joinhd" and journalItem.index >= 5 then
						DeathTable.team["Dagoth"].score = DeathTable.team["Dagoth"].score + 1
						tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.." House Dagoth scored\n",true)
						break
					elseif journalItem.quest == "tie_fw_02_joinhi" and journalItem.index >= 5 then
						DeathTable.team["Indoril"].score = DeathTable.team["Indoril"].score + 1
						tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.." House Indoril scored\n",true)
						break
					elseif journalItem.quest == "tie_fw_02_joinil" and journalItem.index >= 5 then
						DeathTable.team["Imperial"].score = DeathTable.team["Imperial"].score + 1
						tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.." Imperial League scored\n",true)
						break
					end
				end
				
				--CheckScores. call EndofTDM
				if DeathTable.team["Imperial"].score >=  10 then
					tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.."Team Imperial won the Contest all Players get RewardTokens\n",true)
					local str = "imperial"
					--EasyTDM.AddRewards(str)
					EndofTDM()
				elseif DeathTable.team["Almsivi"].score  >=  10 then
					tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.."Team Almsivi won the Contest all Players get RewardTokens\n",true)
					local str = "almsivi"
					--EasyTDM.AddRewards(str)
					EndofTDM()
				elseif DeathTable.team["Dagoth"].score  >=  10 then
					tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.."Team Dagoth won the Contest all Players get RewardTokens\n",true)
					local str = "dagoth"
					--EasyTDM.AddRewards(str)
					EndofTDM()
				elseif DeathTable.team["Indoril"].score >=  10 then
					tes3mp.SendMessage(pid,color.DarkOrange.."[TDM]"..color.Default.."Team Indoril won the Contest all Players get RewardTokens\n",true)
					local str = "indoril"
					--EasyTDM.AddRewards(str)
					EndofTDM()
				end
		end
end


	

local List = color.DarkOrange.."[TDM]"..color.Default.." -  ScoreBoard  - \n"
	
	for team, value in pairs(DeathTable.team) do
		List = List..team.." got "..color.Gold..tostring(value.score)..color.Default.." Points \n"
	end
	
	--tes3mp.ListBox(pid,333,"ScoreBoard:",List)
	tes3mp.MessageBox(pid,-1,List)

local timer = tes3mp.CreateTimerEx("TDMRevive", time.seconds(10), "i", pid)
tes3mp.StartTimer(timer)
end



function TDMRevive(pid)
	
    if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then
	
		if  tdmIsRunning ~= "no" then
				tes3mp.Resurrect(pid,0)
				
				local rand = 1
				
				for i, Cell in pairs(TourCells) do
					if tes3mp.GetCell(pid) == Cell.name then
						rand = i
					end
				end
				
				
				
				
				if DeathTable.play[pid].team == "almsivi" then
					tes3mp.SetPos(pid, TourCells[rand].posx1, TourCells[rand].posy1, TourCells[rand].posz1)
					tes3mp.SetRot(pid, 0, 0, TourCells[rand].rotz1) 
					
					tes3mp.SendPos(pid)
				elseif  DeathTable.play[pid].team == "dagoth" then
					tes3mp.SetPos(pid, TourCells[rand].posx2, TourCells[rand].posy2, TourCells[rand].posz2)
					tes3mp.SetRot(pid, 0, 0, TourCells[rand].rotz2) 
					
					tes3mp.SendPos(pid)
				elseif  DeathTable.play[pid].team == "imperial" then
					tes3mp.SetPos(pid, TourCells[rand].posx3, TourCells[rand].posy3, TourCells[rand].posz3)
					tes3mp.SetRot(pid, 0, 0, TourCells[rand].rotz3) 
					
					tes3mp.SendPos(pid) 
				elseif  DeathTable.play[pid].team == "indoril" then
					tes3mp.SetPos(pid, TourCells[rand].posx4, TourCells[rand].posy4, TourCells[rand].posz4)
					tes3mp.SetRot(pid, 0, 0, TourCells[rand].rotz4) 
					
					tes3mp.SendPos(pid)
				end
		else
			tes3mp.Resurrect(pid,0)
		end
    end
end

return EasyTDM