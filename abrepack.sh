#!/bin/bash
#
#   Android backup repacker
#   Shell script for make backups with `adb backup`, unpack and repack them
#   @author: george.naz

source "$(dirname $0)/abrepackrc"

usage_message="\nUsage: $0 <command> <package/application name>\n
\tCommands:
\t\tsearch <string> - search string in package list on device
\t\tget <app>       - backup app into ab-file
\t\tunpack          - unpack ab-file (unpack to tar and untar)
\t\trepack          - pack untared data into ab-file
\t\textractapp <app> - backup app, unpack to tar-file and untar it
\t\tclear           - remove all tmp files and dir apps
"

[[ $# -eq 0 ]] && echo -e "$usage_message" && exit 1

case "$1" in
    'search')
        search_app $2
        ;;
    'get')
        backup_app $2
        ;;
    'unpack')
        unpack_ab2tar
        untar
        ;;
    'extractapp')
        backup_app $2
        unpack_ab2tar
        untar
        ;;
    'repack')
        pack_ab
        ;;
    'clear')
        [ -d apps ] && rm -rf apps
        for i in $FILESLIST $FILEMTREE $HEADERFILE $BFILE $TFILE; do
            [ -e $i ] && echo "..deleting $i" && rm $i
        done
        echo 'Cleared'
        ;;
    *)
        echo -e "$usage_message"
        exit 0
        ;;
esac
