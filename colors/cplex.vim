"startOfFile
" Filename: cplex.vim
" Author: nonoMain
" Version: 2.3
" Description: colorscheme

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

" Color Pallet - C.P
let s:CP = {
	\'string'     : '#D7875F', 'T_string'     : 173,
	\'comment'    : '#5F875F', 'T_comment'    :  65,
	\'error'      : '#D70000', 'T_error'      : 160,
	\'number'     : '#AFD7AF', 'T_number'     : 151,
	\'bool'       : '#AF87D7', 'T_bool'       : 140,
	\'identifier' : '#5FAFAF', 'T_identifier' :  74,
	\'keyword'    : '#87AFFF', 'T_keyword'    : 111,
	\'repeat'     : '#D787D7', 'T_repeat'     : 176,
	\'function'   : '#D7D7AF', 'T_function'   : 187,
	\'constant'   : '#D7D7AF', 'T_constant'   : 187,
	\'include'    : '#D75F87', 'T_include'    : 168,
	\'object'     : '#E4E4E4', 'T_object'     : 254,
	\'operator'   : '#AF5F87', 'T_operator'   : 132,
	\'bracket'    : '#D7875F', 'T_bracket'    : 173,
	\'special'    : '#5FAFFF', 'T_special'    :  75,
\}

" Enviorment's Color Pallet - E.C.P
let s:ECP = {
	\'selected'        : '#005F87', 'T_selected'        :  24,
	\'fg'              : '#E4E4E4', 'T_fg'              : 254,
	\'objFg'           : '#b2b2b2', 'T_objFg'           : 249,
	\'objBg'           : '#303030', 'T_objBg'           : 236,
	\'non_text'        : '#585858', 'T_non_text'        : 240,
	\'limitLines'      : '#444444', 'T_limitLines'      : 238,
	\'cursorLines'     : '#1C1C1C', 'T_cursorLines'     : 234,
	\'searchHighlight' : '#005F87', 'T_searchHighlight' :  24,
	\'searchSelected'  : '#5F5F00', 'T_searchSelected'  :  58,
	\'visualSelection' : '#005F87', 'T_visualSelection' :  24,
\}
if g:clearBackground
	let s:ECP.bg = 'NONE'    | let s:ECP.T_bg = 'NONE'
else
	let s:ECP.bg = '#000000' | let s:ECP.T_bg = 0
endif
" Highlight Groups - H.G
" Keys:
" Gui:G
" Guifg:GFG
" Guibg:GBG
" Term:T
" Termfg:TFG
" Termbg:TBG

" Text syntax highlight groups
let s:HG = {}
let s:HG.Normal     = { "GFG":s:ECP.fg,        "TFG":s:ECP.T_fg,         "GBG":s:ECP.bg, "TBG":s:ECP.T_bg }
let s:HG.Include    = { "GFG":s:CP.include,    "TFG":s:CP.T_include }
let s:HG.Comment    = { "GFG":s:CP.comment,    "TFG":s:CP.T_comment }
let s:HG.Constant   = { "GFG":s:CP.constant,   "TFG":s:CP.T_constant }
let s:HG.Delimiter  = { "GFG":s:ECP.fg,        "TFG":s:ECP.T_fg,         "GBG":s:ECP.bg, "TBG":s:ECP.T_bg }
let s:HG.String     = { "GFG":s:CP.string,     "TFG":s:CP.T_string }
let s:HG.Character  = { "GFG":s:CP.string,     "TFG":s:CP.T_string }
let s:HG.Boolean    = { "GFG":s:CP.bool,       "TFG":s:CP.T_bool }
let s:HG.Number     = { "GFG":s:CP.number,     "TFG":s:CP.T_number }
let s:HG.Float      = { "GFG":s:CP.number,     "TFG":s:CP.T_number }
let s:HG.Repeat     = { "GFG":s:CP.repeat,     "TFG":s:CP.T_repeat,      "G":'bold',        "T":'bold' }
let s:HG.Keyword    = { "GFG":s:CP.keyword,    "TFG":s:CP.T_keyword,     "G":'bold',        "T":'bold' }
let s:HG.Operator   = { "GFG":s:CP.operator,   "TFG":s:CP.T_operator }
let s:HG.Function   = { "GFG":s:CP.function,   "TFG":s:CP.T_function }
let s:HG.Identifier = { "GFG":s:CP.object,     "TFG":s:CP.T_object }
let s:HG.Type       = { "GFG":s:CP.identifier, "TFG":s:CP.T_identifier }
let s:HG.Directory  = { "GFG":s:CP.special,    "TFG":s:CP.T_special }
let s:HG.Error      = { "GFG":s:CP.error,      "TFG":s:CP.T_error,       "G":'bold',        "T":'bold' }
let s:HG.Special    = { "GFG":s:CP.special,    "TFG":s:CP.T_special }

" Enviorment highlight groups
let s:HG.StatusLine   = { "GFG":s:ECP.objFg,           "TFG":s:ECP.T_objFg,            "GBG":s:ECP.objBg,    "TBG":s:ECP.T_objBg }
let s:HG.StatusLineNC = { "GFG":s:ECP.objFg,           "TFG":s:ECP.T_objFg,            "GBG":s:ECP.bg,       "TBG":s:ECP.T_bg }
let s:HG.Pmenu        = { "GFG":s:ECP.objFg,           "TFG":s:ECP.T_objFg,            "GBG":s:ECP.objBg,    "TBG":s:ECP.T_objBg }
let s:HG.PmenuSel     = { "GFG":s:ECP.objFg,           "TFG":s:ECP.T_objFg,            "GBG":s:ECP.selected, "TBG":s:ECP.T_selected }
let s:HG.PmenuSbar    = { "GBG":s:ECP.limitLines,      "TBG":s:ECP.T_limitLines }
let s:HG.PmenuThumb   = { "GBG":s:ECP.selected,        "TBG":s:ECP.T_selected }
let s:HG.TabLineSel   = { "GFG":s:ECP.fg,              "TFG":s:ECP.T_fg,               "GBG":s:ECP.selected, "TBG":s:ECP.T_selected }
let s:HG.TabLine      = { "GFG":s:ECP.fg,              "TFG":s:ECP.T_fg,               "GBG":s:ECP.objBg,    "TBG":s:ECP.T_objBg }
let s:HG.TabLineFill  = { "GBG":s:ECP.objBg,           "TBG":s:ECP.T_objBg }
let s:HG.WildMenu     = { "GFG":s:ECP.objFg,           "TFG":s:ECP.T_objFg,            "GBG":s:ECP.objBg,    "TBG":s:ECP.T_objBg }
let s:HG.LineNr       = { "GFG":s:ECP.objFg,           "TFG":s:ECP.T_objFg }
let s:HG.SignColumn   = { "GBG":s:ECP.bg,              "TBG":s:ECP.T_bg }
let s:HG.CursorLineNr = { "GFG":s:ECP.fg,              "TFG":s:ECP.T_fg }
let s:HG.CursorLine   = { "GBG":s:ECP.cursorLines,     "TBG":s:ECP.T_cursorLines }
let s:HG.CursorColumn = { "GBG":s:ECP.cursorLines,     "TBG":s:ECP.T_cursorLines }
let s:HG.Cursor       = { "G":'reverse',                  "T":'reverse' }
let s:HG.VertSplit    = { "GFG":s:ECP.limitLines,      "TFG":s:ECP.T_limitLines }
let s:HG.ColorColumn  = { "GBG":s:ECP.cursorLines,     "TBG":s:ECP.T_cursorLines }
let s:HG.IncSearch    = { "GBG":s:ECP.searchSelected,  "TBG":s:ECP.T_searchSelected }
let s:HG.Search       = { "GBG":s:ECP.searchHighlight, "TBG":s:ECP.T_searchHighlight }
let s:HG.Visual       = { "GBG":s:ECP.visualSelection, "TBG":s:ECP.T_visualSelection }
let s:HG.VisualNOS    = { "GFG":s:ECP.objFg,           "TFG":s:ECP.T_objFg }
let s:HG.NonText      = { "GFG":s:ECP.non_text,        "TFG":s:ECP.T_non_text }
let s:HG.SpecialKey   = { "GFG":s:ECP.objFg,           "TFG":s:ECP.T_objFg }

" Coloring function
function! s:HighlightDict(key, dict)
	if has_key(a:dict, 'T')
		let l:term = a:dict.T
	else
		let l:term = 'NONE'
	endif
	if has_key(a:dict, 'G')
		let l:gui = a:dict.G
	else
		let l:gui='NONE'
	endif
	if has_key(a:dict, 'GFG')
		let l:guifg = a:dict.GFG
	else
		let l:guifg='NONE'
	endif
	if has_key(a:dict, 'GBG')
		let l:guibg = a:dict.GBG
	else
		let l:guibg='NONE'
	endif
	if has_key(a:dict, 'T')
		let l:cterm = a:dict.T
	else
		let l:cterm='NONE'
	endif
	if has_key(a:dict, 'TFG')
		let l:ctermfg = a:dict.TFG
	else
		let l:ctermfg='NONE'
		endif
	if has_key(a:dict, 'TBG')
		let l:ctermbg = a:dict.TBG
	else
		let l:ctermbg='NONE'
	endif
	if has_key(a:dict, 'GSP')
		let l:guisp = a:dict.GSP
	else
		let l:guisp='NONE'
	endif
	execute "hi " . a:key . " term=" . l:term . " cterm=" . l:cterm . " gui=" . l:gui . " ctermfg=" . l:ctermfg . " guifg=" . l:guifg . " ctermbg=" . l:ctermbg . " guibg=" . l:guibg . " guisp=" . l:guisp
endfunction

" scan the assignment dict and execute the assignment
for key in keys(s:HG)
	call s:HighlightDict(key, s:HG[key])
endfor

" generic highlight groups
hi! link Title          Normal
hi! link Todo           Repeat
hi! link Conditional    Repeat
hi! link Statement      Repeat
hi! link PreProc        Repeat
hi! link SpecialComment Speical

" diff.vim
hi! link diffAdded   DiffAdd
hi! link diffChanged DiffChange
hi! link diffRemoved DiffDelete

" vim highlight groups
hi! link vimCommand   Keyword
hi! link vimIsCommand Keyword
hi! link vimNotFunc   Keyword

" json highlight groups
hi! link jsonKeyword Keyword
hi! link jsonBoolean Boolean

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
hi! link TSMethod             Method
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
hi! link TSStructure          Structure
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

unlet s:CP
unlet s:ECP
unlet s:HG
"endOfFile
