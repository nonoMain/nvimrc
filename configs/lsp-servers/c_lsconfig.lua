--startOfFile
-- Filename: ccls_lsconfig.lua

-- easiest option to get it if you don't have it:
-- sudo apt install ccls

require'lspconfig'.clangd.setup
{
	cmd = { "clangd" };
	filetypes = {
		"c",
		"cpp",
		"objc",
		"objcpp",
	};
}
--endOfFile
