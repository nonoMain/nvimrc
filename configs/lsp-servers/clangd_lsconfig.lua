-- File Documentation
-- Filename: clangd_lsconfig.lua
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
	on_attach = vim.g.on_attach_lspconfig_global;
	handlers = vim.g.handlers_lspconfig_global;
}
