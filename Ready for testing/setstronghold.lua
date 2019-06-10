setstronghold = {}

setstronghold.login = function(eventStatus, pid)

if eventStatus.validCustomHandlers then --check if some other script made this event obsolete

		logicHandler.RunConsoleCommandOnPlayer(self.pid, "set Stronghold to 4")
		logicHandler.RunConsoleCommandOnPlayer(self.pid, "set Stronghold to 5")
		logicHandler.RunConsoleCommandOnPlayer(self.pid, "set Stronghold to 6")
end
end


customEventHooks.registerHandler("OnPlayerFinishLogin", setstronghold.login)