local function validateVillageParameters(parameter, type, village)
	local log = false
	if log then io.write("\nvalidateParams() ") end
	
	if type == "region" then
		if log then io.write("for REGION ") end
		if parameter == nil then
			if log then io.write("is NIL ") end
			return "normal"
		else 
			for i=1, #villagers.REGIONS do
				if villagers.REGIONS[i] == parameter then 
					if log then io.write("is VALID ") end
					return parameter 
				end
			end
			if log then io.write("notFound setTo=NORMAL ") end
			return "normal"
		end
		
	elseif type == "village" then
		if log then io.write("for VILLAGE ") end
		if parameter == nil then
			if log then io.write("is NIL ") end
			return "nore"
		else
			for i=1, #villagers.VILLAGES do
				if villagers.VILLAGES[i] == parameter then 
					if log then io.write("is VALID ") end				
					return parameter 
				end
			end
			if log then io.write("notFound setTo=NORE ") end
			return "nore"
		end
		
	elseif type == "plot" then
		if log then io.write("for PLOT ") end
		if parameter == nil then
			if log then io.write("is NIL ") end
			return "empty"
		else
			for i=1, #villagers.BUILDINGS do
				if villagers.BUILDINGS[i] == parameter then 
					if log then io.write("is VALID ") end
					return parameter 
				end
			end
			if log then io.write("notFound setTo=EMPTY ") end
			return "empty"
		end
		
	elseif type == "schem" then
		if log then io.write("for SCHEM ") end
		local schems_available = villagers.SCHEMS[village]
		local random_schem = schems_available[math.random(#schems_available)]
		if parameter == nil then
			if log then io.write("is NIL ") end
			return random_schem
		else
			for i=1, #schems_available do
				if schems_available[i] == parameter then 
					if log then io.write("is VALID ") end
					return parameter 
				end
			end
			if log then io.write("notFound setTo="..random_schem.." ") end
			return random_schem
		end
		
	end
end

function villagers.getVillagerListFormspec(player)
	local log = false
	
	local entities = {}
	for _, self in pairs(minetest.luaentities) do
		if self.vSell ~= "none" then
			table.insert(entities, self)
		end
	end
	local count = #entities
	if log then print("  villager count: "..count) end
	
	local width_form = 13.0
	
	local h_labels = 1
	local h_row = 0.7
	local h_exit_button = 1
	local h_between = 0.5 -- between label and list, and between list and exit button
	
	local height_form = h_labels + (h_row * count) + h_exit_button
	
	if log then print("formspec width="..width_form.." height="..height_form) end
	
	-- GUI related stuff
	--local bg = "bgcolor[#080808BB;true]"
	local bg_image = "background[0,0;0,0;gui_formbg.png;true]"
	
	local formspec = 
		-- gui background attributes
		"size["..width_form..","..height_form.."]"..bg_image..
		
		-- header row
		"label[0.3,0;Village]"..
		"label[1.8,0;Plot]"..
		"label[2.5,0;Bed]"..
		"label[3.2,0;Name]"..
		"label[5.2,0;Title]"..
		"label[7.3,0;Origin]"..
		"label[8.3.,0;Current]"..
		"label[9.4,0;Walked]"..
		"label[10.6,0;Dist]"
		--"label[11.5,0;Action]"

	-- main villager list
	if count > 0 then
		for i = 1, count do
			local self = entities[i]
			local villager_name = self.vName
			formspec = formspec..
				"label[0.3,"..(h_row * i)..";"..self.vVillage.."]"..
				"label[1.8,"..(h_row * i)..";"..self.vPlot.."]"..
				"label[2.5,"..(h_row * i)..";"..self.vBed.."]"..
				"label[3.2,"..(h_row * i)..";"..villager_name.."]"..
				"label[5.2,"..(h_row * i)..";"..self.vTitle.."]"..
				"label[7.3,"..(h_row * i)..";"..self.vOriginPos.x..","..self.vOriginPos.z.."]"..
				"label[8.3,"..(h_row * i)..";"..self.vPos.x..","..self.vPos.z.."]"..
				"label[9.6,"..(h_row * i)..";"..self.vTotalDistance.."]"..
				"label[10.6,"..(h_row * i)..";"..villagers.round(vector.distance(self.vPos, player:get_pos()), 1).."]"
				
			local teleport_data = "teleport_"..minetest.pos_to_string(self.vPos)	
			formspec = formspec.."button[11.5,"..(h_row * i)..";1,0.5;"..teleport_data..";go]" 
		end
		
	else
		formspec = formspec.. "label[5.5,0.5;(no villagers nearby)]" 
	end

	formspec = formspec.. 	"button_exit[4.5,"..(height_form - 1)..";2,1;exit;Exit]"..
							"button[6.5,"..(height_form - 1)..";2,1;refresh;refresh]" 
		
	return formspec

end


-- manually spawn villager via chat command. mostly for testing.
minetest.register_chatcommand("villagers", {
	params = "<command>",
	description = "Villager Tools",
	privs = {},	
	func = function(name, param)
		local log = false
		local params = string.split(param, " ")	
		local command_type = params[1]
		local player = minetest.get_player_by_name(name)
		
		if command_type == "list" then
			if log then print("\n## SHOWING VILAGERS LIST ##") end
			local player = minetest.get_player_by_name(name)
			minetest.show_formspec(name, "villagers:list", villagers.getVillagerListFormspec(player))
		
		else
			if command_type == nil then command_type = "NIL" end
			minetest.chat_send_player(name, "Invalid command: "..command_type)
		end
		
	end,
})
