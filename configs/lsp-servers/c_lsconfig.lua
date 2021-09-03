--startOfFile
-- Filename: ccls_lsconfig.lua

-- easiest option to get it if you don't have it:
-- sudo apt install ccls

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
--endOfFile
