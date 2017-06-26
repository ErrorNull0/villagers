--[[
	These are all the plot/building types that are available (from mg_villages) that the villagers
	can spawn onto. For now, only one villager will spawn on each plot type. 
		female: inverse probabiliy of a female villager spawning on this plot type
		age: the set from which a specific age is randomly chosen for the villager
		
-- village towntest: castle
-- village gambit: cementry, lamp, hotel, pub, stable, 
--]]
villagers.plots = {
	allmende = { female = 2, age = {"young", "old"} }, 
	bakery = { female=2, age={"adult", "adult", "old"} }, 
	bench =	{ female=2, age={"adult", "old", "old"} }, 
	chateau = { female=3, age={"adult", "adult", "old"} }, 
	church = { female=4, age={"adult", "old", "old"} }, 
	deco = { female=2, age={"young", "adult", "old"} }, 
	empty =	{ female=3, age={"adult", "adult", "old"} }, 
	farm_full =	{ female=4, age={"adult", "adult", "old"} }, 
	farm_tiny = { female=3, age={"adult", "adult", "old"} }, 
	field = { female=4, age={"adult"} },  
	forge = { female=4, age={"adult"} }, 
	fountain = { female=2, age={"young", "adult", "old"} }, 
	house = { female=2, age={"adult", "adult", "old"} }, 
	hut = { female=3, age={"adult", "adult", "old"} }, 
	library = { female=2, age={"adult", "old", "old"} }, 
	lumberjack = { female=4, age={"adult"} }, 
	mill = { female=4, age={"adult"} }, 
	pasture = { female=2, age={"young", "adult", "old"} }, 
	pit = { female=4, age={"adult"} }, 
	sawmill = { female=4, age={"adult"} }, 
	school = { female=1, age={"young", "young", "adult"} }, 
	secular = { female=3, age={"adult", "old"} }, 
	shed =	{ female=4, age={"adult"} }, 
	shop = { female=3, age={"adult", "adult", "old"} }, 
	spawn = { female=2, age={"adult", "adult", "old"} },
	tavern = { female=3, age={"adult"} }, 
	tent = { female=5, age={"adult"} },  
	tower =	{ female=4, age={"adult"} }, 
	trader = { female=3, age={"adult", "adult", "old"} }, 
	village_square = { female=2, age={"young", "adult", "old"} }, 
	wagon = { female=4, age={"adult", "adult", "old"} }, 
	well = { female=2, age={"adult", "adult", "old"} },
	
	-- village towntest: castle
	castle = { female=4, age={"adult", "adult", "old"} },
	park = { female=2, age={"young", "adult", "old"} }, 
	
	-- village gambit: cementry, lamp, hotel, pub, stable, 
	cementry = { female=2, age={"adult", "old"} },
	lamp = { female=2, age={"young", "adult", "old"} },
	hotel = { female=4, age={"adult", "adult", "old"} },
	pub = { female=3, age={"adult", "adult", "old"} },
	stable = { female=2, age={"adult"} }
}


