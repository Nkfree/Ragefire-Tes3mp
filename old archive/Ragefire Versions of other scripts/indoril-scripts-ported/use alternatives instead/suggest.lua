suggest = {}
-- just open a suggestion channel in your discord intead



--[[ put on top of serverCore.lua
suggest = require("suggest")

add in OnGUIAction in serverCore.lua

	if suggest.OnGUIAction(pid, idGui, data) then return end

and in the command Chain in commmandHandler.lua

	elseif cmd[1] == "suggest" then
		suggest.OnCommand(pid)
		
	
		]]
		
		
suggest.OnCommand = function(pid)

tes3mp.CustomMessageBox(pid,2673,"What do you want to suggest to this cell?","ESP Edit;Quest;Other")

end


suggest.MakeEntry = function(pid, SugType, data)

	local myCell = tes3mp.GetCell(pid)
	local SuggestContainers = {}
	
	if tes3mp.GetCaseInsensitiveFilename(os.getenv("MOD_DIR").."/","SuggestContainers.json") == "invalid" then
		jsonInterface.save("SuggestContainers.json", SuggestContainers)
	else
		SuggestContainers = jsonInterface.load("SuggestContainers.json")
	end
	
	
		if SuggestContainers[myCell] ~= nil then
			table.insert(SuggestContainers[myCell],{key = SugType, sug = data, player = Players[pid].name})
		else
			SuggestContainers[myCell] = {{key = SugType, sug = data, player = Players[pid].name}}
		end
	
	jsonInterface.save("SuggestContainers.json", SuggestContainers)
	
	tes3mp.SendMessage(pid,"thx for your suggest\n",false)
end


suggest.OnGUIAction = function(pid, idGui, data)

if idGui == 2673 then
	if tonumber(data) == 0 then
		tes3mp.InputDialog(pid, 2674, "What should be edited here?","")
	elseif tonumber(data) == 1 then
		tes3mp.InputDialog(pid, 2675, "Which Quest would be neat in here? Only kill or grab item quests","")
	elseif tonumber(data) == 2 then
		tes3mp.InputDialog(pid, 2676, "What else you wanan suggest?","")
	end
end

if idGui == 2674 then
	suggest.MakeEntry(pid, "edit", data)
end

if idGui == 2675 then
	suggest.MakeEntry(pid, "quest", data)
end

if idGui == 2676 then
	suggest.MakeEntry(pid, "other", data)
end


end

return suggest