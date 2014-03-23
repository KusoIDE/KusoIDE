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

function pre_make() {
    rm `find kuso.d -iname "*.elc"` 2> /dev/null
    rm .build -rf
    rm ./kuso.config.el 2> /dev/null

    mkdir -p `pwd`/.build/
    cp ./share/ .build/ -r
    cp ./conf/ .build/ -r
}


function do_make() {
    pre_make

    files=("conf/kuso.config.el" "share/applications/Kuso.desktop")

    read -p "Enter your full name: " fullname
    read -p "Enter your email address: " mail
    read -p "Where is your workspace directory[~/src/]: " workspace

    current_path=`pwd`
    plugins_list=${selected_plugins[@]}

    # Validating informations
    if [ "$workspace" == "" ]
    then
        workspace="$HOME/src/"
    fi

    for file in "${files[@]}"
    do
        cp $file ".build/$file"
        sed "s/--EMAIL--/$mail/mg" -i ".build/$file"
        sed "s/--FULLNAME--/$fullname/mg" -i ".build/$file"
        sed "s,--WORKSPACE--,$workspace,mg" -i ".build/$file"
        sed "s,--REPO--,$repo,mg" -i ".build/$file"
        sed "s,--PATH--,$current_path,mg" -i ".build/$file"
        sed "s,--PLUGINS--,$plugins_list,mg" -i ".build/$file"
        sed "s,--VERSION--,$VERSION,mg" -i ".build/$file"
    done

    post_make
}

function post_make() {
    cp .build/conf/kuso.config.el ./ -f
    # Byte compile everything
    emacs --batch --eval "(byte-recompile-directory \"./kuso.d/\" 0)" -Q -l kuso.config.el > ./build.log

}
