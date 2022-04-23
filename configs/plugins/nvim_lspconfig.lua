-- File Documentation
-- Filename: nvim_lspconfig.lua
-- Author: nonomain
-- last updated: 31/01/22 17:44:26
-- Description:
--	configuration for the nvim_lsconfig plugin


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }

local border = {
	{ '┌', 'FloatBorder' },
	{ '─', 'FloatBorder' },
	{ '┐', 'FloatBorder' },
	{ '│', 'FloatBorder' },
	{ '┘', 'FloatBorder' },
	{ '─', 'FloatBorder' },
	{ '└', 'FloatBorder' },
	{ '│', 'FloatBorder' },
}

-- LSP handlers settings (for overriding per client)
vim.g.handlers_lspconfig_global =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
vim.g.on_attach_lspconfig_global = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-p>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-n>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

-- make sure all this have `on_attach = vim.g.on_attach_lspconfig` in their config

vim.cmd [[
	luafile $MYVIMRCFOLDER/configs/lsp-servers/pyright_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/clangd_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/gopls_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/jdtls_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/sumneko_lua_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/vimls_lsconfig.lua
]]

