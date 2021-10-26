"startOfFile
" Filename: browseFiles.vim
" Description: broswer for recent existing files


if !exists("g:BrowseOldfilesEnabled")
	let g:BrowseOldfilesEnabled = 0
endif
if !g:BrowseOldfilesEnabled
	finish
endif

let s:conceal_Hi_Lvl = 10
let s:conceal_match_id = 99
let s:historybrowserIsOpen = 0

if !exists('g:historyIgnore')
	let s:historyIgnore = [ 'vim\/runtime\/doc\/.*.txt' ]
endif

function! s:fileExists(path)
	if !empty(glob(a:path))
		return 1
	else
		return 0
	endif
endfunction

function! s:openFileUnderCursor() abort
	let l:file = s:files_shown[line('.') - 1]
	execute 'e' fnameescape(l:file)
	call s:closeBrowser()
endfunction

function! s:closeBrowser()
	let s:historybrowserIsOpen = 0
	let l:amountOfbuffers = len(tabpagebuflist())
	let s:historybrowserIsOpen = 0
	silent! call matchdelete(s:conceal_match_id)
	if &filetype == "filebroswer" " quit while browsing
		let l:bufNr = bufnr()
		if (l:amountOfbuffers > 1)
			silent exe "bprevious"
		endif
		silent exe "bwipeout " . bufNr
	else " close after opening a file
		let l:bufNr = bufnr("$")
		while (bufNr >= 1)
			if (getbufvar(bufNr, "&filetype") == "filebroswer")
				silent exe "bwipeout " . bufNr 
			endif
			let bufNr-=1
		endwhile
	endif
	unlet s:files_shown
endfunction

function! s:openBrowser()
	let s:historybrowserIsOpen = 1
	let s:files_shown = []
	let l:ignore = 0
	let l:symbol = ""
	let l:line = ""
	enew

	for l:file in v:oldfiles
		if !s:fileExists(l:file) | continue | endif
		let l:ignore = 0
		if g:Use_nerdfont
			let l:symbol = " " .. Devicons#GetPathSymbol(l:file, 'view') .. " ."
		endif

		for l:pattern in s:historyIgnore
			if  match(l:file, pattern) != -1
				let l:ignore = 1
				break
			endif
		endfor

		if !l:ignore
			let l:line = l:file .. l:symbol
			let s:files_shown += [l:file]
			silent put = l:line
			silent! call matchadd('Conceal', '^\zs.*\ze\/.*\/.*\/', s:conceal_Hi_Lvl, s:conceal_match_id, {'conceal': '…'})
		endif
	endfor
	silent exe "g/^$/d_"

	nnoremap <silent> <buffer> <CR> :call <SID>openFileUnderCursor()<CR>

	setlocal nomodifiable noswapfile nospell nowrap
	setlocal buftype=nofile bufhidden=delete conceallevel=2 filetype=filebroswer
endfunction

function! BrowseOldfiles#ToggleHistory()
	if s:historybrowserIsOpen
		call s:closeBrowser()
	else
		call s:openBrowser()
	endif
endfunction
"endOfFile
