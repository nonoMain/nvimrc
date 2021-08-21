--startOfFile
-- FIlename: python_lsconfig.lua

-- Installation: npm i -g pyright
HOME = vim.fn.expand('$HOME')

require'lspconfig'.pyright.setup
{
	cmd = {HOME .. "/.ls-servers/pyright/packages/pyright/langserver.index.js", "--stdio"},
	filetypes = {
		"python",
	}
}
--endOfFile
