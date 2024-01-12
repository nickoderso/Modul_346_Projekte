# Modul 346 - Projektarbeit

Allgemeine Infos: <br>
- Ein Projekt von Nick Gilgen und Mike Leon Koch - Modul 346 <br>
- In diesem Repository sind alle Dokumente und Scripts für unsere Projekte im Modul 346 vorzufinden. <br>

Die Note von LB2 setzt sich aus **4 individuellen Projekten** zusammen. Ich und Mike haben uns dazu entschieden, Projekt 1 und 2 zu kombinieren, so dass wir beide Projekte zusammen abgebgen können.


<h1>Projekt 1 und 2</h1>
In diesem Projekt werden wir eine EC2 und eine RDS Instanz deployen und diese anschliessend connecten. Die EC2 Instanz dient dabei als Webserver. Beide Instanzen werden mit Terraform deployed. Da das Netzwerk bereits im
Modul 141 erstellt wurde, muss dieses nicht mehr erstellt werden. Folgende Ressourcen werden benötigt um die Umgebung aufzusetzen: <br> <br>

<!-- Folgende Instanzen werden benötigt -->
- EC2 Ubuntu Server Instanz (Webserver) <br>
- RDS (Database) <br>
- Netzwerk (Bereitsvorhanden) <br>

## Informationen zur Datenbank

Im folgenden Abschnitt sind alle Informationen zur Datenbank aufgeführt.

- **Engine:** Wir haben uns für die MySQL-Engine entschieden, da wir bereits umfangreiche Erfahrungen damit gesammelt haben.
- **Benutzer:** Ein Datenbankbenutzer wurde erstellt, mit dem wir uns später an der Datenbank anmelden können.
  - *Name:* Vmadmin
  - *Passwort:* sml12345
- **Auswahl der Datenbank Erstellungsmethode:** Standard-Erstellung
- **Engine Version:** 8.0.25
- **Datenbank Name:** WS1-346
- **Speichergröße und Typ:** Universelle SSD, 20GB
- **Anbindung:** Direkte Verbindung zur erstellten EC2-Instanz für den Webserver.
- **Optionale Einstellungen:** Standard

  
<!-- Infortmationen und Beschreibung zum Webserver -->
<h2>Informationen zum Webserver</h2>
Im unteren Abschnitt folgende alle Informationen zum Webserver.<br><br>

Um eine Website auf dem Server zu hosten, mussten wir zuerst Apache installieren. Das haben wir mit den nachfolgenden Befehlen gemacht: <br>
- sudo apt update (System updaten)
- sudo apt install apache2 (Apache installieren)
- sudo systemctl start apache2 (Apache Dienst starten)

Nachdem ich Apache erfolgreich installiert habe, konnte ich nur noch das HTML und PHP File entsprechend anpassen. Nun konnte ich die Website über die private IP im LAN erreichen. Für das die Website nun öffentlich erreicht werden konnte, muss auf der Firewall der Port "80" geöffent werden. Dies konnte direkt auf der EC2 Instanz mit dem nachfolgenden Befehl erledigt werden: <br>
- sudo ufw allow 80



