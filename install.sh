#! /bin/bash

VERSION="0.9.0"

# Gathering informations
echo -e "\n\tKuso IDE v$VERSION copyright 2010-2011 Sameer Rahmani <lxsameer@gnu.org>\n\n"
echo "Enter requested informations. You can change it later in top"
echo -e "level customization.\n\n"
read -p "Enter your full name: " fullname
read -p "Enter your email address: " mail
read -p "Where is your workspace directory[~/src/]: " workspace
read -p "Where do you want to put pyemacs.sh file[~/bin/]: " addr
echo -e "\n"

# Validating informations
if [ "$workspace" == "" ]
then
    workspace="~/src/"
fi

if [ "$addr" == "" ]
then
    addr="~/bin/"
fi

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
cp conf/bin/pyemacs.sh $addr/ -r
chmod u+x $addr/pyemacs.sh

echo "Creating ~/.emacs"
dotemacs=~/.AAA
cp conf/dotemacs $dotemacs
v="s/--EMAIL--/$fullname/"
sed "s/--EMAIL--/$mail/mg" -i $dotemacs
sed "s/--FULLNAME--/$fullname/mg" -i $dotemacs
sed "s,--WORKSPACE--,$workspace,mg" -i $dotemacs
sed "s,--ADDR--,$addr,mg" -i $dotemacs
sed "s,--KUSOHOME--,$kusohome,mg" -i $dotemacs

echo "Installation finished."
echo "Restart the GNU/Emacs and make sure that all the requirements met."