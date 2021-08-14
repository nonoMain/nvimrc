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

" Open Netrw faster
	nnoremap <leader>e :Explore<CR>

"endOfFile
