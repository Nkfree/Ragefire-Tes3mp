-- dungeon difficulty in eventhandler cell change

dungeoncreation = {}

-- required tables


-- Home Cities
homecityTable = {"-3, -2","-2, 2","-2, -9","6, -7","-22, 17","Mournhold, Temple Courtyard",
"Sotha Sil, Outer Flooded Halls","-9, 16","-11, 11","-4, 18","7, 22","11, 14","13, 14","15, 5",
"17, 4","15, 1","13, -8","14, -13","3, -10","-6, -5","-8, 3","-2, 6", "-9, 17"}
-- PvP
pvpTable = {"Vivec, Arena Pit"}


-- [[ Dungeon Creation ]]--

-- Dungeon Tier Message
-- Tier 1
tier1MessageTable = {"Sarano Ancestral Tomb","Mudan Grotto","Mudan, Lost Dwemer Checkpoint","Lleran Ancestral Tomb","Indalen Ancestral Tomb","Arkngthand, Hall of Centrifuge","Arkngthand, Weepingbell Hall","Arkngthand, Heaven's Gallery","Tharys Ancestral Tomb","Shulk Egg Mine","Shulk Egg Mine, Mining Camp","Addamasartus"}
-- Tier 2
tier2MessageTable = {"Hassour", "Mzahnch","Mzahnch Lower Level","Mamaea, Sanctum of Awakening","-2, 12","Urshilaku, Laterus Burial","Urshilaku, Kakuna Burial","Urshilaku, Kefka Burial","Urshilaku, Astral Burial","Urshilaku, Karma Burial","Urshilaku, Fragile Burial","Arkngthand, Cells of Hollow Hand",
"Arkngthand, Land's Blood Gallery","Arkngthand, Deep Ore Passage","Shulk Egg Mine, Queen's Lair","Shurdan-Raplay Egg Mine","Zainsipilu","Thelas Ancestral Tomb","Andrano Ancestral Tomb",
"Urshilaku, Juno Burial","Mamaea, Sanctum of Black Hope","Vivec, St. Olms Underworks","Samarys Ancestral Tomb"}
-- Tier 3 
tier3MessageTable = {"Hassour, Shrine","Assarnatamat, Shrine","Rothan Ancestral Tomb","Kogoruhn, Nabith Waterway","Kogoruhn, Hall of Maki","Omaren Ancestral Tomb","Kogoruhn, Hall of Phisto","Ald Redaynia, Tower","Kogoruhn, Dome of Pollock's Eve",
"Drethan Ancestral Tomb","Redas Ancestral Tomb","Kogoruhn, Temple of Fey","Berandas, Keep,Top Level","Dushariran, Shrine","Bthuand","Dagon Fel, Sorkvild's Tower","Nchardumz","Magas Volar","Mamaea, Shrine of Pitted Dreams"}
-- Tier 4
tier4MessageTable = {"Vassir-Didanat Cave","Sarys Ancestral Tomb","Falas Ancestral Tomb","Senim Ancestral Tomb","Mawia","Nammu","Falasmaryon, Lower Level","Abanabi","Yesamsi"}
-- Tier 5
tier5MessageTable = {"Ibar-Dad", "Aleft", "Mudan, Central Vault","Bal Fell, Inner Shrine","Hlormaren, Sewers","Hlormaren, Underground","Ilunibi, Soul's Rattle","Ilunibi, Blackened Heart","Ilunibi, Marowak's Spine","Ilunibi, Carcass of the Saint",
"Ilunibi, Tainted Marrow","Hlormaren, Keep, Bottom Level","Almurbalarammi, Shrine","Berandas, Keep, Bottom Level","Berandas, Underground","Falasmaryon, Sewers","Helan Ancestral Tomb","Savel Ancestral Tomb","Assu"}

-- Dungeon Difficulty
cellDifficulties = {}
for _, cellDescription in pairs({"-1, -2","-4, -7","-1, -2", "0, -2","-3, -4","Sarano Ancestral Tomb","Mudan Grotto","Mudan, Lost Dwemer Checkpoint","Lleran Ancestral Tomb","Indalen Ancestral Tomb","Arkngthand, Hall of Centrifuge","Arkngthand, Weepingbell Hall","Arkngthand, Heaven's Gallery","Tharys Ancestral Tomb","Shulk Egg Mine","Shulk Egg Mine, Mining Camp","Samarys Ancestral Tomb","Addamasartus"}) do
    cellDifficulties[cellDescription] = 25
end
for _, cellDescription in pairs({"-5, 11","-4, 11","-5, 17","-4, 17","-7, 10","-3, 17","-4, 14","-4, 18","-5, 7","-5, 8","-4, 7","-1, 17","-1, 12","-2, 13","-5, 14","-3, 16","-1, 14","-2, 19","-4, 16","20, 4","-6, 15","0, -2","-1, -2","-1, -1","0, -1","Mzahnch","Mzahnch Lower Level","Mudan, Central Vault","Mamaea, Sanctum of Awakening","-2, 12","Urshilaku, Laterus Burial","Urshilaku, Kakuna Burial","Urshilaku, Kefka Burial","Urshilaku, Astral Burial","Urshilaku, Karma Burial","Urshilaku, Fragile Burial","Arkngthand, Cells of Hollow Hand","Arkngthand, Land's Blood Gallery","Arkngthand, Deep Ore Passage","Shulk Egg Mine, Queen's Lair","Shurdan-Raplay Egg Mine","Zainsipilu","Thelas Ancestral Tomb","Andrano Ancestral Tomb",
"Urshilaku, Juno Burial","Mamaea, Sanctum of Black Hope","Vivec, St. Olms Underworks", "Hassour"}) do
    cellDifficulties[cellDescription] = 50
end
for _, cellDescription in pairs({"0, 0","-1, 1","0, 1","-1, 0","-4, 13","16, -8","0, -14","-3, 14","-1, 15","-5, 18","-6, 18","-5, 12","15, -10","-2, 18","-6, 17","-2, 17","-3, 18","-6, 18","15, -9","8, -13",
"9, -12","-1, -3","-1, 4","-2, 4","-1, 5","6, -10","6, -9","7, -9","Assarnatamat, Shrine","Rothan Ancestral Tomb", "Nabith Waterway", "Hall of Maki","Omaren Ancestral Tomb","Kogoruhn, Hall of Phisto","Ald Redaynia, Tower","Kogoruhn, Dome of Pollock's Eve","Drethan Ancestral Tomb","Redas Ancestral Tomb","Kogoruhn, Temple of Fey","Dushariran, Shrine","Bthuand",
"Dagon Fel, Sorkvild's Tower","Nchardumz","Magas Volar","Hlormaren, Sewers","Hlormaren, Underground","Mamaea, Shrine of Pitted Dreams", "Hassour, Shrine","Berandas, Keep,Top Level"}) do
    cellDifficulties[cellDescription] = 75
end
for _, cellDescription in pairs({"9, -13","4, 15","-7, 9","8, -12","14, -7","-3, 7","-3, 6","-3, 5","-4, 7","-4, 6","-4, 5","Ilunibi, Soul's Rattle","Ilunibi, Blackened Heart",
"Ilunibi, Marowak's Spine","Ilunibi, Carcass of the Saint","Ilunibi, Tainted Marrow","Bal Fell, Outer Shrine","Kogoruhn, Charma's Breath","Kogoruhn, Bleeding Heart","Bal Fell, Inner Shrine","Almurbalarammi, Shrine",
"Vassir-Didanat Cave","Sarys Ancestral Tomb","Falas Ancestral Tomb","Berandas, Keep, Bottom Level","Senim Ancestral Tomb","Mawia","Nammu","Falasmaryon, Lower Level","Abanabi","Yesamsi","Berandas, Underground",
"Falasmaryon, Sewers","Helan Ancestral Tomb","Savel Ancestral Tomb","Assu"}) do
    cellDifficulties[cellDescription] = 100
end
for _, cellDescription in pairs({"Ibar-Dad"}) do
    cellDifficulties[cellDescription] = 125
end
for _, cellDescription in pairs({"Aleft"}) do
    cellDifficulties[cellDescription] = 150
end
for _, cellDescription in pairs({}) do
    cellDifficulties[cellDescription] = 175
end
for _, cellDescription in pairs({}) do
    cellDifficulties[cellDescription] = 200
end
for _, cellDescription in pairs({}) do
    cellDifficulties[cellDescription] = 225
end
for _, cellDescription in pairs({}) do
    cellDifficulties[cellDescription] = 250
end
for _, cellDescription in pairs({}) do
    cellDifficulties[cellDescription] = 275
end
for _, cellDescription in pairs({"Ebonheart, Underground Caves","Forgotten Vaults of Anudnabia, Forge of Hilbongard","Nerano Ancestral Tomb","Mudan, Central Vault"}) do
    cellDifficulties[cellDescription] = 300
end
for _, cellDescription in pairs({}) do
    cellDifficulties[cellDescription] = 325
end
for _, cellDescription in pairs({}) do
    cellDifficulties[cellDescription] = 350
end
for _, cellDescription in pairs({"16, -9","-5, 16","15, -10","0, -15","0, -13","8, 11","9, 12","9, 13","8, 12","8 ,13"}) do
    cellDifficulties[cellDescription] = 375
end
for _, cellDescription in pairs({"1, -14","Ald Sotha, Lower Level","Ald Sotha, Upper Level","Ald Sotha, Shrine","Hlormaren, Keep, Bottom Level"}) do
    cellDifficulties[cellDescription] = 400
end
for _, cellDescription in pairs({}) do
    cellDifficulties[cellDescription] = 425
end
-- Invulnerable Cells
for _, cellDescription in pairs({"Suran, Goldyn Belaram; Pawnbroker", "ToddTest", "Tower of Tel Fyr, Hall of Fyr", "Corprusarium", "Corprusarium Bowels", "Tower of Tel Fyr, Onyx Hall", "Tower of Tel Fyr, Hall of Fyr",
"Balmora, Guild of Fighters","Balmora, Guild of Mages","Urshilaku Camp, Ahasour's Yurt","Balmora, Caius Cosades' House","Urshilaku Camp, Ashkhan's Yurt","Urshilaku Camp, Kurapli's Yurt","Urshilaku Camp, Maeli's Yurt",
"Urshilaku Camp, Sakiran's Yurt","Urshilaku Camp, Shara's Yurt","Urshilaku Camp, Shimsun's Yurt","Urshilaku Camp, Wise Woman's Yurt","Urshilaku Camp, Zabamund's Yurt","Urshilaku Camp, Zanummu's Yurt"}) do
    cellDifficulties[cellDescription] = 2000
end

-- Player Debuffs
cellsForDiseases = {}


cellsForDiseases.drain_acrobatics_100 = {"Ibar-Dad"}
cellsForDiseases.drain_enchant_100 = {"Ibar-Dad"}
cellsForDiseases.mercantile_nerf = {"Tel Mora, Lower Tower"}

cellsForDiseases.weaknessToFire25 = {}
cellsForDiseases.weaknessToFrost25 = {"Ilunibi, Soul's Rattle","Ilunibi, Blackened Heart","Ilunibi, Marowak's Spine","Ilunibi, Carcass of the Saint","Ilunibi, Tainted Marrow"}
cellsForDiseases.weaknessToFrost50 = {"Ibar-Dad"}
cellsForDiseases.weaknessToShock25 = {"Hlormaren, Sewers"}
cellsForDiseases.weaknessToMagicka25 = {}
cellsForDiseases.weaknessToPoison25 = {}
cellsForDiseases.disintegrateWeapon = {"Hlormaren, Keep, Bottom Level","Hlormaren, Underground"}
cellsForDiseases.disintegrateArmor = {"Hlormaren, Keep, Bottom Level","Hlormaren, Underground"}
cellsForDiseases.blind25 = {"Ilunibi, Soul's Rattle","Ilunibi, Blackened Heart","Ilunibi, Marowak's Spine","Ilunibi, Carcass of the Saint","Ilunibi, Tainted Marrow"}
cellsForDiseases.blind50 = {"Hlormaren, Keep, Bottom Level","Hlormaren, Underground","Hlormaren, Sewers"}
cellsForDiseases.poison2 = {"Hlormaren, Keep, Bottom Level","Hlormaren, Underground"}
cellsForDiseases.drainSpeed20 = {"Hlormaren, Sewers"}
cellsForDiseases.drainSpeed25 = {}
cellsForDiseases.drainSpeed50 = {"Ibar-Dad"}
cellsForDiseases.jump10 = {"Hlormaren, Sewers"}
cellsForDiseases.weaknessToMagicka50 = {"Aleft"}
-- Boyos Additions
cellsForDiseases.by_weaknesstoshock50 = {"Hlormaren, Sewers"}
cellsForDiseases.by_slowfall10 = {"Hlormaren, Sewers"}
cellsForDiseases.by_firedamage1 = {"Hassour, Shrine"}

-- Creature Buffs
cellsForMonsterBuffs = {}


cellsForMonsterBuffs.chameleon25 = {"Ilunibi, Soul's Rattle","Ilunibi, Blackened Heart","Ilunibi, Marowak's Spine","Ilunibi, Carcass of the Saint","Ilunibi, Tainted Marrow"}
cellsForMonsterBuffs.chameleon50 = {"Samarys Ancestral Tomb"}
cellsForMonsterBuffs.speed25 = {"Ilunibi, Soul's Rattle","Ilunibi, Blackened Heart","Ilunibi, Marowak's Spine","Ilunibi, Carcass of the Saint","Ilunibi, Tainted Marrow"}

cellsForMonsterBuffs.fireShield1000 = {}
cellsForMonsterBuffs.sanctuary25 = {"Caldera Mine", "Aleft", "Ibar-Dad"}
cellsForMonsterBuffs.restore_health_1 = {"Samarys Ancestral Tomb"}
cellsForMonsterBuffs.restore_health_5 = {"Aleft"}
cellsForMonsterBuffs.strength50 = {}
cellsForMonsterBuffs.speed10 = {}
cellsForMonsterBuffs.agility50 = {}
cellsForMonsterBuffs.resist_frost_50 = {"Hlormaren, Sewers", "Hlormaren, Keep, Bottom Level"}
cellsForMonsterBuffs.resist_frost_100 = {"Ibar-Dad", "Aleft", "Ilunibi, Soul's Rattle","Ilunibi, Blackened Heart","Ilunibi, Marowak's Spine","Ilunibi, Carcass of the Saint","Ilunibi, Tainted Marrow"}
cellsForMonsterBuffs.resist_magicka_50 = {"Ibar-Dad", "Hlormaren, Sewers", "Hlormaren, Keep, Bottom Level", "Ilunibi, Soul's Rattle","Ilunibi, Blackened Heart","Ilunibi, Marowak's Spine","Ilunibi, Carcass of the Saint",
"Ilunibi, Tainted Marrow"}
cellsForMonsterBuffs.resist_magicka_100 = {"Aleft"}
cellsForMonsterBuffs.resist_shock_50 = {"Ibar-Dad", "Hlormaren, Keep, Bottom Level", "Ilunibi, Soul's Rattle","Ilunibi, Blackened Heart","Ilunibi, Marowak's Spine","Ilunibi, Carcass of the Saint","Ilunibi, Tainted Marrow"}
cellsForMonsterBuffs.resist_shock_100 = {"Aleft", "Hlormaren, Sewers"}
cellsForMonsterBuffs.resist_poison_50 = {"Ibar-Dad", "Hlormaren, Sewers", "Hlormaren, Keep, Bottom Level", "Ilunibi, Soul's Rattle","Ilunibi, Blackened Heart","Ilunibi, Marowak's Spine","Ilunibi, Carcass of the Saint",
"Ilunibi, Tainted Marrow"}
cellsForMonsterBuffs.resist_poison_100 = {}
cellsForMonsterBuffs.resist_fire_50 = {"Ibar-Dad", "Hlormaren, Sewers", "Hlormaren, Keep, Bottom Level", "Ilunibi, Soul's Rattle","Ilunibi, Blackened Heart","Ilunibi, Marowak's Spine","Ilunibi, Carcass of the Saint",
"Ilunibi, Tainted Marrow"}
cellsForMonsterBuffs.resist_fire_100 = {"Aleft"}

--Boyos Additions
cellsForMonsterBuffs.by_levitate = {"Hlormaren, Sewers"}
cellsForMonsterBuffs.by_elementalresistance25 = {"Hlormaren, Sewers","Hlormaren, Keep, Bottom Level"}
cellsForMonsterBuffs.by_restorestrength2 = {"Hlormaren, Sewers"}
cellsForMonsterBuffs.by_restorestrength15 = {"Hlormaren, Keep, Bottom Level"}
cellsForMonsterBuffs.by_fortifyattack50 = {"Hlormaren, Keep, Bottom Level", "Aleft"}
cellsForMonsterBuffs.by_resistancetofire50 = {"Hassour","Hassour, Shrine"}



dungeoncreation.here = function(eventStatus, pid)
--[[ Dungeon Creation ]]--	
-- Difficulty			
				local cell = tes3mp.GetCell(pid)

				tes3mp.LogMessage(2, "Listing cell difficulties:")
                tableHelper.print(cellDifficulties)

                local cellDifficulty = cellDifficulties[cell]

                if cellDifficulty ~= nil then
                    tes3mp.LogAppend(2, "- Found difficulty for " .. cell)
                    Players[pid]:SetDifficulty(cellDifficulty)
                    Players[pid]:LoadSettings()
                else
                    tes3mp.LogAppend(2, "- Could not find difficulty for " .. cell)
                    Players[pid]:SetDifficulty(0)
                    Players[pid]:LoadSettings()
                end				
-- Player Effects                  
                local locationalDiseases = {"mercantile_nerf", "by_firedamage1", "weaknessToMagicka50", "jump10", "weaknessToFire25", "weaknessToFrost25", "weaknessToShock25", "weaknessToMagicka25", "weaknessToPoison25", "blind25", "blind50", "poison2", 
				"disintegrateWeapon","disintegrateArmor", "by_weaknesstoshock50", "by_slowfall10", "drain_acrobatics_100", "drain_enchant_100", "weaknessToFrost50", "drainSpeed25", "drainSpeed50"}

				for _, locationalDisease in pairs(locationalDiseases) do

					if tableHelper.containsValue(Players[pid].data.spellbook, locationalDisease) then
					-- Is the player no longer in a cell where they should have this cell-specific disease?
						if not tableHelper.containsValue(cellsForDiseases[locationalDisease], tes3mp.GetCell(pid)) then
							logicHandler.RunConsoleCommandOnPlayer(pid, "player->removespell " .. locationalDisease)
							tableHelper.removeValue(Players[pid].data.spellbook, locationalDisease)
						end
					elseif tableHelper.containsValue(cellsForDiseases[locationalDisease], tes3mp.GetCell(pid)) then
						table.insert(Players[pid].data.spellbook, locationalDisease)
						logicHandler.RunConsoleCommandOnPlayer(pid, "player->addspell " .. locationalDisease)
					end
				end
-- Creature Effects			
				local locationalMonsterBuffs = { "resist_frost_50", "resist_magicka_50", "resist_shock_50", "resist_poison_50", "resist_fire_50", "by_resistancetofire50", "resist_frost_100", "resist_magicka_100", "resist_shock_100", "resist_poison_100", "resist_fire_100", "chameleon25", "chameleon50", "speed25", "fireShield1000", "sanctuary25", "restore_health_1", "restore_health_5", "strength50", "speed10", "agility50","by_elementalresistance25", "by_levitate", "by_restorestrength2", "by_fortifyattack50", "by_restorestrength15" }


                for _, locationalMonsterBuff in pairs(locationalMonsterBuffs) do

                    -- Are we in a cell where the monsters should be buffed?
                    if tableHelper.containsValue(cellsForMonsterBuffs[locationalMonsterBuff], tes3mp.GetCell(pid)) then
                        local actorList = LoadedCells[cell].data.packets.actorList
                        logicHandler.RunConsoleCommandOnObjectsForPlayer(pid, "addspell " .. locationalMonsterBuff, cell, actorList)
                    end
                end

                Players[pid].data.location.regionName = regionName
                Players[pid].hasFinishedInitialTeleportation = true
            

				--[[
				for _, uniqueIndex in pairs(LoadedCells[cellDescription].data.packets.actorList) do
					if 
				
				local playerLocation = Players[pid].data.location
				local aggroDistance = 50
				for _, uniqueIndex in pairs(LoadedCells[cellDescription].data.packets.actorList) do
				local actorLocation = LoadedCells[cellDescription].data.objectData[uniqueIndex].location
					if math.abs(playerLocation.posX - actorLocation.posX) <= aggroDistance and
						math.abs(playerLocation.posY - actorLocation.posY) <= aggroDistance and
						math.abs(playerLocation.posZ - actorLocation.posZ) <= aggroDistance then
						logicHandler.SetAIForActor(LoadedCells[cellDescription], uniqueIndex, enumerations.ai.COMBAT, pid)
					end
				end
				end
				end]]--
-- Dungeon Tier Messages

				if tableHelper.containsValue(tier1MessageTable, cell) == true then
					tes3mp.MessageBox(pid, -1, color.White .. "You have entered a " .. color.LightGreen .. "Tier I " .. color.White .. "area")
				end

				if tableHelper.containsValue(tier2MessageTable, cell) == true then
					tes3mp.MessageBox(pid, -1, color.White .. "You have entered a " .. color.Aqua .. "Tier II " .. color.White .. "area")
				end

				if tableHelper.containsValue(tier3MessageTable, cell) == true then
					tes3mp.MessageBox(pid, -1, color.White .. "You have entered a " .. color.RoyalBlue .. "Tier III " .. color.White .. "area")
				end

				if tableHelper.containsValue(tier4MessageTable, cell) == true then
					tes3mp.MessageBox(pid, -1, color.White .. "You have entered a " .. color.Yellow .. "Tier IV " .. color.White .. "area")
				end

				if tableHelper.containsValue(tier5MessageTable, cell) == true then
					tes3mp.MessageBox(pid, -1, color.White .. "You have entered a " .. color.Red .. "Tier V " .. color.White .. "area")
				end

-- Change Home Notification Message

				if tableHelper.containsValue(homecityTable, cell) == true and Players[pid].data["changeHomeNotification"] == true then
					tes3mp.MessageBox(pid, -1, color.White .. "You can change your " .. color.BlueViolet .. "Homecity " .. color.White .. "in this area")
				end
-- PvP				
				if tableHelper.containsValue(pvpTable, cell) == true then
					tes3mp.MessageBox(pid, -1, color.White .. "You have entered a " .. color.Red .. "PvP " .. color.White .. "area")
				end
--[[ End of Cell/Dungeon Editing ]]--

end


customEventHooks.registerHandler("OnPlayerCellChange", dungeoncreation.here)