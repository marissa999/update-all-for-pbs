#!/bin/bash

echo "Updating all running containers..."

CONTAINERS=( $(pct list | grep running | awk '{print $1}') )

for CONTAINER in ${CONTAINERS[@]}
do
	echo "Updating $CONTAINER"

        # Debian/Ubuntu, apt-get
        if pct exec $CONTAINER -- which apt-get > /dev/null 2>&1; then
		echo $CONTAINER contains apt-get
		pct exec $CONTAINER -- apt-get update
		pct exec $CONTAINER -- apt-get dist-upgrade -y
		pct exec $CONTAINER -- apt-get clean
		pct exec $CONTAINER -- apt-get autoremove -y
        fi

	# Arch Linux, Pacman
	if pct exec $CONTAINER -- which pacman > /dev/null 2>&1; then
		echo $CONTAINER contains Pacman
                pct exec $CONTAINER -- pacman -Sy archlinux-keyring --noconfirm
		pct exec $CONTAINER -- pacman -Syyu --noconfirm
	fi

        # Arch Linux, Paru
        if pct exec $CONTAINER -- which paru > /dev/null 2>&1; then
                echo $CONTAINER contains Pacman
                pct exec $CONTAINER -- pacman -Sy archlinux-keyring --noconfirm
                pct exec $CONTAINER -- sudo -u user /sbin/paru -Syyu --noconfirm
        fi

done
