--[[
WorldMining.lua by DiscorPeter, RickOff

]]

tableHelper = require("tableHelper")
logicHandler = require("logicHandler")
jsonInterface = require("jsonInterface")

local config = {}
config.whitelist = false --If true, the player must be given permission to place items in the cell that they're in (set using this script's methods, or editing the world.json). Note that this only prevents placement, players can still move/remove items they've placed in the cell.
config.sellbackModifier = 1.25 -- The base cost that an item is multiplied by when selling the items back (0.75 is 75%)
config.MainMenu = "menu player" -- change to your main menu
config.MinerTools = "miner's pick"
config.LumberTools = "iron battle axe"
--GUI Ids used for the script's GUIs. Shouldn't have to be edited.
config.MainGUI = 91363
config.BuyGUI = 91364
config.InventoryGUI = 91365
config.ViewGUI = 91366
config.InventoryOptionsGUI = 91367
config.ViewOptionsGUI = 91368

local message = {}
message.Tools = color.White.."You need an  "..color.Red.."tool "..color.White.."to work on that."
message.Pick = color.White.."You need an "..color.Red.."miners pick "..color.White.."to get this item"
message.Axe = color.White.."You need an "..color.Red.."iron battle axe "..color.White.."to get those items"
message.Rock = color.White.."You got an item of"..color.Red.."rock "..color.White.."in your inventory."
message.Flore = color.White.."You got an item of "..color.Red.."flora "..color.White.."in your inventory."
message.WaitJail = color.White.."You are in prison for  "..color.Red.."5 "..color.White.."minutes."
message.StopJail = color.White.."your time of "..color.Red.."prison "..color.White.."is over."
message.NoBuy = color.White.."you cant buy this"
message.Buy = color.White.." is bought and placed in your inventory"
message.SelectBuy = color.White.."Select sth to buy"
message.SelectFurnInv = color.White.."Select an item with which you want to do things"
message.AddMaterial = color.White.."this item is in your inventory"
message.NoPerm = color.White.."you dont have permission to place"
message.PlaceFurn = color.White.."Select some furn to place"
message.SellFurn = color.White.."this will be sold "
message.UnFurn = color.White.."This cant be done"
message.AddFurn = color.White.." is now in your inventory"
message.SelectFurn = color.White.."Use /dh to move it"
message.InvOption = "Place;Sell;Back" 
message.ViewOption = "Select;Put back;Sell;Back"
message.ChooseDoor = color.White.."Choose one of your doors"
message.OnBuild = color.White.."Choose an Option"
message.OnBuildOption = "Creatures;Furn;Furn2;Dungeon;Rocks;Plants;Ext;Statics;Doors;Back"
message.WhereDoor = "where should this door go?"
message.WelcomeFurn = color.Green.."Welcome at Worldmining.\n\n"..color.Yellow.."Construction "..color.White.."to buy your objects you need and place doors\n\n"..color.Yellow.."Inventory "..color.White.."to see the things you can place\n\n"..color.Yellow.."Stock "..color.White.."to see all the things you placed\n\n"
message.MainChoice = "Inventory;Stock;Construction;Material;Back"
message.MyDoor = "New Door;One of my others;Delete Door;Back"
message.NoCraft = "You dont have enough rock or wood\n"
message.CraftOption = "Fabricate;Back"
message.Wood = "Wood: "
message.Stone = "Stone: "
message.Hardware = "Materials: "
message.ItemName = "Item: " 
message.Gold = "Gold: "
message.Numbers = "Numbers: "
message.Price = "Price: "
message.Count = "Count: "
message.Return = "* Back *\n"

local craftTableRock = {}
local craftTableFlora = {}
local craftTable = {}
local furnitureData = {}

local furnLoader = jsonInterface.load("npc.json")
for index, item in pairs(furnLoader) do
	table.insert(furnitureData, {name = item.name, refId = item.id, material = item.material, price = item.price, tip = "npc", need = "spawn"})
end

local furnLoader = jsonInterface.load("creature.json")
for index, item in pairs(furnLoader) do
	table.insert(furnitureData, {name = item.name, refId = item.id, material = item.material, price = item.price, tip = "creature", need = "spawn"} )
end

local furnLoader = jsonInterface.load("cave.json")
for index, item in pairs(furnLoader) do
	table.insert(furnitureData, {name = item.id, refId = item.id, material = item.material, price = item.price, tip = "dungeon", need = "place"} )
end

local furnLoader = jsonInterface.load("furn.json")
for index, item in pairs(furnLoader) do
	table.insert(furnitureData, {name = item.id, refId = item.id, material = item.material, price = item.price, tip = "furn", need = "place"} )
end

local furnLoader = jsonInterface.load("exterior.json")
for index, item in pairs(furnLoader) do
	table.insert(furnitureData, {name = item.id, refId = item.id, material = item.material, price = item.price, tip = "exterior", need = "place"} )
end

local furnLoader = jsonInterface.load("static.json")
for index, item in pairs(furnLoader) do
	table.insert(furnitureData, {name = item.id, refId = item.id, material = item.material, price = item.price, tip = "static", need = "place"} )
end

local rocksLoader = jsonInterface.load("rocks.json")
for index, item in pairs(rocksLoader) do
	table.insert(craftTableRock, {name = item.id, refId = item.id, material = item.material, price = item.price, tip = "rocks"})
	table.insert(craftTable, {name = item.id, refId = item.id, material = item.material, price = item.price, tip = "rocks"})
	table.insert(furnitureData, {name = item.id, refId = item.id, material = item.material, price = item.price, tip = "rocks", need = "place"} )
end

local floreLoader = jsonInterface.load("flora.json")
for index, item in pairs(floreLoader) do
	table.insert(craftTableFlora, {name = item.id, refId = item.id, material = item.material, price = item.price, tip = "flora"})
	table.insert(craftTable, {name = item.id, refId = item.id, material = item.material, price = item.price, tip = "flora"})
	table.insert(furnitureData, {name = item.id, refId = item.id, material = item.material, price = item.price, tip = "flora", need = "place"} )
end

local WorldMining = {}
--Forward declarations:
local showMainGUI, showBuyGUI, showInventoryGUI, showViewGUI, showInventoryOptionsGUI, showViewOptionsGUI
------------
local playerBuyOptions = {}
local playerInventoryOptions = {} --
local playerInventoryChoice = {}
local playerViewOptions = {}
local playerViewChoice = {}

-- MAIN
showMainGUI = function(pid)
	local count = {terrain = 0, flora = 0, material = 0}

	local index = inventoryHelper.getItemIndex(Players[pid].data.inventory, "crafttree")
	if index ~= nil then count.flora = Players[pid].data.inventory[index].count end

	local index2 = inventoryHelper.getItemIndex(Players[pid].data.inventory, "craftrock")
	if index2 ~= nil then count.terrain = Players[pid].data.inventory[index2].count end
	
	local index3 = inventoryHelper.getItemIndex(Players[pid].data.inventory, "material")
	if index3 ~= nil then count.material = Players[pid].data.inventory[index3].count end
	
	local msg = message.WelcomeFurn
	local msgCustom = msg.."\n"..color.Yellow..message.Wood..color.White..count.flora.."    "..color.Yellow..message.Stone..color.White..count.terrain.."    "..color.Yellow..message.Hardware..color.White..count.material 
	tes3mp.CustomMessageBox(pid, config.MainGUI, msgCustom, message.MainChoice)
end

onMainBuy = function(pid)
	showBuyGUI(pid)
end

onMainInventory = function(pid)
	showInventoryGUI(pid)
end

onMainView = function(pid)
	showViewGUI(pid)
end

WorldMining.OnGUIActionDecide = function(eventStatus, pid, idGui, data)
WorldMining.OnGUIAction(eventStatus, pid, idGui, data)
return customEventHooks.makeEventStatus(true, true)
end

-- GENERAL
WorldMining.OnGUIAction = function(eventStatus, pid, idGui, data)
	
	if idGui == config.MainGUI then -- Main
		if tonumber(data) == 0 then -- Inventory
			onMainInventory(pid)
			return true
		elseif tonumber(data) == 1 then -- View
			onMainView(pid)
			return true
		elseif tonumber(data) == 2 then -- Craft
			WorldMining.OnBuild(pid, "nix")
			return true
		elseif tonumber(data) == 3 then -- Material
			WorldMining.OnCraftCommand(pid, "nix")
			return true
		elseif tonumber(data) == 4 then -- Return Main Menu
			Players[pid].currentCustomMenu = config.MainMenu
			menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)	
			return true
		end
	elseif idGui == config.BuyGUI then -- Buy
		if tonumber(data) == 0 or tonumber(data) == 18446744073709551615 then --Close/Nothing Selected
			--Do nothing return 
			return showMainGUI(pid)
		else
			onBuyChoice(pid, tonumber(data))
			showMainGUI(pid)
			return true
		end
	elseif idGui == config.InventoryGUI then --Inventory main
		if tonumber(data) == 0 or tonumber(data) == 18446744073709551615 then --Close/Nothing Selected
			--Do nothing return
			return showMainGUI(pid)
		else
			onInventoryChoice(pid, tonumber(data))
			return true
		end
	elseif idGui == config.InventoryOptionsGUI then --Inventory options
		if tonumber(data) == 0 then --Place
			onInventoryOptionPlace(pid)
			return true
		elseif tonumber(data) == 1 then --Sell
			onInventoryOptionSell(pid)
			return true
		else 
			--Do nothing return
			return showMainGUI(pid)
		end
	elseif idGui == config.ViewGUI then --View
		if tonumber(data) == 0 or tonumber(data) == 18446744073709551615 then --Close/Nothing Selected
			--Do nothing return
			return showMainGUI(pid)
		else
			onViewChoice(pid, tonumber(data))
			return true
		end
	elseif idGui == config.ViewOptionsGUI then -- View Options
		if tonumber(data) == 0 then --Select
			onViewOptionSelect(pid)
			return true
		elseif tonumber(data) == 1 then --Put away
			onViewOptionPutAway(pid)
		elseif tonumber(data) == 2 then --Sell
			onViewOptionSell(pid)
		else 
			--Do nothing return
			return showMainGUI(pid)
		end
	elseif idGui == 1334 then
		if tonumber(data) == 0 then
			WorldMining.showBuyGUIall(pid,"creature")
		elseif tonumber(data) == 1 then
			WorldMining.showBuyGUIall(pid,"npc")
		elseif tonumber(data) == 2 then
			WorldMining.showBuyGUIall(pid,"furn")
		elseif tonumber(data) == 3 then
			WorldMining.showBuyGUIall(pid,"dungeon")
		elseif tonumber(data) == 4 then
			WorldMining.showBuyGUIall(pid,"rocks")
		elseif tonumber(data) == 5 then
			WorldMining.showBuyGUIall(pid,"flora")
		elseif tonumber(data) == 6 then
			WorldMining.showBuyGUIall(pid,"exterior")
		elseif tonumber(data) == 7 then
			WorldMining.showBuyGUIall(pid,"static")
		elseif tonumber(data) == 8 then -- door
			tes3mp.CustomMessageBox(pid, 1335, message.WhereDoor, message.MyDoor, message.Return)
		elseif tonumber(data) == 9 then -- return
			return showMainGUI(pid)
		end
	elseif idGui == 1335 then
		if tonumber(data) == 0 then --new door dungeon
			newDungeon(pid)
		elseif tonumber(data) == 1 then --create exist door
			toDoor(pid)
		elseif tonumber(data) == 2 then -- delete exist door
			DeleteDoor(pid)
		elseif tonumber(data) == 3 then -- return
			return WorldMining.OnBuild(pid, "nix")
		end
	elseif idGui == 1336 then
		if Players[pid].DoorOptions[tonumber(data)] ~= nil then
			toDoorSecond(pid, tonumber(data))
		else
			print("error with dooroptions")
		end
	elseif idGui == 1337 then
		if Players[pid].DoorOptions[tonumber(data)] ~= nil then
			toDeleteDoor(pid, tonumber(data))
		else
			print("error with dooroptions")
		end		
	elseif idGui == 1338 then
		if tonumber(data) == 0 then
			craft(pid)
		elseif tonumber(data) == 1 then
			return WorldMining.OnBuild(pid, "nix")
		end
	end
end

--all, normal, dungeon, npc, creature, rocks, furn, flora, exterior, static,
WorldMining.OnCommand = function(pid, cmd)
	showMainGUI(pid)
end

WorldMining.OnBuild = function(pid, cmd)
	tes3mp.CustomMessageBox(pid, 1334, message.OnBuild, message.OnBuildOption)
end

newDungeon = function(pid) --just create some doors in interiors
	local interiors = jsonInterface.load("exampleInteriors.json")
	local dungeonCell
	local counter = 0
	local currentCell = tes3mp.GetCell(pid)
	local pname = getName(pid)
	-- on interior get necessary variables
	-- choose any interior
	-- if player is in interior take this one
	if tes3mp.IsInExterior(pid) == false then
		dungeonCell = tes3mp.GetCell(pid)
	else
		-- else choose from list --make a good example list
		-- get the one with smallest dungeonCount from example list
		for index, item in pairs(interiors) do
			if item.dungeonCount < counter or counter == 0 then
				counter = item.dungeonCount
				dungeonCell = index
			end
		end
	end

	-- save which examples have been taken how many times
	-- increase dungeoncount
	if interiors[dungeonCell] == nil then interiors[dungeonCell] = {} end
	if interiors[dungeonCell].dungeonCount == nil then
		interiors[dungeonCell].dungeonCount = 1
	else
		interiors[dungeonCell].dungeonCount = interiors[dungeonCell].dungeonCount + 1
	end
	-- save interiors json back inter
	jsonInterface.save("exampleInteriors.json", interiors)
	--now we got a cell for it
	-- get location in that cell
	local Ilse = interiors[dungeonCell].dungeonCount + 1
	local dungeonLocation = {posX = 0, posY = 0, posZ = 100000 * Ilse,  rotX = 0, rotY = 0, rotZ= 0 }	
	--save door into json for OnActivate
	--save loc
	local pPos = {posX = tes3mp.GetPosX(pid), posY = tes3mp.GetPosY(pid), posZ = tes3mp.GetPosZ(pid),  rotX = tes3mp.GetRotX(pid), rotY = 0, rotZ= tes3mp.GetRotZ(pid) }
	--save door with loc and owner into json
	--plus desination
	myDoor = {location = pPos, owner = pname, destination = {cell = dungeonCell, location = dungeonLocation}}	
	local doors = jsonInterface.load("createdDoors.json")
	if doors[currentCell] == nil then doors[currentCell] = {} end
	table.insert(doors[currentCell], myDoor)
	jsonInterface.save("createdDoors.json", doors)
	--spawn door 
	local furnRefIndex = placeFurniture("ex_nord_door_01", myDoor.location, currentCell, "place")	--Update the database of all placed furniture
	-- save to all placed ones
	addPlaced(furnRefIndex, currentCell, pname, "ex_nord_door_01", true, myDoor.location, "place")
	--Set the placed item as the player's active object for decorateHelpVariation to use
	-- dont do this since we spawn him in new cell instead
	--decorateHelpVariation.SetSelectedObject(pid, furnRefIndex)
	--spawn plate in this cell
	local furnRefIndex = placeFurniture("ex_de_docks_end", dungeonLocation, dungeonCell, "place")	--Update the database of all placed furniture
	-- save to all placed ones
	addPlaced(furnRefIndex, dungeonCell, pname, "ex_de_docks_end", true, dungeonLocation, "place")
	--Set the placed item as the player's active object for decorateHelpVariation to use
	decorateHelpVariation.SetSelectedObject(pid, furnRefIndex)
	--spawn player on top of plate	
	tes3mp.SetCell(pid, dungeonCell)
	tes3mp.SendCell(pid)
	tes3mp.SetPos(pid, dungeonLocation.posX, dungeonLocation.posY, dungeonLocation.posZ + 10)
	tes3mp.SetRot(pid, 0, 0)
	tes3mp.SendPos(pid)	
	-- send fancy message
end
	
toDoor = function(pid)
	--on players door.
	--check json for a list of existing doors
	local doors = jsonInterface.load("createdDoors.json")
	
	local list = ""
	local count = 0
	local pname = getName(pid)
	Players[pid].DoorOptions = {}
	
	for cell, item2 in pairs(doors) do
		for index, item in pairs(item2) do
			if item.owner == pname then
				Players[pid].DoorOptions[count] = {cell = cell, loc = item.location}
				count = count + 1
				list = list.."Door in Cell "..cell.."\n"
			end
		end
	end
	
	tes3mp.ListBox(pid, 1336, message.ChooseDoor, list)
end

toDoorSecond = function(pid, data)	

	-- get old door
	local chosen = Players[pid].DoorOptions[data]
	local chosenCell = chosen.cell
	local chosenLoc = chosen.loc
	local currentCell = tes3mp.GetCell(pid)
	local pname = getName(pid)
	local doors = jsonInterface.load("createdDoors.json")

	--save new door into json for OnActivate
	--save loc
	local pPos = {posX = tes3mp.GetPosX(pid), posY = tes3mp.GetPosY(pid), posZ = tes3mp.GetPosZ(pid),  rotX = tes3mp.GetRotX(pid), rotY = 0, rotZ= tes3mp.GetRotZ(pid) }

	--save door with loc and owner into json
	--plus desination
	myDoor = {location = pPos, owner = pname, destination = {cell = chosenCell, location = chosenLoc}}

	if doors[currentCell] == nil then doors[currentCell] = {} end
	table.insert(doors[currentCell], myDoor)
	jsonInterface.save("createdDoors.json", doors)


	--spawn new door
	local furnRefIndex = placeFurniture("ex_nord_door_01", myDoor.location, currentCell, "place")	--Update the database of all placed furniture
	-- save to all placed ones
	addPlaced(furnRefIndex, currentCell, pname, "ex_nord_door_01", true, myDoor.location, "place")
	--Set the placed item as the player's active object for decorateHelpVariation to use
	-- dont do this since we spawn him in new cell instead
	--decorateHelpVariation.SetSelectedObject(pid, furnRefIndex)
	decorateHelpVariation.SetSelectedObject(pid, furnRefIndex)	
	--fancy message
	
end

DeleteDoor = function(pid)
	--on players door.
	--check json for a list of existing doors
	local doors = jsonInterface.load("createdDoors.json")
	
	local list = ""
	local count = 0
	local pname = getName(pid)
	Players[pid].DoorOptions = {}
	
	for cell, item2 in pairs(doors) do
		for index, item in pairs(item2) do
			if item.owner == pname then
				Players[pid].DoorOptions[count] = {cell = cell, loc = item.location}
				count = count + 1
				list = list.."Door in Cell "..cell.."\n"
			end
		end
	end
	
	tes3mp.ListBox(pid, 1337, message.ChooseDoor, list)
end

toDeleteDoor = function(pid, data)

	-- get old door
	local chosen = Players[pid].DoorOptions[data]
	local chosenCell = chosen.cell
	local CellLower = string.lower(chosen.cell)
	local chosenLoc = chosen.loc
	local pname = getName(pid)
	local doors = jsonInterface.load("createdDoors.json")
	--delete door into createddoor.json
	for x, y in pairs(doors[chosenCell]) do
		if doors[chosenCell][x].owner == pname then --location de not match 
			doors[chosenCell][x] = nil
		end
	end	
	jsonInterface.save("createdDoors.json", doors)
	
	local placed = getPlacedTable()
	local cInfo = placed[CellLower]	
	--delete door into World.json
	--delete door into Cell.json
	for refIndex, info in pairs(cInfo) do
		if info.owner == pname and info.refId == "ex_nord_door_01" then
			removeFurniture(refIndex, CellLower)
			removePlaced(refIndex, CellLower, false)
		end
	end
	WorldInstance:Save()
end

-- ===========
--  DATA ACCESS
-- ===========

getFurnitureInventoryTable = function()
	return WorldInstance.data.customVariables.WorldMining.inventories
end

getPermissionsTable = function()
	return WorldInstance.data.customVariables.WorldMining.permissions
end

getPlacedTable = function()
	return WorldInstance.data.customVariables.WorldMining.placed
end

addPlaced = function(refIndex, cell, pname, refId, save, pPos, packetType)
	local placed = getPlacedTable()
	
	if not placed[cell] then
		placed[cell] = {}
	end
	
	placed[cell][refIndex] = {owner = pname, refId = refId, loc = pPos, need = packetType}
	
	if save then
		WorldInstance:Save()
	end
end

removePlaced = function(refIndex, cell, save)
	local placed = getPlacedTable()
	
	placed[cell][refIndex] = nil
	
	if save then
		WorldInstance:Save()
	end
end

getPlaced = function(cell)
	local placed = getPlacedTable()
	
	if placed[cell] then
		return placed[cell]
	else
		return false
	end
end

addFurnitureItem = function(pname, refId, count, save)
	local fInventories = getFurnitureInventoryTable()
	
	if fInventories[pname] == nil then
		fInventories[pname] = {}
	end
	
	fInventories[pname][refId] = (fInventories[pname][refId] or 0) + (count or 1)
	
	--Remove the entry if the count is 0 or less (so we can use this function to remove items, too!)
	if fInventories[pname][refId] <= 0 then
		fInventories[pname][refId] = nil
	end
	
	if save then
		WorldInstance:Save()
	end
end

WorldMining.OnServerPostInit = function(eventStatus)
	--Create the script's required data if it doesn't exits
	if WorldInstance.data.customVariables.WorldMining == nil then
		WorldInstance.data.customVariables.WorldMining = {}
		WorldInstance.data.customVariables.WorldMining.placed = {}
		WorldInstance.data.customVariables.WorldMining.permissions = {}
		WorldInstance.data.customVariables.WorldMining.inventories = {}
		WorldInstance:Save()
	end
	
	--Slight Hack for updating pnames to their new values. In release 1, the script stored player names as their login names, in release 2 it stores them as their all lowercase names.
	local placed = getPlacedTable()
	for cell, v in pairs(placed) do
		for refIndex, v in pairs(placed[cell]) do
			placed[cell][refIndex].owner = string.lower(placed[cell][refIndex].owner)
		end
	end
	local permissions = getPermissionsTable()
		
	for cell, v in pairs(permissions) do
		local newNames = {}
		
		for pname, v in pairs(permissions[cell]) do
			table.insert(newNames, string.lower(pname))
		end
		
		permissions[cell] = {}
		for k, newName in pairs(newNames) do
			permissions[cell][newName] = true
		end
	end
	
	local inventories = getFurnitureInventoryTable()
	local newInventories = {}
	for pname, invData in pairs(inventories) do
		newInventories[string.lower(pname)] = invData
	end
	
	WorldInstance.data.customVariables.WorldMining.inventories = newInventories
	
	WorldInstance:Save()
end

-------------------------

getName = function(pid)
	--return Players[pid].data.login.name
	--Release 2 change: Now uses all lowercase name for storage
	return string.lower(Players[pid].accountName)
end

getObject = function(refIndex, cell)
	if refIndex == nil then
		return false
	end
	
	if not LoadedCells[cell] then
		--TODO: Should ideally be temporary
		logicHandler.LoadCell(cell)
	end

	if LoadedCells[cell]:ContainsObject(refIndex)  then 
		return LoadedCells[cell].data.objectData[refIndex]
	else
		return false
	end	
end

--Returns the amount of count in a player's inventory

getPlayerGold = function(pid)
	local goldPlayer = inventoryHelper.getItemIndex(Players[pid].data.inventory, "gold_001", -1)
	
	if goldPlayer then
		return Players[pid].data.inventory[goldPlayer].count
	else
		return 0
	end
end

addGold = function(pid, amount)
	--TODO: Add functionality to add gold to offline player's inventories, too
	local goldPlayer = inventoryHelper.getItemIndex(Players[pid].data.inventory, "gold_001", -1)

	if goldPlayer then
		Players[pid].data.inventory[goldPlayer].count = Players[pid].data.inventory[goldPlayer].count + amount
	else
		table.insert(Players[pid].data.inventory, {refId = "gold_001", count = amount, charge = -1})
	end
	
	Players[pid]:Save()
	local itemref = {refId = "gold_001", count = amount, charge = -1}	
	Players[pid]:LoadItemChanges({itemref}, enumerations.inventory.ADD)	
end

removeGold = function(pid, amount)
	--TODO: Add functionality to add gold to offline player's inventories, too
	local goldPlayer = inventoryHelper.getItemIndex(Players[pid].data.inventory, "gold_001", -1)
	
	if goldPlayer then
		Players[pid].data.inventory[goldPlayer].count = Players[pid].data.inventory[goldPlayer].count - amount
	end
	
	Players[pid]:Save()
	local itemref = {refId = "gold_001", count = amount, charge = -1}	
	Players[pid]:LoadItemChanges({itemref}, enumerations.inventory.REMOVE)	
end


getPlayerMaterial = function(pid)
	local locMaterial = inventoryHelper.getItemIndex(Players[pid].data.inventory, "material", -1)
	
	if locMaterial then
		return Players[pid].data.inventory[locMaterial].count
	else
		return 0
	end
end

addMaterial = function(pid, amount)
	--TODO: Add functionality to add gold to offline player's inventories, too
	local locMaterial = inventoryHelper.getItemIndex(Players[pid].data.inventory, "material", -1)

	if locMaterial then
		Players[pid].data.inventory[locMaterial].count = Players[pid].data.inventory[locMaterial].count + amount
	else
		table.insert(Players[pid].data.inventory, {refId = "material", count = amount, charge = -1})
	end
	
	Players[pid]:Save()
	local itemref = {refId = "material", count = amount, charge = -1}	
	Players[pid]:LoadItemChanges({itemref}, enumerations.inventory.ADD)	
end

removeMaterial = function(pid, amount)
	--TODO: Add functionality to add gold to offline player's inventories, too
	local goldMaterial = inventoryHelper.getItemIndex(Players[pid].data.inventory, "material", -1)
	
	if goldMaterial then
		Players[pid].data.inventory[goldMaterial].count = Players[pid].data.inventory[goldMaterial].count - amount
	end
	
	Players[pid]:Save()
	local itemref = {refId = "material", count = amount, charge = -1}	
	Players[pid]:LoadItemChanges({itemref}, enumerations.inventory.REMOVE)	
end

getFurnitureData = function(refId)
	local location = tableHelper.getIndexByNestedKeyValue(furnitureData, "refId", refId)
	if location then
		return furnitureData[location], location
	else
		return false
	end
end

hasPlacePermission = function(pname, cell)
	local perms = getPermissionsTable()
	
	if not config.whitelist then
		return true
	end
	
	if perms[cell] then
		if perms[cell]["all"] or perms[cell][pname] then
			return true
		else
			return false
		end
	else
		--There's not even any data for that cell
		return false
	end
end

getPlayerFurnitureInventory = function(pid)
	local invlist = getFurnitureInventoryTable()
	local pname = getName(pid)
	
	if invlist[pname] == nil then
		invlist[pname] = {}
		WorldInstance:Save()
	end
	
	return invlist[pname]
end

getSortedPlayerFurnitureInventory = function(pid)
	local inv = getPlayerFurnitureInventory(pid)
	local sorted = {}
	
	for refId, amount in pairs(inv) do
		local name = getFurnitureData(refId).name
		table.insert(sorted, {name = name, count = amount, refId = refId})
	end
	
	return sorted
end

placeFurniture = function(refId, loc, cell, packetType)
	local mpNum = WorldInstance:GetCurrentMpNum() + 1	
	local location = {
		posX = loc.posX, posY = loc.posY, posZ = loc.posZ,
		rotX = 0, rotY = 0, rotZ = 0
	}
	local refIndex =  0 .. "-" .. mpNum
	
	WorldInstance:SetCurrentMpNum(mpNum)
	tes3mp.SetCurrentMpNum(mpNum)
	
	if not LoadedCells[cell] then
		--TODO: Should ideally be temporary
		logicHandler.LoadCell(cell)
	end

	LoadedCells[cell]:InitializeObjectData(refIndex, refId)
	LoadedCells[cell].data.objectData[refIndex].location = location
	table.insert(LoadedCells[cell].data.packets.place, refIndex)
	
    if packetType == "place" then
        table.insert(LoadedCells[cell].data.packets.place, refIndex)
    elseif packetType == "spawn" then
        table.insert(LoadedCells[cell].data.packets.spawn, refIndex)
        table.insert(LoadedCells[cell].data.packets.actorList, refIndex)
    end

	for onlinePid, player in pairs(Players) do
		if player:IsLoggedIn() then
			tes3mp.InitializeEvent(onlinePid)
			tes3mp.SetEventCell(cell)
			tes3mp.SetObjectRefId(refId)
			tes3mp.SetObjectRefNumIndex(0)
			tes3mp.SetObjectMpNum(mpNum)
			tes3mp.SetObjectPosition(location.posX, location.posY, location.posZ)
			tes3mp.SetObjectRotation(location.rotX, location.rotY, location.rotZ)
			tes3mp.AddWorldObject()	
			if packetType == "place" then
				tes3mp.SendObjectPlace(true)
			elseif packetType == "spawn" then
				tes3mp.SendObjectSpawn(true)
			end
		end
	end
	
	LoadedCells[cell]:Save()
	
	return refIndex
end

removeFurniture = function(refIndex, cell)
	--If for some reason the cell isn't loaded, load it. Causes a bit of spam in the server log, but that can't really be helped.
	--TODO: Ideally this should only be a temporary load
	if LoadedCells[cell] == nil then
		logicHandler.LoadCell(cell)
	end
	
	if LoadedCells[cell]:ContainsObject(refIndex) and not tableHelper.containsValue(LoadedCells[cell].data.packets.delete, refIndex) then --Shouldn't ever have a delete packet, but it's worth checking anyway
		--Delete the object for all the players currently online
		local splitIndex = refIndex:split("-")
		
		for onlinePid, player in pairs(Players) do
			if player:IsLoggedIn() then
				tes3mp.InitializeEvent(onlinePid)
				tes3mp.SetEventCell(cell)
				tes3mp.SetObjectRefNumIndex(splitIndex[1])
				tes3mp.SetObjectMpNum(splitIndex[2])
				tes3mp.AddWorldObject()
				tes3mp.SendObjectDelete()
			end
		end
		
		LoadedCells[cell]:DeleteObjectData(refIndex)
		LoadedCells[cell]:Save()
		--Removing the object from the placed list will be done elsewhere
	end
end

getAvailableFurnitureStock = function(pid, tip)
	--In the future this can be used to customise what items are available for a particular player, like making certain items only available for things like their race, class, level, their factions, or the quests they've completed. For now, however, everything in furnitureData is available :P
	
	local options = {}
	
	for i = 1, #furnitureData do
		if furnitureData[i].tip == tip or tip == "all" then
			table.insert(options, furnitureData[i])
		end
	end
	
	return options
end

--If the player has placed items in the cell, returns an indexed table containing all the refIndexes of furniture that they have placed.
getPlayerPlacedInCell = function(pname, cell)
	local cellPlaced = getPlaced(cell)
	
	if not cellPlaced then
		-- Nobody has placed items in this cell
		return false
	end
	
	local list = {}
	for refIndex, data in pairs(cellPlaced) do
		if data.owner == pname then
			table.insert(list, refIndex)
		end
	end
	
	if #list > 0 then
		return list
	else
		--The player hasn't placed any items in this cell
		return false
	end
end

addFurnitureData = function(data)
	--Check the furniture doesn't already have an entry, if it does, overwrite it
	--TODO: Should probably check that the data is valid
	local fdata, loc = getFurnitureData(data.refId)
	
	if fdata then
		furnitureData[loc] = data
	else
		table.insert(furnitureData, data)
	end
end

WorldMining.AddFurnitureData = function(data)
	addFurnitureData(data)
end
--NOTE: Both AddPermission and RemovePermission use pname, rather than pid
WorldMining.AddPermission = function(pname, cell)
	local perms = getPermissionsTable()
	
	if not perms[cell] then
		perms[cell] = {}
	end
	
	perms[cell][pname] = true
	WorldInstance:Save()
end

WorldMining.RemovePermission = function(pname, cell)
	local perms = getPermissionsTable()
	
	if not perms[cell] then
		return
	end
	
	perms[cell][pname] = nil
	
	WorldInstance:Save()
end

WorldMining.RemoveAllPermissions = function(cell)
	local perms = getPermissionsTable()
	
	perms[cell] = nil
	WorldInstance:Save()
end

WorldMining.RemoveAllPlayerFurnitureInCell = function(pname, cell, returnToOwner)
	local placed = getPlacedTable()
	local cInfo = placed[cell] or {}
	
	for refIndex, info in pairs(cInfo) do
		if info.owner == pname then
			if returnToOwner then
				addFurnitureItem(info.owner, info.refId, 1, false)
			end
			removeFurniture(refIndex, cell)
			removePlaced(refIndex, cell, false)
		end
	end
	WorldInstance:Save()
end

WorldMining.RemoveAllFurnitureInCell = function(cell, returnToOwner)
	local placed = getPlacedTable()
	local cInfo = placed[cell] or {}
	
	for refIndex, info in pairs(cInfo) do
		if returnToOwner then
			addFurnitureItem(info.owner, info.refId, 1, false)
		end
		removeFurniture(refIndex, cell)
		removePlaced(refIndex, cell, false)
	end
	WorldInstance:Save()
end

--Change the ownership of the specified furniture object (via refIndex) to another character's (playerToName). If playerCurrentName is false, the owner will be changed to the new one regardless of who owned it first.
WorldMining.TransferOwnership = function(refIndex, cell, playerCurrentName, playerToName, save)
	local placed = getPlacedTable()
	
	if placed[cell] and placed[cell][refIndex] and (placed[cell][refIndex].owner == playerCurrentName or not playerCurrentName) then
		placed[cell][refIndex].owner = playerToName
	end
	
	if save then
		WorldInstance:Save()
	end
	
	--Unset the current player's selected item, just in case they had that furniture as their selected item
	if playerCurrentName and logicHandler.IsPlayerNameLoggedIn(playerCurrentName) then
		decorateHelpVariation.SetSelectedObject(logicHandler.GetPlayerByName(playerCurrentName).pid, "")
	end
end

--Same as TransferOwnership, but for all items in a given cell
WorldMining.TransferAllOwnership = function(cell, playerCurrentName, playerToName, save)
	local placed = getPlacedTable()
	
	if not placed[cell] then
		return false
	end
	
	for refIndex, info in pairs(placed[cell]) do
		if not playerCurrentName or info.owner == playerCurrentName then
			placed[cell][refIndex].owner = playerToName
		end
	end
	
	if save then
		WorldInstance:Save()
	end
	
	--Unset the current player's selected item, just in case they had any of the furniture as their selected item
	if playerCurrentName and logicHandler.IsPlayerNameLoggedIn(playerCurrentName) then
		decorateHelpVariation.SetSelectedObject(logicHandler.GetPlayerByName(playerCurrentName).pid, "")
	end
end

--New Release 2 WorldMining:
WorldMining.GetBackPrice = function(value)
	return getSellValue(value)
end

WorldMining.GetFurnitureDataByRefId = function(refId)
	return getFurnitureData(refId)
end

WorldMining.GetPlacedInCell = function(cell)
	return getPlaced(cell)
end

-- VIEW (OPTIONS)
showViewOptionsGUI = function(pid, loc)
	local choice = playerViewOptions[getName(pid)][loc]
	local fdata = getFurnitureData(choice.refId)
	
	local msg = color.Yellow..message.ItemName..color.White..fdata.name..color.Yellow.." (RefIndex: "..color.White..choice.refIndex..")."
	
	playerViewChoice[getName(pid)] = choice
	tes3mp.CustomMessageBox(pid, config.ViewOptionsGUI, msg, message.ViewOption)
end

onViewOptionSelect = function(pid)
	local pname = getName(pid)
	local choice = playerViewChoice[pname]
	local cell = tes3mp.GetCell(pid)
	
	if getObject(choice.refIndex, cell) then
		decorateHelpVariation.SetSelectedObject(pid, choice.refIndex)
		tes3mp.MessageBox(pid, -1, message.SelectFurn)
	else
		tes3mp.MessageBox(pid, -1, message.UnFurn)
	end
end

onViewOptionPutAway = function(pid)
	local pname = getName(pid)
	local choice = playerViewChoice[pname]
	local cell = tes3mp.GetCell(pid)
	
	if getObject(choice.refIndex, cell) and choice.refId ~= "ex_nord_door_01" then
		removeFurniture(choice.refIndex, cell)
		removePlaced(choice.refIndex, cell, true)
		
		addFurnitureItem(pname, choice.refId, 1, true)
		tes3mp.MessageBox(pid, -1, getFurnitureData(choice.refId).name .. message.AddFurn)
	else
		tes3mp.MessageBox(pid, -1, message.UnFurn)
	end
end

onViewOptionSell = function(pid)
	local pname = getName(pid)
	local choice = playerViewChoice[pname]
	local cell = tes3mp.GetCell(pid)
	local price
	local material
	for x, y in pairs(furnitureData) do
		if furnitureData[x].refId == choice.refId then
			price = math.floor(tonumber((furnitureData[x].price) / config.sellbackModifier))
			material = math.floor(tonumber((furnitureData[x].material) / config.sellbackModifier))
			break
		end
	end
	if getObject(choice.refIndex, cell) and choice.refId ~= "ex_nord_door_01" then
		if price > 0 then
			addGold(pid, price)
		end
		if material > 0 then
			addMaterial(pid, material)
		end
		--Add material to inventory
		--Remove the item from the cell
		removeFurniture(choice.refIndex, cell)
		removePlaced(choice.refIndex, cell, true)
		
		--Inform the player
		tes3mp.MessageBox(pid, -1, message.SellFurn..color.Yellow.." "..message.Gold..color.White..price..color.Yellow.." "..message.Hardware..color.White..material)
	else
		tes3mp.MessageBox(pid, -1, message.UnFurn)
	end
end

-- VIEW (MAIN)
showViewGUI = function(pid)
	local pname = getName(pid)
	local cell = tes3mp.GetCell(pid)
	local options = getPlayerPlacedInCell(pname, cell)
	
	local list = message.Return
	local newOptions = {}
	
	if options and #options > 0 then
		for i = 1, #options do
			--Make sure the object still exists, and get its data
			local object = getObject(options[i], cell)
			
			if object then
				local furnData = getFurnitureData(object.refId)
				
				list = list .. furnData.name .. " (at " .. math.floor(object.location.posX + 0.5) .. ", "  ..  math.floor(object.location.posY + 0.5) .. ", " .. math.floor(object.location.posZ + 0.5) .. ")"
				if not(i == #options) then
					list = list .. "\n"
				end
				
				table.insert(newOptions, {refIndex = options[i], refId = object.refId})
			end
		end
	end
	
	playerViewOptions[pname] = newOptions
	tes3mp.ListBox(pid, config.ViewGUI, message.PlaceFurn, list)
	--getPlayerPlacedInCell(pname, cell)
end

onViewChoice = function(pid, loc)
	showViewOptionsGUI(pid, loc)
end

-- INVENTORY (OPTIONS)
showInventoryOptionsGUI = function(pid, loc)
	local choice = playerInventoryOptions[getName(pid)][loc]
	local fdata = getFurnitureData(choice.refId)	
	local msg = color.Yellow..message.ItemName..color.White..choice.name
	
	playerInventoryChoice[getName(pid)] = choice
	tes3mp.CustomMessageBox(pid, config.InventoryOptionsGUI, msg, message.InvOption)
end

onInventoryOptionPlace = function(pid)
	local pname = getName(pid)
	local curCell = tes3mp.GetCell(pid)
	local choice = playerInventoryChoice[pname]
	
	--First check the player is allowed to place items where they are currently
	if config.whitelist and not hasPlacePermission(pname, curCell) then
		--Player isn't allowed
		tes3mp.MessageBox(pid, -1, message.NoPerm)
		return false
	end
	
	--Remove 1 instance of the item from the player's inventory
	addFurnitureItem(pname, choice.refId, -1, true)
	
	--Place the furniture in the world
	local pPos = {posX = tes3mp.GetPosX(pid), posY = tes3mp.GetPosY(pid), posZ = tes3mp.GetPosZ(pid),  rotX = tes3mp.GetRotX(pid), rotY = 0, rotZ= tes3mp.GetRotZ(pid) }
	for index, item in pairs(furnitureData) do
		if item.refId == choice.refId then
			choice.need = item.need
			break
		end
	end
	local furnRefIndex = placeFurniture(choice.refId, pPos, curCell, choice.need)
	
	--Update the database of all placed furniture
	addPlaced(furnRefIndex, curCell, pname, choice.refId, true, pPos, choice.need)
	--Set the placed item as the player's active object for decorateHelpVariation to use
	decorateHelpVariation.SetSelectedObject(pid, furnRefIndex)
end

onInventoryOptionSell = function(pid)
	local pname = getName(pid)
	local choice = playerInventoryChoice[pname]
	local price
	local material
	for x, y in pairs(furnitureData) do
		if furnitureData[x].refId == choice.refId then
			price = math.floor(tonumber((furnitureData[x].price) / config.sellbackModifier))
			material = math.floor(tonumber((furnitureData[x].material) / config.sellbackModifier))
			break
		end
	end
	if price > 0 then
		addGold(pid, price)
	end
	if material > 0 then
		addMaterial(pid, material)
	end
	--Remove 1 instance of the item from the player's inventory
	addFurnitureItem(pname, choice.refId, -1, true)	
	--Inform the player
	tes3mp.MessageBox(pid, -1, message.AddMaterial..color.Yellow.." "..message.Gold..color.White..price..color.Yellow.." "..message.Hardware..color.White..material)
end

-- INVENTORY (MAIN)
showInventoryGUI = function(pid)
	local options = getSortedPlayerFurnitureInventory(pid)
	local list = message.Return
	
	for i = 1, #options do
		list = list..options[i].name..color.Yellow.." "..message.Numbers..color.White..options[i].count
		if not(i == #options) then
			list = list .. "\n"
		end
	end
	
	playerInventoryOptions[getName(pid)] = options
	tes3mp.ListBox(pid, config.InventoryGUI, message.SelectFurnInv, list)
end

onInventoryChoice = function(pid, loc)
	showInventoryOptionsGUI(pid, loc)
end

-- BUY (MAIN)

WorldMining.showBuyGUIall = function(pid, tip)
	local options = getAvailableFurnitureStock(pid, tip)
	local list = message.Return
	if tip == "creature" or tip == "npc" then
		
		for i = 1, #options do
			list = list..options[i].name..color.Yellow.." "..message.Price..color.Default..options[i].price
			if not(i == #options) then
				list = list .. "\n"
			end
		end	
	elseif tip == "furn" or tip == "exterior" or tip == "dungeon" or tip == "static" then	
		for i = 1, #options do
			list = list..options[i].name..color.Yellow.." "..message.Price..color.Default..options[i].price..color.Yellow.." "..message.Hardware..color.White..options[i].material
			if not(i == #options) then
				list = list .. "\n"
			end
		end					
	elseif tip == "rocks" or tip == "flora" then
		for i = 1, #options do
			list = list..options[i].name..color.Yellow.." "..message.Hardware..color.Default..options[i].material
			if not(i == #options) then
				list = list .. "\n"
			end
		end
	end
	playerBuyOptions[getName(pid)] = options
	tes3mp.ListBox(pid, config.BuyGUI, message.SelectBuy, list)
end

onBuyChoice = function(pid, loc)
	local pmaterial = getPlayerMaterial(pid)
	local goldcount = getPlayerGold(pid)
	local choice = playerBuyOptions[getName(pid)][loc]
	local price = tonumber(choice.price)
	local omaterial = tonumber(choice.material)
	if price == nil then price = 0 end
	if omaterial == nil then omaterial = 0 end	
	
	if price > 0 and omaterial == 0 then
		if goldcount < price then
			tes3mp.MessageBox(pid, -1, message.NoBuy .. choice.name .. ".")
			return false
		else
			removeGold(pid, price)
			addFurnitureItem(getName(pid), choice.refId, 1, true)		
		end	
	elseif omaterial > 0 and price == 0 then
		if pmaterial < omaterial then
			tes3mp.MessageBox(pid, -1, message.NoBuy .. choice.name .. ".")
			return false
		else
			removeMaterial(pid, omaterial)
			addFurnitureItem(getName(pid), choice.refId, 1, true)	
		end
	elseif omaterial > 0 and price > 0 then
		if pmaterial < omaterial or goldcount < price then
			tes3mp.MessageBox(pid, -1, message.NoBuy .. choice.name .. ".")
			return false
		elseif pmaterial > omaterial and goldcount < price then
			tes3mp.MessageBox(pid, -1, message.NoBuy .. choice.name .. ".")
			return false
		elseif pmaterial < omaterial and goldcount > price then
			tes3mp.MessageBox(pid, -1, message.NoBuy .. choice.name .. ".")
			return false						
		else
			removeGold(pid, price)		
			removeMaterial(pid, omaterial)
			addFurnitureItem(getName(pid), choice.refId, 1, true)	
		end		
	end
	
	tes3mp.MessageBox(pid, -1, color.Yellow..choice.name..message.Buy..color.Yellow.." "..message.Count..color.White..choice.price..color.Yellow.." "..message.Hardware..color.White..choice.material)
	return true
end

WorldMining.OnHitActivate = function(pid, unique, refId, refNum, mpNum)
	--count to 3 for uniqueId
	local drawState = tes3mp.GetDrawState(pid)

	local itemEquipment = {}
	for x, y in pairs(Players[pid].data.equipment) do
		table.insert(itemEquipment, (Players[pid].data.equipment[x]))
	end
	if tableHelper.containsValue(craftTableRock, refId, true) then
		if drawState == 1 then	
			if tableHelper.containsValue(itemEquipment, config.MinerTools, true) then			
				logicHandler.RunConsoleCommandOnPlayer(pid, "player->say, \"AM/MinerSOund1.wav\", \"\"", false)
				logicHandler.RunConsoleCommandOnPlayer(pid, "player->PlayGroup, PickProbe, 0", false)
				if Players[pid].data.customVariables.craftUnique == nil then
					Players[pid].data.customVariables.craftUnique = unique
					Players[pid].data.customVariables.craftCount = 1
					return true
				elseif Players[pid].data.customVariables.craftUnique == unique then
					if Players[pid].data.customVariables.craftCount < 3 then
						Players[pid].data.customVariables.craftCount = Players[pid].data.customVariables.craftCount + 1
						return true
					else
						-- he hit 3 times get him a rock or tree
						for index, item in pairs(craftTableRock) do
							if string.lower(item.refId) == refId then
								if item.tip == "rocks" then -- should we go over inventory at all, or store just in a table instead?
									inventoryHelper.addItem(Players[pid].data.inventory, "craftrock", 1, -1, -1, "")
									local itemref = {refId = "craftrock", count = 1, charge = -1}	
									Players[pid]:LoadItemChanges({itemref}, enumerations.inventory.ADD)	
								end
								break -- found one match for that inventory item break loop
							end
						end
						objectUniqueIndex = (refNum .. "-" .. mpNum)
						logicHandler.RunConsoleCommandOnObject(pid, "disable", tes3mp.GetCell(pid), objectUniqueIndex, true)
						tes3mp.MessageBox(pid, -1, message.Rock)
						--send fancy message
					end
				else -- if he activated another one
					Players[pid].data.customVariables.craftUnique = unique
					Players[pid].data.customVariables.craftCount = 1
				end
			else
				tes3mp.MessageBox(pid, -1, message.Pick)
			end
		else
			tes3mp.MessageBox(pid, -1, message.Tools)
		end	
		return true
	elseif tableHelper.containsValue(craftTableFlora, refId, true) then
		if drawState == 1 then		
			if tableHelper.containsValue(itemEquipment, config.LumberTools, true) then			
				logicHandler.RunConsoleCommandOnPlayer(pid, "player->say, \"AM/MinerSound2.wav\", \"\"", false)
				logicHandler.RunConsoleCommandOnPlayer(pid, "player->PlayGroup, PickProbe, 0", false)
				if Players[pid].data.customVariables.craftUnique == nil then
					Players[pid].data.customVariables.craftUnique = unique
					Players[pid].data.customVariables.craftCount = 1
				elseif Players[pid].data.customVariables.craftUnique == unique then
					if Players[pid].data.customVariables.craftCount < 3 then
						Players[pid].data.customVariables.craftCount = Players[pid].data.customVariables.craftCount + 1
					else
						-- he hit 3 times get him a rock or tree
						for index, item in pairs(craftTableFlora) do
							if string.lower(item.refId) == refId then
								if item.tip == "flora" then
									inventoryHelper.addItem(Players[pid].data.inventory, "crafttree", 1, -1, -1, "")
									local itemref = {refId = "crafttree", count = 1, charge = -1}	
									Players[pid]:LoadItemChanges({itemref}, enumerations.inventory.ADD)	
								end
								break -- found one match for that inventory item break loop
							end
						end
						objectUniqueIndex = (refNum .. "-" .. mpNum)
						logicHandler.RunConsoleCommandOnObject(pid, "disable", tes3mp.GetCell(pid), objectUniqueIndex, true)
						tes3mp.MessageBox(pid, -1, message.Flore)
						--send fancy message
					end
				else -- if he activated another one
					Players[pid].data.customVariables.craftUnique = unique
					Players[pid].data.customVariables.craftCount = 1
				end
			else
				tes3mp.MessageBox(pid, -1, message.Axe)
			end
		else
			tes3mp.MessageBox(pid, -1, message.Tools)
		end			
		return true
	else
		return false
	end
end

WorldMining.OnObjectDelete = function(pid)
	tes3mp.ReadLastEvent()
	local refId = tes3mp.GetObjectRefId(0)
	local cellId = tes3mp.GetCell(pid)
	local location = {
		posX = tes3mp.GetPosX(pid), posY = tes3mp.GetPosY(pid), posZ = tes3mp.GetPosZ(pid),
		rotX = tes3mp.GetRotX(pid), rotY = 0, rotZ = tes3mp.GetRotZ(pid)
	}
	if tableHelper.containsValue(craftTable, refId, true) then
		local removedCount = 1 -- you need to get the real count th player wants to remove
		local existingIndex = nil				
		for slot, item in pairs(Players[pid].data.inventory) do -- does item exist in inventory
			if Players[pid].data.inventory[slot].refId == refId then
				existingIndex = slot
			end
		end			 
		if existingIndex ~= nil then -- if he got item then change count and or remove 
			local inventoryItem = Players[pid].data.inventory[existingIndex] -- get it for working					
			local itemid = inventoryItem.refId -- save for adding into hdvinv					
			for slot, inv in pairs(Players[pid].data.equipment) do -- does player have item equipped
				if inv.refId == itemid then
					Players[pid].data.equipment[slot] = nil
				end    
			end							
			inventoryItem.count = inventoryItem.count - removedCount					
			if inventoryItem.count < 1 then
				inventoryItem = nil
			end			 
			Players[pid].data.inventory[existingIndex] = inventoryItem -- pack it back
			local itemref = {refId = refId, count = 1, charge = -1}
			Players[pid]:Save()
			Players[pid]:LoadItemChanges({itemref}, enumerations.inventory.REMOVE)
			--logicHandler.CreateObjectAtLocation(cellId, location, refId, "place")			
			Players[pid].currentCustomMenu = "menu avertissement mining"--Avertissement
			menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
			return true
		else
			return true
		end
	else
		return false
	end
end

WorldMining.PunishPrison = function(pid, targetPlayer) -- Used to send a player into the prison
	local targetPlayerName = Players[tonumber(targetPlayer)].name
	local msg = color.Orange .. "SERVER: " .. targetPlayerName .. " goes into prison.\n"
	local cell = "Moonmoth Legion Fort, Prison Towers"
	tes3mp.SetCell(pid, cell)
	tes3mp.SendCell(pid)	
	tes3mp.SetPos(pid, 756, 2560, -383)
	tes3mp.SetRot(pid, 0, 0)
	tes3mp.SendPos(pid)	
	tes3mp.SendMessage(pid, msg, true)
	if Players[pid].data.customVariables.Jailer == nil then
		Players[pid].data.customVariables.Jailer = true
	else	
		Players[pid].data.customVariables.Jailer = true
	end
	local TimerJail = tes3mp.CreateTimer("EventJail", time.seconds(300))
	tes3mp.StartTimer(TimerJail)
	tes3mp.MessageBox(pid, -1, message.WaitJail)		
	function EventJail()
		for pid, player in pairs(Players) do
			if Players[pid] ~= nil and player:IsLoggedIn() then
				if Players[pid].data.customVariables.Jailer == true then
					Players[pid].data.customVariables.Jailer = false
					tes3mp.MessageBox(pid, -1, message.StopJail)
					tes3mp.SetCell(pid, "-3, -2")  
					tes3mp.SetPos(pid, -23974, -15787, 505)
					tes3mp.SetRot(pid, 0, 0)
					tes3mp.SendCell(pid)    
					tes3mp.SendPos(pid)
				end
			end
		end
	end
end

WorldMining.PunishKick = function(pid, targetPlayer) -- Used to send a player into the kick
	Players[pid]:Kick()
end

WorldMining.OnDoor = function(pid, unqId)
	local cell = tes3mp.GetCell(pid)
	local activated = WorldInstance.data.customVariables.WorldMining.placed[cell][unqId]
	local solution
	-- if thers more than one door in that cell compare with position in json
	-- and take the one that is closer to the activated one
	local doors = jsonInterface.load("createdDoors.json")
	if #doors[cell] > 1 then
			--beginn complicated math
		local distance = {}
		for index, item in pairs(doors[cell]) do
			distance[index] = math.sqrt((item.location.posX - activated.loc.posX)^2 + (item.location.posY - activated.loc.posY)^2 + (item.location.posZ - activated.loc.posZ)^2)
		end
			--get smallest distance
		local count = -1
		for index, item in pairs(distance) do
			if item < count or count == -1 then
				solution = doors[cell][index] -- we got the best door in solution
				count = item
			end
		end
	else
		for index, item in pairs(doors[cell]) do
			solution = doors[cell][index]
			break
		end
	end
	--teleport to destination
	tes3mp.SetCell(pid, solution.destination.cell)
	tes3mp.SendCell(pid)
	tes3mp.SetPos(pid, solution.destination.location.posX, solution.destination.location.posY, solution.destination.location.posZ + 10)
	tes3mp.SetRot(pid, 0, 0)
	tes3mp.SendPos(pid)
	--maybe fancy message you entered one of playerNames doors
end

craft = function(pid)
	--require material while kanaFurnin
	--remove one of each
	inventoryHelper.removeItem(Players[pid].data.inventory, "crafttree", 1)
	inventoryHelper.removeItem(Players[pid].data.inventory, "craftrock", 1)
	--add material
	inventoryHelper.addItem(Players[pid].data.inventory, "material", 1, -1, -1, "")
	Players[pid]:Save()
	local itemMat = {refId = "material", count = 1, charge = -1}	
	local itemTree = {refId = "crafttree", count = 1, charge = -1}
	local itemRock = {refId = "craftrock", count = 1, charge = -1}		
	Players[pid]:LoadItemChanges({itemMat}, enumerations.inventory.ADD)
	Players[pid]:LoadItemChanges({itemTree}, enumerations.inventory.REMOVE)	
	Players[pid]:LoadItemChanges({itemRock}, enumerations.inventory.REMOVE)		
	--fancy message
	logicHandler.RunConsoleCommandOnPlayer(pid, "player->say, \"AM/MinerSOund2.wav\", \"\"", false)
	WorldMining.OnCraftCommand(pid, "nix")
end
	
WorldMining.OnCraftCommand = function(pid, cmd)
	local count = {terrain = 0, flora = 0, material = 0}

	local index = inventoryHelper.getItemIndex(Players[pid].data.inventory, "crafttree")
	if index ~= nil then count.flora = Players[pid].data.inventory[index].count end

	local index2 = inventoryHelper.getItemIndex(Players[pid].data.inventory, "craftrock")
	if index2 ~= nil then count.terrain = Players[pid].data.inventory[index2].count end
	
	local index3 = inventoryHelper.getItemIndex(Players[pid].data.inventory, "material")
	if index3 ~= nil then count.material = Players[pid].data.inventory[index3].count end

	--craftrock, crafttree
	if count.terrain > 0 and count.flora > 0 and count.material >= 0 then
		local msgCustom = color.Yellow..message.Stone..color.White..count.terrain.."   "..color.Yellow..message.Wood..color.White..count.flora.."   "..color.Yellow..message.Hardware..color.White..count.material.."\n"
		tes3mp.CustomMessageBox(pid, 1338, msgCustom, message.CraftOption)	
	else
		tes3mp.SendMessage(pid, message.NoCraft, false)
		return showMainGUI(pid)
	end
end

WorldMining.OnActivate = function(eventStatus, pid, cellDescription, objects, players)
isValid = true
if objects[1] == nil then return customEventHooks.makeEventStatus(isValid, isValid) end
objectRefId = objects[1].refId
			objectUniqueIndex = objects[1].uniqueIndex
				local splitIndex = objectUniqueIndex:split("-")
				ObjectRefNum = splitIndex[1]
				ObjectMpNum = splitIndex[2]

							--eventHandler OnActivate exchange for this door with uniqueIndex
							-- if its door and uniqueIndex is in placed list in WorldInstance
						if objectRefId and objectRefId == "ex_nord_door_01" then
							local cell = tes3mp.GetCell(pid)
							if WorldInstance.data.customVariables.WorldMining.placed[cellDescription] ~= nil then
								if WorldInstance.data.customVariables.WorldMining.placed[cellDescription][objectUniqueIndex] then
									WorldMining.OnDoor(pid, objectUniqueIndex)
									isValid = false
								else
									print("door was not in worldinstance")
								end
							end
						end
						if isValid == true and objectRefId and tes3mp.IsInExterior(pid) then
							isValid = not WorldMining.OnHitActivate(pid, objectUniqueIndex, objectRefId, ObjectRefNum, ObjectMpNum)
						end 
						
					return customEventHooks.makeEventStatus(isValid, isValid)
end





WorldMining.OnObjectDeleteEvent = function(eventStatus, pid, cellDescription, objects)			
				isValid = not WorldMining.OnObjectDelete(pid)
				return customEventHooks.makeEventStatus(isValid, isValid)
end





WorldMining.AddPreexistingObjects = function(eventStatus, pid, cellDescription)
	if Players[pid].LoadedCells == nil then Players[pid].LoadedCells = {} end
if WorldInstance.data.LoadedCells == nil then WorldInstance.data.LoadedCells = {} end

	if WorldInstance.data.customVariables ~= nil and WorldInstance.data.customVariables.WorldMining ~= nil and WorldInstance.data.customVariables.WorldMining.placed ~= nil then
		local placed = WorldInstance.data.customVariables.WorldMining.placed
		if placed[cellDescription] ~= nil then
			local unique = {}
			
if tableHelper.containsValue(Players[pid].LoadedCells, cellDescription) == false then
	if WorldInstance.data.LoadedCells[cellDescription] == nil then
		WorldInstance.data.LoadedCells[cellDescription] = {}
			for refIndex, object in pairs(placed[cellDescription]) do
				--place kanaFurniture
				unique[refIndex], mpNum = WorldMining.SpawnHelperForOne(pid, cellDescription, object.loc, object.refId, object.need)
table.insert(WorldInstance.data.LoadedCells[cellDescription], {uniqueIndex = unique[refIndex], mpNum = mpNum})
			end
			
			for refIndex, uniqueId in pairs(unique) do
				-- swap positions in table after we created them
				WorldInstance.data.customVariables.WorldMining.placed[cellDescription][uniqueId] = WorldInstance.data.customVariables.WorldMining.placed[cellDescription][refIndex]
				WorldInstance.data.customVariables.WorldMining.placed[cellDescription][refIndex] = nil
			end

table.insert(Players[pid].LoadedCells, cellDescription)
	end
end
		LoadedCells[cellDescription].forceActorListRequest = true
		end
	end
	
end


WorldMining.SpawnHelperForOne = function(pid, cellDescription, location, refId, packetType)
	
			local mpNum = WorldInstance:GetCurrentMpNum() + 1
			local uniqueIndex =  0 .. "-" .. mpNum


			-- Is this a generated record? If so, add a link to it in the cell it
			-- has been placed in
			if logicHandler.IsGeneratedRecord(refId) then
				local recordStore = logicHandler.GetRecordStoreByRecordId(refId)

				if recordStore ~= nil then
					LoadedCells[cellDescription]:AddLinkToRecord(recordStore.storeType, refId, uniqueIndex)

					-- Do any of the visitors to this cell lack the generated record?
					-- If so, send it to them
					for _, visitorPid in pairs(LoadedCells[cellDescription].visitors) do
						recordStore:LoadGeneratedRecords(visitorPid, recordStore.data.generatedRecords, { refId })
					end
				else
					tes3mp.LogMessage(enumerations.log.ERROR, "Attempt at creating object based on non-existent generated record")
					return
				end
			end

			WorldInstance:SetCurrentMpNum(mpNum)
			tes3mp.SetCurrentMpNum(mpNum)

			LoadedCells[cellDescription]:InitializeObjectData(uniqueIndex, refId)
			LoadedCells[cellDescription].data.objectData[uniqueIndex].location = location

			if packetType == "place" then
				table.insert(LoadedCells[cellDescription].data.packets.place, uniqueIndex)
			elseif packetType == "spawn" then
				table.insert(LoadedCells[cellDescription].data.packets.spawn, uniqueIndex)
				table.insert(LoadedCells[cellDescription].data.packets.actorList, uniqueIndex)
			end

			LoadedCells[cellDescription]:QuicksaveToDrive()

			-- Are there any players on the server? If so, initialize the object
			-- list for the first one we find and just send the corresponding packet
			-- to everyone
			if tableHelper.getCount(Players) > 0 then

				local pid = pid
				tes3mp.ClearObjectList()
				tes3mp.SetObjectListPid(pid)
				tes3mp.SetObjectListCell(cellDescription)
				tes3mp.SetObjectRefId(refId)
				tes3mp.SetObjectRefNum(0)
				tes3mp.SetObjectMpNum(mpNum)
				tes3mp.SetObjectCharge(-1)
				tes3mp.SetObjectEnchantmentCharge(-1)
				tes3mp.SetObjectPosition(location.posX, location.posY, location.posZ)
				tes3mp.SetObjectRotation(location.rotX, location.rotY, location.rotZ)
				tes3mp.AddObject()

				if packetType == "place" then
					tes3mp.SendObjectPlace(false)
				elseif packetType == "spawn" then
					tes3mp.SendObjectSpawn(false)
				end
			end

			return uniqueIndex, mpNum
	
end

customCommandHooks.registerCommand("furn", WorldMining.OnCommand)
customCommandHooks.registerCommand("build", WorldMining.OnBuild)
customCommandHooks.registerCommand("material", WorldMining.OnCraftCommand)
customEventHooks.registerValidator("OnGUIAction", WorldMining.OnGUIActionDecide)
customEventHooks.registerValidator("OnObjectActivate", WorldMining.OnActivate)
customEventHooks.registerValidator("OnObjectDelete", WorldMining.OnObjectDeleteEvent)
customEventHooks.registerHandler("OnServerPostInit", WorldMining.OnServerPostInit)
customEventHooks.registerHandler("OnCellLoad", WorldMining.AddPreexistingObjects)
-- make sure to reset WorldInstance.data.LoadedCells on CellReset