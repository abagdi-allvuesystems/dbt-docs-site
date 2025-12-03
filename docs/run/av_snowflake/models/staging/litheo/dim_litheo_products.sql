
  create or replace   view AV_EDM.AV_STAGING.dim_litheo_products
  
  
  
  
  as (
    WITH lit_products AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.litheo_products
)
SELECT 
        segmentname AS segment
        ,productfamilyname AS product_family
        ,productname AS product 

FROM lit_products
    GROUP BY segmentname, productfamilyname, productname
  );

