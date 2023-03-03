#!/bin/bash

echo -n "Enter A : "
read NUM1
echo -n "Enter Operator : "
read OPN
echo -n "Enter B : "
read NUM2

#cat << EOF
#====================================================
#  (1). +      (2). -     (3). *     (4). /         
#====================================================
#EOF

#echo  -n "Enter Your Choise ? : "
#read CODE

#while true
#do
    case $CODE in
    1)  echo "$NUM1 + $NUM2 =  $(expr $NUM1 + $NUM2)" ;;
    2)  echo "$NUM1 - $NUM2 =  $(expr $NUM1 - $NUM2)" ;;
    3)  echo "$NUM1 * $NUM2 =  $(expr $NUM1 \* $NUM2)" ;;
    4)  echo "$NUM1 / $NUM2 =  $(expr $NUM1 / $NUM2)" ;;
    esac
#done
