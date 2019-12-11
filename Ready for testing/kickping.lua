
kickping = {}

kickping = function(eventStatus, pid)

if eventStatus.validCustomHandlers then --check if some other script made this event obsolete
	local currentPing = tes3mp.GetAvgPing(pid)
	if currentPing >= 250 then tes3mp.Kick(pid) end
end
end


customEventHooks.registerHandler("OnPlayerCellChange", kickping)