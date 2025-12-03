
  create or replace   view AV_EDM.AV_SYSTEM.openair_revcatgroupxref
  
  
  
  
  as (
    WITH revcatgroupxref AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_revcatgroupxref
)

SELECT
        revenuecategory::VARCHAR AS revenue_category
        ,revenuegroup::VARCHAR AS revenue_group
        ,utilizationgroup::VARCHAR AS utilization_group
        ,internalID::INT AS id
FROM revcatgroupxref
  );

