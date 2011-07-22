#! /bin/bash

echo "Enter your full name (you can change it later in top level customization): "
fullname=`read`
echo "Enter your mail: "
mail=`read`
echo "Where is your workspace directory: "
workspace=`read`
echo "Where do you want to put pyemacs.sh file: "
addr=`read`
kusohome=`pwd`
mkdir -p ~/.emacs.d
if [ -x ~/.emacs ]; then
    cp ~/.emacs ~/.emacs.backup
fi

cp conf/emacs.d/* ~/.emacs.d -rv
echo "Creating ~/.emacs"
mkdir -p $addr
cp conf/bin/pyemacs.sh $addr/ -rv
chmod u+x $addr/pyemacs.sh
sed "s/--EMAIL--/$mail/" conf/dotemacs| sed "s/--FULLNAME--/$fullname/"| sed "--WORKSPACE--" | sed "s/--ADDR--/$addrcp/" | sed "s/--KUSOHOME--/$kusohome/" > ~/.emacs
