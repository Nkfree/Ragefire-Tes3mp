-- check: https://github.com/Schnibbsel/tes3mpRagefire/blob/master/scriptsToBePorted/Instructions/taxingsoulgems.txt
-- Soultax put into baseplayer:saveinventory
	  -- Are we gaining more than 500 gold from selling a soul gem with a soul? If so,
                -- apply the soul gem tax
                
				
soultax = {}

soultax = function(EventStatus, pid)
				
		
    local action = tes3mp.GetInventoryChangesAction(self.pid)
    local itemChangesCount = tes3mp.GetInventoryChangesSize(self.pid)

    tes3mp.LogMessage(enumerations.log.INFO, "Saving " .. itemChangesCount .. " item(s) to inventory with action " ..
        tableHelper.getIndexByValue(enumerations.inventory, action))

    if action == enumerations.inventory.SET then self.data.inventory = {} end

    for index = 0, itemChangesCount - 1 do
        local itemRefId = tes3mp.GetInventoryItemRefId(self.pid, index)

        if itemRefId ~= "" then

            local item = {
                refId = itemRefId,
                count = tes3mp.GetInventoryItemCount(self.pid, index),
                charge = tes3mp.GetInventoryItemCharge(self.pid, index),
                enchantmentCharge = tes3mp.GetInventoryItemEnchantmentCharge(self.pid, index),
                soul = tes3mp.GetInventoryItemSoul(self.pid, index)
            }

            tes3mp.LogAppend(enumerations.log.INFO, "- id: " .. item.refId .. ", count: " .. item.count ..
                ", charge: " .. item.charge .. ", enchantmentCharge: " .. item.enchantmentCharge ..
                ", soul: " .. item.soul)

            if action == enumerations.inventory.SET or action == enumerations.inventory.ADD then
		
				
				if item.refId == "gold_001" and item.count > 10 and type(self.lastItemsRemoved) == "table" and
                    os.time() - self.lastItemsRemovedTime <= 2 then

                    local useSoulTax = false

                    for _, lastItemRemoved in pairs(self.lastItemsRemoved) do
                        if lastItemRemoved.soul ~= "" then
                            useSoulTax = true
                            break
                        end
                    end
					if useSoulTax then
                        -- Remove the gold we've received
                        self:LoadItemChanges({item}, enumerations.inventory.REMOVE)
                        -- Instead, give the player 5% of the normal value or 500 gold,
                        -- whichever of those 2 sums is higher
                        item.count = math.max(item.count * 0.01, 50)
                        self:LoadItemChanges({item}, enumerations.inventory.ADD)
                        tes3mp.MessageBox(self.pid, -1, "You have only received " .. item.count .. " gold from that " ..
                            "transaction due to the soul gem tax.")
                    end
				end
			end
		end
	end
			
end

					
	

customEventHooks.registerHandler("OnPlayerInventory", soultax)				
					