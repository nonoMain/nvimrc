"startOfFile
" Filename: keybindings.vim

" Faster way to ESC from insert mode:
	inoremap jk <ESC>

" Keeping the cursor centered when moving between matches:
	nnoremap n nzz
	nnoremap N Nzz

" Better moving of a visual block:
	" sub/add tabs using '<' and '>'
	vnoremap < <gv
	vnoremap > >gv
	" move up or down a line by 'K' or 'J'
	vnoremap J :m '>+1<CR>gv
	vnoremap K :m '<-2<CR>gv

" Allow increament and decreament with Alt
" Ctrl-a/Ctrl-x are sometimes used for actions in the shell itself
" so another way is always handy
	nnoremap <A-a> <C-a>
	nnoremap <A-x> <C-x>

" Easy split resizing
"nnoremap <silent> <C-s>+ :exe "resize " . (winheight(0) * 3/2)<CR>
"nnoremap <silent> <C-s>- :exe "resize " . (winheight(0) * 2/3)<CR>

" Faster way to open/close netrw (Explorer)
noremap <silent> <leader>e :call g:ToggleNetrw()<CR>
noremap <silent> <leader>h :call BrowseOldfiles#ToggleHistory()<CR>

" Get current highlight-group under cursor
nnoremap <f10> :TSHighlightCapturesUnderCursor<CR>

"endOfFile
