"startOfFile
" Filename: file_settings.vim

" enable swap files
set swapfile
" keep the lines as they are
set nowrap

" set fileencoding
set encoding=utf-8 nobomb
set fileencoding=utf-8 nobomb

" enable file type detection
filetype on

" FILE FOLDING SETTINGS:
	" set folds method to indent
	set fdm=indent
	" set foldlevel to one above the current maximum in the file for easier
	" folding and unfolding
	augroup foldTeller
		autocmd!
		autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
	augroup END

"endOfFile
