#! /usr/bin/env python
import os
import sys

MAIL = sys.argv[1]
FULLNAME = sys.argv[2]
WORKSPACE = sys.argv[3]
ADDR = sys.argv[4]
KUSOHOME = sys.argv[5]

HOME = os.environ['HOME']

fd = open("%s/.emacs" % HOME)
buf = fd.read()
fd.close()
buf.replace("--EMAIL--", MAIL)
buf.replace("--FULLNAME--", FULLNAME)
buf.replace("--WORKSPACE--", WORKSPACE)
buf.replace("--ADDR--", ADDR)
buf.replace("--KUSOHOME--", KUSOHOME)
print ">> ", buf
fd = open("%s/.emacs" % HOME, "w+")
fd.write(buf)
fd.close()
