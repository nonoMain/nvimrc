" File Documentation
" Filename: globals.vim
" Author: nonomain
" last updated: 31/01/22 17:48:16
" Description:
" 	global variables for the initiation of the editor

let g:c_ls_path          = "clangd"
let g:java_ls_path       = expand("$HOME") .. "/.ls-servers/eclipse-jdt-ls"
let g:jdt_jar_path       = expand(java_ls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
let g:jdt_java_home_path = '/usr/bin/java'
let g:lua_ls_path        = expand("$HOME") .. "/.ls-servers/lua-language-server"
let g:python_ls_path     = expand("$HOME") .. "/.ls-servers/pyright-ls"
let g:vim_ls_path        = expand("$HOME") .. "/.ls-servers/vim-language-server"

let g:python_recommended_style = 0
