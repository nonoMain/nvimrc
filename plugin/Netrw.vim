"startOfFile
" Filename: Netrw.vim

let s:last_bufNr = 0

" Netrw settings
let g:netrw_banner = 1
let g:netrw_liststyle = 1

function! Netrw#Toggle()
	let l:amountOfbuffers = len(filter(range(1, bufnr('$')), 'bufexists(v:val)'))
	if &filetype == "netrw" " quit while browsing
		let l:bufNr = bufnr()
		if (l:amountOfbuffers > 1)
			silent execute "buffer " .. s:last_bufNr
		else
			silent execute "bwipeout " .. l:bufNr
		endif
	else
		let s:last_bufNr = bufnr()
		silent Explore
	endif
endfunction

augroup AutoDeleteNetrwHiddenBuffers
  autocmd!
  autocmd FileType netrw setlocal bufhidden=wipe
augroup end

"endOfFile
