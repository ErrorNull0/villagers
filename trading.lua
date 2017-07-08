-- ============================================ VILLAGER TRADING ==========================================
-- ========================================================================================================
-- default stock of each item villager will carry
local STOCK = {
	apple = 60, bread = 40, string = 90, mushroom_red = 40, mushroom_brown = 40,
	
	paper = 40, book = 20, 
	
	rose = 20, tulip = 20, dandelion_yellow = 20,
	geranium = 20, viola = 20, dandelion_white = 20, 
	
	dirt = 90, sand = 90, glass = 20,
	gravel = 90, clay = 90, clay_lump = 90, 
	
	tree = 90, wood = 90, stick = 90,
	boat = 10, torch = 40, 
	
	sign_wall_wood = 40, slab_wood = 90, stair_wood = 40,
	door_wood = 20, trapdoor = 20, bookshelf = 20,
	gate_wood = 40, fence_wood = 40, ladder_wood = 40,
	
	bed = 10, chest = 20, screwdriver = 10,
	
	drinking_glass = 20, straw = 90, slab_straw = 90,
	glass_bottle = 20, bucket_empty = 10,
	
	wheat = 90, flour = 90, cotton = 90, string = 90, 
	
	sword_steel = 10,
	axe_stone = 10, pick_stone = 10, shovel_stone = 10, hoe_stone = 10,
	axe_steel = 10, pick_steel = 10, shovel_steel = 10, hoe_steel = 10,
	
	gunpowder = 5, tnt = 5, skeleton_key = 5, steel_bottle = 20,
	
	iron_lump = 10, copper_lump = 5, tin_lump = 5, gold_lump = 5, 
	mese_crystal_fragment = 5, mese_crystal = 5, diamond = 5,
}

-- default cost in coins for each item
local COST = {
	apple = 2, bread = 17, 
	
	mushroom_red = 5, 	mushroom_brown = 5,
	rose = 5, tulip = 5,  dandelion_yellow = 5, geranium = 5,
	viola = 5, dandelion_white = 5, 
	
	papyrus = 2, paper = 6, book = 20, 
	
	cotton = 3, string = 3, 
	wheat = 2, straw = 7, slab_straw = 4, flour = 9,
	
	dirt = 1,  gravel = 2, wool = 5,
	sand = 2, glass = 4, glass_bottle = 1, drinking_glass = 8, 
	clay_lump = 5, clay = 22, clay_brick = 23, brick = 100,
	
	cobble = 3, stone = 6, 
	
	-- coal burn time = 40
	coal_lump = 20, coal_block = 190,
	gunpowder = 25, tnt = 150, 
	
	stick = 1, slab_wood = 3, wood = 5, tree = 23, 
	stair_wood = 7, trapdoor = 16, door_wood = 33, 
	torch = 8, sign_wall_wood = 11, bookshelf = 100,
	bed = 34, boat = 28, chest = 44, 
 
	ladder_wood = 1, fence_wood = 24, gate_wood = 16,
	
	iron_lump = 80,				steel_ingot = 100, 
	copper_lump = 160, 			copper_ingot = 180, 
	tin_lump = 160,				tin_ingot = 180, 
								bronze_ingot = 200, 
	gold_lump = 280, 			gold_ingot = 300,  
	mese_crystal_fragment = 70, mese_crystal = 550,
								diamond = 995,
								
	screwdriver = 105, locked_chest = 150, skeleton_key = 190, bucket_empty = 280, 
	door_steel = 620, steel_bottle = 550,
	
	shovel_wood = 8, 	shovel_stone = 9,	shovel_steel = 105,	shovel_bronze = 185,
	pick_wood = 16, 	pick_stone = 21, 	pick_steel = 305,	pick_bronze = 560,
	sword_wood = 12, 	sword_stone = 14,	sword_steel = 205,	sword_bronze = 365,
	axe_wood = 18, 		axe_stone = 21,  	axe_steel = 305,  	axe_bronze = 565, 
	hoe_wood = 13, 		hoe_stone = 15,		hoe_steel = 205,	hoe_bronze = 365,
}

-- default stock and cost values for assigning to some common building/plot schem types
local DEFAULTS = {
	farm_full = {
		{split=4, min=6, max=8},			
		{"default:apple", STOCK.apple, "villagers:coins", COST.apple},
		{"farming:bread", STOCK.bread, "villagers:coins", COST.bread},
		{"farming:wheat", STOCK.wheat, "villagers:coins", COST.wheat}, 
		{"farming:flour", STOCK.flour, "villagers:coins", COST.flour}, 
		-- split --
		{"flowers:mushroom_red", STOCK.mushroom_red, "villagers:coins", COST.mushroom_red},
		{"flowers:mushroom_brown", STOCK.mushroom_brown, "villagers:coins", COST.mushroom_brown}, 						
		{"farming:straw", STOCK.straw, "villagers:coins", COST.straw}, 
		{"farming:cotton", STOCK.cotton, "villagers:coins", COST.cotton}, 
		{"farming:string", STOCK.string, "villagers:coins", COST.string},
	},
	farm_tiny = {
		{split=2, min=3, max=4},			
		{"farming:bread", STOCK.bread, "villagers:coins", COST.bread},
		{"farming:wheat", STOCK.wheat, "villagers:coins", COST.wheat}, 
		-- split --
		{"farming:flour", STOCK.flour, "villagers:coins", COST.flour}, 
		{"default:apple", STOCK.apple, "villagers:coins", COST.apple},
		{"farming:straw", STOCK.straw, "villagers:coins", COST.straw}, 
		{"farming:cotton", STOCK.cotton, "villagers:cotton", COST.cotton}, 
		{"farming:string", STOCK.string, "villagers:coins", COST.string},
		{"flowers:mushroom_red", STOCK.mushroom_red, "villagers:coins", COST.mushroom_red},
		{"flowers:mushroom_brown", STOCK.mushroom_brown, "villagers:coins", COST.mushroom_brown}, 						
	},
	wagon = {
		{split=0, min=1, max=1},			
		{"farming:straw", STOCK.straw, "villagers:coins", COST.straw}, 
		{"stairs:slab_straw", STOCK.slab_straw, "villagers:coins", COST.slab_straw},
		{"farming:string", STOCK.string, "villagers:coins", COST.string}
	},
	shed = {
		{split=0, min=2, max=5},			
		{"bucket:bucket_empty", STOCK.bucket_empty, "villagers:coins", COST.bucket_empty},
		{"default:hoe_stone", STOCK.hoe_stone, "villagers:coins", COST.hoe_stone},
		{"default:shovel_stone", STOCK.shovel_stone, "villagers:coins", COST.shovel_stone},
		{"default:axe_stone", STOCK.axe_stone, "villagers:coins", COST.axe_stone},
		{"default:pick_stone", STOCK.pick_stone, "villagers:coins", COST.pick_stone},
		{"default:ladder_wood", STOCK.ladder_wood, "villagers:coins", COST.ladder_wood},
		{"default:fence_wood", STOCK.fence_wood, "villagers:coins", COST.fence_wood},
		{"default:gate_wood", STOCK.gate_wood, "villagers:coins", COST.gate_wood},
		{"default:pick_stone", STOCK.pick_stone, "villagers:coins", COST.pick_stone},
		{"default:sign_wall_wood", STOCK.sign_wall_wood, "villagers:coins", COST.sign_wall_wood},
		{"default:door_wood_a", STOCK.door_wood, "villagers:coins", COST.door_wood},
		{"default:slab_wood", STOCK.slab_wood, "villagers:coins", COST.slab_wood},
		{"default:torch", STOCK.torch, "villagers:coins", COST.torch},
		{"boats:boat", STOCK.boat, "villagers:coins", COST.boat},
		{"screwdriver:screwdriver", STOCK.screwdriver, "villagers:coins", COST.screwdriver},
	},
	bakery = {
		{split=2, min=3, max=4},			
		{"farming:bread", STOCK.bread, "villagers:coins", COST.bread},
		{"farming:flour", STOCK.flour, "villagers:coins", COST.flour},
		-- split --
		{"farming:wheat", STOCK.wheat, "villagers:coins", COST.wheat}, 
		{"default:apple", STOCK.apple, "villagers:coins", COST.apple},
		{"flowers:mushroom_red", STOCK.mushroom_red, "villagers:coins", COST.mushroom_red},
		{"flowers:mushroom_brown", STOCK.mushroom_brown, "villagers:coins", COST.mushroom_brown}, 
	},

	tavern = {
		{split=1, min=1, max=3},
		{"vessels:drinking_glass", STOCK.drinking_glass, "villagers:coins", COST.drinking_glass},
		-- split --
		{"default:apple", STOCK.apple, "villagers:coins", COST.apple}, 
		{"farming:bread", STOCK.bread, "villagers:coins", COST.bread}, 
	},
	church = {
		{split=2, min=2, max=3},
		{"default:book", STOCK.book, "villagers:coins", COST.book},
		{"farming:bread", STOCK.bread, "villagers:coins", COST.bread},
		-- split -- 
		{"vessels:glass_bottle", STOCK.glass_bottle, "villagers:coins", COST.glass_bottle},
		{"default:paper", STOCK.paper, "villagers:coins", COST.paper},
	},
	forge = {
		{split=1, min=3, max=4},
		{"default:sword_steel", STOCK.sword_steel, "villagers:coins", COST.sword_steel},
		-- split --
		{"default:axe_steel", STOCK.axe_steel, "villagers:coins", COST.axe_steel},
		{"default:pick_steel", STOCK.pick_steel, "villagers:coins", COST.pick_steel},
		{"default:shovel_steel", STOCK.shovel_steel, "villagers:coins", COST.shovel_steel},
		{"default:hoe_steel", STOCK.hoe_steel, "villagers:coins", COST.hoe_steel},
	},
	
	-- random treasure
	treasure = {
		{split=0, min=1, max=1},
		{"default:iron_lump", STOCK.iron_lump, "villagers:coins", COST.iron_lump}, 
		{"default:copper_lump", STOCK.copper_lump, "villagers:coins", COST.copper_lump}, 
		{"default:tin_lump", STOCK.tin_lump, "villagers:coins", COST.tin_lump}, 
		{"default:gold_lump", STOCK.gold_lump, "villagers:coins", COST.gold_lump}, 
		{"default:mese_crystal_fragment", STOCK.mese_crystal_fragment, "villagers:coins", COST.mese_crystal_fragment}, 
		{"default:mese_crystal", STOCK.mese_crystal, "villagers:coins", COST.mese_crystal}, 
		{"default:diamond", STOCK.diamond, "villagers:coins", COST.diamond}, 
		{"tnt:tnt", STOCK.tnt, "villagers:coins", COST.tnt}, 
	},
}


--[[
	A random number of items between 'min' and 'max' are chosen from
	the corresponding table 'ITEMS.[building_type].[scm_type].
	Items from index = 1 to index = 'split' in the table are chosen
	first as priority.
--]]
villagers.ITEMS = {

	-- traders that give a few coins for small resources that are common to all villages
	small_jobs = {
		{"villagers:coins", 999, "default:sapling", 1},
		{"villagers:coins", 999, "default:junglesapling", 1},
		{"villagers:coins", 999, "default:pine_sapling", 1},
		{"villagers:coins", 999, "default:acacia_sapling", 1},
		{"villagers:coins", 999, "default:aspen_sapling", 1},
		
		{"villagers:coins", 999, "default:dry_shrub", 1},
		{"villagers:coins", 999, "default:bush_stem", 1},
		{"villagers:coins", 999, "default:bush_sapling", 1},
		
		{"villagers:coins", 999, "default:coral_skeleton", 1},
		{"villagers:coins", 999, "default:acacia_bush_stem", 1},
		{"villagers:coins", 999, "default:acacia_bush_sapling", 1},
		{"villagers:coins", 999, "default:cactus", 3}
	},
	
	tent = {
		tent_open_1 = {  --shop
			{split=4, min=3, max=5},
			{"default:torch", STOCK.torch, "villagers:coins", COST.torch},
			{"default:apple", STOCK.apple, "villagers:coins", COST.apple}, 
			{"flowers:mushroom_red", STOCK.mushroom_red, "villagers:coins", COST.mushroom_red},
			{"flowers:mushroom_brown", STOCK.mushroom_brown, "villagers:coins", COST.mushroom_brown},
			-- tier split --
			{"farming:string", STOCK.string, "villagers:coins", COST.string},
			{"farming:cotton", STOCK.cotton, "villagers:coins", COST.cotton},
			{"flowers:rose", STOCK.rose, "villagers:coins", COST.rose},
			{"flowers:tulip", STOCK.tulip, "villagers:coins", COST.tulip},
			{"flowers:dandelion_yellow", STOCK.dandelion_yellow, "villagers:coins", COST.dandelion_yellow},
			{"flowers:geranium", STOCK.geranium, "villagers:coins", COST.geranium},
			{"flowers:viola", STOCK.viola, "villagers:coins", COST.viola},
			{"flowers:dandelion_white", STOCK.dandelion_white, "villagers:coins", COST.dandelion_white}
		},
		tent_open_2 = {  --shop
			{split=4, min=3, max=5},
			{"default:torch", STOCK.torch, "villagers:coins", COST.torch},
			{"default:apple", STOCK.apple, "villagers:coins", COST.apple}, 
			{"flowers:mushroom_red", STOCK.mushroom_red, "villagers:coins", COST.mushroom_red},
			{"flowers:mushroom_brown", STOCK.mushroom_brown, "villagers:coins", COST.mushroom_brown},
			-- tier split --
			{"farming:string", STOCK.string, "villagers:coins", COST.string},
			{"farming:cotton", STOCK.cotton, "villagers:coins", COST.cotton},
			{"flowers:rose", STOCK.rose, "villagers:coins", COST.rose},
			{"flowers:tulip", STOCK.tulip, "villagers:coins", COST.tulip},
			{"flowers:dandelion_yellow", STOCK.dandelion_yellow, "villagers:coins", COST.dandelion_yellow},
			{"flowers:geranium", STOCK.geranium, "villagers:coins", COST.geranium},
			{"flowers:viola", STOCK.viola, "villagers:coins", COST.viola},
			{"flowers:dandelion_white", STOCK.dandelion_white, "villagers:coins", COST.dandelion_white}
		},
		tent_open_3 = {  --shop
			{split=4, min=3, max=5},
			{"default:torch", STOCK.torch, "villagers:coins", COST.torch},
			{"default:apple", STOCK.apple, "villagers:coins", COST.apple}, 
			{"flowers:mushroom_red", STOCK.mushroom_red, "villagers:coins", COST.mushroom_red},
			{"flowers:mushroom_brown", STOCK.mushroom_brown, "villagers:coins", COST.mushroom_brown},
			-- tier split --
			{"farming:string", STOCK.string, "villagers:coins", COST.string},
			{"farming:cotton", STOCK.cotton, "villagers:coins", COST.cotton},
			{"flowers:rose", STOCK.rose, "villagers:coins", COST.rose},
			{"flowers:tulip", STOCK.tulip, "villagers:coins", COST.tulip},
			{"flowers:dandelion_yellow", STOCK.dandelion_yellow, "villagers:coins", COST.dandelion_yellow},
			{"flowers:geranium", STOCK.geranium, "villagers:coins", COST.geranium},
			{"flowers:viola", STOCK.viola, "villagers:coins", COST.viola},
			{"flowers:dandelion_white", STOCK.dandelion_white, "villagers:coins", COST.dandelion_white}
		},
		tent_open_big_1 = DEFAULTS.tavern,
		tent_open_big_2 = { --church
			{split=2, min=2, max=3},
			{"farming:bread", STOCK.bread, "villagers:coins", COST.bread}, 
			{"default:book", STOCK.book, "villagers:coins", COST.book},
			-- tier split --
			{"vessels:glass_bottle", STOCK.glass_bottle, "villagers:coins", COST.glass_bottle},
			{"default:paper", STOCK.paper, "villagers:coins", COST.paper},
		},
		tent_open_big_3 = { --townhall
			{split=0, min=1, max=1},
			{"default:steel_ingot", 3, "default:clay_lump", 30},
			{"default:steel_ingot", 3, "group:wool", 30},
			{"default:steel_ingot", 3, "farming:cotton", 50}
		}
	},
	charachoal = {
		charachoal_hill = {
			{split=1, min=1, max=3},
			{"default:sand", STOCK.sand, "villagers:coins", COST.sand},
			-- tier split --
			{"default:dirt", STOCK.dirt, "villagers:coins", COST.dirt},
			{"default:gravel", STOCK.gravel, "villagers:coins", COST.gravel}
		},
		charachoal_hut = { -- ensure only %25 of these villagers will desire this
			{split=0, min=1, max=1},
			{"default:steel_ingot", 3, "default:clay_lump", 30},
			{"default:steel_ingot", 3, "default:coal_lump", 20},
			{"default:steel_ingot", 3, "default:flint", 10}
		}
	},
	claytrader = {
		clay_pit_1 = {
			{split=0, min=1, max=2},
			{"default:clay", STOCK.clay, "villagers:coins", COST.clay},
			{"default:clay_lump", STOCK.clay_lump, "villagers:coins", COST.clay_lump}
		}, 
		clay_pit_2 = {
			{"default:clay", STOCK.clay, "villagers:coins", COST.clay},
			{"default:clay_lump", STOCK.clay_lump, "villagers:coins", COST.clay_lump}
		}, 
		clay_pit_3 = {
			{"default:clay", STOCK.clay, "villagers:coins", COST.clay},
			{"default:clay_lump", STOCK.clay_lump, "villagers:coins", COST.clay_lump}
		}, 
		clay_pit_4 = {
			{"default:clay", STOCK.clay, "villagers:coins", COST.clay},
			{"default:clay_lump", STOCK.clay_lump, "villagers:coins", COST.clay_lump}
		}, 
		clay_pit_5 = {
			{"default:clay", STOCK.clay, "villagers:coins", COST.clay},
			{"default:clay_lump", STOCK.clay_lump, "villagers:coins", COST.clay_lump}
		}, 
		trader_clay_5 = { -- ensure only %25 of these villagers will desire this
			{split=0, min=1, max=1},
			{"default:bronze_ingot", 3, "default:clay_lump", 60},
			{"default:bronze_ingot", 3, "default:coal_lump", 30},
			{"default:bronze_ingot", 3, "group:tree", 30}
		}
	},
	lumberjack = {
		lumberjack_stable = {
			{split=0, min=1, max=2},
			{"farming:straw", STOCK.straw, "villagers:coins", COST.straw}, 
			{"stairs:slab_straw", STOCK.slab_straw, "villagers:coins", COST.slab_straw}, 
		}, 
		lumberjack_pub_1 = DEFAULTS.tavern,
		lumberjack_church_1 = {
			{split=2, min=2, max=3},
			{"default:book", STOCK.book, "villagers:coins", COST.book},
			{"farming:bread", STOCK.bread, "villagers:coins", COST.bread},
			-- split -- 
			{"vessels:glass_bottle", STOCK.glass_bottle, "villagers:coins", COST.glass_bottle},
			{"default:paper", STOCK.paper, "villagers:coins", COST.paper},
		}, 
		lumberjack_hotel_1 = {
			{split=1, min=2, max=3},
			{"beds:bed", STOCK.bed, "villagers:coins", COST.bed},
			-- split --
			{"default:chest", STOCK.chest, "villagers:coins", COST.chest},
			{"default:paper", STOCK.paper, "villagers:coins", COST.paper},
			{"default:torch", STOCK.torch, "villagers:coins", COST.torch},
			{"default:book", STOCK.book, "villagers:coins", COST.book},
		},
		lumberjack_shop_1 = {
			{split=2, min=6, max=10},
			{"default:wood", STOCK.wood, "villagers:coins", COST.wood},
			{"default:tree", STOCK.tree, "villagers:coins", COST.tree},
			-- split --
			{"default:stick", STOCK.stick, "villagers:coins", COST.stick},
			{"boats:boat", STOCK.boat, "villagers:coins", COST.boat},
			{"default:sign_wall_wood", STOCK.sign_wall_wood, "villagers:coins", COST.sign_wall_wood},
			{"stairs:slab_wood", STOCK.slab_wood, "villagers:coins", COST.slab_wood},
			{"stairs:stair_wood", STOCK.stair_wood, "villagers:coins", COST.stair_wood},
			{"doors:door_wood", STOCK.door_wood, "villagers:coins", COST.door_wood},
			{"doors:trapdoor", STOCK.trapdoor, "villagers:coins", COST.trapdoor},
			{"default:fence_wood", STOCK.fence_wood, "villagers:coins", COST.fence_wood},
			{"default:ladder_wood", STOCK.ladder_wood, "villagers:coins", COST.ladder_wood},
		}, 
		lumberjack_sawmill_1 = {
			{split=0, min=2, max=2},
			{"default:wood", STOCK.wood, "villagers:coins", COST.wood},
			{"default:tree", STOCK.tree, "villagers:coins", COST.tree},
		},
		lumberjack_8 = {	
			-- ensure only %25 of these villagers will desire this
			{split=0, min=1, max=1},
			{"default:bronze_ingot", 3, "default:coal_lump", 30},
			{"default:bronze_ingot", 3, "farming:cotton", 100},
			{"default:bronze_ingot", 3, "group:wool", 60}
		}
		
	},
	logcabin = {
		logcabinpub1 = DEFAULTS.tavern,
		logcabinpub2 = DEFAULTS.tavern,
		logcabinpub3 = DEFAULTS.tavern,
		logcabin11 = {	
			-- ensure only %25 of these villagers will desire this
			{split=0, min=1, max=1},
			{"default:bronze_ingot", 3, "farming:straw", 60},
			{"default:bronze_ingot", 3, "default:coal_lump", 30},
			{"default:bronze_ingot", 3, "default:clay_lump", 60},
		}
		
	},
	
	nore = {
		wheat_field = {
			{split=1, min=1, max=2},
			{"farming:straw", STOCK.straw, "villagers:coins", COST.straw}, 
			-- split --
			{"farming:wheat", STOCK.wheat, "villagers:coins", COST.wheat}, 
		}, 
		cotton_field = {
			{split=1, min=1, max=2},
			{"farming:cotton", STOCK.cotton, "villagers:coins", COST.cotton}, 
			-- split --
			{"farming:string", STOCK.string, "villagers:coins", COST.string}, 
		}, 
		fountain = {	
			-- ensure only %25 of these villagers will desire this
			{split=0, min=1, max=1},
			{"default:gold_ingot", 3, "default:papyrus", 220},
			{"default:gold_ingot", 3, "default:clay", 20},
			{"default:gold_ingot", 3, "default:coal_lump", 45}
		},
		house_with_garden_1_0 = {
			{split=3, min=3, max=6},
			{"default:apple", STOCK.apple, "villagers:coins", COST.apple},
			{"farming:bread", STOCK.bread, "villagers:coins", COST.bread},
			{"farming:wheat", STOCK.wheat, "villagers:coins", COST.wheat}, 
			-- split --
			{"farming:cotton", STOCK.cotton, "villagers:cotton", COST.cotton}, 
			{"flowers:mushroom_red", STOCK.mushroom_red, "villagers:coins", COST.mushroom_red},
			{"flowers:mushroom_brown", STOCK.mushroom_brown, "villagers:coins", COST.mushroom_brown}, 						
			{"flowers:rose", STOCK.rose, "villagers:coins", COST.rose},
			{"flowers:tulip", STOCK.tulip, "villagers:coins", COST.tulip},
			{"flowers:dandelion_yellow", STOCK.dandelion_yellow, "villagers:coins", COST.dandelion_yellow},
			{"flowers:geranium", STOCK.geranium, "villagers:coins", COST.geranium},
			{"flowers:viola", STOCK.viola, "villagers:coins", COST.viola},
			{"flowers:dandelion_white", STOCK.dandelion_white, "villagers:coins", COST.dandelion_white}
		},
		church_1_0 = {
			{split=2, min=2, max=3},
			{"farming:bread", STOCK.bread, "villagers:coins", COST.bread}, 
			{"default:book", STOCK.book, "villagers:coins", COST.book},
			-- tier split --
			{"vessels:glass_bottle", STOCK.glass_bottle, "villagers:coins", COST.glass_bottle},
			{"default:paper", STOCK.paper, "villagers:coins", COST.paper},
		}, 
		tower_1_0 = {
			{split=0, min=1, max=1},
			{"default:stick", STOCK.stick, "villagers:coins", COST.stick},
		}, 
		forge_1_0 = DEFAULTS.forge,
		library_1_0 = {
			{split=1, min=1, max=2},
			{"default:book", STOCK.book, "villagers:coins", COST.book},
			-- split --
			{"default:paper", STOCK.paper, "villagers:coins", COST.paper},
			{"default:bookshelf", STOCK.bookshelf, "villagers:coins", COST.bookshelf},
		}, 
		inn_1_0 = { 
			{split=1, min=2, max=3},
			{"beds:bed", STOCK.bed, "villagers:coins", COST.bed},
			-- split --
			{"default:chest", STOCK.chest, "villagers:coins", COST.chest},
			{"default:torch", STOCK.torch, "villagers:coins", COST.torch},
			{"default:paper", STOCK.paper, "villagers:coins", COST.paper},
			{"default:book", STOCK.book, "villagers:coins", COST.book},
		}, 
		pub_1_0 = DEFAULTS.tavern,
		--well = STREETMERCHANT.well, 
	},
	medieval = {
		church_1 = {
			{split=2, min=2, max=3},
			{"farming:bread", STOCK.bread, "villagers:coins", COST.bread}, 
			{"default:book", STOCK.book, "villagers:coins", COST.book},
			-- tier split --
			{"vessels:glass_bottle", STOCK.glass_bottle, "villagers:coins", COST.glass_bottle},
			{"default:paper", STOCK.paper, "villagers:coins", COST.paper},
		}, 
		forge_1 = DEFAULTS.forge,
		mill_1 = {
			{split=1, min=1, max=2},
			{"farming:flour", STOCK.flour, "villagers:coins", COST.flour},
			-- split --
			{"farming:straw", STOCK.straw, "villagers:coins", COST.straw},
		}, 
		watermill_1 = {
			{split=1, min=1, max=2},
			{"farming:flour", STOCK.flour, "villagers:coins", COST.flour},
			-- split --
			{"farming:straw", STOCK.straw, "villagers:coins", COST.straw},
		}, 
		farm_full_1 = DEFAULTS.farm_full,
		farm_full_2 = DEFAULTS.farm_full,
		farm_full_3 = DEFAULTS.farm_full,
		farm_full_4 = DEFAULTS.farm_full,
		farm_full_5 = DEFAULTS.farm_full,
		farm_full_6 = DEFAULTS.farm_full, 
		farm_tiny_1 = DEFAULTS.farm_tiny,
		farm_tiny_2 = DEFAULTS.farm_tiny,
		farm_tiny_3 = DEFAULTS.farm_tiny,
		farm_tiny_4 = DEFAULTS.farm_tiny,
		farm_tiny_5 = DEFAULTS.farm_tiny,
		farm_tiny_6 = DEFAULTS.farm_tiny,
		farm_tiny_7 = DEFAULTS.farm_tiny,
		taverne_1 = DEFAULTS.tavern,
		taverne_2 = DEFAULTS.tavern,
		taverne_3 = DEFAULTS.tavern,
		taverne_4 = DEFAULTS.tavern,
		wagon_1 = DEFAULTS.wagon,
		wagon_2 = DEFAULTS.wagon,
		wagon_3 = DEFAULTS.wagon, 
		wagon_4 = DEFAULTS.wagon, 
		wagon_5 = DEFAULTS.wagon, 
		wagon_6 = DEFAULTS.wagon, 
		wagon_7 = DEFAULTS.wagon, 
		wagon_8 = DEFAULTS.wagon,
		wagon_9 = DEFAULTS.wagon, 
		wagon_10 = DEFAULTS.wagon,
		wagon_11 = DEFAULTS.wagon,
		wagon_12 = DEFAULTS.wagon,
		shed_1 = DEFAULTS.shed,
		shed_2 = DEFAULTS.shed,
		shed_3 = DEFAULTS.shed,
		shed_4 = DEFAULTS.shed,
		shed_5 = DEFAULTS.shed,
		shed_6 = DEFAULTS.shed,
		shed_7 = DEFAULTS.shed,
		shed_8 = DEFAULTS.shed,
		shed_9 = DEFAULTS.shed,
		shed_10 = DEFAULTS.shed,
		shed_11 = DEFAULTS.shed,
		shed_12 = DEFAULTS.shed,
		baking_house_1 = DEFAULTS.shed,
		baking_house_2 = DEFAULTS.shed, 
		baking_house_3 = DEFAULTS.shed, 
		baking_house_4 = DEFAULTS.shed,
		cow_shed_1_270 = DEFAULTS.shed, 
		shed_with_forge_v2_1_0 = {
			{split=5, min=7, max=9},			
			{"default:sword_steel", STOCK.sword_steel, "villagers:coins", COST.sword_steel},
			{"default:axe_steel", STOCK.axe_steel, "villagers:coins", COST.axe_steel},
			{"default:pick_steel", STOCK.pick_steel, "villagers:coins", COST.pick_steel},
			{"default:shovel_steel", STOCK.shovel_steel, "villagers:coins", COST.shovel_steel},
			{"default:hoe_steel", STOCK.hoe_steel, "villagers:coins", COST.hoe_steel},
			-- split --
			{"bucket:bucket_empty", STOCK.bucket_empty, "villagers:coins", COST.bucket_empty},
			{"default:ladder_wood", STOCK.ladder_wood, "villagers:coins", COST.ladder_wood},
			{"default:fence_wood", STOCK.fence_wood, "villagers:coins", COST.fence_wood},
			{"default:gate_wood", STOCK.gate_wood, "villagers:coins", COST.gate_wood},
			{"default:pick_stone", STOCK.pick_stone, "villagers:coins", COST.pick_stone},
			{"default:sign_wall_wood", STOCK.sign_wall_wood, "villagers:coins", COST.sign_wall_wood},
			{"default:door_wood_a", STOCK.door_wood, "villagers:coins", COST.door_wood},
			{"default:slab_wood", STOCK.slab_wood, "villagers:coins", COST.slab_wood},
			{"default:torch", STOCK.torch, "villagers:coins", COST.torch},
			{"boats:boat", STOCK.boat, "villagers:coins", COST.boat},
			{"screwdriver:screwdriver", STOCK.screwdriver, "villagers:coins", COST.screwdriver},
		},
		--tree_place_1
		--tree_place_2
		--tree_place_3 
		--tree_place_4
		--tree_place_5
		--tree_place_6
		--tree_place_7 
		--tree_place_8
		--tree_place_9
		--tree_place_10
		--field_1
		--field_2
		--field_3
		--field_4
		--well_1 = ALLITEMS.tier1,
		--well_2 = ALLITEMS.tier1,
		--well_3 = ALLITEMS.tier1,
		--well_4 = ALLITEMS.tier1,
		--well_5 = ALLITEMS.tier1,
		--well_6 = ALLITEMS.tier1,
		--well_7 = ALLITEMS.tier1,
		--well_8 = ALLITEMS.tier1,
	},
	gambit = {
		gambit_church_1_0_180 = DEFAULTS.church,
		gambit_forge_1_2_270 = DEFAULTS.forge,
		gambit_library_hotel_0_180 = {
			{split=2, min=3, max=4},
			{"beds:bed", STOCK.bed, "villagers:coins", COST.bed},
			{"default:torch", STOCK.torch, "villagers:coins", COST.torch},
			-- split --
			{"default:paper", STOCK.paper, "villagers:coins", COST.paper},
			{"default:book", STOCK.book, "villagers:coins", COST.book},
			{"default:bookshelf", STOCK.bookshelf, "villagers:coins", COST.bookshelf},
			{"default:chest", STOCK.chest, "villagers:coins", COST.chest},
		}, 
		
		gambit_pub_1_0_0 = DEFAULTS.tavern,
		gambit_shed_open_chests_2_0 = DEFAULTS.shed,
		
		gambit_shop_0_90 = {
			{split=3, min=4, max=6},
			{"farming:bread", STOCK.bread, "villagers:coins", COST.bread},
			{"default:apple", STOCK.apple, "villagers:coins", COST.apple},
			-- split --
			{"farming:flour", STOCK.flour, "villagers:coins", COST.flour},
			{"farming:string", STOCK.string, "villagers:coins", COST.string},
			{"flowers:mushroom_red", STOCK.mushroom_red, "villagers:coins", COST.mushroom_red},
			{"flowers:mushroom_brown", STOCK.mushroom_brown, "villagers:coins", COST.mushroom_brown},
			
			{"default:torch", STOCK.torch, "villagers:coins", COST.torch},
			{"boats:boat", STOCK.boat, "villagers:coins", COST.boat},
			
			{"default:hoe_stone", STOCK.hoe_stone, "villagers:coins", COST.hoe_stone},
			{"default:shovel_stone", STOCK.shovel_stone, "villagers:coins", COST.shovel_stone},
			{"default:axe_stone", STOCK.axe_stone, "villagers:coins", COST.axe_stone},
			{"default:pick_stone", STOCK.pick_stone, "villagers:coins", COST.pick_stone},
			{"bucket:bucket_empty", STOCK.bucket_empty, "villagers:coins", COST.bucket_empty},
			{"screwdriver:screwdriver", STOCK.screwdriver, "villagers:coins", COST.screwdriver},
			
			{"stairs:slab_wood", STOCK.slab_wood, "villagers:coins", COST.slab_wood},
			{"stairs:stair_wood", STOCK.stair_wood, "villagers:coins", COST.stair_wood},
			{"doors:door_wood", STOCK.door_wood, "villagers:coins", COST.door_wood},
			{"doors:trapdoor", STOCK.trapdoor, "villagers:coins", COST.trapdoor},
			{"default:sign_wall_wood", STOCK.sign_wall_wood, "villagers:coins", COST.sign_wall_wood},
			{"default:fence_wood", STOCK.fence_wood, "villagers:coins", COST.fence_wood},
			{"default:gate_wood", STOCK.gate_wood, "villagers:coins", COST.gate_wood},
			{"default:ladder_wood", STOCK.ladder_wood, "villagers:coins", COST.ladder_wood},
		},
		gambit_shop_large_0_0 = {
			{split=3, min=7, max=9},
			{"farming:bread", STOCK.bread, "villagers:coins", COST.bread},
			{"default:apple", STOCK.apple, "villagers:coins", COST.apple},
			{"farming:flour", STOCK.flour, "villagers:coins", COST.flour},
			-- split --
			{"farming:string", STOCK.string, "villagers:coins", COST.string},
			{"flowers:mushroom_red", STOCK.mushroom_red, "villagers:coins", COST.mushroom_red},
			{"flowers:mushroom_brown", STOCK.mushroom_brown, "villagers:coins", COST.mushroom_brown},
			
			{"default:torch", STOCK.torch, "villagers:coins", COST.torch},
			{"boats:boat", STOCK.boat, "villagers:coins", COST.boat},
			
			{"default:hoe_stone", STOCK.hoe_stone, "villagers:coins", COST.hoe_stone},
			{"default:shovel_stone", STOCK.shovel_stone, "villagers:coins", COST.shovel_stone},
			{"default:axe_stone", STOCK.axe_stone, "villagers:coins", COST.axe_stone},
			{"default:pick_stone", STOCK.pick_stone, "villagers:coins", COST.pick_stone},
			{"bucket:bucket_empty", STOCK.bucket_empty, "villagers:coins", COST.bucket_empty},
			{"screwdriver:screwdriver", STOCK.screwdriver, "villagers:coins", COST.screwdriver},
			
			{"stairs:slab_wood", STOCK.slab_wood, "villagers:coins", COST.slab_wood},
			{"stairs:stair_wood", STOCK.stair_wood, "villagers:coins", COST.stair_wood},
			{"doors:door_wood", STOCK.door_wood, "villagers:coins", COST.door_wood},
			{"doors:trapdoor", STOCK.trapdoor, "villagers:coins", COST.trapdoor},
			{"default:sign_wall_wood", STOCK.sign_wall_wood, "villagers:coins", COST.sign_wall_wood},
			{"default:fence_wood", STOCK.fence_wood, "villagers:coins", COST.fence_wood},
			{"default:gate_wood", STOCK.gate_wood, "villagers:coins", COST.gate_wood},
			{"default:ladder_wood", STOCK.ladder_wood, "villagers:coins", COST.ladder_wood},
			
			{"flowers:rose", STOCK.rose, "villagers:coins", COST.rose},
			{"flowers:tulip", STOCK.tulip, "villagers:coins", COST.tulip},
			{"flowers:dandelion_yellow", STOCK.dandelion_yellow, "villagers:coins", COST.dandelion_yellow},
			{"flowers:geranium", STOCK.geranium, "villagers:coins", COST.geranium},
			{"flowers:viola", STOCK.viola, "villagers:coins", COST.viola},
			{"flowers:dandelion_white", STOCK.dandelion_white, "villagers:coins", COST.dandelion_white}
		},
		
		gambit_stable_1_2_90 = DEFAULTS.wagon,
		
		gambit_cementry_0_180 = {	
			-- ensure only %25 of these villagers will desire this
			{split=0, min=1, max=1},
			{"default:mese_crystal", 3, "default:torch", 110},
			{"default:mese_crystal", 3, "group:wool", 170},
			{"default:mese_crystal", 3, "farming:straw", 170}
		},
		
		--gambit_fountain_1_1_90
		--gambit_field_1_1_90
		--gambit_tower_1_0_270
		
	},
	
	taoki = {
		default_town_farm = DEFAULTS.farm_full,
		default_town_fountain = {	
			-- ensure only %25 of these villagers will desire this
			{split=0, min=1, max=1},
			{"default:mese_crystal", 3, "tnt:gunpowder", 35},
			{"default:mese_crystal", 3, "default:clay", 40},
			{"default:mese_crystal", 3, "farming:cotton", 280},
			{"default:mese_crystal", 3, "default:flint", 50},
		}
		--default_town_tower = {},
		--default_town_well = {},
	},
	
	cornernote = {
		towntest_kddekadenz_barn1_1_90 = DEFAULTS.shed, --shed
		towntest_kddekadenz_barn2_1_90 = DEFAULTS.shed, --shed
		towntest_kddekadenz_factory_1_90 = {
			{split=5, min=8, max=10},			
			{"default:sword_steel", STOCK.sword_steel, "villagers:coins", COST.sword_steel},
			{"default:axe_steel", STOCK.axe_steel, "villagers:coins", COST.axe_steel},
			{"default:pick_steel", STOCK.pick_steel, "villagers:coins", COST.pick_steel},
			{"default:shovel_steel", STOCK.shovel_steel, "villagers:coins", COST.shovel_steel},
			{"default:hoe_steel", STOCK.hoe_steel, "villagers:coins", COST.hoe_steel},
			-- split --
			{"bucket:bucket_empty", STOCK.bucket_empty, "villagers:coins", COST.bucket_empty},
			{"default:ladder_wood", STOCK.ladder_wood, "villagers:coins", COST.ladder_wood},
			{"default:fence_wood", STOCK.fence_wood, "villagers:coins", COST.fence_wood},
			{"default:gate_wood", STOCK.gate_wood, "villagers:coins", COST.gate_wood},
			{"default:pick_stone", STOCK.pick_stone, "villagers:coins", COST.pick_stone},
			{"default:sign_wall_wood", STOCK.sign_wall_wood, "villagers:coins", COST.sign_wall_wood},
			{"default:door_wood_a", STOCK.door_wood, "villagers:coins", COST.door_wood},
			{"default:slab_wood", STOCK.slab_wood, "villagers:coins", COST.slab_wood},
			{"default:torch", STOCK.torch, "villagers:coins", COST.torch},
			{"boats:boat", STOCK.boat, "villagers:coins", COST.boat},
			{"screwdriver:screwdriver", STOCK.screwdriver, "villagers:coins", COST.screwdriver},
		}, --shed
		towntest_kddekadenz_windmill_0_90 = {
			{split=1, min=1, max=2},
			{"farming:flour", STOCK.flour, "villagers:coins", COST.flour},
			-- split --
			{"farming:straw", STOCK.straw, "villagers:coins", COST.straw},
		},
		towntest_Nanuk_chapel_1_180 = DEFAULTS.church,
		towntest_kddekadenz_castle_3_90 = { 
			-- ensure only %25 of these villagers will desire this
			{split=0, min=1, max=1},
			{"default:diamond", 3, "default:clay_brick", 70},
			{"default:diamond", 3, "default:iron_lump", 20},
			{"default:diamond", 3, "tnt:tnt", 10},
			{"default:diamond", 3, "default:flint", 100},
			{"default:diamond", 3, "default:tin_lump", 100},
		},
		towntest_cornernote_fortress_4_0 = { 
			-- ensure only %25 of these villagers will desire this
			{split=0, min=1, max=1},
			{"default:diamond", 3, "default:clay_brick", 70},
			{"default:diamond", 3, "default:iron_lump", 20},
			{"default:diamond", 3, "tnt:tnt", 10},
			{"default:diamond", 3, "default:flint", 100},
			{"default:diamond", 3, "default:tin_lump", 100},
		},
		--towntest_Nanuk_well_0_90
		--towntest_cornernote_tower_1_90 --tower
		--towntest_cornernote_turret_1_90 --tower
		--towntest_Nanuk_lavabeacon_0_90 --tower
	},
	sandcity = {
		sandcity_ap_tower_1_1_270 = {
			{split=0, min=1, max=1},
			{"default:wood", STOCK.wood, "villagers:coins", COST.wood},
			{"default:glass", STOCK.glass, "villagers:coins", COST.glass},
			{"vessels:steel_bottle", STOCK.steel_bottle, "villagers:coins", COST.steel_bottle},
		}, --tower
		sandcity_ap_tower_2_1_270 = {
			{split=0, min=1, max=1},
			{"default:wood", STOCK.wood, "villagers:coins", COST.wood},
			{"default:glass", STOCK.glass, "villagers:coins", COST.glass},
			{"vessels:steel_bottle", STOCK.steel_bottle, "villagers:coins", COST.steel_bottle},
		}, --tower
		sandcity_ap_tower_3_1_270 = {
			{split=0, min=1, max=1},
			{"default:wood", STOCK.wood, "villagers:coins", COST.wood},
			{"default:glass", STOCK.glass, "villagers:coins", COST.glass},
			{"vessels:steel_bottle", STOCK.steel_bottle, "villagers:coins", COST.steel_bottle},
		}, --tower
		sandcity_ap_tower_4_1_270 = {
			{split=0, min=1, max=1},
			{"default:wood", STOCK.wood, "villagers:coins", COST.wood},
			{"default:glass", STOCK.glass, "villagers:coins", COST.glass},
			{"vessels:steel_bottle", STOCK.steel_bottle, "villagers:coins", COST.steel_bottle},
		}, --tower
		sandcity_ap_tower_5_1_270 = {
			{split=0, min=1, max=1},
			{"default:wood", STOCK.wood, "villagers:coins", COST.wood},
			{"default:glass", STOCK.glass, "villagers:coins", COST.glass},
			{"vessels:steel_bottle", STOCK.steel_bottle, "villagers:coins", COST.steel_bottle},
		}, --tower
		sandcity_ap_tower_6_1_270 = {
			{split=0, min=1, max=1},
			{"default:wood", STOCK.wood, "villagers:coins", COST.wood},
			{"default:glass", STOCK.glass, "villagers:coins", COST.glass},
			{"vessels:steel_bottle", STOCK.steel_bottle, "villagers:coins", COST.steel_bottle},
		}, --tower
		sandcity_ap_tower_7_1_270 = {
			{split=0, min=1, max=1},
			{"default:wood", STOCK.wood, "villagers:coins", COST.wood},
			{"default:glass", STOCK.glass, "villagers:coins", COST.glass},
			{"vessels:steel_bottle", STOCK.steel_bottle, "villagers:coins", COST.steel_bottle},
		}, --tower
		sandcity_meeting_small_1_1_270  = { 
			-- ensure only %25 of these villagers will desire this
			{split=0, min=1, max=1},
			{"default:diamond", 3, "default:clay_brick", 70},
			{"default:diamond", 3, "flowers:dandelion_white", 300},
			{"default:diamond", 3, "default:bronze_lump", 10},
		}
	}
	
}


function villagers.getTradingFormspec(self, player)
	if villagers.log4 then 
		io.write("getFormspec() ") 
		io.write("for "..self.vName.." vSell:"..dump(self.vSell).."\n")
	end
		
	local item_count = #self.vSell
	
	local width_column = 1
	local width_item_count = 0.25
	local width_trade_button = 1.2
	local number_of_columns = 5
	local width_form = (width_column * number_of_columns) + (width_item_count * 2) + width_trade_button
	
	local height_exit_button = 1
	local height_row = 1
	local height_labels = 1
	local number_of_rows = item_count
	local height_form = height_exit_button + (height_row * number_of_rows) + height_labels
	
	-- GUI related stuff
	--local bg = "bgcolor[#080808BB;true]"
	local bg_image = "background[0,0;0,0;gui_formbg.png;true]"
	local y_offset = 0.4
	
	local formspec = 
		-- gui background attributes
		"size["..width_form..","..height_form.."]"..bg_image..
		
		-- header row
		"label[0,0;Item]"..
		"label["..1+(width_item_count)..",0;Stock]"..
		"label["..2+(width_item_count*2)+(0.2)..",0;Villager\nWants]"..
		"label["..3+(width_item_count*3)+(width_item_count)+(0.3)..",0;You\nHave]"
		--.."label["..4+(width_item_count*4)+(width_item_count*2)..",0;Action]"
	
	local player_inv = minetest.get_inventory({type="player", name=player:get_player_name()})
	local inv_size = player_inv:get_size("main")
	
	-- construct rows for each item villager is selling
	for item_index = 1, item_count do
		
		local sell_data = self.vSell[item_index]
		local item_name = sell_data[1]
		local item_stock = sell_data[2]
		local cost_name = sell_data[3]
		local cost_amount = sell_data[4]
		
		local quantity_inv = 0
		for i=1, inv_size do
			local stack_name = player_inv:get_stack("main",i):get_name()
			local stack_count = player_inv:get_stack("main",i):get_count()
			if stack_name == cost_name then
				quantity_inv = quantity_inv + stack_count
			end
		end
		
		formspec = formspec..
			-- items
			"item_image[0,"..item_index..";1,1;"..item_name.."]".. -- item being sold
			"label["..1.2+(width_item_count)..","..item_index+y_offset..";"..item_stock.."]".. -- how many in stock
			"item_image["..2+(width_item_count*2)..","..item_index..";1,1;"..cost_name.."]".. -- item villager wants
			"label["..2.8+(width_item_count*2)..","..item_index+y_offset..";x"..cost_amount.."]".. -- want how many
			"item_image["..3+(width_item_count*3)+(width_item_count)..","..item_index..";1,1;"..cost_name.."]".. -- what player has
			"label["..3.8+(width_item_count*3)+(width_item_count)..","..item_index+y_offset..";x"..quantity_inv.."]" -- how many player has
			
		local button_name = self.vName.."|"..item_name.."|"..cost_amount.."|"..item_stock.."|"..cost_name.."|"..quantity_inv.."|"..item_index
		if (item_stock > 0) and (quantity_inv >= cost_amount) then 
			formspec = formspec.."button["..4+(width_item_count*4)+(width_item_count*2)..
				","..item_index+(0.2)..";"..width_trade_button..",0.70;"..button_name..";trade]" 
		end
		
	end
		
	formspec = formspec.. "button_exit[2.1,"..(item_count+1.2)..";2.5,"..height_exit_button..";"..self.vName.."_"..self.vID..";I'm Done!]"
		
	return formspec
end

function villagers.tradeVillager(self, player)
	if villagers.log4 then io.write("trade() ") end
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
		minetest.show_formspec(player_name, "villagers:trade_"..self.vID, villagers.getTradingFormspec(self, player))
		
		if villagers.log4 then 
			local items_selling = self.vSell
			io.write(self.vName.." is selling: ")
			for i=1, #items_selling do
				local item_name = string.split(items_selling[i][1], ":")[2]
				io.write(item_name.." ")
			end
		end
	end

end

function villagers.getTradeInventory(self, village_type, schem_type, trading_type)
	if villagers.log4 then 
		io.write("\n## setTradeInv for "..self.vName.." ["..self.vType.."] ") 
		io.write("village="..village_type.." schem="..schem_type.." ")
	end
	
	local new_trade_inventory = {}
			
	-- villager has no profession and simply offers a coin for a small resource item
	if trading_type == "smalljobs" then
		self.vIsTrader = true
		local random_index = math.random(#villagers.ITEMS.small_jobs)
		table.insert(new_trade_inventory, villagers.ITEMS.small_jobs[random_index])
		
	-- villager offers normal range of goods according to their profession
	elseif trading_type == "sell" then
		
		local source_trade_items = villagers.ITEMS[village_type][schem_type]
		if source_trade_items == nil then
			if villagers.log4 then io.write("NO-ITEMS-TO-SELL ") end
			return "none"
		end
		
		if villagers.log5 then io.write("\n      ## Villager trader! ## ") end
		
		self.vIsTrader = true;
		
		local all_items = villagers.copytable(source_trade_items)
		
		local selection_parameters = table.remove(all_items, 1)
		local split_point = selection_parameters.split
		local min_count = selection_parameters.min
		local max_count = selection_parameters.max	
		local item_count = math.random(min_count, max_count)
		
		if villagers.log4 then 
			io.write("min="..min_count.." max="..max_count.." ") 
			io.write("got="..item_count.." ") 
			io.write("mandatoryItems="..split_point.." ") 
		end
		
		if split_point > 0 then
			for i=1, split_point do
				if villagers.log4 then 
					io.write("\n  mandatory #1 >> "..all_items[i][1].." ")
					io.write("item_count is now "..item_count) 
				end
				table.insert(new_trade_inventory, table.remove(all_items, i))
				item_count = item_count - 1
			end
			if villagers.log4 then io.write(" .. no more mandatory items.\n") end
		end
		
		if villagers.log4 then io.write("  item_count="..item_count.." remainingCountOf_allItemsTable="..#all_items.." ") end
		
		while( item_count > 0 ) do
			local index_to_pop = math.random(#all_items)
			local popped_item = table.remove(all_items, index_to_pop)
			local item_name = popped_item[1]
			local item_stock = popped_item[2]
			local cost_name = popped_item[3]
			local cost_amount = popped_item[4]
			
			if villagers.log4 then 
				io.write("\n  adding "..item_name.."("..item_stock..") for "..cost_name.."("..cost_amount..") ") 
			end
			
			table.insert(new_trade_inventory, popped_item)
			item_count = item_count - 1
		end
		if villagers.log4 then io.write("\n") end
		
	-- implementation of this may not be necessary yet
	--elseif trading_type == "buy"
		
	else
		print("## ERROR Invalid trading_type: "..trading_type.." ##")
	end
	
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