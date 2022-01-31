" File Documentation
" Filename: nvim_lspconfig.vim
" Author: nonomain
" last updated: 31/01/22 17:44:26
" Description:
"	configuration for the nvim_lsconfig plugin

lua << EOF
require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})
EOF

"set completeopt=menuone,noinsert,noselect

" LSP binding (the mappings used in the default file don't work well for me)
	nnoremap <silent> gd        :lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> gD        :lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> gr        :lua vim.lsp.buf.references()<CR>
	nnoremap <silent> gi        :lua vim.lsp.buf.implementation()<CR>
	nnoremap <silent> ga        :lua vim.lsp.buf.code_action()<CR>
	nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<CR>
	nnoremap <silent> <C-k>     :lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> <C-p>     :lua vim.lsp.diagnostic.goto_prev()<CR>
	nnoremap <silent> <C-n>     :lua vim.lsp.diagnostic.goto_next()<CR>

" Source all the lsp-configs
	luafile $MYVIMRCFOLDER/configs/lsp-servers/python_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/c_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/java_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/lua_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/vim_lsconfig.lua
