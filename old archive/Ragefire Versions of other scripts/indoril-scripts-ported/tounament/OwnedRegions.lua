OwnedRegions = {}

TabOverHere = {}

--[[
put OwnedRegions = require("OwnedRegions") into customScripts.lua



]]

OwnedRegions.Check = function(eventStatus, pid)
--check for region change if it laggs
	
	TabOverHere[pid] = {}
	
	RegionsTable = {}
	
	if tes3mp.GetCaseInsensitiveFilename(os.getenv("MOD_DIR").."/","Regions.json") == "invalid" then
		jsonInterface.save("Regions.json", RegionsTable)
	else
		RegionsTable = jsonInterface.load("Regions.json")
	end
	
	
	if RegionsTable[tes3mp.GetRegion(pid)] ~= nil and RegionsTable[tes3mp.GetRegion(pid)].Owner ~= nil and Players[pid].data.GotTaxesActive ~= "active" then
	
	
	
		local team = ""
				for id, journalItem in pairs(Players[pid].data.journal) do
					if journalItem.quest == "tie_fw_02_joinao" and journalItem.index >= 5 then
						team = "almsivi"
						break
					elseif journalItem.quest == "tie_fw_02_joinhd" and journalItem.index >= 5 then
						team = "dagoth"
						break
					elseif journalItem.quest == "tie_fw_02_joinhi" and journalItem.index >= 5 then
						team = "indoril"
						break
					elseif journalItem.quest == "tie_fw_02_joinil" and journalItem.index >= 5 then
						team = "imperial"
						break
					end
				end
	
	
		if RegionsTable[tes3mp.GetRegion(pid)].Owner ~= team then
			
			--if timer is not running then
				TabOverHere[pid].Region = tes3mp.GetRegion(pid)
				Players[pid].data.GotTaxesActive = "active"
				
				--change personality based on formular
				Players[pid].data.beforeSkill = tes3mp.GetSkillBase(pid,tes3mp.GetSkillId("personality"))
				local minus = math.floor((tes3mp.GetLevel(pid) / 10 ) +1) * 5 -- add cap for lvl50
				tes3mp.SetSkillBase(pid,tes3mp.GetSkillId("personality"),Players[pid].data.beforeSkill - 10)
				
				--change tax amount based on formular
				local taxes = math.floor((tes3mp.GetLevel(pid) / 5) +1) * 3 
				Players[pid].data.taxamount = 30
				
				--start timer
				local timer = tes3mp.CreateTimerEx("GetTaxes", time.seconds(600), "i", pid)
				tes3mp.StartTimer(timer)
				tes3mp.SendMessage(pid,"This is an Owned Region, you'll have to pay "..tostring(taxes).." Gold in taxes every 10 Minutes.\n",false)
		end
	end
	
	
	
end




OwnedRegions.Show = function(pid)

	RegionsTable = {}
	
	if tes3mp.GetCaseInsensitiveFilename(os.getenv("MOD_DIR").."/","Regions.json") == "invalid" then
		jsonInterface.save("Regions.json", RegionsTable)
	else
		RegionsTable = jsonInterface.load("Regions.json")
	end
	
	
	local List = ""
	
	for region, dat in ipairs(RegionsTable) do
		List = List..region .." is owned by "..dat.Owner.."\n"
	end
	
	tes3mp.ListBox(pid,-1,"Owned Regions by Factions:",List)

end



function GetTaxes(pid)
if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then
	
	if tes3mp.GetRegion(pid) == TabOverHere[pid].Region and Players[pid].data.taxamount ~= nil then
			-- add check if he got gold. if not teleport outta here
				GoldAmount = Players[pid].data.taxamount
				inventoryHelper.removeItem(Players[pid].data.inventory, "gold_001", GoldAmount)
				
				local timer = tes3mp.CreateTimerEx("GetTaxes", time.seconds(600), "i", pid)
				tes3mp.StartTimer(timer)
				tes3mp.SendMessage(pid,"You've payed the Region taxes and will have to pay again in 10 Minutes.\n",false)
	
	else
		Players[pid].data.GotTaxesActive = nil
		tes3mp.SetSkillBase(pid, tes3mp.GetSkillId("personality"), Players[pid].data.beforeSkill)
	end
end
end


customEventHooks.regsiterHandler("OnPlayerCellChange", OwnedRegions.Check)