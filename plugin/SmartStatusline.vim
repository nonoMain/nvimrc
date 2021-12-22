"startOfFile
" Filename: SmartStatusline.vim
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
endif

" Settings for line length"
let s:long = 100
let s:medium = 75
let s:short = 58

if g:Use_nerdfont
	let s:LtStlSep = ""
	let s:RtStlSep = ""
	let s:BlockSymbol = ""
	let s:BranchSymbol = ""
	let s:DiagnosticsSymbol = ""
	let s:ErrorSymbol = ""
	let s:WarningSymbol = ""
else
	let s:LtStlSep = ""
	let s:RtStlSep = ""
	let s:BlockSymbol = ""
	let s:BranchSymbol = "|-"
	let s:DiagnosticsSymbol = "LSP"
	let s:ErrorSymbol = "E"
	let s:WarningSymbol = "W"
endif

let g:saved_windows = {}

" Statusline color Pallet is g:ECP
" Keys:
" gui:G
" guifg:GFG
" guibg:GBG
" term:T
" termfg:TFG
" termbg:TBG
"
" ** using branchFg for both branch and file symbol, if you wish to change one
" of them without affecting the other add another highlight group and update
" the specifications in the variables **

" Highlight Groups - s:HG
" Keys:
" gui:G
" guifg:GFG
" guibg:GBG
" term:T
" termfg:TFG
" termbg:TBG
"
" StatusLine highlight groups
let s:HG = {}

let s:HG.StlReg               = { "FG":g:ECP['objFg'],             "BG":g:ECP['bg'] }
let s:HG.StlRegBg             = { "FG":g:ECP['bg'],                "BG":g:ECP['bg'] }
let s:HG.StlBright            = { "FG":g:ECP['objFg'],             "BG":g:ECP['selected'] }
let s:HG.StlBranch            = { "FG":g:ECP['objFg'],            "BG":g:ECP['objBg'] }
let s:HG.StlUBInfo            = { "FG":g:ECP['objFg'],            "BG":g:ECP['bg'] }

let s:HG.StlBranchSymbol      = { "FG":g:ECP['symbolBranch'],      "BG":g:ECP['bg'] }
let s:HG.StlDiagnosticSymbol  = { "FG":g:ECP['symbolDiagnostics'], "BG":g:ECP['bg'] }
let s:HG.StlBufDataSymbol     = { "FG":g:ECP['symbolBufData'],     "BG":g:ECP['bg'] }

let s:HG.StlSepBranch2Reg     = { "FG":s:HG.StlBranch["BG"],       "BG":s:HG['StlReg']["BG"] }
let s:HG.StlSepBright2Branch  = { "FG":s:HG.StlBright["BG"],       "BG":s:HG['StlBranch']["BG"] }
let s:HG.StlSepBright2Reg     = { "FG":s:HG.StlBright["BG"],       "BG":s:HG['StlReg']["BG"] }

" scan the assignment dict and execute the assignment
function! SmartStatusline#Highlight()
	for key in keys(s:HG)
		call myUtils#BigBrother#HighlightDict(key, s:HG[key])
	endfor
endfunction

function! s:getPathSymbol(win_id) abort
	let l:tmp = ""
	let l:path = g:saved_windows[a:win_id]['path']
	if g:saved_windows[a:win_id]['width'] > s:short
		if g:Use_nerdfont
			let l:tmp .= myUtils#Devicons#GetPathSymbol(l:path, 1)
		else
			let l:tmp .= fnamemodify(l:path, ":e")
		endif
	endif
	return l:tmp
endfunction

function! s:getPath(win_id) abort
	let l:path = g:saved_windows[a:win_id]['path']
	if g:saved_windows[a:win_id]['width'] > s:long
		return l:path " full path

	elseif g:saved_windows[a:win_id]['width'] > s:medium
		return fnamemodify(l:path, ":.") " relative path

	elseif g:saved_windows[a:win_id]['width'] > s:short
		return pathshorten(fnamemodify(l:path, ":."))

	else
		return fnamemodify(l:path, ":t")
	endif
endfunction

function! s:getBranch(win_id) abort
	let l:maybeBranch = myUtils#BigBrother#GetWinGitBranch()
	if !strlen(l:maybeBranch) | return "" | endif " no branch
	if g:saved_windows[a:win_id]['width'] > s:short
		return l:maybeBranch
	else
		return ""
	endif
endfunction

function! s:getLeftSide(win_id) abort
	let l:symbol = ""
	if g:Use_nerdfont
		let l:symbol = "\ %{myUtils#Devicons#GetSystemSymbol()}"
	else
		let l:symbol = "\ %{&fileformat}"
	endif
	return l:symbol .. "\ b:%n\ "
endfunction

function! s:generateActiveStatusline(win_id)
	let l:bufNr = getwininfo(a:win_id)['variables']['bufnr']
	let l:maybeBranch = s:getBranch(a:win_id)
	let l:fileSymbol = s:getPathSymbol(a:win_id)
	let l:tmp = ""

	let l:tmp = "%{SmartStatusline#UpdateActive()}"

	" the active window updates all the windows all the time
	let l:tmp .= "%#StlBright#"
	let l:tmp .=  s:getLeftSide(a:win_id)

	if strlen(l:maybeBranch) " if you are in a git branch:
		let l:tmp .= "%#StlSepBright2Branch#" .. s:LtStlSep .. "\ " " seperator
		let l:tmp .= "%#StlBranchSymbol#"
		let l:tmp .= s:BranchSymbol .. "\ "
		let l:tmp .= "%#StlBranch#"
		let l:tmp .= l:maybeBranch
		let l:tmp .= "%#StlSepBranch2Reg#" .. s:LtStlSep .. "\ " " seperator
	else
		let l:tmp .= "%#StlSepBright2Reg#" .. s:LtStlSep .. "\ " " seperator
	endif

	let l:tmp .= "%#StlReg#"
	let l:tmp .= "%<" .. s:getPath(a:win_id)
	let l:tmp .= "%#StlRegBg#"
	let l:tmp .= "%="
	let l:tmp .= "%#StlReg#"

	if v:lua.vim.lsp.buf.server_ready() == v:true " if lsp is connected
		if g:saved_windows[a:win_id]['width'] > s:short
			let l:tmp .= "%#StlDiagnosticSymbol#"
			let l:tmp .= s:ErrorSymbol .. "\ "
			let l:tmp .= "%#StlUBInfo#"
			let l:tmp .= "%{myUtils#BigBrother#GetBufDiagnostics(" .. l:bufNr ..").ErrorCount}"
			let l:tmp .= "%#StlDiagnosticSymbol#"
			let l:tmp .= "\ " .. s:WarningSymbol .. "\ "
			let l:tmp .= "%#StlUBInfo#"
			let l:tmp .= "%{myUtils#BigBrother#GetBufDiagnostics(" .. l:bufNr ..").WarningCount}"
		endif
		let l:tmp .= "\ "
	endif

	" BufData
	let l:tmp .= "%#StlBufDataSymbol#"
	let l:tmp .= l:fileSymbol .. "\ "
	let l:tmp .= "%#StlUBInfo#"
	if g:saved_windows[a:win_id]['width'] > s:medium
		let l:tmp .= "%P"
	endif
	let l:tmp .= "\ %l"
	let l:tmp .= ","
	let l:tmp .= "%c"
	if g:saved_windows[a:win_id]['width'] > s:long
		let l:tmp .= "\ 0"
		let l:tmp .= "x"
		let l:tmp .= "\%04b"
	endif

	return l:tmp
endfunction

function! s:generateInactiveStatusline(win_id)
	let l:bufNr = getwininfo(a:win_id)['variables']['bufnr']
	let l:maybeBranch = s:getBranch(a:win_id)
	let l:fileSymbol = s:getPathSymbol(a:win_id)
	let l:tmp = ""

	let l:tmp .= "%#statuslineNC#"
	let l:tmp .= "\ "
	let l:tmp .=  s:getLeftSide(a:win_id)
	let l:tmp .= "\ "
	let l:tmp .= l:maybeBranch
	let l:tmp .= "\ \│\ "
	let l:tmp .= "%<" .. s:getPath(a:win_id) .. "%="
	let l:tmp .= "\│\ "
	if g:saved_windows[a:win_id]['width'] > s:medium
		let l:tmp .= "%P\ "
	endif
	if g:saved_windows[a:win_id]['width'] > s:short
		let l:tmp .= "%l,%c\ "
	endif

	return l:tmp
endfunction

function! s:not_to_set(win_id)
	return win_gettype(a:win_id) ==# 'popup' || win_gettype(a:win_id) ==# 'autocmd'
endfunction

function! s:update_saved_windows() abort
	if exists("g:saved_windows") | unlet g:saved_windows | let g:saved_windows = {} | endif
	let l:last_window_nr = winnr('$')
	for l:window_nr in range(1, l:last_window_nr)
		let l:win_id = win_getid(l:window_nr)
		let l:tmpwin = getwininfo(l:win_id)[0]
		let l:tmpbuf = getbufinfo(bufname(l:tmpwin['bufnr']))[0]
		let g:saved_windows[l:win_id] = l:tmpwin

		if getbufvar(l:tmpwin['bufnr'], "&filetype") == "netrw"
			let g:saved_windows[l:win_id]['path'] = l:tmpwin['variables']['netrw_rexdir']
		else
			let g:saved_windows[l:win_id]['path'] = l:tmpbuf['name']
		endif
	endfor
endfunction

function! SmartStatusline#UpdateActive()
	let l:tmp = s:generateActiveStatusline(win_getid())
	call setwinvar(winnr(), '&statusline', l:tmp)
	return ""
endfunction

function! SmartStatusline#Update()
	let l:curr_window_nr = winnr()
	let l:last_window_nr = winnr('$')
	let l:tmp = ""

	call s:update_saved_windows()
	for l:window_nr in range(1, l:last_window_nr)
		if s:not_to_set(l:curr_window_nr)
			continue " skip certin windows
		elseif (l:window_nr == l:curr_window_nr)
			let l:tmp = s:generateActiveStatusline(win_getid(l:window_nr))
		else
			let l:tmp = s:generateInactiveStatusline(win_getid(l:window_nr))
		endif
		call setwinvar(l:window_nr, '&statusline', l:tmp)
	endfor
endfunction

" Create Update Events
augroup statusLine
	autocmd!
	autocmd ColorScheme  * call SmartStatusline#Highlight()
	autocmd BufEnter     * call SmartStatusline#Update()
	autocmd WinEnter     * call SmartStatusline#Update()
augroup END

" Highlight
call SmartStatusline#Highlight()
" Do First Update
call SmartStatusline#Update()
"endOfFile
