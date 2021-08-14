--startOfFile
-- Filename: vim_lsconfig.lua

-- Installation: npm install -g vim-language-server
HOME = vim.fn.expand('$HOME')

local language_server_path = "/.ls-servers/vim-language-server"
local full_path

full_path = HOME .. language_server_path

require'lspconfig'.vimls.setup {
    cmd = {full_path .. "/node_modules/.bin/vim-language-server", "--stdio"},
}
--endOfFile
