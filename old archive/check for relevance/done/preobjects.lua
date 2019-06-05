-- watch file in ProgessTesting











--[[ those have been added to newest corescripts

1) Open up mp-stuff\lib\lua\tableHelper.lua and add these lines to it:

function tableHelper.getAnyValue(inputTable)
    for key, value in pairs(inputTable) do
        return value
    end
end

It doesn't really matter where you add them as long as they're separated from the other functions in there.
Personally, I added them right under these lines:

function tableHelper.insertValueIfMissing(inputTable, value)
    if tableHelper.containsValue(inputTable, value, false) == false then
        table.insert(inputTable, value)
    end
end

2) Open up mp-stuff\scripts\myMod.lua(edited)
Replace these lines:

Methods.CreateObjectAtPlayer = function(pid, refId, packetType)

    local cell = tes3mp.GetCell(pid)
    local location = {
        posX = tes3mp.GetPosX(pid), posY = tes3mp.GetPosY(pid), posZ = tes3mp.GetPosZ(pid),
        rotX = tes3mp.GetRotX(pid), rotY = 0, rotZ = tes3mp.GetRotZ(pid)
    }
    local mpNum = WorldInstance:GetCurrentMpNum() + 1
    local refIndex =  0 .. "-" .. mpNum

    WorldInstance:SetCurrentMpNum(mpNum)
    tes3mp.SetCurrentMpNum(mpNum)

    LoadedCells[cell]:InitializeObjectData(refIndex, refId)
    LoadedCells[cell].data.objectData[refIndex].location = location

    if packetType == "place" then
        table.insert(LoadedCells[cell].data.packets.place, refIndex)
    elseif packetType == "spawn" then
        table.insert(LoadedCells[cell].data.packets.spawn, refIndex)
        table.insert(LoadedCells[cell].data.packets.actorList, refIndex)
    end

    LoadedCells[cell]:Save()

    tes3mp.InitializeEvent(pid)
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

With the following:

Methods.CreateObjectAtLocation = function(cell, location, refId, packetType)

    local mpNum = WorldInstance:GetCurrentMpNum() + 1
    local refIndex =  0 .. "-" .. mpNum

    WorldInstance:SetCurrentMpNum(mpNum)
    tes3mp.SetCurrentMpNum(mpNum)

    LoadedCells[cell]:InitializeObjectData(refIndex, refId)
    LoadedCells[cell].data.objectData[refIndex].location = location

    if packetType == "place" then
        table.insert(LoadedCells[cell].data.packets.place, refIndex)
    elseif packetType == "spawn" then
        table.insert(LoadedCells[cell].data.packets.spawn, refIndex)
        table.insert(LoadedCells[cell].data.packets.actorList, refIndex)
    end

    LoadedCells[cell]:Save()

    -- Are there any players on the server? If so, initialize the event
    -- for the first one we find and just send the corresponding packet
    -- to everyone
    if tableHelper.getCount(Players) > 0 then

        tes3mp.InitializeEvent(tableHelper.getAnyValue(Players).pid)
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

Methods.CreateObjectAtPlayer = function(pid, refId, packetType)

    local cell = tes3mp.GetCell(pid)
    local location = {
        posX = tes3mp.GetPosX(pid), posY = tes3mp.GetPosY(pid), posZ = tes3mp.GetPosZ(pid),
        rotX = tes3mp.GetRotX(pid), rotY = 0, rotZ = tes3mp.GetRotZ(pid)
    }

    Methods.CreateObjectAtLocation(cell, location, refId, packetType)
end
]]--

3) Find this line in myMod.lua: -- this is logicHandler.LoadCell
https://github.com/TES3MP/CoreScripts/blob/0.6.2/scripts/myMod.lua#L549
GitHub
TES3MP/CoreScripts
The serverside Lua scripts used to implement core functionality in TES3MP. - TES3MP/CoreScripts
Add this line right under it:

questFixer.AddPreexistingObjects(cellDescription)

4) Open up mp-stuff\scripts\questFixer.lua and add these lines near the top:

local preexistingObjects = {}
preexistingObjects["Tel Branora, Giron Manas's Shack"] = {
    {
        packetType = "spawn",
        refId = "bonelord",
        location = { posX = -58.224697113037, posY = 62.6845703125, posZ = 33.065208435059,
            rotX = 0.28045430779457, rotY = 0, rotZ = 2.0411622524261 }
    },
    {
        packetType = "spawn",
        refId = "rat",
        location = { posX = 143.7085723877, posY = -68.924293518066, posZ = 19.963296890259,
            rotX = 0.63480252027512, rotY = 0, rotZ = -1.3086879253387 }
    }
}

Personally, I added them right above this one:

local deadlyItems = { "keening" }

They're an example of spawning a bonelord and a rat in Giron Manas's Shack.
5) In questFixer.lua, add this function somewhere:

function questFixer.AddPreexistingObjects(cellDescription)

    if preexistingObjects[cellDescription] ~= nil then

        for arrayIndex, object in pairs(preexistingObjects[cellDescription]) do
           myMod.CreateObjectAtLocation(cellDescription, object.location, object.refId, object.packetType)
        end
    end
end

For what it's worth, I added that right under this line:

local deadlyItems = { "keening" }

6) Every time you delete "Tel Branora, Giron Manas's Shack.json" from your cell folder, check if there's always a bonelord and a rat in that cell.
