local enable_coin_drop = minetest.settings:get_bool("coin_drop")
if enable_coin_drop == nil then enable_coin_drop = true end

local coin_nodes = { "default:dirt", "default:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_rainforest_litter", "default:dirt_with_snow" }
local ethereal_found = false

for i, name in ipairs(minetest.get_modnames()) do
	if name == "ethereal" then ethereal_found = true
	end
end

-- coin findings in dirty nodes :P
local function coin_drop_items(node)
	local set_dirt = "default:dirt"

	-- special treatment for "ethereal:dry_dirt" because it has no drop value, so it gets one :)
	if node == "ethereal:dry_dirt" then set_dirt = node end

	return { { items = {"villagers:coins_gold", set_dirt}, rarity = 50 }, { items = {"villagers:coins", set_dirt}, rarity = 30 } }
end


p_coins_table = {}

local function update_coins(player)
	local p_name = player:get_player_name()
	local inv = player:get_inventory()
	
	-- read-out coin stacks/update current coins
	p_coins_table[p_name].coins.curr = 0
	p_coins_table[p_name].coins_gold.curr = 0

	local curr_stack

	for i = 1, inv:get_size("main") do
		curr_stack = inv:get_stack("main", i):to_table()

		if curr_stack then
			local addCount = curr_stack.count
			local new_count = curr_stack.count

			if curr_stack.name == "villagers:coins" then
				p_coins_table[p_name].coins.curr = p_coins_table[p_name].coins.curr + curr_stack.count
			elseif curr_stack.name == "villagers:coins_gold" then
				p_coins_table[p_name].coins_gold.curr = p_coins_table[p_name].coins_gold.curr + curr_stack.count
			end
		end
	end

	-- update villagers:coins on change
	if p_coins_table[p_name].coins.old ~= p_coins_table[p_name].coins.curr then
		if p_coins_table[p_name].just_joined == false then minetest.sound_play("coins_new", { to_player = p_name, gain = 1.5 }) end
		p_coins_table[p_name].coins.old = p_coins_table[p_name].coins.curr
	end

	-- update villagers:coins_gold on change
	if p_coins_table[p_name].coins_gold.old ~= p_coins_table[p_name].coins_gold.curr then
		if p_coins_table[p_name].just_joined == false then minetest.sound_play("coins_new", { to_player = p_name, gain = 1.5 }) end
		p_coins_table[p_name].coins_gold.old = p_coins_table[p_name].coins_gold.curr
	end

	-- if player just joined do not play sound
	if p_coins_table[p_name].just_joined == true then p_coins_table[p_name].just_joined = false end
end

-- register p_coins_table on playerjoin
minetest.register_on_joinplayer(function(player)
	local p_name = player:get_player_name()

	if p_coins_table[p_name] == nil then
		p_coins_table[p_name] = {}	
	end

	p_coins_table[p_name].just_joined = true
	p_coins_table[p_name].coins = {curr = 0, old = 0}
	p_coins_table[p_name].coins_gold = {curr = 0, old = 0}

	update_coins(player)
end)

if enable_coin_drop then

	minetest.log("[Villagers] hiding coins in dirt, please wait!")

	-- ethereal support
	if ethereal_found == true then
		minetest.log("adding dirt from ethereal")

		table.insert(coin_nodes, "ethereal:bamboo_dirt")
		table.insert(coin_nodes, "ethereal:cold_dirt")
		table.insert(coin_nodes, "ethereal:crystal_dirt")
		table.insert(coin_nodes, "ethereal:dry_dirt")
		table.insert(coin_nodes, "ethereal:fiery_dirt")
		table.insert(coin_nodes, "ethereal:grey_dirt")
		table.insert(coin_nodes, "ethereal:grove_dirt")
		table.insert(coin_nodes, "ethereal:jungle_dirt")
		table.insert(coin_nodes, "ethereal:mushroom_dirt")
		table.insert(coin_nodes, "ethereal:prairie_dirt")
	end

	for n = 1, #coin_nodes do
		local item_def = minetest.registered_items[coin_nodes[n]]

		if item_def ~= nil then
			local debug = ""
			local set_max_items = 1

			-- getting drop-item-table
			local new_items = coin_drop_items(coin_nodes[n])

			-- default drop = "string", build a table and include the default drop at last position
			if type(item_def.drop) == "string" or coin_nodes[n] == "ethereal:dry_dirt" then
				debug = " --> creating new table"
				local insert_drop = item_def.drop

				-- special treatment for "ethereal:dry_dirt" because it has no drop value, so it gets one :)
				if coin_nodes[n] == "ethereal:dry_dirt" then insert_drop = coin_nodes[n] end

				table.insert(new_items, { items = { insert_drop } })

			elseif type(item_def.drop) == "table" then
				debug = " --> modifying existing table"
				set_max_items = item_def.drop.max_items
				for idx = 1, #item_def.drop.items do table.insert(new_items, item_def.drop.items[idx]) end
			end

			local set_item_drop = {
				max_items = set_max_items,
				items = new_items
			}

			minetest.log(coin_nodes[n] .. " has coins now!" .. debug)
			minetest.override_item(coin_nodes[n], { drop = set_item_drop })
		end
	end

	local timer = 0

	-- global loop to checkback if any player just collected a new coin
	minetest.register_globalstep(function(dtime)

		timer = timer + dtime
		if timer < 0.5 then return end -- check for added coins every half second
		timer = 0

		local name = ""
		local inv

		for _,player in ipairs(minetest.get_connected_players()) do
			update_coins(player)
		end
	end)
end
