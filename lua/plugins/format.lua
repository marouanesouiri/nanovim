return { -- Autoformat
	"stevearc/conform.nvim",
	lazy = false,
	-- config
	config = function()
		require("conform").setup({
			-- Map of filetype to formatters
			formatters_by_ft = {
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
				c = { "clang-format" },
				lua = { "stylua" },
				python = { "black" },
				javascript = { { "prettierd", "prettier" } },
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			-- If this is set, Conform will run the formatter on save.
			-- It will pass the table to conform.format().
			-- This can also be a function that returns the table.
			format_on_save = {
				-- I recommend these options. See :help conform.format for details.
				lsp_fallback = true,
				timeout_ms = 500,
			},
			-- If this is set, Conform will run the formatter asynchronously after save.
			-- It will pass the table to conform.format().
			-- This can also be a function that returns the table.
			format_after_save = {
				lsp_fallback = true,
			},
			-- Set the log level. Use `:ConformInfo` to see the location of the log file.
			log_level = vim.log.levels.ERROR,
			-- Conform will notify you when a formatter errors
			notify_on_error = true,
		})
	end,
}
