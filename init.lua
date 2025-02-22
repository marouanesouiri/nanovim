----------------------------------------------------------
--                                                      --
--      ultra minimalistic and powerful nvim config     --
--                                                      --
----------------------------------------------------------

--  leader key
vim.g.mapleader = " "
-- second leader key
vim.g.maplocalleader = vim.api.nvim_replace_termcodes("<BS>", false, false, true)

-- load the plugins
require("plugins.init")

-- load the options
require("settings.options")
-- load Autocommands
require("settings.autoCommands")
-- load the status line
require("settings.statusline")

-- load the keybinds
require("keybinds")
