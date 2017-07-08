local function validateVillageParameters(parameter, type, playername, village)
	if type == "region" then
		if parameter == nil then
			minetest.chat_send_player(playername, "Region not specified - set to NORMAL.")
			return "normal"
		else 
			for i=1, #villagers.REGIONS do
				if villagers.REGIONS[i] == parameter then return parameter end
			end
			return "normal"
		end
		
	elseif type == "village" then
		if parameter == nil then
			minetest.chat_send_player(playername, "Village not specified - set to NORE.")
			return "nore"
		else
			for i=1, #villagers.VILLAGES do
				if villagers.VILLAGES[i] == parameter then return parameter end
			end
			return "nore"
		end
		
	elseif type == "plot" then
		if parameter == nil then
			minetest.chat_send_player(playername, "Plot not specified - set to EMPTY.")
			return "empty"
		else
			for i=1, #villagers.PLOTS do
				if villagers.PLOTS[i] == parameter then return parameter end
			end
			return "empty"
		end
		
	elseif type == "schem" then
		local schems_available = villagers.SCHEMS[village]
		local random_schem = schems_available[math.random(#schems_available)]
		if parameter == nil then
			minetest.chat_send_player(playername, "Schem not specified. Random: "..random_schem)
			return random_schem
		else
			for i=1, #schems_available do
				if schems_available[i] == parameter then return parameter end
			end
			return random_schem
		end
		
	end
end

-- manually spawn villager via chat command. mostly for testing.
minetest.register_chatcommand("villagers", {
	params = "<region> <village> <building> <schem>",
	description = "Spawn Villager",
	privs = {},	
	func = function(name, param)
		
		--local admin = minetest.check_player_privs(name, {server=true})
		--if admin then
		local player = minetest.get_player_by_name(name)
		local entity_name = "villagers:villager"
		local pos = vector.round(player:getpos())
		
		-- for some reason spawning on roads need to be shifted up by 1 block
		if villagers.getNodeName(pos)[2] == "ROAD" then pos.y = pos.y + 1.5
		else pos.y = pos.y + 0.5 end
		
		local params = string.split(param, " ")	
		local region = validateVillageParameters(params[1], "region", name)
		local village = validateVillageParameters(params[2], "village", name)
		local plot = validateVillageParameters(params[3], "plot", name)
		local schem = validateVillageParameters(params[4], "schem", name, village)
		
		-- spawn the villager
		local luaEntity = villagers.spawnVillager(pos, region, village, plot, schem)
		
		-- set metadata for later formspec use
		--setTradingMeta(luaEntity)
			
		--else minetest.chat_send_player(name, "ERROR. Must be admin to spawn villager.") end
	end,
})