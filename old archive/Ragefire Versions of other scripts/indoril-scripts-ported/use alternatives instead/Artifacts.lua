--Artifacts.lua
-- This Script shouts out a Message if Player obtains a Weapon Artifact

--Put --[[   Artifacts = require("Artifacts")     ]] on top of serverCore.lua

--Replace function OnPlayerInventory in serverCore.lua
--[[ 

function OnPlayerInventory(pid)
    tes3mp.LogMessage(enumerations.log.INFO, "Called \"OnPlayerInventory\" for " .. logicHandler.GetChatName(pid))
    eventHandler.OnPlayerInventory(pid)
	Artifacts.ShowArtifact(pid)
end

]]


color  = require("color")

Artifacts = {}



Artifacts.ShowArtifact = function(pid)
local slotcount= tes3mp.GetInventoryChangesSize(pid) - 1
local itemRefId = tes3mp.GetInventoryItemRefId(pid, slotcount)
local lastArtifact = Players[pid].data.customVariables.lastObtained
if tableHelper.containsValue(artifactsTable, itemRefId) and itemRefId ~= lastArtifact then
tes3mp.SendMessage(pid,"The Player "..color.Red..Players[pid].name..color.Default .. " has obtained "..color.Red.."["..itemRefId.."]"..color.Default.."\n", true)
Players[pid].data.customVariables.lastObtained = itemRefId
end

end

return Artifacts