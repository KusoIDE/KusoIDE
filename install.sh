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
cp conf/dotemacs ~/.emacs
sed "s/--EMAIL--/$mail/" -i ~/.emacs
sed "s/--FULLNAME--/$fullname/" -i ~/.emacs
sed "s/--WORKSPACE--/$workspace/" -i ~/.emacs
sed "s/--ADDR--/$addrcp/" -i ~/.emacs
sed "s/--KUSOHOME--/$kusohome/" > ~/.emacs
