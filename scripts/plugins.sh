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

function ask_for_plugins(){

    # Ask user for plugins
    plugins=("kuso-python" "kuso-ruby" "kuso-web")
    echo
    echo "Plugins:"
    for plugin in "${plugins[@]}"
    do
        echo -e "\t$plugin"
    done
    echo -e "\tall"
    echo
    info "Enter the full name of plugins which you want to use with kuso or 'all'"
    echo "to use all of them."
    warn "Remember each plugin will consum startup process."
    read -p "Plugins (separated by space)[defualt all]: " selected_plugins

    if [ "$selected_plugins" == "" -o "$selected_plugins" == "all" ]
    then
        selected_plugins=( `IFS=$'\n'; echo "${plugins[*]}"` )
    else
        tmp=($selected_plugins)
        selected_plugins=( `IFS=$'\n'; echo "${tmp[*]}"` )
    fi
}
