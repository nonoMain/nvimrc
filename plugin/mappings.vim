"startOfFile
"
" Filename: mappings.vim

" Faster way to ESC from insert mode:
	inoremap jk <ESC>

" Keeping the cursor centered when moving between matches:
	nnoremap n nzz
	nnoremap N Nzz

" Better visual block:
	" sub/add tabs using '<' and '>'
	vnoremap < <gv
	vnoremap > >gv
	" move up or down a line by 'K' or 'J'
	vnoremap J :m '>+1<CR>gv
	vnoremap K :m '<-2<CR>gv
	" paste without overwriting the paste register
	vnoremap P "_dP

" Allow increament and decreament with Alt
" Ctrl-a/Ctrl-x are sometimes used for actions in the shell itself
" so another way is always handy
	nnoremap <A-a> <C-a>
	nnoremap <A-x> <C-x>

" Faster way to open/close netrw (Explorer)
noremap <silent> <leader>e :call Netrw#Toggle()<CR>
noremap <silent> <leader>h :call BrowseOldfiles#ToggleHistory()<CR>
noremap <silent> <leader>m :call Maximize#Toggle()<CR>

" Get current highlight-group under cursor
nnoremap <f10> :TSHighlightCapturesUnderCursor<CR>

let g:UltiSnipsJumpForwardTrigger="<c-x>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"endOfFile
