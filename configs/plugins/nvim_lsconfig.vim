"startOfFile
" Filename: nvim_lsconfig.vim

lua << EOF
local nvim_lsp = require('lspconfig')

local icons = {
  Class = "  class",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " field",
  File = " file",
  Folder = " ",
  Function = " func",
  Interface = "ﰮ interface",
  Keyword = " ",
  Method = "ƒ meth",
  Module = " module",
  Property = " prop",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " val",
  Variable = " var",
  Reference = "壟 ref",
}

-- LSP settings
local setSymbols = function()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = icons[kind] or kind
  end
end

-- set the items symbols
if vim.g.Use_dev_icons == 1 then setSymbols() end
EOF

set completeopt=menuone,noinsert,noselect

" LSP binding (the mappings used in the default file don't work well for me)
	nnoremap <silent> gd        :lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> gD        :lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> gr        :lua vim.lsp.buf.references()<CR>
	nnoremap <silent> gi        :lua vim.lsp.buf.implementation()<CR>
	nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<CR>
	nnoremap <silent> <C-k>     :lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> <C-p>     :lua vim.lsp.diagnostic.goto_prev()<CR>
	nnoremap <silent> <C-n>     :lua vim.lsp.diagnostic.goto_next()<CR>
"endOfFile
