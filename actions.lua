
-- ====================================== VILLAGER ACTIONS ================================================
-- ========================================================================================================

-- SUPPORTING FUNCTIONS --

-- verify weather current target position is a valid spot for villager to walk
function targetClear(self)
		
	local pos = {x=self.vTargetPos.x, y=self.vTargetPos.y, z=self.vTargetPos.z}
	local nodenames

	--check vertical pos at villager's lowerbody
	nodenames = villagers.getNodeName({x=pos.x, y=pos.y, z=pos.z})
	if villagers.log then io.write("\n  - "..nodenames[2]) end
	if minetest.registered_nodes[nodenames[1]].walkable then
		if villagers.log then io.write("[fail] ") end
		return false
	else
		if villagers.log then io.write("[OK] ") end
	end
	
	--check vertical pos at villager's upperbody
	nodenames = villagers.getNodeName({x=pos.x, y=pos.y+1, z=pos.z})
	if villagers.log then io.write(nodenames[2]) end
	if minetest.registered_nodes[nodenames[1]].walkable then
		if villagers.log then io.write("[fail] ") end
		return false
	else
		if villagers.log then io.write("[OK] ") end
	end
	
	--check vertical pos below villager's feet
	nodenames = villagers.getNodeName({x=pos.x, y=pos.y-1, z=pos.z})
	local nodename = nodenames[2]
	if villagers.log then io.write(nodenames[2]) end
	if string.find(nodename, "WATER") or string.find(nodename, "LAVA") or string.find(nodename, "AIR") then
		if villagers.log then io.write("[fail] ") end
		return false
	else
		if villagers.log then io.write("[OK] ") end
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
	
	local new_yaw = villagers.YAWS[new_yaw_index]
	self.vFacingDirection = villagers.DIRECTIONS[new_yaw_index]

	self.vYaw = new_yaw
	self.object:set_yaw(new_yaw)
end

local function posHasObject(pos)
	local objects = minetest.get_objects_inside_radius(pos, 0.8)
	local object_count = #objects
	local return_bool
	if object_count > 0 then
		
		for n = 1, #objects do
			if objects[n]:is_player() then
				if villagers.log then io.write("foundPlayer["..objects[n]:get_player_name().."] ") end
			else
				local luaentity = objects[n]:get_luaentity()
				if luaentity.vName then
					if villagers.log then io.write("foundVillager["..luaentity.vName.."] ") end
				else
					if villagers.log then io.write("foundEntity ") end
				end
				local pos = objects[n]:get_pos()
				if villagers.log then io.write("("..pos.x..","..pos.z..") ") end
			end
			
		end
		
		return_bool = true
	else
		if villagers.log then io.write("targetPosNoEntity ") end
		return_bool = false
	end
	return return_bool
end

-- MAIN VILLAGER ACTIONS

-- stand idle
function villagers.standVillager(self)
	if villagers.log then io.write("stand() ") end
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
	if villagers.log then io.write("turn() ") end
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
	
	if villagers.log then io.write("nowFacing="..self.vFacingDirection.." ") end
end

local function walkVillagerEnd(self)
	if villagers.log then io.write(string.upper(self.vName).." ") end
	
	-- stop villager and show standing anim. villager should
	-- now be standing at or near the target position
	self.object:setvelocity({x=0,y=0,z=0})
	self.object:set_animation(
		{x=self.animation["stand_start"], y=self.animation["stand_end"]},
		self.animation_speed + math.random(10)
	)
	self.vAction = "STAND"
	
	-- update total distance travelled by villager
	local travelDistance = vector.distance(self.vPos, {x=self.vTargetPos.x, y=self.vPos.y, z=self.vTargetPos.z})
	self.vTotalDistance = self.vTotalDistance + travelDistance
	
	-- teleport villager to exact target position to makeup for any
	-- discrepencies in movement time and distance
	self.vPos.x = self.vTargetPos.x
	self.vPos.z = self.vTargetPos.z
	self.object:set_pos(self.vPos)
	
	-- update villager pathfinding parameters for next walk attempt
	local newOriginDist = villagers.round(vector.distance(self.vOriginPos, self.vPos),1)
	self.vOriginDistance = newOriginDist			
	
	if newOriginDist < self.vOriginDistMax then
		
	else
		self.vAction = "TURNBACK"
		if villagers.log then io.write("DistMaxed set_vAction=TURNBACK ") end
	end
	if villagers.log then io.write("originDist="..newOriginDist.." ") end
	
end

-- walk forward a specific number of blocks
local function walkVillager(self)
	if villagers.log then io.write("walk() ") end
	self.vAction = "WALKING"
	
	-- calculate velocity and direction
	local facing = self.vFacingDirection
	local x_velocity = villagers.NODE_AREA[facing][1]
	local z_velocity = villagers.NODE_AREA[facing][2]

	--move villager in the direction of target position
	self.object:setvelocity({x=x_velocity,y=0,z=z_velocity})

	--show walking animation
	self.object:set_animation(
		{x=self.animation["walk_start"], y=self.animation["walk_end"]},
		self.animation_speed + math.random(10)
	)
	
	local distance = villagers.round(vector.distance(self.vPos, {x=self.vTargetPos.x, y=self.vPos.y, z=self.vTargetPos.z}),1)
	
	--after 'distance' seconds, stop villager movement
	minetest.after(distance, function() 
		if villagers.log then io.write("\n  ** MTAFTER.WALK-ENDED("..distance..") ") end
		walkVillagerEnd(self)
		if villagers.log then io.write("MTAFTER_END **") end
	end)
	
	if villagers.log then io.write("mtAfterScheduled runIn: "..distance.."sec ") end
end

local function digVillager(self)
	local log = false
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
	local log = false
	if log then io.write("replace() ") end
	self.vAction = "REPLACE"
	
	local dugNodeData = villagers.getFacingNodeInfo(self, 3)
	local dugPosition = dugNodeData[1]
	local dugNodeName = dugNodeData[2]
	local dugNodeNickname = dugNodeData[3]	
	
	-- snow
	if dugNodeNickname == "SNOW" then		
		minetest.remove_node(dugPosition)
		
	-- grass
	elseif string.find(dugNodeNickname, "GRASS_") then
		if dugNodeNickname == "GRASS_1" then
			minetest.remove_node(dugPosition)
		else
			minetest.set_node(dugPosition, {name = "default:grass_1"})
		end
		
	-- cotton
	elseif dugNodeNickname == "COTTON_8" then
		minetest.set_node(dugPosition, {name = "farming:cotton_1"})
		
	-- wheat
	elseif dugNodeNickname == "WHEAT_8" then
		minetest.set_node(dugPosition, {name = "farming:wheat_1"})
		
	elseif string.find(dugNodeNickname, "FLOWER_") then
		minetest.set_node(dugPosition, {name = "default:grass_1"})
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
	if villagers.log then io.write("verify() ") end
	
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
	
	if villagers.log then 
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
		self.vTargetPos.x = self.vTargetPos.x + villagers.NODE_AREA[self.vFacingDirection][1]
		self.vTargetPos.z = self.vTargetPos.z + villagers.NODE_AREA[self.vFacingDirection][2]
		
		if targetClear(self) then
			if posHasObject(self.vTargetPos) then
			
			-- reset targetPos back to the previous node
				self.vTargetPos.x = self.vTargetPos.x - villagers.NODE_AREA[self.vFacingDirection][1]
				self.vTargetPos.z = self.vTargetPos.z - villagers.NODE_AREA[self.vFacingDirection][2]
				if i == 1 then
					facingDeadEnd = true
				end
				break
			else
				possibleWalkDistance = possibleWalkDistance + 1
			end
		else
			-- reset targetPos back to the previous node
			self.vTargetPos.x = self.vTargetPos.x - villagers.NODE_AREA[self.vFacingDirection][1]
			self.vTargetPos.z = self.vTargetPos.z - villagers.NODE_AREA[self.vFacingDirection][2]
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
			if villagers.log then io.write("walkBackBlocked waitAnotherCycle " ) end
			
		-- an entity is blocking the node directly in front
		-- of villager. simply have villager turn
		else
			if villagers.log then io.write("frontNodeBlocked ") end
			turnVillager(self)
		end
		
	elseif possibleWalkDistance > 0 then
		self.vAction = "WALK"
	end

end

-- turn villager 180 degrees and walk random distance back
local function turnBack(self)
	if villagers.log then io.write("turnBack() ") end
	self.vAction = "TURNBACK"
	
	local face_dir = self.vFacingDirection
	local new_facing_dir
	
	if face_dir == "N" then 
		new_facing_dir = "S"
		self.vYaw = villagers.YAWS[5]
	elseif face_dir == "E" then 
		new_facing_dir = "W"
		self.vYaw = villagers.YAWS[7]
	elseif face_dir == "S" then 
		new_facing_dir = "N"
		self.vYaw = villagers.YAWS[1]
	elseif face_dir == "W" then 
		new_facing_dir = "E"
		self.vYaw = villagers.YAWS[3]
	end
	
	-- update yaw to 180 degrees from prior yaw
	self.object:set_yaw(self.vYaw)
	self.vFacingDirection = new_facing_dir
	
	-- if villager despawns before executing below minetest.after() code
	-- then setting vAction to 'WALKBACK' ensures villager resumes 
	-- walking back 1 node upon respawn via verifyPath(self, 1, true)
	self.vAction = "WALKBACK"
	
	minetest.after(1.0, function() 
		if villagers.log then io.write("\n  ** mtAfter.walkBack(1) ") end
		verifyPath(self, 1, true)
		if villagers.log then io.write("MTAFTER_END **") end
	end)

end

local function randomAct(self)
	local log = false
	if log then io.write("randomAct() ") end
	
	local face_dir = self.vFacingDirection	
	if (face_dir == "N" or face_dir == "E" or face_dir == "S" or face_dir == "W") then
		if log then io.write(face_dir.." ") end
		local targetNode = villagers.getFacingNodeInfo(self)
		local tNodeName = targetNode[2]
		local tNodeNickname = targetNode[3]	
		local tNodeDrawtype = minetest.registered_nodes[tNodeName].drawtype
		
		if log then io.write(tNodeDrawtype.." "..tNodeNickname.." plot="..self.vType.." ") end
		
		-- air, ladders/signs, and torches
		if tNodeDrawtype == "airlike" or tNodeDrawtype == "signlike" or tNodeDrawtype == "torchlike" then
			-- villager can walk further distance from origin
			if self.vOriginDistance < self.vOriginDistMax then 
				local random_num = math.random(5)
				if random_num == 1 then turnVillager(self)
				elseif random_num == 2 then villagers.standVillager(self)
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
					elseif random_num == 2 then villagers.standVillager(self)
					else turnVillager(self) end
				end
			
			elseif tNodeNickname == "WHEAT_8" then
				if self.vType == "field" or self.vType == "farm_tiny" or self.vType == "farm_full" then
					self.vDigging = "wheat"
					digVillager(self)
				else
					local random_num = math.random(4)
					if random_num == 1 then verifyPath(self)
					elseif random_num == 2 then villagers.standVillager(self)
					else turnVillager(self) end
				end
				
			elseif tNodeNickname == "COTTON_1" or tNodeNickname == "WHEAT_1" then
				if self.vType == "field" or self.vType == "farm_tiny" or self.vType == "farm_full" then
					verifyPath(self, 1)
				else
					if math.random(2) == 1 then turnVillager(self)
					else villagers.standVillager(self) end
				end
				
			elseif tNodeNickname == "GRASS_1" or tNodeNickname == "GRASS_5" then
				local randomNum = math.random(6)
				if randomNum == 1 then turnVillager(self)
				elseif randomNum == 2 then villagers.standVillager(self)
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
				if randomNum == 1 then villagers.standVillager(self)
				elseif randomNum == 2 then verifyPath(self)
				else turnVillager(self) end
			end
			
		-- all other solid nodes
		elseif tNodeNickname == "SNOW" then
			if math.random(3) == 1 then 
				villagers.standVillager(self)
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
	local log = false
	if log then 
		--io.write("\nANIM ") 
		io.write(string.upper("\n"..self.vName).." ")
	end
	
	
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


function villagers.on_leftclick(self, clicker, time_from_last_punch)
	self.object:set_hp(15) -- don't let villager die from punches, for now........
	
	-- prevent chat if punched by non-player entity (mobs, weapons, etc.)
	if not clicker:is_player() then 
		--print("## Punched by non-player. No chat.") 
		return 
	end
	
	-- debugging
	if villagers.log3 then print("\n## "..self.vTextureString.."\n") end
	
	local current_action = self.vAction
	if villagers.log or villagers.log2 then io.write("vAction="..current_action.." ") end
	
	if current_action == "STAND" or current_action == "TURN" or current_action == "WALK" or
		current_action == "DIG" or current_action == "RESUMEDIG" then
		
		villagers.chatVillager(self, clicker)
		
	elseif current_action == "ENDCHAT" or current_action == "ENDTRADE" then
		local message_text = villagers.chat.busy[math.random(#villagers.chat.busy)]
		villagers.showMessageBubble(self, clicker, message_text, "FRONT", 1.5)
		
	elseif current_action == "CHAT" then
		if self.vChatting == clicker:get_player_name() then
		
			-- if player constantly click spams villager
			-- villager will not be able to 'understand' player
			if time_from_last_punch < 0.8 then
				villagers.showMessageBubble(self, clicker, villagers.chat.spam[math.random(#villagers.chat.spam)], "FRONT", 1)
			else
				villagers.chatVillager(self, clicker)
			end
		else
			local message_text = "I'm chatting with "..string.upper(self.vChatting).."\nOne moment.."
			villagers.showMessageBubble(self, clicker, message_text, "FRONT", 2)
		end
		
	elseif current_action == "TRADE" then
		local message_text = "I'm trading with "..string.upper(self.vTrading).."\nOne moment.."
		villagers.showMessageBubble(self, clicker, message_text, "FRONT", 2)
		
	-- villager will not chat if currently performing the
	-- below actions
	else
		local current_action = self.vAction
		if current_action == "WALKING" then
			local message_text = villagers.chat.walking[math.random(#villagers.chat.walking)]
			villagers.showMessageBubble(self, clicker, message_text, "FRONT", 1.5)
		elseif current_action == "WALKBACK" then
			local message_text = villagers.chat.walkback[math.random(#villagers.chat.walkback)]
			villagers.showMessageBubble(self, clicker, message_text, "FRONT", 1.5)
		elseif current_action == "TURNBACK" then
			local message_text = villagers.chat.busy[math.random(#villagers.chat.busy)]
			villagers.showMessageBubble(self, clicker, message_text, "FRONT", 1.5)
		else
			print("## ERROR Invalid current_action: "..current_action)
		end
		
	end

end


function villagers.on_rightclick(self, clicker)

	local current_action = self.vAction
	if villagers.log then io.write("vAction="..current_action.." ") end
	
	if current_action == "STAND" or current_action == "TURN" or current_action == "WALK" or
		current_action == "DIG" or current_action == "RESUMEDIG" then
		
		if self.vSell == "none" then
			villagers.chatVillager(self, clicker, 3)
		else
			villagers.tradeVillager(self, clicker)
			villagers.chatVillager(self, clicker, 1)
		end
		
	elseif current_action == "ENDTRADE" or current_action == "ENDCHAT" then
		local message_text = villagers.chat.busy[math.random(#villagers.chat.busy)]
		villagers.showMessageBubble(self, clicker, message_text, "FRONT", 1.5)
		
	-- when player right click's on a villager who is already
	-- trading with another player
	elseif current_action == "TRADE" then
		local message_text = "I'm trading with "..string.upper(self.vTrading).."\nOne moment.."
		villagers.showMessageBubble(self, clicker, message_text, "FRONT", 2)
	
	elseif current_action == "CHAT" then
		
		if self.vChatting == clicker:get_player_name() then
			
			self.vChatting = nil
			if self.vSell == "none" then
				villagers.endVillagerChat(self, clicker, 3)
				
			else
				villagers.chatVillager(self, clicker, 1)
				villagers.tradeVillager(self, clicker)
			end
			
		else
			local message_text = "I'm chatting with "..string.upper(self.vChatting).."\nOne moment.."
			villagers.showMessageBubble(self, clicker, message_text, "FRONT", 2)
		end
		
	-- villager will not chat if currently performing the
	-- below actions
	else
		local current_action = self.vAction
		if current_action == "WALKING" then
			local message_text = villagers.chat.walking[math.random(#villagers.chat.walking)]
			villagers.showMessageBubble(self, clicker, message_text, "FRONT", 1.5)
		elseif current_action == "WALKBACK" then
			local message_text = villagers.chat.walkback[math.random(#villagers.chat.walkback)]
			villagers.showMessageBubble(self, clicker, message_text, "FRONT", 1.5)
		elseif current_action == "TURNBACK" then
			local message_text = villagers.chat.busy[math.random(#villagers.chat.busy)]
			villagers.showMessageBubble(self, clicker, message_text, "FRONT", 1.5)
		else
			print("## ERROR Invalid current_action: "..current_action)
		end
		
	end

end


function villagers.on_step(self, dtime)

	self.vTimer = self.vTimer + dtime
	if self.vChatting then
		if self.vTimer > 1 then
			
			self.vTimer = 0
			
			local player = minetest.get_player_by_name(self.vChatting)
			if player then
			
				if self.vChatReady then					
					-- villager maintains yaw direction toward player
					villagers.turnToPlayer(self, player)
					
					local distance = vector.distance(self.vPos, player:getpos())
					
					local currVillagerLookDir = villagers.round(self.object:get_yaw(),3)
					local currPlayerLookDir = villagers.round(player:get_look_horizontal(),3)
					if currVillagerLookDir < 0 then
						currVillagerLookDir = currVillagerLookDir + (3.141*2)
					end
					
					-- player moved away from villager while chatting
					-- villager assumes player no longer wants to chat
					if distance > self.vInitialChatDistance then
						villagers.endVillagerChat(self, player, 1)
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
					self.object:set_yaw(self.vYaw)
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
end