files=("kuso.config.el" "share/applications/some")

function pre_make() {
    if [ -a "`pwd`/.build" ]
    then
       rm "`pwd`/.build -rf"
    fi

    mkdir -p `pwd`/.build/
    cp ./share/ .build/share
}


function do_make() {

    for file in "${files[@]}"
    do
        echo "$file"
    done

    #sed "s/--EMAIL--/$mail/mg" -i $dotemacs
    #sed "s/--FULLNAME--/$fullname/mg" -i $dotemacs
    #sed "s,--WORKSPACE--,$workspace,mg" -i $dotemacs
    #sed "s,--REPO--,$repo,mg" -i $dotemacs
}
