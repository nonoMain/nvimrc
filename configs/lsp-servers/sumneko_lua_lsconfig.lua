-- File Documentation
-- Filename: sumneko_lua_lsconfig.lua
-- Author: nonomain
-- last updated: 31/01/22 17:38:37
-- Description:
--	configuration for the lsp of lua-language-server

-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

SERVER_PATH = vim.g.lua_ls_path

local sumneko_root_path = ""
local sumneko_binary = ""

sumneko_root_path = SERVER_PATH
sumneko_binary = SERVER_PATH .. "/bin/lua-language-server"


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
	};
	on_attach = vim.g.on_attach_lspconfig_global;
	handlers = vim.g.handlers_lspconfig_global;
}
