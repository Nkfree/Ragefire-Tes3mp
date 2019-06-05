-- ability commands

ability = {}

ability.cmd = function(pid, cmd)
--[[ Rage and Race Abilities ]]--

		if cmd[1] == "night" and cmd[2] == "off" and Players[pid].data.customVariables.stealthHunterInTheNight == 1 and Players[pid].data.character.race == "khajiit" then
			logicHandler.RunConsoleCommandOnPlayer(pid, "removespell hunter_in_the_night")
			logicHandler.RunConsoleCommandOnPlayer(pid, "removespell eye_of_night")

		elseif cmd[1] == "night" and cmd[2] == "off" and Players[pid].data.customVariables.stealthHunterInTheNight == 1 and Players[pid].data.character.race ~= "khajiit" then
			logicHandler.RunConsoleCommandOnPlayer(pid, "removespell hunter_in_the_night")

		elseif cmd[1] == "night" and cmd[2] == "off" and Players[pid].data.customVariables.stealthHunterInTheNight == 0 and Players[pid].data.character.race == "khajiit" then
			logicHandler.RunConsoleCommandOnPlayer(pid, "removespell eye_of_night")

		elseif cmd[1] == "night" and cmd[2] == "on" and Players[pid].data.customVariables.stealthHunterInTheNight == 1 and Players[pid].data.character.race == "khajiit" then
			logicHandler.RunConsoleCommandOnPlayer(pid, "addspell hunter_in_the_night")
			logicHandler.RunConsoleCommandOnPlayer(pid, "addspell eye_of_night")

		elseif cmd[1] == "night" and cmd[2] == "on" and Players[pid].data.customVariables.stealthHunterInTheNight == 1 and Players[pid].data.character.race ~= "khajiit" then
			logicHandler.RunConsoleCommandOnPlayer(pid, "addspell hunter_in_the_night")

		elseif cmd[1] == "night" and cmd[2] == "on" and Players[pid].data.customVariables.stealthHunterInTheNight == 0 and Players[pid].data.character.race == "khajiit" then
			logicHandler.RunConsoleCommandOnPlayer(pid, "addspell eye_of_night")

		elseif cmd[1] == "water" and cmd[2] == "on" and Players[pid].data.character.race == "argonian" then
			logicHandler.RunConsoleCommandOnPlayer(pid, 'addspell "argonian_breathing"')

		elseif cmd[1] == "water" and cmd[2] == "off" and Players[pid].data.character.race == "argonian" then
			logicHandler.RunConsoleCommandOnPlayer(pid, 'removespell "argonian_breathing"')		
		end
end
--[[ End Rage Abilities ]]--


customCommandHooks.registerCommand("night", ability.cmd)
customCommandHooks.registerCommand("water", ability.cmd)