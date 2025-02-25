local tbuiltin = require("telescope.builtin")
local tthemes = require("telescope.themes")
local harpoon = require("harpoon")
local todo = require("todo-comments")

-- Helper function for keybinds
local function k(mode, key, action, desc)
  vim.keymap.set(mode, key, action, { desc = desc })
end

-- HEAD: Keybinds for all modes

-- Clipboard operations
k("", "<Leader>p", '"+p', "Paste from System Clipboard")
k("", "<Leader>y", '"+y', "Yank to System Clipboard")
k("", "<Leader>yu", 'gg0vG$"+y', "Copy the Buffer to Clipboard")

-- HEAD: Normal mode keybinds

-- Remove search highlighting
k("n", "<Esc>", "<cmd>nohlsearch<CR>", "Remove Search Highlighting")
-- Telescope keymaps
k("n", "<leader>f?", "<CMD>Telescope help_tags<CR>", "Search Help")
k("n", "<leader>fm", "<CMD>Telescope<CR>", "Select Telescope")
k("n", "<leader>fw", "<CMD>Telescope grep_string<CR>", "Search Current Word")
k("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", "Search by Grep")
k("n", "<leader>fd", "<CMD>Telescope diagnostics<CR>", "Search Diagnostics")
k("n", "<leader>fr", "<CMD>Telescope resume<CR>", "Resume Search")
k("n", "<leader>f.", "<CMD>Telescope oldfiles<CR>", "Search Recent Files")
k("n", "<leader>fb", "<CMD>Telescope buffers<CR>", "Find Buffers")
k("n", "<leader>ff", "<CMD>Telescope find_files<CR>", "Search Files")
k("n", "<Leader>ft", "<cmd>TodoTelescope<CR>", "Telescope Todo Marks")
k("n", "<leader>f/", function()
  tbuiltin.current_buffer_fuzzy_find(tthemes.get_dropdown({ winblend = 10, previewer = false }))
end, "Fuzzily Search in Current Buffer")
k("n", "<leader>s/", function()
  tbuiltin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
end, "Search in Open Files")

-- Diagnostic keymaps
k("n", "[d", vim.diagnostic.goto_prev, "Go to Previous Diagnostic")
k("n", "]d", vim.diagnostic.goto_next, "Go to Next Diagnostic")
k("n", "<leader>e", vim.diagnostic.open_float, "Show Diagnostic Errors")
k("n", "<leader>q", vim.diagnostic.setloclist, "Open Diagnostic Quickfix List")

-- Quickfix list cycling
k("n", "[q", "<cmd>cnext<CR>", "Go to Next in Quickfix List")
k("n", "]q", "<cmd>cprev<CR>", "Go to Previous in Quickfix List")

-- Undo/Redo operations
k("n", "<S-u>", "<C-r>", "Redo")

-- Buffer navigation
k("n", "<leader>bb", "<cmd>bp<CR>", "Previous Buffer")
k("n", "<leader>bn", "<cmd>bn<CR>", "Next Buffer")
k("n", "<leader>br", "<cmd>b#<CR>", "Recent Buffer")
k("n", "[b", "<cmd>bp<CR>", "Previous Buffer")
k("n", "]b", "<cmd>bn<CR>", "Next Buffer")
k("n", "t", "<cmd>b#<CR>", "Recent Buffer")

-- Undo Tree toggle
k("n", "<leader>tu", "<cmd>UndotreeToggle<CR>", "Toggle Undo Tree")

-- Copy buffer content
k("n", "yu", "gg0vG$y", "Copy the Buffer")

-- Window navigation keymaps
k("n", "<C-h>", "<C-w><C-h>", "Move Focus Left")
k("n", "<C-l>", "<C-w><C-l>", "Move Focus Right")
k("n", "<C-j>", "<C-w><C-j>", "Move Focus Down")
k("n", "<C-k>", "<C-w><C-k>", "Move Focus Up")

-- Arrow key window navigation (for some users)
k("n", "<C-Left>", "<C-w><C-h>", "Move Focus Left")
k("n", "<C-Right>", "<C-w><C-l>", "Move Focus Right")
k("n", "<C-Down>", "<C-w><C-j>", "Move Focus Down")
k("n", "<C-Up>", "<C-w><C-k>", "Move Focus Up")

-- Enter resize mode (Ctrl+w+r)
k("n", "<C-w>r", function()
  print("-- RESIZE MODE --")
  local opts = { noremap = true, silent = true, buffer = true }

  -- Resize bindings
  vim.keymap.set("n", "h", ":vertical resize -1<CR>", opts)
  vim.keymap.set("n", "l", ":vertical resize +1<CR>", opts)
  vim.keymap.set("n", "k", ":resize +1<CR>", opts)
  vim.keymap.set("n", "j", ":resize -1<CR>", opts)

  -- Exit resize mode with Escape
  vim.keymap.set("n", "<Esc>", function()
    print(" ")
    vim.api.nvim_buf_del_keymap(0, "n", "h")
    vim.api.nvim_buf_del_keymap(0, "n", "l")
    vim.api.nvim_buf_del_keymap(0, "n", "k")
    vim.api.nvim_buf_del_keymap(0, "n", "j")
    vim.api.nvim_buf_del_keymap(0, "n", "<Esc>")
  end, opts)
end, "Enter Resize Mode")

-- Todo comments navigation
k("n", "]t", function() todo.jump_next() end, "Next Todo Comment")
k("n", "[t", function() todo.jump_prev() end, "Previous Todo Comment")

-- Format buffer using conform
k("n", "<leader>F", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, "Format Buffer")

-- Harpoon keymaps
k("n", "<C-e>", function() harpoon:list():add() end, "Add to Harpoon")
k("n", "gh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Toggle Harpoon Menu")
for i = 1, 9 do k("n", "g"..i, function() harpoon:list():select(i) end, "Select Harpoon "..i) end

-- Open compile mode
k("n", "<leader>j", ":Compile ", "Open Compile Mode")

-- Search and replace word in buffer
k("n", "<leader>cr", function()
  local old_word = vim.fn.input("Word to replace: ")
  if old_word == "" then return end
  local new_word = vim.fn.input("Replace with: ")
  local save_cursor = vim.fn.getpos(".")
  vim.cmd("%s/\\<" .. old_word .. "\\>/" .. new_word .. "/g")
  vim.fn.setpos(".", save_cursor)
end, "Search and Replace in Buffer")

-- Replace word under cursor
k("n", "cc", function()
  local word = vim.fn.expand("<cword>")
  local new_word = vim.fn.input("Replace with: ")
  if new_word ~= "" then
    local save_cursor = vim.fn.getpos(".")
    vim.cmd("%s/\\<" .. word .. "\\>/" .. new_word .. "/g")
    vim.fn.setpos(".", save_cursor)
  end
end, "Replace Word in Buffer")

-- LSP keymaps
k("n", "gd", tbuiltin.lsp_definitions, "Goto Definition")
k("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
k("n", "gr", tbuiltin.lsp_references, "Goto References")
k("n", "gI", tbuiltin.lsp_implementations, "Goto Implementation")
k("n", "<leader>lt", tbuiltin.lsp_type_definitions, "Type Definition")
k("n", "<leader>ls", tbuiltin.lsp_document_symbols, "Document Symbols")
k("n", "<leader>lp", tbuiltin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
k("n", "<leader>lr", vim.lsp.buf.rename, "Rename symbol")
k("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
k("n", "<leader>cd", tbuiltin.diagnostics, "Show Files with Errors")
k("n", "<leader>ci", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.addMissingImports" } }, apply = true,
  })
end, "Import Missing Items")
k("n", "K", vim.lsp.buf.hover, "Hover Documentation")

-- HEAD: Visual mode keybinds

-- Move selected text up or down
k("v", "J", ":m '>+1<CR>gv=gv", "Move Selected Text Down")
k("v", "K", ":m '<-2<CR>gv=gv", "Move Selected Text Up")
k("v", "<S-Up>", ":m '<-2<CR>gv=gv", "Move Selected Text Up")
k("v", "<S-Down>", ":m '>+1<CR>gv=gv", "Move Selected Text Down")
