-- decorateHelp - Release 1.1 - For tes3mp v0.6.1
-- Alter positions of items using a GUI

--[[ INSTALLATION:
1) Save this file as "decorateHelp.lua" in mp-stuff/scripts
2) Add [ decorateHelp = require("decorateHelp") ] to the top of serverCore.lua
3) Add the following to the elseif chain for commands in "OnPlayerSendMessage" inside commandHandler.lua
[	elseif cmd[1] == "decorator" or cmd[1] == "decorate" or cmd[1] == "dh" then
		decorateHelp.OnCommand(pid) ]
4) Add the following to OnGUIAction in serverCore.lua
	[ if decorateHelp.OnGUIAction(pid, idGui, data) then return end ]
5) Add the following to OnObjectPlace in serverCore.lua
	[ decorateHelp.OnObjectPlace(pid, cellDescription) ]
6) Add the following to OnPlayerCellChange in serverCore.lua
	[ decorateHelp.OnPlayerCellChange(pid) ]
]]

------
local config = {}

config.MainId = 31360
config.PromptId = 31361
------

decorateHelpVariation = {}

tableHelper = require("tableHelper")

--
local playerSelectedObject = {}
local playerCurrentMode = {}

--Returns the object's data from a loaded cell. Doesn't need to load the cell because this assumes it'll always be called in a cell that's loaded.
local function getObject(refIndex, cell)
	if refIndex == nil then
		return false
	end

	if LoadedCells[cell]:ContainsObject(refIndex)  then 
		return LoadedCells[cell].data.objectData[refIndex]
	else
		return false
	end	
end

-- add both functions to save new location to WorldInstance
local function getPlacedTable()
	return WorldInstance.data.customVariables.WorldMining.placed
end

local function addPlacedLoc(refIndex, cell, save, pPos)
	local placed = getPlacedTable()
	
	if not placed[cell] then
		placed[cell] = {}
	end
	
	placed[cell][refIndex].loc = pPos
	
	if save then
		WorldInstance:Save()
	end
end

local function resendPlaceToAll(refIndex, cell)
	local object = getObject(refIndex, cell)
	
	if not object then
		return false
	end
	
	local refId = object.refId
	local count = object.count or 1
	local charge = object.charge or -1
	local posX, posY, posZ = object.location.posX, object.location.posY, object.location.posZ
	local rotX, rotY, rotZ = object.location.rotX, object.location.rotY, object.location.rotZ
	local refIndex = refIndex
	
	local inventory = object.inventory or nil
	
	local splitIndex = refIndex:split("-")
	
	for pid, pdata in pairs(Players) do
		if Players[pid]:IsLoggedIn() then
			--First, delete the original
			tes3mp.InitializeEvent(pid)
			tes3mp.SetEventCell(cell)
			tes3mp.SetObjectRefNumIndex(0)
			tes3mp.SetObjectMpNum(splitIndex[2])
			tes3mp.AddWorldObject() --?
			tes3mp.SendObjectDelete()
			
			--Now remake it
			tes3mp.InitializeEvent(pid)
			tes3mp.SetEventCell(cell)
			tes3mp.SetObjectRefId(refId)
			tes3mp.SetObjectCount(count)
			tes3mp.SetObjectCharge(charge)
			tes3mp.SetObjectPosition(posX, posY, posZ)
			tes3mp.SetObjectRotation(rotX, rotY, rotZ)
			tes3mp.SetObjectRefNumIndex(0)
			tes3mp.SetObjectMpNum(splitIndex[2])
			if inventory then
				for itemIndex, item in pairs(inventory) do
					tes3mp.SetContainerItemRefId(item.refId)
					tes3mp.SetContainerItemCount(item.count)
					tes3mp.SetContainerItemCharge(item.charge)

					tes3mp.AddContainerItem()
				end
			end
			
			tes3mp.AddWorldObject()
			tes3mp.SendObjectPlace()
			if inventory then
				tes3mp.SendContainer()
			end
		end
	end
	
	LoadedCells[cell]:Save() --Not needed, but it's nice to do anyways
	
	-- add to save objects new location to WorldInstance
	local loc = {posX = posX, posY = posY, posZ = posZ, rotX = rotX, rotY = rotY, rotZ = rotZ}
	addPlacedLoc(refIndex, cell, true, loc)
end


local function showPromptGUI(pid)
	local message = "[" .. playerCurrentMode[tes3mp.GetName(pid)] .. "] - Enter a number to add/subtract."

	tes3mp.InputDialog(pid, config.PromptId, message,"")
end

local function onEnterPrompt(pid, data)
	local cell = tes3mp.GetCell(pid)
	local pname = tes3mp.GetName(pid)
	local mode = playerCurrentMode[pname]
	local data = tonumber(data) or 0
	
	local object = getObject(playerSelectedObject[pname], cell)
	
	if not object then
		--The object no longer exists, so we should bail out now
		return false
	end
	
	if mode == "Rotate X" then
		local curDegrees = math.deg(object.location.rotX)
		local newDegrees = (curDegrees + data) % 360
		object.location.rotX = math.rad(newDegrees)
	elseif mode == "Rotate Y" then
		local curDegrees = math.deg(object.location.rotY)
		local newDegrees = (curDegrees + data) % 360
		object.location.rotY = math.rad(newDegrees)
	elseif mode == "Rotate Z" then
		local curDegrees = math.deg(object.location.rotZ)
		local newDegrees = (curDegrees + data) % 360
		object.location.rotZ = math.rad(newDegrees)
	elseif mode == "Move North" then
		object.location.posY = object.location.posY + data
	elseif mode == "Move East" then
		object.location.posX = object.location.posX + data
	elseif mode == "Move Up" then
		object.location.posZ = object.location.posZ + data
	elseif mode == "Scale Up" then
		--Not sure how scale works atm.
		--TODO
		return
	end
	
	resendPlaceToAll(playerSelectedObject[pname], cell)
end

local function showMainGUI(pid)
	--Determine if the player has an item
	local currentItem = "None" --default
	local selected = playerSelectedObject[tes3mp.GetName(pid)]
	local object = getObject(selected, tes3mp.GetCell(pid))
	
	if selected and object then --If they have an entry and it isn't gone
		currentItem = object.refId .. " (" .. selected .. ")"
	end
	
	local message = "Select an option. Your current item: " .. currentItem
	tes3mp.CustomMessageBox(pid, config.MainId, message, "Move North;Move East;Move Up;Rotate X;Rotate Y;Rotate Z;Scale Up;Grab;Close")
end

local function setSelectedObject(pid, refIndex)
	playerSelectedObject[tes3mp.GetName(pid)] = refIndex
end

decorateHelpVariation.SetSelectedObject = function(pid, refIndex)
	setSelectedObject(pid, refIndex)
end

decorateHelpVariation.OnObjectPlace = function(eventStatus, pid, cellDescription, objects)
	--Get the last event, which should hopefully be the place packet
	tes3mp.ReadLastEvent()
	
	--Get the refIndex of the first item in the object place packet (in theory, there should only by one)
	local refIndex = tes3mp.GetObjectRefNumIndex(0) .. "-" .. tes3mp.GetObjectMpNum(0)
	
	--Record that item as the last one the player interacted with in this cell
	setSelectedObject(pid, refIndex)
end

decorateHelpVariation.OnGUIActionDecide = function(eventStatus, pid, idGui, data)
decorateHelpVariation.OnGUIAction(pid, idGui, data)
return customEventHooks.makeEventStatus(true, true)
end

decorateHelpVariation.OnGUIAction = function(pid, idGui, data)
	local pname = tes3mp.GetName(pid)
	
	if idGui == config.MainId then
		if tonumber(data) == 0 then --Move North
			playerCurrentMode[pname] = "Move North"
			showPromptGUI(pid)
			return true
		elseif tonumber(data) == 1 then --Move East
			playerCurrentMode[pname] = "Move East"
			showPromptGUI(pid)
			return true
		elseif tonumber(data) == 2 then --Move Up
			playerCurrentMode[pname] = "Move Up"
			showPromptGUI(pid)
			return true
		elseif tonumber(data) == 3 then --Rotate X
			playerCurrentMode[pname] = "Rotate X"
			showPromptGUI(pid)
			return true
		elseif tonumber(data) == 4 then --Rotate Y
			playerCurrentMode[pname] = "Rotate Y"
			showPromptGUI(pid)
			return true
		elseif tonumber(data) == 5 then --Rotate Z
			playerCurrentMode[pname] = "Rotate Z"
			showPromptGUI(pid)
			return true
		elseif tonumber(data) == 6 then --Scale Up
			--TODO
			tes3mp.MessageBox(pid, -1, "Not yet implemented, sorry.")
			return true
		elseif tonumber(data) == 7 then --Grab
			--TODO
			tes3mp.MessageBox(pid, -1, "Not yet implemented, sorry.")
			return true
		elseif tonumber(data) == 8 then --Close
			--Do nothing
			return true
		end
	elseif idGui == config.PromptId then
		if data ~= nil and data ~= "" and tonumber(data) then
			onEnterPrompt(pid, data)
		end
		
		playerCurrentMode[tes3mp.GetName(pid)] = nil
		return true, showMainGUI(pid)
	end
end

decorateHelpVariation.OnPlayerCellChange = function(eventStatus, pid)
	playerSelectedObject[tes3mp.GetName(pid)] = nil
end

decorateHelpVariation.OnCommand = function(pid)
	showMainGUI(pid)
end

customCommandHooks.registerCommand("decorator", decorateHelpVariation.OnCommand)
customCommandHooks.registerCommand("decorate", decorateHelpVariation.OnCommand)
customCommandHooks.registerCommand("dh", decorateHelpVariation.OnCommand)
customEventHooks.registerValidator("OnGUIAction", decorateHelpVariation.OnGUIActionDecide)
customEventHooks.registerHandler("OnObjectPlace", decorateHelpVariation.OnObjectPlace)
customEventHooks.registerHandler("OnPlayerCellChange", decorateHelpVariation.OnPlayerCellChange)