"startOfFile
" Filename: plugins.vim

call plug#begin($VIMRCFOLDER .. '/autoload/plugged')

" Autocompletion (for lsp and snippets)
	Plug 'hrsh7th/nvim-compe'

" Nvim's built in lsp
	Plug 'neovim/nvim-lspconfig'

" Better syntax - tree-sitter parser
	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
	Plug 'nvim-treesitter/playground'

" Git's 'premier vim plugin'
	Plug 'tpope/vim-fugitive'

" Surround text in a smart manner..
	Plug 'tpope/vim-surround'

" Repeats whole maps with '.' (for plugins)
	Plug 'tpope/vim-repeat'

" Colorizer
	Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

call plug#end()

"autocmd VimEnter * PlugInstall
"autocmd VimEnter * PlugInstall | source $MYVIMRC
"endOfFile
