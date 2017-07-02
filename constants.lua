--[[
NORE:
wheat_field, cotton_field, well, fountain, house_with_garden_1_0
church_1_0, tower_1_0, forge_1_0, library_1_0, inn_1_0, pub_1_0
LOG CABIN:
logcabinpub1, logcabinpub2, logcabinpub3
MEDIEVAL:
church_1, forge_1, mill_1, watermill_1, farm_full_1, farm_full_2,
farm_full_3, farm_full_4, farm_full_5, farm_full_6, farm_tiny_1,
farm_tiny_2, farm_tiny_3, farm_tiny_4, farm_tiny_5, farm_tiny_6,
farm_tiny_7, taverne_1, taverne_2, taverne_3, taverne_4, well_1,
well_2, well_3, well_4, well_5, well_6, well_7, well_8, wagon_1,
wagon_2, wagon_3, wagon_4, wagon_5, wagon_6, wagon_7, wagon_8,
wagon_9, wagon_10, wagon_11, wagon_12, shed_1, shed_2, shed_3,
shed_4, shed_5, shed_6, shed_7, shed_8, shed_9, shed_10, shed_11,
shed_12, baking_house_1, baking_house_2, baking_house_3, baking_house_4,
cow_shed_1_270, shed_with_forge_v2_1_0
CHARACHAOL:
charachoal_hill
LUMBERJACK:
lumberjack_stable, lumberjack_pub_1, lumberjack_church_1, lumberjack_hotel_1,
lumberjack_shop_1, lumberjack_sawmill_1
CLAYTRADER:
clay_pit_1, clay_pit_2, clay_pit_3, clay_pit_4, clay_pit_5
TAOKI:
default_town_farm (field), default_town_tower, default_town_well, default_town_fountain
TENT:
tent_open_3 (shop), tent_open_big_1 (pub), tent_open_big_2 (church)
TOWER:
hochsitz_1, hochsitz_2, hochsitz_3, hochsitz_4
CHATEAU:
chateau_without_garden
VILLAGE SANDCITY:
sandcity_ap_tower_1_1_270, sandcity_ap_tower_2_1_270, sandcity_ap_tower_3_1_270
sandcity_ap_tower_4_1_270, sandcity_ap_tower_5_1_270, sandcity_ap_tower_6_1_270
sandcity_ap_tower_7_1_270
VILLAGE GAMBIT MOD:
gambit_church_1_0_180, gambit_forge_1_2_270, gambit_fountain_1_1_90, 
gambit_library_hotel_0_180, gambit_pub_1_0_0, gambit_shed_open_chests_2_0, 
gambit_shop_0_90, gambit_shop_large_0_0, gambit_stable_1_2_90, 
gambit_tower_1_0_270
VILLAGE TOWNTEST/CORNERNOTE:
towntest_cornernote_tower_1_90, towntest_cornernote_turret_1_90 (tower), 
towntest_kddekadenz_barn1_1_90 (shed), towntest_kddekadenz_barn2_1_90 (shed),
towntest_kddekadenz_factory_1_90 (shed), towntest_kddekadenz_windmill_0_90, 
towntest_Nanuk_chapel_1_180, towntest_Nanuk_lavabeacon_0_90 (tower), 
towntest_Nanuk_well_0_90
<<VILLAGE TYPES>>
5-20 tent
10-15 charachoal
10-20 claytrader
10-30 lumberjack
15-30 log cabin
20-40 nore
25-60 medieval
30-60 gambit 
30-70 taoki
50-60 cornernote 
5-60 sandcity
<<NOTES>>
If any of the schema types are unavailable, then unsupported village mods installed
and simply retern special "none" string.
--]]

local STOCK = {
	apple = 99,
	bread = 99,
	string = 99,
	mushroom_red = 99,
	mushroom_brown = 99,
	paper = 99,
	book = 99,
	rose = 99,
	tulip = 99,
	dandelion_yellow = 99,
	geranium = 99,
	viola = 99,
	dandelion_white = 99,
	dirt = 99,
	sand = 99,
	gravel = 99,
	clay = 99,
	clay_lump = 99,
	tree = 99,
	wood = 99,
	stick = 99,
	boat = 99,
	torch = 99,
	shovel_wood = 99,
	pick_wood = 99,
	sword_wood = 99,
	axe_wood = 99,
	sign_wall_wood = 99,
	slab_wood = 99,
	stair_wood = 99,
	door_wood_a = 99,
	trapdoor = 99,
	fence_wood = 99,
	ladder_wood = 99,
	bed = 99,
	chest = 99,
	drinking_glass = 99,
	straw = 99,
	slab_straw = 99,
	glass_bottle = 99,
	
}

local COST = {
	apple = 1,
	bread = 3,
	string = 5,
	mushroom_red = 5,
	mushroom_brown = 5,
	paper = 3,
	book = 15,
	rose = 5,
	tulip = 5,
	dandelion_yellow = 5,
	geranium = 5,
	viola = 5,
	dandelion_white = 5,
	dirt = 1,
	sand = 2,
	gravel = 2,
	clay = 14,
	clay_lump = 3,
	tree = 18,
	wood = 4,
	stick = 1,
	boat = 30,
	torch = 15,
	shovel_wood = 15,
	pick_wood = 15,
	sword_wood = 15,
	axe_wood = 15,
	sign_wall_wood = 10,
	slab_wood = 3,
	stair_wood = 5,
	door_wood_a = 10,
	trapdoor = 5,
	fence_wood = 10,
	ladder_wood = 10,
	bed = 30,
	chest = 20,
	drinking_glass = 5,
	straw = 5,
	slab_straw = 3,
	glass_bottle = 5,
}



villagers.ITEMS = {
	tent = {
		tent_open_3 = {
			{"default:torch "..STOCK.torch, "villagers:coins "..COST.torch},
			{"default:apple "..STOCK.apple, "villagers:coins "..COST.apple}, 
			{"farming:string "..STOCK.string, "villagers:coins "..COST.string},
			{"flowers:mushroom_red "..STOCK.mushroom_red, "villagers:coins "..COST.mushroom_red},
			{"flowers:mushroom_brown "..STOCK.mushroom_brown, "villagers:coins "..COST.mushroom_brown},
			{"flowers:rose "..STOCK.rose, "villagers:coins "..COST.rose},
			{"flowers:tulip "..STOCK.tulip, "villagers:coins "..COST.tulip},
			{"flowers:dandelion_yellow "..STOCK.dandelion_yellow, "villagers:coins "..COST.dandelion_yellow},
			{"flowers:geranium "..STOCK.geranium, "villagers:coins "..COST.geranium},
			{"flowers:viola "..STOCK.viola, "villagers:coins "..COST.viola},
			{"flowers:dandelion_white "..STOCK.dandelion_white, "villagers:coins "..COST.dandelion_white}
		}, --shop
		tent_open_big_1 = {
			{"default:apple "..STOCK.apple, "villagers:coins "..COST.apple}, 
			{"farming:bread "..STOCK.bread, "villagers:coins "..COST.bread}, 
			{"vessels:drinking_glass "..STOCK.drinking_glass, "villagers:coins "..COST.drinking_glass},
		}, --pub
		tent_open_big_2 = {
			{"default:paper "..STOCK.paper, "villagers:coins "..COST.paper},
			{"default:book "..STOCK.book, "villagers:coins "..COST.book},
			{"vessels:glass_bottle "..STOCK.glass_bottle, "villagers:coins "..COST.glass_bottle},
		} --church
	},
	charachoal = {
		charachoal_hill = {
			{"default:dirt "..STOCK.dirt, "villagers:coins "..COST.dirt},
			{"default:sand "..STOCK.sand, "villagers:coins "..COST.sand},
			{"default:gravel "..STOCK.gravel, "villagers:coins "..COST.gravel}
		}
	},
	claytrader = {
		clay_pit_1 = {
			{"default:clay "..STOCK.clay, "villagers:coins "..COST.clay},
			{"default:clay_lump "..STOCK.clay_lump, "villagers:coins "..COST.clay_lump}
		}, 
		clay_pit_2 = {
			{"default:clay "..STOCK.clay, "villagers:coins "..COST.clay},
			{"default:clay_lump "..STOCK.clay_lump, "villagers:coins "..COST.clay_lump}
		}, 
		clay_pit_3 = {
			{"default:clay "..STOCK.clay, "villagers:coins "..COST.clay},
			{"default:clay_lump "..STOCK.clay_lump, "villagers:coins "..COST.clay_lump}
		}, 
		clay_pit_4 = {
			{"default:clay "..STOCK.clay, "villagers:coins "..COST.clay},
			{"default:clay_lump "..STOCK.clay_lump, "villagers:coins "..COST.clay_lump}
		}, 
		clay_pit_5 = {
			{"default:clay "..STOCK.clay, "villagers:coins "..COST.clay},
			{"default:clay_lump "..STOCK.clay_lump, "villagers:coins "..COST.clay_lump}
		}, 
	},
	lumberjack = {
		lumberjack_stable = {
			{"farming:straw "..STOCK.straw, "villagers:coins "..COST.straw}, 
			{"stairs:slab_straw "..STOCK.slab_straw, "villagers:coins "..COST.slab_straw}, 
		}, 
		lumberjack_pub_1 = {
			{"default:apple "..STOCK.apple, "villagers:coins "..COST.apple}, 
			{"farming:bread "..STOCK.bread, "villagers:coins "..COST.bread}, 
			{"vessels:drinking_glass "..STOCK.drinking_glass, "villagers:coins "..COST.drinking_glass},
		}, 
		lumberjack_church_1 = {
			{"default:paper "..STOCK.paper, "villagers:coins "..COST.paper},
			{"default:book "..STOCK.book, "villagers:coins "..COST.book},
			{"vessels:glass_bottle "..STOCK.glass_bottle, "villagers:coins "..COST.glass_bottle},
		}, 
		lumberjack_hotel_1 = {
			{"default:torch "..STOCK.torch, "villagers:coins "..COST.torch},
			{"beds:bed "..STOCK.bed, "villagers:coins "..COST.bed},
			{"default:paper "..STOCK.paper, "villagers:coins "..COST.paper},
			{"default:book "..STOCK.book, "villagers:coins "..COST.book},
			{"default:chest "..STOCK.chest, "villagers:coins "..COST.chest},
		},
		lumberjack_shop_1 = {
			{"default:tree "..STOCK.tree, "villagers:coins "..COST.tree},
			{"default:wood "..STOCK.wood, "villagers:coins "..COST.wood},
			{"default:stick "..STOCK.stick, "villagers:coins "..COST.stick},
			{"boats:boat "..STOCK.boat, "villagers:coins "..COST.boat},
			{"default:shovel_wood "..STOCK.shovel_wood, "villagers:coins "..COST.shovel_wood},
			{"default:pick_wood "..STOCK.pick_wood, "villagers:coins "..COST.pick_wood},
			{"default:sword_wood "..STOCK.sword_wood, "villagers:coins "..COST.sword_wood},
			{"default:axe_wood "..STOCK.axe_wood, "villagers:coins "..COST.axe_wood},
			{"default:sign_wall_wood "..STOCK.sign_wall_wood, "villagers:coins "..COST.sign_wall_wood},
			{"stairs:slab_wood "..STOCK.slab_wood, "villagers:coins "..COST.slab_wood},
			{"stairs:stair_wood "..STOCK.stair_wood, "villagers:coins "..COST.stair_wood},
			{"doors:door_wood_a "..STOCK.door_wood_a, "villagers:coins "..COST.door_wood_a},
			{"doors:trapdoor "..STOCK.trapdoor, "villagers:coins "..COST.trapdoor},
			{"default:fence_wood "..STOCK.fence_wood, "villagers:coins "..COST.fence_wood},
			{"default:ladder_wood "..STOCK.ladder_wood, "villagers:coins "..COST.ladder_wood},
		}, 
		lumberjack_sawmill_1 = {
			{"default:tree "..STOCK.tree, "villagers:coins "..COST.tree},
			{"default:wood "..STOCK.wood, "villagers:coins "..COST.wood},
		}
	},
	logcabin = {
		logcabinpub1 = {
			{"default:apple "..STOCK.apple, "villagers:coins "..COST.apple}, 
			{"farming:bread "..STOCK.bread, "villagers:coins "..COST.bread}, 
			{"vessels:drinking_glass "..STOCK.drinking_glass, "villagers:coins "..COST.drinking_glass},
		}, 
		logcabinpub2 = {
			{"default:apple "..STOCK.apple, "villagers:coins "..COST.apple}, 
			{"farming:bread "..STOCK.bread, "villagers:coins "..COST.bread}, 
			{"vessels:drinking_glass "..STOCK.drinking_glass, "villagers:coins "..COST.drinking_glass},
		}, 
		logcabinpub3 = {
			{"default:apple "..STOCK.apple, "villagers:coins "..COST.apple}, 
			{"farming:bread "..STOCK.bread, "villagers:coins "..COST.bread}, 
			{"vessels:drinking_glass "..STOCK.drinking_glass, "villagers:coins "..COST.drinking_glass},
		}
	},
	nore = {
		wheat_field = {}, 
		cotton_field = {}, 
		well = {}, 
		fountain = {}, 
		house_with_garden_1_0 = {},
		church_1_0 = {}, 
		tower_1_0 = {}, 
		forge_1_0 = {}, 
		library_1_0 = {}, 
		inn_1_0 = {}, 
		pub_1_0 = {}
	},
	medieval = {
		church_1 = {}, 
		forge_1 = {}, 
		mill_1 = {}, 
		watermill_1 = {}, 
		farm_full_1 = {}, 
		farm_full_2 = {},
		farm_full_3 = {}, 
		farm_full_4 = {}, 
		farm_full_5 = {}, 
		farm_full_6 = {}, 
		farm_tiny_1 = {},
		farm_tiny_2 = {}, 
		farm_tiny_3 = {}, 
		farm_tiny_4 = {}, 
		farm_tiny_5 = {}, 
		farm_tiny_6 = {},
		farm_tiny_7 = {}, 
		taverne_1 = {}, 
		taverne_2 = {}, 
		taverne_3 = {}, 
		taverne_4 = {}, 
		well_1 = {},
		well_2 = {}, 
		well_3 = {}, 
		well_4 = {}, 
		well_5 = {}, 
		well_6 = {}, 
		well_7 = {}, 
		well_8 = {}, 
		wagon_1 = {},
		wagon_2 = {}, 
		wagon_3 = {}, 
		wagon_4 = {}, 
		wagon_5 = {}, 
		wagon_6 = {}, 
		wagon_7 = {}, 
		wagon_8 = {},
		wagon_9 = {}, 
		wagon_10 = {}, 
		wagon_11 = {}, 
		wagon_12 = {}, 
		shed_1 = {}, 
		shed_2 = {}, 
		shed_3 = {},
		shed_4 = {}, 
		shed_5 = {}, 
		shed_6 = {}, 
		shed_7 = {}, 
		shed_8 = {}, 
		shed_9 = {}, 
		shed_10 = {}, 
		shed_11 = {},
		shed_12 = {}, 
		baking_house_1 = {}, 
		baking_house_2 = {}, 
		baking_house_3 = {}, 
		baking_house_4 = {},
		cow_shed_1_270 = {}, 
		shed_with_forge_v2_1_0 = {}
		--field_1
		--field_2
		--field_3
		--field_4
	},
	gambit = {
		gambit_church_1_0_180 = {},
		gambit_forge_1_2_270 = {},
		gambit_fountain_1_1_90 = {},
		gambit_library_hotel_0_180 = {},
		gambit_pub_1_0_0 = {},
		gambit_shed_open_chests_2_0 = {},
		gambit_shop_0_90 = {},
		gambit_shop_large_0_0 = {},
		gambit_stable_1_2_90 = {}
		--gambit_field_1_1_90
		--gambit_tower_1_0_270
	},
	taoki = {
		default_town_farm = {}, -- field
		default_town_tower = {},
		default_town_well = {},
		default_town_fountain = {},
		default_town_park = {}
	},
	cornernote = {

		towntest_kddekadenz_barn1_1_90 = {}, --shed
		towntest_kddekadenz_barn2_1_90 = {}, --shed
		towntest_kddekadenz_factory_1_90 = {}, --shed
		towntest_kddekadenz_windmill_0_90 = {},
		towntest_Nanuk_chapel_1_180 = {},
		towntest_Nanuk_well_0_90 = {}
		--towntest_cornernote_tower_1_90 --tower
		--towntest_cornernote_turret_1_90 --tower
		--towntest_Nanuk_lavabeacon_0_90 --tower
		--towntest_kddekadenz_castle_3_90
		--towntest_cornernote_fortress_4_0
	},
	sandcity = {
		sandcity_ap_tower_1_1_270 = {}, --tower
		sandcity_ap_tower_2_1_270 = {}, --tower
		sandcity_ap_tower_3_1_270 = {}, --tower
		sandcity_ap_tower_4_1_270 = {}, --tower
		sandcity_ap_tower_5_1_270 = {}, --tower
		sandcity_ap_tower_6_1_270 = {}, --tower
		sandcity_ap_tower_7_1_270 = {} --tower
	}
	
}