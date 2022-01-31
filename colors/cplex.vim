" File Documentation
" Filename: cplex.vim
" Author: nonomain
" last updated: 31/01/22 17:47:02
" Description:
" 	dark colorscheme

" TODO:
" add links to Startify and diff
" finish normal hi groups

" settings
set background=dark
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name='cplex'

if !exists("g:clearBackground")
	let g:clearBackground = 1
endif

" highlights are from 'genereateHighlights.vim' file in the config
"-------------- Cplex highlights --------------
highlight Function             guifg=#d7d7af guibg=NONE ctermfg=187 ctermbg=NONE term=NONE gui=NONE
highlight Keyword              guifg=#87afff guibg=NONE ctermfg=111 ctermbg=NONE term=NONE gui=NONE
highlight DiffDelete           guifg=#e2b2b2 guibg=NONE ctermfg=181 ctermbg=NONE term=NONE gui=NONE
highlight StatusLineNC         guifg=#b2b2b2 guibg=#202020 ctermfg=249 ctermbg=234 term=NONE gui=NONE
highlight Comment              guifg=#5f875f guibg=NONE ctermfg=65 ctermbg=NONE term=NONE gui=NONE
highlight VisualNOS            guifg=#b2b2b2 guibg=NONE ctermfg=249 ctermbg=NONE term=NONE gui=NONE
highlight PmenuSbar            guifg=NONE guibg=#444444 ctermfg=NONE ctermbg=238 term=NONE gui=NONE
highlight Cursor               guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=reverse gui=reverse
highlight Visual               guifg=NONE guibg=#005f87 ctermfg=NONE ctermbg=24 term=NONE gui=NONE
highlight WildMenu             guifg=#b2b2b2 guibg=#202020 ctermfg=249 ctermbg=234 term=NONE gui=NONE
highlight CursorLine           guifg=NONE guibg=#19191d ctermfg=NONE ctermbg=234 term=NONE gui=NONE
highlight CursorLineNr         guifg=#e4e4e4 guibg=NONE ctermfg=254 ctermbg=NONE term=NONE gui=NONE
highlight Special              guifg=#5fafff guibg=NONE ctermfg=75 ctermbg=NONE term=NONE gui=NONE
highlight TabLineFill          guifg=NONE guibg=#202020 ctermfg=NONE ctermbg=234 term=NONE gui=NONE
highlight PmenuSel             guifg=#b2b2b2 guibg=#005f87 ctermfg=249 ctermbg=24 term=NONE gui=NONE
highlight LineNr               guifg=#b2b2b2 guibg=NONE ctermfg=249 ctermbg=NONE term=NONE gui=NONE
highlight Search               guifg=NONE guibg=#005f87 ctermfg=NONE ctermbg=24 term=NONE gui=NONE
highlight Directory            guifg=#5fafff guibg=NONE ctermfg=75 ctermbg=NONE term=NONE gui=NONE
highlight DiffAdd              guifg=#b2d2b2 guibg=NONE ctermfg=151 ctermbg=NONE term=NONE gui=NONE
highlight Identifier           guifg=#e4e4e4 guibg=NONE ctermfg=254 ctermbg=NONE term=NONE gui=NONE
highlight DiffChange           guifg=#e2e2b2 guibg=NONE ctermfg=254 ctermbg=NONE term=NONE gui=NONE
highlight TabLine              guifg=#e4e4e4 guibg=#202020 ctermfg=254 ctermbg=234 term=NONE gui=NONE
highlight PmenuThumb           guifg=NONE guibg=#005f87 ctermfg=NONE ctermbg=24 term=NONE gui=NONE
highlight Type                 guifg=#5fafaf guibg=NONE ctermfg=73 ctermbg=NONE term=NONE gui=NONE
highlight TabLineSel           guifg=#e4e4e4 guibg=#005f87 ctermfg=254 ctermbg=24 term=NONE gui=NONE
highlight Delimiter            guifg=#e4e4e4 guibg=NONE ctermfg=254 ctermbg=NONE term=NONE gui=NONE
highlight String               guifg=#d7875f guibg=NONE ctermfg=173 ctermbg=NONE term=NONE gui=NONE
highlight VertSplit            guifg=#444444 guibg=NONE ctermfg=238 ctermbg=NONE term=NONE gui=NONE
highlight Error                guifg=#d70000 guibg=NONE ctermfg=160 ctermbg=NONE term=bold gui=bold
highlight Number               guifg=#afd7af guibg=NONE ctermfg=151 ctermbg=NONE term=NONE gui=NONE
highlight Pmenu                guifg=#b2b2b2 guibg=#202020 ctermfg=249 ctermbg=234 term=NONE gui=NONE
highlight Include              guifg=#d75f87 guibg=NONE ctermfg=168 ctermbg=NONE term=NONE gui=NONE
highlight Constant             guifg=#d7d7af guibg=NONE ctermfg=187 ctermbg=NONE term=NONE gui=NONE
highlight NonText              guifg=#585858 guibg=NONE ctermfg=240 ctermbg=NONE term=NONE gui=NONE
highlight Character            guifg=#d7875f guibg=NONE ctermfg=173 ctermbg=NONE term=NONE gui=NONE
highlight SignColumn           guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=NONE gui=NONE
highlight StatusLine           guifg=#b2b2b2 guibg=#202020 ctermfg=249 ctermbg=234 term=NONE gui=NONE
highlight Operator             guifg=#af5f87 guibg=NONE ctermfg=132 ctermbg=NONE term=NONE gui=NONE
highlight SpecialKey           guifg=#b2b2b2 guibg=NONE ctermfg=249 ctermbg=NONE term=NONE gui=NONE
highlight Normal               guifg=#e4e4e4 guibg=NONE ctermfg=254 ctermbg=NONE term=NONE gui=NONE
highlight Float                guifg=#afd7af guibg=NONE ctermfg=151 ctermbg=NONE term=NONE gui=NONE
highlight IncSearch            guifg=NONE guibg=#5f5f00 ctermfg=NONE ctermbg=58 term=NONE gui=NONE
highlight Folded               guifg=#5fafff guibg=#585858 ctermfg=75 ctermbg=240 term=NONE gui=NONE
highlight Boolean              guifg=#af87d7 guibg=NONE ctermfg=140 ctermbg=NONE term=NONE gui=NONE
highlight ColorColumn          guifg=NONE guibg=#19191d ctermfg=NONE ctermbg=234 term=NONE gui=NONE
highlight Repeat               guifg=#bf87d7 guibg=NONE ctermfg=140 ctermbg=NONE term=NONE gui=NONE

" generic highlight groups
hi! link Title          Normal
hi! link Todo           Repeat
hi! link Conditional    Repeat
hi! link Statement      Repeat
hi! link PreProc        Repeat
hi! link SpecialComment Special 
hi! link CursorColumn   CursorLine
hi! link String         Character

" vim highlight groups
hi! link vimEnvvar       Constant
hi! link vimHiKeyList    Constant
hi! link vimCommand      Keyword
hi! link vimUsrCmd       Keyword
hi! link vimIsCommand    Keyword
hi! link vimNotFunc      Keyword
hi! link vimUserFunc     Function
hi! link vimCommentTitle Special 

" json highlight groups
hi! link jsonKeyword Keyword
hi! link jsonBoolean Boolean

" nvim-cmp
hi! link CmpItemKind           Type
hi! link CmpItemMenu           NonText
hi! link CmpItemAbbr           Identifier
hi! link CmpItemAbbrDeprecated Error

" tree-sitter highlight groups
hi! link TSString             String
hi! link TSOperator           Operator
hi! link TSFunction           Function
hi! link TSFuncBuiltin        Function
hi! link TSFuncMacro          Function
hi! link TSError              Error
hi! link TSPunctDelimiter     PunctDelimiter
hi! link TSPunctBracket       PunctBracket
hi! link TSPunctSpecial       PunctSpecial
hi! link TSConstant           Constant
hi! link TSConstBuiltin       Constant
hi! link TSConstMacro         Type
hi! link TSStringRegex        String
hi! link TSStringEscape       Operator
hi! link TSCharacter          String
hi! link TSNumber             Number
hi! link TSBoolean            Boolean
hi! link TSFloat              Float
hi! link TSAnnotation         Comment
hi! link TSAttribute          Attribute
hi! link TSNamespace          Namespace
hi! link TSParameter          Identifier
hi! link TSParameterReference Identifier
hi! link TSMethod             Function
hi! link TSField              Field
hi! link TSProperty           Property
hi! link TSConstructor        Constructor
hi! link TSConditional        Conditional
hi! link TSRepeat             Repeat
hi! link TSLabel              Label
hi! link TSKeyword            Keyword
hi! link TSKeywordFunction    Keyword
hi! link TSKeywordOperator    Keyword
hi! link TSException          Exception
hi! link TSType               Type
hi! link TSTypeBuiltin        Type
hi! link TSStructure          Type
hi! link TSInclude            Include
hi! link TSVariable           Identifier
hi! link TSVariableBuiltin    Identifier
hi! link TSText               Normal
hi! link TSStrong             Strong
hi! link TSEmphasis           Emphasis
hi! link TSUnderline          Underline
hi! link TSTitle              Title
hi! link TSLiteral            Literal
hi! link TSURI                Identifier
hi! link TSTag                Tag
hi! link TSTagDelimiter       TagDelimiter
"endOfFile
