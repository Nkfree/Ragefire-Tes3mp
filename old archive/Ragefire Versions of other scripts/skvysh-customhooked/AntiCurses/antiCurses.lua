------------------
-- Version: 1.0 --
------------------
-- item list
cursedItemsDremora = {"ingred_cursed_daedras_heart_01","ingred_Dae_cursed_diamond_01",
"ebony broadsword_Dae_cursed","ingred_Dae_cursed_emerald_01",
"fiend spear_Dae_cursed","glass dagger_Dae_cursed",
"imperial helmet armor_Dae_curse","ingred_Dae_cursed_pearl_01",
"ingred_Dae_cursed_raw_ebony_01","ingred_Dae_cursed_ruby_01",
"light_com_Dae_cursed_candle_10"}
cursedItemsDremoraSpecial = {"gold_dae_cursed_001","gold_dae_cursed_005"}
cursedItemsGhosts = {"Silver Dagger_Hanin Cursed"}
cursedItemsDwemerCoin = {"misc_dwrv_cursed_coin00"}
-- Settings
local disableDremoras = true
local disableDremorasSpecial = true
local disableGhosts = true
local disableDwemerGhosts = true

antiCurses = {}

antiCurses.CheckItem = function(pid, refId)
    local entity = 0
    local cellDescription = Players[pid].data.location.cell
    if entity == 0 then
        if disableDremoras == true then
            for index, item in pairs(cursedItemsDremora) do
                if string.lower(item) == string.lower(refId) then
                    entity = 1
                    break
                end
            end
        end
        if disableDremorasSpecial == true then
            for index, item in pairs(cursedItemsDremoraSpecial) do
                if string.lower(item) == string.lower(refId) then
                    entity = 1
                    break
                end
            end
        end
        if disableGhosts == true then
            for index, item in pairs(cursedItemsGhosts) do
                if string.lower(item) == string.lower(refId) then
                    entity = 2
                    break
                end
            end
        end
        if disableDwemerGhosts == true then
            for index, item in pairs(cursedItemsDwemerCoin) do
                if string.lower(item) == string.lower(refId) then
                    entity = 3
                    break
                end
            end
        end
    end
    if entity ~= 0 then
        Players[pid]:SaveCell()
        antiCurses.RemoveEntities(pid, cellDescription, entity)
    end
end

antiCurses.RemoveEntities = function(pid, cellDescription, entity)
    tes3mp.ReadLastEvent()
    local creatureName
    local indexes = {}
    local i
    local j = 1
    local tmp = {}
    if entity == 1 then
        creatureName = "dremora_lord"
    elseif entity == 2 then
        creatureName =  "ancestor_ghost"
    elseif entity == 3 then
        creatureName = "dwarven ghost"
    end
    -- locate all creatures with the name of the spawned entitity and store their mpNums
    for index, value in pairs(LoadedCells[cellDescription].data.objectData) do
        if LoadedCells[cellDescription].data.objectData[index].refId == creatureName then
            indexes[j] = index
            j = j + 1
        end
    end
    -- if we found at least one
    if j > 1 then
        -- find the one with highest mpNum
        for k = 1,j-1 do
            i = 1
            for word in string.gmatch(indexes[k], '([^%-]+)') do
                tmp[i] = word
                i = i + 1
            end
            indexes[k] = tmp[2]
        end
        table.sort(indexes)
        local a = indexes[j-1] -- grab the last one in the array, thats the newest entity in the cell
        -- taken from Dave's "Disable Assassins" script
        for i,p in pairs(Players) do -- Do this for each player online
            tes3mp.InitializeEvent(p.pid)
            tes3mp.SetEventCell(cellDescription)
            tes3mp.SetObjectRefNumIndex(0)
            tes3mp.SetObjectMpNum(a)
            tes3mp.AddWorldObject() -- Add actor to packet
            tes3mp.SendObjectDelete() -- Send Delete
            if LoadedCells[cellDescription] ~= nil then
                local refIndex = "0-" .. a
                LoadedCells[cellDescription].data.objectData[refIndex] = nil
                tableHelper.removeValue(LoadedCells[cellDescription].data.packets.spawn, refIndex)
                tableHelper.removeValue(LoadedCells[cellDescription].data.packets.actorList, refIndex)
                LoadedCells[cellDescription]:Save()
            end
        end
    end
end

antiCurses.onObjectDelete = function(eventStatus, pid,  cellDescription, objects)

for _, object in pairs(objects) do
	local wasMovedHere = tableHelper.containsValue(LoadedCells[cellDescription].data.packets.cellChangeFrom, object.uniqueIndex)
	
	if not wasMovedHere then
		local wasPlacedHere = tableHelper.containsValue(LoadedCells[cellDescription].data.packets.place, object.uniqueIndex) or
						tableHelper.containsValue(LoadedCells[cellDescription].data.packets.spawn, object.uniqueIndex)
						
		if wasPlacedHere then
			antiCurses.CheckItem(pid, object.refId)
		end
	end
end

end

customEventHooks.registerHandler("OnObjectDelte", antiCurses.onObjectDelete)
