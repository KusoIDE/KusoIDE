# Copyright (c) 2014 lxsameer <lxsameer@gnu.org>
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your
#  option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
# You should have received a copy of the GNU General Public License along with
# this program. If not, see http://www.gnu.org/licenses/.

from __future__ import print_function
import sys


def check_for_package(pkg):
    try:
        try:
            __import__(pkg, globals(), locals(), [], -1)
        except ValueError:
            __import__(pkg, globals(), locals(), [], 0)
        print("1")
    except ImportError:
        print("0")


if __name__ == "__main__":
    check_for_package(sys.argv[1])
