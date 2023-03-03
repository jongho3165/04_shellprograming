#!/bin/bash

echo -n "your Choise? (yes/no/exit) : "

read CHOISE

case $CHOISE in
    yes | Y | YES | Yes) echo "[ OK ] your YESMAN!!" ;;
    no | N | NO | n | No) echo "[ FAIL ] your SUCK!!" ;;
    exit) exit 0;;
    *) echo "[ FAIL!!! ] ONLY YES or NO!!" 
        exit 1 ;;
esac