"startOfFile
" Filename: netrw.vim

let g:NetrwIsOpen=0
let g:netrw_banner = 0
let g:netrw_liststyle = 1

function! g:ToggleNetrw()
	if &filetype != "netrw"
		if g:NetrwIsOpen
			let bufNr = bufnr("$")
			while (bufNr >= 1)
				if (getbufvar(bufNr, "&filetype") == "netrw")
					silent exe "bprevious"
					silent! exe "bwipeout " . bufNr 
				endif
				let bufNr-=1
			endwhile
			silent Explore
		else
			let g:NetrwIsOpen=1
			silent Explore
		endif
	else
		let bufNr = bufnr("$")
		while (bufNr >= 1)
			if (getbufvar(bufNr, "&filetype") == "netrw")
				silent exe "bprevious"
				silent exe "bwipeout " . bufNr 
			endif
			let bufNr-=1
		endwhile
	endif
endfunction

"endOfFile
