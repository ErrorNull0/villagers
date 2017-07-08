

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if villagers.log4 then
		io.write("\nonReceivFields() ")
		io.write("formname="..formname.." ")
		io.write("fields:"..dump(fields).."\n")
	end
	
	if player == nil then print("\n## ERROR Player = NIL ##") return end
	if formname == nil then print("\n## ERROR formname = NIL ##") return end

	local formname_data = string.split(formname, "_")
	local form_type = formname_data[1]
	
	if form_type == "villagers:trade" then
		
		local villager_id = formname_data[2]
		
		-- obtain villager entity
		local self
		for _,luaentity in pairs(minetest.luaentities) do
			if luaentity.object then
				if luaentity.vID then
					if luaentity.vID == villager_id then 
						self = luaentity 
					end
				else print("\n## ERROR Invalid vID: "..luaentity.vID.." ##") end
			else print("\n## ERROR luaentity.object = NIL ##") end
		end
		
		if fields == nil then print("\n## ERROR fields = NIL ##") return
		elseif fields.quit then
			villagers.endVillagerTrading(self, player)
		else
			local key_data
			for k,v in pairs(fields) do
				print("k="..k)
				key_data = k
			end
			
			print("key_data="..key_data)
			local fields_data = string.split(key_data, "|")
			local villager_name = fields_data[1]
			local item_name = fields_data[2]
			local cost_amount = fields_data[3]
			local item_stock = fields_data[4]
			local cost_name = fields_data[5]
			local player_quant = fields_data[6]
			local row_index = tonumber(fields_data[7])
			
			if villagers.log4 then
				io.write("vName="..villager_name.." ")
				io.write("item_name="..item_name.." ")
				io.write("cost_amount="..cost_amount.." ")
				io.write("item_stock="..item_stock.." ")
				io.write("cost_name="..cost_name.." ")
				io.write("player_quant="..player_quant.." ")
				io.write("row_index="..row_index.." ")
			end
			
			local player_name = player:get_player_name()
			local player_pos = player:get_pos()
			local player_inv = minetest.get_inventory({type="player", name=player_name})
			
			-- remove cost items from player inv
			local stack
			stack = ItemStack(cost_name.." "..cost_amount)
			player_inv:remove_item("main", stack)
			
			-- add item to player inventory
			stack = ItemStack(item_name.." 1")
			if not player_inv:room_for_item("main", stack) then
				-- throw item at player's feet
				minetest.env:add_item(player_pos, item_name)
			else
				local leftover = player_inv:add_item("main", stack)
			end
			
			if villagers.log4 then 
				print("## self.vSell: "..minetest.serialize(self.vSell).." ")
			end
			
			-- remove stock from villager
			self.vSell[row_index][2] = item_stock - 1
			if villagers.log4 then
				io.write("current_item_stock_detail: "..minetest.serialize(current_item).." ")
			end
			
			
			minetest.sound_play("coins", {pos = player_pos, gain = 0.4, max_hear_distance = 8} )
			minetest.show_formspec(player_name, "villagers:trade_"..self.vID, villagers.getTradingFormspec(self, player))
			
		end
		
	else
		io.write("No Action - Unrecognized formname: "..formname.." ")
	end

end)