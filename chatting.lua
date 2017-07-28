
-- ==================================== CHAT BUBBLES AND DIALOGUE =========================================
-- ========================================================================================================
-- show alert box messages
function villagers.showMessageBubble(self, player, message_text, message_location, clear_timer)
	local player_name = player:get_player_name()
	local table_data = minetest.serialize(self.vHudIds[player_name])
	
	if villagers.log2 then 
		io.write("showBubble() ") 
		io.write("self.vHudIds["..player_name.."]:"..table_data.." ")
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
			
		--[[ --formspec cuts into chatbubble. figure out later
		elseif message_location == "TRADINGBYE" then
			x_offset = 0
			y_offset = -240
			bubble_texture = "bubble_villager_front.png"
			message_position = { x = 0.5, y = 1.0 }
			message_align = {x=0, y=0}
		--]]
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
		
		local nameAndTitleString = "~ "..self.vName.." ~"		
		
		-- show chat bubble
		local chat_box_id = player:hud_add({
			hud_elem_type = "image",
			scale = { x = 1, y = 1 },
			position = message_position,
			text = bubble_texture,
			offset = {x=0+x_offset, y=y_offset}, 
		})
		
		--show villager's name within chat bubble
		local chat_name_id = player:hud_add({
			hud_elem_type = "text",
			position = message_position,
			text = nameAndTitleString,
			number = 0x666666,
			offset = {x=0+x_offset, y=y_offset-25} 
		})
		
		--show main text within chat bubble
		local chat_text_id = player:hud_add({
			hud_elem_type = "text",
			position = message_position,
			text = message_text,
			number = 0x000000,
			offset = {x=0+x_offset, y=y_offset+15} 
		})
		
		local villager_id = self.vID
		local player_name = player:get_player_name()
		if self.vHudIds[player_name] == nil then self.vHudIds[player_name] = {} end
		
		table.insert(self.vHudIds[player_name], 1, {chat_box_id, chat_name_id, chat_text_id})
		minetest.after(clear_timer, function() 
			--io.write("\n## MINETEST.AFTER()!! deleting chat IDs..")
			villagers.removeTextHud(self, player)
		end)
		
		if villagers.log2 then 
			--io.write("newHudIds:"..dump(self.vHudIds.chats.timed[villager_id]).." ")
			local table_data = minetest.serialize(self.vHudIds[player_name])
			io.write("self.vHudIds["..player_name.."]:"..table_data.." ")
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
	
	yaw = villagers.round(yaw, 3)
	
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

	degrees_value = villagers.round(degrees_value,1)
	return degrees_value
end

local function getLookDirection(yaw)
   local degrees = yawToDegrees(yaw)
   local lookDirection
   if degrees > 337.5 or degrees <= 22.5 then lookDirection = 1
   elseif degrees > 22.5 and degrees <= 67.5 then lookDirection = 2
   elseif degrees > 67.5 and degrees <= 112.5 then lookDirection = 3
   elseif degrees > 112.5 and degrees <= 157.5 then lookDirection = 4
   elseif degrees > 157.5 and degrees <= 202.5 then lookDirection = 5
   elseif degrees > 202.5 and degrees <= 247.5 then lookDirection = 6
   elseif degrees > 247.5 and degrees <= 292.5 then lookDirection = 7
   elseif degrees > 292.5 and degrees <= 337.5 then lookDirection = 8
   else lookDirection = 1
   end
   return lookDirection
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
function villagers.getRandomChatText(self, chat_texts, script_type, chat_text_count)
	--print("villagers.getRandomChatText("..script_type.." "..chat_text_count..") ")
	
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
			end
			
			table.insert(self[script_type], text_string)
			table.insert(self[script_type.."Saved"], text_string)
		end
	end	

end

function villagers.endVillagerChat(self, player, end_type)
	if villagers.log2 then io.write("endChat() end_type="..end_type.." ") end
	
	local message_location = getChatOrientation(self, player)
	
	local goodbyes
	
	-- normal 'goodbye' dialogues variations when player has walked away
	if end_type == 1 then
		goodbyes = self.vScriptBye
		
		-- remove current chat bubble the villager has displayed
		villagers.removeTextHud(self, player) 
		
		-- display the goodbye message bubble
		villagers.showMessageBubble(self, player, goodbyes[math.random(#goodbyes)], message_location, 1)
		
	-- villager went through all 'main' dialogue
	-- so then ended the chat with player 'got to go!'
	elseif end_type == 2 then
		goodbyes = self.vScriptGtg
		villagers.showMessageBubble(self, player, goodbyes[math.random(#goodbyes)], message_location, 2)
	
	-- villager has nothing to trade, so 'got to go'
	elseif end_type == 3 then
		if self.vAge == "young" then
			goodbyes = villagers.chat.trade.none_young
		else
			goodbyes = villagers.chat.trade.none
		end
		
		villagers.showMessageBubble(self, player, goodbyes[math.random(#goodbyes)], message_location, 2.5)
		
	else
		print("## ERROR Invalid end_type: "..end_type.." ##")
	end
			
	-- load previous yaw value
	self.vYaw = self.vYawSaved
	
	-- resume previous look direction
	minetest.after(2, function() 
		self.object:set_yaw(self.vYaw)
		
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

function villagers.chatVillager(self, player, chat_type)
	local log = false
	if log then io.write("chat() ") end
	
	-- if player initiated chat when villager was about to start 
	-- walking or digging. save this state to continue action once chat ends
	if self.vAction == "WALK" then
		if log then io.write("villagerAboutToWalk ") end
		self.vWalkReady = true
	elseif self.vAction == "DIG" then
		if log then io.write("villagerAboutToDig ") end
		self.vDigReady = true
		minetest.sound_stop(self.vSoundHandle)
		self.object:set_animation(
			{x=self.animation["stand_start"], y=self.animation["stand_end"]},
			self.animation_speed + math.random(10)
		)
	elseif self.vAction == "RESUMEDIG" then
		if log then io.write("villagerAboutToResumeDig ") end
		self.vDigReady = true
	end
	
	self.vAction = "CHAT"
	
	local player_name = player:get_player_name()
	
	-- show a quick greeting bubble for when player right clicks
	-- on villager for trading
	if chat_type == 1 then
		if log then io.write("startTrading ") end
		
		--formspec cuts into chatbubble. figure out later
		--villagers.showMessageBubble(self, player, villagers.chat.trade.hi[math.random(#villagers.chat.trade.hi)], "TRADING", 4)
		
	-- player ended trading with villager, so villager says custom trading goodbyes
	elseif chat_type == 2 then
		if log then io.write("playerEndedTrade vTraded="..tostring(self.vTraded).." ") end
		local bye_text
		if self.vTraded then
			bye_text = villagers.chat.trade.bye_buy
			villagers.showMessageBubble(self, player, bye_text[math.random(#bye_text)], "TRADINGBYE", 2)
			self.vTraded = false
		else
			bye_text = villagers.chat.trade.bye
			villagers.showMessageBubble(self, player, bye_text[math.random(#bye_text)], "TRADINGBYE", 2)
		end
		
	-- villager has no items to trade, and will state as such and say they got to go
	elseif chat_type == 3 then
		if log then io.write("VillageNothingToSell ") end
		
		self.vChatting = player_name
		self.vYawSaved = self.vYaw
		
		-- make villager face player
		villagers.turnToPlayer(self, player)
		
		-- end chat with villager saying nothing to sell
		villagers.endVillagerChat(self, player, 3)	
		
	-- player continuing ongoing dialogue with villager
	elseif self.vChatting then
		if log then io.write("continuingConversation ") end
		local next_dialogue
		
		-- pop/remove one random dialogue from 'smalltalk' table
		local random_num = math.random(6)
		if random_num == 1 then
			local dialogue_count = #self.vScriptSmalltalk
			if log then io.write("getDialogue:smalltalk fromRemain="..dialogue_count.." ") end
			if dialogue_count == 0 then
				local full_dialgue_table = villagers.copytable(villagers.chat.smalltalk)
				villagers.getRandomChatText(self, full_dialgue_table, "vScriptSmalltalk", 3)
				if log then io.write("tableReloaded:smalltalk ") end
			end
			
			next_dialogue = table.remove(self.vScriptSmalltalk, math.random(dialogue_count))
			villagers.showMessageBubble(self, player, next_dialogue, "FRONT", 3)
			if log then io.write("dialogueDisplayedOK remain="..#self.vScriptSmalltalk.." ") end
			
		-- pop/remove one random dialogue from 'mainchat' table
		elseif random_num > 3 then
			local dialogue_count = #self.vScriptMain
			if log then io.write("getDialogue:main fromRemain="..dialogue_count.." ") end
			if dialogue_count == 0 then
				local full_dialgue_table = villagers.copytable(villagers.chat[self.vType].mainchat)
				villagers.getRandomChatText(self, full_dialgue_table, "vScriptMain", 3)
				if log then io.write("tableReloaded:main ") end
				villagers.endVillagerChat(self, player, 2)
				if log then io.write("chatEnded ") end
			else
				next_dialogue = table.remove(self.vScriptMain, math.random(dialogue_count))
				villagers.showMessageBubble(self, player, next_dialogue, "FRONT", 3)
				if log then io.write("dialogueDisplayedOK remain="..#self.vScriptMain.." ") end
			end
			
		else
			local dialogue_count = #self.vScriptGameFacts
			if log then io.write("getDialogue:gamefacts fromRemain="..dialogue_count.." ") end
			if dialogue_count == 0 then
				local full_dialgue_table = villagers.copytable(villagers.chat.gamefacts)
				villagers.getRandomChatText(self, full_dialgue_table, "vScriptGameFacts", 2)
				if log then io.write("tableReloaded:gamefacts ") end
			end
			
			next_dialogue = table.remove(self.vScriptGameFacts, math.random(dialogue_count))
			villagers.showMessageBubble(self, player, next_dialogue, "FRONT", 3)
			if log then io.write("dialogueDisplayedOK remain="..#self.vScriptGameFacts.." ") end
		end
		
	-- player starting new conversation with villager
	else
		if log then io.write("\nnewConversation ") end
		
		self.vChatting = player_name
		self.vYawSaved = self.vYaw
		
		-- make villager face player
		villagers.turnToPlayer(self, player)
		
		-- save initial distance between player and villager. if player 
		-- surpasses this distance, villager will end chat.
		self.vInitialChatDistance = vector.distance(self.vPos, player:getpos())
		
		local greeting_text
		
		-- if player chats while villager was about to walk
		if self.vWalkReady then
			if log then io.write("villagerAboutToWalk ") end
			greeting_text = villagers.chat.walk[math.random(#villagers.chat.walk)]
		
		-- if player chats while villager was digging
		elseif self.vDigReady then
			if log then io.write("villagerDigging ") end
			greeting_text = villagers.chat.dig[self.vDigging][math.random(#villagers.chat.dig[self.vDigging])]
			
		-- show one of the random default greetings for this villager type
		else
			if log then io.write("showDefaultHI ") end
			local greetings = self.vScriptHi
			greeting_text = greetings[math.random(#greetings)]
		end
		
		villagers.showMessageBubble(self, player, greeting_text, "FRONT", 3)
		
	end
	
	if log then io.write("\n") end
end
