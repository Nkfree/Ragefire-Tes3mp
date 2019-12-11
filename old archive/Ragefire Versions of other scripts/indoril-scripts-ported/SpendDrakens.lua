SpendDrakens = {}
--[[


on top SpendDrakens = require("SpendDrakens")




]]

SpendDrakens.Give = function(eventStatus, pid)
if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then
    if GroupParty.IsParty(pid) then     --give all party drakes
        local PartyId = GroupParty.WhichParty(pid)
        
        for i, p in pairs(Partytable[PartyId].player) do
                Players[p.pd]:SaveInventory()
                inventoryHelper.addItem(Players[p.pd].data.inventory, "tie_goldendrake", 100, -1,-1,"")
                --Players[p.pd]:LoadItemChanges({itemref = {refId = "tie_goldendrake", count = 100, charge = -1}}, enumerations.inventory.ADD)
                tes3mp.MessageBox(p.pd,-1,"You got some new Drakes for this Action\n")
				Players[p.pd]:LoadInventory()
				Players[p.pd]:LoadEquipment()
        end
        
    else                                 -- only give player drakes
                Players[pid]:SaveInventory()
                inventoryHelper.addItem(Players[pid].data.inventory, "tie_goldendrake", 100, -1,-1,"")
                --Players[pid]:LoadItemChanges({itemref = {refId = "tie_goldendrake", count = 100, charge = -1}}, enumerations.inventory.ADD)
                tes3mp.MessageBox(pid,-1,"You got some new Drakes for this Action\n")
				Players[pid]:LoadInventory()
				Players[pid]:LoadEquipment()
    end
end
end



SpendDrakens.ShowSpend = function(pid, cmd)

tes3mp.CustomMessageBox(pid, 1805, "What you wanna do with your Drakes?", "Train Skills; Buy House; Buy Furn; DirectTrade; Place Bounty")
end





SpendDrakens.ShowDrakes = function(pid)
local message = ""
local List = ""
Players[pid]:SaveInventory()
local amount = 0 -- get count
for i, item in pairs(Players[pid].data.inventory) do
		if item.refId == "tie_goldendrake" then
			amount = item.count
		end
end



	message = "You have "..tostring(amount) .." Goldendrakes. You can buy "..tostring(math.floor(amount/1000)).." Skills"


	for i= 1,27,1 do 
			List = List .."Spend on ".. tes3mp.GetSkillName(i-1).." which is ".. tostring(tes3mp.GetSkillBase(pid, i-1)).." \n"
	end

	tes3mp.ListBox(pid,1804,message, List)
end


SpendDrakens.Spend = function(pid,data)
	
local amount = 0 -- get count
for i, item in pairs(Players[pid].data.inventory) do
		if item.refId == "tie_goldendrake" then
			amount = item.count
		end
end	
			
		if math.floor(amount/1000) > 0 then
			local skill = tonumber(data)
				--tes3mp.SendMessage(pid,"log off message 3")
			
			inventoryHelper.removeItem(Players[pid].data.inventory, "tie_goldendrake", 1000)	
			Players[pid]:LoadInventory(pid)
			Players[pid]:LoadEquipment(pid)
			
			local modifiedSkill = tes3mp.GetSkillBase(pid,skill) + 1 
			Players[pid].data.skills[tes3mp.GetSkillName(skill)] = modifiedSkill
			Players[pid]:LoadSkills()
			--tes3mp.SendMessage(pid,"log off message 4")
			local modifiedProgress = tes3mp.GetLevelProgress(pid) + 1
			Players[pid].data.stats.levelProgress = modifiedProgress
			Players[pid]:LoadLevel()
			--tes3mp.SendMessage(pid,"log off message 5")
			tes3mp.SendMessage(pid,Players[pid].name.." skilled ".. tes3mp.GetSkillName(skill).." with Goldendrakes\n",true)
			tes3mp.SendSkills(pid)
		else
			tes3mp.SendMessage(pid,"Sorry you dont have enough Goldendrakes.\n",false)
		end
end


SpendDrakens.OnGUIAction  = function(eventStatus, pid, idGui, data)	
	if idGui == 1804 then
		SpendDrakens.Spend(pid,data)
	end
	if idGui == 1805 then --  "Train Skills; Buy House; Buy Furn; DirectTrade; Place Bounty"
		if tonumber(data) == 0 then
			SpendDrakens.ShowDrakes(pid)
		elseif tonumber(data) == 1 then
			if kanaHousing ~= nil then
			kanaHousing.OnUserCommand(pid) 
			end
		elseif tonumber(data) == 2 then
			if kanaFurniture ~= nil then
			kanaFurniture.OnCommand(pid)
			end
		elseif tonumber(data) == 3 then
			if DirectTrade ~= nil then 
			DirectTrade.ShowItem(pid)
			end
		elseif tonumber(data) == 4 then
			if Bountys ~= nil then 
			Bountys.SetPlayer(pid)
			end
		end
	end
		
	
end

customEventHooks.registerHandler("OnGUIAction", SpendDrakens.OnGUIAction)
customEventHooks.registerHandler("OnPlayerJournal",SpendDrakens.Give)
customEventHooks.registerHandler("OnPlayerBook",SpendDrakens.Give)
customEventHooks.registerHandler("OnActorDeath",SpendDrakens.Give)
customCommandHooks.registerCommand("drakes", SpendDrakens.ShowSpend)