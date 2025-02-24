-- HEAD: Keybinds for all modes

-- Interact with system clipboard
vim.keymap.set("", "<Leader>p", '"+p', { desc = "Paste from system clipboard" }) -- Paste
vim.keymap.set("", "<Leader>y", '"+y', { desc = "Yank to system clipboard" }) -- Yank
-- Copy entire buffer to clipboard
vim.keymap.set("", "<Leader>yu", 'gg0vG$"+y', { desc = "Copy the buffer to system clipboard" })
--  HEAD: Normal mode keybinds.
--  remove the highlighting from the search mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f?", "<CMD>Telescope help_tags<CR>", { desc = "Search Help" })
vim.keymap.set("n", "<leader>fm", "<CMD>Telescope<CR>", { desc = "Search Select Telescope" })
vim.keymap.set("n", "<leader>fw", "<CMD>Telescope grep_string<CR>", { desc = "Search current Word" })
vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", { desc = "Search by Grep" })
vim.keymap.set("n", "<leader>fd", "<CMD>Telescope diagnostics<CR>", { desc = "Search Diagnostics" })
vim.keymap.set("n", "<leader>fr", "<CMD>Telescope resume<CR>", { desc = "Search Resume" })
vim.keymap.set("n", "<leader>f.", "<CMD>Telescope oldfiles<CR>", { desc = "Search Recent Files" })
vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>", { desc = "Find existing buffers" })
vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Search Files" })
vim.keymap.set("n", "<Leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Telescope todo marks" })
vim.keymap.set("n", "<leader>f/", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ winblend = 10, previewer = false, }))
end, { desc = "Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>s/", function()
  builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files", })
end, { desc = "Search in Opened Files" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous Diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next Diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

-- Key mappings for cycling through quickfix list
vim.keymap.set("n", "[q", "<cmd>cnext<CR>", { desc = "Go next on Quick fix list" })
vim.keymap.set("n", "]q", "<cmd>cprev<CR>", { desc = "Go previous on Quick fix list" })

-- redo with shift + u
vim.keymap.set("n", "<S-u>", "<C-r>", { desc = "Just redo" })

-- buffer prev/next key maps
vim.keymap.set("n", "<leader>bb", "<cmd>bp<CR>", { desc = "Buffer Previous" })
vim.keymap.set("n", "[b", "<cmd>bp<CR>", { desc = "Buffer Previous" })
vim.keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Buffer Next" })
vim.keymap.set("n", "]b", "<cmd>bn<CR>", { desc = "Buffer Next" })
vim.keymap.set("n", "<leader>br", "<cmd>b#<CR>", { desc = "Buffer Recent" })
vim.keymap.set("n", "t", "<cmd>b#<CR>", { desc = "Buffer Recent" })

-- undo tree
vim.keymap.set("n", "<leader>tu", "<cmd>UndotreeToggle<CR>", { desc = "Toggle Undotree" })

-- copy buffer
vim.keymap.set("n", "yu", "gg0vG$y", { desc = "Copy the buffer" })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- arrows version (some of my friends use my config and use the arrows)
vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Bind Ctrl+w+r  to enter resize mode
vim.keymap.set("n", "<C-w>r", function()
  print("-- RESIZE --")
  local opts = { noremap = true, silent = true, buffer = true }

  -- Resize with h/j/k/l
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
end, { desc = "Enter Resize Mode" })

-- todo comments keymaps
local todo = require("todo-comments")
vim.keymap.set("n", "]t", function()
  todo.jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  todo.jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", "<leader>F", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<C-e>", function() harpoon:list():add()
end, { desc = "Add to harpoon" })

vim.keymap.set("n", "gh", function() harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle harpoon menu" })

for i = 1,9,1 do
  vim.keymap.set("n", "g"..i, function() harpoon:list():select(1)
  end, { desc = "Select harpoon "..i })
end

-- open compile mode
vim.keymap.set("n", "<leader>j", ":Compile ", { desc = "Open compile mode" })

-- Replace the word under the cursor
vim.keymap.set("n", "gr", function()
  local word = vim.fn.expand("<cword>")
  local new_word = vim.fn.input("Replace with: ") 
  if new_word ~= "" then
    local save_cursor = vim.fn.getpos(".")
    vim.cmd("%s/\\<" .. word .. "\\>/" .. new_word .. "/g")
    vim.fn.setpos(".", save_cursor)
  end
end, { desc = "Replace word in buffer" })

-- Replace a word
vim.keymap.set("n", "<leader>cr", function()
  local old_word = vim.fn.input("Word to replace: ")
  if old_word == "" then return end

  local new_word = vim.fn.input("Replace with: ")
  local save_cursor = vim.fn.getpos(".")

  vim.cmd("%s/\\<" .. old_word .. "\\>/" .. new_word .. "/g")
  vim.fn.setpos(".", save_cursor)
end, { desc = "Search and replace in buffer" })

--  HEAD: Visual mode keybinds.

-- move the selected text up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected text up" })
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selected text up" })
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selected text down" })

