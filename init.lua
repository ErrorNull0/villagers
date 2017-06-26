villagers = {}

local modpaths = minetest.get_modpath("villagers")
dofile(modpaths.."/names.lua")
dofile(modpaths.."/plots.lua")
dofile(modpaths.."/textures.lua")
dofile(modpaths.."/colors.lua")
dofile(modpaths.."/dialogue.lua")
dofile(modpaths.."/trading.lua")

local log = false	--debug actions
local log2 = false	--debug chatting
local log3 = true 	--debug textures


-- ============================================ CONSTANTS =================================================
-- ========================================================================================================

local YAWS = { 0, -0.785, -1.571, -2.356, 3.141, 2.356, 1.571, 0.785}
local DIRECTIONS = { "N", "NE", "E", "SE", "S", "SW", "W", "NW"}

-- used to help calculate the x and z positions of nodes that are adjacent to villager 
local NODE_AREA = {
	["NW"]={-1,1},  ["N"]={0,1},  ["NE"]={1,1}, ["W"]={-1,0},  ["C"]={0,0},  
	["E"]={1,0}, ["SW"]={-1,-1}, ["S"]={0,-1}, ["SE"]={1,-1}
}




-- ============================================ HELPER FUNCTIONS ==========================================
-- ========================================================================================================

-- round a decimal number to any number of decimal points
-- or round to nearest whole number if decimal_places is omitted
local function round(float_number, decimal_places)
	local multiplier
	if decimal_places then multiplier = 10^decimal_places 
	else multiplier = 1 end
	return math.floor(float_number * multiplier + 0.5) / multiplier
end

local function copytable(source_table)
	local new_table = {}
	for i = 1, #source_table do
		table.insert(new_table, source_table[i])
	end
	return new_table
end

-- returns the full registered nodename (ex. default:dirt) as well as
-- an all-caps shortened version of the nodename (ex. DIRT) at given position
local function getNodeName(pos)	
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

local function getFacingNodeInfo(self)
	local facing_dir = self.vFacingDirection
	local dug_pos = {
		x=self.vPos.x + NODE_AREA[facing_dir][1], 
		y=self.vTargetHeight, 
		z=self.vPos.z + NODE_AREA[facing_dir][2]
	}
	local node_names = getNodeName(dug_pos)	
	return {dug_pos, node_names[1], node_names[2]}
end

-- makes villager turn and face toward player's direction
local function turnToPlayer(self, player)
	local entityPos = self.object:getpos()
	local playerPos = player:getpos()
	local dx = entityPos.x - playerPos.x
	local dz = playerPos.z - entityPos.z
	self.object:setyaw(math.atan2(dx, dz))
end

local function showAlert(self, player, alert_text, timer)

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
	self.vHudIds.alert_box = player:hud_add({
		hud_elem_type = "image",
		scale = { x = 1, y = 1 },
		position = { x = 0.5, y = 0.0 },
		text = "alert_box.png",
		offset = {x=-30, y=50}, 
	})
	
	--show text within alert box
	self.vHudIds.alert_text = player:hud_add({
		hud_elem_type = "text",
		position = { x = 0.5, y = 0.0 },

		text = alert_text,
		number = 0xFFFFFF,
		offset = {x=-30, y=50} 
	})
	
	minetest.after(timer, function() 
		player:hud_remove(self.vHudIds.alert_text)
		self.vHudIds.alert_text = nil
		player:hud_remove(self.vHudIds.alert_box)
		self.vHudIds.alert_box = nil
	end)
		

end




-- =================================== VILLAGER ATTRIBUTES AND APPEARANCE =================================
-- ========================================================================================================
-- Generate villager attributes and appearance after spawning

-- visual sized of villager entity based on villager's age
local VISUAL_SIZES = {
	male = {
		young = {0.50, 0.65, 0.80}, 
		adult = {0.90, 1.05, 1.20}, 
		old = {0.80, 0.90, 1.00} 
	},
	female = {
		young = {0.50, 0.60, 0.70}, 
		adult = {0.90, 0.95, 1.00}, 
		old = {0.70, 0.80, 0.90} 
	}
}

-- these are all the same exact textures for now
-- will make variations soon
local BODY_TEXTURES = { "body_01.png", "body_02.png", "body_03.png" }
local LOWER_TEXTURES = { "body_01.png", "body_02.png", "body_03.png" }

local STRAPS = {
	"strap_01.png", "strap_02.png", "strap_03.png", 
	"strap_04.png", "strap_05.png", "strap_06.png" 
}

local BACKPACKS = {
	"backpack_01.png", "backpack_02.png", "backpack_03.png",
	"backpack_04.png", "backpack_05.png", "backpack_06.png"
}

local SWORDS = { "sword_01.png", "sword_01.png", "sword_01.png", "sword_01.png" }

local HAIR = {
	male = {
		"hair_male_02.png", "hair_male_03.png", "hair_male_04.png", "hair_male_05.png", "hair_male_06.png", 
		"hair_male_07.png", "hair_male_08.png", "hair_male_09.png", "hair_male_11.png", "hair_male_13.png", 
		"hair_male_14.png", "hair_male_18.png", "hair_male_20.png", "hair_male_21.png", "hair_male_22.png"
	},
	
	female = {
		"hair_female_00.png", "hair_female_02.png", "hair_female_03.png", "hair_female_04.png", "hair_female_05.png", 
		"hair_female_06.png", "hair_female_07.png", "hair_female_08.png", "hair_female_09.png", "hair_female_10.png", 
		"hair_female_11.png", "hair_female_12.png", "hair_female_13.png", "hair_female_14.png", "hair_female_15.png", 
		"hair_female_16.png", "hair_female_17.png", "hair_female_18.png", "hair_female_20.png", "hair_female_21.png", 
		"hair_female_22.png", "hair_female_23.png", "hair_female_27.png", "hair_female_28.png", "hair_female_28.png", 
		"hair_female_29.png", "hair_female_30.png", "hair_female_31.png", "hair_female_32.png"
	},
	
	male_old = { 
		"hair_male_old_01.png", "hair_male_old_02.png", "hair_male_old_03.png", "hair_male_old_04.png",
		"hair_male_old_05.png", "hair_male_old_06.png"
	},
	
	female_old = { 
		"hair_female_old_01.png", "hair_female_old_02.png", "hair_female_old_03.png", "hair_female_old_04.png",
		"hair_female_old_05.png", "hair_female_old_06.png"
	}
}

local function getVillagerName(gender, subtype)
	local name
	if subtype then
		local name_category = gender.."_"..subtype
		local random_index = math.random(#villagers.names[name_category])
		name = villagers.names[name_category][random_index]
	else
		local random_index = math.random(#villagers.names[gender])
		name = villagers.names[gender][random_index]
	end
	return name
end

-- main function that randomly generates villager size and appearance
local function getVillagerAppearance(building_type, region, gender, age)
	
	local final_texture
	local textures
	local colors
	
	-- base body texture
	textures = villagers.textures.body[region]
	local body_texture = textures[math.random(#textures)]
	colors = villagers.colors.body[region]
	local body_color = colors[math.random(#colors)]
	final_texture = "("..body_texture.."^[colorize:"..body_color..")^"
	
	-- apply eyes (small, med, and different color iris)
	textures = villagers.textures.eyes[gender][age]
	local eye_texture_whites = textures[math.random(#textures)]
	local eye_texture_iris
	if string.find(eye_texture_whites, "_sm") then eye_texture_iris = "eyes_iris_sm.png"
	else eye_texture_iris = "eyes_iris_med.png" end
	colors = villagers.colors.eyes[region]
	local eye_color = colors[math.random(#colors)]
	final_texture = final_texture .. "("..eye_texture_whites..")^("..eye_texture_iris.."^[colorize:"..eye_color..")^"
	
	-- apply mouth 
	textures = villagers.textures.mouth[gender][age]
	local mouth_texture = textures[math.random(#textures)]
	final_texture = final_texture .. "("..mouth_texture..")^"
	
	-- apply face accessories (eg. eye glasses)
	textures = villagers.textures.extra_face[gender][age]
	local extra_face_texture = textures[math.random(#textures)]
	final_texture = final_texture .. "("..extra_face_texture..")^"
	
	-- apply footwear
	textures = villagers.textures.footwear[region]
	local footwear_texture = textures[math.random(#textures)]
	colors = villagers.colors.footwear
	local footwear_color = colors[math.random(#colors)]
	final_texture = final_texture .. "("..footwear_texture.."^[colorize:"..footwear_color..")^"
	
	-- apply custom outfit if any
	local custom_outfit = villagers.textures.outfit[building_type]
	if custom_outfit then
		textures = custom_outfit[gender]
		local outfit_texture = textures[math.random(#textures)]
		colors = villagers.colors.jackets
		local outfit_color = colors[math.random(#colors)]
		final_texture = final_texture .. "("..outfit_texture.."^[colorize:"..outfit_color..")^"
	else
		-- apply full dress
		textures = villagers.textures.dress[region][gender][age]
		local dress_texture = textures[math.random(#textures)]
		if string.find(dress_texture, "dress_") then 
			colors = villagers.colors.dress[region][gender]
			local dress_color = colors[math.random(#colors)]
			final_texture = final_texture .. "("..dress_texture.."^[colorize:"..dress_color..")^"
		else
			
			-- apply lower body clothing
			textures = villagers.textures.lower[region][gender][age]
			local lower_texture = textures[math.random(#textures)]
			colors = villagers.colors.lower[region][gender]
			local lower_color = colors[math.random(#colors)]
			final_texture = final_texture .. "("..lower_texture.."^[colorize:"..lower_color..")^"
			
			-- apply upper body clothing
			textures = villagers.textures.upper[region][gender][age]
			local upper_texture = textures[math.random(#textures)]
			colors = villagers.colors.upper[region][gender]
			local upper_color = colors[math.random(#colors)]
			final_texture = final_texture .. "("..upper_texture.."^[colorize:"..upper_color..")^"
			
		end
		
		-- apply jacket
		textures = villagers.textures.jacket[region]
		local jacket_texture = textures[math.random(#textures)]
		colors = villagers.colors.jackets
		local jacket_color = colors[math.random(#colors)]
		final_texture = final_texture .. "("..jacket_texture.."^[colorize:"..jacket_color..")^"
	end
	
	-- apply hair
	textures = villagers.textures.hair[gender][age]
	local hair_texture = textures[math.random(#textures)]
	colors = villagers.colors.hair[region][age]
	local hair_color = colors[math.random(#colors)]
	final_texture = final_texture .. "("..hair_texture.."^[colorize:"..hair_color..")"
	
	local extra_layer = villagers.textures.extra_layer[building_type]
	if extra_layer then
		textures = extra_layer[gender]
		local extra_layer_texture = textures[math.random(#textures)]
		final_texture = final_texture .. "^("..extra_layer_texture..")"
	end
	
	local extra_head = villagers.textures.extra_head[building_type]
	if extra_head then
		textures = extra_head[gender]
		local extra_head_texture = textures[math.random(#textures)]
		final_texture = final_texture .. "^("..extra_head_texture..")"
	end
	
	local extra_neck = villagers.textures.extra_neck[building_type]
	if extra_neck then
		textures = extra_neck[gender]
		local extra_neck_texture = textures[math.random(#textures)]
		final_texture = final_texture .. "^("..extra_neck_texture..")"
	end
	
	local extra_front = villagers.textures.extra_front[building_type]
	if extra_front then
		textures = extra_front[gender]
		local extra_front_texture = textures[math.random(#textures)]
		final_texture = final_texture .. "^("..extra_front_texture..")"
	end
	
	local extra_back = villagers.textures.extra_back[building_type]
	if extra_back then
		textures = extra_back
		local extra_back_texture = textures[math.random(#textures)]
		final_texture = final_texture .. "^("..extra_back_texture..")"
	end

	
	-- determine visual_size
	local sizes = VISUAL_SIZES[gender][age]
	local new_size = sizes[math.random(#sizes)]

	-- calculate collision_box based on new visual_size
	local new_collision_box = {
		-0.25*new_size, -1.00*new_size, -0.25*new_size, 
		 0.25*new_size,  0.75*new_size,  0.25*new_size
	}
	
	return final_texture, new_size, new_collision_box
	

end





-- ====================================== EXECUTING VILLAGER ACTIONS ======================================
-- ========================================================================================================

-- SUPPORTING FUNCTIONS --

-- verify weather current target position is a valid spot for villager to walk
local function targetClear(self)
		
	local pos = {x=self.vTargetPos.x, y=self.vTargetPos.y, z=self.vTargetPos.z}
	local nodenames

	--check vertical pos at villager's lowerbody
	nodenames = getNodeName({x=pos.x, y=pos.y, z=pos.z})
	if log then io.write("\n  - "..nodenames[2]) end
	if minetest.registered_nodes[nodenames[1]].walkable then
		if log then io.write("[fail] ") end
		return false
	else
		if log then io.write("[OK] ") end
	end
	
	--check vertical pos at villager's upperbody
	nodenames = getNodeName({x=pos.x, y=pos.y+1, z=pos.z})
	if log then io.write(nodenames[2]) end
	if minetest.registered_nodes[nodenames[1]].walkable then
		if log then io.write("[fail] ") end
		return false
	else
		if log then io.write("[OK] ") end
	end
	
	--check vertical pos below villager's feet
	nodenames = getNodeName({x=pos.x, y=pos.y-1, z=pos.z})
	local nodename = nodenames[2]
	if log then io.write(nodenames[2]) end
	if string.find(nodename, "WATER") or string.find(nodename, "LAVA") or string.find(nodename, "AIR") then
		if log then io.write("[fail] ") end
		return false
	else
		if log then io.write("[OK] ") end
	end

	return true
end

local function turnYaw(self, yaw_index, turnRight)
	local new_yaw_index
	if turnRight then
		new_yaw_index = yaw_index + 1
		if new_yaw_index > 8 then new_yaw_index = 1 end
	else
		new_yaw_index = yaw_index - 1
		if new_yaw_index < 1 then new_yaw_index = 8 end
	end
	
	local new_yaw = YAWS[new_yaw_index]
	self.vFacingDirection = DIRECTIONS[new_yaw_index]

	self.vYaw = new_yaw
	self.object:setyaw(new_yaw)
end

local function addToInventory(self, item)
	local meta = minetest.get_meta(self.vNodeMetaPos)
	local inv = meta:get_inventory()
	local stack = ItemStack(item)
	
	if inv:room_for_item("main", stack) then
		local leftovers = inv:add_item("main", stack)
		return true
	else
		return false
	end
end

local function posHasObject(pos)
	local objects = minetest.get_objects_inside_radius(pos, 0.8)
	local object_count = #objects
	local return_bool
	if object_count > 0 then
		
		for n = 1, #objects do
			if objects[n]:is_player() then
				if log then io.write("foundPlayer["..objects[n]:get_player_name().."] ") end
			else
				local luaentity = objects[n]:get_luaentity()
				if luaentity.vName then
					if log then io.write("foundVillager["..luaentity.vName.."] ") end
				else
					if log then io.write("foundEntity ") end
				end
				local pos = objects[n]:get_pos()
				if log then io.write("("..pos.x..","..pos.z..") ") end
			end
			
		end
		
		return_bool = true
	else
		if log then io.write("targetPosNoEntity ") end
		return_bool = false
	end
	return return_bool
end

-- MAIN VILLAGER ACTIONS

-- stand idle
local function standVillager(self)
	if log then io.write("stand() ") end
	self.vAction = "STAND"
	
	-- skip remaining code if villager already standing
	if self.vAction == "STAND" then 
		return 
	end
		
	self.object:set_animation(
		{x=self.animation["stand_start"], y=self.animation["stand_end"]},
		self.animation_speed + math.random(10)
	)
	
	-- replace turn preference from 'right' to 'left' or vice versa
	-- after a string of consecutive turns
	if self.vTurnPreference == "right" then
		self.vTurnPreference = "left"
	else
		self.vTurnPreference = "right"
	end
	
end

-- turn left or right by 45 degrees
local function turnVillager(self)
	if log then io.write("turn() ") end
	self.vAction = "TURN"
	
	local face_dir = self.vFacingDirection
	if self.vTurnDirection == "right" then
		if face_dir == "N" then turnYaw(self, 1, true)
		elseif face_dir == "NE" then turnYaw(self, 2, true)
		elseif face_dir == "E" then turnYaw(self, 3, true)
		elseif face_dir == "SE" then turnYaw(self, 4, true)
		elseif face_dir == "S" then turnYaw(self, 5, true)
		elseif face_dir == "SW" then turnYaw(self, 6, true)
		elseif face_dir == "W" then turnYaw(self, 7, true)
		elseif face_dir == "NW" then turnYaw(self, 8, true)
		end
	else
		if face_dir == "N" then turnYaw(self, 1)
		elseif face_dir == "NE" then turnYaw(self, 2)
		elseif face_dir == "E" then turnYaw(self, 3)
		elseif face_dir == "SE" then turnYaw(self, 4)
		elseif face_dir == "S" then turnYaw(self, 5)
		elseif face_dir == "SW" then turnYaw(self, 6)
		elseif face_dir == "W" then turnYaw(self, 7)
		elseif face_dir == "NW" then turnYaw(self, 8)
		end
	end
	
	if log then io.write("nowFacing="..self.vFacingDirection.." ") end
end

local function walkVillagerEnd(self)
	if log then io.write(string.upper(self.vName).." ") end
	
	-- stop villager and show standing anim. villager should
	-- now be standing at or near the target position
	self.object:setvelocity({x=0,y=0,z=0})
	self.object:set_animation(
		{x=self.animation["stand_start"], y=self.animation["stand_end"]},
		self.animation_speed + math.random(10)
	)
	self.vAction = "STAND"
	
	-- teleport villager to exact target position to makeup for any
	-- discrepencies in movement time and distance
	self.vPos.x = self.vTargetPos.x
	self.vPos.z = self.vTargetPos.z
	self.object:set_pos(self.vPos)
	
	-- update villager pathfinding parameters for next walk attempt
	local newOriginDist = round(vector.distance(self.vOriginPos, self.vPos),1)
	self.vOriginDistance = newOriginDist			
	
	if newOriginDist < self.vOriginDistMax then
		
	else
		self.vAction = "TURNBACK"
		if log then io.write("DistMaxed set_vAction=TURNBACK ") end
	end
	if log then io.write("originDist="..newOriginDist.." ") end
	
end

-- walk forward a specific number of blocks
local function walkVillager(self)
	if log then io.write("walk() ") end
	self.vAction = "WALKING"
	
	-- calculate velocity and direction
	local facing = self.vFacingDirection
	local x_velocity = NODE_AREA[facing][1]
	local z_velocity = NODE_AREA[facing][2]

	--move villager in the direction of target position
	self.object:setvelocity({x=x_velocity,y=0,z=z_velocity})

	--show walking animation
	self.object:set_animation(
		{x=self.animation["walk_start"], y=self.animation["walk_end"]},
		self.animation_speed + math.random(10)
	)
	
	local distance = round(vector.distance(self.vPos, {x=self.vTargetPos.x, y=self.vPos.y, z=self.vTargetPos.z}),1)
	
	--after 'distance' seconds, stop villager movement
	minetest.after(distance, function() 
		if log then io.write("\n  ** MTAFTER.WALK-ENDED("..distance..") ") end
		walkVillagerEnd(self)
		if log then io.write("MTAFTER_END **") end
	end)
	
	if log then io.write("mtAfterScheduled runIn: "..distance.."sec ") end
end

local function digVillager(self)
	if log then io.write("dig() ") end
	
	-- skip remaining code if villager already standing
	if self.vAction == "DIG" then
		self.vSavepoints.digVillager = nil
		return
	end
	self.vAction = "DIG"
	
	self.object:set_animation(
		{x=self.animation["dig_start"], y=self.animation["dig_end"]},
		self.animation_speed + math.random(10)
	)
	
	self.vSoundHandle = minetest.sound_play(
		"default_dig_crumbly", 
		{object = self.object, loop = true, gain = 0.2, max_hear_distance = 8} 
	)
	
end

local function replaceNode(self)
	if log then io.write("replace() ") end
	self.vAction = "REPLACE"
	
	local dugNodeData = getFacingNodeInfo(self, 3)
	local dugPosition = dugNodeData[1]
	local dugNodeName = dugNodeData[2]
	local dugNodeNickname = dugNodeData[3]	
	
	-- snow
	if dugNodeNickname == "SNOW" then		
		if addToInventory(self, dugNodeName) then
			minetest.remove_node(dugPosition)
		else
			--io.write("invFull=digFailed ")
		end
		
		
	-- grass
	elseif string.find(dugNodeNickname, "GRASS_") then
		if addToInventory(self, "default:grass_1") then
			if dugNodeNickname == "GRASS_1" then
				minetest.remove_node(dugPosition)
			else
				minetest.set_node(dugPosition, {name = "default:grass_1"})
			end
		else
			--io.write("invFull=digFailed ")
		end
		
	-- cotton
	elseif dugNodeNickname == "COTTON_8" then
		if addToInventory(self, "farming:cotton") then
			minetest.set_node(dugPosition, {name = "farming:cotton_1"})
		else
			--io.write("invFull=digFailed ")
		end
		
	-- wheat
	elseif dugNodeNickname == "WHEAT_8" then
		if addToInventory(self, "farming:wheat") then
			minetest.set_node(dugPosition, {name = "farming:wheat_1"})
		else
			--io.write("invFull=digFailed ")
		end
		
	elseif string.find(dugNodeNickname, "FLOWER_") then
		if addToInventory(self, dugNodeName) then
			minetest.set_node(dugPosition, {name = "default:grass_1"})
		else
			--io.write("invFull=digFailed ")
		end
	end
	
	minetest.sound_stop(self.vSoundHandle)
	minetest.sound_play("default_dig_snappy", {pos = dugPosition, gain = 0.4, max_hear_distance = 8} )
	
	-- show standing anim for the rest of the action cycle
	self.object:set_animation(
		{x=self.animation["stand_start"], y=self.animation["stand_end"]},
		self.animation_speed + math.random(10)
	)
	
	self.vAction = "STAND"
end

-- stand still while verifying path in front and taking note any obstructions
local function verifyPath(self, forced_step_distance, walking_back)
	if log then io.write("verify() ") end
	
	-- if villager has despawned
	if self == nil then return end
	
	-- verifyPath() called from turnBack()
	if walking_back then
		self.vAction = "WALKBACK"
	
	-- verifyPath() called via normal action cycle
	else
		self.vAction = "VERIFY"
	end	
	
	local remainingDistance
	if forced_step_distance then
		-- 'forced_step_distance' param is typicalled passed when verifyPath()
		-- is manually executed by turnBack() when walk distance is maxed and 
		-- only want villager to walk forward 1 block/node
		remainingDistance = forced_step_distance
	else
		remainingDistance = math.random(math.floor(self.vOriginDistMax - self.vOriginDistance))
	end
	
	local possibleWalkDistance = 0
	local facingDeadEnd = false
	
	if log then 
		local currPos = self.object:get_pos()
		io.write("getPos("..currPos.x..","..currPos.z..") ")
		io.write("vPos("..self.vPos.x..","..self.vPos.z..") ")
		io.write("goalDist="..remainingDistance.." ")
	end
	
	-- re-initialize targetPos to player's current x,z coordinates
	self.vTargetPos.x = self.vPos.x
	self.vTargetPos.z = self.vPos.z
	
	for i = 1, remainingDistance do
		--check a column of 3 nodes that is in front of villager. if encounter liquid, 
		--cliff or block node, break loop and save the target pos reached so far
		
		-- set targetPos to one node forward
		self.vTargetPos.x = self.vTargetPos.x + NODE_AREA[self.vFacingDirection][1]
		self.vTargetPos.z = self.vTargetPos.z + NODE_AREA[self.vFacingDirection][2]
		
		if targetClear(self) then
			if posHasObject(self.vTargetPos) then
			
			-- reset targetPos back to the previous node
				self.vTargetPos.x = self.vTargetPos.x - NODE_AREA[self.vFacingDirection][1]
				self.vTargetPos.z = self.vTargetPos.z - NODE_AREA[self.vFacingDirection][2]
				if i == 1 then
					facingDeadEnd = true
				end
				break
			else
				possibleWalkDistance = possibleWalkDistance + 1
			end
		else
			-- reset targetPos back to the previous node
			self.vTargetPos.x = self.vTargetPos.x - NODE_AREA[self.vFacingDirection][1]
			self.vTargetPos.z = self.vTargetPos.z - NODE_AREA[self.vFacingDirection][2]
			if i == 1 then
				facingDeadEnd = true
			end
			break -- break from for loop
		end
		
	end
 
	
	if facingDeadEnd then
		
		-- villager is trying to walk back but is apparently
		-- blocked by an entity. do not turn villager, but
		-- wait for next cycle and verifyPath() and attempt
		-- walking forward again.
		if walking_back then
			if log then io.write("walkBackBlocked waitAnotherCycle " ) end
			
		-- an entity is blocking the node directly in front
		-- of villager. simply have villager turn
		else
			if log then io.write("frontNodeBlocked ") end
			turnVillager(self)
		end
		
	elseif possibleWalkDistance > 0 then
		self.vAction = "WALK"
	end

end

-- turn villager 180 degrees and walk random distance back
local function turnBack(self)
	if log then io.write("turnBack() ") end
	self.vAction = "TURNBACK"
	
	local face_dir = self.vFacingDirection
	local new_facing_dir
	
	if face_dir == "N" then 
		new_facing_dir = "S"
		self.vYaw = YAWS[5]
	elseif face_dir == "E" then 
		new_facing_dir = "W"
		self.vYaw = YAWS[7]
	elseif face_dir == "S" then 
		new_facing_dir = "N"
		self.vYaw = YAWS[1]
	elseif face_dir == "W" then 
		new_facing_dir = "E"
		self.vYaw = YAWS[3]
	end
	
	-- update yaw to 180 degrees from prior yaw
	self.object:setyaw(self.vYaw)
	self.vFacingDirection = new_facing_dir
	
	-- if villager despawns before executing below minetest.after() code
	-- then setting vAction to 'WALKBACK' ensures villager resumes 
	-- walking back 1 node upon respawn via verifyPath(self, 1, true)
	self.vAction = "WALKBACK"
	
	minetest.after(1.0, function() 
		if log then io.write("\n  ** mtAfter.walkBack(1) ") end
		verifyPath(self, 1, true)
		if log then io.write("MTAFTER_END **") end
	end)

end

local function randomAct(self)
	if log then io.write("randomAct() ") end
	
	local face_dir = self.vFacingDirection	
	if (face_dir == "N" or face_dir == "E" or face_dir == "S" or face_dir == "W") then
		local targetNode = getFacingNodeInfo(self)
		local tNodeName = targetNode[2]
		local tNodeNickname = targetNode[3]	
		local tNodeDrawtype = minetest.registered_nodes[tNodeName].drawtype
		
		-- air, ladders/signs, and torches
		if tNodeDrawtype == "airlike" or tNodeDrawtype == "signlike" or tNodeDrawtype == "torchlike" then
				
			-- villager can walk further distance from origin
			if self.vOriginDistance < self.vOriginDistMax then 
				local random_num = math.random(5)
				if random_num == 1 then turnVillager(self)
				elseif random_num == 2 then standVillager(self)
				else verifyPath(self) end
				
			else turnBack(self) end
			
		-- plants or crops
		-- only farmers and field workers will walk into fields and and dig crops
		elseif tNodeDrawtype == "plantlike" then
			
			if tNodeNickname == "COTTON_8" then
				if self.vType == "field" or self.vType == "farm_tiny" or self.vType == "farm_full" then
					self.vDigging = "cotton"
					digVillager(self)
				else
					local random_num = math.random(4)
					if random_num == 1 then verifyPath(self)
					elseif random_num == 2 then standVillager(self)
					else turnVillager(self) end
				end
			
			elseif tNodeNickname == "WHEAT_8" then
				if self.vType == "field" or self.vType == "farm_tiny" or self.vType == "farm_full" then
					self.vDigging = "wheat"
					digVillager(self)
				else
					local random_num = math.random(4)
					if random_num == 1 then verifyPath(self)
					elseif random_num == 2 then standVillager(self)
					else turnVillager(self) end
				end
				
			elseif tNodeNickname == "COTTON_1" or tNodeNickname == "WHEAT_1" then
				if self.vType == "field" or self.vType == "farm_tiny" or self.vType == "farm_full" then
					verifyPath(self, 1)
				else
					if math.random(2) == 1 then turnVillager(self)
					else standVillager(self) end
				end
				
			elseif tNodeNickname == "GRASS_1" or tNodeNickname == "GRASS_5" then
				local randomNum = math.random(6)
				if randomNum == 1 then turnVillager(self)
				elseif randomNum == 2 then standVillager(self)
				elseif randomNum == 3 then verifyPath(self)
				else 
					self.vDigging = "grass"
					digVillager(self) 
				end
				
			elseif string.find(tNodeNickname, "FLOWER_") then
				self.vDigging = "flower"
				digVillager(self)
			
			else
				local randomNum = math.random(3)
				if randomNum == 1 then standVillager(self)
				elseif randomNum == 2 then verifyPath(self)
				else turnVillager(self) end
			end
			
		-- all other solid nodes
		elseif tNodeNickname == "SNOW" then
			if math.random(3) == 1 then 
				standVillager(self)
			else 
				self.vDigging = "snow"
				digVillager(self) 
			end
			
		-- target node is a node block or common obstruction
		else turnVillager(self) end
		
	-- facing direction is NE, SE, SW, NW
	else turnVillager(self) end
	
end


local function animateVillager(self)
	if log then io.write("\nANIM ") end
	
	if log then io.write(self.vName.." "..self.vFacingDirection.." prev="..self.vAction.." ") end
	
	local current_action = self.vAction
	if current_action == "STAND" then -- tested ok!
		randomAct(self) -- randomly do another action
		
	elseif current_action == "TURN" then -- tested ok!
		randomAct(self) -- randomly do another action

	elseif current_action == "DIG" then -- tested ok!
		replaceNode(self)
		
	-- if villager despawns while digging
	elseif current_action == "RESUMEDIG" then -- tested ok!
		digVillager(self)
		
	elseif current_action == "WALK" then -- tested OK!
		walkVillager(self)
		
	elseif current_action == "WALKING" then	-- tested ok!
		if log then io.write("walking.. ") end
		
	elseif current_action == "TURNBACK" then -- test ok!
		turnBack(self)
		
	elseif current_action == "WALKBACK" then
		verifyPath(self, 1, true)
		
	elseif current_action == "ENDCHAT" then
		if log then io.write("chatEnding.. ") end
		
	else
		if log then io.write("error vAction="..current_action.." ") end
	end
		
	if log then io.write("ANIM_END") end
end







-- ==================================== CHAT BUBBLES AND DIALOGUE =========================================
-- ========================================================================================================

-- show alert box messages
local function showMessageBubble(self, player, message_text, message_location, clear_timer)
	
	-- remove any existing message HUDs for this villager if still showing
	if self.vHudIds.chat_name then
		player:hud_remove(self.vHudIds.chat_name)
		self.vHudIds.chat_name = nil
	end
	
	if self.vHudIds.chat_text then
		player:hud_remove(self.vHudIds.chat_text)
		self.vHudIds.chat_text = nil
	end
	
	if self.vHudIds.chat_box then
		player:hud_remove(self.vHudIds.chat_box)
		self.vHudIds.chat_box = nil
	end

	-- player is chatting with a villager
	if self then
	
		local x_offset, message_position, message_align, bubble_texture
		local y_offset
		
		if message_location == "FRONT" then
			x_offset = 0
			y_offset = -300
			bubble_texture = "bubble_villager_front.png"
			message_position = { x = 0.5, y = 1.0 }
			message_align = {x=0, y=0}
		elseif message_location == "FRONTRIGHT" then
			x_offset = -200
			y_offset = -150
			bubble_texture = "bubble_villager_frontright.png"
			message_position = { x = 1.0, y = 1.0 }
			message_align = {x=1, y=0}
		elseif message_location == "RIGHT" then
			x_offset = -200
			y_offset = -150
			bubble_texture = "bubble_villager_right.png"
			message_position = { x = 1.0, y = 1.0 }
			message_align = {x=1, y=0}
		elseif message_location == "BEHINDRIGHT" then
			x_offset = -200
			y_offset = -150
			bubble_texture = "bubble_villager_behindright.png"
			message_position = { x = 1.0, y = 1.0 }
			message_align = {x=1, y=0}
		elseif message_location == "FRONTLEFT" then
			x_offset = 200
			y_offset = -150
			bubble_texture = "bubble_villager_frontleft.png"
			message_position = { x = 0.0, y = 1.0 }
			message_align = {x=-1, y=0}
		elseif message_location == "LEFT" then
			x_offset = 200
			y_offset = -150
			bubble_texture = "bubble_villager_left.png"
			message_position = { x = 0.0, y = 1.0 }
			message_align = {x=-1, y=0}
		elseif message_location == "BEHINDLEFT" then
			x_offset = 200
			y_offset = -150
			bubble_texture = "bubble_villager_behindleft.png"
			message_position = { x = 0.0, y = 1.0 }
			message_align = {x=-1, y=0}
		elseif message_location == "BEHIND" then
			x_offset = 0
			y_offset = -150
			bubble_texture = "bubble_villager_behind.png"
			message_position = { x = 0.5, y = 1.0 }
			message_align = {x=0, y=0}
		elseif message_location == "TRADING" then
			x_offset = -280
			y_offset = -100
			bubble_texture = "bubble_villager_right.png"
			message_position = { x = 0.5, y = 0.5 }
			message_align = {x=1, y=0}
		elseif message_location == "TRADINGBYE" then
			x_offset = 0
			y_offset = -240
			bubble_texture = "bubble_villager_front.png"
			message_position = { x = 0.5, y = 1.0 }
			message_align = {x=0, y=0}
		else
			--io.write("ERROR - Invalid message_location="..message_location.." ")
			return
		end
		
		local nameAndTitleString = "~ "..self.vName.." "
		
		if self.vType == "bakery" then
			nameAndTitleString = nameAndTitleString .. "(baker) ~"
			
		elseif self.vType == "church" then
			if self.vGender == "male" then
				nameAndTitleString = nameAndTitleString .. "(priest) ~"
			else
				nameAndTitleString = nameAndTitleString .. "(priestess) ~"
			end
			
		elseif self.vType == "empty" then
			nameAndTitleString = nameAndTitleString .. "(traveler) ~"
			
		elseif self.vType == "farm_full" or self.vType == "farm_tiny" then
			nameAndTitleString = nameAndTitleString .. "(farmer) ~"
			
		elseif self.vType == "forge" then
			nameAndTitleString = nameAndTitleString .. "(metalsmith) ~"
			
		elseif self.vType == "lumberjack" then
			nameAndTitleString = nameAndTitleString .. "(lumberjack) ~"
			
		elseif self.vType == "mill" or self.vType == "sawmill" then
			nameAndTitleString = nameAndTitleString .. "(millworker) ~"
			
		elseif self.vType == "school" then
			if self.vAge == "young" then
				nameAndTitleString = nameAndTitleString .. "(student) ~"
			else
				nameAndTitleString = nameAndTitleString .. "(teacher) ~"
			end
			
		elseif self.vType == "library" then
			nameAndTitleString = nameAndTitleString .. "(librarian) ~"
			
		elseif self.vType == "shop" then
			nameAndTitleString = nameAndTitleString .. "(shopkeep) ~"
			
		elseif self.vType == "tavern" then
			nameAndTitleString = nameAndTitleString .. "(tavern owner) ~"
			
		elseif self.vType == "tower" then
			nameAndTitleString = nameAndTitleString .. "(guard) ~"
			
		elseif self.vType == "trader" then
			nameAndTitleString = nameAndTitleString .. "(trader) ~"
			
		else
			nameAndTitleString = nameAndTitleString .. " ~"
		end
		
		-- show chat bubble
		self.vHudIds.chat_box = player:hud_add({
			hud_elem_type = "image",
			scale = { x = 1, y = 1 },
			position = message_position,
			text = bubble_texture,
			offset = {x=0+x_offset, y=y_offset}, 
		})
		
		--show villager's name within chat bubble
		self.vHudIds.chat_name = player:hud_add({
			hud_elem_type = "text",
			position = message_position,
			text = nameAndTitleString,
			number = 0x666666,
			offset = {x=0+x_offset, y=y_offset-25} 
		})
		
		--show main text within chat bubble
		self.vHudIds.chat_text = player:hud_add({
			hud_elem_type = "text",
			position = message_position,
			text = message_text,
			number = 0x000000,
			offset = {x=0+x_offset, y=y_offset+15} 
		})
		
		if clear_timer then
			minetest.after(clear_timer, function() 
				if self.vHudIds.chat_name then
					player:hud_remove(self.vHudIds.chat_name)
					self.vHudIds.chat_name = nil
				end
				
				if self.vHudIds.chat_text then
					player:hud_remove(self.vHudIds.chat_text)
					self.vHudIds.chat_text = nil
				end
				
				if self.vHudIds.chat_box then
					player:hud_remove(self.vHudIds.chat_box)
					self.vHudIds.chat_box = nil
				end
			end)
		end
		
		-- play bubble pop sound at the villager's position
		minetest.sound_play("pop", {pos = self.vPos} )
		
	-- player is receiving a notification from this mod
	else
		local vertical_position = 0.0
		local texture_filename = "bubble_notify.png"
	end
	
end

local function yawToDegrees(yaw)
	
	local degrees_value
	local PI_VALUE = 3.141
	local MULTIPLIER = 180 / PI_VALUE
	
	-- convert yaw to value ranging from 2*PI to zero
	if yaw < 0 then
		yaw = (PI_VALUE * 2) + yaw
	end
	
	yaw = round(yaw, 3)
	
	if yaw == 0 or yaw == 6.282 then
		degrees_value = 0
	
	-- range from 0 to 179 degrees
	elseif yaw > PI_VALUE then
		degrees_value = 180 - ((yaw - PI_VALUE) * MULTIPLIER)
		
	-- range from 181 to 359 degrees
	elseif yaw < PI_VALUE then
		degrees_value = 180 + ((PI_VALUE - yaw) * MULTIPLIER)
		
	-- is exactly South
	elseif yaw == PI_VALUE then
		degrees_value = 180
	
	else
		--io.write("ERROR - Invalid yaw="..yaw.." ")
		degrees_value = 0
	end

	degrees_value = round(degrees_value,1)
	return degrees_value
end

local ORIENTATIONS = {
   { "BEHIND", "BEHINDRIGHT", "RIGHT", "FRONTRIGHT", "FRONT", "FRONTLEFT", "LEFT", "BEHINDLEFT" },
   { "BEHINDLEFT", "BEHIND", "BEHINDRIGHT", "RIGHT", "FRONTRIGHT", "FRONT", "FRONTLEFT", "LEFT" },
   { "LEFT", "BEHINDLEFT", "BEHIND", "BEHINDRIGHT", "RIGHT", "FRONTRIGHT", "FRONT", "FRONTLEFT" },
   { "FRONTLEFT", "LEFT", "BEHINDLEFT", "BEHIND", "BEHINDRIGHT", "RIGHT", "FRONTRIGHT", "FRONT" },
   { "FRONT", "FRONTLEFT", "LEFT", "BEHINDLEFT", "BEHIND", "BEHINDRIGHT", "RIGHT", "FRONTRIGHT" },
   { "FRONTRIGHT", "FRONT", "FRONTLEFT", "LEFT", "BEHINDLEFT", "BEHIND", "BEHINDRIGHT", "RIGHT" },
   { "RIGHT", "FRONTRIGHT", "FRONT", "FRONTLEFT", "LEFT", "BEHINDLEFT", "BEHIND", "BEHINDRIGHT" },
   { "BEHINDRIGHT", "RIGHT", "FRONTRIGHT", "FRONT", "FRONTLEFT", "LEFT", "BEHINDLEFT", "BEHIND" }
}

local function getLookDirection(yaw)
   local degrees = yawToDegrees(yaw)
   local lookDirection
   if degrees > 337.5 or degrees <= 22.5 then
      lookDirection = 1
   elseif degrees > 22.5 and degrees <= 67.5 then
      lookDirection = 2
   elseif degrees > 67.5 and degrees <= 112.5 then
      lookDirection = 3
   elseif degrees > 112.5 and degrees <= 157.5 then
      lookDirection = 4
   elseif degrees > 157.5 and degrees <= 202.5 then
      lookDirection = 5
   elseif degrees > 202.5 and degrees <= 247.5 then
      lookDirection = 6
   elseif degrees > 247.5 and degrees <= 292.5 then
      lookDirection = 7
   elseif degrees > 292.5 and degrees <= 337.5 then
      lookDirection = 8
   else
      lookDirection = 1
   end
   return lookDirection
end

local function getChatOrientation(self, player)
   local villagerDir = getLookDirection(self.object:get_yaw())
   local playerDir = getLookDirection(player:get_look_horizontal())
   return ORIENTATIONS[villagerDir][playerDir]
end







--[[
	self: villager lua entity
	chat_texts: table that contains one or more strings of chat dialogue
	script_type: corresponds to the lua entity variables 'vScriptHi', 'vScriptBye', 'vScriptMain'
--]]
local function getRandomChatText(self, chat_texts, script_type, chat_text_count)
	--print("getRandomChatText("..script_type.." "..chat_text_count..") ")
	
	-- all of villager's chat text has been used up (via table.remove) so need to
	-- reload from saved. this ensures the villager keeps the same initial set of
	-- chat texts, but it will be in random order upon each reload.
	-- ** this situation never occurs for HI, BYE, and smalltalk chat tests **
	if self[script_type] then
		for i=1, #self[script_type.."Saved"] do
			local text_string = self[script_type.."Saved"][i]
			table.insert(self[script_type], text_string)
		end
		
	-- first time villager object is activated. initialize with chat text and save
	-- a copy that set for reload later as player 'uses up' those chat taxts when chatting
	else
		self[script_type] = {}
		self[script_type.."Saved"] = {}
		for i=1, chat_text_count do
			local text_string = table.remove(chat_texts, math.random(#chat_texts))
			
			-- add dynamic customization to villagers main chat text, not HI, BYE, or smalltalk
			-- this is mostly for testing and may be removed later
			if script_type == "vScriptMain" then
				text_string = string.gsub(text_string, "VILLAGER_NAME", self.vName)
				text_string = string.gsub(text_string, "BUILDING_TYPE", self.vType)
				text_string = string.gsub(text_string, "AGE", self.vAge)
				text_string = string.gsub(text_string, "GENDER", self.vGender)
				text_string = string.gsub(text_string, "REGION", self.vRegion)
			end
			
			table.insert(self[script_type], text_string)
			table.insert(self[script_type.."Saved"], text_string)
		end
	end	

end

local function endVillagerChat(self, player, player_walked_away)

	local message_location = getChatOrientation(self, player)
	
	local goodbyes
	if player_walked_away then
		goodbyes = self.vScriptBye
		showMessageBubble(self, player, goodbyes[math.random(#goodbyes)], message_location, 1)
		
	-- villager went through all 'main' dialogue
	-- so then ended the chat with player 'got to go!'
	else
		goodbyes = self.vScriptGtg
		showMessageBubble(self, player, goodbyes[math.random(#goodbyes)], message_location, 2)
	end
			
	
	
	-- load previous yaw value
	self.vYaw = self.vYawSaved
	
	-- resume previous look direction
	minetest.after(2, function() 
		self.object:setyaw(self.vYaw)
		
		-- player had initiated tradeing while villager was
		-- about to walk or dig. now continue with that action.
		if self.vWalkReady then
			self.vAction = "WALK"
			self.vWalkReady = false
		elseif self.vDigReady then
			self.vAction = "RESUMEDIG"
			self.vDigReady = false
		else
			self.vAction = "STAND"
		end
		
	end)
	
	self.vChatting = nil
	self.vAction = "ENDCHAT"
end

local function chatVillager(self, player, player_is_trading)
	if log2 then io.write("chat() ") end
	
	-- if player initiated chat when villager was about to start 
	-- walking or digging. save this state to continue action once chat ends
	if self.vAction == "WALK" then
		if log2 then io.write("villagerAboutToWalk ") end
		self.vWalkReady = true
	elseif self.vAction == "DIG" then
		if log2 then io.write("villagerAboutToDig ") end
		self.vDigReady = true
		minetest.sound_stop(self.vSoundHandle)
		self.object:set_animation(
			{x=self.animation["stand_start"], y=self.animation["stand_end"]},
			self.animation_speed + math.random(10)
		)
	elseif self.vAction == "RESUMEDIG" then
		if log2 then io.write("villagerAboutToResumeDig ") end
		self.vDigReady = true
	end
	
	self.vAction = "CHAT"
	
	local player_name = player:get_player_name()
	
	-- show a quick greeting bubble for when player right clicks
	-- on villager for trading
	if player_is_trading == 1 then
		if log2 then io.write("startTrading ") end
		showMessageBubble(self, player, villagers.chat.trade.hi[math.random(#villagers.chat.trade.hi)], "TRADING", 3)
		
	elseif player_is_trading == 2 then
		if log2 then io.write("endingTrade ") end
		showMessageBubble(self, player, villagers.chat.trade.bye[math.random(#villagers.chat.trade.bye)], "TRADINGBYE", 3)
		
	-- player continuing ongoing dialogue with villager
	elseif self.vChatting then
		if log2 then io.write("continuingConversation ") end
		local next_dialogue
		
		-- pop/remove one random dialogue from 'smalltalk' table
		if math.random(3) == 1 then
			local dialogue_count = #self.vScriptSmalltalk
			if log2 then io.write("getDialogue:smalltalk fromRemain="..dialogue_count.." ") end
			if dialogue_count == 0 then
				local full_dialgue_table = copytable(villagers.chat.smalltalk)
				getRandomChatText(self, full_dialgue_table, "vScriptSmalltalk", 3)
				if log2 then io.write("tableReloaded:smalltalk ") end
			end
			
			next_dialogue = table.remove(self.vScriptSmalltalk, math.random(dialogue_count))
			showMessageBubble(self, player, next_dialogue, "FRONT")
			if log2 then io.write("dialogueDisplayedOK remain="..#self.vScriptSmalltalk.." ") end
			
		-- pop/remove one random dialogue from 'mainchat' table
		else
			local dialogue_count = #self.vScriptMain
			if log2 then io.write("getDialogue:main fromRemain="..dialogue_count.." ") end
			if dialogue_count == 0 then
				local full_dialgue_table = copytable(villagers.chat[self.vType].mainchat)
				getRandomChatText(self, full_dialgue_table, "vScriptMain", 3)
				if log2 then io.write("tableReloaded:main ") end
				endVillagerChat(self, player, false)
				if log2 then io.write("chatEnded ") end
			else
				next_dialogue = table.remove(self.vScriptMain, math.random(dialogue_count))
				showMessageBubble(self, player, next_dialogue, "FRONT")
				if log2 then io.write("dialogueDisplayedOK remain="..#self.vScriptMain.." ") end
			end
			
		end
		
	-- player starting new conversation with villager
	else
		if log2 then io.write("\nnewConversation ") end
		
		self.vChatting = player_name
		self.vYawSaved = self.vYaw
		
		-- make villager face player
		turnToPlayer(self, player)
		
		-- save initial distance between player and villager. if player 
		-- surpasses this distance, villager will end chat.
		self.vInitialChatDistance = vector.distance(self.vPos, player:getpos())
		
		local greeting_text
		
		-- if player chats while villager was about to walk
		if self.vWalkReady then
			if log2 then io.write("villagerAboutToWalk ") end
			greeting_text = villagers.chat.walk[math.random(#villagers.chat.walk)]
		
		-- if player chats while villager was digging
		elseif self.vDigReady then
			if log2 then io.write("villagerDigging ") end
			greeting_text = villagers.chat.dig[self.vDigging][math.random(#villagers.chat.dig[self.vDigging])]
			
		-- show one of the random default greetings for this villager type
		else
			if log2 then io.write("showDefaultHI ") end
			local greetings = self.vScriptHi
			greeting_text = greetings[math.random(#greetings)]
		end
		
		showMessageBubble(self, player, greeting_text, "FRONT")
		
	end
	
	if log2 then io.write("\n") end
end





-- ============================================ VILLAGER TRADING ==========================================
-- ========================================================================================================

local function endVillagerTrading(villager_id, player)

	local self
	for _,luaentity in pairs(minetest.luaentities) do
		if luaentity.object then
			if luaentity.vID then
				if luaentity.vID == villager_id then
					self = luaentity					
				end
			else
				--io.write("objectNotVillager ")
			end
		else
			--io.write("foundEntityButNotObject ")
		end
	end

	if self then
		
		chatVillager(self, player, 2)
		
		-- load previous yaw value
		self.vYaw = self.vYawSaved
		
		-- resume previous action
		minetest.after(2, function() 
			self.object:setyaw(self.vYaw)
			
			-- player had initiated tradeing while villager was
			-- about to walk or dig. now continue with that action.
			if self.vWalkReady then
				self.vAction = "WALK"
				self.vWalkReady = false
			elseif self.vDigReady then
				self.vAction = "RESUMEDIG"
				self.vDigReady = false
			else
				self.vAction = "STAND"
			end
		end)
		
		self.vTrading = nil
		self.vAction = "ENDTRADE"
		
	else
		--io.write("NoMatchingVillagerFound ")
	end
	
end

local function getTradingFormspec(self, player)
	
	--[[
	local width_vertical_margins = 0.25
	local width_column = 1
	local width_between_columns = 0.25
	local width_item_count = 0.5
	local width_trade_button = 1
	local number_of_columns = 5
	local number_of_item_counters = 3
	
	local width_form = 
		(width_vertical_margins * 2) +
		(width_column * number_of_columns) +
		(width_between_columns * (number_of_columns - 1)) +
		(width_item_count * (number_of_item_counters)) +
		width_trade_button
	
	local height_horizontal_margins = 0.25
	local height_row = 1
	local height_between_rows = 0.25
	local height_labels = 1
	local height_exit_button = 1
	local number_of_rows = #self.vSell + 2 
	-- the +2 is for rows accupied by the column lables the exit button
	
	local height_form = 
		(height_horizontal_margins * 2) +
		(height_row * number_of_rows) +
		(height_between_rows * (number_of_rows + 1)) +
		height_labels + height_exit_button
	--]]
	
	local width_form = 3
	local height_form = 3
	
	local formspec = "size["..width_form..","..height_form.."]"..
		
		"list[nodemeta:"..self.vNodeMetaPos.x..","..self.vNodeMetaPos.y..","..self.vNodeMetaPos.z..";main;0,0;3,3;]"
		
	return formspec
end

local function tradeVillager(self, player)
	io.write("trade() ")
	self.vAction = "TRADE"
	
	-- formspec was already displayed and villager is currently trading
	if self.vTrading then
	
	-- villager is not yet trading: might be currently standing, walking, etc
	-- so create and show the tranding formspec
	else
		
		local player_name = player:get_player_name()
		self.vTrading = player_name
		self.vYawSaved = self.vYaw
		turnToPlayer(self, player) -- make villager face player
		
		-- show formspec
		minetest.show_formspec(player_name, "villagers:trade".."_"..self.vID, getTradingFormspec(self, player))
		
	end

end

local function setTradeInventory(self, trading_type)
	--[[
	local all_available_items = copytable(villagers.trade[self.vType])
	
	local item_count = math.random(#all_available_items)
	if self.vType == "" then
		
	else
		item_count =  #all_available_items
	end


	while( item_count > 0 ) do
		local index_to_pop = math.random(item_count)
		local popped_item = table.remove(all_available_items, index_to_pop)
		table.insert(self.vSell, popped_item)
		item_count = item_count - 1
	end
	--]]
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	
	if player == nil then 
		return 
	end
	if formname == nil then 
		return 
	end

	local form_data = string.split(formname, "_")
	local form_type = form_data[1]
	
	if form_type == "villagers:trade" then
		
		local villager_id = form_data[2]
		
		if fields == nil then
			return
		elseif fields.quit then
			endVillagerTrading(villager_id, player)
			
		else
			--io.write("ERROR Invalid fields="..fields.." ")
		end
		
	else
		--io.write("ERROR Invalid form_type="..form_type.." ")
	end

end)





-- ==================================== SPAWNING AND ENTITY REGISTRATION ==================================
-- ========================================================================================================

--[[ ENTITY REGISTRATION AND INITIAL SPAWNING --]]

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
	vType = "UNASSIGNED",
	vRegion = "UNASSIGNED",
	vHudIds = {
		chat_box = nil,
		chat_text = nil,
		chat_name = nil,
		alert_box = nil,
		alert_text = nil
	},
	vSoundHandle = nil,
	vSavepoints = {},
	vDespawned = nil,
	
	-- pathfinding
	vPos = {x=0,y=0,z=0},
	vFacingDirection = "N",
	vOriginPos = {x=0,y=0,z=0},
	vOriginDistance = 0,
	vOriginDistMax = 10,
	vTargetPos = {x=0,y=0,z=0},
	vSpawnHeight = 0,
	vTargetHeight = 0,
	vTurnPreference = "right",
	vWalkReady = false,
	vDigReady = false,
	
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
	
	-- trading
	vID = nil,
	vTrading = nil,
	vNodeMetaPos = {x=0,y=0,z=0},
	vBuy = nil,
	vSell = nil,
	
	-- debugging
	vTextureString = nil,
	
	on_activate = function(self, staticdata, dtime_s)
		if log then io.write("\nACTIVATE ") end
		
		-- perform default action, whichi is standing idle animation
		standVillager(self)
		
		if staticdata ~= "" then
			if log then io.write("(existing) ") end
			local customFields = minetest.deserialize(staticdata)
			self.object:set_properties({textures={customFields.vTexture}})
			self.object:set_properties({visual_size=customFields.vSize})
			self.object:set_properties({collisionbox=customFields.vBox})
			self.object:set_properties({infotext=customFields.vInfo})
			self.object:set_properties({hp_max=customFields.vHP})
			self.object:setpos(customFields.vPos)
			self.object:setyaw(customFields.vYaw)
			
			self.vName = customFields.vName
			self.vAge = customFields.vAge
			self.vTexture = customFields.vTexture
			self.vSize = customFields.vSize
			self.vBox = customFields.vBox
			self.vYaw = customFields.vYaw
			self.vYawSaved = customFields.vYawSaved
			self.vGender = customFields.vGender
			self.vAction = customFields.vAction
			self.vDigging = customFields.vDigging
			self.vActionFrequency = customFields.vActionFrequency
			self.vInitialChatDistance = 0
			self.vType = customFields.vType
			self.vRegion = customFields.vRegion
			self.vHudIds = customFields.vHudIds
			self.vSoundHandle = customFields.vSoundHandle
			self.vSavepoints = customFields.vSavepoints
			self.vDespawned = nil
			
			-- pathfinding
			self.vPos = customFields.vPos
			self.vFacingDirection = customFields.vFacingDirection
			self.vOriginPos = customFields.vOriginPos
			self.vOriginDistance = customFields.vOriginDistance
			self.vOriginDistMax = customFields.vOriginDistMax
			self.vTargetPos = customFields.vTargetPos
			self.vSpawnHeight = customFields.vSpawnHeight
			self.vTargetHeight = customFields.vTargetHeight
			self.vTurnPreference = customFields.vTurnPreference
			self.vWalkReady = false
			self.vDigReady = false
			
			-- chatting
			self.vChatting = nil
			self.vChatReady = true
			self.vScriptHi = customFields.vScriptHi
			self.vScriptHiSaved = customFields.vScriptHiSaved
			self.vScriptBye = customFields.vScriptBye
			self.vScriptByeSaved = customFields.vScriptByeSaved
			self.vScriptGtg = customFields.vScriptGtg
			self.vScriptGtgSaved = customFields.vScriptGtgSaved
			self.vScriptMain = customFields.vScriptMain
			self.vScriptMainSaved = customFields.vScriptMainSaved
			self.vScriptSmalltalk = customFields.vScriptSmalltalk
			self.vScriptSmalltalkSaved = customFields.vScriptSmalltalkSaved
			
			-- trading
			self.vID = customFields.vID
			self.vTrading = nil
			self.vNodeMetaPos = customFields.vNodeMetaPos
			self.vBuy = customFields.vBuy
			self.vSell = customFields.vSell
			
			-- debugging
			self.vTextureString = customFields.vTextureString
			
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
		
		-- debugging
		--print("\n## "..self.vTextureString.."\n")
		
		local current_action = self.vAction
		if log then io.write("vAction="..current_action.." ") end
		
		if current_action == "STAND" or current_action == "TURN" or current_action == "WALK" or
			current_action == "DIG" or current_action == "RESUMEDIG" then
			
			chatVillager(self, puncher)
			
		elseif current_action == "ENDCHAT" or current_action == "ENDTRADE" then
			local gender_ref = "his"
			if self.vGender == "female" then gender_ref = "her" end
			showAlert(self, puncher, self.vName.." didn't notice you.", 2)
			
		elseif current_action == "CHAT" then
			if self.vChatting == puncher:get_player_name() then
			
				-- if player constantly click spams villager
				-- villager will not be able to 'understand' player
				if time_from_last_punch < 0.8 then
					showMessageBubble(self, puncher, villagers.chat.spam[math.random(#villagers.chat.spam)], "FRONT")
				else
					chatVillager(self, puncher)
				end
			else
				showAlert(self, puncher, self.vName.." is busy chatting with "..string.upper(self.vChatting))
			end
			
		elseif current_action == "TRADE" then
			showAlert(self, puncher, self.vName.." is busy trading with "..string.upper(self.vTrading))
			
		-- villager will not chat if currently performing the
		-- below actions
		else
			local action_description
			local current_action = self.vAction
			if current_action == "WALKING" then
				action_description = "walking"
			elseif current_action == "TURNBACK" then
				action_description = "turning back"
			elseif current_action == "WALKBACK" then
				action_description = "walking"
			else
				io.write("ERROR vAction="..self.vAction.." ")
				action_description = "ERROR"
			end
			
			showAlert(self, puncher, self.vName.." is busy "..action_description..".")
		end
		
		self.object:set_hp(15) -- don't let villager die from punches
	end,
	
	on_rightclick = function(self, clicker)
	
		local current_action = self.vAction
		if log then io.write("vAction="..current_action.." ") end
		
		if current_action == "STAND" or current_action == "TURN" or current_action == "WALK" or
			current_action == "DIG" or current_action == "RESUMEDIG" then
			
			chatVillager(self, clicker, 1)
			tradeVillager(self, clicker)
			
		elseif current_action == "ENDTRADE" or current_action == "ENDCHAT" then
			local gender_ref = "his"
			if self.vGender == "female" then gender_ref = "her" end
			showAlert(self, clicker, self.vName.." was resuming "..gender_ref.." day\nand didn't hear you.", 2.5)
			
		-- when player right click's on a villager who is already
		-- trading with another player
		elseif current_action == "TRADE" then
			showAlert(self, clicker, self.vName.." is busy trading with "..string.upper(self.vTrading))
		
		elseif current_action == "CHAT" then
			
			if self.vChatting == clicker:get_player_name() then
				showAlert(self, clicker, "You are still chatting.")
			else
				showAlert(self, clicker, self.vName.." is busy chatting with "..string.upper(self.vChatting))
			end
			
		-- villager will not chat if currently performing the
		-- below actions
		else
			local action_description
			local current_action = self.vAction
			--if current_action == "RESUMEDIG" then
			--	action_description = "about to dig"
			if current_action == "WALKING" then
				action_description = "walking"
			elseif current_action == "TURNBACK" then
				action_description = "turning back"
			elseif current_action == "WALKBACK" then
				action_description = "walking"
			else
				io.write("ERROR vAction="..self.vAction.." ")
				action_description = "ERROR"
			end
			
			showAlert(self, clicker, self.vName.." is busy "..action_description..".")
		end
		
	end,
	
	
	on_step = function(self, dtime)
		
		self.vTimer = self.vTimer + dtime
		if self.vChatting then
			if self.vTimer > 1 then
				
				self.vTimer = 0
				
				local player = minetest.get_player_by_name(self.vChatting)
				if player then
				
					if self.vChatReady then					
						-- villager maintains yaw direction toward player
						turnToPlayer(self, player)
						
						local distance = vector.distance(self.vPos, player:getpos())
						
						local currVillagerLookDir = round(self.object:get_yaw(),3)
						local currPlayerLookDir = round(player:get_look_horizontal(),3)
						if currVillagerLookDir < 0 then
							currVillagerLookDir = currVillagerLookDir + (3.141*2)
						end
						
						-- player moved away from villager while chatting
						-- villager assumes player no longer wants to chat
						if distance > self.vInitialChatDistance then
							endVillagerChat(self, player, true)
						end
						
					else
						--io.write("#NOTREADY# ")
					end
					
					
				-- when player is no longer in-game while chatting/trading
				-- with villager, then end the chat.
				else
					-- load previous yaw value
					self.vYaw = self.vYawSaved
					
					-- resume previous action
					minetest.after(2, function() 
						self.object:setyaw(self.vYaw)
						animateVillager(self)
					end)
					
					self.vChatting = nil
				end
				
				
			end
		elseif self.vTrading then
			if self.vTimer > 1 then
				self.vTimer = 0
				--io.write("\n"..self.vName.." trading ")
			end
		else
			if self.vTimer > self.vActionFrequency then
				self.vTimer = 0
				animateVillager(self)
				--io.write("EndC")
			end
		end
		
	end, -- on_step function

	
	get_staticdata = function(self)
		if log then io.write("\nGETSTATIC("..self.vName..") ") end
		-- save all custom fields
		
		if self.vDespawned == false then
			if log then io.write("DESPAWNED vAction="..self.vAction.."\n") end
		else
			self.vDespawned = false
			if log then io.write("SPAWNED ") end
			-- show standing animation while waiting
			-- for the first action cycle to start
			self.object:set_animation(
				{x=self.animation["stand_start"], y=self.animation["stand_end"]},
				self.animation_speed + math.random(10)
			)
		end
		
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
			vType = self.vType,
			vRegion = self.vRegion,
			vHudIds = self.vHudIds,
			vSoundHandle = self.vSoundHandle,
			vSavepoints = self.vSavepoints,
			vDespawned = self.vDespawned,
			
			-- pathfinding
			vPos = self.vPos,
			vFacingDirection = self.vFacingDirection,
			vOriginPos = self.vOriginPos,
			vOriginDistance = self.vOriginDistance,
			vOriginDistMax = self.vOriginDistMax,
			vTargetPos = self.vTargetPos,
			vSpawnHeight = self.vSpawnHeight,
			vTargetHeight = self.vTargetHeight,
			vTurnPreference = self.vTurnPreference,
			vWalkReady = false,
			vDigReady = false,
			
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
			
			-- trading
			vID = self.vID,
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


-- main villager spawning function
local function spawnVillager(pos, building_type, region)
	
	-- SPAWN THE ACTUAL VILLAGER ENTITY!!!!
	local objectRef = minetest.add_entity(pos, "villagers:villager")
	local luaEntity = objectRef:get_luaentity()
	
	--get GENDER and save to 'vGender' object custom field
	local gender = "male"
	if math.random(villagers.plots[building_type].female) == 1 then
		gender = "female"
	end
	luaEntity.vGender = gender
	
	--get AGE and save to 'vAge' object custom field
	local age_chance = villagers.plots[building_type].age
	local age = age_chance[math.random(#age_chance)]
	luaEntity.vAge = age
	
	--get NAME and save to 'vName' object custom field
	if region == "native" then
		luaEntity.vName = getVillagerName(gender, region)
	elseif region == "desert" then
		luaEntity.vName = getVillagerName(gender, region)
	else
		if age == "young" then
			luaEntity.vName = getVillagerName(gender, age)
		else
			luaEntity.vName = getVillagerName(gender)
		end
	end
	
	--get TEXTURE, VISUAL SIZE, and COLLISION BOX and apply it to corresponding entity properties
	local newTexture, newSize, collisionBox = getVillagerAppearance(building_type, region, gender, age)
	objectRef:set_properties({textures={newTexture}})
	objectRef:set_properties({visual_size={x=newSize,y=newSize}})
	objectRef:set_properties({collisionbox=collisionBox})	
	objectRef:set_properties({infotext=
		luaEntity.vName.." ("..building_type..")\n"..
		age.." "..gender.."\n"..
		region.." region"
	})	
		
	--[[ NOTE ABOUT ALL THE DIFFERENT POSITIONS:
		'vPos' Tracks the current position of the villager. Also represents a valid spawn position.
		
		'originPos' Tracks the original spawn point of the villager. Upon first-time spawn, vPos
		and originPos is the same value. The Y value of originPos/vPos is used when villager is
		recalibrated via setpos() whenever the villager completes a WALK routine via walkVillager().
		This Y value is important because it takes into account the differing model scale and collisionbox size.
		This parameter is also used to calculate total distance from original spawn point to current position.
		
		'targetPos' Tracks the pos of the node that verifyPath() has last examined. This is
		not a valid spawn point as the Y coordinate points to the node position corresponding to the
		villagers legs, and does not account for model size and collisionbox size of each different
		sized villager. targetPos is also used to determine/calculate the pos at head and pos 
		below the feet.
	--]]
		
	local pos = objectRef:getpos()
	luaEntity.vSpawnHeight = pos.y
	luaEntity.vTargetHeight = luaEntity.vSpawnHeight - 0.5
	
	--set final position that takes into account calc'd collision_box 
	-- that was based on dynamic visual_size
	pos.y = pos.y - (1-newSize)
	objectRef:setpos(pos)
	luaEntity.vPos = {x=pos.x,y=pos.y,z=pos.z}
	luaEntity.vOriginPos = {x=pos.x,y=pos.y,z=pos.z}
	luaEntity.vTargetPos = {x=pos.x, y=luaEntity.vTargetHeight, z=pos.z}
	
	-- randomly set how often in seconds that this villager will
	-- check to do a different action
	luaEntity.vActionFrequency = math.random(4,6)
	
	--overlay applied entity new properties to custom fields
	local prop = objectRef:get_properties()
	luaEntity.vTexture = prop.textures[1]
	luaEntity.vSize = prop.visual_size
	luaEntity.vBox = prop.collisionbox
	luaEntity.vType = building_type
	luaEntity.vRegion = region
	
	-- copy chat dialogue scripts from villagers.chat global var
	-- and save it into villager entity for more quicker access
	local copy_of_hi_scripts = copytable(villagers.chat[building_type].greetings)
	local copy_of_bye_scripts = copytable(villagers.chat[building_type].goodbyes)
	local copy_of_chat_scripts = copytable(villagers.chat[building_type].mainchat)
	local copy_of_gtg_scripts = copytable(villagers.chat.gtg)
	local copy_of_smalltalk_scripts = copytable(villagers.chat.smalltalk)
	getRandomChatText(luaEntity, copy_of_hi_scripts, "vScriptHi", 3)
	getRandomChatText(luaEntity, copy_of_bye_scripts, "vScriptBye", 3)
	getRandomChatText(luaEntity, copy_of_chat_scripts, "vScriptMain", 3)
	getRandomChatText(luaEntity, copy_of_gtg_scripts, "vScriptGtg", 3)
	getRandomChatText(luaEntity, copy_of_smalltalk_scripts, "vScriptSmalltalk", 3)
	
	-- use for villager trading with formspec formhandler callback
	luaEntity.vID = luaEntity.vName .. tostring(math.random(9999))
	
	-- position of nodemeta for inventory trading
	luaEntity.vNodeMetaPos = {x=pos.x, y=luaEntity.vTargetHeight-1, z=pos.z}
	
	-- generate list of items this villager will trade depending on building_type
	-- setTradeInventory(luaEntity, "sell")
	-- setTradeInventory(luaEntity, "buy")
	
	--set a random default yaw and facing direction
	local random_num = math.random(8)
	objectRef:setyaw(YAWS[random_num])
	luaEntity.vYaw = objectRef:getyaw()
	luaEntity.vFacingDirection = DIRECTIONS[random_num]
	
	luaEntity.object:set_animation(
		{x=luaEntity.animation["stand_start"], y=luaEntity.animation["stand_end"]},
		luaEntity.animation_speed + math.random(10)
	)

	-- debugging
	luaEntity.vTextureString = newTexture

	return luaEntity
	
end




-- for use by chat command to manually spawn a villager
local function validateBuildingType(building_type)

	local is_valid = false
	if building_type then
		for key,_ in pairs(villagers.plots) do
			if key == building_type then
				is_valid = true
			end
		end
	end
	
	if is_valid then
		-- building_type was valid, so return that back
		return building_type
	else
		local bTypes = {}
		for key,_ in pairs(villagers.plots) do
			table.insert(bTypes, key)
		end
		
		local random_btype = bTypes[math.random(#bTypes)]
		return random_btype
	end
end

-- for use by chat command to manually spawn a villager
local function validateRegion(region)

	local REGION_TYPES = { "hot", "cold", "normal", "desert", "native" }
	local is_valid = false
	if region then
		for i=1, #REGION_TYPES do
			if REGION_TYPES[i] == region then
				is_valid = true
			end
		end
	end
	
	if is_valid then
		-- building_type was valid, so return that back
		return region
	else
		if region then
			--print("  REGION INVALID: "..region..". Getting random one..")
		else
			--print("  REGION is NIL. Getting random one..")
		end
		
		local random_region = REGION_TYPES[math.random(#REGION_TYPES)]
		return random_region
	end
end

-- manually spawn villager via chat command. mostly for testing.
minetest.register_chatcommand("v", {
	params = "<building_type> <region>",
	description = "Spawn Villager",
	privs = {},	
	func = function(name, param)
		
		local admin = minetest.check_player_privs(name, {server=true})
		if admin then
			local player = minetest.get_player_by_name(name)
			local entity_name = "villagers:villager"
			local pos = player:getpos()
			pos.y = pos.y + 1.0
			
			local params = string.split(param, " ")	
			spawnVillager(pos, entity_name, validateBuildingType(params[1]), validateRegion(params[2]))
		else
			--print(" ERROR - Must be admin to run command.")
		end
	end,
})





-- spawn traders in villages
mg_villages.part_of_village_spawned = function( village, minp, maxp, data, param2_data, a, cid )
	
	if not( minetest.get_modpath( 'mg_villages')) then
		--io.write("ERROR: mg_villages mob is not installed.")
		return
	end

	-- different village types determine region type (climate)
	-- which determines type of clothing villager will wear
	local village_type  = village.village_type;
	local region_type
		
	-- included in mg_villages
	if village_type == "nore" then
		region_type = "normal"
		
	elseif village_type == "taoki" then
		region_type = "normal"
	
	-- included in 'cottages' mod
	elseif village_type == "medieval" then
		region_type = "normal"
		
	elseif village_type == "charachoal" then
		region_type = "native"
		
	elseif village_type == "lumberjack" then
		region_type = "cold"
		
	elseif village_type == "claytrader" then
		region_type = "desert"
		
	elseif village_type == "logcabin" then
		region_type = "cold"
		
	--elseif village_type == "grasshut" then
	--	region_type = "native"
		
	elseif village_type == "tent" then
		region_type = "hot"
		
		
	-- single lone buildings
	elseif village_type == "tower" then
		region_type = "normal"
		
	elseif village_type == "chateau" then
		region_type = "normal"
		
	elseif village_type == "forge" then
		region_type = "hot"
		
	elseif village_type == "tavern" then
		region_type = "normal"
		
	elseif village_type == "well" then
		region_type = "native"
		
	elseif village_type == "trader" then
		region_type = "desert"
		
	elseif village_type == "sawmill" then
		region_type = "cold"
		
	elseif village_type == "farm_tiny" then
		region_type = "normal"
		
	elseif village_type == "farm_full" then
		region_type = "normal"
		
	elseif village_type == "single" then
		region_type = "normal"
		
		
	-- included in 'village_sandcity'
	elseif village_type == "sandcity" then
		region_type = "desert"
		
		
	-- included in 'village_gambit'
	elseif village_type == "gambit" then
		region_type = "native"
		
		
	-- included in 'village_towntest'
	elseif village_type == "cornernote" then
		region_type = "normal"
		
	else
		print("\n## ERROR Invalid village_type="..village_type)
	end
		
	-- for each building in the village
	for i,bpos in pairs(village.to_add_data.bpos) do
		
		-- get data about the building
		local building_data = mg_villages.BUILDINGS[ bpos.btype ];
		
		local bpos_str = minetest.pos_to_string({x=bpos.x, y=bpos.y, z=bpos.z})
		local error_message
		local nodename, distance
		local existing_villager_name
		local spawn_position
		
		local function getDistance(pos1, pos2)			
			local mult = 10
			return math.floor(vector.distance(pos1, pos2) * mult + 0.5) / mult
		end
		
		local function villagerAlreadySpawned()
			if bpos.traders then
				existing_villager_name = bpos.traders
				return true
			else
				return false
			end
		end
		
		local function locationOutOfRange()
			
			-- how many players are out of range
			local count = 0
			
			-- cycle through all connected players
			for _,player in ipairs(minetest.get_connected_players()) do
				if player ~= nil then			
					
					-- calculate distance between villager spawn position and current player position
					local distance = getDistance(player:getpos(), {x=bpos.x, y=bpos.y, z=bpos.z})
					if distance > 50 then 
						count = count + 1 
					end
					
				else 
					--io.write("noPlayersToCheckRange ") 
				end
			end
			
			if count > 0 then return true
			else return false end
		end
		
		local function notBuildingLocation()
			if (building_data and building_data.typ) then
				return false
			else
				return true
			end
		end
		
		local function invalidLocation()
			if bpos.x > maxp.x then
				error_message = "bpos.x("..bpos.x..") > maxp.x("..maxp.x..")"
				return true
			elseif (bpos.x + bpos.bsizex) < minp.x then
				error_message = "bpos.x("..bpos.x..") + bpos.bsizex("..bpos.bsizex..") < minp.x("..minp.x..")" 
				return true
			elseif bpos.z > maxp.z then
				error_message = "bpos.z("..bpos.z..") > maxp.z("..maxp.z..")"
				return true
			elseif (bpos.z + bpos.bsizez) < minp.z then
				error_message = "bpos.z("..bpos.z..") + bpos.bsizez("..bpos.bsizez..") < minp.z("..minp.z..")"
				return true
			else
				return false
			end
		end
		
		local function validateSpawnPosition(pos, checkNodeBelowVillager)
			local node_name = getNodeName(pos)[2]
			local result = {["pos"]=pos, ["name"]=node_name, ["result"]=false}
			local nodeIsWalkable = minetest.registered_nodes[getNodeName(pos)[1]].walkable
			local nodeIsLiquid = false
			local nodeIsSnow = false
			
			-- check if node is a liquid
			if string.find(node_name, "WATER") then
				nodeIsLiquid = true
			elseif string.find(node_name, "LAVA") then
				nodeIsLiquid = true
			elseif string.find(node_name, "SNOW") then
				nodeIsSnow = true
			end
			
			-- verifying node below villager's feet
			if checkNodeBelowVillager then
				if nodeIsWalkable then
					--io.write("[OK!] ")
					result.result = true
				else
					--io.write("[invalid] ")
				end
				
			-- verifying node at villager's upper or lower body
			else
				--if node_name == "AIR" then
				--	result.result = true
				if node_name == "IGNORE" then
					--io.write("[invalid] ")
				elseif nodeIsSnow then
					--io.write("[SNOW OK!] ")
					result.result = true
				elseif nodeIsWalkable then
					--io.write("[blocked] ")
				elseif nodeIsLiquid then
					--io.write("[liquid] ")
				else 
					--io.write("[OK!] ")
					result.result = true
				end
			end
			
			return result
		end
		
		-- skip spawn if villager already spawned previously
		if villagerAlreadySpawned() then
			--io.write("Already spawned "..string.upper(existing_villager_name).." near "..bpos_str)
		
		-- skip spawn if this building location is not a building plot (eg road, street)
		elseif notBuildingLocation() then 
			--io.write("Not a building plot: "..bpos_str)
			
		-- skip spawn if this building location is too far away from player
		elseif locationOutOfRange() then
			--io.write("Distance to "..building_data.typ.." "..bpos_str.." too far: "..distance)
			
		else
			--io.write("Location OK! "..bpos_str)
			
			local validSpawnPosFound = false
			local valid_spawn_pos
			
			-- At each position surrounding initial building spawn location, inspect a 
			-- column of 3 vertical nodes: below villagers feet, at lower body, and at upper body.
			-- If all three nodes are a valid spawn point, then spawn villager there.
			for direction, spawn_pos in pairs(NODE_AREA) do
				
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
				--io.write("VALID SPAWN POS FOUND! "..building_data.typ.." "..region_type.." ")
				
				-- calculate villager spawn position
				local spawn_pos = {x=valid_spawn_pos[1], y=bpos.y+1.5, z=valid_spawn_pos[2]}
				local spwan_pos_str = minetest.pos_to_string(spawn_pos,1)
				
				-- spawn the actual villager entity
				local luaEntity = spawnVillager(spawn_pos, building_data.typ , region_type)
				
				-- everything below is just for debug output -------
				local vName = luaEntity.vName
				local vPosStr = minetest.pos_to_string(luaEntity.vPos,1)
				local vOriginPosStr = minetest.pos_to_string(luaEntity.vOriginPos,1)
				
				local target_pos = {x=luaEntity.vTargetPos.x, y=luaEntity.vTargetPos.y, z=luaEntity.vTargetPos.z}
				local vTargetPosStr = minetest.pos_to_string(target_pos, 1)
				target_pos.y = target_pos.y - 1
				local nodename = getNodeName(target_pos)[2]
				
				--io.write("## SPAWNED on "..nodename.." ## "..vName.." ")
				--io.write("actualPos"..vPosStr.." origin"..vOriginPosStr.." target"..vTargetPosStr.." ")
				
				-- preliminary code for villager trading behavior
				minetest.after(3, function() 
					-- node metadata for trading inventory
					local meta = minetest.get_meta(luaEntity.vNodeMetaPos)
					local inv = meta:get_inventory()
					inv:set_size("main", 9)
					--local stack = ItemStack("default:apple 1")
					--local extra = inv:add_item("main", stack)
				end)
				
				local traders = {village_type.."_"..building_data.typ.."_villager_"..i}
				village.to_add_data.bpos[ i ].traders = vName
			else
				--io.write("\n      Giving up spawn posistion search...")
			end
			
			
		end
		
	end --end for loop

end
