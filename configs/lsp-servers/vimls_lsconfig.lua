-- File Documentation
-- Filename: vimls_lsconfig.lua
-- Author: nonomain
-- last updated: 31/01/22 17:40:56
-- Description:
--	configuration for the lsp of vimls

SERVER_PATH = vim.g.vim_ls_path

require'lspconfig'.vimls.setup {
    cmd = {SERVER_PATH .. "/node_modules/.bin/vim-language-server", "--stdio"};
	on_attach = vim.g.on_attach_lspconfig_global;
	handlers = vim.g.handlers_lspconfig_global;
}
