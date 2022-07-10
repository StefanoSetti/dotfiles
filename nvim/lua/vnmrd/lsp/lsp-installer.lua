local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("vnmrd.lsp.handlers").on_attach,
		capabilities = require("vnmrd.lsp.handlers").capabilities,
	}

	-- The following commands expands the `opts` table depending on the type of file in use.

	 if server.name == "jsonls" then
	 	local jsonls_opts = require("vnmrd.lsp.settings.jsonls")
	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	 end

	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("vnmrd.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

	 -- TODO
	 if server.name == "rust_analyzer" then
	 	local rust_opts = require("vnmrd.lsp.settings.rust_analyzer")
	 	opts = vim.tbl_deep_extend("force", rust_opts, opts)
	 end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

