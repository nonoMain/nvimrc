--startOfFile
-- Filename: tree_sitter.lua

require'nvim-treesitter.configs'.setup
{
	highlight = {
		enable = true,              -- false will disable the whole extension
		disable = {},  -- list of languages that will be disabled
	},
	ignore_install = {}, -- List of parsers to ignore installing
	ensure_installed = { -- one of "all", "maintained" (parsers with maintainers), or a list of languages
		"c",
		"cpp",
		"python",
		"lua",
		"bash",
		"java"
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = 'o',
			toggle_hl_groups = 'i',
			toggle_injected_languages = 't',
			toggle_anonymous_nodes = 'a',
			toggle_language_display = 'I',
			focus_language = 'f',
			unfocus_language = 'F',
			update = 'R',
			goto_node = '<cr>',
			show_help = '?',
		},
	}
}
--endOfFile
