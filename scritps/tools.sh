#!/bin/bash


clear
cat << EOF
====================================================
  (1). who      (2). date     (3). pwd     (4). Home         
====================================================
EOF

echo -n "Choise your Number! (1|2|3|4) : "
read CHOISE
#echo $CHOISE
case $CHOISE in
    1) who ;;
    2) date ;;
    3) pwd ;;
    4) echo "i want to go HOME!!" ;;
    *) echo "[ FAIL ] THIS NUMBER IS WARONG!" ;;
esac


