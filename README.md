//startOfFile

# NVIMRC V1.7

## Author
* [nonoMain](https://github.com/nonoMain) - Noam Daniel Eliyahu

## Description
--------------------------------------------------------------------------------

My (Programmer) configuration for [Neovim](https://github.com/neovim/neovim/).

1. Auto completion
2. Language-servers integration using built in nvim-lspconfig and and [install script](./releated/setup_lang_servers.sh)
3. Git management from inside the editor
4. Using the tree-sitter parser (better IMO)
5. [cplex colorscheme](./colors/cplex.vim) | [link to vim colors schemes](https://vimcolorschemes.com/nonomain/nvimrc)
6. Usefull & Light [scripts](./plugin)
	+ [x] File history browser
	+ [x] Status line
	+ [x] Tab line
	+ [x] Devicons (that are easy to configure)
	+ [x] Window maximizer

and of course some other settings mappings and tweaks that help me code faster.

Tested on:
+ [x] Linux
+ [x] Windows (install script not available in batch yet)
- [ ] Mac - not soon

## Notes
--------------------------------------------------------------------------------

* First and foremost this configuration was made for my use so it may not be 'the right one' for you,
I deeply encourage any one that uses vim to customize it for themselves
and for their type of use (as I mentioned, for me it is mainly programming)

* This configuration has been tested so far on Linux and on windows (windows needs a bit more tweaking to get it just right)
and is planned to work in a manner that most systems and terminal emulators will
run well.

* There are a lot of parts in this configuration that need things to go right and be installed (compilers, Language-servers, etc)
so for that reason everything used here comes with links for the original pages
(didn't included them because they'd bloat the repo and won't be up to date)

* All the paths for thins such as servers and files outside of the configuration are in the [globals](./globals.vim)
so set them for your paths

## Requirements
--------------------------------------------------------------------------------

### The requirements for the configuration

* [Neovim v0.5+](https://github.com/neovim/neovim/releases/)
* [Git](https://git-scm.com/downloads/)
* [Python3](https://www.python.org/)
> for windows users I recommend getting [MinGW](https://www.mingw-w64.org/) because it comes with make and gcc
* [Make](https://www.gnu.org/software/make/) - for installing certain plugins (also helps with building projects in general)
* C-compiler (e.g [gcc](https://gcc.gnu.org/install/download.html)) with libstdc++ installed! **(windows users!)**
* [Go language](https://golang.org/dl/) - for the color formats coloring plugin (if your not gonna work with color formats you'd be better just remove 'vim-hexokinase' plugin and forget about this one)

### Recommended:
* [nerd font](https://www.nerdfonts.com/) supported terminal (I use 'Hack Nerd Font')
> If you want to use it set `let g:Use_nerdfonts = ?` to 1 and if not then to 0 in [init.vim](./init.vim)
* [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/tree/master/cli/)
> More options with the tree-sitter parser

## Repo layout
--------------------------------------------------------------------------------
```
Flags:
(a) - automatically runs (Doesn't need to get sourced to init)
(s) - does need to be sourced to init
(n) - doesnt releated to the editor directly (or at all)
(.) - same as the one above it

nvim/
|- init.vim                 F(a) File that initializes the editor's behavior
|- plugins.vim              F(s) Specifies the plugins that need to be installed or loaded and configured (for the plugin manager)
|- README.md                F(n) You'r here, inforamtion about this repo
|- after/                   D(a) Overrule or add to the system-wide configuration
|  |- ftplugin/             D(a) File type specific configuration
|- autoload/                D(a) Place to put scripts that will load automatically and can be accessed from anywhere
|  |- plug.vim              F(.) The plugin manager (vim-plug)
|  |- plugged/              D(.) All the installed plugins are here
|  |- myUtils/              D(.) My utils for the configuration (e.g Devicons, lspinfo, coloring, ..)
|- colors/                  D(a) Colorschemes
|- |- cplex.vim             F(.) my colorscheme (feel free to suggest your own!)
|- configs/                 D(s) All the configurations for non-native things
|  |- lsp-servers/          F(.) Lsp-servers configuration
|  |- plugins/              F(.) Plugins configurations
|- releated/                D(n) Files for editor releated things (e.g Language-servers's setup script and file for generating your own highlight lists)
|- plugin/                  D(a) External scripts used by the editor or the user
|  |- sets.vim              F(.) All the 'set ..' command so the main settings for vim
|  |- mappings.vim          F(.) Most of the mappings (if you don't see here a mapping you look for then check inside the specific plugin's config)
```

## Plugins
--------------------------------------------------------------------------------

Plugin manager is [vim-plug](https://github.com/junegunn/vim-plug)

1. [nvim-cmp](https://github.com/hrsh7th/nvim-cmp/)
Lua plugin for auto completions 
> if your moving from nvim-compe to nvim-cmp beware that now everything is in its own plugin now so...
+ [cmp-buffer](https://github.com/hrsh7th/cmp-buffer/) - nvim-cmp buffer completions
+ [cmp-path](https://github.com/hrsh7th/cmp-path/) - cmp-path path completions
+ [cmp-spell](https://github.com/f3fora/cmp-spell/) - vim's spell completions
+ [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp/) - nvim-lsp lsp completions
+ [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua/) - nvim-lua lua's api completions
+ [cmp-nvim-ultisnips](https://github.com/quangnguyen30192/cmp-nvim-ultisnips/) - nvim-ultisnips snippets completions
+ [lspkind-nvim](https://github.com/hrsh7th/lspkind-nvim/) - lsp types
Auto completion for neovim
> Works well and doesn't come with more features then necessary

2. [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/)
Neovim built in language server protocol manager
> For running code actions, code diagonstics and smart auto completion
> it's built in so it's the most trusted on terms of support or maintenance

3. [ultisnips](https://github.com/SirVer/ultisnips.git)
Snippets
> If you want a lot of snippets take a look at [vim-snippets](https://github.com/honza/vim-snippets.git)

4. [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/)
Better (and faster) text parser
> faster, well equipped and good for creating scripts (refactoring, definition tamplates, etc..) for complex code
5. [treesitter-playground](https://github.com/nvim-treesitter/playground/)
> Allowes you to view the 'behind the scenes' of tree-sitter directly in neovim

6. [vim-fugitive](https://github.com/tpope/vim-fugitive/)
Makes Git a seamless part of the vim workflow
> "Fugitive is the premier Vim plugin for Git. Or maybe it's the premier Git plugin for Vim? Either way, it's 'so awesome, it should be illegal'. That's why it's called Fugitive." - From it's README.markdown

7. [vim-gitgutter](https://github.com/airblade/vim-gitgutter/)
Git's diff displayer
> Gotta see what changed while changing some more

8. [vim-surround](https://github.com/tpope/vim-surround/)
The best way imo to manage surrounded text, which is essential for code editing
> Well integrated into vim's text actions and saves a lot of time

9. [vim-repeat](https://github.com/tpope/vim-repeat/)
Enables using the `.` for repeating a plugin map
> "Repeat.vim remaps `.` in a way that plugins can tap into it." - From it's README.markdown

10. [vim-hexokinase](https://github.com/RRethy/vim-hexokinase/)
Preview colors by coloring their value in their color [e.g #ffffff will be displyed in white (also the word white will be displyed in white]
> A true life saver when working on front-end color tables or any other place where coloring by rgb/hex/hsl values

## Language-servers
--------------------------------------------------------------------------------

All the language-servers installing is inside [setup_lang_servers](./releated/setup_lang_servers.sh) script

* [clangd](https://github.com/clangd/clangd) - C/Cpp/Objc/Objcpp language server - [config](./configs/lsp-servers/c_lsconfig.lua)
> C 'family' ls

* [pyright](https://github.com/microsoft/pyright) - Python language server - [config](./configs/lsp-servers/python_lsconfig.lua)
> Microsoft's python ls

* [eclipse-jdt-ls](https://github.com/eclipse/eclipse.jdt.ls) - Java language server - [config](./configs/lsp-servers/java_lsconfig.lua)
> Eclipse's ls, many say that it is hard to configure but it's the best out there

* [vim-language-server](https://github.com/iamcco/vim-language-server) - Vim script language server - [config](./configs/lsp-servers/vim_lsconfig.lua)
> Usefull to have if your customizing your Vim

* [sumneko-lua_ls](https://github.com/sumneko/lua-language-server) - Lua language server - [config](./configs/lsp-servers/lua_lsconfig.lua)
> Usefull to have if your customizing your Neovim

## Pictures
--------------------------------------------------------------------------------

### [colorscheme](./colors/cplex.vim)
![colorscheme on clear terminal](https://github.com/nonoMain/nvimrc/blob/master/pictures/colorscheme.png?raw=true)

### [Tabline](./plugin/SmartTabline.vim) tab types: ` Selected | Normal | Modified | Warning | Error `
![tabline](https://github.com/nonoMain/nvimrc/blob/master/pictures/tabline.png?raw=true)

### [Statusline](./plugin/SmartStatusline.vim)
![statusline](https://github.com/nonoMain/nvimrc/blob/master/pictures/statusline.png/?raw=true)

### [history browser](./plugin/BrowseOldfiles.vim)
![file history browser](https://github.com/nonoMain/nvimrc/blob/master/pictures/history_file_browser.png?raw=true)

//endOfFile
