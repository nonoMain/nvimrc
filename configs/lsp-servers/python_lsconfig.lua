--startOfFile
-- FIlename: python_lsconfig.lua

-- Installation: npm i -g pyright
SERVER_PATH = vim.g.python_ls_path

require'lspconfig'.pyright.setup
{
	cmd = {SERVER_PATH .. "/packages/pyright/langserver.index.js", "--stdio"},
	filetypes = {
		"python",
	}
}
--endOfFile
