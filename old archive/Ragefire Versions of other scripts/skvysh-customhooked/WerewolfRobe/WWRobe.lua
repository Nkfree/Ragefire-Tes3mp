------------------
-- Version: 1.0 --
------------------

require("color")
WWRobe = {}

local powerReq = 0                                  -- 0 for everyone, 1 for mods, 2 for admins
local costItem = "gold_001"                         -- ID of item one must pay. Leave "" for no item
local costCount = 1000                              -- amount of item needed
local costMessage = "This will cost you 1000 gold." -- message to display about the cost
local WWRobeGUIID = 24602                           -- GUIID, probably don't need to touch

WWRobe.Initialize = function(pid, cmd)
    local power = tonumber(Players[pid].data.settings.staffRank)
    local message
    if power < powerReq then
        message = color.Red .. "Insufficient powers.\n" .. color.Default
        tes3mp.SendMessage(pid, message, false)
    else
        WWRobe.ShowCostBox(pid)
    end
end

WWRobe.ShowCostBox = function(pid)
    local label = "Equip Werewolf Robe?\n"
    if costItem ~= "" then
        label = label .. costMessage
    end
    local buttonData = "Yes;No"
    tes3mp.CustomMessageBox(pid, WWRobeGUIID, label, buttonData)
end

WWRobe.OnGUIAction = function(eventSatuts, pid, idGui, data)
	if idGui == WWRobeGUIID then
		if tonumber(data) == 0 then -- Yes
			WWRobe.CostCheck(pid)
			return true
		elseif tonumber(data) == 1 then -- No
			return true
		end
	end
end

WWRobe.CostCheck = function(pid)
    local message
    local itemCount
    local itemIndex
    local canPurchase = true
    if costItem ~= "" then
        itemIndex = tableHelper.getIndexByNestedKeyValue(Players[pid].data.inventory, "refId", costItem)
        if itemIndex ~= nil then
            itemCount = Players[pid].data.inventory[itemIndex].count
        else
            itemCount = 0
        end
        if itemCount < costCount then
            canPurchase = false
        end
    end
    if canPurchase == true then
        if costItem ~= "" then
            Players[pid].data.inventory[itemIndex].count = itemCount - costCount
            if Players[pid].data.inventory[itemIndex].count == 0 then
                Players[pid].data.inventory[itemIndex] = nil
            end
        end
        message = color.Green .. "Robe equipped!\n" .. color.Default
        tes3mp.SendMessage(pid, message, false)
        Players[pid]:LoadInventory()
        Players[pid]:LoadEquipment()
        WWRobe.EquipRobe(pid)
    else
        message = color.IndianRed .. "Item missing.\n" .. color.Default
        tes3mp.SendMessage(pid, message, false)
    end
end

WWRobe.EquipRobe = function(pid)
    if Players[pid].data.equipment[11] == nil then
        local structuredItem = {enchantmentCharge = -1, refId = "werewolfrobe", count = 1, charge = -1}
        table.insert(Players[pid].data.equipment, 11, structuredItem)
    else
        Players[pid].data.equipment[11].refId = "werewolfrobe"
        Players[pid].data.equipment[11].count = 1
        Players[pid].data.equipment[11].charge = -1
        Players[pid].data.equipment[11].enchantmentCharge = -1
    end
    Players[pid]:Save()
    Players[pid]:LoadInventory()
    Players[pid]:LoadEquipment()
end
customCommandHooks.registerCommand("wwrobe", WWRobe.Initialize)
customEventHooks.registerHandler("OnGUIAction", WWRobe.OnGUIAction)

