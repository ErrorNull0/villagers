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
	vSchem = "UNASSIGNED",
	vRegion = "UNASSIGNED",
	vHudIds = {},
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
	vID = nil,
	vIsTrader = false,
	vTrading = nil,
	vNodeMetaPos = {x=0,y=0,z=0},
	vBuy = {},
	vSell = {},
	
	-- debugging
	vTextureString = nil,
	
	on_activate = function(self, staticdata, dtime_s)
		
		if villagers.log then io.write("\nACTIVATE ") end
			
		-- perform default action, whichi is standing idle animation
		villagers.standVillager(self)
		
		if staticdata ~= "" then
			if villagers.log then io.write("(existing) ") end
			local customFields = minetest.deserialize(staticdata)
			self.object:set_properties({textures={customFields.vTexture}})
			self.object:set_properties({visual_size=customFields.vSize})
			self.object:set_properties({collisionbox=customFields.vBox})
			self.object:set_properties({infotext=customFields.vInfo})
			self.object:set_properties({hp_max=customFields.vHP})
			self.object:setpos(customFields.vPos)
			self.object:set_yaw(customFields.vYaw)
			
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
			self.vSchem = customFields.vSchem
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
			self.vBedPos = customFields.vBedPos
			self.vDoorPos = customFields.vDoorPos
			self.vJobPos = customFields.vJobPos
			
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
			self.vScriptGameFacts = customFields.vScriptGameFacts
			self.vScriptGameFactsSaved = customFields.vScriptGameFactsSaved
			
			
			-- trading
			self.vID = customFields.vID
			self.vIsTrader = customFields.vIsTrader
			self.vTrading = nil
			self.vNodeMetaPos = customFields.vNodeMetaPos
			self.vBuy = customFields.vBuy
			self.vSell = customFields.vSell
			
			-- debugging
			self.vTextureString = customFields.vTextureString
			
			if villagers.log then io.write(string.upper(self.vName).." ") end
			
			if self.vDespawned then
				if villagers.log then io.write("vDespawned="..tostring(self.vDespawned).." ") end
			else
				if villagers.log then io.write("vDespawned=NIL ") end
			end
			
			local prior_saved_action = self.vAction
			if prior_saved_action == "STAND" then
				if villagers.log then io.write("loaded="..prior_saved_action.." ") end
			elseif prior_saved_action == "TURN" then 
				if villagers.log then io.write("loaded="..prior_saved_action.." ") end
			elseif prior_saved_action == "DIG" then
				if villagers.log then io.write("loaded="..prior_saved_action.." ") end
				if villagers.log then io.write("set_vAction=RESUMEDIG ") end
				self.vAction = "RESUMEDIG"
			elseif prior_saved_action == "REPLACE" then
				if villagers.log then io.write("loaded="..prior_saved_action.." ") end
				if villagers.log then io.write("set_vAction=RESUMEDIG ") end
				self.vAction = "RESUMEDIG"
			elseif prior_saved_action == "WALK" then
				if villagers.log then io.write("loaded="..prior_saved_action.." ") end
			elseif prior_saved_action == "WALKING" then
				if villagers.log then io.write("loaded="..prior_saved_action.." ") end
				if villagers.log then io.write("set_vAction=WALK ") end
				self.vAction = "WALK"
				self.object:setvelocity({x=0,y=0,z=0})
			elseif prior_saved_action == "TURNBACK" then
				if villagers.log then io.write("loaded="..prior_saved_action.." ") end
			elseif prior_saved_action == "WALKBACK" then
				if villagers.log then io.write("loaded="..prior_saved_action.." ") end
			elseif prior_saved_action == "CHAT" or prior_saved_action == "ENDCHAT" then
				if villagers.log then io.write("loaded="..prior_saved_action.." ") end
				if villagers.log then io.write("set_vAction=STAND ") end
				self.vAction = "STAND"
			elseif prior_saved_action == "TRADE" or prior_saved_action == "ENDTRADE" then
				if villagers.log then io.write("loaded="..prior_saved_action.." ") end
				if villagers.log then io.write("set_vAction=STAND ") end
				self.vAction = "STAND"
			else
				if villagers.log then io.write("ERROR vAction="..prior_saved_action.." ") end
			end
			
		else
			if villagers.log then io.write("(new) "..string.upper(self.vName).." ") end
		end
		
		if villagers.log then io.write("onActivateEND. ") end
		
	end,
	
	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		villagers.on_leftclick(self, puncher, time_from_last_punch)
	end,
	
	on_rightclick = function(self, clicker)
		villagers.on_rightclick(self, clicker)		
	end,
	
	on_step = function(self, dtime)
		villagers.on_step(self, dtime)
	end, -- on_step function

	
	get_staticdata = function(self)
		if villagers.log then io.write("\nGETSTATIC("..self.vName..") ") end
		-- save all custom fields
		
		if self.vDespawned == false then
			if villagers.log then io.write("DESPAWNED vAction="..self.vAction.."\n") end
		else
			self.vDespawned = false
			if villagers.log then io.write("SPAWNED ") end
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
			vSchem = self.vSchem,
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

-- main villager spawning function
function villagers.spawnVillager(pos, region, village_type, building_type, schem_type, trading_allowed, yaw_data, bed_data)
	
	if villagers.log5 then io.write("\n      spawnVillager() ") end
	
	if villagers.log5 then 
		io.write("buildType="..building_type.." ")
		if schem_type then
			io.write("schemType="..schem_type.." ") 
		else
			io.write("schemType=NIL ") 
		end
	end
	
	-- SPAWN THE ACTUAL VILLAGER ENTITY!!!!
	local objectRef = minetest.add_entity(pos, "villagers:villager")
	local self = objectRef:get_luaentity()	
	
	--get GENDER and save to 'vGender' object custom field
	local gender = "male"
	if math.random(villagers.plots[building_type].female) == 1 then
		gender = "female"
	end
	self.vGender = gender
	
	--get AGE and save to 'vAge' object custom field
	local age_chance = villagers.plots[building_type].age
	local age = age_chance[math.random(#age_chance)]
	self.vAge = age
	
	--get NAME and save to 'vName' object custom field
	if region == "native" then
		self.vName = villagers.getVillagerName(gender, region)
	elseif region == "desert" then
		self.vName = villagers.getVillagerName(gender, region)
	else
		if age == "young" then
			self.vName = villagers.getVillagerName(gender, age)
		else
			self.vName = villagers.getVillagerName(gender)
		end
	end
	
	--get TEXTURE, VISUAL SIZE, and COLLISION BOX and apply it to corresponding entity properties
	local newTexture, newSize, collisionBox = villagers.getVillagerAppearance(building_type, region, gender, age)
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
	self.vType = building_type
	self.vRegion = region
	
	-- copy chat dialogue scripts from villagers.chat global var
	-- and save it into villager entity for more quicker access	
	villagers.getRandomChatText(self, villagers.copytable(villagers.chat[building_type].greetings), "vScriptHi", 3)
	villagers.getRandomChatText(self, villagers.copytable(villagers.chat[building_type].goodbyes), "vScriptBye", 3)
	villagers.getRandomChatText(self, villagers.copytable(villagers.chat[building_type].mainchat), "vScriptMain", 3)
	villagers.getRandomChatText(self, villagers.copytable(villagers.chat.gtg), "vScriptGtg", 3)
	villagers.getRandomChatText(self, villagers.copytable(villagers.chat.smalltalk), "vScriptSmalltalk", 3)
	villagers.getRandomChatText(self, villagers.copytable(villagers.chat.gamefacts), "vScriptGameFacts", 2)
	
	-- use for villager trading with formspec formhandler callback
	self.vID = self.vName .. tostring(math.random(9999))
	
	-- position of nodemeta for inventory trading
	self.vNodeMetaPos = {x=pos.x, y=self.vTargetHeight-1, z=pos.z+1}
	
	-- generate list of items this villager will trade depending on building_type
	if trading_allowed == 1 then
		self.vSell = villagers.getTradeInventory(self, village_type, schem_type, "sell")
	elseif trading_allowed == 2 then
		self.vSell = villagers.getTradeInventory(self, village_type, schem_type, "smalljobs")
		if villagers.log5 then io.write("\n      ## Smalljobs trader! ## ") end
	else
		self.vSell = "none"
	end
	
	-- set door position
	self.vDoorPos = {x=pos.x, y=pos.y, z=pos.z} -- will change once true door pos is found
	
	-- prepare infotext
	local infotext_string = ""

	if self.vIsTrader then
		infotext_string = infotext_string.. "** TRADER **\n"
	end

	infotext_string = infotext_string..string.upper(self.vName).." @ "..building_type.." ("..schem_type..")\n".. 
		self.vAge.." "..self.vGender.. " in "..region.." region\n".. 
		"door("..self.vDoorPos.x..","..self.vDoorPos.y..","..self.vDoorPos.z..")"
	
	-- set bed position
	if bed_data then
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

	return self
	
end

local function spawnOnBedPlot(bpos, region_type, village_type, building_type, schem_type, village_posx, village_posz)
	
	if villagers.log5 then io.write("spawnRes() ") end
	
	local building_pos = {x=bpos.x, y=bpos.y, z=bpos.z}
	local beds_data = bpos.beds
	local beds_count = #beds_data
	if beds_count > 0 then
		
		-- for each bed in the building
		for bed_index = 1, beds_count do
			if villagers.log5 then io.write("\n    spawn_pos #"..bed_index.." ") end
			
			-- ensure only one villager (the first one) from a village and schem type
			-- that can trade goods, will actually have goods to trade. This prevents
			-- all villagers belonging a single farm for example being able to trade.
			local trading_allowed = 0
			if bed_index == 1 and villagers.ITEMS[village_type][schem_type] then
				trading_allowed = 1
			
			-- each building with a bed plot will have 33% chance that the last bed will
			-- correspond to a villager that gives players coins for small resources.
			-- this is a way for players to get started on accumulating some coins.
			elseif bed_index == beds_count and (math.random(3) == 1) then
				trading_allowed = 2
			end
			
			local mob_spawner_data = handle_schematics.get_pos_in_front_of_house(bpos, bed_index)
			local mob_spawner_pos = {x=mob_spawner_data.x, y=mob_spawner_data.y, z=mob_spawner_data.z}
			if villagers.log5 then io.write(minetest.pos_to_string(mob_spawner_pos).." ") end
			
			-- if any trader has already spawned for this building AND a villager already
			-- spawned in that specific spawn location 'bed_index' then skip.
			if bpos.traders and bpos.traders[bed_index] then
				if villagers.log5 then io.write(bpos.traders[bed_index].." already spawned @ "..minetest.pos_to_string(mob_spawner_pos).." ") end
				
			-- villager not yet spawned
			else
				
				-- count how many players are in range of this mob spawner position
				local players_in_range = 0
				for _,player in ipairs(minetest.get_connected_players()) do
					if player then			
						-- calculate distance between this spawner position and current player position
						local distance =  math.floor(vector.distance(player:getpos(), mob_spawner_pos) * 10 + 0.5) / 10
						if distance < 50 then 
							players_in_range = players_in_range + 1
							if villagers.log5 then io.write("PlayerInRange ") end
						else 
							if villagers.log5 then io.write("PlayerOutOfRange ") end
						end
					else
						if villagers.log5 then io.write("PlayerDespawned ") end
					end
				end
				
				-- no players are near the mob spawner location. skip spawn.
				if players_in_range == 0 then 
					if villagers.log5 then io.write("No players in range of spawn location: "..minetest.pos_to_string(mob_spawner_pos).." ") end
					
				-- at least one player is near the spawn location. continue spawn.
				else
						
					-- first villager in this building
					local villager_number
					if bpos.traders == nil then
						bpos.traders = {} 
						villager_number = 1
					else
						villager_number = #bpos.traders + 1
					end
						
						
					-- spawn the villager
					mob_spawner_pos.y = mob_spawner_pos.y + 0.5
					if villagers.log5 then 
						io.write("pos"..minetest.pos_to_string(mob_spawner_pos).." ")
						io.write("type="..building_type.." ")
						io.write("scm="..schem_type.." ")
						io.write("region="..region_type.." ")
					end
					local luaEntity = villagers.spawnVillager(mob_spawner_pos, region_type, village_type, building_type, schem_type, trading_allowed, mob_spawner_data.yaw, beds_data[bed_index])
					if villagers.log5 then io.write("** SPAWNED!! "..luaEntity.vName.." "..luaEntity.vGender.." "..luaEntity.vAge.." ") end
					
					--setTradingMeta(luaEntity)  -- set metadata for later formspec use
					
					local villager_descriptor = "("..village_posx..","..village_posz..") "..
					minetest.pos_to_string(building_pos).." "..minetest.pos_to_string(mob_spawner_pos)
					
					
					local traders = {villager_descriptor}
					bpos.traders[bed_index] = luaEntity.vName
					
				end
				
			end
			
		end
	else
		--io.write("notLivingStructure ")
	end

end

local function spawnOnJobPlot(bpos, region_type, village_type, building_type, schem_type, minp, maxp)
	
	if villagers.log5 then io.write("spawnNonRes() ") end
	
	local function getDistance(pos1, pos2)			
		local mult = 10
		return math.floor(vector.distance(pos1, pos2) * mult + 0.5) / mult
	end
	
	local existing_villager_name
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
				if villagers.log5 then io.write("noPlayersExist ") end
			end
		end
		
		if count > 0 then return true
		else return false end
	end
	
	--[[
	local function notBuildingLocation()
		if building_type then return false 
		else return true end
	end
	--]]
	
	local error_message
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
	
	if villagers.log5 then io.write("\n    spawn_pos #1 "..bpos_str.." ") end
	
	if villagerAlreadySpawned() then -- villager already spawned, skip.
		if villagers.log5 then io.write(existing_villager_name.." already spawned @ "..bpos_str.." ") end
	
	--elseif notBuildingLocation() then -- not a building structure, but a road, etc.
	--	if villagers.log5 then io.write("Not a building plot: "..bpos_str.." ") end
		
	elseif locationOutOfRange() then -- plot is too far away from player, skip.
		if villagers.log5 then io.write("Distance to "..building_type.." "..bpos_str.." too far. ") end
		
	else
		if villagers.log5 then io.write("Location OK so far. "..bpos_str.." ") end
		
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
			if villagers.log5 then io.write("VALID SPAWN POS FOUND! ") end
			
			-- calculate villager spawn position
			local spawn_pos = {x=valid_spawn_pos[1], y=bpos.y+1.5, z=valid_spawn_pos[2]}
			local spwan_pos_str = minetest.pos_to_string(spawn_pos,1)
			
			if villagers.log5 then 
				io.write("pos"..minetest.pos_to_string(spawn_pos).." ")
				io.write("type="..building_type.." ")
				io.write("scm="..schem_type.." ")
				io.write("region="..region_type.." ")
			end
			
			-- spawn the actual villager entity
			local trading_allowed = 1
			local luaEntity = villagers.spawnVillager(spawn_pos, region_type, village_type, building_type, schem_type, trading_allowed)
			local vName = luaEntity.vName
			
			--setTradingMeta(luaEntity) -- set metadata for later formspec use
			
			local traders = {vName.."_"..math.random(1000)}
			bpos.traders = vName
		else
			if villagers.log5 then io.write("Spawn POS blocked. Retry next cycle. ") end
		end
		
	end
	
end

-- spawn traders in villages
mg_villages.part_of_village_spawned = function( village, minp, maxp, data, param2_data, a, cid )
	
	if not( minetest.get_modpath( 'mg_villages')) then
		--io.write("ERROR: mg_villages mob is not installed.")
		return
	end

	local snowCover = village.artificial_snow
	local village_type  = village.village_type
	
	-- debug output
	if villagers.log5 then
		io.write("\n## ")
		io.write("village loc("..village.vx..","..village.vz..") ")
		io.write("type="..village_type.." ")
		io.write("radius="..village.vs.." ")
		io.write("height="..village.vh.." ")
		io.write("snow="..tostring(snowCover).." ")
		io.write("buildings="..#village.to_add_data.bpos.." ")
	end
	
	-- different village types determine region type (climate)
	-- which determines type of clothing villager will wear
	local region_type
		
	if snowCover == 1 then
		region_type = "cold"
		
	-- included in mg_villages
	elseif village_type == "nore" then region_type = "normal"
	elseif village_type == "taoki" then region_type = "normal"
	
	-- included in 'cottages' mod
	elseif village_type == "medieval" then region_type = "normal"
	elseif village_type == "charachoal" then region_type = "native"
	elseif village_type == "lumberjack" then region_type = "cold"
	elseif village_type == "claytrader" then region_type = "desert"
	elseif village_type == "logcabin" then region_type = "cold"
	
	-- ** Currently untested for 'grasshut' village type
	-- as it requires biome_lib mod
	elseif village_type == "grasshut" then region_type = "native" 
	
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
		
		if villagers.log5 then
			io.write("\n  building #"..building_index.." ")
			io.write("loc"..minetest.pos_to_string(building_pos).." ")
			io.write("type_id="..bpos.btype.." ")
			
			
			if bpos.btype ~= "road" then
				io.write("scm="..dump(building_scm).." ")
				io.write("type="..building_type.." ")
				io.write("beds="..#bpos.beds.." ")
			end
		end
		
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
			building_type == "trader" then
			spawnOnBedPlot(bpos, region_type, village_type, building_type, building_data.scm, village.vx, village.vz)
		else
			spawnOnJobPlot(bpos, region_type, village_type, building_type, building_data.scm, minp, maxp)
		end
		
		
	end --end for loop
	--io.write("\n")
end