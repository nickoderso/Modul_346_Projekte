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
## Getroffene Ziele

Zu Beginn des Projekts haben wir einige Ziele definiert, um am Schluss zu überprüfen, ob wir unser Projekt nach Plan umsetzen konnten.

| **Definition**         |    Ziel               |
|------------------------|----------------------|
| Name des Webservers     | projekt_burki_web    |
| OS                     | Ubuntu Server        |
| AMI ID                | ami-0fc5d935ebf8bc3bc|
| User                   | Ubuntu               |

| **Definition**           |           Ziel      |
|-------------------------|----------------------|
| Engine                  | MySQL                |
| Passwort                | sml12345             |
| Datenbankname           | WS1-346              |
| Speicher                | 20GB SSD             |


## Informationen zur Datenbank

Im folgenden Abschnitt sind alle Informationen zur Datenbank aufgeführt.

<h3>Tabelle mit Informationen zur Datenbank</h3>

| Eigenschaft                    | Details                                     |
|-------------------------------|---------------------------------------------|
| **Engine**                    | MySQL                                       |
| **Benutzer**                  | Vmadmin                                     |
|             **Name**             |  Vmadmin                             |
|   **Passwort**                  |  sml12345                        |
| **Erstellungsmethode**         | Standard                                    |
| **Engine Version**             | 8.0.25                                      |
| **Datenbank Name**             | WS1-346                                     |
| **Speichergröße und Typ**      | Universell SSD, 20GB                         |
| **Anbindung**                  | Direkte Anbindung an EC2-Instanz für Webserver|
| **Optionale Einstellungen**    | Default                                     |

  
<!-- Infortmationen und Beschreibung zum Webserver -->
<h2>Informationen zum Webserver</h2>
Im unteren Abschnitt folgen alle Informationen zum Webserver.<br><br>

Um eine Website auf dem Server zu hosten, mussten wir zuerst Apache installieren. Das haben wir mit den nachfolgenden Befehlen gemacht: <br>
- `sudo apt update` (System updaten)
- `sudo apt install apache2` (Apache installieren)
- `sudo systemctl start apache2` (Apache Dienst starten)

Nachdem ich Apache erfolgreich installiert habe, konnte ich nur noch das HTML und PHP File entsprechend anpassen. Nun konnte ich die Website über die private IP im LAN erreichen. Für das die Website nun öffentlich erreicht werden konnte, muss auf der Firewall der Port "80" geöffent werden. Dies konnte direkt auf der EC2 Instanz mit dem nachfolgenden Befehl erledigt werden: <br>
- `sudo ufw allow 80`

Bei Schwierigkeiten habe ich mir Hilfe auf folgender Website gesucht: <br>
https://faun.pub/how-to-install-apache-on-aws-ec2-instance-ubuntu-18-04-44fa1fac6236

## Umsetzung des Projekts

Für die Umsetzung habe ich mir zuerst einen groben Ablaufplan erstellt, um die Arbeiten besser einzuplanen und effizienter zu gestalten. Dabei bin ich wie folgt vorgegangen:

1. Terraform Script für die Erstellung der RDS- und EC2-Instanz erstellen
2. VSCode-Anbindung an AWS
3. Mittels SSH auf EC2 (Webserver) Instanz verbinden
4. Webserver-Dienste installieren (Apache)
5. Index.html auf der EC2 bearbeiten
6. Firewall auf der EC2 bearbeiten
<br>

<h1>Projekt 3 und 4</h1>

In diesem Projekt haben wir mit Route 53, AWS Certificate Manager (ACM) und Loadbalancer eine Webseite erstellt, diese mit einer Domain verbunden und eine sichere Verbindung mittels SSL/TSL Zertifikat hergestellt.
Die webseit war bereits bestehend aus einem anderen Projekt und musste daher nicht aufgebaut werden. <br> <br>

## Benötigte Services <br>
- EC2 Instance (Webserver und Loadbalancer)
- Amazon Certificate Manager (ACM)
- Route 53
  
<h2> Informationen zum Webserver </h2>

| **Definition**         |    Ziel              |
|------------------------|----------------------|
| Name des Webservers    |  Dorffete Webserver  |
| OS                     | Ubuntu Server        |
| AMI ID                 |ami-0c7217cdde317cfec |
| User                   | Ubuntu               |
| Service                | Apache               |
| Domain                 | Dorffete.ch          |
| IP Adressen Typ        | Elastisch            |
| Offene Ports           | 22, 80, 443          |

## Loadbalancer
- EC2 in AWS aufrufen
- Load Balancer öffnen
- Application Load Balancer erstellen
- Freie Konfiguration (Wichtig VPC mit dem Webserver auswählen und Port 443 für https auswählen)
- Sicherheitsgruppe Auswählen
  
## Route 53
- Route 53 in AWS aufrufen
- Neue Gehostete Zone Erstellen
- Domain angeben und weiter

## Domain Provider
- Hinterlege den DNS von Route 53 bei deinem Domain Provider (Unterschiedlich zwischen Anbietern)
  
## AWS Certificate Manager (ACM)
- ACM in AWS aufrufen
- Neues öffentliches Zertifikat anfordern
- Deine Domain angeben (füge deine Domain hinzu und einmal noch mit einer Wildcard -> deinedomain.com *.deinedomain.com)
- DNS Verifizierung auswählen (Sofern zugriff auf DNS DB der Domain)
- RSA Zertifikat auswählen und Zertifikat Anfragen

## Domain Provider
- CNAME aus ACM kopieren und damit neue CNAME's in der Domain datenbank anlegen.

## ACM
- Datensätze des Zertifikates in Route 53 Übertragen





