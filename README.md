svnlock
=======

Recursively locks/unlocks all files in a given SVN directory.

####Usage

The u option unlocks all files in the given directory recursively.  
The m option gives a message when lock the files.  
The p option prompts the user for their SVN password.

#####SYNOPSIS
svnlock [-u] [-p] [-m <message>] dir

#####Example

    $ ./svnlock.sh -u -p /path/to/repo
    Enter SVN Password: 
    Now running ...
    Gathering files
    ... unlocking /path/to/repo/Makefile
    'Makefile' unlocked.
    ... unlocking /path/to/repo/.gitignore
    '.gitignore' unlocked
    All files in /path/to/repo unlocked. Remember to commit changes.

