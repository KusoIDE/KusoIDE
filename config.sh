#! /usr/bin/env bash

. ./scripts/check_dep.sh
. ./scripts/make_files.sh
. ./scripts/install_files.sh


echo "  _  __              ___ ___  ___ ";
echo " | |/ /  _ ___ ___  |_ _|   \| __|";
echo " | ' < || (_-</ _ \  | || |) | _| ";
echo " |_|\_\_,_/__/\___/ |___|___/|___|";
echo "                                  ";



do_check
do_make
do_install
