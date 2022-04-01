" File Documentation
" Filename: copilot.vim
" Author: nonomain
" last updated: 01/04/22 20:09:43
" Description:
"	configuration for the copilot plugin

inoremap <silent><script><expr> <Bslash><Bslash> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
