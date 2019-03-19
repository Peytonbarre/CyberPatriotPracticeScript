#!/bin/bash
#Created by Peyton Barre and Raphael Cacho
unalias -a #Get rid of aliases
echo "unalias -a" >> ~/.bashrc
echo "unalias -a" >> /root/.bashrc
PWDthi=$(pwd)

a=0


startgey()
{

	clear

	updategey
	clamgey
	passagegey
	ufwgey
	sshgey
	delusegey

	printf "\033[1;31mDone!\033[0m\n"
}

#Updates Linux using apt-get
updategey(){

	sudo apt-get upgrade
	sudo apt-get clean

}

#Installs and run all of the ClamAv functions
clamgey(){
	
	printf "Downloading ClamAv..."
	sudo apt-get install clamav

}

#Changes the password min/max age
passagegey(){

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

	
}

#Installs and enables Ubuntu Firewall;
ufwgey(){
	
	printf "\033[1;31mInstalling Ubuntu Fire Wall\033[0m\n"
	sudo apt-get install ufw
	printf "\033[1;31mUpgrading UFWl\033[0m\n"
	sudo apt-get upgrade ufw
	printf "\033[1;31mActivating UFW\033[0m\n"
	sudo ufw enable
}

#Installs and disables SSH login
sshgey(){

	printf "\033[1;31mDownloading SSH...\033[0m\n"
	sudo apt-get install ssh
	sudo service ssh start
	printf "\033[1;31mDisabling SSH root login...\033[0m\n"
	sed -i '28s/without-password/no/g' /etc/ssh/sshd_config

}



delusegey(){
	
	array=()
	while IFS= read -r -p "Next user... (end with an empty line): " line; do
    		[[ $line ]] || break  # break if line is empty
    		array+=("$line")
	done
	
	while [[ $a -le 5 ]]; do
	
		userdel ${array[$a]}
		a+=1
	done

	printf '%s\n' "Users deleted:"
	printf '«%s»\n' "${array[@]}" 
	
}

startgey
