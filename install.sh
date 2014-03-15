#! /bin/bash

# Kuso IDE installer script
# Its a very quick way to install Kuso IDE
# I now this code is not very nice but who cares it works


VERSION=1.0.0

remoteconffile="http://raw.github.com/Karajlug/KusoIDE/1.0/conf/dotkuso"
remoteexecutable="http://raw.github.com/Karajlug/KusoIDE/1.0/bin/kuso"

conffile=conf/dotkuso

mode="basic"

REQUIREMENTS=(emacs git)

# Coloring Functions
function info() {
    echo -e "[\033[01;32mINFO\033[00m]: $1"
}

function error(){
    echo -e "[\033[01;31mERR\033[00m]: $1"
}

function warn(){
    echo -e "[\033[01;33mWARN\033[00m]: $1"
}

function requirements_check(){
    for app in "${REQUIRMENTS[@]}"
    do
        info "Check for $app"
        if hash $1 2>/dev/null; then
            info "$app is present"
        else
            REQUIREMENTS_CHECK=false
            error "Can not find $app"
        fi
    done
}



while getopts ":e" option
do
    case "${option}"
        in
        e)mode="expert";;
    esac
done

# Gathering informations
echo -e "\n\033[01;32mKuso IDE\033[00m $VERSION copyright 2010-2013 \033[01;34mSameer Rahmani <lxsameer@gnu.org>\033[00m\n\n"

# Requirments check to make sure everything is ok
echo -e "Requirment Check"
# if this variable changed to fasle , means we have something to install
REQUIREMENTS_CHECK=true
requirements_check $REQUIREMENTS
# exit if our requirement check
if [ $REQUIREMENTS_CHECK == false ]; then
    error "Please install requirments first";
    exit;
fi
echo -e "\n\n"

echo "Enter requested informations. You can change it later in top"
echo -e "your init file.\n\n"

condition="1"
while [ "$condition" == "1" ] ; do
    read -p "Do you want to install Kuso IDE as an stand alone application ([y]/n)? " standalone

    if [ "$standalone" == "" -o "$standalone" == "y" ]
    then
        standalone="y"
        dotemacs=~/.kuso_dev
        repo=~/.kuso.d_dev
        condition="0"
        executable=kuso
    fi

    if [ "$standalone" == "n" ]
    then
        dotemacs=~/.emacs
        repo=~/.emacs.d
        condition="0"
        executable=kuso
    fi

done
read -p "Enter your full name: " fullname
read -p "Enter your email address: " mail
read -p "Where is your workspace directory[~/src/]: " workspace

# Validating informations
if [ "$workspace" == "" ]
then
    workspace="$HOME/src/"
fi

# Installing stage1
info "Creating configuration folder in $repo"
mkdir -p $repo

if [ -e $dotemacs ]; then
    info "An init file already exists."
    info "Backing up exists init file to $dotemacs.backup . . ."
    #cp $dotemacs "$dotemacs.backup"
fi

if [ -e $conffile ]
then
     info "Copying init files . . . "
    cp $conffile $dotemacs
    cp bin/$executable $repo/$executable
else
    info "Downloading init file and executable . . ."
    wget $remoteconffile -q -O $dotemacs
    wget $remoteexecutable -q -O $repo/$executable
fi

if [ "$standalone" == "" -o "$standalone" == "y" ]
then
    info "Creating a link in globe PATH . . ."
    sudo ln -s $repo/$executable /usr/bin/$executable-dev
    chmod +x $repo/$executable
fi

sed "s/--EMAIL--/$mail/mg" -i $dotemacs
sed "s/--FULLNAME--/$fullname/mg" -i $dotemacs
sed "s,--WORKSPACE--,$workspace,mg" -i $dotemacs
sed "s,--REPO--,$repo,mg" -i $dotemacs


#if [ $mode == "expert" ]
#then
#    info "Installing base system . . ."
#    echo "(setq KUSO-INSTALL-MODE \"expert\")" > /tmp/init_kuso_installer.el
#    `which emacs` --batch -l /tmp/init_kuso_installer.el -l $dotemacs
#else
#    info "Installing base system . . ."
#    `which emacs` --batch -l $dotemacs
#fi

echo -e "\nNow run 'kuso' and have fun ;)"
