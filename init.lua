-- {{ OPTIONS:
vim.opt.mouse = "i"
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.have_nerd_font = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.opt.scrolloff = 10
vim.opt.laststatus = 3
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true
vim.env.TERM = "xterm-256color"
vim.opt.signcolumn = "yes"
vim.opt.path:append '**'
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
--}}

--{{ THEMING:
vim.cmd("colorscheme habamax")
--}}

--{{ PLUGINS:
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--depth=1',
    'https://github.com/echasnovski/mini.nvim', mini_path
  })
  vim.cmd('packadd mini.nvim | helptags ALL')
end
require('mini.deps').setup({ path = { package = path_package } })

-- Instalation
MiniDeps.add("nvim-treesitter/nvim-treesitter")
MiniDeps.add("folke/snacks.nvim")

-- Configutation
require("mini.icons").setup()
require("nvim-treesitter").setup({
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
})
require("snacks").setup({
    picker = { enabled = true },
})
--}}

--{{ KEYMAPS:
vim.g.mapleader = " "

local function k(mode, key, action, desc)
  vim.keymap.set(mode, key, action, { desc = desc })
end

k("", "<leader>y", '"+y', "Yank to System Clipboard")
k("", "<leader>p", '"+p', "Paste from System Clipboard")
k("", "<leader>yu", 'gg0vG$"+y', "Copy the Buffer to Clipboard")

k("n", "<Esc>", "<cmd>nohlsearch<CR>", "Remove Search Highlighting")

k("n", "-", "<cmd>Explore<CR>", "Open Netrw")

k("n", "[q", "<cmd>cprev<CR>", "Go to Previous in Quickfix List")
k("n", "]q", "<cmd>cnext<CR>", "Go to Next in Quickfix List")

k("n", "<C-d>", "<C-d>zz", "Page down")
k("n", "<C-u>", "<C-u>zz", "Page up")

k("n", "<S-u>", "<C-r>", "Redo")

k("n", "[b", "<cmd>bp<CR>", "Buffer Previous")
k("n", "]b", "<cmd>bn<CR>", "Buffer Next")
k("n", "<BS>", "<cmd>b#<CR>", "Buffer Recent")

k("n", "<C-h>", "<C-w><C-h>", "Focus Left")
k("n", "<C-l>", "<C-w><C-l>", "Focus Right")
k("n", "<C-j>", "<C-w><C-j>", "Focus Down")
k("n", "<C-k>", "<C-w><C-k>", "Focus Up")

k("n", "<leader><leader>", ":find ", "Find files")

k("n", "<leader>ff", require("snacks").picker.files, "Find file")
k("n", "<leader>fb", require("snacks").picker.buffers, "Find buffer")
k("n", "<leader>fg", require("snacks").picker.grep, "Find by grep")
k("n", "<leader>fp", require("snacks").picker.projects, "Find project")

k("v", "J", ":m '>+1<CR>gv=gv", "Move Selected Text Down")
k("v", "K", ":m '<-2<CR>gv=gv", "Move Selected Text Up")
k("v", "<S-Up>", ":m '<-2<CR>gv=gv", "Move Selected Text Up")
k("v", "<S-Down>", ":m '>+1<CR>gv=gv", "Move Selected Text Down")
--}}

