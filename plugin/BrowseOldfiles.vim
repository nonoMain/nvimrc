"startOfFile
" Filename: BrowseOldfiles.vim
" Description: broswer for recent existing files

let s:last_bufNr = 0
let s:files_shown = []

if !exists('g:historyIgnore')
	let s:historyIgnore = [
	\ 'vim\/runtime\/doc\/.*.txt',
	\ 'nvim\/.*\/doc\/.*.txt',
	\ ]
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
endfunction

function! s:openBrowser()
	let s:files_shown = []
	let l:ignore = 0
	let l:symbol = ""
	let l:line = ""
	enew

	for l:file in v:oldfiles
		if !s:fileExists(l:file) | continue | endif
		let l:ignore = 0
		if g:Use_devicons
			let l:symbol = "\ [" .. myUtils#Devicons#GetPathSymbol(l:file, 'view') .. "\]"
		endif

		for l:pattern in s:historyIgnore
			if  match(l:file, l:pattern) != -1
				let l:ignore = 1
				break
			endif
		endfor

		if !l:ignore
			let l:line = l:file .. l:symbol
			let s:files_shown += [l:file]
			silent put = l:line
		endif
	endfor
	silent exe "g/^$/d_"

	nnoremap <silent> <buffer> <CR> :call <SID>openFileUnderCursor()<CR>

	setlocal nomodifiable noswapfile nospell nowrap
	setlocal buftype=nofile bufhidden=delete conceallevel=2 filetype=oldfilesBroswer
endfunction

function! BrowseOldfiles#ToggleHistory()
	let l:amountOfbuffers = len(filter(range(1, bufnr('$')), 'bufexists(v:val)'))
	if &filetype == "oldfilesBroswer" " quit while browsing
		let l:bufNr = bufnr()
		if (l:amountOfbuffers > 1)
			silent execute "buffer " .. s:last_bufNr
		else
			silent execute "bwipeout " .. l:bufNr
		endif
	else
		let s:last_bufNr = bufnr()
		call s:openBrowser()
	endif
endfunction

augroup AutoDeleteBrowseOldFilesHiddenBuffers
  autocmd!
  autocmd FileType oldfilesBroswer setlocal bufhidden=wipe
augroup end

call myUtils#Devicons#ColorFileType('oldfilesBroswer')
"endOfFile
