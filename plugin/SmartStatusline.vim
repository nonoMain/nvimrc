"startOfFile
" Filename: SmartStatusline.vim

if exists("g:StatuslineInitialized")
	finish
endif
let g:StatuslineInitialized = 1

" Settings for line length"
let s:long = 100
let s:medium = 90
let s:short = 65

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
	let l:symbol = ''
	if g:Use_dev_icons
		let l:symbol = "\ %{g:GetSystemSymbol()}"
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
	let l:symbol = ''
	if g:Use_dev_icons
		let l:symbol = "\ %{g:GetPathSymbol('in_use')}\ "
	else
		let l:symbol = "%y"
	endif
	if winwidth(a:win_id) > s:long
		return l:symbol .. "%p%%\ %l,%c\ 0x%04b"

	elseif winwidth(a:win_id) > s:medium
		return l:symbol .. "%p%%\ %l,%c\ "

	elseif winwidth(a:win_id) > s:short
		return l:symbol .. "%l,%c\ "
	
	else
		return "%l,%c\ "

	endif
	return l:tmp
endfunction

function! GetPath(win_id) abort
	return "\ %f%="
endfunction

function! s:generateStatusline(win_id, mode)
	let l:tmp=""
	if a:mode == 'active'
		let l:tmp.="%#PmenuSel#"
		let l:tmp.= GetRightSide(a:win_id)
		let l:tmp.="%#User1#" " seperator
		let l:tmp.=""
		let l:tmp.="%#statusline#"
		let l:tmp.="\ "
		let l:tmp.= GetPath(a:win_id)
		let l:tmp.="%#User1#" " seperator
		let l:tmp.=""
		let l:tmp.="%#PmenuSel#"
		let l:tmp.= GetLeftSide(a:win_id)
		let l:tmp.="\ "
	elseif a:mode == 'inactive'
		let l:tmp.="%#statusline#"
		let l:tmp.= GetRightSide(a:win_id)
		let l:tmp.="\ "
		let l:tmp.= GetPath(a:win_id)
		let l:tmp.= GetLeftSide(a:win_id)
		let l:tmp.="\ "
	endif
	return l:tmp
endfunction

function! SmartStatusline#Update()
	let l:curr_window_nr = winnr()
	let l:last_window_nr = winnr('$')
	for l:window_nr in range(1, l:last_window_nr)
		let l:state = (l:window_nr == l:curr_window_nr)? 'active' : 'inactive'
		let l:tmp = s:generateStatusline(win_getid(l:window_nr), l:state)
		call setwinvar(l:window_nr, '&statusline', l:tmp)
	endfor
endfunction

" Update Events:
augroup statusLine
	autocmd!
	autocmd VimEnter     * call SmartStatusline#Update()

	autocmd WinNew       * call SmartStatusline#Update()
	autocmd WinEnter     * call SmartStatusline#Update()
	autocmd BufWinEnter  * call SmartStatusline#Update()
	autocmd BufWinLeave  * call SmartStatusline#Update()

	autocmd BufCreate    * call SmartStatusline#Update()
	autocmd BufEnter     * call SmartStatusline#Update()
	autocmd BufDelete    * call SmartStatusline#Update()
augroup END

"endOfFile
