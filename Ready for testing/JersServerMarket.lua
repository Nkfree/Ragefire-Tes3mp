-------In data\recordstore\creature.json this needs to be added to the permanent records-------
--[[
  "permanentRecords":{
	"marketrat":{
      "baseId":"dead rat",
      "name":"Market"
    }
  }
]]--


JersServerMarket = {}
------In commandHandler.lua add to the elseif command chain------

JersServerMarket.cmd = function(pid, cmd)
        if WorldInstance.market == nil then
            WorldInstance.market = {}
        end
        if WorldInstance.data.market == nil then
            WorldInstance.data.market = {earnedOffline = {}}
        end
        WorldInstance.market.cell = "mark's vampire test cell"
        local marketId = ""
        local playerName = Players[pid].data.login.name
        
        if Players[pid].loadedMarket == nil then
            
            if LoadedCells[WorldInstance.market.cell] == nil then
                logicHandler.LoadCell(WorldInstance.market.cell)
            end
            
            if WorldInstance.data.market.marketId == nil then
                local location = {posX = 0,posY = 0,posZ = 0,rotX = 0,rotY = 0,rotZ = 0}
                marketId = logicHandler.CreateObjectAtLocation(WorldInstance.market.cell,location,"marketrat","spawn")
                WorldInstance.data.market.marketId = marketId
                WorldInstance:Save()
            else
                marketId = WorldInstance.data.market.marketId
            end
            
            LoadedCells[WorldInstance.market.cell]:LoadGeneratedRecords(pid)
            
            local objData = LoadedCells[WorldInstance.market.cell].data.objectData
            LoadedCells[WorldInstance.market.cell]:LoadObjectsSpawned(pid,objData,{marketId})
            LoadedCells[WorldInstance.market.cell]:LoadContainers(pid,objData,{marketId})
            Players[pid].loadedMarket = true
            
        end
        marketId = WorldInstance.data.market.marketId
        logicHandler.ActivateObjectForPlayer(pid,WorldInstance.market.cell,marketId)

end
		
		
		
-------In player\base.lua in the SaveInventory function after the local item array add this-------
JersServerMarket.onInventory = function(eventStatus, pid)
		local self = Players[pid]
        local itemRefId = tes3mp.GetInventoryItemRefId(self.pid, 0)
print("oninventory the itemref is was ")
print(itemRefId)
        if itemRefId ~= "" then
            -- don't remove the item this time
            if self.skipRemove then
				print("now inside skipping")
                self:LoadInventory()
                self:LoadEquipment()
				self.skipRemove = false
                return customEventHooks.makeEventStatus(false, false)
            end
		end
end
			
-------In cell\base.lua in the SaveContainers function after the local itemSoul add this-------
JersServerMarket.onContainer = function(eventStatus, pid, cellDescription, objects)

--print("before this")
			

    tes3mp.ReadReceivedObjectList()
    tes3mp.CopyReceivedObjectListToStore()
	
    local packetOrigin = tes3mp.GetObjectListOrigin()
    local action = tes3mp.GetObjectListAction()
    local subAction = tes3mp.GetObjectListContainerSubAction()

    for objectIndex = 0, tes3mp.GetObjectListSize() - 1 do

        local uniqueIndex = tes3mp.GetObjectRefNum(objectIndex) .. "-" .. tes3mp.GetObjectMpNum(objectIndex)
        local refId = tes3mp.GetObjectRefId(objectIndex)
		
        for itemIndex = 0, tes3mp.GetContainerChangesSize(objectIndex) - 1 do
			
			--print("after this")
			
            if WorldInstance.data.market ~= nil and uniqueIndex == WorldInstance.data.market.marketId then
				--print("inside")
				
				local subAction = tes3mp.GetObjectListContainerSubAction()
				if subAction == enumerations.containerSub.TAKE_ALL then
					return customEventHooks.makeEventStatus(false, false)
				end
				print("after")
				local action = tes3mp.GetObjectListAction()
				local itemRefId = tes3mp.GetContainerItemRefId(objectIndex, itemIndex)
				local itemCount = tes3mp.GetContainerItemCount(objectIndex, itemIndex)
				local itemCharge = tes3mp.GetContainerItemCharge(objectIndex, itemIndex)
				local itemEnchantmentCharge = tes3mp.GetContainerItemEnchantmentCharge(objectIndex, itemIndex)
				local itemSoul = tes3mp.GetContainerItemSoul(objectIndex, itemIndex)
				print(itemRefId)
                Players[pid].market = {item = {
                refId = itemRefId,
                count = itemCount,
                charge = itemCharge,
                enchantmentCharge = itemEnchantmentCharge,
                soul = itemSoul
                }}
				
				
                if action == enumerations.container.ADD then -- selling an item
                    --let Players[pid]:SaveInventory() know to skip removing the item
                    Players[pid].skipRemove = true
                    
                    local sellBannedItems = {
                        "bound_battle_axe",
                        "bound_dagger",
                        "bound_longbow",
                        "bound_longsword",
                        "bound_mace",
                        "bound_spear",
                        "bound_boots",
                        "bound_cuirass",
                        "bound_gauntlet_left",
                        "bound_guantlet_right",
                        "bound_helm",
                        "bound_shield"
                    }
                    if tableHelper.containsValue(sellBannedItems,itemRefId) then
                        Players[pid]:Message("Can't sell that item\n")
                    else
                        tes3mp.InputDialog(pid,1200,"Price per item","The amount you want to sell each individual item at")
                    end
                
                elseif action == enumerations.container.REMOVE then -- buying an item
                    Players[pid].market.item.count = tes3mp.GetContainerItemActionCount(objectIndex, itemIndex)
                    local itemListings = WorldInstance.data.market[itemRefId]
                    local price = 0
                    local buyLabel = ""
                    local needProcessing = Players[pid].market.item.count
                    local processedListings = {}
                    local listingChanges = {}
					
					if itemListings == nil then
                        Players[pid]:Message("Couldn't find listing for this item")
                        tes3mp.LogMessage(2,"Couldn't find listing for "..itemRefId)
                        return
                    end
                    
                    -- loop through all the listings to process all the items being bought
                    while needProcessing > 0 do
                        -- find the cheapest listing then oldest
                        local cheapest = {player = "",index = 0,price = math.huge,time = math.huge}
                        for sellingPlayer,playersListings in pairs(itemListings) do
                            for listingIndex,listing in pairs(playersListings) do
                                if tableHelper.containsValue(processedListings,listing) == false then
                                    local ppi = listing.ppi
                                    if Players[pid].data.login.name == sellingPlayer then -- if you are trying to buy your own item then it costs nothing
                                        ppi = 0
                                    end
                                    if ppi < cheapest.price or (ppi == cheapest.price and listing.timeListed < cheapest.time) then
                                        cheapest.player = sellingPlayer
                                        cheapest.index = listingIndex
                                        cheapest.price = ppi
                                        cheapest.time = listing.timeListed
                                    end
                                end
                            end
                        end
                        local cheapestListing = itemListings[cheapest.player][cheapest.index]
                        local buyingCount = 0
                        if needProcessing >= cheapestListing.count then
                            buyingCount = cheapestListing.count
                            needProcessing = needProcessing - cheapestListing.count
                        else
                            buyingCount = needProcessing
                            needProcessing = 0
                        end
                        
                        local listingTotal = cheapestListing.ppi * buyingCount
                        if Players[pid].data.login.name == cheapest.player then -- if you are trying to buy your own item then it costs nothing
                            listingTotal = 0
                        end
                        
                        price = price + listingTotal
                        buyLabel = buyLabel .. string.format("Amount:%i     PerItem:%i     Seller:%.20s\n",buyingCount,cheapestListing.ppi,cheapest.player)
                        table.insert(listingChanges,{count = buyingCount,player = cheapest.player,index = cheapest.index,total = listingTotal})
                        table.insert(processedListings,cheapestListing)
                    end
                    Players[pid].market.price = price
                    Players[pid].market.processedListings = processedListings
                    Players[pid].market.listingChanges = listingChanges
                    buyLabel = buyLabel .. "Buy for " .. price
                    tes3mp.CustomMessageBox(pid,1201,buyLabel,"Accept;Cancel")
                end
                return customEventHooks.makeEventStatus(false, false)
            end				
		end
	end
	
return customEventHooks.makeEventStatus(true, true)		
end
			



			
-------In eventHandler.lua in the OnContainer function this code needs to be either commented out (--[[ and ]]--) or deleted-------

        --[[if not isCellLoaded and logicHandler.DoesPacketOriginRequireLoadedCell(packetOrigin) then
            tes3mp.LogMessage(enumerations.log.WARN, "Invalid Container: " .. logicHandler.GetChatName(pid) ..
                " used impossible packetOrigin for unloaded " .. cellDescription)
            return]]--

-- just turn that var now
config.allowOnContainerForUnloadedCells = true			
			

			
			
-------In eventHandler.lua in the OnGUIAction function in the first if idGui == elseif chain add this-------

JersServerMarket.OnGUIAction = function(eventStatus, pid, idGui, data)

if eventStatus.validCustomHandlers then --check if some other script made this event obsolete
            if idGui == 1200 then -- gui sell
                
                local enteredPrice = tonumber(data)
                if enteredPrice ~= nil and enteredPrice < 10000000 and enteredPrice >= 0 then -- entered valid price
                    local item = Players[pid].market.item
                    local name = Players[pid].data.login.name
                    local marketId = WorldInstance.data.market.marketId
                    local marketCell = WorldInstance.market.cell
                    if WorldInstance.data.market[item.refId] == nil then
                        WorldInstance.data.market[item.refId] = {}
                    end
                    if WorldInstance.data.market[item.refId][name] == nil then -- player is not selling any of these items
                        WorldInstance.data.market[item.refId][name] = {{ppi = enteredPrice,count = item.count,timeListed = os.time()}}
                    else -- player is selling these items but wants to sell more
                        local playersListings = WorldInstance.data.market[item.refId][name]
                        local foundPrice = false
                        -- loop through listings to see if selling items at same price
                        for listingIndex,listing in pairs(playersListings) do
                            if listing.ppi == enteredPrice then
                                WorldInstance.data.market[item.refId][name][listingIndex].count = listing.count + item.count
                                WorldInstance.data.market[item.refId][name][listingIndex].timeListed = os.time()
                                foundPrice = true
                                break
                            end
                        end
                        if foundPrice == false then -- player is selling item but with different price
                            table.insert(WorldInstance.data.market[item.refId][name],{ppi = enteredPrice,count = item.count,timeListed = os.time()})
                        end
                    end
                    WorldInstance:Save()
                    
                    -- move items
                    if LoadedCells[marketCell].data.objectData[marketId].inventory == nil then
                        LoadedCells[marketCell].data.objectData[marketId].inventory = {}
                    end
                    
                    local marketInventory = LoadedCells[marketCell].data.objectData[marketId].inventory
                    inventoryHelper.addItem(marketInventory,item.refId,item.count,item.charge,item.enchantmentCharge,item.soul)
                    if logicHandler.IsGeneratedRecord(item.refId) then
                        local recordStore = logicHandler.GetRecordStoreByRecordId(item.refId)

                        if recordStore ~= nil then
                            LoadedCells[marketCell]:AddLinkToRecord(recordStore.storeType, item.refId, marketId)
                        end
                        
                        for playerId,player in pairs(Players) do -- loop through players and send record
                            recordStore:LoadGeneratedRecords(playerId,recordStore.data.generatedRecords,{item.refId})
                        end
                    end
                    
                    inventoryHelper.removeItem(Players[pid].data.inventory,item.refId,item.count,item.charge,item.enchantmentCharge,item.soul)
                    if not inventoryHelper.containsItem(Players[pid].data.inventory, item.refId) and
                    logicHandler.IsGeneratedRecord(item.refId) then

                        local recordStore = logicHandler.GetRecordStoreByRecordId(item.refId)

                        if recordStore ~= nil then
                            Players[pid]:RemoveLinkToRecord(recordStore.storeType, item.refId)
                        end
                    end
                    
                    tableHelper.cleanNils(Players[pid].data.inventory)
                    tableHelper.cleanNils(marketInventory)
                    LoadedCells[marketCell].data.objectData[marketId].inventory = marketInventory
                    Players[pid]:Save()
                    LoadedCells[marketCell]:Save()
                    Players[pid]:LoadItemChanges({item},enumerations.inventory.REMOVE)
                    local objData = LoadedCells[marketCell].data.objectData
                    LoadedCells[marketCell]:LoadContainers(pid,objData,{marketId})
                    tes3mp.SendContainer(true, true)
                
                end
                
                -- closes inventory to fix an issue with menu
                    logicHandler.RunConsoleCommandOnPlayer(pid, "tm")
                    logicHandler.RunConsoleCommandOnPlayer(pid, "tm")
                
            elseif idGui == 1201 then -- gui buy
                
                if tonumber(data) == 0 then -- clicked accept
                    
                    local goldIndex = tableHelper.getIndexByNestedKeyValue(Players[pid].data.inventory,"refId","gold_001")
                    local goldCount = 0
                    if goldIndex ~= nil then -- has gold
                        goldCount = Players[pid].data.inventory[goldIndex].count
                    end
                    if goldCount >= Players[pid].market.price then -- has enough gold
                        
                        local item = Players[pid].market.item
                        local itemListings = WorldInstance.data.market[item.refId]
                        local processedListings = Players[pid].market.processedListings
                        local listingsChanged = false
                        
                        -- loop through listings to see if they changed since first clicking on item
                        for processedIndex,processedListing in pairs(processedListings) do
                            local foundListing = false
                            for sellingPlayer,playersListings in pairs(itemListings) do
                                for listingIndex,listing in pairs(playersListings) do
                                    if processedListing == listing then
                                        foundListing = true
                                    end
                                end
                            end
                            if foundListing == false then
                                listingsChanged = true
                            end
                        end
                        if listingsChanged == false then -- listings haven't changed
                            local marketId = WorldInstance.data.market.marketId
                            local marketCell = WorldInstance.market.cell
                            
                            --move item and remove gold
                            inventoryHelper.addItem(Players[pid].data.inventory,item.refId,item.count,item.charge,item.enchantmentCharge,item.soul)
                            if logicHandler.IsGeneratedRecord(item.refId) then
                                local recordStore = logicHandler.GetRecordStoreByRecordId(item.refId)

                                if recordStore ~= nil then
                                    Players[pid]:AddLinkToRecord(recordStore.storeType, item.refId)
                                end
                            end
                            
                            local marketInventory = LoadedCells[marketCell].data.objectData[marketId].inventory
                            local itemIndex = inventoryHelper.removeItem(marketInventory,item.refId,item.count,item.charge,item.enchantmentCharge,item.soul)
                            if not inventoryHelper.containsItem(marketInventory, item.refId) and
                            logicHandler.IsGeneratedRecord(item.refId) then
                                local recordStore = logicHandler.GetRecordStoreByRecordId(item.refId)

                                if recordStore ~= nil then
                                    LoadedCells[marketCell]:RemoveLinkToRecord(recordStore.storeType, item.refId, marketId)
                                end
                            end
                            
                            local goldItem = {refId = "gold_001",count = Players[pid].market.price,charge = -1,enchantCharge = -1,soul = ""}
                            inventoryHelper.removeItem(Players[pid].data.inventory,"gold_001",Players[pid].market.price,-1,-1,"")
                            
                            tableHelper.cleanNils(Players[pid].data.inventory)
                            tableHelper.cleanNils(marketInventory)
                            LoadedCells[marketCell].data.objectData[marketId].inventory = marketInventory
                            Players[pid]:Save()
                            LoadedCells[marketCell]:Save()
                            Players[pid]:LoadItemChanges({item},enumerations.inventory.ADD)
                            Players[pid]:LoadItemChanges({goldItem},enumerations.inventory.REMOVE)
                            local objData = LoadedCells[marketCell].data.objectData
                            LoadedCells[marketCell]:LoadContainers(pid,objData,{marketId})
                            tes3mp.SendContainer(true, true)
                            
                            --update listings and give gold
                            local listingChanges = Players[pid].market.listingChanges
                            for processedIndex,processedListing in pairs(processedListings) do
                                if logicHandler.IsPlayerNameLoggedIn(listingChanges[processedIndex].player) then
                                    local seller = logicHandler.GetPlayerByName(listingChanges[processedIndex].player)
                                    local goldItem = {refId = "gold_001",count = listingChanges[processedIndex].total,charge = -1,enchantCharge = -1,soul = ""}
                                    inventoryHelper.addItem(seller.data.inventory,"gold_001",listingChanges[processedIndex].total,-1,-1,"")
                                    seller:Save()
                                    seller:LoadItemChanges({goldItem},enumerations.inventory.ADD)
                                    seller:Message("Earned " .. listingChanges[processedIndex].total .. " in the Market\n")
                                else
                                    local sellerData = jsonInterface.load("player/" .. listingChanges[processedIndex].player .. ".json")
                                    tableHelper.fixNumericalKeys(sellerData)
                                    inventoryHelper.addItem(sellerData.inventory,"gold_001",listingChanges[processedIndex].total,-1,-1,"")
                                    jsonInterface.save("player/" .. listingChanges[processedIndex].player .. ".json",sellerData,config.playerKeyOrder)
                                    if WorldInstance.data.market.earnedOffline == nil then
                                        WorldInstance.data.market.earnedOffline = {}
                                    end
                                    if WorldInstance.data.market.earnedOffline[listingChanges[processedIndex].player] == nil then
                                        WorldInstance.data.market.earnedOffline[listingChanges[processedIndex].player] = 0
                                    end
                                    WorldInstance.data.market.earnedOffline[listingChanges[processedIndex].player] =
                                        WorldInstance.data.market.earnedOffline[listingChanges[processedIndex].player] +
                                            listingChanges[processedIndex].total
                                end
                                if listingChanges[processedIndex].count < processedListing.count then
                                    processedListing.count = processedListing.count - listingChanges[processedIndex].count
                                else
                                    itemListings[listingChanges[processedIndex].player][listingChanges[processedIndex].index] = nil
                                    if tableHelper.isEmpty(itemListings[listingChanges[processedIndex].player]) then
                                        itemListings[listingChanges[processedIndex].player] = nil
                                    end
                                    if tableHelper.isEmpty(WorldInstance.data.market[item.refId]) then
                                        WorldInstance.data.market[item.refId] = nil
                                    end
                                end
                            end
                            WorldInstance:Save()
                            
                        else
                            Players[pid]:Message("Listing(s) changed try again\n")
                        end
                        
                    else
                        Players[pid]:Message("Not enough gold\n")
                    end
                end
			end	
end
end
				
				
				
-------In eventHandler.lua in the OnGUIAction function after Players[pid]:Message("You have successfully logged in.\n") add this-------
-- display how much they earned while offline
JersServerMarket.finishLogin = function(eventStatus, pid)
if eventStatus.validCustomHandlers then --check if some other script made this event obsolete
                    if WorldInstance.data.market ~= nil and
                    WorldInstance.data.market.earnedOffline ~= nil and
                    WorldInstance.data.market.earnedOffline[Players[pid].data.login.name] ~= nil then
                        Players[pid]:Message("Earned " .. WorldInstance.data.market.earnedOffline[Players[pid].data.login.name] .. " in Market while offline\n")
                        WorldInstance.data.market.earnedOffline[Players[pid].data.login.name] = nil
                        WorldInstance:Save()
                    end
end
end

customEventHooks.registerHandler("OnPlayerFinishLogin", JersServerMarket.finishLogin)
customEventHooks.registerHandler("OnGUIAction", JersServerMarket.OnGUIAction)
customEventHooks.registerValidator("OnPlayerInventory", JersServerMarket.onInventory)
customEventHooks.registerValidator("OnContainer", JersServerMarket.onContainer)
customCommandHooks.registerCommand("market", JersServerMarket.cmd)
			
		