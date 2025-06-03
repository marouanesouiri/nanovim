---@diagnostic disable: undefined-global

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
vim.env.term = "xterm-256color"
vim.opt.signcolumn = "yes"
vim.opt.path:append '**'
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 200
vim.opt.completeopt = "menu,menuone,popup,noselect"
--}}

--{{ PLUGINS:
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none', '--depth=1',
        'https://github.com/echasnovski/mini.nvim', mini_path
    })
    vim.cmd('packadd mini.nvim | helptags all')
end
require('mini.deps').setup({ path = { package = path_package } })

-- instalation
MiniDeps.add({ source = "rose-pine/neovim", as = "rose-pine" })
MiniDeps.add("nvim-treesitter/nvim-treesitter")
MiniDeps.add("folke/snacks.nvim")
MiniDeps.add("nvim-lua/plenary.nvim") -- required by neogit
MiniDeps.add({ source = "neogitorg/neogit", checkout = "028e9ee" })
MiniDeps.add("mbbill/undotree")

-- configutation
require("mini.icons").setup()
require("nvim-treesitter.configs").setup({
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
})
require("snacks").setup({
    picker = { enabled = true },
})
require("neogit").setup()
--}}

--{{ THEMING:
vim.cmd("colorscheme rose-pine")
--}}

--{{ LSP:
-- configuration
vim.diagnostic.config({ virtual_text = true })

-- go lang
vim.lsp.config = {
    ['lua_ls'] = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
    },
    ['gopls'] = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.mod", "go.work", ".git" }
    },
    ['rust_analyzer'] = {
        cmd = { 'rust-analyzer' },
        root_markers = { 'Cargo.toml', '.git' },
        filetypes = { 'rs' },
    },
    ['clangd'] = {
        cmd = { 'clangd' },
        root_markers = { '.clangd', '.clang-format', '.git' },
        filetypes = { 'c', 'cpp' },
    },
    ['jdtls'] = {
        cmd = { 'jdtls' },
        root_markers = { "build.gradle", "build.gradle.kts", "pom.xml", ".git" },
        filetypes = { 'java' },
    },
}
for k in pairs(vim.lsp.config) do
    vim.lsp.enable(k)
end
--}}

--{[ AUTOCOMMANDS:
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.keymap.set("n", "w", "<C-^>", { buffer = true, desc = "Close Netrw" })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = args.buf, desc = "Go to definition" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "Go to declaration" })

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        vim.api.nvim_create_autocmd('InsertCharPre', {
            group = vim.api.nvim_create_augroup('aggressive-completion', { clear = true }),
            callback = function()
                if vim.v.char == ' ' or vim.v.char == '\t' then
                    return
                end

                if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
                    vim.defer_fn(function()
                        if vim.fn.pumvisible() == 0 and vim.fn.mode() == 'i' then
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true), 'n',
                                false)
                        end
                    end, 50)
                end
            end,
        })

        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})
--}}

--{{ KEYMAPS:
vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local function k(mode, key, action, desc, expr)
    vim.keymap.set(mode, key, action, { desc = desc, expr = expr or false })
end

k("", "<leader>y", '"+y', "Yank to System Clipboard")
k("", "<leader>p", '"+p', "Paste from System Clipboard")
k("", "yu", 'gg0vG$"+y', "Yank Buffer to System Clipboard")

k("n", "<Esc>", "<cmd>nohlsearch<CR>", "Remove Search Highlighting")

k("n", "-", "<cmd>Explore<CR>", "Open Netrw")

k("n", "<C-d>", "<C-d>zz", "Page down")
k("n", "<C-u>", "<C-u>zz", "Page up")

k("n", "<C-h>", "<C-w><C-h>", "Focus Left")
k("n", "<C-l>", "<C-w><C-l>", "Focus Right")
k("n", "<C-j>", "<C-w><C-j>", "Focus Down")
k("n", "<C-k>", "<C-w><C-k>", "Focus Up")

k("n", "<S-u>", "<C-r>", "Redo")

k("n", "[q", "<cmd>cprev<CR>", "Go to Previous in Quickfix List")
k("n", "]q", "<cmd>cnext<CR>", "Go to Next in Quickfix List")

k("n", "[b", "<cmd>bp<CR>", "Buffer Previous")
k("n", "]b", "<cmd>bn<CR>", "Buffer Next")
k("n", "<BS>", "<cmd>b#<CR>", "Buffer Recent")

k("n", "<leader><leader>", ":find ", "Find files")

k("n", "<leader>ff", require("snacks").picker.files, "Find file")
k("n", "<leader>fb", require("snacks").picker.buffers, "Find buffer")
k("n", "<leader>fg", require("snacks").picker.grep, "Find by grep")
k("n", "<leader>fp", require("snacks").picker.projects, "Find project")

k("n", "<leader>tg", "<cmd>Neogit<CR>", "Toggle neogit")
k("n", "<leader>tu", "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>", "Toggle undotree")

k('i', '<C-space>', vim.lsp.completion.get, "Toggle completion menu")
k("i", '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], "Go down in completion menu", true)
k("i", '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], "Go up in completion menu", true)
k("i", '<C-j>', [[pumvisible() ? "\<C-n>" : "\<C-j>"]], "Go down in completion menu", true)
k("i", '<C-k>', [[pumvisible() ? "\<C-p>" : "\<C-k>"]], "Go up in completion menu", true)

k("v", "J", ":m '>+1<CR>gv=gv", "Move Selected Text Down")
k("v", "K", ":m '<-2<CR>gv=gv", "Move Selected Text Up")
--}}
