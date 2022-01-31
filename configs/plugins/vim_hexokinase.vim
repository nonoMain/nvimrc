"	File Documentation
" Filename: vim_hexokinase.vim
" Author: nonomain
" last updated: 31/01/22 17:46:12
" Description:
"	configuration for the nvim_lsconfig plugin

" options are:
" - virtual
" - sign_column
" - background
" - backgroundfull
" - foreground
" - foregroundfull
let g:Hexokinase_highlighters = [ 'backgroundfull' ]

let g:Hexokinase_optInPatterns = [
\     'full_hex',
\     'triple_hex',
\     'rgb',
\     'rgba',
\     'hsl',
\     'hsla',
\     'colour_names'
\ ]
