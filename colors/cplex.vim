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


" Enviorment's Color Pallet - E.C.P
let g:ECP = {
\'string'            : '#d7875f',
\'comment'           : '#5f875f',
\'error'             : '#d70000',
\'number'            : '#afd7af',
\'bool'              : '#af87d7',
\'type'              : '#5fafaf',
\'keyword'           : '#87afff',
\'repeat'            : '#d787d7',
\'function'          : '#d7d7af',
\'constant'          : '#d7d7af',
\'include'           : '#d75f87',
\'object'            : '#e4e4e4',
\'operator'          : '#af5f87',
\'bracket'           : '#d7875f',
\'special'           : '#5fafff',
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
\'symbolBranch'      : '#87afd7',
\'symbolWarFg'       : '#b7af5f',
\'symbolErrFg'       : '#a70000',
\'symbolDiagnostics' : '#a03d65',
\'symbolBufData'     : '#3da065',
\}

if g:clearBackground
	let g:ECP.bg = 'NONE'
else
	let g:ECP.bg = '#141414'
endif
" Highlight Groups - H.G
" Keys:
" S: Special things like 'bold' 'italic'
" FG: frontground color
" BG: background color
"
" Text syntax highlight groups
let s:HG = {
	\'Normal'       : { "FG":g:ECP.fg,               "BG":g:ECP.bg },
	\'Include'      : { "FG":g:ECP.include, },
	\'Comment'      : { "FG":g:ECP.comment, },
	\'Constant'     : { "FG":g:ECP.constant, },
	\'Delimiter'    : { "FG":g:ECP.fg,               "BG":g:ECP.bg },
	\'String'       : { "FG":g:ECP.string, },
	\'Character'    : { "FG":g:ECP.string, },
	\'Boolean'      : { "FG":g:ECP.bool, },
	\'Number'       : { "FG":g:ECP.number, },
	\'Float'        : { "FG":g:ECP.number, },
	\'Repeat'       : { "FG":g:ECP.repeat,            "S":'bold', },
	\'Keyword'      : { "FG":g:ECP.keyword,           "S":'bold', },
	\'Operator'     : { "FG":g:ECP.operator, },
	\'Function'     : { "FG":g:ECP.function, },
	\'Identifier'   : { "FG":g:ECP.object, },
	\'Type'         : { "FG":g:ECP.type, },
	\'Directory'    : { "FG":g:ECP.special, },
	\'Error'        : { "FG":g:ECP.error,             "S":'bold', },
	\'Special'      : { "FG":g:ECP.special, },
	\'Folded'       : { "FG":g:ECP.special,           "BG":g:ECP.non_text, },
	\'StatusLine'   : { "FG":g:ECP.objFg,            "BG":g:ECP.objBg, },
	\'StatusLineNC' : { "FG":g:ECP.objFg,            "BG":g:ECP.bg, },
	\'Pmenu'        : { "FG":g:ECP.objFg,            "BG":g:ECP.objBg, },
	\'PmenuSel'     : { "FG":g:ECP.objFg,            "BG":g:ECP.selected, },
	\'PmenuSbar'    : { "BG":g:ECP.limitLines, },
	\'PmenuThumb'   : { "BG":g:ECP.selected, },
	\'TabLineSel'   : { "FG":g:ECP.fg,               "BG":g:ECP.selected, },
	\'TabLine'      : { "FG":g:ECP.fg,               "BG":g:ECP.objBg, },
	\'TabLineFill'  : { "BG":g:ECP.objBg, },
	\'WildMenu'     : { "FG":g:ECP.objFg,            "BG":g:ECP.objBg, },
	\'LineNr'       : { "FG":g:ECP.objFg, },
	\'SignColumn'   : { "BG":g:ECP.bg, },
	\'CursorLineNr' : { "FG":g:ECP.fg, },
	\'CursorLine'   : { "BG":g:ECP.cursorLines, },
	\'CursorColumn' : { "BG":g:ECP.cursorLines, },
	\'Cursor'       : { "S":'reverse', },
	\'VertSplit'    : { "FG":g:ECP.limitLines, },
	\'ColorColumn'  : { "BG":g:ECP.cursorLines, },
	\'IncSearch'    : { "BG":g:ECP.searchSelected, },
	\'Search'       : { "BG":g:ECP.searchHighlight, },
	\'Visual'       : { "BG":g:ECP.visualSelection, },
	\'VisualNOS'    : { "FG":g:ECP.objFg, },
	\'NonText'      : { "FG":g:ECP.non_text, },
	\'SpecialKey'   : { "FG":g:ECP.objFg, },
	\'DiffAdd'      : { "FG":g:ECP.diffAdd, },
	\'DiffChange'   : { "FG":g:ECP.diffChange, },
	\'DiffDelete'   : { "FG":g:ECP.diffDelete, },
\}

" Enviorment highlight groups
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

unlet g:ECP
unlet s:HG
"endOfFile
