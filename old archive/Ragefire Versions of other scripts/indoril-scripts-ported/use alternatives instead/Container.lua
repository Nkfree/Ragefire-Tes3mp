-- Storage Containers by >>Jerthebear <<< modded by discordpeter
-- no need for this since kanaStorage

Container = {}

--=================
--INSTALL
--=================

-- Add to top of commandHandler.lua
--[[
Container = require("Container")
]]

-- Add to command Chain of commandHandler.lua
--[[
elseif cmd[1] == "storage" then
	Container.Open(pid)
]]


-- Add storagerat to  mp-stuff\data\recordstore\creature.json in permanentRecords
--[[
  "permanentRecords":[
  "storagerat":{
      "baseId":"dead rat",
      "name":"storage"
    }
  ]
]]

-- Find Players[pid]:FinishLogin() in eventHandler.lua and put below
--[[

Players[pid].data.storageLoaded = false

]]


-- Find this part in eventHandler.lua and comment the "return" with two --
--[[
        if not isCellLoaded and logicHandler.DoesPacketOriginRequireLoadedCell(packetOrigin) then
            tes3mp.LogMessage(enumerations.log.WARN, "Invalid Container: " .. logicHandler.GetChatName(pid) ..
                " used impossible packetOrigin for unloaded " .. cellDescription)
            --return
        end
]]

Container.Open = function(pid)

--Load Guild Json
	local GuildContainers = {}
	
	if tes3mp.GetCaseInsensitiveFilename(os.getenv("MOD_DIR").."/","GuildContainers.json") == "invalid" then
		jsonInterface.save("GuildContainers.json", GuildContainers)
	else
		GuildContainers = jsonInterface.load("GuildContainers.json")
	end


--necessary vars

        local storageCell = "Mark's Vampire Test Cell"
        local temploaded = false
        local storageId = ""
        
		
		--player got storage and cell loaded for him
		
        if Players[pid].data.storageLoaded == false then
		
			--load cell
            if LoadedCells[storageCell] == nil then
                logicHandler.LoadCell(storageCell)
                temploaded = true
            end
            
			
			-- get storage ID if player got alrdy a guild storage
            if Players[pid].data.miscellaneous.storageId == nil then
			
				-- find guild / give guild ID
				
				
				for id, journalItem in pairs(Players[pid].data.journal) do
					if journalItem.quest == "tie_fw_02_joinao" and journalItem.index >= 5 then
						if GuildContainers["almsivi"] ~= nil and GuildContainers["almsivi"].storage ~= nil then
							storageId = GuildContainers["almsivi"].storage
						else
							local location = {posX = 0,posY = 0,posZ = 0,rotX = 0,rotY = 0,rotZ = 0}
							storageId = logicHandler.CreateObjectAtLocation(storageCell,location,"storagerat","spawn")
							GuildContainers["almsivi"] = { storage = storageId}
						end
						break
					elseif journalItem.quest == "tie_fw_02_joinhd" and journalItem.index >= 5 then
						if GuildContainers["dagoth"] ~= nil and GuildContainers["dagoth"].storage ~= nil then
							storageId = GuildContainers["dagoth"].storage
						else
							local location = {posX = 0,posY = 0,posZ = 0,rotX = 0,rotY = 0,rotZ = 0}
							storageId = logicHandler.CreateObjectAtLocation(storageCell,location,"storagerat","spawn")
							GuildContainers["dagoth"] = { storage = storageId}
						end
						break
					elseif journalItem.quest == "tie_fw_02_joinhi" and journalItem.index >= 5 then
						if GuildContainers["indoril"] ~= nil and GuildContainers["indoril"].storage ~= nil then
							storageId = GuildContainers["indoril"].storage
						else
							local location = {posX = 0,posY = 0,posZ = 0,rotX = 0,rotY = 0,rotZ = 0}
							storageId = logicHandler.CreateObjectAtLocation(storageCell,location,"storagerat","spawn")
							GuildContainers["indoril"] = { storage = storageId}
						end
						break
					elseif journalItem.quest == "tie_fw_02_joinil" and journalItem.index >= 5 then
						if GuildContainers["imperial"] ~= nil and GuildContainers["imperial"].storage ~= nil then
							storageId = GuildContainers["imperial"].storage
						else
							local location = {posX = 0,posY = 0,posZ = 0,rotX = 0,rotY = 0,rotZ = 0}
							storageId = logicHandler.CreateObjectAtLocation(storageCell,location,"storagerat","spawn")
							GuildContainers["imperial"] = { storage = storageId}
						end
						break
					end
				end
				
				if storageId == "" then return end -- quit if he got no guild
				
				
				-- save json 
				jsonInterface.save("GuildContainers.json", GuildContainers)
				--give player the guild ones as storageId
                Players[pid].data.miscellaneous.storageId = storageId
            else
                storageId = Players[pid].data.miscellaneous.storageId -- give guild id
            end
            
			
			--load storage record
			
            local recordData = {storagerat = {baseId = "dead rat",name = "Guild's Storage"}}
            RecordStores["creature"]:LoadRecords(pid,recordData,{"storagerat"})
            
			
			--loadcontainers
			
            local objData = LoadedCells[storageCell].data.objectData
            LoadedCells[storageCell]:LoadObjectsSpawned(pid,objData,{storageId})
            LoadedCells[storageCell]:LoadContainers(pid,objData,{storageId})
            Players[pid].data.storageLoaded = true
            
			--unloadCell if necessary
            if temploaded then
                logicHandler.UnloadCell(storageCell)
                temploaded = false
            end
        end
		
		--activate and open container for player
		storageId = Players[pid].data.miscellaneous.storageId 
        logicHandler.ActivateObjectForPlayer(pid,storageCell,storageId)
		
end

return Container