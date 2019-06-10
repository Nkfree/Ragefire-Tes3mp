--  a way to add loot to killed creatures
-- does https://github.com/tes3mp-scripts/ContainerFramework work with killed actors? @urm
creatureLoot = {}


creatureLoot.ProcessLatestKill = function(pid, refId, uniqueIndex) -- put OnWorldKillCount... false .. put OnActorDeath

local cellDescription = tes3mp.GetCell(pid)

if refId == "skeleton warrior"  and cellDescription == "Indalen Ancestral Tomb" then
	
	
			if LoadedCells[cellDescription].data.objectData[uniqueIndex].inventory == nil then
				LoadedCells[cellDescription].data.objectData[uniqueIndex].inventory = {{refId = "iron_shield", count = 1, charge = 200}, {refId = "gold_001", count = 1000, charge = 0}}
				
			else
				table.insert(LoadedCells[cellDescription].data.objectData[uniqueIndex].inventory,  {refId = "iron_shield", count = 1, charge = 200})
				table.insert(LoadedCells[cellDescription].data.objectData[uniqueIndex].inventory, {refId = "gold_001", count = 1000, charge = 0})
			end
			
			
			if LoadedCells[cellDescription].data.objectData[uniqueIndex].equipment == nil then
				LoadedCells[cellDescription].data.objectData[uniqueIndex].equipment = {}
			else
				LoadedCells[cellDescription].data.objectData[uniqueIndex].equipment = {}
			end
			 
			 
        --load all containers to show it up
            local objectData = LoadedCells[cellDescription].data.objectData
            local packets = LoadedCells[cellDescription].data.packets
			LoadedCells[cellDescription]:LoadContainers(pid, objectData, packets.death)    
            tes3mp.SendMessage(pid,"Sorry bro did you really think you can loot that shit?..\n",false)
end
end


creatureLoot.Decide = function(eventStatus, pid, cellDescription)

if eventStatus.validCustomHandlers then --check if some other script made this event obsolete
        local uniqueIndex = tes3mp.GetActorRefNum(0) .. "-" .. tes3mp.GetActorMpNum(0)

			if tes3mp.DoesActorHavePlayerKiller(0) then -- rly necessary ?
				local killerPid = tes3mp.GetActorKillerPid(0)
				if LoadedCells[cellDescription].data.objectData[uniqueIndex] ~= nil then
					local refId = LoadedCells[cellDescription].data.objectData[uniqueIndex].refId

						creatureLoot.ProcessLatestKill(killerPid, refId, uniqueIndex)
				else
				 tes3mp.LogMessage(2, "objectData was nil with this one")
				end
			end
end
end


customEventHooks.registerHandler("OnActorDeath", creatureLoot.Decide)

