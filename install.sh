#! /usr/bin/env bash
# Copyright (c) 2014 lxsameer <lxsameer@gnu.org>
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your
#  option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
# You should have received a copy of the GNU General Public License along with
# this program. If not, see http://www.gnu.org/licenses/.

. ./scripts/check_dep.sh
. ./scripts/make_files.sh
. ./scripts/install_files.sh
. ./scripts/version.sh
. ./scripts/plugins.sh


echo "  _  __              ___ ___  ___ ";
echo " | |/ /  _ ___ ___  |_ _|   \| __|";
echo " | ' < || (_-</ _ \  | || |) | _| ";
echo " |_|\_\_,_/__/\___/ |___|___/|___|";
echo "                                  ";
echo ""
echo "Version $VERSION released under the term of GPLv2"
echo "Copyright 2010-2014 Sameer Rahmani <lxsameer@gnu.org"
echo "If your find any bug or have any idea please report it to me via"
echo "https://github.com/KusoIDE/KusoIDE/issues"
echo ""
warn "This installation will alter your exist one (if you already have one)."
read -p "Continue ([y]/n)? " answer

if [ "$answer" == "" -o "$answer" == "y" ]
then

    ask_for_plugins

    info "Checking for dependencies . . ."
    do_check

    info "Making source files . . ."
    do_make

    info "Installing kuso files . . ."
    do_install
fi
echo
info "KUSO is now installed. If you find my job interesting please give"
info "a kudos in:  http://ohloh.org/accounts/lxsameer"
echo
info "Have fun ;)"
