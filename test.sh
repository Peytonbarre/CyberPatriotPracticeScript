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

	printf "\033[1;31mDone!\033[0m\n"
}

clamgey(){
	
	printf "Downloading ClamAv..."
	sudo apt-get install clamav

}

startgey
