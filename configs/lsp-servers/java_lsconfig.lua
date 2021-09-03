--startOfFile
-- Filename: java_lsconfig.lua
PATH = vim.g.java_ls_path

require'lspconfig'.jdtls.setup
{
	cmd = {PATH};
	filetypes = {
		"java",
	}
}

--endOfFile
