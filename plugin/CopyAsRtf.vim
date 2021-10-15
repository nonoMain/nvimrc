"startOfFile
" Filename: CopyAsRtf.vim
" Description: copies visual selection as RTF (rich text format)

if !exists("g:CopyAsRtfEnabled")
	let g:CopyAsRtfEnabled = 0
endif
if !g:CopyAsRtfEnabled
	finish
endif
