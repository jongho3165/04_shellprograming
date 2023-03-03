#!/bin/bash

clear

PASSWD=/etc/passwd

Menu() {
cat << EOF
(관리 목록)
------------------------------------
1) 사용자 추가
2) 사용자 확인
3) 사용자 삭제
4) 종료
------------------------------------
EOF
}

UserAdd() {
   echo -n "추가할 사용자 : "
   read User
    #echo "$UNAME : $UPASS"
    useradd $User
    echo $User | passwd --stdin $User > /dev/null 2>&1
    echo "[ OK ] $User user add complite!"
}
UserVerify() {
    echo ""
    echo ""
    cat << EOF
    
(사용자 확인)
------------------------------------
$(awk -F: '$3 >= 1000 && $3 <= 60000 {print $1}' $PASSWD | cat -n)
------------------------------------
EOF

}

UserDel() {
    echo -n "삭제할 유저 : "
    read Userdel
    userdel -r $Userdel
    if [ $? != 0 ] ; then
        echo "[ FAIL ] 오류!"
    else 
        
        echo "[ OK ] $UNAME remove complite!"
    fi
}


while true
do
    Menu
    echo -n "번호 선택 (1|2|3|4) : "
    read NUM 

    case $NUM in
        1) UserAdd ;;
        2) UserVerify ;;
        3) UserDel ;;
        4) break ;;
        *) echo "[ 경고 ] 번호가 잘못되었습니다!" ; echo
    esac
    echo ; echo 
done

