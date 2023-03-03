배시 쉘 프로그래밍

1. 선수 지식
	1) 명령어 
		grep CMD
			# grep OPTIONS PATTERNS file1
			OPTIONS : -i, -v, -l, -n, -r, -w
			PATTENS : *, ., ^root, root$, [abc], [a-c], [^a]   (''는 안의 내용을 해석하지 않음, ""는 해석)
		sed CMD
			p CMD) # sed -n '1,3p' /etc/hosts
			p CMD) # sed '1,3d' /etc/hosts
			p CMD) # sed '/main/s/192.168.10.10/192.168.10.20/' /etc/hosts
		awk CMD
			# awk 'statement {action}' file
			Ex. # df -h / | tail -1 | awk '{print $6}' | awk -F% '{print $1}'
				# ifconfig eth0 | grep inet | grep -v inet6 | awk '{print $2}' | awk -F: '{print $2}'
		+
		
		CMD(sort CMD, )
		
	2) 쉘의 특성
		* Redirection(<, 0<, >, 1> >>, 1>>, 2>, 2>>)
		* Pipe(|)
		* Variable()
		* Metacharacter('', "", ``, ;)
		* History
		* Alias
		* Function
			(선언)fun() {CMD; CMD;}
			(실행)fun
			(확인)typeset -f
			(해제)unset -f fun
		* Environment File(s)(/etc/profile, ~/.bash_profile, ~/.bashrc
		
		* cat CMD
		* Grouping 
		* &&, ||
			* A && B
			* A && B || C
			* A || B
		* dirname/basename CMD

2. Shell Script/Shell Programing
	
	1) 프로그램 작성과 실행
		# bash -x script.sh
		# . ~/.bashrc
		# vi script.sh ; chmod -x script.sh ; ./script.sh
		[참고] 매직넘버 (#!/bin/bash)

	2) 주석처리
		* 한줄 주석	- #
		* 여러줄 주석	- : << EOF ~ EOF
	
	3) 입력 & 출력
		출력 : echo CMD, printf CMD (echo -n)
		입력 : read CMD
	
	4) 산술연산(소수점은 인식 못함)
		# expr 1 + 2 (공백필요)
		# expr 3 - 1 
		# expr 3 \* 3 (곱셈은 * 앞에 \ 필요)
		# expr 10 / 2  
		# expr 10 % 3
		
	5) 조건문 : if 문, case 문
		
		* if 구문
			if 조건; then
				statement1
			elif 조건 ; then
				statement2
			else
				statement3
			fi
			
		* case 문
			case VAR in
				조건1) statement1 ;;         * ;; 는 C의 break와 같음
				조건2) statement2 ;;
				*)	  statement3 ;;
			esac	
6) 반복문 : for 문, while 문
	* for 문 : for 문 + seq CMD
		for var in var_list
		do
			statement
		done
	* while 문 : while 문 + continue/break
		while 조건
		do
			statement
		done
7) 함수
	선언)
		func() { CMD; CMD; }
		function func { CMD; CMD; }
	실행) fun
	확인) typeset -f
	해제) unset -f func
	
	함수 입력 : 인자($1, $2, $3....)
	함수 출력 : echo $RET
	
8) IO 리다이렉션 자식 프로세스
	for LINE in $(cat file1)
		do
			echo $LINE
		done

	
	cat file1 | while read LINE
	do
		echo $LINE
	done > file2
		
		-> 하나의 라인에 여러개의 입력값이 있을 경우 더 효율적

9) 시그널 제어
	* 시그널 무시
	* 시그널을 받으면 개발자가 원하는 동작
	
10) 디버깅
		* # bash -x script.sh
		* # bash -xv script.sh
		
11) 옵션 처리
	getopts CMD + while CMD + case CMD
	(EX) # ssh.sh -p 80 192.168.10.20
	while getopts p: options
	do
		case $option in
			p) p_ACTION ;;
			\?> Usage : ;;
			*) Usage : ;;
		esac
	done
	
	shift $(expr $OPTIND - 1)
	if [ $# -ne 1 ] ; then
		Usage
	fi
	echo "$# : $@"

------------------------------------------------------------------------------------
vscode 설치
------------------------------------------------------------------------------------	
	IDE(vscode) -> 통합 개발 환경
		* LINUX) vscode
			# nmtui 
				- DNS를 지운다(내부)
			vscode를 다운로드한다.
			# yum localhost 다운받은 파일이름
			# code --no-sandbox --user-data-dir ~/workspace
				-> alias 에 지정한다.
			# code
			vscode 에서 Bash IDE 와 Bash Debug를 설치한다.
		* WINDOWS) vscode
		
		
		
		ENV1.sh : 환경설정 
		* $HOME/.bashrc
		------------------------
#
# Sfecific configuration
#
export PS1='\[\e[31;1m\][\u@\h\[\e[33;1m\] \w]\$ \[\e[m\]'
alias lsf='ls -l | grep "^-"'
alias lsd='ls -l | grep "^d"'
alias ls='ls --color=auto -h -F'
alias c='clear'
alias cear='clear'
alias clar='clear'
alias pps='ps -ef | head -1 ; ps -ef | grep $1'
alias nstate='netstat -antup | head -2 ; netstat -antup | grep $1'
alias tree='env LANG=C tree'
alias vi='/usr/bin/vim'
alias grep='grep --color=auto -i'
alias df='df -h -T'
alias chrome='/usr/bin/google-chrome --no-sandbox'
alias RS='rsync -avz --delete -e ssh'
alias LS='rsync -av --delete'
alias fwcmd='firewall-cmd'
alias fwlist='firewall-cmd --list-all'
alias fwreload='firewall-cmd --reload'
		------------------------
		ENV2.sh : 필요한 패키지 설치
			* 패키지 설치 (gcc, vscode, php, chrome)
		
		rpm --import https://packages.microsoft.com/keys/microsoft.asc
		sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
		
		sh -c 'echo -e 
		cat << EOF > /etc/yum.repos.d/vscode.repo
		[code]
		nname=Visual Studio Code
		baseurl=https://packages.microsoft.com/yumrepos/vscode
		enabled=1
		gpgcheck=1
		gpgkey=https://packages.microsoft.com/keys/microsoft.asc
		EOF
		
		yum install code
		
		
		sudo dnf localinstall google-chrome-stable_current_x86_64.rpm
		yum localinstall google-chrome-stable_current_x86_64
		
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -O /root/bin/aa.rpm
		yum localinstall /root/bin/aa.rpm
		
		* wget
		* curl
		
		ENV3.sh : 서버 세팅
			* telnet (root 사용자 접속 가능)
				# yum -y install telnet telnet-server
				# systemctl enable telnet.socket
			* ftp 서버 (root 사용자 접속 가능)
				# yum -y install vsftpd ftp
				# sed -i '/^root/#root/' /etc/vsftpd/ftpusers
				# sed -i '/^root/#root/' /etc/vsftpd/user_list
				# systemctl enable --now vsftpd.service
			* ssh 서버 (root 사용자 접속 가능)
				# yum -y install openssh-server openssh-clients openssh
				# sed -i 's/PermitRootlogin no/PermitRootlogin yes/' /etc/ssh/sshd_config
				# sed -i 's/#PermitRootlogin/PermitRootlogin/' /etc/ssh/sshd_config
				# sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
				# sed -i 's/#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
				# systemctl enable --now sshd.service
			* nginx web 서버 (index.html)
				# yum -y install nginx
				# echo "Nginx Web Server" > /usr/share/nginx/html/index.html
				# systemctl enable --now nginx.service
				
				
				nmcli connection | grep -vw ' -- ' | tail -n +2 | awk '{print $4}'
				nmcli connection | grep -vw ' -- ' | tail -n +2 | wc -l
