# debconf

## Was ist debconf
Wenn ein Paket istalliert wird fragt debconf nach allen Einstellungen für dieses Paket. Diese EInstellungen können via Command vor oder nach dem Installieren des Paketes angegeben werden. Falls nicht vor dem Installieren die Werte gesetzt werden, können während der Installation Fenster aufgehen, welche nach diesen Angaben fragen. Das Einfachste Beispiel ist hier die Frage nach einem Passwort.

## Aufbau des Befehls
Der Befehl ist folgendermassen aufgebaut.

debconf-set-selection <<< '{pakagename} {name des modules} {wert}'

## Beispiele

### mySQL
In diesem Beispiel werde ich zeigen wie man das Root Passwort bei einer mySQL Installation angibt.

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password DeinPasswort'

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password DeinPasswort'

### Icinga2
Im zweiten Beispiel zeige ich wie man bei einer Icinga2 Installation angiebt, dass die ido-mysql features aktiviert werden sollen und die dbconfig-common nicht durchgeführt werden.

sudo debconf-set-selections <<< 'icinga2-ido-mysql icinga2-ido-mysql/enable boolean true'

sudo debconf-set-selections <<< 'icinga2-ido-mysql icinga2-ido-mysql/dbconfig-install boolean false'

Wichtig ist hier das der boolean Typ angegeben wird, da es sich um zwei Ja / Nein Fragen handelt.

## Finden der debconf Namen
Um die genauen debconf Namen zu finden, rät es sich in den Files '/var/cache/debconf/config.dat' und '/var/cache/debconf/    change:   passwords.dat'. Das Problem daran ist nur dass sie dort erst ersichtlich sind nachdem das Paket installiert wurde. Es empfiehlt sich somit eine weitere VM vorzubereiten auf welcher man die gleichen Pakete installiert, und sich dann die debconf EIntrage rausschreibt.