VILLAGERS

BY:             ErrorNull
DESCRIPTION:    Villagers for Minetest
VERSION:        0.17
LICENCE:        WTFPL

REQUIRES: Sokomine's mg_villages mod.
Github - https://github.com/Sokomine/mg_villages
Forum - https://forum.minetest.net/viewtopic.php?f=9&t=13588

SILVER COINS:
This mod primarily uses coins for trading. Ten silver coins equal 1 gold coin. A new player will start with a few coins - if that setting was not disabled from config.lua. To get more coins, look for villagers of the following job types that will trade you coins for certain items: ore_seller, potterer, saddler, stoneminer, servant, and schoolteacher. Also, villagers with jobs types of "major" can exchange silver coins for gold coins and vice versa. 

CHAT COMMAND:
/villagers list
Displays a formspec that lists all villagers currently spawned nearby that has a job title. Villagers with no job title are not shown. In addition to some details about each trader, there is a GO button that will teleport you to that trader. This tool is meant to for testing while this mod is WIP, and will be restricted upon official release. The following details are shown for each trader:
- Village: village type that the trader resides in
- Plot: Plot number that the trader initially spawned in
- Bed: Bed number (or spawn sequence#) of the trader
- Name: Trader's name
- Title: Trader's job title
- Origin: x and z coordinates of villager's initial spawn point
- Current: The currentx and z coordinates of villager
- Walked: How many meters the villager has walked
- Dist: Distance the villager is from the player
GO button: Teleports player to the trader/villager
REFRESH button: Updates numbers for Current, Walked and Dist to the present moment.

NOTE ABOUT 'GRASSHUT' VILLAGE TYPE:
This is a village type that is available when the very nice 'cottages' mod (https://forum.minetest.net/viewtopic.php?t=5120) is installed with 'mg_villages' mod - both by Sokomine. At this time, my villagers mod do not support the GRASSHUT village type because it requires Mossmanikin's 'dryplants' mod which depends on Venessa's 'biome_lib' mod. Venessa's biome_lib mod and her beautiful mods 'plantlife_modpack' and 'moretrees' are amazing mods that make the world look so much more lush and realistic. However, in my experience so far with biome_lib and other mods that depend on it, it becomes fairly processing intensive and detracks from my goal of having a lightweight, server and multiplayer friendly villagers mod. If you have a fast computer and primarily play singleplayer, then I would highly recommend installing Venessa's plantlife and moretrees mods for sure!