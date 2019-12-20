# VeChainThor-initialization
Version : 0.1.3  
One script that does it all, updates your system, enable required repos, install essential packages, and more..
And most importantly it makes your system ready for VeChainThor node and also installs it!
currently supports : Centos8, and more to come.

###### Features:
- Update your system
- Enable/Add EPEL
- Setup your hostname
- Change root password
- Install essential packages (nano, wget, git)
- Install the Development Tools and C language for the node support
- Install GO language (go1.13.5) and set it up for system-wide use
- Install and make thor
- You can choose to install the dependencies and set up the server without installing thor

###### How to use
1. Login as root
`sudo su`
2. Install git
`sudo yum -y install git`
3. Clone the repository 
`git clone https://github.com/nooh43/VeChainThor-initialization.git`
4. Browse the folder
`cd VeChainThor-initialization`
5. Give the permissions
`chmod +x install.sh`
6. Launch the script
`sudo ./install.sh`

###### Author
Nasser Alhumood - [QatifServ](http://qatifserv.com/)
nasser@nasserh.com