# Docker - Service in einem Container bereitstellen

# Inhalt
- Einleitung
- Docker
- Dockerfile
- More things

## Einleitung
Bei der LB02 bestand der Auftrag nun daraus einen Service über docker anzubieten. Dazu soll erneut ein Server aufgesetzt werden, darauf dann der Docker Deamon installiert werden. Dann soll ein Docker container erstellt werden, indem sich der Server befindet. Im Rahmer der zweiten Lernberurteilung habe ich mich entschieden einen LDAP Server mit einem PHPLDAPadmin Management Backend zur verfügung zu stellen. Dazu habe ich zuerst einen Ubuntu 16.04 LTS Server aufgesetzt, indem dann der Docker container bereitgestellt wird, über welchen mann dann den LDAP Server erreicht.

## Docker
Docker ist eine Conteinersoftware, welche es einem ermöglicht sehr Ressourcensparend Services laufen zu lassen, und man benötigt dazu nur einen einzigen Host. In den Verschiedenen Containern können dann aus dem Internet heruntergeladene Images mit schon komplett vorinstallierten Services laufen gelassen werden, oder man definert diese in einem eigenen Image. Alternativ kann auch ein frischen Image gewählt werden, und dann via Dockerfile den Service installieren. Danach kann dann aus dem Finalen container ein neues Image erstellt werden.

### Installing Docker
Im ersten Schritt nach dem Aufsetzten des Servers, und nachdem alle Updates durchgeführt wurden, wird nun das Docker certifikat importiert.

``sudo apt install apt-transport-https ca-certificates curl software-properties-common``



## Dockerfile

## More things