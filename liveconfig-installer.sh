#!/bin/bash
clear
read -p"Soll LiveConfig installiert werden? (j/n)? " response

if [ "$response" == "j" ]; then
# Ändert die hostname und host Datei
        	clear
        echo "Bitte geben Sie die Subdomain ein (z.B. www)."
        	read subdomain
        echo "Bitte geben Sie den Domainnamen ein."
        	read domain
        echo "Bitte geben Sie die IP Adresse des Servers ein."
        	read ip

        sudo printf "$subdomain">/etc/hostname
        sudo printf "127.0.0.1  localhost\n 127.0.1.1   $subdomain.$domain $subdomain\n ::1             localhost ip6-localhost ip6-loopback\n ff02::1  ip6-allnodes\n ff02::2  ip6-allrouters\n $ip    $subdomain.$domain $subdomain">/etc/$
        hostname -F /etc/hostname
        clear

        echo "Es wird ein Update und Upgrade durchgeführt"
                sleep 2
                sudo apt update && sudo apt upgrade -y
                clear
        echo "Paket ntp wird installiert"
                sleep 2
                sudo apt install ntp -y
                clear
        echo "Paket quota wird installiert"
                sleep 2
                sudo apt install quota -y
                clear
        echo "LiveConfig wird installiert"
                sleep 2
                wget -O - https://www.liveconfig.com/liveconfig.key | sudo apt-key add -
                cd /etc/apt/sources.list.d
                sudo wget http://repo.liveconfig.com/debian/liveconfig.list
                sudo apt install aptitude -y && sudo aptitude update -y && sudo aptitude install liveconfig-meta -y && sudo aptitude install liveconfig -y
# Fehlende Pakete installieren die für ein Webserver notwendig sind
		sudo apt-get install php-mbstring php-fpm spamassassin php-pear apache2-suexec-custom postgrey dbconfig-common dbconfig-mysql javascript-common libjs-jquery -y
                sudo a2enmod proxy_fcgi
		sudo a2enconf php7.2-fpm
		sudo systemctl restart apache2
                clear

        echo "Installation ist abgeschlossen Server wird jetzt neugestartet...."
	sleep 2
	sudo reboot now
fi
