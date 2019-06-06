mercantileFix = {}

mercantileFix.Fix = function(eventStatus, pid)

if tes3mp.GetSkillBase(pid, tes3mp.GetSkillId("Mercantile")) > 0 then
		Players[pid].data.skills["Mercantile"].base = 0
		Players[pid]:LoadSkills()
		return customEventHooks.makeEventStatus(false, false)

end

end

customEventHooks.registerValidator("OnPlayerSkill", mercantileFix.Fix)
customEventHooks.registerHandler("OnPlayerFinishLogin", mercantileFix.Fix)