-- File Documentation
-- Filename: gopls_lsconfig.lua
-- Author: nonomain
-- last updated: 01/02/22 12:26:24
-- Description:
--	configuration for the lsp of gopls

SERVER_PATH = vim.g.go_ls_path


require'lspconfig'.gopls.setup
{
	cmd = { SERVER_PATH };
	on_attach = vim.g.on_attach_lspconfig_global;
	handlers = vim.g.handlers_lspconfig_global;
}
