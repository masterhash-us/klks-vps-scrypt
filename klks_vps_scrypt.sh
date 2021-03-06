#!/bin/bash
# This script is a derivative work of the code from the following projects:
# Galactrum - https://www.galactrum.org/
# Innova Coin - https://innovacoin.info/
# and this copy was pulled from github user Drhobbi

# Modified for klks by ak3

REL="$(lsb_release -rs)"

clear
cd ~
cat <<'klks'
  		                -/sydmNNNNmdhs+-`
         	            `+hNmdddhyysssyhdddmNdo.
                         :hMmdhso/::::::::::/osyddMd/
                       -dMdhy+::::oo::::::+s::::/yhhNm:
                      oMdhy:::::::yMmo::+dMh:::::::shhMy`
                     yMhh/::::::::yMMMyoMMMh::::::::/dyMd`
                    sMhd//////::::yMMMhsMMMh::::+++++/dyMh
                   -Mdd/:+dMMMNy::yMMMhsMMMh::sNMMMmo:/mhM/
                   sMyh::::+dMMMNyhMMMhsMMMdsNMMMmo::::yyMd
                   dMyo::::::+dMMMMMMMhsMMMMMMMmo::::::ohNM
                   dMyo::::::/hMMMMMMMhsMMMMMMMd+::::::ohNM
                   sMyh::::/hMMMMhhMMMhsMMMdyNMMMd+::::yyMd
                   -Mdd/:/hMMMMh/:yMMMhsMMMh:/yNMMMd+:/myM/
                    sMyd/ooooo/:::yMMMhsMMMh:::/ooooo/dyMh
                     yMyh/::::::::yMMMysMMMh::::::::/dyNd`
                      oMdhs:::::::yMNs::omMh:::::::shhMy`
                       -dNdhs/::::os::::::oy::::/shhNm:
                         :hNddys+/:::::::::::+syddNd/
                           .+hNmddhyssssssyhdddNdo.
                               -+shdmNmmNmdhs+-`
klks
echo && echo && echo
sleep 1
cat << "klks1"
MM    MM   AAA    SSSSS  TTTTTTT EEEEEEE RRRRRR  NN   NN  OOOOO  DDDDD   EEEEEEE
MMM  MMM  AAAAA  SS        TTT   EE      RR   RR NNN  NN OO   OO DD  DD  EE
MM MM MM AA   AA  SSSSS    TTT   EEEEE   RRRRRR  NN N NN OO   OO DD   DD EEEEE
MM    MM AAAAAAA      SS   TTT   EE      RR  RR  NN  NNN OO   OO DD   DD EE
MM    MM AA   AA  SSSSS    TTT   EEEEEEE RR   RR NN   NN  OOOO0  DDDDDD  EEEEEEE
................................................................................
klks1
echo && echo && echo
sleep 1

    # Gather input from user
    read -e -p "Masternode Private Key (In your main wallet: type command masternode genkey in the Debug console. Result e.g. 7edfjLCUzGczZi3JQw8GHp434R9kNY33eFyMGeKRymkB56G4324h) : " key
    if [[ "$key" == "" ]]; then
        echo "WARNING: No private key entered, exiting!!!"
        echo && exit
    fi
    ip=$(dig +short -6 myip.opendns.com aaaa @resolver1.ipv6-sandbox.opendns.com)
    echo && sleep 1
       
    # Update system 
    echo && echo "Upgrading system..."
    sleep 3
    sudo apt-get -y update
    sudo apt-get -y dist-upgrade

    # Add Berkely PPA
    echo && echo "Installing bitcoin PPA..."
    sleep 3
    sudo apt-get -y install software-properties-common pwgen unzip libevent-dev libgmp3-dev libssl-dev bsdmainutils nano htop pwgen
    sudo apt-add-repository -y ppa:bitcoin/bitcoin
    sudo apt-get -y update

    # Install required packages
    echo && echo "Installing base packages..."
    sleep 3
    sudo apt-get -y install \
        libboost-all-dev \
        libdb4.8-dev \
        libdb4.8++-dev
    if [ "16.04" == "${REL}" ]; then
    sudo apt-get -y install libzmq5 libminiupnpc10
    else
    sudo apt-get -y install libzmq3 libminiupnpc8
    fi

    # Install fail2ban if needed
        echo && echo "Installing fail2ban..."
        sleep 3
        sudo apt-get -y install fail2ban
        sudo service fail2ban restart 
    
    # Install firewall if needed
        echo && echo "Installing UFW..."
        sleep 3
        sudo apt-get -y install ufw
        echo && echo "Configuring UFW..."
        sleep 3
        sudo ufw default deny incoming
        sudo ufw default allow outgoing
        sudo ufw allow ssh
        sudo ufw limit ssh/tcp
        sudo ufw allow 51121/tcp
        sudo ufw logging on
        echo "y" | sudo ufw enable
        echo && echo "Firewall installed and enabled!"
   
    # Download klks-Coin
    echo && echo "Downloading KLKS sources"
    sleep 3
    cd ~
    wget -t0 -c "https://github.com/kalkulusteam/klks/releases/download/2.7.0/klks-2.7.0_linux64.tar.gz"
    tar -xvf "klks-2.7.0_linux64.tar.gz"

    chmod +x ~/klks-2.7.0_linux64/klks-cli ~/klksd
    sudo cp -f ~/klks-2.7.0_linux64/klks-cli /usr/local/bin
    sudo cp -f ~/klks-2.7.0_linux64/klksd /usr/local/sbin

    #Checking if we are under root user and creating unpriviliged account
    myuser="$(whoami)"
    klksmnuser="klksmn"

    #Creating klks unprivileged user for klks daemon
    echo && echo "Creating 'klksmn' unprivileged user"
    sudo useradd ${klksmnuser} -s /usr/sbin/nologin

    #Creating configuration directory
    echo && echo "Creating configuratoin directory"
    sudo mkdir -p /home/${klksmnuser}/.klks
    sudo chown ${myuser}:${klksmnuser} -R /home/${klksmnuser}
    sudo chmod 770 -R /home/${klksmnuser}


    datadir="-datadir=/home/${klksmnuser}/.klks"
    OPTIONS="${datadir} -daemon"

    #Adding aliases
    echo -e "\nalias klks-cli='sudo -u ${klksmnuser} klks-cli ${datadir}'\nalias klksd='sudo -u ${klksmnuser} klksd ${datadir}'\n" >> ~/.bash_aliases
    . ~/.bash_aliases

    # Create config for klks-Coin
    echo && echo "Configuring klks-Coin..."
    sleep 3

    sudo -u ${klksmnuser} klksd ${OPTIONS} >/dev/null 2>&1
    sleep 5

    sudo chown ${myuser}:${klksmnuser} /home/${klksmnuser}/.klks/klks.conf

    rpcuser=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
    rpcpass=`pwgen -1 20 -n`

    echo -e "maxconnections=64\nrpcuser=${rpcuser}\nrpcpassword=${rpcpass}\nrpcallowip=127.0.0.1\nlisten=1\nserver=1\ndaemon=1\nstaking=0\nexternalip=${ip}\nmasternode=1\nmasternodeprivkey=${key}\naddnode=209.250.242.79:51121\naddnode=45.63.99.2:51121\naddnode=45.77.226.205:51121\naddnode=199.247.28.77:51121\naddnode=45.32.151.186:51121\naddnode=[2001:67c:27e4:11::68f8:ac18]:51121\naddnode=[2001:19f0:5001:2f19:2111::1]:51121\naddnode=[2001:19f0:5001:2637:2111::2]:51121\naddnode=[2001:19f0:5001:2637:2111::4]:51121\naddnode=[2a01:6e60:10:aa4:65b4::1]:51121\naddnode=[2001:19f0:5001:2637:2111::3]:51121" > /home/${klksmnuser}/.klks/klks.conf

    echo && echo "Starting klks-Coin daemon"
    sudo -u ${klksmnuser}  klksd ${OPTIONS}

    cd ~
     echo "installation COMPLETE"

