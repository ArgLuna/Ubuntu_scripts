#!/bin/bash

source init.conf.sh

disable_sudo_password() {
    sudo grep -q "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" /etc/sudoers.d/${USER}
    if [[ $? == 0 ]] ; then
        logger "disable sudo password already done. skip.\n"
    else
        logger "disable sudo password...\n"
        echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" | sudo -i tee /etc/sudoers.d/${USER}
        if [[ $? == 0 ]] ; then
            logger "disable sudo password done\n"
        else
            logger "[WARN] disable sudo password fail\n"
        fi
    fi
}

enable_login_as_root_via_ssh() {
    # enable root password
    sudo passwd root
    sudo -i
    # TODO: replace PermitRootLogin prohibit-password
    # https://alexhost.com/faq/how-to-enable-root-login-via-ssh-in-ubuntu/
    cat 'PermitRootLogin yes' >> /etc/ssh/sshd_config
    systemctl restart ssh
    exit
}

git_key_gen() {
    sudo -i
    # key gen
    ssh-keygen -t rsa -b 4096 -m pem
    # print pub key
    printf "\n****** Print pub key ******\n"
    cat .ssh/id_rsa.pub
    printf "\nAdd key to https://github.com/settings/keys\n"
    exit
}

if [[ -z "$USER" ]] ; then
    printf "\$USER is not set in init.conf.sh. Abort.\n"
    exit
fi

disable_sudo_password
enable_login_as_root_via_ssh
