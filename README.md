# update-all-for-pbs
Updates all LXC-Containers

Currently only checks for apt-get (Debian/Ubuntu) and pacman/paru (Arch Linux). Arch Linux does have the additional reliance on the package "which", which is not installed by default. Could check for hardcoded paths ig, but nah...
