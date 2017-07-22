VILLAGERS

BY:             ErrorNull
DESCRIPTION:    Villagers for Minetest
VERSION:        0.16
LICENCE:        WTFPL

REQUIRES: Sokomine's mg_villages mod.
Github - https://github.com/Sokomine/mg_villages
Forum - https://forum.minetest.net/viewtopic.php?f=9&t=13588

CHAT COMMAND:
/villagers list
Displays a formspec that lists all villagers currently spawned nearby that has a job title. Villagers with no job title are not shown. In addition to some details about each trader, there is a GO button that will teleport you to that trader. This tool is meant to quickly find traders for testing. The following details are shown for each trader:
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

CHANGELOG:
v0.16
[fixed]
- Eliminated more NIL errors that crash the game
- Stop any ongoing digging anim by villager when trading

[added]
- Young children villagers tell you they don't know much about trading
- New chat command to list all nearby traders and teleport to them
- Created node metadata formspec at village pos that shows any 'soft' errors

[improved]
- Re-worked entire spawning algorithm to use LBMs!
-- if some villagers do not spawn immediately on the mob spawner,
-- unload/reload map block by walking away about 40m and returning
- Calculate 'region' type based on surrounding nodes at village position
- Villagers adopt attributes from mg_villagers: gender, age, and job title!
- Trader items/goods are now determined by the villager's job title, 
-- and is no longer determined by building/schem type.


v0.15
[fixed]
- removed crash on non-players punching villagers

[added]
- completed main trading formspec
- traders will show **trader** on their infospec
- added coins as the main form of buying goods
- completed cost table based on coins for common items villagers will trade
- 'quest' traders who give ingots for a large number of items
- 'simplejob' traders who give a coin for small amount of resources
- if player tries to chat/trade while villager is busy (walking, turning about, etc) 
-- villager will say 'pardon', 'excuse me', etc.
- added lots of gameplay facts as dialogue that all villagers may say

[improved]
- formspec shows goods based on village and plot schem type
- formspec shows correct values for cost, stock, etc.
- only certain villagers trade (farmers, smiths, barkeeps, etc)
- can trade while in the middle of chatting now
- improved chat bubble interaction a bit
- villager tells player they are busy if player tries to chat or trade while another player is doing so first
- added <village> and <schem> parameter to chat command
- organized all code into their own lua files
- infospec on villager has useful info (and some not)


v0.14
[improved]
- if village generates aritificial snow, villagers spawn as cold region inhabitants (light skinned and warmer clothing)
- for each residental building (home, hut, tavern, etc), one villager will spawn for each bed that exists
- these villagers will now spawn on the convenient mob spawners (thanks Sokomine!)
- other villagers still spawn next to the various non-residental buildings (forge, library, bakery, sawmill, church, etc)
[added]
- chat command to manually spawn a villager at current position (instructions above)

v0.13
[fixed]
- white chat bubble image no longer disappears on rare occasions while chatting
- some chat dialogue no longer appear twice in succession
- moved existing dialogue to villager types that make more sense: from secular to library, and trader to shop
[improved]
- redo and optimize code for dynamic body customization (skin, eyes, hair, etc)
- redo and optimize code for dynamic clothing customization (shirts, pants, dresses, boots, etc)
- reworked colorization for all body and clothing textures
- moved all lua constants for names, plots, colors, and dialogue into its own lua file
- tweaked relationship between village types and region type
[added]
- unique texture for priests (though it's not that great for now), which are villagers that spawn by churches. 
- unique 'got to go' message after villager has spoken through their 'main' dialgue
- color variation between body skin colors of villagers among different regions types *
- support for cottage, village_towntest, and village_gambit building mods
- custom dialgue for 'baker', 'mill', 'trader', 'hut', and 'secular'

v0.12
[fixed]
- digging of field/garden crops only allowed by farmers and field workers
- walking on newly planted field/garden only allowed by farmers and field workers
- 'traveler' villagers only spawn from 'empty' plot types now and no longer also from 'deco'
[improved]
- tweaked chatbubble positioning when trading
- shifted eyes down a few pixels to better match hair position
- optimized some code regarding hair auto-generating and chat dialogue while trading
[added]
- old aged male villagers have gray hair (or bald) and facial hair
- old aged female villagers have gray hair
- old aged villagers of either genders might wear eye glasses
- while villager is digging, chat dialogue reflects what is it they are digging (wheat, cotton, grass, snow)
- custom chat dialogue for allmende and deco villager types

v0.11
[fixed]
- prevent 'traveler' villager types from being young/child physical size
- fix NIL dialogue error when chatting with certain 'farmer' villagers
- allow chat when villager is about to walk and when villager is digging
[improved]
- custom dialogue when player chats while villager is about to walk or while digging
- alert messages now include villager's name
- tweaked chat text to better fit width of the chat bubble
[added]
- all travelers now wear straps with either backpack or sword on their backs
