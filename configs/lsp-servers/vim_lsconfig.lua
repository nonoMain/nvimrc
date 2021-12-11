--startOfFile
-- Filename: vim_lsconfig.lua

SERVER_PATH = vim.g.vim_ls_path

require'lspconfig'.vimls.setup {
    cmd = {SERVER_PATH .. "/node_modules/.bin/vim-language-server", "--stdio"},
}
--endOfFile
