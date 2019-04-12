# LDAP

# Inhalt
- Was ist LDAP
- LDAP Server mit Docker aufsetzten
- Image

## Was ist LDAP
LDAP steht für Lightweight Directory Access Protocoll. Es handelt sich dabei um ein Protokoll welches genutzt wird um Benutzer zu authentisieren und deren Berechtigungen zu autorisieren. In meiner LB02 habe ich mir es zur aufgabe gemacht einen solchen Dienst bereitzustellen. 

## LDAP server mit Docker aufsetzen
Nachdem der Docker Deamon auf einem Host Server installiert werden konnte, kann nun damit begonnen werden einen LDAP Server bereitzu stellen. In meiner Vorgehensweise habe ich ein einfaches ubuntu 16.06 LTS Image heruntergelden und in einem Container installiert. Dabei handelt es sich um ein extrem Schlankes ubuntu, welches vile normalerweise standartisierte Pakete und Features nicht mitbringt. Dazu habe ich die Port weiterletungen 8080 vom Host auf 80 auf den Container und 389 des Hosts auf 389 des Containers eingerichtet. Dies, damit über Port 8080 das Webgui von PHPLDAPadmin erreicht werden kann und 389 da es der Port des LDAP Protokolles ist.

Zuerst muss der Container erstellt werden.

``docker run -it -p 8080:80 -p 389:389 --name ubuntu_ldap01 ubuntu:16.04``

Mit -it landet man direkt im Container. Andernfalls kann man mit einem Befehl die Shell des Containers öffnen.

``docker exec -it ubuntu_ldap01 /bin/bash``

Im Container können dann alle Updates duchgeführt werden.

``apt update``

``apt upgrade``

Damit ich einfacher arbeiten konnte habe ich noch die net-tools und den nano Editor installiert.

``apt install net-tools``

``apt install nano``

Danach wurde der apache2 Webserver installiert.

``apt install apache2``

Das File /etc/apache2/apache2.conf bearbeiten. Es muss ledeglich eine Zeile am Ende des Files hinzugefügt werden ``ServerName IP_of_your_server``

``nano /etc/apache2/apache2.conf``

Nun kann über einen Configtest überprüft werden on der apache2 Webserver sichtig Installiert wurde. Wenn der Syntax als OK ausgegeben wird ist alles in Ordnung.

``apache2ctl configtest``

Nun apache2 neustarten

``service apache2 restart``

Wir können nun zum nächsten Schritt weitergehen. --> PHP installieren

``apt install php libapache2-mod-php php-mcrypt php-mysql``

Nachc der Installation kann im /etc/apache2/mods-enabled/dir.conf File das index.php an erste Stelle geschoben werden.

``nano /etc/apache2/mods-enabled/dir.conf``

Apache2 neustarten.

``service apache2 restart``

Jetzt wird es Zeit endlich die LDAP Utilities zu installieren. Es wird während der Installation nach dem Passwort für den Admin Benutzer des LDAPs gefragt, man kann im Grunde eingeben was man will, da das Paket sowieso nochmals neu konfiguriert wird, da wir nict alle Installaitonspunkte angeben konnten.

``apt install slapd ldap-utils``

LDAP neu konfigureiren. Folgende Angaben müssen gemacht werden.

- openLDAP Server: NO
- DNS Name: Top Level Name des LDAPs
- organization: Name der Fimra, meistens wird der DNS Name eingetragen
- Passwort: sicheres PW
- Passwort_again: gleiches PW
- Database backend: MDB
- remove when purged: no
- move old Database: yes
- LDAPv2: no

``dpkg-reconfigure slapd``

Nun da LDAP erfolgreich installiert wurde, kann nun der Management backend PHPLDAPadmin installiert werden.

``apt -y install phpldapadmin``

Im Configfile davon müssen einige Änderungen vorgenommen werden. 

``nano /etc/phpldapadmin/config.php``

Mit ctrl+W kann im Nano Editor gesucht werden.

Zuerst müssen wir nach ``$servers->setValue('server','name'`` suchen. Darin können wir den Anzeigenahmen ändern.

Danch müssen wir nach ``$servers->setValue('server','base'`` suchen. Dort können wir dann die Toplevel domain angeben, damit es auch richtig angezeigt wird, und nicht example.com.

Nun kann ``bind_id`` gesucht werden. Diese Zeile zeigt den standartmässigen Benutzernamen. Für erhöhte sicherheit kann diese Zeile auskommentiert werden. ALternativ kann auch einfach der echte Admin des eigenen LDAPs angegben werden.

Zum Schluss muss noch ``hide_template_warning`` gesucht werden. Diese Zeile kann entkommentiert werden, und dessen Wert von false auf true geändert werden.

Nun kann das File gespeichert und geschlossen werden.

Nun müssen noch einmal der apache2 Service und der slpad Service neu gestartet werden.

``service apach2 restart``

``serive slapd restart``

Mithilfe der Port weiterletung kann nun über die Hostadresse auf das LDAP zugegriffen werden.

http://host_IP:8080/phpldapadmin


## Image
Damit ich immer wieder den LDAP Server bereitstellen kann, habe ich ihn als Image abgelegt. So kann ich immer wieder ein vollständig funktionierendes LDAP in Sekunden bereitstellen.

Als erstes habe ich ein Image erstellt. 

``docker commit ubuntu_ldap01``

Danach muss die ID des neuen Images herausgefunden werden. Dies ist unter der normalen auflistung der Images gefunden werden.

``docker images``

Nun kann das Image mit einem Tag versehen werden, also quasi benannt werden.

``docker tag [Image ID] ldap:v1.0``

Das Image trägt nun den Namen ldap mit der Versionierung v1.0