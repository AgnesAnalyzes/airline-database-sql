# Airline Database Schema (SQL)

This project models an airline booking system using a relational database schema.  
It was created from a training assignment and focuses on **data modeling**, **primary/foreign keys**, and **clean relational structure** as a foundation for analytical SQL queries.

---

## Entities & Relationships

The database includes:

- **Passengers** (basic identity data)
- **Passenger Details** (1:1 extension with demographics, address, contact)
- **Bookings** (connects passengers and flights, includes seat and price)
- **Flights** (flight number, departure/arrival timestamps, airline, aircraft, airports)
- **Airlines** (IATA code, company name, home airport)
- **Aircraft** (capacity, belongs to one airline and one aircraft type)
- **Aircraft Types** (name and description)
- **Airports** (name, city, country, coordinates)

---

## Key Design Choices

- Passenger details are stored in a separate table to keep the core `passenger` table clean (**1:1 relationship**).
- Bookings implement a many-to-many relationship between passengers and flights via foreign keys.
- Flights reference both departure and arrival airports.
- Aircraft belong to exactly one airline and one aircraft type.

---

## Tech

- SQL (PostgreSQL-friendly)
- Relational modeling with PK/FK constraints
