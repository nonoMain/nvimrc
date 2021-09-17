"startOfFile
" Filename: SmartTabline.vim

if !exists("g:SmartTablineEnabled")
	let g:SmartTablineEnabled = 1
endif
if !g:SmartTablineEnabled
	finish
endif

let s:diagnosticsKey = 'diagnostics' " what type of diagnostics there are on all the buffers
let s:StatusKey      = 'status'      " what is the type of the current buffer and how many modified buffers there are

" Tab Diagnostics defines
let s:TabWithWarning = 1
let s:TabWithError   = 2
let s:TabWithNote    = 3

let s:ErrorSigns   = [
	\'LspDiagnosticsSignError',
	\]

let s:WarningSigns   = [
	\'LspDiagnosticsSignWarning',
	\]

if g:Use_nerdfont
	let s:LtSep = ""
	let s:RtSep = ""
else
	let s:LtSep = "|"
	let s:RtSep = "|"
endif

" Tabline color Pallet
let s:CP = {
	\'selected'    : '#005F87', 'T_selected'   :  24,
	\'symbolRegFg' : '#87AFD7', 'T_symbolRegFg': 110,
	\'symbolWarFg' : '#d7af5f', 'T_symbolWarFg': 179,
	\'symbolErrFg' : '#d70000', 'T_symbolErrFg': 160,
	\'fg'          : '#b2b2b2', 'T_fg'         : 249,
	\'bg'          : '#3A3A3A', 'T_bg'         : 237,
	\'darkBg'      : '#1C1C1C', 'T_darkBg'     : 234,
	\'special'     : '#AF5F87', 'T_special'    : 132,
\}

" Highlight Groups - H.G
" Keys:
" gui:G
 " guifg:GFG
" guibg:GBG
" term:T
" termfg:TFG
" termbg:TBG

" Description:
" highlight group - description
"  TabLineSel     - selected tab
"  TabLine        - regular unselcted tab
"  TabSymbolReg   - tab symbols normaly
"  TabSymbolWar   - tab symbols when there are warnings
"  TabSymbolErr   - tab symbols when there are errors
"  TabSpecial     - important ('special') parameters on the tab
"  TabLineFill    - background of the tabline
"  TabSepSel2Fill - seperator for 'TabLineSel' -> 'TabLineFill'
"  TabSepReg2Fill - seperator for 'TabLine'    -> 'TabLineFill'

" StatusLine highlight groups
let s:HG = {}
let s:HG.TabLineSel     = { "GFG":s:CP.fg,          "TFG":s:CP.T_fg,          "GBG":s:CP.selected,"TBG":s:CP.T_selected }
let s:HG.TabLine        = { "GFG":s:CP.fg,          "TFG":s:CP.T_fg,          "GBG":s:CP.bg,      "TBG":s:CP.T_bg }
let s:HG.TabSymbolReg   = { "GFG":s:CP.symbolRegFg, "TFG":s:CP.T_symbolRegFg, "GBG":s:CP.bg,      "TBG":s:CP.T_bg }
let s:HG.TabSymbolWar   = { "GFG":s:CP.symbolWarFg, "TFG":s:CP.T_symbolWarFg, "GBG":s:CP.bg,      "TBG":s:CP.T_bg }
let s:HG.TabSymbolErr   = { "GFG":s:CP.symbolErrFg, "TFG":s:CP.T_symbolErrFg, "GBG":s:CP.bg,      "TBG":s:CP.T_bg }
let s:HG.TabSpecial     = { "GFG":s:CP.special,     "TFG":s:CP.T_special,     "GBG":s:CP.bg,      "TBG":s:CP.T_bg }
let s:HG.TabLineFill    = { "GBG":s:CP.darkBg,      "TBG":s:CP.T_darkBg }
let s:HG.TabSepSel2Fill = { "GFG":s:CP.selected,    "TFG":s:CP.T_selected,    "GBG":s:CP.darkBg,  "TBG":s:CP.T_darkBg }
let s:HG.TabSepReg2Fill = { "GFG":s:CP.bg,          "TFG":s:CP.T_bg,          "GBG":s:CP.darkBg,  "TBG":s:CP.T_darkBg }

" highlighting function
function! s:HighlightDict(key, dict)
	if has_key(a:dict, 'T')
		let l:term = a:dict['T']
	else
		let l:term = 'NONE'
	endif
	if has_key(a:dict, 'G')
		let l:gui = a:dict['G']
	else
		let l:gui='NONE'
	endif
	if has_key(a:dict, 'GFG')
		let l:guifg = a:dict['GFG']
	else
		let l:guifg='NONE'
	endif
	if has_key(a:dict, 'GBG')
		let l:guibg = a:dict['GBG']
	else
		let l:guibg='NONE'
	endif
	if has_key(a:dict, 'T')
		let l:cterm = a:dict['T']
	else
		let l:cterm='NONE'
	endif
	if has_key(a:dict, 'TFG')
		let l:ctermfg = a:dict['TFG']
	else
		let l:ctermfg='NONE'
		endif
	if has_key(a:dict, 'TBG')
		let l:ctermbg = a:dict['TBG']
	else
		let l:ctermbg='NONE'
	endif
	if has_key(a:dict, 'GSP')
		let l:guisp = a:dict['GSP']
	else
		let l:guisp='NONE'
	endif
	execute "hi " . a:key . " term=" . l:term . " cterm=" . l:cterm . " gui=" . l:gui . " ctermfg=" . l:ctermfg . " guifg=" . l:guifg . " ctermbg=" . l:ctermbg . " guibg=" . l:guibg . " guisp=" . l:guisp
endfunction

" scan the assignment dict and execute the assignment
for key in keys(s:HG)
	call s:HighlightDict(key, s:HG[key])
endfor

function! GenerateTabline()
	let l:tmp = ""
	for tabNr in range(tabpagenr('$'))
		if tabNr + 1 == tabpagenr()
			let l:tmp .= s:generateTablable(tabNr + 1, 'active')
		else
			let l:tmp .= s:generateTablable(tabNr + 1, 'inactive')
		endif
	endfor
	let l:tmp .= '%#TabLineFill#%T'
	if tabpagenr('$') > 1
		let l:tmp .= (g:Use_nerdfont)? "%=%#TabLine#\ \ " : "%=%#TabLine#\ X\ "
	endif
	return l:tmp
endfunction

function! s:getFullPath(tabNr)
	let buflist = tabpagebuflist(a:tabNr)
	let winnr = tabpagewinnr(a:tabNr)
	return bufname(buflist[winnr - 1])
endfunction

function! s:getBufDiagnostics(buf)
	let l:found_error = 0
	let l:found_warning = 0
	let signs = sign_getplaced(bufname(a:buf), {"group":'*'})[0]['signs']
	for sign in signs
		if     !(l:found_error) && (match(s:ErrorSigns, sign['name'])     != -1) | let l:found_error = 1
		elseif !(l:found_warning) && (match(s:WarningSigns, sign['name']) != -1) | let l:found_warning = 1
		endif
	endfor
	if     l:found_error   | return s:TabWithError
	elseif l:found_warning | return s:TabWithWarning
	endif
endfunction

function! s:getTabInfo(tabNr)
	let l:returnDict = {}
	let l:status = ""
	let l:diagnostics = 0
	let l:mod = 0

	let buflist = tabpagebuflist(a:tabNr)
	for buf in buflist
		" get diagnostics
		let l:returnDict[s:diagnosticsKey] = s:getBufDiagnostics(buf)

		" get status
		if getbufvar(buf, "&buftype") == 'help'
			let l:status .= '[H]' . fnamemodify(bufname(buf), ':t:s/.txt$//')
		elseif getbufvar(buf, "&buftype") == 'quickfix'
			let l:status .= '[Q]'
		endif
		" check how many are modified
		if getbufvar(buf, "&modified")
			let l:mod += 1
		endif
	endfor
	if l:mod > 0
		let l:status .= " +" .. string(l:mod)
	endif
	let l:returnDict[s:StatusKey] = l:status
	return l:returnDict
endfunction

function! s:generateTablable(tabNr, mode)
	let l:tabInfo = s:getTabInfo(a:tabNr)
	let l:tmp = ""
	let l:path = s:getFullPath(a:tabNr)

	if exists('g:Use_nerdfont') && g:Use_nerdfont
		let l:symbol = Devicons#GetPathSymbol(l:path, 'in_use')
	else
		let l:symbol = ""
	endif

	if l:tabInfo[s:diagnosticsKey]     == s:TabWithError   | let l:SymbolColor = "%#TabSymbolErr#"
	elseif l:tabInfo[s:diagnosticsKey] == s:TabWithWarning | let l:SymbolColor = "%#TabSymbolWar#"
	else | let l:SymbolColor = "%#TabSymbolReg#"
	endif

	if a:mode == 'active'
		let l:tmp .= "%>"
		let l:tmp .= "%#TabSepSel2Fill#" .. s:RtSep
		let l:tmp .= "%#TabLineSel#"
		let l:tmp .= "\ "
		let l:tmp .= l:symbol
		let l:tmp .= "\ "
		let l:tmp .= pathshorten(fnamemodify(l:path, ":~:."))
		let l:tmp .= "\ "
		let l:tmp .= l:tabInfo[s:StatusKey]
		let l:tmp .= "%#TabSepSel2Fill#" .. s:LtSep
		let l:tmp .= "%<"

	elseif a:mode == 'inactive'
		let l:tmp .= "%#TabSepReg2Fill#" .. s:RtSep
		let l:tmp .= "%#TabLine#"
		let l:tmp .= "\ "
		let l:tmp .= l:SymbolColor
		let l:tmp .= l:symbol
		let l:tmp .= "%#TabLine#"
		let l:tmp .= "\ "
		let l:tmp .= pathshorten(fnamemodify(l:path, ":."))
		"add for number of open windows in each tab
		"let l:tmp .= "(" .. tabpagewinnr(a:tabNr, '$') .. ")"
		let l:tmp .= "%#TabSpecial#"
		let l:tmp .= l:tabInfo[s:StatusKey]
		let l:tmp .= "\ "
		let l:tmp .= l:SymbolColor
		let l:tmp .= "●"
		let l:tmp .= "%#TabSepReg2Fill#" .. s:LtSep
	endif
	return l:tmp
endfunction

if g:SmartTablineEnabled
	set tabline=%!GenerateTabline()
endif

"endOfFile
