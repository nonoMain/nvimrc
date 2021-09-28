"startOfFile
" Filename: netrw.vim

if !exists("g:NetrwPluginEnabled")
	let g:NetrwPluginEnabled = 0
endif
if !g:NetrwPluginEnabled
	finish
endif

let g:NetrwIsOpen=0
let g:netrw_banner = 0
let g:netrw_liststyle = 1

function! Netrw#ToggleNetrw()
	let l:amountOfbuffers = len(tabpagebuflist())
	if &filetype != "netrw"
		if g:NetrwIsOpen
			let bufNr = bufnr("$")
			while (bufNr >= 1)
				if (getbufvar(bufNr, "&filetype") == "netrw")
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
				if (l:amountOfbuffers > 1)
					silent exe "bprevious"
				endif
				silent exe "bwipeout " . bufNr
			endif
			let bufNr-=1
		endwhile
	endif
endfunction

"endOfFile
