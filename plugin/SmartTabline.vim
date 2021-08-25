"startOfFile
" Filename: SmartTabline.vim

if !exists("g:SmartTablineEnabled")
	let g:SmartTablineEnabled = 1
elseif !g:SmartTablineEnabled
	finish
endif

if g:Use_nerdfont
	let s:LtSep = ""
	let s:RtSep = ""
"	let s:LtSep = ""
"	let s:RtSep = ""
else
	let s:LtSep = "|"
	let s:RtSep = "|"
endif

" Tabline color Pallet
let s:CP = {
	\'selected'   : '#005F87', 'T_selected':  24,
	\'symbolFg'   : '#87AFD7', 'T_symbolFg': 110,
	\'fg'         : '#b2b2b2', 'T_fg'      : 249,
	\'bg'         : '#252525', 'T_bg'      : 236,
	\'darkBg'     : '#1C1C1C', 'T_darkBg'  : 234,
	\'special'    : '#AF5F87', 'T_special' : 132,
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


" StatusLine highlight groups
let s:HG = {}
let s:HG.TabLineSel     = { "GFG":s:CP.fg,       "TFG":s:CP.T_fg,        "GBG":s:CP.selected,"TBG":s:CP.T_selected }
let s:HG.TabLine        = { "GFG":s:CP.fg,       "TFG":s:CP.T_fg,        "GBG":s:CP.bg,      "TBG":s:CP.T_bg }
let s:HG.TabSymbol      = { "GFG":s:CP.symbolFg, "TFG":s:CP.T_symbolFg,  "GBG":s:CP.bg,      "TBG":s:CP.T_bg }
let s:HG.TabSpecial     = { "GFG":s:CP.special,  "TFG":s:CP.T_special,   "GBG":s:CP.bg,      "TBG":s:CP.T_bg }
let s:HG.TabLineFill    = { "GBG":s:CP.darkBg,   "TBG":s:CP.T_darkBg }
let s:HG.TabSepSel2Fill = { "GFG":s:CP.selected, "TFG":s:CP.T_selected,  "GBG":s:CP.darkBg,  "TBG":s:CP.T_darkBg }
let s:HG.TabSepReg2Fill = { "GFG":s:CP.bg,       "TFG":s:CP.T_bg,        "GBG":s:CP.darkBg,  "TBG":s:CP.T_darkBg }

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

function! GenerateTabline()
	let l:tmp = ""
	if tabpagenr('$') == 1
		let l:tmp .= s:generateTablable(1, 'active')
	else
		for tabNr in range(tabpagenr('$'))
			if tabNr + 1 == tabpagenr()
				let l:tmp .= s:generateTablable(tabNr + 1, 'active')
			else
				let l:tmp .= s:generateTablable(tabNr + 1, 'inactive')
			endif
		endfor
	endif
	let l:tmp .= '%#TabLineFill#%T'
	if tabpagenr('$') > 1
		let l:tmp .= (g:Use_nerdfont)? "%=%#TabLine#\ \ " : "%=%#TabLine#\ X\ "
	endif
	return l:tmp
endfunction

function! s:getFullPath(tabNr)
	let buflist = tabpagebuflist(a:tabNr)
	let winnr = tabpagewinnr(a:tabNr)
	return bufname(buflist[winnr - 1])
endfunction

function! s:getTabStatus(tabNr)
	let l:tmp = ""
	let l:mod = 0
	let buflist = tabpagebuflist(a:tabNr)
	for buf in buflist
		if getbufvar(buf, "&buftype") == 'help'
			let l:tmp .= '[H]' . fnamemodify(bufname(buf), ':t:s/.txt$//')
		elseif getbufvar(buf, "&buftype") == 'quickfix'
			let l:tmp .= '[Q]'
		endif
		if getbufvar(buf, "&modified")
			let l:mod += 1
		endif
	endfor
	if l:mod > 0
		let l:tmp .= " +" .. string(l:mod)
	endif
	return l:tmp
endfunction

function! s:generateTablable(tabNr, mode)
	let l:tmp = ""
	let l:path = s:getFullPath(a:tabNr)

	if exists('g:Use_nerdfont') && g:Use_nerdfont
		let l:symbol = Devicons#GetPathSymbol(l:path, 'in_use')
	else
		let l:symbol = ""
	endif

	if a:mode == 'active'
		let l:tmp .= "%>"
		let l:tmp .= "%#TabSepSel2Fill#" .. s:RtSep
		let l:tmp .= "%#TabLineSel#"
		let l:tmp .= "\ "
		let l:tmp .= l:symbol
		let l:tmp .= "\ "
		let l:tmp .= pathshorten(l:path)
		let l:tmp .= "\ "
		let l:tmp .= s:getTabStatus(a:tabNr)
		let l:tmp .= "%#TabSepSel2Fill#" .. s:LtSep
		let l:tmp .= "%<"

	elseif a:mode == 'inactive'
		let l:tmp .= "%#TabSepReg2Fill#" .. s:RtSep
		let l:tmp .= "%#TabLine#"
		let l:tmp .= "\ "
		let l:tmp .= "%#TabSymbol#"
		let l:tmp .= l:symbol
		let l:tmp .= "%#TabLine#"
		let l:tmp .= "\ "
		let l:tmp .= pathshorten(l:path)
"		add for number of open windows in each tab
"		let l:tmp .= "(" .. tabpagewinnr(a:tabNr, '$') .. ")"
		let l:tmp .= "%#TabSpecial#"
		let l:tmp .= s:getTabStatus(a:tabNr)
		let l:tmp .= "\ "
		let l:tmp .= "%#TabSymbol#"
		let l:tmp .= "●"
		let l:tmp .= "%#TabSepReg2Fill#" .. s:LtSep
	endif
	return l:tmp
endfunction

if g:SmartTablineEnabled
	set tabline=%!GenerateTabline()
endif

"endOfFile
