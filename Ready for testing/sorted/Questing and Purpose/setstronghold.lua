setstronghold = {}

setstronghold.login = function(eventStatus, pid)

		logicHandler.RunConsoleCommandOnPlayer(self.pid, "set Stronghold to 4")
		logicHandler.RunConsoleCommandOnPlayer(self.pid, "set Stronghold to 5")
		logicHandler.RunConsoleCommandOnPlayer(self.pid, "set Stronghold to 6")
end


customEventHooks.registerHandler("OnPlayerFinishLogin", setstronghold.login)