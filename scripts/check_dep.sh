
. scripts/versioncmp.sh
. scripts/log.sh

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
                else
                    info "$package version $version is fine. need ($version_to_check)"

                fi
            else
                info "Found $package"

            fi
        else
            error "Can't find '$package'."
            info "$hint"
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
        info "$package version $version is fine. need ($version_to_check)"
    else
        error "Can't find python package '$package'."
        info "$hint"
    fi

}

function do_check() {
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
}
