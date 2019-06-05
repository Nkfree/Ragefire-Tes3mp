rageExp = {}
rageExp.IDsToPoints = jsonInterface.load("rageExp.json")
rageExp.rageCustomVariables = { "rageExp", "rageExpProgress", "rageLevel", "ragePointsSpent", "ragePoints","magicTreePoints", "magicPointsSpent", "warTreePoints", "warPointsSpent",
 "defensePointsSpent", "healerPointsSpent", "stealthPointsSpent", "defenseLifePool", "defenseRegeneration", "defenseSwiftness", "defenseResilience", "defenseEvasion", "defenseTurtleShell", 
 "defenseVitality", "defenseDumbBrute", "defenseSafeguard", "defenseResistFire", "defenseResistFrost", "defenseResistShock", "defenseResistPoison", "stealthGreed", "stealthSerpentsBlood", "stealthGlibFeet", 
 "stealthSlipperyMind", "stealthHunterInTheNight", "stealthThief", "stealthSecretPockets", "stealthCloakDagger", "stealthPoisonTips", "stealthAssassinate", "healerHealingHands", "healerManaSource", "healerStrengthenedMind", 
 "healerGuidance", "healerClericsBlessing", "healerProtectiveShell", "healerToughness", "healerLastResort", "healerFireIce", "healerGroupMorale", "warFatiguePool", "warCourage", "warHaste", "warCardio", "warAccuracy", 
 "warFighterStance", "warReinforcement", "warSurgeOfStrength", "warConditioning", "warCallToArms", "magicClarity", "magicHavoc", "magicSummoner", "magicWisdom", "magicExtraMana", "magicMagePower", "magicSorcerer", 
 "magicMindControl", "magicBattleMage", "magicWizardStrength" }
	
	
rageExp.Login = function(eventStatus, pid)

for _, value in pairs(rageExp.rageCustomVariables) do
if Players[pid].data.customVariables[value] == nil then
	Players[pid].data.customVariables[value] = 1
end
end
end

rageExp.ProcessLatestKill = function(pid, refId)
	
    tes3mp.LogMessage(enumerations.log.INFO, "Running rageExp.ProcessLatestKill() for pid " .. pid .. ", refId " .. refId)

    if rageExp.IDsToPoints[refId] ~= nil then
		
        local basePoints = rageExp.IDsToPoints[refId].points
        local extraPoints = math.random(-basePoints / 10, basePoints / 10)
        local totalPoints = basePoints + extraPoints

		-- Add a bonus based on the player's current difficulty
		local difficulty = Players[pid].data.settings.difficulty

		if difficulty == "default" then
		difficulty = config.difficulty
		end

		totalPoints = totalPoints
		totalPoints = math.ceil(totalPoints)

        if totalPoints > 0 then
            Players[pid].data.customVariables.rageExp = Players[pid].data.customVariables.rageExp + totalPoints
            tes3mp.MessageBox(pid, -1, color.White .. "You have gained " .. color.LightGreen ..
                totalPoints .. color.White .. " experience")
        end
    end
	
	local currentRageLevel = Players[pid].data.customVariables.rageLevel
	local baseXp = 100
	local nextlevel = math.floor(baseXp *((currentRageLevel + 1) ^ 2.5) / 2)
	
	if Players[pid].data.customVariables.rageLevel == 0 and Players[pid].data.customVariables.rageExp >= nextlevel + 60 then
		Players[pid].data.customVariables.rageLevel = Players[pid].data.customVariables.rageLevel + 1
		Players[pid].data.customVariables.ragePoints = Players[pid].data.customVariables.ragePoints + 5
		logicHandler.RunConsoleCommandOnPlayer(pid, 'playsound "Conjuration Hit"')
		local levelMessage = Players[pid].data.customVariables.rageLevel
		tes3mp.MessageBox(pid,-1, color.White .. "You have gained a " .. color.Coral .. "RageLevel" .. color.White .. "!\n")
		tes3mp.SendMessage(pid, color.BlueViolet .. "Congratulations! You are now Rage Level " .. color.BlueViolet .. levelMessage  .. "!\n" ..
								color.White .. "Type " .. color.Gold .. "/rage " .. color.White .. "to bring up the " .. color.Coral .. "Rage " .. color.White .. "menu.\n",false)
	elseif Players[pid].data.customVariables.rageExp >= nextlevel and Players[pid].data.customVariables.rageLevel >= 1 then
		Players[pid].data.customVariables.rageLevel = Players[pid].data.customVariables.rageLevel + 1
		Players[pid].data.customVariables.ragePoints = Players[pid].data.customVariables.ragePoints + 5
		logicHandler.RunConsoleCommandOnPlayer(pid, 'playsound "Conjuration Hit"')
		local levelMessage = Players[pid].data.customVariables.rageLevel
		tes3mp.MessageBox(pid,-1, color.White .. "You have gained a " .. color.Coral .. "RageLevel" .. color.White .. "!\n")
		tes3mp.SendMessage(pid, color.BlueViolet .. "Congratulations! You are now Rage Level " .. color.BlueViolet .. levelMessage  .. "!\n",false)
	end
end



rageExp.ProcessLatestKillinParty = function(pid, refId, nerfFactor)
	
    tes3mp.LogMessage(enumerations.log.INFO, "Running rageExp.ProcessLatestKill() for pid " .. pid .. ", refId " .. refId)

    if rageExp.IDsToPoints[refId] ~= nil then
		
        local basePoints = rageExp.IDsToPoints[refId].points
        local extraPoints = math.random(-basePoints / 10, basePoints / 10)
        local totalPoints = basePoints + extraPoints

		-- Add a bonus based on the player's current difficulty
		local difficulty = Players[pid].data.settings.difficulty

		if difficulty == "default" then
		difficulty = config.difficulty
		end

		totalPoints = totalPoints / 1.35
		totalPoints = math.ceil(totalPoints)
		
		
		
		
        if totalPoints > 0 then
            Players[pid].data.customVariables.rageExp = Players[pid].data.customVariables.rageExp + totalPoints
            tes3mp.MessageBox(pid, -1, color.White .. "You have gained " .. color.LightGreen ..
                totalPoints .. color.White .. " group experience")
        end
    end
	
	local currentRageLevel = Players[pid].data.customVariables.rageLevel
	local baseXp = 100
	local nextlevel = math.floor(baseXp *((currentRageLevel + 1) ^ 2.5) / 2)
	
	if Players[pid].data.customVariables.rageLevel == 0 and Players[pid].data.customVariables.rageExp >= nextlevel + 60 then
		Players[pid].data.customVariables.rageLevel = Players[pid].data.customVariables.rageLevel + 1
		Players[pid].data.customVariables.ragePoints = Players[pid].data.customVariables.ragePoints + 5
		local levelMessage = Players[pid].data.customVariables.rageLevel
		tes3mp.MessageBox(pid,-1, color.White .. "You have gained a " .. color.Coral .. "RageLevel" .. color.White .. "!\n")
		tes3mp.SendMessage(pid, color.BlueViolet .. "Congratulations! You are now Rage Level " .. color.BlueViolet .. levelMessage  .. "!\n" ..
								color.White .. "Type " .. color.Gold .. "/rage " .. color.White .. "to bring up the " .. color.Coral .. "Rage " .. color.White .. "menu.\n",false)
	elseif Players[pid].data.customVariables.rageExp >= nextlevel and Players[pid].data.customVariables.rageLevel >= 1 then
		Players[pid].data.customVariables.rageLevel = Players[pid].data.customVariables.rageLevel + 1
		Players[pid].data.customVariables.ragePoints = Players[pid].data.customVariables.ragePoints + 5
		local levelMessage = Players[pid].data.customVariables.rageLevel
		tes3mp.MessageBox(pid,-1, color.White .. "You have gained a " .. color.Coral .. "RageLevel" .. color.White .. "!\n")
		tes3mp.SendMessage(pid, color.BlueViolet .. "Congratulations! You are now Rage Level " .. color.BlueViolet .. levelMessage  .. "!\n",false)
	end
end

rageExp.Decide = function(eventStatus, pid, cellDescription)

        local uniqueIndex = tes3mp.GetActorRefNum(0) .. "-" .. tes3mp.GetActorMpNum(0)

			if tes3mp.DoesActorHavePlayerKiller(0) then
				local killerPid = tes3mp.GetActorKillerPid(0)
				local refId = LoadedCells[cellDescription].data.objectData[uniqueIndex].refId

                    rageExp.ProcessLatestKill(killerPid, refId)
             end
end

customEventHooks.registerHandler("OnActorDeath", rageExp.Decide)
customEventHooks.registerHandler("OnPlayerFinishLogin", rageExp.Login)