"startOfFile
" Filename: netrw.vim

let g:NetrwIsOpen=0
let g:netrw_banner = 0
let g:netrw_liststyle = 1

function! g:ToggleNetrw()
	if &filetype != "netrw"
		if g:NetrwIsOpen
			let l:i = bufnr("$")
			while (l:i >= 1)
				if (getbufvar(l:i, "&filetype") == "netrw")
					silent exe "bwipeout " . l:i 
				endif
				let l:i-=1
			endwhile
			silent Explore
		else
			let g:NetrwIsOpen=1
			silent Explore
		endif
	else
		silent exe "bprevious"
		let l:i = bufnr("$")
		while (l:i >= 1)
			if (getbufvar(l:i, "&filetype") == "netrw")
				silent exe "bwipeout " . l:i 
			endif
			let l:i-=1
		endwhile
	endif
endfunction

"endOfFile
