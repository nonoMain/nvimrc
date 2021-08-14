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
}
--endOfFile
