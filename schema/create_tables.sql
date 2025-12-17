DROP TABLE IF EXISTS flughafen;

CREATE TABLE flughafen(
	flughafen_id SMALLINT PRIMARY KEY,
	namen varchar(50) NOT NULL,
	stadt varchar(50),
	land varchar(50) NOT NULL,
	breite NUMERIC(11, 8) NOT NULL,
	laenge NUMERIC(11, 8) NOT NULL
);

DROP TABLE IF EXISTS flugzeugtyp;

CREATE TABLE flugzeug_typ(
	typ_id SERIAL PRIMARY KEY,
	bezeichnung varchar(50),
	beschreibung TEXT
);

DROP TABLE IF EXISTS fluglinie;

CREATE TABLE fluglinie(
	fluglinie_id INT PRIMARY KEY,
	IATA CHAR(2),
	firmenname varchar(40) NOT NULL,
	heimat_flughafen SMALLINT REFERENCES flughafen(flughafen_id)
);

DROP TABLE IF EXISTS flugzeug;

CREATE TABLE flugzeug (
  flugzeug_id SERIAL PRIMARY KEY,
  kapazitaet INTEGER NOT NULL CHECK (kapazitaet >= 0),
  typ_id INTEGER NOT NULL,
  fluglinie_id INTEGER NOT NULL,
  CONSTRAINT fk_flugzeug_typ FOREIGN KEY (typ_id) REFERENCES flugzeug_typ (typ_id),
  CONSTRAINT fk_fluglinie FOREIGN KEY (fluglinie_id) REFERENCES fluglinie (fluglinie_id)
);

DROP TABLE IF EXISTS passagier;

CREATE TABLE passagier (
  passagier_id SERIAL PRIMARY KEY,
  passnummer CHAR(9) NOT NULL,
  vorname VARCHAR(100) NOT NULL,
  nachname VARCHAR(100) NOT NULL,
  CONSTRAINT pass_unq UNIQUE (passnummer)
);

DROP TABLE IF EXISTS passagierdetails;

CREATE TABLE passagierdetails (
  passagier_id INTEGER PRIMARY KEY,
  geburtsdatum DATE NOT NULL,
  geschlecht CHAR(1),
  strasse VARCHAR(100) NOT NULL,
  ort VARCHAR(100) NOT NULL,
  plz SMALLINT NOT NULL,
  land VARCHAR(100) NOT NULL,
  emailadresse VARCHAR(120),
  telefonnummer VARCHAR(30),
  CONSTRAINT fk_passagierdetails_passagier FOREIGN KEY (passagier_id)
    REFERENCES passagier (passagier_id)
);

DROP TABLE IF EXISTS flug;

CREATE TABLE flug (
  flug_id SERIAL PRIMARY KEY,
  flugnr CHAR(8) NOT NULL,
  von SMALLINT NOT NULL,
  nach SMALLINT NOT NULL,
  abflug TIMESTAMP NOT NULL,
  ankunft TIMESTAMP NOT NULL,
  fluglinie_id SMALLINT NOT NULL,
  flugzeug_id INTEGER NOT NULL,
  CONSTRAINT fk_von FOREIGN KEY (von) REFERENCES flughafen (flughafen_id),
  CONSTRAINT fk_nach FOREIGN KEY (nach) REFERENCES flughafen (flughafen_id),
  CONSTRAINT fk_flugzeug FOREIGN KEY (flugzeug_id) REFERENCES flugzeug (flugzeug_id),
  CONSTRAINT fk_fluglinie FOREIGN KEY (fluglinie_id) REFERENCES fluglinie (fluglinie_id)
);

DROP TABLE IF EXISTS buchung;

CREATE TABLE buchung(
  buchung_id SERIAL PRIMARY KEY,
  flug_id INTEGER NOT NULL,
  sitzplatz CHAR(4),
  passagier_id INTEGER NOT NULL,
  preis NUMERIC(10,2) NOT NULL,
  CONSTRAINT sitzplan_unq UNIQUE (flug_id, sitzplatz),
  CONSTRAINT fk_flug FOREIGN KEY (flug_id) REFERENCES flug (flug_id),
  CONSTRAINT fk_passagier FOREIGN KEY (passagier_id) REFERENCES passagier (passagier_id)
);
