
  create or replace   view AV_EDM.AV_SOURCE.ab_lit_products
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.LITHEO.PRODUCTCATALOG
  );

