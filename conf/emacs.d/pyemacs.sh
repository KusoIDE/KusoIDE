#!/bin/bash

epylint "$1" 2>/dev/null
pyflakes "$1"
pep8 --ignore=E221,E701,E202,E128 --repeat "$1"
true

