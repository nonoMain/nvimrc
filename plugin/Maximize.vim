"startOfFile
" Filename: Maximize.vim
" Description: maximize and restore windows

function! s:maximize_window()
	let t:prev_layout_cmd = winrestcmd()
	resize
	vert resize
	let t:post_layout_cmd = winrestcmd()
endfunction

function! s:restore_windows()
	exe t:prev_layout_cmd
endfunction

function! Maximize#Toggle()
	if exists("t:prev_layout_cmd") && exists("t:post_layout_cmd")
		if (t:post_layout_cmd == winrestcmd())
			call s:restore_windows()
		else
			call s:maximize_window()
		endif
	else
		call s:maximize_window()
	endif
endfunction

"endOfFile
