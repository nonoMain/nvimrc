"startOfFile
" Filename: init.vim

" global/environment variables:
	" get the folder that the config goes to (different on each OS)
	let $MYVIMRCFOLDER = fnamemodify($MYVIMRC, ":p:h")

	" Preferences
	let g:clearBackground        = 1
	let g:Use_nerdfont           = 1
	let g:Use_devicons_colors    = 1

" global variables and functions needed for the config (outside of these above)
	source $MYVIMRCFOLDER/globals.vim

" The vim settings - file settings, color settings, cursor... And mappings
	source $MYVIMRCFOLDER/configs/settings.vim
	source $MYVIMRCFOLDER/configs/mappings.vim

" The plugins call file (vim-plug plugin manager)
	source $MYVIMRCFOLDER/plugins.vim

" All the configs for the plugins
	source  $MYVIMRCFOLDER/configs/plugins/nvim_lspconfig.vim
	source  $MYVIMRCFOLDER/configs/plugins/nvim_cmp.lua
	source  $MYVIMRCFOLDER/configs/plugins/vim_hexokinase.vim
	luafile $MYVIMRCFOLDER/configs/plugins/tree_sitter.lua

" The configs for the language servers
	luafile $MYVIMRCFOLDER/configs/lsp-servers/python_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/c_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/java_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/lua_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers/vim_lsconfig.lua

"endOfFile
