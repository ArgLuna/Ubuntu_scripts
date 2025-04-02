#!/bin/bash
USER=""
# set to "y" to install pkgs listed in SERVER_PKGS
IS_SERVER="y"
# set to "y" to remove trailing spaces of shell prompt
# only supprot bash and zsh
RM_SHELL_PROMPT_TAIL_SPACE="n"
BASH_CONF=".bashrc"
ZSH_CONF=".zshrc"
# set timezone
TIMEZONE="Asia/Taipei"

DEFAULT_SHELL="zsh"

HOSTNAME=""

# common pkgs for client and server.
COMMON_PKGS=(vim nmap curl ipython3 scapy cscope hping3 vlan)
# pkgs only resuired for server.
SERVER_PKGS=(apache2 bind9)

# call this function to install pkgs. support both bash and zsh.
install_pkgs() {
    cmd=""
    len=${#COMMON_PKGS[@]}
    sudo apt-get update || exit
    printf "Total ${len} to install\n"
    for ((i=0;i<len;i++)) ; do
        # bash is 0-based but zsh is 1-based. use ":0-based idx:offset" syntax
        # to get correct element.
        pkg=${COMMON_PKGS[@]:$i:1}
        cmd="sudo apt-get install -y ${pkg} || exit"
        printf "${cmd}\n"
        # having some problem on zsh when run cmd direcdtly. let bash take over.
        echo $cmd | bash
        printf "*** ${pkg} install success!\n"
    done
    if [[ $IS_SERVER == "y" ]] ; then
        # Ugly but work.
        len=${#SERVER_PKGS[@]}
        printf "Total ${len} to install for server\n"
        for ((i=0;i<len;i++)) ; do
            pkg=${SERVER_PKGS[@]:$i:1}
            cmd="sudo apt-get install -y ${pkg}"
            printf "${cmd}\n"
            echo $cmd | bash
            printf "*** ${pkg} install success!\n"
        done
    fi
    unset len
    unset i
    unset pkg
    unset cmd
}

# remove trailing spaces from shell prompt. this will change current shell only.
remove_shell_prompt_tail_spaces() {
    curr_shell=`ps -p $(ps -p $$ -o ppid=) -o comm=`
    tmp=""
    shell_conf=""
    if [[ $curr_shell != "bash" && $curr_shell != "zsh" ]] ; then
        # for debugging purpose.
        # source init.conf.sh ; remove_shell_prompt_tail_spaces
        curr_shell=`ps -p $$ -o comm=`
    fi

    printf "Current running shell is ${curr_shell}.\n"
    if [[ $RM_SHELL_PROMPT_TAIL_SPACE == "y" ]] ; then
        if [[ $curr_shell == "bash" ]] ; then
            tmp="export PS1="
            tmp+=$(bash -i -c 'echo $PS1' | sed 's/[[:space:]]*$//')
            shell_conf=${BASH_CONF}
        elif [[ $curr_shell == "zsh" ]] ; then
            tmp="export PROMPT="
            tmp+=$(zsh -i -c 'echo $PROMPT' | sed 's/[[:space:]]*$//')
            shell_conf=${ZSH_CONF}
        else
            printf "Unsupport shell.\n"
            return
        fi
        #shell_conf="tmp.txt"
        printf "The following line will be added to ${shell_conf}\n\n"
        printf "%s\n\n" "$tmp"
        grep -q -F "${tmp}" ./tmp.txt
        if [[ $? == 0 ]] ; then
            printf "Should already set to removing trailing spaces.\n"
            printf "End this operation.\n"
        else
            echo "${tmp}" >> tmp.txt
            printf "Set done. Please login again to apply new config.\n"
        fi
    else
        printf "Skip removing trailing spaces of shell prompt.\n"
    fi
    unset curr_shell
    unset tmp
    unset shell_conf
}

set_default_shell() {
    if [[ $SHELL == *${DEFAULT_SHELL} ]]; then
        printf "${DEFAULT_SHELL} is already set as default.\n"
        return
    else
        printf "Set default shell to ${DEFAULT_SHELL}...\n"
    fi
    chsh -s `which ${DEFAULT_SHELL}` || exit
    sudo chsh -s `which ${DEFAULT_SHELL}` || exit
    printf "Done.\n"
}

set_timezone() {
    printf "Set timezone to ${TIMEZONE}\n\n"
    sudo timedatectl set-timezone $TIMEZONE
    timedatectl
}

disable_auto_update() {
    echo "---------------------------------------------------------"
    echo "Disable Ubuntu auto-upgrade..."
    sudo sed -i 's/APT::Periodic::Update-Package-Lists "1"/APT::Periodic::Update-Package-Lists "0"/'    \
        /etc/apt/apt.conf.d/20auto-upgrades || exit
    sudo sed -i 's/APT::Periodic::Unattended-Upgrade "1";/APT::Periodic::Unattended-Upgrade "0";/'  \
        /etc/apt/apt.conf.d/20auto-upgrades || exit
    echo "---------------------------------------------------------"
}

pub_key_gen() {
    # key gen
    ssh-keygen -t rsa -b 4096 -m pem
    # print pub key
    printf "\n****** Print pub key ******\n\n"
    cat ~/.ssh/id_rsa.pub
    printf "\nAdd key to https://github.com/settings/keys\n"
}

set_hostname() {
    tmp=""
    if [[ -z "$HOSTNAME" ]] ; then
        printf "\$HOSTNAME is not set in init.conf.sh. Keep current hostname\n"
        return
    fi
    if [[ $HOSTNAME == *_* ]] ; then
        printf "hostname cannot contain \"_\"\n"
        return
    fi
    if [[ $HOSTNAME == *"."* ]] ; then
        printf "[WARN] Any substring after \".\" will not be display on terminal prompt.\n"
    fi
    sudo hostnamectl set-hostname $HOSTNAME
    tmp=`hostnamectl status`
    if [[ $tmp == *"Pretty hostname"* ]] ; then
        printf "[WARN] hostname contain invalid char. Please refer to domain name rule.\n"
    else
        sudo systemctl restart systemd-hostnamed
        printf "systemd-hostnamed restart. Please login again to verify changes.\n"
    fi
    unset tmp
}

disable_sudo_password() {
    if [[ -z "$USER" ]] ; then
        printf "\$USER is not set in init.conf.sh. Did not disable sudo password.\n"
        return
    fi
    sudo grep -q "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" /etc/sudoers.d/${USER}
    if [[ $? == 0 ]] ; then
        printf "disable sudo password already done. skip.\n"
    else
        printf "disable sudo password...\n"
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
    sudo echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
    sudo systemctl restart ssh
    printf "enable_login_as_root_via_ssh done\n"
}
