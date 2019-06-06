someMenus = {}

someMenus.cmd = function(pid, cmd)
if cmd[1] == "chat" or cmd[1] == "c" then
            local race = Players[pid].data.character.race
            local sex = ""
            
            if Players[pid].data.character.gender == 1 then
                sex = " male"
            else
                sex = " female"
            end
            
            Players[pid].currentCustomMenu = race .. sex
            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
		
		elseif cmd[1] == "test" then

            Players[pid].currentCustomMenu = "advanced example world"
            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
		
		
		elseif cmd[1] == "leather" then

            Players[pid].currentCustomMenu = "leather recipe menu"
            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
		
		--elseif cmd[1] == "tele" then

            --Players[pid].currentCustomMenu = "teleport player"
            --menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)

		elseif cmd[1] == "crafting" or cmd[1] == "craft" then

            Players[pid].currentCustomMenu = "crafting recipe menu"
            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
			
		elseif cmd[1] == "fletching" or cmd[1] == "fletch" then

            Players[pid].currentCustomMenu = "fletching recipes menu"
            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
		
		elseif cmd[1] == "poison" then

            Players[pid].currentCustomMenu = "poison tips recipes"
            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
		
		
	    elseif cmd[1] == "craft" then

        -- Check "scripts/menu/defaultCrafting.lua" if you want to change the example craft menu
        Players[pid].currentCustomMenu = "default crafting origin"
        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
		
		end
end

customCommandHooks.registerCommand("chat", someMenus.cmd)
customCommandHooks.registerCommand("test", someMenus.cmd)
customCommandHooks.registerCommand("leather", someMenus.cmd)
customCommandHooks.registerCommand("tele", someMenus.cmd)
customCommandHooks.registerCommand("crafting", someMenus.cmd)
customCommandHooks.registerCommand("fletching", someMenus.cmd)
customCommandHooks.registerCommand("poison", someMenus.cmd)
customCommandHooks.registerCommand("craft", someMenus.cmd)