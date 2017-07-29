-- Costs and Stock of all goods: index 1 is cost, index 2 is stock
local GOODS_DATA = {
	["default:apple"] 			= {"villagers:coins", 2, math.random(70,90)},
	["flowers:mushroom_red"] 	= {"villagers:coins", 5, math.random(50,70)},
	["flowers:mushroom_brown"] 	= {"villagers:coins", 5, math.random(50,70)},
	
	["flowers:rose"] 				= {"villagers:coins", 5, math.random(30,50)},
	["flowers:tulip"] 				= {"villagers:coins", 5, math.random(30,50)},
	["flowers:dandelion_yellow"]	= {"villagers:coins", 5, math.random(30,50)},
	["flowers:geranium"] 			= {"villagers:coins", 5, math.random(30,50)},
	["flowers:viola"] 				= {"villagers:coins", 5, math.random(30,50)},
	["flowers:dandelion_white"] 	= {"villagers:coins", 5, math.random(30,50)},
	
	["default:papyrus"] 	= {"villagers:coins", 2, math.random(30,50)},
	["default:paper"] 		= {"villagers:coins", 6, math.random(30,50)},
	["default:book"]		= {"villagers:coins", 20, math.random(20,40)},
	
	["farming:seed_cotton"] = {"villagers:coins", 2, math.random(80,99)},
	["farming:cotton"] 		= {"villagers:coins", 3, math.random(80,99)},
	["farming:string"] 		= {"villagers:coins", 3, math.random(90,99)},
	["farming:seed_wheat"]	= {"villagers:coins", 2, math.random(80,99)},
	["farming:wheat"] 		= {"villagers:coins", 2, math.random(60,80)},
	["farming:straw"] 		= {"villagers:coins", 7, math.random(60,80)},
	
	["farming:flour"] 		= {"villagers:coins", 9, math.random(60,80)},
	["farming:bread"] 		= {"villagers:coins", 17, math.random(30,40)},
	
	["default:ice"] 		= {"villagers:coins", 5, math.random(70,90)},
	["group:wool"] 			= {"villagers:coins", 999, math.random(60,80)},
	
	["default:dirt"] 			= {"villagers:coins", 1, math.random(70,90)},
	["default:gravel"] 			= {"villagers:coins", 2, math.random(70,90)},
	
	["default:sand"] 			= {"villagers:coins", 2, math.random(70,90)},
	["default:desert_sand"] 	= {"villagers:coins", 2, math.random(70,90)},
	["default:silver_sand"] 	= {"villagers:coins", 2, math.random(70,90)},
	
	["default:glass"] 				= {"villagers:coins", 4, math.random(40,60)},
	["vessels:glass_bottle"] 		= {"villagers:coins", 1, math.random(30,40)},
	["vessels:drinking_glass"] 		= {"villagers:coins", 8, math.random(20,30)},
	["cottages:glass_pane"] 		= {"villagers:coins", 2, math.random(30,50)},
	["xpanes:pane_flat"] 			= {"villagers:coins", 14, math.random(30,50)},
	["cottages:glass_pane_side"]	= {"villagers:coins", 14, math.random(30,50)},
	
	["default:clay_lump"] 	= {"villagers:coins", 5, math.random(60,80)},
	["default:clay"] 		= {"villagers:coins", 22, math.random(40,60)},
	["default:clay_brick"] 	= {"villagers:coins", 23, math.random(40,60)},
	["default:cobble"] 		= {"villagers:coins", 3, math.random(60,80)},
	["default:stone"] 		= {"villagers:coins", 6, math.random(60,80)},
	
	["default:desert_stone"] 		= {"villagers:coins", 7, math.random(60,80)},
	["default:sandstone"] 			= {"villagers:coins", 8, math.random(60,80)},
	["default:desert_sandstone"] 	= {"villagers:coins", 7, math.random(60,80)},
	["default:silver_sandstone"] 	= {"villagers:coins", 7, math.random(60,80)},
	
	["default:stonebrick"] 				= {"villagers:coins", 25, math.random(60,80)},
	["default:sandstonebrick"] 			= {"villagers:coins", 30, math.random(60,80)},
	["default:desert_stonebrick"] 		= {"villagers:coins", 30, math.random(60,80)},
	["default:desert_sandstone_brick"] 	= {"villagers:coins", 30, math.random(60,80)},
	["default:silver_sandstone_brick"] 	= {"villagers:coins", 30, math.random(60,80)},
	["default:brick"] 					= {"villagers:coins", 100, math.random(60,80)},
	
	["default:stick"] 		= {"villagers:coins", 1, math.random(80,99)},
	["default:wood"] 		= {"villagers:coins", 5, math.random(60,70)},
	["default:tree"] 		= {"villagers:coins", 23, math.random(50,60)},
	["default:ladder_wood"] = {"villagers:coins", 3, math.random(40,50)},
	["cottages:table"] 		= {"villagers:coins", 5, math.random(20,30)},
	["cottages:bench"] 		= {"villagers:coins", 8, math.random(20,30)},
	
	["default:fence_wood"] 		= {"villagers:coins", 24, math.random(40,60)},
	["doors:gate_wood_closed"] 	= {"villagers:coins", 16, math.random(30,50)},
	["doors:door_wood_a"] 		= {"villagers:coins", 33, math.random(30,50)},
	["default:sign_wall_wood"] 	= {"villagers:coins", 11, math.random(40,60)},
	["doors:trapdoor"] 			= {"villagers:coins", 16, math.random(40,60)},
	["default:chest"] 			= {"villagers:coins", 44, math.random(30,50)},
	["boats:boat"] 				= {"villagers:coins", 28, math.random(20,30)},
	["beds:bed"] 				= {"villagers:coins", 34, math.random(20,30)},
	["beds:fancy_bed"] 			= {"villagers:coins", 40, math.random(10,20)},
	["default:bookshelf"] 		= {"villagers:coins", 10, math.random(30,40)},
	["cottages:shelf"] 			= {"villagers:coins", 18, math.random(30,40)},
	["vessels:shelf"] 			= {"villagers:coins", 50, math.random(30,40)},
	["cottages:tub"] 			= {"villagers:coins", 20, math.random(50,70)},
	["cottages:barrel"] 		= {"villagers:coins", 40, math.random(60,80)},
	["cottages:barrel_lying"] 	= {"villagers:coins", 40, math.random(60,80)},
	["cottages:wood_flat"] 		= {"villagers:coins", 1, math.random(70,90)},
	["cottages:hatch_wood"] 	= {"villagers:coins", 5, math.random(40,60)},
	["cottages:wagon_wheel"] 	= {"villagers:coins", 5, math.random(40,60)},
	["cottages:gate_closed"] 	= {"villagers:coins", 12, math.random(30,50)},
	
	-- STAIRS --
	["stairs:stair_wood"]	 		= {"villagers:coins", 7, math.random(30,50)},
	["stairs:stair_pine_wood"] 		= {"villagers:coins", 9, math.random(30,50)},
	["stairs:stair_junglewood"] 	= {"villagers:coins", 10, math.random(30,50)},
	["stairs:stair_acacia_wood"] 	= {"villagers:coins", 10, math.random(30,50)},
	
	["stairs:slab_wood"] 			= {"villagers:coins", 3, math.random(60,80)},
	
	["stairs:slab_straw"] 			= {"villagers:coins", 4, math.random(40,60)},
	["stairs:stair_straw"] 			= {"villagers:coins", 7, math.random(30,50)},
	
	["stairs:slab_ice"] 			= {"villagers:coins", 3, math.random(70,90)},
	["stairs:stair_ice"] 			= {"villagers:coins", 5, math.random(40,60)},
	
	["stairs:stair_sandstone"] 					= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_sandstone_block"] 			= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_sandstonebrick"] 			= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_desert_sandstone"] 			= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_desert_sandstone_block"] 	= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_desert_sandstone_brick"] 	= {"villagers:coins", 5, math.random(40,60)},
	
	["stairs:stair_"] 	= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_"] 	= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_"] 	= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_"] 	= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_"] 	= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_"] 	= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_"] 	= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_"] 	= {"villagers:coins", 5, math.random(40,60)},
	["stairs:stair_"] 	= {"villagers:coins", 5, math.random(40,60)},
	
	
	["default:coal_lump"] 		= {"villagers:coins", 20, math.random(60,80)},
	["default:coalblock"] 		= {"villagers:coins_gold", 19, math.random(30,50)},
	["default:torch"] 			= {"villagers:coins", 10, math.random(30,50)},
	["tnt:gunpowder"] 			= {"villagers:coins_gold", 25, math.random(30,50)},
	["tnt:tnt"] 				= {"villagers:coins_gold", 15, math.random(20,40)},
	
	["default:iron_lump"] 				= {"villagers:coins", 80, math.random(70,90)},
	["default:copper_lump"] 			= {"villagers:coins_gold", 16, math.random(60,80)},
	["default:tin_lump"] 				= {"villagers:coins_gold", 16, math.random(60,80)},
	["default:gold_lump"] 				= {"villagers:coins_gold", 28, math.random(30,40)},
	["default:mese_crystal_fragment"] 	= {"villagers:coins_gold", 7, math.random(70,90)},
	["default:steel_ingot"] 			= {"villagers:coins_gold", 10, math.random(60,80)},
	["default:copper_ingot"] 			= {"villagers:coins_gold", 18, math.random(60,80)},
	["default:tin_ingot"] 				= {"villagers:coins_gold", 18, math.random(60,80)},
	["default:bronze_ingot"] 			= {"villagers:coins_gold", 20, math.random(60,80)},
	["default:gold_ingot"] 				= {"villagers:coins_gold", 30, math.random(30,50)},	
	["default:mese_crystal"] 			= {"villagers:coins_gold", 55, math.random(20,40)},
	["default:diamond"] 				= {"villagers:coins_gold", 99, math.random(20,40)},
	
	["default:goldblock"] 		= {"villagers:coins_gold", 280, math.random(20,30)},
	["stairs:stair_goldblock"] 	= {"villagers:coins_gold", 100, math.random(20,30)},
	["stairs:slab_goldblock"] 	= {"villagers:coins_gold", 140, math.random(20,30)},
	
	["screwdriver:screwdriver"] = {"villagers:coins_gold", 11, math.random(30,50)},
	["default:chest_locked"] 	= {"villagers:coins_gold", 15, math.random(30,50)},
	["default:skeleton_key"] 	= {"villagers:coins_gold", 19, math.random(30,50)},
	--["bucket:bucket_empty"] 	= {"villagers:coins_gold", 28, math.random(40,60)},
	["default:door_steel"] 		= {"villagers:coins_gold", 62, math.random(20,40)},
	["vessels:steel_bottle"] 	= {"villagers:coins_gold", 55, math.random(20,40)},
	
	["default:shovel_wood"] 	= {"villagers:coins", 8, math.random(30,50)},
	["default:shovel_stone"] 	= {"villagers:coins", 9, math.random(30,50)},
	["default:shovel_steel"] 	= {"villagers:coins_gold", 11, math.random(30,50)},
	["default:shovel_bronze"] 	= {"villagers:coins_gold", 19, math.random(30,50)},
	["default:pick_wood"] 		= {"villagers:coins", 16, math.random(30,50)},
	["default:pick_stone"] 		= {"villagers:coins", 21, math.random(30,50)},
	["default:pick_steel"] 		= {"villagers:coins_gold", 31, math.random(30,50)},
	["default:pick_bronze"] 	= {"villagers:coins_gold", 56, math.random(30,50)},
	["default:sword_wood"] 		= {"villagers:coins", 12, math.random(20,40)},
	["default:sword_stone"] 	= {"villagers:coins", 14, math.random(20,40)},
	["default:sword_steel"] 	= {"villagers:coins_gold", 21, math.random(20,40)},
	["default:sword_bronze"] 	= {"villagers:coins_gold", 37, math.random(20,40)},
	["default:axe_wood"] 		= {"villagers:coins", 18, math.random(20,40)},
	["default:axe_stone"] 		= {"villagers:coins", 21, math.random(20,40)},
	["default:axe_steel"] 		= {"villagers:coins_gold", 31, math.random(20,40)},
	["default:axe_bronze"] 		= {"villagers:coins_gold", 57, math.random(20,40)},
	["farming:hoe_wood"] 		= {"villagers:coins", 13, math.random(30,50)},
	["farming:hoe_stone"] 		= {"villagers:coins", 15, math.random(30,50)},
	["farming:hoe_steel"] 		= {"villagers:coins_gold", 21, math.random(30,50)},
	["farming:hoe_bronze"] 		= {"villagers:coins_gold", 37, math.random(30,50)},
	
	["dye:white"] 		= {"villagers:coins", 3, math.random(30,50)},
	["dye:grey"] 		= {"villagers:coins", 8, math.random(30,50)},
	["dye:dark_grey"] 	= {"villagers:coins", 8, math.random(30,50)},
	["dye:black"] 		= {"villagers:coins", 6, math.random(30,50)},
	["dye:violet"] 		= {"villagers:coins", 8, math.random(30,50)},
	["dye:blue"] 		= {"villagers:coins", 8, math.random(30,50)},
	["dye:cyan"] 		= {"villagers:coins", 8, math.random(30,50)},
	["dye:dark_green"] 	= {"villagers:coins", 8, math.random(30,50)},
	["dye:green"] 		= {"villagers:coins", 8, math.random(30,50)},
	["dye:yellow"] 		= {"villagers:coins", 3, math.random(30,50)},
	["dye:brown"] 		= {"villagers:coins", 8, math.random(30,50)},
	["dye:orange"] 		= {"villagers:coins", 8, math.random(30,50)},
	["dye:red"] 		= {"villagers:coins", 8, math.random(30,50)},
	["dye:magenta"] 	= {"villagers:coins", 8, math.random(30,50)},
	["dye:pink"] 		= {"villagers:coins", 8, math.random(30,50)},
	
	["villagers:coins_gold"] = {"villagers:coins", 10, math.random(70,90)},	
	["villagers:coins"] = {"villagers:coins_gold", 1, math.random(70,90)},
	
}

--io.write("\n## Creating DEFAULT_ITEM_NAMES table..\n")
local goodsDataCount = 1
local DEFAULT_ITEM_NAMES = {}
for key,_ in pairs(GOODS_DATA) do
	local modname = string.split(key, ":")[1]
	--io.write("\n  #"..goodsDataCount.." key="..key.." modname="..modname.." ")
	if (modname == "cottages") or (modname == "farming") then
		-- do nothing
		--io.write("Skipped. ")
	else 
		table.insert(DEFAULT_ITEM_NAMES, key)
		--io.write("Added. ")
	end
	goodsDataCount = goodsDataCount + 1
end

--io.write("\n  Complete. Resulting table data: ")
for i=1, #DEFAULT_ITEM_NAMES do
	--io.write("\n  #"..i.." "..DEFAULT_ITEM_NAMES[i])
end
--io.write("\n")


local function getGoodsData(item_name, quantity, buyback)
	local log = false
	if log then 
		io.write("\ngetGoodsData() ") 
		if buyback then io.write("playerSell ")
		else io.write("villagerSell ") end
		io.write("item_name="..item_name.." ")
	end
	
	-- if the item that villager is selling to player (or player is selling to villager)
	-- is from an optional mod but that is not installed, then use a random item from 
	-- minetest_game instead
	local modname = string.split(item_name, ":")[1]
	if log then io.write("modname="..modname.." ") end
	if (villagers.mods.cottages == nil and modname == "cottages") or
		(villagers.mods.farming == nil and modname == "farming") then
		item_name = DEFAULT_ITEM_NAMES[math.random(#DEFAULT_ITEM_NAMES)]
		if log then io.write("optionalModMissing gotRandomItem="..modname.." ") end
	end
	
	if minetest.registered_items[item_name] == nil then 
		return {"invalid_item", item_name}
	end
	if minetest.registered_items[item_name].description == nil then
		return {"no_description", item_name}
	end
	if GOODS_DATA[item_name] == nil then
		return {"naming_error", item_name}
	end
	
	-- item for player to sell villager for coins
	local goods
	if buyback then
		local purchase_item = GOODS_DATA[item_name][1]
		local itemDescription = minetest.registered_items[purchase_item].description
		local quant_received = villagers.round(GOODS_DATA[item_name][2] / 3)
		if quant_received == 0 then quantity = 1 end
		goods = {
			purchase_item, 		-- registered item name that villager is purchasing (eg. coins)
			itemDescription, 	-- description of the above item
			quant_received, 	-- quantity of the above item to receive for each purchase (typically > 1)
			item_name, 			-- cost item that player must give
			minetest.registered_items[item_name].description, 	-- description of the cost item
			quantity,			-- quantity of the cost item player must give
			GOODS_DATA[purchase_item][3]	-- stock quantity of the item to be purchased
		}
		
	-- item for villager to sell player
	else		
		--print("\n\n##item_name="..item_name)
		local cost_item_name = GOODS_DATA[item_name][1]
		goods = {
			item_name, -- registered item name that villager is purchasing
			minetest.registered_items[item_name].description, -- description of the above item
			quantity, -- quantity of the above item to receive for each purchase (typically 1)
			GOODS_DATA[item_name][1], 	-- cost item that player must give (eg. coins)
			minetest.registered_items[cost_item_name].description, 	-- description of the cost item
			GOODS_DATA[item_name][2], 	-- quantity of the cost item player must give (typically > 1)
			GOODS_DATA[item_name][3] 	-- stock quantity of the itme to be purchased
		}
	end
	
	if log then io.write("returnVal: "..minetest.serialize(goods).." ") end
	--io.write("\ngetGoodsDataEND ")
	return goods

end

-- temporary default goods for villagers until appropriate items are assigned
local DEFAULT_GOODS = { {split=0, min=1, max=1}, getGoodsData("default:dirt", 1) }

if log then io.write("\n## Creating villagers.GOODS table..\n") end
villagers.GOODS = {
	baker = {
		{split=2, min=2, max=4},			
		getGoodsData("farming:bread", 1),
		getGoodsData("farming:flour", 1),
		getGoodsData("default:apple", 1),
		getGoodsData("flowers:mushroom_red", 1),
		getGoodsData("flowers:mushroom_brown", 1),
	},
	barkeeper = {
		{split=1, min=1, max=3},
		getGoodsData("vessels:drinking_glass", 1),
		getGoodsData("default:apple", 1),
		getGoodsData("farming:bread", 1),
	},
	blacksmith = {
		{split=1, min=3, max=4},
		getGoodsData("default:sword_steel", 1),
		getGoodsData("default:axe_steel", 1),
		getGoodsData("default:pick_steel", 1),
		getGoodsData("default:shovel_steel", 1),
		getGoodsData("farming:hoe_steel", 1),
	},
	bricklayer = {
		{split=2, min=2, max=3},
		getGoodsData("default:stonebrick", 1),
		getGoodsData("default:sandstonebrick", 1),
		getGoodsData("default:clay_brick", 1),
		getGoodsData("default:desert_stonebrick", 1),
		getGoodsData("default:desert_sandstone_brick", 1),
		getGoodsData("default:silver_sandstone_brick", 1),
	},
	carpenter = {
		{split=3, min=4, max=5},
		getGoodsData("default:ladder_wood", 1),
		getGoodsData("default:fence_wood", 1),
		getGoodsData("doors:gate_wood_closed", 1),
		getGoodsData("cottages:gate_closed", 1),
		getGoodsData("default:sign_wall_wood", 1),
		getGoodsData("doors:trapdoor", 1),
		getGoodsData("boats:boat", 1),
		getGoodsData("default:chest", 1),
	},
	charachoal_burner = {
		{split=1, min=2, max=3},
		getGoodsData("default:coal_lump", 1),
		getGoodsData("default:sand", 1),
		getGoodsData("default:dirt", 1),
		getGoodsData("default:gravel", 1),
	},
	cooper = {
		{split=1, min=1, max=2},
		getGoodsData("cottages:barrel", 1),
		getGoodsData("cottages:tub", 1),
		getGoodsData("cottages:barrel_lying", 1),
	},
	coppersmith = {
		{split=1, min=3, max=4},
		getGoodsData("default:sword_bronze", 1),
		getGoodsData("default:axe_bronze", 1),
		getGoodsData("default:pick_bronze", 1),
		getGoodsData("default:shovel_bronze", 1),
		getGoodsData("farming:hoe_bronze", 1),
	},
	doormaker = {
		{split=1, min=1, max=3},
		getGoodsData("doors:door_wood_a", 1),
		getGoodsData("doors:trapdoor", 1),
		getGoodsData("doors:gate_wood_closed", 1),
	},
	dyemaker = {
		{split=0, min=3, max=5},
		getGoodsData("dye:brown", 1),
		getGoodsData("dye:dark_green", 1),
		getGoodsData("dye:black", 1),
		getGoodsData("dye:grey", 1),
		getGoodsData("dye:dark_grey", 1),
		getGoodsData("dye:white", 1),
		getGoodsData("dye:violet", 1),
		getGoodsData("dye:blue", 1),
		getGoodsData("dye:cyan", 1),
		getGoodsData("dye:green", 1),
		getGoodsData("dye:yellow", 1),
		getGoodsData("dye:orange", 1),
		getGoodsData("dye:red", 1),
		getGoodsData("dye:magenta", 1),
		getGoodsData("dye:pink", 1),
	},
	farmer = {
		{split=3, min=3, max=5},
		getGoodsData("default:apple", 1),
		getGoodsData("farming:bread", 1),
		getGoodsData("farming:wheat", 1),
		getGoodsData("farming:cotton", 1),
		getGoodsData("flowers:mushroom_red", 1),
		getGoodsData("flowers:mushroom_brown", 1),
		getGoodsData("flowers:straw", 1),
		getGoodsData("farming:string", 1),
	},
	flower_seller = {
		{split=0, min=3, max=5},
		getGoodsData("flowers:rose", 1),
		getGoodsData("flowers:tulip", 1),
		getGoodsData("flowers:dandelion_yellow", 1),
		getGoodsData("flowers:geranium", 1),
		getGoodsData("flowers:viola", 1),
		getGoodsData("flowers:dandelion_white", 1),
	},
	fruit_trader = {
		{split=0, min=1, max=1},
		getGoodsData("default:apple", 1),
	},
	furnituremaker = {
		{split=3, min=3, max=5},
		getGoodsData("cottages:table", 1),
		getGoodsData("cottages:bench", 1),
		getGoodsData("beds:bed", 1),
		-- split --
		getGoodsData("cottages:shelf", 1),
		getGoodsData("default:bookshelf", 1),
		getGoodsData("default:chest", 1),
		getGoodsData("beds:fancy_bed", 1),
		getGoodsData("vessels:shelf", 1),
	},
	glassmaker = {
		{split=0, min=3, max=5},
		getGoodsData("default:glass", 1),
		getGoodsData("vessels:glass_bottle", 1),
		getGoodsData("vessels:drinking_glass", 1),
		getGoodsData("xpanes:pane_flat", 1),
		getGoodsData("cottages:glass_pane", 1),
		getGoodsData("cottages:glass_pane_side", 1),
	},
	goldsmith = {
		{split=1, min=1, max=3},
		getGoodsData("default:goldblock", 1),
		getGoodsData("stairs:stair_goldblock", 1),
		getGoodsData("stairs:slab_goldblock", 1),
	},
	guard = {
		{split=0, min=1, max=1},
		getGoodsData("default:sword_steel", 1),
	},
	horsekeeper = {
		{split=0, min=1, max=2},
		getGoodsData("farming:straw", 1),
		getGoodsData("farming:string", 1),
	},
	iceman = {
		{split=0, min=1, max=2},
		getGoodsData("stairs:slab_ice", 1),
		getGoodsData("stairs:stair_ice", 1),
	},
	innkeeper = {
		{split=1, min=2, max=3},
		getGoodsData("beds:bed", 1),
		getGoodsData("default:chest", 1),
		getGoodsData("default:paper", 1),
		getGoodsData("default:torch", 1),
		getGoodsData("default:book", 1),
	},
	librarian = {
		{split=1, min=1, max=2},
		getGoodsData("default:book", 1),
		getGoodsData("default:paper", 1),
	},
	lumberjack = {
		{split=0, min=1, max=2},
		getGoodsData("default:wood", 1),
		getGoodsData("default:tree", 1),
	}, 
	miller = {
		{split=1, min=1, max=2},
		getGoodsData("farming:flour", 1),
		getGoodsData("farming:straw", 1),
	}, 
	
	priest = DEFAULT_GOODS,
	
	roofer = DEFAULT_GOODS,
	
	sawmill_owner = {
		{split=2, min=3, max=4},
		getGoodsData("default:wood", 1),
		getGoodsData("default:tree", 1),
		getGoodsData("default:stick", 1),
		getGoodsData("stairs:slab_wood", 1),
	}, 
	
	seed_seller = {
		{split=0, min=1, max=2},
		getGoodsData("farming:seed_cotton", 1),
		getGoodsData("farming:seed_wheat", 1),
	}, 
	
	shopkeeper = DEFAULT_GOODS,
	
	smith = {
		{split=1, min=3, max=4},
		getGoodsData("default:sword_steel", 1),
		getGoodsData("default:axe_steel", 1),
		getGoodsData("default:pick_steel", 1),
		getGoodsData("default:shovel_steel", 1),
		getGoodsData("farming:hoe_steel", 1),
	},
	
	stairmaker = DEFAULT_GOODS,
	stonemason = DEFAULT_GOODS,
	
	tinsmith = {
		{split=0, min=1, max=1},
		getGoodsData("default:tin_ingot", 1),
	}, 
	
	toolmaker = {
		{split=1, min=2, max=2},
		getGoodsData("screwdriver:screwdriver", 1),
		getGoodsData("default:shovel_steel", 1),
		getGoodsData("farming:hoe_steel", 1),
		getGoodsData("default:skeleton_key", 1),
	},
	
	trader = DEFAULT_GOODS,
	
	wheelwright = {
		{split=1, min=1, max=2},
		getGoodsData("cottages:wagon_wheel", 1),
		getGoodsData("default:stick", 1),
	}, 
	wood_trader = {
		{split=1, min=3, max=4},
		getGoodsData("default:stick", 1),
		getGoodsData("default:wood", 1),
		getGoodsData("stairs:slab_wood", 1),
		getGoodsData("cottages:wood_flat", 1),
		getGoodsData("cottages:hatch_wood", 1),
	}, 
	
	-- offers players to exchange coins for gold coins and vice versa
	major = {
		{split=0, min=2, max=2},
		{"villagers:coins_gold", "Gold Coin", 1, "villagers:coins", "Silver Coin", 11, math.random(800,999)},
		{"villagers:coins", "Silver Coin", 9, "villagers:coins_gold", "Gold Coin", 1, math.random(800,999)},
	}, 
	
	-- villagers who give coins to players for items
	
	--housemaid = {},
	--landlord = {},
	ore_seller = {
		{split=0, min=1, max=3},
		{split=0, min=1, max=3},
		getGoodsData("default:coal_lump", 1, true),
		getGoodsData("default:iron_lump", 1, true),
		getGoodsData("default:copper_lump", 1, true),
		getGoodsData("default:tin_lump", 1, true),
		getGoodsData("default:gold_lump", 1, true),
		getGoodsData("default:mese_crystal_fragment", 1, true),
	}, 
	potterer = {
		{split=0, min=1, max=2},
		getGoodsData("default:clay_lump", 1, true),
		getGoodsData("default:clay", 1, true),
	}, 
	
	saddler = {
		{split=0, min=1, max=2},
		getGoodsData("farming:cotton", 1, true),
		getGoodsData("farming:string", 1, true),
	}, 

	schoolteacher = {
		{split=0, min=1, max=2},
		getGoodsData("default:paper", 1, true),
		getGoodsData("default:book", 1, true),
	}, 

	servant = {
		{split=0, min=1, max=2},
		--getGoodsData("bucket:bucket_empty", 1, true),
		getGoodsData("default:torch", 1, true),
		getGoodsData("vessels:drinking_glass", 1, true),
		getGoodsData("default:ice", 1, true),
	}, 
	
	stoneminer = {
		{split=0, min=1, max=2},
		getGoodsData("default:stone", 1, true),
		getGoodsData("default:desert_stone", 1, true),
		getGoodsData("default:sandstone", 1, true),
		getGoodsData("default:desert_sandstone", 1, true),
		getGoodsData("default:silver_sandstone", 1, true),
	}, 
}


function villagers.getTradingFormspec(self, player_name)
	local log = false
	if log then 
		io.write("getFormspec() ") 
		io.write("for "..self.vName.." vSell:"..dump(self.vSell).."\n")
	end
		
	local item_count = #self.vSell
	
	local width_column = 1
	local width_item_count = 0.26
	local width_trade_button = 1.2
	local number_of_columns = 5
	local width_form = (width_column * number_of_columns) + (width_item_count * 2) + width_trade_button + 0.2
	
	local height_exit_button = 1
	local height_row = 1
	local height_labels = 1
	local height_between_rows = 0.4
	local number_of_rows = item_count
	local height_form = height_exit_button + ((height_row + height_between_rows) * number_of_rows) + height_labels
	
	-- GUI related stuff
	--local bg = "bgcolor[#080808BB;true]"
	local bg_image = "background[0,0;0,0;gui_formbg.png;true]"
	local y_offset = 0.4
	
	local formspec = 
		-- gui background attributes
		"size["..width_form..","..height_form.."]"..bg_image..
		
		-- header row
		"label[0.2,0;BUY]"..
		"label["..(1.5)+(width_item_count)..",0;STOCK]"..
		"label["..(2.5)+(width_item_count*2)+(0.2)..",0;COST]"..
		"label["..(3.6)+(width_item_count*3)+(width_item_count)+(0.1)..",0;INV]"
		--.."label["..4+(width_item_count*4)+(width_item_count*2)..",0;Action]"
	
	local player_inv = minetest.get_inventory({type="player", name=player_name})
	local inv_size = player_inv:get_size("main")
	
	-- construct rows for each item villager is selling
	for item_index = 1, item_count do
		
		local sell_data = self.vSell[item_index]
		local item_name = sell_data[1]
		local item_desc = sell_data[2]
		local item_quant = sell_data[3]
		local cost_name = sell_data[4]
		local cost_desc = sell_data[5]
		local cost_quant = sell_data[6]
		local item_stock = sell_data[7]
		if log then io.write("sell_data #"..item_index..": "..minetest.serialize(sell_data).." ") end
		
		local inv_quant = 0
		for i=1, inv_size do
			local stack_name = player_inv:get_stack("main",i):get_name()
			local stack_count = player_inv:get_stack("main",i):get_count()
			if stack_name == cost_name then
				inv_quant = inv_quant + stack_count
			end
		end
		
		local ypos = (item_index-0.4) + ((item_index-1)*height_between_rows)
		formspec = formspec..
			-- items
			"item_image[0,"..ypos..";1,1;"..item_name.."]".. -- item being sold
			"label[0,"..(ypos+0.8)..";"..item_desc.."]".. -- item description
			"label[0.8,"..(ypos+0.4)..";x"..item_quant.."]".. -- item count
			"label["..(1.7)+(width_item_count)..","..ypos+y_offset..";"..item_stock.."]".. -- how many in stock
			"item_image["..(2.5)+(width_item_count*2)..","..ypos..";1,1;"..cost_name.."]".. -- cost item
			"label["..(2.5)+(width_item_count*2)..","..(ypos+0.8)..";"..cost_desc.."]".. -- cost description
			"label["..(3.3)+(width_item_count*2)..","..ypos+y_offset..";x"..cost_quant.."]".. -- cost count
			"label["..(3.7)+(width_item_count*3)+(width_item_count)..","..ypos+y_offset..";"..inv_quant.."]" -- how many player has
			
		local button_name = self.vName.."|"..item_name.."|"..item_quant.."|"
		button_name = button_name..cost_name.."|"..cost_quant.."|"..item_stock.."|"..inv_quant.."|"..item_index
		if (item_stock > 0) and (inv_quant >= cost_quant) then 
			formspec = formspec.."button["..(4.2)+(width_item_count*4)+(width_item_count*2)..
				","..ypos+(0.3)..";"..width_trade_button..",0.70;"..button_name..";trade]" 
		end
		
	end
		
	formspec = formspec.. "button_exit[2.3,"..(height_form-0.8)..";2.5,"..height_exit_button..";"..self.vID..";I'm Done!]"
		
	return formspec
end

function villagers.tradeVillager(self, player)
	local log = false
	if log then io.write("trade() ") end
	
	-- if villager was digging when player initiated trade, this ensures after
	-- trading as ended that the next action is RESUMEDIG
	if self.vAction == "DIG" then
		if log then io.write("villagerWasCurrentlyDigging ") end
		self.vDigReady = true
		minetest.sound_stop(self.vSoundHandle)
		self.object:set_animation(
			{x=self.animation["stand_start"], y=self.animation["stand_end"]},
			self.animation_speed + math.random(10)
		)
	end
	
	self.vAction = "TRADE"
	
	-- formspec was already displayed and villager is currently trading
	if self.vTrading then
		local message_text = self.vName.." is busy trading with "..self.vTrading.."."
		villagers.showAlert(self, player, "", 3)
		
	-- villager is not yet trading: might be currently standing, walking, etc
	-- so create and show the tranding formspec
	else
		
		local player_name = player:get_player_name()
		self.vTrading = player_name
		self.vYawSaved = self.vYaw
		villagers.turnToPlayer(self, player)
		
		-- show formspec
		minetest.show_formspec(player_name, "villagers:trade|"..self.vID, villagers.getTradingFormspec(self, player_name))
		
		if log then 
			local items_selling = self.vSell
			io.write(self.vName.." is selling: ")
			for i=1, #items_selling do
				local item_name = string.split(items_selling[i][1], ":")[2]
				io.write(item_name.." ")
			end
		end
	end

end



function villagers.getTradeInventory(title, plot, bed, errors)
	local log = false
	if log then 
		io.write("\n## setTradeInv for "..string.upper(title).." @ plot#"..plot_num.."bed#"..bed.." ")
	end
	
	local new_trade_inventory = {}
		
	local source_trade_items = villagers.GOODS[title]
	if source_trade_items == nil then
		if log then io.write("NO-ITEMS-TO-SELL ") end
		return "none"
	end
	
	if log then io.write("\n      ## Villager trader! ## ") end
	
	local all_items = villagers.copytable(source_trade_items)
	
	local selection_parameters = table.remove(all_items, 1)
	local split_point = selection_parameters.split
	local min_count = selection_parameters.min
	local max_count = selection_parameters.max	
	local item_count = math.random(min_count, max_count)
	
	if log then 
		io.write("min="..min_count.." max="..max_count.." ") 
		io.write("got="..item_count.." ") 
		io.write("mandatoryItems="..split_point.." ") 
	end
	
	if split_point > 0 then
		for i=1, split_point do
			if log then 
				io.write("\n  mandatory #1 >> "..all_items[i][1].." ")
				io.write("item_count is now "..item_count) 
			end
			table.insert(new_trade_inventory, table.remove(all_items, i))
			item_count = item_count - 1
		end
		if log then io.write(" .. no more mandatory items.\n") end
	end
	
	if log then io.write("  item_count="..item_count.." remainingCountOf_allItemsTable="..#all_items.." ") end
	
	while( item_count > 0 ) do
		local index_to_pop = math.random(#all_items)
		local popped_item = table.remove(all_items, index_to_pop)
		
		-- error handling
		if popped_item[1] == "invalid_item" then
			if log then 
				io.write(" #ERROR Item #"..item_count.." - not a registered item '"..popped_item[2].."'.") 
			end
			local error_message = "Item #"..item_count.." '"..popped_item[2]..
			"' not registered for plot#"..plot.." bed#"..bed
			table.insert(errors, error_message)
			popped_item = {"default:dirt", "Dirt [error]", 1, "villagers:coins", 1, 1}
			
		elseif popped_item[1] == "no_description" then
			if log then 
				io.write(" #ERROR Item #"..item_count.." - no item desc for '"..popped_item[2].."'.") 
			end				
			local error_message = "Item #"..item_count.." '"..popped_item[2]..
			"' has no desc for plot#"..plot.." bed#"..bed
			table.insert(errors, error_message)
			popped_item = {"default:dirt", "Dirt [error]", 1, "villagers:coins", 1, 1}
			
		elseif popped_item[1] == "naming_error" then
			if log then 
				io.write(" #ERROR Item #"..item_count.." - '"..popped_item[2].."' not found in GOODS_DATA.") 
			end			
			local error_message = "Item #"..item_count.." '"..popped_item[2]..
			"' not in GOODS_DATA for plot#"..plot.." bed#"..bed
			table.insert(errors, error_message)
			popped_item = {"default:dirt", "Dirt [error]", 1, "villagers:coins", 1, 1}
			
		elseif popped_item == nil then
			if log then 
				io.write(" #ERROR getTradeItem #"..item_count..", it is NIL.") 
			end
			local error_message = "getTradeInventory(): Error trade item #"..item_count.." "..
				"is NIL for villager @ plot#"..plot.." bed#"..bed
			local error_message = "Item #"..item_count.." is NIL for plot#"..plot.." bed#"..bed
			table.insert(errors, error_message)
			popped_item = {"default:dirt", "Dirt [error]", 1, "villagers:coins", 1, 1}
		end
		
		if log then  io.write("\n  adding: "..minetest.serialize(popped_item).." ") end
		table.insert(new_trade_inventory, popped_item)
		item_count = item_count - 1
	end
	if log then io.write("\n") end

	return new_trade_inventory
end


function villagers.endVillagerTrading(self, player)

	if self then
		
		villagers.chatVillager(self, player, 2)
		
		-- load previous yaw value
		self.vYaw = self.vYawSaved
		
		-- resume previous action
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
		
		self.vTrading = nil
		self.vAction = "ENDTRADE"
	else
		--io.write("NoMatchingVillagerFound ")
	end
	
end
