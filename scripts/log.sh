#! /usr/bin/env bash

# Coloring Functions
function info() {
    if [ "$1" ]
    then
        echo -e "[\033[01;32mINFO\033[00m]: $1"
    fi
}

function error(){
    if [ "$1" ]
    then
        echo -e "[\033[01;31mERR\033[00m]: $1"
    fi
}

function warn(){
    if [ "$1" ]
    then
        echo -e "[\033[01;33mWARN\033[00m]: $1"
    fi
}
