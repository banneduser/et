#!/bin/bash

PHONE=$UPSTREAM # For now, there should be some sort of distinction coming around later.
SSH_PORT=8022

remote_exec () { 
	ssh "$UPSTREAM" -p $SSH_PORT $1 
}

if [ $1 == "up" ]
then
	if [ "$#" -eq 1 ]
	then
		ssh "$UPSTREAM" -p $SSH_PORT
	else
		ssh "$UPSTREAM" -p $SSH_PORT $2
	fi

elif [ $1 == "phone" ]
then
	if [ "$#" -eq 1 ]
	then
		ssh "$PHONE" -p $SSH_PORT
	else
		ssh "$PHONE" -p $SSH_PORT $2
	fi

elif [ $1 == "become" ] # Tommyknockers allusion =)
then
	my_identity=$(remote_exec "cat ufo/identity")
	echo "Identity: \"$my_identity\""
	echo "Would you like to set up a user account on this system matching your identity? [yN]"
	read affirmation
	if [ $affirmation == "y" || $affirmation == "Y" ]
	then
		echo "Enter desired password: "
		read -s my_password
		echo "Understood"
		sudo useradd "$my_identity" -p \"$my_password\" -m
	else
		echo "Understood. Aborting"
	fi

elif [ $1 == "terraform" ]
then
	list_apt=$(remote_exec "cat ufo/terraform/apt")
	list_snap=$(remote_exec "cat ufo/terraform/snap")
	sudo apt install $list_apt -y
	sudo snap install $list_snap

elif [ $1 == "vim" ]
then
	list_vim=$(remote_exec "cat ufo/terraform/vim")
	vim_loc=$(which vim)
	wget https://github.com/tpope/vim-pathogen/blob/master/autoload/pathogen.vim

elif [ $1 == "mirror" ]
then
	LOCALPORT=$2
	REMOTEPORT=$3

	remote_exec "nc -v -l -k -p $REMOTEPORT -c \"nc 192.168.43.201 $LOCALPORT\""

else
	scp -P $SSH_PORT -r -v ~/ufo/* -P $UPSTREAM:"/data/data/com.termux/files/home/ufo/" 
	echo "Transfer complete"
fi
