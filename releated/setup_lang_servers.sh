##--------functions--------##
setup_pyright ()
{
	start_pwd=$PWD
	mkdir pyright-ls
	cd pyright-ls
	npm install pyright
	cd $start_pwd
}

setup_jdtls ()
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

setup_lua_langauge_server ()
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

setup_vim-language-server ()
{
	start_pwd=$PWD
	mkdir vim-language-server
	cd vim-language-server
	npm install vim-language-server
	cd $start_pwd
}

##----------code-----------##
cd $HOME
mkdir $HOME/.ls-servers
cd $HOME/.ls-servers

setup_pyright
setup_jdtls
setup_lua_langauge_server
setup_vim-language-server
