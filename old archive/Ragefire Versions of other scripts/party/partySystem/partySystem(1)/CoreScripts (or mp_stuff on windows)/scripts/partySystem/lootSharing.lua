lootSharing = {}

function lootSharing.IsMerchantCell(pid)
    local merchantCells = {
		"Ahemmusa Camp, Lanabi's Yurt", "Ahemmusa Camp, Mamaea's Yurt", "Ahemmusa Camp, Wise Woman's Yurt", "-11, 15", "Ald Velothi, Outpost", "-2, 6", 
		"Ald-ruhn, Ald Skar Inn", "Ald-ruhn, Bevene Releth: Clothier", "Ald-ruhn, Bivale Teneran: Clothier", "Ald-ruhn, Cienne Sintieve: Alchemist",
		"Ald-ruhn, Codus Callonus: Bookseller", "Ald-ruhn, Daynes Redothril: Pawnbroker", "Ald-ruhn, Guild of Fighters", "Ald-ruhn, Guild of Mages",
		"Ald-ruhn, Llether Vari: Enchanter", "Ald-ruhn, Morag Tong Guildhall", "Ald-ruhn, Redoran Council Hall", "Ald-ruhn, Guls Llervu's House",
 	 	"Ald-ruhn, Malpenix Blonia: Trader", "Ald-ruhn, Tuveso Beleth: Smith", "Ald-ruhn, Temple", "Ald-ruhn, The Rat In The Pot", 
 	 	"Ald'ruhn, Tiras Sadus: General Merchandise", "9, -10", "Balmora, Clagius Clanler: Outfitter", "Balmora, Council Club", 
 	 	"Balmora, Dorisa Darvel: Bookseller", "Balmora, Dralasa Nithryon: Pawnbroker", "Balmora, Eight Plates", "Balmora, Guild of Fighters", 
 	 	"Balmora, Guild of Mages", "Balmora, Hecerinde's House", "Balmora, Hlaalu Council Manor", "Balmora, Lucky Lockup", "Balmora, Meldor: Armorer", 
 	 	"Balmora, Milie Hastien: Fine Clothier", "Balmora, Morag Tong Guild", "Balmora, Nalcarya of White Haven: Fine Alchemist", "Balmora, Ra'Virr: Trader", 
 	 	"Balmora, South Wall Cornerclub", "Balmora, Temple", "Balmora, The Razor Hole", "Balmora, Tyermaillin's House", "-3, -8", "Buckmoth Legion Fort, Interior",
 	 	"Caldera, Falanaamo: Clothier", "Caldera, Ghorak Manor", "Caldera, Governor's Hall", "Caldera, Guild of Mages", "Caldera, Hodlismod: Armorer", 
 	 	"Caldera, Irgola: Pawnbroker", "Caldera, Shenk's Shovel", "Caldera, Verick Gemain: Trader", "Clutter Warehouse - Everything Must Go!", 
 	 	"Dagon Fel, Heifnir: Trader", "Dagon Fel, The End of the World", " Dagon Fel, End of the World Renter Rooms", "Dren Plantation, Verethi and Dralor", 
 	 	"Ebonheart, Hawkmoth Legion Garrison", "Ebonheart, Imperial Chapels", "Ebonheart, Six Fishes", "Erabenimsun Camp, Addut-Lamanu's Yurt",
 	 	"Erabenimsun Camp, Massarapal's Yurt", "Erabenimsun Camp, Wise Woman's Yurt", "Ghostgate, Temple", "Ghostgate, Tower of Dawn",
 	 	"Ghostgate, Tower of Dawn Lower Level", "Ghostgate, Tower of Dusk", "Ghostgate, Tower of Dusk Lower Level", "Gnaar Mok, Druegh-jigger's Rest",
 	 	"Gnaar Mok, Nadene Rotheran's Shack", "-11, 11", "Gnisis, Abelmawia Hut", "Gnisis, Fort Darius", "Gnisis, Madach Tradehouse", "Gnisis, Temple",
 	 	"Hla Oad, Fatleg's Drop Off", "Holamayan Monastery", "Indarys Manor, Berendas' House", "Indarys Manor, Manor Services", "Khuul, Thongar's Tradehouse",
 	 	"Maar Gan, Andus Tradehouse", "Maar Gan, Outpost", "Maar Gan, Shrine", "Molag Mar, Redoran Stronghold", "Molag Mar, Saetring the Nord: Smith",
 	 	"Molag Mar, St. Veloth's Hostel", "Molag Mar, Temple", "Molag Mar, The Pilgrim's Rest", "Molag Mar, Vasesius Viciulus: Trader",
 	 	"Moonmoth Legion Fort, Interior", "Pelagiad, Fort Pelagiad", "Pelagiad, Halfway Tavern", "Pelagiad, Mebestien Ence: Trader",
 	 	"Pelagiad, Uulernil: Armorer", "Rethan Manor", "Rethan Manor, Drelas' House", "17, 4", "18, 4", "Sadrith Mora, Anis Seloth: Alchemist",
 	 	"Sadrith Mora, Dirty Muriel's Cornerclub", "Sadrith Mora, Fara's Hole in the Wall", "Sadrith Mora, Gateway Inn", "Sadrith Mora, Morag Tong Guild",
 	 	"Sadrith Mora, Nevrila Areloth's House", "Sadrith Mora, Pierlette Rostorard: Apothecary", "Telvanni Council House, Chambers", 
		"Telvanni Council House, Entry", "Sadrith Mora, Thervul Serethi: Healer", "Seyda Neen, Arrille's Tradehouse", "Suran, Desele's House of Earthly Delights",
		"Suran, Garothmuk gro-Muzgub: Smith", "Suran, Goldyn Belaram: Pawnbroker", "Suran, Ibarnadad Assirnarari: Apothecary", "Suran, Oran Manor",
		"Suran, Ralds Oril: Trader", "Suran, Ranosa Gilvayn: Outfitter", "Suran, Suran Temple", "Suran, Suran Tradehouse", "Suran, Verara Rendo: Clothier",
		"Tel Aruhn, Aryne Telnim: Smith", "Tel Aruhn, Bildren Areleth: Apothecary", "Tel Aruhn, Ferele Athram: Trader", "Tel Aruhn, Maren Uvaren: Enchanter",
		"Tel Aruhn, Plot and Plaster", "Tel Aruhn, Tower Entry", "Tel Aruhn, Tower Living Quarters", "Tel Branora, Fadase Selvayn: Trader", 
		"Tel Branora, Galen Berer: Armorer", "Tel Branora, Sethan's Tradehouse", "Tel Branora, Upper Tower: Therana's Chamber", "Tel Mora, Berwen: Trader",
		"Tel Mora, Elegnan: Clothier", "Tel Mora, Jolda: Apothecary", "Tel Mora, Lower Tower", "Tel Mora, Radras: Smith", "Tel Mora, The Covenant",
		"Tel Uvirith, Menas' House", "Tel Uvirith, Omavel's House", "Tel Uvirith, Seleth's House", "Tel Vos, Services Tower", "ToddTest", -- Ragefire's Grand Hall
		"Urshilaku Camp, Kurapli's Yurt", "Urshilaku Camp, Wise Woman's Yurt", "Valenvaryon, Propylon Chamber", "3, -9", "Vivec, Arena Hidden Area",
		"Vivec, Agrippina Herennia: Clothier", "Vivec, Alusaron: Smith", "Vivec, Andilu Drothan: Alchemist", "Vivec, Aurane Frernis: Apothecary",
		"Vivec, Black Shalk Cornerclub", "Vivec, Foreign Quater Canalworks", "Vivec, Guild of Fighters", "Vivec, Guild of Mages", "Vivec, J'Rasha: Healer", 
		"Vivec, Jeanne: Trader", "Vivec, Jobasha's Rare Books", "Vivec, Foreign Quater Lower Waistworks", "Vivec, Miun-Gei: Enchanter", 
		"Vivec, Ralen Tilvur: Smith", "Vivec, Simine Fralinie: Bookseller", "Vivec, Foreign Quater Upper Waistworks", "2, -11", "Vivec, Elven Nations Cornerclub",
		"Vivec, Hlaalu Alchemist", "Vivec, Hlaalu General Goods", "Vivec, Hlaalu Pawnbroker", "Vivec, Hlaalu Temple", "Vivec, Hlaalu Vaults", 
		"Vivec, Hlaalu Waistworks", "Vivec, Hlaalu Weaponsmith", "Vivec, No Name Club", "Vivec, Redoran Smith", "Vivec, Redoran Temple Shrine", 
		"Vivec, Redoran Trader", "Vivec, The Flowers of Gold", "Vivec, St. Delyn Glassworker's Hall", "Vivec, Lucretinaus Olcinius: Trader", 
		"Vivec, Mevel Fererus: Trader", "Vivec, St. Delyn Potter's Hall", "Vivec, Tervur Braven: Trader", "Vivec, St. Olms Brewers and Fishmongers Hall", 
		"Vivec, St. Olms Canal South-One", "Vivec, St. Olms Farmers and Laborers Hall", "Vivec, St. Olms Temple", "Vivec, St. Olms Tailors and Dyers Hall",
		"Vivec, St. Olms Tanners and Miners Hall", "Vivec, St. Olms Waistworks", "Vivec, Telvanni Alchemist", "Vivec, Telvanni Apothecary",
		"Vivec, Telvanni Enchanter", "Vivec, Telvanni Temple", "Vivec, The Lizard's Head", "4, -13", "Vivec, High Fane", "Vos, Varo Tradehouse", 
		"Vos, Vos Chapel", "Sadrith Mora, Wolverine Hall: Fighter's Guild", "Sadrith Mora, Wolverine Hall: Imperial Shrine", 
		"Sadrith Mora, Wolverine Hall: Mage's Guild", "Zainab Camp, Ababael Timsar-Dadisun's Yurt", "Zainab Camp, Ashur-Dan's Yurt", 
		"Zainab Camp, Tussi's Yurt", "Zainab Camp, Wise Woman's Yurt" }
 	 	--"Ashmelech", "Druscashti, Lower Level", "Druscashti, Upper Level", "Galom Daeus, Entry" - Vampire Lairs - consider adding

	local cellName = Players[pid].data.location.cell
	if tableHelper.containsValue(merchantCells, cellName) then return true 	
	else return false
	end
end

function lootSharing.CellMessage(pid)
    if utils.PlayerPartyCheck(pid) 
    and (partySystem.utils.GetPlayerParty(pid)["lootSharing"] or partySystem.utils.GetPlayerParty(pid)["goldSplitting"])
    and partySystem.lootSharing.IsMerchantCell(pid) then
        tes3mp.MessageBox(pid, -1, "Loot sharing and gold splitting are disallowed in this area.")
	end
end

function lootSharing.SplitGold(pid, goldAmount)

	local goldItem = { ["refId"] = "gold_001", ["count"] = goldAmount, ["charge"] = -1, ["enchantCharge"] = -1, ["soul"] = "" }
	Players[pid]:LoadItemChanges({goldItem}, enumerations.inventory.REMOVE)	
	local dynamicParty = partySystem.utils.GetPlayerDynamicParty(pid)
	local takerCell = Players[pid].data.location.cell

	elligiblePidArray = {}                                     		 --We have to loop through dynamic members to
	for _,playerPid in pairs (dynamicParty["memberPids"]) do   		 --know which are in the same cell - we don't
		if  Players[playerPid].data.location.cell == takerCell then  --store this kind of data :(
			table.insert(elligiblePidArray,playerPid)
		end
	end																
		
	if #elligiblePidArray > 1 then
		local goldPerMember = math.floor(goldAmount/#elligiblePidArray)
		goldItem["count"] = goldPerMember		

		for _,playerPid in ipairs(elligiblePidArray) do --booo :(
			inventoryHelper.addItem(Players[playerPid].data.inventory, "gold_001", goldPerMember, -1, -1, "")
	        if logicHandler.IsGeneratedRecord(goldItem.refId) then
	            local recordStore = logicHandler.GetRecordStoreByRecordId(goldItem.refId)

	            if recordStore ~= nil then
	               Players[randomMemberPid]:AddLinkToRecord(recordStore.storeType, goldItem.refId)
	            end
	        end
			Players[playerPid]:Save()
			Players[playerPid]:LoadItemChanges({goldItem}, enumerations.inventory.ADD)			
		end	

		local beneficiaryExcess = goldAmount%#elligiblePidArray
		local beneficiaryText = "!"
		if beneficiaryExcess > 0 then
			goldItem["count"] = beneficiaryExcess		
			local leaderPid = dynamicParty["memberPids"][partySystem.utils.GetPlayerParty(pid)["leaderName"]]
			local beneficiaryPid = -1		

			if leaderPid ~= nil and Players[leaderPid].data.location.cell == takerCell then
				beneficiaryPid = leaderPid 
			else beneficiaryPid = pid 
			end 
										
			inventoryHelper.addItem(Players[beneficiaryPid].data.inventory, "gold_001", beneficiaryExcess, -1, -1, "")
			if logicHandler.IsGeneratedRecord(goldItem.refId) then
	            local recordStore = logicHandler.GetRecordStoreByRecordId(goldItem.refId)

	            if recordStore ~= nil then
	               Players[beneficiaryPid]:AddLinkToRecord(recordStore.storeType, goldItem.refId)
	            end
	        end
			Players[beneficiaryPid]:Save()		
			Players[beneficiaryPid]:LoadItemChanges({goldItem}, enumerations.inventory.ADD)	
			beneficiaryText = ", "..Players[beneficiaryPid].name.." has received the remainder of "..beneficiaryExcess.. " gold!"
		end
		partySystem.SendToParty(Players[pid].data.customVariables.partyName, "Each member in "..Players[pid].name.."'s location has received "..goldPerMember.." gold"..beneficiaryText)
	elseif #elligiblePidArray == 1 then --Oh great, so nobody else is around	
		inventoryHelper.addItem(Players[pid].data.inventory, "gold_001", goldAmount, -1, -1, "")
		if logicHandler.IsGeneratedRecord(goldItem.refId) then
	    	local recordStore = logicHandler.GetRecordStoreByRecordId(goldItem.refId)

	        if recordStore ~= nil then
	           Players[pid]:AddLinkToRecord(recordStore.storeType, goldItem.refId)
	        end
	    end
    	Players[pid]:Save()		
		Players[pid]:LoadItemChanges({goldItem}, enumerations.inventory.ADD)	
	end	
end

function lootSharing.ShuffleItem(pid, item)

	Players[pid]:LoadItemChanges({item}, enumerations.inventory.REMOVE) 
    local dynamicParty = partySystem.utils.GetPlayerDynamicParty(pid)
    local takerCell = Players[pid].data.location.cell

   	local elligiblePidArray = {}
	for _,playerPid in pairs (dynamicParty["memberPids"]) do   		 
		if  Players[playerPid].data.location.cell == takerCell then  
			table.insert(elligiblePidArray,playerPid)
		end
	end				

	local randomMemberPid = -1
	if #elligiblePidArray > 1 then
		math.randomseed(os.time())
		randomMemberPid = elligiblePidArray[math.random(1,#elligiblePidArray)]
	elseif #elligiblePidArray == 1 then
		randomMemberPid = elligiblePidArray[1]
	else return		
	end
			
    inventoryHelper.addItem(Players[randomMemberPid].data.inventory, item.refId, item.count, item.charge,
        item.enchantmentCharge, item.soul)

    if logicHandler.IsGeneratedRecord(item.refId) then
        local recordStore = logicHandler.GetRecordStoreByRecordId(item.refId)

        if recordStore ~= nil then
           Players[randomMemberPid]:AddLinkToRecord(recordStore.storeType, item.refId)
        end
    end

	Players[randomMemberPid]:Save()	
	Players[randomMemberPid]:LoadItemChanges({item}, enumerations.inventory.ADD)		

	if #elligiblePidArray > 1 then
		local multipleItems = ""
		if item.count > 1 then
			multipleItems =  " x"..item.count
		end
		partySystem.SendToParty(Players[pid].data.customVariables.partyName, item.refId..multipleItems.." goes to "..Players[randomMemberPid].name)
	end
end


function lootSharing.ToggleLootShuffle(pid)
	local newValue = not partySystem.utils.GetPlayerParty(pid)["lootShuffle"]
	partyTable[Players[pid].data.customVariables.partyName]["lootShuffle"] = newValue
	jsonInterface.save("partySystem.json", partyTable)	
	if newValue then lootSharing.CellMessage(pid) end
	partySystem.SendToParty(Players[pid].data.customVariables.partyName, "Loot shuffle has been toggled "..(newValue and "on!" or "off!"))
end

function lootSharing.ToggleGoldSplitting(pid)
	local newValue = not partySystem.utils.GetPlayerParty(pid)["goldSplitting"]
	partyTable[Players[pid].data.customVariables.partyName]["goldSplitting"] = newValue
	jsonInterface.save("partySystem.json", partyTable)
	if newValue then lootSharing.CellMessage(pid) end
	partySystem.SendToParty(Players[pid].data.customVariables.partyName, "Gold splitting has been toggled "..(newValue and "on!" or "off!"))
end

return lootSharing