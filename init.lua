----------------------------------------------------------
--                                                      --
--      ultra minimalistic and powerful nvim config     --
--                                                      --
----------------------------------------------------------

-- install plugin manager if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--  leader key
vim.g.mapleader = " "

-- load the plugins
require("lazy").setup("plugins", {})

-- load the options
require("settings.options")
-- load the global funcs
require("settings.globals")
-- load Autocommands
require("settings.autoCommands")
-- load the keybinds
require("settings.keybinds")
