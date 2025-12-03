
  create or replace   view AV_EDM.AV_STAGING.dim_aha_features_pi_planning
  
  
  
  
  as (
    WITH custom AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.aha_features_custom_fields
    WHERE name = 'PI Planning'
)
SELECT 
        custom.feature_id
        ,pi.value::VARCHAR AS value
        ,RAW_UPDATED

FROM 
        custom
        ,LATERAL FLATTEN(custom.value) pi
  );

