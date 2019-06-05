
-- 
-- work with decorateHelp later

preObjectsAndDeletions = {}


jsonInterface = require("jsonInterface")
preexistingObjects = jsonInterface.load("preObjects.json")
refNumDeletionsByCell = jsonInterface.load("refNumDeletionsByCell.json") -- check if this overrides


preObjectsAndDeletions.AddPreexistingObjects = function(eventstatus, pid, cellDescription)
   
if LoadedCells[cellDescription]:HasEntry() ~= true then
-- only send preObjects to players entering cell later logicHandler line 419 change to false
	 if preexistingObjects[cellDescription] ~= nil then
	 
			for arrayIndex, object in pairs(preexistingObjects[cellDescription]) do
			   logicHandler.CreateObjectAtLocation(cellDescription, object.location, object.refId, object.packetType)
			 
			end
	 
			LoadedCells[cellDescription].forceActorListRequest = true
	  end
	end
end

preObjectsAndDeletions.DeleteCommand = function(pid, cmd)
			-- Enables deletemode- activate object to delete it
			Players[pid].data.deletemode = true
			tes3mp.SendMessage(pid, "Entering deletemode.\n")
			
			elseif cmd[1] == "offdelete" and moderator then
			-- Disables deletemode
			Players[pid].data.deletemode = false
			tes3mp.SendMessage(pid, "leaving deletemode.\n")
end


preObjectsAndDeletions.OnObjectActivate = function(pid, cellDescription, objects, players)
            if Players[pid].data.deletemode == true then -- disables all activations and adds them to refnumdeletions
                isValid = false
                
                refNumDeletionsByCell = jsonInterface.load("refNumDeletionsByCell.json")
				
				local CurrentCell = tes3mp.GetCell(pid)
				
				-- got ObjectUniqueIndex above
				if refNumDeletionsByCell[CurrentCell] == nil then refNumDeletionsByCell[CurrentCell] = {} end
                table.insert(refNumDeletionsByCell[CurrentCell], tonumber(tes3mp.GetObjectRefNum(index)))

                -- note: objectUniqueIndex will be null if you select a player in deletemode!
                
                jsonInterface.save("refNumDeletionsByCell.json", refNumDeletionsByCell)
                tes3mp.SendMessage(pid, "Deleted refNum: " .. tostring(objectUniqueIndex) .. "\n", false)
	end
end



--saveme.lua
-- elseif cmd[1] == "creat" and cmd[2] ~= nil and moderator then
-- saveme.exactRef(pid, cmd[2])
saveme = {}
            
--Rank A Creatures   
creatA = {}
creatA[1]="golden_saint_a"  
creatA[2]="dremora_lord_b"		
creatA[3]="ogrim_titan_b"	
creatA[4]="atronach_flame_b"	
creatA[5]="skeleton_archer_b"	
creatA[6]="skeleton_wizard_a"	
creatA[7]="skeleton_champion_b" 
creatA[8]="skeleton_archer_b"
creatA[9]="winged_twilight_b"
creatA[10]="kwama forager"
creatA[11]="aaakwamawarrior"
creatA[12]="mudcrab"
creatA[13]="aaanixhoundpup"
creatA[14]="rat"
creatA[15]="aascampling"
creatA[16]="scrib"
creatA[17]="aadwarfskeleton"
creatA[18]="aaaspriggansapling"
creatA[19]="aaasteamceuntrion"
creatA[20]="aaawolfpup"
creatA[21]="aaawolfpupred"
creatA[22]="aaacorprusstalker"   

       
--Rank B Creatures
creatB = {}
creatB[1]="aabAlit"
creatB[2]="aabGhost"
creatB[3]="aabDurzogWild"
creatB[4]="aabCorpusStalker"
creatB[5]="aabGoblinMedium"
creatB[6]="aabGoblinScout"
creatB[7]="aabGoblinWorker"
creatB[8]="aabKwamaWarrior"
creatB[9]="aabYoungOgrim"
creatB[10]="aabScribLarge"
creatB[11]="aabSkeleton"
creatB[12]="aabYoungWingedTwilight"
creatB[13]="aabWolfBlack" 
creatB[14]="aabWolfRed"


--Rank C Creatures
creatC = {}
creatC[1]="aacBoar"
creatC[2]="aacBonewolf"


--Rank D Creautres
creatD = {}
creatD[1]="aadGiantFish"
creatD[2]="aadGiantGuar"
creatD[3]="aadGoldenSaint"
creatD[4]="aaSkeletonChampLarge"

--Solsteim Creatures
--Rank A
creatSolsteima = {}
creatSolsteima[1]="aaabearcub"
creatSolsteima[2]="aaasnowbear"
creatSolsteima[3]="aaaspriggansapling"
creatSolsteima[4]="aaarieklingrunt"
creatSolsteima[5]="aaawolfpup"
creatSolsteima[6]="aaawolfpupred"
creatSolsteima[7]="aaabosssprigganmother" --SprigganMotherBoss



saveme.save = function(pid, cmd)
cmd2 = cmd[2]
preTable = {}

--create or read json

		preTable = jsonInterface.load("preObjects.json")

	
--create table for this point
local cell = tes3mp.GetCell(pid)

local locref = ""

if cmd2 =="a" then
  local rando = math.random(22)
  locref = creatA[rando]
elseif cmd2 =="b" then
  local rando = math.random(14)
  locref = creatB[rando]
elseif cmd2 =="c" then
  local rando = math.random(2)
  locref = creatC[rando]
elseif cmd2 =="d" then
  local rando = math.random(4)
  locref = creatD[rando]
elseif cmd2 =="solsteimaa" then
  local rando = math.random(6)
  locref = creatSolsteima[rando]
else
  locref = "aaaAlitBaby"
end


local loc = {
        packetType = "spawn",
        refId = locref,
        location = { posX = tes3mp.GetPosX(pid), posY = tes3mp.GetPosY(pid), posZ = tes3mp.GetPosZ(pid), rotX = tes3mp.GetRotX(pid), rotY = 0, rotZ= tes3mp.GetRotZ(pid) }
        }

if preTable[cell] ~= nil then
else
preTable[cell] = {}
end


--save table to json
table.insert(preTable[cell],loc)
jsonInterface.save("preObjects.json", preTable, config.playerKeyOrder )

logicHandler.CreateObjectAtLocation(cell, loc.location, locref, "spawn")

tes3mp.SendMessage(pid,"saved bro\n"..cell,false)
end


saveme.save2 = function(pid, cmd)
cmd2 = cmd[2]
cmd3 = cmd[3]
preTable = {}

--create or read json

		preTable = jsonInterface.load("preObjects.json")

	
--create table for this point
local cell = tes3mp.GetCell(pid)

local locref = ""

if cmd2 =="a" then
  local rando = tonumber(cmd3)
  locref = creatA[rando]
elseif cmd2 =="b" then
  local rando = tonumber(cmd3)
  locref = creatB[rando]
elseif cmd2 =="c" then
  local rando = tonumber(cmd3)
  locref = creatC[rando]
elseif cmd2 =="d" then
  local rando = tonumber(cmd3)
  locref = creatD[rando]
elseif cmd2 =="solsteima" then
  local rando = tonumber(cmd3)
  locref = creatSolsteima[rando]
else
  locref = "aaaAlitBaby"
end


local loc = {
        packetType = "spawn",
        refId = locref,
        location = { posX = tes3mp.GetPosX(pid), posY = tes3mp.GetPosY(pid), posZ = tes3mp.GetPosZ(pid), rotX = tes3mp.GetRotX(pid), rotY = 0, rotZ= tes3mp.GetRotZ(pid) }
        }

if preTable[cell] ~= nil then
else
preTable[cell] = {}
end


--save table to json
table.insert(preTable[cell],loc)
jsonInterface.save("preObjects.json", preTable, config.playerKeyOrder )
logicHandler.CreateObjectAtLocation(cell, loc.location, locref, "spawn")
tes3mp.SendMessage(pid,"saved bro\n"..cell,false)
end



saveme.exactRef = function(pid, cmd)
cmd2 = cmd[2]
preTable = {}

--create or read json

		preTable = jsonInterface.load("preObjects.json")

	
--create table for this point
local cell = tes3mp.GetCell(pid)

local locref = cmd2


local loc = {
        packetType = "spawn",
        refId = locref,
        location = { posX = tes3mp.GetPosX(pid), posY = tes3mp.GetPosY(pid), posZ = tes3mp.GetPosZ(pid), rotX = tes3mp.GetRotX(pid), rotY = 0, rotZ= tes3mp.GetRotZ(pid) }
        }

if preTable[cell] ~= nil then
else
preTable[cell] = {}
end


--save table to json
table.insert(preTable[cell],loc)
jsonInterface.save("preObjects.json", preTable, config.playerKeyOrder )
logicHandler.CreateObjectAtLocation(cell, loc.location, locref, "spawn")
tes3mp.SendMessage(pid,"saved bro\n"..cell,false)
end


customCommandHooks.registerCommand("save1", saveme.save2)
customCommandHooks.registerCommand("save2", saveme.save)
customCommandHooks.registerCommand("save3", saveme.exactRef)
customCommandHooks.registerCommand("delete", preObjectsAndDeletions.DeleteCommand)
customEventHooks.registerHandler("OnObjectActivate", preObjectsAndDeletions.OnObjectActivate)
customEventHooks.registerHandler("OnCellLoad", preObjectsAndDeletions.AddPreexistingObjects)
