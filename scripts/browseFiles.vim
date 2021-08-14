"startOfFile
" Filename: browseFiles.vim
" Description: broswer for recent and existing files

if exists("g:historyPulled")
    finish
endif
let g:historyPulled = 1

if !exists('g:historyIgnore')
    let g:historyIgnore = [ 'vim\/runtime\/doc\/.*.txt' ]
endif

function! s:fileExists(path)
	if !empty(glob(a:path))
		return 1
	else
		return 0
	endif
endfunction

function! s:openFileUnderCursor()
    let l:file = getline('.') | q | execute 'e' fnameescape(l:file)
endfunction

function! s:pullHistory()
    belowright new + file

	for file in v:oldfiles
		if s:fileExists(file)
			silent put = file
    		silent call matchadd('Conceal', '^\zs.*\ze\/.*\/.*\/', 10, 99, {'conceal': '…'})
		endif
	endfor

	for pattern in g:historyIgnore
		silent execute 'g/' . pattern . '/d_'
	endfor

	nnoremap <silent> <buffer> q :q<CR>
	nnoremap <silent> <buffer> o :call <SID>openFileUnderCursor()<CR>

	setlocal nomodifiable noswapfile nospell nowrap
	setlocal buftype=nofile bufhidden=delete conceallevel=2
endfunction

command! BrowseRecent silent! call <SID>pullHistory()
"endOfFile
