-- display player cells

snippets = {}

snippets.cells = function(pid, cmd)

 
        local mess = ""
        for pd, pl in pairs(Players) do
            if pl:IsLoggedIn() then
            --if partySystem.utils.IsPlayerInAnyParty(pid) then
                mess = mess ..color.LightGreen.. pl.name..": ".. color.White .. tes3mp.GetCell(pd)..color.Default.."\n"
            --else
              --  mess = mess ..color.BlueViolet.. pl.name..": ".. color.White .. tes3mp.GetCell(pd)..color.Default.."\n"
            --end     
        end        
    end
        mess = mess.. ""
         tes3mp.ListBox(pid, -1, color.White .. "Player Locations: " .. color.LightGreen .. "Green " .. color.White .. "names are in a " .. color.LightGreen .. "Party", mess)


end

		 
		 
customCommandHooks.registerCommand("cells", snippets.cells)