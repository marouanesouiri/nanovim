return {
	{ -- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{ -- undo-tree.nvim
		"mbbill/undotree",
	},
	-- lua/plugins/c3.lua
    {
        "wstucco/c3.nvim",
        config = function()
            require("c3")
        end,
    },
}
