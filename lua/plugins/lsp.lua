return { 
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },
	},
	opts ={ 
		servers = {
			lua_ls = {},
			clangd = {},
			gopls = {},
			c3_lsp = {},
		}
	},
	config = function(_, opts)
		--  This function gets run when an LSP attaches to a particular buffer.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("5rdala-lsp-attach", { clear = true }),
			callback = function(event)
				-- Highlight references of the word under cursor
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		-- Create capabilities for LSP servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- Use blink.cmp instead of nvim-cmp for capabilities
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

		-- Setup mason
		require("mason").setup()

		-- Ensure these tools are installed
		require("mason-tool-installer").setup({
			ensure_installed = {
				"gopls", "stylua", "clangd",
			},
		})

		-- Setup mason-lspconfig with handlers
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = opts.servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
