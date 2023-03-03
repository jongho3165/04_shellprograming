#!/bin/bash

echo -n "what is your filename ? : "
read FILE1
#echo $FILE1
if [ -f $FILE1 ] ; then
    echo "This file is regular file!"
elif [ -d $FILE1 ] ; then
    echo "this file is Directory!"
else
    echo "i dont no this file!"
fi