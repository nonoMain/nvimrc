"startOfFile
" Filename: general.vim

" Enables 24 bit color support if possible
if str2nr(&t_Co) > 16
	set termguicolors
else
	set notermguicolors
endif

" sets the leader key
let mapleader = ' '

" Smart redraw
set lazyredraw

" sets the general colorscheme
colorscheme cplex

" navigate to another buffer without saving current buffer
set hidden

" Set the cursor highlight
set guicursor=
set cursorcolumn
set cursorline

" show current line number
set number
" show relative line numbers
set relativenumber

set noerrorbells

" show tabs, end of lines and trailing spaces
set list
set listchars=tab:▸\ ,eol:¬,trail:~,extends:>,precedes:< " ·
set fillchars=stl:_,stlnc:_,vert:\|,fold:-,diff:-

" INDENTATION SETTINGS:
	" how many spaces a tab is
	set tabstop=4
	" how many spaces for every level of indentation
	set shiftwidth=4
	" preserve indentation
	set autoindent
	" smart indentation for languages
	set smartindent

" SEARCH SETTINGS:
	" highlight all search patterns
	set hlsearch
	" enable incremental search
	set incsearch
	" display all matching searches
	set wildmenu

set colorcolumn=80
"endOfFile
