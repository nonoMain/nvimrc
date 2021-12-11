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
	\'string'     : '#d7875f',
	\'comment'    : '#5f875f',
	\'error'      : '#d70000',
	\'number'     : '#afd7af',
	\'bool'       : '#af87d7',
	\'type'       : '#5fafaf',
	\'keyword'    : '#87afff',
	\'repeat'     : '#d787d7',
	\'function'   : '#d7d7af',
	\'constant'   : '#d7d7af',
	\'include'    : '#d75f87',
	\'object'     : '#e4e4e4',
	\'operator'   : '#af5f87',
	\'bracket'    : '#d7875f',
	\'special'    : '#5fafff',
\}

" Enviorment's Color Pallet - E.C.P
let g:ECP = {
	\'selected'          : '#005f87',
	\'fg'                : '#e4e4e4',
	\'objFg'             : '#b2b2b2',
	\'objBg'             : '#202020',
	\'non_text'          : '#585858',
	\'limitLines'        : '#444444',
	\'cursorLines'       : '#19191d',
	\'searchHighlight'   : '#005f87',
	\'searchSelected'    : '#5f5f00',
	\'visualSelection'   : '#005f87',
	\'diffAdd'           : '#b2d2b2',
	\'diffChange'        : '#e2e2b2',
	\'diffDelete'        : '#e2b2b2',
	\'infoFg'            : '#585858',
	\'infoBg'            : '#2a2a2a',
	\'branchFg'          : '#87afd7',
	\'symbolWarFg'       : '#b7af5f',
	\'symbolErrFg'       : '#a70000',
	\'symbolDiagnostics' : '#a03d65',
	\'symbolBufData'     : '#3da065',
\}

if g:clearBackground
	let g:ECP.bg = 'NONE'    | let g:ECP.T_bg = 'NONE'
else
	let g:ECP.bg = '#141414' | let g:ECP.T_bg = 234
endif
" Highlight Groups - H.G
" Keys:
" S: Special things like 'bold' 'italic'
" FG: frontground color
" BG: background color
"
" Text syntax highlight groups
let s:HG = {}
let s:HG.Normal       = { "FG":g:ECP.fg,               "BG":g:ECP.bg }
let s:HG.Include      = { "FG":s:CP.include, }
let s:HG.Comment      = { "FG":s:CP.comment, }
let s:HG.Constant     = { "FG":s:CP.constant, }
let s:HG.Delimiter    = { "FG":g:ECP.fg,               "BG":g:ECP.bg }
let s:HG.String       = { "FG":s:CP.string, }
let s:HG.Character    = { "FG":s:CP.string, }
let s:HG.Boolean      = { "FG":s:CP.bool, }
let s:HG.Number       = { "FG":s:CP.number, }
let s:HG.Float        = { "FG":s:CP.number, }
let s:HG.Repeat       = { "FG":s:CP.repeat,            "S":'bold', }
let s:HG.Keyword      = { "FG":s:CP.keyword,           "S":'bold', }
let s:HG.Operator     = { "FG":s:CP.operator, }
let s:HG.Function     = { "FG":s:CP.function, }
let s:HG.Identifier   = { "FG":s:CP.object, }
let s:HG.Type         = { "FG":s:CP.type, }
let s:HG.Directory    = { "FG":s:CP.special, }
let s:HG.Error        = { "FG":s:CP.error,             "S":'bold', }
let s:HG.Special      = { "FG":s:CP.special, }
let s:HG.Folded       = { "FG":s:CP.special,           "BG":g:ECP.non_text, }

" Enviorment highlight groups
let s:HG.StatusLine   = { "FG":g:ECP.objFg,            "BG":g:ECP.objBg, }
let s:HG.StatusLineNC = { "FG":g:ECP.objFg,            "BG":g:ECP.objBg, }
let s:HG.Pmenu        = { "FG":g:ECP.objFg,            "BG":g:ECP.objBg, }
let s:HG.PmenuSel     = { "FG":g:ECP.objFg,            "BG":g:ECP.selected, }
let s:HG.PmenuSbar    = { "BG":g:ECP.limitLines, }
let s:HG.PmenuThumb   = { "BG":g:ECP.selected, }
let s:HG.TabLineSel   = { "FG":g:ECP.fg,               "BG":g:ECP.selected, }
let s:HG.TabLine      = { "FG":g:ECP.fg,               "BG":g:ECP.objBg, }
let s:HG.TabLineFill  = { "BG":g:ECP.objBg, }
let s:HG.WildMenu     = { "FG":g:ECP.objFg,            "BG":g:ECP.objBg, }
let s:HG.LineNr       = { "FG":g:ECP.objFg, }
let s:HG.SignColumn   = { "BG":g:ECP.bg, }
let s:HG.CursorLineNr = { "FG":g:ECP.fg, }
let s:HG.CursorLine   = { "BG":g:ECP.cursorLines, }
let s:HG.CursorColumn = { "BG":g:ECP.cursorLines, }
let s:HG.Cursor       = { "S":'reverse', }
let s:HG.VertSplit    = { "FG":g:ECP.limitLines, }
let s:HG.ColorColumn  = { "BG":g:ECP.cursorLines, }
let s:HG.IncSearch    = { "BG":g:ECP.searchSelected, }
let s:HG.Search       = { "BG":g:ECP.searchHighlight, }
let s:HG.Visual       = { "BG":g:ECP.visualSelection, }
let s:HG.VisualNOS    = { "FG":g:ECP.objFg, }
let s:HG.NonText      = { "FG":g:ECP.non_text, }
let s:HG.SpecialKey   = { "FG":g:ECP.objFg, }
let s:HG.DiffAdd      = { "FG":g:ECP.diffAdd, }
let s:HG.DiffChange   = { "FG":g:ECP.diffChange, }
let s:HG.DiffDelete   = { "FG":g:ECP.diffDelete, }

" scan the assignment dict and execute the assignment
for key in keys(s:HG)
	call myUtils#BigBrother#HighlightDict(key, s:HG[key])
endfor

" generic highlight groups
hi! link Title          Normal
hi! link Todo           Repeat
hi! link Conditional    Repeat
hi! link Statement      Repeat
hi! link PreProc        Repeat
hi! link SpecialComment Special 

" vim highlight groups
hi! link vimEnvvar       Constant
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

unlet s:CP
unlet s:HG
"endOfFile
