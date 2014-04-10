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

. scripts/versioncmp.sh
. scripts/log.sh

required_packages=("emacs" "jedi" "epc" "ruby")
unmet_deps=()

function can_we_continue() {
    local deps=()
    local failed="0"
    for elem in "${required_packages[@]}"
    do
        if [[ "${unmet_deps[*]}" == *"$elem"* ]]
        then
            deps+=($elem)
            failed="1"
        fi
    done

    if [ $failed == "1" ]
    then
        error "Can't continue. There are some requirements are missing:"
        echo
        for i in "${deps[@]}"
        do
            echo "$i"
        done
        echo
        echo "Install them and retry please."
        exit 1
    fi
}

function check_dep() {
    local package=$1
    local hint=$2
    local version=$3
    local version_to_check=$4
    if [ $package ]
    then
        if hash $package 2>/dev/null; then

            if [ "$version" ]
            then

                version_cmp $version $version_to_check
                #python ./scripts/versioncmp.py $version $version_to_check
                local cmp=$?

                if [ "$cmp" == "2" ]
                then
                    error "$package version $version_to_check required. Yours is $version"
                    info "$hint"
                    unmet_deps+=($package)
                else
                    echo "$package version $version is fine. need ($version_to_check)"

                fi
            else
                echo "Found $package"

            fi
        else
            error "Can't find '$package'."
            info "$hint"
            unmet_deps+=($package)
        fi
    else
        error "first argument is empty"
    fi
}

function py_check_dep() {
    local package=$1
    local hint=$2
    local existance=$3
    if [ "$existance" == "1" ]
    then
        echo "Found $package"
    else
        error "Can't find python package '$package'."
        info "$hint"
        unmet_deps+=($package)
    fi

}

function do_check() {

    check_dep 'emacs' '' `emacs --version | head -n 1 | cut -d " " -f 3` '24.3'

    echo ""
    info "Check for DVCS's needed to install or update packages."
    echo -e "\tIgnore errors if you don't want to install or update any package"

    echo
    check_dep 'git' 'On Debian you can install git by installing "git-core" package.'
    check_dep 'bzr' 'On Debian you can install bzr by installing "bzr" package.'
    check_dep 'makeinfo' 'On Debian you can install makeinfo by installing "texinfo" package.'

    if [[ "${selected_plugins[*]}" == *"kuso-python"* ]]
    then
        echo ""
        info "Check for kuso-python dependencies. . ."
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
    fi

    if [[ "${selected_plugins[*]}" == *"kuso-ruby"* ]]
    then
        echo ""
        info "Check for kuso-ruby dependencies. . ."
        check_dep 'ruby' 'You need to install it from your package manager or from source'
        check_dep 'rake' 'Install it using "gem install rake"'
        check_dep 'bundle' 'Install it using "gem install bundler"'
        check_dep 'rubocop' 'Install it using "gem install rubocop"'
    fi

    if [[ "${selected_plugins[*]}" == *"kuso-web"* ]]
    then
        echo ""
        info "Check for kuso-web dependencies. . ."
        check_dep 'xmlstarlet' 'On Debian you can install xmlstarlet by installing "xmlstarlet" package.'
        check_dep 'csslint' 'For installing csslint you need "nodejs". You can install "csslint" via "npm"'
    fi

    can_we_continue
}
