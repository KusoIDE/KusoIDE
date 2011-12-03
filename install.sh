#! /bin/bash

VERSION="0.10.0"

# Gathering informations
echo -e "\n\tKuso IDE v$VERSION copyright 2010-2011 Sameer Rahmani <lxsameer@gnu.org>\n\n"
echo "Enter requested informations. You can change it later in top"
echo -e "level customization.\n\n"
read -p "Enter your full name: " fullname
read -p "Enter your email address: " mail
read -p "Where is your workspace directory[~/src/]: " workspace

# Validating informations
if [ "$workspace" == "" ]
then
    workspace="$HOME/src/"
fi

addr=$HOME/.kuso

# Installing stage1
kusohome=`pwd`
mkdir -p ~/.emacs.d
if [ -e ~/.emacs ]; then
    echo "Backing up exists .emacs file . . ."
    cp ~/.emacs ~/.emacs.backup
fi
echo "Copying files . . . "
cp conf/emacs.d/* ~/.emacs.d -r
mkdir -p $addr
mkdir -p $HOME/.tmp
cp conf/bin/pyemacs.sh $addr/ -r
chmod u+x $addr/pyemacs.sh

echo "Creating ~/.emacs"
dotemacs=~/.emacs
cp conf/dotemacs $dotemacs
v="s/--EMAIL--/$fullname/"
sed "s/--EMAIL--/$mail/mg" -i $dotemacs
sed "s/--FULLNAME--/$fullname/mg" -i $dotemacs
sed "s,--WORKSPACE--,$workspace,mg" -i $dotemacs
sed "s,--ADDR--,$addr,mg" -i $dotemacs
sed "s,--KUSOHOME--,$kusohome,mg" -i $dotemacs

echo -e "\nInstallation finished."
echo "Restart the GNU/Emacs and make sure that all the requirements met."