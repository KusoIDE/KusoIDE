import sys


def check_for_package(pkg):
    try:
        __import__(pkg, globals(), locals(), [], -1)
        print "1"
    except ImportError:
        print "0"


if __name__ == "__main__":
    check_for_package(sys.argv[1])
