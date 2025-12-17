-- ==========================================================
-- Pricing Overview
-- Business Question:
-- What are the minimum, maximum, and average booking prices?
-- ==========================================================

SELECT 
	min(preis) AS minpreis,
	max(preis) AS maxpreis,
	avg(preis) AS avgpreis

FROM buchung;

-- ==========================================================
-- Customer Spend Analysis
-- Business Question:
-- Which passengers have the highest total booking costs?
-- Purpose:
-- Identify high-value customers based on cumulative spend.
-- ==========================================================

SELECT 
	vorname,
	nachname,
	MAX(preis)
FROM passagier p
INNER JOIN buchung  b USING(passagier_id)
GROUP BY vorname, nachname
ORDER BY MAX(preis) desc;

-- ==========================================================
-- Airline Pricing Analysis
-- Business Question:
-- Which airline has the highest average ticket price?
-- Purpose:
-- Compare airlines based on average booking prices to identify
-- premium-priced carriers.
-- ==========================================================


SELECT
	firmenname,
	MAX(avg_preis) 
FROM (
	SELECT 
		firmenname,
		avg(preis) AS avg_preis
	FROM fluglinie fl
	INNER JOIN flug f USING(fluglinie_id)
	INNER JOIN buchung b USING(flug_id)
	GROUP BY firmenname
)
GROUP BY firmenname
ORDER BY MAX(avg_preis) desc;

-- ==========================================================
-- Aircraft Capacity Analysis
-- Business Question:
-- Which aircraft with the highest capacity have departed from 
-- Altamira Airport?
-- ==========================================================

SELECT DISTINCT
    fzt.bezeichnung, fz.kapazitaet, fh.namen
FROM
    flugzeug fz
INNER JOIN
    flugzeug_typ fzt ON fz.typ_id = fzt.typ_id
INNER JOIN
    flug f ON f.flugzeug_id = fz.flugzeug_id
INNER JOIN
    flughafen fh ON fh.flughafen_id = f.von
WHERE
    fh.namen = 'ALTAMIRA'
ORDER BY fz.kapazitaet DESC;

-- ==========================================================
-- Passenger Transport Analysis
-- Business Question:
-- How many passengers were transported by Spain Airlines
-- between 2015-06-06 and 2015-06-08 based on departure dates,
-- including flights that arrived after this period?
-- ==========================================================


SELECT
COUNT(*) AS anzahl
FROM (
	SELECT 
	*
	FROM fluglinie fl 
	INNER JOIN flug f USING(fluglinie_id)
	INNER JOIN buchung b USING(flug_id)
	WHERE firmenname = 'Spain Airlines'
		AND (
		abflug BETWEEN '2015-06-06 __:__:__' AND '2015-06-08 __:__:__'
		)
)
;

-- ==========================================================
-- Flight Load Factor Analysis (Sample Data)
-- Business Question:
-- For each flight, list the flight number, aircraft capacity, and number of bookings.
-- Add a flag indicating whether the flight was more than 5% utilized
-- (based on capacity vs. booking count). Note: booking counts are based on sample data
-- and do not represent real-world occupancy.
-- ==========================================================

SELECT 
    f.flug_id AS flugid,
    f.flugnr AS flugnummer,
    fl.kapazitaet AS kapazitaet,
    COUNT(b.buchung_id) AS anzahl_buchungen,
    CASE
        WHEN COUNT(b.buchung_id)::DECIMAL / fl.kapazitaet > 0.05 THEN 'Yes'
        ELSE 'No'
    END AS ausgelastet_über_5_prozent
FROM
    flug f
INNER JOIN
    flugzeug fl ON f.flugzeug_id = fl.flugzeug_id
LEFT JOIN
    buchung b ON b.flug_id = f.flug_id
GROUP BY f.flug_id, f.flugnr, fl.kapazitaet
ORDER BY f.flug_id;

-- ==========================================================
-- Airline Destination Analysis
-- Business Question:
-- Which airlines fly most frequently to Kagoshima Airport?
-- ==========================================================

SELECT 
    fl.firmenname AS fluglinie,
    COUNT(*) AS anzahl_fluege
FROM
    flug f
INNER JOIN
    fluglinie fl ON fl.fluglinie_id = f.fluglinie_id
INNER JOIN
    flughafen fh ON fh.flughafen_id = f.nach
WHERE
    fh.namen = 'KAGOSHIMA'
GROUP BY fl.firmenname
ORDER BY anzahl_fluege DESC;

-- ==========================================================
-- Aircraft Utilization Analysis
-- Business Question:
-- Which aircraft belonging to an airline with an Italian home 
-- airport have operated the highest number of flights, and what 
-- are their aircraft types?
-- ==========================================================

SELECT 
    fz.flugzeug_id,
    fl.firmenname,
    fl.heimat_flughafen,
    fh.land,
    COUNT(f.flugnr) AS anzahl_fluege,
    fzt.bezeichnung
FROM
    flug f
INNER JOIN
    fluglinie fl ON f.fluglinie_id = fl.fluglinie_id
INNER JOIN
    flugzeug fz ON fz.flugzeug_id = f.flugzeug_id
INNER JOIN
    flughafen fh ON fh.flughafen_id = fl.heimat_flughafen
INNER JOIN
    flugzeug_typ fzt ON fzt.typ_id = fz.typ_id
WHERE
    fh.land = 'ITALY'
GROUP BY fz.flugzeug_id, fl.firmenname, fl.heimat_flughafen, fh.land, fzt.bezeichnung
ORDER BY anzahl_fluege DESC;

-- ==========================================================
-- Booking Distribution by Aircraft Type
-- Business Question:
-- What percentage share of total bookings does each aircraft 
-- type account for?
-- ==========================================================

SELECT 
    fzt.bezeichnung AS flugzeugtyp,
    COUNT(b.buchung_id) AS anzahl_buchungen,
    ROUND(COUNT(b.buchung_id) * 100.0 / (SELECT COUNT(*) FROM buchung), 2) AS anteil_prozent
FROM
    buchung b
INNER JOIN
    flug f ON f.flug_id = b.flug_id
INNER JOIN
    flugzeug fz ON f.flugzeug_id = fz.flugzeug_id
INNER JOIN
    flugzeug_typ fzt ON fzt.typ_id = fz.typ_id
GROUP BY fzt.bezeichnung
ORDER BY anteil_prozent DESC;



