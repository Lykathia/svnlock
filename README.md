svnlock
=======

Recursively locks/unlocks all files in a given SVN directory.

####Usage

The u option unlocks all files in the given directory recursively.  
The l option locks all files in the given directory recursively.  
The p option prompts the user for their SVN password.

#####SYNOPSIS
svnlock [-u dir] [-l dir] [-p]

#####Example

    $ ./svnlock.sh -u /path/to/repo -p 
    Enter SVN Password: 
    Now running ...
    Gathering files
    ... unlocking /path/to/repo/Makefile
    'Makefile' unlocked.
    ... unlocking /path/to/repo/.gitignore
    '.gitignore' unlocked
    All files in /path/to/repo unlocked. Remember to commit changes.

