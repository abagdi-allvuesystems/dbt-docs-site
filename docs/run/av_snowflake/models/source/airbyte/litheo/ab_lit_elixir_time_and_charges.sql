
  create or replace   view AV_EDM.AV_SOURCE.ab_lit_elixir_time_and_charges
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.LITHEO.TIMEANDCHARGES
  );

