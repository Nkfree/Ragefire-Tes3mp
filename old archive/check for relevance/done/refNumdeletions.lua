-- watch file in ProgessTesting










-- check: https://github.com/Schnibbsel/tes3mpRagefire/blob/master/scriptsToBePorted/Instructions/deleteme1.txt
-- use this in contentfixer to outsource refNumDeletionsByCell
refNumDeletionsByCell = jsonInterface.load("refNumDeletionsByCell.json")

-- delte command in commandhandler
elseif cmd[1] == "deletemode" and moderator then

			-- Enables deletemode- activate object to delete it
			Players[pid].data.deletemode = true
			tes3mp.SendMessage(pid, "Entering deletemode.\n")
			
			elseif cmd[1] == "offdelete" and moderator then
			-- Disables deletemode
			Players[pid].data.deletemode = false
			tes3mp.SendMessage(pid, "leaving deletemode.\n")
