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
version=V0.1.3
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
    sudo source /etc/profile
} > logs/out5.log 2> logs/err5.log
echo -ne "GO INSTALLATION             [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Making sure the user wants to install thor
echo
echo "Congrats, your platform is ready now!"
echo "But we would like to ask you one more time :"
echo
read -p "Would you like to install VeChainThor Node in your system? [y/N] "
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo No problem, at least you can install Thor whenevery you need now. Goodbye!
    exit 0
fi

# Clear the interface and start the process of installing the node
clear
echo -e "\e[1;34;1m+=================================\e[0m"
echo -e "\e[1;34;1m+\e[0m" "VeChainThor Node initializer -  " $version
echo -e "\e[1;34;1m+\e[0m" "supported operating systems: " $oss
echo -e "\e[1;34;1m+=================================\e[0m"
echo
echo
echo "We will start installing the node right now!"

# Step 6 : Creating the directories
echo -ne "DOWNLOADING THE NODE        [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo mkdir ~/go
    sudo git clone https://github.com/vechain/thor.git
    sudo mv thor ~/go/thor
} > logs/out6.log 2> logs/err6.log
echo -ne "DOWNLOADING THE NODE        [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Step 7 : Dependency management
echo -ne "DEPENDENCY MANAGEMENT       [\e[1;30;1;1;47min progress\e[0m]\r"
{
    cd ~/go/thor
    sudo make dep
} > logs/out7.log 2> logs/err7.log
echo -ne "DEPENDENCY MANAGEMENT       [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Step 8 : Building
echo -ne "BUILDING THE NODE           [\e[1;30;1;1;47min progress\e[0m]\r"
{
    cd ~/go/thor
    sudo make all
} > logs/out7.log 2> logs/err7.log
echo -ne "BUILDING THE NODE           [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Conclution
echo "Great! I think that your node is set up and ready"
echo "you can access it in ~/go/thor"
echo "If you think there is an error, you can check the log folder generated by this app and see the steps in details." 
echo

# The End
echo
echo -e "\e[31;1m  Well! Awesome! Everything is set, Thank you.  \e[0m"