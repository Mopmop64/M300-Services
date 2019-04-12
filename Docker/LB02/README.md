# Docker - Service in einem Container bereitstellen

# Inhalt
- Einleitung
- Docker
- Create Image
- Dockerfile & Composefile

## Einleitung
Bei der LB02 bestand der Auftrag nun daraus einen Service über docker anzubieten. Dazu soll erneut ein Server aufgesetzt werden, darauf dann der Docker Deamon installiert werden. Dann soll ein Docker container erstellt werden, indem sich der Server befindet. Im Rahmer der zweiten Lernberurteilung habe ich mich entschieden einen LDAP Server mit einem PHPLDAPadmin Management Backend zur verfügung zu stellen. Dazu habe ich zuerst einen Ubuntu 16.04 LTS Server aufgesetzt, indem dann der Docker container bereitgestellt wird, über welchen mann dann den LDAP Server erreicht.

## Docker
Docker ist eine Conteinersoftware, welche es einem ermöglicht sehr Ressourcensparend Services laufen zu lassen, und man benötigt dazu nur einen einzigen Host. In den Verschiedenen Containern können dann aus dem Internet heruntergeladene Images mit schon komplett vorinstallierten Services laufen gelassen werden, oder man definert diese in einem eigenen Image. Alternativ kann auch ein frischen Image gewählt werden, und dann via Dockerfile den Service installieren. Danach kann dann aus dem Finalen container ein neues Image erstellt werden.

### Installing Docker
Im ersten Schritt nach dem Aufsetzten des Servers, und nachdem alle Updates durchgeführt wurden, wird nun das Docker certifikat importiert.

``sudo apt install apt-transport-https ca-certificates curl software-properties-common``

Danach kann der Reposotory Key importiert werden.

``curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -``

Nun kann das Docker Repository hinzugefügt werden.

``sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"``

Das Repository updaten.

``sudo apt update``

Bestätigen das Docker wirklich über das richtige Repository installiert wird.

``apt-cache policy docker-ce``

Jetzt kann Docker endlich installiert werden.

``sudo apt install docker-ce``

Damit man die Docker Befehle nicht immer mit sudo ausführen muss kann man seinen eigenen Benutzer der Docker Gruppe hinzufügen.

``sudo usermod -aG docker ${USER}``

Damit die Änderungen übernommen werden, muss man sich entweder aus- und wieder einloggen, oder man Benutzt folgenden Befehl.

``su - ${USER}``

Bestätigen das der Benutzer wirklich in der Gruppe ist.

``id -nG``

Herzlichen Glückwunsch. Sie haben nun Docker erfolgreich installiert.

## Create Image
``docker commit`` heisst der Befehl. Hiermit ist es möglich aus einem bestehenden Container ein Image zu kreiren. Dies kann nützlich sein wenn man weiss das man einen Container häufig löschen wird. Damit ist es möglich immer wieder an einen Bestimmten Stand am Arbeitsprozess zurückzukehren.

## Dockerfile & Composefile
Aus Dockerfiles können Images gebaut werden, aus denen dann Containers gestartet werden können. Man gibt darin das Base Image an, sowie ähnlich wie beim Vagrantfile auch Befehle die nach dem Starten des Containers ausgefeührt werden sollen.

In einem Composefile können ziemlich gleiche Sachen gemacht werden, man kann einfach mehrere Images und Container gleichzeiting starten.