"startOfFile
" Filename: devicons.vim

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
	\'bat'         : '',
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
	\'vim'         : '',
	\'vue'         : '﵂',
	\'webmanifest' : '',
	\'webp'        : '',
	\'xcplayground': '',
	\'xul'         : '',
	\'yaml'        : '',
	\'yml'         : '',
	\'zsh'         : '',
\}

let s:specificFilesToSymbols = {
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
	\'License'           : '',
	\'LICENSE'           : '',
	\'makefile'          : '',
	\'Makefile'          : '',
	\'MAKEFILE'          : '',
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
	let l:default = ''
	let l:file = fnamemodify(a:path, ":t")
	let l:fileExtention = fnamemodify(l:file, ":e")
	for key in keys(s:fileExtentionsToSymbols)
		if key == l:fileExtention
			return s:fileExtentionsToSymbols[key]
		endif
	endfor
	for key in keys(s:specificFilesToSymbols)
		if key == l:file
			return s:specificFilesToSymbols[key]
		endif
	endfor
	return l:default
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
	elseif filereadable(a:fullPath)
		let l:symbol = s:fileToSymbol(a:fullPath)
	endif
	return l:symbol
endfunction

"endOfFile
