--startOfFile
-- Filename: ccls_lsconfig.lua

-- easiest option to get it if you don't have it:
-- sudo apt install ccls

require'lspconfig'.ccls.setup
{
	cmd = { "ccls" };
	filetypes = {
		"c",
		"cpp",
		"objc",
		"objcpp",
	};
}
--endOfFile
