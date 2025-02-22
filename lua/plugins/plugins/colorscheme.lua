return { 
	"Yazeed1s/minimal.nvim", 
	config = function()
		vim.cmd("colorscheme minimal")
		-- vim.cmd("colorscheme minimal")

		vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1e1e2e", fg = "#cdd6f4" })  -- Set a visible background
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#89b4fa", fg = "#1e1e2e" }) -- Highlighted item
	end
}
