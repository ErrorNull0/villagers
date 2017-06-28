VILLAGERS

BY:             ErrorNull
DESCRIPTION:    Villagers for Minetest
VERSION:        0.13
LICENCE:        WTFPL

REQUIRES: Sokomine's mg_villages mod.
Github - https://github.com/Sokomine/mg_villages
Forum - https://forum.minetest.net/viewtopic.php?f=9&t=13588

CHAT COMMANDS:

/villager <region> <building type>

<region> are the climate/region types that dictate villager ethnicity and clothing style: hot, cold, normal, native, desert

<building type> are the numerous building types available from mg_villagers mod: allmende, bakery, bench, chateau, church, deco, empty, farm_full, farm_tiny, field, forge, fountain, house, hut, library, lumberjack, mill, pasture, pit, sawmill, school, secular, shed, shop, spawn, tavern, tent, tower, trader, village_square, wagon, well

Example: /villager cold tower

CHANGELOG:

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
