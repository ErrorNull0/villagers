-- OVERRIDES

minetest.override_item("default:mese", {
	
	--[[ 
		When villager is about to first spawn, check if distance from player
		is greater than 30m. If not, spawn villager immediately. If so, 
		save all spawning parameters into nodemeta of the mob spawner and
		set a nodetimer for every 10s to check distance again. Once player
		is finally in range, spawn villager, remove saved nodemeta for that
		villager and stop nodetimer permanently.
		
		minetest.get_node_timer(pos) will execute when villager is first
		spawned in order to start time via start(timeout) once timeout.
	--]]
	on_timer = function(pos, elapsed)
		local log = true
		
		io.write("\n## TIMEOUT ")
		io.write("@"..minetest.pos_to_string(pos).." ")
		
		local meta = minetest.get_meta(pos)
		local meta_table = meta:to_table()
		
		io.write("metadata: "..minetest.serialize(meta_table.fields.spawn).." ")
		
		io.write("\n")
		-- check player distance
		-- if too far, recalibrate timer = (player_dist / 30) * 10
		-- if player dist ok...
		--- get spawn data from nodemeta at spawn position
		--- execute spawnVillager()
		--- turn off nodetimer at spawn position
		
	end
})

-- HELPER FUNCTIONS
villagers.getNearestPlayer(pos)
	local connected_players = minetest.get_connected_players()
	local player
	local player_distance = 0
	local player_pos
	for _, connected_player in ipairs(connected_players) do
		player_pos = player:get_pos()
		local dist = vector.distance(pos, player_pos)
		if dist > player_distance then
			player_distance = dist
			player = connected_player
		end
	end
	return {obj=player, pos=player_pos, dist=player_distance}
end



--[[
'village_pos' is the position of the village mg_villages mod is attempting
to finish spawning.
RETURNS the player data (name, pos, dist) that is nearest to the village
position, but not more than 50 blocks. If no players are inside 50 block
radius of village position, then function returns 'false'.
--]]
local function getValidPlayer(village_pos, distance_max)
	local log = false
	local player_pos, player_name
	local dist_current, dist_shortest
	local valid_player_name
	
	-- cycle through all connected players
	for _,player in ipairs(minetest.get_connected_players()) do
		if player then	
			player_pos = player:get_pos()
			player_name = player:get_player_name()
			dist_current = vector.distance(player_pos, village_pos)
			if log then
				io.write("\n  "..player:get_player_name()..minetest.pos_to_string(player_pos, 1).." ")
				io.write(" distance="..villagers.round(dist_current, 1).." ")
			end
			
			-- The village position from the player meets minimum distance
			-- that is visually practical to start gathering environment data
			-- which will determine the region type of this village.
			if dist_current < distance_max then
				if log then io.write("rangeOK ") end
				
				-- this is the first player in the list to be checked
				if valid_player_name == nil then
					if log then io.write("firstPlayerInSequence setAsShortestDist ") end
					dist_shortest = dist_current
					valid_player_name = player_name
					
				-- other players have already been checked
				else
					if log then io.write("checkingDist.. ") end
					-- This is the closest player distance from the
					-- village pos so far. Save this player.
					if dist_current < dist_shortest then
						if log then io.write("** betterChoiceFound ** ") end
						dist_shortest = dist_current
						valid_player_name = player_name
					else
						if log then io.write("notAnyBetter checkingNextPlayer.. ") end
					end
				end
				
			-- The village position is too far from the player. No need to
			-- attempt gathering spawning data as player most likely cannot
			-- even see to that village position.
			else
				if log then io.write("outOfRange SKIP ") end
			end
		end
	end
	if log then io.write("\n") end
	
	if valid_player_name then 
		return { name = valid_player_name, pos = player_pos, dist = dist_shortest }
	end
end


function getRegionFromArea(pos, radius)
	local log = false
	local log2 = true --show all nodes gathered
	
	local RADIUS_MAX = 30
	local origin_pos = {x=pos.x, y=pos.y, z=pos.z}
	local origin_pos_str = minetest.pos_to_string(origin_pos)
	
	-- debug output
	if log then
		io.write("\n  ")
		io.write("origin_pos"..origin_pos_str.." ")
		io.write("radius="..radius.." ")
	end
	
	if radius > RADIUS_MAX then
		if log then io.write("radiusTooLarge radiusIsNow="..RADIUS_MAX.." ") end
		radius = RADIUS_MAX 
	end
	
	if log then io.write("GettingNodes.. ")end
	
	--gather stats of the surrounding nodes at this village position
	--to determine what region (cold, hot, normal, native, desert) this
	--village should be correspond to
	local nodenames = {}
		
	-- seach each of the 8 directions N, NE, E, SE, S, SW, W, NW
	for dir_index = 1, 8 do
		local search_dir = villagers.DIRECTIONS[dir_index]
		
		if log then io.write("\n    "..search_dir..": ") end
		
		-- gather name of every odd node staring at 1 node
		-- from the origin_pos to radius
		local radius_index = 1
		local loc = {x=0, y=origin_pos.y, z=0}
		local nodename
		while radius_index < radius do
			loc.x = origin_pos.x + (villagers.NODE_AREA[search_dir][1] * radius_index)
			loc.z = origin_pos.z + (villagers.NODE_AREA[search_dir][2] * radius_index)
			nodename = villagers.getNodeName(loc)[2]
			
			if log then io.write(nodename) end
			if nodename == "ROAD" or 
				nodename == "DIRT" or 
				nodename == "STONE" or 
				nodename == "COBBLE" or 
				nodename == "AIR" then
				if log then io.write("[skipped] ") end
			else 
				if log then io.write(", ") end
				table.insert(nodenames, nodename)
			end
			
			radius_index = radius_index + 2
		end
		
	end
	
	if log2 then 
		io.write("\n  ## nodesGathered("..#nodenames.."): ")
		for i = 1, #nodenames do
			io.write(nodenames[i].." ")
		end
	end
	
	-- count re-occuring nodenames and sort from highest occurrance to lowest
	local rated_nodenames = {}
	local popped_name
	--rated_nodenames[popped_name] = 1  --record the first occurance
	
	if log then io.write("\nratingNodes.. ") end
	while #nodenames >= 0 do
		popped_name = table.remove(nodenames)
		if log then 
			io.write("\n  nodenamesSize="..#nodenames.." ")
			io.write("popped="..popped_name.." ")
		end
		
		local match_found = false
		for key,value in pairs(rated_nodenames) do
			if log then io.write("\n    '"..key.."="..value.."' ") end
			if key == popped_name then
				match_found = true
				rated_nodenames[key] = rated_nodenames[key] + 1
				if log then io.write("[MATCH] set v="..rated_nodenames[key].." ") end
				break
			else
				if log then io.write("[noMatch] loopAgain.. ") end
			end
		end
		if not match_found then
			if log then io.write("endOf 'rated_nodenames' withNoMatch savedAsNew poppingNextNode.. ") end
			rated_nodenames[popped_name] = 1
		end
		if #nodenames == 0 then 
			break 
		end
	end
	
	if log then
		io.write("\n\n## rated_nodenames: ")
		for k,v in pairs(rated_nodenames) do
			io.write(k.."="..v.." ")
		end
		io.write("\n")
	end
	
	-- identify the nodename that occurred the most
	if log then io.write("\n  getHighestRatedNode.. ") end
	local top_count = 0
	local top_nodename
	for key,value in pairs(rated_nodenames) do
		if log then 
			io.write("\n    '"..key.."="..value.."' ")
			io.write("top_count="..top_count.." ")
		end
		if value > top_count then
			top_count = value
			top_nodename = key
			if log then io.write("higherValue! setTopCount="..top_count.." setTopNode="..top_nodename.." ") end
		else
			if log then io.write("noChange ") end
		end
	end
	if log then io.write("\n  ## top_nodename = "..top_nodename.." count="..top_count.." ") end

	local region_type
	--tent, claytrader, lumberjack, log cabin, nore, medieval, taoki, cornernote 
	-- assign region type based on the top node found
	-- region types: cold, hot, normal, native, desert
	if top_nodename == "DIRT_WITH_SNOW" then 
		region_type = "cold"
	elseif top_nodename == "SNOWBLOCK" then 
		region_type = "cold"
	elseif top_nodename == "ICE" then 
		region_type = "cold"
	elseif top_nodename == "DIRT_WITH_DRY_GRASS" then 
		region_type = "hot"
	elseif top_nodename == "SAND" then 
		region_type = "hot"
	elseif top_nodename == "DIRT_WITH_GRASS" then 
		region_type = "normal"
	elseif top_nodename == "DIRT_WITH_RAINFOREST_LITTER" then 
		region_type = "native"
	elseif top_nodename == "DESERT_SAND" then 
		if math.random(3) == 1 then region_type = "hot"
		else region_type = "desert" end
	elseif top_nodename == "DESERT_STONE" then 
		if math.random(3) == 1 then region_type = "hot"
		else region_type = "desert" end
	elseif top_nodename == "SILVER_SAND" then 
		if math.random(3) == 1 then region_type = "hot"
		else region_type = "desert" end
	else 
		print("ERROR Invalid top_nodename="..top_nodename)
		villagers.error = top_nodename
		region_type = "normal"
	end
	return region_type
end

--[[
GROUND NODES:
dirt_with_snow, snowblock, ice, dirt_with_dry_grass,
sand, dirt_with_grass, dirt_with_rainforest_litter,
desert_sand, silver_sand, water_source, water_flowing, 
river_water_source, river_water_flowing, tree, 
jungletree, pine_tree, acacia_tree, aspen_tree,
DECORATIONS:
snow, cactus, papyrus, dry_shrub, junglegrass, grass_1, 
grass_2, grass_3, grass_4, grass_5, dry_grass_1,
dry_grass_2, dry_grass_3, dry_grass_4, dry_grass_5, 
bush_stem, bush_leaves, bush_sapling, acacia_bush_stem, 
acacia_bush_leaves, acacia_bush_sapling
--]]



-- main villager spawning function
<<<<<<< HEAD
function villagers.spawnVillager(pos, homeplace, player_name, trading_allowed, yaw_data, bed_data)
	local log = false
	
	if log then 
		io.write("\n      spawnVillager() ")
		io.write(homeplace.region.." "..homeplace.village.." "..homeplace.building.." "..homeplace.schem.." ")
		io.write("tradAllow="..tostring(trading_allowed).." ")
		if yaw_data then io.write("tradAllow="..tostring(trading_allowed).." ") end
		if yaw_data then io.write("tradAllow="..tostring(trading_allowed).." ") end
		io.write("spawningVillager{ ")
=======
function villagers.spawnVillager(pos, region, village_type, building_type, schem_type, trading_allowed, yaw_data, bed_data)
	--io.write("\n    spawnVillager() ")
	if building_type == nil then io.write("building_type is NIL. ")
	else io.write("building_type="..building_type.." ") end
	
	if villagers.log5 then 
		io.write("\n      spawnVillager() ")
		io.write("buildType="..building_type.." ")
		if schem_type then io.write("schemType="..schem_type.." ") 
		else io.write("schemType=NIL ") end
>>>>>>> fa0bd14a66f7bf50ffe842cf02029a973b72e1d6
	end
	
	-- SPAWN THE ACTUAL VILLAGER ENTITY!!!!
	local objectRef = minetest.add_entity(pos, "villagers:villager")
	local self = objectRef:get_luaentity()	
	
<<<<<<< HEAD
	-- If village type is unknown in ITEMS table,
	-- apply 'nore' as the default village type
	local v_type = homeplace.village
	if villagers.ITEMS[v_type] == nil then
		table.insert(self.vUnknown, "Unknown village: "..v_type.."\n")
		v_type = "nore"
	end

	-- If building type is unknown in plots table,
	-- apply 'field' as the default building type
	local b_type = homeplace.building
	if villagers.plots[b_type] == nil then
		table.insert(self.vUnknown, "Unknown building: "..b_type.."\n")
		b_type = "field"
	end
	
	-- this parameter is set within getRegionFromArea() when the rated top node
	-- after analyzing surrounding nodes is an unexpected type
	if villagers.error then
		table.insert(self.vUnknown, "Unknown topnode: "..villagers.error.."\n")
		villagers.error = nil -- reset for next villager spawning
=======
	if villagers.plots[building_type] == nil then
		print("## ERROR Unexpected building_type="..building_type)
>>>>>>> fa0bd14a66f7bf50ffe842cf02029a973b72e1d6
	end
	
	--get GENDER and save to 'vGender' object custom field
	local gender = "male"
	if math.random(villagers.plots[homeplace.building].female) == 1 then
		gender = "female"
	end
	self.vGender = gender
	if log then io.write(gender.." ") end
	
	--get AGE and save to 'vAge' object custom field
	local age_chance = villagers.plots[homeplace.building].age
	local age = age_chance[math.random(#age_chance)]
	self.vAge = age
	if log then io.write(age.." ") end
	
	--get NAME and save to 'vName' object custom field
	if homeplace.region == "native" then
		self.vName = villagers.getVillagerName(gender, homeplace.region)
	elseif homeplace.region == "desert" then
		self.vName = villagers.getVillagerName(gender, homeplace.region)
	else
		if age == "young" then
			self.vName = villagers.getVillagerName(gender, age)
		else
			self.vName = villagers.getVillagerName(gender)
		end
	end
	if log then io.write(string.upper(self.vName).." ") end
	
	--get TEXTURE, VISUAL SIZE, and COLLISION BOX and apply it to corresponding entity properties
	local newTexture, newSize, collisionBox = villagers.getVillagerAppearance(homeplace.building, homeplace.region, gender, age)
	objectRef:set_properties({textures={newTexture}})
	objectRef:set_properties({visual_size={x=newSize,y=newSize}})
	objectRef:set_properties({collisionbox=collisionBox})	
		
	--[[ Notes about vPos, vOriginPos and vTargetPos:
		* 'vPos' Tracks the current position of the villager while vOriginPos Tracks the original spawn 
		point of the villager. Both represent a valid spawn position, is typically used for disctance
		calculations, and its Y value depends on the visual size of the villager entity and collisionbox.
		At initial spawn, vPos and vOriginPos are the same value.
		* 'vTargetPos' tracks the node that verifyPath() last examined. This should not be used for spawning
		as the Y value corresponds to position of the villagers legs. vTargetPos is also used to determine
		the pos of the villager's head and pos below the feet.
	--]]
		
	local pos = objectRef:getpos()
	self.vSpawnHeight = pos.y
	self.vTargetHeight = self.vSpawnHeight - 0.5
	
	--set final position that takes into account calc'd collision_box 
	-- that was based on dynamic visual_size
	pos.y = pos.y - (1-newSize)
	objectRef:setpos(pos)
	self.vPos = {x=pos.x,y=pos.y,z=pos.z}
	self.vOriginPos = {x=pos.x,y=pos.y,z=pos.z}
	self.vTargetPos = {x=pos.x, y=self.vTargetHeight, z=pos.z}
	
	-- randomly set how often in seconds that this villager will
	-- check to do a different action
	self.vActionFrequency = math.random(4,6)
	
	--overlay applied entity new properties to custom fields
	local prop = objectRef:get_properties()
	self.vTexture = prop.textures[1]
	self.vSize = prop.visual_size
	self.vBox = prop.collisionbox
	
	self.vRegion = homeplace.region
	self.vVillage = homeplace.village
	self.vPlot = homeplace.plot
	self.vType = homeplace.building
	self.vSchem = homeplace.schem
	self.vBed = homeplace.bed
	
	-- NIL errors exists due to unknow/unexpected village or building types
	-- Replace village dialogue with error messages instead.
	if #self.vUnknown > 0 then
		local error_message = ""
		for i = 1, #self.vUnknown do
			error_message = error_message..self.vUnknown[i]
		end
		villagers.getRandomChatText(self, villagers.copytable({error_message}), "vScriptHi", 1)
		villagers.getRandomChatText(self, villagers.copytable({error_message}), "vScriptBye", 1)
		villagers.getRandomChatText(self, villagers.copytable({error_message}), "vScriptMain", 1)
		villagers.getRandomChatText(self, villagers.copytable({error_message}), "vScriptGtg", 1)
		villagers.getRandomChatText(self, villagers.copytable({error_message}), "vScriptSmalltalk", 1)
		villagers.getRandomChatText(self, villagers.copytable({error_message}), "vScriptGameFacts", 1)
		
	-- copy chat dialogue scripts from villagers.chat global var
	-- and save it into villager entity for more quicker access	
	else
		villagers.getRandomChatText(self, villagers.copytable(villagers.chat[homeplace.building].greetings), "vScriptHi", 3)
		villagers.getRandomChatText(self, villagers.copytable(villagers.chat[homeplace.building].goodbyes), "vScriptBye", 3)
		villagers.getRandomChatText(self, villagers.copytable(villagers.chat[homeplace.building].mainchat), "vScriptMain", 3)
		villagers.getRandomChatText(self, villagers.copytable(villagers.chat.gtg), "vScriptGtg", 3)
		villagers.getRandomChatText(self, villagers.copytable(villagers.chat.smalltalk), "vScriptSmalltalk", 3)
		villagers.getRandomChatText(self, villagers.copytable(villagers.chat.gamefacts), "vScriptGameFacts", 2)
	end
	
	-- use for villager trading formspec callbacks and for chat commands
	self.vID = pos.x.."_"..pos.y.."_"..pos.z
	--villagers.villager_ids[self.vID] = self.vName	
	
	-- position of nodemeta for inventory trading
	self.vNodeMetaPos = {x=pos.x, y=self.vTargetHeight-1, z=pos.z+1}
	
	-- generate list of items this villager will trade depending on building_type
	if trading_allowed == 1 then
		if log then io.write("normalTrader ") end
		self.vSell = villagers.getTradeInventory(self, homeplace.village, homeplace.schem, "sell")
	elseif trading_allowed == 2 then
		if log then io.write("smallJobsTrader ") end
		self.vSell = villagers.getTradeInventory(self, homeplace.village, homeplace.schem, "smalljobs")
	else
		if log then io.write("nonTrader ") end
		self.vSell = "none"
	end
	
	-- set door position
	self.vDoorPos = {x=pos.x, y=pos.y, z=pos.z} -- will change once true door pos is found
	
	-- prepare infotext
	local infotext_string = ""

	if self.vIsTrader then
		infotext_string = infotext_string.. "** TRADER **\n"
	end

	infotext_string = infotext_string..string.upper(self.vName).." @ "..
		homeplace.building.." ("..homeplace.schem..")\n".. 
		self.vAge.." "..self.vGender.. " in "..homeplace.region.." region\n".. 
		"door("..self.vDoorPos.x..","..self.vDoorPos.y..","..self.vDoorPos.z..")"
	
	-- set bed position
	if bed_data then
		if log then io.write("hasBeds} ") end
		self.vBedPos = bed_data
		infotext_string = infotext_string.. 
		" bed("..bed_data.x..","..bed_data.y..","..bed_data.z..")"
		--.." p2="..bed_data.p2.." typ="..bed_data.typ
	end
	
	-- save infotext to villager object
	objectRef:set_properties({infotext = infotext_string })
	
	local yaw
	if yaw_data then yaw = villagers.DEGREES_TO_YAW[yaw_data]
	else yaw = villagers.YAWS[math.random(8)] end -- set random yaw
	
	objectRef:set_yaw(yaw)
	self.vYaw = yaw
	self.vFacingDirection = villagers.getDirectionFromYaw(yaw)
	
	self.object:set_animation(
		{x=self.animation["stand_start"], y=self.animation["stand_end"]},
		self.animation_speed + math.random(10)
	)

	-- debugging
	self.vTextureString = newTexture

	
	local player = minetest.get_player_by_name(player_name)
	local dist_from_player = villagers.round(vector.distance(self.vPos, player:get_pos()), 1)
	io.write("\n")
	io.write("    SPAWNED! "..self.vID.." dist="..dist_from_player.." "..self.vName.." ")

	return self
end





local function spawnWithBeds(bpos, homeplace)
	local log = false
	
	if log then io.write("spawnWithBeds() ") end
	
	--local building_pos = {x=bpos.x, y=bpos.y, z=bpos.z}
	local beds_data = bpos.beds
	local beds_count = #beds_data
		
	-- for each bed in the building
	for bed_index = 1, beds_count do
		if log then io.write("\n    spawn_pos #"..bed_index.." ") end
		
		-- ensure only one villager (the first one) from a village and schem type
		-- that can trade goods, will actually have goods to trade. This prevents
		-- all villagers belonging a single farm for example being able to trade.
		local trading_allowed = 0
		if bed_index == 1 and villagers.ITEMS[homeplace.village][homeplace.schem] then
			trading_allowed = 1
			if log then io.write("mainTrader ") end
		
		-- each building with a bed plot will have 33% chance that the last bed will
		-- correspond to a villager that gives players coins for small resources.
		-- this is a way for players to get started on accumulating some coins.
		elseif bed_index == beds_count and (math.random(3) == 1) then
			trading_allowed = 2
			if log then io.write("simpleJobsTrader ") end
		end
		
		local mob_spawner_data = handle_schematics.get_pos_in_front_of_house(bpos, bed_index)
		local mob_spawner_pos = {x=mob_spawner_data.x, y=mob_spawner_data.y, z=mob_spawner_data.z}
		if log then io.write(minetest.pos_to_string(mob_spawner_pos).." ") end
		
		-- get data of nearest player from village pos
		if log then io.write("\n  getNearestPlayer{ ") end
		local player_data = villagers.getNearestPlayer(mob_spawner_pos)
		local player_dist = player_data.dist
		if log then 
			io.write("name="..string.upper(player_data.obj:get_player_name()).." ")
			io.write("pos"..minetest.pos_to_string(player_data.pos, 1).." ")
			io.write("dist="..villagers.round(player_dist, 1).." ")
			io.write("} ")
		end
			
		-- save villager's spawn parameters into the node metadata (in villager pos) to be
		-- used by nodetimer (in mob spawner pos) to attempt and spawn villager later,
		-- when player might be within this distance range.
		if player_dist > 30 then
			if log then io.write("distOutOfRange savingSpawnData.. ") end
			local meta = minetest.get_meta(mob_spawner_pos)
			local meta_table = meta:to_table()
			meta_table.fields.spawn = {
				pos = {
					x = mob_spawner_pos.x, 
					y = mob_spawner_pos.y + 0.5, 
					z = mob_spawner_pos.z
				},
				home = {
					region = homeplace.region,
					village = homeplace.village,
					plot_num = homeplace.plot, -- plot number
					building = homeplace.building,
					schem = homeplace.schem,
					bed_num = bed_index, -- bed number
				},
				trading = trading_allowed,
				yaw = mob_spawner_data.yaw,
				bed_data = beds_data[bed_index],
				complete = 0
			}
			if log then 
				io.write("metadata: "..minetest.serialize(meta_table.fields.spawn).." ") 
			end
			
			-- save metadata
			local meta_save_result = meta:from_table(meta_table)

			if meta_save_result then
				if log then io.write("metadataSavedOK! ") end
				
				local saved_meta = minetest.get_meta(village_pos)
				local saved_meta_table = meta:to_table()
				if log then io.write(minetest.serialize(saved_meta_table).." ") end
				
				local timeout = (player_dist / 30) * 10
				if log then io.write("settingNodeTimer="..timeout.." ") end
				
				local nodetimer = minetest.get_node_timer(mob_spawner_pos)
				nodetimer:start(timeout)
			else
				if log then io.write("metadataSaveFAILED. ") end
			end

			
			
		-- Player is within range of villager's spawn pos. Spawn the villager now!
		else
			mob_spawner_pos.y = mob_spawner_pos.y + 0.5
			homeplace.bed = bed_index
			if log then 
				if log then io.write("distOk spawnVillagerNow.. ") end
				io.write("pos"..minetest.pos_to_string(mob_spawner_pos).." ")
				io.write("type="..homeplace.building.." ")
				io.write("scm="..homeplace.schem.." ")
				io.write("region="..homeplace.region.." ")
			end
			local luaEntity = villagers.spawnVillager(
				mob_spawner_pos, 
				homeplace,
				trading_allowed, 
				mob_spawner_data.yaw, 
				beds_data[bed_index]
			)
			if log then 
				io.write("** SPAWNED on mob spawner ** ") 
			end
		end
		
	end
end





local function spawnWithNoBeds(bpos, homeplace, player_data)
	local log = false
	if log then io.write("spawnWithNoBeds() ") end
	
	local existing_villager_name
	local function villagerAlreadySpawned()
		if bpos.traders then
			existing_villager_name = bpos.traders
			return true
		else
			return false
		end
	end
	
	local function validateSpawnPosition(pos, checkNodeBelowVillager)
		local node_name = villagers.getNodeName(pos)[2]
		local result = {["pos"]=pos, ["name"]=node_name, ["result"]=false}
		local nodeIsWalkable = minetest.registered_nodes[villagers.getNodeName(pos)[1]].walkable
		local nodeIsLiquid = false
		local nodeIsSnow = false
		
		-- check if node is a liquid
		if string.find(node_name, "WATER") then nodeIsLiquid = true
		elseif string.find(node_name, "LAVA") then nodeIsLiquid = true
		elseif string.find(node_name, "SNOW") then nodeIsSnow = true
		end
		
		-- verifying node below villager's feet
		if checkNodeBelowVillager then
			if nodeIsWalkable then result.result = true end
			
		else -- verifying node at villager's upper or lower body
			if node_name == "IGNORE" then -- 'result' remains false
			elseif nodeIsSnow then result.result = true
			elseif nodeIsWalkable then -- 'result' remains false
			elseif nodeIsLiquid then -- 'result' remains false
			else result.result = true end
		end
		
		return result
	end
	
	local bpos_str = minetest.pos_to_string({x=bpos.x, y=bpos.y, z=bpos.z})
	
	if log then io.write("\n    spawn_pos #1 "..bpos_str.." ") end
	
	if villagerAlreadySpawned() then -- villager already spawned, skip.
		if log then io.write(existing_villager_name.." already spawned @ "..bpos_str.." ") end
		
	else
		if log then io.write("PosPassed"..bpos_str.." ") end
		
		local validSpawnPosFound = false
		local valid_spawn_pos
		
		-- At each position surrounding initial building spawn location, inspect a 
		-- column of 3 vertical nodes: below villagers feet, at lower body, and at upper body.
		-- If all three nodes are a valid spawn point, then spawn villager there.
		for direction, spawn_pos in pairs(villagers.NODE_AREA) do
			
			local pos1 = validateSpawnPosition({x=bpos.x+spawn_pos[1], y=bpos.y, z=bpos.z+spawn_pos[2]}, true)
			local pos2 = validateSpawnPosition({x=bpos.x+spawn_pos[1], y=bpos.y+1, z=bpos.z+spawn_pos[2]})
			local pos3 = validateSpawnPosition({x=bpos.x+spawn_pos[1], y=bpos.y+2, z=bpos.z+spawn_pos[2]})
			
			if (pos1.result and pos2.result and pos3.result) then
				validSpawnPosFound = true
				
				-- Arbitrarily chose pos3. Values for x and z are same for pos1 and pos2 too.
				valid_spawn_pos = {pos3.pos.x, pos3.pos.z} 
				break
			end
		end
		
		if validSpawnPosFound then
			if log then io.write("validPosFound ") end
			
			-- calculate villager spawn position
			local spawn_pos = {x=valid_spawn_pos[1], y=bpos.y+1.5, z=valid_spawn_pos[2]}
			local spwan_pos_str = minetest.pos_to_string(spawn_pos,1)
			
			if log then 
				io.write("pos"..minetest.pos_to_string(spawn_pos).." ")
				io.write("type="..homeplace.building.." ")
				io.write("scm="..homeplace.schem.." ")
				io.write("region="..homeplace.region.." ")
			end
			
			-- This type of villager spawned in a building that
			-- has no beds. So default value = 1
			homeplace.bed = 1
			
			-- spawn the actual villager entity
			local trading_allowed = 1
			local luaEntity = villagers.spawnVillager(spawn_pos, homeplace, trading_allowed)
			
			local traders = {spawn_pos.x.."_"..spawn_pos.y.."_"..spawn_pos.z}
			bpos.traders = luaEntity.vName
			
			io.write("** SPAWNED near building pos ** ")
		else
			if log then io.write("Spawn POS blocked. Retry next cycle. ") end
		end
		
	end
	
end



-- spawn traders in villages
mg_villages.part_of_village_spawned = function( village, minp, maxp, data, param2_data, a, cid )
	if not( minetest.get_modpath( 'mg_villages')) then return end
		
	local log = true
		
	local village_pos = {x=village.vx, y=village.vh, z=village.vz}
	local village_pos_str = minetest.pos_to_string(village_pos)
	local village_type = village.village_type
	local village_radius = village.vs
	local village_snow = village.artificial_snow
	
	if log then
		io.write("\n\n"..string.upper(village_type)..village_pos_str.." ")
		io.write("radius="..village_radius.." ")
		io.write("snow="..tostring(village_snow).." ")
		io.write("builds="..#village.to_add_data.bpos.." ")
	end 
	
	-- All villagers already spawned successfully for this village pos.
	-- No need to process further villager spawn attempts. Skip.
	local meta = minetest.get_meta(village_pos)
	local success = meta:get_int("success")
	if success == 1 then 
		io.write("** ALREADY SPAWNED **")
		return
	end
	
	local meta_table = meta:to_table()
	
	-- Map chunk no loaded yet so access to block metadata not possible.
	-- Force map chunk to load while skipping village spawn attempt and 
	-- wait for next cycle.
	if meta_table == nil then	
		local pos1 = {x = village_pos.x - village_radius - 5, y = village_pos.y - 5, z = village_pos.z - village_radius - 5}
		local pos2 = {x = village_pos.x + village_radius + 5, y = village_pos.y + 5, z = village_pos.z + village_radius + 5}
		if log then 
			io.write("chunkNotLoaded skipVillagerSpawn forceEmergeVillPos ") 
			io.write(">> pos1"..minetest.pos_to_string(pos1).." pos2"..minetest.pos_to_string(pos2).." ")
		end
		minetest.emerge_area(pos1, pos2)
		return
	end
	
	if log then io.write("** CHUNK LOADED ** ") end
	--------------------------------------------------------------
	-- ## AT THIS POINT THE MAP CHUNK SHOULD BE GENERATED OK ## --
	--------------------------------------------------------------
		
	local region_type -- hot, cold, normal, native, desert

	-- certain village types directly determine the region type
	-- without needing to examine surrounding node data
	if village_type == "sandcity" then
		region_type = "desert"
	elseif village_type == "claytrader" then
		region_type = "desert"
	elseif village_type == "charachoal" then
		region_type = "native"
	elseif village_type == "gambit" then
		region_type = "desert"
	elseif village_snow == 1 then
		region_type = "cold"
		
	-- remaining village types will have region type 
	-- based upon the surrounding types of nodes
	else
		region_type = getRegionFromArea(village_pos, village_radius)
	end

	
	-- inialize and save new node metadata values
	meta_table.fields = {
		village = {
			pos = village_pos,
			name = village_type,
			region = region_type,
			success = 1
		},
		villagers = {}
	}
	
	if log then 
		io.write("metadata: "..minetest.serialize(meta_table.fields).." ") 
	end
	
	-- save
	local meta_save_result = meta:from_table(meta_table)
	if log then 
		if meta_save_result then
			io.write("metadataSavedOK! RecalledMeta: ") 
			local saved_meta = minetest.get_meta(village_pos)
			local saved_meta_table = meta:to_table()
			io.write(minetest.serialize(saved_meta_table).." ")
		else
			io.write("metadataSaveFAILED. ") 
		end
	end
	
	if log then io.write(" ** SPAWNING VILLAGERS ** ...") end
	
	-- for each building in the village
	for building_index, bpos in pairs(village.to_add_data.bpos) do
		local building_data = mg_villages.BUILDINGS[bpos.btype]
		local building_type = building_data.typ
		local building_scm = building_data.scm
		
		if log then io.write("\n  Building #"..building_index.." ") end
		
		if log then 
			if building_type then 
				io.write(string.upper(building_type).." ") 
				io.write("("..building_scm..") ")
			else 
				io.write("N/A ") 
				io.write("("..minetest.serialize(building_scm)..") ")
			end
		end
		
		local homeplace = {
			region = region_type,
			village = village_type,
			plot = building_index,
			building = building_type,
			schem = building_scm
		}
		
		if bpos.btype == "road" then
			if log then io.write("SKIP ") end
		else
			if log then io.write("BEDS="..#bpos.beds.." ") end
			if #bpos.beds > 0 then
				spawnWithBeds(bpos, homeplace)
			else
				spawnWithNoBeds(bpos, homeplace)
			end
			
		end
		
	end --end for loop
	
end

-------------------------
-- ENTITY REGISTRATION --
-------------------------
minetest.register_entity("villagers:villager", {
	
	-- Utilized Object Proerties
	hp_max = 15,
	collisionbox = {-0.25,-1.00,-0.25, 0.25,0.75,0.25},
	physical = true,
	weight = 5,
	visual = "mesh",
	visual_size = {x=1.0, y=1.0},
	mesh = "character.b3d",
	textures = {"character.png"},
	animation = { 
		stand_start = 0, stand_end = 79, 
		walk_start = 168, walk_end = 187,
		dig_start = 189, dig_end = 198,
		walkdig_start = 200, walkdig_end = 219
	},
	animation_speed = 25,
	infotext = "[uninitialized villager]",
	
	-- custom fields
	vName = "no-name",
	vGender = "no-gender",
	vAge = "adult",
	vTexture = "character.png",
	vSize = 1,
	vBox = {-0.25,-1.00,-0.25, 0.25,0.75,0.25},
	vYaw = 0,
	vYawSaved = 0,
	vTimer = 0,
	vAction = "STAND",
	vDigging = nil,
	vActionFrequency = 1, --rate in seconds villager updates action
	vInitialChatDistance = 0,
	vHudIds = {},
	vSoundHandle = nil,
	vDespawned = nil,
	
	-- homeplace
	vRegion = "UNASSIGNED",
	vVillage = "UNASSIGNED",
	vPlot = nil,
	vType = "UNASSIGNED",
	vSchem = "UNASSIGNED",
	vBed = nil,
	vUnknown = {},
	
	-- pathfinding
	vPos = {x=0,y=0,z=0},
	vFacingDirection = "N",
	vOriginPos = {x=0,y=0,z=0},
	vOriginDistance = 0,
	vOriginDistMax = 10,
	vTotalDistance = 0,
	vTargetPos = {x=0,y=0,z=0},
	vSpawnHeight = 0,
	vTargetHeight = 0,
	vTurnPreference = "right",
	vWalkReady = false,
	vDigReady = false,
	vBedPos = nil,
	vDoorPos = nil,
	vJobPos = nil,
	
	-- chatting
	vChatting = nil,
	vChatReady = true,
	vScriptHi = nil,
	vScriptHiSaved = nil,
	vScriptBye = nil,
	vScriptByeSaved = nil,
	vScriptGtg = nil,
	vScriptGtgSaved = nil,
	vScriptMain = nil,
	vScriptMainSaved = nil,
	vScriptSmalltalk = nil,
	vScriptSmalltalkSaved = nil,
	vScriptSmalltalk = nil,
	vScriptSmalltalkSaved = nil,
	vScriptGameFacts = nil,
	vScriptGameFactsSaved = nil,
	
	-- trading
	vID = "UNASSIGNED",
	vIsTrader = false,
	vTrading = nil,
	vNodeMetaPos = {x=0,y=0,z=0},
	vBuy = {},
	vSell = {},
	
	-- debugging
	vTextureString = nil,
	
	on_activate = function(self, staticdata, dtime_s)
		local log = false
		if log then io.write("\nACTIVATE ") end
			
		-- perform default action, whichi is standing idle animation
		villagers.standVillager(self)
		
		if staticdata ~= "" then
			if log then io.write("(existing) ") end
			local data = minetest.deserialize(staticdata)
			self.object:set_properties({textures={data.vTexture}})
			self.object:set_properties({visual_size=data.vSize})
			self.object:set_properties({collisionbox=data.vBox})
			self.object:set_properties({infotext=data.vInfo})
			self.object:set_properties({hp_max=data.vHP})
			self.object:setpos(data.vPos)
			self.object:set_yaw(data.vYaw)
			
			self.vName = data.vName
			self.vAge = data.vAge
			self.vTexture = data.vTexture
			self.vSize = data.vSize
			self.vBox = data.vBox
			self.vYaw = data.vYaw
			self.vYawSaved = data.vYawSaved
			self.vGender = data.vGender
			self.vAction = data.vAction
			self.vDigging = data.vDigging
			self.vActionFrequency = data.vActionFrequency
			self.vInitialChatDistance = 0
			self.vHudIds = data.vHudIds
			self.vSoundHandle = data.vSoundHandle
			self.vDespawned = nil
			
			-- homeplace
			self.vRegion = data.vRegion
			self.vVillage = data.vVillage
			self.vPlot = data.vPlot
			self.vType = data.vType
			self.vSchem = data.vSchem
			self.vBed = data.vBed
			self.vUnknown = data.vUnknown
			
			-- pathfinding
			self.vPos = data.vPos
			self.vFacingDirection = data.vFacingDirection
			self.vOriginPos = data.vOriginPos
			self.vOriginDistance = data.vOriginDistance
			self.vOriginDistMax = data.vOriginDistMax
			self.vTotalDistance = data.vTotalDistance
			self.vTargetPos = data.vTargetPos
			self.vSpawnHeight = data.vSpawnHeight
			self.vTargetHeight = data.vTargetHeight
			self.vTurnPreference = data.vTurnPreference
			self.vWalkReady = false
			self.vDigReady = false
			self.vBedPos = data.vBedPos
			self.vDoorPos = data.vDoorPos
			self.vJobPos = data.vJobPos
			
			-- chatting
			self.vChatting = nil
			self.vChatReady = true
			self.vScriptHi = data.vScriptHi
			self.vScriptHiSaved = data.vScriptHiSaved
			self.vScriptBye = data.vScriptBye
			self.vScriptByeSaved = data.vScriptByeSaved
			self.vScriptGtg = data.vScriptGtg
			self.vScriptGtgSaved = data.vScriptGtgSaved
			self.vScriptMain = data.vScriptMain
			self.vScriptMainSaved = data.vScriptMainSaved
			self.vScriptSmalltalk = data.vScriptSmalltalk
			self.vScriptSmalltalkSaved = data.vScriptSmalltalkSaved
			self.vScriptGameFacts = data.vScriptGameFacts
			self.vScriptGameFactsSaved = data.vScriptGameFactsSaved
			
			
			-- trading
			self.vID = data.vID
			self.vIsTrader = data.vIsTrader
			self.vTrading = nil
			self.vNodeMetaPos = data.vNodeMetaPos
			self.vBuy = data.vBuy
			self.vSell = data.vSell
			
			-- debugging
			self.vTextureString = data.vTextureString
			
			if log then io.write(string.upper(self.vName).." ") end
			
			if self.vDespawned then
				if log then io.write("vDespawned="..tostring(self.vDespawned).." ") end
			else
				if log then io.write("vDespawned=NIL ") end
			end
			
			local prior_saved_action = self.vAction
			if prior_saved_action == "STAND" then
				if log then io.write("loaded="..prior_saved_action.." ") end
			elseif prior_saved_action == "TURN" then 
				if log then io.write("loaded="..prior_saved_action.." ") end
			elseif prior_saved_action == "DIG" then
				if log then io.write("loaded="..prior_saved_action.." ") end
				if log then io.write("set_vAction=RESUMEDIG ") end
				self.vAction = "RESUMEDIG"
			elseif prior_saved_action == "REPLACE" then
				if log then io.write("loaded="..prior_saved_action.." ") end
				if log then io.write("set_vAction=RESUMEDIG ") end
				self.vAction = "RESUMEDIG"
			elseif prior_saved_action == "WALK" then
				if log then io.write("loaded="..prior_saved_action.." ") end
			elseif prior_saved_action == "WALKING" then
				if log then io.write("loaded="..prior_saved_action.." ") end
				if log then io.write("set_vAction=WALK ") end
				self.vAction = "WALK"
				self.object:setvelocity({x=0,y=0,z=0})
			elseif prior_saved_action == "TURNBACK" then
				if log then io.write("loaded="..prior_saved_action.." ") end
			elseif prior_saved_action == "WALKBACK" then
				if log then io.write("loaded="..prior_saved_action.." ") end
			elseif prior_saved_action == "CHAT" or prior_saved_action == "ENDCHAT" then
				if log then io.write("loaded="..prior_saved_action.." ") end
				if log then io.write("set_vAction=STAND ") end
				self.vAction = "STAND"
			elseif prior_saved_action == "TRADE" or prior_saved_action == "ENDTRADE" then
				if log then io.write("loaded="..prior_saved_action.." ") end
				if log then io.write("set_vAction=STAND ") end
				self.vAction = "STAND"
			else
				if log then io.write("ERROR vAction="..prior_saved_action.." ") end
			end
			
		else
			if log then io.write("(new) "..string.upper(self.vName).." ") end
		end
		
		if log then io.write("onActivateEND. ") end
		
	end,
	
	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		villagers.on_leftclick(self, puncher, time_from_last_punch)
	end,
	
	on_rightclick = function(self, clicker) villagers.on_rightclick(self, clicker) end,
	
	on_step = function(self, dtime) villagers.on_step(self, dtime) end,
	
	get_staticdata = function(self)
		local log = true
		if log then 
			io.write("\n  ## getStatic() "..string.upper(self.vVillage).." "..self.vType.." "..self.vName.." ") 
		end
		
		if self.vDespawned == false then
			if log then io.write("** DESPAWNED ** vAction="..self.vAction.." ") end
			if log then io.write("removing vID from villager_ids.. ") end
			villagers.villager_ids[self.vID] = nil
			
			
		else
			self.vDespawned = false
			if log then io.write("** SPAWNED ** ") end
			
			-- villager is spawning for first time and not
			-- completely initialized yet
			if self.vID == "UNASSIGNED" then
				
			-- this is an existing villager re-spawning
			else
				-- required by trading formspec callback and chat commands
				villagers.villager_ids[self.vID] = self.vName
				if log then 
					io.write("vID("..self.vID..") savedTo villager_ids table ") 
					--io.write("  villager_ids: "..minetest.serialize(villagers.villager_ids).." ")
					
				end
			end
			
			-- show standing animation while waiting
			-- for the first action cycle to start
			self.object:set_animation(
				{x=self.animation["stand_start"], y=self.animation["stand_end"]},
				self.animation_speed + math.random(10)
			)
		end

		-- save all custom fields
		local objProps = self.object:get_properties()		
		local villager_data = {
			vInfo = objProps.infotext,
			vHP = objProps.hp_max,
			
			vName = self.vName,
			vAge = self.vAge,
			vTexture = self.vTexture,
			vSize = self.vSize,
			vBox = self.vBox,
			vYaw = self.vYaw,
			vYawSaved = self.vYawSaved,
			vGender = self.vGender,
			vTimer = self.vTimer,
			vAction = self.vAction,
			vDigging = self.vDigging,
			vActionFrequency = self.vActionFrequency,
			vInitialChatDistance = 0,
			vHudIds = self.vHudIds,
			vSoundHandle = self.vSoundHandle,
			vDespawned = self.vDespawned,
			
			-- homeplace
			vRegion = self.vRegion,
			vVillage = self.vVillage,
			vPlot = self.vPlot,
			vType = self.vType,
			vSchem = self.vSchem,
			vBed = self.vBed,
			vUnknown = self.vUnknown,
			
			-- pathfinding
			vPos = self.vPos,
			vFacingDirection = self.vFacingDirection,
			vOriginPos = self.vOriginPos,
			vOriginDistance = self.vOriginDistance,
			vOriginDistMax = self.vOriginDistMax,
			vTotalDistance = self.vTotalDistance,
			vTargetPos = self.vTargetPos,
			vSpawnHeight = self.vSpawnHeight,
			vTargetHeight = self.vTargetHeight,
			vTurnPreference = self.vTurnPreference,
			vWalkReady = false,
			vDigReady = false,
			vBedPos = self.vBed,
			vDoorPos = self.vDoor,
			vJobPos = self.vDoor,
			
			-- chatting
			vChatting = nil,
			vChatReady = true,
			vScriptHi = self.vScriptHi,
			vScriptHiSaved = self.vScriptHiSaved,
			vScriptBye = self.vScriptBye,
			vScriptByeSaved = self.vScriptByeSaved,
			vScriptGtg = self.vScriptGtg,
			vScriptGtgSaved = self.vScriptGtgSaved,
			vScriptMain = self.vScriptMain,
			vScriptMainSaved = self.vScriptMainSaved,
			vScriptSmalltalk = self.vScriptSmalltalk,
			vScriptSmalltalkSaved = self.vScriptSmalltalkSaved,
			vScriptGameFacts = self.vScriptGameFacts,
			vScriptGameFactsSaved = self.vScriptGameFactsSaved,
			
			-- trading
			vID = self.vID,
			vIsTrader = self.vIsTrader,
			vTrading = nil,
			vNodeMetaPos = self.vNodeMetaPos,
			vBuy = self.vBuy,
			vSell = self.vSell,
			
			-- debugging
			vTextureString = self.vTextureString,
			
		}
		
		return minetest.serialize(villager_data)
	end,

})


local function spawnVillager(
	pos, 
	region_type,
	village_type,
	plot_number, 
	building_type, 
	schem_type, 
	bed_num
)
	
	-- SPAWN THE ACTUAL VILLAGER ENTITY!!!!
	local objectRef = minetest.add_entity(pos, "villagers:villager")
	local self = objectRef:get_luaentity()	

	self.vRegion = region_type
	self.vVillage = village_type
	self.vPlot = plot_number
	self.vType = building_type
	self.vSchem = schem_type
	self.vBed = bed_num
	
	-- If village type is unknown in ITEMS table,
	-- apply 'nore' as the default village type
	if villagers.ITEMS[village_type] == nil then
		table.insert(self.vUnknown, "Unknown village: "..village_type.."\n")
		village_type = "nore"
	end
	
	-- If building type is unknown in plots table,
	-- apply 'field' as the default building type
	if villagers.plots[building_type] == nil then
		table.insert(self.vUnknown, "Unknown building: "..building_type.."\n")
		building_type = "field"
	end
	
	-- this parameter is set within getRegionFromArea() when the rated top node
	-- after analyzing surrounding nodes is an unexpected type
	if villagers.error then
		table.insert(self.vUnknown, "Unknown topnode: "..villagers.error.."\n")
		villagers.error = nil -- reset for next villager spawning
	end
	
	--get GENDER and save to 'vGender' object custom field
	local gender = "male"
	if math.random(villagers.plots[building_type].female) == 1 then
		gender = "female"
	end
	self.vGender = gender
	
<<<<<<< HEAD
	--get AGE and save to 'vAge' object custom field
	local age_chance = villagers.plots[building_type].age
	local age = age_chance[math.random(#age_chance)]
	self.vAge = age
	
	--get NAME and save to 'vName' object custom field
	if region_type == "native" then
		self.vName = villagers.getVillagerName(gender, region_type)
	elseif region_type == "desert" then
		self.vName = villagers.getVillagerName(gender, region_type)
	else
		if age == "young" then
			self.vName = villagers.getVillagerName(gender, age)
=======
	elseif village_type == "tent" then region_type = "hot"
		
	-- single lone buildings
	elseif village_type == "tower" then region_type = "normal"
	elseif village_type == "chateau" then region_type = "normal"
	elseif village_type == "forge" then region_type = "hot"
	elseif village_type == "tavern" then region_type = "normal"
	elseif village_type == "well" then region_type = "native"
	elseif village_type == "trader" then region_type = "desert"
	elseif village_type == "sawmill" then region_type = "cold"
	elseif village_type == "farm_tiny" then region_type = "normal"
	elseif village_type == "farm_full" then region_type = "normal"
	elseif village_type == "single" then region_type = "normal"
		
	-- included in 'village_sandcity'
	elseif village_type == "sandcity" then region_type = "desert"
		
	-- included in 'village_gambit'
	elseif village_type == "gambit" then region_type = "native"
		
	-- included in 'village_towntest'
	elseif village_type == "cornernote" then region_type = "normal"
		
	else print("\n## ERROR Invalid village_type="..village_type) end
	
	-- for each building in the village
	for building_index,bpos in pairs(village.to_add_data.bpos) do
	
		local building_data = mg_villages.BUILDINGS[bpos.btype]
		local building_type = building_data.typ
		local building_scm = building_data.scm
		local building_pos = {x=bpos.x, y=bpos.y, z=bpos.z}
		--[[
		if villagers.log5 then
			io.write("\n  building #"..building_index.." ")
			io.write("loc"..minetest.pos_to_string(building_pos).." ")
			io.write("type_id="..bpos.btype.." ")
			
			
			if bpos.btype ~= "road" then
				io.write("scm="..dump(building_scm).." ")
				io.write("type="..building_type.." ")
				io.write("beds="..#bpos.beds.." ")
			end
		end--]]
		--[[
		io.write("\n  #"..building_index.." ")
		io.write("type_id="..bpos.btype.." ")
		--]]
		
		if bpos.btype ~= "road" then
			--[[
			io.write("scm="..dump(building_scm).." ")
			io.write("type="..building_type.." ")
			io.write("beds="..#bpos.beds.." ")
			--]]
			if #bpos.beds > 0 then
				spawnOnBedPlot(bpos, region_type, village_type, building_type, building_data.scm, village.vx, village.vz)
			else
				spawnOnJobPlot(bpos, region_type, village_type, building_type, building_data.scm, minp, maxp)
			end
			
		end

		--[[
		-- get mob spawner positions for this building
		if bpos.btype == "road" then
			--io.write("mob_spawners: n/a ")
			
		-- for homes that don't yet have beds, force a villager to spawn anyway
		elseif (village_type == "sandcity" and building_type == "house") or
			(village_type == "cornernote" and building_type == "hut") or
			(village_type == "gambit" and building_type == "house") then
			--spawnOnNonResidential(bpos, region_type, village_type, building_type, building_data.scm, minp, maxp)
			spawnOnJobPlot(bpos, region_type, village_type, building_type, building_data.scm, minp, maxp)
			
		-- spawn a villager for each # of beds in that building
		elseif building_type == "house" or building_type == "tavern" or building_type == "library" or
			building_type == "mill" or building_type == "farm_full" or building_type == "farm_tiny" or
			building_type == "forge" or building_type == "hut" or building_type == "lumberjack" or 
			building_type == "school" or building_type == "inn" or building_type == "trader" or
			building_type == "tent" or building_type == "chateau" or building_type == "forge" 
			
			then
			spawnOnBedPlot(bpos, region_type, village_type, building_type, building_data.scm, village.vx, village.vz)
>>>>>>> fa0bd14a66f7bf50ffe842cf02029a973b72e1d6
		else
			self.vName = villagers.getVillagerName(gender)
		end
<<<<<<< HEAD
	end

	--### update below function to incorporate above 3 functions in there
	--and simply pass in 'self' and no need to return values
	--get TEXTURE, VISUAL SIZE, and COLLISION BOX and apply it to corresponding entity properties
	villagers.setVillagerAttributes(self)
	objectRef:set_properties({textures={newTexture}})
	objectRef:set_properties({visual_size={x=newSize,y=newSize}})
	objectRef:set_properties({collisionbox=collisionBox})
	-- ^ move these statements into getVillagerAppearance()
	
	
	
	
	
	return self
end

minetest.register_lbm({
	label = "Spawn Villager",
	name = "villagers:spawn_villager",
	nodenames = {"mg_villages:mob_spawner"},
	run_at_every_load = true,
	action = function(pos, node)
		
		--[[
		-- check mode metadata at this pos
		-- check key 'spawned'
		-- if 
		
		
		local mob_spawner_data = handle_schematics.get_pos_in_front_of_house(bpos, bed_index)
		local yaw_data = mob_spawner_data.yaw
		villagers.spawnVillager(
			pos, 
			homeplace = {
				region,
				village,
				plot_num,
				building,
				schem,
				bed_num
			}, 
			player_name, 
			trading_allowed, 
			yaw_data, 
			bed_pos
		)
		--]]
	end
})







=======
		--]]
		
	end --end for loop
	--io.write("\n")
end
>>>>>>> fa0bd14a66f7bf50ffe842cf02029a973b72e1d6
