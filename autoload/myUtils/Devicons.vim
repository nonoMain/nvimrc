"startOfFile
" Filename: Devicons.vim

"if exists("g:Use_nerdfont") && !g:Use_nerdfont
"	finish
"endif

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
	\'.profile'          : '',
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

function! s:dirToSymbol(inUse)
	if (a:inUse == 1)
		return s:dirTypeSymbols['open']
	else
		return s:dirTypeSymbols['closed']
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
	return s:fileExtentionsToSymbols['txt']
endfunction

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

function! myUtils#Devicons#GetSystemSymbol()
	let format = ''
	if has('unix')
		let format = s:getDistro()
	elseif has('win32')
		let format = ''
	elseif has('macunix')
		let format = ''
	endif
	return format
endfunction

function! myUtils#Devicons#GetPathSymbol(fullPath, inUse)
	let l:symbol = ''
	if isdirectory(a:fullPath)
		let l:symbol = s:dirToSymbol(a:inUse)
	else
		let l:symbol = s:fileToSymbol(a:fullPath)
	endif
	return l:symbol
endfunction


function! myUtils#Devicons#ColorFileType(givenFileType)
	let colors = keys(g:devicons_color_icons_dict)
	augroup devicons_colors
		autocmd!
		for color in colors
			exec 'autocmd FileType ' . a:givenFileType . ' highlight devicons_'.color.' guifg='.g:devicons_colorpallet[color][s:gui_idx].' ctermfg='.g:devicons_colorpallet[color][s:term_idx]
			exec 'autocmd FileType ' . a:givenFileType . ' syntax match devicons_'.color.' /\v'.join(g:devicons_color_icons_dict[color], '|').'/ containedin=ALL'
		endfor
	augroup END
endfunction


"endOfFile
