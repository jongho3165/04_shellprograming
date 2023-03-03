#!/bin/bash
Usage() { echo "Usage: $0 [-x] [-y foo] file"; exit 1; }

while getopts xy: options 2>/dev/null
do
    case $options in
        x)  echo "Your Entered : -x" ;;
        y)  echo "Your Entered : -y $OPTARG" ;;
        \?) echo Usage ;;
        *) ecgi Usage ;;
    esac
done


shift $(expr $OPTIND - 1)        # shift $(expr $OPTIND - 1)

if [ $# -ne 0 ] ; then
    Usage
fi
echo "$# : $@"

#if [ $# -eq 0 ] ; then
#	Usage
#fi
#echo "$@ : $1"