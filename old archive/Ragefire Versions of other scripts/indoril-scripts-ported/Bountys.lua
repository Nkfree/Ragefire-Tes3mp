-- friendlyPvP = require("friendlyPvP")  -- enable code lines with friendlyPvP for compability


Bountys = {}
Cooldowns = {}

BountyOptionsList = {}

local bountyCooldownTime = 1000

function bountyTimerEnded()
	for pid, TimerID in pairs(Cooldowns) do
		if tes3mp.IsTimerElapsed(TimerID) then
			Cooldowns[pid] = nil
			tes3mp.FreeTimer(TimerID)
		end
	end
end


Bountys.Devide = function(pid, cmd)
if cmd[2] ~= nil then
	if cmd[2] == "set" then 
	 Bountys.SetPlayer(pid)
	else
	 Bountys.SeeBounty(pid)
	end
else
	tes3mp.SendMessage(pid, "Use /bounty see or /bounty set\n")
end
end
	
Bountys.SetPlayer = function(pid)
	local realcount = 1
	local PlList = ""
	BountyOptionsList[pid] = { data = {} }

	for i, p in pairs(Players) do
		PlList = PlList ..p.name.."\n"
		BountyOptionsList[pid].data[realcount] = i
		realcount = realcount + 1
	end

	PlList = PlList .."***Close***"

	tes3mp.ListBox(pid, 1210, "Choose Player to set Bounty on", PlList)
end


Bountys.ShowGoldInput = function(pid)
	tes3mp.InputDialog(pid,1220,"How much Gold?","how much")
end


Bountys.SeeBounty = function(pid)
	local PlList = ""


	for i, Pl in pairs(Players) do  -- print all online players bounty
		if Players[pid].data.Bounty ~= nil and  Players[pid].data.Bounty ~= "-1" then
			local BountyGold = Players[pid].data.Bounty
			
			PlList = PlList..Pl.name.." has Bounty "..BountyGold.."\n"
		end
	end

	tes3mp.ListBox(pid,1230,"The Bountys",PlList)

end 


Bountys.SetBountyValue = function(pid,gold)

	local targetpid = Players[pid].data.BountyChosenPid
	local BeforeGold = 0
	local GoldAmount = 0
			--Players[pid]:Save()
			--Players[pid]:Load()
			Players[pid]:LoadInventory() -- load before so everythings correct
			Players[pid]:LoadEquipment()

	for i, inv in pairs(Players[pid].data.inventory) do --- check inv if he have does gold
			if 	inv.refId == "tie_goldendrake" then
					GoldAmount = inv.count
					break
			end	
	end





	if GoldAmount >= gold and gold > 0 then -- if he got more gold than he wants to place

		for i, inv in pairs(Players[pid].data.inventory) do --- remove gold
			if 	inv.refId == "tie_goldendrake" then
					Players[pid].data.inventory[i].count = inv.count - gold
					tes3mp.SendMessage(pid,tostring(gold).." #DAA520Gold#FFFFFF were removed from your inventory.\n",false)
							
					if inv.count < 1 then  -- if empty remove
							Players[pid].data.inventory[i] = nil
					end
					break
			end
		end		






		if Players[targetpid].data.Bounty ~= nil and  Players[targetpid].data.Bounty ~= "-1" then  -- increase bounty
			BeforeGold = Players[targetpid].data.Bounty
			gold = gold + BeforeGold
			Players[targetpid].data.Bounty = gold
			tes3mp.SendMessage(targetpid,Players[targetpid].name.." had a private bounty placed on their head worth "..tostring(gold).." #DAA520Gold#FFFFFF. Kill them to claim the reward!\n",true)
		else													--- set new bounty
			Players[targetpid].data.Bounty = gold
			tes3mp.SendMessage(targetpid,Players[targetpid].name.." had their private bounty total increased to "..tostring(gold).." #DAA520Gold#FFFFFF, kill them to claim the reward!\n",true)
		end

		-- if gold > 3000 then friendlyPvP.TurnOn(targetpid) end

	else
	tes3mp.SendMessage(pid,"You don't have enough #DAA520Gold#FFFFFF.\n",false)   -- else send him message
	end



			
			--Players[pid]:Save()    ------reload because we changed gold
			Players[pid]:LoadInventory()
			Players[pid]:LoadEquipment()


end --end function



Bountys.GotKilled = function(eventStatus, pid, cellDescription)

if tes3mp.DoesActorHavePlayerKiller(0) then -- illegal logic when we have multiple objects for actorIndex

                local killerPid = tes3mp.GetActorKillerPid(0)
                local Deathreason = logicHandler.GetChatName(killerPid)

	local BountyHunterPid = -1
	local HeGotGold = false

	for i, Pl in pairs(Players) do  -- check if he got killed from player
		if string.lower(Pl.name) == string.lower(Deathreason)  then
			if Deathreason ~= Players[pid].name then
				BountyHunterPid = Pl.pid
				break
			end
		end
	end





	if BountyHunterPid ~= -1 then 
			
				--Players[BountyHunterPid]:Save()
				--Players[BountyHunterPid]:Load()
				Players[BountyHunterPid]:LoadInventory()
				Players[BountyHunterPid]:LoadEquipment()
				
			if Players[pid].data.Bounty ~= nil and  Players[pid].data.Bounty ~= "-1" then  -- check if player got bounty
				local WinBounty = Players[pid].data.Bounty
				Players[pid].data.Bounty = "-1"
				tes3mp.SendMessage(BountyHunterPid,Players[BountyHunterPid].name.." has claimed a private bounty reward for killing "..Players[pid].name.."!! \n",true)
				
				
					for i, inv in pairs(Players[BountyHunterPid].data.inventory) do ---add gold if he got gold
						if 	inv.refId == "tie_goldendrake" then
							Players[BountyHunterPid].data.inventory[i].count = inv.count + tonumber(WinBounty)
							tes3mp.SendMessage(BountyHunterPid,WinBounty.." #DAA520Gold#FFFFFF added.\n",false)
								HeGotGold = true
							if Players[BountyHunterPid].data.inventory[i].count < 1 then  -- if empty remove. i think this doesnt happen
								Players[BountyHunterPid].data.inventory[i] = nil
							end
							break
						end
					end
				
					if HeGotGold == false then
						table.insert(Players[BountyHunterPid].data.inventory, {refId = "tie_goldendrake", count = tonumber(WinBounty), charge = -1})
					end
					
			end
			
			
				--Players[BountyHunterPid]:Save()
				--Players[BountyHunterPid]:Load()
				Players[BountyHunterPid]:LoadInventory()
				Players[BountyHunterPid]:LoadEquipment()
				
			tes3mp.SendMessage(pid,"Processed BountyStuff. Your private bounty has been cleared.\n",false)
			tes3mp.SendMessage(BountyHunterPid,"Processed BountyStuff. You've claimed a private bounty!\n",false)
			
	end
end
end

Bountys.OnGUIAction = function(eventStatus, pid,idGui,data)

	if idGui == 1210 then
		if tonumber(data) < table.getn(BountyOptionsList[pid].data) then
			  
			local chosenpid = BountyOptionsList[pid].data[tonumber(data)  + 1]
			if logicHandler.CheckPlayerValidity(pid, chosenpid) then Players[pid].data.BountyChosenPid = chosenpid
				Bountys.ShowGoldInput(pid)
			end
		
		else
			tes3mp.SendMessage(pid,"You closed the Menu \n",false)
		end
	end


	if idGui == 1220 then
		if tonumber(data) ~= nil then
			if not Cooldowns[Players[pid].data.BountyChosenPid] then
				local TimerStart = tes3mp.CreateTimer("bountyTimerEnded", bountyCooldownTime)
				Cooldowns[Players[pid].data.BountyChosenPid] = TimerStart
				tes3mp.StartTimer(TimerStart)
				Bountys.SetBountyValue(pid,tonumber(data))
			else
				tes3mp.SendMessage(pid,"Player has had a bounty placed on them within the past hour.\n",false)	
			end
		else
			tes3mp.SendMessage(pid,"Enter a Valid Gold Amount.\n",false)
		end
	end

end -- end ongui


customEventHooks.registerHandler("OnGUIAction", Bountys.OnGUIAction)
customEventHooks.registerHandler("OnActorDeath", Bountys.GotKilled)
customCommands.registerCommand("bounty", Bountys.Devide)
