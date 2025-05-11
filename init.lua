----------------------------------------------------------
--                                                      --
--      ultra minimalistic and powerful nvim config     --
--                                                      --
----------------------------------------------------------

--  leader key
vim.g.mapleader = " "

-- load the plugins
require("plugins.init")

-- load the options
require("settings.options")
-- load the global funcs
require("settings.globals")
-- load Autocommands
require("settings.autoCommands")
-- load the keybinds
require("settings.keybinds")
