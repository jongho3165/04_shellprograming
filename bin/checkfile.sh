#!/bin/bash

# 	# crontab -e
# 	Min Hour Day Mon Week CMD
#  	0   8    *   *   *   /root/shell/check_file.sh
#
# 	# cat /root/shell/test/check_file_list.txt
# 	/etc/passwd
# 	/etc/group
# 	/etc/hosts
# 	.....

F_LIST=/root/bin/file_list.txt                    # 점검할 파일 목록
T_FILE=/tmp/tmp1
T_FILE2=/tmp/tmp2     
T_FILE3=/tmp/tmp3                          # 임시파일
F_RESULT=/root/bin/result.`date +'%m%d'`          # 결과 리포트 파일
EMAIL=root        
BACKUPDIR=/backup
> $F_RESULT     


for F_NAME in $(cat $F_LIST)                         # 점검해야 하는 파일 목록 읽기)
do
    # ==> echo $F_NAME ; read     # F_NAME=/root/bin/passwd
    DIRNAME=$(dirname $F_NAME)      # /root/bin
    FILENAME=$(basename $F_NAME)    # passwd
    BACKUPFILE=$BACKUPDIR/$FILENAME.orig
    # ==> echo "$DIRNAME $FILENAME $BACKUPFILE" ; read
    if [ -f "$BACKUPFILE" ] ; then                   # 백업파일 존재 유무 확인
        diff $F_NAME $BACKUPFILE > $T_FILE         # 원본파일<-->백업파일 비교
        if [ -s $T_FILE ] ; then
            echo "[ WARN ] $F_NAME" >> $F_RESULT
            /bin/cp $F_NAME $BACKUPFILE.$(date +%m%d_%H%M%S)
            /bin/cp $F_NAME $BACKUPFILE
        else
            echo "[ OK ] $F_NAME" >> $F_RESULT
            
        fi
    else
       /bin/cp $F_NAME $BACKUPFILE
    fi
    
done



grep -qw WARNING $F_RESULT > $T_FILE2
if [ $? -eq 0 ] ; then
    mailx -s "[ WARN ] Check Files" $EMAIL < $F_RESULT
     echo "WARNNING"
else
    mailx -s "[ OK ] GOOD" $EMAIL < $F_RESULT
     echo "OK"
fi
# rm T_FILE                     # tempory file delete
