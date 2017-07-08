villagers = {}

local modpaths = minetest.get_modpath("villagers")
dofile(modpaths.."/constants.lua")
dofile(modpaths.."/items.lua")
dofile(modpaths.."/functions.lua")
dofile(modpaths.."/attributes.lua")
dofile(modpaths.."/chatting.lua")
dofile(modpaths.."/actions.lua")
dofile(modpaths.."/dialogue.lua")
dofile(modpaths.."/trading.lua")
dofile(modpaths.."/spawning.lua")
dofile(modpaths.."/callbacks.lua")
dofile(modpaths.."/chat_commands.lua")

villagers.log = false	--debug actions
villagers.log2 = false	--debug chatting
villagers.log3 = false 	--debug textures
villagers.log4 = false	--debug trading
villagers.log5 = false	--debug spawning