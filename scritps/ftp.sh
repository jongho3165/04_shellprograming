#!/bin/bash

HELP () {
cat << EOF
Commands may be addreviated. Commands are :

    a b c d e 
EOF
}

ERROR () { 
        [ "$CMD" ]  &&  echo "[ WARN ] Invalid Command" 
}

while true 
do
    echo -n "ftp> "
    read CMD
     
    case $CMD in
        'quit' | 'bye') break ;;
        'help') HELP ;;
        *) ERROR ;;
    esac
done