------------------
-- Version: 1.0 --
------------------

require("color")
local RPRolls = {}
local attributeArray = {"strength", "intelligence", "willpower", "agility", "endurance", "speed", "personality", "luck"}
local skillArray = {"block", "armorer", "mediumarmor", "heavyarmor", "blunt", "longblade", "axe", "spear", "athletics",
"enchant", "destruction", "alteration", "illusion", "conjuration", "mysticism", "restoration", "alchemy", "unarmored",
"security", "sneak", "acrobatics", "lightarmor", "shortblade", "marksman", "mercantile", "speechcraft", "handtohand"}

RPRolls.DoRoll = function(pid, cmd)
local rollCheck = cmd[2]
math.randomseed(os.time())
    local cellDescription = Players[pid].data.location.cell
    local playerName = logicHandler.GetChatName(pid)
    local message
    local rollCheckId
    local rollCheckValue
    local roll
    local maxroll
    local isAttribute = true
    local found = false
    local i
    for i = 1, 8 do -- go through all attributes and then skills and try to find a match
        if rollCheck == attributeArray[i] then
            isAttribute = true
            found = true
            rollCheckId = i-1
        end
    end
    if found == false then
        for i = 1, 27 do
            if rollCheck == skillArray[i] then
                isAttribute = false
                found = true
                rollCheckId = i-1
            end
        end
    end
    if found == true then
        if isAttribute == true then
            rollCheckValue = tes3mp.GetAttributeBase(pid, rollCheckId)
        else
            rollCheckValue = tes3mp.GetSkillBase(pid, rollCheckId)
        end
        maxroll = 100-rollCheckValue -- calculate how much is already guarnateed - the lower the number, the better
        if maxroll < 1 then
            maxroll = 1
        end
        math.random() -- pre-roll to ensure more randomized numbers
        roll = math.random(0,maxroll) + rollCheckValue
        if roll > 100 then
            roll = 100
        end
        message = color.ForestGreen .. playerName .. " rolled " .. roll .. " on " .. rollCheck .. " check.\n" .. color.Default
        if logicHandler.IsCellLoaded(cellDescription) == true then
            for index, visitorPid in pairs(LoadedCells[cellDescription].visitors) do
                tes3mp.SendMessage(visitorPid, message, false)
            end
        end
    else
        message = color.ForestGreen .. "Invalid attribute/skill.\n" .. color.Default
        tes3mp.SendMessage(pid, message, false)
    end
end

customCommandHooks.registerCommand("roll", RPRolls.DoRoll)
