#Code des config.sh Files

# ubuntu updaten und upgrade
sudo apt-get update
sudo apt-get -y upgrade

# PHP installieren
sudo apt-get -y install php php-{xml,cli,opcache,gd,intl,readline,mysql,curl,mbstring,ldap,json}

# apache2 installieren
sudo apt-get -y install apache2 libapache2-mod-php


# mySQL installieren und konfigurieren
# Den Repository Key hinzufügen
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8

# Das Repository hinzufügen
sudo add-apt-repository 'deb [arch=amd64] http://mirror.zol.co.zw/mariadb/repo/10.3/ubuntu bionic main'

# Die debconf werte für das mySQL Passwort setzten
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'

# Nochmals updaten um die Pakete des neuen Repositorys auf den neusten Stand zu bringen.
sudo apt-get update

# mariadb als mySQL Dataend installieren
sudo apt-get -y install mariadb-server mariadb-client


 # mySQL Datenbanken erstellen
# Bei mySQL anmelden, mit dem davor gesetzten passwort.
mysql -uroot -ppassword
# Neue icinga2 Database erstellen und Änderungen dann überschreiben.
         CREATE DATABASE icinga2_db;
         GRANT ALL PRIVILEGES on icinga2_db.* to 'icinga2_user'@'localhost' identified by '12345678';
         FLUSH PRIVILEGES;
# Neue icingaweb2 Datenbank erstellen und die Änderungen wieder speichern und den Agent verlassen.
        CREATE DATABASE icingaweb2_db;
        GRANT ALL PRIVILEGES on icingaweb2_db.* to 'icingaweb2_user'@'localhost' identified by '12345678';
        FLUSH PRIVILEGES;
        quit

 # Icinga2 und Icinga2web installieren
# Den Repository Key für das Icinga2 Repository aus den Internet hinzufügen.
curl -sSL https://packages.icinga.com/icinga.key | sudo apt-key add -

# Nochmals updaten um die Pakete des neuen Repositorys auf den neusten Stand zu bringen.
sudo apt-get update

# Die debconf angaben auf 'yes' und 'no' stellen.
# In der ersten Abfrage werden wir gefragt, ob wir das ido-mysql Feature enablen wollen, was wir wollen.
sudo debconf-set-selections <<< 'true'
# Im zweiten Schritt werden wir gefragt, ob wir jetzt automatisch Datenbanken aufsetzten wollen, was nich wollen, da wir bereits manuell Datenbanken aufgesetzt haben.
sudo debconf-set-selections <<< 'false'

# Alle benötigten Icinga2 Pakete installieren.
# Dazu gehören der Service Icinga2, das Webgui Icingaweb2 und die mySQL Tools icinga2-ido-mysql.
sudo apt-get -y install icinga2 icingaweb2 icinga2-ido-mysql



sudo icinga2 feature enable command  ido-mysql
sudo systemctl restart icinga2.service
mysql -u root icinga2_db -p password < /usr/share/icinga2-ido-mysql/schema/mysql.sql
sudo nano /etc/icinga2/features-enabled/ido-mysql.conf

# Das im share folder abgelegte ido-mysql file kopieren.
cp /etc/share/ido-mysql.conf /etc/icinga2/features-enable/ido-mysql.conf -f

sudo systemctl restart icinga2
sudo icingacli setup token create


 # PHP 7.1 installieren
#sudo add-apt-repository ppa:ondrej/php
#sudo apt update
#sudo apt -y install php7.1
#sudo apt -y install php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring php7.1-mcrypt php7.1-zip
#sudo sed -i -e"s/^;date.timezone\s*=/date.timezone = Europe/Zurich/" /etc/php/7.1/apache2/php.ini

