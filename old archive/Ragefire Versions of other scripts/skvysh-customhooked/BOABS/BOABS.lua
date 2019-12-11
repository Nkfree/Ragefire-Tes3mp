------------------
-- Version: 1.0 --
------------------

BOABS = {}
BOABS.FindBoots = function(eventStatus, pid)
    local fade = nil
    if Players[pid].data.customVariables.Skvysh == nil then
        Players[pid].data.customVariables.Skvysh = {}
    end
    if Players[pid].data.customVariables.Skvysh.BOABS == nil then
        Players[pid].data.customVariables.Skvysh.BOABS = false
    end
    if tableHelper.containsKeyValue(Players[pid].data.equipment, "refId", "boots of blinding speed[unique]", true) then
        if Players[pid].data.customVariables.Skvysh.BOABS == false then
            fade = true
            Players[pid].data.customVariables.Skvysh.BOABS = true
        end
    else
        if Players[pid].data.customVariables.Skvysh.BOABS == true then
            fade = false
            Players[pid].data.customVariables.Skvysh.BOABS = false
        end
    end
    if fade == true then
        logicHandler.RunConsoleCommandOnPlayer(pid, "FadeOut 1")
    elseif fade == false then
        logicHandler.RunConsoleCommandOnPlayer(pid, "FadeIn 1")
    end
end

customEventHooks.registerHandler("OnPlayerEquipment", BOABS.FindBoots)

