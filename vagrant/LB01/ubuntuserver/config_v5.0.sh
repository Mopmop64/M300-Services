#Code des config.sh Files

  # Auf den root wechseln
#sudo su

  # ubuntu update und upgrade
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
mysql -uroot -ppassword <<%EOF%
# Neue icinga2 Database erstellen und Änderungen dann überschreiben.
         CREATE DATABASE icinga2_db;
         GRANT ALL PRIVILEGES on icinga2_db.* to 'icinga2_user'@'localhost' identified by '12345678';
         FLUSH PRIVILEGES;
# Neue icingaweb2 Datenbank erstellen und die Änderungen wieder speichern und den Agent verlassen.
        CREATE DATABASE icingaweb2_db;
        GRANT ALL PRIVILEGES on icingaweb2_db.* to 'icingaweb2_user'@'localhost' identified by '12345678';
        FLUSH PRIVILEGES;
%EOF%

  # Icinga2 und Icinga2web installieren
# Den Repository Key für das Icinga2 Repository aus den Internet hinzufügen.
curl -sSL https://packages.icinga.com/icinga.key | sudo apt-key add -

# Nochmals updaten um die Pakete des neuen Repositorys auf den neusten Stand zu bringen.
sudo apt-get update

# Die debconf angaben auf 'yes' und 'no' stellen.
# In der ersten Abfrage werden wir gefragt, ob wir das ido-mysql Feature enablen wollen, was wir wollen.
sudo debconf-set-selections <<< 'icinga2-ido-mysql icinga2-ido-mysql/enable boolean true'
# Im zweiten Schritt werden wir gefragt, ob wir jetzt automatisch Datenbanken aufsetzten wollen, was nich wollen, da wir bereits manuell Datenbanken aufgesetzt haben.
sudo debconf-set-selections <<< 'icinga2-ido-mysql icinga2-ido-mysql/dbconfig-install boolean false'

# Alle benötigten Icinga2 Pakete installieren.
# Dazu gehören der Service Icinga2, das Webgui Icingaweb2 und die mySQL Tools icinga2-ido-mysql.
sudo apt-get -y install icinga2 icingaweb2 icinga2-ido-mysql

# Nun müssen die ido-mysql features noch aktiviert werden.
sudo icinga2 feature enable command ido-mysql

# Danach den icinga2 Service einmal neu starten.
sudo systemctl restart icinga2

# In der icinga2_db Datenbank werden Einträge generieren
mysql -uroot icinga2_db -ppassword < /usr/share/icinga2-ido-mysql/schema/mysql.sql

# Das im share folder abgelegte ido-mysql file kopieren. Da essenzielle Änderungen vorgenommen werden müssen.
sudo cp /etc/share/ido-mysql.conf /etc/icinga2/features-enabled/ido-mysql.conf

# Den Icinga2 Service erneut neu starten
sudo systemctl restart icinga2

# Ganz zum Schluss wird noch ein Token erstellt, welches benötigt wird um das Webgui zu initialisieren.
sudo icingacli setup token create


  # Aufgrund eines bekannten Fehlers mit icingaweb2 und PHP 7.2 muss auf PHP 7.1 gedowngraded werden.
# Ein weiteres Repository hinzufügen
sudo add-apt-repository -y ppa:ondrej/php

# Die Pakagebase erneut upgraden
sudo apt update

# PHP 7.1 installalieren
sudo apt -y install php7.1

# Alle weiteren PHP 7.1 Module installieren
sudo apt install php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring php7.1-mcrypt php7.1-zip

# php.ini File wird kopiert
sudo cp /etc/share/php.ini /etc/php/7.1/apache2/php.ini

# Nun muss PHP 7.2 noch deaktiviert und PHP 7.1 aktiviert werden.
sudo a2dismod php7.2
sudo a2enmod php7.1

# apache2 Service neu starten
sudo systemctl restart apache2


# end