--startOfFile
-- Filename: lua_lsconfig.lua

-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
HOME = vim.fn.expand('$HOME')

local lua_language_server_path = "/.ls-servers/lua-language-server"
local sumneko_root_path = ""
local sumneko_binary = ""

sumneko_root_path = HOME .. lua_language_server_path
sumneko_binary = HOME .. lua_language_server_path .. "/bin/Linux/lua-language-server"

require'lspconfig'.sumneko_lua.setup {
	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';')
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'}
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
				maxPreload = 10000
			}
		}
	}
}
--endOfFile
