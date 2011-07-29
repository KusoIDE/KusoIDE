#! /bin/bash

echo "Enter your full name (you can change it later in top level customization): "
read fullname
echo "Enter your mail: "
read mail
echo "Where is your workspace directory: "
read workspace
echo "Where do you want to put pyemacs.sh file: "
read addr
kusohome=`pwd`

mkdir -p ~/.emacs.d
if [ -x ~/.emacs ]; then
    cp ~/.emacs ~/.emacs.backup
fi

cp conf/emacs.d/* ~/.emacs.d -r
echo "Creating ~/.emacs"
mkdir -p "$addr"
cp conf/bin/pyemacs.sh $addr/ -r
chmod u+x $addr/pyemacs.sh -v
cp conf/dotemacs ~/.emacs
echo "python ./rep.py $mail $fullname $workspace $addr $kusohome"
python ./rep.py $mail $fullname $workspace $addr $kusohome
#sed "s/--EMAIL--/$mail/" -i ~/.emacs
#sed "s/--FULLNAME--/$fullname/" -i ~/.emacs
#sed "s/--WORKSPACE--/$workspace/" -i ~/.emacs
#sed "s/--ADDR--/$addr/" -i ~/.emacs
#sed "s/--KUSOHOME--/$kusohome/" -i ~/.emacs
