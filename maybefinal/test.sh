#!/bin/bash
#Created by Peyton Barre
unalias -a #Get rid of aliases
echo "unalias -a" >> ~/.bashrc
echo "unalias -a" >> /root/.bashrc
PWDthi=$(pwd)

a=0
b=0
c=0

startpey()
{

	clear
	passpey
	updatepey
	clampey
	passagepey
	ufwpey
	sshpey
	peyuserdel
	guestpey
	norootpey
	adminaddpey
	
	printf "\033[1;31mDone!\033[0m\n"
}



passpey(){
	printf "\033[1;31mTask finsihed... proceed?(Y/N)\033[0m\n"
	read contyn
	if [ "$contyn" = "N" ] || [ "$contyn" = "n" ]; then
		printf "\033[1;31mAborted\033[0m\n"
		exit
	fi
	clear
}

#Updates Linux using apt-get
updatepey(){

	printf"\033[1;31mUpdating ubuntu!\033[0m\n"
	sudo apt-get upgrade
	sudo apt-get clean
	passpey
}

#Installs and run all of the ClamAv functions
clampey(){
	
	printf "Downloading ClamAv..."
	sudo apt-get install clamav
	passpey
}

#Changes the password min/max age
passagepey(){

	printf "\033[1;31mChanging password requirements...\033[0m\n"
	
	
	#Start 99999
	CUR_DAYS=`cat /etc/login.defs | grep PASS\_MAX\_DAYS | head -n 2 | tail -n 1 | cut -f2`

	if [ $CUR_DAYS == 99999 ]

		then
		sed -i '160s/99999/90/g' /etc/login.defs
		echo "99999 has been changed to 90!"
	else
		echo "Not 99999!"
	fi
	#End 99999
	
	

	#Start 0
	CUR_DAYS0=`cat /etc/login.defs | grep PASS\_MIN\_DAYS | head -n 2 | tail -n 1 | cut -f2`

	if [ $CUR_DAYS0 == 0 ]
	then
		sed -i '161s/0/7/g' /etc/login.defs
		echo "0 has been changed to 7!"		
	else
		echo "Not 0!"
	fi
	#End 0



	#Start 7
	CUR_DAYS7=`cat /etc/login.defs | grep PASS\_WARN\_AGE | head -n 2 | tail -n 1 | cut -f2`

	if [ $CUR_DAYS7 == 7 ]
	then
		sed -i '162s/7/14/g' /etc/login.defs
		echo "7 has been changed to 14!"
	else
		echo "Not 7!"
	fi
	#End 7	
	passpey
	
}

#Installs and enables Ubuntu Firewall;
ufwpey(){
	
	printf "\033[1;31mInstalling Ubuntu Fire Wall\033[0m\n"
	sudo apt-get install ufw
	printf "\033[1;31mUpgrading UFWl\033[0m\n"
	sudo apt-get upgrade ufw
	printf "\033[1;31mActivating UFW\033[0m\n"
	sudo ufw enable
	passpey
}

#Installs and disables SSH login
sshpey(){

	printf "\033[1;31mDownloading SSH...\033[0m\n"
	sudo apt-get install ssh
	sudo service ssh start
	printf "\033[1;31mDisabling SSH root login...\033[0m\n"
	sed -i '28s/without-password/no/g' /etc/ssh/sshd_config
	passpey
}



peyuserdel(){
	
	array=()
	while IFS= read -r -p "Next user... (end with an empty line): " line; do
    		[[ $line ]] || break  # break if line is empty
    		array+=("$line")
	done
	
	for i in ${array[@]}; do
	
		userdel ${array[$a]}
		a+=1
	done

	printf '%s\n' "Users deleted:"
	printf '«%s»\n' "${array[@]}"
	passpey
}

guestpey(){

	echo "removing all guests..."
	echo "allow-guest=false" >> /etc/lightdm/lightdm.conf.d
	passpey
}

norootpey(){


	sed -i '28s/yes/no/g' /etc/ssh/sshd_config
	echo "Root has been disabled!"
	passpey
}

adminaddpey(){

	arrayad=()
	while IFS= read -r -p "Next user... (end with an empty line): " linepow; do
    		[[ $linepow ]] || break  # break if line is empty
    		arrayad+=("$linepow")
	done
	
	while [[ $b -le 5 ]]; do
	
		usermod -a -G sudo ${arrayad[$b]} 
		b+=1
	done

	printf '%s\n' "Admin Powers added to:"
	printf '«%s»\n' "${arrayad[@]}" 
	passpey
}



startpey
