"startOfFile
" Filename: statusline.vim

function! GetGitBranch()
	if exists('g:loaded_fugitive')
		let l:maybeBranch = g:FugitiveHead()
		if g:Use_dev_icons
			return ( strlen(l:maybeBranch) > 0)? " "..l:maybeBranch : '-'
		else
			return ( strlen(l:maybeBranch) > 0)? "ᚠ "..l:maybeBranch : '-'
		endif
	endif
endfunction

function! GetStatusLine(mode)
	let tmp=""
	if g:Use_dev_icons " Dev icons
		if a:mode == 'active'
			let tmp.="%#PmenuSel#"
			let tmp.="%m%r%w\ bf:%n\ %{GetGitBranch()}"
			let tmp.="%#User1#" " seperator
			let tmp.=""
			let tmp.="%#statusline#"
			let tmp.="\ %f %m\ %="
			let tmp.="%#User1#" " seperator
			let tmp.=""
			let tmp.="%#PmenuSel#"
			let tmp.="\[%{g:GetPathSymbol('in_use')}\]%p%%\ %l,%c\ 0x%04b"
			let tmp.="\ "
		else
			let tmp.="%#statusline#"
			let tmp.="%m%r%w\ bf:%n"
			let tmp.="\ %f %m\ %="
			let tmp.="%y\ %l:%c"
			let tmp.="\ "
		endif
	else " utf-8
		if a:mode == 'active'
			let tmp.="%#PmenuSel#"
			let tmp.="%m%r%w\ bf:%n\ %{GetGitBranch()}"
			let tmp.="%#statusline#"
			let tmp.="\ %f %m\ %="
			let tmp.="%#PmenuSel#"
			let tmp.="%y%p%%\ %l,%c\ 0x%04b"
			let tmp.="\ "
		else
			let tmp.="%#statusline#"
			let tmp.="%m%r%w\ bf:%n"
			let tmp.="\ %f %m\ %="
			let tmp.="%y\ %l:%c"
			let tmp.="\ "
		endif
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
