--responding

responding = {}

responding.message = function(pid, cmd)
        if pid == tonumber(cmd[2]) then
            tes3mp.SendMessage(pid, "You can't message yourself.\n")
        elseif cmd[3] == nil then
            tes3mp.SendMessage(pid, "You cannot send a blank message.\n")
        elseif logicHandler.CheckPlayerValidity(pid, cmd[2]) then
            local targetPid = tonumber(cmd[2])
            local targetName = Players[targetPid].name
            message = logicHandler.GetChatName(pid) .. " to " .. logicHandler.GetChatName(targetPid) .. ": "
            message = message .. tableHelper.concatenateFromIndex(cmd, 3) .. "\n"
            Players[targetPid].data.lastmessaged = pid
                Players[pid].data.lastmessaged = pid
            tes3mp.SendMessage(pid, message, false)
            tes3mp.SendMessage(targetPid, message, false)
        end
end    

responding.respond = function(pid, cmd)	
      if Players[pid].data.lastmessaged ~= nil then
        if logicHandler.CheckPlayerValidity(pid, Players[pid].data.lastmessaged) then
            
            local targetPid = tonumber(Players[pid].data.lastmessaged)
            local targetName = Players[targetPid].name
            message = logicHandler.GetChatName(pid) .. " to " .. logicHandler.GetChatName(targetPid) .. ": "
            message = message .. tableHelper.concatenateFromIndex(cmd, 2) .. "\n"
            Players[targetPid].data.lastmessaged = pid
            tes3mp.SendMessage(pid, message, false)
            tes3mp.SendMessage(targetPid, message, false)
        end
      else
         tes3mp.SendMessage(pid, "you need to /msg someone first.",false)
      end
end


customCommandHooks.registerCommand("msg", responding.message)
customCommandHooks.registerCommand("message", responding.message)
customCommandHooks.registerCommand("r", responding.respond)
customCommandHooks.registerCommand("respond", responding.respond)