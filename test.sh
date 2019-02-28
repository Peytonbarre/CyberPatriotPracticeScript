#!/bin/bash
#Created by Peyton Barre and Raphael Cacho
unalias -a #Get rid of aliases
echo "unalias -a" >> ~/.bashrc
echo "unalias -a" >> /root/.bashrc
PWDthi=$(pwd)

startgey()
{

	clear

	clamgey
	updategey
	passagegey

	printf "\033[1;31mDone!\033[0m\n"
}


#Updates Linux using apt-get
updategey(){

	sudo apt-get upgrade
	sudo apt-get clean

	cont
}




#Installs and run all of the ClamAv functions
clamgey(){
	
	printf "Downloading ClamAv..."
	sudo apt-get install clamav

	cont
}


#Changes the password min/max age
passagegey(){

	sed 's/99999/90/g' /etc/login.defs

	

	cont
}

startgey
