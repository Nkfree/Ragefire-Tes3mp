What to change to make the framework work:

commandHandler.lua:

    elseif cmd[1] == "party" then
                partySystem.guiHandler.ShowMenu(pid)

    elseif cmd[1] == "pmessage" or cmd[1] == "pmsg" and partySystem.utils.CompletePlayerPartyCheck(pid) then
        if cmd[2] == nil then
            tes3mp.SendMessage(pid, "You cannot send a blank message.\n")
        else
            message = tableHelper.concatenateFromIndex(cmd, 2)
            partySystem.SendToParty(Players[pid].data.customVariables.partyName, message, Players[pid].data.login.name)
        end

serverCore.lua:

    menuHelper = require("menuHelper")
    partySystem = require("partySystem/partySystem")

    ...

	function OnPlayerDisconnect(pid)
        partySystem.DeletePendingRequest(pid)
    	partySystem.HandlePlayerOnlineStatus(pid)

    ...

    function OnPlayerCellChange(pid)
	    tes3mp.LogMessage(enumerations.log.INFO, "Called \"OnPlayerCellChange\" for " .. logicHandler.GetChatName(pid))
	    eventHandler.OnPlayerCellChange(pid)
	    partySystem.lootSharing.CellMessage(pid)

    ...

    function OnGUIAction(pid, idGui, data)
        tes3mp.LogMessage(enumerations.log.INFO, "Called \"OnGUIAction\" for " .. logicHandler.GetChatName(pid))
        if eventHandler.OnGUIAction(pid, idGui, data) then return end -- if eventHandler.OnGUIAction is called
        if partySystem.guiHandler.OnGUIAction(pid, idGui, data) then return end
    
eventHandler.lua (in eventHandler.OnGUIAction):

    else
        Players[pid]:FinishLogin()
        partySystem.HandlePlayerOnlineStatus(pid)                    
        Players[pid]:Message("You have successfully logged in.\n" .. config.chatWindowInstructions)        		  

/player/base.lua:

    customVariables = { partyName }

    ...

    (in BasePlayer:SaveInventory)

    tes3mp.LogAppend(enumerations.log.INFO, "- id: " .. item.refId .. ", count: " .. item.count ..
    ", charge: " .. item.charge .. ", enchantmentCharge: " .. item.enchantmentCharge ..
    ", soul: " .. item.soul)

    if action == enumerations.inventory.ADD and partySystem.utils.PlayerPartyCheck(self.pid)
    and (partySystem.utils.GetPlayerParty(self.pid)["lootShuffle"] and item.refId ~= "gold_001" 
    or partySystem.utils.GetPlayerParty(self.pid)["goldSplitting"] and item.refId == "gold_001") 
    and not partySystem.lootSharing.IsMerchantCell(self.pid) and partySystem.utils.DynamicPartyCheck(self.pid) then

        if partySystem.utils.GetPlayerParty(self.pid)["lootShuffle"] and item.refId ~= "gold_001" then
            partySystem.lootSharing.ShuffleItem(self.pid, item)
        elseif partySystem.utils.GetPlayerParty(self.pid)["goldSplitting"] and item.refId == "gold_001" then
            partySystem.lootSharing.SplitGold(self.pid, item.count)
        end

    elseif action == enumerations.inventory.SET or action == enumerations.inventory.ADD then

        inventoryHelper.addItem(self.data.inventory, item.refId, item.count, item.charge,
            item.enchantmentCharge, item.soul)

        ...

/menu/help.lua:

    color.Yellow .. "/local <text>\n" ..
        color.White .. "Send a message that only players in your area can read " ..
        color.Yellow .. "(/l)\n" ..
    color.Yellow .. "/pmessage <pid> <text>\n" ..
        color.White .. "Send a message to party members " ..
        color.Yellow .. "(/pmsg)\n" ..