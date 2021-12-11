"startOfFile
" Filename: SmartStatusline.vim

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

" Description:
" highlight group - description
"
"  StlReg               - general color
"  StlRegBg             - general color same but fg and bg are the same (for not showing certin text like ^^^^^^^ in filchars)
"  StlBright            - main color for theme
"  StlBranch            - git's branch
"
"  StlDiagnosticSep     - color for seperator before diagnostics
"  StlDiagnosticSymbol  - symbol of diagnostics
"  StlDiagnosticDetail  - Details of diagnostics
"
"  StlBufDataSep        - color for seperator before BufData
"  StlBufDataSymbol     - symbol of BufData
"  StlBufDataDetail     - Details of BufData
"
"  StlSepBright2Reg     - seperator Bright -> Reg
"  StlSepBright2UBInfo  - seperator Bright -> UBInfo
"
"  StlSepReg2Bright     - seperator Reg -> Bright
"  StlSepReg2UBInfo     - seperator Reg -> UBInfo
"
"  StlSepUBInfo2Bright  - seperator UBInfo -> Bright
"  StlSepUBInfo2Reg     - seperator UBInfo -> Reg
"
" StatusLine highlight groups
let s:HG = {}

let s:HG.StlReg               = { "FG":g:ECP['objFg'],             "BG":g:ECP['objBg'] }
let s:HG.StlRegBg             = { "FG":g:ECP['objBg'],             "BG":g:ECP['objBg'] }
let s:HG.StlBright            = { "FG":g:ECP['objFg'],             "BG":g:ECP['selected'] }
let s:HG.StlBranch            = { "FG":g:ECP['branchFg'],          "BG":g:ECP['infoBg'] }
let s:HG.StlUBInfo            = { "FG":g:ECP['infoFg'],            "BG":g:ECP['objBg'] }

let s:HG.StlDiagnosticSep     = { "FG":g:ECP['symbolDiagnostics'], "BG":g:ECP['objBg'] }
let s:HG.StlDiagnosticSymbol  = { "FG":g:ECP['objBg'],            "BG":g:ECP['symbolDiagnostics'] }
let s:HG.StlDiagnosticDetail  = { "FG":g:ECP['symbolDiagnostics'], "BG":g:ECP['objBg'] }

let s:HG.StlBufDataSep        = { "FG":g:ECP['symbolBufData'], "BG":g:ECP['objBg'] }
let s:HG.StlBufDataSymbol     = { "FG":g:ECP['objBg'],            "BG":g:ECP['symbolBufData'] }
let s:HG.StlBufDataDetail     = { "FG":g:ECP['symbolBufData'], "BG":g:ECP['objBg'] }

let s:HG.StlSepBright2Reg     = { "FG":s:HG['StlBright']["BG"],    "BG":s:HG['StlReg']["BG"] }
let s:HG.StlSepBright2UBInfo  = { "FG":s:HG['StlBright']["BG"],    "BG":g:ECP['infoBg'] }
let s:HG.StlSepReg2Bright     = { "FG":s:HG['StlReg']["BG"],       "BG":s:HG['StlBright']["BG"] }
let s:HG.StlSepReg2UBInfo     = { "FG":g:ECP['infoBg'],            "BG":s:HG['StlReg']["BG"] }
let s:HG.StlSepUBInfo2Bright  = { "FG":g:ECP['infoBg'],            "BG":s:HG['StlBright']["BG"] }
let s:HG.StlSepUBInfo2Reg     = { "FG":g:ECP['infoBg'],            "BG":s:HG['StlReg']["BG"] }

" scan the assignment dict and execute the assignment
for key in keys(s:HG)
	call myUtils#BigBrother#HighlightDict(key, s:HG[key])
endfor

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
		return s:BranchSymbol .. "\ " .. l:maybeBranch
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
	if g:saved_windows[a:win_id]['width'] > s:long
		return l:symbol .. "\ %m%r%w\ b:%n\ "

	elseif g:saved_windows[a:win_id]['width'] > s:medium
		return "\ %M%R%W\ b:%n\ "

	elseif g:saved_windows[a:win_id]['width'] > s:short
		return "\ %M%R%W\ b:%n\ "

	else
		return "\ %M%R%W\ "
	endif
endfunction

function! s:generateStatusline(win_id, mode)
	let l:bufNr = getwininfo(a:win_id)['variables']['bufnr']
	let l:maybeBranch = s:getBranch(a:win_id)
	let l:fileSymbol = s:getPathSymbol(a:win_id)
	let l:tmp = ""

	if a:mode == 'active'
		" the active window updates all the windows all the time
		let l:tmp .= "%{SmartStatusline#Update()}"
		let l:tmp .= "%#StlBright#"
		let l:tmp .=  s:getLeftSide(a:win_id)

		if strlen(l:maybeBranch) " if you are in a git branch:
			let l:tmp .= "%#StlSepBright2UBInfo#" .. s:LtStlSep .. "\ " " seperator
			let l:tmp .= "%#StlBranch#"
			let l:tmp .= l:maybeBranch
			let l:tmp .= "%#StlSepUBInfo2Reg#" .. s:LtStlSep .. "\ " " seperator
		else
			let l:tmp .= "%#StlSepBright2Reg#" .. s:LtStlSep .. "\ " " seperator
		endif

		let l:tmp .= "%#StlReg#"
		let l:tmp .= "%<" .. s:getPath(a:win_id)
		let l:tmp .= "%#StlRegBg#"
		let l:tmp .= "%="
		let l:tmp .= "%#StlReg#"

		if v:lua.vim.lsp.buf.server_ready() == v:true " if lsp is connected
			let l:tmp .= "%#StlDiagnosticSep#"
			let l:tmp .= s:BlockSymbol
			let l:tmp .= "%#StlDiagnosticSymbol#"
			let l:tmp .= s:DiagnosticsSymbol .. "\ "
			let l:tmp .= "%#StlDiagnosticDetail#" .. "\ "
			if g:saved_windows[a:win_id]['width'] > s:short
				let l:tmp .= s:ErrorSymbol .. "\ "
				let l:tmp .= "%#StlUBInfo#"
				let l:tmp .= "%{myUtils#BigBrother#GetBufDiagnostics(" .. l:bufNr ..").ErrorCount}"
				let l:tmp .= "%#StlDiagnosticDetail#"
				let l:tmp .= "\ " .. s:WarningSymbol .. "\ "
				let l:tmp .= "%#StlUBInfo#"
				let l:tmp .= "%{myUtils#BigBrother#GetBufDiagnostics(" .. l:bufNr ..").WarningCount}"
				let l:tmp .= "\ "
			endif
		endif

		" BufData
		let l:tmp .= "%#StlBufDataSep#"
		let l:tmp .= s:BlockSymbol
		let l:tmp .= "%#StlBufDataSymbol#"
		let l:tmp .= l:fileSymbol .. "\ "
		if g:saved_windows[a:win_id]['width'] > s:medium
			let l:tmp .= "%#StlUBInfo#" .. "\ "
			let l:tmp .= "%p"
			let l:tmp .= "%#StlBufDataDetail#"
			let l:tmp .= "%%"
		endif
		let l:tmp .= "%#StlUBInfo#"
		let l:tmp .= "\ %l"
		let l:tmp .= "%#StlBufDataDetail#"
		let l:tmp .= ","
		let l:tmp .= "%#StlUBInfo#"
		let l:tmp .= "%c"
		if g:saved_windows[a:win_id]['width'] > s:long
			let l:tmp .= "\ 0"
			let l:tmp .= "%#StlBufDataDetail#"
			let l:tmp .= "x"
			let l:tmp .= "%#StlUBInfo#"
			let l:tmp .= "\%04b"
		endif

	elseif a:mode == 'inactive'

		let l:tmp .= "%#statuslineNC#"
		let l:tmp .= "\ "
		let l:tmp .=  s:getLeftSide(a:win_id)
		let l:tmp .= "\ "
		let l:tmp .= l:maybeBranch
		let l:tmp .= "\ \│\ "
		let l:tmp .= "%<" .. s:getPath(a:win_id) .. "%="
		let l:tmp .= "\│\ "
		if g:saved_windows[a:win_id]['width'] > s:medium
			let l:tmp .= "%p%%\ "
		endif
		if g:saved_windows[a:win_id]['width'] > s:short
			let l:tmp .= "%l,%c\ "
		endif
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

function! SmartStatusline#Update()
	let l:curr_window_nr = winnr()
	let l:last_window_nr = winnr('$')
	if s:not_to_set(l:curr_window_nr) | return | endif
	call s:update_saved_windows()

	for l:window_nr in range(1, l:last_window_nr)
		if (l:window_nr == l:curr_window_nr)
			if s:not_to_set(l:curr_window_nr)
				continue " skip certin windows
			else
				let l:state = 'active'
			endif
		else
			let l:state = 'inactive'
		endif

		let l:tmp = s:generateStatusline(win_getid(l:window_nr), l:state)
		call setwinvar(l:window_nr, '&statusline', l:tmp)
	endfor
	return ""
endfunction

function! SmartStatusline#Enable()
	" Create Update Events:
	augroup statusLine
		autocmd!
		" TODO: fix window stops being 'active' after insert mode
		autocmd BufLeave     * call SmartStatusline#Update()
		autocmd BufEnter     * call SmartStatusline#Update()
		autocmd WinEnter     * call SmartStatusline#Update()
		autocmd WinLeave     * call SmartStatusline#Update()
	augroup END

	" Do First Update:
	call SmartStatusline#Update()
endfunction

function! SmartStatusline#Disable()
	" Delete Update Events:
	augroup! statusLine
endfunction

" Start plugin
call SmartStatusline#Enable()
"endOfFile
