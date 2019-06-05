-- compare with https://github.com/Schnibbsel/tes3mpRagefire/blob/master/scriptsToBePorted/Instructions/preobjects.txt
-- combine with https://github.com/Schnibbsel/tes3mpRagefire/blob/master/scriptsToBePorted/OwnScriptFiles/saveme.lua
-- maybe together with refNum stuff:
-- https://github.com/Schnibbsel/tes3mpRagefire/blob/master/scriptsToBePorted/Instructions/deleteme1.txt
--custom preObjects


-- check: https://pastebin.com/KJQFxYPU

jsonInterface = require("jsonInterface")

local preexistingObjects = {}
preexistingObjects = jsonInterface.load("preObjects.json")

function contentFixer.AddPreexistingObjects(cellDescription)
if WorldInstance.data.myUniques == nil then WorldInstance.data.myUniques = {} end
    if preexistingObjects[cellDescription] ~= nil then

        for arrayIndex, object in pairs(preexistingObjects[cellDescription]) do
            local unqIndex = logicHandler.CreateObjectAtLocation(cellDescription, object.location, object.refId, object.packetType)
            table.insert(WorldInstance.data.myUniques, unqIndex)
        end

        LoadedCells[cellDescription].forceActorListRequest = true
    end
end
