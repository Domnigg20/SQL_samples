--Create a view that displays the number of New York City taxi
--trips per hour.

-- View: public.nyc_taxi_trips_per_hour

-- DROP VIEW public.nyc_taxi_trips_per_hour;

CREATE OR REPLACE VIEW public.nyc_taxi_trips_per_hour
 AS
 SELECT date_part('hour'::text, nyc_yellow_taxi_trips_2016_06_01.tpep_pickup_datetime) AS date_part,
    count(date_part('hour'::text, nyc_yellow_taxi_trips_2016_06_01.tpep_pickup_datetime)) AS count
   FROM nyc_yellow_taxi_trips_2016_06_01
  GROUP BY (date_part('hour'::text, nyc_yellow_taxi_trips_2016_06_01.tpep_pickup_datetime))
  ORDER BY (date_part('hour'::text, nyc_yellow_taxi_trips_2016_06_01.tpep_pickup_datetime));

ALTER TABLE public.nyc_taxi_trips_per_hour
    OWNER TO postgres;

