#!/bin/bash
#|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#| VeChainThor Node Initialization
#|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#| This script is intended to help in installing VeChainThor
#| by making it a one-click process. The main goal of this
#| script is to provide support for multiple Linux distos
#|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#| Version : V 0.0.1
#| Author  : Nasser Alhumood
#| .-.    . . .-.-.
#| |.|.-.-|-.-|-`-..-,.-.. .
#| `-``-`-'-' ' `-'`'-'   `
#|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
clear

# Some Unnecessary Variables, but they're here anyway
version=V0.1.1
oss="CentOS8"

# Welcome Massage
echo -e "\e[1;34;1m+=================================\e[0m"
echo -e "\e[1;34;1m+\e[0m" "VeChainThor Node initializer -  " $version
echo -e "\e[1;34;1m+\e[0m" "supported operating systems: " $oss
echo -e "\e[1;34;1m+=================================\e[0m"
echo
echo

# Making sure you wanna continue
echo "Welcome! Please make sure to be patient and never close this installer until it's done."
echo "This process could take up to 15 minutes and should be done on a fresh server."
echo
read -p "Would you like to continue ? [y/N] "
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo No problem, goodbye!
    exit 0
fi

# Creating a logs folder
mkdir logs

# Hostname Update
read -p "Would you like to update your hostname ? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Current hostname: $(hostname)"
    echo -n "Hostname: "
    read yourhostname
    echo > /etc/hostname
    echo $yourhostname > /etc/hostname
    echo -n "Hostname domain: "
    read hostnamedomain
    echo -n "Public ip: "
    read publicip
    echo "$publicip $hostnamedomain $yourhostname" >> /etc/hosts
    hostnamectl set-hostname $yourhostname
    echo -e "HOSTNAME UPDATE             [\e[1;37;1;1;42m   +done   \e[0m]"
    echo
fi

# Root Password Change
read -p "Would you like to change your root password ? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo passwd
    echo -e "Root Password               [\e[1;37;1;1;42m   +done   \e[0m]"
    echo
fi

# Starting the process
echo "Starting the process:"

# Step 1 : Updating the systems
echo -ne "SYSTEM UPDATE               [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo yum -y update
} > logs/out1.log 2> logs/err1.log
echo -ne "SYSTEM UPDATE               [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Step 2 : Installing epel
echo -ne "EPEL INSTALLATION           [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
    sudo yum -y update
} > logs/out2.log 2> logs/err2.log
echo -ne "EPEL INSTALLATION           [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Step 3 : Installing esential packages
echo -ne "PACKAGES INSTALLATION       [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo yum -y install git nano wget
} > logs/out3.log 2> logs/err3.log
echo -ne "PACKAGES INSTALLATION       [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Step 4 : Installing Development Tools and C
echo -ne "DEVTOOLS AND C INSTALLATION [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo dnf -y groupinstall "Development Tools"
} > logs/out4.log 2> logs/err4.log
echo -ne "DEVTOOLS AND C INSTALLATION [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Step 5 : Installing GO
echo -ne "GO INSTALLATION             [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
    sudo tar -C /usr/local -xf go1.13.5.linux-amd64.tar.gz
    sudo echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
    source /etc/profile
} > logs/out4.log 2> logs/err4.log
echo -ne "GO INSTALLATION             [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# The End
echo
echo -e "\e[31;1m  Awesome, Everything is set, Thank you.  \e[0m"