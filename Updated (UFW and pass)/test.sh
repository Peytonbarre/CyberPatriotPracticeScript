#!/bin/bash
#Created by Peyton Barre and Raphael Cacho
unalias -a #Get rid of aliases
echo "unalias -a" >> ~/.bashrc
echo "unalias -a" >> /root/.bashrc
PWDthi=$(pwd)

startpey()
{

	clear

	updatepey
	clampey
	passagepey
	ufwpey

	printf "\033[1;31mDone!\033[0m\n"
}


#Updates Linux using apt-get
updatepey(){

	sudo apt-get upgrade
	sudo apt-get clean

}




#Installs and run all of the ClamAv functions
clampey(){
	
	printf "Downloading ClamAv..."
	sudo apt-get install clamav

}


#Changes the password min/max age
passagepey(){

	printf "\033[1;31mChanging password requirements...\033[0m\n"
	
	sed -i '160s/99999/90/g' /etc/login.defs
	sed -i '161s/0/7/g' /etc/login.defs
	sed -i '162s/7/14/g' /etc/login.defs
	

}

#Installs and enables Ubuntu Firewall;
ufwpey(){
	
	printf "\033[1;31mInstalling Ubuntu Fire Wall\033[0m\n"
	sudo apt-get install ufw
	printf "\033[1;31mUpgrading UFWl\033[0m\n"
	sudo apt-get upgrade ufw
	printf "\033[1;31mActivating UFW\033[0m\n"
	sudo ufw enable
}


startpey
