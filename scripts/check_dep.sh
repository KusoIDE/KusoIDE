
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
