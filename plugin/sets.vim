"startOfFile
" Filename: sets.vim
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
	if g:Use_devicons
		set listchars=tab:\ ,eol:¬,trail:~,extends:>,precedes:< " ·
	else
		set listchars=tab:▸\ ,eol:¬,trail:~,extends:>,precedes:< " ·
	endif

" Indentation settings:
	set tabstop=4 " how many spaces a tab is
	set shiftwidth=4
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
	set nowrap " don't wrap lines at the end

" File
	filetype on
	filetype plugin on
	set swapfile
	set encoding=utf-8
	set fileencoding=utf-8
	set fdm=indent " set folds method to indent
	" set foldlevel to the current max in the file for easier folding:
	augroup foldTeller
		autocmd!
		autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
	augroup END

" Other
	set mouse=a " use mouse
	set showmatch " show matching brackets
	set showmode " show current mode
	set showtabline=2 " show tabline
	set backspace=indent,eol,start
	set lazyredraw " Smart redraw
	set colorcolumn=100 " default suggested length for a line
	set noerrorbells " silent errors
	set fillchars=stlnc:\ ,stl:\ ,vert:\│,fold:-,diff:-

	if has('win32')
		set viminfo=!,'250,<50,s10,h,rA:,rB:
	else
		set viminfo=!,'250,<50,s10,h
	endif

	if has('nvim-0.7.0')
		set laststatus=3
	else
		set laststatus=2
	endif

	autocmd FileType markdown,text setlocal spell

"endOfFile
