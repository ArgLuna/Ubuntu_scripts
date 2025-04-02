#!/bin/bash

source init.conf.sh

disable_sudo_password() {
    sudo grep -q "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" /etc/sudoers.d/${USER}
    if [[ $? == 0 ]] ; then
        printf "disable sudo password already done. skip.\n"
    else
        logger "disable sudo password...\n"
        echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" | sudo -i tee /etc/sudoers.d/${USER}
        if [[ $? == 0 ]] ; then
            printf "disable sudo password done\n"
        else
            printf "[WARN] disable sudo password fail\n"
        fi
    fi
}

enable_login_as_root_via_ssh() {
    # enable root password
    sudo passwd root
    # TODO: replace PermitRootLogin prohibit-password
    # https://alexhost.com/faq/how-to-enable-root-login-via-ssh-in-ubuntu/
    sudo cat 'PermitRootLogin yes' >> /etc/ssh/sshd_config
    sudo systemctl restart ssh
    printf "enable_login_as_root_via_ssh done\n"
}

if [[ -z "$USER" ]] ; then
    printf "\$USER is not set in init.conf.sh. Abort.\n"
    exit
fi

disable_sudo_password
enable_login_as_root_via_ssh
