import sys
from distutils.version import LooseVersion


def version_cmp(ver1, ver2):
    print ">>>> ", ver1, ver2
    if LooseVersion(ver1) < LooseVersion(ver2):
        print 1
    else:
        print 0


if __name__ == "__main__":
    version_cmp(sys.argv[1], sys.argv[2])
