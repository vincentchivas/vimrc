#!/bin/sh
warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

git clone git://github.com/likun5053/vimrc.git
cd vimrc

INSTALL_DIR=`pwd`

# Download vim plugin bundles
git submodule init
git submodule update

git submodule foreach git pull origin master
if [ -d ~/vimrc ]l;then
    rm -rf ~/vimrc
fi
ln -sf ${INSTALL_DIR} ~/vimrc

if [ ! -d ~/vimrc/vim/.tmp ];then
    mkdir vim/.tmp
fi
# Compile command-t for the current platform
cd vim/ruby/command-t
(ruby extconf.rb && make clean && make) || warn "Ruby compilation failed. Ruby not installed, maybe?"

touch ~/vimrc/vim/user.vim

echo '
set runtimepath=~/vimrc/vim,~/vimrc/vim/after,\$VIMRUNTIME
source ~/vimrc/vimrc
helptags ~/vimrc/vim/doc'> ~/.vimrc

echo "Installed and configured vim, have fun."
