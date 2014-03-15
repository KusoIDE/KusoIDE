#! /usr/bin/env bash

. ./scripts/check_dep.sh


echo "  _  __              ___ ___  ___ ";
echo " | |/ /  _ ___ ___  |_ _|   \| __|";
echo " | ' < || (_-</ _ \  | || |) | _| ";
echo " |_|\_\_,_/__/\___/ |___|___/|___|";
echo "                                  ";




check_dep 'emacs' '' `emacs --version | head -n 1 | cut -d " " -f 3` '24.3'

check_dep 'git' 'On Debian you can install git by installing "git-core" package.'
check_dep 'bzr' 'On Debian you can install bzr by installing "bzr" package.'
check_dep 'makeinfo' 'On Debian you can install makeinfo by installing "texinfo" package.'

check_dep 'python' 'You need to install it from your package manager or from source'
check_dep 'pep8' 'Install it using "pip" or "easy_install"'
check_dep 'pyflakes' 'Install it using "pip" or "easy_install"'
check_dep 'pychecker' 'Install it using "pip" or "easy_install"'
check_dep 'pylint' 'Install it using "pip" or "easy_install"'
py_check_dep 'jedi' 'Install it using "pip" or "easy_install"' `python ./scripts/pypackage.py jedi`
py_check_dep 'epc' 'Install it using "pip" or "easy_install"' `python ./scripts/pypackage.py epc`
check_dep 'csscapture' 'Install it using "pip cssutils" or "easy_install cssutils"'
check_dep 'csscombine' 'Install it using "pip cssutils" or "easy_install cssutils"'
check_dep 'cssparse' 'Install it using "pip cssutils" or "easy_install cssutils"'

check_dep 'ruby' 'You need to install it from your package manager or from source'
check_dep 'rake' 'Install it using "gem install rake"'
check_dep 'bundle' 'Install it using "gem install bundler"'

check_dep 'xmlstarlet' 'On Debian you can install xmlstarlet by installing "xmlstarlet" package.'
check_dep 'csslint' 'For installing csslint you need "nodejs". You can install "csslint" via "npm"'


do_make
do_install
