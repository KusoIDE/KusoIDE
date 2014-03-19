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

# Coloring Functions
function info() {
    if [ "$1" ]
    then
        echo -e "[\033[01;32mINFO\033[00m]: $1"
    fi
}

function error(){
    if [ "$1" ]
    then
        echo -e "[\033[01;31mERR\033[00m]: $1"
    fi
}

function warn(){
    if [ "$1" ]
    then
        echo -e "[\033[01;33mWARN\033[00m]: $1"
    fi
}
