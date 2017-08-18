local enable_coin_drop = minetest.settings:get_bool("coin_drop")
if enable_coin_drop == nil then enable_coin_drop = true end

-- coin findings in dirty nodes :P
local item_drop_def = {
	{ items = {"villagers:coins_gold", "default:dirt"}, rarity = 50 },
	{ items = {"villagers:coins", "default:dirt"}, rarity = 30 }
}

local coin_nodes = { "default:dirt", "default:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_rainforest_litter", "default:dirt_with_snow" }
local ethereal_found = false

for i, name in ipairs(minetest.get_modnames()) do
	if name == "ethereal" then ethereal_found = true
	end
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
			local debug
			local set_max_items = 1

			-- reset table
			local new_items = {}
			for idx = 1, #item_drop_def do table.insert(new_items, item_drop_def[idx]) end

			-- default drop = "string", build a table and include the default drop at last position
			if type(item_def.drop) == "string" or coin_nodes[n] == "ethereal:dry_dirt" then
				debug = " --> creating new table"

				local insert_drop = item_def.drop

				-- special treatment for "ethereal:dry_dirt" because it has no drop value, so it gets one :)
				if coin_nodes[n] == "ethereal:dry_dirt" then
					new_items[1].items[2] = "ethereal:dry_dirt"
					new_items[2].items[2] = "ethereal:dry_dirt"

					insert_drop = coin_nodes[n]
				end

				table.insert(new_items, { items = { insert_drop } })
			elseif type(item_def.drop) == "table" then

				debug = " --> modifying existing table"
				set_max_items = item_def.drop.max_items
				for idx = 1, #item_def.drop.items do
					table.insert(new_items, item_def.drop.items[idx])
				end
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
