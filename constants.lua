-- ============================================ CONSTANTS =================================================
-- ========================================================================================================

villagers.YAWS = { 0, -0.785, -1.571, -2.356, 3.141, 2.356, 1.571, 0.785}
villagers.DIRECTIONS = { "N", "NE", "E", "SE", "S", "SW", "W", "NW"}
villagers.DEGREES_TO_YAW = { 
	[0] = 0, [45] = -0.785, [90] = -1.571, [135] = -2.356, [180] = 3.141, 
	[225] = 2.356, [270] = 1.571, [315] = 0.785, [360] = 0
}

-- used to help calculate the x and z positions of nodes that are adjacent to villager 
villagers.NODE_AREA = {
	["NW"]={-1,1},  ["N"]={0,1},  ["NE"]={1,1}, ["W"]={-1,0},  ["C"]={0,0},  
	["E"]={1,0}, ["SW"]={-1,-1}, ["S"]={0,-1}, ["SE"]={1,-1}
}

villagers.REGIONS = { "hot", "cold", "normal", "navtive", "desert" }

villagers.VILLAGES = { 
	"tent", "charachoal", "claytrader", "lumberjack", "logcabin", "nore", 
	"medieval", "gambit", "taoki", "cornernote", "sandcity"
}

villagers.PLOTS = {
	"allmende", "bakery", "bench", "chateau", "church", "deco", "empty", 
	"farm_full", "farm_tiny", "field", "forge", "fountain", "house", "hut", 
	"library", "lumberjack", "mill", "pasture", "pit", "sawmill", "school", 
	"secular", "shed", "shop", "spawn", "tavern", "tent", "tower", "trader",
	"village_square", "wagon", "well", "castle", "park", "cementry", "lamp",
	"hotel", "pub", "stable", "horsestable"
}

villagers.SCHEMS = {
	tent = {
		"tent_tiny_1", "tent_tiny_2", "tent_big_1", "tent_big_2", 
		"tent_medium_1", "tent_medium_2", "tent_medium_3", 
		"tent_medium_4", "tent_open_1", 
		"tent_open_2", "tent_open_3", 
		"tent_open_big_1", "tent_open_big_2", "tent_open_big_3", 
		"empty_1", "empty_2", "empty_3", "empty_4", "empty_5", 
		"empty_16x32_2_90", "empty_32x32_2_90"
	}, 
	charachoal = {
		"charachoal_hut", "charachoal_hill", 
		"empty_1", "empty_2", "empty_3", "empty_4", "empty_5", 
		"empty_16x32_2_90", "empty_32x32_2_90"
	}, 
	claytrader = {
		"trader_clay_1", "trader_clay_2", "trader_clay_3", 
		"trader_clay_4", "trader_clay_5", "clay_pit_1", 
		"clay_pit_2", "clay_pit_3", "clay_pit_4", "clay_pit_5",
		"empty_1", "empty_2", "empty_3", "empty_4", "empty_5", 
		"empty_16x32_2_90", "empty_32x32_2_90"
	}, 
	lumberjack = {
		"lumberjack_1", "lumberjack_2", "lumberjack_3", "lumberjack_4", 
		"lumberjack_5", "lumberjack_6", "lumberjack_7", "lumberjack_8", 
		"lumberjack_9", "lumberjack_10", "lumberjack_11", "lumberjack_12", 
		"lumberjack_13", "lumberjack_14", "lumberjack_15", "lumberjack_16", 
		"lumberjack_school", "lumberjack_stable", "lumberjack_pub_1", 
		"lumberjack_church_1", "lumberjack_hotel_1", "lumberjack_shop_1", 
		"lumberjack_sawmill_1",
		"empty_1", "empty_2", "empty_3", "empty_4", "empty_5", 
		"empty_16x32_2_90", "empty_32x32_2_90"
	}, 
	logcabin = {
		"allmende_3_90", "logcabin1", "logcabin2", "logcabin3", "logcabin4",
		"logcabin5", "logcabin6", "logcabin7", "logcabin8", "logcabin9",
		"logcabin10", "logcabin11", "logcabinpub1", "logcabinpub2", "logcabinpub3", 
		"empty_1", "empty_2", "empty_3", "empty_4", "empty_5", 
		"empty_16x32_2_90", "empty_32x32_2_90"
	}, 
	nore = {
		"house_1_0", "wheat_field", "cotton_field", "lamp", "well", 
		"fountain", "small_house_1_0", "house_with_garden_1_0", "church_1_0", 
		"tower_1_0", "forge_1_0", "library_1_0", "inn_1_0", "pub_1_0", 
		"empty_1", "empty_2", "empty_3", "empty_4", "empty_5", 
		"empty_16x32_2_90", "empty_32x32_2_90"
	}, 
	medieval = {
		"church_1", "forge_1", "mill_1", "watermill_1", "hut_1", "hut_2", 
		"farm_full_1", "farm_full_2", "farm_full_3", "farm_full_4", "farm_full_5", 
		"farm_full_6", "farm_tiny_1", "farm_tiny_2", "farm_tiny_3", "farm_tiny_4", 
		"farm_tiny_5", "farm_tiny_6", "farm_tiny_7", "taverne_1", "taverne_2", 
		"taverne_3", "taverne_4", "well_1", "well_2", "well_3", "well_4", 
		"well_5", "well_6", "well_7", "well_8", "allmende_3_90", "tree_place_1", 
		"tree_place_2", "tree_place_3", "tree_place_4", "tree_place_5", "tree_place_6", 
		"tree_place_7", "tree_place_8", "tree_place_9", "tree_place_10", "wagon_1", 
		"wagon_2", "wagon_3", "wagon_4", "wagon_5", "wagon_6", "wagon_7", "wagon_8", 
		"wagon_9", "wagon_10", "wagon_11", "wagon_12", "bench_1", "bench_2", 
		"bench_3", "bench_4", "shed_1", "shed_2", "shed_3", "shed_4", "shed_5", 
		"shed_6", "shed_7", "shed_8", "shed_9", "shed_10", "shed_11", "shed_12", 
		"weide_1", "weide_2", "weide_3", "weide_4", "weide_5", "weide_6", "field_1", 
		"field_2", "field_3", "field_4", "baking_house_1", "baking_house_2", 
		"baking_house_3", "baking_house_4", "house_medieval_fancy_1_90", 
		"cow_shed_1_270", "shed_with_forge_v2_1_0", 
		"empty_1", "empty_2", "empty_3", "empty_4", "empty_5", 
		"empty_16x32_2_90", "empty_32x32_2_90"
	}, 
	gambit = {
		"gambit_church_1_0_180", "gambit_cementry_0_180", "gambit_field_1_1_90", 
		"gambit_forge_1_2_270", "gambit_fountain_1_1_90", "gambit_house_1_0_0", 
		"gambit_lamp_0_270", "gambit_library_hotel_0_180", "gambit_pub_1_0_0", 
		"gambit_shed_open_chests_2_0", "gambit_shop_0_90", "gambit_shop_large_0_0", 
		"gambit_stable_1_2_90", "gambit_tower_1_0_270"
	}, 
	taoki = {
		"allmende_3_90", "default_town_farm", "default_town_house_large_1", 
		"default_town_house_large_2", "default_town_house_medium", 
		"default_town_house_small", "default_town_house_tiny_1", 
		"default_town_house_tiny_2", "default_town_house_tiny_3", "default_town_park", 
		"default_town_tower", "default_town_well", "default_town_fountain", 
		"empty_1", "empty_2", "empty_3", "empty_4", "empty_5", 
		"empty_16x32_2_90", "empty_32x32_2_90"
	}, 
	cornernote = {
		"towntest_ACDC_house_0_270", "towntest_cornernote_hut1_1_0", "towntest_cornernote_hut2_1_90", 
		"towntest_cornernote_hut3_1_180", "towntest_cornernote_fortress_4_0", 
		"towntest_cornernote_tower_1_90", "towntest_cornernote_turret_1_90", 
		"towntest_irksomeduck_manor_0_90", "towntest_kddekadenz_barn1_1_90", 
		"towntest_kddekadenz_barn2_1_90", "towntest_kddekadenz_castle_3_90", 
		"towntest_kddekadenz_factory_1_90", "towntest_kddekadenz_gazebo_0_90", 
		"towntest_kddekadenz_home1_1_90", "towntest_kddekadenz_home2_1_90", 
		"towntest_kddekadenz_windmill_0_90", "towntest_Nanuk_chapel_1_180", 
		"towntest_Nanuk_lavabeacon_0_90", "towntest_Nanuk_well_0_90", 
		"towntest_VanessaE_home1_1_0", "towntest_VanessaE_home2_0_0"
	}, 
	sandcity = {
		"sandcity_tiny_1_1_270", "sandcity_tiny_2_1_270", "sandcity_tiny_3_1_270", 
		"sandcity_tiny_4_1_270", "sandcity_small_1_1_270", "sandcity_small_2_1_270", 
		"sandcity_small_3_1_270", "sandcity_small_4_1_270", "sandcity_small_5_1_270", 
		"sandcity_meeting_small_1_1_270", "sandcity_ap_tower_1_1_270", 
		"sandcity_ap_tower_2_1_270", "sandcity_ap_tower_3_1_270", "sandcity_ap_tower_4_1_270", 
		"sandcity_ap_tower_5_1_270", "sandcity_ap_tower_6_1_270", "sandcity_ap_tower_7_1_270", 
		"sandcity_ap_mixed_1_1_270", "sandcity_ap_mixed_2_1_270", "sandcity_ap_tiny_3_1_270", 
		"sandcity_ap_tiny_3b_1_270", "sandcity_small_2_1_270", "sandcity_small_3_1_270"
	}
}
