
kickping = {}

kickping = function(eventStatus, pid)

	local currentPing = tes3mp.GetAvgPing(pid)
	if currentPing >= 250 then kick(pid) end

end


customEventHooks.registerHandler("OnPlayerCellChange", kickping)