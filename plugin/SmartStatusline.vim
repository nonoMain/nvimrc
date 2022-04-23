"startOfFile
" Filename: SmartStatusline.vim
" Description: smart status line (shows branch and lsp info)

" Settings for line length"
let s:long_width = 100
let s:medium_width = 75
let s:short_width = 58

if g:Use_devicons
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

"-------------- Statusline highlights --------------
function! SmartStatusline#Highlight()
	highlight StlReg               guifg=#b2b2b2 guibg=#202020 ctermfg=249 ctermbg=234 term=NONE gui=NONE
	highlight StlBranchSymbol      guifg=#87afd7 guibg=#202020 ctermfg=110 ctermbg=234 term=BOLD gui=BOLD
	highlight StlSepBranch2Reg     guifg=#202020 guibg=#202020 ctermfg=234 ctermbg=234 term=NONE gui=NONE
	highlight StlDiagnosticSymbol  guifg=#a03d65 guibg=#202020 ctermfg=131 ctermbg=234 term=BOLD gui=BOLD
	highlight StlBranch            guifg=#b2b2b2 guibg=#202020 ctermfg=249 ctermbg=234 term=NONE gui=NONE
	highlight StlSepBright2Reg     guifg=#005f87 guibg=#202020 ctermfg=24 ctermbg=234 term=NONE gui=NONE
	highlight StlRegBg             guifg=#202020 guibg=#202020 ctermfg=234 ctermbg=234 term=NONE gui=NONE
	highlight StlSepBright2Branch  guifg=#005f87 guibg=#202020 ctermfg=24 ctermbg=234 term=NONE gui=NONE
	highlight StlBufDataSymbol     guifg=#3da065 guibg=#202020 ctermfg=71 ctermbg=234 term=BOLD gui=BOLD
	highlight StlUBInfo            guifg=#b2b2b2 guibg=#202020 ctermfg=249 ctermbg=234 term=NONE gui=NONE
	highlight StlBright            guifg=#b2b2b2 guibg=#005f87 ctermfg=249 ctermbg=24 term=NONE gui=NONE
endfunction

function! s:getFullPath(bufnr)
	if a:bufnr == 0
		return ""
	endif
	let l:path = getbufinfo(bufname(a:bufnr))[0]['name']
	if l:path == ""
		return ""
	endif
	return l:path
endfunction

function! s:getPathSized(win_id)
	let l:width = winwidth(a:win_id)
	let l:bufnr = winbufnr(a:win_id)
	let l:path = s:getFullPath(l:bufnr)
	if l:width > s:long_width
		return l:path " full path
	elseif l:width > s:medium_width
		return fnamemodify(l:path, ":.") " relative path
	elseif l:width > s:short_width
		return pathshorten(fnamemodify(l:path, ":.")) " relative path shortened by pathshorten
	else
		return fnamemodify(l:path, ":t") " path tail
	endif
endfunction

function! s:getPathType(win_id) abort
	let l:tmp = ""
	let l:path = s:getFullPath(winbufnr(a:win_id))
	let l:width = winwidth(a:win_id)
	let l:tmp = ""
	if l:width > s:short_width
		if g:Use_devicons
			let l:tmp .= myUtils#Devicons#GetPathSymbol(l:path, 1)
		else
			let l:tmp .= fnamemodify(l:path, ":e")
		endif
	endif
	return l:tmp
endfunction

function! s:getBranch(win_id) abort
	let l:maybeBranch = myUtils#BigBrother#GetWinGitBranch()
	if !strlen(l:maybeBranch) | return "" | endif " no branch
	if winwidth(a:win_id) > s:short_width
		return l:maybeBranch
	else
		return ""
	endif
endfunction

function! s:getLeftSide(win_id) abort
	let l:symbol = ""
	if g:Use_devicons
		let l:symbol = "\ %{myUtils#Devicons#GetSystemSymbol()}"
	else
		let l:symbol = "\ %{&fileformat}"
	endif
	return l:symbol .. "\ b:%n\ "
endfunction

function! s:generateActiveStatusline(win_id)
	let l:width = winwidth(a:win_id)
	let l:bufNr = getwininfo(a:win_id)['variables']['bufnr']
	let l:maybeBranch = s:getBranch(a:win_id)
	let l:fileSymbol = s:getPathType(a:win_id)
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
	let l:tmp .= "%<" .. s:getPathSized(a:win_id)
	let l:tmp .= "%#StlRegBg#"
	let l:tmp .= "%="
	let l:tmp .= "%#StlReg#"

	if v:lua.vim.lsp.buf.server_ready() == v:true " if lsp is connected
		if l:width > s:short_width
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
	if l:width > s:medium_width
		let l:tmp .= "%P"
	endif
	let l:tmp .= "\ %l"
	let l:tmp .= ","
	let l:tmp .= "%c"
	if l:width > s:long_width
		let l:tmp .= "\ 0"
		let l:tmp .= "x"
		let l:tmp .= "\%04b"
	endif

	return l:tmp
endfunction

function! s:generateInactiveStatusline(win_id)
	let l:width = winwidth(a:win_id)
	let l:bufNr = getwininfo(a:win_id)['variables']['bufnr']
	let l:maybeBranch = s:getBranch(a:win_id)
	let l:fileSymbol = s:getPathType(a:win_id)
	let l:tmp = ""

	let l:tmp .= "%#statuslineNC#"
	let l:tmp .= "\ "
	let l:tmp .=  s:getLeftSide(a:win_id)
	if strlen(l:maybeBranch) " if you are in a git branch:
	let l:tmp .= s:BranchSymbol .. "\ "
	let l:tmp .= "\ "
	let l:tmp .= l:maybeBranch
	endif
	let l:tmp .= "\ \│\ "
	let l:tmp .= "%<" .. s:getPathSized(a:win_id) .. "%="
	let l:tmp .= "\│\ "
	if l:width > s:medium_width
		let l:tmp .= "%P\ "
	endif
	if l:width > s:short_width
		let l:tmp .= "%l,%c\ "
	endif

	return l:tmp
endfunction

function! s:not_to_set(win_id)
	return win_gettype(a:win_id) ==# 'popup' || win_gettype(a:win_id) ==# 'autocmd'
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
augroup statusline
	autocmd!
	autocmd ColorScheme  * call SmartStatusline#Highlight()
	autocmd BufEnter     * call SmartStatusline#Update()
	autocmd WinEnter     * call SmartStatusline#Update()
	autocmd VimResized   * call SmartStatusline#Update()
augroup END
