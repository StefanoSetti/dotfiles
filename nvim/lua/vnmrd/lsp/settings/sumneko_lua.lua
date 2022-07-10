return {
	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim" }, -- It works globally.
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
