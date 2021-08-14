"startOfFile
" Filename: nvim_lsconfig.vim

set completeopt=menuone,noinsert,noselect

" LSP binding (the mappings used in the default file don't work well for me)
	nnoremap <silent> gd        :lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> gD        :lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> gr        :lua vim.lsp.buf.references()<CR>
	nnoremap <silent> gi        :lua vim.lsp.buf.implementation()<CR>
	nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<CR>
	nnoremap <silent> <C-k>     :lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> <C-n>     :lua vim.lsp.diagnostic.goto_prev()<CR>
	nnoremap <silent> <C-p>     :lua vim.lsp.diagnostic.goto_next()<CR>
"endOfFile
