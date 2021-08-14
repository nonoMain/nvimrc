--startOfFile
-- Filename: java_lsconfig.lua

HOME = vim.fn.expand('$VIMRCFOLDER')

local java_language_server_wrapper = "/releated/jdtls.sh"

require'lspconfig'.jdtls.setup
{
	cmd = {HOME .. java_language_server_wrapper};
	filetypes = {
		"java",
	}
}

--endOfFile
