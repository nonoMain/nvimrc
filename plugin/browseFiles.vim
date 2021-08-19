"startOfFile
" Filename: browseFiles.vim
" Description: broswer for recent and existing files

let g:historyPulled = 0

let s:conceal_Hi_Lvl = 10
let s:conceal_match_id = 99
let s:symbol_len = 0

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

function! s:openFileUnderCursor()
	let l:file = getline('.')
	let l:file = strpart(l:file, 0, strlen(l:file) - s:symbol_len)
	q
	execute 'e' fnameescape(l:file)
	call s:closeBrowser()
	let g:historyPulled = 0
endfunction

function! s:closeBrowser()
	let l:i = bufnr("$")
	while (l:i >= 1)
		if (getbufvar(l:i, "&filetype") == "filebroswer")
			silent exe "bwipeout " . l:i 
		endif
		let l:i-=1
	endwhile
endfunction

function! s:openBrowser()
	let l:tmp = ""
	belowright new + file
	resize

	for l:file in v:oldfiles
		if s:fileExists(l:file)
			if g:Use_dev_icons | let l:tmp = " " .. Devicons#GetPathSymbol(l:file, 'view') | endif
			silent put = l:file .. l:tmp
			silent! call matchadd('Conceal', '^\zs.*\ze\/.*\/.*\/', s:conceal_Hi_Lvl, s:conceal_match_id, {'conceal': '…'})
		endif
	endfor

	for pattern in s:historyIgnore
		silent execute 'g/' . pattern . '/d_'
	endfor

	let s:symbol_len = strlen(l:tmp)

	nnoremap <silent> <buffer> q :q<CR>
	nnoremap <silent> <buffer> <CR> :call <SID>openFileUnderCursor()<CR>

	setlocal nomodifiable noswapfile nospell nowrap
	setlocal buftype=nofile bufhidden=delete conceallevel=2 filetype=filebroswer
endfunction

function! browseFiles#ToggleHistory()
	if g:historyPulled
		call s:closeBrowser()
		let g:historyPulled = 0
	else
		call s:openBrowser()
		let g:historyPulled = 1
	endif
endfunction

command! BrowseRecent silent! call g:PullHistory()
"endOfFile
