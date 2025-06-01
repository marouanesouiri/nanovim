return { 
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		-- edit status line
		vim.opt.statusline = " %f %m %= %l:%c 🍁 "

		require("rose-pine").setup({
			disable_background = true,
			highlight_groups = {
				StatusLine = { fg = "none", bg = "none", blend = 10 },
				StatusLineNC = { fg = "subtle", bg = "surface" },
				CurSearch = { fg = "base", bg = "leaf", inherit = false },
				Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
				TelescopeBorder = { fg = "highlight_high", bg = "none" },
				TelescopeNormal = { bg = "none" },
				TelescopePromptNormal = { bg = "base" },
				TelescopeResultsNormal = { fg = "subtle", bg = "none" },
				TelescopeSelection = { fg = "text", bg = "base" },
				TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
			},
		})

		vim.cmd("colorscheme rose-pine")
	end
}
