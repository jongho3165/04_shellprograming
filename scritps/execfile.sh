#!/bin/bash

echo -n "ENter your filename ! : "
read FILE1
:<< EOF
if [ -x $FILE1 ]; then
     eval $FILE1
fi
EOF

[ -x $FILE1 ] && eval $FILE1