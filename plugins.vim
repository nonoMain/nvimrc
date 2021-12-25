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
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'f3fora/cmp-spell'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-nvim-lua'
	Plug 'quangnguyen30192/cmp-nvim-ultisnips'
	Plug 'hrsh7th/lspkind-nvim'

" Nvim's built in lsp
 	Plug 'neovim/nvim-lspconfig'

" Fast snippets
	Plug 'SirVer/ultisnips'

" Better syntax - tree-sitter parser
	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
	Plug 'nvim-treesitter/playground'

" Gits premier vim plugins
	Plug 'tpope/vim-fugitive' " git manager
	Plug 'airblade/vim-gitgutter' " git diff displayer
	let g:gitgutter_map_keys = 0 " disable gitgutter mappings

" Surround text in a smart manner..
	Plug 'tpope/vim-surround'

" Repeats whole maps with '.' (for plugins)
	Plug 'tpope/vim-repeat'

" Colorizer
	Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

call plug#end()

"autocmd VimEnter * PlugInstall
"autocmd VimEnter * PlugInstall | source $MYVIMRC

" Configs for the plugins
	source  $MYVIMRCFOLDER/configs/plugins/nvim_lspconfig.vim
	source  $MYVIMRCFOLDER/configs/plugins/nvim_cmp.lua
	source  $MYVIMRCFOLDER/configs/plugins/vim_hexokinase.vim
	luafile $MYVIMRCFOLDER/configs/plugins/tree_sitter.lua
"endOfFile
