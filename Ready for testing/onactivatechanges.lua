--[[
make customhook for everything


OnObjectActivate(pid, cellDescription, objects, players) objects and players container lists of activated objects and players respectively.

objects elements have form { uniqueIndex = ..., refId = ... }

players elements have form { pid = ... }


]]--

-- onobjectactivate changes in eventhandler
-- https://pastebin.com/NWsKhjF5


-- kanahousing changes to permit others open
-- https://pastebin.com/1JCJ1R3N

 doorTable = {"ex_s_door_rounded", "ex_redoran_hut_01_a", "in_impsmall_door_01", "in_impsmall_trapdoor_01a", "ex_velothicave_door_01", "ex_velothicave_door_03", "ex_emp_tower_01_a", "ex_nord_door_01", "ex_nord_door_02", "ex_common_door_01", "ex_imp_loaddoor_01", "Ex_imp_loaddoor_02", "ex_imp_loaddoor_03", "ex_redoran_barracks_door", "in_redoran_barrack_door", "in_strong_vaultdoor00", "in_ar_door_01", "in_redoran_ladder_01", "door_cavern_doors00", "door_cavern_doors10", "in_r_s_door_01", "in_c_door_arched", "in_c_door_wood_square", "door_cavern_doors20", "ex_emp_tower_01_b", "in_com_trapbottom_01", "in_com_traptop_01", "hlaal_loaddoor_01", "hlaalu_loaddoor_ 02", "in_redoran_hut_door_01", "ex_t_door_01", "ex_t_door_02", "ex_t_door_stone_large", "in_impsmall_door_jail_01", "in_impsmall_loaddoor_01", "ex_t_door_sphere_01", "ex_t_door_slavepod_01", "door_dwrv_double00", "door_dwrv_double01", "in_hlaalu_door", "in_t_housepod_door_exit", "in_t_door_small", "in_t_s_plain_door", "in_t_l_door_01", "ex_de_shack_door", "in_de_shack_door", "door_dwrv_inner00", "ex_cave_door_01", "in_v_s_trapdoor_01", "in_v_s_trapdoor_02", "door_dwrv_main00", "door_dwrv_load00", "ex_velothi_loaddoor_01", "in_dae_door_01", "ex_ashl_door_01", "ex_dae_door_load_oval", "in_ashl_door_01", "ex_ashl_door_02", "ex_common_door_balcony", "ex_velothi_loaddoor_02", "in_ashl_door_02", "in_hlaalu_loaddoor_01", 	"in_hlaalu_loaddoor_02", "in_vivec_grate_door_01", "ex_vivec_grate_01", "in_impsmall_d_cave_01", "In_impsmall_d_hidden_01", "in_velothismall_ndoor_01", "chargen door hall",
 "chargen customs door", "ex_r_trapdoor_01", "in_r_trapdoor_01", "ex_v_palace_grate_01", "ex_de_ship_trapdoor", "in_de_ship_cabindoor", "vivec_grate_door_02", "door_dwrv_loaddown00", "door_dwrv_loadup00", "in_ci_door_01", "smora_fara_door", "pelagiad_halfway_room", "rent_ebon_six_door", "rent_balmora_south_door", "rent_balmora_council_door", "rent_balmora_lucky_door", "rent_balmora_eight_door", "rent_caldera_shenk_door", "rent_maargan_andus_door", "rent_vivec_lizard_door", "rent_vivec_flower_door", "rent_vivec_black_door", "in_v_s_jaildoor_01", "ex_h_pcfort_exdoor_ 01", "ex_r_pcfort_d_01", "ex_r_pcfort_d_02", "ex_h_pcfort_exdoor_ 03", "ex_h_pcfort_exdoor_ 03-3", "ex_h_pcfort_exdoor_ 02", "ex_r_pcfort_d_01-3", "ex_r_pcfort_d_01-2", "ex_t_door_01_pc_hold_a", "ex_t_door_02_pc_hold_a", "ex_t_door_02_pc_hold_b", "ex_t_door_01_pc_hold_b", "in_t_door_small_load", "ex_h_trapdoor_01", "in_h_trapdoor_01", "ex_h_pcfort_trapdoor_01-2", "chargen door exit", "in_velothismall_ndoor_agrippina", "Ex_Cave_Door_01_Koal", "in_de_shipdoor_toplevel", "Ex_DE_ship_cabindoor", "CharGen_ship_trapdoor", "CharGen_cabindoor", "ex_nord_door_01-back", "CharGen Exit Door", "Ex_De_SN_Gate", "In_De_Shack_Trapdoor_01", "In_De_Shack_Trapdoor", "In_Hlaalu_Door_01", "chargen door captain", "hlaalu_loaddoor_ 02_balyn", "chargen_shipdoor", "In_DE_LLshipdoor_Large", "in_ashl_door_02_sha", "Ex_V_palace_grate_02", "Velothi_Sewer_Door", "in_impsmall_door_01_shrine", "Rent_Ghost_Dusk_Door", "chargendoorjournal", "Ex_V_cantondoor_01",
 "in_strong_vaultdoor_tela_UNIQUE", "in_v_s_jaildoor_frelene", "in_ci_door_01_indoor", "Ex_Dae_door_static", "clutter_whouse_door_01", "clutter_whouse_door_02", "door_cavern_vassir_un", "in_velothismall_ndoor_01_jeanne", "door_ravenrock_mine", "Ex_S_door", "In_S_door", "Ex_S_door_double", "ex_S_door_rounded", "ex_S_fence_gate", "Ex_colony_bardoor", "Ex_colony_minedoor", "Ex_colony_door01.NIF", "Ex_colony_door02", "Ex_colony_door03", "Ex_colony_door04", "Ex_colony_door05", "ex_nord_door_wolf", "In_thirsk_door", "Ex_BM_tomb_door_03", "Ex_BM_tomb_door_02", "Ex_BM_tomb_door_01", "Ex_colony_door02_1", "Ex_colony_door04_2", "Ex_colony_door04_1", "Ex_colony_door03_4", "Ex_colony_door02_2", "Ex_colony_door03_1", "Ex_colony_door03_2", "Ex_colony_door04_2b", "Ex_colony_door03_4a", "Ex_colony_door05b_4", "Ex_colony_door05c_4", "Ex_colony_door05_2", "Ex_colony_door02b_2", "Ex_colony_door04_3", "Ex_colony_door04b_3", "Ex_colony_door05_3", "Ex_colony_door04c_3", "BM_KA_door", "BM_KA_door_dark", "ex_S_fence_gate_uni", "BM_IC_door_01", "Ex_S_door_double_fixing", "Ex_S_door_double_fixed", "In_thirsk_door_main_1", "In_thirsk_door_main_2", "ex_nord_door_lair", "BM_IC_door_pelt", "BM_IC_door_pelt_dark", "Ex_colony_door06", "In_thirsk_door_main_1_b", "In_thirsk_door_main_2_b", "ex_nord_door_gyldenhul", "Ex_colony_door07", "Ex_colony_door08", "Ex_colony_door03 int", "Ex_colony_door01_1B.NIF", "Ex_colony_door03_int", "Ex_colony_door05a_4", "Ex_colony_door05_int", "BM_KA_door_dark_udyr", "BM_IC_door_pelt_wolf", 
 "Ex_S_door_rigmor", "Ex_S_door_rigmor2", "BM_KarstCav_Door", "BM_kartaag_Door", "Ex_BM_tomb_door_skaalara", "ex_co_ship_trapdoor", "Ex_co_ship_cabindoor", "Ex_colony_door03_1_uryn", "Rent_colony_door", "BM_mazegate_01", "BM_mazegate_02", "BM_mazegate_03", "BM_KA_door_dark_SG", "Ex_S_door_double_GH", "BM_KA_door_dark_02", "ex_BM_ringdoor", "Ex_colony_door05_int_a", "Ex_colony_door05_int_b", "Ex_colony_door05_int_c", "In_DB_door01", "In_DB_door_oval", "In_OM_door_round", "in_m_sewer_trapdoor_01", "In_M_sewer_door_01", "In_DB_door_oval_02", "In_MH_door_01", "In_MH_door_02", "door_sotha_load", "door_sotha_pre_load", "door_dwe_00_exp", "ex_nord_door_01_ignatius", "ex_nord_door_01_ignatius1", "door_cavern_doors00_velas", "in_hlaalu_door_uni", "door_sotha_mach_door", "Ex_MH_sewer_trapdoor_01", "Indalen_closet_door", "EX_MH_temple_door_01", "Ex_MH_Door_01", "In_DB_door_oval_relvel", "In_MH_jaildoor_01", "In_MH_door_02_play", "Ex_MH_swr_trapdr_blkd", "in_m_sewer_trapdoor_01_blkd", "EX_MH_door_02", "In_MH_trapdoor_01", "In_MH_door_01_velas", "door_sotha_mach_door2", "door_sotha_imp_door", "In_MH_door_02_hels_uni", "In_MH_door_02_bar2_uni", "In_MH_door_02_bar1_uni", "EX_MH_door_02_sadri", "Ex_MH_sewer_trapdoor_sadri", "In_MH_door_02_bar3_uni", "door_load_darkness00", "Ex_MH_Pav_Gate_Door", "Ex_MH_Pav_Ladder_01", "Ex_MH_Palace_gate", "In_MH_Pav_Ladder", "In_MH_door_02_chapel", "EX_MH_temple_door_01_ch", "In_MH_door_02_bar4_uni", "EX_MH_door_02_velas", "Rent_MH_Guar_Door", "EX_MH_door_02_ignatius", 
 "In_MH_door_02_throne1", "In_MH_door_02_throne2"}

 -- house block				
				if not tableHelper.containsValue(doorTable, tes3mp.GetObjectRefId(index)) and Players[pid].data.isInOwnedHouse == true then
					isValid = false

				end
-- sneak block  
				if tes3mp.GetSneakState(activatingPid) and tes3mp.GetCell(pid) == "ToddTest" then
					isValid = false
				elseif tes3mp.GetSneakState(activatingPid) and tes3mp.GetCell(pid) == "Suran, Goldyn Belaram; Pawnbroker" then
					isValid = false				
				elseif tes3mp.GetSneakState(activatingPid) and Players[pid].data.customVariables.stealthThief == 0 then
					isValid = false
				end
-- summons block
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "daedroth_summon" then
					isValid = false
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "dremora_summon" then
					isValid = false
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "golden saint_summon" then
					isValid = false
				end
-- loot blocks
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "bovkinna" then
					isValid = false
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "vala herennius" then
					isValid = false
				end

-- delete mode
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
-- party commands
				-- to see the current stats of PartyMembers
-- add to eventHandlers OnActivate Chain

				if isObjectPlayer and GroupParty.IsParty(activatingPid) then 
					local activatedOne = tes3mp.GetObjectPid(index)
					local health = tostring(tes3mp.GetHealthCurrent(activatedOne))
					local magicka = tostring(tes3mp.GetMagickaCurrent(activatedOne))
					local fatigue = tostring(tes3mp.GetFatigueCurrent(activatedOne))

					local maxHealth = tostring(tes3mp.GetHealthBase(activatedOne))
					local maxMagicka = tostring(tes3mp.GetMagickaBase(activatedOne))
					local maxFatigue = tostring(tes3mp.GetFatigueBase(activatedOne))


					local List = ""
					List = List .. color.Aqua .. Players[activatedOne].name.."\n\n"
					List = List .. color.White .. "Current Health: " .. color.Red .. math.floor(health / maxHealth * 100) .. "%\n"
					List = List .. color.White .. "Current Magicka: " .. color.RoyalBlue .. math.floor(magicka / maxMagicka * 100) .. "%\n"
					List = List .. color.White .. "Current Fatigue: " .. color.LightGreen .. math.floor(fatigue / maxFatigue * 100) .. "%\n"
					tes3mp.MessageBox(activatingPid,-1,List)
				end
-- Tutorials
-- Redas Robe of Deeds
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "ex_velothi_loaddoor_01" and tes3mp.GetCell(pid) ==
				"13, -9" and Players[pid].data["redasRobeTutorial"] == nil then
					isValid = true
						Players[pid].currentCustomMenu = "redas robe tutorial"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end	
-- Dungeon Intros
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "door_cavern_doors10" and tes3mp.GetCell(pid) ==
				"-9, 4" then
					isValid = true
						Players[pid].currentCustomMenu = "ilunibi intro"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end	
-- Azura Block
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "active_dae_azura" then
					isValid = false
						tes3mp.MessageBox(pid, -1, "This quest is currently unavailable in this world.")
				end					
-- Transporters
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"ToddTest" and Players[pid].data["transportTutorial"] == nil then
					isValid = false
						Players[pid].currentCustomMenu = "great hall transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"0, -7" then
					isValid = false
						Players[pid].currentCustomMenu = "pelagiad transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"-3, -2" then
					isValid = false
						Players[pid].currentCustomMenu = "balmora transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"-2, 2" then
					isValid = false
						Players[pid].currentCustomMenu = "caldera transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"-2, -9" then
					isValid = false
						Players[pid].currentCustomMenu = "seyda neen transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"6, -7" then
					isValid = false
						Players[pid].currentCustomMenu = "suran transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"Mournhold, Temple Courtyard" then
					isValid = false
						Players[pid].currentCustomMenu = "mournhold transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"-22, 17" then
					isValid = false
						Players[pid].currentCustomMenu = "frostmoth transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"Sotha Sil, Outer Flooded Halls" then
					isValid = false
						Players[pid].currentCustomMenu = "sotha sil transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end	
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"-9, 16" then
					isValid = false
						Players[pid].currentCustomMenu = "khuul transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"-11, 11" then
					isValid = false
						Players[pid].currentCustomMenu = "gnisis transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"-4, 18" then
					isValid = false
						Players[pid].currentCustomMenu = "urshilaku transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"7, 22" then
					isValid = false
						Players[pid].currentCustomMenu = "dagon fel transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"11, 14" then
					isValid = false
						Players[pid].currentCustomMenu = "vos transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"13, 14" then
					isValid = false
						Players[pid].currentCustomMenu = "tel mora transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"15, 5" then
					isValid = false
						Players[pid].currentCustomMenu = "tel aruhn transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"17, 4" then
					isValid = false
						Players[pid].currentCustomMenu = "sadrith mora transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"15, 1" then
					isValid = false
						Players[pid].currentCustomMenu = "tel fyr transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"13, -8" then
					isValid = false
						Players[pid].currentCustomMenu = "molag mar transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"14, -13" then
					isValid = false
						Players[pid].currentCustomMenu = "tel branora transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"3, -10" then
					isValid = false
						Players[pid].currentCustomMenu = "vivec transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"-6, -5" then
					isValid = false
						Players[pid].currentCustomMenu = "hla oad transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"-8, 3" then
					isValid = false
						Players[pid].currentCustomMenu = "gnaar mok transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"-2, 6" then
					isValid = false
						Players[pid].currentCustomMenu = "ald-ruhn transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"4, -11" then
					isValid = false
						Players[pid].currentCustomMenu = "arena transporter"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) ==
				"Vivec, Arena Pit" then
					isValid = false
						Players[pid].currentCustomMenu = "arena spectators"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
-- Great Hall(toddTest cell) Shop Items
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "crafting_anvil" then
					isValid = false
						Players[pid].currentCustomMenu = "crafting menu"
                                    menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "crafting_hammer" then
					isValid = false
						Players[pid].currentCustomMenu = "crafting menu"
                                    menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
-- Elton Brand
                if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "katana_bluebrand_unique_dis" then
                    isValid = false
                        Players[pid].currentCustomMenu = "elton brand"
                                    menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
                end
-- Auriel's Bow
                if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "ebony_bow_auriel_2_dis" then
                    isValid = false
                        Players[pid].currentCustomMenu = "auriel bow"
                                    menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
                end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "poison_flask" and Players[pid].data.customVariables.stealthPoisonTips == 0 then
					isValid = false
                        Players[pid].currentCustomMenu = "can't make poison"
                                    menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "poison_flask" and Players[pid].data.customVariables.stealthPoisonTips == 1 then
                    isValid = false
                        Players[pid].currentCustomMenu = "poison tips"
                                    menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
                end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "fletching_table" then
                    isValid = false
                        Players[pid].currentCustomMenu = "fletching menu"
                                    menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
                end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "tannery" then
					isValid = false
						Players[pid].currentCustomMenu = "leather menu"
                                    menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "spinning_wheel" then
					isValid = false
						Players[pid].currentCustomMenu = "tailoring menu"
                                    menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "boots_speed_50_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "heavy boots of speed"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "boots_speed_60_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "medium boots of speed"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "boots_speed_70_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "light boots of speed"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "regen_ammy_1_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "lesser regen amulet"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "healer_ammy_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "healer's amulet"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "christmas_stars" and tes3mp.GetCell(pid) == "ToddTest" then
					isValid = false
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "mana_ammy_1_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "mana regen amulet"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "glove_l_str_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "glove of strength"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "glove_r_marksman_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "marksman glove"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "glove_r_armorer_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "armorer glove"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "leapfrog_ring_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "leapfrog ring"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "divers_ring_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "diver ring"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "book_of_fire_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "book of fire"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "book_of_summoning_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "book of summoning"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "book_of_vitality_dis" then
                    isValid = false
						Players[pid].currentCustomMenu = "book of vitality"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end			


-- daedroth_a activation block
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "daedroth_a" then
                    isValid = false
						Players[pid].currentCustomMenu = "cannot loot"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
-- daedroth_a activation block
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "skeleton_wizard_a" then
                    isValid = false
						Players[pid].currentCustomMenu = "cannot loot"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end			
-- Legendary Items
-- Helm of Bearclaw
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "active_dae_malacath" and 
                    tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "da_malacath", index = 70 }, true) then	
					isValid = true

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "active_dae_malacath" and 
                    tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "da_malacath", index = 60 }, true) then
						Players[pid].currentCustomMenu = "bear claw"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
						logicHandler.RunConsoleCommandOnPlayer(pid, 'additem "helm_bearclaw_unique" 1')
						logicHandler.RunConsoleCommandOnPlayer(pid, 'PlaySound "miss"')
						logicHandler.RunConsoleCommandOnPlayer(pid, 'journal "da_malacath" 70')
logicHandler.RunConsoleCommandOnPlayer(pid, 'say, "Vo\\Misc\\DA_MalacathComplete.wav","You have killed the false hero, and ensured there will be no more to follow. You have helped bring honor back to the Orcish people, and for that I am glad. Here, take the Helm of Oreyn Bearclaw. Wear it proudly, and let it serve as a reminder of what really happened."')
						tes3mp.MessageBox(pid, -1, "The Helm of Oreyn Bearclaw has been added to your inventory.")		
				end
-- Goldbrand	
-- First part(broken shrine)
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "active_dae_b_bo_head" and Players[pid].data["legendaryGoldbrand"] == nil then	
					isValid = false
					Players[pid].currentCustomMenu = "cannot loot"
                    menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end

				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "ex_dae_boethiah_fixed" and 
                    tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "da_boethiah", index = 70 }, true) then	
					isValid = false
				end

-- Ten Pace Boots
				if doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Bal Fell, Inner Shrine" and tes3mp.GetObjectRefId(index) == "de_p_chest_balfell"
				and Players[pid].data["legendaryTenPace"] == 0 then
					isValid = true			
				elseif doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Bal Fell, Inner Shrine" and tes3mp.GetObjectRefId(index) == "de_p_chest_balfell" 
				and Players[pid].data["legendaryTenPace"] == nil then
					isValid = false
						Players[pid].currentCustomMenu = "cannot loot yet"
                            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)				
				end
-- Dragonbone Cuirass
				if doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Mudan, Central Vault" and tes3mp.GetObjectRefId(index) == "dwrv_closet_dragon"
				and Players[pid].data["legendaryDragonBone"] == 0 then
					isValid = true					
				elseif doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Mudan, Central Vault" and tes3mp.GetObjectRefId(index) == "dwrv_closet_dragon" 
				and Players[pid].data["legendaryDragonBone"] == nil then
					isValid = false
						Players[pid].currentCustomMenu = "cannot loot yet"
                            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)				
				end
-- Fists of Randagulf
				if doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Ilunibi, Soul's Rattle" and tes3mp.GetObjectRefId(index) == "gauntlet_fists_l_unique"
				and Players[pid].data["legendaryRandagulf"] == 0 then
					isValid = true

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Ilunibi, Soul's Rattle" and tes3mp.GetObjectRefId(index) == "gauntlet_fists_l_unique"
				and Players[pid].data["legendaryRandagulf"] == nil then
					isValid = false
						Players[pid].currentCustomMenu = "cannot loot yet"
                            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)				
				end
				if doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Ilunibi, Soul's Rattle" and tes3mp.GetObjectRefId(index) == "gauntlet_fists_r_unique"
				and Players[pid].data["legendaryRandagulf"] == 0 then
					isValid = true

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Ilunibi, Soul's Rattle" and tes3mp.GetObjectRefId(index) == "gauntlet_fists_r_unique"
				and Players[pid].data["legendaryRandagulf"] == nil then
					isValid = false
						Players[pid].currentCustomMenu = "cannot loot yet"
                            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)				
				end

-- Fang of Haynekhtnamet
				if doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Mamaea, Shrine of Pitted Dreams" and tes3mp.GetObjectRefId(index) == "dagger_fang_unique"
				and Players[pid].data["legendaryFang"] == 0 then
					isValid = true

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Mamaea, Shrine of Pitted Dreams" and tes3mp.GetObjectRefId(index) == "dagger_fang_unique" 
				and Players[pid].data["legendaryFang"] == nil then
					isValid = false
						Players[pid].currentCustomMenu = "cannot loot yet"
                            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)				
				end
-- Denstagmer's Ring
				if doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Falas Ancestral Tomb" and tes3mp.GetObjectRefId(index) == "urn_ash_nan00_unique"
				and Players[pid].data["legendaryDenstagmer"] == 0 then
					isValid = true

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Falas Ancestral Tomb" and tes3mp.GetObjectRefId(index) == "urn_ash_nan00_unique" 
				and Players[pid].data["legendaryDenstagmer"] == nil then
					isValid = false
						Players[pid].currentCustomMenu = "cannot loot yet"
                            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)				
				end
-- Phynaster Ring
				if doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Senim Ancestral Tomb" and tes3mp.GetObjectRefId(index) == "contain_corpse_pop00"
				and Players[pid].data["legendaryPhynaster"] == 0 then
					isValid = true

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetCell(pid) == "Senim Ancestral Tomb" and tes3mp.GetObjectRefId(index) == "contain_corpse_pop00" 
				and Players[pid].data["legendaryPhynaster"] == nil then
					isValid = false
						Players[pid].currentCustomMenu = "cannot loot yet"
                            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)				
				end

-- Tribunal Blocked Off
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "asciene rane" then
                    isValid = false
						Players[pid].currentCustomMenu = "mournhold blocked"
                        menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end
-- Hlormaren 1 way exit
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "door_cavern_doors10" and tes3mp.GetCell(pid) == "-7, -1"then
                    isValid = false
						tes3mp.MessageBox(pid, -1, "This door can only be opened from the other side")
				end				
-- Main Quest Fixes
-- dwemer cube
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "dwemer_cube" and tes3mp.GetCell(pid) == "Arkngthand, Cells of Hollow Hand" 
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a1_2_antabolisinformant", index = 7 }, true) then 
					isValid = false
						Players[pid].currentCustomMenu = "already looted this"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "dwemer_cube" and tes3mp.GetCell(pid) == "Arkngthand, Cells of Hollow Hand" 
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a1_2_antabolisinformant", index = 5 }, true) then 
					isValid = false
						Players[pid].currentCustomMenu = "dwemer cube"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "dwemer_cube" and tes3mp.GetCell(pid) == "Arkngthand, Cells of Hollow Hand" then 
					isValid = false
						Players[pid].currentCustomMenu = "item is blocked"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)	
				end

-- andrano skull
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "andrano_skull" and tes3mp.GetCell(pid) == "Andrano Ancestral Tomb" 
				and Players[pid].data["andranoSkull"] == 1 then 
					isValid = false
						Players[pid].currentCustomMenu = "already looted this"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "andrano_skull" and tes3mp.GetCell(pid) == "Andrano Ancestral Tomb" 
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a1_4_muzgobinformant", index = 12 }, true) then 
					isValid = false
						Players[pid].currentCustomMenu = "andrano skull"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "andrano_skull" and tes3mp.GetCell(pid) == "Andrano Ancestral Tomb" then 
					isValid = false
						Players[pid].currentCustomMenu = "item is blocked"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)	
				end

-- Holamayan Time Skip
-- transporter to enter
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) == "19, -4"
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a2_4_milogone", index = 22 }, true) then 
					isValid = false
						Players[pid].currentCustomMenu = "holamayan monastery"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc" and tes3mp.GetCell(pid) == "19, -4"
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a2_4_milogone", index = 22 }, false) then 
					isValid = true
				end

-- transporter to leave
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc_2" and tes3mp.GetCell(pid) == "19, -4"
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a2_4_milogone", index = 22 }, true) then 
					isValid = false
						Players[pid].currentCustomMenu = "holamayan monastery exit"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "transport_npc_2" and tes3mp.GetCell(pid) == "19, -4"
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a2_4_milogone", index = 22 }, false) then 
					isValid = true
				end

-- Nibani Maesa Wait Duration
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "nibani maesa" and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a2_6_incarnate", index = 1 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a2_6_incarnate", index = 5 }, true) then
					isValid = true
				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "nibani maesa" and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "a2_6_incarnate", index = 1 }, true) then
				logicHandler.RunConsoleCommandOnPlayer(pid, 'journal "a2_6_incarnate" 5')
					isValid = true
				end


-- Cavern of the Incarnate
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "in_ci_door_01" and tes3mp.GetCell(pid) == "6, 13"
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "A2_6_Incarnate", index = 29 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "A2_6_Incarnate", index = 50 }, true) then 
					isValid = true

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "in_ci_door_01" and tes3mp.GetCell(pid) == "6, 13"
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "A2_6_Incarnate", index = 29 }, true) then 
					isValid = false
						Players[pid].currentCustomMenu = "cavern of the incarnate"
						menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)
				end


-- hortator final part to reach vivec
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "danso indules" and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B8_MeetVivec", index = 30 }, true) then
					isValid = true

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "danso indules" 
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B5_RedoranHort", index = 50 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B6_HlaaluHort", index = 50 }, true) 
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B7_TelvanniHort", index = 50 }, true) and
			--	and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B7_TelvanniHort", index = 60 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B2_AhemmusaSafe", index = 50 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B4_KillWarLovers", index = 50 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B3_ZainabBride", index = 50 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B1_UnifyUrshilaku", index = 50 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "b8_meetvivec", index = 1 }, true) then
				logicHandler.RunConsoleCommandOnPlayer(pid, 'journal "B8_MeetVivec" 30')
					isValid = true

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "danso indules" 
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B5_RedoranHort", index = 50 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B6_HlaaluHort", index = 50 }, true) 
			--	and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B7_TelvanniHort", index = 50 }, true) and
				and tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B7_TelvanniHort", index = 60 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B2_AhemmusaSafe", index = 50 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B4_KillWarLovers", index = 50 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B3_ZainabBride", index = 50 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "B1_UnifyUrshilaku", index = 50 }, true) and
				tableHelper.containsKeyValuePairs(Players[pid].data.journal, { quest = "b8_meetvivec", index = 1 }, true) then
				logicHandler.RunConsoleCommandOnPlayer(pid, 'journal "B8_MeetVivec" 30')
					isValid = true
				end

-- Tribunal
-- Hopesfire		
				if doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "almalexia_warrior"
				and Players[pid].data["tribunalMainQuest"] == nil then
					isValid = false
						Players[pid].currentCustomMenu = "almalexia warrior"
                            menuHelper.DisplayMenu(pid, Players[pid].currentCustomMenu)			

				elseif doesObjectHaveActivatingPlayer and tes3mp.GetObjectRefId(index) == "almalexia_warrior" and
				Players[pid].data["tribunalMainQuest"] >= 1 then
				isValid = false
				end	
