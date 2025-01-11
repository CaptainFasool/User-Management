#!/bin/bash

username=$1

if [[ -z "$username" ]]; then # Input validation
	echo "Specify username as argument."
	exit 1
fi

if getent passwd | grep "$username" >> /dev/null; then # Queries passwd DB and searches for username. If exists, displays user's groups and home directory.
	echo "GROUPS -" $(groups "$username")
	echo "HOME DIRECTORY -" $(getent passwd | grep "$username" | awk -F: '{print $6}')
else
	sudo useradd "$username" && sudo passwd "$username" && sudo usermod -aG users "$username" # Creates user, adds to users group, and sets a password.
	echo "New user $username has been added to the system."
fi

