#!/bin/bash
#!/usr/bin/expect -f
#set pass "test"

sudo apt-get update

#sudo apt-get install -y git #Installiert git um Dateien von Github zu laden

sudo apt-get install -y apache2 samba samba-common smbclient #installiert apache server, samba & samba common +smbclient

#Für die Samba-Grundkonfiguration gibt es eine zentrale Konfigurationsdatei "/etc/samba/smb.conf".
#Diese Datei ist in der Vorkonfiguration äußerst umfangreich und dadurch unübersichtlich.
#Für eine einfache Grundkonfiguration empfiehlt sich die Datei umzubenennen und neu zu erstellen.

sudo git clone https://github.com/Geeroy92/Geeroy92.git /home/git/code #Lädt Dateien von Github

sudo chmod 777 -R /home/git/

sudo cp /home/git/code/smb.conf /etc/samba/ #Kopiert die Datei aus dem Downloadordner an die richtige Stelle.

sudo service smbd restart
sudo service nmbd restart

sudo smbpasswd -a pi #Passwortvergabe für den User Pi


#Userabfrage ob die CPU Temp als Service erstellt werden soll? 

getAntwort(){

    read -p "Soll die CPU-Temperaturabfrage als Service erstellt werden? (y/n)" antwort

    case "$antwort" in #
        y|Y|yes|Yes) #
            sudo cp /home/git/code/cputempscript.service /etc/systemd/system/cputempscript.service #Kopiert die Servicedatein in den Systemordner
            sudo systemctl daemon-reload #Informiert systemd das ein neuer Service hinzugefügt wurde
            sudo systemctl enable cputempscript.service #Autostartbefehl
            echo "Die CPU-Temperaturabfrage wurde als Service erstellt." #
            return 0 #
            ;;
        n|N|no|No) #
            echo "Es wurde kein Service erstellt." #
            return 0 #
            ;;
        *) #
            echo "Folgende Antwortmöglichkeiten sind möglich: 'y', 'Y', 'yes', 'Yes'; 'n', 'N', 'no', 'No'"
            return 1 #
            ;;
    esac #
}
until getAntwort; do : ; done #

#echo $antwort

#if [ "$antwort" == "y" ]
#    then
#        sudo cp /home/git/code/cputempscript.service /etc/systemd/system/cputempscript.service #Kopiert die Servicedatein in den Systemordner
#        sudo systemctl daemon-reload #Informiert systemd das ein neuer Service hinzugefügt wurde
#        sudo systemctl enable cputempscript.service #Autostartbefehl
#        echo "Die CPU-Temperaturabfrage wurde als Service erstellt."
#    else
#        echo "Es wurde kein Service erstellt."
#fi
