-- bloodmoon stop put into contentfixer
stopbloodmoon = {}

bloodmoonTable = {"-16, 18","-15, 18","-14, 18","-13, 18","-22, 16","-23, 16","-24, 16","-25, 16","-26, 16","-27, 16","-28, 16","-28, 17","-28, 18","-28, 19","-28, 20","-28, 21","-28, 22","-24, 15",
"-21, 16","-20, 16","-19, 16","-18, 16","-17, 16","-17, 17","-17, 18","-17, 19","-17, 20","-17, 21","-17, 22","-17, 23","-17, 24","-17, 25","-17, 26","-17, 27","-18, 27","-19, 27","-20, 27","-21, 27",
"-22, 27","-23, 27","-24, 27","-25, 27","-26, 27","-27, 27","-28, 27","-28, 26","-28, 25","-28, 24","-28, 23","-22, 17","-21, 17"}

stopbloodmoon = function(eventStatus, pid)

    local cell = tes3mp.GetCell(pid)

    if tableHelper.containsValue(bloodmoonTable, cell) == true then
        tes3mp.CustomMessageBox(pid, -1, color.Gold .. "Bloodmoon\n\n" .. color.White .. "Currently: " .. color.Yellow .. "Unavailable\n\n" ..
			color.White .. "Release Date: " .. color.Yellow .. "Unannounced", "Ok")
				customEventHooks.makeEventStatus(false, false)
	end

end
			
customEventHooks.registerValidator("OnPlayerCellChange", stopbloodmoon)