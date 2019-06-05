-- rage menu

rage = {}

rage.cmd = function(pid, cmd)
			local currentRageLevel = Players[pid].data.customVariables.rageLevel
			local baseXp = 100
			local nextLevel = math.floor(baseXp *((currentRageLevel + 1) ^ 2.5) / 2)
			local nextLevelTotal = math.floor(baseXp *((currentRageLevel) ^ 2.5) / 2)
			local expTowardsNextLevel = nextLevel - Players[pid].data.customVariables.rageExp
			local expForNextLevel = nextLevel - nextLevelTotal
			if currentRageLevel == 0 then
				Players[pid].data.customVariables.rageExpProgress = expForNextLevel - expTowardsNextLevel
				Players[pid].data.customVariables.rageExpRequired = nextLevel - nextLevelTotal + 60
				Players[pid].data.customVariables.rageExpPercentage = math.floor(Players[pid].data.customVariables.rageExpProgress / Players[pid].data.customVariables.rageExpRequired * 100)
				Players[pid].currentCustomMenu = "ragepoint main"
				menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)		
			elseif currentRageLevel == 1 then
				Players[pid].data.customVariables.rageExpProgress = expForNextLevel - expTowardsNextLevel - 60
				Players[pid].data.customVariables.rageExpRequired = nextLevel - nextLevelTotal - 60
				Players[pid].data.customVariables.rageExpPercentage = math.floor(Players[pid].data.customVariables.rageExpProgress / Players[pid].data.customVariables.rageExpRequired * 100)
				Players[pid].currentCustomMenu = "ragepoint main"
				menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
			else			
			Players[pid].data.customVariables.rageExpProgress = expForNextLevel - expTowardsNextLevel
			Players[pid].data.customVariables.rageExpRequired = nextLevel - nextLevelTotal
			Players[pid].data.customVariables.rageExpPercentage = math.floor(Players[pid].data.customVariables.rageExpProgress / Players[pid].data.customVariables.rageExpRequired * 100)
			Players[pid].currentCustomMenu = "ragepoint main"
			menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
			end
end
			
customCommandHooks.registerCommand("rage", rage.cmd)