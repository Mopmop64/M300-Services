# LB01 - Automatiesiert einen Service bereitstellen.

# Inhalt
- Einleitung
- Vagrantfile
- Config.ch
- Sharefolder
- Icinga2
- Backups und Versionierung
- Debconf
- Security
- Testfälle
- Reflexion

## Einleitung
Im ersten Schritt wird die gesmate LB01 erleutert und gezeigt. in welcher es darum ging einen Server und einen darauf installierten Service automatisiert zur Verfügung zu stellen. Ich habe mich dabei für einen Ubuntuserver 18.04 LTS entschiden. Was den Service angeht habe ich mich für Icinga2 entschiden. Dies ist ein Monitoring Tool, mit welchem man Services und den Status von Servern überwachen kann.

Um dies zu bewerkstelligen, sind ein paar Programme nötig. Es wurden vagrant installiert, eine Software um automatisiert VMs zu starten. Dazu wurden die Virtualisierungs Software VirtualBox von Oracle installiert, um die benötigten MVs laufen zu lassen.

## Vagrantfile
Um eine VM via Vagrant zu starten ist ein Vagrant File nötig, indem alle Konfigurationen angegeben sind. Dieses sogenannte vagrantfile ist hier zu finden. --> [vagrantfile](ubuntuserver/vagrantfile)

## Config.sh
Da dies nur die Installation der VM beinhaltet müssen danach noch alle Befehle definiert werden, die die VM nach der Installation ausführen soll. Dazu wurde im vagrantfile das config.sh File angegeben, welches diesen Inhalt beherbergt. Dies finden sie hier. --> [config.sh](ubuntuserver/config_v6.1.sh).


## Sharefolder
Da mehrere Files bearbeitet wurden, war es am einfachsten einen Sharefolder zu erstellen, in dem sich die bereits bearbeiteten Files befanden, und dann nur noch kopiert werden mussten. Im Sharedfolder befand sich ein php.ini und ein ido-mysql.conf, welche wichtige Einstellungen mit sich brachten. Den Inhalt des Sharefolders finden sie hier. --> [Sharefolder](share/)

Ein Sharedfolder kann mit folgender Linie im vagrantfile definiert werden.

![sharefolder](images/sharefolder.PNG)

Das ido-mysql.conf File. In diesem File werden die Angaben für die mySQL Datenbank icinga2_db gemacht, die für die Ablage der Daten verantwortlich ist.

![ido-mysql](images/ido-mysql.PNG)

## Icinga2
Als meinen Service habe ich mich für Icinga2 und dessen Anhang Icingaweb2 entschieden. Dabei handelt es sich um ein kostenfreies Monitoringtool, mit welchem Services und generelle Statusabfragen der Hardware von Servern und Workstations gemscht werden können. Die Anleitung und vertiefte Erklärung ist hier zu finden. --> [Icinga2](icinga2/)

## Backups und Versionierung
Ich habe meine grösseren Änderungen stehts in neuen Versionen festgehalten. Diese sind im Backup ordner zu finden. Neben den verschiedenen Versionen wurden hier auch alle debug files gelagert, welche benutzt wurden um einzelne Fehlerquellen zu finden. Den Backupordner finden sie hier. --> [Backups](backups/)

## Debconf
Ein wichtiger Teil bei der Automatisierung der Bereitstellung von Servicen ist die Installation deren Pakete. Damit alle EInstellung korrekt sind, können diese via debconf Befehl vor der Installation schon bestätigt werden, damit diese bei der Installation nicht mehr gefragt werden und manuell keine Angabe mehr gemacht werden müssen. Die genauen Angaben sind hier zu finden. --> [debconf](debconf/)

## Security
Bei den Security EInstellungen habe ich mich sehr simpel gehalten. Ich habe die Hostfilrewall aktiviert und den apache2 Service darauf erlaubt. Damit die Verbindung auf das Webgui weiterhin besteht.

## Testfälle

Um die Arbeit die geleistet Arbeit werten zu können, müssen Testfälle erstellt und Protokolliert werden. Diese sind hier aufgeführt.

| Testfall                                                  | Soll                               | Ist                                |
| --------------------------------------------------------- | ---------------------------------- | ---------------------------------- |
| VM wird via Vagrant vollständig aufgesetzt.               | VM wird erfolgreich aufgesetzt.    | VM wird erfolgreich aufgesetzt.    |
| Im Order der VM kann mit "vagrant ssh" verbunden werden.  | SSH verbindung wird geöffnet.      | SSH verbindung wird geöffnet.      |
| VM ist via SSH über PuTTY auf localhost erreichbar.       | Verbindung kann aufgebaut werden.  | Verbindung kann aufgebaut werden.  |
| Das Icingaweb2 Webgui ist im Browser über http://127.0.0.1:8080/icingaweb2 erreichbar.          | Webgui ist erreichbar.             | Webgui ist erreichbar.             |
| Login in das Webgui ist erfolgreich.                      | Login erfolgreich.                 | Login erfolgreich.                 |
| Services des Hosts werden angezeigt.                      | Services werden angezeigt.         | Services werden angezeigt.         |

## Reflexion
Das Ganze Projekt war für mich zum Teil sehr Nervenaufreibend, aber im grosssen und ganzen sehr interessant, da ich viel neues Lernen konnte. Der grösste Problemfaktor war die debconf Einstellungen bei der Icinga2 Installation. Alleine um die zwei Befehle richtig zu Schreiben und funktionsfähig zu kriegen habe ich über 10 Stunden gebraucht. Aber fühlte mich dann umso besser als es endlich funktionierte. Als zweites kleines Problem bin ich bei PHP gestossen, als es einen Sessionfehler mit dem Webgui von Icingaweb2 gab. Dieser liess sich aber zum Glück ziemlich unkompliziert lösen, da ich ein falschen php.ini File aus dem Internet herunter geladen habe.

Ansonsten ist das Projekt sehr gut und ohne nennenswerte Probleme vonstatten gegangen. Es war einfach sehr zeitintensiv, da ich mich für einen sehr komplexen Service entschieden habe.