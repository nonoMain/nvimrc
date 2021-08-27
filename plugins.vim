"startOfFile
" Filename: plugins.vim

" To install vim-plug (the used plugin manager):

" ## for unix / linux
"sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

" ## for windows (powershell)
"iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
"    ni \"$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim\" -Force

call plug#begin($MYVIMRCFOLDER .. '/autoload/plugged')

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
