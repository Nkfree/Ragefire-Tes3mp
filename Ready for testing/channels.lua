--channels should be as easy as this

            --in function OnPlayerSendMessage in eventHandler.lua
            --replace tes3mp.SendMessage(pid, message, true) with 
channels = {}
channels.message = function(eventStatus, pid, message)

			if message:sub(1, 1) == '/' then

                local command = (message:sub(2, #message)):split(" ")
                commandHandler.ProcessCommand(pid, command)
            else
                local message = color.White .. logicHandler.GetChatName(pid) .. ": " .. message .. "\n"

                -- Check for chat overrides that add extra text
                if Players[pid]:IsServerStaff() then

                    if Players[pid]:IsServerOwner() then
                        message = config.rankColors.serverOwner .. "[Owner] " .. message
                    elseif Players[pid]:IsAdmin() then
                        message = config.rankColors.admin .. "[Admin] " .. message
                    elseif Players[pid]:IsModerator() then
                        message = config.rankColors.moderator .. "[Mod] " .. message
                    end
                end

                for pd, pl in pairs(Players) do
                if pl.data.customVariables.ChatChannel == nil then Players[pd].data.customVariables.ChatChannel = 1 end
				if pl.data.customVariables.ChatChannel == Players[pid].data.customVariables.ChatChannel then
						tes3mp.SendMessage(pd, message, false)
					end
				end
            end
			return customEventHooks.makeEventStatus(false, false)
end			
            --place at beginning of function OnPlayerConnect in serverCore
channels.connect = function(eventStatus, pid)
            Players[pid].data.customVariables.ChatChannel = 1
end

            --make command in cmdChain
channels.cmd = function(pid, cmd)
            if cmd[1] == "channel" and cmd[2] ~= nil then
                Players[pid].data.customVariables.ChatChannel = tonumber(cmd[2])
                tes3mp.SendMessage(pid,"You changed to Chat Channel "..cmd[2].."\n")
            elseif cmd[1] == "mainchannel" then
                Players[pid].data.customVariables.ChatChannel =1
                tes3mp.SendMessage(pid,"You changed to Chat Channel main\n")
			end
end


customCommandHooks.registerCommand("channel", channels.cmd)
customCommandHooks.registerCommand("mainchannel", channels.cmd)
customEventHooks.registerHandler("OnPlayerConnect", channels.connect)
customEventHooks.registerValidator("OnPlayerSendMessage", channels.message)