# Variable Definitions

export PKG_DOWN_DIR=/root/bin
export VSFTPD_FTPUSERS=/etc/vsftpd/ftpusers
export VSFTPD_USERLIST=/etc/vsftpd/user_list
export SSHD_CONF=/etc/ssh/sshd_config
# Function Definitions
PkgInst() {
    # input : pkgs
    # output : output string
    # functions : 
    PKGS=$*
    #echo $PKGS
    yum -qy install $PKGS > /dev/null 2>&1
    if [ $? -eq 0 ] ; then
        echo "[ OK ] $PKGS installed Successful!"
    else 
        echo "[ FAIL ] $PKGS installed fail!!"
        exit 1;
    fi
}

SvcEnable() {
    SVC="$1"
    systemctl enable --now $SVC > /dev/null 2>&1
    if [ $? -eq 0 ] ; then
        echo "[ OK ] $SVC Activate Successful!"
    else
        echo "[ FAIL ] $SVC Activate fail!"
        exit 1
    fi
}



VScodeInst() {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -O /root/bin/google-chrome-stable_current_x86_64.rpm > /dev/null 2>&1
    yum localinstall /root/bin/google-chrome-stable_current_x86_64.rpm > /dev/null 2>&1
    cat << EOF > /etc/yum.repos.d/vscode.repo
		[code]
		nname=Visual Studio Code
		baseurl=https://packages.microsoft.com/yumrepos/vscode
		enabled=1
		gpgcheck=1
		gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
    PkgInst "code"
}

VScodeComment() {
cat << EOF
    *  실행은 다음과 같이 합니다
    (root 사용자) # code --no-sandbox --user-data-dir ~/workspace
    (일반 사용자) # code
    
EOF

}

ChromeInst() {
    URL="https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
    CHROME_PKG=$(basename $URL)
    wget $URL -O $PKG_DOWN_DIR/$CHROME_PKG > /dev/null 2>&1
    if [ $? -eq 0 ] ; then
        echo "[ OK ] Chrome Download Successful!"
    else 
        echo "[ FAIL ] Chrome Download Fail!"
        exit 2
    fi
    yum -qy localinstall $PKG_DOWN_DIR/$CHROME_PKG > /dev/null 2>&1
    if [ $? -eq 0 ] ; then
        echo "[ OK ] Chrome Install Successful!"
    else
        echo "[ FAIL ] Chrome Install Fail! "
        exit 3
    fi
}


VsFtpConf() {
    sed -i 's/^root/#root/' $VSFTPD_FTPUSERS
    sed -i 's/^root/#root/' $VSFTPD_USERLIST
    echo "[ OK ] FTP Configuration Successful!"
}

SshConf() {
    sed -i 's/PermitRootlogin no/PermitRootlogin yes/' $SSHD_CONF 
    sed -i 's/#PermitRootlogin/PermitRootlogin/' $SSHD_CONF
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' $SSHD_CONF
    sed -i 's/#PasswordAuthentication/PasswordAuthentication/' $SSHD_CONF
    echo "[ OK ] SSH Configuration Successful!"
}   

CheckWebSvc() {
    # input : str(nginx|htppd)
    # output : str(nginx|httpd)
    # function : ()
    WEBSVC=$1
    case $WEBSVC in 
        nginx) CHECKWEBSVC=httpd ;;
        httpd) CHECKWEBSVC=nginx ;;
    esac
    systemctl disable --now $CHECKWEBSVC > /dev/null 2>&1
}

NginxConf() {
    echo "NGINX WebServer" > /usr/share/nginx/html/index.html
    echo "[ OK ] NGINX WEB Configuration Complite!"
}

function print_good () {
    echo -e "\x1B[01;32m[ OK ]\x1B[0m $1"
}

function print_error () {
    echo -e "\x1B[01;31m[ FAIL ]\x1B[0m $1"
}

function print_info () {
    echo -e "\x1B[01;34m[ info ]\x1B[0m $1"
}