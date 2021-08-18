local queries = require"nvim-treesitter".query

require("nvim-treesitter").define_modules {
	refactor = {
		highlight_current_scope = {
			module_path = "easyCodeActions.hl_curr_scope",
			enable = false,
			disable = {},
			is_supported = queries.has_locals,
		},
	},
}
