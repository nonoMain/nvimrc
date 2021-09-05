"startOfFile
" Filename: Devicons.vim

if !exists("g:Use_nerdfont")
	let g:Use_nerdfont = 0
elseif !g:Use_nerdfont
	finish
endif

if !(exists("g:Use_devicons_colors"))
	let g:Use_devicons_colors = 0
endif

let s:gui_idx = 0 | let s:term_idx = 1
function s:getDistro()
	if exists('s:distroSymbol')
	return s:distroSymbol
	endif

	" Default distro symbol
	let s:distroSymbol = ''

	if executable('lsb_release')
		let l:release = system('lsb_release -i')
		if l:release =~# 'Ubuntu'
			let s:distroSymbol = ''
		elseif l:release =~# 'Debian'
			let s:distroSymbol = ''
		elseif l:release =~# 'Arch'
			let s:distroSymbol = ''
		elseif l:release =~# 'Gentoo'
			let s:distroSymbol = ''
		elseif l:release =~# 'Cent'
			let s:distroSymbol = ''
		elseif l:release =~# 'Dock'
			let s:distroSymbol = ''
		else
			let s:distroSymbol = ''
		endif
	endif
	return s:distroSymbol
endfunction

let s:fileExtentionsToSymbols = {
	\'ai'          : '',
	\'awk'         : '',
	\'bash'        : '',
	\'bat'         : '',
	\'bmp'         : '',
	\'c'           : '',
	\'c++'         : '',
	\'cc'          : '',
	\'clj'         : '',
	\'cljc'        : '',
	\'cljs'        : '',
	\'coffee'      : '',
	\'conf'        : '',
	\'cp'          : '',
	\'cpp'         : '',
	\'cs'          : '',
	\'csh'         : '',
	\'css'         : '',
	\'cxx'         : '',
	\'d'           : '',
	\'dart'        : '',
	\'db'          : '',
	\'diff'        : '',
	\'dump'        : '',
	\'edn'         : '',
	\'eex'         : '',
	\'ejs'         : '',
	\'elm'         : '',
	\'erl'         : '',
	\'ex'          : '',
	\'exs'         : '',
	\'f#'          : '',
	\'fish'        : '',
	\'fs'          : '',
	\'fsi'         : '',
	\'fsscript'    : '',
	\'fsx'         : '',
	\'gemspec'     : '',
	\'gif'         : '',
	\'go'          : '',
	\'h'           : '',
	\'haml'        : '',
	\'hbs'         : '',
	\'hh'          : '',
	\'hpp'         : '',
	\'hrl'         : '',
	\'hs'          : '',
	\'htm'         : '',
	\'html'        : '',
	\'hxx'         : '',
	\'ico'         : '',
	\'ini'         : '',
	\'java'        : '',
	\'jl'          : '',
	\'jpeg'        : '',
	\'jpg'         : '',
	\'js'          : '',
	\'json'        : '',
	\'jsx'         : '',
	\'ksh'         : '',
	\'leex'        : '',
	\'less'        : '',
	\'lhs'         : '',
	\'lua'         : '',
	\'markdown'    : '',
	\'md'          : '',
	\'mdx'         : '',
	\'mjs'         : '',
	\'mk'          : '',
	\'ml'          : 'λ',
	\'mli'         : 'λ',
	\'mustache'    : '',
	\'nix'         : '',
	\'php'         : '',
	\'pl'          : '',
	\'pm'          : '',
	\'png'         : '',
	\'pp'          : '',
	\'ps1'         : '',
	\'psb'         : '',
	\'psd'         : '',
	\'py'          : '',
	\'pyc'         : '',
	\'pyd'         : '',
	\'pyo'         : '',
	\'r'           : 'ﳒ',
	\'rake'        : '',
	\'rb'          : '',
	\'rlib'        : '',
	\'rmd'         : '',
	\'rproj'       : '鉶',
	\'rs'          : '',
	\'rss'         : '',
	\'sass'        : '',
	\'scala'       : '',
	\'scss'        : '',
	\'sh'          : '',
	\'slim'        : '',
	\'sln'         : '',
	\'sol'         : 'ﲹ',
	\'sql'         : '',
	\'styl'        : '',
	\'suo'         : '',
	\'swift'       : '',
	\'t'           : '',
	\'tex'         : 'ﭨ',
	\'toml'        : '',
	\'ts'          : '',
	\'tsx'         : '',
	\'twig'        : '',
	\'txt'         : '',
	\'vim'         : '',
	\'vue'         : '﵂',
	\'webmanifest' : '',
	\'webp'        : '',
	\'xcplayground': '',
	\'xul'         : '',
	\'yaml'        : '',
	\'yml'         : '',
	\'zsh'         : '',
	\'exe'         : '省',
	\'bin'         : '省',
\}

let s:specificFilesToSymbols = {
	\'bash'              : '',
	\'.bashprofile'      : '',
	\'.bashrc'           : '',
	\'cmakelists.txt'    : '',
	\'docker-compose.yml': '',
	\'dockerfile'        : '',
	\'dropbox'           : '',
	\'.ds_store'         : '',
	\'gemfile'           : '',
	\'.gitattributes'    : '',
	\'.gitconfig'        : '',
	\'.gitignore'        : '',
	\'.gitlab-ci.yml'    : '',
	\'gruntfile.coffee'  : '',
	\'gruntfile.js'      : '',
	\'gruntfile.ls'      : '',
	\'gulpfile.coffee'   : '',
	\'gulpfile.js'       : '',
	\'gulpfile.ls'       : '',
	\'.gvimrc'           : '',
	\'_gvimrc'           : '',
	\'license'           : '',
	\'license.md'        : '',
	\'license.markdown'  : '',
	\'makefile'          : '',
	\'mix.lock'          : '',
	\'node_modules'      : '',
	\'procfile'          : '',
	\'rakefile'          : '',
	\'react.jsx'         : '',
	\'.vimrc'            : '',
	\'_vimrc'            : '',
	\'.zprofile'         : '',
	\'.zshenv'           : '',
	\'.zshrc'            : '',
\}

let s:dirTypeSymbols = {
	\'open'   : '',
	\'closed' : '',
	\'linked' : '',
\}

function! DeviconsColors(config)
	let colors = keys(a:config)
	augroup devicons_colors
		autocmd!
		for color in colors
			exec 'autocmd FileType filebroswer highlight devicons_'.color.' guifg='.g:devicons_colorpallet[color][s:gui_idx].' ctermfg='.g:devicons_colorpallet[color][s:term_idx]
			exec 'autocmd FileType filebroswer syntax match devicons_'.color.' /\v'.join(a:config[color], '|').'/ containedin=ALL'
		endfor
	augroup END
endfunction

function! s:dirToSymbol(mode)
	if (a:mode == 'in_use')
		return s:dirTypeSymbols['open']
	elseif (a:mode == 'view')
		return s:dirTypeSymbols['closed']
	else
		return dirTypeSymbols['linked']
	endif
endfunction

function! s:fileToSymbol(path)
	let l:file = fnamemodify(a:path, ":t")
	let l:fileExtention = fnamemodify(l:file, ":e")
	for key in keys(s:specificFilesToSymbols)
		if tolower(key) == tolower(l:file)
			return s:specificFilesToSymbols[key]
		endif
	endfor
	for key in keys(s:fileExtentionsToSymbols)
		if key == l:fileExtention
			return s:fileExtentionsToSymbols[key]
		endif
	endfor
	return l:fileExtention
endfunction

function! Devicons#GetSystemSymbol()
	let format = ''
	if &fileformat ==? 'unix'
		let format = s:getDistro()
	elseif &fileformat ==? 'dos'
		let format = ''
	elseif &fileformat ==? 'mac' || has('macunix')
		let format = ''
	endif
	return format
endfunction

function! Devicons#GetPathSymbol(fullPath, mode)
	let l:symbol = ''
	if isdirectory(a:fullPath)
		let l:symbol = s:dirToSymbol(a:mode)
	else
		let l:symbol = s:fileToSymbol(a:fullPath)
	endif
	return l:symbol
endfunction

if g:Use_devicons_colors
	let g:devicons_colorpallet = {
		\'brown'       : ['#875F5F',  95],
		\'aqua'        : ['#5FFFD7',  86],
		\'blue'        : ['#005f87',  24],
		\'darkBlue'    : ['#005fd7',  26],
		\'purple'      : ['#875F87',  96],
		\'red'         : ['#af0000', 124],
		\'yellow'      : ['#FFD700', 220],
		\'orange'      : ['#FFAF5F', 215],
		\'pink'        : ['#FF5F87', 204],
		\'salmon'      : ['#D75F5F', 167],
		\'green'       : ['#87AF5F', 107],
		\'lightGreen'  : ['#5FAF5F',  71],
		\'grey'        : ['#b2b2b2', 249],
		\'white'       : ['#FFFFFF', 231],
	\}

	let g:devicons_color_icons_dict = {
	\'brown':[''],
	\'aqua':[''],
	\'blue':['', '', '', '', '', '', '', '', '', '', '', ''],
	\'darkBlue':['', '', '', '', ''],
	\'purple':['', '', '', '', '', '', ''],
	\'red':['', '', '', ''],
	\'yellow':[''],
	\'orange':['', '', '', '', '', '', '', '', '', 'λ', '', '', '', ''],
	\'pink':['', ''],
	\'salmon':['', ''],
	\'green':['', '', '', '', '', '', '', ''],
	\'lightGreen':['﵂'],
	\'grey':['', '', '', ''],
	\'white':['', '', '', ''],
	\}

	call DeviconsColors(g:devicons_color_icons_dict)
endif

"endOfFile
