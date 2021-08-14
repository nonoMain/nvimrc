"startOfFile
" Filename: statusline.vim

function! GetGitBranch()
	if exists('g:loaded_fugitive')
		let l:maybeBranch = g:FugitiveStatusline()
		return ( strlen(l:maybeBranch) > 0)? l:maybeBranch : '-'
	endif
endfunction

function! GetStatusLine(mode)
	let tmp=""
	if a:mode == 'active'
		let tmp.="%#User1#"
		let tmp.="%m%r%w\ bf:%n\ %{GetGitBranch()}"
		let tmp.="%#CursorLineNr#"
		let tmp.="\ %f %m\ %="
		let tmp.="%#User1#"
		let tmp.="%y%p%%\|%l:%c\ 0x%04b"
		let tmp.="\ "
	else
		let tmp.="%#Pmenu#"
		let tmp.="%m%r%w\ bf:%n\|\ %{GetGitBranch()}"
		let tmp.="%#LineNr#"
		let tmp.="\ %f %m\ %="
		let tmp.="%#Pmenu#"
		let tmp.="%y\ %l:%c"
		let tmp.="\ "
	endif
	return tmp
endfunction

augroup statusLine
	autocmd!
	autocmd WinEnter * setlocal statusline=%!GetStatusLine('active')
	autocmd WinLeave * setlocal statusline=%!GetStatusLine('inactive')
augroup END

set statusline=%!GetStatusLine('active')

"endOfFile
