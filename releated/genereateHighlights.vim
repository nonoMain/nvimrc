" File Documentation
" Filename: genereateHighlights.vim
" Author: nonomain
" last updated: 31/01/22 17:50:04
" Description:
"	genereates all the required highlights for this configuration

let s:filename = $MYVIMRCFOLDER .. "/genereated_highlights.vim"

"
" Coloring function
" Highlight Groups - H.G
" Keys:
" S: Special things like 'bold' 'italic'
" FG: frontground color
" BG: background color
function! s:AppendColorToFile(key, dict)
	if has_key(a:dict, 'FG')
		let l:guifg = a:dict['FG']
		let l:ctermfg = myUtils#BigBrother#GetClosetTermColor(a:dict['FG'])
	else
		let l:guifg='NONE'
		let l:ctermfg='NONE'
	endif
	if has_key(a:dict, 'BG')
		if (a:dict['BG'] == 'NONE')
			let l:guibg = 'NONE'
			let l:ctermbg = 'NONE'
		else
			let l:guibg = a:dict['BG']
			let l:ctermbg = myUtils#BigBrother#GetClosetTermColor(a:dict['BG'])
		endif
	else
		let l:guibg='NONE'
		let l:ctermbg='NONE'
	endif
	if has_key(a:dict, 'S')
		let l:special = a:dict['S']
	else
		let l:special='NONE'
	endif
	let l:name = a:key
	for i in range(20 - len(l:name))
		let l:name ..= ' '
	endfor
	let line = "highlight " . l:name . " guifg=". l:guifg . " guibg=" . l:guibg . " ctermfg=" . l:ctermfg . " ctermbg=" . l:ctermbg . " term=" . l:special . " gui=" . l:special
	call writefile([line], s:filename, "a")
endfunction

let s:ECP = {
\'bg'                : 'NONE',
\'string'            : '#d7875f',
\'comment'           : '#5f875f',
\'error'             : '#d70000',
\'number'            : '#afd7af',
\'bool'              : '#af87d7',
\'type'              : '#5fafaf',
\'keyword'           : '#87afff',
\'repeat'            : '#bf87d7',
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

let s:CplexHighlights = {
	\'Normal'       : { "FG":s:ECP.fg,                "BG":s:ECP.bg },
	\'Include'      : { "FG":s:ECP.include, },
	\'Comment'      : { "FG":s:ECP.comment, },
	\'Constant'     : { "FG":s:ECP.constant, },
	\'Delimiter'    : { "FG":s:ECP.fg,                "BG":s:ECP.bg },
	\'String'       : { "FG":s:ECP.string, },
	\'Character'    : { "FG":s:ECP.string, },
	\'Boolean'      : { "FG":s:ECP.bool, },
	\'Number'       : { "FG":s:ECP.number, },
	\'Float'        : { "FG":s:ECP.number, },
	\'Repeat'       : { "FG":s:ECP.repeat, },
	\'Keyword'      : { "FG":s:ECP.keyword, },
	\'Operator'     : { "FG":s:ECP.operator, },
	\'Function'     : { "FG":s:ECP.function, },
	\'Identifier'   : { "FG":s:ECP.object, },
	\'Type'         : { "FG":s:ECP.type, },
	\'Directory'    : { "FG":s:ECP.special, },
	\'Error'        : { "FG":s:ECP.error,             "S":'bold', },
	\'Special'      : { "FG":s:ECP.special, },
	\'Folded'       : { "FG":s:ECP.special,           "BG":s:ECP.non_text, },
	\'StatusLine'   : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'StatusLineNC' : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'Pmenu'        : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'PmenuSel'     : { "FG":s:ECP.objFg,             "BG":s:ECP.selected, },
	\'PmenuSbar'    : { "BG":s:ECP.limitLines, },
	\'PmenuThumb'   : { "BG":s:ECP.selected, },
	\'TabLineSel'   : { "FG":s:ECP.fg,                "BG":s:ECP.selected, },
	\'TabLine'      : { "FG":s:ECP.fg,                "BG":s:ECP.objBg, },
	\'TabLineFill'  : { "BG":s:ECP.objBg, },
	\'WildMenu'     : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'LineNr'       : { "FG":s:ECP.objFg, },
	\'ModeMsg'       : { "FG":s:ECP.objFg, },
	\'SignColumn'   : { "BG":s:ECP.bg, },
	\'CursorLineNr' : { "FG":s:ECP.fg, },
	\'CursorLine'   : { "BG":s:ECP.cursorLines, },
	\'ColorColumn'  : { "BG":s:ECP.cursorLines, },
	\'Cursor'       : { "S":'reverse', },
	\'VertSplit'    : { "FG":s:ECP.limitLines, },
	\'IncSearch'    : { "BG":s:ECP.searchSelected, },
	\'Search'       : { "BG":s:ECP.searchHighlight, },
	\'Visual'       : { "BG":s:ECP.visualSelection, },
	\'VisualNOS'    : { "FG":s:ECP.objFg, },
	\'NonText'      : { "FG":s:ECP.non_text, },
	\'SpecialKey'   : { "FG":s:ECP.objFg, },
	\'DiffAdd'      : { "FG":s:ECP.diffAdd, },
	\'DiffChange'   : { "FG":s:ECP.diffChange, },
	\'DiffDelete'   : { "FG":s:ECP.diffDelete, },
\}

let s:StatusLineHighlights = {
	\'StlReg'               : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'StlRegBg'             : { "FG":s:ECP.objBg,                "BG":s:ECP.objBg, },
	\'StlBright'            : { "FG":s:ECP.objFg,             "BG":s:ECP.selected, },
	\'StlBranch'            : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'StlUBInfo'            : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'StlBranchSymbol'      : { "FG":s:ECP.symbolBranch,      "BG":s:ECP.objBg,         "S":'BOLD', },
	\'StlDiagnosticSymbol'  : { "FG":s:ECP.symbolDiagnostics, "BG":s:ECP.objBg,         "S":'BOLD', },
	\'StlBufDataSymbol'     : { "FG":s:ECP.symbolBufData,     "BG":s:ECP.objBg,         "S":'BOLD', },
\}
" next few are based on other keys..
let s:StatusLineHighlights.StlSepBranch2Reg     = { "FG":s:StatusLineHighlights.StlBranch["BG"],       "BG":s:StatusLineHighlights['StlReg']["BG"], }
let s:StatusLineHighlights.StlSepBright2Branch  = { "FG":s:StatusLineHighlights.StlBright["BG"],       "BG":s:StatusLineHighlights['StlBranch']["BG"], }
let s:StatusLineHighlights.StlSepBright2Reg     = { "FG":s:StatusLineHighlights.StlBright["BG"],       "BG":s:StatusLineHighlights['StlReg']["BG"], }

let s:TablineHighlights = {
	\'TabLineSel'        : { "FG":s:ECP.objFg,       "BG":s:ECP.selected, },
	\'TabLine'           : { "FG":s:ECP.objFg,       "BG":s:ECP.objBg, },
	\'TabDiagnosticsReg' : { "FG":s:ECP.objFg,       "BG":s:ECP.objBg, },
	\'TabDiagnosticsWar' : { "FG":s:ECP.symbolWarFg, "BG":s:ECP.objBg, },
	\'TabDiagnosticsErr' : { "FG":s:ECP.symbolErrFg, "BG":s:ECP.objBg, },
	\'TabLineFill'       : { "BG":s:ECP.objBg, },
\}

function! g:Genereate_highlights()
	call writefile(['" This file was genereated with genereateHighlights.vim file'], s:filename, "a")

	call writefile(['"-------------- Cplex highlights --------------'], s:filename, "a")
	for key in keys(s:CplexHighlights)
		call s:AppendColorToFile(key, s:CplexHighlights[key])
	endfor

	call writefile(['"-------------- Statusline highlights --------------'], s:filename, "a")
	for key in keys(s:StatusLineHighlights)
		call s:AppendColorToFile(key, s:StatusLineHighlights[key])
	endfor

	call writefile(['"-------------- Tabline highlights --------------'], s:filename, "a")
	for key in keys(s:TablineHighlights)
		call s:AppendColorToFile(key, s:TablineHighlights[key])
	endfor
endfunction
