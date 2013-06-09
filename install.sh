#! /bin/bash

VERSION=1.0.0

remoteconffile=
remoteexecutable=

conffile=conf/dotkuso

# Gathering informations
echo -e "\n\033[01;32mKuso IDE\033[00m $VERSION copyright 2010-2013 \033[01;34mSameer Rahmani <lxsameer@gnu.org>\033[00m\n\n"
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
	executable=kuso-dev
    fi

    if [ "$standalone" == "n" ]
    then
	dotemacs=~/.emacs
	repo=~/.emacs.d
	condition="0"

	executable=emacs-dev
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

addr=$HOME/.kuso.d

# Installing stage1
kusohome=`pwd`
mkdir -p $repo
if [ -e $dotemacs ]; then
    echo "Backing up exists init file . . ."
    #cp $dotemacs "$dotemacs.backup"
fi
echo "Copying files . . . "
if [ -e $conffile ]
then
    cp $conffile $dotemacs
    cp bin/$executable $repo/$executable
else
    wget $remoteconffile -o $dotemacs
    wget $remoteexecutable -o $repo/$executable
fi

if [ "$standalone" == "" -o "$standalone" == "y" ]
then
    sudo ln -s $repo/$executable /usr/bin/$executable
fi

sed "s/--EMAIL--/$mail/mg" -i $dotemacs
sed "s/--FULLNAME--/$fullname/mg" -i $dotemacs
sed "s,--WORKSPACE--,$workspace,mg" -i $dotemacs
sed "s,--REPO--,$repo,mg" -i $dotemacs


echo "Copy the below code in your initial shell script:"
echo
echo "export PATH=\$PATH:$repo"
echo -e "\nInstallation finished."
echo "Restart the GNU/Emacs and make sure that all the requirements met."
echo
printf "\033[01;33mImportant Note:\033[00m Do NOT remove the Kuso IDE source.\n"
