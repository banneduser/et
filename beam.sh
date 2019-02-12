#!/bin/bash

# beam.sh is where most of the et action currently takes place
# It contains no code involved in setting up and viewing the state of a cluster.
# beam.sh solely deals with performing actions inside the cluster, based on it's current configuration.
# For example, 'beam up' opens an SSH connection to the direct upstream of the current node.

MY_IP=$(ifconfig | grep broadcast | awk '{print $2}')
# termux SSH port...
SSH_PORT=8022

remote_exec () { ssh "$UPSTREAM" -p $SSH_PORT $1 }

# opens an SSH connection to, or runs a command on, the local upstream
if [ "$1" == "up" ]
then
	if [ "$#" -eq 1 ]
	then
		ssh "$UPSTREAM" -p $SSH_PORT
	else
		ssh "$UPSTREAM" -p $SSH_PORT $2
	fi

# opens an SSH connection to, or runs a command on, the phone
elif [ "$1" == "phone" ]
then
	if [ "$#" -eq 1 ]
	then
		ssh "$PHONE_IP" -p $SSH_PORT
	else
		ssh "$PHONE_IP" -p $SSH_PORT $2
	fi

# Creates an account on the local machine matching the et identity file
elif [ "$1" == "become" ] # Tommyknockers allusion =)
then
	my_identity=$(remote_exec "cat .et/identity")
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

# Installs programs cached on upstream
elif [ "$1" == "form" ]
then
	list_apt=$(remote_exec "cat .et/terraform/apt")
	list_snap=$(remote_exec "cat .et/terraform/snap")
	sudo apt install $list_apt -y
	sudo snap install $list_snap

# Installs vim configuration stored on upstream
elif [ "$1" == "vim" ]
then
	list_vim=$(remote_exec "cat .et/terraform/vim")
	vim_loc=$(which vim)
	sudo apt install vim
	wget https://github.com/tpope/vim-pathogen/blob/master/autoload/pathogen.vim

# Creates a reverse runnel on upstream leading to local
elif [ "$1" == "mirror" ]
then
	LOCALPORT=$2
	REMOTEPORT=$3

	remote_exec "nc -v -l -k -p $REMOTEPORT -c \"nc 192.168.43.201 $LOCALPORT\""

# Recall a string on upstream
elif [ "$1" == "recall" ]
then
	remote_exec "echo \"$2\" >> .et/recall"

# Back up your current user directory on upstream
elif [ "$1" == "backup" ]
then
	date
	echo "Beginning backup (rsync)"
	BACKUP_PATH="/data/data/com.termux/files/home/.et/backups/" 
	rsync --progress --stats --delete -e "ssh -p 8022" -a --exclude=".*/" --exclude=~/.cache ~ user@$UPSTREAM:$BACKUP_PATH 
	echo "Backup complete"
else
	echo "unknown arg"
fi

