
tableHelper = require("tableHelper")
require("enumerations")
require("time")


--[[
THIS SCRIPT JAILS Players
   --/jail pid 2302 //adds someone to jail with time in seconds
   --/addjailer pid //adds moderator able to jail
   --/removejailer pid //removes moderator able to jail
   --/unjail pid //removes player from jail before time
		
by Xenkahn https://github.com/Xenkhan/tes3mp-jail/
reworked for 0.7 by discordpeter

>>INSTALL 

--put jail.json into mp-stuff/data


--put on top of serverCore.lua
jail = require("jail")


--put as own function in serverCore.lua
function UnjailPlayer(pid)
    jail.UnjailPlayer(pid)
end

put at the end of OnServerInit  in serverCore.lua
jail.Init()

put at the end of OnServerExit in serverCore.lua
jail.Save()

put at the end of OnPlayerCellChange in serverCore.lua
jail.CheckCellChange(pid)

put on top of player/base.lua
jail = require("jail")

in player/base.lua in line247 after self:LoadCell() add
jail.JailedRejoin(self.pid)

in cmdChain in commandHandler.lua add

	  elseif jail.ParseCommand(pid, cmd, moderator) == true then
	          -- do nothing
			  
]]--

jail = {}


jail.Data = {}

jail.Init = function()  --Call on OnServerInit after mymod
	jail.Data = jsonInterface.load("jail.json")
end

jail.Save = function() --Call OnServerExit after mymod
	jsonInterface.save("jail.json", jail.Data)

end

jail.TeleportPlayer = function(pid) -- teleports player to jail
	local cellName = jail.Data.jailData.cell
	local x = tonumber(jail.Data.jailData.posx)
	local y = tonumber(jail.Data.jailData.posy)
	local z = tonumber(jail.Data.jailData.posz)
	
	tes3mp.SetCell(pid, cellName)
	tes3mp.SendCell(pid)
	tes3mp.SetPos(pid, x, y, z)
	tes3mp.SendPos(pid)
end

jail.UnjailPlayer = function(pid) -- unjails player
	local name = Players[pid].name
    
    if jail.Data.jailed[name] == nil then
    	return
    end

    tes3mp.Resurrect(pid, enumerations.resurrect.IMPERIAL_SHRINE)
    tes3mp.Jail(pid, tonumber(jail.Data.jailed[name].jailTime) / jail.Data.jailRate, true, true, "Spending time in Jail", "You have been unjailed.")

    tes3mp.LogMessage(0, name .. " unjailed \n")


    tes3mp.SendMessage(pid, color.Error ..jail.Data.jailMessage.onunjail .. color.Default, false)
    jail.Data.jailed[name] = nil
    jsonInterface.save("jail.json", jail.Data)
end




jail.ParseCommand = function(pid, cmd, isMod)
	local name = Players[pid].name

	local targetpid = tonumber(cmd[2])
	if Players[targetpid] == nil then
		return false
	end
	

	if cmd[1] == "jail" and cmd[2] ~= nil and cmd[3] ~= nil and tableHelper.containsValue(jail.Data.jailers, name) == true then
	
		if jail.Data.jailed[name] == nil then
			local jailed = {}
			jailed.startTime = os.time(os.date("!*t"))
			jailed.jailTime = tonumber(cmd[3])
			jail.jailer = Players[pid].name
			
			
			jail.Data.jailed[name] = jailed
			
			jsonInterface.save("jail.json", jail.Data)
			
			tes3mp.SendMessage(pid, color.Green .. "User jailed.     \n".. color.Default, false)
			

			

			jail.TeleportPlayer(targetpid)
			tes3mp.SendMessage(targetpid, color.Error .. jail.Data.jailMessage.onjail .. color.Default, false)
			
			
		
			Players[pid].unjailTimer = tes3mp.CreateTimerEx("UnjailPlayer", time.seconds(jailed.jailTime), "i", targetpid)
			tes3mp.StartTimer(Players[pid].unjailTimer)


		else
			tes3mp.SendMessage(pid, color.Error .. "User is already jailed. \n".. color.Default, false)
		end
	
	elseif cmd[1] == "addjailer" and cmd[2] ~= nil and isMod then
		table.insert(jail.Data.jailers, Players[targetpid].name)
		jsonInterface.save("jail.json", jail.Data)

		tes3mp.SendMessage(pid, color.Green .. "User added to people able to jail.     \n" .. color.Default, false)

	elseif cmd[1] == "removejailer" and cmd[2] ~= nil and isMod then

		jail.Data.jailers[Players[targetpid].name] = nil
  		jsonInterface.save("jail.json", jail.Data)

		tes3mp.SendMessage(pid, color.Green .. "User removed from people able to jail.     \n" .. color.Default, false)
	elseif cmd[1] == "unjail" and cmd[2] ~= nil and tableHelper.containsValue(jail.Data.jailers, name) == true then
		UnjailPlayer(targetpid)

		tes3mp.SendMessage(pid, color.Green .. "User unjailed.     \n" .. color.Default, false)

		
	else
		return false
	end
	
	return true
end

jail.CheckCellChange = function(pid) --OnPlayerCellChange after mymod
	local name = Players[pid].name
	
	if jail.Data.jailed[name] ~= nil and Players[pid].loggedIn then

		local cellName = tes3mp.GetCell(pid)
		
		tes3mp.LogMessage(0, cellName .. " " .. jail.Data.jailData.cell)

		if cellName ~= jail.Data.jailData.cell then

		

			jail.TeleportPlayer(pid)
			tes3mp.SendMessage(pid, color.Error .. jail.Data.jailMessage.onleave .. color.Default, false)

		end
	end
end

jail.JailedRejoin = function(pid) -- player/base.lua line 156
	local name = Players[pid].name

	if jail.Data.jailed[name] ~= nil then
		local currentTime = os.time(os.date("!*t"))
		local startTime = tonumber(jail.Data.jailed[name].startTime)
		
		local jailTime = tonumber(jail.Data.jailed[name].jailTime)
		local elapsedTime = startTime - currentTime
		
	

		if startTime < jailTime + currentTime then
			UnjailPlayer(pid)
			
			return
		end
		
		Players[pid].unjailTimer = tes3mp.CreateTimerEx("UnjailPlayer", time.seconds(jailTime), "i", pid)
		tes3mp.StartTimer(Players[pid].unjailTimer)
	end
end



return jail