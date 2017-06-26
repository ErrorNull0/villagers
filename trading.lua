local DEFAULT_ITEMS = { 
	{"default:apple 1", "villagers:coins 1"}, 
	{"farming:bread 1", "villagers:coins 2"} 
}

villagers.trade = {

	allmende = { DEFAULT_ITEMS }, 
	
	bakery = {
		{"farming:flour", "villagers:coins 1"},
		{"farming:wheat", "villagers:coins 1"},
		{"farming:bread", "villagers:coins 1"},
		{"default:apple", "villagers:coins 1"}
	}, 
	
	bench = { DEFAULT_ITEMS }, 
	chateau = { DEFAULT_ITEMS }, 
	church = { DEFAULT_ITEMS }, 
	deco = { DEFAULT_ITEMS }, 
	empty = { DEFAULT_ITEMS }, 
	empty5x5 = { DEFAULT_ITEMS }, 
	empty6x12 = { DEFAULT_ITEMS }, 
	empty8x8 = { DEFAULT_ITEMS }, 
	empty16x16 = { DEFAULT_ITEMS }, 
	
	farm_full =	{
		{"default:apple", "villagers:coins 1"},
		{"farming:seed_wheat", "villagers:coins 1"},
		{"farming:wheat", "villagers:coins 1"},
		{"farming:straw", "villagers:coins 1"},
		{"farming:seed_cotton", "villagers:coins 1"},
		{"farming:cotton", "villagers:coins 1"},
		{"farming:string", "villagers:coins 1"},
		{"flowers:mushroom_red", "villagers:coins 1"},
		{"flowers:mushroom_brown", "villagers:coins 1"}
	}, 
	
	farm_tiny = {
		{"farming:wheat", "villagers:coins 1"},
		{"farming:cotton", "villagers:coins 1"},
		{"flowers:rose", "villagers:coins 1"},
		{"flowers:tulip", "villagers:coins 1"},
		{"flowers:dandelion_yellow", "villagers:coins 1"},
		{"flowers:geranium", "villagers:coins 1"},
		{"flowers:viola", "villagers:coins 1"},
		{"flowers:dandelion_white", "villagers:coins 1"}
	}, 
	
	field = {
		{"farming:wheat", "villagers:coins 1"},
		{"farming:cotton", "villagers:coins 1"},
		{"default:dirt", "villagers:coins 1"},
		{"default:clay", "villagers:coins 1"}
	}, 
	
	forge = {
		{"default:iron_lump", "villagers:coins 1"},
		{"default:steelblock", "villagers:coins 1"},
		{"default:copper_lump", "villagers:coins 1"},
		{"default:copperblock", "villagers:coins 1"},
		{"default:tin_lump", "villagers:coins 1"},
		{"default:tinblock", "villagers:coins 1"},
		{"default:gold_lump", "villagers:coins 1"},
		{"default:goldblock", "villagers:coins 1"},
		{"default:bronzeblock", "villagers:coins 1"},
		{"default:sword_steel", "villagers:coins 1"},
		{"default:sword_bronze", "villagers:coins 1"},
		{"default:steel_ingot", "villagers:coins 1"},
		{"default:copper_ingot", "villagers:coins 1"},
		{"default:tin_ingot", "villagers:coins 1"},
		{"default:bronze_ingot", "villagers:coins 1"},
		{"default:gold_ingot", "villagers:coins 1"}
	}, 
	
	fountain = { DEFAULT_ITEMS }, 
	house = { DEFAULT_ITEMS }, 
	hut = { DEFAULT_ITEMS }, 
	library = { DEFAULT_ITEMS }, 
	
	lumberjack = {
		{"default:tree", "villagers:coins 1"},
		{"default:jungletree", "villagers:coins 1"},
		{"default:pine_tree", "villagers:coins 1"},
		{"default:acacia_tree", "villagers:coins 1"},
		{"default:acacia_tree", "villagers:coins 1"},
		{"default:aspen_tree", "villagers:coins 1"}
	}, 
	
	mill = {
		{"farming:wheat", "villagers:coins 1"},
		{"farming:straw", "villagers:coins 1"},
		{"farming:flour", "villagers:coins 1"}
	}, 
	
	pasture = {
		{"flowers:rose", "villagers:coins 1"},
		{"flowers:tulip", "villagers:coins 1"},
		{"flowers:dandelion_yellow", "villagers:coins 1"},
		{"flowers:geranium", "villagers:coins 1"},
		{"flowers:viola", "villagers:coins 1"},
		{"flowers:dandelion_white", "villagers:coins 1"}
	}, 
	
	pit = {
		{"default:dirt", "villagers:coins 1"},
		{"default:sand", "villagers:coins 1"},
		{"default:gravel", "villagers:coins 1"}
	}, 
	
	sawmill = {
		{"default:wood", "villagers:coins 1"},
		{"default:junglewood", "villagers:coins 1"},
		{"default:pine_wood", "villagers:coins 1"},
		{"default:acacia_wood", "villagers:coins 1"},
		{"default:acacia_wood", "villagers:coins 1"},
		{"default:aspen_wood", "villagers:coins 1"}
	}, 
	
	school = { DEFAULT_ITEMS }, 
	secular = { DEFAULT_ITEMS }, 
	shed =	{ DEFAULT_ITEMS }, 
	shop = { 
		{"default:key", "villagers:coins 1"},
		{"default:torch", "villagers:coins 1"},
		{"default:shovel_steel", "villagers:coins 1"},
		{"default:shovel_bronze", "villagers:coins 1"},
		{"default:shovel_mese", "villagers:coins 1"},
		{"default:shovel_diamond", "villagers:coins 1"},
		{"default:pick_steel", "villagers:coins 1"},
		{"default:pick_bronze", "villagers:coins 1"},
		{"default:pick_mese", "villagers:coins 1"},
		{"default:pick_diamond", "villagers:coins 1"},
		{"default:sword_steel", "villagers:coins 1"},
		{"default:sword_bronze",  "villagers:coins 1"},
		{"default:sword_mese", "villagers:coins 1"},
		{"default:sword_diamond", "villagers:coins 1"},
		{"default:axe_steel", "villagers:coins 1"},
		{"default:axe_bronze", "villagers:coins 1"},
		{"default:axe_mese", "villagers:coins 1"},
		{"default:axe_diamond", "villagers:coins 1"},
		{"default:cactus", "villagers:coins 1"},
		{"default:papyrus", "villagers:coins 1"},
		{"default:chest_locked", "villagers:coins 1"},
		{"default:sign_wall_steel", "villagers:coins 1"},
		{"default:ladder_steel", "villagers:coins 1"},
		{"default:glass", "villagers:coins 1"},
		{"default:meselamp", "villagers:coins 1"},
		{"default:paper", "villagers:coins 1"},
		{"default:book", "villagers:coins 1"},
		{"default:skeleton_key", "villagers:coins 1"},
		{"default:flint", "villagers:coins 1"},
		{"carts:rail", "villagers:coins 1"},
		{"carts:cart", "villagers:coins 1"},
		{"beds:fancy_bed", "villagers:coins 1"},
		{"beds:bed", "villagers:coins 1"},
		{"boats:boat", "villagers:coins 1"},
		{"bucket:bucket_empty", "villagers:coins 1"}
	}, 
	spawn = { DEFAULT_ITEMS }, 
	tavern = { DEFAULT_ITEMS }, 
	tent = { DEFAULT_ITEMS }, 
	
	tower =	{ 
		{"default:sword_steel", "villagers:coins 1"},
		{"default:sword_bronze", "villagers:coins 1"}
	}, 
	
	trader = {
		{"default:clay", "villagers:coins 1"},
		{"default:clay_lump", "villagers:coins 1"}
	}, 
	
	village_square = { DEFAULT_ITEMS }, 
	wagon = { DEFAULT_ITEMS }, 
	well = { DEFAULT_ITEMS },

	-- village towntest: castle
	castle = { DEFAULT_ITEMS },
	park = { DEFAULT_ITEMS }, 

	-- village gambit: cementry, lamp, hotel, pub, stable, 
	cementry = { DEFAULT_ITEMS },
	lamp = { DEFAULT_ITEMS },
	hotel = { DEFAULT_ITEMS },
	pub = { DEFAULT_ITEMS },
	stable = { DEFAULT_ITEMS }
}
