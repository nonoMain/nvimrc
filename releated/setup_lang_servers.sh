# File Documentation
# Filename: install_lang_servers.sh
# Author: nonomain
# last updated: 31/01/22 17:51:38
# Description:
# 	script that installs all the needed ls-servers to INSTALLDIR variable (outside of things like clang that are installed with a specific package manager)

INSTALLDIR='.ls-servers'
##--------functions--------##
install_pyright ()
{
	start_pwd=$PWD
	mkdir pyright-ls
	cd pyright-ls
	npm install pyright
	cd $start_pwd
}

install_jdtls ()
{
	start_pwd=$PWD
	mkdir eclipse-jdt-ls
	cd eclipse-jdt-ls
	# update url from https://download.eclipse.org/jdtls/milestones/?d
	curl https://download.eclipse.org/jdtls/milestones/1.6.0/jdt-language-server-1.6.0-202111261512.tar.gz -o jdtls.tar.gz
	tar xzf jdtls.tar.gz
	rm -rf jdtls.tar.gz
	cd $start_pwd
}

install_lua_langauge_server ()
{
	start_pwd=$PWD
	git clone https://github.com/sumneko/lua-language-server
	cd lua-language-server
	git submodule update --init --recursive
	cd 3rd/luamake
	ninja -f compile/ninja/linux.ninja
	cd ../..
	./3rd/luamake/luamake rebuild
	cd $start_pwd
}

install_vim-language-server ()
{
	start_pwd=$PWD
	mkdir vim-language-server
	cd vim-language-server
	npm install vim-language-server
	cd $start_pwd
}

##----------code-----------##
cd $HOME
mkdir $HOME/$INSTALLDIR
cd $HOME/$INSTALLDIR

install_pyright
install_jdtls
install_lua_langauge_server
install_vim-language-server
