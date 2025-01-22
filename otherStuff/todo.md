# TODOs

Aufschrift aller notwenigen ToDos.

## Iteration 1 (20.11. bis 03.12.)

Ziel ist ein eine erste funktionierende Version mit einem Durchstich von einer Landing-Page bis zum Erstellen eines neuen Parkhauses. 
Folgende Sub-Ziele gilt es zu erreichen:
- Über die graphische Oberfläche soll ein neues Parkhaus erstellt werden können.
- Es soll eine Unterscheidung zwischen Facility-Manager, Manager und Visitor geben.
- Das bereits existierende Defect-Management soll an die neuen Anforderungen angepasst werden.
- Es sollen bereits Gerüst für die anderen Services existieren.

### wichtige Todos
- Einbindung der Tenants (Anpassung im Frontend (Defects) und im Backend)
- Anzeigetafel
- Sequenzdiagramm (Bezug auf den Nutzer) -> Bspw. Bezahlen (synchron und asynchron)
- Multi-Tenancy (Folien anschauen!!!)


### Aufgaben  

- Parking-Garage-Service: Planung der Architektur des Services: Parking Management
  - Entwurf für Datenbank anlegen
  - Sicherheitsaspekte für den Zugriff auf die Datenbanken (Tenants und Rollen)
  - Datenbankabfragen genauer spezifizieren
- Parking-Garage-Service: Aufsetzen der neuen Datenbank und Füllen mit Testwerten
- Parking-Garage-Service: Implementierung der Datenbankabfragen (genauer spezifiziert im Architekturentwurf)
- Parking-Garage-Service: Implementierung der Sicherheitsaspekte
- Defect-Management-Service: Erweiterung der Defect-Datenbank
- Defect-Management-Service: Anpassung der Änderungen in der Defect-Datenbank
- Frontend: Design und Gestaltung
- Frontend: Landing-Page (Übersicht über alle Parkhäuser und deren aktueller Belegungszustand, Login-Button in der Ecke)
- Frontend: "Own ParkingGarages"-Übersicht (Wenn Angemeldet (ansonsten Fehler-Hinweis), dann Übersicht über eigene Parkhäuser)
- Frontend: "ParkingGarage": Übersichtsseite von einem speziellen Parkhaus
- Frontend: "Defect Management" anpassen

### Anmerkungen / Brainstorming

- Automatisiertes Hinzufügen einer neuen Datenbank
- Mögliches Feature: Multi-Languages

## TODO for me

- Erstellung von "Personas"
    - HTWG-Konstanz: Auslagerung des Managements. Parken nur für Mitglieder der HTWG. Cost effective solution.
    - AirportPark: großes Unternehmen mit Standorten überall auf der Welt. Bedarf: Automatisiertes Integrieren, Finanzielles Accounting und Reporting System.
    - Falcon: großes Gebäude, welches ein neues Parkdeck braucht und dafür die entsprechende Software als eine "All-in-One"-Solution.
- User Stories schreiben und in Sprint-Board hinzufügen

ToDo:
- Elisha: Design fertig stellen
- Maren&Nico: Diskussion des Aufbaus GitHub, Diskussion Technologien
- Maren: Requirements-Engineering: Verfeinerung der Datenbank + Überlegung für Technologien
- Nico: Programmieren

## Random Notes

Datastorage in the right country (Configurierbarkeit)

- Ways for scaling with tenants (single-tenant / Multi-Tenants, Multiple instances / single Instance)
- Multi-Tenancy at Component Level: Decide for each container, which tenancy approach is the best
- Different solutions: one big bucket (e.g. with meta-data), own bucket or own subfolder for own tenant E.g. use own service account for each tenant
- e.g. for my customer I use one Identify path and for the other one another

Think about: 
- Cost calculation
- pricing and billing methods for each model
- Automate tenant creation as far as possible
