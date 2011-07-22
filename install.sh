#! /bin/bash

mkdir -p ~/.emacs.d
if [ -x ~/.emacs ]; then
    cp ~/.emacs ~/.emacs.backup
fi

cp conf/emacs.d/* ~/.emacs.d -rv
cp conf/dotemacs ~/.emacs -v

echo "Enter your full name (you can change it later in top level customization): "
$fullname=`read`
echo "Enter your mail: "
$mail=`read`
echo "Enter your workspace directory path: "
$workspace=`read`