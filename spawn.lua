function getRegionFromArea(pos, radius, errors)
	local log = false
	local log2 = false --show all nodes gathered
	
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
				nodename == "FELDWEG" or 
				nodename == "STONE" or 
				nodename == "STONEBRICK" or 
				nodename == "COBBLE" or 
				nodename == "AIR" or 
				nodename == "WATER_SOURCE" or 
				nodename == "IGNORE" then
				if log then io.write("[skipped] ") end
			else 
				if log then io.write(", ") end
				table.insert(nodenames, nodename)
			end
			
			radius_index = radius_index + 2
		end
		
	end
	
	if log then 
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
	
	if log2 then
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
	elseif top_nodename == "DIRT_WITH_GRASS" then 
		region_type = "normal"
	elseif top_nodename == "DIRT_WITH_RAINFOREST_LITTER" then 
		region_type = "native"
	elseif top_nodename == "SOIL_WET" then 
		region_type = "native"
	elseif top_nodename == "SAND" or
		top_nodename == "DESERT_SAND" or
		top_nodename == "SILVER_SAND" or
		top_nodename == "DESERT_STONE" or
		top_nodename == "SANDSTONE" then 
		if math.random(2) == 1 then 
			region_type = "hot"
		else 
			region_type = "desert" 
		end
	else 
		io.write(" #ERROR IN getRegionFromArea()# ")
		local error_message = "Unknown value for top_nodename = "..top_nodename.." "..
			"Falling back to region=NORMAL."
		table.insert(errors, error_message)
		region_type = "normal"
	end
	return region_type
end



minetest.register_lbm({
	label = "Spawn Villager",
	name = "villagers:spawn_villager",
	nodenames = {"mg_villages:mob_spawner"},
	run_at_every_load = true,
	action = function(pos, node)
		local log = false
		
		if log then io.write("\n## LBM ## ") end
		
		local spawn_meta = minetest.get_meta(pos)
		local meta_table = spawn_meta:to_table()
		local plot_num = tonumber(meta_table.fields.plot_nr)
		local bed_num = tonumber(meta_table.fields.bed_nr)
		
		if spawn_meta:get_int("success") == 1 then 
			if log then io.write("** ALREADY SPAWNED ** Plot #"..plot_num.." Bed #"..bed_num) end
			return
		end
		
		-- track any errors. for use by formspec in 
		-- node metadata located at the village position
		local errors = {}
		
		local village_id = meta_table.fields.village_id
		local village_data = mg_villages.all_villages[village_id]
		local village_pos = {x=village_data.vx, y=village_data.vh, z=village_data.vz}
		local village_pos_str = minetest.pos_to_string(village_pos)
		local village_radius = village_data.vs
		local village_type = village_data.village_type
		local village_snow = village_data.artificial_snow
		if village_snow == nil then village_snow = "NIL" end
		
		if log then io.write(string.upper(village_type)..village_pos_str.." ") end
			
		-- Get region type data if it was already calculated
		-- and saved from a previous LBM call. Region data is
		-- saved in node metadata at village position.
		local village_meta = minetest.get_meta(village_pos)
		local region = village_meta:get_string("region")
		local note = ""
		if region == "" then
			note = "*"
			-- certain village types directly determine the region type
			-- without needing to examine surrounding node data
			if village_type == "sandcity" then region = "desert"
			elseif village_type == "claytrader" then region = "desert"
			elseif village_type == "charachoal" then region = "native"
			elseif village_type == "gambit" then region = "desert"
			elseif village_snow == 1 then region = "cold"
				
			-- remaining village types will have region type 
			-- based upon the surrounding types of nodes
			else 
				region = getRegionFromArea(village_pos, village_radius, errors) 
				note = "**"
			end
			village_meta:set_string("region", region)
		end
		
		if log then io.write("size="..village_radius.." snow="..village_snow.." region="..region..note.." ") end
		
		--[[ currently unused
		local village_num = village_data.nr
		local village_height = village_data.optimal_height
		local village_is_single = village_data.is_single_house
		local village_name = village_data.name
		--]]
		
		local plot_data = village_data.to_add_data.bpos[plot_num]
		local plot_pos = {x = plot_data.x, y = plot_data.y, z = plot_data.z}
		local plot_pos_str = minetest.pos_to_string(plot_pos)
		local sizex = plot_data.bsizex
		local sizez = plot_data.bsizez
		local rotate = plot_data.brotate
		local side = plot_data.side
		if side == nil then side = "NIL" end
		
		if log then io.write("Plot #"..plot_num.." "..plot_pos_str.." ") end
		
		local b_type_num = plot_data.btype
		local building_data = mg_villages.BUILDINGS[b_type_num]
		local b_type = building_data.typ
		local b_schem = building_data.scm
		local b_sizex = building_data.sizex
		local b_sizez = building_data.sizez
		local b_sizey = building_data.ysize
		local b_inhab = building_data.inh
		local b_bedcount = building_data.bed_count
		local b_bedlist = building_data.bed_list -- table
		local b_nodenames = building_data.nodenames -- table
		
		if b_inhab == nil then b_inhab = "NIL" end
		if b_sizex == nil then b_sizex = "NIL" end
		if b_sizey == nil then b_sizey = "NIL" end
		if b_sizez == nil then b_sizez = "NIL" end
		if type(b_schem) == "table" then b_schem = "n/a" end
		if b_type == nil then b_type = "NIL" end
		if b_bedcount == nil then b_bedcount = "NIL" end
		
		local beds_data_count = 0
		for k,v in pairs(plot_data.beds) do
			beds_data_count = beds_data_count + 1
		end
		
		if log then 
			io.write(string.upper(b_type).."["..b_schem.."] inh="..b_inhab.." ")
			io.write("bedcount="..b_bedcount.." beds_data_count="..beds_data_count.." ") 
		end
		--if log then io.write("plot_data.beds["..bed_num.."]: "..minetest.serialize(plot_data.beds).." ") end
		if bed_num > beds_data_count then
			if log then io.write(" #ERROR IN bed_num vs beds_data_count# ") end
			local error_message = "to_add_data.bpos(meta.fields.plot_nr="..plot_num..")(meta.fields.bed_nr="..bed_num..") NIL. "..
			"BUILDINGS(btype).bed_count="..b_bedcount.." and inh="..b_inhab..". Wait next cycle.." 
			table.insert(errors, error_message)
			return
		end
		
		local beds_data = plot_data.beds[bed_num]
		local bed_pos = {x=beds_data.x, y=beds_data.y, z=beds_data.z}
		local bed_pos_str = minetest.pos_to_string(bed_pos)
	
		local gen = beds_data.generation
		local age = beds_data.age
		local gender = beds_data.gender
		if gender == "m" then gender = "male" else gender = "female" end

		--get NAME and save to 'vName' object custom field
		local villager_name
		if region == "native" then villager_name = villagers.getVillagerName(gender, region)
		elseif region == "desert" then villager_name = villagers.getVillagerName(gender, region)
		else
			if age == "young" then villager_name = villagers.getVillagerName(gender, age)
			else villager_name = villagers.getVillagerName(gender) end
		end
	
		local title = beds_data.title
		local works_at = beds_data.works_at
		local unique = beds_data.uniq
		local owns_data = beds_data.owns
		
		if log then
			pos.y = village_data.vh + 1.5
			io.write("\nVillager: "..string.upper(villager_name).." "..minetest.pos_to_string(pos).." ")
			io.write("gender="..gender.." age="..age.." gen="..gen.." bed#"..bed_num.." "..bed_pos_str.." ")
			if title then io.write("*"..string.upper(title).."* ") end
			if works_at then io.write("@ plot #"..works_at.." ") end
			if unique then io.write("unique="..unique.." ") end
			if owns_data then 
				io.write("OWNS PLOT(S) "..minetest.serialize(owns_data).." ") 
			end
		end
		
		local worker_data = village_data.to_add_data.bpos[plot_num].worker
		
		if worker_data then
			--local lives_at = worker_data.lives_at
			local work_as = worker_data.work_as
			local titl = worker_data.title
			local uniq = worker_data.uniq
			if log then
				if work_as then io.write("Work Info: job="..work_as.." ") end
				if titl then io.write("titl="..titl.." ") end
				if uniq then io.write("uniq="..uniq.." ") end
			end
		end
		
		-------------------------------
		-- SPAWN THE ACTUAL VILLAGER! --
		-------------------------------
		
		-- 'pos' is currently location of mg_Villages mob spawner. 
		-- Ensure villager spawns one node above this position.
		pos.y = village_data.vh + 0.5
		local objectRef = minetest.add_entity(pos, "villagers:villager")
		local self = objectRef:get_luaentity()	
		
		if log then io.write("\n  ** SPAWNING VILLAGER ** ") end
		
		self.vName = villager_name
		self.vGender = gender
		if log then io.write(self.vGender.." ") end
		
		if gen == 1 then age = "young"
		elseif gen == 2 then age = "adult"
		else age = "old" end
		self.vAge = age
		if log then io.write(self.vAge.." ") end
		
		-- assigned trading goods to villagers who
		-- possess the appropriate title		
		if title == nil then
			-- these are home/hut dwellers
			self.vSell = "none"
		elseif villagers.GOODS[title] == nil then
			self.vSell = "none"
			table.insert(errors, "villagers.GOODS: Unknown job title '"..title.."' for plot#"..plot_num.." bed#"..bed_num.." villager.")
		else
			-- getTradeInventory() can also return "none" for job titles
			-- that fail probability check of trading items
			self.vSell = villagers.getTradeInventory(title, region, plot_num, bed_num, errors) 
		end
		self.vTitle = title
		
		--get TEXTURE, VISUAL SIZE, and COLLISION BOX and apply it to corresponding entity properties
		local newTexture, newSize, newCollisionBox = villagers.getVillagerAppearance(b_type, region, gender, age)
		objectRef:set_properties({textures={newTexture}})
		objectRef:set_properties({visual_size={x=newSize,y=newSize}})
		objectRef:set_properties({collisionbox=newCollisionBox})	
		
		local final_pos = objectRef:getpos()
		self.vSpawnHeight = final_pos.y
		self.vTargetHeight = self.vSpawnHeight - 0.5
		
		-- set final position that takes into account calc'd 
		-- collision_box that was based on dynamic visual_size
		final_pos.y = final_pos.y
		objectRef:setpos(final_pos)
		self.vPos = 		{x=final_pos.x,y=final_pos.y,z=final_pos.z}
		self.vOriginPos = 	{x=final_pos.x,y=final_pos.y,z=final_pos.z}
		self.vTargetPos = 	{x=final_pos.x, y=self.vTargetHeight, z=final_pos.z}
		
		-- randomly set how often in seconds that this
		-- villager will check to do a different action
		self.vActionFrequency = math.random(4,6)
		
		--overlay applied entity new properties to custom fields
		local prop = objectRef:get_properties()
		self.vTexture = prop.textures[1]
		self.vSize = prop.visual_size
		self.vBox = prop.collisionbox
	
		self.vRegion = region
		self.vVillage = village_type
		self.vPlot = plot_num
		self.vType = b_type
		self.vSchem = b_schem
		self.vBed = bed_num
		
		-- use for villager trading formspec callbacks and for chat commands
		self.vID = final_pos.x.."_"..final_pos.y.."_"..final_pos.z
		
		-- copy chat dialogue scripts from villagers.chat global var
		-- and save it into villager entity for more quicker access	
		local hi_script, bye_script, main_script
		if villagers.chat[b_type] == nil then
			if log then io.write(" #ERROR IN LOADING Chat Scripts# ") end
			local error_message = "villagers.chat('"..b_type.."') = NIL for "..
				"plot#"..plot_num.." bed#"..bed_num.." villager. Fallback to default scripts."
			table.insert(errors, error_message)
			hi_script = { "I am error.", "My chat failed", "Potato."}
			bye_script = { "Blah.", "Kill me.", "Chimichangas." }
			main_script = { "My building type is unknown:\nBUILDING_TYPE", 
				"I have nothing meaningful to\nbecause of a chat setup error.",
				"My chat dialogue setup failed.\nRight click at "..village_pos_str.."\nfor more details."
			}
		else  
			hi_script = villagers.copytable(villagers.chat[b_type].greetings)
			bye_script = villagers.copytable(villagers.chat[b_type].goodbyes)
			main_script = villagers.copytable(villagers.chat[b_type].mainchat)
		end 
		villagers.getRandomChatText(self, hi_script, "vScriptHi", 3)
		villagers.getRandomChatText(self, bye_script, "vScriptBye", 3)
		villagers.getRandomChatText(self, main_script, "vScriptMain", 3)		
		villagers.getRandomChatText(self, villagers.copytable(villagers.chat.gtg), "vScriptGtg", 3)
		villagers.getRandomChatText(self, villagers.copytable(villagers.chat.smalltalk), "vScriptSmalltalk", 3)
		villagers.getRandomChatText(self, villagers.copytable(villagers.chat.gamefacts), "vScriptGameFacts", 2)
		
		-- set door position. currently same a spawn position, but will update soon
		-- to action door position obtained from mg_villages parameters
		self.vDoorPos = {x=final_pos.x, y=final_pos.y, z=final_pos.z} 
		
		-- setup infotext
		local infotext_string = ""
		
		if self.vTitle == "guest" then
			infotext_string = infotext_string..string.upper(self.vName).." (guest)\n"
		elseif self.vTitle == nil then
			infotext_string = infotext_string..string.upper(self.vName).."\n"
		else
			infotext_string = infotext_string.."TRADER ("..self.vTitle..")\n"..self.vName.." "
		end
		infotext_string = infotext_string..self.vAge.." "..self.vGender.."\n"..
			"Person #"..self.vBed.." from Plot #"..self.vPlot
		
		
		-- save infotext to villager object
		objectRef:set_properties({infotext = infotext_string })
		
		-- set YAW
		local yaw = villagers.YAWS[math.random(8)]
		objectRef:set_yaw(yaw)
		self.vYaw = yaw
		self.vFacingDirection = villagers.getDirectionFromYaw(yaw)
		
		-- default to standing animation
		self.object:set_animation(
			{x=self.animation["stand_start"], y=self.animation["stand_end"]},
			self.animation_speed + math.random(10)
		)
		
		-- save texture string for debug output
		self.vTextureString = newTexture
		
		
		
		-- save any found errors into the node metadata field 'errors'
		if #errors > 0 then
			if log then io.write("\n  "..#errors.." ERRORS DETECTED: "..minetest.serialize(errors).." ") end
			local prev_errors = village_meta:get_string("errors")
			if prev_errors == "" then
				if log then io.write("\n  noPrevErrors insertingNewErrors ") end
				village_meta:set_string("errors", minetest.serialize(errors))
			else
				if log then io.write("\n  prevErros: "..prev_errors.." ") end
				local all_errors = {}
				for i = 1, #errors do table.insert(all_errors, errors[i]) end
				
				local prev_err_table = minetest.deserialize(prev_errors)
				for i = 1, #prev_err_table do table.insert(all_errors, prev_err_table[i]) end
				
				local all_err_str = minetest.serialize(all_errors)
				if log then io.write("\n  combinedErrors: "..all_err_str.." ") end
				village_meta:set_string("errors", all_err_str)
			end
			if log then io.write("\n  meta_errors: "..village_meta:get_string("errors").." ") end
			
		else
			if log then io.write("\n  No Errors detected.\n") end
		end
		
		
		-- save any changes (error messages) to this 'village formspec'
		--io.write("\n  Compiling village formspec... ")
		local village_formspec = "size[12,7]background[0,0;0,0;gui_formbg.png;true]label[0,0;"..
			"type: "..string.upper(village_type).." "..
			village_pos_str.."\n"..
			"name: "..string.upper(village_data.name).."\n"..
			"region: "..string.upper(region).."]"
		
		local saved_errors = village_meta:get_string("errors")
		if saved_errors == "" then
			--io.write("noErrorsFound ")
			village_formspec = village_formspec.."label[0,1.5;(No Errors)]"
		else
			--io.write("\n  errorsFound: "..saved_errors.." ")
			local error_string = ""
			local saved_err_table = minetest.deserialize(saved_errors)
			for i = 1, #saved_err_table do
				error_string = error_string.."- "..saved_err_table[i].."\n"
			end
			village_formspec = village_formspec.."label[0,1.5;"..error_string.."]"
		end
		village_meta:set_string("formspec", village_formspec)
		--io.write("\n  ##Village Formspec: "..village_formspec.." ")
		
		-- set infotext for village formspec
		village_meta:set_string("infotext", "Village Information\n(right click to view)")
		
		-- indicate that this mob spawner location has now successfully
		-- spawned a village. processing of this mob spawner will
		-- be skipped the next time the LBM at this pos executes
		spawn_meta:set_int("success", 1)
		
		--io.write("\n")
	end
})

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
	vTitle = nil,
	vTraded = false,
	
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
			self.vTitle = data.vTitle
			self.vTraded = false
			
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
		local log = false
		if log then 
			io.write("\ngetStatic() ") 
		end
		
		if self.vDespawned == false then
			if log then
				io.write("DESPAWNED plot #"..self.vPlot.." person #"..self.vBed.." "..self.vName.." "..string.upper(self.vVillage).." ")
			end
			
			
		else
			self.vDespawned = false
			if log then io.write(" SPAWNED ") end
			
			-- villager is spawning for first time and not
			-- completely initialized yet
			if self.vID == "UNASSIGNED" then
				
			-- this is an existing villager re-spawning
			else
			
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
			vTitle = self.vTitle,
			vTraded = false,
			
			-- debugging
			vTextureString = self.vTextureString,
			
		}
		
		return minetest.serialize(villager_data)
	end,

})
