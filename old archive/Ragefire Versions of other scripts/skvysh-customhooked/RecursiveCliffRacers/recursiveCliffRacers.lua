------------------
-- Version: 1.0 --
------------------

require("color")
RCR = {}
RCR.HitIt = function(eventStauts, pid)
    local killId -- get the ID of the killed creature by this player (wonky on pre-0.7 because the PID with autohority in the cell is the PID sent)
    local cliffRacerIds = {"cliff racer", "cliff racer_diseased", "cliff racer_blighted"} -- cliff racer IDs, add more if your mods have more cliff racer variations
    local consoleCommand -- console command string
    local sendMessage = true -- set to false if you don't want to display taunt message to the player
    local cliffRacerCount = 2 -- how many cliff racers to spawn for each cliff racer killed
    local i, j -- loop variables
    for i = 1, 3 do -- increase the second number if you have more cliff racer IDs
	for j = 0, tes3mp.GetKillChangesSize(pid) - 1 do
            killId = tes3mp.GetKillRefId(pid, j)
            if killId == cliffRacerIds[i] then
                consoleCommand = "placeatpc, \"" .. killId .. "\"," .. cliffRacerCount .. ",1,1"
                if sendMessage == true then
                    tes3mp.MessageBox(pid, -1, color.Red .. "The cliff racer God laughs at you" .. color.Default) -- change the message if you want to
                end
                logicHandler.RunConsoleCommandOnPlayer(pid, consoleCommand)
            end
        end
    end
end

customEventHooks.registerHandler("OnWorldKillCount", RCR.HitIt)