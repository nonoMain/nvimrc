"startOfFile
" Color
	set termguicolors
	colorscheme cplex

" Cursor highlights
	set guicursor=
	set cursorcolumn
	set cursorline

" Undo
	set undodir=~/.nvim/undodir
	set undofile
	set undolevels=1000
	set undoreload=10000

" List
	set list " show tabs, end of lines and trailing spaces
	if g:Use_nerdfont
		set listchars=tab:\ ,eol:¬,trail:~,extends:>,precedes:< " ·
	else
		set listchars=tab:▸\ ,eol:¬,trail:~,extends:>,precedes:< " ·
	endif

" Indentation settings:
	set tabstop=4 " how many spaces a tab is
	set shiftwidth=4 " how many spaces for every level of indentation
	set autoindent " preserve indentation
	set smartindent " smart indentation for languages
	set noexpandtab " keep tabs as tabs

" Search settings:
	set hlsearch " highlight all search patterns
	set incsearch " enable incremental search
	set wildmenu " display all matching searches

" Number
	set number " show current line number
	set relativenumber " show relative line numbers

" Buffer
	set updatetime=500
	set hidden " navigate to another buffer without saving current buffer
	set nowrap " don't wrap lines around

" File
	filetype on
	filetype plugin on
	set swapfile
	set encoding=utf-8 nobomb
	set fileencoding=utf-8 nobomb
	set fdm=indent " set folds method to indent
	" set foldlevel to the current max in the file for easier folding:
	augroup foldTeller
		autocmd!
		autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
	augroup END

" Other
	set backspace=indent,eol,start
	set lazyredraw " Smart redraw
	set colorcolumn=80 " length of limit length line
	set showtabline=2 " always show tabline
	set noerrorbells " silent errors
	set fillchars=stlnc:\ ,stl:\ ,vert:\│,fold:-,diff:-

"endOfFile
