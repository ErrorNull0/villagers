-- ============================================ HELPER FUNCTIONS ==========================================
-- ========================================================================================================

-- round a decimal number to any number of decimal points
-- or round to nearest whole number if decimal_places is omitted
function villagers.round(float_number, decimal_places)
	local multiplier
	if decimal_places then multiplier = 10^decimal_places 
	else multiplier = 1 end
	return math.floor(float_number * multiplier + 0.5) / multiplier
end

function villagers.copytable(source_table)
	local new_table = {}
	for i = 1, #source_table do
		table.insert(new_table, source_table[i])
	end
	return new_table
end

-- returns the full registered nodename (ex. default:dirt) as well as
-- an all-caps shortened version of the nodename (ex. DIRT) at given position
function villagers.getNodeName(pos)	
	local node_name = minetest.get_node({x=pos.x,y=pos.y,z=pos.z}).name
	local node_nickname
	local name_table = string.split(node_name, ":")
	if #name_table > 1 then 
		node_nickname = name_table[2]
	else 
		node_nickname = name_table[1]
	end	
	return {node_name, string.upper(node_nickname)}
end

-- get direction (N, NE, E, SE, S, SW, W, NW) from yaw
-- yaw can be radians or degrees (0-360)
--local YAWS = { 0, -0.785, -1.571, -2.356, 3.141, 2.356, 1.571, 0.785}
--local villagers.DIRECTIONS = { "N", "NE", "E", "SE", "S", "SW", "W", "NW"}
function villagers.getDirectionFromYaw(yaw)
	local direction
		if yaw == 0 then direction = "N"
		elseif yaw == -0.785 or yaw == 45 then direction = "NE"
		elseif yaw == -1.571 or yaw == 90 then direction = "E"
		elseif yaw == -2.356 or yaw == 135 then direction = "SE"
		elseif yaw == 3.141 or yaw == 180 then direction = "S"
		elseif yaw == 2.356 or yaw == 225 then direction = "SW"
		elseif yaw == 1.571 or yaw == 270 then direction = "W"
		elseif yaw == 0.785 or yaw == 315 then direction = "NW"
		else
			print("\n## ERROR invalid yaw="..yaw)
		end
		
	return direction
end

function villagers.getFacingNodeInfo(self)
	local facing_dir = self.vFacingDirection
	local dug_pos = {
		x=self.vPos.x + villagers.NODE_AREA[facing_dir][1], 
		y=self.vTargetHeight, 
		z=self.vPos.z + villagers.NODE_AREA[facing_dir][2]
	}
	local node_names = villagers.getNodeName(dug_pos)	
	return {dug_pos, node_names[1], node_names[2]}
end

-- makes villager turn and face toward player's direction
function villagers.turnToPlayer(self, player)
	local entityPos = self.object:getpos()
	local playerPos = player:getpos()
	local dx = entityPos.x - playerPos.x
	local dz = playerPos.z - entityPos.z
	self.object:set_yaw(math.atan2(dx, dz))
end

function villagers.removeTextHud(self, player)

	local hud_id_table = self.vHudIds[player:get_player_name()]
	if #hud_id_table > 0 then
		if villagers.log2 then io.write("Removing Text Hud IDs: ") end
		local hud_id_data
		hud_id_data = table.remove(hud_id_table)
		for i = 1, #hud_id_data do
			local hud_id = hud_id_data[i]
			player:hud_remove(hud_id)
			io.write(hud_id.." ")
		end
	else
		if villagers.log2 then io.write("NoTextHudsShowing doNothing ") end
	end
	
end

function villagers.showAlert(self, player, alert_text, timer)

	if self.vHudIds.alert_text then
		player:hud_remove(self.vHudIds.alert_text)
		self.vHudIds.alert_text = nil
	end
	
	if self.vHudIds.alert_box then
		player:hud_remove(self.vHudIds.alert_box)
		self.vHudIds.alert_box = nil
	end

	if timer == nil then timer = 3 end
		
	-- show alert box
	local alert_box_id = player:hud_add({
		hud_elem_type = "image",
		scale = { x = 1, y = 1 },
		position = { x = 0.5, y = 0.0 },
		text = "alert_box.png",
		offset = {x=-30, y=50}, 
	})
	
	--show text within alert box
	local alert_text_id = player:hud_add({
		hud_elem_type = "text",
		position = { x = 0.5, y = 0.0 },

		text = alert_text,
		number = 0xFFFFFF,
		offset = {x=-30, y=50} 
	})
	
	if villagers.log2 then io.write("alertBox hudIDs saved ") end
	
	table.insert(self.vHudIds, 1, {alert_box_id, alert_text_id})
	minetest.after(timer, function() 
		io.write("\n## MINETEST.AFTER()!! deleting alert text IDs..")
		villagers.removeTextHud(self, player)
	end)
	
	if villagers.log2 then 
		io.write("newTextIds:"..dump(self.vHudIds.chats.timed[villager_id]).." ")
	end
		

end