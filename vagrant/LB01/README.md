# LB01 - Automatiesiert einen Service bereitstellen.

Im ersten Schritt wird die gesmate LB01 erleutert und gezeigt. in welcher es darum ging einen Server und einen darauf installierten Service automatisiert zur Verfügung zu stellen. Ich habe mich dabei für einen Ubuntuserver 18.04 LTS entschiden. Was den Service angeht habe ich mich für Icinga2 entschiden. Dies ist ein Monitoring Tool, mit welchem man Services und den Status von Servern überwachen kann.

Um dies zu bewerkstelligen, sind ein paar Programme nötig. Es wurden vagrant installiert, eine Software um automatisiert VMs zu starten. Dazu wurden die Virtualisierungs Software VirtualBox von Oracle installiert, um die benötigten MVs laufen zu lassen.

Um eine VM via Vagrant zu starten ist ein Vagrant File nötig, indem alle Konfigurationen angegeben sind. Dieses File ist [hier](myserver/vagrantfile) zu finden.