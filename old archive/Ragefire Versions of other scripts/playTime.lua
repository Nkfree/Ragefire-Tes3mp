--- old thingy by skvysh
--- maybe port this to customhooks but isnt rly necessary


--------------------
-- Version: 1.0.1 --
--------------------

local playTime = {}
local playTimeGuiID = 01245780
playTime.UpdatePlayTime = function()
    for pid, player in pairs(Players) do
        if Players[pid] ~= nil and player:IsLoggedIn() then
            local playTime = Players[pid].data.customVariables.playTime
            if playTime ~= nil then
                playTime = playTime + 1
            else
                playTime = 0
            end
            Players[pid].data.customVariables.playTime = playTime
        end
    end
end

playTime.ShowPlayTime = function(pid)
    local timeString = playTime.GetTimeString(pid, false)
    local message = "You have been playing for " .. timeString
    tes3mp.MessageBox(pid, -1, message)
end

playTime.GetConnectedPlayersPlayTime = function()
    local lastPid = tes3mp.GetLastPlayerId()
    local list = ""
    local divider = ""
    for i = 0, lastPid do
        if i == lastPid then
            divider = ""
        else
            divider = "\n"
        end
        if Players[i] ~= nil and Players[i]:IsLoggedIn() then
            local timeString = playTime.GetTimeString(i, true)
            list = list .. tostring(Players[i].name)
            list = list .. " (ID: " .. tostring(Players[i].pid) .. ") "
            list = list .. "play time: " ..  timeString
            list = list .. divider
        end
    end
    return list
end

playTime.ShowPlayTimeAllConnected = function(pid)
    local label = "Connected players' play time"
    tes3mp.ListBox(pid, playTimeGuiID, label, playTime.GetConnectedPlayersPlayTime())
end

playTime.GetTimeString = function(pid, returnList)
    local playTime = Players[pid].data.customVariables.playTime
    local timeString = ""
    local mod
    local timeArray = {0, 0, 0}
    local timeSection = {86400, 3600, 60}
    local timeName
    local div1
    local div2
    local plural
    local dot
    if returnList == false then
        timeName = {" day", " hour", " minute", " second"}
        div1 = ", "
        div2 = " and "
        plural = "s"
        dot = "."
    else
        timeName = {"d", "h", "m", "s"}
        div1 = " "
        div2 = " "
        plural = ""
        dot = ""
    end
    for i = 1, 3 do
        mod = playTime % timeSection[i]
        timeArray[i] = (playTime - mod) / timeSection[i]
        if timeArray[i] > 0 then
            if i > 1 then
                if timeArray[i-1] > 0 then
                    if mod ~= 0 then
                        timeString = timeString .. div1 .. timeArray[i]
                    else
                        timeString = timeString .. div2 .. timeArray[i]
                    end
                else
                    timeString = timeString .. timeArray[i]
                end
            else
                timeString = timeArray[i]
            end
            if timeArray[i] > 1 then
                timeString = timeString .. timeName[i] .. plural
            else
                timeString = timeString .. timeName[i]
            end
        end
        playTime = mod
    end
    if mod ~= 0 then
        if timeString ~= "" then
            if mod > 1 then
                timeString = timeString .. div2 .. mod .. timeName[4] .. plural .. dot
            else
                timeString = timeString .. div2 .. mod .. timeName[4] .. dot
            end
        else
            if mod > 1 then
                timeString = mod .. timeName[4] .. plural .. dot
            else
                timeString = mod .. timeName[4] .. dot
            end
        end
    end
    return timeString
end

return playTime