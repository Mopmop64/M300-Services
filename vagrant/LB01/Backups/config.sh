 # ubuntu updaten und upgrade
sudo apt-get update
sudo apt-get -y upgrade

 # PHP installieren
sudo apt-get -y install php php-{xml,cli,opcache,gd,intl,readline,mysql,curl,mbstring,ldap,json}

 # apache2 installieren
sudo apt-get -y install apache2 libapache2-mod-php

 # PHP Zeitzone definieren
sudo sed -i 's/;date.timezone=/date.timezone=Europe/Zurich/g' /etc/php/7.2/apache2/php.ini

 # apache2 neustarten
sudo systemctl restart apache2
