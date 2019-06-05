-- collision fix

collisionRefs = {}


collisionRefs = function(eventStatus)
 tableHelper.insertValues(config.enforcedCollisionRefIds,{ "dungeonchest_loot_rattle", "dungeonchest_ten_pace", "dungeonchest_dwemer_one", "dungeonchest_dragon_bone", "dungeonchest_lords_cuirass", "dungeonchest_berserker_set", 
"dungeonchest_saviors_hide", "misc_uni_pillow_01", "misc_uni_pillow_02", "red_bed", "tannery", "spinning_wheel", "crafting_anvil", "altar_1", "fletching_table", "dungeonchest_armor_one_a", "dungeonchest_mentor_ring", 
"dungeonchest_boots_apostle", "dungeonchest_fireweapon_one", "dungeonchest_tier_two" })
end


customEventHooks.registerHandler("OnServerPostInit", collisionRefs)