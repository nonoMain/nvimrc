"startOfFile
" Filename: init.vim

" global/environment variables:
	" get the folder that the config goes to (different on each OS)
	let $MYVIMRCFOLDER = fnamemodify($MYVIMRC, ":p:h")
	let g:Use_dev_icons = 1 " needs supported font

" source the general vim settings - file settings, color settings, cursor...
	source $MYVIMRCFOLDER/configs/general-vim-config/general.vim
	source $MYVIMRCFOLDER/configs/general-vim-config/file_settings.vim
	source $MYVIMRCFOLDER/configs/general-vim-config/keybindings.vim
	source $MYVIMRCFOLDER/configs/general-vim-config/devicons.vim
	source $MYVIMRCFOLDER/configs/general-vim-config/netrw.vim
	source $MYVIMRCFOLDER/configs/general-vim-config/statusline.vim

" source all my scripts
	source $MYVIMRCFOLDER/scripts/browseFiles.vim
"	luafile $MYVIMRCFOLDER/scripts/saveCodeActions/saveCodeActions.lua

" source the plugins call file
	source $MYVIMRCFOLDER/plugins.vim

" source all the configs for the plugins
	source $MYVIMRCFOLDER/configs/plugins-configs/nvim_lsconfig.vim
	source $MYVIMRCFOLDER/configs/plugins-configs/vim_hexokinase.vim
	luafile $MYVIMRCFOLDER/configs/plugins-configs/nvim_compe.lua
	luafile $MYVIMRCFOLDER/configs/plugins-configs/tree_sitter.lua

" source all the configs for the language servers
	luafile $MYVIMRCFOLDER/configs/lsp-servers-configs/python_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers-configs/c_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers-configs/lua_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers-configs/vim_lsconfig.lua
	luafile $MYVIMRCFOLDER/configs/lsp-servers-configs/java_lsconfig.lua

"endOfFile
