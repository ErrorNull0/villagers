--[[
- villager spawns for the first time
- villager is either a resident or a trader
- residents spawn in homes, huts and other residental plots
- traders spawn in shops, forges, bakeries, or other commercal plots
- determination for villager to be resident vs trader is based on schem type
- ** create table that pairs dialgue with each schem type **

- villager is assigned a schem type
- based on that schem type, villager is categorized in the following way
	- homes, huts, etc: residents
	-- similar to 'simple jobs' but one-time reward (only 1 per village)
	-- these are randomly pulled from a simple jobs database
	-- value is higher than 'simple jobs'
	- shops, bakeries, forges, etc: goods traders
	- empty: chance to be 'mystery merchant' liminted supply (only 1 per village) costs in coins
	- town hall: 'quest merchant' one-time reward (only 1 per village) costs in goods
	- well, fountain: 'simple jobs' unlimited supply (only 1 per village)
	
- each category above determines the 'main' dialogue for that villager
- each villager has the following dialogue types
	- main
	- hello
	- bye
	- trading start
	- trading end
	- walking forward
	- busy action


	
--]]
