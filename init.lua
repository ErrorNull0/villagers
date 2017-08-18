villagers = {}
villagers.mods = {}

if minetest.get_modpath("cottages") then villagers.mods["cottages"] = true end
if minetest.get_modpath("farming") then villagers.mods["farming"] = true end

local modpaths = minetest.get_modpath("villagers")
dofile(modpaths.."/config.lua")
dofile(modpaths.."/constants.lua")
dofile(modpaths.."/items.lua")
dofile(modpaths.."/coins.lua")
dofile(modpaths.."/functions.lua")
dofile(modpaths.."/attributes.lua")
dofile(modpaths.."/chatting.lua")
dofile(modpaths.."/actions.lua")
dofile(modpaths.."/dialogue.lua")
dofile(modpaths.."/trading.lua")
dofile(modpaths.."/spawn.lua")
dofile(modpaths.."/callbacks.lua")
dofile(modpaths.."/chat_commands.lua")
