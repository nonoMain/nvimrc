"startOfFile
" Filename: browseFiles.vim Description: broswer for recent existing files

if !(exists("g:Use_devicons_colors"))
	let g:Use_devicons_colors = 0
endif

let s:conceal_Hi_Lvl = 10
let s:conceal_match_id = 99
let s:last_bufNr = 0
let s:files_shown = []

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
	silent! call matchdelete(s:conceal_match_id)
	unlet s:files_shown
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
		if g:Use_nerdfont
			let l:symbol = "\ " .. myUtils#Devicons#GetPathSymbol(l:file, 'view') .. "\ ."
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
			silent! call matchadd('Conceal', '^\zs.*\ze\/.*\/.*\/', s:conceal_Hi_Lvl, s:conceal_match_id, {'conceal': '…'})
		endif
	endfor
	silent exe "g/^$/d_"

	nnoremap <silent> <buffer> <CR> :call <SID>openFileUnderCursor()<CR>

	setlocal nomodifiable noswapfile nospell nowrap
	setlocal buftype=nofile bufhidden=delete conceallevel=2 filetype=oldfilesBroswer
endfunction

function! BrowseOldfiles#ToggleHistory()
	let l:amountOfbuffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
	if &filetype == "oldfilesBroswer" " quit while browsing
		let l:bufNr = bufnr()
		if (l:amountOfbuffers > 0)
			silent execute "buffer " .. s:last_bufNr
		else
			silent execute "bwipeout " .. l:bufNr
		endif
		call s:closeBrowser()
	else
		let s:last_bufNr = bufnr()
		call s:openBrowser()
	endif
endfunction

augroup AutoDeleteBrowseOldFilesHiddenBuffers
  autocmd!
  autocmd FileType oldfilesBroswer setlocal bufhidden=wipe
augroup end

if g:Use_devicons_colors
	call myUtils#Devicons#ColorFileType('oldfilesBroswer')
endif

"endOfFile
