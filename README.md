# Airline Database – SQL Data Modeling & Analysis

This project demonstrates the design and analysis of a relational airline booking database using **pure SQL**.  
It was developed as part of a data analytics training program and transformed into a portfolio-ready project with a strong focus on **data modeling, relational integrity, and analytical querying**.

The repository covers the full workflow from **conceptual modeling (ERD)** to **schema creation**, **sample data insertion**, and **business-oriented SQL analysis**.

---

## Project Scope

The database models a simplified airline booking system including:

- Passengers and passenger details  
- Bookings and ticket prices  
- Flights, airlines, aircraft, and aircraft types  
- Airports with geographic information  

The project uses **sample data** for demonstration purposes.  
Analytical results do not represent real-world airline operations.

---

## Database Schema (ERD)

The entity-relationship diagram illustrates all tables, primary keys, foreign keys, and relationships used in the database.

![ERD](erd/erd.png)

---

## Repository Structure

```text
airline-database-sql/
│
├── README.md
│
├── erd/
│   └── erd.png
│
├── schema/
│   ├── create_tables.sql
│   ├── insert_airport.sql
│   ├── insert_aircraft_type.sql
│   ├── insert_passenger.sql
│   ├── insert_passenger_details.sql
│   ├── insert_airline.sql
│   ├── insert_aircraft.sql
│   ├── insert_flight.sql
│   └── insert_booking.sql
│
├── queries/
│   └── advanced_queries.sql
