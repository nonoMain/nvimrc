-- File Documentation
-- Filename: c_lsconfig.lua
-- Author: nonomain
-- last updated: 31/01/22 17:36:12
-- Description:
--	configuration for the lsp of clang

SERVER_PATH = vim.g.c_ls_path

require'lspconfig'.clangd.setup
{
	cmd = { SERVER_PATH };
	filetypes = {
		"c",
		"cpp",
		"objc",
		"objcpp",
	};
}
