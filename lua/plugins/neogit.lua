return {
	"NeogitOrg/neogit",
	commit = "028e9ee",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup()
	end,
}
