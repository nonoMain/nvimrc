"startOfFile
" Filename: SmartStatusline.vim

" Settings for line length"
let s:long = 100
let s:medium = 90
let s:short = 65

let g:SmartStatuslineEnabled = 0

function! GetGitBranch() abort
	if exists('g:loaded_fugitive')
		let l:maybeBranch = g:FugitiveHead()
		if g:Use_dev_icons
		return ( strlen(l:maybeBranch) > 0)? "-"..l:maybeBranch : ''
		else
		return ( strlen(l:maybeBranch) > 0)? "ᚠ-"..l:maybeBranch : ''
		endif
	endif
endfunction

function! GetRightSide(win_id) abort
	let l:symbol = ""
	if g:Use_dev_icons
		let l:symbol = "\ %{Devicons#GetSystemSymbol()}"
	else
		let l:symbol = "\ %{&fileformat}"
	endif
	if winwidth(a:win_id) > s:long
		return l:symbol .. "%m%r%w\ b:%n\ %{GetGitBranch()}"

	elseif winwidth(a:win_id) > s:medium
		return "%m%r%w\ b:%n\ %{GetGitBranch()}"

	elseif winwidth(a:win_id) > s:short
		return "%M%R%W\ b:%n\ %{GetGitBranch()}"

	else
		return "%M%R%W\ b:%n"

	endif
endfunction

function! GetLeftSide(win_id) abort
	if winwidth(a:win_id) > s:long
		return "%p%%\ %l,%c\ 0x%04b"

	elseif winwidth(a:win_id) > s:medium
		return "%p%%\ %l,%c\ "

	elseif winwidth(a:win_id) > s:short
		return "\ %l,%c\ "
	else
		return "%l,%c"
	endif
endfunction

function! GetPathSymbol(win_id) abort
	let l:tmp = ""
	if winwidth(a:win_id) > s:short
		let l:tmp .= "%#User4#" " seperator
		let l:tmp .= ""
		let l:tmp .= "%#User3#" " seperator
		if g:Use_dev_icons
			let l:tmp .= "%{Devicons#GetPathSymbol(expand('%'), 'in_use')}\ "
		else
			let l:tmp .= "%Y"
		endif
		let l:tmp .= "%#User1#" " seperator
		let l:tmp .= ""
	endif
	return l:tmp
endfunction

function! s:generateStatusline(win_id, mode)
	let l:tmp = ""
	if a:mode == 'active'
		let l:tmp .= "%#User1#"
		let l:tmp .=  GetRightSide(a:win_id)
		let l:tmp .= "%#User2#" " seperator
		let l:tmp .= ""
		let l:tmp .= "%#statusline#"
		let l:tmp .=  "%f%="
		let l:tmp .=  GetPathSymbol(a:win_id)
		let l:tmp .= "%#User1#"
		let l:tmp .=  GetLeftSide(a:win_id)
		let l:tmp .= "\ "
	elseif a:mode == 'inactive'
		let l:tmp .= "%#statusline#"
		let l:tmp .=  GetRightSide(a:win_id)
		let l:tmp .= "\ "
		let l:tmp .=  "%f%="
		let l:tmp .=  GetPathSymbol(a:win_id)
		let l:tmp .=  GetLeftSide(a:win_id)
		let l:tmp .= "\ "
	endif
	return l:tmp
endfunction

function! s:not_to_set(win_id)
	return win_gettype(a:win_id) ==# 'popup' || win_gettype(a:win_id) ==# 'autocmd'
endfunction

function! SmartStatusline#Update()
	let l:curr_window_nr = winnr()
	let l:last_window_nr = winnr('$')

	for l:window_nr in range(1, l:last_window_nr)
		if g:SmartStatuslineEnabled
			let l:state = (l:window_nr == l:curr_window_nr)? 'active' : 'inactive'
			let l:tmp = s:generateStatusline(win_getid(l:window_nr), l:state)
			call setwinvar(l:window_nr, '&statusline', l:tmp)
		else
			call setwinvar(l:window_nr, '&statusline', '')
		endif
	endfor
endfunction

function! SmartStatusline#Enable()
	if !g:SmartStatuslineEnabled
		let g:SmartStatuslineEnabled = 1
		" Create Update Events:
		augroup statusLine
			autocmd!
			" TODO: fix window stops being 'active' after insert mode
			autocmd InsertLeave  * call SmartStatusline#Update()

			autocmd WinNew       * call SmartStatusline#Update()
			autocmd BufWipeout   * call SmartStatusline#Update()
			autocmd WinEnter     * call SmartStatusline#Update()
			autocmd BufWinEnter  * call SmartStatusline#Update()
			autocmd BufWinLeave  * call SmartStatusline#Update()

			autocmd BufNew       * call SmartStatusline#Update()
			autocmd BufCreate    * call SmartStatusline#Update()
			autocmd BufEnter     * call SmartStatusline#Update()
			autocmd BufDelete    * call SmartStatusline#Update()
		augroup END

		" Do First Update:
		call SmartStatusline#Update()
	endif
endfunction

function! SmartStatusline#Disable()
	if g:SmartStatuslineEnabled
		let g:SmartStatuslineEnabled = 0
		" Delete Update Events:
		augroup! statusLine
		" Clear &statusline:
		call SmartStatusline#Update()
	endif
endfunction

" Start plugin
call SmartStatusline#Enable()
"endOfFile
