# TODOs

Aufschrift aller notwenigen ToDos.

## Sprint 1

- Über die graphische Oberfläche soll ein neues Parkhaus erstellt werden können.
- Es soll eine Unterscheidung zwischen Facility-Manager, Manager und Visitor geben.
- Das bereits existierende Defect-Management soll an die neuen Anforderungen angepasst werden.
- Es sollen bereits Gerüst für die anderen Services existieren.

### Aufgaben

- Parking-Management-Service: Planung der Architektur des Services: Parking Management
  - Entwurf für Datenbank anlegen
  - Sicherheitsaspekte für den Zugriff auf die Datenbanken (Tenants und Rollen)
  - Datenbankabfragen genauer spezifizieren
- Parking-Management-Service: Aufsetzen der neuen Datenbank und Füllen mit Testwerten
- Parking-Management-Service: Implementierung der Datenbankabfragen (genauer spezifiziert im Architekturentwurf)
- Parking-Management-Service: Implementierung der Sicherheitsaspekte

### Anmerkungen / Brainstorming

- Automatisiertes Hinzufügen einer neuen Datenbank

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
