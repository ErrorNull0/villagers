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
end
