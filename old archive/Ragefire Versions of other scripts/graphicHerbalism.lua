-- use https://github.com/tes3mp-scripts/VisualHarvesting instead







--[[Graphic Herbalism Server Scripts 1.23 - Developed with tes3mp 0.7.0-alpha
This is necessary because graphic herbalism mods work using a global player variable that is not saved correctly

Installation

Save this file in the mp-stuff\scripts\ directory.
These edits will be made in the same directory in the serverCore.lua file.

1a) Add: graphicHerbalism = require("graphicHerbalism")
under: menuHelper = require("menuHelper") ~line 14

1b) Add: graphicHerbalism.OnServerPostInit()
under: ResetAdminCounter() ~line 285

1c) Add: graphicHerbalism.OnCellLoad(pid, cellDescription)
under: eventHandler.OnCellLoad(pid, cellDescription) ~line 460

Save/close serverCore.lua and open eventHandler.lua

2a) Add: if graphicHerbalism.CanPickPlant(objectRefId) then
		    graphicHerbalism.OnObjectActivate(objectRefId, pid, objectUniqueIndex)
		 	isValid = false --disable inventory screen
		 end
under: objectUniqueIndex = tes3mp.GetObjectRefNum(index) .. "-" .. tes3mp.GetObjectMpNum(index) ~line 609

If you'd like to change the default 3 in game day plant respawn, you can edit the 'local growthDays = 3' variable on line 33 of this script.

The line numbers are approximations and can change in the future.
-------------------------------------------------------------------------]]

local jsonInterface = require("jsonInterface")
local pickData = nil
local growthHours = 0.1 --How many in-game hours it takes for the plant to respawn. Allows fractions

local disabledPlants = {}

local function SaveJSON(pickData)
	jsonInterface.save("graphicHerbalism.json", pickData)
end

local updated = false

local plantList = {
	{["checkRefId"] = "kollop_03_pearl", ["name"] = "Small Kollop", ["ingredientRefId"] = "ingred_pearl_01", ["chanceCount"] = 1, ["chanceNone"] = 0.1},
	{["checkRefId"] = "kollop_02_pearl", ["name"] = "Kollop", ["ingredientRefId"] = "ingred_pearl_01", ["chanceCount"] = 2, ["chanceNone"] = 0.1},
	{["checkRefId"] = "kollop_01_pearl", ["name"] = "Large Kollop", ["ingredientRefId"] = "ingred_pearl_01", ["chanceCount"] = 3, ["chanceNone"] = 0.1},
	{["checkRefId"] = "flora_ash_yam_01,flora_ash_yam_02", ["name"] = "Ash Yam", ["ingredientRefId"] = "ingred_ash_yam_01", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_bittergreen_01,flora_bittergreen_02,flora_bittergreen_03,flora_bittergreen_04,flora_bittergreen_05,flora_bittergreen_06,flora_bittergreen_07,flora_bittergreen_08,flora_bittergreen_09,flora_bittergreen_10", ["name"] = "Bittergreen Petal", ["ingredientRefId"] = "ingred_bittergreen_petals_01", ["chanceCount"] = 2, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_black_anther_01,flora_black_anther_02", ["name"] = "Black Anther", ["ingredientRefId"] = "ingred_black_anther_01", ["chanceCount"] = 2, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_black_lichen_01,flora_black_lichen_02", ["name"] = "Black Lichen", ["ingredientRefId"] = "ingred_black_lichen_01", ["chanceCount"] = 1, ["chanceNone"] = 3/10},
	{["checkRefId"] = "cavern_spore00", ["name"] = "Bloat", ["ingredientRefId"] = "ingred_bloat_01", ["chanceCount"] = 1, ["chanceNone"] = 3/10},
	{["checkRefId"] = "flora_bc_shelffungus_01,flora_bc_shelffungus_02", ["name"] = "Bungler's Bane", ["ingredientRefId"] = "ingred_bc_bungler's_bane", ["chanceCount"] = 1, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_bc_shelffungus_03,flora_bc_shelffungus_04", ["name"] = "Hypha Facia", ["ingredientRefId"] = "ingred_bc_hypha_facia", ["chanceCount"] = 1, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_chokeweed_02", ["name"] = "Chokeweed", ["ingredientRefId"] = "ingred_chokeweed_01", ["chanceCount"] = 1, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_comberry_01", ["name"] = "Comberry", ["ingredientRefId"] = "ingred_comberry_01", ["chanceCount"] = 2, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_bc_podplant_01,flora_bc_podplant_02", ["name"] = "Ampoule Pod", ["ingredientRefId"] = "ingred_bc_ampoule_pod", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_bc_podplant_03,flora_bc_podplant_04", ["name"] = "Coda Flower", ["ingredientRefId"] = "ingred_bc_coda_flower", ["chanceCount"] = 1, ["chanceNone"] = 2.5/10},
	{["checkRefId"] = "flora_corkbulb", ["name"] = "Corkbulb Root", ["ingredientRefId"] = "ingred_corkbulb_root_01", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_fire_fern_01,flora_fire_fern_02,flora_fire_fern_03", ["name"] = "Fire Petal", ["ingredientRefId"] = "ingred_fire_petal_01", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_gold_kanet_uni", ["name"] = "Roland's Tear", ["ingredientRefId"] = "ingred_gold_kanet_unique", ["chanceCount"] = 3, ["chanceNone"] = 0},
	{["checkRefId"] = "flora_gold_kanet_01,flora_gold_kanet_02,flora_gold_kanet_01_uni", ["name"] = "Gold Kanet", ["ingredientRefId"] = "ingred_gold_kanet_01", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_sedge_01", ["name"] = "Golden Sedge Flower", ["ingredientRefId"] = "ingred_golden_sedge_01", ["chanceCount"] = 1, ["chanceNone"] = 3/10},
	{["checkRefId"] = "flora_green_lichen_01,flora_green_lichen_02", ["name"] = "Green Lichen", ["ingredientRefId"] = "ingred_green_lichen_01", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_hackle-lo_01,flora_hackle-lo_02", ["name"] = "Hackle-Lo Leaf", ["ingredientRefId"] = "ingred_hackle-lo_leaf_01", ["chanceCount"] = 1, ["chanceNone"] = 2.5/10},
	{["checkRefId"] = "flora_heather_01", ["name"] = "Heather", ["ingredientRefId"] = "ingred_heather_01", ["chanceCount"] = 2, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_plant_01", ["name"] = "Horn Lily Bulb", ["ingredientRefId"] = "ingred_horn_lily_bulb_01", ["chanceCount"] = 2, ["chanceNone"] = 3/10},
	{["checkRefId"] = "flora_kreshweed_01,flora_kreshweed_02,flora_kreshweed_03", ["name"] = "Kresh Fiber", ["ingredientRefId"] = "ingred_kresh_fiber_01", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "egg_kwama00", ["name"] = "Large Kwama Egg", ["ingredientRefId"] = "food_kwama_egg_02", ["chanceCount"] = 1, ["chanceNone"] = 0},
	{["checkRefId"] = "flora_bc_mushroom_01,flora_bc_mushroom_02,flora_bc_mushroom_03,flora_bc_mushroom_04,flora_bc_mushroom_05", ["name"] = "Luminous Russula", ["ingredientRefId"] = "ingred_russula_01", ["chanceCount"] = 2, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_bc_mushroom_06,flora_bc_mushroom_07,flora_bc_mushroom_08", ["name"] = "Violet Coprinus", ["ingredientRefId"] = "ingred_coprinus_01", ["chanceCount"] = 2, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_marshmerrow_01,flora_marshmerrow_02,flora_marshmerrow_03", ["name"] = "Marshmerrow", ["ingredientRefId"] = "ingred_marshmerrow_01", ["chanceCount"] = 1, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_plant_04", ["name"] = "Meadow Rye", ["ingredientRefId"] = "ingred_meadow_rye_01", ["chanceCount"] = 2, ["chanceNone"] = 0},
	{["checkRefId"] = "flora_muckspunge_01,flora_muckspunge_02,flora_muckspunge_03,flora_muckspunge_04,flora_muckspunge_05,flora_muckspunge_06", ["name"] = "Muck", ["ingredientRefId"] = "ingred_muck_01", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_plant_02", ["name"] = "Nirthfly Stalk", ["ingredientRefId"] = "ingred_nirthfly_stalks_01", ["chanceCount"] = 2, ["chanceNone"] = 3/10},
	{["checkRefId"] = "flora_sedge_02", ["name"] = "Noble Sedge Flower", ["ingredientRefId"] = "ingred_noble_sedge_01", ["chanceCount"] = 1, ["chanceNone"] = 3/10},
	{["checkRefId"] = "flora_red_lichen_01,flora_red_lichen_02", ["name"] = "Red Lichen", ["ingredientRefId"] = "ingred_red_lichen_01", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_roobrush_02", ["name"] = "Roobrush", ["ingredientRefId"] = "ingred_roobrush_01", ["chanceCount"] = 1, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_rm_scathecraw_01,flora_rm_scathecraw_02", ["name"] = "Scathecraw", ["ingredientRefId"] = "ingred_scathecraw_01", ["chanceCount"] = 1, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_saltrice_01,flora_saltrice_02", ["name"] = "Saltrice", ["ingredientRefId"] = "ingred_saltrice_01", ["chanceCount"] = 1, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_plant_07", ["name"] = "Scrib Cabbage", ["ingredientRefId"] = "ingred_scrib_cabbage_01", ["chanceCount"] = 2, ["chanceNone"] = 3/10},
	{["checkRefId"] = "flora_bc_fern_01", ["name"] = "Spore Pod", ["ingredientRefId"] = "ingred_bc_spore_pod", ["chanceCount"] = 3, ["chanceNone"] = 0},
	{["checkRefId"] = "flora_bc_fern_04_chuck", ["name"] = "Meteor Slime", ["ingredientRefId"] = "ingred_scrib_jelly_02", ["chanceCount"] = 1, ["chanceNone"] = 0},
	{["checkRefId"] = "flora_plant_08", ["name"] = "Lloramor Spine", ["ingredientRefId"] = "ingred_lloramor_spines_01", ["chanceCount"] = 2, ["chanceNone"] = 0},
	{["checkRefId"] = "flora_stoneflower_01,flora_stoneflower_02", ["name"] = "Stoneflower Petal", ["ingredientRefId"] = "ingred_stoneflower_petals_01", ["chanceCount"] = 1, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_plant_05,flora_plant_06", ["name"] = "Sweetpulp", ["ingredientRefId"] = "ingred_sweetpulp_01", ["chanceCount"] = 2, ["chanceNone"] = 3/10},
	{["checkRefId"] = "flora_plant_03", ["name"] = "Timsa-Come-By Flower", ["ingredientRefId"] = "ingred_timsa-come-by_01", ["chanceCount"] = 2, ["chanceNone"] = 3/10},
	{["checkRefId"] = "tramaroot_01,contain_trama_shrub_", ["name"] = "Trama Root", ["ingredientRefId"] = "ingred_trama_root_01", ["chanceCount"] = 3, ["chanceNone"] = 2/10},
	{["checkRefId"] = "tramaroot_01,tramaroot_02,tramaroot_03,tramaroot_04,tramaroot_05,tramaroot_06", ["name"] = "Trama Root", ["ingredientRefId"] = "ingred_trama_root_01", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "contain_trama_shrub_05,contain_trama_shrub_01", ["name"] = "ingred_trama_root_01", ["ingredientRefId"] = "ingred_trama_root_01", ["chanceCount"] = 2, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_wickwheat_01,flora_wickwheat_02,flora_wickwheat_03,flora_wickwheat_04", ["name"] = "Wickwheat", ["ingredientRefId"] = "ingred_wickwheat_01", ["chanceCount"] = 1, ["chanceNone"] = 1/10},
	{["checkRefId"] = "flora_willow_flower_01,flora_willow_flower_02", ["name"] = "Willow Anther", ["ingredientRefId"] = "ingred_willow_anther_01", ["chanceCount"] = 1, ["chanceNone"] = 1.5/10},
	{["checkRefId"] = "flora_bm_belladonna_03", ["name"] = "ripened Belladonna Berries", ["ingredientRefId"] = "ingred_belladonna_01", ["chanceCount"] = 1, ["chanceNone"] = 0},
	{["checkRefId"] = "flora_bm_belladonna_01,flora_willow_flower_02,flora_willow_flower_03", ["name"] = "unripened Belladonna Berries", ["ingredientRefId"] = "ingred_belladonna_02", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_bm_holly_01,flora_bm_holly_02,flora_bm_holly_03,flora_bm_holly_04,flora_bm_holly_05,flora_bm_holly_06", ["name"] = "Holly Berries", ["ingredientRefId"] = "ingred_holly_01", ["chanceCount"] = 1, ["chanceNone"] = 2/10},
	{["checkRefId"] = "flora_bm_wolfsbane_01", ["name"] = "Wolfsbane Petal", ["ingredientRefId"] = "ingred_wolfsbane_01", ["chanceCount"] = 1, ["chanceNone"] = 0}
}

local refIdToPlant = {}
for k,plant in pairs(plantList) do
	local multipleRefId = plant["checkRefId"]:split(",")
	for _, RefId in pairs(multipleRefId) do
		refIdToPlant[RefId] = k
	end
end

local function GetIngredient(plantRefId) --this will return how many we need to add, the name for the message, and the reference ID
	local ingredient = {}
	ingredient.Count = 0
	
	local ingredientChanceCount = 0
	local ingredientChanceNone = 0
	
	local plant = plantList[refIdToPlant[plantRefId]]
	
	ingredient.Name = plant["name"]
	ingredient.RefId = plant["ingredientRefId"]
	ingredientChanceCount = plant["chanceCount"]
	ingredientChanceNone = plant["chanceNone"]
	
	for i = 1, ingredientChanceCount, 1 do
		if math.random() > ingredientChanceNone then --this is run in a loop to calculate 'for each' like vanilla
			ingredient.Count = ingredient.Count + 1
		end
	end
	
	return ingredient
end

local function InventoryManagement(plantRefId, pid)
	local ingredient = GetIngredient(plantRefId)
	
	if ingredient.Count > 0 then
		inventoryHelper.addItem(Players[pid].data.inventory, ingredient.RefId, ingredient.Count, -1, -1, "")
		
		local item = {}
		item.refId = ingredient.RefId
		item.charge = -1
		item.enchantmentCharge = -1
		item.count = ingredient.Count
		item.soul = ""
		
		Players[pid]:LoadItemChanges({item}, enumerations.inventory.ADD)
		
		local message = ""
		
		if ingredient.Count > 1 then
			message = "You harvested %d %ss."
			
			local lastLetter = string.sub(ingredient.Name, -1)
			if lastLetter == "s" then
				ingredient.Name = ingredient.Name .. "'" --if it ends in s, change to s'
				message = "You harvested %d %s."
			end
		else
			message = "You harvested %d %s."
		end
		
		tes3mp.MessageBox(pid, -1, string.format(message, ingredient.Count, ingredient.Name))
		tes3mp.PlaySpeech(pid, "Fx/item/item.wav")
	else
		tes3mp.MessageBox(pid, -1, "You failed to harvest anything useful.")
		tes3mp.PlaySpeech(pid, "Fx/item/blunt.wav")
	end
end

local GraphicHerbalism = {}

function GraphicHerbalism.OnServerPostInit() --load the file or create if necessary
	local jsonFile = io.open(tes3mp.GetModDir() .. "/graphicHerbalism.json", "r")
	io.close()
	
	if jsonFile == nil then
		pickData = {}
		SaveJSON(pickData)
	else
		pickData = jsonInterface.load("graphicHerbalism.json")
	end
end

function GraphicHerbalism.OnCellUnload(pid, cellDescription)
	if pickData~=nil and updated then
		SaveJSON(pickData)
		updated = false
	end
end

function GraphicHerbalism.OnCellLoad(pid, cellDescription)
	if pickData[cellDescription] ~= nil then
		local deletedCount = 0
		local loopCount = 0
		tes3mp.ClearObjectList()
		tes3mp.SetObjectListPid(pid)
		tes3mp.SetObjectListCell(cellDescription)
		
		for uniqueIndex, plant in pairs(pickData[cellDescription]) do
			loopCount = loopCount + 1
			
			local daysPassed = WorldInstance.data.time.daysPassed - plant['daysPassed']
			local hoursPassed = WorldInstance.data.time.hour - plant['hour'] + 24*daysPassed
			
			if hoursPassed>=growthHours then
				if LoadedCells[cellDescription].data.objectData[uniqueIndex] ~= nil then					
					logicHandler.RunConsoleCommandOnObject("Enable", cellDescription, uniqueIndex)
					disabledPlants[uniqueIndex] = nil
					
					local objectData = {}
					objectData.refId = plant['plantRefId']
					objectData.state = true
					
					packetBuilder.AddObjectState(uniqueIndex, objectData)
					LoadedCells[cellDescription].data.objectData[uniqueIndex].state = true
					tes3mp.SendObjectState()
					
					pickData[cellDescription][uniqueIndex] = nil --delete reference
					
					deletedCount = deletedCount + 1
				else
					pickData[cellDescription][uniqueIndex] = nil
					deletedCount = deletedCount + 1
				end
			end
		end
		
		if loopCount == deletedCount then
			pickData[cellDescription] = nil --delete cell from json if there are no references in it
		end
		
		if deletedCount > 0 then
			updated = true
			SaveJSON(pickData)
		end
	end
end

function GraphicHerbalism.OnObjectActivate(pid, plantRefId, uniqueIndex)
	if refIdToPlant[plantRefId]==nil then
		return false
	end
	
	if disabledPlants[uniqueIndex]~=nil then
		return true
	end
	
	
	local cellDescription = tes3mp.GetCell(pid)
	
	if pickData == nil then
		pickData = {}
	end
	
	if pickData[cellDescription] == nil then
		pickData[cellDescription] = {}
	end
	
	if pickData[cellDescription][uniqueIndex] == nil then
		pickData[cellDescription][uniqueIndex] = {}
	end
	
	pickData[cellDescription][uniqueIndex].plantRefId = plantRefId
	pickData[cellDescription][uniqueIndex].daysPassed = WorldInstance.data.time.daysPassed
	pickData[cellDescription][uniqueIndex].hour = math.floor(WorldInstance.data.time.hour)
	
	InventoryManagement(plantRefId, pid)
	
	logicHandler.RunConsoleCommandOnObject("Disable", cellDescription, uniqueIndex)
	disabledPlants[uniqueIndex] = true
	
	updated = true
	
	return true
end

return GraphicHerbalism