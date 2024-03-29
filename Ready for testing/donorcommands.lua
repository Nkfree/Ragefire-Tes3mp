-- donor commands
-- by NkFree
--[[ Donor Commands ]]--


donor = {}

donor.title = function(pid, cmd)	
	if cmd[2] ~= nil then

		local player = Players[pid]
		local donorSettings = player.data.donorSettings

		if donorSettings == nil or donorSettings.tier < 1 then
			tes3mp.SendMessage(pid, "Sorry, but you are not a donor.\n")
		elseif string.len(cmd[2]) > 12  then
			tes3mp.SendMessage(pid, "Sorry, but your title cannot be longer than 12 characters.\n")
		elseif string.find(cmd[2], "#") then
			tes3mp.SendMessage(pid, "You cannot set your color with the /title command. " ..
				"You want to use /titlecolor instead.\n")
		else
			donorSettings.title = cmd[2]
			tes3mp.SendMessage(pid, "Your title is now " .. donorSettings.title .. "\n")
		end
	end
end

donor.titleColor = function(pid, cmd)
		
	if cmd[2] ~= nil then

		local player = Players[pid]
		local donorSettings = player.data.donorSettings
		local desiredColor = cmd[2]

		if donorSettings == nil or donorSettings.tier < 1 then
			tes3mp.SendMessage(pid, "Sorry, but you are not a donor.\n")
		elseif donorSettings.tier < 2 then
			tes3mp.SendMessage(pid, "Sorry, but you need to be at least a tier 2 donor in order to set your color.\n")
		elseif color[desiredColor] then
			donorSettings.color = desiredColor
			tes3mp.SendMessage(pid, "Your color is now " .. donorSettings.color .. "\n")
		else
			tes3mp.SendMessage(pid, "That is not a valid color. Please use one of the supported color names: " ..
				tableHelper.concatenateFromIndex(tableHelper.getArrayFromIndexes(color), 1, ", ") .. "\n")
		end
	end
end

donor.setDonorTier = function(pid, cmd)
			
    if cmd[2] ~= nil and moderator and logicHandler.CheckPlayerValidity(pid, cmd[2]) then

        local tier = tonumber(cmd[3])

        if tier == nil or type(tier) ~= "number" then
            tes3mp.SendMessage(pid, "Please use a correct number for the tier you want this player to have, as in:\n"
                .. "/setdonortier <pid> <tier>\n")
        else
            local targetPid = tonumber(cmd[2])
            local targetPlayer = Players[targetPid]

            if tier > 0 then

                if targetPlayer.data.donorSettings == nil then
                    targetPlayer.data.donorSettings = {}
                end

                targetPlayer.data.donorSettings.tier = tier

                if targetPlayer.data.donorSettings.title == nil then
                    targetPlayer.data.donorSettings.title = "Donor"
                end

                if targetPlayer.data.donorSettings.color == nil then
                    targetPlayer.data.donorSettings.color = config.defaultDonorColor
                end

                tes3mp.SendMessage(pid, targetPlayer.accountName .. " is now recorded as being a tier " ..
                    tostring(tier) .. " donor.\n")
            else
                targetPlayer.data.donorSettings = nil
                tes3mp.SendMessage(pid, targetPlayer.accountName .. " is no longer recorded as being a donor.\n")
            end

            targetPlayer:Save()
        end
	end
end

customCommandHooks.registerCommand("title", donor.title)
customCommandHooks.registerCommand("titlecolor", donor.titleColor)
customCommandHooks.registerCommand("setdonortier", donor.setDonorTier)

return donor