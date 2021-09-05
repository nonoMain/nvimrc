"startOfFile
" Filename: SmartStatusline.vim

if !exists("g:SmartStatuslineEnabled")
	let g:SmartStatuslineEnabled = 1
endif
if !g:SmartStatuslineEnabled
	finish
endif

" Settings for line length"
let s:long = 100
let s:medium = 75
let s:short = 50

if g:Use_nerdfont
	let s:LtStlSep = ""
	let s:RtStlSep = ""
"	let s:LtSep = ""
"	let s:RtSep = ""
else
	let s:LtStlSep = ""
	let s:RtStlSep = ""
endif

let g:saved_windows = {}

" Statusline color Pallet
let s:CP = {
	\'selected'   : '#005F87', 'T_selected'   :  24,
	\'fg'         : '#b2b2b2', 'T_fg'         : 249,
	\'selectedfg' : '#87AFD7', 'T_selectedfg' : 110,
	\'bg'         : '#252525', 'T_bg'         : 236,
	\'lightBg'    : '#3A3A3A', 'T_lightBg'    : 237,
\}

" Highlight Groups - H.G
" Keys:
" gui:G
" guifg:GFG
" guibg:GBG
" term:T
" termfg:TFG
" termbg:TBG

" Description:
" highlight group - description
"
"  StatusLine        - general color
"  StlMain           - main color for theme
"  StlBranch         - git's branch
"  StlSymbol         - file symbol (or extention)
"  StlSepMain2Branch - seperator for 'Main'       -> 'Branch'
"  StlSepMain2Stl    - seperator for 'Main'       -> 'StatusLine'
"  StlSepSymbol2Main - seperator for 'Symbol'     -> 'Main'
"  StlSepBranch2Stl  - seperator for 'Branch'     -> 'StatusLine'
"  StlSepStl2Symbol  - seperator for 'statusLine' -> 'Symbol'

" StatusLine highlight groups
let s:HG = {}
let s:HG.StatusLine        = { "GFG":s:CP['fg'],               "TFG":s:CP['T_fg'],             "GBG":s:CP['bg'],                "TBG":s:CP['T_bg'] }
let s:HG.StlMain           = { "GFG":s:CP['fg'],               "TFG":s:CP['T_fg'],             "GBG":s:CP['selected'],          "TBG":s:CP['T_selected'] }
let s:HG.StlBranch         = { "GFG":s:CP['selectedfg'],       "TFG":s:CP['T_selectedfg'],     "GBG":s:CP['lightBg'],           "TBG":s:CP['T_lightBg'] }
let s:HG.StlSymbol         = { "GFG":s:CP['selectedfg'],       "TFG":s:CP['T_selectedfg'],     "GBG":s:CP['lightBg'],           "TBG":s:CP['T_lightBg'] }
let s:HG.StlSepStl2Symbol  = { "GFG":s:HG['StlSymbol']["GBG"], "TFG":s:HG['StlSymbol']["TBG"], "GBG":s:CP['bg'],                "TBG":s:CP['T_bg'] }
let s:HG.StlSepSymbol2Main = { "GFG":s:HG['StlSymbol']["GBG"], "TFG":s:HG['StlSymbol']["TBG"], "GBG":s:HG['StlMain']["GBG"],    "TBG":s:HG['StlMain']["TBG"] }
let s:HG.StlSepMain2Branch = { "GFG":s:HG['StlMain']["GBG"],   "TFG":s:HG['StlMain']["TBG"],   "GBG":s:HG['StlBranch']["GBG"],  "TBG":s:HG['StlBranch']["TBG"] }
let s:HG.StlSepMain2Stl    = { "GFG":s:HG['StlMain']["GBG"],   "TFG":s:HG['StlMain']["TBG"],   "GBG":s:HG['StatusLine']["GBG"], "TBG":s:HG['StatusLine']["TBG"] }
let s:HG.StlSepBranch2Stl  = { "GFG":s:HG['StlBranch']["GBG"], "TFG":s:HG['StlBranch']["TBG"], "GBG":s:HG['StatusLine']["GBG"], "TBG":s:HG['StatusLine']["TBG"] }

" highlighting function
function! s:HighlightDict(key, dict)
	if has_key(a:dict, 'T')
		let l:term = a:dict['T']
	else
		let l:term = 'NONE'
	endif
	if has_key(a:dict, 'G')
		let l:gui = a:dict['G']
	else
		let l:gui='NONE'
	endif
	if has_key(a:dict, 'GFG')
		let l:guifg = a:dict['GFG']
	else
		let l:guifg='NONE'
	endif
	if has_key(a:dict, 'GBG')
		let l:guibg = a:dict['GBG']
	else
		let l:guibg='NONE'
	endif
	if has_key(a:dict, 'T')
		let l:cterm = a:dict['T']
	else
		let l:cterm='NONE'
	endif
	if has_key(a:dict, 'TFG')
		let l:ctermfg = a:dict['TFG']
	else
		let l:ctermfg='NONE'
		endif
	if has_key(a:dict, 'TBG')
		let l:ctermbg = a:dict['TBG']
	else
		let l:ctermbg='NONE'
	endif
	if has_key(a:dict, 'GSP')
		let l:guisp = a:dict['GSP']
	else
		let l:guisp='NONE'
	endif
	execute "hi " . a:key . " term=" . l:term . " cterm=" . l:cterm . " gui=" . l:gui . " ctermfg=" . l:ctermfg . " guifg=" . l:guifg . " ctermbg=" . l:ctermbg . " guibg=" . l:guibg . " guisp=" . l:guisp
endfunction

" scan the assignment dict and execute the assignment
for key in keys(s:HG)
	call s:HighlightDict(key, s:HG[key])
endfor

function! s:getGitBranch(win_id) abort
	if exists('g:loaded_fugitive') && (g:saved_windows[a:win_id]['width'] > s:short)
		let l:maybeBranch = g:FugitiveHead()
		if strlen(l:maybeBranch)
			if g:Use_nerdfont
				return "-" .. l:maybeBranch
			else
				return "|-" .. l:maybeBranch
			endif
		endif
	endif
	return ""
endfunction

function! s:getPathSymbol(win_id) abort
	let l:tmp = ""
	let l:path = g:saved_windows[a:win_id]['path']
	if g:saved_windows[a:win_id]['width'] > s:short
		if g:Use_nerdfont
			let l:tmp .= Devicons#GetPathSymbol(l:path, 'in_use')
		else
			let l:tmp .= fnamemodify(l:path, ":e")
		endif
	endif
	return l:tmp
endfunction

function! s:getPath(win_id) abort
	let l:path = g:saved_windows[a:win_id]['path']
	if g:saved_windows[a:win_id]['width'] > s:long
		return l:path " full path

	elseif g:saved_windows[a:win_id]['width'] > s:medium
		return fnamemodify(l:path, ":.") " relative path

	elseif g:saved_windows[a:win_id]['width'] > s:short
		return pathshorten(fnamemodify(l:path, ":."))

	else
		return fnamemodify(l:path, ":t")
	endif
endfunction

function! s:getRightSide(win_id) abort
	let l:symbol = ""
	if g:Use_nerdfont
		let l:symbol = "\ %{Devicons#GetSystemSymbol()}"
	else
		let l:symbol = "\ %{&fileformat}"
	endif
	if g:saved_windows[a:win_id]['width'] > s:long
		return l:symbol .. "%m%r%w\ b:%n\ "

	elseif g:saved_windows[a:win_id]['width'] > s:medium
		return "%m%r%w\ b:%n\ "

	elseif g:saved_windows[a:win_id]['width'] > s:short
		return "%M%R%W\ b:%n\ "

	else
		return "%M%R%W\ b:%n"
	endif
endfunction

function! s:getLeftSide(win_id) abort
	if g:saved_windows[a:win_id]['width'] > s:long
		return "%p%%\ %l,%c\ 0x%04b\ "

	elseif g:saved_windows[a:win_id]['width'] > s:medium
		return "%p%%\ %l,%c\ "

	elseif g:saved_windows[a:win_id]['width'] > s:short
		return "\ %l,%c\ "
	else
		return "%l,%c\ "
	endif
endfunction

function! s:generateStatusline(win_id, mode)
	let l:tmp = ""
	let l:symbol = s:getPathSymbol(a:win_id)
	if a:mode == 'active'
		let l:tmp .= "%#StlMain#"
		let l:tmp .=  s:getRightSide(a:win_id)

		if strlen(s:getGitBranch(a:win_id)) " if you are in a git branch:
			let l:tmp .= "%#StlSepMain2Branch#" .. s:LtStlSep " seperator
			let l:tmp .= "%#StlBranch#"
			let l:tmp .= s:getGitBranch(a:win_id)
			let l:tmp .= "%#StlSepBranch2Stl#" .. s:LtStlSep " seperator
		else
			let l:tmp .= "%#StlSepMain2Stl#" .. s:LtStlSep " seperator
		endif

		let l:tmp .= "%#statusline#"
		let l:tmp .= "%<"
		let l:tmp .= "\ " .. s:getPath(a:win_id)
		let l:tmp .= "%="

		if strlen(l:symbol) " if recognized
			let l:tmp .= "%#StlSepStl2Symbol#" .. s:RtStlSep " seperator
			let l:tmp .= "%#StlSymbol#"
			let l:tmp .= l:symbol .. "\ "
			let l:tmp .= "%#StlSepSymbol2Main#" .. s:LtStlSep " seperator
		else
			let l:tmp .= "%#StlSepMain2Stl#" .. s:RtStlSep " seperator
		endif

		let l:tmp .= "%#StlMain#"
		let l:tmp .=  s:getLeftSide(a:win_id)

	elseif a:mode == 'inactive'

		let l:tmp .= "%#statuslineNC#"
		let l:tmp .=  s:getRightSide(a:win_id)
		let l:tmp .= "\ "
		let l:tmp .= s:getGitBranch(a:win_id)
		let l:tmp .= "\ \│\ "
		let l:tmp .= "%<"
		let l:tmp .= s:getPath(a:win_id)
		let l:tmp .= "%=\ "
		let l:tmp .= l:symbol
		let l:tmp .= "\ \│\ "
		let l:tmp .=  s:getLeftSide(a:win_id)
	endif
	return l:tmp
endfunction

function! s:not_to_set(win_id)
	return win_gettype(a:win_id) ==# 'popup' || win_gettype(a:win_id) ==# 'autocmd'
endfunction

function! s:update_saved_windows() abort
	if exists("g:saved_windows") | unlet g:saved_windows | let g:saved_windows = {} | endif
	let l:last_window_nr = winnr('$')
	for l:window_nr in range(1, l:last_window_nr)
		if g:SmartStatuslineEnabled
			let l:win_id = win_getid(l:window_nr)
			let l:tmpwin = getwininfo(l:win_id)[0]
			let l:tmpbuf = getbufinfo(bufname(l:tmpwin['bufnr']))[0]
			let g:saved_windows[l:win_id] = l:tmpwin

			if getbufvar(l:tmpwin['bufnr'], "&filetype") == "netrw"
				let g:saved_windows[l:win_id]['path'] = l:tmpwin['variables']['netrw_rexdir']
			else
				let g:saved_windows[l:win_id]['path'] = l:tmpbuf['name']
			endif
		endif
	endfor
endfunction

function! SmartStatusline#Update()
	let l:curr_window_nr = winnr()
	let l:last_window_nr = winnr('$')
	if s:not_to_set(l:curr_window_nr) | return | endif
	call s:update_saved_windows()

	for l:window_nr in range(1, l:last_window_nr)
		if g:SmartStatuslineEnabled
			let l:state = (l:window_nr == l:curr_window_nr)? 'active' : 'inactive'
			let l:tmp = s:generateStatusline(win_getid(l:window_nr), l:state)
			call setwinvar(l:window_nr, '&statusline', l:tmp)
		else
			call setwinvar(l:window_nr, '&statusline', '')
		endif
	endfor
endfunction

function! SmartStatusline#Enable()
	if !g:SmartStatuslineEnabled
		let g:SmartStatuslineEnabled = 1
	endif
	" Create Update Events:
	augroup statusLine
		autocmd!
		" TODO: fix window stops being 'active' after insert mode
		autocmd VimResized   * call SmartStatusline#Update()
		autocmd InsertEnter  * call SmartStatusline#Update()
		autocmd InsertLeave  * call SmartStatusline#Update()

		autocmd WinNew       * call SmartStatusline#Update()
		autocmd BufWipeout   * call SmartStatusline#Update()
		autocmd WinEnter     * call SmartStatusline#Update()
		autocmd WinLeave     * call SmartStatusline#Update()
		autocmd BufWinEnter  * call SmartStatusline#Update()
		autocmd BufWinLeave  * call SmartStatusline#Update()

		autocmd BufNew       * call SmartStatusline#Update()
		autocmd BufCreate    * call SmartStatusline#Update()
		autocmd BufEnter     * call SmartStatusline#Update()
		autocmd BufDelete    * call SmartStatusline#Update()
	augroup END

	" Do First Update:
	call SmartStatusline#Update()
endfunction

function! SmartStatusline#Disable()
	if g:SmartStatuslineEnabled
		let g:SmartStatuslineEnabled = 0
		" Delete Update Events:
		augroup! statusLine
		" Clear &statusline:
		call SmartStatusline#Update()
	endif
endfunction

" Start plugin
if g:SmartStatuslineEnabled
	call SmartStatusline#Enable()
endif
"endOfFile
