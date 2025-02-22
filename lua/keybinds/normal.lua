local key = function(key, commands, desc)
	vim.keymap.set("n", key, commands, { desc = desc or "" })
end

------------------------------------------------------------------------------

-- HEAD: remove the highlighting from the search mode
key("<Esc>", "<cmd>nohlsearch<CR>")

-- HEAD: Telescope
local builtin = require("telescope.builtin")
key("<leader>f?", "<CMD>Telescope help_tags<CR>", "Search Help")
key("<leader>fm", "<CMD>Telescope<CR>", "Search Select Telescope")
key("<leader>fw", "<CMD>Telescope grep_string<CR>", "Search current Word")
key("<leader>fg", "<CMD>Telescope live_grep<CR>", "Search by Grep")
key("<leader>fd", "<CMD>Telescope diagnostics<CR>", "Search Diagnostics")
key("<leader>fr", "<CMD>Telescope resume<CR>", "Search Resume")
key("<leader>f.", "<CMD>Telescope oldfiles<CR>", "Search Recent Files")
key("<leader>fb", "<CMD>Telescope buffers<CR>", "Find existing buffers")
key("<leader>ff", "<CMD>Telescope find_files<CR>", "Search Files")
key("<Leader>ft", "<cmd>TodoTelescope<CR>", "Telescope todo marks")
key("<leader>f/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, "Fuzzily search in current buffer")
key("<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, "Search in Opened Files")

-- HEAD: Diagnostic keymaps
key("[d", vim.diagnostic.goto_prev, "Go to previous Diagnostic message")
key("]d", vim.diagnostic.goto_next, "Go to next Diagnostic message")
key("<leader>e", vim.diagnostic.open_float, "Show diagnostic Error messages")
key("<leader>q", vim.diagnostic.setloclist, "Open diagnostic Quickfix list")

-- HEAD: Key mappings for cycling through quickfix list
key("[q", "<cmd>cnext<CR>", "Go next on Quick fix list")
key("]q", "<cmd>cprev<CR>", "Go previous on Quick fix list ")

-- HEAD: redu with sift + u
key("<S-u>", "<C-r>", "Just redu")

-- HEAD: buffer prev/next key maps
key("<leader>bb", "<cmd>bp<CR>", "Buffer Previous")
key("[b", "<cmd>bp<CR>", "Buffer Previous")
key("<leader>bn", "<cmd>bn<CR>", "Buffer Next")
key("]b", "<cmd>bn<CR>", "Buffer Next")
key("<leader>br", "<cmd>b#<CR>", "Buffer Recent")
key("t", "<cmd>b#<CR>", "Buffer Recent")

-- HEAD: undo tree
key("<leader>tu", "<cmd>UndotreeToggle<CR>", "Toggle Undotree")

-- HEAD: copy buffer
key("yu", "gg0vG$y", "Copy the buffer")

-- HEAD: Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
key("<C-h>", "<C-w><C-h>", "Move focus to the left window")
key("<C-l>", "<C-w><C-l>", "Move focus to the right window")
key("<C-j>", "<C-w><C-j>", "Move focus to the lower window")
key("<C-k>", "<C-w><C-k>", "Move focus to the upper window")

-- HEAD: todo comments keymaps
local todo = require("todo-comments")
key("]t", function()
	todo.jump_next()
end, "Next todo comment")

key("[t", function()
	todo.jump_prev()
end, "Previous todo comment")

-- HEAD: formatter keymaps
key("<C-r>", ":!", "Run command")

-- HEAD: formatter keymaps
key("<leader>F", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, "Format buffer")

-- HEAD: harpoon
local harpoon = require("harpoon")
key("<C-e>", function()
	harpoon:list():add()
end, "Add to harpoon")

key("gh", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, "Toggle harpoon menu")

key("g1", function()
	harpoon:list():select(1)
end, "Select harpoon 1")
key("g2", function()
	harpoon:list():select(2)
end, "Select harpoon 2")
key("3", function()
	harpoon:list():select(3)
end, "Select harpoon 3")
key("4", function()
	harpoon:list():select(4)
end, "Select harpoon 4")
