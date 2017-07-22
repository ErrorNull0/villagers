-- ============================================ VILLAGER TRADING ==========================================
-- ========================================================================================================
-- default stock of each item villager will carry

-- Costs and Stock of all goods: index 1 is cost, index 2 is stock
local CS = {
	["default:apple"] 			= {2, math.random(70,90)},
	["flowers:mushroom_red"] 	= {5, math.random(50,70)},
	["flowers:mushroom_brown"] 	= {5, math.random(50,70)},
	
	["flowers:rose"] 				= {5, math.random(30,50)},
	["flowers:tulip"] 				= {5, math.random(30,50)},
	["flowers:dandelion_yellow"]	= {5, math.random(30,50)},
	["flowers:geranium"] 			= {5, math.random(30,50)},
	["flowers:viola"] 				= {5, math.random(30,50)},
	["flowers:dandelion_white"] 	= {5, math.random(30,50)},
	
	["default:papyrus"] 	= {2, math.random(30,50)},
	["default:paper"] 		= {6, math.random(30,50)},
	["default:book"]		= {20, math.random(20,40)},
	
	["farming:cotton"] 		= {3, math.random(80,99)},
	["farming:string"] 		= {3, math.random(90,99)},
	["farming:wheat"] 		= {2, math.random(60,80)},
	["farming:straw"] 		= {7, math.random(60,80)},
	
	["farming:flour"] 		= {9, math.random(60,80)},
	["farming:bread"] 		= {17, math.random(30,40)},
	
	["default:ice"] 		= {5, math.random(70,90)},

	
	["default:dirt"] 				= {1, math.random(70,90)},
	["default:gravel"] 				= {2, math.random(70,90)},
	["group:wool"] 					= {999, math.random(60,80)},
	["default:sand"] 				= {2, math.random(70,90)},
	["default:glass"] 				= {4, math.random(40,60)},
	["vessels:glass_bottle"] 		= {1, math.random(30,40)},
	["vessels:drinking_glass"] 		= {8, math.random(20,30)},
	["cottages:glass_pane"] 		= {2, math.random(30,50)},
	["xpanes:pane_flat"] 			= {14, math.random(30,50)},
	["cottages:glass_pane_side"]	= {14, math.random(30,50)},
	
	["default:clay_lump"] 	= {5, math.random(60,80)},
	["default:clay"] 		= {22, math.random(40,60)},
	["default:clay_brick"] 	= {23, math.random(40,60)},
	["default:cobble"] 		= {3, math.random(60,80)},
	["default:stone"] 		= {6, math.random(60,80)},
	
	["default:stonebrick"] 			= {25, math.random(60,80)},
	["default:desert_stonebrick"] 		= {30, math.random(60,80)},
	["default:sandstonebrick"] 			= {30, math.random(60,80)},
	["default:desert_sandstone_brick"] 	= {30, math.random(60,80)},
	["default:silver_sandstone_brick"] 	= {30, math.random(60,80)},
	["default:brick"] 					= {100, math.random(60,80)},
	
	["default:stick"] 		= {1, math.random(80,99)},
	["default:wood"] 		= {5, math.random(60,70)},
	["default:tree"] 		= {23, math.random(50,60)},
	["default:ladder_wood"] = {3, math.random(40,50)},
	["cottages:table"] 		= {5, math.random(20,30)},
	["cottages:bench"] 		= {8, math.random(20,30)},
	
	["default:fence_wood"] 		= {24, math.random(40,60)},
	["doors:gate_wood_closed"] 	= {16, math.random(30,50)},
	["doors:door_wood_a"] 	= {33, math.random(30,50)},
	["default:sign_wall_wood"] 	= {11, math.random(40,60)},
	["doors:trapdoor"] 			= {16, math.random(40,60)},
	["default:chest"] 			= {44, math.random(30,50)},
	["boats:boat"] 				= {28, math.random(20,30)},
	["beds:bed"] 				= {34, math.random(20,30)},
	["beds:fancy_bed"] 			= {40, math.random(10,20)},
	["default:bookshelf"] 		= {100, math.random(30,40)},
	["cottages:shelf"] 			= {18, math.random(30,40)},
	["vessels:shelf"] 			= {50, math.random(30,40)},
	["cottages:tub"] 			= {20, math.random(50,70)},
	["cottages:barrel"] 		= {40, math.random(60,80)},
	["cottages:barrel_lying"] 	= {40, math.random(60,80)},
	["cottages:wood_flat"] 		= {1, math.random(70,90)},
	["cottages:hatch_wood"] 	= {5, math.random(40,60)},
	["cottages:wagon_wheel"] 	= {5, math.random(40,60)},
	["cottages:gate_closed"] 	= {12, math.random(30,50)},
	
	-- STAIRS --
	["stairs:stair_wood"]	 		= {7, math.random(30,50)},
	["stairs:stair_pine_wood"] 		= {9, math.random(30,50)},
	["stairs:stair_junglewood"] 	= {10, math.random(30,50)},
	["stairs:stair_acacia_wood"] 	= {10, math.random(30,50)},
	
	["stairs:slab_wood"] 			= {3, math.random(60,80)},
	
	["stairs:slab_straw"] 			= {4, math.random(40,60)},
	["stairs:stair_straw"] 			= {7, math.random(30,50)},
	
	["stairs:slab_ice"] 			= {3, math.random(70,90)},
	["stairs:stair_ice"] 			= {5, math.random(40,60)},
	
	["stairs:stair_sandstone"] 					= {5, math.random(40,60)},
	["stairs:stair_sandstone_block"] 			= {5, math.random(40,60)},
	["stairs:stair_sandstonebrick"] 			= {5, math.random(40,60)},
	["stairs:stair_desert_sandstone"] 			= {5, math.random(40,60)},
	["stairs:stair_desert_sandstone_block"] 	= {5, math.random(40,60)},
	["stairs:stair_desert_sandstone_brick"] 	= {5, math.random(40,60)},
	
	["stairs:stair_"] 			= {5, math.random(40,60)},
	["stairs:stair_"] 			= {5, math.random(40,60)},
	["stairs:stair_"] 			= {5, math.random(40,60)},
	["stairs:stair_"] 			= {5, math.random(40,60)},
	["stairs:stair_"] 			= {5, math.random(40,60)},
	["stairs:stair_"] 			= {5, math.random(40,60)},
	["stairs:stair_"] 			= {5, math.random(40,60)},
	["stairs:stair_"] 			= {5, math.random(40,60)},
	["stairs:stair_"] 			= {5, math.random(40,60)},
	
	
	["default:coal_lump"] 		= {20, math.random(60,80)},
	["default:coalblock"] 		= {190, math.random(30,50)},
	["default:torch"] 			= {10, math.random(30,50)},
	["tnt:gunpowder"] 			= {25, math.random(30,50)},
	["tnt:tnt"] 				= {150, math.random(20,40)},
	
	["default:iron_lump"] 				= {80, math.random(70,90)},
	["default:copper_lump"] 			= {160, math.random(60,80)},
	["default:tin_lump"] 				= {160, math.random(60,80)},
	["default:gold_lump"] 				= {280, math.random(30,40)},
	["default:mese_crystal_fragment"] 	= {70, math.random(70,90)},
	["default:steel_ingot"] 			= {100, math.random(60,80)},
	["default:copper_ingot"] 			= {180, math.random(60,80)},
	["default:tin_ingot"] 				= {180, math.random(60,80)},
	["default:bronze_ingot"] 			= {200, math.random(60,80)},
	["default:gold_ingot"] 				= {300, math.random(30,50)},	
	["default:mese_crystal"] 			= {550, math.random(20,40)},
	["default:diamond"] 				= {995, math.random(20,40)},
	
	["default:goldblock"] 			= {2800, math.random(20,30)},
	["stairs:stair_goldblock"] 	= {1000, math.random(20,30)},
	["stairs:slab_goldblock"] 		= {1400, math.random(20,30)},
	
	["screwdriver:screwdriver"] = {105, math.random(30,50)},
	["default:chest_locked"] 	= {150, math.random(30,50)},
	["default:skeleton_key"] 	= {190, math.random(30,50)},
	["bucket:bucket_empty"] 	= {280, math.random(40,60)},
	["default:door_steel"] 		= {620, math.random(20,40)},
	["vessels:steel_bottle"] 	= {550, math.random(20,40)},
	
	["default:shovel_wood"] 	= {8, math.random(30,50)},
	["default:shovel_stone"] 	= {9, math.random(30,50)},
	["default:shovel_steel"] 	= {105, math.random(30,50)},
	["default:shovel_bronze"] 	= {185, math.random(30,50)},
	["default:pick_wood"] 		= {16, math.random(30,50)},
	["default:pick_stone"] 		= {21, math.random(30,50)},
	["default:pick_steel"] 		= {305, math.random(30,50)},
	["default:pick_bronze"] 	= {560, math.random(30,50)},
	["default:sword_wood"] 		= {12, math.random(20,40)},
	["default:sword_stone"] 	= {14, math.random(20,40)},
	["default:sword_steel"] 	= {205, math.random(20,40)},
	["default:sword_bronze"] 	= {365, math.random(20,40)},
	["default:axe_wood"] 		= {18, math.random(20,40)},
	["default:axe_stone"] 		= {21, math.random(20,40)},
	["default:axe_steel"] 		= {305, math.random(20,40)},
	["default:axe_bronze"] 		= {565, math.random(20,40)},
	["farming:hoe_wood"] 		= {13, math.random(30,50)},
	["farming:hoe_stone"] 		= {15, math.random(30,50)},
	["farming:hoe_steel"] 		= {205, math.random(30,50)},
	["farming:hoe_bronze"] 		= {365, math.random(30,50)},
	
	["dye:white"] 		= {3, math.random(30,50)},
	["dye:grey"] 		= {8, math.random(30,50)},
	["dye:dark_grey"] 	= {8, math.random(30,50)},
	["dye:black"] 		= {6, math.random(30,50)},
	["dye:violet"] 		= {8, math.random(30,50)},
	["dye:blue"] 		= {8, math.random(30,50)},
	["dye:cyan"] 		= {8, math.random(30,50)},
	["dye:dark_green"] 	= {8, math.random(30,50)},
	["dye:green"] 		= {8, math.random(30,50)},
	["dye:yellow"] 		= {3, math.random(30,50)},
	["dye:brown"] 		= {8, math.random(30,50)},
	["dye:orange"] 		= {8, math.random(30,50)},
	["dye:red"] 		= {8, math.random(30,50)},
	["dye:magenta"] 	= {8, math.random(30,50)},
	["dye:pink"] 		= {8, math.random(30,50)},
	
	["villagers:coin_gold"] = {10, math.random(70,90)},	
	
}


-- temporary default goods for villagers until appropriate
-- items are assigned
local DEFAULT_GOODS = {
	{split=0, min=1, max=1},
	{"default:dirt", CS["default:dirt"][2], "villagers:coins", CS["default:dirt"][1]},
}

villagers.GOODS = {
	
	baker = {
		{split=2, min=3, max=4},			
		{"farming:bread", CS["farming:bread"][2], "villagers:coins", CS["farming:bread"][1]},
		{"farming:flour", CS["farming:flour"][2], "villagers:coins", CS["farming:flour"][1]},
		-- split --
		{"farming:wheat", CS["farming:wheat"][2], "villagers:coins", CS["farming:wheat"][1]}, 
		{"default:apple", CS["default:apple"][2], "villagers:coins", CS["default:apple"][1]},
		{"flowers:mushroom_red", CS["flowers:mushroom_red"][2], "villagers:coins", CS["flowers:mushroom_red"][1]},
		{"flowers:mushroom_brown", CS["flowers:mushroom_brown"][2], "villagers:coins", CS["flowers:mushroom_brown"][1]}, 
	},
	barkeeper = {
		{split=1, min=1, max=3},
		{"vessels:drinking_glass", CS["vessels:drinking_glass"][2], "villagers:coins", CS["vessels:drinking_glass"][1]},
		-- split --
		{"default:apple", CS["default:apple"][2], "villagers:coins", CS["default:apple"][1]}, 
		{"farming:bread", CS["farming:bread"][2], "villagers:coins", CS["farming:bread"][1]}, 
	},
	blacksmith = {
		{split=1, min=3, max=4},
		{"default:sword_steel", CS["default:sword_steel"][2], "villagers:coins", CS["default:sword_steel"][1]},
		-- split --
		{"default:axe_steel", CS["default:axe_steel"][2], "villagers:coins", CS["default:axe_steel"][1]},
		{"default:pick_steel", CS["default:pick_steel"][2], "villagers:coins", CS["default:pick_steel"][1]},
		{"default:shovel_steel", CS["default:shovel_steel"][2], "villagers:coins", CS["default:shovel_steel"][1]},
		{"farming:hoe_steel", CS["farming:hoe_steel"][2], "villagers:coins", CS["farming:hoe_steel"][1]},
	},
	bricklayer = {
		{split=2, min=2, max=3},
		{"default:stonebrick", CS["default:stonebrick"][2], "villagers:coins", CS["default:stonebrick"][1]},
		{"default:sandstonebrick", CS["default:sandstonebrick"][2], "villagers:coins", CS["default:sandstonebrick"][1]},
		-- split --
		{"default:clay_brick", CS["default:clay_brick"][2], "villagers:coins", CS["default:clay_brick"][1]},
		{"default:desert_stonebrick", CS["default:desert_stonebrick"][2], "villagers:coins", CS["default:desert_stonebrick"][1]},
		{"default:desert_sandstone_brick", CS["default:desert_sandstone_brick"][2], "villagers:coins", CS["default:desert_sandstone_brick"][1]},
		{"default:silver_sandstone_brick", CS["default:silver_sandstone_brick"][2], "villagers:coins", CS["default:silver_sandstone_brick"][1]},
	},
	carpenter = {
		{split=3, min=4, max=5},
		{"default:ladder_wood", CS["default:ladder_wood"][2], "villagers:coins", CS["default:ladder_wood"][1]},
		{"default:fence_wood", CS["default:fence_wood"][2], "villagers:coins", CS["default:fence_wood"][1]},
		{"doors:gate_wood_closed", CS["doors:gate_wood_closed"][2], "villagers:coins", CS["doors:gate_wood_closed"][1]},
		-- split --
		{"cottages:gate_closed", CS["cottages:gate_closed"][2], "villagers:coins", CS["cottages:gate_closed"][1]},
		{"default:sign_wall_wood", CS["default:sign_wall_wood"][2], "villagers:coins", CS["default:sign_wall_wood"][1]},
		{"doors:trapdoor", CS["doors:trapdoor"][2], "villagers:coins", CS["doors:trapdoor"][1]},
		{"boats:boat", CS["boats:boat"][2], "villagers:coins", CS["boats:boat"][1]},
		{"default:chest", CS["default:chest"][2], "villagers:coins", CS["default:chest"][1]},
	},
	charachoal_burner = {
		{split=1, min=2, max=3},
		{"default:coal_lump", CS["default:coal_lump"][2], "villagers:coins", CS["default:coal_lump"][1]},
		-- split --
		{"default:sand", CS["default:sand"][2], "villagers:coins", CS["default:sand"][1]},
		{"default:dirt", CS["default:dirt"][2], "villagers:coins", CS["default:dirt"][1]},
		{"default:gravel", CS["default:gravel"][2], "villagers:coins", CS["default:gravel"][1]},
	},
	cooper = {
		{split=1, min=1, max=2},
		{"cottages:barrel", CS["cottages:barrel"][2], "villagers:coins", CS["cottages:barrel"][1]},
		-- split --
		{"cottages:tub", CS["cottages:tub"][2], "villagers:coins", CS["cottages:tub"][1]},
		{"cottages:barrel_lying", CS["cottages:barrel_lying"][2], "villagers:coins", CS["cottages:barrel_lying"][1]},
	},
	coppersmith = {
		{split=1, min=3, max=4},
		{"default:sword_bronze", CS["default:sword_bronze"][2], "villagers:coins", CS["default:sword_bronze"][1]},
		-- split --
		{"default:axe_bronze", CS["default:axe_bronze"][2], "villagers:coins", CS["default:axe_bronze"][1]},
		{"default:pick_bronze", CS["default:pick_bronze"][2], "villagers:coins", CS["default:pick_bronze"][1]},
		{"default:shovel_bronze", CS["default:shovel_bronze"][2], "villagers:coins", CS["default:shovel_bronze"][1]},
		{"farming:hoe_bronze", CS["farming:hoe_bronze"][2], "villagers:coins", CS["farming:hoe_bronze"][1]},
	},
	doormaker = {
		{split=1, min=1, max=3},
		{"doors:door_wood_a", CS["doors:door_wood_a"][2], "villagers:coins", CS["doors:door_wood_a"][1]},
		-- split --
		{"doors:trapdoor", CS["doors:trapdoor"][2], "villagers:coins", CS["doors:trapdoor"][1]},
		{"doors:gate_wood_closed", CS["doors:gate_wood_closed"][2], "villagers:coins", CS["doors:gate_wood_closed"][1]},
	},
	dyemaker = {
		{split=5, min=6, max=8},
		{"dye:brown", CS["dye:brown"][2], "villagers:coins", CS["dye:brown"][1]},
		{"dye:dark_green", CS["dye:dark_green"][2], "villagers:coins", CS["dye:dark_green"][1]},
		{"dye:black", CS["dye:black"][2], "villagers:coins", CS["dye:black"][1]},
		{"dye:grey", CS["dye:grey"][2], "villagers:coins", CS["dye:grey"][1]},
		{"dye:dark_grey", CS["dye:dark_grey"][2], "villagers:coins", CS["dye:dark_grey"][1]},
		-- split --
		{"dye:white", CS["dye:white"][2], "villagers:coins", CS["dye:white"][1]},
		{"dye:violet", CS["dye:violet"][2], "villagers:coins", CS["dye:violet"][1]},
		{"dye:blue", CS["dye:blue"][2], "villagers:coins", CS["dye:blue"][1]},
		{"dye:cyan", CS["dye:cyan"][2], "villagers:coins", CS["dye:cyan"][1]},
		{"dye:green", CS["dye:green"][2], "villagers:coins", CS["dye:green"][1]},
		{"dye:yellow", CS["dye:yellow"][2], "villagers:coins", CS["dye:yellow"][1]},
		{"dye:orange", CS["dye:orange"][2], "villagers:coins", CS["dye:orange"][1]},
		{"dye:red", CS["dye:red"][2], "villagers:coins", CS["dye:red"][1]},
		{"dye:magenta", CS["dye:magenta"][2], "villagers:coins", CS["dye:magenta"][1]},
		{"dye:pink", CS["dye:pink"][2], "villagers:coins", CS["dye:pink"][1]},
	},
	farmer = {
		{split=4, min=6, max=8},
		{"default:apple", CS["default:apple"][2], "villagers:coins", CS["default:apple"][1]},
		{"farming:bread", CS["farming:bread"][2], "villagers:coins", CS["farming:bread"][1]},
		{"farming:wheat", CS["farming:wheat"][2], "villagers:coins", CS["farming:wheat"][1]}, 
		{"farming:cotton", CS["farming:cotton"][2], "villagers:coins", CS["farming:cotton"][1]}, 
		-- split --
		{"flowers:mushroom_red", CS["flowers:mushroom_red"][2], "villagers:coins", CS["flowers:mushroom_red"][1]},
		{"flowers:mushroom_brown", CS["flowers:mushroom_brown"][2], "villagers:coins", CS["flowers:mushroom_brown"][1]}, 						
		{"farming:straw", CS["farming:straw"][2], "villagers:coins", CS["farming:straw"][1]}, 
		{"farming:string", CS["farming:string"][2], "villagers:coins", CS["farming:string"][1]},
	},
	flower_seller = {
		{split=0, min=4, max=6},
		{"flowers:rose", CS["flowers:rose"][2], "villagers:coins", CS["flowers:rose"][1]},
		{"flowers:tulip", CS["flowers:tulip"][2], "villagers:coins", CS["flowers:tulip"][1]},
		{"flowers:dandelion_yellow", CS["flowers:dandelion_yellow"][2], "villagers:coins", CS["flowers:dandelion_yellow"][1]},
		{"flowers:geranium", CS["flowers:geranium"][2], "villagers:coins", CS["flowers:geranium"][1]},
		{"flowers:viola", CS["flowers:viola"][2], "villagers:coins", CS["flowers:viola"][1]},
		{"flowers:dandelion_white", CS["flowers:dandelion_white"][2], "villagers:coins", CS["flowers:dandelion_white"][1]},
	},
	fruit_trader = {
		{split=0, min=1, max=1},
		{"default:apple", CS["default:apple"][2], "villagers:coins", CS["default:apple"][1]},
	},
	furnituremaker = {
		{split=3, min=3, max=5},
		{"cottages:table", CS["cottages:table"][2], "villagers:coins", CS["cottages:table"][1]},
		{"cottages:bench", CS["cottages:bench"][2], "villagers:coins", CS["cottages:bench"][1]},
		{"beds:bed", CS["beds:bed"][2], "villagers:coins", CS["beds:bed"][1]},
		-- split --
		{"cottages:shelf", CS["cottages:shelf"][2], "villagers:coins", CS["cottages:shelf"][1]},
		{"default:bookshelf", CS["default:bookshelf"][2], "villagers:coins", CS["default:bookshelf"][1]},
		{"default:chest", CS["default:chest"][2], "villagers:coins", CS["default:chest"][1]},
		{"beds:fancy_bed", CS["beds:fancy_bed"][2], "villagers:coins", CS["beds:fancy_bed"][1]},
		{"vessels:shelf", CS["vessels:shelf"][2], "villagers:coins", CS["vessels:shelf"][1]},
	},
	glassmaker = {
		{split=0, min=3, max=5},
		{"default:glass", CS["default:glass"][2], "villagers:coins", CS["default:glass"][1]},
		{"vessels:glass_bottle", CS["vessels:glass_bottle"][2], "villagers:coins", CS["vessels:glass_bottle"][1]},
		{"vessels:drinking_glass", CS["vessels:drinking_glass"][2], "villagers:coins", CS["vessels:drinking_glass"][1]},
		{"xpanes:pane_flat", CS["xpanes:pane_flat"][2], "villagers:coins", CS["xpanes:pane_flat"][1]},
		{"cottages:glass_pane", CS["cottages:glass_pane"][2], "villagers:coins", CS["cottages:glass_pane"][1]},
		{"cottages:glass_pane_side", CS["cottages:glass_pane_side"][2], "villagers:coins", CS["cottages:glass_pane_side"][1]},
	},
	goldsmith = {
		{split=1, min=1, max=3},
		{"default:goldblock", CS["default:goldblock"][2], "villagers:coins", CS["default:goldblock"][1]},
		-- split --
		{"stairs:stair_goldblock", CS["stairs:stair_goldblock"][2], "villagers:coins", CS["stairs:stair_goldblock"][1]},
		{"stairs:slab_goldblock", CS["stairs:slab_goldblock"][2], "villagers:coins", CS["stairs:slab_goldblock"][1]},
	},
	guard = {
		{split=0, min=1, max=1},
		{"default:sword_steel", 2, "villagers:coins", CS["default:sword_steel"][1]},
	},
	horsekeeper = {
		{split=0, min=1, max=2},			
		{"farming:straw", CS["farming:straw"][2], "villagers:coins", CS["farming:straw"][1]}, 
		{"farming:string", CS["farming:string"][2], "villagers:coins", CS["farming:string"][1]},
	},
	iceman = {
		{split=0, min=1, max=2},			
		{"stairs:slab_ice", CS["stairs:slab_ice"][2], "villagers:coins", CS["stairs:slab_ice"][1]}, 
		{"stairs:stair_ice", CS["stairs:stair_ice"][2], "villagers:coins", CS["stairs:stair_ice"][1]},
	},
	innkeeper = {
		{split=1, min=2, max=3},
		{"beds:bed", CS["beds:bed"][2], "villagers:coins", CS["beds:bed"][1]}, 
		-- split --
		{"default:chest", CS["default:chest"][2], "villagers:coins", CS["default:chest"][1]},
		{"default:paper", CS["default:paper"][2], "villagers:coins", CS["default:paper"][1]}, 
		{"default:torch", CS["default:torch"][2], "villagers:coins", CS["default:torch"][1]},
		{"default:book", CS["default:book"][2], "villagers:coins", CS["default:book"][1]}, 
	},
	librarian = {
		{split=1, min=1, max=2},
		{"default:book", CS["default:book"][2], "villagers:coins", CS["default:book"][1]}, 
		-- split --
		{"default:paper", CS["default:paper"][2], "villagers:coins", CS["default:paper"][1]}, 
	},
	lumberjack = {
		{split=0, min=1, max=2},
		{"default:wood", CS["default:wood"][2], "villagers:coins", CS["default:wood"][1]}, 
		{"default:tree", CS["default:tree"][2], "villagers:coins", CS["default:tree"][1]}, 
	}, 
	miller = {
		{split=1, min=1, max=2},
		{"farming:flour", CS["farming:flour"][2], "villagers:coins", CS["farming:flour"][1]}, 
		-- split --
		{"farming:straw", CS["farming:straw"][2], "villagers:coins", CS["farming:straw"][1]}, 
	}, 
	
	
	priest = DEFAULT_GOODS,
	roofer = DEFAULT_GOODS,
	
	sawmill_owner = {
		{split=2, min=3, max=4},
		{"default:wood", CS["default:wood"][2], "villagers:coins", CS["default:wood"][1]}, 
		{"default:tree", CS["default:tree"][2], "villagers:coins", CS["default:tree"][1]}, 
		-- split --
		{"default:stick", CS["default:stick"][2], "villagers:coins", CS["default:stick"][1]}, 
		{"stairs:slab_wood", CS["stairs:slab_wood"][2], "villagers:coins", CS["stairs:slab_wood"][1]},
	}, 
	
	seed_seller = DEFAULT_GOODS,
	
	shopkeeper = DEFAULT_GOODS,
	
	smith = {
		{split=1, min=3, max=4},
		{"default:sword_steel", CS["default:sword_steel"][2], "villagers:coins", CS["default:sword_steel"][1]},
		-- split --
		{"default:axe_steel", CS["default:axe_steel"][2], "villagers:coins", CS["default:axe_steel"][1]},
		{"default:pick_steel", CS["default:pick_steel"][2], "villagers:coins", CS["default:pick_steel"][1]},
		{"default:shovel_steel", CS["default:shovel_steel"][2], "villagers:coins", CS["default:shovel_steel"][1]},
		{"farming:hoe_steel", CS["farming:hoe_steel"][2], "villagers:coins", CS["farming:hoe_steel"][1]},
	},
	
	stairmaker = DEFAULT_GOODS,
	
	tinsmith = {
		{split=0, min=1, max=1},
		{"default:tin_ingot", CS["default:tin_ingot"][2], "villagers:coins", CS["default:tin_ingot"][1]},
	}, 
	
	toolmaker = DEFAULT_GOODS,
	
	trader = DEFAULT_GOODS,
	
	wheelwright = {
		{split=1, min=1, max=2},
		{"cottages:wagon_wheel", CS["cottages:wagon_wheel"][2], "villagers:coins", CS["cottages:wagon_wheel"][1]},
		-- split -- 
		{"default:stick", CS["default:stick"][2], "villagers:coins", CS["default:stick"][1]}, 
	}, 
	wood_trader = {
		{split=1, min=3, max=4},
		{"default:stick", CS["default:stick"][2], "villagers:coins", CS["default:stick"][1]}, 
		-- split --
		{"default:wood", CS["default:wood"][2], "villagers:coins", CS["default:wood"][1]}, 
		{"stairs:slab_wood", CS["stairs:slab_wood"][2], "villagers:coins", CS["stairs:slab_wood"][1]}, 
		{"cottages:wood_flat", CS["cottages:wood_flat"][2], "villagers:coins", CS["cottages:wood_flat"][1]}, 
		{"cottages:hatch_wood", CS["cottages:hatch_wood"][2], "villagers:coins", CS["cottages:hatch_wood"][1]}, 
	}, 
	
	
	major = DEFAULT_GOODS,
	ore_seller = DEFAULT_GOODS,
	potterer = DEFAULT_GOODS,
	saddler = DEFAULT_GOODS,
	stoneminer = DEFAULT_GOODS,
	servant = DEFAULT_GOODS,
	schoolteacher = DEFAULT_GOODS,
	stonemason = DEFAULT_GOODS,
}


function villagers.getTradingFormspec(self, player_name)
	local log = false
	if log then 
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
	
	local player_inv = minetest.get_inventory({type="player", name=player_name})
	local inv_size = player_inv:get_size("main")
	
	-- construct rows for each item villager is selling
	for item_index = 1, item_count do
		
		local sell_data = self.vSell[item_index]
		local item_name = sell_data[1]
		local item_stock = sell_data[2]
		local cost_name = sell_data[3]
		local cost_amount = sell_data[4]
		if log then io.write("sell_data #"..item_index..": "..minetest.serialize(sell_data).." ") end
		
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
		
	formspec = formspec.. "button_exit[2.1,"..(item_count+1.2)..";2.5,"..height_exit_button..";"..self.vID..";I'm Done!]"
		
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
		local param1 = popped_item[1]
		local param2 = popped_item[2]
		local param3 = popped_item[3]
		local param4 = popped_item[4]
		
		if param1 == nil or param2 == nil or param3 == nil or param4 == nil then
			io.write(" #ERROR IN Getting Trade Item# ")
			local error_message = "getTradeInventory(): Invalid trade item detail for "..
				"plot#"..plot.." bed#"..bed.." villager\n    "..minetest.serialize(popped_item)
			table.insert(errors, error_message)
			popped_item = {"default:dirt", 1, "villagers:coins", 1}
		end
		
		if log then 
			io.write("\n  adding: "..minetest.serialize(popped_item).." ") 
		end
		
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
