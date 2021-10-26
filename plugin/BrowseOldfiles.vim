"startOfFile
" Filename: browseFiles.vim
" Description: broswer for recent existing files


if !exists("g:BrowseOldfilesEnabled")
	let g:BrowseOldfilesEnabled = 0
endif
if !g:BrowseOldfilesEnabled
	finish
endif

let g:historyPulled = 0
let s:conceal_Hi_Lvl = 10
let s:conceal_match_id = 99

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
	call s:closeBrowser()
	execute s:win_nr . "wincmd w"
	execute 'e' fnameescape(l:file)
	let g:historyPulled = 0
	unlet s:win_nr
endfunction

function! s:closeBrowser()
	let bufNr = bufnr("$")
	while (bufNr >= 1)
		if (getbufvar(bufNr, "&filetype") == "filebroswer")
			silent exe "bwipeout " . bufNr 
		endif
		let bufNr-=1
	endwhile
	unlet s:files_shown
endfunction

function! s:openBrowser()
	let s:win_nr = winnr()
	let s:files_shown = []
	let l:ignore = 0
	let l:symbol = ""
	let l:line = ""
	belowright new
	resize

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

	nnoremap <silent> <buffer> q :q<CR>
	nnoremap <silent> <buffer> <CR> :call <SID>openFileUnderCursor()<CR>

	setlocal nomodifiable noswapfile nospell nowrap
	setlocal buftype=nofile bufhidden=delete conceallevel=2 filetype=filebroswer
endfunction

function! BrowseOldfiles#ToggleHistory()
	if g:historyPulled
		call s:closeBrowser()
		let g:historyPulled = 0
	else
		call s:openBrowser()
		let g:historyPulled = 1
	endif
endfunction
"endOfFile
