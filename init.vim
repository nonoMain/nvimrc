"startOfFile
" Filename: init.vim

" global/environment variables:
	" get the folder that the config goes to (different on each OS)
	let $VIMRCFOLDER = fnamemodify($MYVIMRC, ":p:h")
	let g:Use_unicode = 1 " if 0 then will use ASCII

" source the general vim settings - file settings, color settings, cursor...
	source $VIMRCFOLDER/configs/general-vim-config/general.vim
	source $VIMRCFOLDER/configs/general-vim-config/file_settings.vim
	source $VIMRCFOLDER/configs/general-vim-config/keybindings.vim
	source $VIMRCFOLDER/configs/general-vim-config/netrw.vim
	source $VIMRCFOLDER/configs/general-vim-config/statusline.vim

" source all my scripts
	source $VIMRCFOLDER/scripts/browseFiles.vim

" source the plugins call file
	source $VIMRCFOLDER/plugins.vim

" source all the configs for the plugins
	source $VIMRCFOLDER/configs/plugins-configs/nvim_lsconfig.vim
	source $VIMRCFOLDER/configs/plugins-configs/vim_hexokinase.vim
	luafile $VIMRCFOLDER/configs/plugins-configs/nvim_compe.lua
	luafile $VIMRCFOLDER/configs/plugins-configs/tree_sitter.lua

" source all the configs for the language servers
	luafile $VIMRCFOLDER/configs/lsp-servers-configs/python_lsconfig.lua
	luafile $VIMRCFOLDER/configs/lsp-servers-configs/c_lsconfig.lua
	luafile $VIMRCFOLDER/configs/lsp-servers-configs/lua_lsconfig.lua
	luafile $VIMRCFOLDER/configs/lsp-servers-configs/vim_lsconfig.lua
	luafile $VIMRCFOLDER/configs/lsp-servers-configs/java_lsconfig.lua

"endOfFile
