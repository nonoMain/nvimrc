"startOfFile
" Filename: SmartTabline.vim
"
if !exists("g:ECP")
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
		let g:ECP.bg = 'NONE'
	else
		let g:ECP.bg = '#141414'
	endif
endif

let s:diagnosticsKey = 'diagnostics' " what type of diagnostics there are on all the buffers
let s:StatusKey      = 'status'      " what is the type of the current buffer and how many modified buffers there are

if g:Use_nerdfont
	let s:diagnosticsOkSymbol = ""
	let s:diagnosticsWarSymbol = ""
	let s:diagnosticsErrSymbol = ""
else
	let s:diagnosticsOkSymbol = "×"
	let s:diagnosticsWarSymbol = "W"
	let s:diagnosticsErrSymbol = "E"
endif
" Highlight Groups - H.G
" Keys:
" S: Special things like 'bold' 'italic'
" FG: frontground color
" BG: background color
" Description:
"
" highlight group - description
"  TabLineSel     - selected tab
"  TabLine        - regular unselcted tab
"  TabDiagnosticsReg   - tab symbols normaly
"  TabDiagnosticsWar   - tab symbols when there are warnings
"  TabDiagnosticsErr   - tab symbols when there are errors
"  TabLineFill    - background of the tabline

" StatusLine highlight groups
let s:HG = {}
let s:HG.TabLineSel        = { "FG":g:ECP.objFg,       "BG":g:ECP.selected }
let s:HG.TabLine           = { "FG":g:ECP.objFg,       "BG":g:ECP.objBg }
let s:HG.TabDiagnosticsReg = { "FG":g:ECP.objFg,       "BG":g:ECP.objBg }
let s:HG.TabDiagnosticsWar = { "FG":g:ECP.symbolWarFg, "BG":g:ECP.objBg }
let s:HG.TabDiagnosticsErr = { "FG":g:ECP.symbolErrFg, "BG":g:ECP.objBg }
let s:HG.TabLineFill       = { "BG":g:ECP.bg }

" scan the assignment dict and execute the assignment
function! SmartTabline#Highlight()
	for key in keys(s:HG)
		call myUtils#BigBrother#HighlightDict(key, s:HG[key])
	endfor
endfunction

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

function! s:getTabDiagnostics(tabNr)
	let l:tabDiagnostics = {}
	let l:tabDiagnostics.ErrorCount = 0
	let l:tabDiagnostics.WarningCount = 0

	let buflist = tabpagebuflist(a:tabNr)
	let buflist = uniq(buflist)
	for buf in buflist
		let l:curr_buff_diagnostics = myUtils#BigBrother#GetBufDiagnostics(buf)
		let l:tabDiagnostics.ErrorCount += l:curr_buff_diagnostics.ErrorCount
		let l:tabDiagnostics.WarningCount += l:curr_buff_diagnostics.WarningCount
	endfor

	return l:tabDiagnostics
endfunction

function! s:getModCount(tabNr)
	let l:mod = ""
	let l:count = 0

	let buflist = tabpagebuflist(a:tabNr)
	let buflist = uniq(buflist)
	for buf in buflist
		" check how many are modified
		if getbufvar(buf, "&modified")
			let l:count += 1
		endif
	endfor
	if l:count > 0
		let l:mod .= "[+" .. string(l:count) .. "]"
	endif
	return l:mod
endfunction

function! s:generateTablable(tabNr, mode)
	let l:tabDiagnostics = s:getTabDiagnostics(a:tabNr)
	let l:tabModCount = s:getModCount(a:tabNr)
	let l:tmp = ""
	let l:fileSymbol = ""
	let l:path = s:getFullPath(a:tabNr)
	let l:diagnosticsColor = "%#TabDiagnosticsReg#"
	let l:diagnosticsSymbol = s:diagnosticsOkSymbol

	if exists('g:Use_nerdfont') && g:Use_nerdfont
		let l:fileSymbol = myUtils#Devicons#GetPathSymbol(l:path, 1)
	endif

	if l:tabDiagnostics.ErrorCount > 0
		let l:diagnosticsColor = "%#TabDiagnosticsErr#"
		let l:diagnosticsSymbol = s:diagnosticsErrSymbol
	elseif l:tabDiagnostics.WarningCount > 0
		let l:diagnosticsColor = "%#TabDiagnosticsWar#"
		let l:diagnosticsSymbol = s:diagnosticsWarSymbol
	endif

	if a:mode == 'active'
		let l:tmp .= "%>"
		let l:tmp .= "%#TabLineSel#"
		let l:tmp .= "\ "
		let l:tmp .= l:fileSymbol
		let l:tmp .= "\ "
		let l:tmp .= pathshorten(fnamemodify(l:path, ":~:."))
		if strlen(l:tabModCount)
			let l:tmp .= "\ "
			let l:tmp .= l:tabModCount
		endif
		let l:tmp .= "\ "
		let l:tmp .= l:diagnosticsSymbol .. "\ "
		let l:tmp .= "%#TabLine#"
		let l:tmp .= "\|\ "
		let l:tmp .= "%<"

	elseif a:mode == 'inactive'
		let l:tmp .= "%#TabLine#"
		let l:tmp .= "\ "
		let l:tmp .= l:fileSymbol
		let l:tmp .= "\ "
		let l:tmp .= pathshorten(fnamemodify(l:path, ":."))
		if strlen(l:tabModCount)
			let l:tmp .= "\ "
			let l:tmp .= "%#DiffChange#"
			let l:tmp .= l:tabModCount
			let l:tmp .= "%#TabLine#"
		endif
		let l:tmp .= "\ "
		let l:tmp .= l:diagnosticsColor
		let l:tmp .= l:diagnosticsSymbol .. "\ "
		let l:tmp .= "\|"
	endif
	return l:tmp
endfunction

augroup tabline
	autocmd!
	autocmd ColorScheme  * call SmartTabline#Highlight()
augroup END

set tabline=%!GenerateTabline()

"endOfFile
