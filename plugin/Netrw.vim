"startOfFile
" Filename: netrw.vim

if !exists("g:NetrwPluginEnabled")
	let g:NetrwPluginEnabled = 0
endif
if !g:NetrwPluginEnabled
	finish
endif

let g:netrw_banner = 0
let g:netrw_liststyle = 1
let s:NetrwIsOpen = 0

function! s:closeNetrw()
	let s:NetrwIsOpen = 0
	let l:bufNr = bufnr("$")
	while (l:bufNr >= 1)
		if (getbufvar(l:bufNr, "&filetype") == "netrw")
			silent exe "bwipeout " . l:bufNr 
		endif
		let l:bufNr-=1
	endwhile
endfunction

function! Netrw#ToggleNetrw()
	let l:amountOfbuffers = len(tabpagebuflist())
	if &filetype == "netrw" " quit while browsing
		let l:bufNr = bufnr()
		if (l:amountOfbuffers > 1)
			silent exe "bprevious"
		endif
		silent exe "bwipeout " . l:bufNr
	else
		if s:NetrwIsOpen
			call s:closeNetrw()
			let s:NetrwIsOpen=1
			silent Explore
		else
			let s:NetrwIsOpen=1
			silent Explore
		endif
	endif
endfunction

"endOfFile
