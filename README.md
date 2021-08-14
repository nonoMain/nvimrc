//startOfFile

# NVIMRC V1.2.9

## Authors
--------------------------------------------------------------------------------

* [nonoMain](https://github.com/nonoMain) - Noam Daniel Elihu

## Description
--------------------------------------------------------------------------------

My (Programmer) configiration for [Neovim](https://github.com/neovim/neovim), including my scripts and colorscheme.

1. Using external parser (better imo)
2. Auto completion from many sources (e.g buffer, Language-server, Parser, paths)
3. Language-servers integration using built in nvim-lspconfig
4. Git commands and management from inside the editor
5. Easy to modify [colorscheme](./colors/cplex.vim)
6. Fast general [mappings](./configs/general-vim-config/keybindings.vim)

and other usefull tweaks.

Tested on:
- [x] Linux
- [ ] Windows - soon
- [ ] Mac - less soon

## Notes
--------------------------------------------------------------------------------

* First and foremost this configiration was made for my use so it may not be 'right' for you,
I deeply encourage any one that uses vim to customize it for themselves
and for their type of use (as I mentioned, for me it is mainly programming)

* This config has been tested so far on linux (and on windows with little changes)
and is planned to work in a manner that most systems and terminal emulators will
run well.

## Configiration layout
--------------------------------------------------------------------------------
```
nvim/
|- init.vim                 F-> File that initializes the editor's settings
|- plugins.vim              F-> Specifies the plugins that need to be installed or loaded (for the plugin manager)
|- README.md                F-> You'r here, the general data about the configiration
|- FILEGUIDE.md             F-> Specifies complicated file arrangements (i.e duplicates for different OS etc)
|- after/                   D-> Overrule or add to the system-wide configiration
|  |- ftplugin/             D-> File type specific configiration
|- autoload/                D-> Place to put scripts that will load automatically and can be accessed from anywhere
|  |- plug.vim              F-> The plugin manager (vim-plug)
|  |- plugged/              D-> All the installed plugins are here
|  |  |- nvim-compe/        |
|  |  |- nvim-lspconfig/    |
|  |  |- nvim-treesitter/   |
|  |  |- playground/        |
|  |  |- vim-fugitive/      |
|  |  |- vim-hexokinase/    |
|  |  |- vim-repeat/        |
|  |  |- vim-surround/      |
|- colors/                  D-> Colorschemes
|- configs/                 D-> All the configirations
|  |- general-vim-config/   |
|  |- lsp-servers-configs/  |
|  |- plugins-configs/      |
|- releated/                D-> Files for editor releated things (e.g Language-server wrappers)
|- scripts/                 D-> External scripts used by the editor or the user
```

## Requirements
--------------------------------------------------------------------------------

### The requirements for the configiration

* Neovim [nightly](https://github.com/neovim/neovim/releases/nightly)
* [Git](https://git-scm.com/downloads)
* [Node](https://nodejs.org/en/download/)
* [Python2 & Python3](https://www.python.org/)
* C-compiler (e.g [gcc](https://gcc.gnu.org/install/download.html))
* Go language - either [binaries](https://golang.org/dl/) **or** using a package manager

### Recommended for more options:
* [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/tree/master/cli)

## Plugins
--------------------------------------------------------------------------------

Plugin manager is [vim-plug](https://github.com/junegunn/vim-plug)

* [nvim-compe](https://github.com/hrsh7th/nvim-compe/)
Auto completion for neovim
> Works well and doesn't come with more features then necessary

* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/)
Neovim built in language server protocol manager
> For running code actions, code diagonstics and smart auto completion
> + it's built in so it's the most trusted on terms of support or maintenance

* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/)
Better (and faster) text parser
> faster, well equipped and good for creating scripts (refactoring, definition tamplates, etc..) for complex code
* [treesitter-playground](https://github.com/nvim-treesitter/playground/)
> Allowes you to view the 'behind the scenes' of tree-sitter directly in neovim

* [vim-fugitive](https://github.com/tpope/vim-fugitive/)
Makes Git a seamless part of the vim workflow
> "Fugitive is the premier Vim plugin for Git. Or maybe it's the premier Git plugin for Vim? Either way, it's 'so awesome, it should be illegal'. That's why it's called Fugitive." - From it's README.markdown

* [vim-surround](https://github.com/tpope/vim-surround/)
The best way imo to manage surrounded text, which is essential for code editing
> Well integrated into vim's text actions and saves a lot of time

* [vim-repeat](https://github.com/tpope/vim-repeat/)
Enables using the `.` for repeating a plugin map
> "Repeat.vim remaps `.` in a way that plugins can tap into it." - From it's README.markdown

* [vim-hexokinase](https://github.com/RRethy/vim-hexokinase/)
Preview colors by coloring their value in their color (e.g #ffffff will be displyed in white)
> A true life saver when working on front-end color tables or any other place where coloring by rgb/hex/hsl values

## Language-servers
--------------------------------------------------------------------------------

* [ccls](https://github.com/MaskRay/ccls) - C/Cpp/Objc/Objcpp language server - [config](./configs/lsp-servers-configs/c_lsconfig.lua)
> C 'family' ls

* [pyright](https://github.com/microsoft/pyright) - Python language server - [config](./configs/lsp-servers-configs/python_lsconfig.lua)
> Microsoft's python ls

* [jdtls](https://github.com/eclipse/eclipse.jdt.ls) - Java language server - [config](./configs/lsp-servers-configs/java_lsconfig.lua)
> Eclipse's ls, many say that it is hard to configure but it's the best out there so for that you have the jdtls.sh wrapper

* [vimls](https://github.com/iamcco/vim-language-server) - Vim script language server - [config](./configs/lsp-servers-configs/vim_lsconfig.lua)
> Usefull to have if your customizing your vim

* [sumneko_lua](https://github.com/sumneko/lua-language-server) - Lua language server - [config](./configs/lsp-servers-configs/lua_lsconfig.lua)
> Helped me control the scripts i saw without knowing the language

## Colorscheme pics
--------------------------------------------------------------------------------
![](https://github.com/nonoMain/nvimrc/blob/master/pictures/cplex_dark_bg.png?raw=true "dark background")
![](https://github.com/nonoMain/nvimrc/blob/master/pictures/cplex_clear_bg.png?raw=true "clear background")

//endOfFile
