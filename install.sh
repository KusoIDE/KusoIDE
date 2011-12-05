#! /bin/bash

VERSION=$(emacs -l src/lib/version.el --eval "(princ (get_version))" --batch -Q)

# Gathering informations
echo -e "\n\tKuso IDE $VERSION copyright 2010-2011 Sameer Rahmani <lxsameer@gnu.org>\n\n"
echo "Enter requested informations. You can change it later in top"
echo -e "level customization.\n\n"
condition="1"
while [ "$condition" == "1" ] ; do
    read -p "Do you want to install Kuso IDE as an stand alone application ([y]/n)? " standalone

    if [ "$standalone" == "" -o "$standalone" == "y" ]
    then
	standalone="y"
	dotemacs=~/.kuso
	repo=~/.kuso.d
	condition="0"
	conffile=conf/dotkuso
    fi

    if [ "$standalone" == "n" ]
    then
	dotemacs=~/.emacs
	repo=~/.emacs.d
	condition="0"
	conffile=conf/dotemacs
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
    echo "Backing up exists .emacs file . . ."
    cp $dotemacs "$dotemacs.backup"
fi
echo "Copying files . . . "
cp conf/emacs.d/* $repo -r
mkdir -p $addr
mkdir -p $HOME/.tmp
cp conf/bin/pyemacs.sh $addr/ -r
chmod u+x $addr/pyemacs.sh

echo "Creating ~/.emacs"
cp $conffile $dotemacs

if [ "$standalone" == "y" ]
then
    cp bin/kuso $repo
    cp bin/kuso.desktop $HOME/.local/share/applications/
    sed "s,--HOME--,$HOME,mg" -i $HOME/.local/share/applications/kuso.desktop
    cp images/icon.svg $repo
fi

sed "s/--EMAIL--/$mail/mg" -i $dotemacs
sed "s/--FULLNAME--/$fullname/mg" -i $dotemacs
sed "s,--WORKSPACE--,$workspace,mg" -i $dotemacs
sed "s,--ADDR--,$addr,mg" -i $dotemacs
sed "s,--KUSOHOME--,$kusohome,mg" -i $dotemacs

echo "Copy the below code in your initial shell script:"
echo 
echo "export PATH=\$PATH:$repo"
echo -e "\nInstallation finished."
echo "Restart the GNU/Emacs and make sure that all the requirements met."
echo
printf "\033[01;33mImportant Note:\033[00m Do NOT remove the Kuso IDE source.\n"
