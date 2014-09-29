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
    rm -R .build 
    rm ./kuso.config.el 2> /dev/null

    mkdir -p `pwd`/.build/
    mkdir .build/share
    mkdir .build/conf
    mkdir .build/bin
    cp -r ./share/ .build/ 
    cp -r ./conf/ .build/
    cp -r ./bin/ .build/ 
}


function do_make() {
    pre_make
    #No such place
   files=("conf/kuso.config.el"  "bin/kuso")

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
	
        cp  $file ".build/$file"
        sed -i '' -e "s|--EMAIL--|$mail|g"  ".build/$file"
        sed -i '' -e "s|--FULLNAME--|$fullname|g"  ".build/$file"
        sed -i '' -e "s|--WORKSPACE--|$workspace|g" ".build/$file"
        sed -i '' -e "s|--REPO--|$repo|g"  ".build/$file"
        sed -i '' -e "s|--PATH--|$current_path|g"  ".build/$file"
        sed -i '' -e "s|--PLUGINS--|$plugins_list|g"  ".build/$file"
        sed -i '' -e "s|--VERSION--|$VERSION|g"  ".build/$file"
    done

    post_make
}

function post_make() {
    cp -r .build/conf/kuso.config.el ./ 
    cp -r .build/bin/kuso ./ 
    chmod +x ./kuso
    # Byte compile everything
    echo "Compiling elisp files ..."
    emacs --batch --eval "(byte-recompile-directory \"./kuso.d/\" 0)" -Q -l kuso.config.el 2> ./build.log

}
