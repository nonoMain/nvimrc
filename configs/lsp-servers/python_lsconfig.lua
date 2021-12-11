--startOfFile
-- FIlename: python_lsconfig.lua

SERVER_PATH = vim.g.python_ls_path

require'lspconfig'.pyright.setup
{
	cmd = {SERVER_PATH .. "/node_modules/pyright/langserver.index.js", "--stdio"},
	filetypes = {
		"python",
	}
}
--endOfFile
