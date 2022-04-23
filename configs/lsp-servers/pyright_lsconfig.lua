-- File Documentation
-- Filename: pyright_lsconfig.lua
-- Author: nonomain
-- last updated: 31/01/22 17:39:11
-- Description:
--	configuration for the lsp of pyright

SERVER_PATH = vim.g.python_ls_path


require'lspconfig'.pyright.setup
{
	cmd = {SERVER_PATH .. "/node_modules/pyright/langserver.index.js", "--stdio"},
	filetypes = {
		"python",
	};
	on_attach = vim.g.on_attach_lspconfig_global;
	handlers = vim.g.handlers_lspconfig_global;
}
