#!/bin/bash

clear
TMP1=/test/pv1.txt
TMP2=/test/pv2.txt
TMP3=/test/vg1
TMP4=/test/vg2
# 1. PV
# 2. VG
# 3. LV

PVC() {
echo ""
echo "################# PV create #################"
echo ""
############################
# 1. PV
############################
# (1) View
fdisk -l | grep LVM | awk '{print $1}' > $TMP1
pvs | tail -n +2 | awk '{print $1}' > $TMP2

cat << EOF
############# PV VIEW #############
$(cat $TMP1 $TMP2 | sort | uniq -u)
###################################

EOF

# (2) Works
echo "=> 위의 목록에서 PV로 생성하고 싶은 볼륨을 선택합니다. <="
echo -n "볼륨 선택? (ex: /dev/sdb1 /dev/sdc1 ...) : "
read VOLUME

pvcreate $VOLUME > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[  OK  ] Physical volume $VOLUME successfully created."
    echo "==========================================="
    pvs
    echo "==========================================="
else
    echo "[ FAIL ] Physical volume not created."
    exit 1 
fi

echo -n "작업을 유지합니까 ?(Y|N) : "
read YN1
case $YN1 in
    Y) main ;;
    N) pvremove $VOLUME;;
    *) echo "[ 경고 ] 번호가 잘못되었습니다!" ; echo
esac

}


############################
# 2. VG
############################
# (1) View
VGC() {
echo ""
echo "################# VG create #################"
echo ""
vgs | tail -n +2 | awk '{print $1}' > $TMP3
pvs > $TMP4
for i in $(cat $TMP3)
do
    sed -i "/$i/d" $TMP4
done

cat << EOF
############# PV LIST #############
$(cat $TMP4)
###################################
EOF
# (2) Works
# vgcreate vg1 /dev/sdb1 /dev/sdc1
echo -n "VG 이름은? (ex : vg1) : "
read VGNAME

echo -n "선택 가능한 PV 목록을 적어주세요 (ex: /dev/sdb1 /dev/sdc1) : "
read PVLIST

vgcreate $VGNAME $PVLIST > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[ OK ] Volume group $VGNAME successfully created"
    echo "==========================================="
    vgs
    echo "==========================================="
else
    echo "[FAIL] Volume group not created"
    exit 2
fi

echo -n "작업을 유지합니까 ?(Y|N) : "
read YN2
case $YN2 in
    Y) main ;;
    N) vgremove $VGNAME ;;
    *) echo "[ 경고 ] 번호가 잘못되었습니다!" ; echo
esac
}


############################
# 3. LV
############################
# (1) View
LVC() {
echo ""
echo "################# LV create #################"
echo ""
cat << EOF
############### VG LIST ###############
$(vgs | awk '$7 != '0' {print $0}')
#######################################
EOF
# (2) Works
# lvcreate vg1 -n lv1 -L 500M
echo -n "LV를 생성할 VG 이름은? (ex: vg1) : "
read VGLV

echo -n "생성할 LV 이름은? (ex lv1) : "
read LVNAME

echo -n "LV 용량은? (ex: 500m) : "
read LVSIZE

lvcreate $VGLV -n $LVNAME -L $LVSIZE
if [ $? -eq 0 ] ; then
    echo "[ OK ] Logical Volume $LVNAME successfully created"
    echo "======================================================================================"
    lvs
    echo "======================================================================================"
else
    echo "[ FAIL ] Logical Volume not created"
    exit 3
fi
echo -n "작업을 유지합니까 ?(Y|N) : "
read YN3
case $YN3 in
    Y) main ;;
    N) lvremove -y /dev/$VGLV/$LVNAME ;;
    *) echo "[ 경고 ] 번호가 잘못되었습니다!" ; echo
esac

}


main() {
while true
do
cat << EOF
############### VG LIST ###############
1) PV 만들기 
2) VG 만들기
3) LV 만들기
4) 종료
#######################################
EOF
echo -n "수행 할 작업을 선택 : "
read NUM
    case $NUM in
        1) PVC ;;
        2) VGC ;;
        3) LVC ;;
        4) exit 0 ;;
        *) echo "[ 경고 ] 번호가 잘못되었습니다!" ; echo
    esac
    echo ; echo 
done
}
main