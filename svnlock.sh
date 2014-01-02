#!/bin/bash

# Recursively (un)lock all files in a given svn directory.
# Copyright (C) 2014 Evan Lowry <lowry.e@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

showhelp() {
    echo "usage: [-u directory] [-l directory] [-svnpass]"
}

lock() {
    DIR=$1
    echo "Gathering files"
    files=`$SVN list -R $DIR | grep -v '/$'`
    for file in $files; do
        echo "... locking $file"
        $SVN lock "$DIR/$file"
    done
    echo "All files in $DIR locked. Remember to commit changes."
}

unlock() {
    DIR=$1
    echo "Gathering files"
    files=`$SVN st -u $DIR | grep "^.\{5\}[O|K]" | rev | cut -d' ' -f1 | rev`
    for file in $files; do
        echo "... unlocking $file"
        $SVN unlock $file
    done
    echo "All files in $DIR unlocked. Remember to commit changes."
}

UNLOCK_FLAG=
LOCK_FLAG=
SVN_PASS=

# Parse Command Line Arguments
while getopts "u:l:p" opt; do
    case "$opt" in
        u)  UNLOCK_FLAG=1
            UNLOCK_DIR="$OPTARG"
            ;;
        l)  LOCK_FLAG=1
            LOCK_DIR="$OPTARG"
            ;;
        p)  read -s -p "Enter SVN Password: " SVN_PASS
            ;;
        \?) showhelp
            ;;
    esac
done

SVN="svn"
if [ ! -z "$SVN_PASS" ]; then
    SVN="svn --password $SVN_PASS"
fi

echo -e "\nNow running ...\n"
if [ ! -z "$LOCK_FLAG" ]; then
    lock $LOCK_DIR
fi
if [ ! -z "$UNLOCK_FLAG" ]; then
    unlock $UNLOCK_DIR
fi
